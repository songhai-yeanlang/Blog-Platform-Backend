const pool = require('../../configs/db.config');
const createAccount = async (data, connection = pool) => {
    const sql = `
        INSERT INTO account (email, password, verification_token, verification_expires, is_verified, is_active, role)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    `;
    const params = [
        data.email,
        data.password,
        data.verificationToken,
        data.verificationExpires,
        data.isVerified ? 1 : 0,
        data.isActive ? 1 : 0,
        'user'
    ];
    const [result] = await connection.query(sql, params);
    return result;
};

const createUser = async (data, connection = pool) => {
    const sql = `
        INSERT INTO users (account_id, name)
        VALUES (?, ?)
    `;
    const [result] = await connection.query(sql, [data.accountId, data.name]);
    return result;
};


const findByEmail = async (email) => {
    const sql = `
        SELECT a.id, u.name, a.email, a.is_verified
        FROM account a
        LEFT JOIN users u ON u.account_id = a.id
        WHERE a.email = ?
        LIMIT 1
    `;
    const [rows] = await pool.query(sql, [email]);
    return rows[0];
};


const findForLogin = async (email) => {
    const sql = `
        SELECT a.id, u.name, a.email, a.password, a.role, a.is_verified, a.is_active
        FROM account a
        LEFT JOIN users u ON u.account_id = a.id
        WHERE a.email = ?
        LIMIT 1
    `;
    const [rows] = await pool.query(sql, [email]);
    return rows[0];
};


const findById = async (id) => {
    const sql = `
        SELECT a.id, u.name, a.email, a.role, a.is_verified, a.is_active, u.phone, u.bio, u.avatar
        FROM account a
        LEFT JOIN users u ON u.account_id = a.id
        WHERE a.id = ?
        LIMIT 1
    `;
    const [rows] = await pool.query(sql, [id]);
    return rows[0];
};


const findByVerificationToken = async (verificationToken) => {
    const sql = `
        SELECT a.id, u.name, a.email, a.is_verified, a.is_active, a.verification_expires
        FROM account a
        LEFT JOIN users u ON u.account_id = a.id
        WHERE a.verification_token = ?
        LIMIT 1
    `;
    const [rows] = await pool.query(sql, [verificationToken]);
    return rows[0];
};


const markEmailAsVerified = async (id) => {
    const sql = `
        UPDATE account 
        SET is_verified = 1, is_active = 1, verification_token = NULL, verification_expires = NULL
        WHERE id = ?
    `;
    const [row] = await pool.query(sql, [id]);
    return row;
};


const updateVerificationToken = async (id, verificationToken, verificationExpires) => {
    const sql = `
        UPDATE account 
        SET verification_token = ?, verification_expires = ? 
        WHERE id = ?
    `;
    await pool.query(sql, [verificationToken, verificationExpires, id]);
};


const updateToken = async (id, token) => {
    const sql = `
        UPDATE account 
        SET token = ? 
        WHERE id = ?
    `;
    await pool.query(sql, [token, id]);
};

const findByOtp = async (otp) => {
    const sql = `
        SELECT id, email, token
        FROM account
        WHERE token LIKE ?
        LIMIT 1
    `;
    const [rows] = await pool.query(sql, [`%"otp":"${otp}"%`]);
    return rows[0];
};

const findTokenByEmail = async (email) => {
    const sql = `
        SELECT id, email, token
        FROM account
        WHERE email = ?
        LIMIT 1
    `;
    const [rows] = await pool.query(sql, [email]);
    return rows[0];
};

const findPasswordById = async (id) => {
    const sql = `
        SELECT password 
        FROM account 
        WHERE id = ? 
        LIMIT 1
    `;
    const [rows] = await pool.query(sql, [id]);
    return rows[0];
};

const updatePassword = async (id, newPasswordHash) => {
    const sql = `
        UPDATE account 
        SET password = ? 
        WHERE id = ?
    `;
    await pool.query(sql, [newPasswordHash, id]);
};

const findByRefreshToken = async (refreshToken) => {
    const sql = `
        SELECT a.id, u.name, a.email, a.role, a.is_verified, a.is_active, a.refresh_token_expires
        FROM account a
        LEFT JOIN users u ON u.account_id = a.id
        WHERE a.refresh_token = ?
        LIMIT 1
    `;
    const [rows] = await pool.query(sql, [refreshToken]);
    return rows[0];
};

const updateRefreshToken = async (id, refreshToken, refreshTokenExpires) => {
    const sql = `
        UPDATE account 
        SET refresh_token = ?, refresh_token_expires = ? 
        WHERE id = ?
    `;
    await pool.query(sql, [refreshToken, refreshTokenExpires, id]);
};

module.exports = {
    createAccount,
    createUser,
    findByEmail,
    findForLogin,
    findById,
    findByVerificationToken,
    markEmailAsVerified,
    updateVerificationToken,
    updateToken,
    findByOtp,
    findTokenByEmail,
    updatePassword,
    findPasswordById,
    findByRefreshToken,
    updateRefreshToken
};

