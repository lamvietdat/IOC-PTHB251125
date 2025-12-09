set  SEARCH_PATH to bai4;
CREATE TABLE Customer (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          email VARCHAR(100),
                          phone VARCHAR(20),
                          points INT
);
INSERT INTO Customer (name, email, phone, points) VALUES
                                                      ('Nguyễn Văn A', 'a@gmail.com', '0901234567', 120),
                                                      ('Trần Thị B', 'b@gmail.com', '0912345678', 150),
                                                      ('Lê Văn C', 'c@gmail.com', '0923456789', 180),
                                                      ('Phạm Thị D', NULL, '0934567890', 100),
                                                      ('Hoàng Văn E', 'e@gmail.com', '0945678901', 200),
                                                      ('Vũ Thị F', 'f@gmail.com', '0956789012', 170),
                                                      ('Đặng Văn G', 'g@gmail.com', '0967890123', 160);

CREATE TABLE OrderInfo (
                           id SERIAL PRIMARY KEY,
                           customer_id INT,
                           order_date DATE,
                           total NUMERIC(10,2),
                           status VARCHAR(20)
);
INSERT INTO OrderInfo (customer_id, order_date, total, status) VALUES
                                                                   (1, '2025-01-10', 1500.00, 'Pending'),
                                                                   (2, '2025-01-12', 3200.00, 'Completed'),
                                                                   (3, '2025-01-15', 800.00, 'Cancelled'),
                                                                   (4, '2025-01-18', 2500.00, 'Completed'),
                                                                   (5, '2025-01-20', 1800.00, 'Pending');
--c2
select * from OrderInfo where total >500;
--c3
select * from OrderInfo where order_date between '2024-10-01' and '2024-11-01';
--c4
select * from OrderInfo where status != 'completed';
--c5
select * from OrderInfo order by id DESC limit 2;