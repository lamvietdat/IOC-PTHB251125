set SEARCH_PATH to bai4;
CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          price NUMERIC,
                          discount_percent INT
);
INSERT INTO products (name, price, discount_percent) VALUES
                                                         ('Laptop Dell Inspiron', 18000000, 10),
                                                         ('Điện thoại iPhone 14', 22000000, 5),
                                                         ('Tai nghe Sony WH-1000XM5', 7000000, 15),
                                                         ('Máy lọc không khí Xiaomi', 3500000, 20),
                                                         ('Bàn phím cơ Keychron K6', 2500000, 12);

--
create  or REPLACE PROCEDURE calculate_discount(p_id INT, OUT p_final_price NUMERIC(10,2))
language plpgsql
as $$
    DECLARE price_on numeric(10,2);
            discount_on int ;
    begin
        --lấy giá theo id
        select price into price_on from products where id=p_id;
        -- lấy phần trăm giảm giá theo id
        select discount_percent into discount_on  from products where id =p_id ;
        if discount_on >50 then update products set price = price - (price * 1/2) where id =p_id;
        select price into p_final_price from products where id =p_id ;
        else
            update products set price = price - (price * discount_on/100) where id =p_id;
            select price into p_final_price from products where id =p_id ;
            end if;

    end;
$$;
call calculate_discount(1,null);