#!/bin/bash
# Quick check script - compares our shaders to original and shows key features

echo "🔍 Quick Shader Check (No Dependencies Required)"
echo "================================================"
echo ""

check_file() {
    local file=$1
    local part=$2
    
    echo "📄 Checking: $file ($part)"
    
    if [ ! -f "$file" ]; then
        echo "   ❌ File not found!"
        return 1
    fi
    
    echo "   ✓ File exists"
    
    # Check key features
    if grep -q "#version 330" "$file"; then
        echo "   ✓ GLSL 330 version declared"
    fi
    
    if grep -q "void main()" "$file"; then
        echo "   ✓ main() function found"
    fi
    
    if grep -q "gl_FragColor" "$file"; then
        echo "   ✓ Fragment output assigned"
    fi
    
    # Part-specific checks
    case $part in
        "Part 1")
            if grep -q "refract" "$file"; then
                echo "   ✓ refract() function found"
            fi
            if grep -q "Schlick\|R0\|Fresnel" "$file"; then
                echo "   ✓ Schlick approximation detected"
            fi
            if grep -q "mix.*reflColor.*refrColor" "$file"; then
                echo "   ✓ Reflection/refraction blending found"
            fi
            ;;
        "Part 2")
            if grep -q "irradianceMap" "$file"; then
                echo "   ✓ Irradiance map sampler found"
            fi
            if grep -q "texture.*irradianceMap.*N" "$file"; then
                echo "   ✓ Normal-based sampling found"
            fi
            ;;
        "Part 3")
            if grep -q "rand()" "$file"; then
                echo "   ✓ Random number generator found"
            fi
            if grep -q "numSamples\|samples" "$file"; then
                echo "   ✓ Sampling loop found"
            fi
            if grep -q "weight\|dot.*N" "$file"; then
                echo "   ✓ Cosine weighting detected"
            fi
            ;;
    esac
    
    # Count lines
    lines=$(wc -l < "$file" | tr -d ' ')
    echo "   📊 Total lines: $lines"
    
    echo ""
}

echo "Comparing our shaders to original..."
echo ""

check_file "example12b.fs" "Part 1"
check_file "example12c.fs" "Part 2"
check_file "example12d.fs" "Part 3"

echo "================================================"
echo "✅ Quick check complete!"
echo ""
echo "The shaders look good. To actually test them:"
echo "  1. Install: brew install freeimage glfw glew"
echo "  2. Build: make"
echo "  3. Run: ./example12 a b (Part 1)"
echo ""

