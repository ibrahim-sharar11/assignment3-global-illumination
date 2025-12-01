/*
 *  Fragment shader for Example 12 (base implementation)
 *  Simple reflection using environment map
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
	vec3 tc;
	
	tc = reflect(position - Eye, normal);
	fragColor = texture(tex,tc);

}
