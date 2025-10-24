# Quick Start Guide

This guide will get you up and running with Intent Kit in minutes.

## What You'll Need

- Python 3.11 or higher
- uv package manager
- Git (optional but recommended)
- A supported AI coding agent

## Step 1: Install Intent CLI

```bash
# Install Intent CLI globally
uv tool install intent-cli --from git+https://github.com/Nom-nom-hub/Intended.git

# Verify installation
intent --help
```

## Step 2: Initialize Your Project

```bash
# Create a new project
intent init my-first-project

# Or initialize in current directory
intent init .
```

The CLI will:

1. Check your system for required tools
2. Let you choose your AI assistant
3. Download the appropriate template
4. Set up the project structure
5. Initialize a Git repository (if available)

## Step 3: Set Up Your AI Agent

1. **Navigate to your project**:

   ```bash
   cd my-first-project
   ```

2. **Launch your AI agent** (e.g., Claude Code):

   ```bash
   claude
   ```

3. **Verify slash commands are available**:
   You should see `/intentkit.constitution`, `/intentkit.Intended`, `/intentkit.plan`, `/intentkit.tasks`, and
   `/intentkit.implement` commands available.

## Step 4: Establish Project Principles

Start with the constitution to set your project's foundational guidelines:

```bash
/intentkit.constitution Create principles focused on code quality, testing standards \\
  user experience consistency, and performance requirements. Include governance \\
  for how these principles should guide technical decisions and implementation choices.
```

This creates `.intent/memory/constitution.md` with your project's governing principles.

## Step 5: Create Your Specification

Define what you want to build:

```bash
/intentkit.Intended Build a task management application where users can create \\
  projects, add team members, assign tasks, and track progress in a Kanban-style \\
  interface. Users should be able to drag and drop tasks between columns like \\
  "To Do," "In Progress," and "Done."
```

This creates a new branch (e.g., `001-task-management`) and generates a detailed specification in `intents/001-task-management/Intent.md`.

## Step 6: Create Implementation Plan

Intended your technical approach:

```bash
/intentkit.plan Use React with TypeScript for the frontend, Node.js with Express \\
  for the backend, and PostgreSQL for data storage. Implement drag-and-drop \\
  functionality with react-beautiful-dnd. Include user authentication and \\
  real-time updates.
```

This generates implementation details in the `intents/001-task-management/` directory.

## Step 7: Generate Tasks

Break down the work into actionable tasks:

```bash
/intentkit.tasks
```

This creates a detailed task breakdown in `intents/001-task-management/tasks.md`.

## Step 8: Implement the Feature

Execute the implementation:

```bash
/intentkit.implement
```

The AI agent will work through each task systematically, building your feature according to the plan.

## What's Next?

### Optional Enhancement Commands

For better quality and confidence:

```bash
# Clarify any ambiguous requirements (before planning)
# /intentkit.clarify

# Analyze consistency across artifacts (after tasks, before implementation)
/intentkit.analyze

# Generate quality checklists (after planning)
/intentkit.checklist
```

### Working with Multiple Features

Each new feature gets its own branch and directory:

```bash
# Create another feature
/intentkit.Intended Add user authentication with email/password and social login options

# The system automatically creates branch 002-user-authentication
```

### Best Practices

1. **Start with clear intent**: Be specific about what you want to build and why
2. **Focus on user value**: Prioritize features that deliver real user benefits
3. **Use the workflow**: Follow the constitution → Intended → plan → tasks → implement sequence
4. **Iterate**: Use clarification and analysis commands to improve quality
5. **Test independently**: Each user story should be independently testable

## Getting Help

- **Documentation**: Visit [github.github.io/intent-kit](https://github.github.io/intent-kit)
- **Issues**: Report problems on [GitHub](https://github.com/Nom-nom-hub/Intended/issues)
- **Discussions**: Ask questions in [GitHub Discussions](https://github.com/Nom-nom-hub/Intended/discussions)

## Troubleshooting

### Common Issues

#### "No AI agent detected"

- Make sure your AI agent is installed and in PATH
- Use `--ignore-agent-tools` flag if you want to skip validation

#### "Git repository issues"

- Ensure Git is installed
- Use `--no-git` flag to skip Git initialization

#### "Template download failed"

- Check your internet connection
- Try using `--skip-tls` flag if you have SSL issues

- Use `--debug` flag for detailed error information

For more detailed troubleshooting, see the [Installation Guide](installation.md).
