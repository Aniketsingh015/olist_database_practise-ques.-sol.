-- Leadership wants to know which states have more than 500 customers — a real market, not a negligible one.
select count(*),customer_state from olist_customers_dataset GROUP BY customer_state having count(*)>500;

-- The sellers team wants to see which sellers have sold more than 100 order items — their high-volume sellers.

select count(*),seller_id from olist_order_items_dataset GROUP BY seller_id HAVING count(*)>100;