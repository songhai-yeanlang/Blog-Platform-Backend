const pool = require('../../configs/db.config');

const findById = async (id) => {
    const sql = `
        SELECT a.id, u.id as user_id, u.name, a.email, a.role, a.is_verified, a.is_active, u.phone, u.bio, u.avatar
        FROM account a
        LEFT JOIN users u ON u.account_id = a.id
        WHERE a.id = ?
        LIMIT 1
    `;
    const [rows] = await pool.query(sql, [id]);
    return rows[0];
};

const getAllUsers = async () => {
    const sql = `
        SELECT a.id, u.id as user_id, u.name, a.email, a.role, a.is_verified, a.is_active, u.phone, u.bio, u.avatar
        FROM account a
        LEFT JOIN users u ON u.account_id = a.id
    `;
    const [rows] = await pool.query(sql);
    return rows;
};

const updateByAccountId = async (accountId, data) => {
    const sql = `
        UPDATE users
        SET name = COALESCE(?, name),
            phone = COALESCE(?, phone),
            bio = COALESCE(?, bio),
            avatar = COALESCE(?, avatar)
        WHERE account_id = ?
    `;
    const params = [
        data.name ?? null,
        data.phone ?? null,
        data.bio ?? null,
        data.avatar ?? null,
        accountId
    ];
    const [result] = await pool.query(sql, params);
    return result;
};

const updateAvatarByAccountId = async (accountId, avatarUrl) => {
    const sql = `
        UPDATE users
        SET avatar = ?
        WHERE account_id = ?
    `;
    const [result] = await pool.query(sql, [avatarUrl, accountId]);
    return result;
};

module.exports = {
    findById,
    getAllUsers,
    updateByAccountId,
    updateAvatarByAccountId
};

