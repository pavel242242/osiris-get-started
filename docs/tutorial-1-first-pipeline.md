# Tutorial 1: My First Pipeline - E-commerce Analytics

Build a data pipeline to analyze product category performance by region using conversational AI.

**Business Question:** "Which product categories are performing best by region?"

**Time to complete:** 30-45 minutes

**Prerequisites:** Complete [setup.md](setup.md) first

---

## What You'll Learn

- Describe data tasks in natural language
- Watch Claude orchestrate complex pipelines using Osiris MCP tools
- Understand deterministic compilation
- Work with reproducible OML manifests
- Debug and iterate conversationally

---

## Before You Start: Cleanup

If you've run this tutorial before, clean up previous outputs to start fresh:

```bash
# Clean up previous pipeline runs (safe to run anytime)
rm -rf examples/tutorial-1/data-out/*
rm -rf pipelines/*
rm -rf build/*
rm -rf aiop/*
rm -rf run_logs/*

echo "✅ Cleanup complete - ready for fresh start!"
```

---

## Start the Tutorial

**Note:** This is "Session 2" - Session 1 was completing [setup.md](setup.md) to install Osiris.

In your terminal, start Claude Code:

```bash
cd osiris-get-started
claude
```

### Verify MCP Connection

First, check that Osiris MCP tools are available:

```
/mcp
```

You should see `osiris` listed with tools like:
- `osiris_components_list`
- `osiris_oml_schema_get`
- `osiris_oml_validate`
- `osiris_oml_save`
- `osiris_guide_start`
- `osiris_discovery_run`
- `osiris_connections_list`

If you don't see these tools:
1. Check `.claude/settings.local.json` has `"enableAllProjectMcpServers": true`
2. Restart Claude Code
3. See [setup.md](setup.md) troubleshooting section

---

## The Tutorial Prompt

Copy and paste this complete prompt into Claude Code:

```
I've completed the Osiris setup and I'm ready to start Tutorial 1.

I need to analyze which product categories are performing best by region.

I have two CSV files in examples/tutorial-1/data-in/:
- sales_data.csv with transactions (order_id, product_id, region, quantity, price, order_date, customer_id)
- product_catalog.csv with product details (product_id, product_name, category, cost_price)

Can you:
1. Clean the data (remove records with missing product_id)
2. Join sales with product catalog on product_id
3. Calculate total revenue (quantity * price) for each order
4. Aggregate by category and region to show: total_revenue, order_count, avg_order_value
5. Output the results to examples/tutorial-1/data-out/category_performance.csv

IMPORTANT: As you work, please explain:
- Which Osiris MCP tools you're using at each step
- What each tool does
- What the OML pipeline structure looks like
- How the deterministic compilation works

I want to understand the process, not just see the results.
```

---

## What Happens Next

Claude will guide you through the process, explaining:

### 1. **Discovery Phase**
- Claude calls `osiris_discovery_run` to analyze your CSV files
- Detects schemas automatically (column names, types)
- Understands data structure without you specifying it

### 2. **Pipeline Design**
- Claude calls `osiris_guide_start` to get OML syntax guidance
- Calls `osiris_oml_schema_get` to understand available components
- Calls `osiris_components_list` to see extractors, processors, writers
- Designs the pipeline steps in OML (Osiris Markup Language)

### 3. **OML Pipeline Creation**
Claude creates an OML file with:
```yaml
version: "0.4.0"
name: "Category Performance Analysis"

pipeline:
  extractors:
    - id: sales_extractor
      type: csv_reader
      config:
        file_path: "examples/tutorial-1/data-in/sales_data.csv"

    - id: products_extractor
      type: csv_reader
      config:
        file_path: "examples/tutorial-1/data-in/product_catalog.csv"

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
        file_path: "examples/tutorial-1/data-out/category_performance.csv"
```

### 4. **Validation**
- Claude calls `osiris_oml_validate` to check syntax
- If errors occur, Claude reads them and fixes automatically
- Re-validates until the OML is correct

### 5. **Save & Execute**
- Claude calls `osiris_oml_save` to save the pipeline
- Osiris compiles it into a deterministic manifest (with fingerprint)
- Pipeline executes: extracts → cleans → joins → computes → aggregates → writes
- AIOP (AI Operation Package) artifacts generated for Claude to analyze

