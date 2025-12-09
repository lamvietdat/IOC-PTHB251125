set SEARCH_PATH to bai7;
CREATE TABLE Department (
                            id SERIAL PRIMARY KEY,
                            name VARCHAR(50)
);

CREATE TABLE Employee (
                          id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          department_id INT,
                          salary NUMERIC(10,2)
);
INSERT INTO Department (name) VALUES
                                  ('Human Resources'),
                                  ('Finance'),
                                  ('Engineering'),
                                  ('Marketing'),
                                  ('Customer Support');

INSERT INTO Employee (full_name, department_id, salary) VALUES
                                                            ('Nguyen Van A', 1, 1200.00),
                                                            ('Tran Thi B', 2, 1500.50),
                                                            ('Le Van C', 3, 2000.00),
                                                            ('Pham Thi D', 4, 1800.75),
                                                            ('Hoang Van E', 5, 1300.25);
--c1
select e.*, d.name  from Employee e join Department d on e.department_id =d.id;
--c2
select d.name,avg(e.salary) from Employee e join Department d on e.department_id =d.id
group by  d.name;
--c3
select d.name,avg(e.salary) from Employee e join Department d on e.department_id =d.id
group by  d.name
having avg(e.salary)>1000;
--c4
select * from Employee e left join Department d on e.department_id =d.id
where e.id is null;

