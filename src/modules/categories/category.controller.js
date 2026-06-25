const { handleError } = require('../../utils/handleError');
const categoryService = require('./category.service');

const createCategory = async (req, res) => {
    try {
        const { name } = req.validated || req.body;
        const data = await categoryService.createCategory(name);
        return res.status(201).json({
            success: true,
            message: "Category created successfully",
            data
        });
    } catch (error) {
        return await handleError(res, 'categoryController', error);
    }
};

const updateCategory = async (req, res) => {
    try {

        const data = await categoryService.updateCategory(req.params, req.validated || req.body);
        return res.status(200).json({
            success: true,
            message: "Category updated successfully",
            data
        });
    } catch (error) {
        return await handleError(res, 'categoryController', error);
    }
};

const deleteCategory = async (req, res) => {
    try {
        const { id } = req.params;
        await categoryService.deleteCategory(id);
        return res.status(200).json({
            success: true,
            message: "Category deleted successfully"
        });
    } catch (error) {
        return await handleError(res, 'categoryController', error);
    }
};

const getAllCategories = async (req, res) => {
    try {
        const data = await categoryService.getAllCategories();
        return res.status(200).json({
            success: true,
            message: "Get all categories successfully",
            data
        });
    } catch (error) {
        return await handleError(res, 'categoryController', error);
    }
};

module.exports = {
    createCategory,
    updateCategory,
    deleteCategory,
    getAllCategories
};
