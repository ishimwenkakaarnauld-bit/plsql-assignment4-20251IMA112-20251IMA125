-- Sample data: 3 categories and 8 products.
INSERT INTO categories (category_name) VALUES ('Electronics');
INSERT INTO categories (category_name) VALUES ('Stationery');
INSERT INTO categories (category_name) VALUES ('Furniture');

INSERT INTO products (product_name, category_id, unit_price, quantity, reorder_level)
VALUES ('Laptop', 1, 850000, 12, 3);
INSERT INTO products (product_name, category_id, unit_price, quantity, reorder_level)
VALUES ('Wireless Mouse', 1, 18000, 30, 8);
INSERT INTO products (product_name, category_id, unit_price, quantity, reorder_level)
VALUES ('Keyboard', 1, 25000, 18, 5);
INSERT INTO products (product_name, category_id, unit_price, quantity, reorder_level)
VALUES ('A4 Paper Pack', 2, 6500, 50, 10);
INSERT INTO products (product_name, category_id, unit_price, quantity, reorder_level)
VALUES ('Blue Pen', 2, 500, 100, 20);
INSERT INTO products (product_name, category_id, unit_price, quantity, reorder_level)
VALUES ('Notebook', 2, 2500, 40, 10);
INSERT INTO products (product_name, category_id, unit_price, quantity, reorder_level)
VALUES ('Office Chair', 3, 95000, 7, 2);
INSERT INTO products (product_name, category_id, unit_price, quantity, reorder_level)
VALUES ('Office Desk', 3, 180000, 4, 2);

INSERT INTO stock_transactions (product_id, transaction_type, quantity, remarks)
VALUES (1, 'IN', 12, 'Opening stock');
INSERT INTO stock_transactions (product_id, transaction_type, quantity, remarks)
VALUES (2, 'IN', 30, 'Opening stock');
INSERT INTO stock_transactions (product_id, transaction_type, quantity, remarks)
VALUES (3, 'IN', 18, 'Opening stock');
INSERT INTO stock_transactions (product_id, transaction_type, quantity, remarks)
VALUES (4, 'IN', 50, 'Opening stock');
INSERT INTO stock_transactions (product_id, transaction_type, quantity, remarks)
VALUES (5, 'IN', 100, 'Opening stock');
INSERT INTO stock_transactions (product_id, transaction_type, quantity, remarks)
VALUES (6, 'IN', 40, 'Opening stock');
INSERT INTO stock_transactions (product_id, transaction_type, quantity, remarks)
VALUES (7, 'IN', 7, 'Opening stock');
INSERT INTO stock_transactions (product_id, transaction_type, quantity, remarks)
VALUES (8, 'IN', 4, 'Opening stock');

COMMIT;
PROMPT Sample data inserted successfully.
