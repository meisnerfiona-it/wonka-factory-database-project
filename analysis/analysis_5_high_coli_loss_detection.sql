use wonka_factory;
select * from dim_locations;
select * from dim_products;
select * from fact_sales;

-- Analysis 5: Identifying specific products sold at a loss in expensive regions.
-- Uses a subquery to filter for states where the COLI index is above 110.

SELECT 
    dim_products.product_name, 
    dim_locations.state_province, 
    fact_sales.gross_profit
FROM fact_sales
JOIN dim_products ON fact_sales.product_id = dim_products.product_id
JOIN dim_locations ON fact_sales.location_id = dim_locations.location_id
WHERE fact_sales.gross_profit < 0 
AND fact_sales.location_id IN (
    SELECT location_id 
    FROM dim_locations 
    WHERE coli_index > 110
);

/* SUMMARY: HIGH-COST LOCATION LOSS DETECTION
- FINDING: Data analysis confirms zero loss-making transactions in states with a high COST OF LIVING INDEX (Index > 110).
- INSIGHT: Current pricing strategies in expensive regions are effectively protecting margins; the growth focus can remain on increasing sales volume.
*/