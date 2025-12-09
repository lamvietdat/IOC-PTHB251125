set SEARCH_PATH to bai5;
CREATE TABLE Course (
                        id SERIAL PRIMARY KEY,
                        title VARCHAR(100),
                        instructor VARCHAR(50),
                        price NUMERIC(10,2),
                        duration INT -- số giờ học
);
INSERT INTO Course (title, instructor, price, duration) VALUES
                                                            ('Lập trình Python cơ bản', 'Nguyễn Văn A', 1500000.00, 40),
                                                            ('Thiết kế Web với HTML & CSS', 'Trần Thị B', 1200000.00, 30),
                                                            ('Phân tích dữ liệu với Excel', 'Lê Văn C', 1000000.00, 25),
                                                            ('Machine Learning nâng cao', 'Phạm Thị D', 2500000.00, 50),
                                                            ('Marketing số cho người mới bắt đầu', 'Hoàng Văn E', 1300000.00, 35),
                                                            ('Kỹ năng giao tiếp chuyên nghiệp', 'Vũ Thị F', 900000.00, 20);
--c2
update Course set price = price*11/10 where duration >30;
--c3
delete FROM Course where title ='Demo';
--c4
select * from Course where title ilike '%SQL%';
--c5
select * FROM Course where price between 500000 and 2000000;