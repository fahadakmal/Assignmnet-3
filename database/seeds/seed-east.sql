-- Seed Data for East Region Database
-- Replicated Data: All categories (same in all databases)
-- Fragmented Data: East-specific customers, orders, and some products

-- ======================
-- REPLICATED DATA (50%)
-- ======================

-- Categories (100% replicated - same in all databases)
INSERT INTO categories (id, name, description) VALUES
(1, 'Electronics', 'Electronic devices and gadgets'),
(2, 'Clothing', 'Apparel and fashion items'),
(3, 'Home & Garden', 'Home improvement and garden supplies'),
(4, 'Books', 'Books and educational materials'),
(5, 'Sports', 'Sports equipment and accessories'),
(6, 'Toys', 'Toys and games for all ages'),
(7, 'Food & Beverages', 'Groceries and drinks'),
(8, 'Beauty', 'Beauty and personal care products'),
(9, 'Automotive', 'Car parts and accessories'),
(10, 'Office Supplies', 'Office equipment and stationery');

-- Global Products (replicated across all databases)
INSERT INTO products (id, category_id, name, description, price, stock, warehouse_location) VALUES
(1, 1, 'Wireless Mouse', 'Ergonomic wireless mouse', 25.99, 150, 'GLOBAL'),
(2, 1, 'USB Cable', 'USB-C charging cable', 12.99, 300, 'GLOBAL'),
(3, 2, 'White T-Shirt', 'Cotton t-shirt', 19.99, 200, 'GLOBAL'),
(4, 4, 'Programming Book', 'Learn Python basics', 39.99, 100, 'GLOBAL'),
(5, 5, 'Yoga Mat', 'Non-slip yoga mat', 29.99, 80, 'GLOBAL');

-- ======================
-- FRAGMENTED DATA (50%)
-- ======================

-- East Region Specific Products
INSERT INTO products (id, category_id, name, description, price, stock, warehouse_location) VALUES
(301, 1, 'Smart Watch (East)', 'Fitness tracking smartwatch', 249.99, 50, 'EAST'),
(302, 4, 'East Regional History Book', 'Historical documentation', 29.99, 85, 'EAST'),
(303, 6, 'Educational Toys Set', 'STEM learning toys', 59.99, 65, 'EAST'),
(304, 9, 'Car Navigation System', 'GPS navigation', 179.99, 40, 'EAST'),
(305, 10, 'Premium Desk Chair', 'Ergonomic office chair', 349.99, 30, 'EAST');

-- East Region Customers
INSERT INTO customers (id, name, email, phone, region, address) VALUES
(41, 'William Chen', 'wchen@east.com', '555-0301', 'EAST', '10 Tech Park, East Metro'),
(42, 'Emma Wang', 'ewang@east.com', '555-0302', 'EAST', '20 Innovation Dr, East City'),
(43, 'Oliver Kim', 'okim@east.com', '555-0303', 'EAST', '30 Silicon Valley, East Metro'),
(44, 'Ava Patel', 'apatel@east.com', '555-0304', 'EAST', '40 Digital Ave, East City'),
(45, 'Noah Singh', 'nsingh@east.com', '555-0305', 'EAST', '50 Startup Ln, East Metro'),
(46, 'Sophia Lee', 'slee@east.com', '555-0306', 'EAST', '60 Campus Rd, East City'),
(47, 'Liam Zhang', 'lzhang@east.com', '555-0307', 'EAST', '70 Research Blvd, East Metro'),
(48, 'Mia Kumar', 'mkumar@east.com', '555-0308', 'EAST', '80 University St, East City'),
(49, 'Ethan Park', 'epark@east.com', '555-0309', 'EAST', '90 Academic Way, East Metro'),
(50, 'Charlotte Liu', 'cliu@east.com', '555-0310', 'EAST', '100 Scholar Dr, East City'),
(51, 'Benjamin Nguyen', 'bnguyen@east.com', '555-0311', 'EAST', '110 Learning Ct, East Metro'),
(52, 'Amelia Yamamoto', 'ayamamoto@east.com', '555-0312', 'EAST', '120 Knowledge Ave, East City');

-- East Region Orders
INSERT INTO orders (id, customer_id, total_amount, status, order_date) VALUES
(41, 41, 275.98, 'completed', '2025-11-01 09:15:00'),
(42, 42, 349.99, 'shipped', '2025-11-02 11:45:00'),
(43, 43, 59.99, 'completed', '2025-11-03 14:20:00'),
(44, 44, 429.98, 'processing', '2025-11-04 10:30:00'),
(45, 45, 179.99, 'completed', '2025-11-05 13:00:00'),
(46, 46, 109.97, 'shipped', '2025-11-06 15:40:00'),
(47, 47, 249.99, 'completed', '2025-11-07 09:50:00'),
(48, 48, 89.97, 'processing', '2025-11-08 12:25:00'),
(49, 49, 529.97, 'completed', '2025-11-09 14:55:00'),
(50, 50, 459.97, 'shipped', '2025-11-10 10:10:00'),
(51, 51, 299.97, 'completed', '2025-11-11 13:35:00'),
(52, 52, 119.96, 'processing', '2025-11-12 15:20:00');

-- East Region Order Items
INSERT INTO order_items (id, order_id, product_id, quantity, price, subtotal) VALUES
(41, 41, 301, 1, 249.99, 249.99),
(42, 41, 1, 1, 25.99, 25.99),
(43, 42, 305, 1, 349.99, 349.99),
(44, 43, 303, 1, 59.99, 59.99),
(45, 44, 304, 2, 179.99, 359.98),
(46, 44, 302, 1, 29.99, 29.99),
(47, 45, 304, 1, 179.99, 179.99),
(48, 46, 302, 3, 29.99, 89.97),
(49, 46, 4, 1, 39.99, 39.99),
(50, 47, 301, 1, 249.99, 249.99),
(51, 48, 303, 1, 59.99, 59.99),
(52, 48, 5, 1, 29.99, 29.99),
(53, 49, 305, 1, 349.99, 349.99),
(54, 49, 304, 1, 179.99, 179.99),
(55, 50, 301, 1, 249.99, 249.99),
(56, 50, 304, 1, 179.99, 179.99),
(57, 50, 5, 1, 29.99, 29.99),
(58, 51, 303, 5, 59.99, 299.95),
(59, 52, 302, 4, 29.99, 119.96);

-- Reset sequences
SELECT setval('categories_id_seq', (SELECT MAX(id) FROM categories));
SELECT setval('products_id_seq', (SELECT MAX(id) FROM products));
SELECT setval('customers_id_seq', (SELECT MAX(id) FROM customers));
SELECT setval('orders_id_seq', (SELECT MAX(id) FROM orders));
SELECT setval('order_items_id_seq', (SELECT MAX(id) FROM order_items));
