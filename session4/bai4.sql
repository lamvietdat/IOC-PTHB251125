CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          category VARCHAR(50),
                          price DECIMAL(12, 2),
                          stock INT,
                          manufacturer VARCHAR(50)
);


INSERT INTO products (name, category, price, stock, manufacturer) VALUES
                                                                      ('Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
                                                                      ('Chuột Logitech M90', 'Phụ kiện', 150000, 50, 'Logitech'),
                                                                      ('Bàn phím cơ Razer', 'Phụ kiện', 2200000, 0, 'Razer'),
                                                                      ('Macbook Air M2', 'Laptop', 32000000, 7, 'Apple'),
                                                                      ('iPhone 14 Pro Max', 'Điện thoại', 35000000, 15, 'Apple'),
                                                                      ('Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
                                                                     ('Tai nghe AirPods 3', 'Phụ kiện', 4500000, NULL, 'Apple');

-- Thêm một sản phẩm mới vào bảng products với các giá trị tương ứng
INSERT INTO products (name, category, price, stock, manufacturer)
VALUES ('Chuột không dây Logitech M170', 'Phụ kiện', 300000, 20, 'Logitech');

-- Tăng giá tất cả sản phẩm của hãng Apple thêm 10%
UPDATE products
SET price = price * 1.10
WHERE manufacturer = 'Apple';

-- Xóa các sản phẩm có số lượng tồn kho bằng 0
DELETE FROM products
WHERE stock = 0;

-- Hiển thị sản phẩm có giá trong khoảng 10 triệu đến 30 triệu
SELECT * FROM products
WHERE price BETWEEN 10000000 AND 30000000;

-- Hiển thị sản phẩm có giá trị stock là NULL (chưa nhập kho)
SELECT * FROM products
WHERE stock IS NULL;

-- Liệt kê danh sách các hãng sản xuất duy nhất, không trùng lặp
SELECT DISTINCT manufacturer FROM products;

-- Hiển thị toàn bộ sản phẩm, sắp xếp giảm dần theo giá (cao → thấp),
-- sau đó tăng dần theo tên (A → Z) nếu cùng giá
SELECT * FROM products
ORDER BY price DESC, name ASC;

-- ILIKE: Không phân biệt chữ hoa/thường (PostgreSQL)
-- Tìm sản phẩm có tên chứa từ "laptop"
SELECT * FROM products
WHERE name ILIKE '%laptop%';

-- Chỉ hiển thị 2 sản phẩm đầu tiên sau khi sắp xếp giảm dần theo giá
SELECT * FROM products
ORDER BY price DESC
LIMIT 2;