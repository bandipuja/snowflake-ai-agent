# Snowflake Retail Sales AI Agent (Cortex Agents)

This project is a **Snowflake Cortex Agent** that acts as a small
*Retail Sales Analytics Assistant*.

You deploy everything using the **Snowflake web UI (Snowsight)** — no CLI is required.
All SQL and project files are kept here so you can push them to GitHub.

## What this project does

- Creates a demo Snowflake environment:
  - Warehouse `AGENT_WH`
  - Database `RETAIL_AGENT_DB`
  - Schema `ANALYTICS`
  - Table `SALES_ORDERS` with sample data
- Creates a **Cortex Agent** object called `RETAIL_SALES_AGENT`
  - Uses a Snowflake LLM (`snowflake-arctic`) for orchestration
  - Is designed as a *Retail Sales Assistant* for business users
- Gives you a starting point to later wire in:
  - Cortex Analyst (text-to-SQL over your tables)
  - Cortex Search (over docs, product descriptions, etc.)
  - Custom tools (procedures, UDFs)

> ⚠️ Note  
> The agent specification in `02_create_retail_agent.sql` uses the public
> Snowflake `CREATE AGENT` syntax as of late 2025. Snowflake may change
> or extend this syntax over time, so always check the latest docs if you
> see a parsing error.

## How to deploy using Snowsight (web UI only)

1. Log in to Snowflake (Snowsight).
2. Make sure your role has the `CORTEX_USER` or `CORTEX_AGENT_USER` database role
   and can `CREATE AGENT` in the target schema.
3. Open a new Worksheet.
4. Copy/paste and run the contents of:
   - `sql/01_setup_retail_env.sql`
   - `sql/02_create_retail_agent.sql`
5. In Snowsight, go to **AI & ML → Agents**.
   - You should see an agent named **RETAIL_SALES_AGENT** in database
     `RETAIL_AGENT_DB`, schema `ANALYTICS`.
6. Click the agent and start chatting with it. Try questions like:
   - *"What kind of retail questions can you help with?"*
   - *"How would I calculate revenue by region for last month?"*
7.Architecture

- Snowflake warehouse with a retail star schema:
  - FACT_SALES (~100k rows)
  - DIM_CUSTOMER, DIM_PRODUCT, DIM_REGION, DIM_DATE
- Cortex Semantic Model created using Snowsight UI
- Cortex Analyst attached to a Snowflake AI Agent
- Agent translates natural language questions into optimized Snowflake SQL
- Supports MoM and YoY revenue analytics

## Snowflake Cortex Agent

This project includes a Snowflake Cortex AI Agent deployed using Snowsight.

- The agent is backed by a semantic model created in the Snowflake UI
- Cortex Analyst is attached to enable text-to-SQL
- The agent queries a retail star schema with ~100k fact rows
- MoM and YoY revenue analytics are supported

> Note: Semantic models and agent attachments are managed Snowflake objects
> and are created via Snowsight UI rather than SQL.


Right now the agent is **instruction‑only** (it doesn’t yet call tools to run SQL),
but it’s a real Cortex Agent object and is a clean foundation for extending with:
- Custom Snowpark procedures for complex KPIs
- A UI (Streamlit, React, etc.) that talks to the agent via the Agents API

## Files

- `sql/01_setup_retail_env.sql` – Creates warehouse, DB, schema, and demo table with sample data.
- `sql/02_create_retail_agent.sql` – Creates the `RETAIL_SALES_AGENT` agent object.
- `README.md` – This file. Use it directly in your GitHub repo.

## Suggested GitHub repo layout

```
snowflake-retail-ai-agent/
├── README.md
├── sql/
│   ├── 01_create_schema.sql
│   ├── 02_create_dimensions.sql
│   ├── 03_create_fact_sales.sql
│   ├── 04_data_quality_checks.sql
│   └── 05_create_agent.sql
├── docs/
│   ├── architecture.png
│   └── agent-ui.png

```

You can now:

1. Download this project as a ZIP.
2. Unzip it locally.
3. Run the SQL in Snowsight to create the agent.
4. Initialize a Git repo and push it to GitHub.
