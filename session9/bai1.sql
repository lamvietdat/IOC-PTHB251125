set SEARCH_PATH to  bai1;
CREATE TABLE Orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT NOT NULL,
                        order_date DATE NOT NULL,
                        total_amount NUMERIC(10, 2)
);
CREATE INDEX idx_orders_customer_id ON Orders(customer_id);
drop index idx_orders_customer_id;
explain analyse  SELECT * FROM Orders WHERE customer_id = 1;
-- Seq Scan on orders  (cost=0.00..28.12 rows=7 width=28) (actual time=0.011..0.011 rows=0.00 loops=1)
--   Filter: (customer_id = 1)
-- Planning:
--   Buffers: shared hit=21 read=1
-- Planning Time: 1.324 ms
-- Execution Time: 0.026 ms
-- trc
-- Bitmap Heap Scan on orders  (cost=4.21..14.35 rows=7 width=28) (actual time=0.014..0.015 rows=0.00 loops=1)
--   Recheck Cond: (customer_id = 1)
--   Buffers: shared hit=2
--   ->  Bitmap Index Scan on idx_orders_customer_id  (cost=0.00..4.21 rows=7 width=0) (actual time=0.003..0.003 rows=0.00 loops=1)
--         Index Cond: (customer_id = 1)
--         Index Searches: 1
--         Buffers: shared hit=2
-- Planning:
--   Buffers: shared hit=16 read=1
-- Planning Time: 1.099 ms
-- Execution Time: 0.036 ms
