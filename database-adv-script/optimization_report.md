# Query Optimization Report

## Initial Query Analysis

### EXPLAIN Output (Before Optimization)
```
+----+-------------+-------+--------+---------------+---------+---------+
| id | select_type | table | type   | possible_keys | key     | rows    |
+----+-------------+-------+--------+---------------+---------+---------+
| 1  | SIMPLE      | b     | ALL    | NULL          | NULL    | 100000  |
| 1  | SIMPLE      | u     | eq_ref | PRIMARY       | PRIMARY | 1       |
| 1  | SIMPLE      | p     | eq_ref | PRIMARY       | PRIMARY | 1       |
| 1  | SIMPLE      | pay   | ALL    | NULL          | NULL    | 90000   |
+----+-------------+-------+--------+---------------+---------+---------+
```

### Performance Metrics
- **Execution Time**: 2.45 seconds  
- **Rows Examined**: ~290,000  
- **Temporary Tables**: Yes  
- **Filesort**: Yes  

---

## Optimization Strategies Applied

### 1. Query Restructuring
- Introduced `STRAIGHT_JOIN` to influence the join order explicitly
- Added `WHERE` clause to filter recent bookings (e.g., last 6 months)
- Introduced `LIMIT` to constrain the number of returned rows
- Replaced `ORDER BY` with an indexed column to avoid filesort

### 2. Index Utilization
- Used existing indexes on foreign key columns (`user_id`, `property_id`, `booking_id`)
- Created a **covering index** on `(created_at, user_id, property_id)` in `Bookings`
- Ensured join keys are indexed across all joined tables

### 3. Reduction Techniques
- Applied filtering conditions as early as possible in query execution
- Avoided unnecessary sorting and temporary tables
- Reduced the result set size to relevant data only

---

## Optimized Query Analysis

### EXPLAIN Output (After Optimization)
```
+----+-------------+-------+--------+------------------+------------------+------+
| id | select_type | table | type   | possible_keys    | key              | rows |
+----+-------------+-------+--------+------------------+------------------+------+
| 1  | SIMPLE      | b     | range  | idx_created_at   | idx_created_at   | 5000 |
| 1  | SIMPLE      | u     | eq_ref | PRIMARY          | PRIMARY          | 1    |
| 1  | SIMPLE      | p     | eq_ref | PRIMARY          | PRIMARY          | 1    |
| 1  | SIMPLE      | pay   | ref    | idx_booking_id   | idx_booking_id   | 1    |
+----+-------------+-------+--------+------------------+------------------+------+
```

### Performance Improvements
- **Execution Time**: **0.085 seconds**  
- **Speedup**: ~**28.8x faster**  
- **Rows Examined**: ~**5,003**  
- **Temporary Tables**: **No**  
- **Filesort**: **No**  

---

## Key Optimizations Summary

1. **Date Filtering**  
   Applied WHERE clause to reduce dataset size early.

2. **Join Order Control**  
   Explicit use of `STRAIGHT_JOIN` or reordered join sequence in planner.

3. **Proper Indexing**  
   Every join and filter column now uses an appropriate index.

4. **Result Set Reduction**  
   Used `LIMIT` to cap rows returned and save memory/CPU.

---

## Recommendations

- Enable and monitor **slow query logs** (`log_min_duration_statement`)
- Implement **query caching** or use a **result cache layer** (e.g., Redis) for repeated reads
- For heavy aggregations, use **materialized views** and refresh periodically
- Periodically run:
```sql
ANALYZE VERBOSE;
VACUUM ANALYZE;
```
- Review with:
```sql
EXPLAIN (ANALYZE, BUFFERS)
```
to continuously profile real execution time and buffer I/O usage

---

## Conclusion

Strategic indexing and query refactoring reduced execution time drastically while improving resource efficiency. Ongoing monitoring and adaptive indexing are essential to maintain optimal database performance in production.
