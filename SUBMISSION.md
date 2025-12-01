# Submission Instructions

## Files to Include

Create a zip file named `assign3_sharar_ibrahim.zip` containing:

### Required Files

**Source Code:**
- All `.cpp`, `.h`, `.cc` files (viewer.cpp, viewer_irradiance.cpp, Shaders.cpp, Shaders.h, texture.cpp, texture.h, tiny_obj_loader.cc, tiny_obj_loader.h)

**Shaders:**
- All `.vs` and `.fs` files (example12a.vs, example12a.fs, example12b.fs, example12c.fs, example12d.fs, cube.vs, cube.fs)

**Documentation:**
- `README.md` - Build and usage instructions
- `REPORT.md` - Assignment report with implementation details
- `ASSIGNMENT_THREE.md` - Assignment description (optional, for reference)

**Assets:**
- `sphere.obj` - Sphere model
- `VancouverConventionCentre/` - Environment map directory (6 JPG files)
- `VancouverConventionCentre.zip` - Original environment map archive (optional)

**Build System:**
- `Makefile` - Build configuration

**Screenshots:**
- `part1_screenshot.png` - Part 1 results
- `part2a_screenshot.png` - Part 2a results  
- `part2b_screenshot.png` - Part 2b results

**Scripts:**
- `create_irradiance_map.sh` - Script to generate irradiance map

**Other:**
- `CREDITS.md` - Credits and licenses
- `.gitignore` - Git ignore file (optional)

## Creating the Zip File

```bash
zip -r assign3_sharar_ibrahim.zip \
  *.cpp *.h *.cc \
  *.vs *.fs \
  *.obj \
  VancouverConventionCentre/ \
  *.md \
  Makefile \
  *.sh \
  *.png \
  .gitignore
```

## Verification Checklist

Before submitting, verify:

- [ ] All source files compile without errors
- [ ] Part 1 runs correctly: `./example12 a b`
- [ ] Part 2a runs correctly: `./example12_irradiance a c` (after creating irradiance map)
- [ ] Part 2b runs correctly: `./example12 a d`
- [ ] All screenshots are included and display correctly
- [ ] REPORT.md contains all required information
- [ ] README.md has complete build instructions
- [ ] Zip file is named correctly: `assign3_sharar_ibrahim.zip`

## Note on Irradiance Map

The irradiance map (`VancouverConventionCentreIrradiance/`) is not included in the submission as it can be regenerated using the provided script. However, if you have created it, you may include it.

## Submission

Submit the zip file through Canvas before the deadline.

