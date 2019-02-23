/**
* SNOW FRAG sinus refactoring by Stan le Punk
* alias the cosmic background the univers state after 380.000 years, the first print of him
* 2014-2019
* v 0.0.4
* @see https://github.com/StanLepunK
* @see https://github.com/StanLepunK/Shader
* inspiration maybe sand box ?
*/

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 resolution;

uniform float time;

uniform vec3 rgb;

uniform vec2 position;
uniform float speed;
uniform float quality;

void main() {
	float temp_time = time * (speed -.5);
	float min = .001;
  float a = 1000 *(quality +min);
  float b = 489.9 *(quality +min);
  float c = 50. *(quality +min);
  float d = 1450. *(quality +min);
	vec2 position = ( gl_FragCoord.xy / resolution.xy );
	float color = cos(position.x *position.y *a 
										+cos(position.y *b +temp_time +position.x *c *position.x) 
										*d);

	// vec3 rgb = vec3(rgb.xyz) *color;
	gl_FragColor = vec4(rgb*color,1);
}