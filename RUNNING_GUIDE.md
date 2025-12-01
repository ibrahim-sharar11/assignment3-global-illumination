# Running Guide - Step by Step

## Prerequisites Check

Before running, make sure:
- ✅ You're in the project directory: `cd assignment3-global-illumination`
- ✅ Environment map is extracted: `ls VancouverConventionCentre/` shows 6 JPG files
- ✅ Project is built: `ls example12` shows the executable exists

---

## Part 1: Reflection and Refraction

### Command:
```bash
./example12 a b
```

### Expected Output:

**In Terminal:**
- No errors (or minimal warnings)
- Program starts without crashing
- You may see shader compilation messages (normal)

**Visual Output:**
- A **512x512 window** opens
- **Background:** Shows the environment map (Vancouver Convention Centre) as a cube
- **Foreground:** A **glass-like sphere** in the center
- The sphere shows:
  - **Reflection** of the environment (like a mirror)
  - **Refraction** (transparent, distorted view through the sphere)
  - **Fresnel effect:** More reflection at the edges, more refraction in the center

### What You Should See:
- Glass sphere that looks like it's reflecting and refracting the environment
- As you rotate the camera, the reflection/refraction changes
- The sphere should look realistic and glass-like

### Controls:
- **W** - Rotate camera up
- **S** - Rotate camera down
- **A** - Rotate camera left
- **D** - Rotate camera right
- **ESC** - Exit program

### Testing:
1. Run the program
2. Rotate camera with W/S/A/D to see different angles
3. Observe the Fresnel effect (more reflection at edges)
4. Press ESC to exit
5. **Take a screenshot!** (for your report)

---

## Part 2b: Monte Carlo Sampling

### Command:
```bash
./example12 a d
```

### Expected Output:

**In Terminal:**
- Same as Part 1 (no errors)
- **Note:** May take a moment to start (compiling shader with 500 samples)

**Visual Output:**
- Same **512x512 window** opens
- **Background:** Same environment map cube
- **Foreground:** A **smooth, diffuse sphere**
- The sphere shows:
  - **Soft, matte appearance** (not shiny like Part 1)
  - **No visible seams** between cube map faces
  - **Smooth color transitions**
  - **Diffuse lighting** from the environment

### What You Should See:
- A sphere that looks like it's receiving soft, ambient light from all directions
- Smooth appearance without sharp reflections
- No visible boundaries/seams (unlike what Part 2a might show)

### Performance:
- **Slower than Part 1** (~5-10 FPS is normal)
- This is expected - each pixel samples 500 directions
- The quality is good but comes at a performance cost

### Controls:
- Same as Part 1 (W/S/A/D/ESC)

### Testing:
1. Run the program
2. Wait for it to render (may be slow)
3. Rotate camera to see the diffuse effect
4. Notice the smooth, seamless appearance
5. Press ESC to exit
6. **Take a screenshot!** (for your report)

---

## Part 2a: Irradiance Maps (Optional)

### Prerequisites:
You need to create the irradiance map first (blurred environment map).

### Create Irradiance Map:
```bash
# Install ImageMagick if not installed
sudo apt-get install imagemagick

# Create directory
mkdir -p VancouverConventionCentreIrradiance

# Create blurred/resized images
for img in VancouverConventionCentre/*.jpg; do
    convert "$img" -resize 512x512 -gaussian-blur 0x25 \
        "VancouverConventionCentreIrradiance/$(basename $img)"
done

# Verify
ls VancouverConventionCentreIrradiance/
```

### Command:
```bash
./example12_irradiance a c
```

### Expected Output:
- Similar to Part 2b (diffuse sphere)
- May show **visible seams** between cube map faces (this is expected!)
- Faster than Part 2b (real-time)

---

## Troubleshooting

### "Cannot find VancouverConventionCentre"
**Error:** Program can't find the environment map
**Fix:**
```bash
# Make sure you're in the right directory
pwd
# Should show: .../assignment3-global-illumination

# Check if environment map exists
ls VancouverConventionCentre/
# Should show 6 JPG files
```

### "Permission denied"
**Error:** Can't run the executable
**Fix:**
```bash
chmod +x example12 example12_irradiance
```

### Window doesn't open / Black screen
**Possible causes:**
- Display not set up properly in VM
- Missing X11 libraries
- OpenGL not available

**Fix:**
```bash
# Check if display is set
echo $DISPLAY

# Install X11 libraries
sudo apt-get install libx11-dev libxext-dev

# Try running with explicit display
DISPLAY=:0 ./example12 a b
```

### Program crashes immediately
**Check:**
- Are you in the project directory?
- Is `sphere.obj` present? (`ls sphere.obj`)
- Are shader files present? (`ls example12*.fs`)

### "No such file or directory: example12"
**Fix:** Build the project first:
```bash
make clean
make
```

---

## Expected Screenshots for Report

### Part 1 Screenshot Should Show:
- Glass sphere with visible reflection
- Visible refraction (transparent/distorted view)
- Environment map in background
- Clear Fresnel effect

### Part 2b Screenshot Should Show:
- Smooth, diffuse sphere
- Soft lighting from environment
- No visible seams
- Mat-like appearance (not shiny)

---

## Quick Test Sequence

Run this to test everything quickly:

```bash
# Part 1
echo "Testing Part 1..."
./example12 a b &
sleep 10
pkill example12

# Part 2b
echo "Testing Part 2b..."
./example12 a d &
sleep 10
pkill example12

echo "Tests complete!"
```

---

## Success Indicators

✅ **Part 1 is working if:**
- Window opens
- Glass sphere visible
- Reflection and refraction visible
- Can rotate camera smoothly

✅ **Part 2b is working if:**
- Window opens
- Diffuse sphere visible
- Smooth appearance (no seams)
- Can rotate camera (may be slow)

---

**Ready to run? Start with Part 1 and let me know what you see!**

