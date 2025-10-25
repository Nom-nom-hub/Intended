# Implementation Plan: [FEATURE]

**Template Version**: 2.0
**Branch**: `[###-feature-name]` | **Date**: [DATE] | **Intent**: [link]
**Input**: Feature intent from `/intents/[###-feature-name]/intent.md`

**Note**: This template is filled in by the `/intent.plan` command. See `.intent/templates/commands/plan.md` for the
execution workflow.

## Summary

[Extract from feature intent: primary requirement + technical approach from research.
Provide a high-level overview of what will be built and how the technical approach addresses the user needs.]

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
  Ensure all NEEDS CLARIFICATION items are resolved through research.
-->

**Language/Version**: [e.g., Python 3.11, Swift 5.9, Rust 1.75 or NEEDS CLARIFICATION]
**Primary Dependencies**: [e.g., FastAPI, UIKit, LLVM or NEEDS CLARIFICATION]
**Storage**: [if applicable, e.g., PostgreSQL, CoreData, files or N/A]
**Testing**: [e.g., pytest, XCTest, cargo test or NEEDS CLARIFICATION]
**Target Platform**: [e.g., Linux server, iOS 15+, WASM or NEEDS CLARIFICATION]
**Project Type**: [single/web/mobile - determines source structure]
**Performance Goals**: [domain-specific, e.g., 1000 req/s, 10k lines/sec, 60 fps or NEEDS CLARIFICATION]
**Constraints**: [domain-specific, e.g., <200ms p95, <100MB memory, offline-capable or NEEDS CLARIFICATION]
**Scale/Scope**: [domain-specific, e.g., 10k users, 1M LOC, 50 screens or NEEDS CLARIFICATION]
**Integration Points**: [List external systems/services that need to be integrated]
**Security Requirements**: [Specific security measures required, e.g., encryption, authentication methods]
**Deployment Environment**: [Where the feature will be deployed, e.g., AWS, Azure, on-premises]
**Monitoring & Logging**: [Requirements for observability, e.g., metrics, alerting, log levels]

## Architecture Decision Records

**ADR-001**: [Title of key architectural decision]

- **Context**: [Problem or situation that requires a decision]
- **Decision**: [What was decided and why]
- **Status**: [Proposed/Approved/Implemented/Deprecated]
- **Consequences**: [Positive and negative impacts of this decision]

[Add more ADRs as needed for major architectural decisions]

## Technology Rationale

**Selected Technologies**: [List key technologies chosen and why]

- **[Technology Name]**: [Reason for selection, alternatives considered, benefits]
- **[Technology Name]**: [Reason for selection, alternatives considered, benefits]

**Alternatives Considered**: [Brief analysis of alternatives rejected and why]

- **[Alternative 1]**: [Why it was not selected]
- **[Alternative 2]**: [Why it was not selected]

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

**Constitution Compliance Status**: [Pass/Fail - if fail, document justification]

[Gates determined based on constitution file]

- **Gate 1**: [Description of first constitution check]
- **Gate 2**: [Description of second constitution check]
- **Gate 3**: [Description of third constitution check]

## Project Structure

### Documentation (this feature)

```text
intents/[###-feature]/
├── plan.md              # This file (/intent.plan command output)
├── research.md          # Phase 0 output (/intent.plan command)
├── data-model.md        # Phase 1 output (/intent.plan command)
├── quickstart.md        # Phase 1 output (/intent.plan command)
├── contracts/           # Phase 1 output (/intent.plan command)
└── tasks.md             # Phase 2 output (/intent.tasks command - NOT created by /intent.plan)
```

### Source Code (repository root)
<!--
  ACTION REQUIRED: Replace the placeholder tree below with the concrete layout
  for this feature. Delete unused options and expand the chosen structure with
  real paths (e.g., apps/admin, packages/something). The delivered plan must
  not include Option labels.
-->

