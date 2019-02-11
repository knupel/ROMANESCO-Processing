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
uniform vec2 texOffset; // from Processing core don't to pass in sketch vector (1/width, 1/height)
varying vec4 vertColor;
varying vec4 vertTexCoord;

// sketch implementation
uniform sampler2D texture;
uniform vec2 position;
uniform vec2 resolution;
uniform float angle;
uniform float threshold;
uniform float size;

const float PI = 3.1415926535897932384626433832795;

float added(vec2 sh, float sa, float ca, vec2 c, float d) {
  return 0.5 + 0.25 * cos((sh.x * sa + sh.y * ca + c.x) * d) + 0.25 * cos((sh.x * ca - sh.y * sa + c.y) * d);
}

void main() {
  vec2 uv = vertTexCoord.st;
  vec2 offset = uv - position;

  float rasterization = added(offset, sin(angle), cos(angle), position, PI / size * 680.0);

  vec4 color = texture(texture,vertTexCoord.st);
        
  float average = 0.2125 * color.r + 0.7154 * color.g + 0.0721 * color.b;
  float gray = (rasterization * threshold + average - threshold) / (1.0 - threshold);

   
  gl_FragColor = vec4(gray,gray,gray,1.0);
}