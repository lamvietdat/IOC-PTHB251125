set SEARCH_PATH to bai4;
-- Bảng tài khoản khách hàng
CREATE TABLE accounts (
                          account_id SERIAL PRIMARY KEY,           -- Mã tài khoản, tự động tăng
                          customer_name VARCHAR(100),              -- Tên khách hàng
                          balance NUMERIC(12,2)                    -- Số dư tài khoản, định dạng số thập phân
);

-- Bảng ghi nhận giao dịch
CREATE TABLE transactions (
                              trans_id SERIAL PRIMARY KEY,             -- Mã giao dịch, tự động tăng
                              account_id INT REFERENCES accounts(account_id),  -- Liên kết đến tài khoản
                              amount NUMERIC(12,2),                    -- Số tiền giao dịch
                              trans_type VARCHAR(20),                  -- Loại giao dịch: 'WITHDRAW' hoặc 'DEPOSIT'
                              created_at TIMESTAMP DEFAULT NOW()       -- Thời gian thực hiện giao dịch
);
--
-- Giả sử dùng PostgreSQL
-- Biến đầu vào
-- account_id cần rút và số tiền cần rút
-- Ví dụ: rút 100.00 từ account_id = 1

BEGIN;

-- (Tùy chọn) khóa hàng để tránh cập nhật đồng thời
SELECT balance
FROM accounts
WHERE account_id = 1
    FOR UPDATE;

-- Trừ số dư nếu đủ tiền
UPDATE accounts
SET balance = balance - 100.00
WHERE account_id = 1
  AND balance >= 100.00;

-- Kiểm tra có thực sự trừ được hay không (phải có 1 hàng bị ảnh hưởng)
-- Nếu không có hàng nào, có thể ROLLBACK (thực thi thủ công) hoặc để ứng dụng quyết định
-- Tiếp tục ghi log giao dịch
INSERT INTO transactions (account_id, amount, trans_type)
VALUES (1, 100.00, 'WITHDRAW');

COMMIT;

-- Kiểm tra lại số dư và log
SELECT * FROM accounts WHERE account_id = 1;
SELECT * FROM transactions WHERE account_id = 1 ORDER BY created_at DESC;

--
-- Mô phỏng lỗi: nhập sai account_id khi ghi log (vi phạm khóa ngoại)
BEGIN;

-- Khóa và kiểm tra số dư
SELECT balance
FROM accounts
WHERE account_id = 1
    FOR UPDATE;

-- Trừ số dư nếu đủ
UPDATE accounts
SET balance = balance - 100.00
WHERE account_id = 1
  AND balance >= 100.00;

-- Ghi log lỗi (account_id = 9999 không tồn tại -> lỗi FK)
INSERT INTO transactions (account_id, amount, trans_type)
VALUES (9999, 100.00, 'WITHDRAW');

-- Do câu lệnh INSERT gây lỗi, transaction sẽ thất bại.
-- Thực hiện ROLLBACK để hoàn tác toàn bộ thay đổi
ROLLBACK;

-- Chứng minh số dư không đổi sau ROLLBACK
SELECT * FROM accounts WHERE account_id = 1;
SELECT * FROM transactions WHERE account_id = 1 ORDER BY created_at DESC;