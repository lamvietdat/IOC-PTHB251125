set SEARCH_PATH  to bai3;
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
--c2
select distinct name from Customer;
--c3
select *from Customer where email is null;
--c4
select *from Customer order by points DESC limit 3  offset 1;
--c5
select *from Customer order by name DESC ;