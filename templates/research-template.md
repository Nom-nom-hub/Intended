# Research Document: [FEATURE NAME]

**Feature Branch**: `[###-feature-name]`
**Created**: [DATE]
**Status**: Draft
**Research Request**: "$ARGUMENTS"

## Research Overview

**Purpose**: [Brief statement of why this research is needed and what decisions it will inform]

**Key Questions**:
- [Central question 1 that this research answers]
- [Central question 2 that this research answers]
- [Central question 3 that this research answers]

**Scope**: [Boundaries of this research - what is included and explicitly excluded]

---

## Technology Research

### [Technology Topic 1 - e.g., Framework Selection]

**Context**: [Which requirements from Intent.md drive this research decision]

| Option | Pros | Cons | Best For |
|--------|------|------|----------|
| [Option A] | [2-3 key advantages] | [2-3 key disadvantages] | [When to choose this] |
| [Option B] | [2-3 key advantages] | [2-3 key disadvantages] | [When to choose this] |
| [Option C] | [2-3 key advantages] | [2-3 key disadvantages] | [When to choose this] |

**Recommendation**: [Option A]
**Rationale**: [Clear explanation of why this option is recommended based on project requirements, team skills, ecosystem maturity, and constitution alignment]
**Constitution Alignment**: [How this aligns with the project constitution principles]

---

### [Technology Topic 2 - e.g., Database Selection]

**Context**: [Which requirements from Intent.md drive this research decision]

| Option | Pros | Cons | Best For |
|--------|------|------|----------|
| [Option A] | [2-3 key advantages] | [2-3 key disadvantages] | [When to choose this] |
| [Option B] | [2-3 key advantages] | [2-3 key disadvantages] | [When to choose this] |

**Recommendation**: [Option B]
**Rationale**: [Clear explanation with references to project constraints]
**Constitution Alignment**: [How this aligns with the project constitution principles]

---

## Architecture Research

### [Architecture Topic - e.g., State Management Approach]

**Context**: [Which requirements drive this decision]

**Considered Approaches**:
1. **[Approach A]**: [Brief description]
   - Strengths: [Key strength 1], [Key strength 2]
   - Weaknesses: [Key weakness 1], [Key weakness 2]
   - When appropriate: [Scenarios where this approach excels]

2. **[Approach B]**: [Brief description]
   - Strengths: [Key strength 1], [Key strength 2]
   - Weaknesses: [Key weakness 1], [Key weakness 2]
   - When appropriate: [Scenarios where this approach excels]

**Recommendation**: [Approach A]
**Rationale**: [Why this approach is preferred]
**Constitution Alignment**: [How this aligns with the project constitution]

---

## Dependency Analysis

### Required Dependencies

| Dependency | Version | Purpose | Risk Level | Alternative |
|------------|---------|---------|------------|-------------|
| [Dependency name] | [Version range] | [Why needed] | Low/Medium/High | [Alternative if applicable] |
| [Dependency name] | [Version range] | [Why needed] | Low/Medium/High | [Alternative if applicable] |

### Optional Dependencies

| Dependency | Version | Purpose | When to Add | Risk Level |
|------------|---------|---------|-------------|------------|
| [Dependency name] | [Version range] | [Why needed] | [Condition for including] | Low/Medium/High |

### Integration Points

| External System | Integration Pattern | Data Flow | Security Considerations |
|-----------------|-------------------|------------|------------------------|
| [System name] | REST/GraphQL/Event/etc. | [Direction and nature of data flow] | [Auth, encryption, etc.] |

---

## Risk Assessment

### Technical Risks

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| [Specific risk] | High/Medium/Low | High/Medium/Low | [Mitigation strategy] |
| [Specific risk] | High/Medium/Low | High/Medium/Low | [Mitigation strategy] |

### Dependency Risks

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| [Specific risk] | High/Medium/Low | High/Medium/Low | [Mitigation strategy] |

### Migration Risks (if applicable)

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| [Specific risk] | High/Medium/Low | High/Medium/Low | [Mitigation strategy] |

---

## Alternatives Considered

### Discarded Options

| Option | Why Considered | Why Discarded |
|--------|----------------|---------------|
| [Option] | [What problem it would solve] | [Reasons for not choosing] |
| [Option] | [What problem it would solve] | [Reasons for not choosing] |

---

## Key Decisions

Based on this research, the following decisions are recommended for the implementation plan:

1. **Decision 1**: [Decision] - [Brief rationale] ([Constitution reference])
2. **Decision 2**: [Decision] - [Brief rationale] ([Constitution reference])
3. **Decision 3**: [Decision] - [Brief rationale] ([Constitution reference])

## Open Questions

- [Question 1 that still needs resolution]
- [Question 2 that still needs resolution]

## References

- [Link or reference 1]
- [Link or reference 2]
- [Link or reference 3]

---

## Appendix: Research Methodology

**Sources consulted**:
- Official documentation and release notes
- Community benchmarks and comparisons
- Industry case studies and best practices
- Project-specific constraints and requirements

**Evaluation criteria**:
- Alignment with project requirements
- Maturity and community support
- Learning curve and team familiarity
- Long-term maintainability
- Cost and licensing considerations
