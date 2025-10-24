#!/usr/bin/env bash

set -e

echo "Checking prerequisites for Intent Kit..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to print status
print_status() {
    local status=$1
    local message=$2
    if [ "$status" = "ok" ]; then
        echo -e "${GREEN}✓${NC} $message"
    elif [ "$status" = "warning" ]; then
        echo -e "${YELLOW}⚠${NC} $message"
    elif [ "$status" = "error" ]; then
        echo -e "${RED}✗${NC} $message"
    fi
}

# Check Git
if command_exists git; then
    git_version=$(git --version | cut -d' ' -f3)
    print_status "ok" "Git $git_version"
else
    print_status "error" "Git not found"
    echo "  Install Git from: https://git-scm.com/downloads"
fi

# Check Python
if command_exists python3; then
    python_version=$(python3 --version | cut -d' ' -f2)
    print_status "ok" "Python $python_version"
    if ! python3 -c "import sys; sys.exit(0 if sys.version_info >= (3, 11) else 1)" 2>/dev/null; then
        print_status "warning" "Python 3.11+ recommended for best experience"
    fi
elif command_exists python; then
    python_version=$(python --version | cut -d' ' -f2)
    print_status "ok" "Python $python_version"
    if ! python -c "import sys; sys.exit(0 if sys.version_info >= (3, 11) else 1)" 2>/dev/null; then
        print_status "warning" "Python 3.11+ recommended for best experience"
    fi
else
    print_status "error" "Python not found"
    echo "  Install Python 3.11+ from: https://python.org/downloads"
fi

# Check uv (Python package manager)
if command_exists uv; then
    uv_version=$(uv --version | cut -d' ' -f2)
    print_status "ok" "uv $uv_version"
else
    print_status "warning" "uv not found (optional, but recommended)"
    echo "  Install uv from: https://docs.astral.sh/uv/getting-started/installation/"
fi

# Check AI Agents
echo ""
echo "Checking AI agents..."

# Claude Code
if command_exists claude; then
    print_status "ok" "Claude Code"
elif [ -f "$HOME/.claude/local/claude" ]; then
    print_status "ok" "Claude Code (local installation)"
else
    print_status "warning" "Claude Code not found"
    echo "  Install from: https://docs.anthropic.com/en/docs/claude-code/setup"
fi

# Cursor
if command_exists cursor; then
    print_status "ok" "Cursor"
else
    print_status "warning" "Cursor not found"
    echo "  Install from: https://cursor.sh/"
fi

# GitHub Copilot (VS Code)
if command_exists code; then
    print_status "ok" "Visual Studio Code"
else
    print_status "warning" "Visual Studio Code not found"
    echo "  Install from: https://code.visualstudio.com/"
fi

# VS Code Insiders
if command_exists code-insiders; then
    print_status "ok" "Visual Studio Code Insiders"
fi

# Gemini CLI
if command_exists gemini; then
    print_status "ok" "Gemini CLI"
else
    print_status "warning" "Gemini CLI not found"
    echo "  Install from: https://github.com/google-gemini/gemini-cli"
fi

# Qwen Code
if command_exists qwen; then
    print_status "ok" "Qwen Code"
else
    print_status "warning" "Qwen Code not found"
    echo "  Install from: https://github.com/QwenLM/qwen-code"
fi

# opencode
if command_exists opencode; then
    print_status "ok" "opencode"
else
    print_status "warning" "opencode not found"
    echo "  Install from: https://opencode.ai/"
fi

# Codex CLI
if command_exists codex; then
    print_status "ok" "Codex CLI"
else
    print_status "warning" "Codex CLI not found"
    echo "  Install from: https://github.com/openai/codex"
fi

# Windsurf
if command_exists windsurf; then
    print_status "ok" "Windsurf"
else
    print_status "warning" "Windsurf not found"
    echo "  Install from: https://windsurf.com/"
fi

# Kilo Code
if command_exists kilocode; then
    print_status "ok" "Kilo Code"
else
    print_status "warning" "Kilo Code not found"
    echo "  Install from: https://github.com/Kilo-Org/kilocode"
fi

# Auggie CLI
if command_exists auggie; then
    print_status "ok" "Auggie CLI"
else
    print_status "warning" "Auggie CLI not found"
    echo "  Install from: https://docs.augmentcode.com/cli/setup-auggie/install-auggie-cli"
fi

# CodeBuddy CLI
if command_exists codebuddy; then
    print_status "ok" "CodeBuddy CLI"
else
    print_status "warning" "CodeBuddy CLI not found"
    echo "  Install from: https://www.codebuddy.ai/cli"
fi

# Roo Code
if command_exists roo; then
    print_status "ok" "Roo Code"
else
    print_status "warning" "Roo Code not found"
    echo "  Install from: https://roocode.com/"
fi

# Amazon Q Developer CLI
if command_exists q; then
    print_status "ok" "Amazon Q Developer CLI"
else
    print_status "warning" "Amazon Q Developer CLI not found"
    echo "  Install from: https://aws.amazon.com/developer/learning/q-developer-cli/"
fi

# Amp
if command_exists amp; then
    print_status "ok" "Amp"
else
    print_status "warning" "Amp not found"
    echo "  Install from: https://ampcode.com/manual#install"
fi

echo ""
echo "Prerequisites check complete!"
echo ""
echo "To install Intent CLI:"
echo "  uv tool install intent-cli --from git+https://github.com/Nom-nom-hub/Intended.git"
echo ""
echo "To initialize a new project:"
echo "  intent init my-project"