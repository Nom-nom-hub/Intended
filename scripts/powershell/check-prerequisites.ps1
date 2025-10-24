#!/usr/bin/env pwsh

param(
    [switch]$Help
)

if ($Help) {
    Write-Host "Usage: .\check-prerequisites.ps1" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Checks if all prerequisites for Intent Kit are installed."
    Write-Host ""
    Write-Host "Prerequisites checked:"
    Write-Host "  - Git"
    Write-Host "  - Python 3.11+"
    Write-Host "  - uv (Python package manager)"
    Write-Host "  - AI agents (Claude Code, Cursor, GitHub Copilot, etc.)"
    exit 0
}

Write-Host "Checking prerequisites for Intent Kit..." -ForegroundColor Cyan
Write-Host ""

# Function to check if a command exists
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

# Function to print status
function Write-Status {
    param(
        [string]$Status,
        [string]$Message,
        [string]$Details = ""
    )

    switch ($Status) {
        "ok" {
            Write-Host "✓" -ForegroundColor Green -NoNewline
            Write-Host " $Message" -ForegroundColor White
        }
        "warning" {
            Write-Host "⚠" -ForegroundColor Yellow -NoNewline
            Write-Host " $Message" -ForegroundColor White
        }
        "error" {
            Write-Host "✗" -ForegroundColor Red -NoNewline
            Write-Host " $Message" -ForegroundColor White
        }
    }

    if ($Details) {
        Write-Host "  $Details" -ForegroundColor DarkGray
    }
}

# Check Git
if (Test-Command "git") {
    $gitVersion = (git --version) | Select-String -Pattern "git version (\d+\.\d+\.\d+)" | ForEach-Object { $_.Matches[0].Groups[1].Value }
    Write-Status "ok" "Git $gitVersion"
}
else {
    Write-Status "error" "Git not found"
    Write-Host "  Install Git from: https://git-scm.com/downloads" -ForegroundColor DarkGray
}

# Check Python
if (Test-Command "python") {
    $pythonVersion = (python --version) | Select-String -Pattern "Python (\d+\.\d+\.\d+)" | ForEach-Object { $_.Matches[0].Groups[1].Value }
    Write-Status "ok" "Python $pythonVersion"

    # Check if Python 3.11+
    $versionParts = $pythonVersion.Split('.')
    $majorVersion = [int]$versionParts[0]
    $minorVersion = [int]$versionParts[1]

    if ($majorVersion -lt 3 -or ($majorVersion -eq 3 -and $minorVersion -lt 11)) {
        Write-Status "warning" "Python 3.11+ recommended for best experience"
    }
}
elseif (Test-Command "python3") {
    $pythonVersion = (python3 --version) | Select-String -Pattern "Python (\d+\.\d+\.\d+)" | ForEach-Object { $_.Matches[0].Groups[1].Value }
    Write-Status "ok" "Python $pythonVersion"

    # Check if Python 3.11+
    $versionParts = $pythonVersion.Split('.')
    $majorVersion = [int]$versionParts[0]
    $minorVersion = [int]$versionParts[1]

    if ($majorVersion -lt 3 -or ($majorVersion -eq 3 -and $minorVersion -lt 11)) {
        Write-Status "warning" "Python 3.11+ recommended for best experience"
    }
}
else {
    Write-Status "error" "Python not found"
    Write-Host "  Install Python 3.11+ from: https://python.org/downloads" -ForegroundColor DarkGray
}

# Check uv (Python package manager)
if (Test-Command "uv") {
    $uvVersion = (uv --version) | Select-String -Pattern "uv (\d+\.\d+\.\d+)" | ForEach-Object { $_.Matches[0].Groups[1].Value }
    Write-Status "ok" "uv $uvVersion"
}
else {
    Write-Status "warning" "uv not found (optional, but recommended)"
    Write-Host "  Install uv from: https://docs.astral.sh/uv/getting-started/installation/" -ForegroundColor DarkGray
}

# Check AI Agents
Write-Host ""
Write-Host "Checking AI agents..." -ForegroundColor Cyan

# Claude Code
if (Test-Command "claude") {
    Write-Status "ok" "Claude Code"
}
elseif (Test-Path "$env:USERPROFILE\.claude\local\claude") {
    Write-Status "ok" "Claude Code (local installation)"
}
else {
    Write-Status "warning" "Claude Code not found"
    Write-Host "  Install from: https://docs.anthropic.com/en/docs/claude-code/setup" -ForegroundColor DarkGray
}

