set SEARCH_PATH to bai6;
CREATE TABLE Orders (
                        id SERIAL PRIMARY KEY,
                        customer_id INT,
                        order_date DATE,
                        total_amount NUMERIC(10,2)
);
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
                                                               (1, '2025-01-10', 1500.00),
                                                               (2, '2025-01-12', 3200.00),
                                                               (3, '2025-01-15', 800.00),
                                                               (4, '2025-01-18', 2500.00),
                                                               (5, '2025-01-20', 1800.00);
--c1
select sum(total_amount) as "total-revenue" ,count(id) as "average",avg(Orders.total_amount) as"average-order-value" from orders;
--2
select sum(total_amount) from orders
group by extract(year from order_date);
--c3
select extract(year from order_date),sum(total_amount) from orders
group by extract(year from order_date)
having sum(total_amount)>500;
--c4
select * from orders order by total_amount DESC limit 5;
