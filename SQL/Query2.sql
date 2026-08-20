-- Count how many customers exist per customer_state

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

