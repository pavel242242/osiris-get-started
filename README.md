# Osiris Get Started Tutorial

> Learn to build deterministic data pipelines by talking to AI - no boilerplate code required.

This tutorial teaches you how to use **Osiris** - a deterministic data pipeline compiler - through conversational AI assistants like Claude Code, Claude Desktop, or other MCP-compatible tools.

## What You'll Learn

- Describe data goals in natural language
- Watch AI orchestrate complex pipelines
- Understand deterministic compilation
- Work with reproducible manifests
- Debug and iterate conversationally
- Build production-ready data pipelines

## The Osiris Difference

**Traditional approach:**
```
Write Python/SQL → Test → Debug → Deploy → Hope it works everywhere
```

**With Osiris:**
```
Describe goal to AI → Osiris compiles → Execute anywhere → Guaranteed reproducibility
```

## Quick Start

### Prerequisites

- Python 3.9+
- An MCP client:
  - [Claude Code](https://claude.ai/code) (recommended)
  - [Claude Desktop](https://claude.ai/desktop)
  - [Cursor](https://cursor.sh/)
  - [Windsurf](https://codeium.com/windsurf)
  - Other MCP-compatible tools

### Installation (Two-Session Setup)

This tutorial uses a **two-session approach** for the best learning experience:

**Session 1: Setup & MCP Server**
```bash
# Clone this repository
git clone https://github.com/[user]/osiris-get-started.git
cd osiris-get-started

# Create virtual environment
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Clone and install Osiris in editable mode
git clone https://github.com/keboola/osiris.git /tmp/osiris-repo
pip install -e /tmp/osiris-repo

# Install MCP SDK
pip install mcp

# Verify installation
osiris --version  # Should show Osiris v0.5.0 or similar

# Initialize Osiris project
osiris init

# Copy component definitions
cp -r /tmp/osiris-repo/components .

# Verify components
osiris components list | head -5  # Should list available components
```

**Register Osiris MCP server:**
```bash
claude mcp add osiris
```

This creates `.mcp.json` with the Osiris server configuration. Claude Code will auto-launch the server when needed.

Alternatively, manually create `.mcp.json`:
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

**Enable MCP server auto-approval:**

Add to `.claude/settings.local.json`:
```json
{
  "enableAllProjectMcpServers": true
}
```

This ensures Osiris MCP server is automatically enabled in Session 2.

**Session 2: Tutorial (New Terminal)**

In a new terminal window, start Claude Code:
```bash
cd osiris-get-started
claude
```

**Important:** When Claude Code starts, you may be prompted to approve the Osiris MCP server. Click "Allow" or "Enable".

If not prompted, enable it manually in `.claude/settings.local.json`:
```json
{
  "enableAllProjectMcpServers": true
}
```

Then restart Claude Code.

### Verify Setup

Check MCP status:
```
/mcp
```

**Use this initial prompt in Session 2:**

```
Hi! I'm going through the Osiris tutorial for building my first data pipeline.

Can you:
1. Check if Osiris MCP tools are available with /mcp
2. Show me what Osiris tools you have access to

Once verified, I'll be ready to start building the e-commerce analytics pipeline from the tutorial.
```

You should see confirmation that Osiris MCP tools are accessible (e.g., `osiris_oml_validate`, `osiris_connections_list`, `osiris_discovery_run`, etc.).

## Tutorial

📖 **[Start the tutorial: docs/my_first_process.md](docs/my_first_process.md)**

**Time to complete:** 30-45 minutes

**What you'll build:**
- E-commerce category performance analysis
- Clean, join, and aggregate sales data
- Handle data quality issues
- Generate reproducible manifests
- Iterate and improve conversationally

## Repository Structure

```
osiris-get-started/
├── README.md                    # This file
├── PLAN.md                      # Comprehensive tutorial planning doc
├── requirements.txt             # Python dependencies
│
├── docs/
│   └── my_first_process.md      # Step-by-step tutorial
│
├── examples/
│   ├── data-in/                 # Sample input data (provided)
│   │   ├── sales_data.csv       # 30 transaction records
│   │   └── product_catalog.csv  # 10 product records
│   │
│   ├── data-out/                # Generated outputs
│   │   └── (results appear here)
│   │
│   └── manifests/               # Generated pipeline definitions
│       └── (manifests appear here)
│
└── .osiris/                     # Osiris configuration
    ├── config.yaml              # Global settings
    ├── profiles/                # Credential profiles
    └── logs/                    # Execution logs
```

## How It Works

**Two-Session Architecture:**

```
SESSION 1 (Setup)                    SESSION 2 (Tutorial)
┌─────────────────┐                 ┌─────────────────┐
│  Terminal       │                 │  YOU            │
│  Running MCP    │◄────────────────│  (Claude Code)  │
│  Server         │   MCP Protocol  │                 │
└─────────────────┘                 └────────┬────────┘
         │                                   │
         │                                   ▼
         │                          ┌─────────────────┐
         │                          │  CLAUDE/AI      │
         │                          │  (MCP Client)   │
         │                          │  Calls Osiris   │
         │                          └────────┬────────┘
         │                                   │
         └───────────────────────────────────┘
                                             │
                                             ▼
                                    ┌─────────────────┐
                                    │  OSIRIS         │
                                    │  (Compiler)     │
                                    │  Generates &    │
                                    │  Executes       │
                                    └─────────────────┘
```

**Your role:** Describe what you need in natural language (Session 2)

**Claude's role:** Interpret goals, call Osiris MCP tools, present insights

**Osiris's role:** Compile deterministic manifests, execute reproducibly (via MCP server in Session 1)

## Key Concepts

### Deterministic Compilation
Same input + same manifest = same output, **always**. No hidden state, no randomness, works identically across environments.

### Manifest
YAML file defining your pipeline. Version controlled, human-readable, machine-executable.

### MCP (Model Context Protocol)
Standard protocol allowing AI assistants to call external tools. Osiris exposes its capabilities through MCP.

### Reproducibility
Run the same manifest on your laptop, a colleague's machine, or in E2B cloud - get identical results.

## Example: Business Question to Pipeline

**You ask:**
```
Which product categories perform best by region?
```

**Claude understands you need to:**
1. Extract sales and product data
2. Clean records with missing values
3. Join on product_id
4. Calculate revenue
5. Aggregate by category and region
6. Output results

**Osiris generates a manifest** defining this pipeline deterministically.

**You get:**
- Processed data in `examples/data-out/`
- Transparent manifest in `examples/manifests/`
- Execution logs with metrics
- AI-readable operation data (AIOP)

**You can:**
- Inspect the manifest to understand exactly what happened
- Modify and re-run
- Version control the manifest
- Share with teammates
- Deploy to production

## What You Can Build

### Starter Projects (Included)
- [x] E-commerce category analysis (this tutorial)
- [ ] Customer segmentation
- [ ] Sales forecasting
- [ ] Data quality monitoring

### Advanced Patterns
- Connect to databases (PostgreSQL, MySQL, MongoDB)
- Extract from APIs (REST, GraphQL)
- Write to cloud storage (S3, GCS, Azure)
- Build custom processors
- Schedule automated runs
- Compose complex multi-stage pipelines
- Handle streaming data (v0.5+)

## Tutorial Roadmap

**Part 1:** Your First Pipeline (15 min)
- Describe a business goal
- Watch Claude build the pipeline
- View and understand results

**Part 2:** Understanding the System (10 min)
- Inspect generated manifests
- Learn the three-layer architecture
- Understand reproducibility guarantees

**Part 3:** Iterate and Improve (10 min)
- Modify pipelines conversationally
- Compare results
- Save manifests for reuse

**Part 4:** Next Steps (5 min)
- Data quality checks
- Custom components
- Production deployment
- Advanced features

## FAQ

### Do I need to know Python?
No! You describe what you want in plain English. Claude generates the pipeline manifest using Osiris. However, Python knowledge helps if you want to build custom components.

### Can I edit the manifests directly?
Yes! Manifests are human-readable YAML. You can edit them directly or ask Claude to make changes.

### Does this work without Claude?
Osiris works as a standalone CLI tool. However, this tutorial teaches the AI-assisted workflow, which is the recommended approach. You can use any MCP-compatible AI assistant.

### What if I want to use my own data?
Just tell Claude about your data sources (files, databases, APIs). Claude will help you configure extractors and adapt the pipeline.

### Is this production-ready?
Yes! Osiris generates deterministic manifests suitable for production. Add error handling, monitoring, and scheduling as needed.

### How is this different from dbt or Airflow?
- **dbt:** SQL transformation focused, requires writing YAML/SQL
- **Airflow:** Orchestration focused, requires Python DAG code
- **Osiris:** Conversational, AI-friendly, deterministic compiler for end-to-end pipelines

Osiris complements these tools and can integrate with them.

## Support

- **Tutorial Issues:** [GitHub Issues](https://github.com/[user]/osiris-get-started/issues)
- **Osiris Issues:** [Osiris GitHub](https://github.com/keboola/osiris/issues)
- **Discussions:** [GitHub Discussions](https://github.com/keboola/osiris/discussions)
- **Documentation:** [Osiris Docs](https://github.com/keboola/osiris)

## Contributing

Found a bug in the tutorial? Have suggestions for improvements? PRs welcome!

```bash
# Fork this repo
git checkout -b feature/improvement
# Make your changes
git commit -m "Improve tutorial section X"
git push origin feature/improvement
# Open a Pull Request
```

## License

This tutorial repository: MIT License

Osiris: See [Osiris repository](https://github.com/keboola/osiris) for license details

## Acknowledgments

- **Osiris** by [Keboola](https://github.com/keboola)
- **MCP (Model Context Protocol)** by [Anthropic](https://anthropic.com)
- **Claude Code** and **Claude Desktop** by [Anthropic](https://anthropic.com)

---

## Ready to Start?

🚀 **[Begin the tutorial: docs/my_first_process.md](docs/my_first_process.md)**

Or ask your AI assistant:
```
Let's go through the osiris-get-started tutorial together
```

---

**Questions?** Open an issue or start a discussion. We're here to help!
