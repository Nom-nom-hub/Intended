#!/usr/bin/env python3
"""
Intent CLI - Setup tool for Intent-Driven Development projects

Intent-Driven Development CLI tool that sets up projects with AI agent integration
for intent-focused software development.

Usage:
    uvx intent-cli.py init <project-name>
    uvx intent-cli.py init .
    uvx intent-cli.py init --here

Or install globally:
    uv tool install --from intent-cli.py intent-cli
    intent init <project-name>
    intent init .
    intent init --here
"""

import os
import subprocess
import sys
import zipfile
import tempfile
import shutil
import shlex
import json
from pathlib import Path
from typing import Optional, Tuple, Union

import typer
import httpx
from rich.console import Console
from rich.panel import Panel
from rich.progress import Progress, SpinnerColumn, TextColumn
from rich.text import Text
from rich.live import Live
from rich.align import Align
from rich.table import Table
from rich.tree import Tree
from typer.core import TyperGroup

# For cross-platform keyboard input
import readchar
import ssl
import truststore

ssl_context = truststore.SSLContext(ssl.PROTOCOL_TLS_CLIENT)
client = httpx.Client(verify=ssl_context)

def _github_token(cli_token: str | None = None) -> str | None:
    """Return sanitized GitHub token (cli arg takes precedence) or None."""
    return ((cli_token or os.getenv("GH_TOKEN") or os.getenv("GITHUB_TOKEN") or "").strip()) or None

def _github_auth_headers(cli_token: str | None = None) -> dict:
    """Return Authorization header dict only when a non-empty token exists."""
    token = _github_token(cli_token)
    return {"Authorization": f"Bearer {token}"} if token else {}

# Agent configuration with name, folder, install URL, and CLI tool requirement
# Enhanced features configuration
ENHANCED_FEATURES = {
    "version_control": {
        "description": "Git branch tracking and commit integration",
        "enabled_by_default": True,
    },
    "codebase_validation": {
"description": "Real-time validation against existing code",
"enabled_by_default": False,
},
"cicd_integration": {
"description": "Automated CI/CD pipeline validation",
"enabled_by_default": False,
},
"dependency_graph": {
"description": "Advanced dependency resolution and conflict detection",
"enabled_by_default": True,
},
"performance_optimization": {
"description": "Large codebase support and caching",
"enabled_by_default": False,
},
    "artifact_expansion": {
        "description": "Extended support for additional document types and external integrations",
        "enabled_by_default": True,
    },
    "task_quality": {
        "description": "Enhanced task granularity, estimation, and validation",
        "enabled_by_default": True,
    },
}

AGENT_CONFIG = {
    "copilot": {
        "name": "GitHub Copilot",
        "folder": ".github/",
        "install_url": None,  # IDE-based, no CLI check needed
        "requires_cli": False,
    },
    "claude": {
        "name": "Claude Code",
        "folder": ".claude/",
        "install_url": "https://docs.anthropic.com/en/docs/claude-code/setup",
        "requires_cli": True,
    },
    "gemini": {
        "name": "Gemini CLI",
        "folder": ".gemini/",
        "install_url": "https://github.com/google-gemini/gemini-cli",
        "requires_cli": True,
    },
    "cursor-agent": {
        "name": "Cursor",
        "folder": ".cursor/",
        "install_url": None,  # IDE-based
        "requires_cli": False,
    },
    "qwen": {
        "name": "Qwen Code",
        "folder": ".qwen/",
        "install_url": "https://github.com/QwenLM/qwen-code",
        "requires_cli": True,
    },
    "opencode": {
        "name": "opencode",
        "folder": ".opencode/",
        "install_url": "https://opencode.ai",
        "requires_cli": True,
    },
    "codex": {
        "name": "Codex CLI",
        "folder": ".codex/",
        "install_url": "https://github.com/openai/codex",
        "requires_cli": True,
    },
    "windsurf": {
        "name": "Windsurf",
        "folder": ".windsurf/",
        "install_url": None,  # IDE-based
        "requires_cli": False,
    },
    "kilocode": {
        "name": "Kilo Code",
        "folder": ".kilocode/",
        "install_url": None,  # IDE-based
        "requires_cli": False,
    },
    "auggie": {
        "name": "Auggie CLI",
        "folder": ".augment/",
        "install_url": "https://docs.augmentcode.com/cli/setup-auggie/install-auggie-cli",
        "requires_cli": True,
    },
    "codebuddy": {
        "name": "CodeBuddy",
        "folder": ".codebuddy/",
        "install_url": "https://www.codebuddy.ai/cli",
        "requires_cli": True,
    },
    "roo": {
        "name": "Roo Code",
        "folder": ".roo/",
        "install_url": None,  # IDE-based
        "requires_cli": False,
    },
    "q": {
        "name": "Amazon Q Developer CLI",
        "folder": ".amazonq/",
        "install_url": "https://aws.amazon.com/developer/learning/q-developer-cli/",
        "requires_cli": True,
    },
    "amp": {
        "name": "Amp",
        "folder": ".agents/",
        "install_url": "https://ampcode.com/manual#install",
        "requires_cli": True,
    },
}

