#!/bin/bash

# Build script for Assignment 3 on macOS
# This compiles the viewer program with all necessary libraries

echo "Building Assignment 3..."

# Check if we have required libraries
if ! command -v pkg-config &> /dev/null; then
    echo "Error: pkg-config not found. Please install it first."
    exit 1
fi

# Compile object files
echo "Compiling object files..."
g++ -c -o viewer.o viewer.cpp -I/usr/local/include -I/opt/homebrew/include
g++ -c -o Shaders.o Shaders.cpp -I/usr/local/include -I/opt/homebrew/include
g++ -c -o tiny_obj_loader.o tiny_obj_loader.cc -I/usr/local/include -I/opt/homebrew/include
g++ -c -o texture.o texture.cpp -I/usr/local/include -I/opt/homebrew/include

# Link everything
echo "Linking..."
g++ -o example12 viewer.o Shaders.o tiny_obj_loader.o texture.o \
    -L/usr/local/lib -L/opt/homebrew/lib \
    -lfreeimage -lglfw -lGLEW -framework OpenGL -framework GLUT -lm

if [ $? -eq 0 ]; then
    echo "Build successful! Run with: ./example12 a b"
    echo "  Part 1 (reflection/refraction): ./example12 a b"
    echo "  Part 3 (sampling): ./example12 a d"
else
    echo "Build failed!"
    exit 1
fi

