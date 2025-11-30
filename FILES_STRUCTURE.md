# File Structure for Submission

## Core Files (Required)

### Source Code
```
viewer.cpp              - Main viewer for Part 1 and Part 2b
viewer_irradiance.cpp   - Viewer for Part 2a (irradiance maps)
Shaders.cpp             - Shader loading utilities
Shaders.h               - Shader header
texture.cpp             - Texture loading utilities
texture.h               - Texture header
tiny_obj_loader.cc      - OBJ file loader
tiny_obj_loader.h       - OBJ loader header
```

### Shaders
```
example12a.vs           - Vertex shader
example12b.fs           - Part 1: Reflection & Refraction
example12c.fs           - Part 2a: Irradiance Map
example12d.fs           - Part 2b: Monte Carlo Sampling
cube.vs                 - Background cube vertex shader
cube.fs                 - Background cube fragment shader
```

### Build & Data
```
Makefile                - Build configuration
sphere.obj              - Sphere model file
```

### Documentation
```
README.md               - Project documentation
ASSIGNMENT_THREE.md     - Assignment description
```

## Optional Files (Can be included)

```
SUBMISSION_CHECKLIST.md - Submission checklist
FILES_STRUCTURE.md      - This file
```

## Files NOT Needed for Submission

These are development/testing files and can be excluded:
- `build.sh`, `check_*.sh`, `test_parts.sh`, `quick_check.sh`
- `example12a.fs` (original example, not used)
- `random (1).fs` (reference file)
- `Makefile.portable` (replaced by Makefile)
- Various markdown documentation files (IMPLEMENTATION_SUMMARY.md, etc.)

## How to Build

```bash
make                    # Builds both example12 and example12_irradiance
make clean              # Cleans build artifacts
```

## How to Run

```bash
# Part 1: Reflection and Refraction
./example12 a b

# Part 2a: Irradiance Maps (requires irradiance map)
./example12_irradiance a c

# Part 2b: Monte Carlo Sampling
./example12 a d
```


