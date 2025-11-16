-- Seed Data for South Region Database
-- Replicated Data: All categories (same in all databases)
-- Fragmented Data: South-specific customers, orders, and some products

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

-- South Region Specific Products
INSERT INTO products (id, category_id, name, description, price, stock, warehouse_location) VALUES
(201, 2, 'South Beach Wear', 'Lightweight summer clothing', 49.99, 120, 'SOUTH'),
(202, 3, 'Garden Hose (South)', 'Heavy-duty garden hose', 34.99, 75, 'SOUTH'),
(203, 5, 'Surfboard', 'Professional surfboard', 399.99, 20, 'SOUTH'),
(204, 7, 'BBQ Grill', 'Outdoor barbecue grill', 299.99, 35, 'SOUTH'),
(205, 8, 'Sunscreen SPF 50', 'Water-resistant sunscreen', 15.99, 200, 'SOUTH');

-- South Region Customers
INSERT INTO customers (id, name, email, phone, region, address) VALUES
(21, 'Carlos Rodriguez', 'carlos.r@south.com', '555-0201', 'SOUTH', '100 Beach Blvd, South Bay'),
(22, 'Maria Gonzalez', 'maria.g@south.com', '555-0202', 'SOUTH', '200 Palm Ave, South Beach'),
(23, 'Antonio Lopez', 'alopez@south.com', '555-0203', 'SOUTH', '300 Ocean Dr, South Coast'),
(24, 'Isabella Martinez', 'imartinez@south.com', '555-0204', 'SOUTH', '400 Sunset Blvd, South Bay'),
(25, 'Diego Hernandez', 'dhernandez@south.com', '555-0205', 'SOUTH', '500 Coastal Rd, South Beach'),
(26, 'Sofia Perez', 'sperez@south.com', '555-0206', 'SOUTH', '600 Marina Way, South Coast'),
(27, 'Miguel Sanchez', 'msanchez@south.com', '555-0207', 'SOUTH', '700 Seaside Ln, South Bay'),
(28, 'Lucia Ramirez', 'lramirez@south.com', '555-0208', 'SOUTH', '800 Harbor St, South Beach'),
(29, 'Juan Torres', 'jtorres@south.com', '555-0209', 'SOUTH', '900 Tide Ave, South Coast'),
(30, 'Carmen Flores', 'cflores@south.com', '555-0210', 'SOUTH', '1000 Wave Dr, South Bay'),
(31, 'Pedro Rivera', 'privera@south.com', '555-0211', 'SOUTH', '1100 Coral Ct, South Beach'),
(32, 'Ana Gomez', 'agomez@south.com', '555-0212', 'SOUTH', '1200 Lagoon Rd, South Coast');

-- South Region Orders
INSERT INTO orders (id, customer_id, total_amount, status, order_date) VALUES
(21, 21, 449.98, 'completed', '2025-11-01 11:00:00'),
(22, 22, 34.99, 'shipped', '2025-11-02 13:30:00'),
(23, 23, 399.99, 'completed', '2025-11-03 10:45:00'),
(24, 24, 315.98, 'processing', '2025-11-04 15:20:00'),
(25, 25, 49.99, 'completed', '2025-11-05 12:15:00'),
(26, 26, 95.97, 'shipped', '2025-11-06 14:40:00'),
(27, 27, 299.99, 'completed', '2025-11-07 16:00:00'),
(28, 28, 65.97, 'processing', '2025-11-08 11:30:00'),
(29, 29, 425.98, 'completed', '2025-11-09 13:10:00'),
(30, 30, 79.98, 'shipped', '2025-11-10 15:50:00'),
(31, 31, 415.97, 'completed', '2025-11-11 10:20:00'),
(32, 32, 149.96, 'processing', '2025-11-12 14:30:00');

-- South Region Order Items
INSERT INTO order_items (id, order_id, product_id, quantity, price, subtotal) VALUES
(21, 21, 203, 1, 399.99, 399.99),
(22, 21, 201, 1, 49.99, 49.99),
(23, 22, 202, 1, 34.99, 34.99),
(24, 23, 203, 1, 399.99, 399.99),
(25, 24, 204, 1, 299.99, 299.99),
(26, 24, 205, 1, 15.99, 15.99),
(27, 25, 201, 1, 49.99, 49.99),
(28, 26, 205, 3, 15.99, 47.97),
(29, 26, 3, 2, 19.99, 39.98),
(30, 27, 204, 1, 299.99, 299.99),
(31, 28, 201, 1, 49.99, 49.99),
(32, 28, 205, 1, 15.99, 15.99),
(33, 29, 203, 1, 399.99, 399.99),
(34, 29, 1, 1, 25.99, 25.99),
(35, 30, 202, 2, 34.99, 69.98),
(36, 31, 203, 1, 399.99, 399.99),
(37, 31, 205, 1, 15.99, 15.99),
(38, 32, 201, 3, 49.99, 149.97),
(39, 32, 2, 1, 12.99, 12.99);

-- Reset sequences
SELECT setval('categories_id_seq', (SELECT MAX(id) FROM categories));
SELECT setval('products_id_seq', (SELECT MAX(id) FROM products));
SELECT setval('customers_id_seq', (SELECT MAX(id) FROM customers));
SELECT setval('orders_id_seq', (SELECT MAX(id) FROM orders));
SELECT setval('order_items_id_seq', (SELECT MAX(id) FROM order_items));
