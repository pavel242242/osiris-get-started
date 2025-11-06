# My First Osiris Process: E-commerce Analytics

## What You'll Build

In this tutorial, you'll solve a real business problem using Osiris - a deterministic data pipeline compiler that you interact with through Claude or other AI assistants.

**Business Question:**
> "Which product categories are performing best by region?"

**What makes this different:**
- You describe what you need in plain English
- Claude (or your AI assistant) uses Osiris to build and execute the pipeline
- Osiris generates reproducible, deterministic data manifests
- You get results with full transparency into what happened

**Time to complete:** 30-45 minutes

---

## How This Works

Traditional data engineering:
```
YOU → Write code → Test → Debug → Run → Get results
```

With Osiris + Claude:
```
YOU → Describe goal → CLAUDE uses OSIRIS → Get results
```

**Your role:**
- Describe business goals in natural language
- Observe and validate what happens
- Guide the process with feedback

**Claude's role:**
- Interprets your goal
- Uses Osiris MCP tools to build pipelines
- Executes and reports results

**Osiris's role:**
- Generates deterministic, reproducible manifests
- Executes pipelines locally or in cloud
- Provides transparent logs and reports

---

## Prerequisites

**What you need:**
- **Python 3.9+** installed
- **An MCP client** (choose one):
  - **Claude Code** (recommended for this tutorial) - CLI from Anthropic
  - **Claude Desktop** - GUI with MCP support
  - **Cursor** - AI-powered IDE
  - **Windsurf** - AI code editor
  - Other MCP-compatible tools

**What you'll learn:**
- How to describe data tasks in natural language
- Watching AI orchestrate complex pipelines
- Understanding deterministic compilation
- Working with reproducible manifests
- Debugging and iterating conversationally

---

## Setup

### Step 1: Clone This Tutorial Repository

```bash
git clone https://github.com/[user]/osiris-get-started.git
cd osiris-get-started
```

### Step 2: Install Osiris

```bash
# Create virtual environment
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install Osiris
pip install -r requirements.txt
```

### Step 3: Initialize Osiris as MCP Server

```bash
python -m osiris init
```

This sets up Osiris as an MCP (Model Context Protocol) server that Claude can use.

### Step 4: Verify Setup with Your AI Assistant

**Using Claude Code:**
```bash
claude
```

**Using Claude Desktop:**
- Open Claude Desktop
- Navigate to this folder

**Then ask:**
```
Can you check if Osiris is available?
```

Claude should confirm that Osiris MCP tools are accessible and ready.

---

## Part 1: Your First Pipeline (15 minutes)

### The Business Problem

You have two CSV files:
- `sales_data.csv` - Transaction records (30 rows with intentional data quality issues)
- `product_catalog.csv` - Product information (10 products)

You need to answer: **Which product categories perform best by region?**

### The Data

**Peek at the files:**

```bash
head -5 examples/data-in/sales_data.csv
```

```csv
order_id,product_id,region,quantity,price,order_date,customer_id
1001,P101,North America,2,29.99,2024-01-15,C501
1002,P205,Europe,1,149.99,2024-01-15,C502
1003,P101,North America,5,29.99,2024-01-16,C503
1004,,Asia Pacific,3,79.99,2024-01-16,C504
```

**Notice:** Row 1004 has a missing `product_id` - intentional data quality issue!

```bash
head -5 examples/data-in/product_catalog.csv
```

```csv
product_id,product_name,category,cost_price
P101,Wireless Mouse,Electronics,15.00
P205,Mechanical Keyboard,Electronics,75.00
P340,Office Chair,Furniture,120.00
P450,Desk Lamp,Furniture,35.00
```

### Describe Your Goal to Claude

**Open your AI assistant and say:**

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

### Watch Claude Work

Claude will:

1. **Inspect the data:**
```
Let me first examine your data files...

Found:
- examples/data-in/sales_data.csv: 30 rows, 7 columns
- examples/data-in/product_catalog.csv: 10 rows, 4 columns
- Detected 3 rows with missing product_id (will be filtered out)
```

2. **Generate a pipeline:**
```
I'll create a pipeline with these steps:
1. Extract: Read both CSV files
2. Clean: Filter out rows with null product_id
3. Join: LEFT JOIN sales → products on product_id
4. Compute: Calculate revenue = quantity * price
5. Aggregate: GROUP BY category, region with SUM, COUNT, AVG
6. Write: Output to category_performance.csv

Creating manifest...
```

