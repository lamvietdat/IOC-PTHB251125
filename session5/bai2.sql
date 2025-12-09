set SEARCH_PATH  to  baikha2;


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
select p.product_name , sum(o.total_price)from products p JOIN orders  o on p.product_id = o.product_id
group by p.product_id
having sum(o.total_price)=(select   sum(o.total_price)  from products p JOIN orders  o on p.product_id = o.product_id
                           group by p.product_id
                           order by   sum(o.total_price) DESC  limit 1);

--c2
select p.category , sum(o.total_price) from products p JOIN orders  o on p.product_id = o.product_id
group by p.category;
--c3
(select p.category , sum(o.total_price)from products p JOIN orders  o on p.product_id = o.product_id
group by p.category
having sum(o.total_price)=(select   sum(o.total_price)  from products p JOIN orders  o on p.product_id = o.product_id
                           group by p.category
                           order by   sum(o.total_price) DESC  limit 1))
intersect
(select p.category , sum(o.total_price) from products p join orders o
on p.product_id=o.product_id
group by p.category
having sum(o.total_price)>3000)



