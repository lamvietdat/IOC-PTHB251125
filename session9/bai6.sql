set SEARCH_PATH  to   bai6;
CREATE TABLE Products (
                          product_id SERIAL PRIMARY KEY,
                          name VARCHAR(100) NOT NULL,
                          price DECIMAL(10,2) NOT NULL,
                          category_id INT NOT NULL
);
INSERT INTO Products (name, price, category_id) VALUES
                                                    ('Laptop Dell Inspiron', 1500.00, 1),
                                                    ('Chuột Logitech', 25.50, 2),
                                                    ('Bàn phím cơ Keychron', 89.99, 2),
                                                    ('Điện thoại iPhone 15', 1200.00, 3),
                                                    ('Tai nghe Sony WH-1000XM5', 299.00, 4);
create or REPLACE PROCEDURE update_product_price(p_category_id INT, p_increase_percent NUMERIC)
language plpgsql
as $$
    begin
        update products set price = price +(price * p_category_id/100) where category_id =p_category_id;


    end;

    $$;
call update_product_price(1,50);
drop PROCEDURE update_product_price(p_category_id INT, p_increase_percent NUMERIC);