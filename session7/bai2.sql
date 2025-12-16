set SEARCH_PATH  to bai2;
CREATE TABLE customer (
                          customer_id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          email VARCHAR(100),
                          phone VARCHAR(15)
);

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customer(customer_id),
                        total_amount DECIMAL(10,2),
                        order_date DATE
);
INSERT INTO customer (full_name, email, phone) VALUES
                                                   ('Nguyễn Văn A', 'a.nguyen@example.com', '0901234567'),
                                                   ('Trần Thị B', 'b.tran@example.com', '0912345678'),
                                                   ('Lê Văn C', 'c.le@example.com', '0923456789'),
                                                   ('Phạm Thị D', 'd.pham@example.com', '0934567890'),
                                                   ('Hoàng Văn E', 'e.hoang@example.com', '0945678901'),
                                                   ('Đặng Thị F', 'f.dang@example.com', '0956789012'),
                                                   ('Vũ Văn G', 'g.vu@example.com', '0967890123'),
                                                   ('Bùi Thị H', 'h.bui@example.com', '0978901234'),
                                                   ('Đỗ Văn I', 'i.do@example.com', '0989012345'),
                                                   ('Ngô Thị J', 'j.ngo@example.com', '0990123456');
INSERT INTO orders (customer_id, total_amount, order_date) VALUES
                                                               (1, 250000.00, '2025-12-01'),
                                                               (2, 175000.50, '2025-12-02'),
                                                               (3, 320000.00, '2025-12-03'),
                                                               (4, 150000.75, '2025-12-04'),
                                                               (5, 450000.00, '2025-12-05'),
                                                               (6, 210000.00, '2025-12-06'),
                                                               (7, 380000.25, '2025-12-07'),
                                                               (8, 190000.00, '2025-12-08'),
                                                               (9, 275000.00, '2025-12-09'),
                                                               (10, 500000.00, '2025-12-10');

--c1
create view v_order_summary as select  c.full_name,o.total_amount,o.order_date  from orders o join customer c on c.customer_id = o.customer_id ;
--c2
SELECT * FROM v_order_summary;
--c3
create view order_full as select * from orders;
update  order_full set total_amount = 99999.9
where customer_id = 1;
--c4
create view v_monthly_sales as select  TRIM(TO_CHAR(order_date, 'Month')) as "thời gian" , sum(total_amount)  from orders group by  TRIM(TO_CHAR(order_date, 'Month'));

--c5
drop VIEW v_order_summary ;
--đây la câu lệnh xóa một view tực chất là xóa môt câu truy vấn ta đã lưu
-- còn drop materialized là xó một kết quả truy vấn được lưu dưới dang một bảng
