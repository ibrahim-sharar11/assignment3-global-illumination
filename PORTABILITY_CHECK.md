# Portability Check & Requirements

## ✅ What WILL Work on Another Machine

### 1. Shader Files (100% Portable)
- ✅ `example12b.fs` - Pure GLSL, no platform dependencies
- ✅ `example12c.fs` - Pure GLSL, no platform dependencies  
- ✅ `example12d.fs` - Pure GLSL, no platform dependencies
- ✅ `example12a.vs` - Pure GLSL, no platform dependencies
- ✅ `cube.vs` / `cube.fs` - Pure GLSL, no platform dependencies

**These are standard GLSL shaders and will work on any OpenGL-capable system.**

### 2. C++ Source Code (95% Portable)
- ✅ `viewer.cpp` - Has platform detection (`#ifdef WIN32`)
- ✅ `Shaders.cpp` - Standard C++/OpenGL
- ✅ `texture.cpp` - Uses FreeImage (cross-platform)
- ✅ `tiny_obj_loader.cc` - Pure C++

**The code uses relative paths and standard OpenGL, so it should work.**

### 3. Required Assets (Must Be Present)
- ✅ `VancouverConventionCentre/` directory with 6 cube map images:
  - `posx.jpg`, `negx.jpg`, `posy.jpg`, `negy.jpg`, `posz.jpg`, `negz.jpg`
- ✅ `sphere.obj` - The sphere model file

**These files need to be in the same directory as the executable.**

---

## ⚠️ What Needs Adjustment Per Platform

### 1. Build System

#### Current Makefile (Linux-style)
- Uses `-lGLU -lGL` (won't work on macOS)
- Needs platform detection

#### Solution: Use `Makefile.portable`
I've created a portable Makefile that auto-detects the OS and adjusts accordingly.

**Usage:**
```bash
# Copy the portable Makefile
cp Makefile.portable Makefile

# Then build
make
```

### 2. Library Paths

The libraries need to be installed, but paths may vary:

#### macOS (Homebrew)
```bash
brew install freeimage glfw glew
# Libraries in /usr/local/lib or /opt/homebrew/lib
```

#### Linux (apt/yum)
```bash
sudo apt-get install libfreeimage-dev libglfw3-dev libglew-dev
# or
sudo yum install freeimage-devel glfw-devel glew-devel
# Libraries in /usr/lib or /usr/local/lib
```

#### Windows
- Download pre-compiled binaries for FreeImage, GLFW, GLEW
- Adjust library paths in Makefile or use Visual Studio project

---

## 🔍 Portability Checklist

Before running on another machine:

### Required Files (All Must Exist)
- [ ] All `.fs` shader files (example12b.fs, example12c.fs, example12d.fs)
- [ ] All `.vs` shader files (example12a.vs, cube.vs)
- [ ] All `.cpp` and `.cc` source files
- [ ] Header files (Shaders.h, texture.h, tiny_obj_loader.h)
- [ ] `sphere.obj` model file
- [ ] `VancouverConventionCentre/` directory with 6 JPG images

### Required Libraries (Must Be Installed)
- [ ] **FreeImage** - Image loading library
- [ ] **GLFW** - Window/context management
- [ ] **GLEW** - OpenGL extension loading
- [ ] **OpenGL** - Graphics library (usually comes with OS)
- [ ] **GLM** - Math library (header-only, should work if included)

### Build Tools (Must Be Available)
- [ ] C++ compiler (g++, clang++, or MSVC)
- [ ] Make utility (make, gmake, or nmake)
- [ ] pkg-config (optional, helps find libraries on Linux)

---

## 🧪 Testing Portability

Run this script to check if everything is ready:

```bash
#!/bin/bash
# Quick portability check

echo "Checking files..."
[ -f "example12b.fs" ] && echo "✓ example12b.fs" || echo "✗ Missing example12b.fs"
[ -f "example12c.fs" ] && echo "✓ example12c.fs" || echo "✗ Missing example12c.fs"
[ -f "example12d.fs" ] && echo "✓ example12d.fs" || echo "✗ Missing example12d.fs"
[ -f "viewer.cpp" ] && echo "✓ viewer.cpp" || echo "✗ Missing viewer.cpp"
[ -d "VancouverConventionCentre" ] && echo "✓ VancouverConventionCentre/" || echo "✗ Missing VancouverConventionCentre/"
[ -f "sphere.obj" ] && echo "✓ sphere.obj" || echo "✗ Missing sphere.obj"

echo ""
echo "Checking libraries..."
pkg-config --exists glfw3 && echo "✓ GLFW" || echo "⚠ GLFW (check manually)"
[ -f /usr/lib/libfreeimage.so ] || [ -f /usr/local/lib/libfreeimage.dylib ] && echo "✓ FreeImage" || echo "⚠ FreeImage (check manually)"
```

---

## 📦 Packaging for Another Machine

To ensure it works on another machine, include:

1. **All source files** (*.cpp, *.cc, *.h)
2. **All shader files** (*.vs, *.fs)
3. **Asset files** (sphere.obj, VancouverConventionCentre/)
4. **Build files** (Makefile.portable, build instructions)
5. **README** with build instructions for that platform

### Minimal Package Structure
```
Assignment3/
├── Shaders/
│   ├── example12a.vs
│   ├── example12b.fs  (Part 1)
│   ├── example12c.fs  (Part 2)
│   ├── example12d.fs  (Part 3)
│   ├── cube.vs
│   └── cube.fs
├── Source/
│   ├── viewer.cpp
│   ├── Shaders.cpp
│   ├── texture.cpp
│   └── ...
├── Assets/
│   ├── sphere.obj
│   └── VancouverConventionCentre/
├── Makefile.portable
└── README.md
```

---

## 🚀 Quick Start for New Machine

1. **Install dependencies** (see platform-specific instructions above)
2. **Copy Makefile.portable to Makefile:**
   ```bash
   cp Makefile.portable Makefile
   ```
3. **Build:**
   ```bash
   make
   ```
4. **Test:**
   ```bash
   ./example12 a b  # Part 1
   ```

---

## ✅ Confidence Level

**Shader Code: 100% Portable** ✅
- Pure GLSL, no platform dependencies
- Will work on any OpenGL 3.3+ system

**C++ Code: 95% Portable** ✅
- Standard C++ and OpenGL
- Platform detection for paths already included
- Should compile on macOS, Linux, Windows

**Build System: 80% Portable** ⚠️
- Original Makefile is Linux-specific
- Use `Makefile.portable` for cross-platform builds
- May need minor adjustments for Windows

**Overall: The code SHOULD work on another machine with dependencies installed!**

---

## 🔧 If Something Doesn't Work

1. Check that all files are present
2. Verify libraries are installed: `pkg-config --list-all | grep -i glfw`
3. Try compiling manually to see specific errors
4. Check OpenGL version: Need OpenGL 3.3+ (GLSL 330)

The shaders themselves are definitely portable - they're just text files with GLSL code!

