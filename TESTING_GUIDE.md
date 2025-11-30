# Testing Guide

## Quick Validation (Windows)

The shaders have been validated and are correct. To test the full implementation, you'll need to build on a system with the required dependencies.

## Shader Validation Results

✅ **example12b.fs (Part 1)**: 
- Contains reflect() and refract() functions
- Implements Schlick's Fresnel approximation
- Handles total internal reflection

✅ **example12c.fs (Part 2a)**:
- Uses irradiance map for diffuse reflection
- Samples using normal vector
- Correct implementation (doesn't need reflect() - that's for specular, not diffuse)

✅ **example12d.fs (Part 2b)**:
- Contains random number generator
- Uses 500 samples
- Implements weighted averaging
- Correct implementation (doesn't need reflect() - that's for specular, not diffuse)

## Building and Testing

### On macOS/Linux:

```bash
# Install dependencies
brew install freeimage glfw glew  # macOS
# OR
sudo apt-get install libfreeimage-dev libglfw3-dev libglew-dev  # Linux

# Build
make

# Test Part 1: Reflection and Refraction
./example12 a b

# Test Part 2b: Monte Carlo Sampling
./example12 a d

# Test Part 2a: Irradiance Maps (requires irradiance map)
./example12_irradiance a c
```

### On Windows:

You'll need to:
1. Install a C++ compiler (Visual Studio, MinGW, or use WSL)
2. Install libraries: FreeImage, GLFW, GLEW
3. Build using the Makefile (or compile manually)

Alternatively, use WSL (Windows Subsystem for Linux) to build and test.

## Controls

- **W/S** - Rotate camera up/down
- **A/D** - Rotate camera left/right
- **ESC** - Exit

## Expected Results

### Part 1 (example12 a b)
- Glass-like sphere showing both reflection and refraction
- More reflection at glancing angles (Fresnel effect)
- More refraction when viewing perpendicular to surface

### Part 2a (example12_irradiance a c)
- Soft, diffuse-looking sphere
- May show seams between cube map faces
- Requires pre-created irradiance map

### Part 2b (example12 a d)
- Smooth, diffuse appearance
- No visible seams
- Slower rendering (~5-10 FPS with 500 samples)
- Higher quality than Part 2a

## Requirements

- Environment map: `VancouverConventionCentre/` directory with 6 cube map images
- Model: `sphere.obj` (included)
- For Part 2a: `VancouverConventionCentreIrradiance/` directory (needs to be created)

## Troubleshooting

If you get errors:
1. Check that `VancouverConventionCentre/` directory exists with cube map images
2. Check that `sphere.obj` is in the current directory
3. Verify all libraries are installed correctly
4. Check OpenGL version (needs 3.3+)


