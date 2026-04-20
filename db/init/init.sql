DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

\c techstore_db

CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       name VARCHAR(255) NOT NULL,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       password_hash VARCHAR(244) NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
                            id SERIAL PRIMARY KEY,
                            name VARCHAR(255) NOT NULL,
                            description TEXT
);
CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(255) NOT NULL,
                          price NUMERIC(10,2) NOT NULL CHECK (price > 0),
                          category_id INTEGER REFERENCES categories(id) ON DELETE RESTRICT,
                          stock INTEGER NOT NULL CHECK (stock >= 0),
                          information TEXT,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
                        id SERIAL PRIMARY KEY,
                        user_id INTEGER REFERENCES users(id) ON DELETE RESTRICT,
                        total_amount NUMERIC(10,2) NOT NULL,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items(
                            id SERIAL PRIMARY KEY,
                            order_id INTEGER REFERENCES orders(id) ON DELETE RESTRICT,
                            product_id INTEGER REFERENCES products(id) ON DELETE RESTRICT,
                            quantity INTEGER NOT NULL,
                            price NUMERIC(10,2) NOT NULL
);

TRUNCATE TABLE order_items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;
TRUNCATE TABLE products RESTART IDENTITY CASCADE;
TRUNCATE TABLE categories RESTART IDENTITY CASCADE;
TRUNCATE TABLE users RESTART IDENTITY CASCADE;

INSERT INTO users (name, email, password_hash) VALUES
('Sergey', 'sergey@example.com', '$2b$12$...'),
('Alex', 'alex@example.com', '$2b$12$...'),
('Pol', 'pol@example.com', '$2b$12$...'),
('Alina', 'alina@example.com', '$2b$12$...'),
('Jon', 'jon@example.com', '$2b$12$...');

INSERT INTO categories (name, description) VALUES
('Notebooks', 'Notebooks for work and study'),
('Smartphones', 'Latest smartphones'),
('Headphones', 'Wireless and noise-canceling headphones'),
('Cameras', 'Digital cameras for photography'),
('Gaming Consoles', 'Next-generation gaming consoles');

INSERT INTO products (name, price, category_id, stock, information) VALUES
('MacBook Pro 13"', 1299.99, 1, 100, 'Apple M1 chip, 8GB RAM, 256GB SSD'),
('MacBook Pro 16', 1890, 1, 30, 'Apple M3 chip, 16GB RAM, 256GB SSD'),
('MacBook Pro 16', 2890, 1, 30, 'Apple M5 chip, 24GB RAM, 256GB SSD'),
('iPhone 11', 699,2,10,'A13 Bionic chip, 4GB RAM, 64GB storage'),
('iPhone 12', 799,2,20,'A15 Bionic chip, 4GB RAM, 64GB storage'),
('iPhone 13', 899,2,15,'A18 Bionic chip, 4GB RAM, 64GB storage'),
('Apple Max', 2890, 3, 50, 'Apple MAX headphones'),
('Sony WH-1000XM4', 249.99, 3, 60, 'Noise-canceling wireless headphones'),
('Bose QuietComfort 35 II', 310, 3, 20, 'Wireless Bluetooth headphones with noise cancellation'),
('Canon EOS R5', 4890, 4, 10, '45MP full-frame mirrorless camera'),
('Nikon Z6 II', 2000, 4, 28, '24.5MP full-frame mirrorless camera'),
('Nikon Z7 II', 2800, 4, 22, '35MP full-frame mirrorless camera'),
('Xbox Series X', 480.99, 5, 5, 'Powerful gaming console with fast load times'),
('Switch 2', 1480.99, 5, 5, 'Powerful gaming console'),
('PlayStation 5', 489, 5, 70, 'Next-gen gaming console with ultra-fast SSD');

INSERT INTO orders (user_id, total_amount) VALUES
(1, 2248.98),
(2, 9780),
(3,3997.98),
(4,249.99),
(5,14670);

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1,1,1, 1299.99),
(1,4,1,699),
(1,8,1,249.99),
(2,10,2,4890),
(3,1,2,1299.99),
(3,4,2,699),
(4,8,1,249.99),
(5,10,3,4890);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_name ON users(name);

CREATE INDEX IF NOT EXISTS idx_products_category_price
    ON products(category_id, price);

CREATE INDEX IF NOT EXISTS idx_products_price_desc
    ON products(price DESC);

CREATE INDEX IF NOT EXISTS idx_products_name ON products(name);

CREATE INDEX IF NOT EXISTS idx_orders_user_id ON orders(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_user_id_total
    ON orders(user_id, total_amount);

CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON order_items(order_id);

CREATE INDEX IF NOT EXISTS idx_order_items_product_id ON order_items(product_id);

CREATE INDEX IF NOT EXISTS idx_order_items_product_quantity
    ON order_items(product_id, quantity);
