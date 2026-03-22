## Query: products WHERE price > 1000

### До индексов
Sort  (cost=1.25..1.26 rows=5 width=592) (actual time=0.062..0.063 rows=8.00 loops=1)
Sort Key: price DESC
Sort Method: quicksort  Memory: 25kB
Buffers: shared hit=1
->  Seq Scan on products  (cost=0.00..1.19 rows=5 width=592) (actual time=0.043..0.045 rows=8.00 loops=1)
Filter: (price > '1000'::numeric)
Rows Removed by Filter: 7
Buffers: shared hit=1
Planning Time: 0.136 ms
Execution Time: 0.076 ms
(10 rows)
### После индексов
Sort  (cost=1.25..1.26 rows=5 width=592) (actual time=0.026..0.026 rows=8.00 loops=1)
Sort Key: price DESC
Sort Method: quicksort  Memory: 25kB
Buffers: shared hit=1
->  Seq Scan on products  (cost=0.00..1.19 rows=5 width=592) (actual time=0.016..0.018 rows=8.00 loops=1)
Filter: (price > '1000'::numeric)
Rows Removed by Filter: 7
Buffers: shared hit=1
Planning Time: 0.086 ms
Execution Time: 0.040 ms
(10 rows)

### Вывод
На таблице из 15 строк PostgreSQL выбирает Seq Scan —
накладные расходы на чтение индекса превышают выгоду.
На таблице от ~1000 строк появится Index Scan.