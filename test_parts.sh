#!/bin/bash

# Quick test script for Assignment 3 parts

echo "Testing Assignment 3 Parts..."
echo "================================"
echo ""

# Check if example12 exists
if [ ! -f "./example12" ]; then
    echo "Building example12 first..."
    make 2>&1 || ./build.sh 2>&1
    if [ ! -f "./example12" ]; then
        echo "ERROR: Could not build example12"
        exit 1
    fi
fi

echo "Part 1: Reflection and Refraction (Press ESC to exit)"
echo "Running: ./example12 a b"
./example12 a b &
PART1_PID=$!

sleep 3
echo "Part 1 window should be open. Close it to continue..."
wait $PART1_PID 2>/dev/null

echo ""
echo "Part 3: Monte Carlo Sampling (Press ESC to exit)"
echo "Running: ./example12 a d"
echo "Note: This may be slow with 500 samples"
./example12 a d &
PART3_PID=$!

sleep 3
echo "Part 3 window should be open. Close it to continue..."
wait $PART3_PID 2>/dev/null

echo ""
echo "Testing complete!"

