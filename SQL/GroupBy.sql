-- Scenario A: the sellers and logistics team
-- The logistics team is looking at seller activity and shipping costs.


-- 1. How many sellers are there in each state?
select count(*),seller_state FROM olist_sellers_dataset GROUP BY seller_state;
 

--  2. What is the average freight value across all order items?
select avg(freight_value) from olist_order_items_dataset;


-- 3. For each seller, show the number of items sold, the total revenue and the average item price.
select count(*),avg(price),sum(price),seller_id from olist_order_items_dataset GROUP BY seller_id;

-- 4 For each seller state, compare the number of sellers with the number of different cities they are in.
select count(*),count(DISTINCT seller_city),seller_state from olist_sellers_dataset group by seller_state;


-- 5. What is the total revenue for each product, counting only items with freight under 15?
select sum(price),product_id from olist_order_items_dataset where freight_value <15 group by product_id;