/**
Halftone full refactoring
Stan le Punk 
@see https://github.com/StanLepunK
v 0.0.1
2018-2018
Based https://www.shadertoy.com/view/XslGRM by Atomek
Halftone dot matrix shader
@author Tomek Augustyn 2010
Ported from my old PixelBender experiment
https://github.com/og2t/HiSlope/blob/master/src/hislope/pbk/fx/halftone/Halftone.pbk
Hold and drag horizontally to adjust the threshold
*/

// Processing implementation
#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;


// sketch implementation template, uniform use by most of filter Romanesco shader
uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform bvec2 flip_source; // can be use to flip texture

uniform sampler2D texture;


uniform vec2 position;

uniform float angle;
uniform float threshold;
uniform float size;

const float PI = 3.1415926535897932384626433832795;

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




float added(vec2 sh, float sa, float ca, vec2 c, float d) {
  return 0.5 + 0.25 * cos((sh.x * sa + sh.y * ca + c.x) * d) + 0.25 * cos((sh.x * ca - sh.y * sa + c.y) * d);
}

void main() {
  vec2 uv = set_uv(flip_source,resolution_source);
  vec2 offset = uv - position;

  float rasterization = added(offset, sin(angle), cos(angle), position, PI / size * 680.0);

  vec4 color = texture(texture_source,uv);
        
  float average = 0.2125 * color.r + 0.7154 * color.g + 0.0721 * color.b;
  float gray = (rasterization * threshold + average - threshold) / (1.0 - threshold);

   
  gl_FragColor = vec4(gray,gray,gray,1.0);
}