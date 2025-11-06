# Tutorial Session Prompts

This file contains ready-to-use prompts for each tutorial. Copy and paste these into Claude Code after completing setup.

---

## Tutorial 1: My First Pipeline - E-commerce Analytics

**Before starting:**
1. Complete [docs/setup.md](docs/setup.md)
2. Start Claude Code: `claude`
3. Verify MCP connection: `/mcp`

**Copy this prompt:**

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

## Tutorial 2: Data Quality & Validation (Coming Soon)

**Prerequisite:** Complete Tutorial 1

**Copy this prompt:**

```
I've completed Tutorial 1 and I'm ready for Tutorial 2.

Please follow the guide in docs/tutorial-2-data-quality.md.

Focus on explaining:
- How to add validation rules to pipelines
- Error handling patterns
- Quality metrics and logging
```

---

## Tutorial 3: Database Integration (Coming Soon)

**Prerequisite:** Complete Tutorial 1

**Copy this prompt:**

```
I've completed Tutorial 1 and I'm ready for Tutorial 3.

Please follow the guide in docs/tutorial-3-databases.md.

Focus on explaining:
- How to configure database connections
- SQL extractors and incremental loading
- Best practices for database pipelines
```

---

## Tutorial 4: Scheduled Pipelines (Coming Soon)

**Prerequisite:** Complete Tutorials 1-3

**Copy this prompt:**

```
I've completed Tutorials 1-3 and I'm ready for Tutorial 4.

Please follow the guide in docs/tutorial-4-scheduling.md.

Focus on explaining:
- Pipeline scheduling and automation
- Parameterization
- Monitoring and notifications
```

---

## Tutorial 5: Custom Components (Coming Soon)

**Prerequisite:** Complete all previous tutorials

**Copy this prompt:**

```
I've completed all previous tutorials and I'm ready for Tutorial 5.

Please follow the guide in docs/tutorial-5-custom-components.md.

Focus on explaining:
- Osiris component architecture
- How to build custom extractors, processors, and writers
- Testing and contributing components
```

---

## General Troubleshooting Prompt

If you encounter issues during any tutorial, use this prompt:

```
I'm having trouble with [describe issue].

Can you:
1. Check the Osiris configuration and project structure
2. Verify MCP connection status
3. Review recent error logs
4. Suggest fixes based on common issues in docs/setup.md
```

---

## Quick Cleanup Prompt

Use this before starting any tutorial fresh:

```
Can you clean up all previous tutorial outputs and pipeline runs?

Remove contents from:
- examples/*/data-out/
- pipelines/
- build/
- aiop/
- run_logs/

This will give me a clean slate for the tutorial.
```

---

## Tips for Using These Prompts

1. **Always verify MCP connection first** with `/mcp` before starting a tutorial
2. **Read the tutorial guide** alongside using the prompt for full context
3. **Ask follow-up questions** - Claude can explain any step in more detail
4. **Experiment** - Modify the prompts to explore different approaches
5. **Save your pipelines** - Ask Claude to save interesting pipeline variations

---

## Customizing Prompts

Feel free to modify these prompts to:
- Focus on specific aspects you want to learn
- Use your own data instead of sample data
- Combine multiple tutorials
- Deep dive into particular components

Example customization:
```
I've completed Tutorial 1, but I want to:
- Use my own sales data from [path]
- Add custom business logic for [specific requirement]
- Export to both CSV and JSON formats

Please adapt the Tutorial 1 approach for my use case and explain the differences.
```
