set  SEARCH_PATH to bai2;
-- Tạo bảng inventory
CREATE TABLE inventory (
                           product_id SERIAL PRIMARY KEY,
                           product_name VARCHAR(100),
                           quantity INT
);

-- Thêm 5 bản ghi
INSERT INTO inventory (product_name, quantity) VALUES
                                                   ('Bàn phím cơ', 25),
                                                   ('Chuột không dây', 40),
                                                   ('Tai nghe Bluetooth', 18),
                                                   ('Màn hình 24 inch', 12),
                                                   ('USB 64GB', 60);
create or REPLACE PROCEDURE  check_stock(p_id INT, p_qty INT)
language plpgsql
as $$
    begin
        if (select quantity from inventory where product_id=p_id) <p_qty  then
            RAISE NOTICE 'Sản phẩm không đủ hàng trong kho.';
        else
            RAISE NOTICE 'Sản phẩm  đủ hàng trong kho.';
        end if;
    end;
$$;
call check_stock(3,5);
call check_stock(2,500);