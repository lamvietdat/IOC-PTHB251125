set  SEARCH_PATH to baigioi1
CREATE TABLE customers (
                           customer_id INT PRIMARY KEY,
                           customer_name VARCHAR(100),
                           city VARCHAR(50)
);
INSERT INTO customers (customer_id, customer_name, city) VALUES
                                                             (1, 'Nguyễn Văn A', 'Hà Nội'),
                                                             (2, 'Trần Thị B', 'Đà Nẵng'),
                                                             (3, 'Lê Văn C', 'Hồ Chí Minh'),
                                                             (4, 'Phạm Thị D', 'Hà Nội');
CREATE TABLE orders (
                        order_id INT PRIMARY KEY,
                        customer_id INT,
                        order_date DATE,
                        total_price INT
);
alter table orders add
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

INSERT INTO orders (order_id, customer_id, order_date, total_price) VALUES
                                                                        (101, 1, '2024-12-20', 3000),
                                                                        (102, 2, '2025-01-05', 1500),
                                                                        (103, 1, '2025-02-10', 2500),
                                                                        (104, 3, '2025-02-15', 4000),
                                                                        (105, 4, '2025-03-01', 800);
CREATE TABLE order_items (
                             item_id INT PRIMARY KEY,
                             order_id INT,
                             product_id INT,
                             quantity INT,
                             price INT,
                             FOREIGN KEY (order_id) REFERENCES orders(order_id)

);
INSERT INTO order_items (item_id, order_id, product_id, quantity, price) VALUES
                                                                             (1, 101, 1, 2, 1500),
                                                                             (2, 102, 2, 1, 1500),
                                                                             (3, 103, 3, 5, 500),
                                                                             (4, 104, 2, 4, 1000);
--c1
select c.customer_id as"id khach hàng",c.customer_name as "tên khách hàng",
       sum(o.total_price) as "tông doanh thu",sum(oi.quantity) as "số lượng " from customers c JOIN orders o on c.customer_id = o.customer_id
                         join order_items oi on o.order_id = oi.order_id
group by c.customer_id,c.customer_name
having sum(o.total_price)>2000;
--c2
select c.customer_id,c.customer_name from customers c join orders o
on c.customer_id = o.customer_id
group by c.customer_id , c.customer_name
having sum(o.total_price)>(select avg(o.total_price) from orders o);
--c3
select c.city,sum(o.total_price)  from customers c join orders o on c.customer_id = o.customer_id
group by c.city
having sum(o.total_price)=(select sum(o.total_price) from customers c join orders o on c.customer_id = o.customer_id
                           group by c.city
                           order by sum(o.total_price) DESC limit 1);
--c4
select c.customer_name,c.city,sum(oi.quantity),sum(o.total_price)   from customers c join orders o on c.customer_id = o.customer_id
    join order_items oi on o.order_id = oi.order_id
group by c.customer_name,c.city
