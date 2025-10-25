# Intent-Driven Development Agent Context

**Project**: intended
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
- **Research**: `intents/[FEATURE]/research.md`
- **Data Model**: `intents/[FEATURE]/data-model.md`
- **API Contracts**: `intents/[FEATURE]/contracts/`
- **Quickstart Guide**: `intents/[FEATURE]/quickstart.md`
- **Constitution**: `memory/constitution.md`

## Development Guidelines

1. **Intent-First**: Always start with clear user intent and requirements before implementation
2. **Independent Stories**: Each user story should be independently testable and deliverable
3. **Quality Gates**: Use checklists to validate requirements quality before proceeding
4. **Progressive Enhancement**: Build MVP first, then enhance incrementally
5. **Architecture First**: Address architecture and design decisions early in planning
6. **Security by Design**: Consider security implications from the beginning
7. **Performance Conscious**: Think about performance requirements during planning
8. **Test-Driven**: Consider tests when defining requirements and design

## Best Practices

- **User Stories**: Prioritize stories by business value and technical risk
- **Requirements**: Make them testable, specific, and unambiguous
- **Success Criteria**: Define measurable outcomes that align with business goals
- **Dependencies**: Identify and plan for technical dependencies early
- **Architecture**: Document key decisions with rationale in Architecture Decision Records (ADRs)

## Next Actions

[Current phase and immediate next steps]
