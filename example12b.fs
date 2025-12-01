/*
 *  Fragment shader for Assignment 3 - Part 1
 *  Reflection and Refraction with Schlick approximation
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

void main() {
	vec3 V;           // View direction (from surface to eye)
	vec3 N;           // Normalized normal
	vec3 R;           // Reflection vector
	vec3 T;           // Refraction vector
	float eta;        // Index of refraction ratio
	float R0;         // Schlick's R0
	float F;          // Schlick's Fresnel factor
	vec4 reflColor;   // Reflected color
	vec4 refrColor;   // Refracted color
	float cosTheta;   // Cosine of incident angle (for Fresnel)
	
	// Normalize inputs
	V = normalize(Eye - position);
	N = normalize(normal);
	
	// Index of refraction (air to glass ratio)
	eta = 1.0 / 1.5;  // 1.5 is typical glass IoR
	
	// Compute reflection vector
	R = reflect(-V, N);
	
	// Compute refraction vector
	// refract(incident, normal, eta) - note: V points from surface to eye, so we need -V
	T = refract(-V, N, eta);
	
	// If total internal reflection occurred, T will be (0,0,0)
	// In that case, use reflection only
	if (length(T) < 0.01) {
		fragColor = texture(tex, R);
		return;
	}
	
	// Sample environment map for reflection and refraction
	reflColor = texture(tex, R);
	refrColor = texture(tex, T);
	
	// Schlick's approximation for Fresnel reflection
	cosTheta = clamp(dot(-V, N), 0.0, 1.0); // use incident vector (-V)
	R0 = pow((1.0 - eta) / (1.0 + eta), 2.0);
	F = R0 + (1.0 - R0) * pow(1.0 - cosTheta, 5.0);
	
	// Combine reflection and refraction using Fresnel factor
	fragColor = mix(refrColor, reflColor, F);
}
