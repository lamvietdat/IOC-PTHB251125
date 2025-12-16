set SEARCH_PATH to bai4;
CREATE TABLE Sales (
                       sale_id SERIAL PRIMARY KEY,
                       customer_id INT NOT NULL,
                       product_id INT NOT NULL,
                       sale_date DATE NOT NULL,
                       amount DECIMAL(10,2) NOT NULL
);
INSERT INTO Sales (customer_id, product_id, sale_date, amount) VALUES
                                                                   (101, 1, '2025-12-01', 250.00),
                                                                   (102, 2, '2025-12-02', 180.50),
                                                                   (101, 3, '2025-12-03', 75.00),
                                                                   (103, 1, '2025-12-04', 320.00),
                                                                   (102, 4, '2025-12-05', 150.75);
create VIEW customerSales as select customer_id, sum(amount) as "doannh thu" from Sales group by customer_id;
SELECT * FROM CustomerSales where "doannh thu">320;
drop view customerSales;
update customerSales set "doannh thu" =456 where customer_id=1;
-- công cập nhật đc