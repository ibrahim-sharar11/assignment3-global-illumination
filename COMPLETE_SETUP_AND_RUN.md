# Complete Assignment Setup and Run Guide

## Overview: All 3 Parts

1. **Part 1:** Reflection and Refraction (REQUIRED)
2. **Part 2a:** Irradiance Maps (REQUIRED - shows the seam problem)
3. **Part 2b:** Monte Carlo Sampling (REQUIRED - solves the seam problem)

---

## Step 1: Verify Everything is Ready

```bash
# Make sure you're in the project directory
cd assignment3-global-illumination
pwd

# Check environment map is extracted
ls VancouverConventionCentre/
# Should show: posx.jpg, negx.jpg, posy.jpg, negy.jpg, posz.jpg, negz.jpg

# Check executables are built
ls example12 example12_irradiance
# Both should exist

# Check sphere model
ls sphere.obj
# Should exist
```

---

## Step 2: Create Irradiance Map for Part 2a

This is required for Part 2a. We need to create a blurred version of the environment map.

### Install ImageMagick:
```bash
sudo apt-get install imagemagick
```

### Create Irradiance Map:
```bash
# Create directory for irradiance map
mkdir -p VancouverConventionCentreIrradiance

# Create blurred/resized images (this may take a minute)
for img in VancouverConventionCentre/*.jpg; do
    echo "Processing $(basename $img)..."
    convert "$img" -resize 512x512 -gaussian-blur 0x25 \
        "VancouverConventionCentreIrradiance/$(basename $img)"
done

# Verify it worked
ls VancouverConventionCentreIrradiance/
# Should show 6 blurred JPG files
```

**Expected output:** 6 files created in `VancouverConventionCentreIrradiance/`

---

## Step 3: Run Part 1 - Reflection and Refraction

### Command:
```bash
./example12 a b
```

### What You Should See:
- **Window:** 512x512 opens
- **Background:** Environment map (Vancouver Convention Centre cube)
- **Foreground:** Glass sphere in center
- **Sphere shows:**
  - Reflection (mirror-like, shows environment)
  - Refraction (transparent, distorted view through sphere)
  - Fresnel effect (more reflection at edges, more refraction in center)

### Testing:
1. Run the command
2. Window opens automatically
3. Use **W/S** to rotate camera up/down
4. Use **A/D** to rotate camera left/right
5. Observe the glass effect from different angles
6. Notice more reflection at glancing angles (edges)
7. Press **ESC** to exit

### Screenshot:
- Take a screenshot showing the glass sphere
- Capture it from a good angle showing both reflection and refraction
- Save as: `part1_screenshot.png` or similar

---

## Step 4: Run Part 2a - Irradiance Maps

### Command:
```bash
./example12_irradiance a c
```

### What You Should See:
- **Window:** Same 512x512 window
- **Background:** Same environment map cube
- **Foreground:** Diffuse, matte sphere
- **Sphere shows:**
  - Soft, blurred appearance (not sharp)
  - Diffuse lighting from environment
  - **May show visible seams** between cube map faces (this is expected and demonstrates the problem!)

### Testing:
1. Run the command
2. Window opens
3. Rotate camera with W/S/A/D
4. Notice the soft, diffuse appearance
5. Look for seams at the edges (if visible - this is the problem Part 2b solves)
6. Press **ESC** to exit

### Screenshot:
- Take a screenshot showing the diffuse sphere
- Note if seams are visible (this is important for your report!)
- Save as: `part2a_screenshot.png`

---

## Step 5: Run Part 2b - Monte Carlo Sampling

### Command:
```bash
./example12 a d
```

### What You Should See:
- **Window:** Same 512x512 window
- **Background:** Same environment map cube
- **Foreground:** Smooth, diffuse sphere
- **Sphere shows:**
  - Smooth, matte appearance
  - Diffuse lighting from environment
  - **NO visible seams** (this solves the problem from Part 2a!)
  - Better quality than Part 2a

### Performance:
- **Slower than Part 1 and Part 2a** (~5-10 FPS is normal)
- This is expected - each pixel samples 500 directions
- Wait a moment for initial rendering

### Testing:
1. Run the command
2. Wait a few seconds for rendering (may be slow)
3. Window opens with smooth diffuse sphere
4. Rotate camera with W/S/A/D
5. Notice the smooth, seamless appearance
6. Compare to Part 2a - no seams!
7. Press **ESC** to exit

### Screenshot:
- Take a screenshot showing the smooth diffuse sphere
- Save as: `part2b_screenshot.png`

---

## Step 6: Compare All Three Parts

Run them side by side (in separate terminals) or one after another to compare:

