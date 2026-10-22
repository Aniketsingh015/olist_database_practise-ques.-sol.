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