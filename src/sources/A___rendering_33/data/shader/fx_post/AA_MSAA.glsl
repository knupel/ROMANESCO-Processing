/**
* WARNING DON'T WORK
*/

/**
* Antialiasing MSAA
* @see @stanlepunk
* @see https://github.com/StanLepunK/Shader
* v 0.0.1
* 2019-2019
* @see https://github.com/libretro/glsl-shaders/blob/master/anti-aliasing/shaders/fxaa.glsl
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
uniform sampler2DMS texture_source;
//uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform ivec2 flip_source; // can be use to flip texture source






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
    vec2 fsUV =  set_uv(flip_source,resolution_source);
    ivec2 size = textureSize(texture_source);
    ivec2 uv = ivec2(size * fsUV);
    // vec2 uv = set_uv(flip_source,resolution_source);
    vec3 color0 = texelFetch(texture_source, uv, 0).rgb;
    vec3 color1 = texelFetch(texture_source, uv, 1).rgb;
    vec3 color2 = texelFetch(texture_source, uv, 2).rgb;
    vec3 color3 = texelFetch(texture_source, uv, 3).rgb;
 
    vec3 color = (color0 + color1 + color2 + color3) * 0.25;
 
    float t = abs(step(color.g, 0.5) + step(color.b, 0.5)) - 1.0;
 
    color = mix(color, vec3(1,0,0), t);
 
    gl_FragColor = vec4(color.rgb, 1.0f);
}