
/*
 * WHY CURSOR PAGINATION (WHERE id > ?) IS MORE EFFICIENT THAN OFFSET:
 * 
 * 1. NO ROW SKIPPING
 *    - OFFSET 10000 LIMIT 20: Database reads 10,020 rows, throws away 10,000
 *    - WHERE id > 10000 LIMIT 20: Database seeks directly to id 10000, reads 20
 * 
 * 2. INDEX USAGE
 *    - WHERE id > ? uses the PRIMARY KEY index for direct positioning
 *    - OFFSET must still scan through all rows even with an index
 * 
 * 3. CONSISTENT PERFORMANCE
 *    - Cursor: Always fast, regardless of position (page 1 = page 1000)
 *    - Offset: Gets slower as offset increases (page 1000 is 1000x slower than page 1)
 * 
 * 4. HANDLES CONCURRENT CHANGES
 *    - Cursor: Won't show duplicates or skip rows if data is inserted/deleted
 *    - Offset: Can show duplicates or miss rows during active writes
 * 
 * TRADE-OFF: Can't jump to arbitrary pages (only next/previous navigation)
 */
SELECT * FROM transactions WHERE id > ? LIMIT ?