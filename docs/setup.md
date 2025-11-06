# Osiris Setup Guide

This guide will set up Osiris and the MCP server for use with Claude Code. It's **idempotent** - safe to run multiple times. It will only install what's missing.

**Time to complete:** 5-10 minutes

**✨ New:** Osiris is now available on [PyPI](https://pypi.org/project/osiris-pipeline/) (version 0.5.1+)! Installation is now faster and simpler with `pip install osiris-pipeline`.

---

## Prerequisites

- **Python 3.11+** installed
- **Claude Code** CLI installed ([download here](https://claude.ai/code))

Verify your Python version:
```bash
python3.11 --version  # Should show Python 3.11.x or higher
```

---

## Setup Steps

### Step 1: Navigate to the Tutorial Directory

```bash
cd osiris-get-started
```

### Step 2: Run the Idempotent Setup Script

Copy and paste this entire script into your terminal:

```bash
#!/bin/bash
set -e

echo "🔧 Osiris Idempotent Setup"
echo "=========================="
echo ""

# Check Python 3.11
if ! command -v python3.11 &> /dev/null; then
    echo "❌ Python 3.11 not found. Please install Python 3.11 or higher."
    exit 1
fi
echo "✅ Python 3.11 found"

# Check/Create virtual environment
if [ ! -d ".venv" ]; then
    echo "📦 Creating virtual environment..."
    python3.11 -m venv .venv
    echo "✅ Virtual environment created"
else
    echo "✅ Virtual environment exists"
fi

# Activate virtual environment and check Osiris
source .venv/bin/activate

if ! command -v osiris &> /dev/null; then
    echo "📦 Installing Osiris and MCP from PyPI..."
    pip install -q --upgrade pip
    pip install osiris-pipeline mcp
    echo "✅ Osiris and MCP installed"
else
    OSIRIS_VERSION=$(osiris --version 2>&1)
    echo "✅ Osiris already installed: $OSIRIS_VERSION"
fi

# Check/Initialize Osiris project
if [ ! -f "osiris.yaml" ]; then
    echo "📦 Initializing Osiris project..."
    osiris init
    echo "✅ Osiris project initialized"
else
    echo "✅ Osiris project already initialized"
fi

# Check/Create .mcp.json
if [ ! -f ".mcp.json" ]; then
    echo "📦 Creating MCP server configuration..."
    cat > .mcp.json << 'EOF'
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
EOF
    echo "✅ MCP server configured"
else
    echo "✅ MCP server configuration exists"
fi

# Check/Create .claude/settings.local.json
mkdir -p .claude
if [ ! -f ".claude/settings.local.json" ]; then
    echo "📦 Creating Claude settings..."
    cat > .claude/settings.local.json << 'EOF'
{
  "enableAllProjectMcpServers": true
}
EOF
    echo "✅ Claude settings configured"
else
    # Check if enableAllProjectMcpServers is set
    if ! grep -q "enableAllProjectMcpServers" .claude/settings.local.json; then
        echo "⚠️  Adding enableAllProjectMcpServers to existing settings..."
        # Backup existing settings
        cp .claude/settings.local.json .claude/settings.local.json.backup
        # Add the setting (basic approach - may need manual verification)
        echo "   Please manually verify .claude/settings.local.json contains:"
        echo '   "enableAllProjectMcpServers": true'
    else
        echo "✅ Claude settings already configured"
    fi
fi

echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo ""
echo "Next steps:"
echo "1. Start a new Claude Code session: claude"
echo "2. Verify MCP connection with: /mcp"
echo "3. Choose a tutorial from the README.md"
echo ""
```

### Step 3: Verify Setup

Check that everything is configured:

```bash
# Verify Osiris is installed
source .venv/bin/activate
osiris --version  # Should show: Osiris v0.5.1 or higher

# Verify project structure
ls osiris.yaml pipelines/ build/ aiop/  # All should exist

# Verify MCP configuration
cat .mcp.json  # Should show osiris config

# Verify Claude settings
cat .claude/settings.local.json  # Should show enableAllProjectMcpServers: true
```

---

## Troubleshooting

### Issue: "Python 3.11 not found"

**Solution:**
```bash
# On macOS with Homebrew
brew install python@3.11

# On Ubuntu/Debian
sudo apt install python3.11

# On Windows
# Download from python.org
```

### Issue: "osiris: command not found" after installation

**Solution:**
```bash
# Make sure virtual environment is activated
source .venv/bin/activate

# Check if osiris is in the venv
which osiris  # Should show path in .venv/bin/
```

### Issue: MCP server not connecting in Claude Code

**Solution:**
1. Check `.mcp.json` exists in project root
2. Check `.claude/settings.local.json` has `"enableAllProjectMcpServers": true`
3. Restart Claude Code session
4. Run `/mcp` to verify connection

---

## What Gets Created

After running setup, your project will have:

```
osiris-get-started/
├── .venv/                          # Python virtual environment (gitignored)
├── .mcp.json                       # MCP server config (gitignored)
├── .claude/
│   └── settings.local.json         # Claude settings (gitignored)
├── osiris.yaml                     # Project configuration (gitignored)
├── pipelines/                      # OML pipeline definitions (gitignored)
├── build/                          # Compiled manifests (gitignored)
├── aiop/                           # AI Operation Package (gitignored)
├── run_logs/                       # Execution logs (gitignored)
└── examples/                       # Tutorial data (committed)
```

---

## Re-running Setup

This setup is **idempotent** - you can run it again anytime:
- If something breaks
- After cloning the repo on a new machine
- To update Osiris to the latest version

Just run the setup script again. It will skip steps that are already complete.

---

## Next Steps

Setup complete! Return to [README.md](../README.md) to choose a tutorial.
