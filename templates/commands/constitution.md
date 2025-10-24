---
description: Create or update project governing principles and development guidelines that will guide all subsequent development.
scripts:
  sh: scripts/bash/check-prerequisites.sh --json
  ps: scripts/powershell/check-prerequisites.ps1 -Json
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Goal

Establish the project's foundational principles, development guidelines, and quality standards that will govern all subsequent development activities. This creates the "constitution" that all AI agents and team members must follow.

## Operating Constraints

**FOUNDATIONAL AUTHORITY**: The constitution becomes the highest authority for the project. All subsequent specifications, plans, and implementations must align with these principles.

**NON-NEGOTIABLE**: Once established, constitution principles cannot be violated or ignored. If a principle needs to change, it must be explicitly updated through this command.

**COMPREHENSIVE COVERAGE**: The constitution must address all major aspects of development: quality, process, technology choices, user experience, and team collaboration.

## Execution Steps

### 1. Initialize Context

Run `{SCRIPT}` from repo root and parse JSON for project structure. Check if constitution already exists at `/memory/constitution.md`. For single quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot' (or double-quote if possible: "I'm Groot").

### 2. Analyze User Requirements

Parse the user's input to understand:
- Project type and domain
- Quality expectations
- Technology preferences or constraints
- Team size and collaboration model
- Target users and use cases
- Compliance or regulatory requirements
- Performance and scalability needs

### 3. Load Existing Constitution (if any)

If `/memory/constitution.md` exists:
- Read current principles
- Identify areas for enhancement or updates
- Preserve existing principles unless explicitly changed

### 4. Generate Constitution Structure

Create or update the constitution with the following sections:

#### Core Principles
- **Intent-Driven Development**: All work must start from clear user intent and requirements
- **Quality First**: Code quality, testing, and user experience are non-negotiable
- **Independent Verification**: Each user story must be independently testable and deliverable
- **Progressive Enhancement**: Build MVP first, then enhance incrementally

#### Development Standards
- **Code Quality**: Standards for code organization, naming, documentation
- **Testing Requirements**: Unit tests, integration tests, acceptance criteria
- **Documentation**: Code comments, API docs, user guides
- **Security**: Authentication, authorization, data protection standards

#### Process Guidelines
- **Specification First**: Requirements must be clear before implementation
- **Planning Required**: Technical approach must be defined before coding
- **Task Breakdown**: Work must be broken into manageable, trackable tasks
- **Review Process**: Code review, testing, and validation requirements

#### Technology Choices
- **Framework Selection**: Preferred frameworks, libraries, and tools
- **Architecture Patterns**: Design patterns and architectural principles
- **Deployment Strategy**: Development, staging, and production requirements
- **Monitoring**: Logging, metrics, and observability requirements

#### User Experience
- **Accessibility**: WCAG compliance and inclusive design requirements
- **Performance**: Response times, loading requirements
- **Responsive Design**: Cross-device compatibility requirements
- **Error Handling**: User-friendly error messages and recovery flows

#### Team Collaboration
- **Communication**: Meeting cadence, documentation standards
- **Code Review**: Review process and quality gates
- **Knowledge Sharing**: Documentation and onboarding requirements
- **Conflict Resolution**: Decision-making and escalation processes

### 5. Validate Constitution Completeness

Ensure the constitution addresses:
- ✅ All major development phases (Intent, plan, implement, deploy)
- ✅ Quality standards and validation criteria
- ✅ Technology and architecture guidelines
- ✅ Team collaboration and communication norms
- ✅ User experience and accessibility requirements
- ✅ Security and compliance considerations

### 6. Write Constitution File

Write the complete constitution to `/memory/constitution.md` using the following structure:

```markdown
# Project Constitution: [PROJECT_NAME]

**Created**: [DATE]
**Last Updated**: [DATE]
**Purpose**: Foundational principles and guidelines for all development activities

## Core Philosophy

[Intent-driven development principles and project vision]

## Development Standards

### Code Quality
- [Specific coding standards and requirements]
- [Documentation requirements]
- [Testing standards]

### Architecture
- [Architecture patterns and principles]
- [Technology stack guidelines]
- [Security requirements]

## Process Guidelines

### Development Workflow
- [Specification requirements]
- [Planning requirements]
- [Implementation standards]
- [Review and validation process]

### Quality Gates
- [Code review requirements]
- [Testing requirements]
- [Performance benchmarks]
- [Security validation]

## User Experience

### Accessibility
- [Accessibility standards]
- [Inclusive design requirements]

### Performance
- [Performance requirements]
- [Responsive design standards]

### Error Handling
- [Error handling standards]
- [User feedback requirements]

## Team Collaboration

### Communication
- [Meeting and communication standards]
- [Documentation requirements]

### Decision Making
- [Decision-making process]
- [Escalation procedures]

## Compliance & Security

### Data Protection
- [Data handling requirements]
- [Privacy standards]

### Regulatory Compliance
- [Compliance requirements]
- [Audit standards]

---

*This constitution is the highest authority for the project. All specifications, plans, and implementations must align with these principles.*
```

### 7. Update Agent Context

After creating/updating the constitution:
- Run the appropriate agent context update script
- Ensure all agents are aware of the new principles
- Update any relevant configuration files

### 8. Report Completion

Provide a summary of:
- What was created/updated
- Key principles established
- Next steps for the project

## Constitution Quality Criteria

### Completeness
- ✅ Addresses all development phases
- ✅ Covers quality, process, and collaboration
- ✅ Includes technology and architecture guidance
- ✅ Specifies user experience requirements

### Clarity
- ✅ Uses specific, actionable language
- ✅ Avoids vague terms without definition
- ✅ Provides clear rationale for each principle

### Enforceability
- ✅ Principles are testable/verifiable
- ✅ Standards are measurable
- ✅ Guidelines are actionable

## Common Constitution Elements

### For Web Applications
- Responsive design requirements
- Cross-browser compatibility
- Performance budgets (e.g., <2s load time)
- Accessibility standards (WCAG 2.1 AA)
- Security headers and HTTPS requirements

### For APIs
- RESTful design principles
- Rate limiting and throttling
- Authentication and authorization
- API documentation standards
- Error response formats

### For Mobile Applications
- Platform-specific design guidelines
- Offline capability requirements
- Push notification standards
- App store compliance requirements
- Battery and memory optimization

### For Enterprise Software
- Audit logging requirements
- Data retention policies
- Backup and recovery procedures
- Compliance reporting
- Multi-tenant architecture

## Operating Principles

### Authority
- **Highest Priority**: Constitution supersedes all other considerations
- **Non-Negotiable**: Principles cannot be violated without explicit update
- **Living Document**: Constitution evolves with project needs

### Implementation
- **Agent Training**: All AI agents must be configured with constitution awareness
- **Validation**: Regular checks ensure compliance with constitution
- **Updates**: Constitution changes require careful consideration and team consensus

## Context

{ARGS}