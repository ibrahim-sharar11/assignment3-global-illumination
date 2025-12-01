/*
 *  Fragment shader for background cube
 *  Displays the environment map as a skybox
 */

#version 330 core

in vec3 normal;
in vec3 position;
uniform samplerCube tex;
uniform vec3 Eye;

out vec4 fragColor;

void main() {
	vec3 tc;
	vec3 V = -normalize(Eye-position);
	
	tc = reflect(V,normal);
	fragColor = texture(tex,normalize(position));

}
