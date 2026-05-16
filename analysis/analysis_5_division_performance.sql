use wonka_factory;
select * from dim_locations;
select * from dim_products;
select * from fact_sales;

-- Analysis 4: High-level summary of performance by Product Division.
-- This compares the financial health of Chocolate versus Sugar and other categories.

SELECT 
    dim_products.division, 
    SUM(fact_sales.sales) AS total_revenue, 
    SUM(fact_sales.gross_profit) AS total_profit,
    ROUND((SUM(fact_sales.gross_profit) / SUM(fact_sales.sales)) * 100, 2) AS net_margin
FROM fact_sales
JOIN dim_products ON fact_sales.product_id = dim_products.product_id
GROUP BY dim_products.division
ORDER BY net_margin DESC;

/* SUMMARY: DIVISION PERFORMANCE SUMMARY
- FINDING: The 'Chocolate' division is the primary driver of EARNINGS BEFORE INTEREST AND TAXES with a 67.45% margin, significantly outperforming the 'Other' division's 44.69% margin.
- INSIGHT: Prioritizing the high-margin Chocolate and Sugar divisions will maximize overall company Operating Profit.
*/