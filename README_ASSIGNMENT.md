# Assignment 3 - Faking Global Illumination on the GPU

This directory contains the implementation for Assignment 3, which explores techniques for faking global illumination effects in real-time.

## Files Created

### Shader Files
- **example12b.fs** - Part 1: Reflection and Refraction with Schlick approximation
- **example12c.fs** - Part 2: Diffuse Reflection using Irradiance Map
- **example12d.fs** - Part 3: Diffuse Reflection using Monte Carlo sampling

### Source Files
- **viewer_irradiance.cpp** - Modified viewer that supports loading an irradiance map (for Part 2)

### Build Files
- **build.sh** - Build script for macOS

## Building on macOS

### Prerequisites

You'll need to install the following libraries using Homebrew:

```bash
brew install freeimage glfw glew
```

### Building

1. Make the build script executable:
   ```bash
   chmod +x build.sh
   ```

2. Run the build script:
   ```bash
   ./build.sh
   ```

   Or manually compile:
   ```bash
   make
   ```

## Running the Programs

### Part 1: Reflection and Refraction (50%)

This uses the Schlick approximation to combine reflection and refraction:

```bash
./example12 a b
```

- Uses shader: `example12b.fs`
- Shows a transparent sphere with both reflection and refraction effects
- The Fresnel effect causes more reflection at glancing angles

### Part 2: Irradiance Maps (50%)

This uses a pre-blurred environment map for diffuse reflection:

**Note:** You need to create an irradiance map first by:
1. Taking your environment map images (from `VancouverConventionCentre/`)
2. Resizing them to 512x512
3. Applying a blur filter (Gaussian blur works well)
4. Saving them to a new directory `VancouverConventionCentreIrradiance/`

Then you can use the modified viewer:
```bash
# First compile the irradiance viewer
g++ -c -o viewer_irradiance.o viewer_irradiance.cpp
g++ -o example12_irradiance viewer_irradiance.o Shaders.o tiny_obj_loader.o texture.o \
    -lfreeimage -lglfw -lGLEW -framework OpenGL -framework GLUT -lm

# Run it
./example12_irradiance a c
```

### Part 3: Monte Carlo Sampling (50%)

This samples the environment map directly in the shader:

```bash
./example12 a d
```

- Uses shader: `example12d.fs`
- Samples the environment map ~500 times per pixel
- This is slower but produces smoother results without seams

**Performance Note:** Part 3 is computationally expensive. You may want to reduce `numSamples` in the shader (e.g., to 100-200) for faster rendering during testing.

## Controls

- **W/S** - Rotate camera up/down (theta)
- **A/D** - Rotate camera left/right (phi)
- **ESC** - Exit

## Notes

- The random number generator in `example12d.fs` is initialized per-pixel based on the normal vector
- For Part 2, if the irradiance map isn't found, the program will fall back to using the environment map
- All shaders use the same vertex shader (`example12a.vs`)

## Creating an Irradiance Map

To create the irradiance map for Part 2:

1. Open GIMP or your favorite image editor
2. For each of the 6 cube map images in `VancouverConventionCentre/`:
   - Open the image
   - Scale it down to 512x512
   - Apply a Gaussian blur (radius ~20-30 pixels works well)
   - Save it with the same name in a new `VancouverConventionCentreIrradiance/` directory

Or use ImageMagick from command line:
```bash
mkdir -p VancouverConventionCentreIrradiance
for img in VancouverConventionCentre/*.jpg; do
    convert "$img" -resize 512x512 -gaussian-blur 0x25 \
        "VancouverConventionCentreIrradiance/$(basename $img)"
done
```

## Troubleshooting

### Library Issues

If you get linking errors:
- Make sure FreeImage, GLFW, and GLEW are installed: `brew install freeimage glfw glew`
- Check library paths: `pkg-config --libs glfw3`

### Texture Not Found

- Make sure the `VancouverConventionCentre/` directory exists with all 6 cube map images
- Check that filenames match: `posx.jpg`, `negx.jpg`, `posz.jpg`, `negz.jpg`, `posy.jpg`, `negy.jpg`

### Slow Performance (Part 3)

- Reduce the number of samples in `example12d.fs` (line with `numSamples = 500`)
- Try 100-200 samples for faster rendering

