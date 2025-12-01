# Submission Checklist

## Required Files

### Source Code
- [x] `viewer.cpp` - Main viewer for Part 1 and Part 2b
- [x] `viewer_irradiance.cpp` - Viewer for Part 2a (irradiance maps)
- [x] `Shaders.cpp` / `Shaders.h` - Shader loading utilities
- [x] `texture.cpp` / `texture.h` - Texture loading utilities
- [x] `tiny_obj_loader.cc` / `tiny_obj_loader.h` - OBJ file loader

### Shader Files
- [x] `example12a.vs` - Vertex shader
- [x] `example12b.fs` - Part 1: Reflection & Refraction
- [x] `example12c.fs` - Part 2a: Irradiance Map
- [x] `example12d.fs` - Part 2b: Monte Carlo Sampling
- [x] `cube.vs` / `cube.fs` - Background cube shaders

### Build Files
- [x] `Makefile` - Build configuration
- [x] `sphere.obj` - Model file

### Documentation
- [x] `README.md` - Project documentation
- [x] `ASSIGNMENT_THREE.md` - Assignment description

## Implementation Requirements

### Part 1: Reflection and Refraction (50%)
- [x] Uses `reflect()` function
- [x] Uses `refract()` function with index of refraction
- [x] Implements Schlick's Fresnel approximation
- [x] Combines reflection and refraction based on viewing angle
- [x] Handles total internal reflection

### Part 2a: Irradiance Maps
- [x] Uses pre-blurred environment map (irradiance map)
- [x] Samples using normal vector
- [x] Loads both environment map and irradiance map

### Part 2b: Monte Carlo Sampling (50%)
- [x] Uses provided random number generator
- [x] Initializes RNG in main() function
- [x] Generates random sampling directions
- [x] Ensures dot product with normal is positive
- [x] Weights samples by dot product
- [x] Divides weighted sum by sum of weights
- [x] Uses approximately 500 samples

## Testing

Before submission, test:
- [ ] Part 1: `./example12 a b` - Shows glass-like sphere
- [ ] Part 2a: `./example12_irradiance a c` - Shows diffuse sphere (requires irradiance map)
- [ ] Part 2b: `./example12 a d` - Shows smooth diffuse sphere (may be slow)

## Build Verification

- [ ] `make clean` works
- [ ] `make` builds both executables successfully
- [ ] No compilation errors or warnings

## Report Requirements

- [ ] Written report describing implementation
- [ ] Sample images from each part
- [ ] Note on number of samples used in Part 2b (500)
- [ ] All source code included
- [ ] Everything needed to build the solution

## Zip File

- [ ] Create zip file named `assign3_lastname_firstname.zip`
- [ ] Include all source files
- [ ] Include all shader files
- [ ] Include README.md
- [ ] Include report and images
- [ ] Include Makefile
- [ ] Include sphere.obj





