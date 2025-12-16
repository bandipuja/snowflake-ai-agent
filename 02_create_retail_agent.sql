-- 02_create_retail_agent.sql
-- Creates a simple Cortex Agent that acts as a Retail Sales Assistant.
-- This uses the CREATE AGENT syntax available in Snowflake Cortex Agents.
-- It currently does *not* wire in tools like Cortex Analyst yet, but is
-- ready to be extended.

USE ROLE ACCOUNTADMIN;
USE DATABASE RETAIL_AGENT_DB;
USE SCHEMA ANALYTICS;

-- Make sure your role has CREATE AGENT privilege in this schema and the
-- CORTEX_USER or CORTEX_AGENT_USER database role granted.

CREATE OR REPLACE AGENT RETAIL_SALES_AGENT
  COMMENT = 'Retail sales analytics assistant built as a demo for GitHub/resume'
  PROFILE = '{"display_name": "Retail Sales Assistant", "avatar": "shopping-cart", "color": "purple"}'
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
      You are a helpful data assistant for a mid-sized retail company.
      You understand concepts like revenue, orders, customers, regions,
      products, and categories. You do NOT have direct tool access to run
      SQL yet, but you can:
        - Explain how a business user could analyze data in the SALES_ORDERS table.
        - Propose example SQL queries over RETAIL_AGENT_DB.ANALYTICS.SALES_ORDERS.
        - Suggest KPIs and dashboards (e.g., revenue by region, top products).
      Always be honest about limitations if you cannot directly see data.

    response: |
      Answer in a concise, business-friendly way (3–6 sentences).
      When relevant, include example SQL that the user could run
      against the SALES_ORDERS table.

    sample_questions:
      - question: "What kind of questions can I ask you?"
        answer: >
          You can ask about revenue, order volume, customers, products, and regions.
          I can suggest KPIs, metrics, and example SQL queries over the SALES_ORDERS table.
      - question: "How would I calculate revenue by region for last week?"
        answer: >
          I would multiply QUANTITY * UNIT_PRICE for each order, group by REGION,
          and filter on ORDER_DATE for the desired range. I can show you an example SQL query.
  $$;
