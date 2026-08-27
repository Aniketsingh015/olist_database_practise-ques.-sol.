-- The operations team wants to know how many customers you have in each state, to decide where to open new warehouses.

select customer_state,count(*) from olist_customers_dataset
group by customer_state;


-- Count how many orders exist per order_status
select order_status,count(*) from olist_orders_dataset
group by order_status;

-- Find the average payment_value per payment_type

select AVG(payment_value),payment_type from olist_order_payments_dataset
GROUP BY payment_type;


-- Find total price sold per product_category_name (single table, order_items only)
select sum(price),product_id from olist_order_items_dataset group by product_id;
-- as the product category not aviable so for now before join we have used product id

-- Count how many sellers exist per seller_state"
select count(*),seller_state from olist_sellers_dataset GROUP BY seller_state;

-- Find min and max freight_value — no grouping, whole table
select min(freight_value),max(freight_value) from olist_order_items_dataset ;


-- group by using where clauss


-- Per payment_type, show COUNT(*), AVG(payment_value), and MAX(payment_value) all in one query.

SELECT payment_type, COUNT(*), AVG(payment_value), MAX(payment_value)
FROM olist_order_payments_dataset
GROUP BY payment_type;


-- The customer growth team wants to know, per state: how many total customers you have,
--  and how many distinct cities those customers are spread across — to figure out if 
-- growth is concentrated in a few big cities or spread out.
SELECT customer_state, COUNT(*),count(DISTINCT customer_city) FROM olist_customers_dataset GROUP BY customer_state;


-- The category management team only cares about "meaningful" sales — they want total revenue per product, but explicitly 
-- excluding any order item priced under ₹50/$50 (noise/test transactions). How would you build that report?

select sum(price),product_id from olist_order_items_dataset where price>50 group by product_id;


-- The reviews team wants average review score per month, but only for 2018 — 
-- they don't want older data skewing the trend.
SELECT * from olist_order_reviews_dataset

select AVG(review_score),month(review_creation_date) from olist_order_reviews_dataset where year(review_creation_date)=2018
group by month(review_creation_date); 

-- The payments team wants average payment_value per payment_type, but only for transactions with payment_installments > 1.
select avg(payment_value),payment_type from olist_order_payments_dataset where payment_installments >1 GROUP BY payment_type;


-- Count of reviews per review_score, but only for reviews created in the second half of 2018 (July–December).
select count(*),review_score from olist_order_reviews_dataset where MONTH(review_creation_date) BETWEEN 7 and 12 and year(review_creation_date)=2018 GROUP BY review_score;


-- The category team wants total price sold per product_id, but only including order items where freight_value was less than 20.
select sum(price),product_id from olist_order_items_dataset where freight_value<20 group by product_id;

-- Grouping by time (a very common real scenario)
-- Leadership wants to see order volume trending by year — are we growing year over year?
select count(*),year(order_purchase_timestamp) from olist_orders_dataset GROUP BY year(order_purchase_timestamp);

-- The growth team wants order volume by month — but they specifically warn you: don't accidentally merge
--  January 2017 and January 2018 into the same bucket. How do you avoid that mistake?
SELECT YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp), COUNT(*)
FROM olist_orders_dataset
GROUP BY YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp);


-- NULL-aware business questions
-- Operations wants to know how many orders were 
-- never marked as delivered vs how many were — they suspect a data quality or fulfillment issue.

select order_delivered_customer_date is null ,count(*)from olist_orders_dataset GROUP BY order_delivered_customer_date is null;




-- Pattern 6 from group by 
-- The reviews team wants to know if review volume differs
--  by day of week — do more reviews get left on weekends vs weekdays? (DAYNAME(review_creation_date))

select count(*) , DAYNAME(review_creation_date)
 from olist_order_reviews_dataset 
 group by DAYNAME(review_creation_date);

-- Question 2 Ops wants order count per hour of day the order was placed — 
-- are most orders placed in the morning or evening? (HOUR(order_purchase_timestamp))

