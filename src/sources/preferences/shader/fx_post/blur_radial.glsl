/**
* Stan le punk version
* @see http://stanlepunk.xyz
* @see https://github.com/StanLepunK/Shader
* v 0.0.2
* 2018-2019
*/

#ifdef GL_ES
precision highp float;
#endif
// from Processing
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;

// from Sketch
uniform sampler2D texture_source;
uniform bvec2 flip_source; // can be use to flip texture
uniform vec2 resolution_source;

uniform vec2 position;
uniform float strength;
uniform float scale;

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



void main() {   
  vec2 uv = set_uv(flip_source,resolution_source);
  vec2 position_temp = vec2(position.x,1-position.y);
  float strength_temp = strength;
  float scale_temp = scale;
  // if(scale_temp <= 0) scale_temp = .9;
  if(strength_temp < 2) strength_temp = 2;

  vec4 color;
  for(float i = 0.0; i < 1.0 ; i += 1.0/strength_temp) {
    float v = scale_temp + i * 0.1;//convert "i" to the 0.9 to 1 range
    color += texture2D(texture_source,uv * v +(position_temp) *(1.0-v));
  }

  color /= strength_temp;
  gl_FragColor =  color *vertColor;
}


