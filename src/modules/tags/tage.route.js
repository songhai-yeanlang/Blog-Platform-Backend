const express = require('express');
const { authMiddleware, isLogin, isAdmin } = require('../auth/auth.middleware');
const tagController = require('./tag.controller');
const { createTagSchema } = require('./tag.validation');

const router = express.Router();

router.post('/create-tag', isLogin, isAdmin, authMiddleware(createTagSchema), tagController.createTag);

module.exports = router;
