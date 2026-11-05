CREATE OR REPLACE PROCEDURE purge_old_transactions (
    p_before_date IN DATE,
    p_deleted_count OUT NUMBER
)
IS
BEGIN
    DELETE FROM stock_transactions
    WHERE transaction_date < p_before_date;

    p_deleted_count := SQL%ROWCOUNT;

    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('No old transactions were found.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Deleted transactions: ' || SQL%ROWCOUNT);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20031, 'purge_old_transactions failed: ' || SQLERRM);
END;
/
