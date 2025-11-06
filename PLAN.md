# My First Process Tutorial - Comprehensive Plan

## Overview
This document outlines the structure for `my_first_process.md` - a comprehensive tutorial that guides users through solving their first business problem with Osiris, where **Claude Code acts as the interface** between the user and Osiris.

## Critical Interaction Model

**USER** → speaks to → **CLAUDE CODE** → uses → **OSIRIS** → generates → **RESULTS**

- Users **do NOT** run Osiris commands directly
- Users **describe business goals** in natural language to Claude Code
- Claude Code **uses Osiris MCP tools** to generate and execute pipelines
- Users **observe, validate, and guide** the process
- Tutorial shows "watching AI in action" while explaining what happens behind the scenes

---

## Business Scenario: E-commerce Customer Analysis

**Business Question (Natural Language):**
> "I need to understand which product categories are performing best by region. Combine our sales data with product information, clean up any issues, and show me total revenue and order count by category and region."

**Why This Scenario?**
- Represents real-world business analysis needs
- Not framed as a "technical data task"
- Could easily be: "build a data mart," "monitor ad spend," "identify churn risk," etc.
- Shows how Osiris translates business intent into technical execution

---

## Sample Data Structure

### File 1: `sales_data.csv`
Contains transactional sales data:
```
order_id,product_id,region,quantity,price,order_date,customer_id
1001,P101,North America,2,29.99,2024-01-15,C501
1002,P205,Europe,1,149.99,2024-01-15,C502
1003,P101,North America,5,29.99,2024-01-16,C503
1004,,Asia Pacific,3,79.99,2024-01-16,C504
1005,P340,Europe,1,199.99,2024-01-17,C505
...
```

**Data Issues (intentional for cleaning demo):**
- Missing product_id values (row 4)
- Inconsistent region naming
- Potential duplicate orders

### File 2: `product_catalog.csv`
Contains product information:
```
product_id,product_name,category,cost_price
P101,Wireless Mouse,Electronics,15.00
P205,Mechanical Keyboard,Electronics,75.00
P340,Office Chair,Furniture,120.00
P450,Desk Lamp,Furniture,35.00
...
```

### Expected Output: `category_performance.csv`
```
category,region,total_revenue,order_count,avg_order_value
Electronics,North America,15789.45,234,67.47
Electronics,Europe,12450.80,156,79.81
Furniture,North America,8920.30,89,100.23
...
```

---

## Tutorial Structure

## Phase 1: Introduction & How This Works (5 minutes)

### 1.1 The Business Problem
- Frame it from a business perspective
- Examples of similar questions:
  - "Build a customer segmentation data mart"
  - "Monitor daily ad spend by campaign"
  - "Identify customers at risk of churn"
  - "Calculate inventory turnover by warehouse"
  - "Track customer acquisition cost by channel"

### 1.2 The New Way: Describe → AI Executes → Results
- **You (User):** Describe your goal in plain English to Claude Code
- **Claude Code:** Uses Osiris to generate and execute a pipeline
- **Osiris:** Creates deterministic, reproducible data manifests
- **Result:** Your data processed, with full transparency

**Key insight:** You won't type `osiris` commands. You'll talk to Claude, and Claude will orchestrate Osiris for you.

### 1.3 What We'll Build
- Clear objectives
- Input → Process → Output diagram
- Expected outcome
- Your role: Describe, observe, validate

---

## Phase 2: Understanding Osiris (10 minutes)

### 2.1 Core Concepts
- **Deterministic Compiler:** Same input = Same output, always
- **Manifest:** The compiled, reproducible pipeline definition
- **Conversational Workflow:** Natural language → Interrogation → Proposal → Execution
- **Environment Parity:** Works identically local or cloud

### 2.2 Osiris Architecture (High-Level)
```
┌─────────────────┐
│  Natural        │
│  Language       │  "Analyze sales by category..."
│  Description    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  AI Compiler    │  Interrogates data sources
│  (Osiris)       │  Proposes pipeline
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Manifest       │  Reproducible pipeline definition
│  (.yaml)        │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Execution      │  Runs locally or E2B cloud
│  Engine         │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Results +      │  Data + Reports + AIOP
│  Reports        │
└─────────────────┘
```

