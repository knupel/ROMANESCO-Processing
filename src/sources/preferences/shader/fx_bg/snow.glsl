/**
* snow / cosmic background
* inspiration maybe sand box ?
* 2014-2018
* v 0.0.2
*/
#ifdef GL_ES
precision mediump float;
#endif

uniform vec4 rgba;
uniform float time;
uniform vec2 mouse;
uniform float speed;
uniform vec2 resolution;
uniform float quality;

void main( void ) {
	float temp_time = time * (speed -.5);
	float min = .001;
  float a = 1000 *(quality +min);
  float b = 489.9 *(quality +min);
  float c = 50. *(quality +min);
  float d = 1450. *(quality +min);
	vec2 position = ( gl_FragCoord.xy / resolution.xy );
	float color = cos(position.x *mouse.y *a 
										+cos(position.y *b +temp_time +position.x *c *mouse.x) 
										*d);

	vec3 rgb = vec3(rgba.xyz) *color;
	gl_FragColor = vec4(rgb,rgba.a);
}