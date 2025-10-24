#!/usr/bin/env bash

# Common functions and utilities for Intent Kit scripts

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1" >&2
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to find repository root
find_repo_root() {
    local dir="$1"
    while [ "$dir" != "/" ]; do
        if [ -d "$dir/.git" ] || [ -d "$dir/.intent" ]; then
            echo "$dir"
            return 0
        fi
        dir="$(dirname "$dir")"
    done
    return 1
}

# Function to resolve repository root
resolve_repo_root() {
    if git rev-parse --show-toplevel >/dev/null 2>&1; then
        git rev-parse --show-toplevel
    else
        local script_dir
        script_dir="$(cd "$(dirname "${BASH_SOURCE[1]}")" && pwd)"
        local repo_root
        repo_root="$(find_repo_root "$script_dir")"
        if [ -z "$repo_root" ]; then
            print_error "Could not determine repository root. Please run this script from within the repository."
            exit 1
        fi
        echo "$repo_root"
    fi
}

# Function to check if we're in a git repository
is_git_repo() {
    git rev-parse --is-inside-work-tree >/dev/null 2>&1
}

# Function to get the next feature number
get_next_feature_number() {
    local specs_dir="$1"
    local max_num=0

    if [ -d "$specs_dir" ]; then
        for dir in "$specs_dir"/*; do
            [ -d "$dir" ] || continue
            local dirname
            dirname=$(basename "$dir")
            local number
            number=$(echo "$dirname" | grep -o '^[0-9]\+' || echo "0")
            number=$((10#$number))
            if [ "$number" -gt "$max_num" ]; then
                max_num=$number
            fi
        done
    fi

    echo $((max_num + 1))
}

# Function to format feature number with leading zeros
format_feature_number() {
    local number=$1
    printf "%03d" "$number"
}

# Function to generate branch name from description
generate_branch_name() {
    local description="$1"

    # Common stop words to filter out
    local stop_words="^(i|a|an|the|to|for|of|in|on|at|by|with|from|is|are|was|were|be|been|being|have|has|had|do|does|did|will|would|should|could|can|may|might|must|shall|this|that|these|those|my|your|our|their|want|need|add|get|set)$"

    # Convert to lowercase and split into words
    local clean_name
    clean_name=$(echo "$description" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/ /g')

    # Filter words: remove stop words and words shorter than 3 chars (unless they're uppercase acronyms in original)
    local meaningful_words=()
    for word in $clean_name; do
        # Skip empty words
        [ -z "$word" ] && continue

        # Keep words that are NOT stop words AND (length >= 3 OR are potential acronyms)
        if ! echo "$word" | grep -qiE "$stop_words"; then
            if [ ${#word} -ge 3 ]; then
                meaningful_words+=("$word")
            elif echo "$description" | grep -q "\b${word^^}\b"; then
                # Keep short words if they appear as uppercase in original (likely acronyms)
                meaningful_words+=("$word")
            fi
        fi
    done

    # If we have meaningful words, use first 3-4 of them
    if [ ${#meaningful_words[@]} -gt 0 ]; then
        local max_words=3
        if [ ${#meaningful_words[@]} -eq 4 ]; then max_words=4; fi

        local result=""
        local count=0
        for word in "${meaningful_words[@]}"; do
            if [ $count -ge $max_words ]; then break; fi
            if [ -n "$result" ]; then result="$result-"; fi
            result="$result$word"
            count=$((count + 1))
        done
        echo "$result"
    else
        # Fallback to original logic if no meaningful words found
        echo "$description" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//' | tr '-' '\n' | grep -v '^$' | head -3 | tr '\n' '-' | sed 's/-$//'
    fi
}

# Function to validate branch name length (GitHub limit is 244 bytes)
validate_branch_name() {
    local branch_name="$1"
    local max_length=244

    if [ ${#branch_name} -gt $max_length ]; then
        print_warning "Branch name exceeded GitHub's 244-byte limit"
        print_warning "Original: $branch_name (${#branch_name} bytes)"

        # Calculate how much we need to trim from suffix
        # Account for: feature number (3) + hyphen (1) = 4 chars
        local max_suffix_length=$((max_length - 4))

        # Extract the suffix part (everything after the first hyphen)
        local suffix
        suffix=$(echo "$branch_name" | cut -d'-' -f2-)

        # Truncate suffix at word boundary if possible
        local truncated_suffix
        truncated_suffix=$(echo "$suffix" | cut -c1-$max_suffix_length)
        # Remove trailing hyphen if truncation created one
        truncated_suffix=$(echo "$truncated_suffix" | sed 's/-$//')

        # Extract the number part
        local number_part
        number_part=$(echo "$branch_name" | cut -d'-' -f1)

        # Create new branch name
        local new_branch_name="${number_part}-${truncated_suffix}"

        print_warning "Truncated to: $new_branch_name (${#new_branch_name} bytes)"
        echo "$new_branch_name"
    else
        echo "$branch_name"
    fi
}

# Function to run command with error handling
run_command() {
    local cmd="$1"
    local error_msg="${2:-Command failed: $cmd}"

    if ! eval "$cmd"; then
        print_error "$error_msg"
        exit 1
    fi
}

# Function to confirm action
confirm_action() {
    local message="$1"
    local default="${2:-n}"

    if [ -t 0 ]; then
        # Interactive terminal
        if [ "$default" = "y" ]; then
            read -p "$message [Y/n] " -r
            [[ $REPLY =~ ^[Nn]$ ]] && return 1
        else
            read -p "$message [y/N] " -r
            [[ $REPLY =~ ^[Yy]$ ]] && return 0
            return 1
        fi
    else
        # Non-interactive
        if [ "$default" = "y" ]; then
            print_info "$message (auto-confirmed)"
            return 0
        else
            print_warning "$message (cancelled in non-interactive mode)"
            return 1
        fi
    fi
}

# Function to check if directory is empty or confirm overwrite
check_directory() {
    local dir="$1"
    local force="$2"

    if [ ! -d "$dir" ]; then
        return 0
    fi

    local item_count
    item_count=$(find "$dir" -maxdepth 1 -mindepth 1 | wc -l)

    if [ "$item_count" -eq 0 ]; then
        return 0
    fi

    if [ "$force" = "true" ]; then
        print_warning "Directory $dir is not empty, but --force specified. Continuing..."
        return 0
    fi

    print_warning "Directory $dir is not empty ($item_count items)"
    if ! confirm_action "Do you want to continue? This may overwrite existing files."; then
        print_info "Operation cancelled"
        exit 0
    fi
}

# Function to set up git repository
setup_git_repo() {
    local project_path="$1"

    if ! command_exists git; then
        print_warning "Git not found, skipping repository initialization"
        return 1
    fi

    if is_git_repo; then
        print_info "Git repository already exists"
        return 0
    fi

    print_info "Initializing git repository..."
    cd "$project_path"
    run_command "git init" "Failed to initialize git repository"
    run_command "git add ." "Failed to add files to git"
    run_command "git commit -m 'Initial commit from Intent template'" "Failed to create initial commit"

    print_success "Git repository initialized"
    return 0
}

# Function to ensure script is executable
make_executable() {
    local script_path="$1"

    if [ -w "$script_path" ] && [ ! -x "$script_path" ]; then
        chmod +x "$script_path"
        print_info "Made script executable: $script_path"
    fi
}

# Function to ensure all scripts in directory are executable
make_scripts_executable() {
    local scripts_dir="$1"

    if [ ! -d "$scripts_dir" ]; then
        return
    fi

    find "$scripts_dir" -name "*.sh" -type f -exec make_executable {} \;
}

# Export functions so they can be used by other scripts
export -f print_info
export -f print_success
export -f print_warning
export -f print_error
export -f command_exists
export -f find_repo_root
export -f resolve_repo_root
export -f is_git_repo
export -f get_next_feature_number
export -f format_feature_number
export -f generate_branch_name
export -f validate_branch_name
export -f run_command
export -f confirm_action
export -f check_directory
export -f setup_git_repo
export -f make_executable
export -f make_scripts_executable