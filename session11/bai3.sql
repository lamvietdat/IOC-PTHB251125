set SEARCH_PATH to bai3;
-- Bảng sản phẩm
CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,         -- Mã sản phẩm, tự tăng
                          product_name VARCHAR(100),             -- Tên sản phẩm
                          stock INT,                             -- Số lượng tồn kho
                          price NUMERIC(10,2)                    -- Giá sản phẩm
);

-- Bảng đơn hàng
CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,           -- Mã đơn hàng, tự tăng
                        customer_name VARCHAR(100),            -- Tên khách hàng
                        total_amount NUMERIC(10,2),            -- Tổng tiền đơn hàng
                        created_at TIMESTAMP DEFAULT NOW()     -- Thời gian tạo đơn hàng
);

-- Bảng chi tiết đơn hàng
CREATE TABLE order_items (
                             order_item_id SERIAL PRIMARY KEY,      -- Mã chi tiết đơn hàng, tự tăng
                             order_id INT REFERENCES orders(order_id),     -- Liên kết đến đơn hàng
                             product_id INT REFERENCES products(product_id), -- Liên kết đến sản phẩm
                             quantity INT,                          -- Số lượng sản phẩm đặt
                             subtotal NUMERIC(10,2)                 -- Thành tiền cho sản phẩm đó
);



--

BEGIN;

-- Kiểm tra tồn kho sản phẩm 1
SELECT stock FROM products WHERE product_id = 1;

-- Kiểm tra tồn kho sản phẩm 2
SELECT stock FROM products WHERE product_id = 2;

-- Giảm tồn kho nếu đủ hàng
UPDATE products
SET stock = stock - 2
WHERE product_id = 1 AND stock >= 2;

UPDATE products
SET stock = stock - 1
WHERE product_id = 2 AND stock >= 1;

-- Tạo đơn hàng
INSERT INTO orders (customer_name, total_amount)
VALUES ('Nguyen Van A', 0);

-- Lấy order_id vừa tạo
-- (giả sử đang dùng PostgreSQL, có thể dùng currval)
SELECT currval('orders_order_id_seq') INTO order_id;

-- Thêm sản phẩm vào order_items
INSERT INTO order_items (order_id, product_id, quantity, subtotal)
SELECT order_id, 1, 2, price * 2 FROM products WHERE product_id = 1;

INSERT INTO order_items (order_id, product_id, quantity, subtotal)
SELECT order_id, 2, 1, price * 1 FROM products WHERE product_id = 2;

-- Tính tổng tiền và cập nhật vào đơn hàng
UPDATE orders
SET total_amount = (
    SELECT SUM(subtotal)
    FROM order_items
    WHERE order_id = orders.order_id
)
WHERE order_id = order_id;

COMMIT;

-- Kiểm tra lại dữ liệu
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;


---


-- Giảm tồn kho sản phẩm 2 xuống 0 để mô phỏng lỗi
UPDATE products
SET stock = 0
WHERE product_id = 2;

-- Bắt đầu transaction đặt hàng
BEGIN;

-- Giảm tồn kho sản phẩm 1
UPDATE products
SET stock = stock - 2
WHERE product_id = 1 AND stock >= 2;

-- Giảm tồn kho sản phẩm 2 (sẽ không thực hiện được do stock = 0)
UPDATE products
SET stock = stock - 1
WHERE product_id = 2 AND stock >= 1;

-- Nếu một trong hai UPDATE không thực hiện được, rollback
ROLLBACK;

-- Kiểm tra lại dữ liệu để chứng minh không có thay đổi
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;