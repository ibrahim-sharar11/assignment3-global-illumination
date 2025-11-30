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

void main() {
	vec3 N;           // Normalized normal
	
	// Normalize the normal
	N = normalize(normal);
	
	// For diffuse reflection, use the normal vector directly
	// to look up the irradiance map
	// The irradiance map should be bound to texture unit 1
	gl_FragColor = texture(irradianceMap, N);
}

