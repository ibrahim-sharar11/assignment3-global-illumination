# Assignment 3 - Faking Global Illumination on the GPU

**CSCI 3090**  
**Due:** December 01, 2025

This project implements three techniques for faking global illumination effects in real-time using GPU shaders.

## Overview

- **Part 1 (50%):** Reflection and Refraction with Schlick approximation
- **Part 2 (50%):** Diffuse Reflection using Irradiance Maps  
- **Part 3 (50%):** Diffuse Reflection using Monte Carlo Sampling

## Quick Start

### Prerequisites

```bash
# macOS
brew install freeimage glfw glew

# Linux (Ubuntu/Debian)
sudo apt-get install libfreeimage-dev libglfw3-dev libglew-dev
```

### Building

```bash
# Use the portable Makefile
cp Makefile.portable Makefile
make
```

### Running

```bash
# Part 1: Reflection and Refraction
./example12 a b

# Part 3: Monte Carlo Sampling
./example12 a d

# Part 2: Irradiance Map (requires viewer_irradiance binary)
./example12_irradiance a c
```

## Project Structure

### Shader Files
- `example12b.fs` - Part 1: Reflection & Refraction with Schlick
- `example12c.fs` - Part 2: Irradiance Map sampling
- `example12d.fs` - Part 3: Monte Carlo sampling (500 samples)

### Source Files
- `viewer.cpp` - Main viewer application
- `viewer_irradiance.cpp` - Viewer with irradiance map support (Part 2)
- `Shaders.cpp`, `texture.cpp` - Utility functions

### Documentation
- `ASSIGNMENT_THREE.md` - Assignment description
- `IMPLEMENTATION_SUMMARY.md` - Technical implementation details
- `WILL_IT_WORK.md` - Portability information
- `README_ASSIGNMENT.md` - Detailed build instructions

## Controls

- **W/S** - Rotate camera up/down
- **A/D** - Rotate camera left/right  
- **ESC** - Exit

## Features

### Part 1: Reflection & Refraction
- Uses `reflect()` and `refract()` GLSL functions
- Implements Schlick's Fresnel approximation
- Blends reflection and refraction based on viewing angle
- Handles total internal reflection

### Part 2: Irradiance Maps
- Uses pre-blurred environment map
- Simple normal-based sampling
- Requires creating blurred version of environment map

### Part 3: Monte Carlo Sampling
- Random number generator in shader
- Cosine-weighted hemisphere sampling
- ~500 samples per pixel
- No visible seams (samples across cube map boundaries)

## Testing Without Dependencies

You can validate the code without installing dependencies:

```bash
# Check shader syntax
./quick_check.sh

# Check portability
./check_portability.sh

# Check dependencies
./check_dependencies.sh
```

## Requirements

- OpenGL 3.3+ (GLSL 330)
- Environment map: `VancouverConventionCentre/` directory with 6 cube map images
- Model file: `sphere.obj`

## License

Academic project for CSCI 3090.

