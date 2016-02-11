#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

void main( void ) {

	vec2 position = ( gl_FragCoord.xy / resolution.xy );
	float color = cos(position.x *mouse.y *1000. +cos(position.y *489.9 +time +position.x *50. *mouse.x) *1450.);
	gl_FragColor = vec4( vec3( color), 1.0 );

}