# My First Process Tutorial - Comprehensive Plan

## Overview
This document outlines the structure for `my_first_process.md` - a comprehensive tutorial that guides users through building their first data pipeline with Osiris, from a business problem to a complete solution.

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

## Phase 1: Introduction & Business Context (5 minutes)

### 1.1 The Business Problem
- Frame it from a business perspective
- Examples of similar questions:
  - "Build a customer segmentation data mart"
  - "Monitor daily ad spend by campaign"
  - "Identify customers at risk of churn"
  - "Calculate inventory turnover by warehouse"
  - "Track customer acquisition cost by channel"

### 1.2 Traditional Approach vs. Osiris
- **Traditional:** Manual SQL queries, scripts, orchestration tools
- **Osiris:** Describe intent → AI generates → Deterministic execution
- Emphasize: "You describe WHAT, Osiris figures out HOW"

### 1.3 What We'll Build
- Clear objectives
- Input → Process → Output diagram
- Expected outcome

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
- Python 3.9+ installed
- Basic command-line familiarity
- Text editor (VS Code, Sublime, etc.)

### 3.2 Install Osiris
```bash
# Create project directory
mkdir osiris-demo
cd osiris-demo

# Create virtual environment
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install Osiris
pip install -r requirements.txt
# Or: pip install osiris-pipeline

# Initialize Osiris
osiris init
```

**What happens behind the scenes:**
- Creates `.osiris/` configuration directory
- Sets up default profiles
- Initializes logging structure
- Creates manifest template directory

### 3.3 Verify Installation
```bash
osiris --version
osiris --help
```

### 3.4 Project Structure
```
osiris-demo/
├── .osiris/              # Osiris configuration
│   ├── config.yaml       # Global settings
│   └── profiles/         # Environment profiles
├── examples/
│   ├── data-in/          # Input data
│   ├── data-out/         # Output results
│   └── manifests/        # Saved pipeline definitions
├── .venv/                # Virtual environment
└── requirements.txt
```

### 3.5 Download Sample Data
```bash
# Create directory structure
mkdir -p examples/data-in examples/data-out

# Download sample files (from this repo)
curl -o examples/data-in/sales_data.csv https://raw.githubusercontent.com/[user]/osiris-get-started/main/examples/data-in/sales_data.csv
curl -o examples/data-in/product_catalog.csv https://raw.githubusercontent.com/[user]/osiris-get-started/main/examples/data-in/product_catalog.csv
```

---

## Phase 4: Building Your First Process (30 minutes)

### 4.1 Start Conversational Interface
```bash
osiris chat
```

**What you'll see:**
```
Osiris Pipeline v0.4.0
Deterministic compiler for AI-native data pipelines

Ready. Describe your data goal in plain English.
>
```

### 4.2 Describe Your Goal
```
> I need to analyze product category performance by region.
> I have two CSV files: sales_data.csv with transactions (order_id,
> product_id, region, quantity, price, order_date) and
> product_catalog.csv with product details (product_id, product_name,
> category, cost_price).
>
> Please:
> 1. Clean the data (remove records with missing product_id)
> 2. Join sales with product catalog on product_id
> 3. Calculate total revenue (quantity * price) for each order
> 4. Aggregate by category and region: total_revenue, order_count, avg_order_value
> 5. Output to examples/data-out/category_performance.csv
```

**What happens behind the scenes:**
- Osiris analyzes your request
- Identifies data sources (CSV files)
- Plans transformation steps
- Determines output format

### 4.3 Osiris Interrogates & Proposes
```
Interrogating data sources...
✓ Found: examples/data-in/sales_data.csv (1,234 rows, 7 columns)
✓ Found: examples/data-in/product_catalog.csv (45 rows, 4 columns)

Analyzing data structure...
✓ Identified join key: product_id
⚠ Found 23 rows with missing product_id in sales_data.csv
✓ No schema conflicts detected

Proposed pipeline:
┌──────────────────────────────────────────────────────┐
│ Step 1: Extract                                      │
│ - Read sales_data.csv                                │
│ - Read product_catalog.csv                           │
├──────────────────────────────────────────────────────┤
│ Step 2: Clean                                        │
│ - Filter sales: product_id IS NOT NULL              │
│ - Result: 1,211 valid rows                          │
├──────────────────────────────────────────────────────┤
│ Step 3: Join                                         │
│ - LEFT JOIN sales → products ON product_id          │
│ - Compute: revenue = quantity * price               │
├──────────────────────────────────────────────────────┤
│ Step 4: Aggregate                                    │
│ - GROUP BY: category, region                        │
│ - SUM(revenue) AS total_revenue                     │
│ - COUNT(*) AS order_count                           │
│ - AVG(revenue) AS avg_order_value                   │
├──────────────────────────────────────────────────────┤
│ Step 5: Write                                        │
│ - Output: examples/data-out/category_performance.csv│
└──────────────────────────────────────────────────────┘

Estimated execution time: ~2 seconds
Estimated output: ~12 rows

Approve pipeline? [Y/n/modify]
```