### 2.3 The Osiris Workflow
1. **Describe:** User states business goal in plain English
2. **Interrogate:** Osiris analyzes available data sources
3. **Propose:** AI suggests a pipeline approach
4. **Review:** User approves or requests changes
5. **Compile:** Generates deterministic manifest
6. **Execute:** Runs pipeline (local or cloud)
7. **Report:** Interactive dashboards and AI-readable outputs

### 2.4 Key Components (Conceptual)
- **Extractors:** Read data from sources (CSV, DB, APIs)
- **Processors:** Transform, clean, join, aggregate
- **Writers:** Output results to destinations
- **Orchestrator:** Manages execution flow

---

## Phase 3: Installation & Setup (15 minutes)

### 3.1 Prerequisites

**MCP Client (choose one):**
- **Claude Code** (recommended for this tutorial) - Official CLI from Anthropic
- **Claude Desktop** - GUI application with MCP support
- **Cursor** - AI-powered IDE with MCP integration
- **Windsurf (Codeium)** - AI code editor
- **Other MCP-compatible clients** - Any tool supporting Model Context Protocol

**Note:** This tutorial uses Claude Code examples, but the same workflow applies to any MCP client. Just replace "ask Claude Code" with "ask your MCP client."

**System Requirements:**
- Python 3.9+ installed
- Basic command-line familiarity

### 3.2 Install Osiris as MCP Server

**Clone this tutorial repository:**
```bash
git clone https://github.com/[user]/osiris-get-started.git
cd osiris-get-started
```

**Install Osiris:**
```bash
# Create virtual environment
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install Osiris
pip install -r requirements.txt
```

**Configure Osiris as MCP server for Claude Code:**
```bash
# Initialize Osiris
python -m osiris init

# This creates the MCP server configuration that Claude Code can use
```

**What happens behind the scenes:**
- Osiris sets up as an MCP (Model Context Protocol) server
- Claude Code can now call Osiris tools/functions
- Creates `.osiris/` configuration directory
- Sets up logging and manifest directories

### 3.3 Verify Setup with Claude Code

**Open Claude Code and ask:**
```
Can you check if Osiris is available?
```

**Claude will verify:**
- Osiris MCP tools are accessible
- Configuration is valid
- Ready to process data pipelines

### 3.4 Project Structure
```
osiris-get-started/
├── .osiris/              # Osiris configuration (MCP server)
│   ├── config.yaml       # Global settings
│   └── profiles/         # Environment profiles
├── examples/
│   ├── data-in/          # Input data (provided)
│   │   ├── sales_data.csv
│   │   └── product_catalog.csv
│   ├── data-out/         # Output results (generated)
│   └── manifests/        # Pipeline definitions (generated by Osiris)
├── docs/
│   └── my_first_process.md  # This tutorial
├── .venv/                # Virtual environment
└── requirements.txt
```

### 3.5 Sample Data Ready to Use

The repository includes sample CSV files in `examples/data-in/`:
- `sales_data.csv` - Transaction data with intentional quality issues
- `product_catalog.csv` - Product details

**You don't need to download anything** - the data is ready for your first pipeline!

---

## Phase 4: Your First Process - Watch Claude Use Osiris (30 minutes)

### 4.1 Open Your MCP Client

**Using Claude Code (CLI):**
```bash
cd osiris-get-started
claude
```

**Using Claude Desktop:**
- Open Claude Desktop
- Navigate to the `osiris-get-started` folder in the file browser

**Using Cursor / Windsurf / Other IDE:**
- Open the `osiris-get-started` folder as your project
- Start a conversation with the AI assistant

**The workflow is the same regardless of which client you use.**

### 4.2 Describe Your Business Goal to Claude

**You say to Claude:**
```
I need to analyze which product categories are performing best by region.

I have two CSV files in examples/data-in/:
- sales_data.csv with transactions (order_id, product_id, region, quantity, price, order_date, customer_id)
- product_catalog.csv with product details (product_id, product_name, category, cost_price)

Can you:
1. Clean the data (remove records with missing product_id)
2. Join sales with product catalog on product_id
3. Calculate total revenue (quantity * price) for each order
4. Aggregate by category and region to show: total_revenue, order_count, avg_order_value
5. Output the results to examples/data-out/category_performance.csv
```

**What you'll observe:**
- Claude acknowledges your request
- Claude mentions it will use Osiris to build a pipeline
- Claude starts working

### 4.3 Watch Claude Use Osiris

