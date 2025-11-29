#!/bin/bash
# Check if all dependencies are installed

echo "🔍 Checking Dependencies for Assignment 3"
echo "=========================================="
echo ""

ALL_INSTALLED=true

check_library() {
    local lib=$1
    local pkg=$2
    
    echo -n "Checking $lib... "
    
    # Check for header files
    if find /opt/homebrew /usr/local -name "$lib.h" 2>/dev/null | grep -q .; then
        echo "✅ Found"
        return 0
    elif pkg-config --exists "$pkg" 2>/dev/null; then
        echo "✅ Found (via pkg-config)"
        return 0
    else
        echo "❌ NOT FOUND"
        ALL_INSTALLED=false
        return 1
    fi
}

check_framework() {
    local fw=$1
    echo -n "Checking $fw framework... "
    if [ -d "/System/Library/Frameworks/${fw}.framework" ] || [ -d "/Library/Frameworks/${fw}.framework" ]; then
        echo "✅ Found"
        return 0
    else
        echo "❌ NOT FOUND"
        ALL_INSTALLED=false
        return 1
    fi
}

# Check libraries
check_library "glfw3" "glfw3"
check_library "GL/glew" "glew"
check_library "FreeImage" "freeimage"
check_framework "OpenGL"

echo ""
echo "=========================================="
if [ "$ALL_INSTALLED" = true ]; then
    echo "✅ All dependencies installed!"
    echo ""
    echo "You can now build with:"
    echo "  make"
else
    echo "❌ Some dependencies are missing"
    echo ""
    echo "To install on macOS:"
    echo "  brew install freeimage glfw glew"
    echo ""
    echo "Note: OpenGL comes with macOS, so if that's missing,"
    echo "there might be a system issue."
    echo ""
    echo "⏱️  Installation time: ~2-5 minutes depending on internet speed"
fi

