create schema bai1;
set SEARCH_PATH  to bai1;
-- Tạo bảng lưu thông tin khách hàng
CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,   -- Mã khách hàng, tự động tăng
                           name VARCHAR(50),                 -- Tên khách hàng
                           email VARCHAR(50)                 -- Email khách hàng
);

-- Tạo bảng ghi log hoạt động của khách hàng
CREATE TABLE customer_log (
                              log_id SERIAL PRIMARY KEY,        -- Mã log, tự động tăng
                              customer_name VARCHAR(50),        -- Tên khách hàng thực hiện hành động
                              action_time TIMESTAMP             -- Thời điểm thực hiện hành động
);

--
create or REPLACE function f_insert()
returns trigger
as $$
    begin
        insert into bai1.customer_log(customer_name, action_time)
        values (New.name,current_timestamp);
        return new ;
    end;
    $$ language plpgsql;

create or REPLACE TRIGGER trg_f_insert
    after  INSERT ON bai1.customers
    for each ROW
    execute function f_insert();
