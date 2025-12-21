set SEARCH_PATH TO bai6;
CREATE TABLE accounts (
                          account_id SERIAL PRIMARY KEY,
                          account_name VARCHAR(50),
                          balance NUMERIC
);
INSERT INTO accounts (account_name, balance) VALUES
                                                 ('Tai khoan A', 1000000),
                                                 ('Tai khoan B', 500000);
BEGIN;

-- Giả sử chuyển 300000 từ tài khoản A (id = 1) sang tài khoản B (id = 2)
DO $$
    DECLARE
        sender_balance NUMERIC;
        amount NUMERIC := 300000;
    BEGIN
        SELECT balance INTO sender_balance FROM accounts WHERE account_id = 1;

        IF sender_balance >= amount THEN
            UPDATE accounts SET balance = balance - amount WHERE account_id = 1;
            UPDATE accounts SET balance = balance + amount WHERE account_id = 2;
            COMMIT;
            RAISE NOTICE 'Giao dịch thành công.';
        ELSE
            ROLLBACK;
            RAISE NOTICE 'Số dư không đủ, giao dịch bị hủy.';
        END IF;
    END;
$$;