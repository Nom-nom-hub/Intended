# Installation

This guide will help you install and set up Intent Kit for Intent-Driven Development.

## Prerequisites

- **Linux/macOS/Windows**
- [Supported](#supported-ai-agents) AI coding agent.
- [uv](https://docs.astral.sh/uv/) for package management
- [Python 3.11+](https://www.python.org/downloads/)
- [Git](https://git-scm.com/downloads)

If you encounter issues with an agent, please open an issue so we can refine the integration.

## Installing Intent CLI

### Option 1: Persistent Installation (Recommended)

Install once and use everywhere:

```bash
uv tool install intent-cli --from git+https://github.com/Nom-nom-hub/Intended.git
```

Then use the tool directly:

```bash
intent init <PROJECT_NAME>
intent check
```

To upgrade intent run:

```bash
uv tool install intent-cli --force --from git+https://github.com/Nom-nom-hub/Intended.git
```

**Benefits of persistent installation:**

- Tool stays installed and available in PATH
- No need to create shell aliases
- Better tool management with `uv tool list`, `uv tool upgrade`, `uv tool uninstall`
- Cleaner shell configuration

### Option 2: One-time Usage

Run directly without installing:

```bash
uvx --from git+https://github.com/Nom-nom-hub/Intended.git intent init <PROJECT_NAME>
```

## Verifying Installation

After installation, verify that Intent CLI is working correctly:

```bash
intent --help
```

You should see the help output with available commands and options.

## Setting Up AI Agents

Intent Kit works with various AI coding agents. Make sure you have at least one of the supported agents installed:

### Checking Available Tools

Use the built-in check command to verify your environment:

```bash
intent check
```

This will check for:
- Git version control
- Supported AI agents (Claude Code, Cursor, GitHub Copilot, etc.)
- Visual Studio Code variants

### Recommended AI Agents

For the best experience, we recommend:

1. **[Claude Code](https://docs.anthropic.com/en/docs/claude-code/setup)** - Full-featured coding assistant
2. **[Cursor](https://cursor.sh/)** - IDE with built-in AI support
3. **[GitHub Copilot](https://github.com/features/copilot)** - VS Code integration

## Troubleshooting

### Common Issues

#### "command not found" errors

If you get "command not found" errors:

1. **For persistent installation**: Make sure `uv` is in your PATH and run `uv tool list` to verify installation
2. **For one-time usage**: Use the full `uvx` command each time
3. **Check Python version**: Ensure you have Python 3.11 or higher

#### Agent detection failures

If the agent detection fails:

1. **Verify installation**: Make sure the AI agent is properly installed and in your PATH
2. **Skip checks**: Use the `--ignore-agent-tools` flag if you want to proceed without agent validation:

```bash
intent init my-project --ignore-agent-tools
```

#### Git issues

If you encounter Git-related issues:

1. **Install Git**: Make sure Git is installed and in your PATH
2. **Skip Git**: Use the `--no-git` flag to skip Git repository initialization:

```bash
intent init my-project --no-git
```

### Getting Help

If you need help:

1. **Check the documentation**: Visit our [documentation site](https://github.github.io/intent-kit/)
2. **Open an issue**: Report bugs or request features on [GitHub](https://github.com/github/intent-kit/issues)
3. **Check troubleshooting**: See the [troubleshooting section](../README.md#troubleshooting) in the main README

## Next Steps

Once you have Intent CLI installed:

1. **Initialize your first project**: `intent init my-project`
2. **Set up project principles**: Use `/intentkit.constitution` in your AI agent
3. **Create your first specification**: Use `/intentkit.specify` to define what you want to build
4. **Start developing**: Follow the Intent-Driven Development workflow

For detailed step-by-step instructions, see the [Quick Start Guide](quickstart.md).