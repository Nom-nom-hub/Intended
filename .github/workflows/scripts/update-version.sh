#!/usr/bin/env bash
set -euo pipefail

# update-version.sh
# Update the version in pyproject.toml for release artifacts
# Usage: update-version.sh <new_version>

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <new_version>" >&2
  exit 1
fi

NEW_VERSION="$1"

echo "Updating version to $NEW_VERSION in pyproject.toml"

# Update version in pyproject.toml
sed -i.bak "s/^version = \".*\"/version = \"$NEW_VERSION\"/" pyproject.toml

# Check if the change was made
if grep -q "version = \"$NEW_VERSION\"" pyproject.toml; then
  echo "Successfully updated version to $NEW_VERSION"
  rm pyproject.toml.bak
else
  echo "Error: Failed to update version" >&2
  exit 1
fi

echo "Version updated successfully"