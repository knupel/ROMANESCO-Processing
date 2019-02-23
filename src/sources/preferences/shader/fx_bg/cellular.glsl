/**
* Cellular refactoring by Stan le Punk
* 2013-2019
* v 0.0.5
* @see https://github.com/StanLepunK
* @see https://github.com/StanLepunK/Shader
* original unkown inspiration maybe sandbox ?
*/
#ifdef GL_ES
precision mediump float;
#endif


uniform float time;
uniform vec2 resolution;

uniform vec4 rgba; 
uniform float quality;
uniform int num;
uniform vec2 speed;
// uniform vec3 direction;

float field(in vec3 p) {
	float strength = 7. + .03 * log(1.e-6 + fract(sin(time) * 4373.11));
	float accum = 0.;
	float prev = 0.;
	float tw = 0.;
	float max = 12 + num;

	for (int i = 0; i < max; i++) {
		float mag = dot(p,p);
		p = abs(p) / mag + vec3(-.5, -.4, -1.5);
		float w = exp(-float(i) / 7.);
		accum += w * exp(-strength * pow(abs(mag - prev), 2.3));
		tw += w;
		prev = mag;
	}
	return max(0., 5. * accum / tw - .7);
}


void main() {
	vec2 uv = 2. * gl_FragCoord.xy / resolution.xy - 1.;
	vec2 uvs = uv * resolution.xy / max(resolution.x, resolution.y);
	vec3 p = vec3(uvs / 4., 0) + vec3(1., -1.3, 0.);
	p += .2 * vec3(sin(time *speed.x), sin(time *speed.y),  sin(time *quality));
	float t = field(p);
	float v = (1. - exp((abs(uv.x) - 1.) * 6.)) * (1. - exp((abs(uv.y) - 1.) * 6.));

	vec4 tempColor = mix(.4, 1., v) * vec4(1.8 * t * t * t, 1.4 * t * t, t, 1.0);
	gl_FragColor = vec4(tempColor.x *rgba.x, tempColor.y *rgba.y, tempColor.z *rgba.z, tempColor.w *rgba.w) ;
}