/*
 *  Fragment shader for Assignment 3 - Part 3
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

// Generate a random vector in the hemisphere above the surface
// Using cosine-weighted hemisphere sampling
vec3 randomHemisphereDirection(vec3 N) {
	// Generate two random values
	float u1 = rand();
	float u2 = rand();
	
	// Map to range [0, 1]
	u1 = (u1 + 1.0) * 0.5;
	u2 = (u2 + 1.0) * 0.5;
	
	// Sample in spherical coordinates with cosine weighting
	float theta = 2.0 * 3.14159265359 * u1;  // Azimuth angle
	float phi = acos(sqrt(u2));               // Polar angle (cosine-weighted)
	
	// Convert to Cartesian coordinates in tangent space
	vec3 dir = vec3(sin(phi) * cos(theta), sin(phi) * sin(theta), cos(phi));
	
	// Transform from tangent space to world space
	// Create an orthonormal basis from the normal
	vec3 tangent = normalize(cross(N, vec3(0.0, 1.0, 0.0)));
	if (length(tangent) < 0.1) {
		tangent = normalize(cross(N, vec3(1.0, 0.0, 0.0)));
	}
	vec3 bitangent = cross(N, tangent);
	
	// Transform direction to world space
	return normalize(dir.x * tangent + dir.y * bitangent + dir.z * N);
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
	
	// Initialize random number generator based on position
	// This ensures each pixel gets a different sequence
	num = int((normal.x * normal.y + normal.x * normal.z) * 123456);
	num = num % m;
	if (num < 0) num += m;
	
	// Initialize accumulators
	weightedSum = vec4(0.0);
	weightSum = 0.0;
	
	// Sample the hemisphere above the surface
	for (i = 0; i < numSamples; i++) {
		// Generate random direction in hemisphere
		sampleDir = randomHemisphereDirection(N);
		
		// Weight by cosine of angle (dot product)
		weight = dot(sampleDir, N);
		
		// Sample environment map
		sampleColor = texture(tex, sampleDir);
		
		// Accumulate weighted color
		weightedSum += sampleColor * weight;
		weightSum += weight;
	}
	
	// Divide by sum of weights to get weighted average
	if (weightSum > 0.0) {
		gl_FragColor = weightedSum / weightSum;
	} else {
		gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
	}
}

