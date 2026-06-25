const joi = require('joi');

const createCategorySchema = joi.object({
    name: joi.string().min(2).max(100).required().messages({
        'string.empty': 'category name is required',
        'any.required': 'category name is required'
    })
});

const updateCategorySchema = joi.object({
    name: joi.string().min(2).max(100).required().messages({
        'string.empty': 'category name is required',
        'any.required': 'category name is required'
    })
});

module.exports = {
    createCategorySchema,
    updateCategorySchema
};
