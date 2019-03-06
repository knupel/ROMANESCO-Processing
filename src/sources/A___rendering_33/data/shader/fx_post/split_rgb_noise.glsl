/**
* Stan le punk refactoring
* @see http://stanlepunk.xyz
* @see https://github.com/StanLepunK/Shader
* v 0.0.2
* 2018-2019
* @see https://www.shadertoy.com/view/XdXGz4 by ushiostarfish 
* and SableRaf interpretation
*/

#ifdef GL_ES
precision highp float;
#endif
// from Processing texture
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;

// from Sketch
uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform bvec2 flip_source;

uniform vec2 position; 
uniform vec2 offset;

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





float hash(float n) {
	return fract(sin(n)*43758.5453);
}

float noise(in vec3 x) {
  vec3 p = floor(x);
  vec3 f = fract(x);

  f = f*f*(3.0-2.0*f);

  float n = p.x + p.y*57.0 + 113.0*p.z;

  float res = mix(mix(mix(hash(n+ 0.0),  hash(n+  1.0),f.x),
                      mix(hash(n+ 57.0), hash(n+ 58.0),f.x),f.y),
                  mix(mix(hash(n+113.0), hash(n+114.0),f.x),
                      mix(hash(n+170.0), hash(n+171.0),f.x),f.y),f.z);
  return res;
}

void main() {
	vec2 uv = set_uv(flip_source,resolution_source);
	// vec2 uv = vertTexCoord.st;

	//float mult = resolution.x * .01;
	float mult = 2.;


	float noise_x = noise(vec3(offset.x,0,0)) * mult - 1.0;
	//float displacement_x = noise_x * 0.025;
	float displacement_x = noise_x * 0.01;
	
	float noise_y = noise(vec3(offset.y,1,0)) * mult - 1.0;
	float displacement_y = noise_y * 0.01;

	

	vec2 red_uv = uv + vec2(displacement_x, displacement_y);
	vec2 green_uv = uv + vec2(-displacement_x, -displacement_y);
	vec2 blue_uv = uv + vec2(0);

	float r = texture2D(texture_source,red_uv).r;
	float g = texture2D(texture_source,green_uv).g;
	float b = texture2D(texture_source,blue_uv).b;
	
	gl_FragColor = vec4(r,g,b,1);
}