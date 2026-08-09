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

-- Ques 3:Find all products where product_category_name = 'beleza_saude'

SELECT * FROM olist_products_dataset 
WHERE product_category_name = "beleza_saude";

--  Ques 4:Find all payments where payment_type = 'credit_card'
Select * from olist_order_payments_dataset where payment_type ='credit_card';

-- Ques5:List all sellers not located in 'SP' (practice != / <>)

-- we have two approach for this when we have to do not in single condition use
-- != and when there is more than one condition then use()

select * from olist_sellers_dataset where seller_state != 'SP';

select * from olist_sellers_dataset where seller_state NOT IN ('SP');

-- Ques 6:Find all reviews with review_score = 1 (the angriest customers)

select review_id,review_score,
review_comment_title, review_comment_message,
review_creation_date from olist_order_reviews_dataset
where review_score = 1;

--Ques7 Find all order items where price > 500

select * from olist_order_payments_dataset where payment_value > 500;

-- Find customers from either 'SP' or 'RJ' (practice IN)
SELECT * from olist_customers_dataset where customer_state IN ('SP','RJ');


-- IN / NOT IN

-- Ques1 Find all customers from 'SP', 'RJ', or 'MG'
select * from olist_customers_dataset where customer_state IN('SP','RJ','MG');

-- Ques2 Find all payments where payment_type is either 'voucher' or 'debit_card'
select * from olist_order_payments_dataset where payment_type In ('voucher','debit_card');

-- Ques3 Find all sellers not located in 'SP', 'RJ', or 'MG' (practice NOT IN)
select * from olist_sellers_dataset where seller_state NOT In('SP', 'RJ','MG');

-- Ques4:Find all orders where order_status is 'delivered' or 'shipped'
select * from olist_orders_dataset where order_status IN ('delivered','shipped');

-- BETWEEN (numeric and date ranges)

--Ques5: Find all order items priced BETWEEN 100 AND 300
select * from olist_order_items_dataset where price BETWEEN 100 AND 300;

-- Ques 6:Find all products with product_weight_g BETWEEN 500 AND 2000

select * from olist_products_dataset where product_weight_g between 500 and 2000;

-- Ques7: Find all orders placed BETWEEN '2017-06-01' AND '2017-08-31' (using order_purchase_timestamp)
SELECT * from olist_orders_dataset where order_purchase_timestamp BETWEEN '2017-06-01' AND '2017-08-31';

-- Ques 8:Find all reviews with review_score BETWEEN 2 AND 4 (excludes both the happiest and angriest extremes)
select * from olist_order_reviews_dataset where review_score BETWEEN 2 AND 4;

-- Ques9:Find all payments where payment_installments BETWEEN 1 AND 3
select * from olist_order_payments_dataset where payment_installments BETWEEN 1 and 3;

-- NULL handling (IS NULL / IS NOT NULL)
-- Ques1:Find all orders where order_delivered_customer_date IS NULL (never delivered)
select * from olist_orders_dataset where order_delivered_customer_date IS NULL;