SCRIPT_TYPE_CHOICES = {"sh": "POSIX Shell (bash/zsh)", "ps": "PowerShell"}

BANNER = """
╔══════════════════════════════════════════════════════════════════╗
║                                                                  ║
║  ██╗███╗   ██╗████████╗███████╗███╗   ██╗████████╗              ║
║  ██║████╗  ██║╚══██╔══╝██╔════╝████╗  ██║╚══██╔══╝  ║
║  ██║██╔██╗ ██║   ██║   █████╗  ██╔██╗ ██║   ██║     ║
║  ██║██║╚██╗██║   ██║   ██╔══╝  ██║╚██╗██║   ██║     ║
║  ██║██║ ╚████║   ██║   ███████╗██║ ╚████║   ██║     ║
║  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝   ╚═╝     ║
║                                                                  ║
║              🌟 Intent-Driven Development 🌟              ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
"""

TAGLINE = "Intent Kit - Intent-Driven Development & AI Integration Framework"

class StepTracker:
    """Track and render hierarchical steps without emojis, similar to Claude Code tree output.
    Supports live auto-refresh via an attached refresh callback.
    """
    def __init__(self, title: str):
        self.title = title
        self.steps = []  # list of dicts: {key, label, status, detail}
        self.status_order = {"pending": 0, "running": 1, "done": 2, "error": 3, "skipped": 4}
        self._refresh_cb = None  # callable to trigger UI refresh

    def attach_refresh(self, cb):
        self._refresh_cb = cb

    def add(self, key: str, label: str):
        if key not in [s["key"] for s in self.steps]:
            self.steps.append({"key": key, "label": label, "status": "pending", "detail": ""})
            self._maybe_refresh()

    def start(self, key: str, detail: str = ""):
        self._update(key, status="running", detail=detail)

    def complete(self, key: str, detail: str = ""):
        self._update(key, status="done", detail=detail)

    def error(self, key: str, detail: str = ""):
        self._update(key, status="error", detail=detail)

    def skip(self, key: str, detail: str = ""):
        self._update(key, status="skipped", detail=detail)

    def _update(self, key: str, status: str, detail: str):
        for s in self.steps:
            if s["key"] == key:
                s["status"] = status
                if detail:
                    s["detail"] = detail
                self._maybe_refresh()
                return

        self.steps.append({"key": key, "label": key, "status": status, "detail": detail})
        self._maybe_refresh()

    def _maybe_refresh(self):
        if self._refresh_cb:
            try:
                self._refresh_cb()
            except Exception:
                pass

    def render(self):
        # Create spectacular progress display with enhanced styling
        from rich.table import Table
        from rich.panel import Panel
        from rich.progress import Progress, BarColumn, TextColumn, TimeElapsedColumn

        # Create a table for the progress display
        table = Table(show_header=False, box=None, padding=(0, 1))
        table.add_column("Status", width=3, justify="center")
        table.add_column("Step", style="white bold")
        table.add_column("Details", style="bright_black")

        # Add title with styling
        title_panel = Panel.fit(
            f"[bold bright_blue]⚡ {self.title} ⚡[/bold bright_blue]",
            border_style="bright_blue",
            padding=(0, 1)
        )

        # Build the steps display
        completed_count = 0
        total_count = len(self.steps)

        for step in self.steps:
            label = step["label"]
            detail_text = step["detail"].strip() if step["detail"] else ""

            status = step["status"]
            if status == "done":
                symbol = "[green]✓[/green]"
                completed_count += 1
            elif status == "pending":
                symbol = "[dim]○[/dim]"
            elif status == "running":
                symbol = "[cyan]⟳[/cyan]"
            elif status == "error":
                symbol = "[red]✗[/red]"
            elif status == "skipped":
                symbol = "[yellow]⊘[/yellow]"
            else:
                symbol = "[dim]○[/dim]"

            # Enhanced styling based on status
            if status == "running":
                step_style = "[bold cyan]" + label + "[/bold cyan]"
            elif status == "done":
                step_style = "[green]" + label + "[/green]"
            elif status == "error":
                step_style = "[bold red]" + label + "[/bold red]"
            else:
                step_style = "[bright_black]" + label + "[/bright_black]"

            detail_style = f"[bright_black]{detail_text}[/bright_black]" if detail_text else ""

            table.add_row(symbol, step_style, detail_style)

        # Create progress bar
        progress_bar = Progress(
            TextColumn("[progress.description]{task.description}"),
            BarColumn(complete_style="bright_blue", finished_style="bright_green"),
            TextColumn("{task.completed}/{task.total}"),
            TimeElapsedColumn(),
        )

        progress_task = progress_bar.add_task(
            f"[cyan]Progress: {completed_count}/{total_count} steps completed",
            total=total_count,
            completed=completed_count
        )

        # Combine everything into a spectacular display
        from rich.console import Group

        layout = Group(
            title_panel,
            "",  # Spacer
            table,
            "",  # Spacer
            progress_bar
        )

        return layout

