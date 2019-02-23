/**
Grain scatter refactoring
Stan le Punk 
* @see http://stanlepunk.xyz
* @see https://github.com/StanLepunK/Shader
v 0.0.4
2018-2019
Based https://www.shadertoy.com/view/XtsBz8 by FlexMonkey
*/


/**
WARNING
this filter work only with texture PGraphics, not with method
g.filter(PSharder pshader);
*/
// Processing implementation
#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 resolution;
// sketch implementation template, uniform use by most of filter Romanesco shader
uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform bvec2 flip_source; // can be use to flip texture

uniform float strength;


// UTIL TEMPLATE
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




// shader method
float noise(vec2 co) {
  vec2 seed = vec2(cos(co.x),sin(co.y));
  // return fract(sin(dot(seed ,vec2(12.9898,78.233))) * 43758.5453);
  return fract(cos(dot(seed ,vec2(12.9898,78.233))) * 43758.5453);
}

void main() {
  float value = strength;
  vec2 uv = set_uv(flip_source,resolution_source);

  vec2 offset = -value + vec2(noise(uv), noise(uv.yx)) *value;
  
  vec2 uv_2 = uv + (offset/resolution); // on PGraphics ext
    
  gl_FragColor = texture(texture_source,uv_2);
}







