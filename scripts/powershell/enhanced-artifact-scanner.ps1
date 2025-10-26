#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Enhanced Artifact Scanner for Intent Kit
.DESCRIPTION
    Discovers and classifies project artifacts for enhanced task generation
#>

param(
    [string]$ConfigFile = "$PSScriptRoot/../../.intent/enhanced-config.json",
    [switch]$Verbose
)

# Configuration
$ScanPatterns = @("**/*.md", "**/*.json", "**/*.yaml", "**/*.yml", "docs/**", "design/**", "specs/**")
$IgnorePatterns = @("node_modules/**", ".git/**", "dist/**", "build/**", "**/.DS_Store")

# Colors for output
$Colors = @{
    Info = "Blue"
    Success = "Green"
    Warning = "Yellow"
    Error = "Red"
}

function Write-Log {
    param(
        [string]$Message,
        [string]$Level = "Info"
    )

    $color = $Colors[$Level]
    if ($color) {
        Write-Host "[$Level] $Message" -ForegroundColor $color
    } else {
        Write-Host "[$Level] $Message"
    }
}

function Test-EnhancedFeatures {
    if (-not (Test-Path $ConfigFile)) {
        Write-Log "Enhanced config file not found: $ConfigFile" -Level Warning
        return $false
    }

    try {
        $config = Get-Content $ConfigFile -Raw | ConvertFrom-Json
        $enabled = $config.enhanced_features.artifact_expansion.enabled
        if (-not $enabled) {
            Write-Log "Artifact expansion feature is disabled" -Level Info
            return $false
        }
        return $true
    }
    catch {
        Write-Log "Error reading config file: $($_.Exception.Message)" -Level Error
        return $false
    }
}

function Get-Config {
    if (-not (Test-Path $ConfigFile)) {
        throw "Configuration file not found: $ConfigFile"
    }

    $config = Get-Content $ConfigFile -Raw | ConvertFrom-Json

    # Load scan patterns from config
    if ($config.artifact_support.discovery.scan_patterns) {
        $script:ScanPatterns = $config.artifact_support.discovery.scan_patterns
    }

    Write-Log "Loaded configuration from $ConfigFile"
}

function Test-ShouldIgnore {
    param([string]$File)

    foreach ($pattern in $IgnorePatterns) {
        if ($File -like $pattern) {
            return $true
        }
    }
    return $false
}

function Get-ArtifactType {
    param([string]$File)

    $relativePath = $File.Replace($RepoRoot, "").TrimStart("\")

    # Check file extension and path
    if ($relativePath -match "\.md$") {
        if ($relativePath -match "architecture") { return "architecture" }
        elseif ($relativePath -match "wireframe|mockup") { return "wireframes" }
        elseif ($relativePath -match "api|spec") { return "api-specs" }
        elseif ($relativePath -match "data|model") { return "data-model" }
        else { return "documentation" }
    }
    elseif ($relativePath -match "\.(json|yaml|yml)$") {
        if ($relativePath -match "contract|api") { return "contracts" }
        else { return "configuration" }
    }
    else {
        return "unknown"
    }
}

function Find-Artifacts {
    $artifacts = @()

    Write-Log "Scanning for artifacts in $RepoRoot"

    foreach ($pattern in $ScanPatterns) {
        Write-Log "Scanning pattern: $pattern"

        try {
            $files = Get-ChildItem -Path $RepoRoot -Recurse -File -Filter $pattern -ErrorAction SilentlyContinue
            foreach ($file in $files) {
                $relativePath = $file.FullName.Replace($RepoRoot, "").TrimStart("\")

                if (-not (Test-ShouldIgnore $relativePath)) {
                    $artifactType = Get-ArtifactType $file.FullName
                    $artifacts += @{
                        Path = $file.FullName
                        RelativePath = $relativePath
                        Type = $artifactType
                        Size = $file.Length
                        Modified = $file.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss")
                    }

                    Write-Log "Found $($artifactType): $($relativePath)"
                }
            }
        }
        catch {
            Write-Log "Error scanning pattern $pattern`: $($_.Exception.Message)" -Level Warning
        }
    }

    return $artifacts
}

function New-ArtifactReport {
    param([array]$Artifacts)

    $reportFile = Join-Path $RepoRoot ".intent/artifact-scan-report.json"

    Write-Log "Generating artifact scan report: $reportFile"

    # Create directory if it doesn't exist
    $reportDir = Split-Path $reportFile -Parent
    if (-not (Test-Path $reportDir)) {
        New-Item -ItemType Directory -Path $reportDir -Force | Out-Null
    }

    # Build report object
    $report = @{
        timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
        total_artifacts = $Artifacts.Count
        artifacts = $Artifacts | ForEach-Object {
            @{
                path = $_.RelativePath
                type = $_.Type
                size = $_.Size
                modified = $_.Modified
            }
        }
    }

    # Save as JSON
    $report | ConvertTo-Json -Depth 10 | Out-File $reportFile -Encoding UTF8

    Write-Log "Scanned $($Artifacts.Count) artifacts and saved report to $reportFile" -Level Success
}

# Main execution
function Invoke-Main {
    Write-Log "Intent Kit Enhanced Artifact Scanner"
    Write-Log "===================================="

    if (-not (Test-EnhancedFeatures)) {
        Write-Log "Enhanced features not enabled. Run 'intent init --all-enhanced' to enable." -Level Info
        exit 0
    }

    try {
        Get-Config

        # Scan for artifacts
        $artifacts = Find-Artifacts

        if ($artifacts.Count -eq 0) {
            Write-Log "No artifacts found" -Level Warning
            exit 0
        }

        # Generate report
        New-ArtifactReport -Artifacts $artifacts

        Write-Log "Artifact scanning completed successfully" -Level Success
    }
    catch {
        Write-Log "Error: $($_.Exception.Message)" -Level Error
        exit 1
    }
}

# Set script root and repo root
$ScriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
$RepoRoot = Split-Path $ScriptDir -Parent | Split-Path -Parent

# Run main function
Invoke-Main
