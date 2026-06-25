const bcrypt = require('bcrypt');
const crypto = require('crypto');
const jwt = require('jsonwebtoken');
const authMailer = require('../../configs/mail.config');
const authModel = require('./auth.model');
const pool = require('../../configs/db.config');

const VERIFICATION_EXPIRES_HOURS = 24;

const createVerificationUrl = (verificationToken) => {
    const baseUrl = process.env.APP_URL || `http://localhost:${process.env.PORT || 3000}`;
    const verificationUrl = new URL('/api/auth/verify-email', baseUrl);
    verificationUrl.searchParams.set('token', verificationToken);

    return verificationUrl.toString();
};

const register = async (data) => {
    const name = data.name || data.username;
    const email = data.email.toLowerCase();
    const hashPassword = await bcrypt.hash(data.password, 10);
    const verificationToken = crypto.randomBytes(32).toString('hex');
    const verificationExpires = new Date(Date.now() + VERIFICATION_EXPIRES_HOURS * 60 * 60 * 1000);

    const connection = await pool.getConnection();
    let accountId;
    try {
        await connection.beginTransaction();

        const accountResult = await authModel.createAccount({
            email,
            password: hashPassword,
            verificationToken,
            verificationExpires,
            isVerified: false,
            isActive: false
        }, connection);

        accountId = accountResult.insertId;

        await authModel.createUser({
            accountId,
            name
        }, connection);

        await connection.commit();
    } catch (error) {
        await connection.rollback();
        throw error;
    } finally {
        connection.release();
    }

    const verificationUrl = createVerificationUrl(verificationToken);
    let emailSent = true;

    try {
        await authMailer.sendVerificationEmail({
            to: email,
            name,
            verificationUrl
        });
    } catch (error) {
        console.error(`[auth.service] Failed to send verification email to ${email}:`, error.message);
        emailSent = false;
    }

    return {
        id: accountId,
        name,
        email,
        isVerified: false,
        isActive: false,
        emailSent
    };
};

const verifyEmail = async (verificationToken) => {
    if (!verificationToken) {
        const error = new Error('Verification token is required');
        error.statusCode = 400;
        throw error;
    }

    const user = await authModel.findByVerificationToken(verificationToken);

    if (!user) {
        const error = new Error('Invalid verification link');
        error.statusCode = 400;
        throw error;
    }

    if (new Date(user.verification_expires).getTime() < Date.now()) {
        const error = new Error('Verification link has expired');
        error.statusCode = 400;
        throw error;
    }

    await authModel.markEmailAsVerified(user.id);

    return {
        id: user.id,
        name: user.name,
        email: user.email,
        isVerified: true,
        isActive: true
    };
};

const resendVerification = async (email) => {
    const user = await authModel.findByEmail(email.toLowerCase());

    if (!user) {
        const error = new Error('User not found');
        error.statusCode = 404;
        throw error;
    }

    if (user.is_verified) {
        const error = new Error('Email is already verified');
        error.statusCode = 400;
        throw error;
    }

    const verificationToken = crypto.randomBytes(32).toString('hex');
    const verificationExpires = new Date(Date.now() + VERIFICATION_EXPIRES_HOURS * 60 * 60 * 1000);

    await authModel.updateVerificationToken(user.id, verificationToken, verificationExpires);

    const verificationUrl = createVerificationUrl(verificationToken);
    let emailSent = true;

    try {
        await authMailer.sendVerificationEmail({
            to: user.email,
            name: user.name,
            verificationUrl
        });
    } catch (error) {
        console.error(`[auth.service] Failed to resend verification email to ${user.email}:`, error.message);
        emailSent = false;
    }

    return { emailSent };
};

const login = async (data) => {
    const { email, password } = data;
    const user = await authModel.findForLogin(email.toLowerCase());

    if (!user) {
        const error = new Error('Invalid email or password');
        error.statusCode = 401;
        throw error;
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
        const error = new Error('Invalid email or password');
        error.statusCode = 401;
        throw error;
    }

    if (!user.is_verified) {
        const error = new Error('Please verify your email before logging in');
        error.statusCode = 403;
        throw error;
    }

    if (!user.is_active) {
        const error = new Error('Your account has been deactivated');
        error.statusCode = 403;
        throw error;
    }

    const payload = {
        id: user.id,
        email: user.email,
        role: user.role
    };
    const token = jwt.sign(payload, process.env.JWT_SECRET || 'your_fallback_secret_key', {
        expiresIn: process.env.JWT_EXPIRES_IN || '1d'
    });

    const refreshToken = crypto.randomBytes(40).toString('hex');
    const refreshTokenExpires = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000); // 7 days

    await authModel.updateToken(user.id, token);
    await authModel.updateRefreshToken(user.id, refreshToken, refreshTokenExpires);

    return {
        user: {
            id: user.id,
            name: user.name,
            email: user.email,
            role: user.role
        },
        token,
        refreshToken
    };
};

