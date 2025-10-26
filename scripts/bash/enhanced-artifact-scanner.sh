#!/bin/bash

# Enhanced Artifact Scanner for Intent Kit
# Discovers and classifies project artifacts for enhanced task generation

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Configuration
CONFIG_FILE="$REPO_ROOT/.intent/enhanced-config.json"
SCAN_PATTERNS=("**/*.md" "**/*.json" "**/*.yaml" "**/*.yml" "docs/**" "design/**" "specs/**")
IGNORE_PATTERNS=("node_modules/**" ".git/**" "dist/**" "build/**" "**/.DS_Store")

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if enhanced features are enabled
check_enhanced_features() {
    if [[ ! -f "$CONFIG_FILE" ]]; then
        log_warning "Enhanced config file not found: $CONFIG_FILE"
        return 1
    fi

    # Check if artifact_expansion is enabled
    if ! jq -e '.enhanced_features.artifact_expansion.enabled // false' "$CONFIG_FILE" > /dev/null 2>&1; then
        log_info "Artifact expansion feature is disabled"
        return 1
    fi

    return 0
}

# Load configuration
load_config() {
    if [[ ! -f "$CONFIG_FILE" ]]; then
        log_error "Configuration file not found: $CONFIG_FILE"
        exit 1
    fi

    # Load scan patterns from config
    local config_patterns
    config_patterns=$(jq -r '.artifact_support.discovery.scan_patterns[] // empty' "$CONFIG_FILE" 2>/dev/null || echo "")
    if [[ -n "$config_patterns" ]]; then
        mapfile -t SCAN_PATTERNS < <(jq -r '.artifact_support.discovery.scan_patterns[]' "$CONFIG_FILE")
    fi

    log_info "Loaded configuration from $CONFIG_FILE"
}

# Check if file should be ignored
should_ignore() {
    local file="$1"

    for pattern in "${IGNORE_PATTERNS[@]}"; do
        if [[ "$file" == $pattern ]]; then
            return 0
        fi
    done
    return 1
}

# Classify artifact type based on path and content
classify_artifact() {
    local file="$1"
    local relative_path="${file#$REPO_ROOT/}"

    # Check file extension and path
    case "$relative_path" in
        *.md)
            if [[ "$relative_path" == *"architecture"* ]]; then
                echo "architecture"
            elif [[ "$relative_path" == *"wireframe"* ]] || [[ "$relative_path" == *"mockup"* ]]; then
                echo "wireframes"
            elif [[ "$relative_path" == *"api"* ]] || [[ "$relative_path" == *"spec"* ]]; then
                echo "api-specs"
            elif [[ "$relative_path" == *"data"* ]] || [[ "$relative_path" == *"model"* ]]; then
                echo "data-model"
            else
                echo "documentation"
            fi
            ;;
        *.json|*.yaml|*.yml)
            if [[ "$relative_path" == *"contract"* ]] || [[ "$relative_path" == *"api"* ]]; then
                echo "contracts"
            else
                echo "configuration"
            fi
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

# Scan for artifacts
scan_artifacts() {
    local artifacts_found=()

    log_info "Scanning for artifacts in $REPO_ROOT"

    for pattern in "${SCAN_PATTERNS[@]}"; do
        log_info "Scanning pattern: $pattern"

        # Use find for more reliable globbing
        while IFS= read -r -d '' file; do
            if [[ -f "$file" ]] && ! should_ignore "${file#$REPO_ROOT/}"; then
                local artifact_type
                artifact_type=$(classify_artifact "$file")

                artifacts_found+=("$file:$artifact_type")
                log_info "Found $artifact_type: ${file#$REPO_ROOT/}"
            fi
        done < <(find "$REPO_ROOT" -type f -path "$pattern" -print0 2>/dev/null || true)
    done

    echo "${artifacts_found[@]}"
}

# Generate artifact report
generate_report() {
    local artifacts=("$@")
    local report_file="$REPO_ROOT/.intent/artifact-scan-report.json"

    log_info "Generating artifact scan report: $report_file"

    # Create directory if it doesn't exist
    mkdir -p "$(dirname "$report_file")"

    # Build JSON report
    local json_artifacts="[]"
    local artifact_count=0

    for artifact in "${artifacts[@]}"; do
        IFS=':' read -r file_path artifact_type <<< "$artifact"
        local relative_path="${file_path#$REPO_ROOT/}"

        # Get file metadata
        local file_size
        file_size=$(stat -f%z "$file_path" 2>/dev/null || stat -c%s "$file_path" 2>/dev/null || echo "0")
        local modified_time
        modified_time=$(stat -f%Sm -t "%Y-%m-%d %H:%M:%S" "$file_path" 2>/dev/null || stat -c"%y" "$file_path" 2>/dev/null || echo "unknown")

        # Add to JSON array
        local artifact_json
        artifact_json=$(jq -n \
            --arg path "$relative_path" \
            --arg type "$artifact_type" \
            --arg size "$file_size" \
            --arg modified "$modified_time" \
            '{path: $path, type: $type, size: ($size | tonumber), modified: $modified}')

        json_artifacts=$(echo "$json_artifacts" | jq --argjson artifact "$artifact_json" '. += [$artifact]')
        ((artifact_count++))
    done

    # Create final report
    local report
    report=$(jq -n \
        --argjson artifacts "$json_artifacts" \
        --arg count "$artifact_count" \
        --arg timestamp "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
        '{timestamp: $timestamp, total_artifacts: ($count | tonumber), artifacts: $artifacts}')

    echo "$report" > "$report_file"

    log_success "Scanned $artifact_count artifacts and saved report to $report_file"
}

# Main execution
main() {
    log_info "Intent Kit Enhanced Artifact Scanner"
    log_info "===================================="

    if ! check_enhanced_features; then
        log_info "Enhanced features not enabled. Run 'intent init --all-enhanced' to enable."
        exit 0
    fi

    load_config

    # Scan for artifacts
    IFS=' ' read -r -a artifacts <<< "$(scan_artifacts)"

    if [[ ${#artifacts[@]} -eq 0 ]]; then
        log_warning "No artifacts found"
        exit 0
    fi

    # Generate report
    generate_report "${artifacts[@]}"

    log_success "Artifact scanning completed successfully"
}

# Run main function
main "$@"
