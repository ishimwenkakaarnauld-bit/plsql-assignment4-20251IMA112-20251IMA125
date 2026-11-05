# Implementation Notes – Inventory Control System

## 1. Application description
The application manages products held by a small institution or shop. It stores product categories, product details, current quantities, reorder levels, prices, and a history of stock received or issued.

## 2. Database design
- `CATEGORIES` stores category names.
- `PRODUCTS` stores each product, its category, unit price, available quantity, and reorder level.
- `STOCK_TRANSACTIONS` records every stock-in or stock-out movement.

Relationships:
- One category can contain many products.
- One product can have many stock transactions.
- Foreign keys prevent products or transactions from referring to missing parent records.
- CHECK constraints prevent negative prices/stock and invalid transaction types.

## 3. PL/SQL concepts demonstrated
- **User-defined record:** `product_summary_record` in `show_inventory` groups product name, category, quantity, price, and stock value.
- **%ROWTYPE:** `v_product products%ROWTYPE` in `add_stock` stores an entire row from PRODUCTS.
- **Collection:** `name_array` in `show_low_stock` stores multiple product names. `product_id_table` in `bulk_discount_products` stores IDs retrieved by BULK COLLECT.
- **Implicit cursors:** DML in `add_stock`, `issue_stock`, and `purge_old_transactions` uses `SQL%FOUND`, `SQL%NOTFOUND`, and `SQL%ROWCOUNT`. INSERT statements also use the implicit SQL cursor.
- **Explicit cursor:** `c_inventory` in `show_inventory` is explicitly OPENed, FETCHed, and CLOSEd to process multiple rows.
- **BULK COLLECT and FORALL:** `bulk_discount_products` fetches product IDs into a nested-table collection and updates them with FORALL. `SAVE EXCEPTIONS` allows the procedure to inspect individual bulk DML failures.
- **Procedures:** `add_stock`, `issue_stock`, `show_inventory`, `show_low_stock`, `purge_old_transactions`, and `bulk_discount_products`.
- **Functions:** `get_inventory_value` returns the total value of all stock; `get_product_stock` returns the quantity for one product.
- **Exception handling:** predefined exceptions include `NO_DATA_FOUND` and `TOO_MANY_ROWS`; user-defined exceptions validate stock operations; `RAISE_APPLICATION_ERROR` returns meaningful application errors.

## 4. Bulk processing and performance
A row-by-row loop repeatedly switches between the PL/SQL engine and the SQL engine. `BULK COLLECT` retrieves multiple rows in one operation, while `FORALL` sends repeated DML statements in batches. This reduces context switching and can improve performance for larger data sets. For very large tables, use a `LIMIT` clause with BULK COLLECT in a loop to control memory use. `SAVE EXCEPTIONS` collects row-level DML errors so they can be inspected rather than stopping at the first failed row.

## 5. Test plan
Run `test_success_cases.sql` to demonstrate normal operations and `test_error_cases.sql` to demonstrate validation and exception handling. Enable DBMS Output in SQL Developer. The success script ends with ROLLBACK so the test operations do not permanently change the sample data; remove the ROLLBACK if you want to retain the test changes.

## 6. Notes about test results
Actual output depends on the current data in the database and the order in which scripts are run. Capture screenshots from your own Oracle session after running the scripts. Do not submit fabricated screenshots.
