---

description: "Task list template for intent-driven feature implementation"
---

# Tasks: [FEATURE NAME]

**Template Version**: 2.0

**Input**: Design documents from `/intents/[###-feature-name]/`
**Prerequisites**: plan.md (required), intent.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: The examples below include test tasks. Tests are OPTIONAL - only include them if explicitly requested in the
feature intent.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions
- **[Priority]**: Tasks should be completed in priority order (P1, P2, P3)

## Path Conventions

- **Single project**: `src/`, `tests/` at repository root
- **Web app**: `backend/src/`, `frontend/src/`
- **Mobile**: `api/src/`, `ios/src/` or `android/src/`
- **Microservices**: `services/service-name/src/`
- Paths shown below assume single project - adjust based on plan.md structure

<!--
  ============================================================================
  IMPORTANT: The tasks below are SAMPLE TASKS for illustration purposes only.

  The /intent.tasks command MUST replace these with actual tasks based on:
  - User stories from intent.md (with their priorities P1, P2, P3...)
  - Feature requirements from plan.md
  - Entities from data-model.md
  - Endpoints from contracts/
  - API contracts from contracts/

  Tasks MUST be organized by user story so each story can be:
  - Implemented independently
  - Tested independently
  - Delivered as an MVP increment

  DO NOT keep these sample tasks in the generated tasks.md file.
  ============================================================================
-->

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [ ] T001 [P1] Create project structure per implementation plan in [specific directory]
- [ ] T002 [P1] Initialize [language] project with [framework] dependencies and configure build system
- [ ] T003 [P] [P1] Configure linting, formatting, and code quality tools
- [ ] T004 [P1] Set up CI/CD pipelines and environment configuration
- [ ] T005 [P1] Configure version control ignores and initial project settings

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

Examples of foundational tasks (adjust based on your project):

- [ ] T006 [P1] Setup database schema and migrations framework with initial structure
- [ ] T007 [P] [P1] Implement authentication/authorization framework
- [ ] T008 [P] [P1] Setup API routing and middleware structure
- [ ] T009 [P1] Create base models/entities that all stories depend on
- [ ] T010 [P] [P1] Configure error handling and logging infrastructure
- [ ] T011 [P1] Setup environment configuration management and secrets handling
- [ ] T012 [P1] Configure testing framework and initial test setup
- [ ] T013 [P1] Implement common utilities and helper functions used across stories

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - [Title] (Priority: P1) 🎯 MVP

**Goal**: [Brief description of what this story delivers]

**Independent Test**: [How to verify this story works on its own]

### Tests for User Story 1 (OPTIONAL - only if tests requested) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T014 [P] [US1] [P1] Contract test for [endpoint] in tests/contract/test_[name].py
- [ ] T015 [P] [US1] [P1] Integration test for [user journey] in tests/integration/test_[name].py
- [ ] T016 [P] [US1] [P1] Unit tests for [core functionality] in tests/unit/test_[name].py

### Implementation for User Story 1

- [ ] T017 [P] [US1] [P1] Create [Entity1] model in src/models/[entity1].py
- [ ] T018 [P] [US1] [P1] Create [Entity2] model in src/models/[entity2].py
- [ ] T019 [US1] [P1] Implement [Service] in src/services/[service].py (depends on T017, T018)
- [ ] T020 [US1] [P1] Implement [endpoint/feature] in src/[location]/[file].py
- [ ] T021 [US1] [P1] Add validation and error handling for [feature]
- [ ] T022 [US1] [P1] Add logging for user story 1 operations
- [ ] T023 [US1] [P1] Implement [UI component] in src/ui/[component].js (if applicable)
- [ ] T024 [US1] [P1] Update documentation for [feature] in docs/[feature].md

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - [Title] (Priority: P2)

**Goal**: [Brief description of what this story delivers]

**Independent Test**: [How to verify this story works on its own]

### Tests for User Story 2 (OPTIONAL - only if tests requested) ⚠️

