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



-- Ops wants order status and customer state, but only for customers based in 'SP' or 'RJ'.
select o.order_id,o.order_status,c.customer_id,c.customer_city,c.customer_state from olist_customers_dataset as c inner join olist_orders_dataset as o on o.customer_id=c.customer_id
where c.customer_state in ('SP','RJ');

-- The pricing team wants seller state and price, but only for order items priced between 50 and 150.

select s.seller_id,s.seller_state,o.price,o.order_id from olist_sellers_dataset as s inner join olist_order_items_dataset as o on o.seller_id=s.seller_id
where o.price between 50 and 150;



-- Pattern 3 — INNER JOIN + GROUP BY
-- The category management team finally wants what they originally asked for at the start of this whole project: 
-- total revenue per product category name (readable English names, not raw category codes).

select sum(o.price),p.product_id,p.product_category_name from olist_products_dataset as p inner join olist_order_items_dataset as o on o.product_id=p.product_id group by p.product_category_name,p.product_id; 


-- Regional operations wants: how many orders exist per customer state — the exact question that got queued back when we first hit the JOIN wall.
select count(*),c.customer_state from olist_customers_dataset as c inner join olist_orders_dataset as o on c.customer_id=o.customer_id group by c.customer_state;

-- The reviews team wants to know if certain order statuses correlate with worse satisfaction: average review score per order status.
select avg(r.review_score),o.order_status from olist_order_reviews_dataset as r inner join olist_orders_dataset as o on o.order_id=r.order_id group by o.order_status;


-- The logistics team wants: average freight value per seller state — to see which regions have the most expensive shipping.

select avg(o.freight_value),s.seller_state from olist_order_items_dataset as o inner join olist_sellers_dataset as s on o.seller_id=s.seller_id GROUP BY s.seller_state;


-- Finance wants: total payment value per order status — how much money is tied up in orders that are still processing, cancelled, etc., versus delivered.

select sum(p.payment_type),o.order_status from olist_order_payments_dataset as p inner join olist_orders_dataset as o on o.order_id=p.order_id GROUP BY o.order_status;


-- The sellers team wants: total revenue per seller state — which regions are generating the most sales.

select sum(price),s.seller_state from olist_sellers_dataset as s inner join olist_order_items_dataset as o on o.seller_id=s.seller_id GROUP BY s.seller_state;

-- The pricing team wants: average price per product category name — which categories tend to be premium vs budget.
select avg(o.price),p.product_category_name from olist_order_items_dataset as o inner join olist_products_dataset as p on o.product_id=p.product_id GROUP BY p.product_category_name;

-- Ops wants: count of reviews per order status — do cancelled orders still generate reviews? How many?
select count(*),o.order_status from olist_order_reviews_dataset as r inner join olist_orders_dataset as o on o.order_id=r.order_id GROUP BY o.order_status;




-- Pattern 4 — LEFT JOIN questions
-- Show every seller along with the order_id of items they've sold — but don't drop sellers who haven't sold anything yet.


select s.seller_id ,o.order_id from olist_sellers_dataset as s left join olist_order_items_dataset as o on o.seller_id=s.seller_id; 

-- Show every product along with the order_id of any order item containing it — but don't drop products that have never been ordered.
select p.product_id,o.order_id from olist_products_dataset as p left join olist_order_items_dataset as o  on o.product_id=p.product_id;


-- Show every customer along with the order_id of orders they've placed — but don't drop customers who have never placed an order.
select c.customer_id,o.order_id from olist_customers_dataset as c Left join olist_orders_dataset as o on c.customer_id=o.customer_id;

-- Show every order item along with its review score (via the order it belongs to) — but don't drop order items whose order was never reviewed.
select o.order_item_id,r.review_score from olist_order_items_dataset as o left join olist_order_reviews_dataset as r on o.order_id=r.order_id;

-- Pattern 5 — LEFT JOIN + IS NULL (anti-join)

-- The sellers performance team wants a list of sellers who have never sold anything — completely inactive accounts they might want to follow up with or remove.
select s.seller_id,o.order_id from olist_sellers_dataset as s left join olist_order_items_dataset as o on s.seller_id=o.seller_id where o.order_id is null;

-- The catalog team wants to find products that have never been ordered — dead inventory they might want to discontinue or promote.
select p.product_id,o.order_id from olist_products_dataset as p left join olist_order_items_dataset as o on p.product_id=o.product_id where o.order_id is null;

-- The growth team wants to identify customers who signed up but never placed a single order — a re-engagement campaign target list.
select c.customer_id,o.order_id from olist_customers_dataset as c left join olist_orders_dataset as o on c.customer_id=o.customer_id where o.order_id is null;