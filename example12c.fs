/*
 *  Fragment shader for Assignment 3 - Part 2a
 *  Diffuse Reflection using Irradiance Map
 */

#version 330 core

in vec3 normal;
in vec3 position;
in vec2 tc;
uniform samplerCube tex;          // Environment map (for background cube)
uniform samplerCube irradianceMap; // Irradiance map (blurred environment map)
uniform vec4 colour;
uniform vec3 Eye;
uniform vec3 light;
uniform vec4 material;

out vec4 fragColor;

void main() {
	vec3 N;           // Normalized normal
	vec4 irradiance;  // Irradiance color (diffuse)
	
	// Normalize inputs
	N = normalize(normal);
	
	// Primary diffuse reflection using irradiance map
	irradiance = texture(irradianceMap, N);
	
	// Output irradiance color (clamp to prevent oversaturation)
	fragColor = vec4(clamp(irradiance.rgb, 0.0, 1.0), 1.0);
}
