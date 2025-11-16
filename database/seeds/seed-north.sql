-- Seed Data for North Region Database
-- Replicated Data: All categories (same in all databases)
-- Fragmented Data: North-specific customers, orders, and some products

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

-- North Region Specific Products
INSERT INTO products (id, category_id, name, description, price, stock, warehouse_location) VALUES
(101, 1, 'North Gaming Laptop', 'High-performance gaming laptop', 1299.99, 25, 'NORTH'),
(102, 1, 'North Wireless Headphones', 'Noise-canceling headphones', 199.99, 45, 'NORTH'),
(103, 2, 'Winter Jacket (North)', 'Heavy winter jacket', 149.99, 60, 'NORTH'),
(104, 3, 'Snow Blower', 'Electric snow removal', 599.99, 15, 'NORTH'),
(105, 5, 'Ice Skates', 'Professional ice skates', 89.99, 30, 'NORTH');

-- North Region Customers
INSERT INTO customers (id, name, email, phone, region, address) VALUES
(1, 'John Smith', 'john.smith@north.com', '555-0101', 'NORTH', '123 Main St, North City'),
(2, 'Emily Johnson', 'emily.j@north.com', '555-0102', 'NORTH', '456 Oak Ave, North Town'),
(3, 'Michael Brown', 'mbrown@north.com', '555-0103', 'NORTH', '789 Pine Rd, North Village'),
(4, 'Sarah Davis', 'sdavis@north.com', '555-0104', 'NORTH', '321 Elm St, North City'),
(5, 'David Wilson', 'dwilson@north.com', '555-0105', 'NORTH', '654 Maple Dr, North Town'),
(6, 'Jennifer Garcia', 'jgarcia@north.com', '555-0106', 'NORTH', '987 Cedar Ln, North Village'),
(7, 'Robert Martinez', 'rmartinez@north.com', '555-0107', 'NORTH', '147 Birch Way, North City'),
(8, 'Lisa Anderson', 'landerson@north.com', '555-0108', 'NORTH', '258 Spruce St, North Town'),
(9, 'James Thomas', 'jthomas@north.com', '555-0109', 'NORTH', '369 Ash Blvd, North Village'),
(10, 'Mary Jackson', 'mjackson@north.com', '555-0110', 'NORTH', '741 Willow Ct, North City'),
(11, 'Christopher White', 'cwhite@north.com', '555-0111', 'NORTH', '852 Poplar Ave, North Town'),
(12, 'Patricia Harris', 'pharris@north.com', '555-0112', 'NORTH', '963 Hickory Rd, North Village');

-- North Region Orders
INSERT INTO orders (id, customer_id, total_amount, status, order_date) VALUES
(1, 1, 1325.98, 'completed', '2025-11-01 10:30:00'),
(2, 2, 45.98, 'completed', '2025-11-02 14:15:00'),
(3, 3, 199.99, 'shipped', '2025-11-03 09:20:00'),
(4, 4, 679.98, 'processing', '2025-11-04 16:45:00'),
(5, 5, 149.99, 'completed', '2025-11-05 11:00:00'),
(6, 6, 89.99, 'shipped', '2025-11-06 13:30:00'),
(7, 7, 38.98, 'completed', '2025-11-07 15:10:00'),
(8, 8, 1299.99, 'processing', '2025-11-08 10:50:00'),
(9, 9, 219.97, 'completed', '2025-11-09 12:20:00'),
(10, 10, 599.99, 'shipped', '2025-11-10 14:00:00'),
(11, 11, 179.98, 'completed', '2025-11-11 09:40:00'),
(12, 12, 249.97, 'processing', '2025-11-12 16:15:00');

-- North Region Order Items
INSERT INTO order_items (id, order_id, product_id, quantity, price, subtotal) VALUES
(1, 1, 101, 1, 1299.99, 1299.99),
(2, 1, 1, 1, 25.99, 25.99),
(3, 2, 3, 2, 19.99, 39.98),
(4, 2, 2, 1, 12.99, 12.99),
(5, 3, 102, 1, 199.99, 199.99),
(6, 4, 104, 1, 599.99, 599.99),
(7, 4, 3, 4, 19.99, 79.96),
(8, 5, 103, 1, 149.99, 149.99),
(9, 6, 105, 1, 89.99, 89.99),
(10, 7, 5, 1, 29.99, 29.99),
(11, 7, 4, 1, 39.99, 39.99),
(12, 8, 101, 1, 1299.99, 1299.99),
(13, 9, 102, 1, 199.99, 199.99),
(14, 9, 1, 1, 25.99, 25.99),
(15, 10, 104, 1, 599.99, 599.99),
(16, 11, 103, 1, 149.99, 149.99),
(17, 11, 5, 1, 29.99, 29.99),
(18, 12, 105, 2, 89.99, 179.98),
(19, 12, 3, 2, 19.99, 39.98);

-- Reset sequences
SELECT setval('categories_id_seq', (SELECT MAX(id) FROM categories));
SELECT setval('products_id_seq', (SELECT MAX(id) FROM products));
SELECT setval('customers_id_seq', (SELECT MAX(id) FROM customers));
SELECT setval('orders_id_seq', (SELECT MAX(id) FROM orders));
SELECT setval('order_items_id_seq', (SELECT MAX(id) FROM order_items));
