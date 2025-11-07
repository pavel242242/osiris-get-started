# Getting Started with Osiris

Welcome! This guide will walk you through installing Osiris and setting it up to work with Claude Desktop or Claude Code. By the end (about 5-7 minutes), you'll be ready to build your first AI-native data pipeline.

## What You'll Do

1. Clone this tutorial repository
2. Check your Python version and create a virtual environment
3. Install Osiris
4. Connect Osiris to Claude via MCP (Model Context Protocol)
5. Verify everything works
6. Run your first example

Let's get started!

---

## 1. Clone the Tutorial Repository

First, clone this getting started repository to your local machine:

```bash
cd ~
git clone https://github.com/pavel242242/osiris-getting-started
cd osiris-getting-started
```

This repository contains:
- Sample data for the examples
- Pre-configured directory structure
- Example pipeline configurations
- Documentation and guides

All the following steps assume you're working inside this cloned `osiris-getting-started` directory.

---

## 2. Prerequisites

### Check Your Python Version

Osiris requires **Python 3.11 or higher**. Check what you have:

```bash
# Check if python3 is available and its version
python3 --version
```

If you see `Python 3.11.x` or `Python 3.12.x` or higher, you're good to go!

If you have an older version, you might have multiple Python versions installed:

```bash
# Try checking for specific versions
python3.11 --version
python3.12 --version
```

