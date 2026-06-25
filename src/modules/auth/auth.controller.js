const { handleError } = require('../../utils/handleError');
const authService = require('./auth.service');
const authView = require('./auth.view');


const register = async (req, res) => {
    try {
        let row = await authService.register(req.validated || req.body);
        const message = row.emailSent
            ? "User registered successfully. Please check your email to verify your account."
            : "User registered successfully, but we couldn't send the verification email right now. Please try requesting a new verification link later.";

        return res.status(201).json({
            success: true,
            message,
            data: row
        });
    } catch (error) {
        return await handleError(res, 'authController', error);
    }
};

const verifyEmail = async (req, res) => {
    try {
        const row = await authService.verifyEmail(req.query.token);
        return authView.verifyEmailSuccess(req, res, row);
    } catch (error) {
        return await authView.verifyEmailError(req, res, error);
    }
};

const resendVerification = async (req, res) => {
    try {
        const { email } = req.validated;
        const result = await authService.resendVerification(email);

        const message = result.emailSent
            ? "Verification email resent successfully. Please check your inbox."
            : "We encountered an issue sending the email. Please try again later.";

        return res.status(200).json({ success: true, message });
    } catch (error) {
        return await handleError(res, 'authController', error);
    }
};

const login = async (req, res) => {
    try {
        let row = await authService.login(req.validated);
        return res.status(200).json({
            success: true,
            message: "Login successful",
            data: row
        });
    } catch (error) {
        return await handleError(res, 'authController', error);
    }
};

const forgotPassword = async (req, res) => {
    try {
        const { email } = req.validated;
        const result = await authService.forgotPassword(email);

        const message = result.emailSent
            ? "Password reset OTP sent successfully. Please check your email."
            : "We encountered an issue sending the email. Please try again later.";

        return res.status(200).json({ success: true, message });
    } catch (error) {
        return await handleError(res, 'authController', error);
    }
};

const verifyOtp = async (req, res) => {
    try {
        const { email, otp } = req.validated;
        const result = await authService.verifyOtp(email, otp);

        return res.status(200).json({
            success: true,
            message: "OTP verified successfully. You can now proceed to reset your password.",
            data: result
        });
    } catch (error) {
        return await handleError(res, 'authController', error);
    }
};

const resetPassword = async (req, res) => {
    try {
        if (!req.user || !req.user.isResetToken) {
            const error = new Error('Unauthorized reset password session');
            error.statusCode = 401;
            throw error;
        }

        const { newPassword } = req.validated;
        await authService.resetPassword(req.user.id, newPassword);

        return res.status(200).json({
            success: true,
            message: "Password reset successfully. You can now login with your new password."
        });
    } catch (error) {
        return await handleError(res, 'authController', error);
    }
};

const logout = async (req, res) => {
    try {
        await authService.logout(req.user.id);
        return res.status(200).json({
            success: true,
            message: "Logout successful"
        });
    } catch (error) {
        return await handleError(res, 'authController', error);
    }
};

const changePassword = async (req, res) => {
    try {
        await authService.changePassword(req.user.id, req.validated || req.body);
        return res.status(200).json({
            success: true,
            message: "Password changed successfully"
        });
    } catch (error) {
        return await handleError(res, 'authController', error);
    }
};

const refreshToken = async (req, res) => {
    try {
        const { refreshToken } = req.validated;
        const result = await authService.refreshToken(refreshToken);
        return res.status(200).json({
            success: true,
            message: "Token refreshed successfully",
            data: result
        });
    } catch (error) {
        return await handleError(res, 'authController', error);
    }
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