const forgotPassword = async (email) => {
    const user = await authModel.findByEmail(email.toLowerCase());

    if (!user) {
        const error = new Error('User not found');
        error.statusCode = 404;
        throw error;
    }

    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    const tokenData = JSON.stringify({
        otp,
        expires: Date.now() + 3600000 
    });

    await authModel.updateToken(user.id, tokenData);

    let emailSent = true;

    try {
        await authMailer.sendResetPasswordEmail({
            to: user.email,
            name: user.name,
            otp
        });
    } catch (error) {
        console.error(`[auth.service] Failed to send reset password email to ${user.email}:`, error.message);
        emailSent = false;
    }

    return { emailSent };
};

const verifyOtp = async (email, otp) => {
    const user = await authModel.findTokenByEmail(email.toLowerCase());

    if (!user || !user.token) {
        const error = new Error('Invalid OTP');
        error.statusCode = 400;
        throw error;
    }

    let tokenData;
    try {
        tokenData = JSON.parse(user.token);
    } catch (e) {
        const error = new Error('Invalid or expired OTP');
        error.statusCode = 400;
        throw error;
    }

    if (tokenData.otp !== otp) {
        const error = new Error('Invalid OTP');
        error.statusCode = 400;
        throw error;
    }

    if (Date.now() > tokenData.expires) {
        const error = new Error('OTP has expired');
        error.statusCode = 400;
        throw error;
    }

    const payload = {
        id: user.id,
        email: user.email,
        isResetToken: true
    };
    const token = jwt.sign(payload, process.env.JWT_SECRET || 'your_fallback_secret_key', {
        expiresIn: '15m'
    });

    await authModel.updateToken(user.id, token);

    return { token };
};

const resetPassword = async (userId, newPassword) => {
    const user = await authModel.findById(userId);

    if (!user) {
        const error = new Error('User not found');
        error.statusCode = 404;
        throw error;
    }

    const hashPassword = await bcrypt.hash(newPassword, 10);
    await authModel.updatePassword(userId, hashPassword);
    await authModel.updateToken(userId, null);
    await authModel.updateRefreshToken(userId, null, null);
};

const logout = async (userId) => {
    await authModel.updateToken(userId, null);
    await authModel.updateRefreshToken(userId, null, null);
};

const changePassword = async (userId, data) => {
    const { currentPassword, newPassword } = data;
    
    const account = await authModel.findPasswordById(userId);
    if (!account) {
        const error = new Error('User not found');
        error.statusCode = 404;
        throw error;
    }

    const isPasswordValid = await bcrypt.compare(currentPassword, account.password);
    if (!isPasswordValid) {
        const error = new Error('Current password is incorrect');
        error.statusCode = 400;
        throw error;
    }

    const hashPassword = await bcrypt.hash(newPassword, 10);
    await authModel.updatePassword(userId, hashPassword);
};

const refreshToken = async (oldRefreshToken) => {
    const user = await authModel.findByRefreshToken(oldRefreshToken);

    if (!user) {
        const error = new Error('Invalid refresh token');
        error.statusCode = 401;
        throw error;
    }

    if (new Date(user.refresh_token_expires).getTime() < Date.now()) {
        const error = new Error('Refresh token has expired');
        error.statusCode = 401;
        throw error;
    }

    if (!user.is_verified) {
        const error = new Error('Please verify your email');
        error.statusCode = 403;
        throw error;
    }

    if (!user.is_active) {
        const error = new Error('Your account has been deactivated');
        error.statusCode = 403;
        throw error;
    }

    const payload = {
        id: user.id,
        email: user.email,
        role: user.role
    };

    const newToken = jwt.sign(payload, process.env.JWT_SECRET || 'your_fallback_secret_key', {
        expiresIn: process.env.JWT_EXPIRES_IN || '1d'
    });

    const newRefreshToken = crypto.randomBytes(40).toString('hex');
    const newRefreshTokenExpires = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000); // 7 days

    await authModel.updateToken(user.id, newToken);
    await authModel.updateRefreshToken(user.id, newRefreshToken, newRefreshTokenExpires);

    return {
        token: newToken,
        refreshToken: newRefreshToken
    };
};

module.exports = {
    register,
    verifyEmail,
    resendVerification,
    login,
    forgotPassword,
    verifyOtp,
    resetPassword,
    logout,
    changePassword,
    refreshToken
};
