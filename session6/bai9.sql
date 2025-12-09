set SEARCH_PATH  to bai9;
CREATE TABLE Product (
                         id SERIAL PRIMARY KEY,
                         name VARCHAR(100),
                         category VARCHAR(50),
                         price NUMERIC(10,2)
);
CREATE TABLE OrderDetail (
                             id SERIAL PRIMARY KEY,
                             order_id INT,
                             product_id INT,
                             quantity INT
);
 alter table OrderDetail add
     foreign key (product_id) references product(id);
INSERT INTO Product (name, category, price) VALUES
                                                ('Laptop Dell XPS 13', 'Electronics', 1200.00),
                                                ('iPhone 15 Pro', 'Electronics', 1500.50),
                                                ('Bàn làm việc gỗ', 'Furniture', 300.00),
                                                ('Ghế văn phòng Ergonomic', 'Furniture', 250.75),
                                                ('Áo sơ mi nam', 'Clothing', 45.25);
INSERT INTO OrderDetail (order_id, product_id, quantity) VALUES
                                                             (1, 1, 2),   -- 2 chiếc Laptop Dell XPS 13
                                                             (1, 2, 1),   -- 1 chiếc iPhone 15 Pro
                                                             (2, 3, 5),   -- 5 bàn làm việc gỗ
                                                             (3, 4, 3),   -- 3 ghế văn phòng Ergonomic
                                                             (4, 5, 10);  -- 10 áo sơ mi nam
--c1
select p.name,sum(price*quantity) as "tổng doanh thu" from product p join OrderDetail o on p.id =o.product_id
group by p.id , p.name;
--c2
select p.category,avg(price*quantity) from  product p join OrderDetail o on p.id =o.product_id
group by category;
--c3
select p.category from product p join OrderDetail o on p.id =o.product_id
group by p.id , p.category
having avg(price*quantity)>2000;
--c4
select p.name from product p join OrderDetail o on p.id =o.product_id
group by p.id , p.name
having sum(price*quantity)>(select avg(price*quantity)from  product p join OrderDetail o on p.id =o.product_id);
--