# Cursor
if (Test-Command "cursor") {
    Write-Status "ok" "Cursor"
}
else {
    Write-Status "warning" "Cursor not found"
    Write-Host "  Install from: https://cursor.sh/" -ForegroundColor DarkGray
}

# Visual Studio Code
if (Test-Command "code") {
    Write-Status "ok" "Visual Studio Code"
}
else {
    Write-Status "warning" "Visual Studio Code not found"
    Write-Host "  Install from: https://code.visualstudio.com/" -ForegroundColor DarkGray
}

# VS Code Insiders
if (Test-Command "code-insiders") {
    Write-Status "ok" "Visual Studio Code Insiders"
}

# Gemini CLI
if (Test-Command "gemini") {
    Write-Status "ok" "Gemini CLI"
}
else {
    Write-Status "warning" "Gemini CLI not found"
    Write-Host "  Install from: https://github.com/google-gemini/gemini-cli" -ForegroundColor DarkGray
}

# Qwen Code
if (Test-Command "qwen") {
    Write-Status "ok" "Qwen Code"
}
else {
    Write-Status "warning" "Qwen Code not found"
    Write-Host "  Install from: https://github.com/QwenLM/qwen-code" -ForegroundColor DarkGray
}

# opencode
if (Test-Command "opencode") {
    Write-Status "ok" "opencode"
}
else {
    Write-Status "warning" "opencode not found"
    Write-Host "  Install from: https://opencode.ai/" -ForegroundColor DarkGray
}

# Codex CLI
if (Test-Command "codex") {
    Write-Status "ok" "Codex CLI"
}
else {
    Write-Status "warning" "Codex CLI not found"
    Write-Host "  Install from: https://github.com/openai/codex" -ForegroundColor DarkGray
}

# Windsurf
if (Test-Command "windsurf") {
    Write-Status "ok" "Windsurf"
}
else {
    Write-Status "warning" "Windsurf not found"
    Write-Host "  Install from: https://windsurf.com/" -ForegroundColor DarkGray
}

# Kilo Code
if (Test-Command "kilocode") {
    Write-Status "ok" "Kilo Code"
}
else {
    Write-Status "warning" "Kilo Code not found"
    Write-Host "  Install from: https://github.com/Kilo-Org/kilocode" -ForegroundColor DarkGray
}

# Auggie CLI
if (Test-Command "auggie") {
    Write-Status "ok" "Auggie CLI"
}
else {
    Write-Status "warning" "Auggie CLI not found"
    Write-Host "  Install from: https://docs.augmentcode.com/cli/setup-auggie/install-auggie-cli" -ForegroundColor DarkGray
}

# CodeBuddy CLI
if (Test-Command "codebuddy") {
    Write-Status "ok" "CodeBuddy CLI"
}
else {
    Write-Status "warning" "CodeBuddy CLI not found"
    Write-Host "  Install from: https://www.codebuddy.ai/cli" -ForegroundColor DarkGray
}

# Roo Code
if (Test-Command "roo") {
    Write-Status "ok" "Roo Code"
}
else {
    Write-Status "warning" "Roo Code not found"
    Write-Host "  Install from: https://roocode.com/" -ForegroundColor DarkGray
}

# Amazon Q Developer CLI
if (Test-Command "q") {
    Write-Status "ok" "Amazon Q Developer CLI"
}
else {
    Write-Status "warning" "Amazon Q Developer CLI not found"
    Write-Host "  Install from: https://aws.amazon.com/developer/learning/q-developer-cli/" -ForegroundColor DarkGray
}

# Amp
if (Test-Command "amp") {
    Write-Status "ok" "Amp"
}
else {
    Write-Status "warning" "Amp not found"
    Write-Host "  Install from: https://ampcode.com/manual#install" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "Prerequisites check complete!" -ForegroundColor Green
Write-Host ""
Write-Host "To install Intent CLI:" -ForegroundColor Cyan
Write-Host "  uv tool install intent-cli --from git+https://github.com/Nom-nom-hub/Intended.git" -ForegroundColor White
Write-Host ""
Write-Host "To initialize a new project:" -ForegroundColor Cyan
Write-Host "  intent init my-project" -ForegroundColor White