#!/usr/bin/env pwsh

# Load common functions
. (Join-Path $PSScriptRoot "common.ps1")

Write-Info "Updating agent context..."

# Resolve repository root
$repoRoot = Get-RepoRoot
Set-Location $repoRoot

# Check if we have a constitution
$constitutionFile = Join-Path $repoRoot ".intent\memory\constitution.md"
if (-not (Test-Path $constitutionFile)) {
    Write-Warning "Constitution not found: $constitutionFile"
    Write-Info "Creating default constitution..."

    $memoryDir = Join-Path $repoRoot ".intent\memory"
    New-Item -ItemType Directory -Force -Path $memoryDir | Out-Null

    $constitutionContent = @'
# Intent Kit Constitution

## Core Principles

### I. Intent-First Development
Every feature begins with a clear, unambiguous statement of intent. Intent specifications define **what** users need and **why**, without specifying **how** to implement. Implementation details emerge from intent, not the other way around.

### II. AI-Augmented Workflow
AI agents are powerful collaborators, not autonomous systems. Human oversight, judgment, and decision-making remain essential throughout the development process. AI suggestions are validated, refined, and approved by human developers.

### III. Quality Through Structure
Quality emerges from structured processes, not from individual brilliance. Every project follows the Intent-Driven Development methodology: Constitution → Intended → Plan → Tasks → Implement, with clarification and analysis as needed.

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

**Version**: 1.0.0 | **Established**: 2025-01-01 | **Last Amended**: Never
'@

    Set-Content -Path $constitutionFile -Value $constitutionContent
    Write-Success "Created default constitution: $constitutionFile"
}

# Check if we have templates
$templatesDir = Join-Path $repoRoot ".intent\templates"
if (-not (Test-Path $templatesDir)) {
    Write-Warning "Templates directory not found: $templatesDir"
    Write-Info "Creating basic templates..."

    $commandsDir = Join-Path $templatesDir "commands"
    New-Item -ItemType Directory -Force -Path $templatesDir, $commandsDir | Out-Null

    # Create basic Intent template
    $specTemplate = Join-Path $templatesDir "Intent-template.md"
    $specContent = @'
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

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST [specific capability]
- **FR-002**: Users MUST be able to [key interaction]

### Key Entities *(include if feature involves data)*

- **[Entity 1]**: [What it represents, key attributes without implementation]

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: [Measurable metric, e.g., "Users can complete task in under 2 minutes"]
- **SC-002**: [Measurable metric, e.g., "System handles 1000 concurrent users"]
'@
    Set-Content -Path $specTemplate -Value $specContent

    # Create basic plan template
    $planTemplate = Join-Path $templatesDir "plan-template.md"
    $planContent = @'
# Implementation Plan: [FEATURE NAME]

**Created**: [DATE]
**Status**: Draft

## Technical Approach

### Technology Stack
[Intended the technology stack and rationale]

### Architecture Overview
[High-level architecture description]

## Implementation Strategy

### Phase 1: [Phase Name]
- [Task 1]
- [Task 2]

## Integration Points
[Describe how components integrate]

## Risk Assessment
[Identify potential risks and mitigation strategies]
'@
    Set-Content -Path $planTemplate -Value $planContent

    # Create basic tasks template
    $tasksTemplate = Join-Path $templatesDir "tasks-template.md"
    $tasksContent = @'
# Task Breakdown: [FEATURE NAME]

**Created**: [DATE]
**Status**: Draft

## User Story 1: [Story Title]

### Tasks:
- [ ] Task 1 - [Description]
- [ ] Task 2 - [Description]

## User Story 2: [Story Title]

### Tasks:
- [ ] Task 1 - [Description]
- [ ] Task 2 - [Description]

## Dependencies
[Note any dependencies between tasks]
'@
    Set-Content -Path $tasksTemplate -Value $tasksContent

    Write-Success "Created basic templates in: $templatesDir"
}

# Check if we have command templates
$commandsDir = Join-Path $templatesDir "commands"
if (-not (Test-Path $commandsDir)) {
    Write-Warning "Command templates not found: $commandsDir"
    Write-Info "Creating command templates..."

    # Create Intended command template
    $specifyTemplate = Join-Path $commandsDir "Intended.md"
    $specifyContent = @'
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
'@
    Set-Content -Path $specifyTemplate -Value $specifyContent

    # Create plan command template
    $planTemplate = Join-Path $commandsDir "plan.md"
    $planContent = @'
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
'@
    Set-Content -Path $planTemplate -Value $planContent

    Write-Success "Created command templates in: $commandsDir"
}

Write-Success "Agent context updated successfully!"
Write-Host ""
Write-Info "Available commands:"
Write-Host "• /intentkit.constitution - Establish project principles" -ForegroundColor DarkGray
Write-Host "• /intentkit.Intended - Create feature specifications" -ForegroundColor DarkGray
Write-Host "• /intentkit.plan - Create implementation plans" -ForegroundColor DarkGray
Write-Host "• /intentkit.tasks - Generate task breakdowns" -ForegroundColor DarkGray
Write-Host "• /intentkit.implement - Execute implementation" -ForegroundColor DarkGray
Write-Host ""
Write-Info "Project structure ready at: $repoRoot" -ForegroundColor DarkGray