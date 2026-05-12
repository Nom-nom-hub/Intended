# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/Intent/v2.0.0.html).

## [Unreleased]

## [0.0.13] - 2025-05-12

### Added
- **📋 Self-contained `.intent/` directory** — `intent init` now copies templates, scripts, enhanced config, and agent context into `.intent/` for fully offline agent operation
- **🔬 Research command** — New `/intent.research` command with structured research workflow, comparison tables, dependency analysis, and risk assessment
- **📝 Research template** — New `templates/research-template.md` with full research document structure
- **🛠️ Research scripts** — New `create-research.sh` and `create-research.ps1` for setting up research environments
- **🚀 Enhanced init experience** — `intent init` now creates `.intent/templates/`, `.intent/scripts/`, `.intent/enhanced-config.json`, `.intent/AGENTS.md`, and `.intent/.gitignore`
- **🔧 Expanded init output** — Shows enabled enhanced features on initialization success

### Fixed
- **🐛 Path resolution in init** — Fixed `Path(__file__).parent.parent` to `.parent.parent.parent` to correctly find templates and scripts directory when running from development source tree

## [0.0.12] - 2025-10-25

### Added
- **🎨 Spectacular CLI UI** with animated banners, progress displays, and interactive menus
- **🎭 Enhanced ASCII art banner** with gradients, borders, emoji integration, and system info
- **⚡ Real-time progress tracking** with animated status indicators and completion bars
- **🎯 Interactive selection menus** with keyboard navigation and visual feedback
- **🚀 Welcome dashboard** with quick actions, pro tips, and rich panels
- **💎 Rich terminal UI components** using Rich library for professional presentation
- **🛠️ Enhanced features system** for advanced task generation and validation
- **🔄 Version control integration** for git branch tracking and commit messaging
- **🔧 CI/CD pipeline integration** capabilities with automated test validation
- **👁️ Real-time codebase validation** with cross-reference checking
- **📊 Advanced dependency graph analysis** with conflict detection and visualization
- **⚡ Performance optimizations** for large codebases with caching and incremental updates
- **📁 Expanded artifact support** (architecture diagrams, wireframes, API specs, data flow diagrams)
- **🔗 External integrations** support for Jira, GitHub Issues, Trello, Linear, Asana, Azure DevOps
- **📋 Custom artifact schemas** with JSON schema validation and versioning
- **🔍 Artifact discovery system** with automatic scanning and classification
- **⭐ Enhanced task quality** with configurable granularity, smart splitting, and estimation
- **🔗 Cross-artifact dependency management** with dynamic updates and impact analysis
- **✅ Quality validation checklists** automatically generated for tasks and artifacts
- **⚙️ Configurable enhanced features** via CLI options (`--enhanced`, `--all-enhanced`)
- **🔧 Artifact scanner scripts** for both bash and PowerShell platforms
- **📝 Enhanced configuration file** with customizable settings for all features

### Changed
- **🎨 Complete UI overhaul** with spectacular visual design and animations
- **📄 Enhanced all command templates** with feature integration and improved descriptions
- **🛡️ Standardized error handling** and progress tracking across all templates
- **📏 Improved template structure** with consistent formatting and markdown compliance
- **💻 CLI init command** now supports enhanced features configuration and spectacular UI
- **🔄 Task generation workflow** enhanced with git integration, validation, and automation
- **📚 Template standard documentation** created for consistency and maintainability

### Fixed
- **📝 Markdown linting issues** resolved in command templates
- **🔍 Type checking warnings** addressed with appropriate type ignore comments
- **💻 Syntax errors** corrected throughout the codebase
- **📏 Indentation consistency** improved across all files

## [0.0.1] - 2025-10-25

### Added
- Initial Intent Kit framework implementation
- Intent CLI with support for multiple AI agents
- Template system for intent-driven development
- Documentation structure with DocFX setup
- Script system (bash and PowerShell) for cross-platform support
- Memory system with constitution.md for project governance

### Changed
- Adapted from Intent Kit to Intent Kit methodology
- Updated all templates for intent-driven development approach
- Modified command structure from `/speckit.*` to `/intent.*`
- Updated documentation to reflect intent-driven development principles

### Removed
- Intent Kit specific references and terminology
- Legacy command structures not applicable to intent methodology

## [1.0.0] - 2024-10-24

### Added
- Initial release of Intent Kit
- Core intent-driven development framework
- Support for 14+ AI agents including Claude, Cursor, GitHub Copilot, and others
- Complete template system for specifications, plans, and tasks
- Cross-platform script support (bash/PowerShell)
- Comprehensive documentation and examples

### Features
- **Intent CLI**: Command-line interface for bootstrapping intent-driven projects
- **Template System**: Pre-built templates for specifications, implementation plans, and task breakdowns
- **Agent Integration**: Support for multiple AI coding assistants with agent-specific configurations
- **Quality Gates**: Built-in validation and quality checking mechanisms
- **Documentation**: Complete documentation with DocFX setup and comprehensive guides

---

## Versioning

This project follows semantic versioning:

- **Major**: Breaking changes to the intent methodology or CLI interface
- **Minor**: New features, agent support, or template additions
- **Patch**: Bug fixes, documentation updates, or minor improvements

## Release Process

1. Update version in `pyproject.toml`
2. Add changelog entry for the new version
3. Create release packages for all supported agents
4. Update documentation and examples
5. Tag and publish release

---

*For older changes, see the commit history on GitHub.*