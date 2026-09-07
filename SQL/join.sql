-- Pattern 1 — Basic INNER JOIN questions
-- The logistics team wants to see, for every order item, the product_category_name of the product involved — combine 
-- olist_order_items_dataset with olist_products_dataset.


select o.order_item_id,o.order_id,p.product_category_name from olist_order_items_dataset as o INNER JOIN olist_products_dataset as p On o.product_id=p.product_id;

-- Finance wants to see, for every payment, the order_status of the order it belongs to — combine olist_order_payments_dataset with olist_orders_dataset.
select p.payment_type,p.payment_value,o.order_id,o.order_status from olist_order_payments_dataset as p INNER JOIN olist_orders_dataset as o on o.order_id=p.order_id;


-- The reviews team wants to see, for every review, the order_status of the order it was left on — combine olist_order_reviews_dataset with olist_orders_dataset.

select r.review_id,r.review_comment_message,o.order_id,o.order_status from olist_order_reviews_dataset as r inner join olist_orders_dataset as o on o.order_id=r.order_id;