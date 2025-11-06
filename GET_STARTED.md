# Get Started with Osiris

## Initial Prompt for Claude Code

Use this prompt to get started with the Osiris tutorial:

```
I want to learn Osiris by following the tutorial at:
https://github.com/pavel242242/osiris-get-started

Please:
1. Clone the repository to a clean directory
2. Guide me through the setup process in docs/setup.md
3. Once setup is complete, walk me through Tutorial 1 following docs/tutorial-1-first-pipeline.md

As we go through the tutorial, please explain:
- Which Osiris MCP tools you're using at each step
- What each tool does
- What the OML pipeline structure looks like
- How the deterministic compilation works

I want to understand the process, not just see the results.
```

---

## What This Does

When you use this prompt with Claude Code, it will:

1. **Clone the repository** to a fresh directory
2. **Run the idempotent setup script** from `docs/setup.md`:
   - Create Python 3.11 virtual environment
   - Install `osiris-pipeline` and `mcp` from PyPI
   - Initialize Osiris project
   - Copy component definitions
   - Configure MCP server
   - Set up Claude Code integration

3. **Guide you through Tutorial 1**:
   - Build your first data pipeline
   - Analyze e-commerce category performance by region
   - Learn about OML, MCP tools, and deterministic compilation
   - Get hands-on experience with conversational pipeline building

---

## Time Required

- **Setup**: 5-10 minutes
- **Tutorial 1**: 30-45 minutes
- **Total**: ~40-55 minutes

---

## What You'll Build

A data pipeline that:
- Reads sales and product data from CSV files
- Cleans data (removes missing values)
- Joins datasets on product_id
- Calculates revenue (quantity × price)
- Aggregates by category and region
- Outputs results to CSV

**Business Question**: "Which product categories are performing best by region?"

---

## Prerequisites

Before starting, ensure you have:
- Python 3.11+ installed
- Claude Code CLI installed
- A terminal/command prompt

That's it! Everything else will be set up automatically.

---

## Quick Start (Alternative)

If you prefer to clone manually first:

```bash
# Clone the repository
git clone https://github.com/pavel242242/osiris-get-started.git
cd osiris-get-started

# Start Claude Code
claude
```

Then use this prompt:
```
I've cloned the osiris-get-started repository.

Please guide me through:
1. Setup process in docs/setup.md
2. Tutorial 1 in docs/tutorial-1-first-pipeline.md

As we work, explain the MCP tools, OML structure, and how deterministic compilation works.
```

---

## After Tutorial 1

Once you complete the first tutorial, you'll be ready to:
- **Tutorial 2**: Data Quality & Validation (coming soon)
- **Tutorial 3**: Database Integration (coming soon)
- **Tutorial 4**: Scheduled Pipelines (coming soon)

Or try your own data by telling Claude about your use case!

---

## Support

- **Tutorial Issues**: [GitHub Issues](https://github.com/pavel242242/osiris-get-started/issues)
- **Osiris Core**: [Osiris GitHub](https://github.com/keboola/osiris)
- **Discussions**: [GitHub Discussions](https://github.com/keboola/osiris/discussions)

Happy learning! 🚀
