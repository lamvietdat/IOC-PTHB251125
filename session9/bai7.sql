set SEARCH_PATH to bai7;
-- Tạo bảng Customers
CREATE TABLE Customers (
                           customer_id INT PRIMARY KEY,
                           name VARCHAR(100),
                           email VARCHAR(100)
);

-- Tạo bảng Orders với khóa ngoại liên kết đến Customers
CREATE TABLE Orders (
                        order_id serial PRIMARY KEY,
                        customer_id INT,
                        amount DECIMAL(10, 2),
                        order_date DATE,
                        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


-- Thêm 5 bản ghi vào bảng Customers
INSERT INTO Customers (customer_id, name, email) VALUES
                                                     (1, 'Nguyễn Văn A', 'a.nguyen@example.com'),
                                                     (2, 'Trần Thị B', 'b.tran@example.com'),
                                                     (3, 'Lê Văn C', 'c.le@example.com'),
                                                     (4, 'Phạm Thị D', 'd.pham@example.com'),
                                                     (5, 'Hoàng Văn E', 'e.hoang@example.com');

-- Thêm 5 bản ghi vào bảng Orders (đảm bảo customer_id tồn tại)
INSERT INTO Orders (customer_id, amount, order_date) VALUES
                                                                   ( 1, 250000.00, '2025-12-01'),
                                                                   ( 2, 150000.00, '2025-12-02'),
                                                                   ( 3, 300000.00, '2025-12-03'),
                                                                   ( 4, 100000.00, '2025-12-04'),
                                                                   ( 5, 500000.00, '2025-12-05');
--
create or REPLACE PROCEDURE add_order(p_customer_id INT, p_amount NUMERIC)
language plpgsql

as $$
    DECLARE id_khach int ;
    begin
        -- lây id khách
        select Orders.customer_id into id_khach from orders where p_customer_id = customer_id;

        if id_khach is null then RAISE EXCEPTION 'không tôn tại khách hàng nay ';
        else
            insert into orders( customer_id, amount, order_date)
            VALUES(id_khach,p_amount, CURRENT_DATE);
        end if;

        end;
    $$;
call add_order(1,15000);