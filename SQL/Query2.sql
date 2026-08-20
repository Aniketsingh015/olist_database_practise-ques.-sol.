-- Count how many customers exist per customer_state

select customer_state,count(*) from olist_customers_dataset
group by customer_state;