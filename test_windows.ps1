# Windows Testing Script for Assignment 3
# Uses WSL to build and test

Write-Host "Assignment 3 - Windows Testing Script" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Check if WSL is available
$wslCheck = wsl --list 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: WSL not available. Please install WSL first." -ForegroundColor Red
    Write-Host "Install: wsl --install" -ForegroundColor Yellow
    exit 1
}

Write-Host "WSL detected. Checking environment..." -ForegroundColor Green
Write-Host ""

# Check if we're in the right directory
$currentDir = Get-Location
Write-Host "Current directory: $currentDir" -ForegroundColor Yellow

# Check for required files
$requiredFiles = @("viewer.cpp", "example12b.fs", "example12d.fs", "sphere.obj", "Makefile")
$missing = @()

foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "  [OK] $file" -ForegroundColor Green
    } else {
        Write-Host "  [MISSING] $file" -ForegroundColor Red
        $missing += $file
    }
}

if ($missing.Count -gt 0) {
    Write-Host ""
    Write-Host "ERROR: Missing required files!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Files check passed!" -ForegroundColor Green
Write-Host ""

# Check if environment map exists
Write-Host "Checking for environment map..." -ForegroundColor Cyan
$envMapCheck = wsl test -d "VancouverConventionCentre" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "  WARNING: VancouverConventionCentre directory not found" -ForegroundColor Yellow
    Write-Host "  You'll need this to run the program" -ForegroundColor Yellow
} else {
    Write-Host "  [OK] Environment map directory found" -ForegroundColor Green
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Ready to build and test!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Install dependencies in WSL:" -ForegroundColor White
Write-Host "   wsl sudo apt-get update" -ForegroundColor Yellow
Write-Host "   wsl sudo apt-get install -y build-essential libfreeimage-dev libglfw3-dev libglew-dev" -ForegroundColor Yellow
Write-Host ""
Write-Host "2. Build the project:" -ForegroundColor White
Write-Host "   wsl make" -ForegroundColor Yellow
Write-Host ""
Write-Host "3. Test Part 1:" -ForegroundColor White
Write-Host "   wsl ./example12 a b" -ForegroundColor Yellow
Write-Host ""
Write-Host "4. Test Part 2b:" -ForegroundColor White
Write-Host "   wsl ./example12 a d" -ForegroundColor Yellow
Write-Host ""