```bash
# Terminal 1
./example12 a b

# Terminal 2 (after closing Part 1)
./example12_irradiance a c

# Terminal 3 (after closing Part 2a)
./example12 a d
```

### Key Differences to Note:

**Part 1 vs Part 2:**
- Part 1: Shiny, glass-like (specular reflection/refraction)
- Part 2: Matte, diffuse (soft lighting)

**Part 2a vs Part 2b:**
- Part 2a: May show seams, uses pre-blurred map
- Part 2b: No seams, samples directly in shader, better quality

---

## Step 7: Update Your Report

### Add Screenshots to REPORT.md:

1. Open `REPORT.md` in a text editor
2. Find the placeholder lines:
   - `*[Screenshot of Part 1...]`
   - `*[Screenshot of Part 2a...]`
   - `*[Screenshot of Part 2b...]`

3. Replace with your screenshots:
   - Option A: Add image files and reference them
   - Option B: Describe what you see in detail

### Update Report Sections:

**Part 1 Results:**
- Describe the glass-like appearance
- Note the Fresnel effect (more reflection at edges)
- Mention both reflection and refraction are visible

**Part 2a Results:**
- Describe the soft, diffuse appearance
- **Important:** Note if seams are visible (this demonstrates the problem)
- Explain this is why Part 2b was needed

**Part 2b Results:**
- Describe the smooth, seamless appearance
- Note it's better quality than Part 2a
- Mention it uses 500 samples per pixel
- Note the performance trade-off (slower but better quality)

### Add Your Name and Date:

In `REPORT.md`, replace:
- `[Your Name]` with your actual name
- `[Submission Date]` with today's date

---

## Step 8: Final Checklist

Before submitting, verify:

- [ ] Part 1 runs and shows glass sphere
- [ ] Part 2a runs and shows diffuse sphere (may show seams)
- [ ] Part 2b runs and shows smooth diffuse sphere (no seams)
- [ ] Screenshots captured for all 3 parts
- [ ] Screenshots added to REPORT.md
- [ ] Your name and date added to REPORT.md
- [ ] Report describes all 3 implementations
- [ ] Number of samples documented (500 for Part 2b)

---

## Troubleshooting

### Part 2a: "Cannot find irradiance map"
**Fix:** Make sure you created it:
```bash
ls VancouverConventionCentreIrradiance/
# Should show 6 files
```

### Part 2a: Window shows black or crashes
**Fix:** Check irradiance map files are valid:
```bash
file VancouverConventionCentreIrradiance/*.jpg
# Should all show "JPEG image"
```

### All parts: Window doesn't open
**Fix:** Check display:
```bash
echo $DISPLAY
# Should show :0 or :1

# If empty, try:
export DISPLAY=:0
./example12 a b
```

### Performance issues in Part 2b
**Normal!** Part 2b is slow (~5-10 FPS) because it uses 500 samples. This is expected and acceptable.

---

## Quick Run Script

Create `run_all.sh`:

```bash
#!/bin/bash

echo "=========================================="
echo "Running All Assignment Parts"
echo "=========================================="

echo ""
echo "Part 1: Reflection and Refraction"
echo "Press ESC to exit, then press Enter to continue..."
./example12 a b
read

echo ""
echo "Part 2a: Irradiance Maps"
echo "Press ESC to exit, then press Enter to continue..."
./example12_irradiance a c
read

echo ""
echo "Part 2b: Monte Carlo Sampling"
echo "Press ESC to exit, then press Enter to continue..."
./example12 a d
read

echo ""
echo "All parts completed!"
echo "Don't forget to take screenshots!"
```

Make it executable and run:
```bash
chmod +x run_all.sh
./run_all.sh
```

---

## Expected Results Summary

| Part | Command | Visual | Performance | Notes |
|------|---------|--------|-------------|-------|
| Part 1 | `./example12 a b` | Glass sphere | Fast (60+ FPS) | Reflection + Refraction |
| Part 2a | `./example12_irradiance a c` | Diffuse sphere | Fast (60+ FPS) | May show seams |
| Part 2b | `./example12 a d` | Smooth diffuse | Slow (5-10 FPS) | No seams, 500 samples |

---

## You're Ready!

Follow these steps in order:
1. ✅ Verify setup (Step 1)
2. ✅ Create irradiance map (Step 2)
3. ✅ Run Part 1 (Step 3) - Take screenshot
4. ✅ Run Part 2a (Step 4) - Take screenshot
5. ✅ Run Part 2b (Step 5) - Take screenshot
6. ✅ Update report (Step 7)
7. ✅ Final checklist (Step 8)

**Start with Step 1 and work through each step. Let me know if you hit any issues!**