def get_key():
    """Get a single keypress in a cross-platform way using readchar."""
    key = readchar.readkey()

    if key == readchar.key.UP or key == readchar.key.CTRL_P:
        return 'up'
    if key == readchar.key.DOWN or key == readchar.key.CTRL_N:
        return 'down'

    if key == readchar.key.ENTER:
        return 'enter'

    if key == readchar.key.ESC:
        return 'escape'

    if key == readchar.key.CTRL_C:
        raise KeyboardInterrupt

    return key

def select_with_arrows(options: dict, prompt_text: str = "Select an option", default_key: Optional[str] = None) -> str:
    """
    Interactive selection using arrow keys with Rich Live display.

    Args:
        options: Dict with keys as option keys and values as descriptions
        prompt_text: Text to show above the options
        default_key: Default option key to start with

    Returns:
        Selected option key
    """
    option_keys = list(options.keys())
    if default_key and default_key in option_keys:
        selected_index = option_keys.index(default_key)
    else:
        selected_index = 0

    selected_key = None

    def create_selection_panel():
        """Create the spectacular selection panel with enhanced styling and animations."""
        # Create a more visually appealing table
        table = Table(show_header=False, box=None, padding=(0, 1))
        table.add_column("Indicator", width=4, justify="center")
        table.add_column("Option", style="bold white")
        table.add_column("Description", style="bright_black")

        # Add spectacular header
        header_panel = Panel.fit(
            f"[bold bright_magenta]🎯 {prompt_text} 🎯[/bold bright_magenta]\n[dim]Choose your destiny...[/dim]",
            border_style="bright_magenta",
            padding=(1, 2)
            )

        # Add options with enhanced styling
        for i, key in enumerate(option_keys):
            if i == selected_index:
                # Selected option with spectacular styling
                indicator = "[bold bright_yellow]▶[/bold bright_yellow]"
                option_style = f"[bold bright_cyan blink]{key}[/bold bright_cyan blink]"
                desc_style = f"[bright_white]{options[key]}[/bright_white]"
                # Add a subtle animation effect
                table.add_row(f"{indicator} ✨", option_style, desc_style)
            else:
                # Unselected options
                indicator = "[dim]○[/dim]"
                option_style = f"[bright_black]{key}[/bright_black]"
                desc_style = f"[dim]{options[key]}[/dim]"
                table.add_row(indicator, option_style, desc_style)
        # Enhanced instructions with better styling
        instructions = "\n[bright_yellow]Navigation:[/bright_yellow] [cyan]↑/↓[/cyan] [bright_black]arrows[/bright_black] • [cyan]Enter[/cyan] [bright_black]select[/bright_black] • [cyan]Esc[/cyan] [bright_black]cancel[/bright_black]"

        # Combine everything into a spectacular layout
        from rich.console import Group
        from rich.text import Text

        layout = Group(
            header_panel,
            "",  # Spacer
            table,
            "",  # Spacer
            Align.center(Text.from_markup(instructions))
        )

        return Panel(  # type: ignore
        layout,
        border_style="bright_blue",
        padding=(1, 1),
        title="[bold bright_white]Interactive Selection[/bold bright_white]",
        title_align="center"
        )

    console.print()

    def run_selection_loop():
        nonlocal selected_key, selected_index
        with Live(create_selection_panel(), console=console, transient=True, auto_refresh=False) as live:  # type: ignore
            while True:
                try:
                    key = get_key()
                    if key == 'up':
                        selected_index = (selected_index - 1) % len(option_keys)
                    elif key == 'down':
                        selected_index = (selected_index + 1) % len(option_keys)
                    elif key == 'enter':
                        selected_key = option_keys[selected_index]
                        break
                    elif key == 'escape':
                        console.print("\n[yellow]Selection cancelled[/yellow]")
                        raise typer.Exit(1)

                    live.update(create_selection_panel(), refresh=True)  # type: ignore

                except KeyboardInterrupt:
                    console.print("\n[yellow]Selection cancelled[/yellow]")
                    raise typer.Exit(1)

    run_selection_loop()

    if selected_key is None:
        console.print("\n[red]Selection failed.[/red]")
        raise typer.Exit(1)

    return selected_key

