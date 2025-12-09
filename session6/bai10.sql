set SEARCH_PATH to bai10;
-- Tạo bảng OldCustomers
CREATE TABLE OldCustomers (
                              id SERIAL PRIMARY KEY,
                              name VARCHAR(100),
                              city VARCHAR(50)
);

-- Thêm 5 bản ghi vào bảng OldCustomers
INSERT INTO OldCustomers (name, city) VALUES
                                          ('Nguyễn Văn A', 'Hà Nội'),
                                          ('Trần Thị B', 'Đà Nẵng'),
                                          ('Lê Văn C', 'Hồ Chí Minh'),
                                          ('Phạm Thị D', 'Cần Thơ'),
                                          ('Hoàng Văn E', 'Huế');

-- Tạo bảng NewCustomers
CREATE TABLE NewCustomers (
                              id SERIAL PRIMARY KEY,
                              name VARCHAR(100),
                              city VARCHAR(50)
);

-- Thêm 5 bản ghi vào bảng NewCustomers
INSERT INTO NewCustomers (name, city) VALUES
                                          ('Vũ Thị hao', 'Hà Nội'),
                                          ('Đặng Văn G', 'Hải Phòng'),
                                          ('Bùi Thị H', 'Nha Trang'),
                                          ('Ngô Văn I', 'Bình Dương'),
                                          ('Dương Thị J', 'Vũng Tàu');
--c1
(select * from NewCustomers)
union
(select * from OldCustomers);
--c2
(select * from NewCustomers)
intersect
(select * from OldCustomers);
--c3
(select  city ,count(id) as"số khách hàng " from NewCustomers group by city)
union
(select  city ,count(id) as"số khách hàng " from OldCustomers group by city);
--c4
(select city ,count(id) from NewCustomers
                       group by city
having  count(id) = (select count(id) from NewCustomers group by city order by count(id) DESC limit 1))
union
(select city ,count(id) from OldCustomers
 group by city
 having  count(id) = (select count(id) from OldCustomers group by city order by count(id) DESC limit 1))


