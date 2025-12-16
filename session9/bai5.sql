set SEARCH_PATH  to bai5;
CREATE TABLE CustomerSales (
                               sale_id SERIAL PRIMARY KEY,
                               customer_id INT NOT NULL,
                               amount DECIMAL(10,2) NOT NULL,
                               sale_date DATE NOT NULL
);INSERT INTO CustomerSales (customer_id, amount, sale_date) VALUES
                                                                 (101, 250.00, '2025-12-01'),
                                                                 (102, 180.50, '2025-12-02'),
                                                                 (101, 75.00,  '2025-12-03'),
                                                                 (103, 320.00, '2025-12-04'),
                                                                 (102, 150.75, '2025-12-05');--
create or REPLACE PROCEDURE  calculate_total_sales(start_date DATE, end_date DATE, OUT total NUMERIC)
language  plpgsql
as $$
    begin
        SELECT SUM(amount) INTO total
        FROM CustomerSales
        WHERE sale_date BETWEEN start_date AND end_date;


    end;
    $$;
drop PROCEDURE calculate_total_sales(start_date DATE, end_date DATE, total NUMERIC);
call calculate_total_sales('2025-12-01','2025-12-03',null);
