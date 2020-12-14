--TASK 4--
--Our company distinguishes orders to sizes by value like so:
--order with value less or equal to 25 euro is marked as SMALL
--order with value more than 25 euro but less or equal to 100 euro is marked as MEDIUM
--order with value more than 100 euro is marked as BIG
--Write query which shows only three columns: full_name (first and last name divided by space), order_id and order_size
--Make sure the duplicated values are not shown
SELECT DISTINCT c1.first_name ||' '|| c1.last_name AS full_name,
                o.order_id,
                CASE
                    WHEN o.order_value <= 25 THEN 'SMALL'
                    WHEN o.order_value > 25 AND o.order_value <= 100 THEN 'MEDIUM'
                    WHEN o.order_value > 100 THEN 'BIG'
                ELSE 'other'
                END AS order_size
  FROM orders AS o
  LEFT JOIN customers AS c1
    ON o.customer_id=c1.customer_id;