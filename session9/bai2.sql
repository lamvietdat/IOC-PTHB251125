set SEARCH_PATH to bai2;
CREATE TABLE Users (
                       user_id SERIAL PRIMARY KEY,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       username VARCHAR(100) NOT NULL
);
INSERT INTO Users (email, username) VALUES
                                        ('alice@example.com', 'alice123'),
                                        ('bob@example.com', 'bobby'),
                                        ('charlie@example.com', 'charlie_c'),
                                        ('diana@example.com', 'diana_d'),
                                        ('eve@example.com', 'eve_eve');


EXPLAIN analyse SELECT * FROM Users WHERE email = 'example@example.com';
-- Index Scan using users_email_key on users  (cost=0.14..8.16 rows=1 width=738) (actual time=0.048..0.049 rows=0.00 loops=1)
--   Index Cond: ((email)::text = 'example@example.com'::text)
--   Index Searches: 1
--   Buffers: shared hit=1
-- Planning Time: 0.156 ms
-- Execution Time: 0.090 ms
CREATE INDEX users_email_hash_idx ON Users USING HASH (email);
-- Seq Scan on users  (cost=0.00..1.06 rows=1 width=738) (actual time=0.044..0.045 rows=0.00 loops=1)
--   Filter: ((email)::text = 'example@example.com'::text)
--   Rows Removed by Filter: 5
--   Buffers: shared hit=1
-- Planning:
--   Buffers: shared hit=16
-- Planning Time: 2.194 ms
-- Execution Time: 0.066 ms
create schema bai3;