---
description: Execute all tasks to build the feature according to the implementation plan.
scripts:
  sh: scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks
  ps: scripts/powershell/check-prerequisites.ps1 -Json -RequireTasks -IncludeTasks
---

# User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Goal

Execute the complete implementation plan by working through all tasks in the correct order, respecting dependencies and
parallel execution opportunities. This command transforms the detailed task breakdown into working code.

## Operating Constraints

**PREREQUISITE VALIDATION**: Must have complete intent.md, plan.md, and tasks.md before starting implementation.

**DEPENDENCY RESPECT**: Execute tasks in the order specified, respecting all dependencies and parallel execution markers.

**CONSTITUTION COMPLIANCE**: All implementation must adhere to the project constitution (`/memory/constitution.md`).

**ERROR RECOVERY**: Handle errors gracefully and provide clear feedback for resolution.

**QUALITY ASSURANCE**: Maintain high code quality and test coverage throughout the implementation process.

## Execution Steps

### 1. Initialize Implementation Context

Run `{SCRIPT}` from repo root and parse JSON for FEATURE_DIR and AVAILABLE_DOCS. Derive absolute paths:

- Intent = FEATURE_DIR/Intent.md
- PLAN = FEATURE_DIR/plan.md
- TASKS = FEATURE_DIR/tasks.md
- CONSTITUTION = /memory/constitution.md

Validate all required files exist and are complete. For single quotes in args like "I'm Groot", use escape syntax: e.g
'I'\''m Groot' (or double-quote if possible: "I'm Groot").

### 2. Load and Parse Task Structure

Parse tasks.md to build:

- **Task dependency graph**: Which tasks depend on which others
- **Parallel execution groups**: Tasks marked [P] that can run simultaneously
- **Phase structure**: Setup → Foundational → User Stories → Polish
- **File mapping**: Which tasks create/modify which files

### 3. Validate Prerequisites

Before starting implementation:

- ✅ All required artifacts present (Intent, plan, tasks, research, data-model)
- ✅ Constitution loaded and understood
- ✅ Required tools and dependencies available
- ✅ Development environment properly configured
- ✅ No blocking issues in analysis or clarification phases
- ✅ All [NEEDS CLARIFICATION] items resolved in plan.md
- ✅ API contracts defined in contracts/ directory

### 4. Execute Implementation Phases

#### Phase 1: Setup Tasks

Execute project initialization and basic structure tasks:

- Create project structure per plan.md
- Initialize dependencies and configuration
- Set up development tools and linting

#### Phase 2: Foundational Tasks

Execute core infrastructure that blocks all user stories:

- Database schema and migrations
- Authentication/authorization framework
- API routing and middleware
- Base models and services

**CRITICAL**: No user story work begins until foundational phase completes successfully.

#### Phase 3: User Story Implementation

Execute user stories in priority order (P1 → P2 → P3...):

For each user story:

1. **Pre-implementation**: Verify story can be implemented independently
2. **Test-first**: If tests requested, write and verify tests fail before implementation
3. **Implementation**: Execute all tasks for this story
4. **Integration**: Ensure story integrates with completed stories
5. **Validation**: Test story independently and mark complete
6. **Checkpoint**: Verify story delivers expected value

#### Phase 4: Polish & Cross-Cutting Concerns

Execute final improvements:

- Documentation updates
- Code cleanup and refactoring
- Performance optimization
- Additional testing
- Security hardening

### 5. Handle Parallel Execution

For tasks marked [P] (parallel):

- Execute simultaneously when dependencies allow
- Coordinate file creation to avoid conflicts
- Merge results appropriately

### 6. Error Handling and Recovery

**Task-level errors**:

- Stop execution of dependent tasks
- Provide clear error messages with resolution steps
- Allow user to fix issues and resume

**File conflicts**:

- Detect when multiple tasks try to modify same file
- Suggest resolution strategies
- Allow manual intervention if needed

**Environment issues**:

- Detect missing tools or dependencies
- Provide installation/setup instructions
- Validate environment before retrying

### 7. Progress Reporting

Throughout implementation:

- Show current phase and task
- Display progress percentage
- Report successful completions
- Highlight any issues or delays

### 8. Quality Assurance Throughout

Execute quality checks at each phase:

