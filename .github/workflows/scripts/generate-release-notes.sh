#!/usr/bin/env bash
set -euo pipefail

# generate-release-notes.sh
# Generate release notes based on commits since the last release
# Usage: generate-release-notes.sh <new_version> <latest_tag>

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <new_version> <latest_tag>" >&2
  exit 1
fi

NEW_VERSION="$1"
LATEST_TAG="$2"

echo "Generating release notes for $NEW_VERSION since $LATEST_TAG"

# Generate release notes using git log
# Use subshell to avoid issues with grep returning exit code 1 when no matches
RELEASE_NOTES=$( (git log --pretty=format:"- %s (%h)" --no-merges "${LATEST_TAG}..HEAD" 2>/dev/null || true) | grep -E "^- (feat|fix|docs|style|refactor|test|chore)" || true)
RELEASE_NOTES=$(echo "$RELEASE_NOTES" | head -20)

if [[ -z "$RELEASE_NOTES" ]]; then
  RELEASE_NOTES="- No significant changes since last release"
fi

# Create release notes with header
{
  echo "## $NEW_VERSION"
  echo ""
  echo "### Changes"
  echo ""
  echo "$RELEASE_NOTES"
  echo ""
  echo "### Installation"
  echo ""
  echo "Update Intent Kit to the latest version:"
  echo ""
  echo '```bash'
  echo "uv tool install intent-cli --force --from git+https://github.com/Nom-nom-hub/Intended.git"
  echo '```'
  echo ""
  echo "### Documentation"
  echo ""
  echo "For detailed documentation, see: https://github.github.io/intent-kit/"
} > release_notes.md

echo "Generated release notes:"
cat release_notes.md

# Only write to GITHUB_OUTPUT if running in GitHub Actions
if [ ! -z "${GITHUB_OUTPUT:-}" ]; then
  echo "release_notes_file=release_notes.md" >> $GITHUB_OUTPUT
fi