set SEARCH_PATH  to bai1;
CREATE TABLE book (
                      book_id SERIAL PRIMARY KEY,
                      title VARCHAR(255),
                      author VARCHAR(100),
                      genre VARCHAR(50),
                      price DECIMAL(10,2),
                      description TEXT,
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO book (title, author, genre, price, description) VALUES
                                                                ('Lập trình C# cơ bản', 'Nguyễn Văn A', 'Công nghệ thông tin', 120000, 'Cuốn sách hướng dẫn lập trình C# từ cơ bản đến nâng cao.'),
                                                                ('Tiếng Anh giao tiếp', 'Trần Thị B', 'Ngoại ngữ', 95000, 'Giúp người học cải thiện kỹ năng giao tiếp tiếng Anh hàng ngày.'),
                                                                ('Tư duy phản biện', 'Lê Văn C', 'Kỹ năng sống', 87000, 'Phát triển khả năng phân tích và đánh giá thông tin.'),
                                                                ('Lịch sử Việt Nam', 'Phạm Quốc D', 'Lịch sử', 105000, 'Tổng hợp các sự kiện lịch sử quan trọng của Việt Nam.'),
                                                                ('Toán học vui', 'Ngô Thị E', 'Giáo dục', 98000, 'Giải thích các khái niệm toán học qua trò chơi và ví dụ thực tế.'),
                                                                ('Marketing hiện đại', 'Hoàng Minh F', 'Kinh tế', 135000, 'Chiến lược tiếp thị trong thời đại số.'),
                                                                ('Thiền và đời sống', 'Vũ Hồng G', 'Tâm lý học', 89000, 'Ứng dụng thiền trong cuộc sống để giảm căng thẳng.'),
                                                                ('Lập trình Python nâng cao', 'Nguyễn Văn A', 'Công nghệ thông tin', 145000, 'Kỹ thuật lập trình Python chuyên sâu cho dự án thực tế.'),
                                                                ('Văn học dân gian Việt Nam', 'Đặng Thị H', 'Văn học', 92000, 'Tuyển tập truyện cổ tích, ngụ ngôn và ca dao.'),
                                                                ('Kỹ năng quản lý thời gian', 'Trần Văn I', 'Kỹ năng sống', 99000, 'Phương pháp sắp xếp công việc hiệu quả và khoa học.');
-- c1
create index book_author on book(author);
select *from book where author Ilike '%rowling%';
create index book_genre on book using hash(genre);
select * from book where genre = 'Fantasy';
--c2
explain analyse select *from book where author Ilike '%rowling%';
-- Seq Scan on book  (cost=0.00..1.12 rows=1 width=912) (actual time=0.142..0.143 rows=0.00 loops=1)
--   Filter: ((author)::text ~~* '%rowling%'::text)
--   Rows Removed by Filter: 10
--   Buffers: shared hit=1
-- Planning Time: 0.283 ms
-- Execution Time: 0.176 ms

drop index book_author;
-- Seq Scan on book  (cost=0.00..1.12 rows=1 width=912) (actual time=0.078..0.078 rows=0.00 loops=1)
--   Filter: ((author)::text ~~* '%rowling%'::text)
--   Rows Removed by Filter: 10
--   Buffers: shared hit=1
-- Planning Time: 0.182 ms
-- Execution Time: 0.111 ms
--c3
create index genre_book on book(genre);
CREATE EXTENSION pg_trgm;
CREATE EXTENSION btree_gin;
create index title_book on Book using gin(description);
--4
create index genre_book on book(genre);
CLUSTER book USING genre_book;
--c5
-- B-tree index là loại chỉ mục phổ biến và hiệu quả nhất cho các truy vấn tìm kiếm theo giá trị chính xác, phạm vi (BETWEEN, <, >), và sắp xếp.
--- GIN index (Generalized Inverted Index) phù hợp cho truy vấn toàn văn (full-text search) hoặc dữ liệu mảng, vì nó cho phép tìm kiếm nhanh trong các tập hợp lớn.
--- Hash index chỉ hỗ trợ so sánh bằng (=), không hỗ trợ phạm vi hay sắp xếp.
--- GiST index (Generalized Search Tree) thích hợp cho dữ liệu không gian (spatial),

--- Hash index không được khuyến khích trong PostgreSQL vì B-tree cũng xử lý tốt truy vấn bằng, trong khi Hash index trước đây thiếu tính năng  logging (dễ mất dữ liệu) và ít lợi thế về hiệu suất.



