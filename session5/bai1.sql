create schema baikha1;
set SEARCH_PATH to baikha1;
CREATE TABLE products (
                          product_id INT PRIMARY KEY,
                          product_name VARCHAR(100),
                          category VARCHAR(50)
);

INSERT INTO products (product_id, product_name, category) VALUES
                                                              (1, 'Laptop Dell', 'Electronics'),
                                                              (2, 'IPhone 15', 'Electronics'),
                                                              (3, 'Bàn học gỗ', 'Furniture'),
                                                              (4, 'Ghế xoay', 'Furniture');


CREATE TABLE orders (
                        order_id INT PRIMARY KEY,
                        product_id INT,
                        quantity INT,
                        total_price DECIMAL(10, 2)
);
ALTER TABLE orders
    ADD FOREIGN KEY (product_id) REFERENCES products(product_id);

INSERT INTO orders (order_id, product_id, quantity, total_price) VALUES
                                                                     (101, 1, 2, 2200),
                                                                     (102, 2, 3, 3300),
                                                                     (103, 3, 5, 2500),
                                                                     (104, 4, 4, 1600),
                                                                     (105, 1, 1, 1100);

--c1
select  category as "danh mục",sum(total_price*quantity) as "tổng doanh thu",sum(quantity) as "tổng số lượng "
from products as p  join orders as o on p.product_id = o.product_id
group by category
--c2
select p.product_name from products p  join orders o on p.product_id = o.product_id
group by p.product_name
having sum(total_price*quantity)>2000;
--c3
select p.product_name ,sum(total_price*quantity) from products p  join orders o on p.product_id = o.product_id
group by p.product_name
order by  sum(total_price*quantity) DESC ;