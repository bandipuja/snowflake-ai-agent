-- 01_setup_retail_env.sql
-- Creates a simple environment and demo data for the Retail Sales AI Agent.

-- Adjust ROLE / WAREHOUSE sizes to match your account if needed.

USE ROLE ACCOUNTADMIN;

-- 1) Create a small warehouse for the agent demos
CREATE WAREHOUSE IF NOT EXISTS AGENT_WH
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

-- 2) Create database & schema
CREATE DATABASE IF NOT EXISTS RETAIL_AGENT_DB;
USE DATABASE RETAIL_AGENT_DB;

CREATE SCHEMA IF NOT EXISTS ANALYTICS;
USE SCHEMA ANALYTICS;

-- 3) Create a simple sales orders table
CREATE OR REPLACE TABLE SALES_ORDERS (
  ORDER_ID        NUMBER AUTOINCREMENT,
  ORDER_DATE      DATE,
  CUSTOMER_ID     NUMBER,
  REGION          STRING,
  PRODUCT_NAME    STRING,
  CATEGORY        STRING,
  QUANTITY        NUMBER,
  UNIT_PRICE      NUMBER(10,2)
);

-- 4) Insert some demo data
INSERT INTO SALES_ORDERS (ORDER_DATE, CUSTOMER_ID, REGION, PRODUCT_NAME, CATEGORY, QUANTITY, UNIT_PRICE)
VALUES
  ('2025-01-05', 101, 'North',  'Running Shoes',  'Footwear',      2, 79.99),
  ('2025-01-06', 102, 'South',  'Yoga Mat',       'Fitness',       1, 25.50),
  ('2025-01-07', 103, 'East',   'T-Shirt',        'Apparel',       3, 15.00),
  ('2025-01-08', 104, 'West',   'Hoodie',         'Apparel',       1, 45.00),
  ('2025-01-09', 101, 'North',  'Water Bottle',   'Accessories',   2, 12.00),
  ('2025-01-10', 105, 'South',  'Trail Shoes',    'Footwear',      1, 95.00),
  ('2025-01-11', 106, 'East',   'Fitness Tracker','Electronics',   1, 129.00),
  ('2025-01-12', 107, 'West',   'Running Shorts', 'Apparel',       2, 22.50),
  ('2025-01-13', 108, 'North',  'Gym Bag',        'Accessories',   1, 39.99),
  ('2025-01-14', 109, 'South',  'Sports Socks',   'Apparel',       5, 8.99);

-- 5) Quick check
SELECT * FROM SALES_ORDERS ORDER BY ORDER_DATE;
