# Intent-Driven Development Agent Context

**Project**: Intent-Kit
**Purpose**: Agent-specific configuration and context for intent-driven development
**Updated**: [DATE]

## Intent Methodology Commands

The following slash commands are available for intent-driven development:

### Core Commands

- `/intent.constitution` - Create or update project governing principles and development guidelines
- `/intent.Intended` - Define what you want to build (requirements and user stories)
- `/intent.plan` - Create technical implementation plans with your chosen tech stack
- `/intent.tasks` - Generate actionable task lists for implementation
- `/intent.implement` - Execute all tasks to build the feature according to the plan

### Optional Commands

- `/intent.clarify` - Clarify underspecified areas (recommended before `/intent.plan`)
- `/intent.analyze` - Cross-artifact consistency & coverage analysis
- `/intent.checklist` - Generate custom quality checklists for requirements validation

## Project Context

**Current Feature**: [FEATURE_NAME]
**Branch**: [BRANCH_NAME]
**Status**: [STATUS]

## Available Documentation

- **Intent**: `intents/[FEATURE]/intent.md`
- **Implementation Plan**: `intents/[FEATURE]/plan.md`
- **Tasks**: `intents/[FEATURE]/tasks.md`
- **Constitution**: `memory/constitution.md`

## Development Guidelines

1. **Intent-First**: Always start with clear user intent and requirements before implementation
2. **Independent Stories**: Each user story should be independently testable and deliverable
3. **Quality Gates**: Use checklists to validate requirements quality before proceeding
4. **Progressive Enhancement**: Build MVP first, then enhance incrementally

## Next Actions

[Current phase and immediate next steps]
