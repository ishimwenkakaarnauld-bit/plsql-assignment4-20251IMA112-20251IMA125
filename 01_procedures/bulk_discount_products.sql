CREATE OR REPLACE PROCEDURE bulk_discount_products (
    p_category_id IN products.category_id%TYPE,
    p_discount_percent IN NUMBER
)
IS
    TYPE product_id_table IS TABLE OF products.product_id%TYPE;
    v_product_ids product_id_table;
    e_bulk_errors EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_bulk_errors, -24381);
BEGIN
    IF p_discount_percent IS NULL OR p_discount_percent < 0 OR p_discount_percent > 100 THEN
        RAISE_APPLICATION_ERROR(-20041, 'Discount must be between 0 and 100.');
    END IF;

    -- BULK COLLECT retrieves many product IDs into one collection.
    SELECT product_id
    BULK COLLECT INTO v_product_ids
    FROM products
    WHERE category_id = p_category_id;

    IF v_product_ids.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No products found in this category.');
        RETURN;
    END IF;

    -- FORALL sends the updates to SQL in batches instead of one PL/SQL loop per row.
    FORALL i IN 1 .. v_product_ids.COUNT SAVE EXCEPTIONS
        UPDATE products
        SET unit_price = ROUND(unit_price * (1 - p_discount_percent / 100), 2)
        WHERE product_id = v_product_ids(i);

    DBMS_OUTPUT.PUT_LINE('Products updated in bulk: ' || SQL%ROWCOUNT);

EXCEPTION
    WHEN e_bulk_errors THEN
        DBMS_OUTPUT.PUT_LINE('Some bulk updates failed. Error count: ' || SQL%BULK_EXCEPTIONS.COUNT);
        FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(
                'Collection index ' || SQL%BULK_EXCEPTIONS(i).ERROR_INDEX ||
                ', Oracle error: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE)
            );
        END LOOP;
        RAISE_APPLICATION_ERROR(-20042, 'Bulk discount completed with one or more row errors.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20043, 'bulk_discount_products failed: ' || SQLERRM);
END;
/
