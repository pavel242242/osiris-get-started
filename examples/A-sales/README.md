# Example A: Sales Revenue Analysis

Welcome to your first Osiris pipeline! This example will walk you through building a complete data pipeline that analyzes sales data from two CSV files.

## Business Scenario

You're a business analyst at an e-commerce company. You have quarterly sales data exported from your order management system. Your goal is to:
1. Combine Q1 and Q2 sales data
2. Clean and validate the data
3. Calculate total revenue by product category
4. Export the results for further analysis

This is a common real-world scenario - combining multiple data sources, transforming them, and producing insights.

## What You'll Build

A pipeline that:
- **Loads** two CSV files (`sales_q1.csv` and `sales_q2.csv`)
- **Cleans** the data (handles types, nulls, duplicates)
- **Joins** the datasets together
- **Computes** total revenue per category (quantity × unit_price, aggregated by category)
- **Outputs** results to a Parquet file

## The Data

Both CSV files contain sales transactions with these columns:
- `order_id` - Unique order identifier
- `order_date` - Date of the order
- `product_name` - Name of the product
- `category` - Product category (Electronics, Furniture, Accessories)
- `quantity` - Number of items ordered
- `unit_price` - Price per item
- `region` - Sales region (North America, Europe, Asia)
- `customer_id` - Customer identifier

**Sample data**: 71 orders across Q1 and Q2 2024

## Getting Started

### Prerequisites

Make sure you've completed the [Getting Started Guide](../../getting_started.md):
- ✅ Cloned this repository
- ✅ Installed Osiris in a virtual environment
- ✅ Configured MCP with Claude Desktop or Claude Code
- ✅ Verified Osiris is working (`osiris --version`)

### Using Claude (Recommended)

This is the AI-native approach - let Claude work with Osiris to build your pipeline!

#### Step 1: Open Claude

**Claude Desktop:**
- Make sure Osiris MCP server is connected (check connectors panel)

**Claude Code:**
- Open this workspace in VS Code
- Verify Osiris is connected: run `/mcp` and look for "osiris"

#### Step 2: Use the Starter Prompt

Copy and paste this prompt into Claude:

```
I want to build a sales analysis pipeline using the data in examples/A-sales/data/.

Please:
1. Load sales_q1.csv and sales_q2.csv from examples/A-sales/data/
2. Clean the data: handle any type issues, nulls, or duplicates
3. Combine both datasets
4. Calculate total revenue per category (quantity × unit_price, summed by category)
5. Save the results to outputs/revenue_by_category.parquet

Before writing the pipeline, please:
- Ask me any clarifying questions
- Explain what steps you'll take
- Show me the pipeline structure

Let me review and approve before you create it.
```

#### Step 3: Review and Run

Claude will:
1. Ask clarifying questions (answer based on your preferences)
2. Propose a pipeline structure
3. Validate the pipeline using Osiris tools
4. Help you run it

You can ask Claude to:
- Explain any step in detail
- Modify the pipeline (e.g., filter by region, add more calculations)
- Validate the output
- Debug any issues

## Expected Output

After running the pipeline, you should see a file with revenue aggregated by category.

**Approximate values**:
| category    | total_revenue |
|-------------|---------------|
| Electronics | $95,000+      |
| Furniture   | $45,000+      |
| Accessories | $8,000+       |

## Troubleshooting

**Pipeline fails to load CSV files:**
- Check that you're running from the repository root
- Verify `OSIRIS_HOME` is set correctly
- Confirm the data files exist: `ls examples/A-sales/data/`

**Validation errors:**
- Review the logs: `osiris logs`
- Check for type mismatches in the CSV data
- Verify column names match expectations

**Output not generated:**
- Check the pipeline completed successfully
- Look in `outputs/` directory (create if missing)
- Review execution logs for errors

## Next Steps

Once you've completed this example:

1. **Experiment**: Modify the pipeline to answer different questions
2. **Coming soon**: Example B (Movie Co-actors) and Example C (Logistics Bronze to Gold)

---

**Ready to build?** Use the starter prompt above with Claude!
