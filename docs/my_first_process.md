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

**Important:** This tutorial uses a **two-session approach**:
- **Session 1** (Setup): Install Osiris and run the MCP server
- **Session 2** (Tutorial): Use Claude to build pipelines through conversation

### Session 1: Installation and MCP Server Setup

**Step 1: Clone This Tutorial Repository**

```bash
git clone https://github.com/[user]/osiris-get-started.git
cd osiris-get-started
```

**Step 2: Install Osiris**

```bash
# Create virtual environment
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Clone Osiris repository
git clone https://github.com/keboola/osiris.git /tmp/osiris-repo

# Install Osiris in editable mode
pip install -e /tmp/osiris-repo

# Install MCP SDK (required dependency)
pip install mcp
```

**✓ Checkpoint: Verify Installation**
```bash
# Confirm Osiris is installed
osiris --version          # Should show: Osiris v0.5.0 or similar
which osiris              # Should show path in .venv/bin/

# If "command not found", check venv is activated (look for (.venv) in prompt)
```

**Step 3: Initialize Osiris Project**

```bash
osiris init
```

This creates the project structure and configuration files:
- `osiris.yaml` - Filesystem contract configuration
- `pipelines/` - Where pipeline definitions are stored
- `build/` - Compiled manifests
- `aiop/` - AI Operation Package artifacts
- `run_logs/` - Execution logs

**✓ Checkpoint: Verify Project Structure**
```bash
# Confirm initialization worked
ls -la osiris.yaml                    # Should exist
ls -la pipelines/ build/ aiop/        # Directories should exist

# If missing, run: osiris init
```

**Copy component definitions:**

```bash
# Copy components from the cloned Osiris repo
cp -r /tmp/osiris-repo/components .
```

**✓ Checkpoint: Verify Components**
```bash
# Confirm components were copied
ls -la components/                    # Should show directories
osiris components list | head -5      # Should list available components

# If empty, the copy failed - check /tmp/osiris-repo exists
```

**Step 4: Register Osiris MCP Server with Claude Code**

Use the `claude mcp add` command to register Osiris:

```bash
claude mcp add osiris
```

This will create `.mcp.json` with the Osiris MCP server configuration. Claude Code will automatically launch the server when needed.

Alternatively, you can manually create `.mcp.json`:

```json
{
  "mcpServers": {
    "osiris": {
      "command": "/bin/bash",
      "args": [
        "-lc",
        "source .venv/bin/activate && python -m osiris.cli.mcp_entrypoint"
      ]
    }
  }
}
```

**Step 5: Enable MCP Server Auto-Approval**

Add MCP server approval to `.claude/settings.local.json`. If the file doesn't exist, create it:

```json
{
  "enableAllProjectMcpServers": true
}
```

If the file already exists, add the `enableAllProjectMcpServers` setting to the existing JSON:

```json
{
  "permissions": {
    "allow": [...]
  },
  "enableAllProjectMcpServers": true
}
```

This ensures the Osiris MCP server is automatically enabled when you start Session 2.

**✓ Checkpoint: Verify MCP Configuration**
```bash
# Confirm MCP is configured
cat .mcp.json                         # Should show osiris config
grep "enableAllProjectMcpServers" .claude/settings.local.json  # Should return true

# Test MCP JSON syntax
python3 -c "import json; json.load(open('.mcp.json'))" && echo "✓ Valid JSON" || echo "✗ Invalid JSON"
```

**Step 6: Session 1 Setup Complete**

You've now completed the setup phase:
- ✅ Osiris installed
- ✅ Project initialized
- ✅ Components available
- ✅ MCP server registered
- ✅ Auto-approval enabled

Close this session/terminal and proceed to Session 2 for the tutorial.

---

### Session 2: Tutorial (Use a New Claude Code Session)

In a **new terminal window**, start a fresh Claude Code session:

```bash
cd osiris-get-started
claude
```

**Understanding MCP (Quick Primer):**

MCP (Model Context Protocol) is how Claude talks to Osiris - think of it like an API.
- Claude calls Osiris functions to build pipelines
- You describe what you want in natural language
- Claude uses MCP tools behind the scenes

**Verify Osiris MCP Server:**

Check that Osiris is connected:
```
/mcp
```

You should see "osiris" listed with tools like `osiris_oml_validate`, `osiris_components_list`, etc.

If you see "No MCP servers configured":
- Check `.claude/settings.local.json` has `"enableAllProjectMcpServers": true`
- Restart Claude Code

**Initial Prompt for Session 2:**

Once MCP tools are verified, use this simple prompt:

