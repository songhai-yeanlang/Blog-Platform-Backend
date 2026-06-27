const pool = require('../../configs/db.config');

const getUserIdByAccountId = async (accountId) => {
    const sql = `
        SELECT id FROM users WHERE account_id = ? LIMIT 1
    `;
    const [rows] = await pool.query(sql, [accountId]);
    return rows[0] ? rows[0].id : null;
};

const findCategoryById = async (categoryId) => {
    const sql = `
        SELECT id, name FROM categories WHERE id = ? LIMIT 1
    `;
    const [rows] = await pool.query(sql, [categoryId]);
    return rows[0];
};

const findTagsByIds = async (tagIds) => {
    if (!tagIds || tagIds.length === 0) return [];
    const sql = `
        SELECT id, name FROM tags WHERE id IN (?)
    `;
    const [rows] = await pool.query(sql, [tagIds]);
    return rows;
};

const createBlogPost = async (data, connection = pool) => {
    const sql = `
        INSERT INTO blog_post (user_id, category_id, title, content, image)
        VALUES (?, ?, ?, ?, ?)
    `;
    const params = [
        data.userId,
        data.categoryId,
        data.title,
        data.content,
        data.image
    ];
    const [result] = await connection.query(sql, params);
    return result;
};

const addBlogPostTags = async (postId, tagIds, connection = pool) => {
    if (!tagIds || tagIds.length === 0) return;
    const sql = `
        INSERT INTO blog_post_tags (post_id, tag_id)
        VALUES ?
    `;
    const values = tagIds.map(tagId => [postId, tagId]);
    await connection.query(sql, [values]);
};

const findById = async (id) => {
    const sql = `
        SELECT bp.id, bp.user_id, bp.category_id, bp.title, bp.content, bp.image, bp.created_at, bp.updated_at,
               u.name as author_name, c.name as category_name,
               (SELECT COUNT(*) FROM view_blog WHERE post_id = bp.id) as views
        FROM blog_post bp
        LEFT JOIN users u ON u.id = bp.user_id
        LEFT JOIN categories c ON c.id = bp.category_id
        WHERE bp.id = ?
        LIMIT 1
    `;
    const [rows] = await pool.query(sql, [id]);
    if (!rows[0]) return null;

    const post = rows[0];

    const tagsSql = `
        SELECT t.id, t.name
        FROM tags t
        JOIN blog_post_tags bpt ON bpt.tag_id = t.id
        WHERE bpt.post_id = ?
    `;
    const [tags] = await pool.query(tagsSql, [id]);
    post.tags = tags;

    return post;
};

const updateBlogPost = async (id, data, connection = pool) => {
    const sql = `
        UPDATE blog_post
        SET title = COALESCE(?, title),
            content = COALESCE(?, content),
            category_id = COALESCE(?, category_id),
            image = COALESCE(?, image)
        WHERE id = ?
    `;
    const params = [
        data.title ?? null,
        data.content ?? null,
        data.categoryId ?? null,
        data.image ?? null,
        id
    ];
    const [result] = await connection.query(sql, params);
    return result;
};

const deleteBlogPostTags = async (postId, connection = pool) => {
    const sql = `
        DELETE FROM blog_post_tags
        WHERE post_id = ?
    `;
    await connection.query(sql, [postId]);
};

