CREATE OR REPLACE PROCEDURE add_stock (
    p_product_id IN products.product_id%TYPE,
    p_quantity   IN NUMBER,
    p_remarks    IN VARCHAR2 DEFAULT 'Stock received',
    p_new_stock  OUT NUMBER
)
IS
    e_invalid_quantity EXCEPTION;
    v_product products%ROWTYPE; -- %ROWTYPE record: same structure as a products row
BEGIN
    IF p_quantity IS NULL OR p_quantity <= 0 THEN
        RAISE e_invalid_quantity;
    END IF;

    SELECT * INTO v_product
    FROM products
    WHERE product_id = p_product_id;

    UPDATE products
    SET quantity = quantity + p_quantity
    WHERE product_id = p_product_id;

    IF SQL%FOUND THEN
        SELECT quantity INTO p_new_stock
        FROM products
        WHERE product_id = p_product_id;

        INSERT INTO stock_transactions
            (product_id, transaction_type, quantity, remarks)
        VALUES
            (p_product_id, 'IN', p_quantity, p_remarks);

        DBMS_OUTPUT.PUT_LINE('Stock received for ' || v_product.product_name);
        DBMS_OUTPUT.PUT_LINE('New stock quantity: ' || p_new_stock);
        DBMS_OUTPUT.PUT_LINE('Rows inserted into transaction history: ' || SQL%ROWCOUNT);
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Product was not updated.');
    END IF;

EXCEPTION
    WHEN e_invalid_quantity THEN
        RAISE_APPLICATION_ERROR(-20002, 'Stock quantity must be greater than zero.');
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'Product ID ' || p_product_id || ' does not exist.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20004, 'add_stock failed: ' || SQLERRM);
END;
/
