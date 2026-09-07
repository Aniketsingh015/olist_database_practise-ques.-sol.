-- Pattern 1 — Basic INNER JOIN questions
-- The logistics team wants to see, for every order item, the product_category_name of the product involved — combine 
-- olist_order_items_dataset with olist_products_dataset.


select o.order_item_id,o.order_id,p.product_category_name from olist_order_items_dataset as o INNER JOIN olist_products_dataset as p On o.product_id=p.product_id;

-- Finance wants to see, for every payment, the order_status of the order it belongs to — combine olist_order_payments_dataset with olist_orders_dataset.
select p.payment_type,p.payment_value,o.order_id,o.order_status from olist_order_payments_dataset as p INNER JOIN olist_orders_dataset as o on o.order_id=p.order_id;


-- The reviews team wants to see, for every review, the order_status of the order it was left on — combine olist_order_reviews_dataset with olist_orders_dataset.

select r.review_id,r.review_comment_message,o.order_id,o.order_status from olist_order_reviews_dataset as r inner join olist_orders_dataset as o on o.order_id=r.order_id;

-- The sellers team wants to see, for every order item, the seller_city and seller_state of the seller who sold it — combine olist_order_items_dataset with olist_sellers_dataset.

select o.order_id ,s.seller_city,s.seller_state,s.seller_id from olist_sellers_dataset as s inner join olist_order_items_dataset o on o.seller_id=s.seller_id; 


-- Marketing wants to see, for every order, the customer_city of the customer who placed it — combine olist_orders_dataset with olist_customers_dataset.

select o.order_id,c.customer_city,c.customer_id from olist_customers_dataset c INNER JOIN olist_orders_dataset o on o.customer_id=c.customer_id;


-- Pattern 2 — INNER JOIN + WHERE
-- The logistics team wants the product_category_name for every order item, but only for order items priced above 300.

select p.product_category_name,o.order_id,o.order_item_id from olist_order_items_dataset as o INNER JOIN olist_products_dataset as p on p.product_id=o.product_id where o.price>300


-- Finance wants to see payment details, but only for payments belonging to orders with order_status = 'delivered'.
select p.payment_type,p.payment_value,o.order_id,o.order_status from olist_order_payments_dataset as p inner join olist_orders_dataset as o on p.order_id=o.order_id where o.order_status='delivered';

-- The reviews team wants to see review scores and comments, but only for reviews left on orders that were 'canceled' — investigating dissatisfaction on failed orders.
select r.review_score,r.review_id,r.review_comment_message,o.order_id,o.order_status from olist_order_reviews_dataset as r INNER JOIN olist_orders_dataset as o
on o.order_id=r.order_id where o.order_status='canceled';

-- The sellers team wants seller city and state, but only for order items with freight_value above 100 — high-shipping-cost items.
select s.seller_city,s.seller_state,o.order_id,o.order_item_id from olist_order_items_dataset as o INNER JOIN olist_sellers_dataset as s on o.seller_id=s.seller_id where o.freight_value>100

-- Marketing wants customer city for every order, but only for orders placed in the year 2018.
select c.customer_city,o.order_id from olist_customers_dataset as c inner join olist_orders_dataset as o on o.customer_id=c.customer_id where year(order_purchase_timestamp)=2018;


-- The category team wants product category names, but only 
-- for order items where the associated product has product_weight_g above 5000 (heavy items) — combine order_items with products, filter on weight.

select p.product_category_name,o.order_id,o.order_item_id from olist_products_dataset as p inner join olist_order_items_dataset as o on p.product_id=o.product_id
where product_weight_g>5000;