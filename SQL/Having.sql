-- Leadership wants to know which states have more than 500 customers — a real market, not a negligible one.
select count(*),customer_state from olist_customers_dataset GROUP BY customer_state having count(*)>500;

-- The sellers team wants to see which sellers have sold more than 100 order items — their high-volume sellers.

select count(*),seller_id from olist_order_items_dataset GROUP BY seller_id HAVING count(*)>100;

-- Finance wants to know which payment types have an average transaction value above 150 — identifying premium payment behavior.

select avg(payment_value),payment_type from olist_order_payments_dataset GROUP BY payment_type having avg(payment_value)>150;



-- Pattern 2 — WHERE + GROUP BY + HAVING together
-- The category team wants products where total revenue exceeds 5000, but only counting 
-- order items priced above 20 (filter noise first, then check the group's total).

select sum(price),product_id from olist_order_items_dataset where price>20 GROUP BY product_id having sum(price)>5000;


-- Ops wants order statuses that have more than 1000 orders, but only counting orders placed in 2018.
select count(*),order_status from olist_orders_dataset where year(order_purchase_timestamp)=2018 GROUP BY order_status HAVING count(*)>1000;



-- The reviews team wants review scores that appear more than 200 times, but only among reviews that actually have a written comment.

select count(*),review_score from olist_order_reviews_dataset where review_comment_message  IS NOT NULL GROUP BY review_score having count(*)>200


-- Pattern 3 — Multiple HAVING conditions (AND/OR)
-- The sellers team wants sellers with more than 50 order items sold AND total revenue above 3000 — genuinely high-volume, high-value sellers.

select count(*),sum(price),seller_id from olist_order_items_dataset group by seller_id having count(*)>50 and sum(price)>3000;
