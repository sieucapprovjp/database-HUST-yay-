-- 1. Tạo bảng Danh mục (Hỗ trợ cấu trúc phân cấp)
CREATE TABLE categories (
                            category_id SERIAL PRIMARY KEY,
                            name VARCHAR(100) NOT NULL,
                            parent_id INT REFERENCES categories(category_id)
);

-- 2. Tạo bảng Khách hàng
CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           city VARCHAR(100),
                           join_date DATE NOT NULL
);

-- 3. Tạo bảng Sản phẩm
CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          name VARCHAR(150) NOT NULL,
                          category_id INT REFERENCES categories(category_id),
                          price DECIMAL(10, 2) NOT NULL
);

-- 4. Tạo bảng Đơn hàng
CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customers(customer_id),
                        order_date DATE NOT NULL,
                        status VARCHAR(50) DEFAULT 'completed'
);

-- 5. Tạo bảng Chi tiết đơn hàng
CREATE TABLE order_items (
                             order_id INT REFERENCES orders(order_id),
                             product_id INT REFERENCES products(product_id),
                             quantity INT NOT NULL,
                             unit_price DECIMAL(10, 2) NOT NULL,
                             PRIMARY KEY (order_id, product_id)
);

-- ==========================================
-- CHÈN DỮ LIỆU MẪU
-- ==========================================

-- Categories (Điện tử là danh mục cha, các mục khác là con)
INSERT INTO categories (name, parent_id) VALUES
                                             ('Điện tử', NULL),         -- 1
                                             ('Điện thoại', 1),         -- 2
                                             ('Laptop', 1),             -- 3
                                             ('Phụ kiện', 1),           -- 4
                                             ('Gia dụng', NULL);        -- 5

-- Customers
INSERT INTO customers (name, city, join_date) VALUES
                                                  ('Nguyễn Văn A', 'Hà Nội', '2025-12-15'),
                                                  ('Trần Thị B', 'Hồ Chí Minh', '2026-01-10'),
                                                  ('Lê Văn C', 'Hà Nội', '2026-02-20'),
                                                  ('Phạm Thị D', 'Đà Nẵng', '2026-03-05'),
                                                  ('Hoàng Văn E', 'Hải Phòng', '2026-04-01');

-- Products
INSERT INTO products (name, category_id, price) VALUES
                                                    ('iPhone 15 Pro Max', 2, 1200.00),
                                                    ('Samsung Galaxy S24', 2, 1000.00),
                                                    ('MacBook Pro M3', 3, 2000.00),
                                                    ('ThinkPad X1 Carbon', 3, 1800.00),
                                                    ('Tai nghe AirPods Pro', 4, 250.00),
                                                    ('Chuột Logitech MX Master 3', 4, 100.00),
                                                    ('Bàn phím cơ Keychron', 4, 150.00),
                                                    ('Nồi chiên không dầu', 5, 200.00);

-- Orders (Tháng 3 và Tháng 4 năm 2026)
INSERT INTO orders (customer_id, order_date, status) VALUES
                                                         (1, '2026-03-10', 'completed'), -- Order 1
                                                         (2, '2026-03-15', 'completed'), -- Order 2
                                                         (1, '2026-04-02', 'completed'), -- Order 3
                                                         (3, '2026-04-05', 'completed'), -- Order 4
                                                         (4, '2026-04-10', 'cancelled'), -- Order 5
                                                         (1, '2026-04-15', 'completed'); -- Order 6

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
                                                                         (1, 1, 1, 1200.00),
                                                                         (1, 5, 2, 250.00),
                                                                         (2, 3, 1, 2000.00),
                                                                         (3, 2, 1, 1000.00),
                                                                         (3, 6, 1, 100.00),
                                                                         (4, 5, 1, 250.00),
                                                                         (4, 7, 1, 150.00),
                                                                         (5, 8, 1, 200.00),
                                                                         (6, 1, 1, 1200.00),
                                                                         (6, 2, 1, 1000.00);