**Claude's actions (visible to you):**
```
I'll help you analyze category performance by region using Osiris.

First, let me interrogate the data sources...
[Claude calls Osiris MCP tools to inspect the CSV files]

Found:
- examples/data-in/sales_data.csv: 1,234 rows, 7 columns
- examples/data-in/product_catalog.csv: 45 rows, 4 columns
- Detected 23 rows with missing product_id in sales data

Now I'll create a pipeline to process this data...
[Claude calls Osiris to generate pipeline manifest]

Pipeline created with these steps:
1. Extract: Read both CSV files
2. Clean: Filter out rows with null product_id
3. Join: LEFT JOIN sales → products on product_id
4. Compute: Calculate revenue = quantity * price
5. Aggregate: GROUP BY category, region with SUM, COUNT, AVG
6. Write: Output to category_performance.csv

Executing pipeline...
[Claude calls Osiris to run the pipeline]

✓ Pipeline completed successfully in 1.87s
✓ Generated 12 rows in examples/data-out/category_performance.csv
```

**What happens behind the scenes:**
- Claude uses Osiris MCP tool: `osiris_inspect_data()` to analyze CSV files
- Claude uses Osiris MCP tool: `osiris_generate_pipeline()` to create manifest
- Claude uses Osiris MCP tool: `osiris_execute_pipeline()` to run it
- Osiris creates a deterministic, reproducible manifest
- Osiris executes and logs everything

### 4.4 Inspect What Claude Created

**Ask Claude:**
```
Can you show me the manifest that was generated?
```

**Claude will display the generated YAML manifest:**

**Sample manifest structure:**
```yaml
version: "0.4.0"
fingerprint: "7a3f9c2e-1b4d-4e8f-9a2c-5d6e7f8a9b0c"
name: "Category Performance Analysis"
description: "Analyze product category performance by region"

pipeline:
  extractors:
    - id: sales_extractor
      type: csv_reader
      config:
        file_path: "examples/data-in/sales_data.csv"
        delimiter: ","
        encoding: "utf-8"

    - id: products_extractor
      type: csv_reader
      config:
        file_path: "examples/data-in/product_catalog.csv"
        delimiter: ","
        encoding: "utf-8"

  processors:
    - id: clean_sales
      type: filter
      input: sales_extractor
      config:
        condition: "product_id IS NOT NULL"

    - id: join_data
      type: join
      inputs:
        - clean_sales
        - products_extractor
      config:
        join_type: "left"
        on: "product_id"

    - id: calculate_revenue
      type: compute
      input: join_data
      config:
        new_column: "revenue"
        expression: "quantity * price"

    - id: aggregate_results
      type: aggregate
      input: calculate_revenue
      config:
        group_by:
          - "category"
          - "region"
        aggregations:
          - function: "sum"
            column: "revenue"
            alias: "total_revenue"
          - function: "count"
            column: "*"
            alias: "order_count"
          - function: "avg"
            column: "revenue"
            alias: "avg_order_value"

  writers:
    - id: output_writer
      type: csv_writer
      input: aggregate_results
      config:
        file_path: "examples/data-out/category_performance.csv"
        delimiter: ","
        encoding: "utf-8"

execution:
  mode: "batch"
  parallelism: 1
```

### 4.5 Verify the Results

**Ask Claude:**
```
Can you show me the output data?
```

**Claude will display:**
```csv
category,region,total_revenue,order_count,avg_order_value
Electronics,North America,15789.45,234,67.47
Electronics,Europe,12450.80,156,79.81
Electronics,Asia Pacific,9823.10,143,68.69
Furniture,North America,8920.30,89,100.23
Furniture,Europe,7234.50,72,100.48
Home & Garden,North America,6789.20,78,87.04
...
```

**Behind the scenes:** Claude reads `examples/data-out/category_performance.csv` and formats it for you

### 4.6 Request Additional Analysis

**Ask Claude:**
```
Which category has the highest average order value?
```

**Claude analyzes the data and responds:**
```
Based on the results, **Furniture** has the highest average order value at ~$100,
followed by Home & Garden (~$87) and Electronics (~$72).

This suggests that while Electronics has higher overall volume,
Furniture customers make larger individual purchases.
```

**Behind the scenes:** Claude can read and analyze the generated data without re-running the pipeline

### 4.7 View Execution Logs (Optional)

**Ask Claude:**
```
Can you show me the execution logs or metrics?
```

**Claude will display:**
- Pipeline execution time
- Row counts at each step
- Data quality checks performed
- Any warnings or issues encountered

