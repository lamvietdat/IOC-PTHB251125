set SEARCH_PATH to bai4;
-- Bảng lưu thông tin sản phẩm
CREATE TABLE products (
                          id SERIAL PRIMARY KEY,          -- Khóa chính, tự tăng
                          name VARCHAR(100) NOT NULL,     -- Tên sản phẩm
                          stock INT NOT NULL              -- Số lượng tồn kho
);

-- Bảng lưu thông tin đơn hàng
CREATE TABLE orders (
                        id SERIAL PRIMARY KEY,          -- Khóa chính, tự tăng
                        product_id INT NOT NULL,        -- Khóa ngoại tham chiếu sản phẩm
                        quantity INT NOT NULL,          -- Số lượng đặt
                        CONSTRAINT fk_product
                            FOREIGN KEY (product_id) REFERENCES products(id)
);


INSERT INTO products (name, stock)
VALUES
    ('Laptop Dell XPS 13', 50),
    ('iPhone 15 Pro', 30),
    ('Samsung Galaxy S24', 40),
    ('Tai nghe Sony WH-1000XM5', 25),
    ('Máy ảnh Canon EOS R6', 15);

drop trigger trg_f_dieuchinh on orders;
drop function  f_dieu_chinh();


CREATE OR REPLACE FUNCTION f_dieu_chinh()
    RETURNS TRIGGER
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE bai4.products
        SET stock = stock - NEW.quantity
        WHERE id = NEW.product_id;
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        IF NEW.quantity > OLD.quantity THEN
            UPDATE bai4.products
            SET stock = stock - (NEW.quantity - OLD.quantity)
            WHERE id = NEW.product_id;
        ELSE
            UPDATE bai4.products
            SET stock = stock + (OLD.quantity - NEW.quantity)
            WHERE id = NEW.product_id;
        END IF;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE bai4.products
        SET stock = stock + OLD.quantity
        WHERE id = OLD.product_id;
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_f_dieuchinh
    AFTER INSERT OR UPDATE OR DELETE ON orders
    FOR EACH ROW
EXECUTE FUNCTION f_dieu_chinh();