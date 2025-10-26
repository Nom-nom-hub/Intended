---
description: Clarify underspecified areas in the current feature specification through structured questioning with enhanced artifact analysis and dependency discovery.
scripts:
  sh: scripts/bash/check-prerequisites.sh --json --require-Intent
  ps: scripts/powershell/check-prerequisites.ps1 -Json -RequireSpec
---

# User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Enhanced Features Integration

With enhanced features enabled, clarification includes:

- **Artifact-driven Questions**: Generate questions based on discovered project artifacts
- **Dependency Analysis**: Identify clarification needs related to external dependencies
- **Quality Assessment**: Evaluate specification clarity against quality metrics
- **Automated Gap Detection**: Use heuristics to identify underspecified areas

## Goal

Perform structured clarification of the current feature specification to resolve ambiguities, gaps, and underspecified
areas before proceeding to planning. This command should be run after `/intent.Intended` but before `/intent.plan`.

## Operating Constraints

**READ-ONLY ANALYSIS**: Do not modify the Intent.md file directly. Instead, ask targeted clarification questions and wait
for user responses.

**STRUCTURED APPROACH**: Use systematic, coverage-based questioning that records answers in a structured format for later
integration.

**CONSTITUTION AWARE**: All clarification questions must respect the project constitution (`/memory/constitution.md`) and
not propose solutions that violate established principles.

## Execution Steps

### 1. Initialize Context

Run `{SCRIPT}` from repo root and parse JSON for FEATURE_DIR and AVAILABLE_DOCS. Derive absolute paths:

- Intent = FEATURE_DIR/Intent.md
- CONSTITUTION = /memory/constitution.md

Abort with error if Intent.md is missing. For single quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot'
(or double-quote if possible: "I'm Groot").

### 2. Load and Analyze Current Intent

Load the current Intent.md and analyze for:

**Ambiguity Detection:**

- Vague adjectives lacking measurable criteria (fast, scalable, secure, intuitive, robust)
- Unresolved placeholders (TODO, TKTK, ???, `<placeholder>`, [NEEDS CLARIFICATION])
- Requirements with verbs but missing objects or measurable outcomes
- User stories missing acceptance criteria alignment

**Gap Detection:**

- Missing edge cases or error scenarios
- Incomplete user journey coverage
- Underspecified non-functional requirements
- Missing dependencies or assumptions

**Constitution Alignment:**

- Any requirements conflicting with MUST principles
- Missing mandated quality gates or processes

### 3. Generate Clarification Questions

Create a structured set of clarification questions (maximum 5) organized by priority:

**Question Categories (in priority order):**

1. **Scope & Boundaries** - What is/isn't included
2. **Security & Compliance** - Critical requirements
3. **User Experience** - Primary user journey details
4. **Technical Constraints** - Performance, compatibility
5. **Edge Cases** - Error handling, boundary conditions

**Question Format:**
Each question should:

- Be specific and actionable
- Reference the relevant Intent section
- Provide 2-4 concrete options when possible
- Explain implications of each choice
- Allow for custom user input

**Example Question Structure:**

```markdown
## Question 1: Authentication Method

**Context**: Intent §FR-006 mentions user authentication but doesn't specify the method.

**Current**: "System MUST authenticate users"

**What we need to know**: Which authentication method should be implemented?

**Options**:

| Method | Description | Implications |
|--------|-------------|--------------|
| A | Email/Password | Standard web authentication, requires password reset flow, user manages credentials |
| B | OAuth2/Social | Integration with Google, GitHub, etc., simpler for users, requires external service |
| C | Magic Links | Passwordless, email-based, better UX but requires reliable email delivery |
| D | Multi-Factor Auth | Enhanced security with multiple verification methods, more complex UX |
| E | Custom | [Describe your preferred approach] |

**Your choice**: _[Wait for user response: A, B, C, D, or E with custom details]_
```

### 7. Documentation of Clarifications

After user responds, create a clarifications log that records:

- Original ambiguous requirement
- Clarification question asked
- User's answer
- Impact on technical decisions or implementation approach
- How the answer will be incorporated into plan.md and tasks.md

### 4. Present Questions and Collect Answers

Output all clarification questions in a single, well-formatted response. Wait for user to provide answers for all questions
before proceeding.

**Response Format:**

- Number questions sequentially (Q1, Q2, Q3, etc.)
- Group related questions when appropriate
- Provide clear context for each question
- Make options concrete and actionable

### 5. Validate Answers Against Constitution

For each user answer:

- Check alignment with constitution principles
- Flag any conflicts or concerns
- Suggest alternatives if needed

### 6. Summarize Clarifications

After receiving all answers, provide a summary of:

- What was clarified
- Impact on the specification
- Next recommended steps

## Question Generation Guidelines

### Prioritization Rules

1. **Scope questions first** - Boundaries determine everything else
2. **Security/Compliance second** - Critical for risk management
3. **Core UX third** - Primary user journey must be clear
4. **Technical constraints fourth** - Performance, compatibility
5. **Edge cases last** - Important but less critical

### Question Quality Criteria

- **Specific**: Ask about concrete decisions, not vague concepts
- **Actionable**: Each question should lead to implementable requirements
- **Limited**: Maximum 5 questions total
- **Constitution-aligned**: Never propose anti-patterns or principle violations
- **User-focused**: Frame questions in terms of user value and experience

### Common Clarification Areas

**Scope & Boundaries:**

- What user types/roles are supported?
- Which platforms/browsers must be supported?
- What data sources or external services are involved?
- Are there any specific compliance requirements?

**Security & Privacy:**

- What sensitive data needs protection?
- Are there specific authentication/authorization requirements?
- What audit logging is needed?
- Any regulatory compliance (GDPR, HIPAA, etc.)?

**User Experience:**

- What are the primary user workflows?
- How should errors be communicated to users?
- What accessibility requirements exist?
- Are there performance expectations from user perspective?

**Technical Constraints:**

- What are the performance/scalability requirements?
- Are there specific technology or platform constraints?
- What deployment or infrastructure requirements exist?
- Any integration requirements with existing systems?

**Edge Cases:**

- How should the system handle errors or failures?
- What happens with network connectivity issues?
- How does the system behave with invalid inputs?
- What are the data validation requirements?

## Operating Principles

### Context Efficiency

- **Targeted questions**: Only ask about genuinely ambiguous areas
- **Progressive disclosure**: Start with high-impact questions
- **User autonomy**: Always provide options and allow custom input
- **Constitution first**: Never violate established principles

### Analysis Guidelines

- **Evidence-based**: Only ask about issues actually present in the Intent
- **Impact-driven**: Prioritize questions by implementation impact
- **Solution-oriented**: Frame questions to lead toward implementable requirements
- **Respectful**: Acknowledge user expertise and domain knowledge

## Context

{ARGS}
