#!/usr/bin/env pwsh

param(
    [switch]$Json,
    [string]$ShortName = "",
    [int]$Number = 0,
    [switch]$Help
)

# Load common functions
. (Join-Path $PSScriptRoot "common.ps1")

if ($Help) {
    Write-Host "Usage: .\create-new-feature.ps1 [-Json] [-ShortName <name>] [-Number N] <feature_description>" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -Json              Output in JSON format"
    Write-Host "  -ShortName <name>  Provide a custom short name (2-4 words) for the branch"
    Write-Host "  -Number N          Specify branch number manually (overrides auto-detection)"
    Write-Host "  -Help              Show this help message"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\create-new-feature.ps1 'Add user authentication system' -ShortName 'user-auth'"
    Write-Host "  .\create-new-feature.ps1 'Implement OAuth2 integration for API' -Number 5"
    exit 0
}

# Get feature description from remaining arguments
$featureDescription = $args -join " "
if (-not $featureDescription) {
    Write-Error "Usage: .\create-new-feature.ps1 [-Json] [-ShortName <name>] [-Number N] <feature_description>"
    exit 1
}

# Resolve repository root
$repoRoot = Get-RepoRoot
Set-Location $repoRoot

# Set up directories
$intentsDir = Join-Path $repoRoot "intents"
New-Item -ItemType Directory -Force -Path $intentsDir | Out-Null

# Generate branch name
if ($ShortName) {
    $branchSuffix = $ShortName.ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-', '' -replace '-$'
}
else {
    $branchSuffix = New-BranchName $featureDescription
}

# Determine branch number
if ($Number -eq 0) {
    if (Test-GitRepo) {
        $branchNumber = Get-NextFeatureNumber $intentsDir
    }
    else {
        $branchNumber = Get-NextFeatureNumber $intentsDir
    }
}
else {
    $branchNumber = $Number
}

$featureNum = Format-FeatureNumber $branchNumber
$branchName = "$featureNum-$branchSuffix"

# Validate branch name length
$branchName = Test-BranchNameLength $branchName

# Create and checkout branch if in git repo
if (Test-GitRepo) {
    Invoke-Command "git checkout -b $branchName" "Failed to create and checkout branch"
}
else {
    Write-Warning "Git repository not detected; skipped branch creation for $branchName"
}

# Create feature directory
$featureDir = Join-Path $intentsDir $branchName
New-Item -ItemType Directory -Force -Path $featureDir | Out-Null

# Copy template
$template = Join-Path $repoRoot ".intent\templates\Intent-template.md"
$specFile = Join-Path $featureDir "Intent.md"

if (Test-Path $template) {
    Copy-Item $template $specFile
    Write-Success "Created specification template: $specFile"
}
else {
    New-Item -ItemType File -Path $specFile | Out-Null
    Write-Warning "Template not found, created empty Intent file: $specFile"
}

# Set environment variable
$env:INTENT_FEATURE = $branchName

# Output results
if ($Json) {
    $result = @{
        BRANCH_NAME = $branchName
        SPEC_FILE = $specFile
        FEATURE_NUM = $featureNum
    }
    $result | ConvertTo-Json -Compress
}
else {
    Write-Success "Feature created successfully!"
    Write-Host "BRANCH_NAME: $branchName" -ForegroundColor White
    Write-Host "SPEC_FILE: $specFile" -ForegroundColor White
    Write-Host "FEATURE_NUM: $featureNum" -ForegroundColor White
    Write-Host "INTENT_FEATURE environment variable set to: $branchName" -ForegroundColor White
    Write-Host ""
    Write-Info "Next steps:"
    Write-Host "1. Edit the specification in: $specFile" -ForegroundColor DarkGray
    Write-Host "2. Use /intentkit.plan to create implementation plan" -ForegroundColor DarkGray
    Write-Host "3. Use /intentkit.tasks to generate task breakdown" -ForegroundColor DarkGray
    Write-Host "4. Use /intentkit.implement to execute implementation" -ForegroundColor DarkGray
}