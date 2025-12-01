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
	vec3 V;           // View direction
	vec3 R;           // Reflection vector
	vec4 irradiance;  // Irradiance color (diffuse)
	vec4 envColor;    // Environment color (for reflection)
	vec3 color;       // Final color
	float fresnel;    // Fresnel factor for blending
	float NdotV;      // Dot product for fresnel
	
	// Normalize inputs
	N = normalize(normal);
	V = normalize(Eye - position);
	NdotV = max(dot(N, V), 0.0);
	
	// Primary diffuse reflection using irradiance map
	irradiance = texture(irradianceMap, N);
	
	// Add specular reflection for polish
	R = reflect(-V, N);
	envColor = texture(tex, R);
	
	// Compute Fresnel factor - more reflection at glancing angles
	fresnel = pow(1.0 - NdotV, 3.0);
	
	// Blend: more reflection at edges, more diffuse in center
	// Base: 70% diffuse, up to 30% reflection based on fresnel
	color = mix(irradiance.rgb, envColor.rgb, fresnel * 0.3);
	
	// Boost brightness significantly
	color = color * 1.6;
	
	// Apply tone mapping for better color range
	color = color / (1.0 + color * 0.3);
	
	// Enhance contrast and saturation
	float luminance = dot(color, vec3(0.299, 0.587, 0.114));
	color = mix(vec3(luminance), color, 1.3);
	
	// Apply gamma correction
	color = pow(color, vec3(1.0 / 2.2));
	
	// Final brightness adjustment
	color = color * 1.1;
	
	// Clamp to valid range
	color = clamp(color, 0.0, 1.0);
	
	gl_FragColor = vec4(color, 1.0);
}

