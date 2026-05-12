#!/usr/bin/env pwsh

# Load common functions
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$scriptPath/common.ps1"

# Parse arguments
$jsonMode = $false
$argsList = @()

for ($i = 0; $i -lt $args.Count; $i++) {
    switch ($args[$i]) {
        '-Json' { $jsonMode = $true }
        '-Help' { 
            Write-Host "Usage: create-research.ps1 [-Json] [research description]"
            Write-Host ""
            Write-Host "Options:"
            Write-Host "  -Json              Output in JSON format"
            Write-Host "  -Help              Show this help message"
            exit 0
        }
        default { $argsList += $args[$i] }
    }
}

# Resolve repository root
$repoRoot = Get-RepoRoot
Set-Location $repoRoot

# Determine the current feature
$branchName = ""

# Check INTENT_FEATURE environment variable first
if ($env:INTENT_FEATURE) {
    $branchName = $env:INTENT_FEATURE
    Write-Info "Using INTENT_FEATURE: $branchName"
}

# Fall back to git branch detection
if (-not $branchName -and (Test-GitRepo)) {
    try {
        $currentBranch = git rev-parse --abbrev-ref HEAD 2>$null
        if ($currentBranch -and $currentBranch -ne "main" -and $currentBranch -ne "master") {
            $branchName = $currentBranch
            Write-Info "Using current branch: $branchName"
        }
    }
    catch {
        # Git not available
    }
}

# If no feature detected, abort
if (-not $branchName) {
    Write-Error "No active feature detected."
    Write-Error "Please run /intent.intend first to create a feature specification."
    exit 1
}

# Set up research directory
$intentsDir = Join-Path $repoRoot "intents"
$featureDir = Join-Path $intentsDir $branchName

# Check if feature directory exists
if (-not (Test-Path $featureDir)) {
    Write-Warning "Feature directory not found: $featureDir"
    Write-Info "Creating feature directory..."
    New-Item -ItemType Directory -Path $featureDir -Force | Out-Null
}

# Ensure Intent.md exists
$intentFile = Join-Path $featureDir "Intent.md"
if (-not (Test-Path $intentFile)) {
    Write-Warning "Intent.md not found in $featureDir"
    Write-Info "Creating placeholder Intent.md..."
    New-Item -ItemType File -Path $intentFile -Force | Out-Null
}

# Create research directory
$researchDir = Join-Path $featureDir "research"
New-Item -ItemType Directory -Path $researchDir -Force | Out-Null

# Generate timestamp
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$researchFile = Join-Path $researchDir "research-${timestamp}.md"

# Copy research template if available
$template = Join-Path $repoRoot ".intent" "templates" "research-template.md"
if (-not (Test-Path $template)) {
    # Fall back to Intended project templates
    $template = Join-Path $repoRoot "Intended" "templates" "research-template.md"
}

if (Test-Path $template) {
    Copy-Item $template $researchFile
    Write-Success "Created research document from template: $researchFile"
}
else {
    New-Item -ItemType File -Path $researchFile -Force | Out-Null
    Write-Warning "Research template not found, created empty research document: $researchFile"
}

# Set the INTENT_FEATURE environment variable for downstream use
$env:INTENT_FEATURE = $branchName

# Output results
if ($jsonMode) {
    $output = @{
        BRANCH_NAME   = $branchName
        RESEARCH_DIR  = $researchDir
        RESEARCH_FILE = $researchFile
        FEATURE_DIR   = $featureDir
    }
    ConvertTo-Json $output
}
else {
    Write-Success "Research environment ready!"
    Write-Host "BRANCH_NAME: $branchName"
    Write-Host "RESEARCH_DIR: $researchDir"
    Write-Host "RESEARCH_FILE: $researchFile"
    Write-Host "FEATURE_DIR: $featureDir"
    Write-Host ""
    Write-Info "Next steps:"
    Write-Host "1. Review the Intent.md at: $featureDir\Intent.md"
    Write-Host "2. Conduct research and document findings in: $researchFile"
    Write-Host "3. Use /intent.plan to create implementation plan based on research"
}