**Behind the scenes:** Claude uses Osiris MCP tool to access execution logs and AIOP (AI Operation Package) data

---

## Phase 5: Understanding What Happened (15 minutes)

### 5.1 The Three-Layer System

**Your conversation with Claude triggered a sophisticated workflow:**

```
┌─────────────────────────────────────────┐
│  1. YOU (User)                          │
│  "Analyze category performance..."      │
└──────────────┬──────────────────────────┘
               │ Natural language
               ▼
┌─────────────────────────────────────────┐
│  2. CLAUDE (MCP Client)                 │
│  - Understands your goal                │
│  - Calls Osiris MCP tools               │
│  - Presents results back to you         │
└──────────────┬──────────────────────────┘
               │ MCP function calls
               ▼
┌─────────────────────────────────────────┐
│  3. OSIRIS (Pipeline Compiler)          │
│  - Inspects data sources                │
│  - Generates deterministic manifest     │
│  - Executes pipeline                    │
│  - Returns results + logs               │
└─────────────────────────────────────────┘
```

**Step-by-Step Breakdown:**

1. **You describe your goal** - No code, no technical specs, just business intent
2. **Claude interprets** - Understands what you need and decides to use Osiris
3. **Claude calls Osiris MCP tools:**
   - `osiris_inspect_data()` - Analyze CSV files
   - `osiris_generate_pipeline()` - Create manifest
   - `osiris_execute()` - Run the pipeline
4. **Osiris compiles & executes** - Deterministic, reproducible processing
5. **Claude presents results** - Shows you the data, analysis, and insights

### 5.2 Reproducibility Guarantee

**The manifest Osiris created is deterministic.**

**Ask Claude:**
```
Can you run that same analysis again?
```

**Claude will:**
- Use the same manifest fingerprint
- Execute with identical parameters
- Produce exactly the same results

**This works anywhere:** Local machine, E2B cloud, any environment with Osiris

### 5.3 Modifying the Pipeline

**You can iterate conversationally:**

**Ask Claude:**
```
Can you modify the analysis to only include orders from 2024 and add a filter for orders over $50?
```

**Claude will:**
- Load the existing manifest
- Apply your modifications
- Generate a new manifest with updated fingerprint
- Execute the new version
- Show you the updated results

**Or you can manually edit:** The manifest is YAML, so you can edit it directly if you prefer

### 5.4 Key Takeaways

✓ **Conversational interface** - Describe goals in plain English
✓ **AI orchestration** - Claude chooses when and how to use Osiris
✓ **Deterministic execution** - Same input = same output, guaranteed
✓ **Transparent** - Inspect manifests to see exactly what happens
✓ **Reproducible** - Works identically everywhere
✓ **Iterative** - Easily modify and refine through conversation

---

## Phase 6: Configuration & Credentials (20 minutes)

### 6.1 Working with Databases

**Example: PostgreSQL source**

```bash
osiris chat
```

```
> Connect to my PostgreSQL database at localhost:5432, database 'sales_db',
> read from table 'orders', and export active orders to CSV.
```

**Osiris will prompt:**
```
To connect to PostgreSQL, I need credentials:
- Username: [enter]
- Password: [enter] (hidden)
- Or use existing profile: [list profiles]
```

### 6.2 Credential Management

**Create profile:**
```bash
osiris profile create prod-db
```

**Configure:**
```yaml
# .osiris/profiles/prod-db.yaml
name: "prod-db"
type: "postgresql"
connection:
  host: "localhost"
  port: 5432
  database: "sales_db"
  username: "${PG_USER}"      # Environment variable
  password: "${PG_PASSWORD}"  # Environment variable
  ssl: true
```

**Use in manifest:**
```yaml
extractors:
  - id: db_extractor
    type: postgresql_reader
    profile: "prod-db"
    config:
      query: "SELECT * FROM orders WHERE status = 'active'"
```

### 6.3 Data Source Types

Osiris supports:
- **Files:** CSV, JSON, Parquet, Excel
- **Databases:** PostgreSQL, MySQL, SQLite, MongoDB
- **Cloud Storage:** S3, GCS, Azure Blob
- **APIs:** REST, GraphQL
- **Streams:** Kafka, Kinesis (coming in v0.5+)

### 6.4 Data Destination Types

