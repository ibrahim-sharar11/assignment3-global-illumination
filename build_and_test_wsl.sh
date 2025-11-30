#!/bin/bash
# Build and test script for WSL

echo "======================================"
echo "Assignment 3 - Build and Test"
echo "======================================"
echo ""

# Check if we're in WSL
if [ -z "$WSL_DISTRO_NAME" ]; then
    echo "Note: This script is designed for WSL"
fi

# Update package list
echo "Step 1: Updating package list..."
sudo apt-get update -qq

# Install dependencies
echo "Step 2: Installing dependencies..."
sudo apt-get install -y build-essential libfreeimage-dev libglfw3-dev libglew-dev libgl1-mesa-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev 2>&1 | grep -E "(Setting up|Unpacking|done)" || true

echo ""
echo "Step 3: Building project..."
make clean 2>/dev/null || true
make

if [ $? -eq 0 ]; then
    echo ""
    echo "======================================"
    echo "Build successful!"
    echo "======================================"
    echo ""
    echo "To test:"
    echo "  ./example12 a b    # Part 1: Reflection & Refraction"
    echo "  ./example12 a d    # Part 2b: Monte Carlo Sampling"
    echo ""
    echo "Note: You'll need the VancouverConventionCentre directory"
    echo "      with cube map images to run the programs"
else
    echo ""
    echo "Build failed. Check errors above."
    exit 1
fi


