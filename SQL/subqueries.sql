-- The pricing team wants every order item priced above the average item price.

select order_item_id,price from olist_order_items_dataset where price>(select avg(price) from olist_order_items_dataset);