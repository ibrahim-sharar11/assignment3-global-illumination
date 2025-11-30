# Windows PowerShell script to build and run Assignment 3 using WSL

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Assignment 3 - Windows Build & Run" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get current directory path
$currentDir = Get-Location
$wslPath = $currentDir.Path.Replace('\', '/').Replace('C:', '/mnt/c')

Write-Host "Current directory: $currentDir" -ForegroundColor Yellow
Write-Host "WSL path: $wslPath" -ForegroundColor Yellow
Write-Host ""

# Step 1: Check WSL
Write-Host "Step 1: Checking WSL..." -ForegroundColor Green
$wslCheck = wsl --status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: WSL not available!" -ForegroundColor Red
    Write-Host "Please install WSL first: wsl --install" -ForegroundColor Yellow
    exit 1
}
Write-Host "  [OK] WSL is available" -ForegroundColor Green
Write-Host ""

# Step 2: Check dependencies
Write-Host "Step 2: Checking dependencies..." -ForegroundColor Green
$depCheck = wsl bash -c "dpkg -l | grep -E 'libfreeimage|libglfw|libglew' | head -3"
if ($depCheck -match "libfreeimage|libglfw|libglew") {
    Write-Host "  [OK] Some dependencies found" -ForegroundColor Green
} else {
    Write-Host "  [WARN] Dependencies may need to be installed" -ForegroundColor Yellow
    Write-Host "  Run: wsl sudo apt-get install -y build-essential libfreeimage-dev libglfw3-dev libglew-dev libgl1-mesa-dev" -ForegroundColor Cyan
}
Write-Host ""

# Step 3: Navigate to project and check files
Write-Host "Step 3: Checking project files..." -ForegroundColor Green
try {
    $fileCheck = wsl bash -c "cd '$wslPath' 2>&1 && ls -1 *.cpp *.fs *.vs Makefile sphere.obj 2>/dev/null | wc -l" 2>&1
    if ($fileCheck -match '^\d+') {
        $fileCount = [int]($fileCheck -replace '[^\d]', '')
        if ($fileCount -gt 0) {
            Write-Host "  [OK] Found required files" -ForegroundColor Green
        } else {
            Write-Host "  [WARN] Could not verify files (but continuing anyway)" -ForegroundColor Yellow
        }
    } else {
        Write-Host "  [WARN] Could not verify files (but continuing anyway)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  [WARN] Could not verify files (but continuing anyway)" -ForegroundColor Yellow
}
Write-Host ""

# Step 4: Menu
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "What would you like to do?" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Install dependencies (first time only)" -ForegroundColor White
Write-Host "2. Build the project" -ForegroundColor White
Write-Host "3. Build and run Part 1 (Reflection & Refraction)" -ForegroundColor White
Write-Host "4. Build and run Part 2b (Monte Carlo Sampling)" -ForegroundColor White
Write-Host "5. Run Part 1 (if already built)" -ForegroundColor White
Write-Host "6. Run Part 2b (if already built)" -ForegroundColor White
Write-Host "7. Exit" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Enter your choice (1-7)"

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "Installing dependencies..." -ForegroundColor Green
        Write-Host "You may be asked for your password" -ForegroundColor Yellow
        wsl sudo apt-get update
        wsl sudo apt-get install -y build-essential libfreeimage-dev libglfw3-dev libglew-dev libgl1-mesa-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev
        Write-Host ""
        Write-Host "Dependencies installed!" -ForegroundColor Green
    }
    "2" {
        Write-Host ""
        Write-Host "Building project..." -ForegroundColor Green
        wsl bash -c "cd '$wslPath' && make clean && make"
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "Build successful!" -ForegroundColor Green
        } else {
            Write-Host ""
            Write-Host "Build failed. Check errors above." -ForegroundColor Red
        }
    }
    "3" {
        Write-Host ""
        Write-Host "Building and running Part 1..." -ForegroundColor Green
        wsl bash -c "cd '$wslPath' && make clean && make && ./example12 a b"
    }
    "4" {
        Write-Host ""
        Write-Host "Building and running Part 2b..." -ForegroundColor Green
        Write-Host "Note: This may be slow (5-10 FPS with 500 samples)" -ForegroundColor Yellow
        wsl bash -c "cd '$wslPath' && make clean && make && ./example12 a d"
    }
    "5" {
        Write-Host ""
        Write-Host "Running Part 1..." -ForegroundColor Green
        Write-Host "Controls: W/S (up/down), A/D (left/right), ESC (exit)" -ForegroundColor Cyan
        wsl bash -c "cd '$wslPath' && ./example12 a b"
    }
    "6" {
        Write-Host ""
        Write-Host "Running Part 2b..." -ForegroundColor Green
        Write-Host "Controls: W/S (up/down), A/D (left/right), ESC (exit)" -ForegroundColor Cyan
        Write-Host "Note: May be slow due to 500 samples per pixel" -ForegroundColor Yellow
        wsl bash -c "cd '$wslPath' && ./example12 a d"
    }
    "7" {
        Write-Host "Goodbye!" -ForegroundColor Cyan
        exit 0
    }
    default {
        Write-Host "Invalid choice!" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

