use wonka_factory;
select * from dim_locations;
select * from dim_products;
select * from fact_sales;

/* ================================================================================
WONKA FACTORY: REGIONAL & PRODUCT EFFICIENCY MASTER AUDIT
================================================================================
This script contains the full 5-part analysis used to identify operational 
inefficiencies and product profitability for the 2024 fiscal year.
*/

-- -----------------------------------------------------------------------------
-- ANALYSIS 1: REGIONAL EFFICIENCY ANALYSIS
-- -----------------------------------------------------------------------------
/* SUMMARY: 
- FINDING: Identified an 'Efficiency Gap' where states with a low COST OF LIVING INDEX 
  (like Texas) have higher manufacturing costs than expensive states like California.
- INSIGHT: Reducing this waste directly improves EARNINGS BEFORE INTEREST AND TAXES.
*/

SELECT 
    dim_locations.state_province, 
    dim_locations.coli_index, 
    ROUND(AVG(fact_sales.cost / fact_sales.units), 2) AS average_production_cost_per_unit
FROM fact_sales
JOIN dim_locations ON fact_sales.location_id = dim_locations.location_id
GROUP BY dim_locations.state_province, dim_locations.coli_index
ORDER BY dim_locations.coli_index DESC;


-- -----------------------------------------------------------------------------
-- ANALYSIS 2: PRODUCT PROFITABILITY ANALYSIS
-- -----------------------------------------------------------------------------
/* SUMMARY: 
- FINDING: 'Scrumdiddlyumptious' is the top profit earner, but 'Nutty Crunch Surprise' 
  is the most efficient product with the highest margin (71%).
- INSIGHT: Shifting sales to high-margin products is the fastest way to grow 
  EARNINGS BEFORE INTEREST AND TAXES.
*/

SELECT 
    dim_products.product_name, 
    SUM(fact_sales.gross_profit) AS total_gross_profit,
    ROUND((SUM(fact_sales.gross_profit) / SUM(fact_sales.sales)) * 100, 2) AS profit_margin_percentage
FROM fact_sales
JOIN dim_products ON fact_sales.product_id = dim_products.product_id
WHERE dim_products.division = 'Chocolate'
GROUP BY dim_products.product_name
ORDER BY total_gross_profit DESC;


-- -----------------------------------------------------------------------------
-- ANALYSIS 3: TEXAS ANOMALY OPERATIONAL AUDIT
-- -----------------------------------------------------------------------------
/* SUMMARY: 
- FINDING: Performance issues in Texas are caused by the 'Secret Factory' and 
  'The Other Factory,' which have unit costs triple the regional average.
- INSIGHT: Fixing these high-cost factories is the most direct way to recover 
  EARNINGS BEFORE INTEREST AND TAXES in the Texas region.
*/

SELECT 
    dim_locations.factory_name, 
    dim_locations.state_province, 
    dim_locations.coli_index,
    ROUND(AVG(fact_sales.cost / fact_sales.units), 2) AS average_production_cost_per_unit,
    SUM(fact_sales.gross_profit) AS total_factory_operating_profit
FROM fact_sales
JOIN dim_locations ON fact_sales.location_id = dim_locations.location_id
WHERE dim_locations.state_province = 'Texas'
GROUP BY dim_locations.factory_name, dim_locations.state_province, dim_locations.coli_index;


-- -----------------------------------------------------------------------------
-- ANALYSIS 4: DIVISION PERFORMANCE SUMMARY
-- -----------------------------------------------------------------------------
/* SUMMARY: 
- FINDING: The 'Chocolate' division is the primary driver of EARNINGS BEFORE 
  INTEREST AND TAXES, maintaining a strong 67% profit margin.
- INSIGHT: Prioritizing the high-margin Chocolate and Sugar divisions will 
  maximize overall company Operating Profit.
*/

SELECT 
    dim_products.division, 
    SUM(fact_sales.sales) AS total_sales_revenue, 
    SUM(fact_sales.gross_profit) AS total_gross_profit,
    ROUND((SUM(fact_sales.gross_profit) / SUM(fact_sales.sales)) * 100, 2) AS net_profit_margin_percentage
FROM fact_sales
JOIN dim_products ON fact_sales.product_id = dim_products.product_id
GROUP BY dim_products.division
ORDER BY net_profit_margin_percentage DESC;


-- -----------------------------------------------------------------------------
-- ANALYSIS 5: HIGH-COST LOCATION LOSS DETECTION
-- -----------------------------------------------------------------------------
/* SUMMARY: 
- FINDING: Data confirms zero loss-making transactions in states with a 
  high COST OF LIVING INDEX (Index > 110).
- INSIGHT: Current pricing in expensive regions is effectively protecting 
  Operating Profit; growth should focus on volume.
*/

SELECT 
    dim_products.product_name, 
    dim_locations.state_province, 
    fact_sales.gross_profit AS unit_operating_profit_or_loss
FROM fact_sales
JOIN dim_products ON fact_sales.product_id = dim_products.product_id
JOIN dim_locations ON fact_sales.location_id = dim_locations.location_id
WHERE fact_sales.gross_profit < 0 
AND fact_sales.location_id IN (
    SELECT dim_locations.location_id 
    FROM dim_locations 
    WHERE dim_locations.coli_index > 110
);

/* ================================================================================
END OF AUDIT
================================================================================
*/


/* SUMMARY: FINAL DELIVERABLES & STRATEGIC RECOMMENDATIONS
- FINDING: Data confirms that while 'Chocolate' is our strongest division, high operational waste in specific Texas factories is dragging down regional performance.
- INSIGHT: To maximize EARNINGS BEFORE INTEREST AND TAXES, Wonka must optimize Texas production and shift sales volume to high-margin products like 'Nutty Crunch Surprise.'
*/