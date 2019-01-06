/**
Stan le punk version
@see https://github.com/StanLepunK
v 0.0.1
2018-2018
*/

#ifdef GL_ES
precision highp float;
#endif
// from Processing
#define PROCESSING_TEXTURE_SHADER
uniform vec2 texOffset; // The inverse of the texture dimensions along X and Y
varying vec4 vertColor;
varying vec4 vertTexCoord;

// from Sketch
uniform sampler2D texture;
uniform vec2 position;//x,y
uniform float strength;
uniform float scale;

void main() {   
  vec2 tex_coord = vertTexCoord.st;
  vec2 position_temp = vec2(position.x,1-position.y);
  float strength_temp = strength;
  float scale_temp = scale;
  // if(scale_temp <= 0) scale_temp = .9;
  if(strength_temp < 2) strength_temp = 2;

  vec4 color;
  for(float i = 0.0; i < 1.0 ; i += 1.0/strength_temp) {
    float v = scale_temp + i * 0.1;//convert "i" to the 0.9 to 1 range
    color += texture2D(texture,tex_coord * v +(position_temp) *(1.0-v));
  }

  color /= strength_temp;
  gl_FragColor =  color *vertColor;
}


