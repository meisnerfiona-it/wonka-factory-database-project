use wonka_factory;
select * from dim_locations;
select * from dim_products;
select * from fact_sales;

-- Analysis 3: Investigating operational costs within Texas factories.
-- Goal: Determine why costs are high in a state with a relatively low Cost of Living Index.

SELECT 
    dim_locations.factory_name, 
    dim_locations.state_province, 
    dim_locations.coli_index,
    ROUND(AVG(fact_sales.cost / fact_sales.units), 2) AS avg_unit_cost,
    SUM(fact_sales.gross_profit) AS total_factory_profit
FROM fact_sales
JOIN dim_locations ON fact_sales.location_id = dim_locations.location_id
WHERE dim_locations.state_province = 'Texas'
GROUP BY dim_locations.factory_name, dim_locations.state_province, dim_locations.coli_index;

/* SUMMARY: TEXAS ANOMALY OPERATIONAL AUDIT
- FINDING: Identified extreme manufacturing inefficiency at the 'Secret Factory' and 'The Other Factory' in Texas, where unit costs reached $3.00—nearly triple the $1.10 cost at 'Lot's O' Nuts'.
- INSIGHT: Closing or optimizing these specific high-cost factories is the most direct way to recover EARNINGS BEFORE INTEREST AND TAXES in the Texas region.
*/