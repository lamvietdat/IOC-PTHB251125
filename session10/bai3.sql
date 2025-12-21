set  SEARCH_PATH  to  bai3;
CREATE TABLE employees (
                           id SERIAL PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           position VARCHAR(50),
                           salary NUMERIC(12, 2)
);
create table employess_log(
    employee_id int,
    operation varchar(50),
    old_data json ,
    new_data json,
    change_time date

);
create function f_luu ()
returns trigger
as $$
    begin
     if TG_OP = 'INSERT' then
         INSERT INTO bai3.employess_log(employee_id, operation, old_data, new_data, change_time)
         VALUES (NEW.id, 'INSERT', NULL, to_jsonb(NEW), current_timestamp);
         return new;


     elseif TG_OP = 'UPDATE' then
         INSERT INTO bai3.employess_log(employee_id, operation, old_data, new_data, change_time)
         VALUES (NEW.id, 'INSERT', to_jsonb(old), to_jsonb(NEW), current_timestamp);
         return new;
     elseif TG_OP = 'DELETE' Then
         INSERT INTO bai3.employess_log(employee_id, operation, old_data, new_data, change_time)
         VALUES (NEW.id, 'INSERT', to_jsonb(old), null, current_timestamp);
         return old;
     end if;


    end;
    $$ language plpgsql;

create trigger  tg_lich_su
BEFORE INSERT or UPDATE or DELETE  on bai3.employees
    for each row execute FUNCTION f_luu();
drop TRIGGER tg_lich_su on bai3.employees;
drop  FUNCTION f_luu();
delete FROM employees where id=2