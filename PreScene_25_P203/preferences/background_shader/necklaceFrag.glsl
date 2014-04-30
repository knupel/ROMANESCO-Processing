#ifdef GL_ES
precision lowp float;
#endif



uniform vec2 mouse;
uniform vec2 resolution;

uniform float time;
#define PI 3.1414159265359
#define M  0.9
#define D  0.6


void main(){

vec2 p = (gl_FragCoord.xy - 0.5* resolution) / min(resolution.x, resolution.y);
  vec2 t = vec2(gl_FragCoord.xy / resolution);

	vec3 c = vec3(0);
  float y=0.;
	float x=0.;
	for(int i = 0; i < 100; i++) {
		float t = 1.9 * PI * float(i*8) / 50.0 * time * 0.5;
		 x = D*cos(t+x+y);
		 y = M*sin(t+y+x);
		vec2 o = 0.3 * vec2(x, y);
		float r = fract(y+x);
		float g = 1. - r;
		c += 0.0015 / (length(p-o)) * vec3(r, g, x+y);
	}

	gl_FragColor = vec4(c, 1);
}