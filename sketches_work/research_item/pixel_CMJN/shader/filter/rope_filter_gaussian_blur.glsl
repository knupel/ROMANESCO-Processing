/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2017 
* Stan le Punk > http://stanlepunk.xyz/

based on Callumhay work
<a href="http://callumhay.blogspot.com/2010/09/gaussian-blur-shader-glsl.html" target="_blank" rel="nofollow">http://callumhay.blogspot.com/2010/09/gaussian-blur-shader-glsl.html</a>

Gaussian blur 
the method used 2 pass, one vertical and one horizontal
v 0.0.3
*/
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER


varying vec4 vertTexCoord;

uniform sampler2D texture;
uniform sampler2D texture_PGraphics;

uniform vec2 wh_renderer_ratio;
uniform bvec2 flip;
uniform bool PGraphics_renderer_is;

// blur data
#define PI 3.1415926535897932384626433832795

uniform vec2 texOffset ; // the texOffset is not used after but it's necessary to complete the process

uniform int blurSize;       
uniform bool horizontalPass; 

uniform float sigma;        
/**
The sigma value for the gaussian function: higher value means more blur
A good value for 9x9 is around 3 to 5
A good value for 7x7 is around 2.5 to 4
A good value for 5x5 is around 2 to 3.5
play around with this based on what you need <span class="Emoticon Emoticon1"><span>:)</span></span>
*/










void main() {
  vec2 coord = vertTexCoord.st;

  // scale
  vec2 zero = vec2(0,0);
  if(notEqual(wh_renderer_ratio,zero).x && notEqual(wh_renderer_ratio,zero).y && horizontalPass) { 
    coord /= wh_renderer_ratio;
  }

  if(PGraphics_renderer_is) {
    coord.y = 1 -coord.y;
  }

  vec2 coord_tex = coord;
  // flip
 if(flip.x) {
    coord_tex.x = 1 -coord_tex.x;
  } 
  if(flip.y) {
    coord_tex.y = 1 -coord_tex.y;
  }


  float numBlurPixelsPerSide = float(blurSize / 2); 
 
  vec2 blurMultiplyVec = horizontalPass? vec2(1.0, 0.0) : vec2(0.0, 1.0);
 
  // Incremental Gaussian Coefficent Calculation (See GPU Gems 3 pp. 877 - 889)
  vec3 incrementalGaussian;
  incrementalGaussian.x = 1.0 / (sqrt(2.0 * PI) * sigma);
  incrementalGaussian.y = exp(-0.5 / (sigma * sigma));
  incrementalGaussian.z = incrementalGaussian.y * incrementalGaussian.y;
  ///incrementalGaussian *= ratio.xyz ;
 
  vec4 avgValue = vec4(0.0, 0.0, 0.0, 0.0);
  float coefficientSum = 0.0;
 
  // Take the central sample first...
  if(!PGraphics_renderer_is) {
    avgValue += texture2D(texture, coord_tex) * incrementalGaussian.x;
    coefficientSum += incrementalGaussian.x;
    incrementalGaussian.xy *= incrementalGaussian.yz;
   
    // Go through the remaining 8 vertical samples (4 on each side of the center)
    for (float i = 1.0; i <= numBlurPixelsPerSide; i++) { 
      avgValue += texture2D(texture, coord_tex - i * texOffset * 
                            blurMultiplyVec) * incrementalGaussian.x;         
      avgValue += texture2D(texture, coord_tex + i * texOffset * 
                            blurMultiplyVec) * incrementalGaussian.x;   

      coefficientSum += 2.0 * incrementalGaussian.x;
      incrementalGaussian.xy *= incrementalGaussian.yz;
    }
  } else {
    avgValue += texture2D(texture_PGraphics, coord_tex) * incrementalGaussian.x;
    coefficientSum += incrementalGaussian.x;
    incrementalGaussian.xy *= incrementalGaussian.yz;
   
    // Go through the remaining 8 vertical samples (4 on each side of the center)
    for (float i = 1.0; i <= numBlurPixelsPerSide; i++) { 
      avgValue += texture2D(texture_PGraphics, coord_tex - i * texOffset * 
                            blurMultiplyVec) * incrementalGaussian.x;         
      avgValue += texture2D(texture_PGraphics, coord_tex + i * texOffset * 
                            blurMultiplyVec) * incrementalGaussian.x;   

      coefficientSum += 2.0 * incrementalGaussian.x;
      incrementalGaussian.xy *= incrementalGaussian.yz;
    }
  }
  
  // display
  vec4 result = avgValue / coefficientSum;
  gl_FragColor = result;

}



