/**
* Stan le punk refactoring version
* @see https://github.com/StanLepunK/Filter
* v 0.0.6
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
uniform vec2 texOffset; // The inverse of the texture dimensions along X and Y
varying vec4 vertColor;
varying vec4 vertTexCoord;



#define PI 3.1415926535897932384626433832795
 
uniform sampler2D texture;

uniform int radius;       
uniform bool horizontal_pass; // 0 or 1 to indicate vertical or horizontal pass
       
/*
The sigma value for the gaussian function: higher value means more blur
  A good value for 9x9 is around 3 to 5
  A good value for 7x7 is around 2.5 to 4
  A good value for 5x5 is around 2 to 3.5
  ... play around with this based on what you need!
*/
uniform float sigma; 


vec4 gaussian_blur() {
  float num_pass = float(radius *.5);
  float sigma_def = radius *sigma *.5; // calcule to be a good value all the time, like toward.
 
  vec2 ratio = horizontal_pass? vec2(1,0) : vec2(0,1);
 
  // Incremental Gaussian Coefficent Calculation (See GPU Gems 3 pp. 877 - 889)
  vec3 inc_gaussian;
  inc_gaussian.x = 1.0 / (sqrt(2.0 * PI) * sigma_def);
  inc_gaussian.y = exp(-0.5 / (sigma_def * sigma_def));
  inc_gaussian.z = inc_gaussian.y * inc_gaussian.y;
 
  vec4 average_value = vec4(0);
  float coef_sum = 0;
 
  // Take the central sample first...
  average_value += texture2D(texture, vertTexCoord.st) * inc_gaussian.x;
  coef_sum += inc_gaussian.x;
  inc_gaussian.xy *= inc_gaussian.yz;
 
  // Go through the remaining 8 vertical samples (4 on each side of the center)
  for (float i = 1.0; i <= num_pass; i++) { 
    average_value += texture2D(texture, vertTexCoord.st - i * texOffset * ratio) * inc_gaussian.x;         
    average_value += texture2D(texture, vertTexCoord.st + i * texOffset * ratio) * inc_gaussian.x;         
    coef_sum += 2.0 * inc_gaussian.x;
    inc_gaussian.xy *= inc_gaussian.yz;
  }

  return average_value / coef_sum;
}


void main() {
  gl_FragColor = gaussian_blur();

}
















/*
float normpdf(in float x, in float sigma) {
  return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
}


void main() {
  vec3 c = texture(texture, vertTexCoord.xy).rgb;
  // vec3 c = texture(texture, vertTexCoord.xy / resolution).rgb;
  if (vertTexCoord.x < .5) {
    gl_FragColor = vec4(c, 1.0); 
  } else {
    
    //declare stuff
    const int mSize = 11;
    const int kSize = (mSize-1)/2;
    float kernel[mSize];
    vec3 final_colour = vec3(0);
    
    //create the 1-D kernel
    // float sigma = 7.0;
    float Z = 0.0;
    for (int j = 0; j <= kSize; ++j) {
      kernel[kSize+j] = kernel[kSize-j] = normpdf(float(j), sigma);
    }
    
    //get the normalization factor (as the gaussian has been clamped)
    for (int j = 0; j < mSize; ++j) {
      Z += kernel[j];
    }
    
    //read out the texels
    for (int i=-kSize; i <= kSize; ++i) {
      for (int j=-kSize; j <= kSize; ++j) {
        // final_colour += kernel[kSize+j]*kernel[kSize+i]*texture(texture, (vertTexCoord.xy+vec2(float(i),float(j))) / resolution.xy).rgb;
        final_colour += kernel[kSize+j] *kernel[kSize+i] *texture(texture,(vertTexCoord.xy+vec2(float(i),float(j)))/ texOffset).rgb;
      }
    }
    
    
    gl_FragColor = vec4(final_colour/(Z*Z), 1.0);
  }
}
*/











/*
void main() {
  vec2 i_res = texOffset.xy;
  float tau = 6.28318530718; // Pi*2
  
  // GAUSSIAN BLUR SETTINGS {{{
  float dir = 16.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
  float quality = 3.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
  float radius = 8.0; // BLUR SIZE (Radius)
  // GAUSSIAN BLUR SETTINGS }}}
 
  vec2 rad = vec2(i_res /radius);
  
  // Normalized pixel coordinates (from 0 to 1)
   vec2 uv = vertTexCoord.st /i_res;
  // vec2 uv = vertTexCoord.st; // texel coordinates
  // vec2 uv = vec2(vertTexCoord.x,vertTexCoord.y);
  // Pixel colour
  vec4 result = texture(texture,uv);
  
  // Blur calculations
  for(float d = 0.0; d < tau ; d += tau/dir) {
    for(float i = 1.0 / quality ; i <= 1.0 ; i +=1.0/quality) {
      result += texture(texture, uv +vec2(cos(d),sin(d)) *rad *i);    
    }
  }
  
  result /= quality * dir + 1.0;
  gl_FragColor =  result;
}
*/






