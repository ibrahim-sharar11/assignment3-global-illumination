# Assignment 3 Implementation Summary

## Overview

This implementation provides solutions for all three parts of Assignment 3: Faking Global Illumination on the GPU.

## Files Created

### 1. Shader Files

#### `example12b.fs` - Part 1: Reflection and Refraction (50%)
- Implements reflection using `reflect()` function
- Implements refraction using `refract()` function with index of refraction
- Uses Schlick's Fresnel approximation to blend between reflection and refraction
- Formula: `F = R0 + (1-R0) * (1 - dot(V,N))^5`
- Handles total internal reflection (when T becomes zero vector)

**Usage:** `./example12 a b`

#### `example12c.fs` - Part 2: Irradiance Map (50%)
- Uses a pre-blurred environment map (irradiance map)
- Samples the irradiance map using the surface normal
- Requires a separate irradiance map texture to be loaded

**Usage:** Requires modified viewer that loads irradiance map (see `viewer_irradiance.cpp`)

#### `example12d.fs` - Part 3: Monte Carlo Sampling (50%)
- Samples the environment map directly in the fragment shader
- Uses cosine-weighted hemisphere sampling
- Generates ~500 random samples per pixel
- Weights each sample by the cosine of the angle with the normal
- Computes weighted average for final color

**Usage:** `./example12 a d`

**Performance Note:** Uses 500 samples by default. Reduce `numSamples` variable for faster rendering.

### 2. Modified Viewer

#### `viewer_irradiance.cpp`
- Extended version of `viewer.cpp` that supports loading both:
  - Environment map (for background cube)
  - Irradiance map (for diffuse reflection on sphere)
- Binds environment map to texture unit 0
- Binds irradiance map to texture unit 1
- Falls back to environment map if irradiance map is not found

### 3. Build and Test Scripts

#### `build.sh`
- macOS build script
- Compiles all object files
- Links with required libraries (FreeImage, GLFW, GLEW)
- Handles library paths for Homebrew installations

#### `test_parts.sh`
- Tests Part 1 and Part 3 implementations
- Can be extended to test Part 2 when irradiance map is available

## Key Implementation Details

### Part 1: Reflection and Refraction

**Schlick Approximation:**
```glsl
R0 = pow((1.0 - eta) / (1.0 + eta), 2.0);
F = R0 + (1.0 - R0) * pow(1.0 - dot(V, N), 5.0);
```

**Index of Refraction:**
- Uses `eta = 1.0 / 1.5` (air to glass)
- Typical glass has IoR of ~1.5

**Blending:**
```glsl
gl_FragColor = mix(refrColor, reflColor, F);
```

### Part 2: Irradiance Maps

**Requirements:**
1. Create blurred version of environment map
2. Resize to 512x512 (from original 2048x2048)
3. Apply Gaussian blur
4. Save to `VancouverConventionCentreIrradiance/` directory

**Sampling:**
- Simply uses normal vector: `texture(irradianceMap, N)`
- No special computation needed in shader

### Part 3: Monte Carlo Sampling

**Random Number Generator:**
- Linear congruential generator (LCG)
- Initialized per-pixel based on normal vector
- Parameters: `a=141, c=28411, m=134456`

**Hemisphere Sampling:**
- Uses cosine-weighted sampling for better distribution
- Samples in spherical coordinates
- Transforms to world space using orthonormal basis

**Weighted Averaging:**
```glsl
weight = dot(sampleDir, N);
weightedSum += sampleColor * weight;
weightSum += weight;
// Final color = weightedSum / weightSum
```

## Building and Running

### Prerequisites
```bash
brew install freeimage glfw glew
```

### Build
```bash
./build.sh
# or
make
```

### Run Tests
```bash
# Part 1
./example12 a b

# Part 3  
./example12 a d

# Part 2 (requires irradiance map)
./example12_irradiance a c
```

## Creating Irradiance Map (Part 2)

### Using ImageMagick (Command Line)
```bash
mkdir -p VancouverConventionCentreIrradiance
for img in VancouverConventionCentre/*.jpg; do
    convert "$img" -resize 512x512 -gaussian-blur 0x25 \
        "VancouverConventionCentreIrradiance/$(basename $img)"
done
```

### Using GIMP (Manual)
1. Open each cube map image from `VancouverConventionCentre/`
2. Image → Scale Image → Set to 512x512
3. Filters → Blur → Gaussian Blur → Radius 25-30 pixels
4. Save to `VancouverConventionCentreIrradiance/` with same filename

## Expected Results

### Part 1
- Transparent glass-like sphere
- Shows both reflection and refraction
- More reflection at glancing angles (Fresnel effect)
- Similar to Figure 1 in assignment

### Part 2
- Soft, diffuse-looking sphere
- No sharp reflections
- May show seams between cube map faces (known issue)
- Similar to Figure 2 in assignment

### Part 3
- Smooth diffuse appearance
- No visible seams (samples across boundaries)
- Slower rendering (~500 samples per pixel)
- Higher quality than Part 2

## Performance Considerations

- **Part 1:** Real-time (60+ FPS)
- **Part 2:** Real-time (60+ FPS)
- **Part 3:** Slower, depends on sample count
  - 500 samples: ~5-10 FPS on older hardware
  - 100 samples: ~30-60 FPS
  - 50 samples: Real-time but lower quality

## Troubleshooting

### Common Issues

1. **Linking errors:** Make sure all libraries are installed via Homebrew
2. **Texture not found:** Check `VancouverConventionCentre/` directory exists
3. **Part 3 too slow:** Reduce `numSamples` in `example12d.fs`
4. **Part 2 not working:** Create irradiance map first, or modify shader to use env map as fallback

### Debug Tips

- Check shader compilation: Look for error messages when running
- Verify texture loading: Check console output for texture loading messages
- Test with fewer samples: Start with `numSamples = 50` in Part 3

## Next Steps

1. Test Part 1 (reflection/refraction) ✅
2. Create irradiance map and test Part 2
3. Test Part 3 with different sample counts
4. Take screenshots for report
5. Document sample count used in Part 3

