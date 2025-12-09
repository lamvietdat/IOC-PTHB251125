set SEARCH_PATH  to bai2;
CREATE TABLE Employee (
                          id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          department VARCHAR(50),
                          salary NUMERIC(10,2),
                          hire_date DATE
);
--c1
INSERT INTO Employee (full_name, department, salary, hire_date) VALUES
                                                                    ('Ngô Thị Hạnh', 'Kế toán', 12500.00, '2020-11-01'),
                                                                    ('Đặng Văn Huy', 'IT', 19500.00, '2021-06-18'),
                                                                    ('Vũ Thị Mai', 'Marketing', 14200.00, '2022-09-10'),
                                                                    ('Bùi Văn Khánh', 'Bán hàng', 10800.00, '2023-02-25'),
                                                                    ('Phan Thị Lan', 'Nhân sự', 13800.00, '2019-12-05'),
                                                                    ('Trương Văn Phúc', 'IT', 18500.00, '2020-04-22');
--c2
update Employee set salary = salary*11/10 where department='IT';
--c3
delete from Employee where salary<6000;
--c4
select* from Employee where full_name like '%An%';
--c5
select*from Employee where hire_date between '2023-01-01' and'2023-12-31';