-- The pricing team wants every order item priced above the average item price.

select order_item_id,price from olist_order_items_dataset where price>(select avg(price) from olist_order_items_dataset);

-- Finance wants every payment whose value is below the average payment value.
select payment_type, payment_value from olist_order_payments_dataset where payment_value <(Select avg(payment_value) from olist_order_payments_dataset);