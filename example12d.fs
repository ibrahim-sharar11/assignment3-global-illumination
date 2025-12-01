/*
 *  Fragment shader for Assignment 3 - Part 2b
 *  Diffuse Reflection using Monte Carlo sampling in shader
 */

#version 330 core

in vec3 normal;
in vec3 position;
in vec2 tc;
uniform samplerCube tex;
uniform vec4 colour;
uniform vec3 Eye;
uniform vec3 light;
uniform vec4 material;

out vec4 fragColor;

// Random number generator parameters
int num = 1235;
int a = 141;
int c = 28411;
int m = 134456;

// Random number generator function
float rand() {
	float f;
	num = (a * num + c) % m;
	f = (num + 0.0) / m;
	return (f - 0.5) * 2.0;  // Returns value in range [-1, 1]
}

// Generate a random vector uniformly distributed on the hemisphere above N
// According to assignment: generate random vectors and keep only those with positive dot product
vec3 randomHemisphereDirection(vec3 N) {
	vec3 dir;
	float dotProd;
	int maxAttempts = 10;  // Safety limit to prevent infinite loops
	int attempts = 0;
	
	// Generate random vectors until we get one in the hemisphere above the surface
	// This ensures uniform distribution on the hemisphere
	do {
		dir = normalize(vec3(rand(), rand(), rand()));
		dotProd = dot(dir, N);
		attempts++;
	} while (dotProd <= 0.0 && attempts < maxAttempts);
	
	// If we couldn't find one after max attempts, use a fallback
	if (dotProd <= 0.0) {
		// Reflect the vector through the plane perpendicular to N
		dir = dir - 2.0 * dot(dir, N) * N;
	}
	
	return dir;
}

void main() {
	vec3 N;                    // Normalized normal
	vec3 sampleDir;            // Random sampling direction
	vec4 sampleColor;          // Color from sample
	vec4 weightedSum;          // Weighted sum of colors
	float weight;              // Weight for current sample (dot product)
	float weightSum;           // Sum of all weights
	int numSamples = 500;      // Number of samples to take
	int i;
	
	// Normalize the normal
	N = normalize(normal);
	
	// Initialize random number generator using screen position for decorrelated seeds
	num = int(gl_FragCoord.x * 1973.0 + gl_FragCoord.y * 9277.0) & 65535;
	num = num % m;
	if (num < 0) num += m;
	
	// Initialize accumulators
	weightedSum = vec4(0.0);
	weightSum = 0.0;
	
	// Sample the hemisphere above the surface
	for (i = 0; i < numSamples; i++) {
		// Generate random direction (already guaranteed to be in hemisphere above surface)
		sampleDir = randomHemisphereDirection(N);
		
		// Weight by cosine of angle (dot product with normal)
		weight = dot(sampleDir, N);
		
		// Sample environment map
		sampleColor = texture(tex, sampleDir);
		
		// Accumulate weighted color
		weightedSum += sampleColor * weight;
		weightSum += weight;
	}
	
	// Divide by sum of weights to get weighted average
	if (weightSum > 0.0) {
		fragColor = weightedSum / weightSum;
	} else {
		fragColor = vec4(0.0, 0.0, 0.0, 1.0);
	}
}
