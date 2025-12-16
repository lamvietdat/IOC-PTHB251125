set SEARCH_PATH to bai1;
-- Tạo bảng order_detail
CREATE TABLE order_detail (


                              id SERIAL PRIMARY KEY,
                              order_id INT,
                              product_name VARCHAR(100),
                              quantity INT,
                              unit_price NUMERIC
);

-- Thêm 5 bản ghi vào bảng order_detail
INSERT INTO order_detail (order_id, product_name, quantity, unit_price) VALUES
                                                                            (101, 'Bút bi Thiên Long', 20, 3500),
                                                                            (102, 'Vở Campus A4', 10, 12000),
                                                                            (103, 'Máy tính Casio FX-580VN X', 2, 550000),
                                                                            (104, 'Thước kẻ 30cm', 15, 5000),
                                                                            (105, 'Balo học sinh chống gù', 1, 450000);

-- c2
create or replace procedure calculate_order_tltal (order_id_in int ,out total numeric(10,2))
language plpgsql
as $$
    begin
         select  sum(unit_price*quantity) into  total from order_detail group by order_id
         having order_id=order_id_in;
    end;
$$;
drop PROCEDURE calculate_order_tltal(order_id_in int, total numeric(10,2));
call calculate_order_tltal(101,null);