---
description: Execute the implementation planning workflow using the plan template to generate design artifacts with enhanced artifact discovery and validation.
scripts:
  sh: scripts/bash/setup-plan.sh --json
  ps: scripts/powershell/setup-plan.ps1 -Json
agent_scripts:
  sh: scripts/bash/update-agent-context.sh __AGENT__
  ps: scripts/powershell/update-agent-context.ps1 -AgentType __AGENT__
---

# User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Enhanced Features Integration

If enhanced features are enabled (`artifact_expansion`, `task_quality`, `dependency_graph`), this command will:

- **Automatically discover existing artifacts** using the artifact scanner
- **Validate artifact schemas** and check for version consistency
- **Analyze dependencies** between artifacts and external systems
- **Generate quality checklists** for the planning phase
- **Cache intermediate results** for improved performance

## Outline

1. **Setup**: Run `{SCRIPT}` from repo root and parse JSON for FEATURE_SPEC, IMPL_PLAN, SPECS_DIR, BRANCH. For single
quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot' (or double-quote if possible: "I'm Groot").

2. **Load context**: Read FEATURE_SPEC and `.intent/memory/constitution.md`. Load IMPL_PLAN template (already copied).

3. **Execute plan workflow**: Follow the structure in IMPL_PLAN template to:
     - Fill Technical Context (mark unknowns as "NEEDS CLARIFICATION")
     - Fill Architecture Decision Records section
     - Fill Technology Rationale section
     - Fill Constitution Check section from constitution
     - Evaluate gates (ERROR if violations unjustified)
     - Phase 0: Generate research.md (resolve all NEEDS CLARIFICATION)
     - Phase 1: Generate data-model.md, contracts/, quickstart.md
     - Phase 1: Update agent context by running the agent script
     - Re-evaluate Constitution Check post-design
     - Complete Project Structure based on research findings

4. **Stop and report**: Command ends after Phase 2 planning. Report branch, IMPL_PLAN path, and generated artifacts.

## Phases

### Phase 0: Outline & Research

1. **Extract unknowns from Technical Context** above:
     - For each NEEDS CLARIFICATION → research task
     - For each dependency → best practices task
     - For each integration → patterns task
     - For each technology decision → comparison task

2. **Generate and dispatch research agents**:

     ```text
     For each unknown in Technical Context:
       Task: "Research {unknown} for {feature context}"
     For each technology choice:
       Task: "Find best practices for {tech} in {domain}"
     For each architecture decision:
       Task: "Compare alternatives for {decision}: {option1} vs {option2} vs {option3}"
     ```

3. **Consolidate findings** in `research.md` using format:
     - Decision: [what was chosen]
     - Rationale: [why chosen]
     - Alternatives considered: [what else evaluated]
     - Key findings: [critical insights from research]
     - Risk assessment: [potential risks and mitigation strategies]
     - Implementation notes: [specific implementation details discovered]

**Output**: research.md with all NEEDS CLARIFICATION resolved

### Phase 1: Design & Contracts

**Prerequisites:** `research.md` complete

1. **Extract entities from feature intent** → `data-model.md`:
     - Entity name, fields, relationships
     - Validation rules from requirements
     - State transitions if applicable
     - Security and privacy considerations for each entity

2. **Generate API contracts** from functional requirements:
     - For each user action → endpoint
     - For each data access → API endpoint
     - Use standard REST/GraphQL patterns
     - Include authentication and authorization requirements
     - Output OpenAPI/GraphQL schema to `.intent/contracts/`
     - Include error response patterns

3. **Create detailed project structure**:
     - Map out specific directories and files based on research
     - Define technology-specific directory layouts
     - Plan for testing structure (unit, integration, contract tests)

4. **Agent context update**:
     - Run `{AGENT_SCRIPT}`
     - These scripts detect which AI agent is in use
     - Update the appropriate agent-specific context file
     - Add only new technology from current plan
     - Preserve manual additions between markers
     - Include key architecture decisions in agent context

5. **Create quickstart guide**:
     - Steps to set up the development environment
     - How to run the project locally
     - Key configuration settings
     - Common troubleshooting steps

**Output**: data-model.md, .intent/contracts/*, quickstart.md, agent-specific file

## Architecture Decision Guidelines

When making architectural decisions:

- Document significant decisions in Architecture Decision Records (ADRs)
- Consider alternatives for major technical choices
- Evaluate impact on performance, scalability, security, and maintainability
- Ensure decisions align with project constitution
- Plan for future evolution and extension

## Technical Context Guidelines

For each technical context element:

- Be specific about versions and configurations
- Consider performance, security, and scalability implications
- Plan for monitoring and observability
- Account for deployment environments
- Identify external dependencies and integration points

## Key rules

- Use absolute paths
- ERROR on gate failures or unresolved clarifications
- Prioritize security and performance in all design decisions
- Document all key technical decisions with rationale
- Ensure all generated artifacts are complete and actionable
