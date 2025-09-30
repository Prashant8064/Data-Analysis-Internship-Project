-/* =======================================
   STEP 1: CREATE TABLE
   ======================================= */
DROP TABLE IF EXISTS shipping;

CREATE TABLE shipping (
    shipping_id INTEGER,
    status INTEGER,
    customer INTEGER
);


/* =======================================
   STEP 2: INSERT SAMPLE DATA
   (Replace with your actual data)
   ======================================= */
INSERT INTO shipping (shipping_id, status, customer) VALUES
(1, 0, 101),   -- Valid
(2, 1, 102),   -- Valid
(3, 2, 103),   -- Valid
(4, 5, 104),   -- ❌ Invalid status
(5, 1, NULL),  -- ❌ Missing customer
(6, NULL, 105),-- ❌ Missing status
(7, 1, -10),   -- ❌ Negative customer ID
(2, 1, 102);   -- ❌ Duplicate shipping_id


/* =======================================
   STEP 3: VALIDATION QUERIES
   ======================================= */

-- 1. DATA CONSISTENCY CHECKS
SELECT *
FROM shipping
WHERE shipping_id < 0;

SELECT DISTINCT status
FROM shipping;

SELECT *
FROM shipping
WHERE typeof(customer) != 'integer';


-- 2. COMPLETENESS CHECKS
SELECT 
    SUM(CASE WHEN shipping_id IS NULL THEN 1 ELSE 0 END) AS missing_shipping_id,
    SUM(CASE WHEN status IS NULL THEN 1 ELSE 0 END) AS missing_status,
    SUM(CASE WHEN customer IS NULL THEN 1 ELSE 0 END) AS missing_customer
FROM shipping;


-- 3. DUPLICATE DETECTION
SELECT shipping_id, COUNT(*) AS duplicate_count
FROM shipping
GROUP BY shipping_id
HAVING COUNT(*) > 1;

SELECT customer, COUNT(*) AS duplicate_count
FROM shipping
GROUP BY customer
HAVING COUNT(*) > 1;


-- 4. BUSINESS RULE VALIDATION
SELECT *
FROM shipping
WHERE status NOT IN (0,1,2);

SELECT *
FROM shipping
WHERE shipping_id <= 0;

SELECT *
FROM shipping
WHERE customer <= 0;
