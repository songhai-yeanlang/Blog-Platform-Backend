const tagModel = require('./tag.model');

const createTag = async (name) => {
    const existing = await tagModel.findByName(name);
    if (existing) {
        const error = new Error('Tag name already exists');
        error.statusCode = 400;
        throw error;
    }

    const result = await tagModel.create(name);
    const newTag = await tagModel.findById(result.insertId);
    return newTag;
};

module.exports = {
    createTag
};
