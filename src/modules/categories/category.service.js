const categoryModel = require('./category.model');

const createCategory = async (name) => {
    const existing = await categoryModel.findByName(name);
    if (existing) {
        const error = new Error('Category name already exists');
        error.statusCode = 400;
        throw error;
    }

    const result = await categoryModel.create(name);
    const newCategory = await categoryModel.findById(result.insertId);
    return newCategory;
};

const updateCategory = async (params, body) => {
    const { id } = params;
    const { name } = body;

    const category = await categoryModel.findById(id);
    if (!category) {
        const error = new Error('Category not found');
        error.statusCode = 404;
        throw error;
    }

    const existing = await categoryModel.findByName(name);
    if (existing && existing.id !== category.id) {
        const error = new Error('Category name already exists');
        error.statusCode = 400;
        throw error;
    }

    await categoryModel.updateById(id, name);
    return await categoryModel.findById(id);
};

const deleteCategory = async (id) => {
    const category = await categoryModel.findById(id);
    if (!category) {
        const error = new Error('Category not found');
        error.statusCode = 404;
        throw error;
    }

    await categoryModel.deleteById(id);
};

const getAllCategories = async () => {
    return await categoryModel.getAll();
};

module.exports = {
    createCategory,
    updateCategory,
    deleteCategory,
    getAllCategories
};
