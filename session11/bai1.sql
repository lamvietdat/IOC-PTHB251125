create schema bai1;
set SEARCH_PATH  to  bai1;
-- Tạo bảng flights
CREATE TABLE flights (
                         flight_id SERIAL PRIMARY KEY,
                         flight_name VARCHAR(100),
                         available_seats INT
);

-- Tạo bảng bookings với khóa ngoại liên kết đến bảng flights
CREATE TABLE bookings (
                          booking_id SERIAL PRIMARY KEY,
                          flight_id INT REFERENCES flights(flight_id),
                          customer_name VARCHAR(100)
);

-- Chèn dữ liệu vào bảng flights
INSERT INTO flights (flight_name, available_seats)
VALUES ('VN123', 3), ('VN456', 2);
BEGIN;

-- Giảm số ghế của chuyến bay 'VN123' đi 1
UPDATE flights
SET available_seats = available_seats - 1
WHERE flight_name = 'VN123';

-- Thêm bản ghi đặt vé của khách hàng 'Nguyen Van A'
INSERT INTO bookings (flight_id, customer_name)
SELECT flight_id, 'Nguyen Van A'
FROM flights
WHERE flight_name = 'VN123';
BEGIN;

-- Giảm số ghế của chuyến bay 'VN123' đi 1
UPDATE flights
SET available_seats = available_seats - 1
WHERE flight_name = 'VN123';

-- Nhập sai flight_id (ví dụ: flight_id không tồn tại)
INSERT INTO bookings (flight_id, customer_name)
VALUES (9999, 'Nguyen Van A');  -- Giả sử 9999 không tồn tại

-- Gọi rollback do lỗi
ROLLBACK;

-- Kiểm tra lại dữ liệu để chứng minh số ghế không thay đổi
SELECT * FROM flights;
SELECT * FROM bookings;

COMMIT;

-- Kiểm tra lại dữ liệu
SELECT * FROM flights;
SELECT * FROM bookings;