```text
# [REMOVE IF UNUSED] Option 1: Single project (DEFAULT)
src/
├── models/
├── services/
├── controllers/ or api/ or routes/
├── middleware/
├── utils/
├── config/
├── cli/
└── lib/

tests/
├── unit/
├── integration/
├── contract/
├── e2e/
└── fixtures/

# [REMOVE IF UNUSED] Option 2: Web application (when "frontend" + "backend" detected)
backend/
├── src/
│   ├── models/
│   ├── services/
│   ├── controllers/
│   └── middleware/
└── tests/

frontend/
├── src/
│   ├── components/
│   ├── pages/
│   ├── services/
│   ├── store/ or state/
│   └── assets/
└── tests/

# [REMOVE IF UNUSED] Option 3: Mobile + API (when "iOS/Android" detected)
api/
└── [same as backend above]

ios/ or android/
└── [platform-specific structure: feature modules, UI flows, platform tests]

# [REMOVE IF UNUSED] Option 4: Microservices (when multiple services detected)
services/
├── service-name-1/
├── service-name-2/
└── shared/
```

**Structure Decision**: [Document the selected structure and reference the real
directories captured above. Explain the reasoning for choosing this structure over alternatives.]

## API Design & Contracts

**API Version**: [Versioning strategy for this feature]
**API Style**: [REST/GraphQL/gRPC/other]
**Authentication**: [How the API will be secured]
**Rate Limiting**: [If applicable]

## Data Model Overview

**Primary Entities**: [High-level overview of key data structures]

- **[Entity Name]**: [Brief description and key attributes]
- **[Entity Name]**: [Brief description and key attributes]

**Relationships**: [Key relationships between entities]

- [Description of how entities relate to each other]

## Risk Assessment

### Technical Risks

| Risk | Impact | Probability | Mitigation Strategy |
|------|--------|-------------|-------------------|
| [Specific technical risk] | [High/Medium/Low] | [High/Medium/Low] | [How to mitigate or address the risk] |
| [Specific technical risk] | [High/Medium/Low] | [High/Medium/Low] | [How to mitigate or address the risk] |

### Dependencies & External Factors

- **External Dependencies**: [List of external services, APIs, or libraries the feature depends on]
- **Internal Dependencies**: [Other features or teams this feature depends on]
- **Timeline Dependencies**: [Any time-sensitive factors that could impact delivery]

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |

## Research Summary

**Key Findings**: [Summary of critical research findings that influenced the technical approach]

**Technical Decisions Made**: [Decisions that were made based on research]

- [Decision 1]: [Brief explanation]
- [Decision 2]: [Brief explanation]

**Remaining Unknowns**: [Any technical questions that still need to be answered during Phase 1]

## Validation Checklist

**Before proceeding to task generation, verify:**

- [ ] All [NEEDS CLARIFICATION] items from intent.md are resolved
- [ ] Architecture Decision Records document key decisions with rationale
- [ ] Project structure matches the selected architecture pattern
- [ ] API contracts are defined and compatible with chosen technology stack
- [ ] Risk assessment is complete with mitigation strategies
- [ ] Technology choices align with project requirements
- [ ] Data model aligns with functional requirements
- [ ] Performance and security requirements are addressed in design

## Troubleshooting Common Issues

### Technology Stack Selection Issues

**Problem**: Unable to determine appropriate technology stack
**Solution**:

- Review research.md for findings and recommendations
- Consider team expertise and existing infrastructure
- Start with proven technologies for the domain
- List 2-3 viable options with pros/cons

**Problem**: Multiple viable technology options with no clear winner
**Solution**:

- Create prototype with top 2 options to compare
- Consider integration with existing systems
- Evaluate long-term maintenance costs
- Get team input on preferences and expertise

### Architecture Decision Challenges

**Problem**: Difficulty making key architectural decisions
**Solution**:

- Document decision in ADR with clear rationale
- Consider impact on scalability, performance, security
- Review similar systems in the domain
- Consult with senior engineers if available

