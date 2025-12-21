set  SEARCH_PATH  to bai222;
CREATE TABLE customers (
                           id SERIAL PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           credit_limit NUMERIC(12,2) DEFAULT 0
);

CREATE TABLE orders (
                        id SERIAL PRIMARY KEY,
                        customer_id INTEGER NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
                        order_amount NUMERIC(12,2) NOT NULL
);

INSERT INTO bai222.customers (name, credit_limit) VALUES
                                                    ('Nguyen Van A', 5000000),
                                                    ('Tran Thi B', 3000000),
                                                    ('Le Van C', 7000000),
                                                    ('Pham Thi D', 10000000),
                                                    ('Hoang Van E', 2000000);
create function  check_credit_limit()
returns trigger
as $$
    declare   credit_limit_on numeric(10,2);
              tong_tien numeric(10,2) ;
        begin
        -- lấy ra hạn mức chi tiêu của khách hàng theo id
        select credit_limit into credit_limit_on from bai222.customers where new.customer_id = id;
        -- tông chi tiêu của khách hàng trong nhưng hóa đơn trước đó
        select sum(order_amount) into tong_tien from bai222.orders group by customer_id having new.customer_id = bai222.orders.customer_id ;
        -- kiem tra
        tong_tien := tong_tien+new.order_amount;

        -- điều kiện
        if tong_tien >credit_limit_on then raise exception 'đơn hàng này đã vượt quá mức chi tiêu của khách hàng ';
        else return new;
        end if;
    end;
    $$ language  plpgsql;
create trigger trg_check_credit
    before insert ON bai222.orders
    for each ROW
execute FUNCTION check_credit_limit();
drop TRIGGER trg_check_credit on orders;
drop FUNCTION check_credit_limit();