SELECT Count(*),HOUR(order_purchase_timestamp) from olist_orders_dataset GROUP BY HOUR(order_purchase_timestamp);

-- The delivery team wants a two-bucket split: orders that were delivered vs never delivered (order_delivered_customer_date IS NULL)
SELECT count(*),order_delivered_customer_date is NULL from olist_orders_dataset GROUP BY order_delivered_customer_date is NULL;


-- The reviews team wants a two-bucket split: reviews that are "positive"
--  (score ≥ 4) vs "not positive" (score < 4) — group by the expression review_score >= 4 directly

select count(*) , review_score>=4 from olist_order_reviews_dataset group by review_score>=4;


-- Finance wants payment count split into two buckets: single payment (installments = 1) vs multi-installment (installments > 1)
select count(*), payment_installments>1 from olist_order_payments_dataset group by payment_installments>1;

-- Ops wants order count per day of the month (1st, 2nd, ... 31st), regardless of
--  which month — to check if certain days consistently see spikes (DAY(order_purchase_timestamp)

select count(*),DAY(order_purchase_timestamp),MONTH(order_purchase_timestamp) from olist_orders_dataset GROUP BY DAY(order_purchase_timestamp),MONTH(order_purchase_timestamp)   ;


-- The pricing team wants order items split into "cheap" (price < 100) vs "expensive" (price >= 100) buckets,
--  with total revenue in each bucket

select count (*) ,(price<100) as cheap from olist_order_items_dataset GROUP BY (price<100);



-- Pattern 7 — Compound (multi-column) grouping
-- The payments team wants average payment_value broken down by both payment_type and payment_installments

select avg(payment_value),payment_type,payment_installments from olist_order_payments_dataset GROUP BY payment_type,payment_installments;


-- The reviews team wants average review_score broken down by both year and month separately (two columns in GROUP BY, not merged)

select avg(review_score),YEAR(review_creation_date),MONTH(review_creation_date) from olist_order_reviews_dataset
group by YEAR(review_creation_date),MONTH(review_creation_date);


-- Ops wants order count broken down by order_status and whether the order was placed on a weekend or weekday
select count(*) ,order_status,DAYOFWEEK(order_purchase_timestamp) In(1,7) from olist_orders_dataset
group by order_status, DAYOFWEEK(order_purchase_timestamp)In(1,7);


-- The pricing team wants count of order items broken down by both product_id
--  and whether freight_value was above or below $20

select count(*),product_id,freight_value<20  FROM olist_order_items_dataset GROUP BY  product_id,freight_value<20;


-- The reviews team wants review count broken down by 
-- review_score and whether a comment was left (review_comment_message IS NULL or not)

select count(*),review_score,review_comment_message IS NULL from olist_order_reviews_dataset GROUP BY review_score,review_comment_message IS NULL;



-- Pattern 8 — Sorting/limiting grouped results (Top-N)
-- Leadership wants the top 5 states by customer count, for an ad campaign focu

select count(*),customer_state from olist_customers_dataset group by customer_state order by count(*)Desc limit 5;

-- Ops wants the top 3 months (merged across all years) with the highest order volume — which months tend to be busiest overall?
select count(*),MONTH(order_purchase_timestamp) from olist_orders_dataset GROUP BY MONTH(order_purchase_timestamp) order by count(*) DESC limit 3;

-- The pricing team wants the top 5 products (product_id) by total revenue from olist_order_items_dataset.
select sum(price),product_id from olist_order_items_dataset GROUP BY product_id ORDER BY sum(price) desc limit 5;

-- Finance wants the least-used payment type — the one with the smallest transaction count.
select count(*),payment_type from olist_order_payments_dataset GROUP BY payment_type order by count(*) ASC LIMIT 1;

-- The reviews team wants the 5 lowest-rated months by average review score (across all years merged).
select AVG(review_score),MONTH(review_creation_date) from olist_order_reviews_dataset group by review_creation_date order by AVG(review_score) ASC limit 1;