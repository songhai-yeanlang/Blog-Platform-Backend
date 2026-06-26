const express = require('express');
const { authMiddleware, isLogin } = require('../auth/auth.middleware');
const blogPostController = require('./blogPost.controller');
const { createBlogSchema, updateBlogSchema } = require('./blogPost.validation');
const { upload } = require('../../configs/upload.config');

const router = express.Router();

router.post('/create-blog', isLogin, upload.single('image'), authMiddleware(createBlogSchema), blogPostController.createBlog);
router.put('/update-blog/:id', isLogin, upload.single('image'), authMiddleware(updateBlogSchema), blogPostController.updateBlog);
router.get('/get-all-blogs', blogPostController.getAllBlogs);
router.get('/get-owner-blogs', isLogin, blogPostController.getAllOwnerBlogs);
router.delete('/delete-blog/:id', isLogin, blogPostController.deleteBlog);
router.post('/add-blog-view/:id', isLogin, blogPostController.addBlogView);

router.post('/toggleFavorite/:id', isLogin, blogPostController.toggleFavorite);

module.exports = router;
