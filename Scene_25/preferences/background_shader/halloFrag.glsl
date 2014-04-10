#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 resolution;

void main(void) {

	vec2 position = (gl_FragCoord.xy / resolution.xy);
	vec2 center = vec2(resolution.x/2.0, resolution.y/2.0);
	
	//float distance = distance(normalize(position),normalize(center));
	float distanceFromReferencePoint = clamp(distance(position, vec2(.5,.5)), 0.0, 1.0);
	
	vec4 top = vec4(1.0, 1, 1, 1.0);
	vec4 bottom = vec4(0.0, 0.0, 0, 1.0);
	
	
	gl_FragColor = mix(bottom, top, distanceFromReferencePoint);
	
}