```
I'm ready to start the Osiris tutorial. Can you verify Osiris MCP tools are working?
```

Claude should confirm tools are available and ask what you'd like to build.

**Expected Response:**

`/mcp` should show the Osiris server is running with tools available.

**MCP Tools Reference (What Claude Uses):**

You'll see Claude call these automatically - you don't need to call them yourself:

- **osiris_components_list** - Shows available extractors/processors/writers (csv, sql, etc.)
- **osiris_oml_schema_get** - Gets OML syntax documentation so Claude knows correct format
- **osiris_oml_validate** - Checks that OML pipeline syntax is correct
- **osiris_oml_save** - Saves an OML pipeline to pipelines/ directory
- **osiris_guide_start** - Gets guidance on building OML pipelines
- **osiris_discovery_run** - Analyzes data sources to detect schemas automatically
- **osiris_connections_list** - Lists database connections (if configured)

If tools are available, you're ready to proceed with Part 1!

---

## Part 1: Your First Pipeline (15 minutes)

### The Business Problem

You have two CSV files:
- `sales_data.csv` - Transaction records (30 rows with intentional data quality issues)
- `product_catalog.csv` - Product information (10 products)

You need to answer: **Which product categories perform best by region?**

### The Data

The tutorial includes sample CSV files:
- `examples/data-in/sales_data.csv` - 30 transaction records with intentional data quality issues (some missing `product_id` values)
- `examples/data-in/product_catalog.csv` - 10 product records with category information

**Note:** You don't need to manually inspect these files. Claude will use Osiris MCP tools to discover the schema and handle the data for you.

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

### Watch Claude Work with Osiris MCP Tools

Claude will use **Osiris MCP tools** to build and execute your pipeline. Here's what happens behind the scenes:

1. **Understand your goal:**
   - Claude interprets your natural language request
   - Identifies the data sources (CSV files)
   - Plans the transformation steps needed

2. **Use MCP tools to build the pipeline:**
   - `osiris_guide_start` - Get guidance on building the OML pipeline
   - `osiris_oml_schema_get` - Understand OML syntax and available components
   - `osiris_components_list` - See what extractors, processors, and writers are available

3. **Create the OML pipeline definition:**
   - Claude writes an OML (Osiris Markup Language) file describing:
     - Extract: Read both CSV files
     - Clean: Filter out rows with null product_id
     - Join: Combine sales with product catalog on product_id
     - Compute: Calculate revenue = quantity * price
     - Aggregate: GROUP BY category, region with SUM, COUNT, AVG
     - Write: Output to category_performance.csv

4. **Validate and save:**
   - `osiris_oml_validate` - Check the pipeline syntax
   - `osiris_oml_save` - Save the validated pipeline

5. **Execute the pipeline:**
   - Claude orchestrates the execution (via `osiris run` command)
   - You'll see results: extracted rows, transformations applied, output written
   - AIOP (AI Operation Package) artifacts are generated for Claude to analyze

**You just describe what you want - Claude orchestrates everything through Osiris MCP tools and handles execution!**

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

### The Generated OML Pipeline

**Ask Claude:**
```
Can you show me the OML pipeline that was created?
```

Claude will show you the OML (Osiris Markup Language) file. Here's what an OML pipeline looks like (with annotations):

```yaml
version: "0.4.0"
fingerprint: "7a3f9c2e-1b4d-4e8f-9a2c-5d6e7f8a9b0c"  # Unique ID for this pipeline
name: "Category Performance Analysis"

pipeline:
  # EXTRACTORS: Read data from sources
  extractors:
    - id: sales_extractor               # Read sales transactions
      type: csv_reader
      config:
        file_path: "examples/data-in/sales_data.csv"

    - id: products_extractor            # Read product catalog
      type: csv_reader
      config:
        file_path: "examples/data-in/product_catalog.csv"

  # PROCESSORS: Transform the data step-by-step
  processors:
    - id: clean_sales                   # Remove rows with missing product_id
      type: filter
      input: sales_extractor
      config:
        condition: "product_id IS NOT NULL"

    - id: join_data                     # Combine sales with product info
      type: join
      inputs: [clean_sales, products_extractor]
      config:
        join_type: "left"               # Keep all sales, add product details
        on: "product_id"

    - id: calculate_revenue             # Add new column: revenue
      type: compute
      input: join_data
      config:
        new_column: "revenue"
        expression: "quantity * price"  # Calculate revenue per order

    - id: aggregate_results             # Group and summarize
      type: aggregate
      input: calculate_revenue
      config:
        group_by: ["category", "region"]  # Group by category and region
        aggregations:
          - {function: "sum", column: "revenue", alias: "total_revenue"}
          - {function: "count", column: "*", alias: "order_count"}
          - {function: "avg", column: "revenue", alias: "avg_order_value"}

  # WRITERS: Output the results
  writers:
    - id: output_writer                 # Write final results to CSV
      type: csv_writer
      input: aggregate_results
      config:
        file_path: "examples/data-out/category_performance.csv"
```

