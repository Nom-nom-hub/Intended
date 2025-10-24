#!/usr/bin/env pwsh

# Load common functions
. (Join-Path $PSScriptRoot "common.ps1")

Write-Info "Setting up implementation plan..."

# Resolve repository root
$repoRoot = Get-RepoRoot
Set-Location $repoRoot

# Check if we have a feature set
if (-not $env:INTENT_FEATURE) {
    Write-Error "INTENT_FEATURE environment variable not set"
    Write-Info "Please run this script from within a feature branch or set INTENT_FEATURE"
    exit 1
}

$featureDir = Join-Path $repoRoot "intents" $env:INTENT_FEATURE

if (-not (Test-Path $featureDir)) {
    Write-Error "Feature directory not found: $featureDir"
    Write-Info "Please ensure you're in the correct feature branch"
    exit 1
}

# Check if Intent exists
$specFile = Join-Path $featureDir "Intent.md"
if (-not (Test-Path $specFile)) {
    Write-Error "Specification file not found: $specFile"
    Write-Info "Please create a specification first using /intentkit.Intended"
    exit 1
}

Write-Success "Feature directory found: $featureDir"
Write-Success "Specification found: $specFile"

# Create plan directory structure
$contractsDir = Join-Path $featureDir "contracts"
$plansDir = Join-Path $featureDir "plans"
New-Item -ItemType Directory -Force -Path $contractsDir, $plansDir | Out-Null

# Create plan file
$planTemplate = Join-Path $repoRoot ".intent\templates\plan-template.md"
$planFile = Join-Path $plansDir "plan.md"

if (Test-Path $planTemplate) {
    Copy-Item $planTemplate $planFile
    Write-Success "Created plan template: $planFile"
}
else {
    $date = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"
    $planContent = @"
# Implementation Plan: $env:INTENT_FEATURE

**Created**: $date
**Status**: Draft

## Technical Approach

### Technology Stack
[Intended the technology stack and rationale]

### Architecture Overview
[High-level architecture description]

## Implementation Strategy

### Phase 1: [Phase Name]
- [Task 1]
- [Task 2]

### Phase 2: [Phase Name]
- [Task 1]
- [Task 2]

## Integration Points
[Describe how components integrate]

## Risk Assessment
[Identify potential risks and mitigation strategies]
"@
    Set-Content -Path $planFile -Value $planContent
    Write-Success "Created basic plan structure: $planFile"
}

# Create research document
$researchFile = Join-Path $featureDir "research.md"
$date = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"
$researchContent = @"
# Research Document: $env:INTENT_FEATURE

**Created**: $date
**Status**: In Progress

## Technology Research

### [Technology 1]
- **Purpose**: [Why this technology]
- **Version**: [Recommended version]
- **Rationale**: [Why this choice]
- **Alternatives considered**: [Other options and why not chosen]

## Architecture Research

### Design Patterns
[Relevant design patterns and their application]

### Integration Patterns
[How different components will integrate]

## Risk Analysis

### Technical Risks
- **Risk**: [Description]
  **Mitigation**: [How to address]
  **Impact**: [High/Medium/Low]

## Recommendations

### Immediate Actions
[What should be done next]

### Open Questions
[Unresolved questions that need answers]
"@
Set-Content -Path $researchFile -Value $researchContent
Write-Success "Created research document: $researchFile"

# Create quickstart document
$quickstartFile = Join-Path $featureDir "quickstart.md"
$quickstartContent = @"
# Quick Start: $env:INTENT_FEATURE

**Created**: $date

## Overview
[Brief description of what this feature does]

## Getting Started

### Prerequisites
- [Requirement 1]
- [Requirement 2]

### Setup Steps
1. [Step 1]
2. [Step 2]

## Usage

### Basic Usage
[How to use the feature]

### Examples
[Code examples or usage examples]

## Next Steps
[What to do after this feature is complete]
"@
Set-Content -Path $quickstartFile -Value $quickstartContent
Write-Success "Created quickstart document: $quickstartFile"

Write-Success "Plan setup complete!"
Write-Host ""
Write-Info "Next steps:"
Write-Host "1. Review and update: $planFile" -ForegroundColor DarkGray
Write-Host "2. Research technologies: $researchFile" -ForegroundColor DarkGray
Write-Host "3. Update quickstart: $quickstartFile" -ForegroundColor DarkGray
Write-Host "4. Use /intentkit.tasks to generate task breakdown" -ForegroundColor DarkGray
Write-Host "5. Use /intentkit.implement to execute implementation" -ForegroundColor DarkGray