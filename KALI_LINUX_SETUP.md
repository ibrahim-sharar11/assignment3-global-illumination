# Step-by-Step Guide for Kali Linux VM

## Step 1: Get the Repository

### Option A: Clone from GitHub (if you have internet)
```bash
git clone https://github.com/ibrahim-sharar11/assignment3-global-illumination
cd assignment3-global-illumination
```

### Option B: Copy from Windows (if files are shared)
```bash
# Navigate to shared folder or mount point
cd /mnt/...
# Or copy files from Windows host
```

---

## Step 2: Extract Environment Map

The environment map is in a zip file. Extract it:
```bash
unzip VancouverConventionCentre.zip
```

This should create a `VancouverConventionCentre/` directory with 6 JPG images.

**Verify:**
```bash
ls VancouverConventionCentre/
# Should show: posx.jpg, negx.jpg, posy.jpg, negy.jpg, posz.jpg, negz.jpg
```

---

## Step 3: Install Dependencies

Kali Linux uses apt. Install the required libraries:

```bash
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    libfreeimage-dev \
    libglfw3-dev \
    libglew-dev \
    libgl1-mesa-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxi-dev \
    git \
    unzip
```

**Note:** You'll be asked for your password.

---

## Step 4: Build the Project

```bash
make clean
make
```

**Expected output:**
- Should compile without errors
- Creates `example12` and `example12_irradiance` executables

**If you see errors:**
- Make sure all dependencies are installed (Step 3)
- Check that you have a C++ compiler: `g++ --version`

---

## Step 5: Run Part 1 (Reflection & Refraction)

```bash
./example12 a b
```

**A window should open showing a glass sphere!**

**Controls:**
- **W** - Rotate camera up
- **S** - Rotate camera down
- **A** - Rotate camera left
- **D** - Rotate camera right
- **ESC** - Exit

**Take a screenshot!** (Use your VM's screenshot tool or `scrot`)

---

## Step 6: Run Part 2b (Monte Carlo Sampling)

```bash
./example12 a d
```

**Note:** This will be slower (~5-10 FPS) because it uses 500 samples per pixel. That's normal!

**Controls:** Same as Part 1 (W/S/A/D/ESC)

**Take a screenshot!**

---

## Step 7: (Optional) Run Part 2a (Irradiance Maps)

This requires creating an irradiance map first:

```bash
# Create irradiance map directory
mkdir -p VancouverConventionCentreIrradiance

# If you have ImageMagick installed:
sudo apt-get install imagemagick

# Create blurred/resized images
for img in VancouverConventionCentre/*.jpg; do
    convert "$img" -resize 512x512 -gaussian-blur 0x25 \
        "VancouverConventionCentreIrradiance/$(basename $img)"
done

# Then run:
./example12_irradiance a c
```

---

## Troubleshooting

### "Cannot find VancouverConventionCentre"
**Fix:** Make sure you extracted the zip file:
```bash
unzip VancouverConventionCentre.zip
ls VancouverConventionCentre/
```

### "Permission denied" when running
**Fix:** Make executable:
```bash
chmod +x example12 example12_irradiance
```

### "Package not found" errors
**Fix:** Update package list:
```bash
sudo apt-get update
```

### Window doesn't open / Display errors
**Fix:** Install X11 development libraries:
```bash
sudo apt-get install libx11-dev libxext-dev
```

### Build errors about missing headers
**Fix:** Install GLM (math library):
```bash
sudo apt-get install libglm-dev
```

Or if not available, download GLM manually (it's header-only).

---

## Quick Test Script

Create a file `test_all.sh`:

```bash
#!/bin/bash
echo "Building project..."
make clean
make

echo ""
echo "Running Part 1..."
./example12 a b &
PART1_PID=$!
sleep 5
kill $PART1_PID 2>/dev/null

echo ""
echo "Running Part 2b..."
./example12 a d &
PART2B_PID=$!
sleep 5
kill $PART2B_PID 2>/dev/null

echo ""
echo "Done! Check screenshots."
```

Make it executable and run:
```bash
chmod +x test_all.sh
./test_all.sh
```

---

## Success Checklist

- [ ] Repository cloned/copied
- [ ] Environment map extracted
- [ ] Dependencies installed
- [ ] Project builds successfully
- [ ] Part 1 runs and shows window
- [ ] Part 2b runs (may be slow)
- [ ] Screenshots captured
- [ ] Screenshots added to REPORT.md

---

**Ready? Start with Step 1 and let me know if you hit any issues!**

