---
description: Conduct structured technology and domain research to inform implementation planning with enhanced artifact discovery and dependency analysis.
scripts:
  sh: scripts/bash/create-research.sh --json
  ps: scripts/powershell/create-research.ps1 -Json
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

With enhanced features enabled, research includes:

- **Artifact Context Awareness**: Reference existing project artifacts during research
- **Dependency Discovery**: Identify potential external dependencies and integrations
- **Quality-driven Research**: Apply quality standards from the constitution during analysis
- **Impact Analysis**: Assess downstream effects of technology choices and architecture decisions

## Goal

Conduct structured research on technology choices, architecture patterns, dependencies, and domain considerations to inform the implementation plan. This command should be run after `/intent.clarify` but before `/intent.plan`.

## Operating Constraints

**READ-ONLY ARTIFACTS**: Do not modify Intent.md or other specification files during research. Output goes to the research directory only.

**CONSTITUTION ALIGNED**: All research and recommendations must respect the project constitution (`.intent/memory/constitution.md`) and not propose solutions that violate established principles.

**EVIDENCE-BASED**: Research findings must be supported by references, comparisons, or logical reasoning. Avoid unsupported opinions.

**SCOPE-BOUNDED**: Research should focus on areas that directly impact implementation decisions. Avoid exhaustive exploration of tangential topics.

## Execution Steps

### 1. Initialize Context

Run `{SCRIPT}` from repo root and parse JSON for RESEARCH_DIR, BRANCH_NAME, and FEATURE_DIR. Derive absolute paths:

- Intent = `.intent/Intent.md`
- PLAN = `.intent/plan.md` (if exists)
- CONSTITUTION = `.intent/memory/constitution.md`

For single quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot' (or double-quote if possible: "I'm Groot").

If script indicates no active feature branch, abort with instructions to run `/intent.intend` first.

### 2. Load Context Artifacts

Load the following artifacts for context:

**From Intent.md:**

- Functional and non-functional requirements
- Key entities and data considerations
- Success criteria and thresholds
- Edge cases and error scenarios

**From constitution:**

- Core principles and development standards
- Technology philosophy and architecture guidance
- Quality gates and process governance

### 3. Determine Research Areas

Based on the user's input and existing artifacts, identify specific research areas. The user's input may specify exact technologies to research, or may be broad (e.g., "research database options"). Use these categories:

**Technology Research:**

- Framework and library options (compare 2-3 alternatives)
- Language runtime considerations
- Tooling and build system choices
- Deployment and infrastructure options

**Architecture Research:**

- Design pattern suitability
- Integration patterns for external services
- Data flow and storage strategies
- Scalability and performance approaches

**Dependency Research:**

- External service providers and APIs
- Third-party library compatibility
- Version compatibility and migration paths
- Licensing and compliance considerations

**Domain Research:**

- Industry best practices for the problem domain
- Common pitfalls and anti-patterns
- Regulatory or compliance considerations
- Accessibility and UX standards

### 4. Conduct Structured Research

For each research area identified, produce structured findings:

**Comparison Format:**

```markdown
### [Research Topic]

**Context**: Why this research is needed (reference specific requirements from Intent.md)

**Options**:

| Option | Pros | Cons | Best For |
|--------|------|------|----------|
| [Option A] | [2-3 key advantages] | [2-3 key disadvantages] | [When to choose this] |
| [Option B] | [2-3 key advantages] | [2-3 key disadvantages] | [When to choose this] |
| [Option C] | [2-3 key advantages] | [2-3 key disadvantages] | [When to choose this] |

**Recommendation**: [Clear, justified recommendation with rationale]

**Constitution Alignment**: [How this aligns with the project constitution]
```

**Depth Guidelines:**

- For simple decisions (e.g., which CSS framework): Brief comparison table
- For complex decisions (e.g., database selection): Detailed analysis with trade-offs
- For domain research: Focus on actionable findings, not theoretical deep-dives

### 5. Identify Dependencies and Integration Points

Document external dependencies and integration considerations:

- **Required services**: External APIs, platforms, or infrastructure needed
- **Data dependencies**: Data sources, formats, and transformation needs
- **Tooling requirements**: Build tools, testing infrastructure, monitoring
- **Integration complexity**: Estimated effort and risk level for each integration

### 6. Assess Risks and Mitigations

Identify risks discovered during research:

- **Technical risk**: Unfamiliar technology, complex integration, performance concerns
- **Dependency risk**: Third-party reliability, version stability, licensing
- **Timeline risk**: Learning curve, implementation complexity, unknown unknowns
- **Migration risk**: If replacing existing technology, consider migration path

### 7. Write Research Document

Write the research findings to the research document at the path provided by the script output.

Use the research template structure (see `templates/research-template.md`) to organize findings. Follow the template sections but adapt depth as appropriate for each research area.

**Quality criteria for research document:**

- Every recommendation includes clear rationale
- Comparisons include at least 2-3 viable options
- Trade-offs are explicitly called out
- Constitution alignment is noted
- Dependencies and risks are documented
- Research areas are prioritized by implementation impact

### 8. Report Completion

Report completion with:

- Research document path
- Number of research areas explored
- Key decisions supported by research
- Technologies evaluated
- Risks identified
- Readiness for planning phase

## Research Quality Guidelines

### Depth Guidelines

- **Critical decisions** (core tech stack, architecture): Detailed analysis with 3+ options
- **Important decisions** (library choice, tooling): Comparison of 2-3 alternatives
- **Minor decisions** (utility libraries, formatting tools): Brief recommendation

### What NOT to Research

- Standard language features (assume proficiency)
- Well-established patterns (unless multiple valid alternatives exist)
- Trivial implementation details (focus on significant decisions)
- Topics already decided by the constitution

### Common Research Areas by Project Type

**Web Applications:**
- Frontend framework (React, Vue, Svelte, etc.)
- CSS approach (Tailwind, CSS-in-JS, vanilla CSS)
- State management patterns
- Hosting and deployment options

**APIs:**
- API framework (Express, FastAPI, ASP.NET, etc.)
- API design style (REST, GraphQL, gRPC)
- Authentication/authorization approach
- Rate limiting and throttling strategies

**Mobile Applications:**
- Cross-platform vs native approach
- Navigation and routing patterns
- Offline storage strategies
- Push notification services

**Data Processing:**
- Batch vs streaming architecture
- Storage technology (relational, document, columnar)
- Processing framework selection
- Monitoring and alerting approach

## Error Handling

**NO ACTIVE FEATURE**: If no feature branch or INTENT_FEATURE is detected, abort and instruct the user to run `/intent.intend` first.

**MISSING INTENT**: If Intent.md is missing or empty, abort and instruct user to create intent first.

**CONSTITUTION VIOLATION**: If research recommendations would violate the constitution, note the conflict and suggest alternatives.

**AMBIGUOUS REQUEST**: If the user's research request is too vague, focus on the most impactful research areas based on Intent.md requirements.

## Context

{ARGS}
