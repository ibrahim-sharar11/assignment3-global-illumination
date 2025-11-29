# How to Access This Repository on Another Device

## ✅ Everything is Committed!

All files have been committed to the git repository. Here's how to access it on another device:

---

## Option 1: Push to GitHub/GitLab (Recommended)

### Step 1: Create a Remote Repository

1. Go to [GitHub](https://github.com) or [GitLab](https://gitlab.com)
2. Click "New Repository"
3. Name it something like `assignment3-global-illumination`
4. **Don't** initialize with README (we already have one)
5. Click "Create repository"

### Step 2: Push from This Machine

```bash
# Add remote (replace YOUR_USERNAME and REPO_NAME)
git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git

# Push everything
git push -u origin main
```

### Step 3: Clone on Other Device

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/REPO_NAME.git

# Navigate into it
cd REPO_NAME
```

---

## Option 2: Copy Repository Directly (USB/Network)

### Step 1: Copy the Entire Directory

```bash
# On this machine, compress the repository
cd /Users/ibrahimsharar/Downloads
tar -czf Assignment3.tar.gz Example12

# Or just copy the entire Example12 folder
```

### Step 2: Transfer to Other Device

- Copy `Example12` folder via USB drive, network share, or cloud storage

### Step 3: On Other Device

```bash
# Navigate to the copied folder
cd /path/to/Example12

# Verify git is working
git status

# If needed, reinitialize (shouldn't be necessary)
git log  # Should show all commits
```

---

## Option 3: Create a Bundle File

This creates a single file with the entire repository:

### On This Machine:

```bash
cd /Users/ibrahimsharar/Downloads/Example12

# Create bundle file
git bundle create Assignment3.bundle --all

# This creates Assignment3.bundle - a single file with everything
```

### On Other Device:

```bash
# Clone from bundle
git clone Assignment3.bundle Assignment3

# Or if you have the bundle file
cd Assignment3
git pull
```

---

## Verify Everything is There

After syncing to another device, check:

```bash
# See all files
git ls-files

# Check recent commits
git log --oneline

# Verify shaders are present
ls -la *.fs *.vs

# Check documentation
ls -la *.md
```

---

## What's Included in the Repository

- ✅ All shader files (example12b.fs, example12c.fs, example12d.fs)
- ✅ All C++ source code
- ✅ Build files (Makefile, Makefile.portable)
- ✅ All documentation (.md files)
- ✅ Testing/validation scripts
- ✅ Assignment PDF
- ✅ Model file (sphere.obj)
- ✅ Project files (.vcxproj, etc.)

---

## Important Notes

### Environment Map Images

If `VancouverConventionCentre/` directory exists but isn't in git:
- It might be in `.gitignore` (it's not)
- Or it might be too large (GitHub has 100MB file limit)
- You may need to add it separately or use Git LFS

### Build Artifacts

Compiled files (*.o, executables) are intentionally excluded via `.gitignore` - you'll need to build on the new machine.

### Dependencies

Remember to install dependencies on the new device:
- macOS: `brew install freeimage glfw glew`
- Linux: `sudo apt-get install libfreeimage-dev libglfw3-dev libglew-dev`

---

## Quick Checklist

- [ ] All files committed: `git status` shows nothing
- [ ] Choose sync method (GitHub/USB/Bundle)
- [ ] Test on new device: `git log` shows commits
- [ ] Install dependencies on new device
- [ ] Build and test: `make` then `./example12 a b`

---

## Troubleshooting

### "Repository not found" on clone
- Check repository URL is correct
- Verify repository is public or you have access

### Missing files on other device
- Run `git ls-files` to see what's tracked
- Check `.gitignore` to see what's excluded
- Use `git add -A && git status` to see untracked files

### Build fails on new device
- Install dependencies first
- Use `Makefile.portable` instead of regular Makefile
- Check `./check_dependencies.sh`

---

**Your repository is ready to sync! All files are committed and ready to transfer.**

