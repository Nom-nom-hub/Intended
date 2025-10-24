# Contributing to Intent Kit

Thank you for your interest in contributing to Intent Kit! We welcome
contributions from the community to help improve the intent-driven
development experience.

## Table of Contents

- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Contributing Guidelines](#contributing-guidelines)
- [Adding New Agent Support](#adding-new-agent-support)
- [Testing](#testing-requirements)
- [Documentation](#documentation)
- [Release Process](#release-process)
- [Community](#community)

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:

   ```bash
   git clone https://github.com/your-username/intended.git
   cd intended
   ```

3. **Set up the development environment** (see [Development Setup](#development-setup))
4. **Create a feature branch**:

   ```bash
   git checkout -b feature/your-feature-name
   ```

5. **Make your changes** and ensure tests pass
6. **Submit a pull request** with a clear description of your changes

## Development Setup

### Prerequisites

- **Python 3.11+**
- **uv** package manager
- **Git**
- **Supported AI agent** (for testing)

### Environment Setup

1. **Install dependencies**:

   ```bash
   uv sync
   ```

2. **Install Intent CLI in development mode**:

   ```bash
   uv tool install -e .
   ```

3. **Set up pre-commit hooks**:

   ```bash
   uv run pre-commit install
   ```

4. **Verify installation**:

   ```bash
   intent --version
   intent check
   ```

### Development Tools

- **Code formatting**: `black`, `isort`
- **Linting**: `flake8`, `mypy`
- **Testing**: `pytest`
- **Documentation**: `mkdocs` or `sphinx`

## Contributing Guidelines

### Code Standards

- **Follow PEP 8** for Python code style
- **Use type hints** for all function signatures
- **Write docstrings** for all public functions and classes
- **Keep functions small** and focused on single responsibilities
- **Use meaningful variable names** and avoid abbreviations

### Commit Guidelines

- **Use conventional commits**: `feat:`, `fix:`, `docs:`, `style:`, `refactor:`, `test:`, `chore:`
- **Write clear commit messages** explaining what and why
- **Reference issues** when applicable: `Fixes #123`, `Closes #456`
- **Keep commits atomic** - one logical change per commit

### Pull Request Process

1. **Update documentation** if you're changing functionality
2. **Add tests** for new features or bug fixes
3. **Ensure all tests pass**:

   ```bash
   uv run pytest
   ```

4. **Run linting and formatting**:

   ```bash
   uv run black .
   uv run isort .
   uv run flake8
   ```

5. **Update CHANGELOG.md** for significant changes
6. **Submit your PR** with a clear description

### Testing Requirements

- **Unit tests** for all new functionality
- **Integration tests** for CLI commands and agent interactions
- **Cross-platform tests** (Windows, macOS, Linux)
- **Agent compatibility tests** for all supported AI agents

## Adding New Agent Support

See [AGENTS.md](./AGENTS.md) for detailed instructions on adding support for new AI agents.

### Quick Summary

1. **Add to AGENT_CONFIG** in `src/intent_cli/__init__.py`
2. **Update CLI help text** and validation
3. **Create command templates** in `templates/commands/`
4. **Update scripts** in `scripts/bash/` and `scripts/powershell/`
5. **Add tests** for the new agent integration
6. **Update documentation** and examples

## Documentation

### Documentation Structure

- **`README.md`**: Main project overview and getting started guide
- **`docs/`**: Detailed documentation with DocFX setup
- **`AGENTS.md`**: Agent integration guide and supported agents
- **`CHANGELOG.md`**: Version history and changes
- **Inline documentation**: Code comments and docstrings

### Writing Documentation

- **Use clear, concise language** appropriate for the audience
- **Include examples** for complex features
- **Keep documentation in sync** with code changes
- **Use relative links** for internal references
- **Test code examples** to ensure they work

## Release Process

### Version Management

- **Follow semantic versioning** (MAJOR.MINOR.PATCH)
- **Update version** in `pyproject.toml`
- **Create changelog entry** for the new version
- **Tag releases** with version numbers

### Release Checklist

- [ ] Update version in `pyproject.toml`
- [ ] Add changelog entry
- [ ] Run full test suite
- [ ] Update documentation
- [ ] Create release packages for all agents
- [ ] Test installation from release packages
- [ ] Tag and publish release

## Community

### Getting Help

- **GitHub Issues**: For bug reports and feature requests
- **GitHub Discussions**: For questions and discussions
- **Documentation**: Check the docs first for common questions

### Code of Conduct

Please read and follow our [Code of Conduct](./CODE_OF_CONDUCT.md) when participating in the Intent Kit community.

### Recognition

Contributors who make significant improvements to Intent Kit may be recognized in the project documentation or release notes.

---

Thank you for contributing to Intent Kit! Your help makes intent-driven development better for everyone.
