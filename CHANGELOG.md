# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/Intent/v2.0.0.html).

## [Unreleased]

## [0.0.12] - 2025-10-25

### Added
- Enhanced features system for advanced task generation
- Version control integration for git branch tracking
- CI/CD pipeline integration capabilities
- Real-time codebase validation features
- Advanced dependency graph analysis
- Performance optimizations for large codebases
- Expanded artifact support (architecture diagrams, wireframes, API specs)
- Enhanced task quality with configurable granularity and smart splitting
- Cross-artifact dependency management with conflict resolution
- Dynamic dependency graph updates and impact analysis
- Artifact discovery and classification system
- Enhanced configuration file with customizable settings
- Artifact scanner scripts for both bash and PowerShell
- Configurable enhanced features via CLI options (`--enhanced`, `--all-enhanced`)
- Updated tasks.md template with comprehensive automation and validation improvements

### Changed
- Enhanced all command templates with enhanced features integration
- Added standardized error handling and progress tracking sections
- Updated template descriptions to reflect enhanced capabilities
- Created template standard documentation for consistency
- CLI init command now supports enhanced features configuration
- Improved task generation workflow with git integration and validation

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