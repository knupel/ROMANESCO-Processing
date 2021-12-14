/**
* Level
* @see @stanlepunk
* @see https://github.com/StanLepunK/Shader
* v 0.0.1
* 2021-2021
* https://gist.github.com/aferriss/9be46b6350a08148da02559278daa244
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
uniform ivec2 flip_source; // can be use to flip texture source
uniform vec3 r_level;
uniform vec3 g_level;
uniform vec3 b_level;




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

vec3 gamma_correct(vec3 color, float gamma){
    return pow(color, vec3(1.0/gamma));
}

vec3 level_range(vec3 color, float min_input, float max_input){
    return min(max(color - vec3(min_input), vec3(0.0)) / (vec3(max_input) - vec3(min_input)), vec3(1.0));
}

vec3 final_levels(vec3 color, float min_input, float gamma, float max_input){
    return gamma_correct(level_range(color, min_input, max_input), gamma);
}









void main() {
  vec2 uv = set_uv(flip_source,resolution_source);
  vec3 color = texture2D(texture_source,uv).xyz;
  float min_input = (r_level.x + g_level.x + b_level.x) / 3;
  float gamma = (r_level.y + g_level.y + b_level.y) / 3;
  float max_input = (r_level.z + g_level.z + b_level.z) / 3;
  gl_FragColor = vec4(final_levels(color, min_input, gamma, max_input),1);
}





