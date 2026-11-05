CREATE OR REPLACE PROCEDURE show_low_stock
IS
    -- Associative array collection stores multiple product names.
    TYPE name_array IS TABLE OF products.product_name%TYPE INDEX BY PLS_INTEGER;
    v_names name_array;
    v_index PLS_INTEGER := 0;
BEGIN
    FOR r IN (
        SELECT product_name, quantity, reorder_level
        FROM products
        WHERE quantity <= reorder_level
        ORDER BY product_name
    ) LOOP
        v_index := v_index + 1;
        v_names(v_index) := r.product_name;
        DBMS_OUTPUT.PUT_LINE(
            'LOW STOCK: ' || r.product_name ||
            ' | quantity=' || r.quantity ||
            ' | reorder level=' || r.reorder_level
        );
    END LOOP;

    IF v_index = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No products are currently below their reorder level.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Low-stock products stored in collection: ' || v_names.COUNT);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20022, 'show_low_stock failed: ' || SQLERRM);
END;
/
