# Osiris Get Started: Interactive Tutorials

> Learn to build deterministic data pipelines by talking to AI - no boilerplate code required.

Build production-ready data pipelines using **Osiris** - a deterministic data pipeline compiler - through conversational AI assistants like Claude Code.

---

## 🚀 Quick Start

### 1. One-Time Setup (5-10 minutes)

**Prerequisites:**
- Python 3.11+ installed
- [Claude Code](https://claude.ai/code) CLI installed
- Git installed

**Run the setup:**

```bash
# Clone this repository
git clone https://github.com/pavel242242/osiris-get-started
cd osiris-get-started

# Follow the idempotent setup guide
# (Safe to re-run anytime)
```

👉 **[Complete Setup Guide](docs/setup.md)** - Idempotent installation of Osiris, MCP server, and dependencies

### 2. Choose Your Tutorial

Once setup is complete, pick a tutorial and start building!

---

## 📚 Tutorials

### 🟢 Beginner

#### [Tutorial 1: My First Pipeline - E-commerce Analytics](docs/tutorial-1-first-pipeline.md)
**Time:** 30-45 minutes | **Level:** Beginner

Build your first data pipeline by describing what you want in plain English. Learn the fundamentals of:
- Conversational pipeline building
- OML (Osiris Markup Language) structure
- Deterministic compilation
- MCP tools and how Claude uses them

**What you'll build:** Analyze which product categories perform best by region using sales data

**Skills learned:**
- ✅ CSV extraction
- ✅ Data cleaning (filter nulls)
- ✅ Joining datasets
- ✅ Computing derived columns
- ✅ Aggregations (GROUP BY)
- ✅ CSV output

---

### 🟡 Intermediate (Coming Soon)

#### Tutorial 2: Data Quality & Validation
**Time:** 20-30 minutes | **Level:** Intermediate

Add robust data quality checks and error handling to your pipelines.

**What you'll build:** Customer segmentation with validation rules

**Skills learned:**
- Data validation rules
- Error handling patterns
- Quality metrics
- Logging bad records
- Conditional processing

---

#### Tutorial 3: Database Integration
**Time:** 30-45 minutes | **Level:** Intermediate

Connect to real databases and build end-to-end ETL pipelines.

**What you'll build:** Extract from PostgreSQL, transform, load to data warehouse

**Skills learned:**
- Database connections
- SQL extractors
- Incremental loading
- Database writers
- Connection profiles

---

### 🔴 Advanced (Coming Soon)

#### Tutorial 4: Scheduled Pipelines
**Time:** 20-30 minutes | **Level:** Advanced

Automate your pipelines with scheduling and orchestration.

**What you'll build:** Daily sales summary pipeline with email alerts

**Skills learned:**
- Cron scheduling
- Parameterized pipelines
- Notifications
- Monitoring
- CI/CD integration

---

#### Tutorial 5: Custom Components
**Time:** 45-60 minutes | **Level:** Advanced

Build custom extractors, processors, and writers.

**What you'll build:** Custom API extractor and ML prediction processor

**Skills learned:**
- Component architecture
- Python SDK
- Testing components
- Contributing to Osiris

---

## 🎯 What Makes Osiris Different?

### Traditional Approach
```
Write Python/SQL → Test → Debug → Deploy → Hope it works everywhere
```

### With Osiris + AI
```
Describe goal to Claude → Osiris compiles → Execute anywhere → Guaranteed reproducibility
```

### Key Benefits

- **🗣️ Conversational:** Describe what you need in plain English
- **🔒 Deterministic:** Same input = same output, always
- **📦 Reproducible:** Works identically on laptop, colleague's machine, or cloud
- **🔍 Transparent:** Full visibility into what happens at every step
- **🤖 AI-Native:** Designed for AI assistants to orchestrate
- **⚡ Fast Iteration:** Modify and re-run conversationally

---

## 📖 How It Works

### The Three-Layer Architecture

```
┌─────────────────────────────────────────────────────┐
│  YOU (User)                                         │
│  "Analyze category performance by region..."        │
└────────────────┬────────────────────────────────────┘
                 │ Natural language
                 ▼
┌─────────────────────────────────────────────────────┐
│  CLAUDE (MCP Client)                                │
│  - Interprets your goals                            │
│  - Calls Osiris MCP tools                           │
│  - Presents results and insights                    │
└────────────────┬────────────────────────────────────┘
                 │ MCP function calls
                 ▼
┌─────────────────────────────────────────────────────┐
│  OSIRIS (Compiler)                                  │
│  - Generates deterministic OML manifests            │
│  - Executes pipelines reproducibly                  │
│  - Provides transparent logs and AIOP artifacts     │
└─────────────────────────────────────────────────────┘
```

### What Happens When You Ask Claude

1. **You describe** your data goal in natural language
2. **Claude interprets** and calls Osiris MCP tools:
   - `osiris_discovery_run` - Analyze data sources
   - `osiris_components_list` - See available components
   - `osiris_oml_schema_get` - Get OML syntax
   - `osiris_oml_validate` - Validate pipeline
   - `osiris_oml_save` - Save pipeline
3. **Osiris generates** a deterministic OML manifest
4. **Pipeline executes** with full transparency
5. **You get results** with logs, metrics, and insights

---

## 🛠️ Repository Structure

```
osiris-get-started/
├── README.md                           # This file - tutorial menu
├── PROMPTS.md                          # Ready-to-use session prompts
├── .gitignore                          # Git ignore patterns
│
├── docs/
│   ├── setup.md                        # Idempotent setup guide
│   ├── tutorial-1-first-pipeline.md    # Tutorial 1: E-commerce analytics
│   ├── tutorial-2-data-quality.md      # Tutorial 2: (coming soon)
│   ├── tutorial-3-databases.md         # Tutorial 3: (coming soon)
│   └── tutorial-4-scheduling.md        # Tutorial 4: (coming soon)
│
├── examples/
│   └── tutorial-1/
│       ├── data-in/                    # Sample CSV files
│       │   ├── sales_data.csv
│       │   └── product_catalog.csv
│       └── data-out/                   # Output directory (empty)
│           └── .gitkeep
│
└── [Generated during setup - gitignored]
    ├── .venv/                          # Python virtual environment
    ├── .mcp.json                       # MCP server config
    ├── .claude/                        # Claude settings directory
    ├── osiris.yaml                     # Project configuration
    ├── pipelines/                      # Your OML pipelines
    ├── build/                          # Compiled manifests
    ├── aiop/                           # AI Operation Packages
    ├── run_logs/                       # Execution logs
    └── components/                     # Component definitions
```

---

## 💡 Key Concepts

### OML (Osiris Markup Language)
YAML-based declarative language for defining pipelines. Contains three main sections:
- **Extractors:** Read data from sources (CSV, databases, APIs)
- **Processors:** Transform data (filter, join, compute, aggregate)
- **Writers:** Output results (CSV, databases, cloud storage)

### Deterministic Compilation
Same input + same manifest = same output, **always**. No hidden state or randomness.

### Manifest
Compiled version of your OML with a unique fingerprint. Guarantees reproducible execution.

### MCP (Model Context Protocol)
Standard protocol allowing AI assistants to call external tools. Osiris exposes its capabilities through MCP.

### AIOP (AI Operation Package)
Machine-readable execution data including metrics, lineage, and quality information that AI can analyze.

---

## 🎓 Learning Path

**Recommended order:**

1. **Start here:** [Setup Guide](docs/setup.md) - One-time installation
2. **Beginner:** [Tutorial 1](docs/tutorial-1-first-pipeline.md) - Learn the basics
3. **Intermediate:** Tutorial 2 → Tutorial 3 - Build production skills
4. **Advanced:** Tutorial 4 → Tutorial 5 - Master advanced patterns

**Estimated total time:** 3-4 hours for all tutorials

---

## ❓ FAQ

### Do I need to know Python?
No! You describe what you want in plain English. Claude generates the pipeline. However, Python knowledge helps for Tutorial 5 (custom components).

### Can I edit the OML manifests directly?
Yes! They're human-readable YAML. You can edit them manually or ask Claude to make changes.

### Does this work without Claude?
Osiris works as a standalone CLI tool. However, these tutorials teach the AI-assisted workflow, which is the recommended approach.

### Can I use my own data?
Absolutely! Just tell Claude about your data sources. The tutorials use sample data, but you can adapt them to your real data.

### Is this production-ready?
Yes! Osiris generates deterministic manifests suitable for production. Many teams use it for critical data pipelines.

### How is this different from dbt or Airflow?

| Tool | Focus | Approach | Osiris Integration |
|------|-------|----------|-------------------|
| **dbt** | SQL transformations | Code-based (YAML + SQL) | Complementary - Osiris can call dbt |
| **Airflow** | Orchestration | Code-based (Python DAGs) | Complementary - Airflow can schedule Osiris |
| **Osiris** | End-to-end pipelines | Conversational + Deterministic | Standalone or integrated |

Osiris complements these tools and can integrate with them.

---

## 🤝 Support & Contributing

### Get Help
- **Tutorial Issues:** [GitHub Issues](https://github.com/pavel242242/osiris-get-started/issues)
- **Osiris Core:** [Osiris GitHub](https://github.com/keboola/osiris)
- **Discussions:** [GitHub Discussions](https://github.com/keboola/osiris/discussions)

### Contributing
Found a bug? Have tutorial suggestions? PRs welcome!

```bash
git checkout -b feature/improvement
# Make your changes
git commit -m "Improve tutorial X"
git push origin feature/improvement
# Open a Pull Request
```

---

## 📄 License

This tutorial repository: MIT License

Osiris: See [Osiris repository](https://github.com/keboola/osiris) for license details

---

## 🙏 Acknowledgments

- **Osiris** by [Keboola](https://github.com/keboola)
- **MCP (Model Context Protocol)** by [Anthropic](https://anthropic.com)
- **Claude Code** by [Anthropic](https://anthropic.com)

---

## 🚀 Ready to Start?

1. **[Run Setup](docs/setup.md)** - Install Osiris and MCP server
2. **[Start Tutorial 1](docs/tutorial-1-first-pipeline.md)** - Build your first pipeline
3. **Share your experience** - Open an issue or discussion!

---

**Questions?** Open an issue or start a discussion. We're here to help! 🎉
