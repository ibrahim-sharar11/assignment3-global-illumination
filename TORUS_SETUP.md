# Setting Up Torus for Part 1

## Step 1: Generate Torus Model

On your Kali Linux VM, run:

```bash
# Make sure Python 3 is installed
python3 create_torus.py
```

This creates `torus.obj`

## Step 2: Update Code to Use Torus

Change `viewer.cpp` line 142 from:
```cpp
std::string err = tinyobj::LoadObj(shapes, materials, "sphere.obj", 0);
```

To:
```cpp
std::string err = tinyobj::LoadObj(shapes, materials, "torus.obj", 0);
```

## Step 3: Rebuild

```bash
make clean
make
```

## Step 4: Run Part 1

```bash
./example12 a b
```

You should now see a torus (ring) instead of a sphere!

