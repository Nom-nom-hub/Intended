#!/usr/bin/env bash

# Load common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

set -e

print_info "Updating agent context..."

# Resolve repository root
REPO_ROOT="$(resolve_repo_root)"
cd "$REPO_ROOT"

# Check if we have a constitution
CONSTITUTION_FILE="$REPO_ROOT/.intent/memory/constitution.md"
if [ ! -f "$CONSTITUTION_FILE" ]; then
    print_warning "Constitution not found: $CONSTITUTION_FILE"
    print_info "Creating default constitution..."

    mkdir -p "$REPO_ROOT/.intent/memory"

    cat > "$CONSTITUTION_FILE" << 'EOF'
# Intent Kit Constitution

## Core Principles

### I. Intent-First Development
Every feature begins with a clear, unambiguous statement of intent. Intent specifications define **what** users need and **why**, without specifying **how** to implement. Implementation details emerge from intent, not the other way around.

### II. AI-Augmented Workflow
AI agents are powerful collaborators, not autonomous systems. Human oversight, judgment, and decision-making remain essential throughout the development process. AI suggestions are validated, refined, and approved by human developers.

### III. Quality Through Structure
Quality emerges from structured processes, not from individual brilliance. Every project follows the Intent-Driven Development methodology: Constitution → Specify → Plan → Tasks → Implement, with clarification and analysis as needed.

### IV. Testability as Foundation
Every requirement must be independently testable. User stories are prioritized by business value and can be developed, tested, and deployed independently. Success criteria are measurable and technology-agnostic.

### V. Transparency and Documentation
All decisions, assumptions, and trade-offs are documented. Specifications are written for business stakeholders. Technical decisions include clear rationale. The development process is visible and understandable to all participants.

## Development Standards

### Code Quality
- **Readability over cleverness**: Code should be understandable by developers of varying experience levels
- **Consistency over perfection**: Follow established patterns and conventions within each project
- **Simplicity over complexity**: Choose the simplest solution that meets requirements
- **Maintainability over optimization**: Write code that can be easily modified and extended

### Testing Standards
- **Test-Driven Development**: Write tests before implementation when practical
- **Independent testability**: Each user story must be testable in isolation
- **Comprehensive coverage**: Test both happy paths and edge cases
- **Automated validation**: Use automated tests to prevent regressions

### Documentation Standards
- **User-focused**: Documentation serves end users and stakeholders first
- **Developer-friendly**: Include technical details needed for maintenance and extension
- **Current and accurate**: Documentation reflects the current state of the system
- **Accessible**: Use clear language and provide examples

## Technology Philosophy

### Appropriate Technology Selection
- **Fit over fashion**: Choose technologies that solve the actual problem
- **Maturity over novelty**: Prefer proven solutions over bleeding-edge technologies
- **Integration over isolation**: Consider how new components fit into the existing ecosystem
- **Evolution over revolution**: Plan for gradual improvement rather than wholesale replacement

### Architecture Principles
- **Separation of concerns**: Each component has a single, well-defined responsibility
- **Dependency management**: Minimize coupling between components
- **Interface design**: Design clean, stable interfaces between systems
- **Performance consideration**: Plan for scale from the beginning

## Process Governance

### Decision Making
- **Principle-based**: All decisions must align with the constitution
- **Documented rationale**: Technical choices include clear justification
- **Stakeholder involvement**: Include relevant stakeholders in significant decisions
- **Reversible when possible**: Prefer reversible decisions over permanent commitments

### Quality Gates
- **Specification completeness**: All requirements are clear and testable
- **Plan validation**: Technical approach is feasible and appropriate
- **Implementation review**: Code meets quality and security standards
- **Testing validation**: All tests pass and cover critical functionality

### Communication Standards
- **Clear intent**: All communication focuses on outcomes, not implementation details
- **Regular updates**: Keep stakeholders informed of progress and challenges
- **Issue resolution**: Address problems promptly and transparently
- **Knowledge sharing**: Document solutions for future reference

**Version**: 1.0.0 | **Established**: 2025-01-01 | **Last Amended**: Never
EOF

    print_success "Created default constitution: $CONSTITUTION_FILE"
fi

# Check if we have templates
TEMPLATES_DIR="$REPO_ROOT/.intent/templates"
if [ ! -d "$TEMPLATES_DIR" ]; then
    print_warning "Templates directory not found: $TEMPLATES_DIR"
    print_info "Creating basic templates..."

    mkdir -p "$TEMPLATES_DIR/commands"

    # Create basic Intent template
    cat > "$TEMPLATES_DIR/Intent-template.md" << 'EOF'
