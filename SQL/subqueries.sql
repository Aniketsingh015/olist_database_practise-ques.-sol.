-- The pricing team wants every order item priced above the average item price.

select order_item_id,price from olist_order_items_dataset where price>(select avg(price) from olist_order_items_dataset);

-- Finance wants every payment whose value is below the average payment value.
select payment_type, payment_value from olist_order_payments_dataset where payment_value <(Select avg(payment_value) from olist_order_payments_dataset);


-- The reviews team wants every review with a score below the overall average score.
select DISTINCT review_score,review_id from olist_order_reviews_dataset where review_score<(select avg (review_score) from olist_order_reviews_dataset);

-- Logistics wants every order item whose freight_value is higher than the average freight value.
select order_item_id,freight_value from olist_order_items_dataset where freight_value >(select avg(freight_value) from olist_order_items_dataset);

-- The pricing team wants the most expensive order item(s), meaning every item whose price equals the highest price.
select order_item_id,price from olist_order_items_dataset where price=(select max(price)from olist_order_items_dataset);

-- Finance wants every payment above the average value of credit card payments only, whichever payment type the row itself has.
select payment_value,payment_type from olist_order_payments_dataset where payment_value > (select avg(payment_value) from olist_order_payments_dataset where payment_type="credit_card");


-- Ops wants the most recently placed order(s), meaning orders whose purchase timestamp equals the latest timestamp in the table.
select order_id from olist_orders_dataset where order_purchase_timestamp=(SELECT MAX(order_purchase_timestamp)
    FROM olist_orders_dataset);

-- The catalog team wants every product heavier than the average product weight
select product_id,product_category_name from olist_products_dataset where product_weight_g>(select avg(product_weight_g)from olist_products_dataset);

-- The pricing team wants 'premium outliers': order items priced at more than double the average price
select product_id from olist_order_items_dataset where price>2*(select avg(price) from olist_order_items_dataset);

-- The category team wants every order item priced above the average item price, showing the product category name next to it.

select p.product_id,p.product_category_name,o.price from olist_products_dataset as p inner join olist_order_items_dataset as o on p.product_id=o.product_id
where price>(select avg(price) from olist_order_items_dataset);



-- Pattern 2: Subquery with IN / NOT IN
-- Marketing wants every order placed by a customer from SP.
select order_id,customer_id from olist_orders_dataset where customer_id in (Select customer_id from olist_customers_dataset where customer_state='SP');

-- Finance wants every order that was paid by voucher at least once.
select order_id from olist_orders_dataset where order_id in (Select order_id from olist_order_payments_dataset where payment_type='voucher');

-- The reviews team wants every order that received a 1-star review.
select order_id from olist_orders_dataset where order_id in (select order_id from olist_order_reviews_dataset where review_score =1);


-- The sellers team wants every seller who has sold at least one item priced above 1000.
select seller_id,seller_state from olist_sellers_dataset where seller_id in(select seller_id from olist_order_items_dataset where price>1000);

-- Support wants every customer who has had an order canceled.
select customer_id ,customer_state from olist_customers_dataset where customer_id in(select customer_id from olist_orders_dataset where order_status='canceled');


-- The catalog team wants every product that has never been ordered.
select product_id,product_category_name from olist_products_dataset where product_id not in (select product_id from olist_order_items_dataset);