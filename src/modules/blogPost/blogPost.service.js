const path = require('path');
const fs = require('fs');
const sharp = require('sharp');
const blogPostModel = require('./blogPost.model');
const pool = require('../../configs/db.config');

const BLOG_IMAGE_DIR = path.join(process.cwd(), 'uploads', 'blogs');

const createBlog = async (accountId, body, file) => {
    const userId = await blogPostModel.getUserIdByAccountId(accountId);
    if (!userId) {
        const error = new Error('User profile not found');
        error.statusCode = 404;
        throw error;
    }

    // Validate category
    const category = await blogPostModel.findCategoryById(body.category_id);
    if (!category) {
        const error = new Error('Category not found');
        error.statusCode = 400;
        throw error;
    }

    // Parse and validate tags
    let tagIds = body.tags;
    if (typeof tagIds === 'string') {
        try {
            tagIds = JSON.parse(tagIds);
        } catch (e) {
            tagIds = [];
        }
    }
    if (!tagIds) {
        tagIds = [];
    }

    if (tagIds.length > 0) {
        const existingTags = await blogPostModel.findTagsByIds(tagIds);
        if (existingTags.length !== tagIds.length) {
            const existingTagIds = existingTags.map(t => t.id);
            const missingTagId = tagIds.find(id => !existingTagIds.includes(id));
            const error = new Error(`Tag with id ${missingTagId} not found`);
            error.statusCode = 400;
            throw error;
        }
    }

    // Handle image upload if provided
    let imageUrl = null;
    if (file) {
        if (!fs.existsSync(BLOG_IMAGE_DIR)) {
            fs.mkdirSync(BLOG_IMAGE_DIR, { recursive: true });
        }

        const filename = `${userId}_${Date.now()}.webp`;
        const filepath = path.join(BLOG_IMAGE_DIR, filename);

        await sharp(file.buffer)
            .resize({ width: 800, height: 450, fit: 'cover' })
            .webp({ quality: 80 })
            .toFile(filepath);

        imageUrl = `/uploads/blogs/${filename}`;
    }

    // Execute in transaction
    const connection = await pool.getConnection();
    let newPostId;
    try {
        await connection.beginTransaction();

        const result = await blogPostModel.createBlogPost({
            userId,
            categoryId: body.category_id,
            title: body.title,
            content: body.content,
            image: imageUrl
        }, connection);

        newPostId = result.insertId;

        if (tagIds.length > 0) {
            await blogPostModel.addBlogPostTags(newPostId, tagIds, connection);
        }

        await connection.commit();
    } catch (error) {
        await connection.rollback();
        throw error;
    } finally {
        connection.release();
    }

    return await blogPostModel.findById(newPostId);
};

const updateBlog = async (accountId, id, body, file) => {
    const userId = await blogPostModel.getUserIdByAccountId(accountId);
    if (!userId) {
        const error = new Error('User profile not found');
        error.statusCode = 404;
        throw error;
    }

    const blogPost = await blogPostModel.findById(id);
    if (!blogPost) {
        const error = new Error('Blog post not found');
        error.statusCode = 404;
        throw error;
    }

    // Check ownership
    if (blogPost.user_id !== userId) {
        const error = new Error('Access denied. You can only update your own blog posts.');
        error.statusCode = 403;
        throw error;
    }

    // Validate category if provided
    if (body.category_id) {
        const category = await blogPostModel.findCategoryById(body.category_id);
        if (!category) {
            const error = new Error('Category not found');
            error.statusCode = 400;
            throw error;
        }
    }

    // Parse and validate tags if provided
    let tagIds = body.tags;
    if (tagIds !== undefined) {
        if (typeof tagIds === 'string') {
            try {
                tagIds = JSON.parse(tagIds);
            } catch (e) {
                tagIds = [];
            }
        }
        if (!tagIds) {
            tagIds = [];
        }

        if (tagIds.length > 0) {
            const existingTags = await blogPostModel.findTagsByIds(tagIds);
            if (existingTags.length !== tagIds.length) {
                const existingTagIds = existingTags.map(t => t.id);
                const missingTagId = tagIds.find(tid => !existingTagIds.includes(tid));
                const error = new Error(`Tag with id ${missingTagId} not found`);
                error.statusCode = 400;
                throw error;
            }
        }
    }

    // Handle cover image replacement if a new file is uploaded
    let imageUrl = null;
    if (file) {
        if (!fs.existsSync(BLOG_IMAGE_DIR)) {
            fs.mkdirSync(BLOG_IMAGE_DIR, { recursive: true });
        }

        const filename = `${userId}_${Date.now()}.webp`;
        const filepath = path.join(BLOG_IMAGE_DIR, filename);

        await sharp(file.buffer)
            .resize({ width: 800, height: 450, fit: 'cover' })
            .webp({ quality: 80 })
            .toFile(filepath);

        imageUrl = `/uploads/blogs/${filename}`;

        // Safely clean up the old cover image file from disk
        if (blogPost.image) {
            const oldFilepath = path.join(process.cwd(), blogPost.image);
            fs.unlink(oldFilepath, (err) => {
                if (err) console.error(`[blogPost.service] Failed to delete old image ${blogPost.image}:`, err.message);
            });
        }
    }

    // Run the updates in transaction
    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();

        await blogPostModel.updateBlogPost(id, {
            title: body.title,
            content: body.content,
            categoryId: body.category_id,
            image: imageUrl
        }, connection);

        if (tagIds !== undefined) {
            await blogPostModel.deleteBlogPostTags(id, connection);
            if (tagIds.length > 0) {
                await blogPostModel.addBlogPostTags(id, tagIds, connection);
            }
        }

        await connection.commit();
    } catch (error) {
        await connection.rollback();
        throw error;
    } finally {
        connection.release();
    }

    return await blogPostModel.findById(id);
};

