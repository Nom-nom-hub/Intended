#!/usr/bin/env bash
set -euo pipefail

# create-github-release.sh
# Create a GitHub release with the generated packages and release notes
# Usage: create-github-release.sh <version>

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version>" >&2
  exit 1
fi

VERSION="$1"

echo "Creating GitHub release for $VERSION"

# Check if release notes file exists
if [[ ! -f release_notes.md ]]; then
  echo "Error: release_notes.md not found" >&2
  exit 1
fi

# Create the release with all packages
gh release create "$VERSION" \
  --title "$VERSION" \
  --notes-file release_notes.md \
  .genreleases/intent-kit-template-*-"${VERSION}".zip

echo "Created release $VERSION successfully"

# Clean up
rm -f release_notes.md