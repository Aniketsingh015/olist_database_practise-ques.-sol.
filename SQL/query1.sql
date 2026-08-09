-- SELECT + WHERE (filtering fundamentals) on dataset olist
-- List all customers from customer_state = 'SP'



SELECT *

FROM olist_customers_dataset

WHERE customer_state = 'SP'

LIMIT 10;