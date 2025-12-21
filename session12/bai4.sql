set SEARCH_PATH  to bai4;
CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          name VARCHAR(50),
                          stock INT,
                          price numeric(10,2)
);
CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        product_id INT REFERENCES products(product_id),
                        quantity INT,
                        total_amount NUMERIC
);
create or REPLACE function f_tt()
returns trigger
as $$
    declare price_on numeric(10,2);
    begin
        select price into price_on from bai4.products where product_id=new.product_id;


        if tg_op='INSERT' then  update bai4.orders set total_amount=price_on*new.quantity where order_id= new.order_id;

     end if;
        return new;
    end;
       $$ language  plpgsql;
create or REPLACE trigger tg_f_tt
 after INSERT on orders
    for EACH ROW  EXECUTE FUNCTION f_tt();


INSERT INTO products (name, stock, price) VALUES
                                              ('Laptop Lenovo', 20, 15000000.00),
                                              ('Chuột Logitech', 100, 450000.00),
                                              ('Bàn phím cơ Akko', 50, 1200000.00),
                                              ('Màn hình LG 24 inch', 30, 3200000.00),
                                              ('Tai nghe Sony WH-1000XM5', 15, 6900000.00);
insert into orders(product_id, quantity, total_amount) VALUES (1,2,null);
