# Local Development

This guide covers setting up a local development environment for Intent Kit.

## Development Prerequisites

- **Python 3.11+** - For running the CLI
- **uv** - For Python package management
- **Git** - For version control
- **Make** (optional) - For running build tasks
- **DocFX** (optional) - For building documentation locally

## Setting Up Development Environment

### 1. Clone the Repository

```bash
git clone https://github.com/Nom-nom-hub/Intended.git
cd intended
```

### 2. Set Up Python Environment

```bash
# Install uv if you don't have it
curl -LsSf https://astral.sh/uv/install.sh | sh

# Create virtual environment and install dependencies
uv sync

# Or install in development mode
uv pip install -e .
```

### 3. Install Development Tools

```bash
# Install pre-commit hooks (optional)
uv pip install pre-commit
pre-commit install

# Install documentation tools (optional)
dotnet tool install -g docfx
```

## Project Structure

```text
intended/
├── src/intent_cli/          # Main CLI source code
├── docs/                    # Documentation source
├── scripts/                 # Build and utility scripts
├── templates/               # Project templates
├── media/                   # Images and media files
├── memory/                  # Project memory and constitution
├── tests/                   # Test files
├── .github/                 # GitHub workflows and templates
└── pyproject.toml           # Python project configuration
```

## Running the CLI Locally

### Development Installation

```bash
# Install in development mode
uv pip install -e .

# Run the CLI
intent --help
```

### Direct Execution

```bash
# Run without installation
uv run python -m intent_cli --help

# Or run directly
python src/intent_cli/__init__.py --help
```

## Building Documentation

### Local Documentation Build

```bash
# Build and serve documentation locally
cd docs
docfx docfx.json --serve

# Open http://localhost:8080 in your browser
```

### Documentation Structure

- `docs/docfx.json` - DocFX configuration
- `docs/index.md` - Main documentation page
- `docs/toc.yml` - Table of contents
- `docs/_site/` - Generated documentation (ignored by git)

## Testing

### Running Tests

```bash
# Run all tests
uv run pytest

# Run with coverage
uv run pytest --cov=intent_cli

# Run specific test file
uv run pytest tests/test_cli.py
```

### Writing Tests

Tests should cover:

- CLI command functionality
- Template generation
- Script execution
- Error handling
- Edge cases

## Code Quality

### Linting and Formatting

```bash
# Format code
uv run black src/ tests/

# Check linting
uv run flake8 src/ tests/

# Type checking
uv run mypy src/
```

### Pre-commit Hooks

If using pre-commit:

```bash
# Install hooks
pre-commit install

# Run on all files
pre-commit run --all-files
```

## Building and Publishing

### Building the Package

```bash
# Build wheel
uv build

# Build and install locally
uv pip install -e .
```

### Publishing to PyPI

```bash
# Build and upload
uv build
uv publish
```

## Development Workflow

### Making Changes

1. **Create a feature branch**:

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** following the project conventions

3. **Test your changes**:

   ```bash
   uv run pytest
   ```

4. **Update documentation** if needed

5. **Create a pull request** with a clear description

### Code Style Guidelines

- Follow PEP 8 for Python code
- Use type hints where appropriate
- Write docstrings for public functions and classes
- Keep functions focused and small
- Use meaningful variable and function names

### Commit Message Format

```text
type(scope): description

- Bullet points for additional details
- More details if needed
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

## Debugging

### CLI Debugging

```bash
# Enable debug output
intent init test-project --debug

# Check Python path and environment
python -c "import sys; print(sys.path)"
```

### Common Issues

**Import errors**: Make sure you're in the project root or have the package installed in development mode.

**Template not found**: Check that template files exist in the `templates/` directory.

**Git issues**: Ensure Git is properly configured and the repository is clean.

## Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed contribution guidelines.

## Getting Help

- **Issues**: [GitHub Issues](https://github.com/Nom-nom-hub/Intended/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Nom-nom-hub/Intended/discussions)
- **Documentation**: [Local docs](http://localhost:8080) (after running `docfx --serve`)
