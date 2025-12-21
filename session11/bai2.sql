set SEARCH_PATH to bai2;
CREATE TABLE accounts (
                          account_id SERIAL PRIMARY KEY,       -- Mã tài khoản, tự tăng
                          owner_name VARCHAR(100),             -- Tên chủ tài khoản
                          balance NUMERIC(10,2)                -- Số dư, định dạng số thập phân với 2 chữ số sau dấu phẩy
);
INSERT INTO accounts (owner_name, balance)
VALUES ('A', 500.00), ('B', 300.00);

BEGIN;

-- Giảm số dư tài khoản A đi 100.00
UPDATE accounts
SET balance = balance - 100.00
WHERE owner_name = 'A';

-- Tăng số dư tài khoản B thêm 100.00
UPDATE accounts
SET balance = balance + 100.00
WHERE owner_name = 'B';

COMMIT;

-- Kiểm tra lại số dư mới của cả hai tài khoản
SELECT * FROM accounts;


--
BEGIN;

-- Giảm số dư tài khoản A đi 100.00
UPDATE accounts
SET balance = balance - 100.00
WHERE owner_name = 'A';

-- Cố ý nhập sai account_id hoặc tên người nhận (ví dụ: 'C' không tồn tại)
UPDATE accounts
SET balance = balance + 100.00
WHERE owner_name = 'C';

-- Khi xảy ra lỗi, hủy toàn bộ thay đổi
ROLLBACK;

-- Kiểm tra lại số dư để chứng minh không có thay đổi
SELECT * FROM accounts;

create schema bai3;