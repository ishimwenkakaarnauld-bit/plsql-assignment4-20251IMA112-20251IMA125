# plsql-assignment4-20251IMA112-20251IMA125
# Inventory Control System (PL/SQL Assignment IV)

**Course:** Database Development with PL/SQL (INSY 8311)  
**Platform:** ORACLE XE 21C
**Project theme:** Inventory control

## Team
1. **Name:** ISHIMWE NKAKA Arnauld | **Student ID:** 20251IMA125
2. **Name:** SHIMWA ELOIS Arnaud | **Student ID:** 20251IMA112



## Overview
This project is an inventory management system for a shop or an institution. It keeps track of product categories, products, prices, stock quantities, reorder levels, and every movement of stock in and out. With it, a user can:

- receive new stock and issue stock to customers or departments
- view the full inventory at any time
- find products that have fallen below their reorder level
- apply a discount to every product in a category
- calculate the total value of the inventory



## Project layout
```text
plsql-assignment4-<studentID1>-<studentID2>/
├── README.md
├── .gitignore
├── 00_schema/
│   ├── 01_create_tables.sql
│   └── 02_insert_sample_data.sql
├── 01_procedures/
│   ├── add_stock.sql
│   ├── issue_stock.sql
│   ├── show_inventory.sql
│   ├── show_low_stock.sql
│   ├── purge_old_transactions.sql
│   └── bulk_discount_products.sql
├── 02_functions/
│   ├── get_inventory_value.sql
│   └── get_product_stock.sql
├── 03_tests/
│   ├── test_success_cases.sql
│   └── test_error_cases.sql
├── screenshots/
└── docs/
    └── IMPLEMENTATION_NOTES.md
```

## Running the project
Use one Oracle connection and the same schema for every step, in this exact order:

1. Open SQL Developer and connect with your Oracle 21c XE user
2. Run `00_schema/01_create_tables.sql` 
3. Run `00_schema/02_insert_sample_data.sql` to load the sample data.
4. Compile all `.sql` files inside `01_procedures/`.
5. Compile all `.sql` files inside `02_functions/`.
6. Run `03_tests/test_success_cases.sql`.
7. Run `03_tests/test_error_cases.sql`.
8. Review the Script Output and DBMS Output panels, .

.

## Sample function calls
```sql
SELECT get_inventory_value() AS total_inventory_value FROM dual;

SELECT get_product_stock(1) AS laptop_quantity FROM dual;
```

.
