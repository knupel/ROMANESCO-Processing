/**
* Gausian blur
* Stan le punk refactoring version
* @see https://github.com/StanLepunK/Filter
* v 0.0.8
* 2018-2019
* Adapted from:
* @see http://callumhay.blogspot.com/2010/09/gaussian-blur-shader-glsl.html
*/

#ifdef GL_ES
precision highp float;
precision mediump int;
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

uniform float size;       
uniform bool horizontal_pass; // 0 or 1 to indicate vertical or horizontal pass

       
/*
The sigma value for the gaussian function: higher value means more blur
  A good value for 9x9 is around 3 to 5
  A good value for 7x7 is around 2.5 to 4
  A good value for 5x5 is around 2 to 3.5
  ... play around with this based on what you need!
*/
uniform float sigma; 


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










vec4 gaussian_blur() {
  vec2 uv = set_uv(flip_source,resolution_source);
  float num_pass = size *.5;
  float sigma_def = size *sigma *.5; // calcule to be a good value all the time, like toward.
 
  vec2 ratio = horizontal_pass? vec2(1,0) : vec2(0,1);
 
  // Incremental Gaussian Coefficent Calculation (See GPU Gems 3 pp. 877 - 889)
  vec3 inc_gaussian;
  inc_gaussian.x = 1.0 / (sqrt(2.0 * PI) * sigma_def);
  inc_gaussian.y = exp(-0.5 / (sigma_def * sigma_def));
  inc_gaussian.z = inc_gaussian.y * inc_gaussian.y;
 
  vec4 average_value = vec4(0);
  float coef_sum = 0;
 
  // Take the central sample first...
  average_value += texture2D(texture_source,uv) * inc_gaussian.x;
  coef_sum += inc_gaussian.x;
  inc_gaussian.xy *= inc_gaussian.yz;
 
  // Go through the remaining 8 vertical samples (4 on each side of the center)
  // vec2 texOffset   = vertTexCoord.st;
  vec2 texOffset   = vec2(1) / resolution; // only work with uniform resolution
  // vec2 texOffset   = vec2(1) / vertTexCoord.st;

  for (float i = 1.0; i <= num_pass; i++) { 
    /*
    average_value += texture2D(texture, uv - i * ratio) * inc_gaussian.x;         
    average_value += texture2D(texture, uv + i * ratio) * inc_gaussian.x; 
    */
    average_value += texture2D(texture_source, uv - i * texOffset * ratio) * inc_gaussian.x;         
    average_value += texture2D(texture_source, uv + i * texOffset * ratio) * inc_gaussian.x;    
        
    coef_sum += 2.0 * inc_gaussian.x;
    inc_gaussian.xy *= inc_gaussian.yz;
  }

  return average_value / coef_sum;
}



void main() {
  gl_FragColor = gaussian_blur();
}









