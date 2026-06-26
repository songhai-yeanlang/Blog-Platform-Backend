const { handleError } = require('../../utils/handleError');
const blogPostService = require('./blogPost.service');

const createBlog = async (req, res) => {
    try {
        const data = await blogPostService.createBlog(req.user.id, req.validated || req.body, req.file);
        return res.status(201).json({
            success: true,
            message: "Blog post created successfully",
            data
        });
    } catch (error) {
        return await handleError(res, 'blogPostController', error);
    }
};

const updateBlog = async (req, res) => {
    try {
        const data = await blogPostService.updateBlog(req.user.id, req.params.id, req.validated || req.body, req.file);
        return res.status(200).json({
            success: true,
            message: "Blog post updated successfully",
            data
        });
    } catch (error) {
        return await handleError(res, 'blogPostController', error);
    }
};

const getAllBlogs = async (req, res) => {
    try {
        const data = await blogPostService.getAllBlogs();
        return res.status(200).json({
            success: true,
            message: "Get all blogs successfully",
            data
        });
    } catch (error) {
        return await handleError(res, 'blogPostController', error);
    }
};

const getAllOwnerBlogs = async (req, res) => {
    try {
        const data = await blogPostService.getAllOwnerBlogs(req.user.id);
        return res.status(200).json({
            success: true,
            message: "Get all owner blogs successfully",
            data
        });
    } catch (error) {
        return await handleError(res, 'blogPostController', error);
    }
};

const deleteBlog = async (req, res) => {
    try {
        const { id } = req.params;
        await blogPostService.deleteBlog(req.user.id, req.user.role, id);
        return res.status(200).json({
            success: true,
            message: "Blog post deleted successfully"
        });
    } catch (error) {
        return await handleError(res, 'blogPostController', error);
    }
};

const addBlogView = async (req, res) => {
    try {
        const { id } = req.params;
        await blogPostService.addView(req.user.id, id);
        return res.status(200).json({
            success: true,
            message: "Blog view recorded successfully"
        });
    } catch (error) {
        return await handleError(res, 'blogPostController', error);
    }
};

const toggleFavorite = async (req, res) => {
    try {
        const { id } = req.params;
        const data = await blogPostService.toggleFavorite(req.user.id, id);
        const message = data.favorited
            ? 'Blog post added to favorites'
            : 'Blog post removed from favorites';
        return res.status(200).json({
            success: true,
            message,
            data
        });
    } catch (error) {
        return await handleError(res, 'blogPostController', error);
    }
};

module.exports = {
    createBlog,
    updateBlog,
    getAllBlogs,
    getAllOwnerBlogs,
    deleteBlog,
    addBlogView,
    toggleFavorite
};
