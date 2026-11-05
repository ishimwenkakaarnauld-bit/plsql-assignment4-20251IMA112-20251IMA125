SET SERVEROUTPUT ON;

PROMPT === TEST 1: Show inventory using explicit cursor and user-defined record ===
BEGIN
    show_inventory;
END;
/

PROMPT === TEST 2: Add stock (uses %ROWTYPE and implicit cursor attributes) ===
DECLARE
    v_new_stock NUMBER;
BEGIN
    add_stock(1, 5, 'Test stock delivery', v_new_stock);
    DBMS_OUTPUT.PUT_LINE('Returned new stock: ' || v_new_stock);
END;
/

PROMPT === TEST 3: Issue stock ===
DECLARE
    v_remaining NUMBER;
BEGIN
    issue_stock(2, 3, 'Test issue to department', v_remaining);
    DBMS_OUTPUT.PUT_LINE('Returned remaining stock: ' || v_remaining);
END;
/

PROMPT === TEST 4: Show low-stock items using a collection ===
BEGIN
    show_low_stock;
END;
/

PROMPT === TEST 5: Bulk discount all Electronics by 5 percent ===
BEGIN
    bulk_discount_products(1, 5);
END;
/

PROMPT === TEST 6: Call functions from an anonymous PL/SQL block ===
BEGIN
    DBMS_OUTPUT.PUT_LINE('Total inventory value: ' || get_inventory_value());
    DBMS_OUTPUT.PUT_LINE('Laptop stock: ' || get_product_stock(1));
END;
/

PROMPT === TEST 7: Demonstrate DELETE implicit cursor attributes ===
DECLARE
    v_deleted NUMBER;
BEGIN
    -- Future date used so this demonstration removes the sample transactions.
    purge_old_transactions(SYSDATE + 1, v_deleted);
    DBMS_OUTPUT.PUT_LINE('Output parameter deleted count: ' || v_deleted);
END;
/

ROLLBACK;