### 4.4 Review & Approve
```
> Y
```

### 4.5 Compilation
```
Compiling manifest...
✓ Generated fingerprint: 7a3f9c2e-1b4d-4e8f-9a2c-5d6e7f8a9b0c
✓ Manifest saved: examples/manifests/category_performance_20240315_143022.yaml
✓ Manifest is deterministic and reproducible
```

**What happens behind the scenes:**
- Osiris creates a YAML manifest with all pipeline steps
- Generates a unique fingerprint for reproducibility
- Validates manifest structure
- Saves to manifests directory

### 4.6 Inspect the Manifest (Optional)
```bash
cat examples/manifests/category_performance_20240315_143022.yaml
```

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

### 4.7 Execute the Pipeline
```bash
osiris run examples/manifests/category_performance_20240315_143022.yaml
```

**Execution output:**
```
Starting pipeline execution...
Fingerprint: 7a3f9c2e-1b4d-4e8f-9a2c-5d6e7f8a9b0c

[1/5] Extracting data...
  ✓ sales_extractor: 1,234 rows read
  ✓ products_extractor: 45 rows read

[2/5] Cleaning data...
  ✓ clean_sales: 1,211 rows (23 filtered)

[3/5] Joining datasets...
  ✓ join_data: 1,211 rows joined

[4/5] Computing revenue...
  ✓ calculate_revenue: revenue column added

[5/5] Aggregating results...
  ✓ aggregate_results: 12 categories × regions

[6/6] Writing output...
  ✓ output_writer: examples/data-out/category_performance.csv

Pipeline completed successfully in 1.87s
```

### 4.8 Verify Results
```bash
cat examples/data-out/category_performance.csv
```

```csv
category,region,total_revenue,order_count,avg_order_value
Electronics,North America,15789.45,234,67.47
Electronics,Europe,12450.80,156,79.81
Electronics,Asia Pacific,9823.10,143,68.69
Furniture,North America,8920.30,89,100.23
Furniture,Europe,7234.50,72,100.48
...
```

### 4.9 View Interactive Reports
```bash
osiris logs html --open
```

**What opens:**
- Interactive HTML dashboard
- Execution timeline
- Data flow visualization
- Row counts at each step
- Performance metrics
- Error logs (if any)

### 4.10 Access AI-Readable Output
```bash
osiris logs aiop --last
```

**AIOP (AI Operation Package) contains:**
- Structured execution summary
- Data quality metrics
- Anomaly detection results
- LLM-friendly analysis format

---

## Phase 5: Understanding What Happened (15 minutes)

### 5.1 The Osiris Magic Explained

**Step-by-Step Breakdown:**

1. **Natural Language Parsing**
   - Your English description → Structured intent
   - Identified: sources, operations, destination

2. **Data Source Interrogation**
   - Read file headers
   - Inferred schema
   - Detected data types
   - Identified potential issues

3. **Pipeline Generation**
   - Created extraction steps
   - Planned transformations
   - Determined optimal join strategy
   - Configured aggregation logic

4. **Deterministic Compilation**
   - Generated YAML manifest
   - Created fingerprint
   - Made reproducible

5. **Execution**
   - Loaded data into memory
   - Applied transformations sequentially
   - Wrote results to CSV

### 5.2 Reproducibility Guarantee

**Run it again:**
```bash
osiris run examples/manifests/category_performance_20240315_143022.yaml
```

**Result:** Identical output, same fingerprint, guaranteed behavior

**Run on E2B cloud:**
```bash
osiris run examples/manifests/category_performance_20240315_143022.yaml --e2b
```

**Result:** Same output, cloud execution, <1% overhead

### 5.3 Modifying the Pipeline

**Option 1: Conversational modification**
```bash
osiris chat --manifest examples/manifests/category_performance_20240315_143022.yaml
```

```
> Add a filter to only include orders from 2024
```

Osiris will:
- Load existing manifest
- Apply your modification
- Generate new manifest with new fingerprint

**Option 2: Manual YAML editing**
- Edit the manifest file directly
- Add/modify steps
- Re-run with `osiris run`

### 5.4 Key Takeaways

✓ **No code required** for basic pipelines
✓ **Deterministic** - same input = same output
✓ **Reproducible** - works everywhere identically
✓ **Transparent** - inspect the manifest to see exactly what happens
✓ **Flexible** - modify through conversation or YAML editing

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

