-- Scenario 1: the customer care desk
-- The customer care team is reviewing complaints and order history before a service-quality meeting.

select* from olist_customers_dataset;
select* from olist_geolocation_dataset;
select* from olist_order_items_dataset;
select* from olist_order_payments_dataset;
select* from olist_order_reviews_dataset;
select* from olist_orders_dataset;
select* from olist_products_dataset;
select* from olist_sellers_dataset;
select* from product_category_name_translation;

-- 1. List the order_id and status of every order that was canceled or is unavailable.
select order_id,order_status from olist_orders_dataset where order_status in ('canceled','unavailable');

-- 2. How many customers are registered in each state? Show the largest states first.

select count(*),customer_state from olist_customers_dataset group by customer_state order by count(*)DESC;

-- 3. Show the distinct cities that customers live in within the state of RJ.
select DISTINCT customer_city from olist_customers_dataset where customer_state='RJ';

-- 4. Find all reviews with a score of 1 where the customer also wrote a comment
select review_score,order_id from olist_order_reviews_dataset where review_score=1 and review_comment_message is NOT NULL;

-- 5. Which review scores have been given more than 5,000 times?
select count(review_score),review_score from olist_order_reviews_dataset GROUP BY (review_score) having count(review_score)>5000;

-- 6. Show each order placed in January 2018 together with the city of the customer who placed it.
select o.order_id,o.order_purchase_timestamp,c.customer_city,c.customer_id from olist_orders_dataset as o
INNER JOIN olist_customers_dataset as c ON c.customer_id=o.customer_id where year(order_purchase_timestamp)='2018'and Month(order_purchase_timestamp)=1;


-- 7. Which customers have never placed an order?
select customer_id from olist_customers_dataset where customer_id NOT IN(select customer_id from olist_orders_dataset); --this is one way to solve 
-- or --this join will give the null values with customer id who have not orderd but if we directly give is null then it will give only those ifd with null
select c.customer_id from olist_customers_dataset as c left join olist_orders_dataset as o on c.customer_id=o.customer_id where o.customer_id is null;

-- we dont do with inner join because it will not give the unmatched rows 