# Git Repository Information

## Repository Created! ✅

Your Assignment 3 project is now a git repository.

## What's Included

### Committed Files:
- ✅ All shader files (*.fs, *.vs)
- ✅ All source code (*.cpp, *.cc, *.h)
- ✅ Build files (Makefile, Makefile.portable)
- ✅ Documentation (*.md files)
- ✅ Testing scripts (*.sh, *.py)
- ✅ Model file (sphere.obj)
- ✅ .gitignore (excludes build artifacts)

### Not Included (by design):
- ❌ Build artifacts (*.o files, executables)
- ❌ Environment map images (VancouverConventionCentre/ directory)
  - **Note:** These are large image files - you may want to add them separately or use Git LFS

## Basic Git Commands

### View Status
```bash
git status
```

### See What Changed
```bash
git diff
```

### Commit Changes
```bash
git add <files>
git commit -m "Description of changes"
```

### View History
```bash
git log
git log --oneline  # Compact view
```

## Adding the Environment Map (Optional)

The `VancouverConventionCentre/` directory contains large image files. You have options:

### Option 1: Add Normally (if files are small)
```bash
git add VancouverConventionCentre/
git commit -m "Add environment map images"
```

### Option 2: Use Git LFS (for large files)
```bash
# Install Git LFS first
git lfs install

# Track large image files
git lfs track "*.jpg"
git add .gitattributes
git add VancouverConventionCentre/
git commit -m "Add environment map images (LFS)"
```

### Option 3: Don't Include (if you'll have them on target machine)
Just document that they need to be added manually.

## Pushing to Remote (GitHub, etc.)

If you want to push to GitHub or another remote:

```bash
# Create repository on GitHub first, then:
git remote add origin <your-repo-url>
git branch -M main
git push -u origin main
```

## Repository Structure

```
Assignment3/
├── .git/                    # Git repository data
├── .gitignore              # Files to exclude
├── README.md               # Main readme
├── Shaders/                # Shader files
│   ├── example12b.fs      # Part 1
│   ├── example12c.fs      # Part 2
│   └── example12d.fs      # Part 3
├── Source/                 # C++ source files
├── Documentation/          # Markdown docs
└── Scripts/               # Test/validation scripts
```

## Current Status

Run `git status` to see:
- Uncommitted changes
- Untracked files
- Files ready to commit

## Next Steps

1. ✅ Repository is ready
2. Optionally add environment map directory
3. Optionally push to remote (GitHub, GitLab, etc.)
4. Continue development with version control!

