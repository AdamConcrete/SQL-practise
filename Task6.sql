--TASK 6--
-- Please find out if some customer was referred by already existing customer
-- Return results in following format "Customer Last name Customer First name" "Last name First name of customer who recomended the new customer"
SELECT c1.last_name || ' ' || c1.first_name AS customer_name,
       c2.last_name || ' ' || c2.first_name AS referred_by
  FROM customers AS c1
 INNER JOIN customers AS c2
    ON c2.customer_id = c1.referred_by_id;