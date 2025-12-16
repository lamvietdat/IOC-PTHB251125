set  SEARCH_PATH  to bai8;
-- Tạo bảng Customers
CREATE TABLE Customers (
                           customer_id SERIAL PRIMARY KEY,
                           name VARCHAR(100),
                           email VARCHAR(100),
                           total_spent DECIMAL(12,2) DEFAULT 0
);

-- Tạo bảng Orders
CREATE TABLE Orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT,
                        amount DECIMAL(12,2),
                        order_date DATE,
                        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
-- Thêm 5 khách hàng
INSERT INTO Customers (name, email) VALUES
                                        ('Nguyễn Văn A', 'a.nguyen@example.com'),
                                        ('Trần Thị B', 'b.tran@example.com'),
                                        ('Lê Văn C', 'c.le@example.com'),
                                        ('Phạm Thị D', 'd.pham@example.com'),
                                        ('Hoàng Văn E', 'e.hoang@example.com');

-- Thêm 5 đơn hàng (giả sử customer_id từ 1 đến 5)
INSERT INTO Orders (customer_id, amount, order_date) VALUES
                                                         (1, 250000.00, CURRENT_DATE),
                                                         (2, 150000.00, CURRENT_DATE),
                                                         (3, 300000.00, CURRENT_DATE),
                                                         (4, 100000.00, CURRENT_DATE),
                                                         (5, 500000.00, CURRENT_DATE);
create or REPLACE PROCEDURE add_order_and_update_customer(p_customer_id INT, p_amount NUMERIC)
language plpgsql
as $$
    DECLARE
        id_khach int ;
    begin
        -- lấy ra id khách hàng
        select customer_id into id_khach from Customers where customer_id=p_customer_id;
        if id_khach is null then  RAISE EXCEPTION 'không tôn tại khách hàng nay ';
        else
            insert into orders(customer_id, amount, order_date)
                   VALUES(id_khach,p_amount,CURRENT_DATE);
            update Customers set total_spent = total_spent+p_amount where customer_id=id_khach;
        end if;
    EXCEPTION

        WHEN others THEN
        RAISE EXCEPTION 'Thêm đơn hàng thất bại: %', SQLERRM;


    end;
    $$;
call add_order_and_update_customer(1,50000);