### Project Structure Confusion

**Problem**: Uncertain about directory structure for specific technology
**Solution**:

- Follow established conventions for the technology stack
- Review official documentation and recommended practices
- Look at similar open-source projects for reference
- Keep structure simple initially, evolve as needed

## Quality Scoring

**Rate each section from 1-5 (5 = Excellent):**

### Architecture Quality (Score: ___/5)

- [ ] Clear technology stack selection
- [ ] Justified technology choices
- [ ] Appropriate architecture pattern for requirements
- [ ] Addressed scalability considerations
- [ ] Security requirements included

### Design Quality (Score: ___/5)

- [ ] Complete data model design
- [ ] API contracts well-defined
- [ ] Project structure appropriate
- [ ] Risk assessment thorough
- [ ] Architecture Decision Records comprehensive

### Research Integration (Score: ___/5)

- [ ] Research findings incorporated
- [ ] Technical decisions justified
- [ ] Alternatives considered
- [ ] Remaining unknowns identified
- [ ] Risk mitigation strategies defined

### Overall Quality (Score: ___/5)

**Recommendation**: [Proceed to task generation / Needs revision / Needs major revision]

## Automated Testing Guidance

### Testing Strategy by Architecture Type

#### For Web Applications

- Frontend: Component tests, integration tests, E2E tests with tools like Jest, Cypress, or Playwright
- Backend: Unit tests, API tests, database integration tests
- Performance: Load testing with Artillery or k6

#### For APIs

- Contract testing with Pact or Spring Cloud Contract
- API testing with Postman/Newman or REST-assured
- Security testing with OWASP ZAP
- Performance: API endpoint load testing

#### For Microservices

- Service component tests
- Contract tests between services
- Integration tests at API gateway level
- Chaos engineering for resilience testing
- Distributed tracing validation

#### For Data Processing Systems

- Data validation tests
- Pipeline integration tests
- Schema evolution tests
- Performance and throughput tests

### Testing Implementation Guidelines

- **Test Pyramid**: Follow the 70% unit, 20% integration, 10% E2E ratio
- **Test organization**: Mirror your source code structure
- **Test data management**: Use factories/fixtures for consistent test data
- **Performance testing**: Define SLAs and monitor against them
- **Security testing**: Include authentication/authorization tests

## Dependency Tracking

### External Dependencies

| Dependency | Version | Purpose | Risk Level | Alternative |
|------------|---------|---------|------------|-------------|
| [Library/Service Name] | [Version/Spec] | [What it's used for] | [High/Medium/Low] | [Alternative solutions] |
| | | | | |
| | | | | |

### Internal Dependencies

- **Prerequisite Features**: [List features that must be completed first]
- **Shared Components**: [Components this feature will depend on]
- **Data Dependencies**: [Existing data models/processes this relies on]
- **Infrastructure**: [Required infrastructure components]

### Dependency Validation Checklist

- [ ] All external dependencies have been researched for security vulnerabilities
- [ ] Version constraints are specified appropriately
- [ ] Fallback strategies exist for critical dependencies
- [ ] Internal dependencies are stable and documented
- [ ] Performance impact of dependencies has been assessed

## Cross-Reference Validation

### Alignment with Intent.md

- [ ] All P1 user stories from intent.md are addressed in technical approach
- [ ] Success criteria from intent.md are considered in design decisions
- [ ] Non-functional requirements from intent.md are addressed in architecture
- [ ] Security considerations from intent.md are reflected in technical decisions
- [ ] Performance requirements from intent.md are achievable with selected approach

### Forward Compatibility for tasks.md

- [ ] All technical components needed are specific enough for task creation
- [ ] API contracts defined completely for implementation tasks
- [ ] Data model design clear enough for implementation tasks
- [ ] Project structure defined completely for setup tasks
- [ ] Risk mitigation strategies translate to specific implementation tasks