const getAllBlogs = async () => {
    return await blogPostModel.getAllBlogs();
}

const getAllOwnerBlogs = async (accountId) => {
    const userId = await blogPostModel.getUserIdByAccountId(accountId);
    if (!userId) {
        const error = new Error('User profile not found');
        error.statusCode = 404;
        throw error;
    }
    return await blogPostModel.getAllBlogsByUserId(userId);
};

const deleteBlog = async (accountId, role, id) => {
    const userId = await blogPostModel.getUserIdByAccountId(accountId);
    if (!userId) {
        const error = new Error('User profile not found');
        error.statusCode = 404;
        throw error;
    }

    const blogPost = await blogPostModel.findById(id);
    if (!blogPost) {
        const error = new Error('Blog post not found');
        error.statusCode = 404;
        throw error;
    }

    // Admin can delete any blog. Normal users can only delete their own.
    if (role !== 'admin' && blogPost.user_id !== userId) {
        const error = new Error('Access denied. You can only delete your own blog posts.');
        error.statusCode = 403;
        throw error;
    }

    // Clean up cover image file
    if (blogPost.image) {
        const filepath = path.join(process.cwd(), blogPost.image);
        fs.unlink(filepath, (err) => {
            if (err) console.error(`[blogPost.service] Failed to delete image ${blogPost.image}:`, err.message);
        });
    }

    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();

        await blogPostModel.deleteBlogPostTags(id, connection);
        await blogPostModel.deleteBlogPost(id, connection);

        await connection.commit();
    } catch (error) {
        await connection.rollback();
        throw error;
    } finally {
        connection.release();
    }
};

const addView = async (accountId, postId) => {
    const userId = await blogPostModel.getUserIdByAccountId(accountId);
    if (!userId) {
        const error = new Error('User profile not found');
        error.statusCode = 404;
        throw error;
    }

    const blogPost = await blogPostModel.findById(postId);
    if (!blogPost) {
        const error = new Error('Blog post not found');
        error.statusCode = 404;
        throw error;
    }

    await blogPostModel.addBlogView(postId, userId);
};

const toggleFavorite = async (accountId, postId) => {
    const userId = await blogPostModel.getUserIdByAccountId(accountId);
    if (!userId) {
        const error = new Error('User profile not found');
        error.statusCode = 404;
        throw error;
    }

    const blogPost = await blogPostModel.findById(postId);
    if (!blogPost) {
        const error = new Error('Blog post not found');
        error.statusCode = 404;
        throw error;
    }

    const existing = await blogPostModel.findFavorite(userId, postId);
    if (existing) {
        await blogPostModel.removeFavorite(userId, postId);
        return { favorited: false };
    } else {
        await blogPostModel.addFavorite(userId, postId);
        return { favorited: true };
    }
};

module.exports = {
    createBlog,
    updateBlog,
    getAllBlogs,
    getAllOwnerBlogs,
    deleteBlog,
    addView,
    toggleFavorite
};

