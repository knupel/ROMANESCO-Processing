/**
* Mask post FX
* @see @stanlepunk
* @see https://github.com/StanLepunK/Shader
* v 0.0.2
* 2019-2019
*/
// Processing implementation
#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;
uniform vec2 resolution; // WARNING VERY IMPORTANT // need this name for unknow reason :( here your pass your resolution texture
// vec2 texOffset   = vec2(1) / resolution; // only work with uniform resolution

// Rope implementation
uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform ivec2 flip_source; // can be use to flip texture source
uniform vec4 level_source;

uniform sampler2D texture_layer;
uniform vec2 resolution_layer;
uniform ivec2 flip_layer; // can be use to flip texture layer
uniform vec4 level_layer;





// UTIL TEMPLATE
vec2 set_uv(int flip_vertical, int flip_horizontal, vec2 res) {
  vec2 uv;
  if(all(equal(vec2(0),res))) {
    uv = vertTexCoord.st;
  } else if(all(greaterThan(res,vertTexCoord.st))) {
    uv = vertTexCoord.st;
  } else {
    uv = res;
  }
  // flip 
  float condition_y = step(0.1, flip_vertical);
  uv.y = 1.0 -(uv.y *condition_y +(1.0 -uv.y) *(1.0 -condition_y));

  float condition_x = step(0.1, flip_horizontal);
  uv.x = 1.0 -(uv.x *condition_x +(1.0 -uv.x) *(1.0 -condition_x));

  return uv;
}

vec2 set_uv(ivec2 flip, vec2 res) {
  return set_uv(flip.x,flip.y,res);
}

vec2 set_uv() {
  return set_uv(0,0,vec2(0));
}













void main() {
  vec2 uv_source = set_uv(flip_source,resolution_source);
  vec2 uv_layer = set_uv(flip_layer,resolution_layer);

  vec4 colour_source = texture2D(texture_source,uv_source);

  vec4 colour_mask = texture2D(texture_layer,uv_layer);
  vec4 remove = vec4((colour_mask.x + colour_mask.y + colour_mask.z) / 3.0);
  colour_source.xyzw = colour_source.xyzw - remove;
  gl_FragColor = colour_source;
}






