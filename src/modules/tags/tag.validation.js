const joi = require('joi');

const createTagSchema = joi.object({
    name: joi.string().min(2).max(50).required().messages({
        'string.empty': 'tag name is required',
        'any.required': 'tag name is required'
    })
});

module.exports = {
    createTagSchema
};
