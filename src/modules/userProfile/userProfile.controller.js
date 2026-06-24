const { handleError } = require('../../utils/handleError');
const userProfileService = require('./userProfile.service');

const getProfile = async (req, res) => {
    try {
        const profile = await userProfileService.getProfile(req.user.id);
        return res.status(200).json({
            success: true,
            message: "Get profile successfully",
            data: profile
        });
    } catch (error) {
        return await handleError(res, 'userProfileController', error);
    }
};

const updateProfile = async (req, res) => {
    try {
        const profile = await userProfileService.updateProfile(req.user.id, req.validated || req.body);
        return res.status(200).json({
            success: true,
            message: "Update profile successfully",
            data: profile
        });
    } catch (error) {
        return await handleError(res, 'userProfileController', error);
    }
};

module.exports = {
    getProfile,
    updateProfile
};
