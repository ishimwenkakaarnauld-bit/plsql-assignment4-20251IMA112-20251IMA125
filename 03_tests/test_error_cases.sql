SET SERVEROUTPUT ON;

PROMPT === ERROR TEST 1: Invalid zero stock quantity ===
DECLARE
    v_new_stock NUMBER;
BEGIN
    add_stock(1, 0, 'Invalid test', v_new_stock);
EXCEPTION
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Expected error: ' || SQLERRM);
END;
/

PROMPT === ERROR TEST 2: Issue more stock than available ===
DECLARE
    v_remaining NUMBER;
BEGIN
    issue_stock(1, 999999, 'Invalid issue test', v_remaining);
EXCEPTION
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Expected error: ' || SQLERRM);
END;
/

PROMPT === ERROR TEST 3: Unknown product ID in function ===
BEGIN
    DBMS_OUTPUT.PUT_LINE('Stock: ' || get_product_stock(-999));
EXCEPTION
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Expected error: ' || SQLERRM);
END;
/

PROMPT === ERROR TEST 4: Invalid discount percentage ===
BEGIN
    bulk_discount_products(1, 150);
EXCEPTION
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Expected error: ' || SQLERRM);
END;
/
