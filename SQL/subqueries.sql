-- The pricing team wants every order item priced above the average item price.

select order_item_id,price from olist_order_items_dataset where price>(select avg(price) from olist_order_items_dataset);

-- Finance wants every payment whose value is below the average payment value.
select payment_type, payment_value from olist_order_payments_dataset where payment_value <(Select avg(payment_value) from olist_order_payments_dataset);


-- The reviews team wants every review with a score below the overall average score.
select DISTINCT review_score,review_id from olist_order_reviews_dataset where review_score<(select avg (review_score) from olist_order_reviews_dataset);

-- Logistics wants every order item whose freight_value is higher than the average freight value.
select order_item_id,freight_value from olist_order_items_dataset where freight_value >(select avg(freight_value) from olist_order_items_dataset);
