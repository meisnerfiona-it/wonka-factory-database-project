CREATE DATABASE IF NOT EXISTS wonka_factory;
USE wonka_factory;

DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_products;
DROP TABLE IF EXISTS dim_locations;

CREATE TABLE dim_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    division VARCHAR(100) NOT NULL
);

CREATE TABLE dim_locations (
    location_id INT PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    state_province VARCHAR(100) NOT NULL,
    factory_name VARCHAR(100) NOT NULL,
    coli_index DECIMAL(10,2) NOT NULL
);

CREATE TABLE fact_sales (
    order_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    location_id INT NOT NULL,
    sales DECIMAL(10,2) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    gross_profit DECIMAL(10,2) NOT NULL,
    units INT NOT NULL,

    CONSTRAINT fk_fact_products
        FOREIGN KEY (product_id) REFERENCES dim_products(product_id),

    CONSTRAINT fk_fact_locations
        FOREIGN KEY (location_id) REFERENCES dim_locations(location_id)
);

DELETE FROM dim_products
WHERE product_id IS NULL
  AND product_name IS NULL
  AND division IS NULL;

DELETE FROM dim_locations
WHERE location_id IS NULL
  AND city IS NULL
  AND state_province IS NULL
  AND factory_name IS NULL
  AND coli_index IS NULL;
  
DELETE FROM fact_sales
WHERE order_id IS NULL
  AND product_id IS NULL
  AND location_id IS NULL
  AND sales IS NULL
  AND cost IS NULL
  AND gross_profit IS NULL
  AND units IS NULL;

SELECT COUNT(*) 
FROM dim_products
WHERE product_id IS NULL;
