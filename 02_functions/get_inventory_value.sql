CREATE OR REPLACE FUNCTION get_inventory_value
RETURN NUMBER
IS
    v_total_value NUMBER(16,2);
BEGIN
    SELECT NVL(SUM(quantity * unit_price), 0)
    INTO v_total_value
    FROM products;

    RETURN v_total_value;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20051, 'get_inventory_value failed: ' || SQLERRM);
END;
/