console = Console()

class BannerGroup(TyperGroup):
    """Custom group that shows banner before help."""

    def format_help(self, ctx, formatter):
        # Show banner before help
        show_banner()
        super().format_help(ctx, formatter)


app = typer.Typer(
    name="intent",
    help="Setup tool for Intent-Driven Development projects with AI agent integration",
    add_completion=False,
    invoke_without_command=True,
    cls=BannerGroup,
)

def show_banner():
    """Display the spectacular ASCII art banner with animations and styling."""
    banner_lines = BANNER.strip().split('\n')
    colors = ["bright_blue", "blue", "cyan", "bright_cyan", "white", "bright_white"]

    styled_banner = Text()
    for i, line in enumerate(banner_lines):
        color = colors[i % len(colors)]
        styled_banner.append(line + "\n", style=color)

    console.print(Align.center(styled_banner))
    console.print(Align.center(Text(TAGLINE, style="italic bright_yellow")))
    console.print()

@app.callback()
def callback(ctx: typer.Context):
    """Show spectacular banner and interactive menu when no subcommand is provided."""
    if ctx.invoked_subcommand is None and "--help" not in sys.argv and "-h" not in sys.argv:
        show_banner()

        # Add interactive quick actions
        console.print()
        quick_actions_panel = Panel.fit(
                    "[bold bright_green]🚀 Quick Actions[/bold bright_green]\n\n" +
                    "[cyan]intent init my-project[/cyan] [dim]- Create new project[/dim]\n" +
                    "[cyan]intent init --all-enhanced[/cyan] [dim]- Enable all features[/dim]\n" +
                    "[cyan]intent check[/cyan] [dim]- Verify system requirements[/dim]\n\n" +
                    "[bright_yellow]💡 Pro Tips:[/bright_yellow]\n" +
                    "• Use [cyan]--enhanced[/cyan] for specific features\n" +
                    "• Run [cyan]intent --help[/cyan] for full documentation\n" +
                    "• Check [bright_magenta]AGENTS.md[/bright_magenta] for supported AI assistants",
                    border_style="bright_green",
                    padding=(1, 2),
                    title="[bold bright_white]Welcome to Intent Kit![/bold bright_white]"
                )
        console.print(quick_actions_panel)


