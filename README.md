# Assignment 3: Faking Global Illumination on the GPU

**Course:** CSCI 3090  
**Student:** Ibrahim Sharar (100753058)  
**Due Date:** December 01, 2025

## Overview

This assignment implements techniques for faking global illumination effects in real-time using GPU shaders. There are two main parts:

- **Part 1 (50%):** Reflection and Refraction with Schlick approximation
- **Part 2 (50%):** Diffuse Reflection using two approaches:
  - Irradiance Maps (pre-blurred environment map)
  - Monte Carlo Sampling (direct sampling in shader)

## Requirements

- OpenGL 3.3+ (GLSL 330)
- FreeImage library
- GLFW library
- GLEW library
- Environment map: `VancouverConventionCentre/` directory with 6 cube map images
- Model file: `sphere.obj` (included)

## Building

### Prerequisites

**macOS:**
```bash
brew install freeimage glfw glew
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get install libfreeimage-dev libglfw3-dev libglew-dev libgl1-mesa-dev
```

**Windows:**
Use WSL (Windows Subsystem for Linux) or install libraries manually.

### Compile

```bash
make clean
make
```

This builds two executables:
- `example12` - Main viewer for Part 1 and Part 2b
- `example12_irradiance` - Viewer with irradiance map support for Part 2a

## Running

### Part 1: Reflection and Refraction
```bash
./example12 a b
```

Shows a glass-like sphere with reflection and refraction using Schlick's Fresnel approximation.

**Controls:** W/S (up/down), A/D (left/right), ESC (exit)

### Part 2a: Irradiance Maps
```bash
./example12_irradiance a c
```

**Note:** Requires creating an irradiance map first (see below).

### Part 2b: Monte Carlo Sampling
```bash
./example12 a d
```

Samples the environment map directly in the shader using ~500 random samples per pixel.

**Note:** Performance is slower (~5-10 FPS) due to 500 samples per pixel.

## Creating Irradiance Map (Part 2a)

The irradiance map is a blurred version of the environment map. A script is provided to automate this process:

```bash
./create_irradiance_map.sh
```

This script will:
1. Resize each cube map image from 2048x2048 to 512x512
2. Apply a Gaussian blur (radius 25 pixels)
3. Save to `VancouverConventionCentreIrradiance/` directory

**Manual method (using ImageMagick):**
```bash
mkdir -p VancouverConventionCentreIrradiance
for img in VancouverConventionCentre/*.jpg; do
    convert "$img" -resize 512x512 -gaussian-blur 0x25 \
        "VancouverConventionCentreIrradiance/$(basename $img)"
done
```

**Note:** Requires ImageMagick (`brew install imagemagick` on macOS, `apt-get install imagemagick` on Linux)

## Project Structure

### Shader Files
- `example12a.vs` - Vertex shader
- `example12b.fs` - Part 1: Reflection & Refraction with Schlick approximation
- `example12c.fs` - Part 2a: Irradiance Map
- `example12d.fs` - Part 2b: Monte Carlo Sampling (500 samples)
- `cube.vs` / `cube.fs` - Background cube shaders

### Source Files
- `viewer.cpp` - Main viewer application
- `viewer_irradiance.cpp` - Viewer with irradiance map support
- `Shaders.cpp` / `Shaders.h` - Shader loading utilities
- `texture.cpp` / `texture.h` - Texture loading utilities
- `tiny_obj_loader.cc` / `tiny_obj_loader.h` - OBJ file loader

### Documentation
- `REPORT.md` - Assignment report
- `ASSIGNMENT_THREE.md` - Assignment description

## Implementation Details

### Part 1: Reflection and Refraction
- Uses `reflect()` and `refract()` GLSL functions
- Index of refraction: `eta = 1.0 / 1.5` (air to glass)
- Schlick's Fresnel approximation:
  ```glsl
  R0 = pow((1.0 - eta) / (1.0 + eta), 2.0)
  F = R0 + (1.0 - R0) * pow(1.0 - clamp(dot(-V, N), 0.0, 1.0), 5.0)
  ```
- Blends reflection and refraction: `mix(refrColor, reflColor, F)`

### Part 2a: Irradiance Maps
- Uses pre-blurred environment map
- Samples using normal vector: `texture(irradianceMap, N)`
- Simple and efficient, but may show seams

### Part 2b: Monte Carlo Sampling
- Random number generator (LCG) initialized per pixel
- Uniform hemisphere sampling with cosine weighting applied in the average
- **500 samples per pixel**
- Weighted average: `weightedSum / weightSum`
- No visible seams (samples across cube map boundaries)

## Performance

- **Part 1:** Real-time (60+ FPS)
- **Part 2a:** Real-time (60+ FPS)
- **Part 2b:** Slower (~5-10 FPS with 500 samples)

To adjust sample count in Part 2b, edit `numSamples` in `example12d.fs`.

## Environment Map

The environment map is provided in the `VancouverConventionCentre/` directory containing 6 cube map images (JPG format):
- `posx.jpg`, `negx.jpg` (right, left)
- `posy.jpg`, `negy.jpg` (top, bottom)
- `posz.jpg`, `negz.jpg` (front, back)

**Note:** The environment map is provided by Emil Persson (Humus) under Creative Commons Attribution 3.0 License.

For Part 2a, create the irradiance map by running `./create_irradiance_map.sh` or following the manual instructions above.
