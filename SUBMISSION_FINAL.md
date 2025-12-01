# Final Submission Checklist

## ✅ Implementation Verification

### Part 1: Reflection and Refraction (50%)
- ✅ Uses `reflect()` function
- ✅ Uses `refract()` function with index of refraction (eta = 1.0/1.5)
- ✅ Implements Schlick's Fresnel approximation
- ✅ Combines reflection and refraction using Fresnel factor
- ✅ Handles total internal reflection

### Part 2a: Irradiance Maps
- ✅ Uses pre-blurred environment map
- ✅ Samples using normal vector
- ✅ Loads both environment map and irradiance map

### Part 2b: Monte Carlo Sampling (50%)
- ✅ Uses provided random number generator (LCG)
- ✅ Random number generator initialized in `main()` function
- ✅ Generates random sampling directions
- ✅ Ensures dot product with normal is positive
- ✅ Weights samples by dot product
- ✅ Divides weighted sum by sum of weights
- ✅ Uses **500 samples** per pixel

## 📁 Files to Include in Submission

### Required Source Files
- ✅ `viewer.cpp` - Main viewer
- ✅ `viewer_irradiance.cpp` - Irradiance viewer
- ✅ `Shaders.cpp` / `Shaders.h` - Shader utilities
- ✅ `texture.cpp` / `texture.h` - Texture loading
- ✅ `tiny_obj_loader.cc` / `tiny_obj_loader.h` - OBJ loader

### Required Shader Files
- ✅ `example12a.vs` - Vertex shader
- ✅ `example12b.fs` - Part 1: Reflection & Refraction
- ✅ `example12c.fs` - Part 2a: Irradiance Map
- ✅ `example12d.fs` - Part 2b: Monte Carlo (500 samples)
- ✅ `cube.vs` / `cube.fs` - Background cube shaders

### Required Assets
- ✅ `sphere.obj` - Sphere model
- ✅ `VancouverConventionCentre.zip` - Environment map (or extracted directory)

### Required Build Files
- ✅ `Makefile` - Build configuration

### Required Documentation
- ✅ `REPORT.md` - Assignment report (with your name and date)
- ✅ `README.md` - Project documentation
- ✅ `ASSIGNMENT_THREE.md` - Assignment description

## 📝 Report Requirements

- [ ] Your name added to REPORT.md
- [ ] Submission date added to REPORT.md
- [ ] Screenshot/image from Part 1 added
- [ ] Screenshot/image from Part 2a added (if tested)
- [ ] Screenshot/image from Part 2b added
- [ ] Number of samples documented (500)
- [ ] All source code included in report or separate files

## 📦 Creating Submission Zip

1. Create zip file named: `assign3_lastname_firstname.zip`

2. Include:
   - All source files (.cpp, .cc, .h)
   - All shader files (.fs, .vs)
   - `Makefile`
   - `sphere.obj`
   - `REPORT.md` (with your name/date)
   - `README.md`
   - `ASSIGNMENT_THREE.md`
   - `VancouverConventionCentre.zip` (or extracted directory)

3. Verify zip file:
   - Can be extracted
   - All files present
   - Report is readable

## ✅ Final Verification

- [ ] All three parts implemented correctly
- [ ] Code compiles without errors
- [ ] Report is complete with your information
- [ ] Screenshots included (if available)
- [ ] Zip file created correctly
- [ ] Ready to submit!

---

**Your assignment is complete and ready for submission!** 🎉

