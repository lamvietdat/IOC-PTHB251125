set SEARCH_PATH to bai3;
CREATE TABLE employees (
                           emp_id SERIAL PRIMARY KEY,
                           emp_name VARCHAR(100),
                           job_level INT CHECK (job_level IN (1, 2, 3)),
                           salary NUMERIC
);
INSERT INTO employees (emp_name, job_level, salary) VALUES
                                                        ('Nguyễn Văn A', 1, 10000000),
                                                        ('Trần Thị B', 2, 12000000),
                                                        ('Lê Văn C', 3, 15000000),
                                                        ('Phạm Thị D', 1, 9500000),
                                                        ('Hoàng Văn E', 2, 11000000);


--
create or  REPLACE PROCEDURE adjust_salary(p_emp_id int , out p_new_salary numeric(10,2) )
language plpgsql
as $$
    Declare lv_job int ;

    begin
        -- lấy ra leve
        select job_level into lv_job from employees where emp_id = p_emp_id;
        -- so sanh
        if lv_job = 1 then update employees set salary = salary *1.05 where emp_id=p_emp_id;
                        select employees.salary into p_new_salary from employees where emp_id = p_emp_id;
        elseif lv_job=2 then update employees set salary = salary *1.10 where emp_id=p_emp_id;
                        select employees.salary into p_new_salary from employees where emp_id = p_emp_id;
        elseif lv_job=3 then update employees set salary = salary *1.15 where emp_id=p_emp_id;
                        select employees.salary into p_new_salary from employees where emp_id = p_emp_id;
        else
            RAISE NOTICE 'câp độ này ko đc tăng lương.';
        end if;
    end;
$$;
drop PROCEDURE adjust_salary(p_emp_id int, p_new_salary numeric(10,2));

call adjust_salary(1,null);
call adjust_salary(2,null);
call adjust_salary(3,null);
