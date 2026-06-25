const { handleError } = require('../../utils/handleError');
const tagService = require('./tag.service');

const createTag = async (req, res) => {
    try {
     
        const data = await tagService.createTag(req.validated || req.body);
        return res.status(201).json({
            success: true,
            message: "Tag created successfully",
            data
        });
    } catch (error) {
        return await handleError(res, 'tagController', error);
    }
};

module.exports = {
    createTag
};
