use wonka_factory;
select * from dim_locations;
select * from dim_products;
select * from fact_sales;

-- Analysis 1: Comparing internal production costs against the state Cost of Living Index (COLI).
-- This helps identify if manufacturing costs are scaling correctly with the local economy.

SELECT 
    dim_locations.state_province, 
    dim_locations.coli_index, 
    ROUND(AVG(fact_sales.cost / fact_sales.units), 2) AS avg_unit_cost
FROM fact_sales
JOIN dim_locations ON fact_sales.location_id = dim_locations.location_id
GROUP BY dim_locations.state_province, dim_locations.coli_index
ORDER BY dim_locations.coli_index DESC;

/* SUMMARY: REGIONAL EFFICIENCY ANALYSIS
- FINDING: Identified an 'Efficiency Gap' where low-cost states like Texas have high unit costs.
- INSIGHT: Reducing this waste directly improves EARNINGS BEFORE INTEREST AND TAXES (Operating Profit).
*/

