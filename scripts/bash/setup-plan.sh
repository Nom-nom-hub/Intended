#!/usr/bin/env bash

# Load common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

set -e

print_info "Setting up implementation plan..."

# Resolve repository root
REPO_ROOT="$(resolve_repo_root)"
cd "$REPO_ROOT"

# Check if we're in a feature directory or have INTENT_FEATURE set
if [ -z "$INTENT_FEATURE" ]; then
    print_error "INTENT_FEATURE environment variable not set"
    print_info "Please run this script from within a feature branch or set INTENT_FEATURE"
    exit 1
fi

FEATURE_DIR="$REPO_ROOT/intents/$INTENT_FEATURE"

if [ ! -d "$FEATURE_DIR" ]; then
    print_error "Feature directory not found: $FEATURE_DIR"
    print_info "Please ensure you're in the correct feature branch"
    exit 1
fi

# Check if Intent exists
SPEC_FILE="$FEATURE_DIR/Intent.md"
if [ ! -f "$SPEC_FILE" ]; then
    print_error "Specification file not found: $SPEC_FILE"
    print_info "Please create a specification first using /intentkit.Intended"
    exit 1
fi

print_success "Feature directory found: $FEATURE_DIR"
print_success "Specification found: $SPEC_FILE"

# Create plan directory structure
mkdir -p "$FEATURE_DIR/contracts"
mkdir -p "$FEATURE_DIR/plans"

# Copy plan template if available
PLAN_TEMPLATE="$REPO_ROOT/.intent/templates/plan-template.md"
PLAN_FILE="$FEATURE_DIR/plans/plan.md"

if [ -f "$PLAN_TEMPLATE" ]; then
    cp "$PLAN_TEMPLATE" "$PLAN_FILE"
    print_success "Created plan template: $PLAN_FILE"
else
    # Create basic plan structure
    cat > "$PLAN_FILE" << EOF
# Implementation Plan: $INTENT_FEATURE

**Created**: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
**Status**: Draft

## Technical Approach

### Technology Stack
[Intended the technology stack and rationale]

### Architecture Overview
[High-level architecture description]

### Component Breakdown
[Break down into major components]

## Implementation Strategy

### Phase 1: [Phase Name]
- [Task 1]
- [Task 2]
- [Task 3]

### Phase 2: [Phase Name]
- [Task 1]
- [Task 2]
- [Task 3]

## Integration Points
[Describe how components integrate]

## Deployment Strategy
[How the system will be deployed]

## Risk Assessment
[Identify potential risks and mitigation strategies]

## Success Criteria
[How we'll know this is complete]
EOF
    print_success "Created basic plan structure: $PLAN_FILE"
fi

# Create research document
RESEARCH_FILE="$FEATURE_DIR/research.md"
cat > "$RESEARCH_FILE" << EOF
# Research Document: $INTENT_FEATURE

**Created**: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
**Status**: In Progress

## Technology Research

### [Technology 1]
- **Purpose**: [Why this technology]
- **Version**: [Recommended version]
- **Rationale**: [Why this choice]
- **Alternatives considered**: [Other options and why not chosen]

### [Technology 2]
- **Purpose**: [Why this technology]
- **Version**: [Recommended version]
- **Rationale**: [Why this choice]
- **Alternatives considered**: [Other options and why not chosen]

## Architecture Research

### Design Patterns
[Relevant design patterns and their application]

### Integration Patterns
[How different components will integrate]

### Performance Considerations
[Performance requirements and approach]

## Risk Analysis

### Technical Risks
- **Risk**: [Description]
  **Mitigation**: [How to address]
  **Impact**: [High/Medium/Low]

### Integration Risks
- **Risk**: [Description]
  **Mitigation**: [How to address]
  **Impact**: [High/Medium/Low]

## Recommendations

### Immediate Actions
[What should be done next]

### Future Considerations
[Things to keep in mind for later phases]

### Open Questions
[Unresolved questions that need answers]
EOF

print_success "Created research document: $RESEARCH_FILE"

# Create quickstart document
QUICKSTART_FILE="$FEATURE_DIR/quickstart.md"
cat > "$QUICKSTART_FILE" << EOF
# Quick Start: $INTENT_FEATURE

**Created**: $(date -u +"%Y-%m-%dT%H:%M:%SZ")

## Overview
[Brief description of what this feature does]

## Getting Started

### Prerequisites
- [Requirement 1]
- [Requirement 2]
- [Requirement 3]

### Setup Steps
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Usage

### Basic Usage
[How to use the feature]

### Configuration
[Configuration options]

### Examples
[Code examples or usage examples]

## Testing

### Running Tests
[How to run tests for this feature]

### Test Coverage
[What should be tested]

## Troubleshooting

### Common Issues
- **Issue**: [Problem description]
  **Solution**: [How to fix]

### Getting Help
[Where to get help]

## Next Steps
[What to do after this feature is complete]
EOF

print_success "Created quickstart document: $QUICKSTART_FILE"

print_success "Plan setup complete!"
echo ""
print_info "Next steps:"
echo "1. Review and update: $PLAN_FILE"
echo "2. Research technologies: $RESEARCH_FILE"
echo "3. Update quickstart: $QUICKSTART_FILE"
echo "4. Use /intentkit.tasks to generate task breakdown"
echo "5. Use /intentkit.implement to execute implementation"