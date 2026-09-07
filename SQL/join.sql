-- Pattern 1 — Basic INNER JOIN questions
-- The logistics team wants to see, for every order item, the product_category_name of the product involved — combine 
-- olist_order_items_dataset with olist_products_dataset.


select o.order_item_id,o.order_id,p.product_category_name from olist_order_items_dataset as o INNER JOIN olist_products_dataset as p On o.product_id=p.product_id;