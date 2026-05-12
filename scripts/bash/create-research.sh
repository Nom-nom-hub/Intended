#!/usr/bin/env bash

# Load common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

set -e

# Parse arguments
JSON_MODE=false
ARGS=()
i=1
while [ $i -le $# ]; do
    arg="${!i}"
    case "$arg" in
        --json)
            JSON_MODE=true
            ;;
        --help|-h)
            echo "Usage: $0 [--json] [research description]"
            echo ""
            echo "Options:"
            echo "  --json              Output in JSON format"
            echo "  --help, -h          Show this help message"
            exit 0
            ;;
        *)
            ARGS+=("$arg")
            ;;
    esac
    i=$((i + 1))
done

# Resolve repository root
REPO_ROOT="$(resolve_repo_root)"
cd "$REPO_ROOT"

# Determine the current feature
BRANCH_NAME=""

# Check INTENT_FEATURE environment variable first
if [ -n "${INTENT_FEATURE:-}" ]; then
    BRANCH_NAME="$INTENT_FEATURE"
    print_info "Using INTENT_FEATURE: $BRANCH_NAME"
fi

# Fall back to git branch detection
if [ -z "$BRANCH_NAME" ] && is_git_repo; then
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")
    if [ "$CURRENT_BRANCH" != "main" ] && [ "$CURRENT_BRANCH" != "master" ] && [ -n "$CURRENT_BRANCH" ]; then
        BRANCH_NAME="$CURRENT_BRANCH"
        print_info "Using current branch: $BRANCH_NAME"
    fi
fi

# If no feature detected, abort
if [ -z "$BRANCH_NAME" ]; then
    print_error "No active feature detected."
    print_error "Please run /intent.intend first to create a feature specification."
    exit 1
fi

# Set up research directory
INTENTS_DIR="$REPO_ROOT/intents"
FEATURE_DIR="$INTENTS_DIR/$BRANCH_NAME"

# Check if feature directory exists
if [ ! -d "$FEATURE_DIR" ]; then
    print_warning "Feature directory not found: $FEATURE_DIR"
    print_info "Creating feature directory..."
    mkdir -p "$FEATURE_DIR"
fi

# Ensure Intent.md exists
if [ ! -f "$FEATURE_DIR/Intent.md" ]; then
    print_warning "Intent.md not found in $FEATURE_DIR"
    print_info "Creating placeholder Intent.md..."
    touch "$FEATURE_DIR/Intent.md"
fi

# Create research directory
RESEARCH_DIR="$FEATURE_DIR/research"
mkdir -p "$RESEARCH_DIR"

# Generate timestamp
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
RESEARCH_FILE="$RESEARCH_DIR/research-${TIMESTAMP}.md"

# Copy research template if available
TEMPLATE="$REPO_ROOT/.intent/templates/research-template.md"
if [ ! -f "$TEMPLATE" ]; then
    # Fall back to Intended project templates
    TEMPLATE="$REPO_ROOT/Intended/templates/research-template.md"
fi

if [ -f "$TEMPLATE" ]; then
    cp "$TEMPLATE" "$RESEARCH_FILE"
    print_success "Created research document from template: $RESEARCH_FILE"
else
    touch "$RESEARCH_FILE"
    print_warning "Research template not found, created empty research document: $RESEARCH_FILE"
fi

# Set the INTENT_FEATURE environment variable for downstream use
export INTENT_FEATURE="$BRANCH_NAME"

# Output results
if $JSON_MODE; then
    printf '{"BRANCH_NAME":"%s","RESEARCH_DIR":"%s","RESEARCH_FILE":"%s","FEATURE_DIR":"%s"}\n' \
        "$BRANCH_NAME" "$RESEARCH_DIR" "$RESEARCH_FILE" "$FEATURE_DIR"
else
    print_success "Research environment ready!"
    echo "BRANCH_NAME: $BRANCH_NAME"
    echo "RESEARCH_DIR: $RESEARCH_DIR"
    echo "RESEARCH_FILE: $RESEARCH_FILE"
    echo "FEATURE_DIR: $FEATURE_DIR"
    echo ""
    print_info "Next steps:"
    echo "1. Review the Intent.md at: $FEATURE_DIR/Intent.md"
    echo "2. Conduct research and document findings in: $RESEARCH_FILE"
    echo "3. Use /intent.plan to create implementation plan based on research"
fi