const getAllBlogs = async () => {
    const sql = `
        SELECT bp.id, bp.user_id, bp.category_id, bp.title, bp.content, bp.image, bp.created_at, bp.updated_at,
               u.name as author_name, c.name as category_name,
               (SELECT COUNT(*) FROM view_blog WHERE post_id = bp.id) as views
        FROM blog_post bp
        LEFT JOIN users u ON u.id = bp.user_id
        LEFT JOIN categories c ON c.id = bp.category_id
        ORDER BY bp.created_at DESC
    `;
    const [posts] = await pool.query(sql);

    if (posts.length === 0) return [];

    // Fetch tags for all posts in a single query
    const postIds = posts.map(p => p.id);
    const tagsSql = `
        SELECT bpt.post_id, t.id, t.name
        FROM tags t
        JOIN blog_post_tags bpt ON bpt.tag_id = t.id
        WHERE bpt.post_id IN (?)
    `;
    const [allTags] = await pool.query(tagsSql, [postIds]);

    // Group tags by post ID
    const tagsMap = {};
    for (const tag of allTags) {
        if (!tagsMap[tag.post_id]) tagsMap[tag.post_id] = [];
        tagsMap[tag.post_id].push({ id: tag.id, name: tag.name });
    }

    return posts.map(post => ({
        ...post,
        tags: tagsMap[post.id] || []
    }));
};
const getAllBlogsByUserId= async (userId) => {
        const sql = `
            SELECT bp.id, bp.user_id, bp.category_id, bp.title, bp.content, bp.image, bp.created_at, bp.updated_at,
                   u.name as author_name, c.name as category_name,
                   (SELECT COUNT(*) FROM view_blog WHERE post_id = bp.id) as views
            FROM blog_post bp
            LEFT JOIN users u ON u.id = bp.user_id
            LEFT JOIN categories c ON c.id = bp.category_id
            WHERE bp.user_id = ?
            ORDER BY bp.created_at DESC
        `;
        const [posts] = await pool.query(sql, [userId]);
        if (posts.length === 0) return [];

        const postIds = posts.map(p => p.id);
        const tagsSql = `
            SELECT bpt.post_id, t.id, t.name
            FROM tags t
            JOIN blog_post_tags bpt ON bpt.tag_id = t.id
            WHERE bpt.post_id IN (?)
        `;
        const [allTags] = await pool.query(tagsSql, [postIds]);

        const tagsMap = {};
        for (const tag of allTags) {
            if (!tagsMap[tag.post_id]) tagsMap[tag.post_id] = [];
            tagsMap[tag.post_id].push({ id: tag.id, name: tag.name });
        }

        return posts.map(post => ({ ...post, tags: tagsMap[post.id] || [] }));
    }
const deleteBlogPost = async (id, connection = pool) => {
    const sql = `
        DELETE FROM blog_post
        WHERE id = ?
    `;
    const [result] = await connection.query(sql, [id]);
    return result;
};

const addBlogView = async (postId, userId) => {
    const sql = `
        INSERT INTO view_blog (post_id, user_id)
        VALUES (?, ?)
        ON DUPLICATE KEY UPDATE viewed_at = CURRENT_TIMESTAMP
    `;
    const [result] = await pool.query(sql, [postId, userId]);
    return result;
};

const hasUserViewed = async (postId, userId) => {
    const sql = `
        SELECT 1 FROM view_blog WHERE post_id = ? AND user_id = ? LIMIT 1
    `;
    const [rows] = await pool.query(sql, [postId, userId]);
    return rows.length > 0;
};

const findFavorite = async (userId, postId) => {
    const sql = `
        SELECT id FROM favorites WHERE user_id = ? AND post_id = ? LIMIT 1
    `;
    const [rows] = await pool.query(sql, [userId, postId]);
    return rows[0] || null;
};

const addFavorite = async (userId, postId) => {
    const sql = `
        INSERT INTO favorites (user_id, post_id) VALUES (?, ?)
    `;
    const [result] = await pool.query(sql, [userId, postId]);
    return result;
};

const removeFavorite = async (userId, postId) => {
    const sql = `
        DELETE FROM favorites WHERE user_id = ? AND post_id = ?
    `;
    const [result] = await pool.query(sql, [userId, postId]);
    return result;
};

module.exports = {
    getUserIdByAccountId,
    findCategoryById,
    findTagsByIds,
    createBlogPost,
    addBlogPostTags,
    findById,
    updateBlogPost,
    deleteBlogPostTags,
    getAllBlogs,
    getAllBlogsByUserId,
    deleteBlogPost,
    addBlogView,
    hasUserViewed,
    findFavorite,
    addFavorite,
    removeFavorite
};

