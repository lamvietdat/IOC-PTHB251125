CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100) NOT NULL,
                          category VARCHAR(50),
                          price DECIMAL(10, 2),
                          stock_quantity INT
);

-- Thêm sản phẩm mới
INSERT INTO products (name, category, price, stock_quantity) VALUES
                                                                 ('iPhone 15', 'Điện thoại', 25000000, 10),
                                                                 ('MacBook Pro', 'Laptop', 45000000, 5),
                                                                 ('Samsung Galaxy S24', 'Điện thoại', 22000000, 15),
                                                                 ('Bàn phím cơ', 'Phụ kiện', 1200000, 30);

-- Tăng giá sản phẩm thuộc danh mục "Điện thoại" thêm 5%
UPDATE products
SET price = price * 1.05
WHERE category = 'Điện thoại';

-- Xóa sản phẩm hết hàng (stock_quantity = 0)
DELETE FROM products
WHERE stock_quantity = 0;

-- Lấy tất cả sản phẩm
SELECT * FROM products;

-- Lấy sản phẩm trong danh mục "Điện thoại"
SELECT * FROM products
WHERE category = 'Điện thoại';

-- Sắp xếp theo giá giảm dần
SELECT * FROM products
ORDER BY price DESC;

-- Lấy 3 sản phẩm đầu tiên
SELECT * FROM products
LIMIT 3;

-- Bỏ qua 2 sản phẩm đầu, lấy 3 sản phẩm tiếp theo
SELECT * FROM products
OFFSET 2 LIMIT 3;

-- Tìm sản phẩm có tên chứa "iPhone"
SELECT * FROM products
WHERE name LIKE '%iPhone%';

-- Lấy danh mục duy nhất
SELECT DISTINCT category FROM products;

-- Tìm sản phẩm có giá từ 10 triệu đến 30 triệu
SELECT * FROM products
WHERE price BETWEEN 10000000 AND 30000000;