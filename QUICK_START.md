# Quick Start Guide

## Prerequisites

Install required libraries:

**macOS:**
```bash
brew install freeimage glfw glew imagemagick
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get install libfreeimage-dev libglfw3-dev libglew-dev libgl1-mesa-dev imagemagick
```

## Build

```bash
make clean
make
```

This creates two executables:
- `example12` - For Part 1 and Part 2b
- `example12_irradiance` - For Part 2a

## Run

### Part 1: Reflection and Refraction
```bash
./example12 a b
```
**Controls:** W/S (up/down), A/D (left/right), ESC (exit)

### Part 2a: Irradiance Maps
```bash
# First, create the irradiance map
./create_irradiance_map.sh

# Then run
./example12_irradiance a c
```

### Part 2b: Monte Carlo Sampling
```bash
./example12 a d
```
**Note:** This is slower (~5-10 FPS) due to 500 samples per pixel.

## Troubleshooting

**"Irradiance map not found" warning:**
- Run `./create_irradiance_map.sh` to generate it
- Requires ImageMagick to be installed

**Compilation errors:**
- Ensure all dependencies are installed
- Check that you're using a C++11 compatible compiler
- On macOS, ensure Xcode command line tools are installed

**Runtime errors:**
- Ensure `sphere.obj` is in the current directory
- Ensure `VancouverConventionCentre/` directory exists with 6 JPG files
- Check that OpenGL 3.3+ is supported on your system

