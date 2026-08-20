-- Count how many customers exist per customer_state

select customer_state,count(*) from olist_customers_dataset
group by customer_state;


-- Count how many orders exist per order_status
select order_status,count(*) from olist_orders_dataset
group by order_status;