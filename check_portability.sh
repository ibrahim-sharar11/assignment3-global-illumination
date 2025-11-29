#!/bin/bash
# Portability checker - verifies all files needed for another machine are present

echo "🔍 Portability Check for Assignment 3"
echo "======================================"
echo ""

ALL_GOOD=true

check_file() {
    if [ -f "$1" ]; then
        echo "✅ $1"
        return 0
    else
        echo "❌ MISSING: $1"
        ALL_GOOD=false
        return 1
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo "✅ $1/"
        return 0
    else
        echo "❌ MISSING: $1/"
        ALL_GOOD=false
        return 1
    fi
}

echo "📁 Checking Required Shader Files..."
echo "-----------------------------------"
check_file "example12a.vs"
check_file "example12b.fs"
check_file "example12c.fs"
check_file "example12d.fs"
check_file "cube.vs"
check_file "cube.fs"
echo ""

echo "📁 Checking Required Source Files..."
echo "-----------------------------------"
check_file "viewer.cpp"
check_file "Shaders.cpp"
check_file "Shaders.h"
check_file "texture.cpp"
check_file "texture.h"
check_file "tiny_obj_loader.cc"
check_file "tiny_obj_loader.h"
echo ""

echo "📁 Checking Required Assets..."
echo "-----------------------------------"
check_file "sphere.obj"
check_dir "VancouverConventionCentre"

# Check if cube map images exist
if [ -d "VancouverConventionCentre" ]; then
    echo ""
    echo "  Checking cube map images..."
    for img in posx.jpg negx.jpg posy.jpg negy.jpg posz.jpg negz.jpg; do
        if [ -f "VancouverConventionCentre/$img" ]; then
            echo "    ✅ $img"
        else
            echo "    ❌ MISSING: $img"
            ALL_GOOD=false
        fi
    done
fi
echo ""

echo "📁 Checking Build Files..."
echo "-----------------------------------"
check_file "Makefile"
check_file "Makefile.portable"
check_file "README_ASSIGNMENT.md"
echo ""

echo "🔧 Checking for Libraries (optional - may need adjustment)..."
echo "-----------------------------------"
if pkg-config --exists glfw3 2>/dev/null; then
    echo "✅ GLFW found via pkg-config"
else
    echo "⚠️  GLFW: Check manually or install with package manager"
fi

if [ -f "/usr/lib/libfreeimage.so" ] || [ -f "/usr/local/lib/libfreeimage.dylib" ] || [ -f "/opt/homebrew/lib/libfreeimage.dylib" ]; then
    echo "✅ FreeImage library found"
else
    echo "⚠️  FreeImage: Check manually or install with package manager"
fi
echo ""

echo "======================================"
if [ "$ALL_GOOD" = true ]; then
    echo "✅ ALL REQUIRED FILES PRESENT!"
    echo ""
    echo "The code should work on another machine if:"
    echo "  1. Dependencies are installed (FreeImage, GLFW, GLEW)"
    echo "  2. Use Makefile.portable (copy it to Makefile)"
    echo "  3. All files are copied to the new machine"
    exit 0
else
    echo "❌ SOME FILES ARE MISSING"
    echo ""
    echo "Please ensure all required files are present before"
    echo "transferring to another machine."
    exit 1
fi

