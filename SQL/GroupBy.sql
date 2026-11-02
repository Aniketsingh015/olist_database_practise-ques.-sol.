-- Scenario A: the sellers and logistics team
-- The logistics team is looking at seller activity and shipping costs.


-- 1. How many sellers are there in each state?
select count(*),seller_state FROM olist_sellers_dataset GROUP BY seller_state;
 