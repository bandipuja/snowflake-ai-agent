-- 03_create_fact_sales.sql
-- Creates and populates the FACT_SALES table with ~100k rows
-- using a deterministic GENERATOR-based pattern.

USE ROLE ACCOUNTADMIN;
USE DATABASE RETAIL_AGENT_DB;
USE SCHEMA ANALYTICS;

-- Recreate fact table
CREATE OR REPLACE TABLE FACT_SALES (
  SALES_ID   NUMBER AUTOINCREMENT,
  ORDER_DATE DATE,
  CUSTOMER_ID NUMBER,
  PRODUCT_ID  NUMBER,
  REGION_ID   NUMBER,
  QUANTITY    NUMBER,
  REVENUE     NUMBER(12,2)
);

-- Insert synthetic but realistic fact data
INSERT INTO FACT_SALES (
  ORDER_DATE,
  CUSTOMER_ID,
  PRODUCT_ID,
  REGION_ID,
  QUANTITY,
  REVENUE
)
SELECT
  d.DATE_KEY                                      AS ORDER_DATE,
  c.CUSTOMER_ID,
  p.PRODUCT_ID,
  r.REGION_ID,
  qty                                             AS QUANTITY,
  qty * p.UNIT_PRICE                              AS REVENUE
FROM TABLE(GENERATOR(ROWCOUNT => 100000)) g
JOIN DIM_DATE d
  ON d.DATE_KEY = DATEADD(day, MOD(SEQ4(), 730), '2023-01-01')
JOIN DIM_CUSTOMER c
  ON c.CUSTOMER_ID = MOD(SEQ4(), 500) + 100
JOIN DIM_PRODUCT p
  ON p.PRODUCT_ID = MOD(SEQ4(), 200) + 1000
JOIN DIM_REGION r
  ON r.REGION_ID = MOD(SEQ4(), 4) + 1
CROSS JOIN LATERAL (
  SELECT UNIFORM(1, 5, RANDOM()) AS qty
);

-- Validation
SELECT COUNT(*) AS fact_sales_rows FROM FACT_SALES;