### 6. **Results**
Claude shows you:
```csv
category,region,total_revenue,order_count,avg_order_value
Electronics,North America,1349.88,9,149.99
Electronics,Europe,1049.91,5,209.98
Electronics,Asia Pacific,629.94,4,157.49
Furniture,North America,799.96,5,159.99
Furniture,Europe,599.97,4,149.99
Furniture,Asia Pacific,249.98,2,124.99
```

---

## Key Concepts Explained

### Deterministic Compilation
- Same input + same manifest = same output, **always**
- No hidden state, no randomness
- Run on your laptop, colleague's machine, or cloud → identical results

### OML (Osiris Markup Language)
- YAML-based declarative language
- Defines: extractors → processors → writers
- Human-readable and version-controllable
- Created by Claude using MCP tools (you don't write it manually)

### Manifest
- Compiled version of OML with unique fingerprint
- Stored in `build/` directory
- Guarantees reproducible execution
- Contains complete lineage and metadata

### MCP (Model Context Protocol)
- Standard for AI assistants to call tools
- Osiris exposes capabilities as MCP functions
- Claude orchestrates these functions based on your goals

### AIOP (AI Operation Package)
- Machine-readable execution data
- Includes row counts, metrics, data quality info
- Claude analyzes this to provide insights

---

## Exploring Further

Once the pipeline runs successfully, try these follow-ups:

### Ask Claude to Show You:

```
Can you show me the OML pipeline that was created?
```

```
Show me the execution logs and explain what happened at each step
```

```
What's in the AIOP artifacts? What insights can you derive?
```

### Modify the Pipeline:

```
Can you modify the analysis to:
1. Only include orders from January 2024
2. Add a filter for orders over $50
3. Sort results by total_revenue descending
```

### Compare Results:

```
How do the results differ from the original analysis?
```

### Save for Reuse:

```
Save this pipeline as "high_value_jan_analysis" so I can run it again later
```

---

## What You've Accomplished

✅ Built your first data pipeline using natural language
✅ Watched Claude use Osiris MCP tools to orchestrate complex tasks
✅ Understood how OML pipelines are structured
✅ Learned about deterministic compilation and reproducibility
✅ Saw how to iterate and improve pipelines conversationally

---

## Common Issues

### Issue: "No MCP servers configured"

**Fix:**
```bash
# Check configuration
cat .mcp.json
cat .claude/settings.local.json

# If missing, re-run setup
# See docs/setup.md
```

### Issue: "FileNotFoundError: sales_data.csv"

**Fix:**
Tell Claude: "The files are in examples/tutorial-1/data-in/, please update the paths"

### Issue: "Column 'product_id' not found"

**Fix:**
Claude will inspect the datasets and fix column references automatically. Just wait for it to retry.

### Issue: OML Validation Failed

**Fix:**
Claude will read the error, fix the syntax, and retry automatically. This is normal - Osiris provides detailed error messages that Claude understands.

---

## Next Steps

🎉 **Congratulations!** You've completed your first Osiris pipeline.

**What's next?**

1. **Tutorial 2:** [Data Quality & Validation](tutorial-2-data-quality.md) - Add validation rules and error handling
2. **Tutorial 3:** [Database Integration](tutorial-3-databases.md) - Connect to PostgreSQL/MySQL
3. **Tutorial 4:** [Scheduled Pipelines](tutorial-4-scheduling.md) - Automate your workflows

Return to [README.md](../README.md) to choose your next tutorial.

---

## Additional Experiments

Try these on your own:

**Export to different format:**
```
Also export the results as JSON
```

**Add data quality checks:**
```
Add validation to ensure price is always positive and less than $10,000
```

**Create a summary report:**
```
Create a summary showing just the top 3 performing categories overall
```

**Handle errors gracefully:**
```
If there are any data quality issues, save problem records to errors.csv
instead of failing the whole pipeline
```

**Work with your own data:**
```
I have my own sales data in [path]. Can you adapt this pipeline for my data?
```

---

**Need help?** Open an issue on [GitHub](https://github.com/pavel242242/osiris-get-started/issues)
