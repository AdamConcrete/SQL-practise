--TASK 5--
-- Filter out all items from orders table which containt in their name 'ea' or start with 'Key'

SELECT *
  FROM orders
 WHERE item NOT LIKE 'Key%'
   AND item NOT LIKE '%ea%';