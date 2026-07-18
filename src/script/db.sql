CREATE TABLE account (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    token VARCHAR(500),
    role ENUM('admin', 'user') DEFAULT 'user',
    is_active TINYINT(1) DEFAULT 0,
    is_verified TINYINT(1) DEFAULT 0,
    verification_token VARCHAR(255),
    verification_expires DATETIME,
    last_login_at DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL UNIQUE,
    name VARCHAR(255),
    phone VARCHAR(20),
    bio TEXT,
    avatar TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES account(id) ON DELETE CASCADE
);

CREATE TABLE addresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT, 
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE blog_post (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NULL,
    category_id INT NULL,
    title VARCHAR(255) NOT NULL,
    content LONGTEXT,
    image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

CREATE TABLE blog_post_tags (
    post_id INT,
    tag_id INT,
    PRIMARY KEY (post_id, tag_id),
    FOREIGN KEY (post_id) REFERENCES blog_post(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);


-- update table account 24/06/2026
ALTER TABLE account
ADD COLUMN refresh_token VARCHAR(500) AFTER token,
ADD COLUMN refresh_token_expires DATETIME AFTER refresh_token;

-- add table view_blog 25/06/2026
CREATE TABLE view_blog (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    viewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_user_view (post_id, user_id),
    FOREIGN KEY (post_id) REFERENCES blog_post(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- add table favorites 26/06/2026
CREATE TABLE favorites (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_user_post_favorite (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES blog_post(id) ON DELETE CASCADE
);

-- add table notifications 28/06/2026
-- CREATE TABLE notifications (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     recipient_id INT NOT NULL,     
--     sender_id INT,                
--     post_id INT,                   
--     type VARCHAR(50) NOT NULL,     
--     message VARCHAR(255),          
--     is_read TINYINT(1) DEFAULT 0,
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--     FOREIGN KEY (recipient_id) REFERENCES users(id) ON DELETE CASCADE,
--     FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
--     FOREIGN KEY (post_id) REFERENCES blog_post(id) ON DELETE CASCADE
-- );