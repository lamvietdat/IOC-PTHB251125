set SEARCH_PATH to baigioi2
CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           customer_name VARCHAR(100),
                           city VARCHAR(50)
);
CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customers(customer_id),
                        order_date DATE,
                        total_amount NUMERIC(10,2)
);
CREATE TABLE order_items (
                             item_id SERIAL PRIMARY KEY,
                             order_id INT REFERENCES orders(order_id),
                             product_name VARCHAR(100),
                             quantity INT,
                             price NUMERIC(10,2)
);
INSERT INTO customers (customer_name, city) VALUES
                                                ('Nguyễn Văn A', 'Hà Nội'),
                                                ('Trần Thị B', 'Đà Nẵng'),
                                                ('Lê Văn C', 'Hồ Chí Minh'),
                                                ('Phạm Thị D', 'Hà Nội');
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
                                                               (1, '2024-12-20', 3000.00),
                                                               (2, '2025-01-05', 1500.00),
                                                               (1, '2025-02-10', 2500.00),
                                                               (3, '2025-02-15', 4000.00),
                                                               (4, '2025-03-01', 800.00);
INSERT INTO order_items (order_id, product_name, quantity, price) VALUES
                                                                      (1, 'Laptop', 2, 1500.00),
                                                                      (2, 'Smartphone', 1, 1500.00),
                                                                      (3, 'Chuột máy tính', 5, 500.00),
                                                                      (4, 'Smartphone', 4, 1000.00);

--c1
select c.customer_name , o.order_date,o.total_amount  from customers c inner join  orders o on c.customer_id = o.order_id
--c2
select sum(o.total_amount) as "tổng doanh thi ",avg(o.total_amount) as "trung bình",max(o.order_id) as "giá cao nhất ",
       min(o.total_amount) as "gia nhỏ nhất",count(o.order_id) as "số lượng đợn"  from orders o
--3
select c.city,sum(o.total_amount)  from customers c join orders o on c.customer_id = o.customer_id
group by c.city
having sum(o.total_amount)>1000;
--c4
select oi.product_name,c.customer_name,o.order_date,oi.quantity,oi.price from customers c join orders o on c.customer_id = o.customer_id
                        join order_items oi on o.order_id = oi.order_id
--c5
select c.customer_name from customers c
where c.customer_id=
(select c.customer_id from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id,c.customer_name
order by  sum(o.total_amount) DESC limit 1)
--6
(select * from customers c left join orders o on c.customer_id = o.customer_id)
union
(select *from customers c right join orders o on c.customer_id = o.customer_id);

(select * from customers c left join orders o on c.customer_id = o.customer_id)
intersect
(select *from customers c right join orders o on c.customer_id = o.customer_id);