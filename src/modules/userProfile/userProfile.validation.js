const joi = require('joi');

const updateProfileSchema = joi.object({
    name: joi.string().min(3).optional(),
    phone: joi.string().allow('', null).optional(),
    bio: joi.string().allow('', null).optional(),
    avatar: joi.string().allow('', null).optional()
});

module.exports = {
    updateProfileSchema
};
