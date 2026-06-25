const pool = require('../../configs/db.config');

const findByName = async (name) => {
    const sql = `
        SELECT id, name, created_at, updated_at
        FROM tags
        WHERE name = ?
        LIMIT 1
    `;
    const [rows] = await pool.query(sql, [name]);
    return rows[0];
};

const findById = async (id) => {
    const sql = `
        SELECT id, name, created_at, updated_at
        FROM tags
        WHERE id = ?
        LIMIT 1
    `;
    const [rows] = await pool.query(sql, [id]);
    return rows[0];
};

const create = async (name) => {
    const sql = `
        INSERT INTO tags (name)
        VALUES (?)
    `;
    const [result] = await pool.query(sql, [name]);
    return result;
};

module.exports = {
    findByName,
    findById,
    create
};
