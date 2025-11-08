# Example C: Logistics Bronze to Gold

Learn the bronze-silver-gold layered architecture for building production-grade data transformations!

## Business Scenario

You're a data engineer at a logistics company. You need to transform raw operational data into actionable business metrics. Your goal is to:
1. Ingest raw shipment and customer data (bronze layer)
2. Clean, validate, and join the data (silver layer)
3. Calculate business metrics and KPIs (gold layer)
4. Deliver analytics-ready datasets to your BI team

This demonstrates the **medallion architecture** (bronze → silver → gold), a best practice for building scalable, maintainable data pipelines.

## What You'll Build

A multi-layer pipeline that:
- **Bronze**: Loads raw CSV files (shipments, customers, shipping costs)
- **Silver**: Cleans data, removes cancelled orders, adds calculated fields (weight tiers), joins datasets
- **Gold**: Calculates shipping costs, aggregates metrics by customer, produces final analytics dataset
- **Output**: Customer-level shipping metrics ready for BI tools

## The Data

**shipments_raw.csv** (bronze layer):
- `shipment_id` - Unique shipment identifier
- `order_date` - When the order was placed
- `customer_id` - Customer identifier
- `origin`, `destination` - Shipping locations
- `weight_kg` - Package weight
- `status` - delivered, in_transit, or cancelled
- `carrier` - FedEx, UPS, or DHL
- `tracking_number` - Carrier tracking ID

**customers_raw.csv** (bronze layer):
- `customer_id` - Customer identifier
- `customer_name` - Company name
- `customer_type` - enterprise or small_business
- `registration_date` - Account creation date
- `account_status` - active or inactive
- `credit_limit` - Maximum credit allowed

**shipping_costs.csv** (bronze layer):
- `carrier` - Shipping carrier
- `weight_tier` - Weight range (0-20, 20-30, 30+)
- `base_cost` - Fixed cost per shipment
- `cost_per_kg` - Variable cost per kilogram

**Sample data**: 12 shipments across 8 customers with 3 carriers

## Architecture: Bronze → Silver → Gold

This pipeline demonstrates the **medallion architecture**:

1. **Bronze Layer** (Raw):
   - Load data as-is from sources
   - No transformations, preserve original data
   - Useful for auditing and reprocessing

2. **Silver Layer** (Cleaned & Joined):
   - Remove invalid/cancelled records
   - Standardize data types and formats
   - Join related datasets
   - Add calculated fields

3. **Gold Layer** (Business Metrics):
   - Aggregate to business entities (customers)
   - Calculate KPIs and metrics
   - Filter to relevant records (active customers)
   - Produce analytics-ready datasets

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
I want to build a logistics data transformation pipeline (bronze to gold) using the data in examples/C-logistics/data/.

Please create a multi-layer transformation:

Bronze layer (raw data):
1. Load shipments_raw.csv, customers_raw.csv, and shipping_costs.csv

Silver layer (cleaned & joined):
2. Clean shipments: remove cancelled shipments, validate dates
3. Join shipments with customers to get customer details
4. Calculate weight tier for each shipment (0-20, 20-30, 30+)

Gold layer (business metrics):
5. Join with shipping costs based on carrier and weight tier
6. Calculate actual shipping cost for each shipment
7. Aggregate metrics by customer: total shipments, total weight, total cost, avg cost per shipment
8. Filter to active customers only

Output:
- Save gold layer results to outputs/customer_shipping_metrics.parquet

Before writing the pipeline, please:
- Ask me any clarifying questions
- Explain the bronze-silver-gold approach
- Show me the pipeline structure

Let me review and approve before you create it.
```

#### Step 3: Review and Run

Claude will:
1. Ask clarifying questions (answer based on your preferences)
2. Propose a pipeline structure with clear layer separation
3. Validate the pipeline using Osiris tools
4. Help you run it

You can ask Claude to:
- Explain the medallion architecture in detail
- Modify the pipeline (e.g., add delivery time analysis)
- Add data quality checks
- Debug any issues

## Expected Output

After running the pipeline, you should see customer-level shipping metrics.

**Sample results**:
| customer_id | customer_name      | customer_type  | total_shipments | total_weight_kg | total_shipping_cost | avg_cost_per_shipment |
|-------------|-------------------|----------------|-----------------|-----------------|--------------------|-----------------------|
| C101        | Acme Corp         | enterprise     | 3               | 71.5            | $142.50            | $47.50                |
| C102        | Best Buy LLC      | enterprise     | 2               | 50.6            | $101.20            | $50.60                |
| ...         | ...               | ...            | ...             | ...             | ...                | ...                   |

## Troubleshooting

**Pipeline fails to load CSV files:**
- Check that you're running from the repository root
- Verify `OSIRIS_HOME` is set correctly
- Confirm the data files exist: `ls examples/C-logistics/data/`

**Join issues:**
- Verify join keys exist in all datasets
- Check for type mismatches between join columns
- Review the logs: `osiris logs`

**Aggregation errors:**
- Ensure numeric columns (weight, cost) are properly typed
- Check for null values in key fields
- Verify group_by columns exist

**Output not generated:**
- Check the pipeline completed successfully
- Look in `outputs/` directory (create if missing)
- Review execution logs for errors

## Key Concepts

**Bronze-Silver-Gold (Medallion Architecture):**
- Separates concerns across layers
- Makes pipelines easier to debug and maintain
- Allows reprocessing at any layer
- Standard pattern in modern data engineering

**Benefits:**
- **Auditability**: Bronze layer preserves raw data
- **Reusability**: Silver layer can feed multiple gold tables
- **Maintainability**: Changes isolated to specific layers
- **Scalability**: Each layer can be optimized independently

## Next Steps

Once you've completed this example:

1. **Experiment**: Modify the pipeline to:
   - Add delivery time analysis (days from order to delivery)
   - Create separate gold tables for different business questions
   - Add data quality checks (row counts, null percentages)
   - Calculate month-over-month growth metrics

2. **Go deeper**: Try combining Examples A, B, and C patterns in your own projects

---

**Ready to build?** Use the starter prompt above with Claude!
