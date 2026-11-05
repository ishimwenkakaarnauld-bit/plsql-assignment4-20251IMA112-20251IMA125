CREATE OR REPLACE PROCEDURE issue_stock (
    p_product_id IN products.product_id%TYPE,
    p_quantity   IN NUMBER,
    p_remarks    IN VARCHAR2 DEFAULT 'Stock issued',
    p_remaining  OUT NUMBER
)
IS
    v_current_stock products.quantity%TYPE;
    e_invalid_quantity EXCEPTION;
    e_insufficient_stock EXCEPTION;
BEGIN
    IF p_quantity IS NULL OR p_quantity <= 0 THEN
        RAISE e_invalid_quantity;
    END IF;

    SELECT quantity INTO v_current_stock
    FROM products
    WHERE product_id = p_product_id;

    IF v_current_stock < p_quantity THEN
        RAISE e_insufficient_stock;
    END IF;

    UPDATE products
    SET quantity = quantity - p_quantity
    WHERE product_id = p_product_id;

    IF SQL%FOUND THEN
        p_remaining := v_current_stock - p_quantity;

        INSERT INTO stock_transactions
            (product_id, transaction_type, quantity, remarks)
        VALUES
            (p_product_id, 'OUT', p_quantity, p_remarks);

        DBMS_OUTPUT.PUT_LINE('Stock issued successfully.');
        DBMS_OUTPUT.PUT_LINE('Remaining stock: ' || p_remaining);
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20011, 'Cannot issue stock: product not found.');
    WHEN e_invalid_quantity THEN
        RAISE_APPLICATION_ERROR(-20012, 'Issue quantity must be greater than zero.');
    WHEN e_insufficient_stock THEN
        RAISE_APPLICATION_ERROR(-20013, 'Insufficient stock. Available quantity: ' || v_current_stock);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20014, 'issue_stock failed: ' || SQLERRM);
END;
/