# Feature Specification: [FEATURE NAME]

**Feature Branch**: `[###-feature-name]`
**Created**: [DATE]
**Status**: Draft
**Input**: User description: "$ARGUMENTS"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - [Brief Title] (Priority: P1)

[Describe this user journey in plain language]

**Why this priority**: [Explain the value and why it has this priority level]

**Independent Test**: [Describe how this can be tested independently]

**Acceptance Scenarios**:

1. **Given** [initial state], **When** [action], **Then** [expected outcome]
2. **Given** [initial state], **When** [action], **Then** [expected outcome]

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST [specific capability]
- **FR-002**: Users MUST be able to [key interaction]
- **FR-003**: System MUST [behavior or constraint]

### Key Entities *(include if feature involves data)*

- **[Entity 1]**: [What it represents, key attributes without implementation]
- **[Entity 2]**: [What it represents, relationships to other entities]

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: [Measurable metric, e.g., "Users can complete task in under 2 minutes"]
- **SC-002**: [Measurable metric, e.g., "System handles 1000 concurrent users"]
- **SC-003**: [Measurable metric, e.g., "99% uptime during business hours"]
EOF

    # Create basic plan template
    cat > "$TEMPLATES_DIR/plan-template.md" << 'EOF'
# Implementation Plan: [FEATURE NAME]

**Created**: [DATE]
**Status**: Draft

## Technical Approach

### Technology Stack
[Specify the technology stack and rationale]

### Architecture Overview
[High-level architecture description]

## Implementation Strategy

### Phase 1: [Phase Name]
- [Task 1]
- [Task 2]

### Phase 2: [Phase Name]
- [Task 1]
- [Task 2]

## Integration Points
[Describe how components integrate]

## Risk Assessment
[Identify potential risks and mitigation strategies]
EOF

    # Create basic tasks template
    cat > "$TEMPLATES_DIR/tasks-template.md" << 'EOF'
# Task Breakdown: [FEATURE NAME]

**Created**: [DATE]
**Status**: Draft

## User Story 1: [Story Title]

### Tasks:
- [ ] Task 1 - [Description]
- [ ] Task 2 - [Description]
- [ ] Task 3 - [Description]

## User Story 2: [Story Title]

### Tasks:
- [ ] Task 1 - [Description]
- [ ] Task 2 - [Description]

## Dependencies
[Note any dependencies between tasks]

## Parallel Execution
[Mark tasks that can run in parallel with [P]]
EOF

    print_success "Created basic templates in: $TEMPLATES_DIR"
fi

# Check if we have command templates
COMMANDS_DIR="$TEMPLATES_DIR/commands"
if [ ! -d "$COMMANDS_DIR" ]; then
    print_warning "Command templates not found: $COMMANDS_DIR"
    print_info "Creating command templates..."

    # Create specify command template
    cat > "$COMMANDS_DIR/specify.md" << 'EOF'
---
description: Create or update the feature specification from a natural language feature description.
scripts:
  sh: scripts/bash/create-new-feature.sh --json "{ARGS}"
  ps: scripts/powershell/create-new-feature.ps1 -Json "{ARGS}"
---

## User Input

```text
$ARGUMENTS
```

## Outline

1. Parse user description from Input
2. Generate branch name and feature number
3. Create feature directory and specification file
4. Set up basic template structure
5. Return branch name and file paths
EOF

    # Create plan command template
    cat > "$COMMANDS_DIR/plan.md" << 'EOF'
---
description: Create technical implementation plan for the current feature.
scripts:
  sh: scripts/bash/setup-plan.sh
  ps: scripts/powershell/setup-plan.ps1
---

## Outline

1. Check current feature context
2. Create plan directory structure
3. Generate implementation plan template
4. Create research and quickstart documents
5. Set up for task breakdown
EOF

    print_success "Created command templates in: $COMMANDS_DIR"
fi

# Make scripts executable
make_scripts_executable "$REPO_ROOT/.intent/scripts"

print_success "Agent context updated successfully!"
echo ""
print_info "Available commands:"
echo "• /intentkit.constitution - Establish project principles"
echo "• /intentkit.specify - Create feature specifications"
echo "• /intentkit.plan - Create implementation plans"
echo "• /intentkit.tasks - Generate task breakdowns"
echo "• /intentkit.implement - Execute implementation"
echo ""
print_info "Project structure ready at: $REPO_ROOT"