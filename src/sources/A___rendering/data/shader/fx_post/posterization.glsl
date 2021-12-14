/**
* Posterization
* @see @stanlepunk
* @see https://github.com/StanLepunK/Shader
* v 0.0.1
* 2019-2019
*/

// https://www.geeks3d.com/20091027/shader-library-posterization-post-processing-effect-glsl/



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

uniform vec3 threshold;
uniform int num;



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











void main()  { 
  vec2 uv = set_uv(flip_source,resolution_source);

  vec3 colour = texture2D(texture_source,uv).xyz;
  colour = pow(colour, threshold);
  colour = colour *num;
  colour = floor(colour);
  colour = colour / num;
  colour = pow(colour, vec3(1.0) / threshold);


  gl_FragColor = vec4(colour,1.0);
}








