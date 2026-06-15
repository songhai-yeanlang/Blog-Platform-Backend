const { writeErrorLog } = require('../../utils/handleError');
const jwt = require('jsonwebtoken');

const userMiddleware = (schema) => async (req, res, next) => {
    // Joi uses .validate(), not .userValidate()
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
}

const isLogin = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;
        
        // Check if the header exists and starts with 'Bearer '
        if (!authHeader || !authHeader.startsWith('Bearer ')) {
            return res.status(401).json({
                success: false,
                message: 'Access denied. No token provided.'
            });
        }

        const token = authHeader.split(' ')[1]; // Extract token after 'Bearer'
        const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your_fallback_secret_key');
        req.user = decoded; // Attach the decoded payload (id, email, role) to req.user
        next();
    } catch (error) {
        return res.status(401).json({
            success: false,
            message: 'Invalid or expired token.'
        });
    }
};

module.exports = {
    userMiddleware,
    isLogin
};
