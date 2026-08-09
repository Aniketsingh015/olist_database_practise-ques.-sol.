-- SELECT + WHERE (filtering fundamentals) on dataset olist
-- List all customers from customer_state = 'SP'



SELECT *

FROM olist_customers_dataset

WHERE customer_state = 'SP'

LIMIT 10;


-- Question 2 :List all orders
-- where order_status = 'delivered'

select * from olist_orders_dataset
 where order_status="delivered";

-- Find all products where product_category_name = 'beleza_saude'

SELECT * FROM olist_products_dataset 
WHERE product_category_name = "beleza_saude";