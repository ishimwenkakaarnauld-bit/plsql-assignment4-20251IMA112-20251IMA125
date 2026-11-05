CREATE OR REPLACE PROCEDURE show_inventory
IS
    -- User-defined record: groups related product summary fields.
    TYPE product_summary_record IS RECORD (
        product_name VARCHAR2(100),
        category_name VARCHAR2(60),
        quantity NUMBER,
        unit_price NUMBER(10,2),
        stock_value NUMBER(14,2)
    );
    v_item product_summary_record;

    -- Explicit cursor retrieves several rows.
    CURSOR c_inventory IS
        SELECT p.product_name, c.category_name, p.quantity, p.unit_price,
               (p.quantity * p.unit_price) AS stock_value
        FROM products p
        JOIN categories c ON c.category_id = p.category_id
        ORDER BY c.category_name, p.product_name;
BEGIN
    OPEN c_inventory;
    LOOP
        FETCH c_inventory INTO v_item;
        EXIT WHEN c_inventory%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            RPAD(v_item.product_name, 20) ||
            ' Category: ' || RPAD(v_item.category_name, 12) ||
            ' Qty: ' || v_item.quantity ||
            ' Price: ' || v_item.unit_price ||
            ' Value: ' || v_item.stock_value
        );
    END LOOP;
    CLOSE c_inventory;
EXCEPTION
    WHEN OTHERS THEN
        IF c_inventory%ISOPEN THEN CLOSE c_inventory; END IF;
        RAISE_APPLICATION_ERROR(-20021, 'show_inventory failed: ' || SQLERRM);
END;
/