If none of these work, you'll need to install Python 3.11+:
- **macOS**: Use [Homebrew](https://brew.sh/) - `brew install python@3.11`
- **Linux**: Use your package manager - `sudo apt install python3.11` (Ubuntu/Debian) or `sudo yum install python311` (RedHat/CentOS)

**Note**: This tutorial focuses on macOS and Linux. Windows support is coming soon!

---

## 3. Installation

### Step 3.1: Create a Virtual Environment (Required)

Virtual environments keep your Python packages isolated and prevent conflicts. This step is **required** for Osiris.

You should already be in the `osiris-getting-started` directory from step 1. If not, navigate there now:

```bash
cd osiris-getting-started
```

Now create the virtual environment using the Python version you confirmed above:

```bash
# If python3 is 3.11+, use:
python3 -m venv .venv

# If you needed to use python3.11 specifically:
python3.11 -m venv .venv

# If you needed to use python3.12 specifically:
python3.12 -m venv .venv
```

### Step 3.2: Activate the Virtual Environment

**Every time** you work with Osiris, you'll need to activate this environment:

```bash
source .venv/bin/activate
```

You should see `(.venv)` appear at the start of your terminal prompt. This confirms the virtual environment is active.

**Tip**: If you close your terminal and come back later, remember to run `source .venv/bin/activate` again!

### Step 3.3: Install Osiris

With your virtual environment active, install Osiris:

```bash
pip install osiris-pipeline
```

This will download and install Osiris and all its dependencies.

### Step 3.4: Verify Installation

Let's confirm everything is working:

```bash
# Check the version
osiris --version

# Run diagnostics
osiris doctor
```

If both commands work without errors, you're ready to move on!

---

## 4. Understanding OSIRIS_HOME

Before we connect to Claude, let's understand where Osiris stores its data.

**OSIRIS_HOME** is the directory where Osiris keeps:
- Configuration files
- Pipeline artifacts
- Execution logs
- Output data

**Default location**: `~/.osiris` (in your home directory)

**For this tutorial**, we use the cloned repository location:
- `OSIRIS_HOME=~/osiris-getting-started`

This allows Osiris to use **relative paths** to access the sample data in the `examples/` directory.

You can set this in several ways:
1. In a `.env` file (we provide `.env.example` as a template)
2. As an environment variable in your shell
3. In your MCP server configuration (covered next)
4. Using the `--home` flag with Osiris commands

For now, we'll configure it in the MCP setup.

---

## 5. MCP Setup: Connect Osiris to Claude

MCP (Model Context Protocol) lets Claude interact with Osiris directly. You can use Claude to generate pipelines, validate them, and more - all through natural conversation.

Choose your setup based on what you use:
- **[Option A: Claude Desktop](#option-a-claude-desktop)** - The Claude desktop app
- **[Option B: Claude Code v2](#option-b-claude-code-v2)** - The Claude VS Code extension

### Option A: Claude Desktop

#### Find Your Configuration File

Claude Desktop stores its MCP configuration in a JSON file. The location depends on your operating system:

**macOS**:
```
~/Library/Application Support/Claude/claude_desktop_config.json
```

**Linux**:
```
~/.config/Claude/claude_desktop_config.json
```

You can edit this file directly, or access it through the app:
1. Open Claude Desktop
2. Click on "Claude" in the menu bar (macOS) or menu (Linux)
3. Select "Settings"
4. Look for "Developer" or "MCP Servers" section

#### Add Osiris Configuration

Open the configuration file in your favorite text editor and add the Osiris server configuration.

If the file is **empty or new**, use this:

```json
{
  "mcpServers": {
    "osiris": {
      "command": "osiris",
      "args": ["mcp"],
      "env": {
        "OSIRIS_HOME": "~/osiris-getting-started"
      }
    }
  }
}
```

If the file **already has content**, add the `"osiris"` entry inside the existing `"mcpServers"` object:

```json
{
  "mcpServers": {
    "existing-server": {
      ...
    },
    "osiris": {
      "command": "osiris",
      "args": ["mcp"],
      "env": {
        "OSIRIS_HOME": "~/osiris-getting-started"
      }
    }
  }
}
```

#### Restart Claude Desktop

After saving the configuration file:
1. **Quit Claude Desktop completely** (don't just close the window)
2. Reopen Claude Desktop

#### Verify Connection

Once Claude Desktop restarts:
1. Look for the **MCP icon** or **connectors panel** (usually a plug icon or in the settings area)
2. Click on it to see connected MCP servers
3. You should see **"osiris"** listed as a connected server

If you don't see it, check the **[Troubleshooting](#troubleshooting)** section below.

---

### Option B: Claude Code v2

Claude Code v2 provides two ways to add MCP servers: an interactive CLI command or manual configuration.

#### Method 1: Interactive CLI (Recommended)

The easiest way is to use the built-in command:

1. Open VS Code with Claude Code extension installed
2. Open this tutorial repository as your workspace
3. Open the Claude Code panel
4. Type:
   ```
   claude mcp add
   ```
5. Follow the interactive prompts:
   - Name: `osiris`
   - Command: `osiris`
   - Args: `mcp`
   - Environment variables: Add `OSIRIS_HOME` with value `${workspaceFolder}`

#### Method 2: Manual Configuration

Alternatively, you can manually create the configuration file:

1. In your workspace, create `.claude/config.json` (if it doesn't exist)
2. Add the following configuration:

```json
{
  "mcpServers": {
    "osiris": {
      "command": "osiris",
      "args": ["mcp"],
      "env": {
        "OSIRIS_HOME": "${workspaceFolder}"
      }
    }
  }
}
```

**Note**: The OSIRIS_HOME should point to your workspace folder (Claude Code will resolve `${workspaceFolder}` automatically).

#### Restart/Reload Window

After configuration, start a new Claude Code session in the terminal.

#### Verify Connection

After reloading:
1. In the Claude Code panel, type:
   ```
   /mcp
   ```
2. You should see a list of connected MCP servers
3. Look for **"osiris"** in the list with a connected status

If you don't see it, check the **[Troubleshooting](#troubleshooting)** section below.

---

## 6. Quick Start: What's Next?

Congratulations! You've successfully:
- ✅ Cloned the tutorial repository
- ✅ Installed Python 3.11+ and created a virtual environment
- ✅ Installed Osiris
- ✅ Connected Osiris to Claude via MCP
- ✅ Verified everything is working

### Ready to Build Your First Pipeline?

Head over to **[Example A: Sales Analysis](examples/A-sales/)** to:
- Load and clean CSV data
- Join multiple datasets
- Aggregate revenue by category
- Export results to Parquet format

**Using Claude Desktop or Claude Code?** Simply open the example and use the provided starter prompt. Claude will work with Osiris to build the pipeline for you!

---

## Troubleshooting

### Python Version Issues

**Problem**: `python3 --version` shows Python 3.10 or older
- Install Python 3.11+: `brew install python@3.11` (macOS) or use your Linux package manager
- Use the specific version when creating venv: `python3.11 -m venv .venv`

### Virtual Environment Not Activating

**Problem**: `(.venv)` doesn't appear in your prompt
- Make sure you ran: `source .venv/bin/activate`
- Check you're in the right directory: `pwd` should show `osiris-getting-started`
- Try deactivating first: `deactivate`, then activate again

### Osiris Command Not Found

**Problem**: `osiris: command not found` after installation
- Make sure virtual environment is active (you should see `(.venv)`)
- Try reinstalling: `pip install --upgrade osiris-pipeline`
- Check installation: `pip list | grep osiris`

### MCP Not Connecting (Claude Desktop)

**Problem**: Osiris doesn't appear in connectors panel
- Check JSON syntax in `claude_desktop_config.json` (no trailing commas, proper quotes)
- Verify the `osiris` command works in terminal: `osiris --version`
- Make sure you **fully quit** Claude Desktop (Cmd+Q on macOS, not just close window)
- Check Claude Desktop logs for errors

### MCP Not Connecting (Claude Code)

**Problem**: `/mcp` doesn't show osiris
- Verify `.claude/config.json` exists in your workspace
- Check JSON syntax is valid
- Reload the VS Code window: Cmd+Shift+P → "Developer: Reload Window"
- Make sure virtual environment is active before starting Claude Code
- Check the MCP server logs in the output panel

### OSIRIS_HOME Issues

**Problem**: Osiris can't find data files
- Verify OSIRIS_HOME is set correctly in MCP config
- Use absolute paths instead of `~`: `/Users/yourname/osiris-getting-started`
- Check the directory exists: `ls ~/osiris-getting-started`
- For Claude Code, make sure you opened the workspace folder, not just a file

### Still Having Issues?

- Run `osiris doctor` to check your installation
- Check [GitHub Issues](https://github.com/keboola/osiris/issues) for known problems
- Open a new issue with your error message and setup details

---

**Next**: [Example A: Sales Analysis →](examples/A-sales/)
