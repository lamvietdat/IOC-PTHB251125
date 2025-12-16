set  SEARCH_PATH  to bai4;
CREATE TABLE customer (
                          customer_id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          region VARCHAR(50)
);

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customer(customer_id),
                        total_amount DECIMAL(10,2),
                        order_date DATE,
                        status VARCHAR(20)
);

CREATE TABLE product (
                         product_id SERIAL PRIMARY KEY,
                         name VARCHAR(100),
                         price DECIMAL(10,2),
                         category VARCHAR(50)
);

CREATE TABLE order_detail (
                              order_id INT REFERENCES orders(order_id),
                              product_id INT REFERENCES product(product_id),
                              quantity INT
);
-- Khách hàng
INSERT INTO customer (full_name, region) VALUES
                                             ('Nguyễn Văn A', 'Hà Nội'),
                                             ('Trần Thị B', 'TP. Hồ Chí Minh'),
                                             ('Lê Văn C', 'Đà Nẵng');

-- Sản phẩm
INSERT INTO product (name, price, category) VALUES
                                                ('Laptop Dell XPS 13', 25000000, 'Electronics'),
                                                ('Điện thoại iPhone 14', 22000000, 'Electronics'),
                                                ('Bàn làm việc gỗ sồi', 3500000, 'Furniture');

-- Đơn hàng
INSERT INTO orders (customer_id, total_amount, order_date, status) VALUES
                                                                       (1, 47000000, '2025-12-10', 'Completed'),
                                                                       (2, 3500000, '2025-12-11', 'Pending');

-- Chi tiết đơn hàng
INSERT INTO order_detail (order_id, product_id, quantity) VALUES
                                                              (1, 1, 1),
                                                              (1, 2, 1),
                                                              (2, 3, 1);
--1
CREATE VIEW v_revenue_by_region AS
SELECT c.region, SUM(o.total_amount) AS total_revenue
FROM customer c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region;

SELECT region, total_revenue
FROM v_revenue_by_region
ORDER BY total_revenue DESC
LIMIT 3;
--2
CREATE MATERIALIZED VIEW mv_monthly_sales AS
SELECT DATE_TRUNC('month', order_date) AS month,
       SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date);

UPDATE orders
SET status = 'Completed'
WHERE DATE_TRUNC('month', order_date) = DATE '2025-12-01';

CREATE VIEW v_pending_orders AS
SELECT * FROM orders
WHERE status = 'Pending'
        WITH CHECK OPTION;

UPDATE v_pending_orders
SET status = 'Completed'
WHERE order_id = 2;
--3
CREATE VIEW v_revenue_above_avg AS
SELECT region, total_revenue
FROM v_revenue_by_region
WHERE total_revenue > (
    SELECT AVG(total_revenue)
    FROM v_revenue_by_region
);