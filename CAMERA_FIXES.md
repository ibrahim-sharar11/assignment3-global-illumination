# Camera and View Fixes Applied

## Issues Fixed:

1. **Upside Down View** - Fixed by changing up vector from (0,0,1) to (0,1,0)
2. **Zoomed In** - Fixed by adjusting projection FOV and near/far planes
3. **Poor Initial Angle** - Set better starting camera position

## Changes Made:

### viewer.cpp and viewer_irradiance.cpp:

1. **Up Vector Fixed:**
   ```cpp
   // OLD: glm::vec3(0.0f, 0.0f, 1.0f)  // Wrong - Z-up
   // NEW: glm::vec3(0.0f, 1.0f, 0.0f)  // Correct - Y-up
   ```

2. **Better Initial Camera Position:**
   ```cpp
   // OLD: theta = 1.5, phi = 1.5 (random angles)
   // NEW: theta = 60°, phi = 45° (nice viewing angle)
   r = 5.0;
   theta = M_PI / 3.0;  // 60 degrees down from top
   phi = M_PI / 4.0;    // 45 degrees around
   ```

3. **Improved Projection:**
   ```cpp
   // OLD: glm::perspective(0.7f, 1.0f, 1.0f, 200.0f)
   // NEW: glm::perspective(glm::radians(45.0f), 1.0f, 0.1f, 100.0f)
   // Better FOV (45°), closer near plane, reasonable far plane
   ```

4. **Reverted to Sphere:**
   - Changed back from torus.obj to sphere.obj (as requested)

## On Your Kali VM:

```bash
# Pull the latest changes
git pull

# Rebuild
make clean
make

# Run Part 1 - should now look amazing!
./example12 a b
```

## Expected Result:

- ✅ View is right-side up (not upside down)
- ✅ Properly framed (not zoomed in too much)
- ✅ Nice initial camera angle showing the glass sphere beautifully
- ✅ Smooth camera controls (W/S/A/D still work)

The sphere should now be perfectly visible with the environment map in the background, showing beautiful reflection and refraction effects!

