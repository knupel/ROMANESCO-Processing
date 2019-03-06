/**
* warp texture type B
* @see http://stanlepunk.xyz
* @see https://github.com/StanLepunK/Shader
* v 0.0.11
* 2018-2019
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

// Rope implementationuniform sampler2D texture_source;
uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform bvec2 flip_source; // can be use to flip texture source

uniform sampler2D texture_layer;
uniform vec2 resolution_layer;
uniform bvec2 flip_layer; // can be use to flip texture source
uniform float strength;

uniform int color_mode; // 0 is RGB / 3 is HSB





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

vec2 set_uv() {
  return set_uv(false,false,vec2(0));
}











void main() {
  // compute fx watercolour
  vec2 uv_fx = set_uv(flip_layer,resolution_layer);
  vec4 colour = texture2D(texture_layer,uv_fx);
  float delta = strength;
  vec4 colour_dx = texture2D(texture_layer, uv_fx +vec2(delta,0.0));
  vec4 colour_dy = texture2D(texture_layer, uv_fx +vec2(0.0,delta));
  vec3 intensity = 1.0 - colour.rgb;
  float sample_raw = dot(vec3(1.0),colour.rgb);
  float sample_dx = dot(vec3(1.0),colour_dx.rgb);
  float sample_dy = dot(vec3(1.0),colour_dy.rgb);
  
  // apply watercolour on texture
  vec2 flow = delta * vec2(sample_dy -sample_raw, sample_raw -sample_dx);
  vec2 uv_source = set_uv(flip_source,resolution_source);
  vec4 colour_source = texture2D(texture_source,uv_source +vec2(-delta,delta) *flow);
  intensity = 0.05 *intensity +0.95 * (1.0 - colour_source.rgb);

  gl_FragColor = vec4(1.0 - intensity,1.0);
}







