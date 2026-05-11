use wonka_factory;
select * from dim_locations;
select * from dim_products;
select * from fact_sales;

-- Analysis 2: Ranking 'Wonka Bar' flavors by total profit and margin.
-- We use this to identify 'Money Makers' and 'Money Losers' in our core chocolate division.

-- Identify the Top 3 "Money Makers"
SELECT 
    dim_products.product_name, 
    SUM(fact_sales.gross_profit) AS total_profit,
    ROUND((SUM(fact_sales.gross_profit) / SUM(fact_sales.sales)) * 100, 2) AS profit_margin_pct
FROM fact_sales
JOIN dim_products ON fact_sales.product_id = dim_products.product_id
WHERE dim_products.division = 'Chocolate'
GROUP BY dim_products.product_name
ORDER BY total_profit DESC
LIMIT 3;

-- Identify the Bottom performers
SELECT 
    dim_products.product_name, 
    SUM(fact_sales.gross_profit) AS total_profit,
    ROUND((SUM(fact_sales.gross_profit) / SUM(fact_sales.sales)) * 100, 2) AS profit_margin_pct
FROM fact_sales
JOIN dim_products ON fact_sales.product_id = dim_products.product_id
WHERE dim_products.division = 'Chocolate'
GROUP BY dim_products.product_name
ORDER BY total_profit ASC;

/* SUMMARY OF PRODUCT PROFITABILITY
- Top Money Maker (Total Profit): Wonka Bar - Scrumdiddlyumptious ($18,350)
- Efficiency Leader (Highest Margin): Wonka Bar - Nutty Crunch Surprise (71.35%)
- Underperformer: Wonka Bar - Fudge Mallows (Lowest profit and mid-range margin).
- Insight: Shifting sales volume to Nutty Crunch Surprise could increase overall company EBIT.
*/