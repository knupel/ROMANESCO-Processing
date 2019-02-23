/**
* HEART refactoring by Stan le Punk
* v 0.0.4
* 2014-2019
* @see https://github.com/StanLepunK
* @see https://github.com/StanLepunK/Shader
* original unkown inspiration maybe sandbox ?
*/
uniform vec2 resolution;
uniform float time;




uniform vec3 rgb;
uniform float speed;
uniform float quality;
uniform float strength; // min 10

uniform int num;




// float angle ;

float noise(float t) {
	return fract(sin(t)*4397.33);
}

vec3 rotate(vec3 p) {
    // give the speed rotation
	float angle = speed *.05;
	return vec3(p.x*cos(angle) + p.z*sin(angle), p.y, p.x*sin(angle) - p.z*cos(angle));
}

float field(vec3 p,float num_f) {
	float d = 0.;
	p = abs(rotate(p));
	
	float varBeat  ;
	varBeat = abs(10.0 -strength) ;
	num_f *= varBeat ;
	int num = int(num_f) ;
	if(num < 1) { 
		num = 7 ;
		num_f = 1. ;
	}

	for (int i = 0; i < num ; ++i) {
		d = max(d, exp(-float(i) / num_f) * (length(max(p - .4, vec3(0.))) - .2));
		p = abs(2.*fract(p) - 1.) + .1;
	}
	return d;
}

void main() {
	vec2 uv = 2. * gl_FragCoord.xy / resolution.xy - 1.;
	uv *= resolution.xy / max(resolution.x, resolution.y);
	vec3 ro = vec3(0., 0., 2.7);
	vec3 rd = normalize(vec3(uv.x, -uv.y, -1.5));
	float dSum = 0.;
	float dMax = 0.;
	
	float variance = mix(3., 1., pow(.5 + .5*sin(time), 8.));
	variance -= .05 * log(1.e-6 + noise(time));

	float num = quality ;
	float finalNum = quality *100. ;
	int numLoop = int(finalNum) ;

	
	for (int i = 0; i < numLoop; ++i) {
		float d = field(ro,num);
		float weight = 1. + .2 * (exp(-10. * abs(2.*fract(abs(4.*ro.y)) - 1.)));
		float value = exp(-variance * abs(d)) * weight;
		dSum += value;
		dMax = max(dMax, value);
		ro += (d / 8.) * rd;
	}
	
	float t = max(dSum / 32., dMax) * mix(.92, 1., noise(uv.x + noise(uv.y + time)));
	// gl_FragColor = vec4(t * vec3(t*t*1.3, t*1.3, 1.), 1.);
	gl_FragColor = vec4(t * vec3(t*t*rgb.x, t*rgb.y, rgb.z), 1.);
}