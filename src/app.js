require('dotenv').config();
const express = require('express');
const cors = require('cors');
const app = express();
app.use(express.json());
app.use(cors());

const userRoutes = require('./modules/users/user.routes');
app.use('/api/users', userRoutes);

const productRoutes = require('./modules/products/product.routes');
app.use('/api/products', productRoutes);

const adminRoutes = require('./modules/admin/admin.routes');
app.use('/api/admins', adminRoutes);

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
