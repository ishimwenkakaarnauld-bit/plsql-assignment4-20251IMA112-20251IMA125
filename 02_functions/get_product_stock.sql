CREATE OR REPLACE FUNCTION get_product_stock (
    p_product_id IN products.product_id%TYPE
)
RETURN NUMBER
IS
    v_quantity products.quantity%TYPE;
BEGIN
    SELECT quantity INTO v_quantity
    FROM products
    WHERE product_id = p_product_id;

    RETURN v_quantity;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20052, 'No product exists with ID ' || p_product_id);
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20053, 'Unexpected duplicate product rows.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20054, 'get_product_stock failed: ' || SQLERRM);
END;
/
