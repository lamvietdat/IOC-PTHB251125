set SEARCH_PATH  to  bai2;
CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          name VARCHAR(50),
                          stock INT
);
CREATE TABLE sales (
                       sale_id SERIAL PRIMARY KEY,
                       product_id INT REFERENCES products(product_id),
                       quantity INT
);

create or REPLACE function f_chẹck()
returns trigger
as $$
    begin
        if new.quantity >(select stock from bai2.products where product_id= new.product_id)
            then raise exception 'số lượng trong kho không còn đủ ';
            end if;
        return new;
    end;
    $$ language plpgsql;
create or REPLACE trigger tg_f_check
    before INSERT ON bai2.sales
    for each row
    execute  function f_chẹck();
INSERT INTO products (name, stock) VALUES
                                       ('Laptop Dell XPS 13', 25),
                                       ('Chuột Logitech MX Master 3', 50),
                                       ('Bàn phím cơ Keychron K2', 40),
                                       ('Màn hình LG UltraFine 27"', 15),
                                       ('Tai nghe Sony WH-1000XM5', 30);
insert into sales(product_id, quantity) VALUES (1,10);