- **Code quality**: Linting and formatting validation
- **Security scanning**: Check for vulnerabilities in dependencies and code
- **Test execution**: Run relevant test suites after each completed user story
- **Performance validation**: Verify performance meets requirements defined in plan.md
- **Architecture compliance**: Verify implementation matches architectural decisions

### 9. Final Validation

After all tasks complete:

- Run comprehensive validation suite
- Execute all automated tests (unit, integration, contract, end-to-end)
- Verify constitution compliance
- Generate implementation summary report
- Validate feature against original intent.md requirements

## Task Execution Guidelines

### Code Quality Standards

- **Follow constitution guidelines**: All code must comply with project standards
- **Test-driven**: Write tests before implementation when specified
- **Documentation**: Add appropriate comments and documentation
- **Error handling**: Implement proper error handling and validation
- **Security first**: Implement security measures from the start
- **Performance conscious**: Consider performance implications during implementation

### File Management

- **Atomic operations**: Complete entire files when possible
- **Backup existing**: Preserve existing files before modification
- **Clear naming**: Use descriptive names that match task descriptions
- **Consistent structure**: Follow project conventions for file organization
- **Version control**: Commit changes regularly with meaningful commit messages
- **Conflict prevention**: Plan parallel work to minimize merge conflicts

### Integration Points

- **API consistency**: Ensure new endpoints follow established patterns
- **Data compatibility**: Maintain backward compatibility when possible
- **UI consistency**: Follow design system and UX guidelines
- **Security compliance**: Implement appropriate security measures
- **Monitoring readiness**: Include observability from the start

## Implementation Strategy

### MVP-First Approach

1. Complete Setup and Foundational phases
2. Implement User Story 1 (P1) completely
3. **STOP and VALIDATE**: Test US1 independently
4. Deploy/demo if ready before continuing

### Incremental Delivery

1. Complete foundation → Ready for user stories
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 → Test independently → Deploy/Demo
4. Continue with remaining stories
5. Each story adds value without breaking previous work

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once foundation complete:
    - Developer A: User Story 1
    - Developer B: User Story 2
    - Developer C: User Story 3
3. Stories complete and integrate independently

## Quality Gates

### During Implementation

- **Code review standards**: Follow project code review guidelines
- **Testing requirements**: Execute tests as specified in tasks
- **Performance validation**: Verify performance meets requirements
- **Security scanning**: Run security checks if specified
- **Architecture alignment**: Verify implementation matches planned architecture

### Post-Implementation

- **Integration testing**: Verify all components work together
- **User acceptance**: Validate against original requirements
- **Documentation**: Update all relevant documentation
- **Cleanup**: Remove temporary files and unused code
- **Performance benchmarking**: Validate performance against defined goals

## Error Recovery

### Common Issues and Solutions

**Missing Dependencies**:

- Install required packages/tools
- Update environment configuration
- Retry failed tasks

**File Conflicts**:

- Coordinate with team members
- Use feature branches for parallel work
- Merge changes carefully

**Test Failures**:

- Debug failing tests
- Fix implementation issues
- Re-run test suite

**Performance Issues**:

- Profile and optimize slow code
- Review architecture decisions
- Consider alternative implementations

**Security Vulnerabilities**:

- Run security scans regularly
- Update vulnerable dependencies
- Implement security best practices

## Success Criteria

Implementation is complete when:

- ✅ All tasks in tasks.md are completed
- ✅ All user stories are independently functional
- ✅ Code passes all quality gates
- ✅ Implementation aligns with constitution
- ✅ Feature delivers expected user value
- ✅ Documentation is complete and accurate
- ✅ All tests pass (unit, integration, contract, e2e)
- ✅ Performance meets defined requirements
- ✅ Security scans pass
- ✅ Code review completed and approved

## Operating Principles

### Execution Discipline

- **Order matters**: Execute tasks in specified dependency order
- **Quality first**: Never sacrifice quality for speed
- **Transparency**: Keep user informed of progress and issues
- **Recovery ready**: Always have a path to fix problems
- **Security conscious**: Implement security measures at every step

### Team Coordination

- **Clear communication**: Report progress and issues clearly
- **Dependency awareness**: Understand and respect task dependencies
- **Parallel efficiency**: Maximize parallel execution when safe
- **Integration focus**: Ensure components work together

## Context

{ARGS}
