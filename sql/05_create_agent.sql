USE ROLE ACCOUNTADMIN;
USE DATABASE RETAIL_AGENT_DB;
USE SCHEMA ANALYTICS;

CREATE OR REPLACE AGENT RETAIL_SALES_AGENT
FROM SPECIFICATION
$$
models:
  orchestration: auto

orchestration:
  budget:
    seconds: 30
    tokens: 8000

instructions:
  system: |
    You are a retail analytics AI assistant built on Snowflake.
    The warehouse uses a star schema with FACT_SALES and dimension tables.
    You generate optimized Snowflake SQL to answer business questions
    including MoM and YoY revenue analysis.

  response: |
    Respond concisely and include SQL when appropriate.
$$;
