--TASK 2--
-- There is  suspision that some orders were wrongly inserted more times. Check if there are any duplicated orders. If so, return duplicates with the following details:
-- first name, last name, email, order id and item
SELECT DISTINCT c1.first_name,
                c1.last_name,
                c2.email,
                o.order_id,
                o.item,
                t.counter
  FROM orders AS o
 INNER JOIN
       (SELECT order_id,
       	       COUNT(*) AS counter
       	  FROM orders
       	 GROUP BY order_id
       	HAVING counter > 1) AS t
    ON t.order_id = o.order_id
  LEFT JOIN customers AS c1
    ON o.customer_id = c1.customer_id
  LEFT JOIN contacts AS c2
    ON o.customer_id = c2.customer_id;