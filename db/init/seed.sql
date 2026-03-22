TRUNCATE TABLE order_items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;
TRUNCATE TABLE products RESTART IDENTITY CASCADE;
TRUNCATE TABLE categories RESTART IDENTITY CASCADE;
TRUNCATE TABLE users RESTART IDENTITY CASCADE;

INSERT INTO users (name, email) VALUES
('Sergey', 'sergey@example.com'),
('Alex', 'alex@example.com'),
('Pol', 'pol@example.com'),
('Alina', 'alina@example.com'),
('Jon', 'jon@example.com');

INSERT INTO categories (name) VALUES
('Notebooks'),
('Smartphones'),
('Headphones'),
('Cameras'),
('Gaming Consoles');

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