@app.command()
def init(
    project_name: str = typer.Argument(None, help="Name of the project to initialize"),
    ai_assistant: str = typer.Option(None, "--ai", help="AI assistant to use: " + ", ".join(AGENT_CONFIG.keys())),
    enhanced: list[str] = typer.Option([], "--enhanced", help="Enhanced features to enable"),
    all_enhanced: bool = typer.Option(False, "--all-enhanced", help="Enable all enhanced features"),
):
    """Initialize a new Intent-Driven Development project with AI agent integration."""
    if project_name is None:
        project_name = "."

    # Interactive selection for AI assistant if not provided
    if ai_assistant is None:
        options = {k: v["name"] for k, v in AGENT_CONFIG.items()}
        ai_assistant = select_with_arrows(options, "Select your AI assistant")

    # Determine enhanced features
    if all_enhanced:
        enabled_features = list(ENHANCED_FEATURES.keys())
    elif enhanced:
        enabled_features = enhanced
    else:
        # Default to enabled by default features
        enabled_features = [k for k, v in ENHANCED_FEATURES.items() if v.get("enabled_by_default", False)]

    console.print(f"Initializing project: {project_name}")
    console.print(f"AI Assistant: {ai_assistant}")
    console.print(f"Enhanced features: {enabled_features}")

    # Implement project creation
    import shutil
    from pathlib import Path

    tracker = StepTracker("Project Initialization")

    project_path = Path(project_name).resolve()
    if project_name != ".":
        project_path.mkdir(parents=True, exist_ok=True)
        tracker.complete("Project directory", f"Created {project_path}")

    # Create agent-specific directory
    agent_config = AGENT_CONFIG[ai_assistant]
    agent_dir = project_path / agent_config["folder"].lstrip(".")
    agent_dir.mkdir(parents=True, exist_ok=True)
    commands_dir = agent_dir / "commands"
    commands_dir.mkdir(exist_ok=True)
    tracker.complete("Agent directory", f"Created {agent_dir}")

    # Determine format
    if ai_assistant in ["gemini", "qwen"]:
        format_ext = "toml"
    else:
        format_ext = "md"

    # Copy command templates
    templates_dir = Path(__file__).parent.parent / "templates" / "commands"
    if templates_dir.exists():
        copied = 0
        for template_file in templates_dir.glob(f"*.{format_ext}"):
            shutil.copy(template_file, commands_dir / template_file.name)
            copied += 1
        tracker.complete("Command templates", f"Copied {copied} templates")
    else:
        tracker.error("Command templates", "Templates directory not found")

    # Create core artifacts
    artifacts = ["Intent.md", "plan.md", "tasks.md"]
    for artifact in artifacts:
        (project_path / artifact).touch()
    tracker.complete("Core artifacts", f"Created {', '.join(artifacts)}")

    # Create additional directories
    dirs = ["checklists", "contracts", "memory", "data-model", "research"]
    for d in dirs:
        (project_path / d).mkdir(exist_ok=True)
    tracker.complete("Project structure", f"Created directories: {', '.join(dirs)}")

    # Create constitution if memory exists
    constitution_path = project_path / "memory" / "constitution.md"
    if not constitution_path.exists():
        constitution_path.write_text("# Project Constitution\n\nDefine your project principles here.\n")
        tracker.complete("Constitution", "Created default constitution.md")

    tracker.complete("Project initialization", f"Complete - ready for Intent-Driven Development with {agent_config['name']}")

    console.print(f"\n[green]✅ Project '{project_name}' initialized successfully![/green]")
    console.print(f"📁 Location: {project_path}")
    console.print(f"🤖 AI Assistant: {agent_config['name']}")
    console.print(f"📋 Next steps:")
    console.print(f"  1. Edit Intent.md to define your feature requirements")
    console.print(f"  2. Run 'intent plan' (when implemented) to create the technical plan")
    console.print(f"  3. Start development with your chosen AI assistant!")


def check_tool(tool_name: str) -> bool:
    """Check if a tool is available in PATH."""
    import shutil
    return shutil.which(tool_name) is not None

@app.command()
def check():
    """Check system requirements and AI assistant availability."""
    tracker = StepTracker("System Requirements Check")

    # Check Python version
    import sys
    python_version = f"{sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro}"
    tracker.complete("Python", f"Version {python_version}")

    # Check required packages
    try:
        import typer
        tracker.complete("Typer", "Available")
    except ImportError:
        tracker.error("Typer", "Missing - install with pip install typer")

    try:
        import rich
        tracker.complete("Rich", "Available")
    except ImportError:
        tracker.error("Rich", "Missing - install with pip install rich")

    # Check AI assistant CLI tools
    for agent_key, config in AGENT_CONFIG.items():
        if config["requires_cli"]:
            if check_tool(agent_key):
                tracker.complete(f"{config['name']} CLI", "Available")
            else:
                install_url = config.get("install_url", "N/A")
                tracker.error(f"{config['name']} CLI", f"Missing - install from {install_url}")

    tracker.complete("System check", "Complete")


def main():
    app()