3. **Execute:**
```
Executing pipeline...

✓ Extracted 30 sales records
✓ Extracted 10 product records
✓ Filtered to 27 valid sales records (removed 3 with missing product_id)
✓ Joined sales with product catalog
✓ Calculated revenue for 27 orders
✓ Aggregated to 6 category-region combinations
✓ Wrote results to examples/data-out/category_performance.csv

Pipeline completed in 1.23s
```

### View the Results

**Ask Claude:**
```
Can you show me the output?
```

**Claude displays:**
```csv
category,region,total_revenue,order_count,avg_order_value
Electronics,North America,1349.88,9,149.99
Electronics,Europe,1049.91,5,209.98
Electronics,Asia Pacific,629.94,4,157.49
Furniture,North America,799.96,5,159.99
Furniture,Europe,599.97,4,149.99
Furniture,Asia Pacific,249.98,2,124.99
```

### Request Analysis

**Ask Claude:**
```
Which category has the highest average order value?
```

**Claude responds:**
```
Electronics in Europe has the highest average order value at $209.98,
followed by Electronics in North America at $149.99.

This suggests that European customers tend to purchase higher-value
electronics items, possibly keyboards and hubs rather than just mice.
```

---

## Part 2: Understanding What Happened (10 minutes)

### The Generated Manifest

**Ask Claude:**
```
Can you show me the manifest that was generated?
```

Claude will display the YAML manifest Osiris created. Here's a simplified view:

```yaml
version: "0.4.0"
fingerprint: "7a3f9c2e-1b4d-4e8f-9a2c-5d6e7f8a9b0c"
name: "Category Performance Analysis"

pipeline:
  extractors:
    - id: sales_extractor
      type: csv_reader
      config:
        file_path: "examples/data-in/sales_data.csv"

    - id: products_extractor
      type: csv_reader
      config:
        file_path: "examples/data-in/product_catalog.csv"

  processors:
    - id: clean_sales
      type: filter
      input: sales_extractor
      config:
        condition: "product_id IS NOT NULL"

    - id: join_data
      type: join
      inputs: [clean_sales, products_extractor]
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
        group_by: ["category", "region"]
        aggregations:
          - {function: "sum", column: "revenue", alias: "total_revenue"}
          - {function: "count", column: "*", alias: "order_count"}
          - {function: "avg", column: "revenue", alias: "avg_order_value"}

  writers:
    - id: output_writer
      type: csv_writer
      input: aggregate_results
      config:
        file_path: "examples/data-out/category_performance.csv"
```

**Key points:**
- **Deterministic:** Same input = same output, always
- **Fingerprint:** Unique identifier for this exact pipeline configuration
- **Readable:** YAML format you can understand and modify
- **Reproducible:** Run this manifest anywhere with identical results

### The Three-Layer System

```
┌─────────────────┐
│  YOU (User)     │  "Analyze category performance..."
└────────┬────────┘
         │ Natural language
         ▼
┌─────────────────┐
│  CLAUDE         │  Interprets goal, calls Osiris MCP tools
│  (MCP Client)   │  Presents results and insights
└────────┬────────┘
         │ MCP function calls
         ▼
┌─────────────────┐
│  OSIRIS         │  Generates deterministic manifests
│  (Compiler)     │  Executes pipelines, logs everything
└─────────────────┘
```

### Where Files Live

```
osiris-get-started/
├── examples/
│   ├── data-in/
│   │   ├── sales_data.csv          # Your input data
│   │   └── product_catalog.csv     # Your input data
│   ├── data-out/
│   │   └── category_performance.csv # Generated output
│   └── manifests/
│       └── [fingerprint].yaml       # Generated by Osiris
├── .osiris/
│   ├── config.yaml                  # Osiris configuration
│   ├── profiles/                    # Credential profiles
│   └── logs/                        # Execution logs
└── docs/
    └── my_first_process.md          # This tutorial
```

---

## Part 3: Iterate and Improve (10 minutes)

### Modify the Pipeline

**Ask Claude:**
```
Can you modify the analysis to:
1. Only include orders from January 2024
2. Add a filter for orders over $50
3. Sort results by total_revenue descending
```