- [ ] T025 [P] [US2] [P2] Contract test for [endpoint] in tests/contract/test_[name].py
- [ ] T026 [P] [US2] [P2] Integration test for [user journey] in tests/integration/test_[name].py

### Implementation for User Story 2

- [ ] T027 [P] [US2] [P2] Create [Entity] model in src/models/[entity].py
- [ ] T028 [US2] [P2] Implement [Service] in src/services/[service].py
- [ ] T029 [US2] [P2] Implement [endpoint/feature] in src/[location]/[file].py
- [ ] T030 [US2] [P2] Integrate with User Story 1 components (if needed)
- [ ] T031 [US2] [P2] Add validation and error handling for [feature]
- [ ] T032 [US2] [P2] Update documentation for [feature] in docs/[feature].md

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - [Title] (Priority: P3)

**Goal**: [Brief description of what this story delivers]

**Independent Test**: [How to verify this story works on its own]

### Tests for User Story 3 (OPTIONAL - only if tests requested) ⚠️

- [ ] T033 [P] [US3] [P3] Contract test for [endpoint] in tests/contract/test_[name].py
- [ ] T034 [P] [US3] [P3] Integration test for [user journey] in tests/integration/test_[name].py

### Implementation for User Story 3

- [ ] T035 [P] [US3] [P3] Create [Entity] model in src/models/[entity].py
- [ ] T036 [US3] [P3] Implement [Service] in src/services/[service].py
- [ ] T037 [US3] [P3] Implement [endpoint/feature] in src/[location]/[file].py
- [ ] T038 [US3] [P3] Add validation and error handling for [feature]
- [ ] T039 [US3] [P3] Update documentation for [feature] in docs/[feature].md

**Checkpoint**: All user stories should now be independently functional

---

[Add more user story phases as needed, following the same pattern]

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] TXXX [P] [P3] Documentation updates in docs/[feature].md and README.md
- [ ] TXXX [P3] Code cleanup and refactoring across all user stories
- [ ] TXXX [P3] Performance optimization across all stories
- [ ] TXXX [P] [P3] Additional unit tests (if requested) in tests/unit/
- [ ] TXXX [P3] Security hardening and security audit
- [ ] TXXX [P3] Run quickstart.md validation and update quickstart guide
- [ ] TXXX [P3] Update monitoring and alerting configurations
- [ ] TXXX [P3] Final code review and quality gate check

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - May integrate with US1 but should be independently testable
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - May integrate with US1/US2 but should be independently testable

### Within Each User Story

- Tests (if included) MUST be written and FAIL before implementation
- Models before services
- Services before endpoints
- Core implementation before integration
- Story complete before moving to next priority

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- All Foundational tasks marked [P] can run in parallel (within Phase 2)
- Once Foundational phase completes, all user stories can start in parallel (if team capacity allows)
- All tests for a user story marked [P] can run in parallel
- Models within a story marked [P] can run in parallel
- Different user stories can be worked on in parallel by different team members

---

## Task Execution Guidelines

### Quality Standards

- **Code Review**: Each task must pass code review before completion
- **Testing**: All tests must pass before marking a task complete
- **Documentation**: Update documentation as part of each implementation task
- **Error Handling**: Implement robust error handling in all code

### Commit Strategy

- **Granular Commits**: Commit after completing logical groups of tasks
- **Descriptive Messages**: Use clear, descriptive commit messages
- **Feature Branch**: Work on a dedicated feature branch
- **Regular Pushes**: Push regularly to share progress and backup work

---

## Parallel Example: User Story 1