Osiris can write to:
- **Files:** CSV, JSON, Parquet
- **Databases:** Any SQL database
- **Cloud Storage:** S3, GCS, Azure
- **APIs:** REST endpoints
- **Data Warehouses:** Snowflake, BigQuery, Redshift (roadmap)

---

## Phase 7: Building Custom Components (30 minutes)

### 7.1 When to Build Custom Components

**Use cases:**
- Business-specific transformations
- Custom data validation rules
- Integration with proprietary systems
- Advanced ML preprocessing
- Domain-specific enrichment

### 7.2 Custom Processor Example

**Goal:** Add a custom "revenue tier" classification

**Create processor file:**
```python
# custom_processors/revenue_tier.py

from osiris.processors import BaseProcessor

class RevenueTierProcessor(BaseProcessor):
    """
    Classifies orders into revenue tiers:
    - Low: < $50
    - Medium: $50-$200
    - High: > $200
    """

    def __init__(self, config):
        super().__init__(config)
        self.low_threshold = config.get('low_threshold', 50)
        self.high_threshold = config.get('high_threshold', 200)

    def process(self, data):
        """
        Args:
            data: DataFrame with 'revenue' column
        Returns:
            DataFrame with added 'revenue_tier' column
        """
        def classify(revenue):
            if revenue < self.low_threshold:
                return 'Low'
            elif revenue < self.high_threshold:
                return 'Medium'
            else:
                return 'High'

        data['revenue_tier'] = data['revenue'].apply(classify)
        return data

    def validate(self, data):
        """Validate input data has required columns"""
        if 'revenue' not in data.columns:
            raise ValueError("Input data must have 'revenue' column")
        return True
```

### 7.3 Register Custom Processor

**Method 1: Configuration file**
```yaml
# .osiris/config.yaml
custom_components:
  processors:
    - name: "revenue_tier"
      module: "custom_processors.revenue_tier"
      class: "RevenueTierProcessor"
```

**Method 2: CLI registration**
```bash
osiris register processor revenue_tier custom_processors/revenue_tier.py:RevenueTierProcessor
```

### 7.4 Use Custom Processor

**In conversational mode:**
```bash
osiris chat
```

```
> Use my custom revenue_tier processor to classify orders,
> then aggregate by tier and region
```

**In manifest:**
```yaml
processors:
  - id: classify_tiers
    type: revenue_tier  # Your custom processor
    input: calculate_revenue
    config:
      low_threshold: 50
      high_threshold: 200
```

### 7.5 Custom Extractor Example

**Goal:** Extract data from a custom REST API

```python
# custom_extractors/custom_api.py

from osiris.extractors import BaseExtractor
import requests
import pandas as pd

class CustomAPIExtractor(BaseExtractor):
    """
    Extracts data from custom REST API
    """

    def __init__(self, config):
        super().__init__(config)
        self.api_url = config['api_url']
        self.api_key = config.get('api_key')
        self.headers = {'Authorization': f'Bearer {self.api_key}'} if self.api_key else {}

    def extract(self):
        """
        Returns:
            DataFrame with extracted data
        """
        response = requests.get(self.api_url, headers=self.headers)
        response.raise_for_status()

        data = response.json()
        df = pd.DataFrame(data['results'])

        return df

    def schema(self):
        """Return expected schema"""
        return {
            'columns': ['id', 'name', 'value', 'timestamp'],
            'types': ['int', 'str', 'float', 'datetime']
        }
```

### 7.6 Custom Writer Example

**Goal:** Write results to a monitoring dashboard API

```python
# custom_writers/dashboard_writer.py

from osiris.writers import BaseWriter
import requests

class DashboardWriter(BaseWriter):
    """
    Writes aggregated results to monitoring dashboard
    """

    def __init__(self, config):
        super().__init__(config)
        self.dashboard_url = config['dashboard_url']
        self.api_key = config['api_key']

    def write(self, data):
        """
        Args:
            data: DataFrame to write
        """
        # Convert DataFrame to dashboard format
        payload = {
            'metrics': data.to_dict(orient='records'),
            'timestamp': datetime.now().isoformat(),
            'pipeline_id': self.config.get('pipeline_id')
        }

        response = requests.post(
            self.dashboard_url,
            json=payload,
            headers={'Authorization': f'Bearer {self.api_key}'}
        )
        response.raise_for_status()

        return len(data)
```

### 7.7 Testing Custom Components

**Unit test example:**
```python
# tests/test_revenue_tier.py

import pytest
import pandas as pd
from custom_processors.revenue_tier import RevenueTierProcessor

def test_revenue_tier_classification():
    # Arrange
    config = {'low_threshold': 50, 'high_threshold': 200}
    processor = RevenueTierProcessor(config)

    data = pd.DataFrame({
        'order_id': [1, 2, 3],
        'revenue': [25, 100, 300]
    })

    # Act
    result = processor.process(data)

    # Assert
    assert result['revenue_tier'].tolist() == ['Low', 'Medium', 'High']

def test_revenue_tier_validation():
    config = {}
    processor = RevenueTierProcessor(config)

    invalid_data = pd.DataFrame({'order_id': [1, 2]})

    with pytest.raises(ValueError):
        processor.validate(invalid_data)
```

**Run tests:**
```bash
pytest tests/
```

### 7.8 Best Practices for Custom Components

1. **Inherit from base classes:** `BaseExtractor`, `BaseProcessor`, `BaseWriter`
2. **Implement required methods:** `extract()`, `process()`, `write()`
3. **Add validation:** Check input data structure and types
4. **Handle errors gracefully:** Use try-except blocks
5. **Log operations:** Use Osiris logging framework
6. **Document thoroughly:** Docstrings with examples
7. **Write tests:** Unit tests for each component
8. **Make configurable:** Accept configuration parameters

---

## Phase 8: Advanced Patterns (20 minutes)

### 8.1 Conditional Processing

**Scenario:** Different logic for different regions

```yaml
processors:
  - id: region_router
    type: conditional
    input: cleaned_data
    conditions:
      - condition: "region == 'North America'"
        route_to: us_processor
      - condition: "region == 'Europe'"
        route_to: eu_processor
      - default: international_processor
```

### 8.2 Error Handling & Data Quality

**Manifest configuration:**
```yaml
error_handling:
  strategy: "continue"  # Options: fail, continue, skip_record
  dead_letter:
    enabled: true
    output: "examples/data-out/errors.csv"

data_quality:
  checks:
    - type: "not_null"
      columns: ["product_id", "order_id"]
    - type: "range"
      column: "price"
      min: 0
      max: 10000
    - type: "unique"
      columns: ["order_id"]
```

### 8.3 Incremental Processing

**Track processed data:**
```yaml
extractors:
  - id: sales_extractor
    type: csv_reader
    config:
      file_path: "data/sales_data.csv"
      incremental:
        enabled: true
        column: "order_date"
        last_value: "${LAST_PROCESSED_DATE}"
```

### 8.4 Parallel Processing

**Process large datasets in parallel:**
```yaml
execution:
  mode: "batch"
  parallelism: 4  # Use 4 parallel workers
  partition_by: "region"  # Partition data by region
```

### 8.5 Scheduled Execution

**Run pipelines on schedule:**
```bash
# Using cron
crontab -e
```

```
# Run every day at 2 AM
0 2 * * * /path/to/osiris run /path/to/manifest.yaml
```

**Using Osiris scheduler (coming in v0.5+):**
```yaml
schedule:
  cron: "0 2 * * *"
  timezone: "UTC"
```

### 8.6 Pipeline Composition

**Reuse manifests as sub-pipelines:**
```yaml
pipeline:
  sub_pipelines:
    - name: "data_cleaning"
      manifest: "examples/manifests/clean_sales_data.yaml"
    - name: "enrichment"
      manifest: "examples/manifests/enrich_products.yaml"

  processors:
    - id: final_aggregation
      input: enrichment.output  # Reference sub-pipeline output
      type: aggregate
```

---

## Phase 9: Troubleshooting & Best Practices (15 minutes)

### 9.1 Common Issues

**Issue 1: File not found**
```
Error: FileNotFoundError: examples/data-in/sales_data.csv
```
**Solution:** Check file paths are relative to execution directory

**Issue 2: Schema mismatch**
```
Error: Column 'product_id' not found in join
```
**Solution:** Verify column names match exactly (case-sensitive)

**Issue 3: Memory errors with large files**
```
Error: MemoryError: Unable to allocate array
```
**Solution:** Use chunking or increase parallelism

### 9.2 Debugging Pipelines

**Enable verbose logging:**
```bash
osiris run manifest.yaml --verbose
```

**Inspect intermediate results:**
```yaml
processors:
  - id: clean_sales
    type: filter
    debug: true  # Save intermediate output
    debug_output: "debug/clean_sales.csv"
```

