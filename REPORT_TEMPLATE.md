# Assignment 3 Report Template

Use this template to create your report. Fill in the sections marked with [brackets].

---

# Assignment 3 Report: Faking Global Illumination on the GPU

**CSCI 3090**  
**Student Name:** [Your Name]  
**Date:** [Submission Date]

## Introduction

[Brief introduction about the assignment and what you implemented]

## Part 1: Reflection and Refraction (50%)

### Implementation

[Describe how you implemented reflection and refraction:
- Use of reflect() and refract() functions
- Index of refraction used
- Schlick's Fresnel approximation
- How reflection and refraction are combined]

### Results

[Insert screenshot/image of Part 1 showing the glass-like sphere]

[Describe what you see in the image - reflection, refraction, Fresnel effect]

## Part 2: Diffuse Reflection

### Part 2a: Irradiance Maps

#### Implementation

[Describe the irradiance map approach:
- How the irradiance map was created (blurred environment map)
- How it's sampled in the shader
- Any challenges encountered]

#### Results

[Insert screenshot/image of Part 2a]

[Describe the results - soft diffuse appearance, any visible seams]

### Part 2b: Monte Carlo Sampling (50%)

#### Implementation

[Describe the Monte Carlo sampling approach:
- Random number generator used
- How sampling directions are generated
- Cosine weighting
- How samples are accumulated]

#### Number of Samples

**I used [NUMBER] samples per pixel to produce a reasonable image.**

[Explain why you chose this number - quality vs performance trade-off]

#### Results

[Insert screenshot/image of Part 2b]

[Describe the results - smooth diffuse appearance, no seams, performance]

## Technical Details

### Build Instructions

[Brief instructions on how to build and run]

### Dependencies

[List required libraries and files]

## Conclusion

[Summary of what was accomplished, challenges faced, and results]

---

## Quick Fill-in Checklist

- [ ] Add your name and date
- [ ] Insert screenshot for Part 1
- [ ] Insert screenshot for Part 2a (if you created irradiance map)
- [ ] Insert screenshot for Part 2b
- [ ] Fill in number of samples used (500)
- [ ] Describe results for each part
- [ ] Add any additional technical details
- [ ] Write conclusion