```bash
# Launch all tests for User Story 1 together (if tests requested):
Task: "Contract test for [endpoint] in tests/contract/test_[name].py"
Task: "Integration test for [user journey] in tests/integration/test_[name].py"
Task: "Unit tests for [core functionality] in tests/unit/test_[name].py"

# Launch all models for User Story 1 together:
Task: "Create [Entity1] model in src/models/[entity1].py"
Task: "Create [Entity2] model in src/models/[entity2].py"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Test User Story 1 independently
5. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 → Test independently → Deploy/Demo
4. Add User Story 3 → Test independently → Deploy/Demo
5. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
    - Developer A: User Story 1
    - Developer B: User Story 2
    - Developer C: User Story 3
3. Stories complete and integrate independently

---

## Progress Tracking

### Milestones

- **Foundation Complete**: [Date] - All foundational work finished
- **User Story 1 Complete**: [Date] - MVP ready for testing
- **User Story 2 Complete**: [Date] - Additional functionality ready
- **User Story 3 Complete**: [Date] - Feature complete
- **Polish Complete**: [Date] - Production ready

### Status Indicators

- **[ ]**: Task not started
- **[x]**: Task completed
- **[/]**: Task in progress
- **[?]**: Task blocked or requires clarification

---

## Validation & Quality Assurance

### Cross-Reference Validation

Verify alignment between artifacts:

- [ ] All user stories from intent.md have corresponding implementation tasks
- [ ] All functional requirements from plan.md have implementation tasks
- [ ] API contracts from contracts/ have corresponding implementation tasks
- [ ] Data model entities from data-model.md have implementation tasks
- [ ] Success criteria from intent.md have validation/test tasks

### Task Quality Checks

- [ ] All tasks follow the format: `[ ] [TaskID] [Priority] [P?] [Story?] Description with file path`
- [ ] Task IDs are sequential (T001, T002, T003...)
- [ ] Parallel tasks [P] are on different files with no dependencies
- [ ] User story tasks have correct [US1], [US2], etc. labels
- [ ] No vague or ambiguous task descriptions
- [ ] Each task has a specific file path or location

### Dependency Validation

- [ ] Critical foundational tasks complete before user story work
- [ ] No circular dependencies between tasks
- [ ] User stories maintain independence where possible
- [ ] All blocking tasks identified and scheduled first

## Troubleshooting Common Issues

### Task Granularity Issues

**Problem**: Tasks are too large and difficult to implement
**Solution**:
- Break down complex tasks into smaller, focused steps
- Separate implementation from testing tasks
- Create specific tasks for different components (model, service, endpoint)
- Ensure each task results in a testable unit

**Problem**: Tasks are too small and create overhead
**Solution**:
- Combine related tasks that must be done together
- Group tasks by component or feature area
- Maintain focus on single purpose per task while avoiding micro-tasks

### Parallel Execution Conflicts

**Problem**: Multiple parallel tasks conflict when modifying the same files
**Solution**:
- Identify file dependencies between tasks
- Remove [P] marker for tasks affecting same files
- Schedule conflicting tasks sequentially instead of in parallel
- Use feature branches for parallel development of related components

### User Story Dependencies

**Problem**: User stories have hidden dependencies and can't be implemented independently
**Solution**:
- Identify shared entities and infrastructure
- Move dependencies to foundational phase
- Adjust user story scope to maintain independence
- Document necessary dependencies clearly

### Quality and Completeness Checks

**Problem**: Generated tasks don't align with original requirements
**Solution**:
- Cross-reference each task with original user stories
- Verify all functional requirements have corresponding tasks
- Confirm acceptance criteria are addressed
- Check that success criteria have validation tasks

## Cross-Reference Validation

### Alignment with plan.md

- [ ] All architectural components from plan.md have corresponding implementation tasks
- [ ] Technology stack decisions from plan.md reflected in task details
- [ ] API contracts from plan.md have implementation tasks
- [ ] Data model from plan.md has implementation tasks
- [ ] Risk mitigation strategies from plan.md have corresponding tasks

### Alignment with intent.md

- [ ] All P1 user stories from intent.md have complete implementation tasks
- [ ] Acceptance criteria from intent.md are validated by test tasks
- [ ] Success criteria from intent.md have measurement/verification tasks
- [ ] Edge cases from intent.md have handling tasks
- [ ] Non-functional requirements from intent.md have implementation tasks

## Notes

- [P] tasks = different files, no dependencies - can run in parallel
- [Story] label maps task to specific user story for traceability
- [Priority] ensures tasks are completed in the right order
- Each user story should be independently completable and testable
- Verify tests fail before implementing
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence
