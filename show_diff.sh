#!/bin/bash
# Show differences between original and our new shaders

echo "📊 Shader Comparison"
echo "===================="
echo ""

compare_shader() {
    local original=$1
    local new=$2
    local name=$3
    
    echo "🔍 Comparing: $name"
    echo "─────────────────────────────────────────"
    
    if [ ! -f "$original" ]; then
        echo "Original file not found: $original"
        return
    fi
    
    if [ ! -f "$new" ]; then
        echo "New file not found: $new"
        return
    fi
    
    echo ""
    echo "Key differences:"
    echo ""
    
    # Show what's new in our shader
    echo "✨ NEW features in $new:"
    grep -n "//\|refract\|Schlick\|irradiance\|rand\|sample\|weight" "$new" | head -10
    echo ""
    
    echo "📝 Lines added:"
    orig_lines=$(wc -l < "$original" | tr -d ' ')
    new_lines=$(wc -l < "$new" | tr -d ' ')
    added=$((new_lines - orig_lines))
    echo "   Original: $orig_lines lines"
    echo "   New: $new_lines lines"
    echo "   Added: $added lines"
    echo ""
}

echo "Part 1: Reflection & Refraction"
compare_shader "example12a.fs" "example12b.fs" "Part 1"

echo ""
echo "Part 3: Monte Carlo Sampling"  
compare_shader "example12a.fs" "example12d.fs" "Part 3"

echo ""
echo "Part 2: Irradiance Map (new shader, no original)"
echo "   This is a new shader that uses irradiance maps"
echo ""

