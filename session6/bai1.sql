set SEARCH_PATH to bai1;
CREATE TABLE Product (
                         id SERIAL PRIMARY KEY,
                         name VARCHAR(100),
                         category VARCHAR(50),
                         price NUMERIC(10,2),
                         stock INT
);
--c1
INSERT INTO Product (name, category, price, stock) VALUES
                                                       ('Laptop Dell XPS 13', 'Laptop', 25000.00, 10),
                                                       ('iPhone 15 Pro', 'Smartphone', 32000.00, 15),
                                                       ('Tai nghe Sony WH-1000XM5', 'Phụ kiện', 7000.00, 25),
                                                       ('Chuột Logitech MX Master 3', 'Phụ kiện', 2500.00, 40),
                                                       ('Màn hình LG UltraFine 4K', 'Màn hình', 12000.00, 8);
--c2
select *from Product;
--c3
select *from Product order by price DESC limit 3;
--c4
select * from Product where category='Điện Tử' and price<100000000;
--c5

select *from Product where stock>0 order by stock ASC ;
