# Intent Kit Documentation

Welcome to the Intent Kit documentation. Intent Kit is an open source toolkit
that allows you to focus on product scenarios and predictable outcomes instead
of vibe coding every piece from scratch.

## What is Intent-Driven Development?

Intent-Driven Development **flips the script** on traditional software development.
For decades, code has been king — specifications were just scaffolding we built
and discarded once the "real work" of coding began. Intent-Driven Development
changes this: **intent becomes executable**, directly generating working
implementations rather than just guiding them.

## Quick Start

### 1. Install Intent CLI

Choose your preferred installation method:

#### Option 1: Persistent Installation (Recommended)

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

#### Option 2: One-time Usage

Run directly without installing:

```bash
uvx --from git+https://github.com/Nom-nom-hub/Intended.git intent init <PROJECT_NAME>
```

### 2. Establish project principles

Launch your AI assistant in the project directory. The `/intentkit.*` commands
are available in the assistant.

Use the **`/intentkit.constitution`** command to create your project's governing
principles and development guidelines that will guide all subsequent
development.

```bash
/intentkit.constitution Create principles focused on code quality, testing
standards, user experience consistency, and performance requirements
```

### 3. Create the intent

Use the **`/intentkit.Intended`** command to describe what you want to build. Focus
on the **what** and **why**, not the tech stack.

```bash
/intentkit.Intended Build an application that can help me organize my photos in
separate photo albums. Albums are grouped by date and can be re-organized by
dragging and dropping on the main page. Albums are never in other nested albums.
Within each album, photos are previewed in a tile-like interface.
```

### 4. Create a technical implementation plan

Use the **`/intentkit.plan`** command to provide your tech stack and architecture choices.

```bash
/intentkit.plan The application uses Vite with minimal number of libraries. Use
vanilla HTML, CSS, and JavaScript as much as possible. Images are not uploaded
anywhere and metadata is stored in a local SQLite database.
```

### 5. Break down into tasks

Use **`/intentkit.tasks`** to create an actionable task list from your implementation plan.

```bash
/intentkit.tasks
```

### 6. Execute implementation

Use **`/intentkit.implement`** to execute all tasks and build your feature according to the plan.

```bash
/intentkit.implement
```

For detailed step-by-step instructions, see our
[comprehensive guide](./intent-driven.md).

## Supported AI Agents

| Agent                    | Support | Notes                                             |
|-----------------------------------------------------------|---------|---------------------------------------------------|
| [Claude Code](https://www.anthropic.com/claude-code)      | ✅ |                                                   |
| [GitHub Copilot](https://code.visualstudio.com/)          | ✅ |                                                   |
| [Gemini CLI](https://github.com/google-gemini/gemini-cli) | ✅ |                                                   |
| [Cursor](https://cursor.sh/)                              | ✅ |                                                   |
| [Qwen Code](https://github.com/QwenLM/qwen-code)          | ✅ |                                                   |
| [opencode](https://opencode.ai/)                          | ✅ |                                                   |
| [Windsurf](https://windsurf.com/)                         | ✅ |                                                   |
| [Kilo Code](https://github.com/Kilo-Org/kilocode)         | ✅ |                                                   |
| [Auggie CLI](https://docs.augmentcode.com/cli/overview)   | ✅ |                                                   |
| [CodeBuddy CLI](https://www.codebuddy.ai/cli)             | ✅ |                                                   |
| [Roo Code](https://roocode.com/)                          | ✅ |                                                   |
| [Codex CLI](https://github.com/openai/codex)              | ✅ |                                                   |
| [Amazon Q Developer CLI](https://aws.amazon.com/developer/learning/q-developer-cli/) | ⚠️ | Amazon Q Developer CLI [does not support](https://github.com/aws/amazon-q-developer-cli/issues/3064) custom arguments for slash commands. |
| [Amp](https://ampcode.com/) | ✅ | |

## Intent CLI Reference

The `intent` command supports the following options:

### Commands

| Command     | Description                                                    |
|-------------|----------------------------------------------------------------|
| `init`      | Initialize a new Intent project from the latest template      |
| `check`     | Check for installed tools (`git`, `claude`, `gemini`, etc.) |

### Available Slash Commands

After running `intent init`, your AI coding agent will have access to these slash commands for structured development:

#### Core Commands

Essential commands for the Intent-Driven Development workflow:

| Command                  | Description                                                           |
|--------------------------|-----------------------------------------------------------------------|
| `/intentkit.constitution`  | Create or update project governing principles and development guidelines |
| `/intentkit.Intended`       | Define what you want to build (requirements and user stories)        |
| `/intentkit.plan`          | Create technical implementation plans with your chosen tech stack     |
| `/intentkit.tasks`         | Generate actionable task lists for implementation                     |
| `/intentkit.implement`     | Execute all tasks to build the feature according to the plan         |

#### Optional Commands

Additional commands for enhanced quality and validation:

| Command              | Description                                                           |
|----------------------|-----------------------------------------------------------------------|
| `/intentkit.clarify`   | Clarify underspecified areas (recommended before `/intentkit.plan`) |
| `/intentkit.analyze`   | Cross-artifact consistency & coverage analysis (run after tasks, before implement) |
| `/intentkit.checklist` | Generate quality checklists that validate requirements (like "unit tests for English") |

## Learn More

- **[Complete Intent-Driven Development Methodology](./intent-driven.md)** - Deep dive into the full process
- **[Installation Guide](./installation.md)** - Detailed installation instructions
- **[Quick Start Guide](./quickstart.md)** - Get up and running quickly
- **[Local Development](./local-development.md)** - Set up a development environment
