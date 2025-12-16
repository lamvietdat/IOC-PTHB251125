set SEARCH_PATH  to bai3;
CREATE TABLE post (
                      post_id SERIAL PRIMARY KEY,
                      user_id INT NOT NULL,
                      content TEXT,
                      tags TEXT[],
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      is_public BOOLEAN DEFAULT TRUE
);

CREATE TABLE post_like (
                           user_id INT NOT NULL,
                           post_id INT NOT NULL,
                           liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           PRIMARY KEY (user_id, post_id)
);INSERT INTO post (user_id, content, tags, is_public)
  select *
  from (VALUES (1, 'Hôm nay trời đẹp quá, đi dạo quanh hồ Tây thật thư giãn', ARRAY ['đời sống', 'thiên nhiên'], TRUE),
               (2, 'Vừa hoàn thành xong bài tập lập trình, cảm giác thật tuyệt!', ARRAY ['học tập', 'công nghệ'], TRUE),
               (3, 'Ai có quán cà phê yên tĩnh ở Hà Nội giới thiệu mình với nhé', ARRAY ['hỏi đáp', 'cà phê'], TRUE),
               (4, 'Mình vừa đọc xong “Tuổi trẻ đáng giá bao nhiêu”, rất truyền cảm hứng', ARRAY ['sách', 'cảm hứng'],
                TRUE),
               (5, 'Tối nay ăn lẩu cùng hội bạn, vui hết nấc!', ARRAY ['ẩm thực', 'bạn bè'], TRUE),
               (6, 'Thử thách 30 ngày học tiếng Anh bắt đầu từ hôm nay!', ARRAY ['học tập', 'ngôn ngữ'], TRUE),
               (7, 'Chụp được khoảnh khắc hoàng hôn tuyệt đẹp ở Đà Lạt', ARRAY ['du lịch', 'ảnh đẹp'], TRUE),
               (8, 'Mình đang học cách thiền mỗi sáng, thấy tâm trí nhẹ nhàng hơn', ARRAY ['sức khỏe', 'thiền'], TRUE),
               (9, 'Có ai mê phim hoạt hình Nhật như mình không?', ARRAY ['giải trí', 'anime'], TRUE),
               (10, 'Hôm nay mình thấy hơi mệt, chắc do thiếu ngủ', ARRAY ['cảm xúc', 'sức khỏe'], FALSE)) alias;
-- (Tiếp tục với 40 bản ghi khác mang nội dung đa dạng như: công việc, tình yêu, thời trang, thể thao, âm nhạc, v.v.)
INSERT INTO post_like (user_id, post_id)
select *
from (VALUES (1, 2),
             (2, 2),
             (3, 5),
             (4, 1),
             (5, 3),
             (6, 7),
             (7, 7),
             (8, 4),
             (9, 6),
             (10, 8)) alias;

--c1
explain analyse SELECT * FROM post
                WHERE is_public = TRUE AND content ILIKE '%du lịch%';
-- Seq Scan on post  (cost=0.00..19.25 rows=1 width=81) (actual time=0.028..0.028 rows=0.00 loops=1)
--   Filter: (is_public AND (content ~~* '%du lịch%'::text))
-- Planning:
--   Buffers: shared hit=15 read=1
-- Planning Time: 2.767 ms
-- Execution Time: 0.083 ms
CREATE INDEX idx_post_content_lower ON post (LOWER(content));
-- Seq Scan on post  (cost=0.00..19.25 rows=1 width=81) (actual time=0.014..0.014 rows=0.00 loops=1)
--   Filter: (is_public AND (content ~~* '%du lịch%'::text))
-- Planning:
--   Buffers: shared hit=2
-- Planning Time: 0.160 ms
-- Execution Time: 0.038 ms
--c2
explain analyse SELECT * FROM post WHERE tags @> ARRAY['travel'];
-- Seq Scan on post  (cost=0.00..19.25 rows=4 width=81) (actual time=0.016..0.016 rows=0.00 loops=1)
--   Filter: (tags @> '{travel}'::text[])
-- Planning:
--   Buffers: shared hit=2
-- Planning Time: 0.206 ms
-- Execution Time: 0.045 ms
CREATE INDEX idx_post_tags_gin ON post USING GIN (tags);
CREATE EXTENSION pg_trgm;
CREATE EXTENSION btree_gin;
-- Bitmap Heap Scan on post  (cost=8.57..17.03 rows=4 width=81) (actual time=0.119..0.120 rows=0.00 loops=1)
--   Recheck Cond: (tags @> '{travel}'::text[])
--   Buffers: shared hit=2
--   ->  Bitmap Index Scan on idx_post_tags_gin  (cost=0.00..8.57 rows=4 width=0) (actual time=0.077..0.077 rows=0.00 loops=1)
--         Index Cond: (tags @> '{travel}'::text[])
--         Index Searches: 1
--         Buffers: shared hit=2
-- Planning:
--   Buffers: shared hit=24 read=1
-- Planning Time: 3.104 ms
-- Execution Time: 0.185 ms
--c3
CREATE INDEX idx_post_recent_public
    ON post(created_at DESC)
    WHERE is_public = TRUE;
explain analyse SELECT * FROM post
                WHERE is_public = TRUE AND created_at >= NOW() - INTERVAL '7 days';
-- Bitmap Heap Scan on post  (cost=4.17..16.32 rows=123 width=81) (actual time=0.034..0.034 rows=0.00 loops=1)
--   Recheck Cond: ((created_at >= (now() - '7 days'::interval)) AND is_public)
--   Buffers: shared hit=2
--   ->  Bitmap Index Scan on idx_post_recent_public  (cost=0.00..4.14 rows=123 width=0) (actual time=0.008..0.008 rows=0.00 loops=1)
--         Index Cond: (created_at >= (now() - '7 days'::interval))
--         Index Searches: 1
--         Buffers: shared hit=2
-- Planning:
--   Buffers: shared hit=3
-- Planning Time: 0.197 ms
-- Execution Time: 0.060 ms
--4
create index post_index on post (user_id,created_at DESC );
explain analyse select * from post order by post_id DESC limit 1;
-- Limit  (cost=0.15..0.22 rows=1 width=81) (actual time=0.003..0.003 rows=0.00 loops=1)
--   Buffers: shared hit=1
--   ->  Index Scan Backward using post_pkey on post  (cost=0.15..55.25 rows=740 width=81) (actual time=0.002..0.002 rows=0.00 loops=1)
--         Index Searches: 1
--         Buffers: shared hit=1
-- Planning:
--   Buffers: shared hit=45 read=1 dirtied=1
-- Planning Time: 1.089 ms
-- Execution Time: 0.019 ms
