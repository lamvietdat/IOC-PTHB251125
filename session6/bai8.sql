set SEARCH_PATH to bai8;
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

CREATE TABLE Customer (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100)
);
INSERT INTO Customer (name) VALUES
                                ('Nguyen Van Nam'),
                                ('Tran Thi Hoa'),
                                ('Le Minh Tuan'),
                                ('Pham Van Duc'),
                                ('Hoang Thi Lan');
--c1
select c.name ,sum(total_amount) from Customer c JOIN Orders o on c.id = o.customer_id
group by c.id,c.name
--c2
select c.name , sum(total_amount) from Customer c join Orders o on c.id =o.customer_id
group by c.id , c.name
order by sum(total_amount) DESC limit 1;
--c3
SELECT c.id, c.name
FROM Customer c
         LEFT JOIN Orders o ON c.id = o.customer_id
WHERE o.customer_id IS NULL;
--c4
select c.name from Customer c join Orders o on c.id = o.customer_id
group by c.id ,c.name
having sum(total_amount)>(select avg(total_amount) from Orders);
