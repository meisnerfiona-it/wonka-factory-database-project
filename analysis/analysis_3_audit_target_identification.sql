/* ANALYSIS: Regional Risk & Performance Audit Target.
OBJECTIVE: Identify high-impact locations in low-COLI areas (Index < 100).
*/

SELECT 
    l.state_province,
    SUM(s.sales) AS total_revenue,
    SUM(s.units) AS total_units,
    SUM(s.gross_profit) AS total_profit
FROM dim_locations l
JOIN fact_sales s ON l.location_id = s.location_id
WHERE l.coli_index < 100
GROUP BY l.state_province
ORDER BY total_units DESC;

/* SUMMARY: AUDIT TARGET IDENTIFIED: TEXAS.
JUSTIFICATION: Texas is a significant financial outlier. 
It leads all low-cost regions in revenue ($13,024.10), 
units sold (3,614), and total gross profit ($8,643.08).
*/