--TASK 1--
--Write query which will match contacts and orders to our customers
SELECT *
  FROM customers AS c1
 INNER JOIN contacts AS c2
    ON c1.customer_id=c2.customer_id
 INNER JOIN orders AS o
    ON c2.customer_id=o.customer_id;