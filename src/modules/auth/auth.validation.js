const joi = require('joi');

const registerUserSchema = joi.object({
    name: joi.string().min(3),
    username: joi.string().min(3),
    email: joi.string().email().required(),
    password: joi.string()
        .min(8)
        .max(30)
        .pattern(new RegExp('^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\\$%\\^&\\*])'))
        .required()
        .messages({
            'string.min': 'password must be at least 8 characters',
            'string.max': 'password must be at most 30 characters',
            'string.pattern.base': 'password must include uppercase, lowercase, number, and special character',
            'any.required': 'password is required'
        })
}).xor('name', 'username');

const resendVerificationSchema = joi.object({
    email: joi.string().email().required()
});

const loginUserSchema = joi.object({
    email: joi.string().email().required(),
    password: joi.string().required()
});

const forgotPasswordSchema = joi.object({
    email: joi.string().email().required()
});

const verifyOtpSchema = joi.object({
    email: joi.string().email().required(),
    otp: joi.string().length(6).required().messages({
        'string.length': 'OTP must be exactly 6 characters',
        'any.required': 'OTP is required'
    })
});

const resetPasswordSchema = joi.object({
    newPassword: joi.string()
        .min(8)
        .max(30)
        .pattern(new RegExp('^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\\$%\\^&\\*])'))
        .required()
        .messages({
            'string.min': 'new password must be at least 8 characters',
            'string.max': 'new password must be at most 30 characters',
            'string.pattern.base': 'new password must include uppercase, lowercase, number, and special character',
            'any.required': 'new password is required'
        }),
    confirmPassword: joi.string()
        .required()
        .valid(joi.ref('newPassword'))
        .messages({
            'any.only': 'confirm password must match new password',
            'any.required': 'confirm password is required'
        })
});

const changePasswordSchema = joi.object({
    currentPassword: joi.string().required().messages({
        'any.required': 'current password is required'
    }),
    newPassword: joi.string()
        .min(8)
        .max(30)
        .pattern(new RegExp('^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\\$%\\^&\\*])'))
        .required()
        .messages({
            'string.min': 'new password must be at least 8 characters',
            'string.max': 'new password must be at most 30 characters',
            'string.pattern.base': 'new password must include uppercase, lowercase, number, and special character',
            'any.required': 'new password is required'
        }),
    confirmPassword: joi.string()
        .required()
        .valid(joi.ref('newPassword'))
        .messages({
            'any.only': 'confirm password must match new password',
            'any.required': 'confirm password is required'
        })
});

const refreshTokenSchema = joi.object({
    refreshToken: joi.string().required().messages({
        'any.required': 'refresh token is required'
    })
});

module.exports = {
    registerUserSchema,
    resendVerificationSchema,
    loginUserSchema,
    forgotPasswordSchema,
    resetPasswordSchema,
    verifyOtpSchema,
    changePasswordSchema,
    refreshTokenSchema
};

