#!/usr/bin/env pwsh

# Common functions and utilities for Intent Kit PowerShell scripts

# Function to print colored output
function Write-Info {
    param([string]$Message)
    Write-Host "ℹ $Message" -ForegroundColor Blue
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠ $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red -NoNewline
    Write-Host "" -ForegroundColor Red
}

# Function to check if command exists
function Test-Command {
    param([string]$Command)

    try {
        $null = Get-Command $Command -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

# Function to find repository root
function Find-RepoRoot {
    param([string]$StartPath = (Get-Location).Path)

    $current = $StartPath
    while ($current -ne [System.IO.Path]::GetPathRoot($current)) {
        if ((Test-Path "$current\.git") -or (Test-Path "$current\.intent")) {
            return $current
        }
        $current = Split-Path $current -Parent
    }

    return $null
}

# Function to resolve repository root
function Get-RepoRoot {
    # Try git first
    try {
        $gitRoot = git rev-parse --show-toplevel 2>$null
        if ($gitRoot) {
            return $gitRoot
        }
    }
    catch {
        # Git not available or not in repo
    }

    # Fall back to searching for markers
    $repoRoot = Find-RepoRoot
    if (-not $repoRoot) {
        Write-Error "Could not determine repository root. Please run this script from within the repository."
        exit 1
    }

    return $repoRoot
}

# Function to check if we're in a git repository
function Test-GitRepo {
    try {
        $null = git rev-parse --is-inside-work-tree 2>$null
        return $true
    }
    catch {
        return $false
    }
}

# Function to get the next feature number
function Get-NextFeatureNumber {
    param([string]$IntentsDir)

    $maxNum = 0

    if (Test-Path $IntentsDir) {
        Get-ChildItem $IntentsDir -Directory | ForEach-Object {
            $dirName = $_.Name
            $number = $dirName -match '^(\d+)-' | Out-Null
            if ($matches[1]) {
                $num = [int]$matches[1]
                if ($num -gt $maxNum) {
                    $maxNum = $num
                }
            }
        }
    }

    return $maxNum + 1
}

# Function to format feature number with leading zeros
function Format-FeatureNumber {
    param([int]$Number)
    return "{0:D3}" -f $Number
}

# Function to generate branch name from description
function New-BranchName {
    param([string]$Description)

    # Common stop words to filter out
    $stopWords = @("i", "a", "an", "the", "to", "for", "of", "in", "on", "at", "by", "with", "from", "is", "are", "was", "were", "be", "been", "being", "have", "has", "had", "do", "does", "did", "will", "would", "should", "could", "can", "may", "might", "must", "shall", "this", "that", "these", "those", "my", "your", "our", "their", "want", "need", "add", "get", "set")

    # Convert to lowercase and split into words
    $cleanName = $Description.ToLower() -replace '[^a-z0-9]', ' '

    # Filter words: remove stop words and words shorter than 3 chars
    $meaningfulWords = @()
    $cleanName.Split(' ') | ForEach-Object {
        $word = $_.Trim()
        if ($word -and $word.Length -ge 3 -and $word -notin $stopWords) {
            $meaningfulWords += $word
        }
    }

    # Use first 3-4 meaningful words
    $maxWords = 3
    if ($meaningfulWords.Count -eq 4) {
        $maxWords = 4
    }

    $result = ""
    for ($i = 0; $i -lt [Math]::Min($maxWords, $meaningfulWords.Count); $i++) {
        if ($result) {
            $result += "-"
        }
        $result += $meaningfulWords[$i]
    }

    if (-not $result) {
        # Fallback to original logic if no meaningful words found
        $result = $Description.ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-', '' -replace '-$', ''
    }

    return $result
}

# Function to validate branch name length (GitHub limit is 244 bytes)
function Test-BranchNameLength {
    param([string]$BranchName)

    $maxLength = 244

    if ($BranchName.Length -gt $maxLength) {
        Write-Warning "Branch name exceeded GitHub's 244-byte limit"
        Write-Warning "Original: $BranchName ($($BranchName.Length) bytes)"

        # Calculate how much we need to trim from suffix
        # Account for: feature number (3) + hyphen (1) = 4 chars
        $maxSuffixLength = $maxLength - 4

        # Extract the suffix part (everything after the first hyphen)
        $suffix = $BranchName.Split('-', 2)[1]

        # Truncate suffix at word boundary if possible
        $truncatedSuffix = $suffix.Substring(0, [Math]::Min($maxSuffixLength, $suffix.Length))
        # Remove trailing hyphen if truncation created one
        $truncatedSuffix = $truncatedSuffix -replace '-$'

        # Extract the number part
        $numberPart = $BranchName.Split('-')[0]

        # Create new branch name
        $newBranchName = "$numberPart-$truncatedSuffix"

        Write-Warning "Truncated to: $newBranchName ($($newBranchName.Length) bytes)"
        return $newBranchName
    }

    return $BranchName
}

# Function to run command with error handling
function Invoke-Command {
    param(
        [string]$Command,
        [string]$ErrorMessage = "Command failed: $Command"
    )

    try {
        Invoke-Expression $Command
        if ($LASTEXITCODE -ne 0) {
            Write-Error $ErrorMessage
            exit 1
        }
    }
    catch {
        Write-Error $ErrorMessage
        exit 1
    }
}

# Function to confirm action
function Confirm-Action {
    param(
        [string]$Message,
        [bool]$DefaultYes = $false
    )

    if (-not (Test-Path "variable:Host")) {
        # Non-interactive
        if ($DefaultYes) {
            Write-Info "$Message (auto-confirmed)"
            return $true
        }
        else {
            Write-Warning "$Message (cancelled in non-interactive mode)"
            return $false
        }
    }

    $choices = @(
        [System.Management.Automation.Host.ChoiceDescription]::new("&Yes", "Continue")
        [System.Management.Automation.Host.ChoiceDescription]::new("&No", "Cancel")
    )

    $default = if ($DefaultYes) { 0 } else { 1 }
    $result = $Host.UI.PromptForChoice("", $Message, $choices, $default)

    return $result -eq 0
}

# Function to check if directory is empty or confirm overwrite
function Test-Directory {
    param(
        [string]$Path,
        [switch]$Force
    )

    if (-not (Test-Path $Path)) {
        return $true
    }

    $itemCount = (Get-ChildItem $Path -Force).Count

    if ($itemCount -eq 0) {
        return $true
    }

    if ($Force) {
        Write-Warning "Directory $Path is not empty, but -Force specified. Continuing..."
        return $true
    }

    Write-Warning "Directory $Path is not empty ($itemCount items)"
    return Confirm-Action "Do you want to continue? This may overwrite existing files."
}

# Function to set up git repository
function New-GitRepo {
    param([string]$ProjectPath)

    if (-not (Test-Command "git")) {
        Write-Warning "Git not found, skipping repository initialization"
        return $false
    }

    if (Test-GitRepo) {
        Write-Info "Git repository already exists"
        return $true
    }

    Write-Info "Initializing git repository..."
    Push-Location $ProjectPath

    try {
        Invoke-Command "git init" "Failed to initialize git repository"
        Invoke-Command "git add ." "Failed to add files to git"
        Invoke-Command "git commit -m 'Initial commit from Intent template'" "Failed to create initial commit"

        Write-Success "Git repository initialized"
        return $true
    }
    finally {
        Pop-Location
    }
}

# Export functions so they can be used by other scripts
Export-ModuleMember -Function Write-Info, Write-Success, Write-Warning, Write-Error
Export-ModuleMember -Function Test-Command, Get-RepoRoot, Test-GitRepo
Export-ModuleMember -Function Get-NextFeatureNumber, Format-FeatureNumber, New-BranchName
Export-ModuleMember -Function Test-BranchNameLength, Invoke-Command, Confirm-Action
Export-ModuleMember -Function Test-Directory, New-GitRepo