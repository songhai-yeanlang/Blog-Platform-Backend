const express = require('express');
const { authMiddleware, isLogin } = require('../auth/auth.middleware');
const userProfileController = require('./userProfile.controller');
const { updateProfileSchema } = require('./userProfile.validation');

const router = express.Router();
router.get('/get-profile', isLogin, userProfileController.getProfile);
router.put('/update-profile', isLogin, authMiddleware(updateProfileSchema), userProfileController.updateProfile);
// router.post('/profile/avatar')
module.exports = router;
