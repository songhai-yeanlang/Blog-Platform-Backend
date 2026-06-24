const userProfileModel = require('./userProfile.model');

const getProfile = async (userId) => {
    const user = await userProfileModel.findById(userId);
    if (!user) {
        const error = new Error('User profile not found');
        error.statusCode = 404;
        throw error;
    }
    return user;
};

const updateProfile = async (userId, body) => {
    const user = await userProfileModel.findById(userId);
    if (!user) {
        const error = new Error('User profile not found');
        error.statusCode = 404;
        throw error;
    }

    await userProfileModel.updateByAccountId(userId, {
        name: body.name,
        phone: body.phone,
        bio: body.bio,
        avatar: body.avatar
    });

    return await userProfileModel.findById(userId);
};

module.exports = {
    getProfile,
    updateProfile
};