**Claude will:**
- Load the existing manifest
- Apply your modifications
- Generate a new manifest with updated fingerprint
- Execute the new version
- Show you the updated results

### Compare Results

**Ask Claude:**
```
How do the results differ from the original analysis?
```

Claude will compare the two outputs and highlight changes.

### Save for Later

**Ask Claude:**
```
Save this manifest as "high_value_jan_analysis.yaml" so I can run it again later
```

Claude will save the manifest to `examples/manifests/` with a descriptive name.

---

## Part 4: Next Steps (5 minutes)

### What You've Learned

✅ Describing data goals in natural language
✅ Watching AI orchestrate Osiris pipelines
✅ Understanding deterministic compilation
✅ Inspecting and modifying manifests
✅ Iterating conversationally

### Try These Next

**1. Add data quality checks:**
```
Add validation to ensure price is always positive and less than $10,000
```

**2. Export to different format:**
```
Also export the results as JSON
```

**3. Create a summary report:**
```
Create a summary showing just the top 3 performing categories overall
```

**4. Handle errors gracefully:**
```
If there are any data quality issues, save problem records to errors.csv
instead of failing the whole pipeline
```

### Explore Advanced Features

**Working with databases:**
```
I need to extract data from my PostgreSQL database instead of CSV
```

**Custom transformations:**
```
I need a custom processor that calculates customer lifetime value
```

**Scheduled execution:**
```
I want this pipeline to run automatically every morning at 2 AM
```

**Real-time processing:**
```
Can we process data as it arrives instead of in batch?
```

---

## Troubleshooting

### Issue: "Can't find Osiris MCP tools"

**Solution:**
- Ensure you ran `python -m osiris init`
- Restart your AI assistant (Claude Code, Claude Desktop, etc.)
- Check that `.osiris/config.yaml` exists

### Issue: "FileNotFoundError for CSV"

**Solution:**
Tell Claude about the error. Claude will:
- Check if the file exists
- Verify your working directory
- Suggest the correct path

### Issue: "Column not found in join"

**Solution:**
Tell Claude: "The pipeline failed with Column 'product_id' not found"

Claude will:
- Inspect both datasets
- Show you the actual column names
- Fix the manifest with correct references

### General Debugging

**Ask Claude:**
```
Run the pipeline with verbose logging
```

```
Show me the execution logs from the last run
```

```
Save intermediate results after each step so we can debug
```

---

## Key Concepts Reference

### Deterministic Compilation
- Same input → Same output, always
- No hidden state or randomness
- Reproducible across environments

### Manifest
- YAML file defining your pipeline
- Contains extractors, processors, writers
- Has a unique fingerprint
- Version controlled like code

### MCP (Model Context Protocol)
- Standard for AI assistants to call tools
- Osiris exposes capabilities as MCP functions
- Claude (or other AI) orchestrates these functions

### AIOP (AI Operation Package)
- Machine-readable execution data
- Includes row counts, data quality metrics, lineage
- AI assistants can analyze this automatically

### Profiles
- Secure credential storage
- Reusable across pipelines
- Support environment variables

---

## Additional Resources

### Documentation
- [Osiris User Guide](link) - Complete reference
- [Architecture Overview](link) - How Osiris works
- [MCP Integration Guide](link) - Using Osiris with AI assistants
- [llms.txt](link) - AI-friendly documentation

### Example Projects
Ask Claude to help you build:
- Customer segmentation pipeline
- Ad spend monitoring with alerts
- Churn prediction data mart
- Inventory forecasting pipeline

### Get Help
- **GitHub Issues:** Report bugs or request features
- **Discussions:** Ask questions, share patterns
- **Contributing:** Submit custom components

---

## Summary

You've just built your first data pipeline using Osiris - by describing what you wanted in plain English and letting Claude handle the technical details.

**What's powerful about this approach:**
- No need to write boilerplate code
- Deterministic and reproducible by default
- Full transparency into what happens
- Easy to iterate and modify
- Works the same way locally or in cloud

**What you can build next:**
- Connect to real databases
- Process larger datasets
- Create custom transformations
- Schedule automated runs
- Build production data pipelines

**Remember:** You're always in control. Ask Claude to show you what it's doing, inspect the manifests, and modify anything you want.

Now go build something amazing! 🚀
