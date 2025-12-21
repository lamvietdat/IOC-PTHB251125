
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

create or REPLACE function f_chẹck1()
    returns trigger
as $$
begin
    if new.quantity >(select stock from bai3.products where product_id= new.product_id)
         then raise exception 'số lượng trong kho không còn đủ';

    end if;
    return new;
end;
$$ language plpgsql;
create or REPLACE trigger tg_f_check1
    before INSERT ON bai3.sales
    for each row
execute  function f_chẹck();
--c3
create or REPLACE function f_stock()
returns trigger
as $$
    begin
        update bai3.products set stock = stock - new.quantity where product_id = new.product_id;
        return new;
    end;
    $$ language plpgsql;
create or REPLACE trigger trg_f_stock
    after INSERT on sales
    for EACH ROW  EXECUTE FUNCTION f_stock();



INSERT INTO products (name, stock) VALUES
                                       ('Laptop Dell XPS 13', 25),
                                       ('Chuột Logitech MX Master 3', 50),
                                       ('Bàn phím cơ Keychron K2', 40),
                                       ('Màn hình LG UltraFine 27"', 15),
                                       ('Tai nghe Sony WH-1000XM5', 30);
insert into bai3.sales(product_id, quantity) VALUES (1,3);