**You never write this yourself - Claude generates it using Osiris MCP tools.**

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
│   └── data-out/
│       └── category_performance.csv # Generated output
├── pipelines/
│   └── [your_pipeline].oml.yaml    # OML pipeline definitions (created by Claude)
├── build/
│   └── [fingerprint].yaml          # Compiled manifests (generated by Osiris)
├── aiop/
│   └── [session_id]/               # AI Operation Package artifacts
├── run_logs/
│   └── [execution_logs]            # Detailed execution logs
└── docs/
    └── my_first_process.md         # This tutorial
```

**Note:** Claude uses Osiris MCP tools to create OML files in `pipelines/`, which Osiris compiles into deterministic manifests in `build/`.

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
- Use `osiris_oml_validate` to load the existing OML pipeline
- Apply your modifications to the OML definition
- Validate the updated pipeline
- Save it with `osiris_oml_save`
- Execute the new version
- Show you the updated results

### Compare Results

**Ask Claude:**
```
How do the results differ from the original analysis?
```

Claude will read the output files and compare the two analyses, highlighting key differences.

### Save for Later

**Ask Claude:**
```
Save this pipeline as "high_value_jan_analysis" so I can run it again later
```

Claude will use `osiris_oml_save` to save the OML pipeline with a descriptive name in `pipelines/`.

---

## Part 4: Next Steps (5 minutes)

### What You've Learned

✅ Describing data goals in natural language
✅ Watching Claude use Osiris MCP tools to orchestrate pipelines
✅ Understanding OML (Osiris Markup Language) pipeline definitions
✅ Inspecting and modifying pipelines conversationally
✅ Building data pipelines without writing code

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

## What Can Go Wrong? (Common Errors)

This section shows **expected errors** and how to fix them. Don't panic - these are normal!

### Error 1: "No MCP servers configured"

**What you see:**
```
/mcp
No MCP servers configured.
```

**What this means:** Claude Code hasn't loaded the Osiris MCP server.

**How to fix:**
```bash
# 1. Check .mcp.json exists
cat .mcp.json

# 2. Check settings allow MCP servers
grep "enableAllProjectMcpServers" .claude/settings.local.json

# 3. Restart Claude Code
exit
claude
```

---

### Error 2: "FileNotFoundError: sales_data.csv"

**What you see:**
```
Error: FileNotFoundError: [Errno 2] No such file or directory: 'examples/data-in/sales_data.csv'
```

**What this means:** The data files aren't where Osiris expects them.

**How to fix:**
```bash
# Verify files exist
ls -la examples/data-in/sales_data.csv
ls -la examples/data-in/product_catalog.csv

# If missing, you didn't clone the tutorial repo correctly
```

Tell Claude: "The files are at a different location: [actual path]" and it will update the OML.

---

### Error 3: "Component 'csv_reader' not found"

**What you see:**
```
Error: Unknown component type: csv_reader
```

**What this means:** The components directory wasn't copied.

**How to fix:**
```bash
# Check components exist
osiris components list

# If empty, copy components again
cp -r /tmp/osiris-repo/components .
```

---

### Error 4: OML Validation Failed

**What you see:**
Claude says: "OML validation failed: Invalid syntax at line X"

**What this means:** The OML Claude created has a syntax error.

**How to fix:**
- Claude will automatically read the error and fix it
- Just wait - Claude will call `osiris_oml_validate` again with corrected OML
- This is a normal part of the iterative process

---

## Troubleshooting

### Issue: "Can't find Osiris MCP tools"

**Solution:**
- Check `/mcp` to see if Osiris is listed
- Ensure `.mcp.json` exists in project root
- Verify `.claude/settings.local.json` has `"enableAllProjectMcpServers": true`
- Restart Claude Code session (exit and run `claude` again)
- Check that `osiris init` was run (look for `osiris.yaml` file)

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

### OML (Osiris Markup Language)
- YAML-based language for defining data pipelines
- Created by Claude using Osiris MCP tools
- Contains extractors, processors, writers
- Stored in `pipelines/` directory
- Human-readable and editable

### Manifest
- Compiled, deterministic version of OML pipeline
- Generated by Osiris compiler from OML
- Has a unique fingerprint
- Stored in `build/` directory
- Guarantees reproducible execution

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
