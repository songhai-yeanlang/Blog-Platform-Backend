const { writeErrorLog } = require('../../utils/handleError');
const jwt = require('jsonwebtoken');
const authModel = require('./auth.model');

const authMiddleware = (schema) => async (req, res, next) => {
    const { error, value } = schema.validate(req.body, {
        abortEarly: false
    });
    if (error) {
        return res.status(400).json({
            success: false,
            message: 'invalid field',
            details: error.details.map((d) => d.message)
        });
    } else {
        req.validated = value;
        next();
    }
};

const isLogin = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;

        if (!authHeader || !authHeader.startsWith('Bearer ')) {
            return res.status(401).json({
                success: false,
                message: 'Access denied. No token provided.'
            });
        }

        const token = authHeader.split(' ')[1];
        const decoded = jwt.verify(token, process.env.JWT_SECRET);

        const userTokenObj = await authModel.findTokenByEmail(decoded.email);
        if (!userTokenObj || userTokenObj.token !== token) {
            return res.status(401).json({
                success: false,
                message: 'Invalid or expired token.'
            });
        }

        req.user = decoded;
        next();
    } catch (error) {
        return res.status(401).json({
            success: false,
            message: 'Invalid or expired token.'
        });
    }
};

const isAdmin = async (req, res, next) => {
    try {
        if (!req.user) {
            return res.status(401).json({
                success: false,
                message: 'Access denied. Please login first.'
            });
        }

        if (req.user.role !== 'admin') {
            return res.status(403).json({
                success: false,
                message: 'Access denied. Admin only.'
            });
        }

        next();
    } catch (error) {
        await writeErrorLog('authMiddleware', error);
        return res.status(500).json({
            success: false,
            message: 'Internal server error !!!'
        });
    }
};
module.exports = {
    authMiddleware,
    isLogin,
    isAdmin
};
