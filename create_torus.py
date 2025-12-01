#!/usr/bin/env python3
"""
Generate a torus (ring) OBJ file for Part 1
"""

import math

def generate_torus(outer_radius=1.0, inner_radius=0.5, segments=32, rings=16):
    """Generate a torus mesh"""
    vertices = []
    normals = []
    faces = []
    
    for i in range(rings + 1):
        u = 2 * math.pi * i / rings
        cos_u = math.cos(u)
        sin_u = math.sin(u)
        
        for j in range(segments + 1):
            v = 2 * math.pi * j / segments
            cos_v = math.cos(v)
            sin_v = math.sin(v)
            
            # Vertex position
            x = (outer_radius + inner_radius * cos_v) * cos_u
            y = (outer_radius + inner_radius * cos_v) * sin_u
            z = inner_radius * sin_v
            
            vertices.append((x, y, z))
            
            # Normal (for smooth shading)
            nx = cos_v * cos_u
            ny = cos_v * sin_u
            nz = sin_v
            
            normals.append((nx, ny, nz))
    
    # Generate faces
    for i in range(rings):
        for j in range(segments):
            # Current quad indices
            v0 = i * (segments + 1) + j
            v1 = i * (segments + 1) + j + 1
            v2 = (i + 1) * (segments + 1) + j + 1
            v3 = (i + 1) * (segments + 1) + j
            
            # Two triangles per quad
            faces.append((v0, v1, v2, v1))  # First triangle
            faces.append((v0, v2, v3, v1))  # Second triangle
    
    return vertices, normals, faces

def write_obj(filename, vertices, normals, faces):
    """Write OBJ file"""
    with open(filename, 'w') as f:
        # Write vertices
        for v in vertices:
            f.write(f"v {v[0]:.6f} {v[1]:.6f} {v[2]:.6f}\n")
        
        # Write normals
        for n in normals:
            f.write(f"vn {n[0]:.6f} {n[1]:.6f} {n[2]:.6f}\n")
        
        # Write faces (1-indexed in OBJ format)
        for face in faces:
            if len(face) == 4:
                # Quad - split into two triangles
                f.write(f"f {face[0]+1}//{face[0]+1} {face[1]+1}//{face[1]+1} {face[2]+1}//{face[2]+1}\n")
                f.write(f"f {face[0]+1}//{face[0]+1} {face[2]+1}//{face[2]+1} {face[3]+1}//{face[3]+1}\n")
            else:
                # Triangle
                f.write(f"f {face[0]+1}//{face[0]+1} {face[1]+1}//{face[1]+1} {face[2]+1}//{face[2]+1}\n")

if __name__ == "__main__":
    print("Generating torus.obj...")
    vertices, normals, faces = generate_torus(outer_radius=1.0, inner_radius=0.4, segments=32, rings=32)
    write_obj("torus.obj", vertices, normals, faces)
    print(f"Created torus.obj with {len(vertices)} vertices and {len(faces)} faces")

