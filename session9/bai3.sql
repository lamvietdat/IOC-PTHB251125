set SEARCH_PATH  to  bai3;
CREATE TABLE Products (
                          product_id SERIAL PRIMARY KEY,
                          category_id INT NOT NULL,
                          price DECIMAL(10,2) NOT NULL,
                          stock_quantity INT NOT NULL
);
INSERT INTO Products (category_id, price, stock_quantity) VALUES
                                                              (1, 199.99, 50),
                                                              (2, 89.50, 120),
                                                              (1, 149.00, 30),
                                                              (3, 59.99, 200),
                                                              (2, 120.00, 80);
CREATE INDEX idx_category_id ON Products(category_id);
CREATE INDEX idx_price ON Products(price);
SELECT *
FROM Products
WHERE category_id = 1
ORDER BY price;
--
- Khi bạn tạo Clustered Index trên category_id, dữ liệu trong bảng được sắp xếp vật lý theo category_id.
- Điều này giúp truy vấn WHERE category_id = 1 nhanh hơn vì hệ quản trị có thể truy cập trực tiếp vào vùng dữ liệu chứa các bản ghi thuộc category_id = 1 thay vì quét toàn bộ bảng.
- Tương tự như việc bạn có một cuốn sách đã sắp xếp theo chương, bạn chỉ cần mở đúng chương thay vì lật từng trang.
-
 create schema bai4;