**Use AIOP for analysis:**
```bash
osiris logs aiop --last | jq '.data_quality'
```

### 9.3 Performance Optimization

**Tips:**
1. Use appropriate parallelism
2. Filter early in the pipeline
3. Avoid unnecessary joins
4. Use columnar formats (Parquet) for large data
5. Profile execution: `osiris run --profile`

### 9.4 Best Practices

1. **Version control manifests:** Treat manifests as code
2. **Use profiles for credentials:** Never hardcode secrets
3. **Test with sample data first:** Before running on full datasets
4. **Document business logic:** Add comments to manifests
5. **Monitor execution:** Use HTML reports and AIOP
6. **Validate outputs:** Check data quality after each run
7. **Handle errors gracefully:** Use dead letter queues
8. **Keep manifests modular:** Break complex pipelines into sub-pipelines

---

## Phase 10: Next Steps & Resources (10 minutes)

### 10.1 What You've Learned

✅ Translate business questions into Osiris pipelines
✅ Install and configure Osiris
✅ Use conversational interface to build pipelines
✅ Understand deterministic compilation and manifests
✅ Execute pipelines locally and in cloud
✅ Configure data sources and credentials
✅ Build custom extractors, processors, and writers
✅ Apply advanced patterns (error handling, incremental processing)
✅ Debug and optimize pipelines
✅ Follow best practices

### 10.2 Where to Go Next

**Documentation:**
- [User Guide](link) - Complete reference
- [Architecture Docs](link) - Technical deep-dive
- [API Reference](link) - Component interfaces
- [LLM-friendly docs](llms.txt) - For AI assistants

**Examples:**
- Multi-source aggregation
- Streaming pipelines (v0.5+)
- ML preprocessing pipelines
- Real-time monitoring dashboards

**Community:**
- GitHub Issues: Report bugs, request features
- Discussions: Ask questions, share patterns
- Contributing: Submit PRs for new components

### 10.3 Advanced Topics to Explore

- **Streaming pipelines:** Process real-time data streams
- **ML integration:** Prepare data for machine learning
- **Data quality frameworks:** Advanced validation rules
- **Monitoring & alerting:** Production pipeline monitoring
- **CI/CD integration:** Automated testing and deployment
- **Multi-environment workflows:** Dev → Staging → Prod
- **Data lineage tracking:** Understand data provenance
- **Cost optimization:** Efficient cloud execution

### 10.4 Sample Projects to Try

1. **Customer Segmentation Pipeline**
   - Extract: CRM database + Transaction logs
   - Process: RFM analysis, clustering
   - Write: Marketing automation platform

2. **Ad Spend Monitoring**
   - Extract: Google Ads + Facebook Ads APIs
   - Process: Aggregate by campaign, calculate ROI
   - Write: Real-time dashboard + Slack alerts

3. **Inventory Forecasting**
   - Extract: Sales history + Inventory levels
   - Process: Time-series aggregation
   - Write: Forecasting model input

4. **Churn Prediction Data Mart**
   - Extract: User activity logs + Support tickets
   - Process: Feature engineering
   - Write: Data warehouse

---

## Appendix: Quick Reference

### Common Commands
```bash
# Installation
osiris init

# Conversational interface
osiris chat

# Run pipeline
osiris run manifest.yaml
osiris run manifest.yaml --e2b  # Cloud execution

# Reports
osiris logs html --open
osiris logs aiop --last

# Profiles
osiris profile create <name>
osiris profile list

# Components
osiris register processor <name> <path>
osiris list processors

# Debugging
osiris run manifest.yaml --verbose
osiris run manifest.yaml --profile
```

### Manifest Template
```yaml
version: "0.4.0"
name: "Pipeline Name"

pipeline:
  extractors:
    - id: source
      type: csv_reader
      config:
        file_path: "data/input.csv"

  processors:
    - id: transform
      type: filter
      input: source
      config:
        condition: "column > 0"

  writers:
    - id: output
      type: csv_writer
      input: transform
      config:
        file_path: "data/output.csv"
```

---

## Document Metadata

- **Version:** 1.0
- **Last Updated:** 2024-03-15
- **Target Audience:** Data analysts, engineers, business users
- **Estimated Completion Time:** 2-3 hours
- **Prerequisites:** Python 3.9+, basic command-line knowledge
- **Osiris Version:** 0.4.0+

