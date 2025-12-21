set SEARCH_PATH to bai5;
CREATE TABLE employees (
                           emp_id SERIAL PRIMARY KEY,
                           name VARCHAR(50),
                           position VARCHAR(50)
);
CREATE TABLE employee_log (
                              log_id SERIAL PRIMARY KEY,
                              emp_name VARCHAR(50),
                              action_time TIMESTAMP
);
create or REPLACE function f_them()
returns  trigger
as $$
    begin
        if TG_OP = 'INSERT' then insert into bai5.employee_log (emp_name, action_time)
                                 VALUES (new.name,current_timestamp);

        end if;
        return new;
    end;
    $$ language  plpgsql;

create or REPLACE TRIGGER tg_f_them
    AFTER INSERT ON employees
    for EACH ROW EXECUTE FUNCTION f_them();



