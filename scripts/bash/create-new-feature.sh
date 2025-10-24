#!/usr/bin/env bash

# Load common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

set -e

# Parse arguments
JSON_MODE=false
SHORT_NAME=""
BRANCH_NUMBER=""
ARGS=()
i=1
while [ $i -le $# ]; do
    arg="${!i}"
    case "$arg" in
        --json)
            JSON_MODE=true
            ;;
        --short-name)
            if [ $((i + 1)) -gt $# ]; then
                print_error "--short-name requires a value"
                exit 1
            fi
            i=$((i + 1))
            next_arg="${!i}"
            # Check if the next argument is another option (starts with --)
            if [[ "$next_arg" == --* ]]; then
                print_error "--short-name requires a value"
                exit 1
            fi
            SHORT_NAME="$next_arg"
            ;;
        --number)
            if [ $((i + 1)) -gt $# ]; then
                print_error "--number requires a value"
                exit 1
            fi
            i=$((i + 1))
            next_arg="${!i}"
            if [[ "$next_arg" == --* ]]; then
                print_error "--number requires a value"
                exit 1
            fi
            BRANCH_NUMBER="$next_arg"
            ;;
        --help|-h)
            echo "Usage: $0 [--json] [--short-name <name>] [--number N] <feature_description>"
            echo ""
            echo "Options:"
            echo "  --json              Output in JSON format"
            echo "  --short-name <name> Provide a custom short name (2-4 words) for the branch"
            echo "  --number N          Specify branch number manually (overrides auto-detection)"
            echo "  --help, -h          Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0 'Add user authentication system' --short-name 'user-auth'"
            echo "  $0 'Implement OAuth2 integration for API' --number 5"
            exit 0
            ;;
        *)
            ARGS+=("$arg")
            ;;
    esac
    i=$((i + 1))
done

FEATURE_DESCRIPTION="${ARGS[*]}"
if [ -z "$FEATURE_DESCRIPTION" ]; then
    print_error "Usage: $0 [--json] [--short-name <name>] [--number N] <feature_description>"
    exit 1
fi

# Resolve repository root
REPO_ROOT="$(resolve_repo_root)"
cd "$REPO_ROOT"

# Set up directories
INTENTS_DIR="$REPO_ROOT/intents"
mkdir -p "$INTENTS_DIR"

# Generate branch name
if [ -n "$SHORT_NAME" ]; then
    # Use provided short name, just clean it up
    BRANCH_SUFFIX=$(echo "$SHORT_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//')
else
    # Generate from description with smart filtering
    BRANCH_SUFFIX=$(generate_branch_name "$FEATURE_DESCRIPTION")
fi

# Determine branch number
if [ -z "$BRANCH_NUMBER" ]; then
    if is_git_repo; then
        # Check existing branches on remotes
        BRANCH_NUMBER=$(get_next_feature_number "$INTENTS_DIR")
    else
        # Fall back to local directory check
        BRANCH_NUMBER=$(get_next_feature_number "$INTENTS_DIR")
    fi
fi

FEATURE_NUM=$(format_feature_number "$BRANCH_NUMBER")
BRANCH_NAME="${FEATURE_NUM}-${BRANCH_SUFFIX}"

# Validate branch name length
BRANCH_NAME=$(validate_branch_name "$BRANCH_NAME")

# Create and checkout branch if in git repo
if is_git_repo; then
    git checkout -b "$BRANCH_NAME"
else
    print_warning "Git repository not detected; skipped branch creation for $BRANCH_NAME"
fi

# Create feature directory
FEATURE_DIR="$INTENTS_DIR/$BRANCH_NAME"
mkdir -p "$FEATURE_DIR"

# Copy template
TEMPLATE="$REPO_ROOT/.intent/templates/Intent-template.md"
SPEC_FILE="$FEATURE_DIR/Intent.md"
if [ -f "$TEMPLATE" ]; then
    cp "$TEMPLATE" "$SPEC_FILE"
    print_success "Created specification template: $SPEC_FILE"
else
    touch "$SPEC_FILE"
    print_warning "Template not found, created empty Intent file: $SPEC_FILE"
fi

# Set the INTENT_FEATURE environment variable for the current session
export INTENT_FEATURE="$BRANCH_NAME"

# Output results
if $JSON_MODE; then
    printf '{"BRANCH_NAME":"%s","SPEC_FILE":"%s","FEATURE_NUM":"%s"}\n' "$BRANCH_NAME" "$SPEC_FILE" "$FEATURE_NUM"
else
    print_success "Feature created successfully!"
    echo "BRANCH_NAME: $BRANCH_NAME"
    echo "SPEC_FILE: $SPEC_FILE"
    echo "FEATURE_NUM: $FEATURE_NUM"
    echo "INTENT_FEATURE environment variable set to: $BRANCH_NAME"
    echo ""
    print_info "Next steps:"
    echo "1. Edit the specification in: $SPEC_FILE"
    echo "2. Use /intentkit.plan to create implementation plan"
    echo "3. Use /intentkit.tasks to generate task breakdown"
    echo "4. Use /intentkit.implement to execute implementation"
fi