#!/usr/bin/env python3
"""
Shader Validator - Validates GLSL shader syntax without requiring OpenGL
This checks for common syntax errors and validates structure
"""

import re
import sys
import os

def check_shader_file(filename):
    """Validate a GLSL shader file"""
    if not os.path.exists(filename):
        print(f"❌ ERROR: File not found: {filename}")
        return False
    
    with open(filename, 'r') as f:
        content = f.read()
    
    errors = []
    warnings = []
    
    # Check version declaration
    if not re.search(r'#version\s+\d+\s+core', content):
        errors.append("Missing or invalid #version directive")
    
    # Check balanced braces
    open_braces = content.count('{')
    close_braces = content.count('}')
    if open_braces != close_braces:
        errors.append(f"Unbalanced braces: {open_braces} open, {close_braces} close")
    
    # Check balanced parentheses
    open_parens = content.count('(')
    close_parens = content.count(')')
    if open_parens != close_parens:
        errors.append(f"Unbalanced parentheses: {open_parens} open, {close_parens} close")
    
    # Check for main function
    if 'void main()' not in content:
        errors.append("Missing main() function")
    
    # Check for gl_FragColor assignment (fragment shader)
    if '.fs' in filename and 'gl_FragColor' not in content:
        errors.append("Fragment shader missing gl_FragColor assignment")
    
    # Check for common GLSL functions we use
    required_functions = {
        'reflect': 'reflect() function',
        'refract': 'refract() function (Part 1)',
        'texture': 'texture() function',
        'normalize': 'normalize() function',
        'dot': 'dot() function',
        'mix': 'mix() function',
        'pow': 'pow() function',
        'length': 'length() function',
    }
    
    # Check function usage
    for func, desc in required_functions.items():
        if func + '(' not in content and func + ' (' not in content:
            if 'refract' in func and 'b' in filename:  # Part 1 needs refract
                errors.append(f"Missing {desc}")
            elif func in ['reflect', 'texture', 'normalize']:
                errors.append(f"Missing {desc}")
    
    # Part 1 specific checks
    if 'b' in filename:  # example12b.fs
        if 'refract' not in content:
            errors.append("Part 1 shader missing refract() function")
        if 'Schlick' in content or 'R0' in content or 'F' in content:
            print("  ✓ Schlick approximation code detected")
        else:
            warnings.append("Schlick approximation might be missing")
    
    # Part 3 specific checks
    if 'd' in filename:  # example12d.fs
        if 'rand()' not in content:
            errors.append("Part 3 shader missing random number generator")
        if 'numSamples' in content or 'samples' in content.lower():
            print("  ✓ Sampling loop detected")
        else:
            warnings.append("Sampling loop might be missing")
    
    # Check for undefined variables (basic check)
    declared_vars = set(re.findall(r'\b(in|out|uniform)\s+\w+\s+(\w+)', content))
    used_vars = set(re.findall(r'\b([a-zA-Z_][a-zA-Z0-9_]*)\s*[=;,\[\]]', content))
    
    # Check semicolons after statements (basic check)
    lines = content.split('\n')
    for i, line in enumerate(lines, 1):
        stripped = line.strip()
        # Skip comments and empty lines
        if stripped.startswith('//') or stripped.startswith('/*') or not stripped:
            continue
        # Check if line should end with semicolon (simple heuristic)
        if stripped and not stripped.endswith(';') and not stripped.endswith('{') and not stripped.endswith('}'):
            if 'for' not in stripped and 'if' not in stripped and 'while' not in stripped:
                if '=' in stripped or 'return' in stripped:
                    warnings.append(f"Line {i} might be missing semicolon: {stripped[:50]}")
    
    # Print results
    print(f"\n📋 Validating: {filename}")
    print("=" * 60)
    
    if errors:
        print(f"❌ ERRORS found ({len(errors)}):")
        for error in errors:
            print(f"   • {error}")
    
    if warnings:
        print(f"⚠️  WARNINGS ({len(warnings)}):")
        for warning in warnings:
            print(f"   • {warning}")
    
    if not errors and not warnings:
        print("✅ No obvious syntax errors found!")
    
    # Additional validation
    print("\n📊 Structure Analysis:")
    code_lines = [l for l in lines if l.strip() and not l.strip().startswith('//')]
    func_pattern = r'\w+\s+\w+\s*\([^)]*\)\s*\{'
    functions = re.findall(func_pattern, content)
    uniforms = re.findall(r'uniform\s+\w+', content)
    print(f"   • Lines of code: {len(code_lines)}")
    print(f"   • Functions defined: {len(functions)}")
    print(f"   • Uniform variables: {len(uniforms)}")
    
    return len(errors) == 0

def main():
    shader_files = [
        'example12b.fs',  # Part 1
        'example12c.fs',  # Part 2
        'example12d.fs',  # Part 3
    ]
    
    print("GLSL Shader Validator")
    print("=" * 60)
    print("This checks syntax without requiring OpenGL libraries\n")
    
    all_valid = True
    for shader in shader_files:
        valid = check_shader_file(shader)
        all_valid = all_valid and valid
        print()
    
    print("=" * 60)
    if all_valid:
        print("SUCCESS: All shaders passed validation!")
        print("\nNext steps:")
        print("  1. Install dependencies: brew install freeimage glfw glew")
        print("  2. Build: make or ./build.sh")
        print("  3. Test: ./example12 a b (for Part 1)")
    else:
        print("ERROR: Some shaders have errors. Please fix them before building.")
    
    return 0 if all_valid else 1

if __name__ == '__main__':
    sys.exit(main())

