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