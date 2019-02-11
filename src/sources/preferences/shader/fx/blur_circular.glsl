/**
* blur circular Stan le punk version
* @see https://github.com/StanLepunK
* @see https://github.com/StanLepunK/Filter
v 0.0.5
2018-2019
refactoring from project
https://github.com/spite/Wagner/tree/master/fragment-shaders
*/

#ifdef GL_ES
precision highp float;
#endif
// Processing implementation
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;
/**
WARNING VERY IMPORTANT
*/
uniform vec2 resolution; // need this name for unknow reason :( here your pass your resolution texture
// vec2 texOffset   = vec2(1) / resolution; // only work with uniform resolution

#define PI 3.1415926535897932384626433832795

uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform bvec2 flip_source;

uniform float strength;
uniform int num;


/**
UTIL TEMPLATE
*/
vec2 set_uv(bool flip_vertical, bool flip_horizontal, vec2 res) {
  vec2 uv;
  if(all(equal(vec2(0),res))) {
    uv = vertTexCoord.st;
  } else if(all(greaterThan(res,vertTexCoord.st))) {
    uv = vertTexCoord.st;
  } else {
    uv = res;
  }

  // flip 
  if(!flip_vertical && !flip_horizontal) {
    return uv;
  } else if(flip_vertical && !flip_horizontal) {
    uv.y = 1 -uv.y;
    return uv;
  } else if(!flip_vertical && flip_horizontal) {
    uv.x = 1 -uv.x;
    return uv;
  } else if(flip_vertical && flip_horizontal) {
    return vec2(1) -uv;
  } return uv;
}

vec2 set_uv(bvec2 flip, vec2 res) {
  return set_uv(flip.x,flip.y,res);
}



float random(vec2 seed){
	return fract(sin(dot(seed.xy ,vec2(12.9898,78.233))) * 43758.5453);
}


vec2 rot2d( vec2 p, float a) {
	vec2 sc = vec2(sin(a),cos(a));
	return vec2(dot(p,vec2(sc.y,-sc.x)),dot(p,sc.xy));
}

void main() {
	vec2 uv = set_uv(flip_source,resolution_source);
  
  const int MAX_SAMPLES = 256;
  vec2 ofs[MAX_SAMPLES];

	int num_samples = num;
	if(num_samples <= 0) {
		num_samples = 16; // default samples num
	} else if (num_samples > MAX_SAMPLES) {
		num_samples = MAX_SAMPLES;
	}
	int num_samples_half = num_samples/2;
	// const float NUM_SAMPLES_F = float(num_samples);
	float step_angle = 2*PI /float(num_samples);
	

	float render = texture2D(texture_source, gl_FragCoord.xy / 8.0 ).r;


	// create halfcircle of offsets
	float angle = PI*render;
	for(int i = 0; i < num_samples_half ; i++) {
		ofs[i] = rot2d(vec2(strength,0),angle) / resolution.xy;
		angle += step_angle;
	}

	vec4 sum = vec4(0);
	float bias = -8.0; // Is unactivad because I don't see a difference with or without bias
	// sample positive half-circle
	for(int i = 0 ; i < num_samples_half ; i++)
		// sum += texture2D(texture_source,vec2(uv.x,uv.y)+ofs[i],bias);
		sum += texture2D(texture_source,vec2(uv.x,uv.y)+ofs[i]);

	// sample negative half-circle
	for( int i = 0 ; i < num_samples_half ; i++)
		// sum += texture2D(texture_source,vec2(uv.x,uv.y)-ofs[i],bias);
		sum += texture2D(texture_source,vec2(uv.x,uv.y)-ofs[i]);

	gl_FragColor.rgb = sum.rgb / float(num_samples);
	gl_FragColor.a = texture2D(texture_source,uv).a;
}

















