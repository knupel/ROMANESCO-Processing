/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2017 
* Stan le Punk > http://stanlepunk.xyz/
Shader level color from texture
v 0.1.
*/
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

varying vec4 vertTexCoord;
uniform sampler2D texture;
uniform sampler2D texture_PGraphics;

uniform vec4 ratio;   
uniform vec2 wh_renderer_ratio;
uniform bvec2 flip;
uniform bool PGraphics_renderer_is;

uniform vec4 level;



void main() {
  vec2 coord = vertTexCoord.st;

  // scale
  vec2 zero = vec2(0,0);
  if(notEqual(wh_renderer_ratio,zero).x && notEqual(wh_renderer_ratio,zero).y) { 
    coord /= wh_renderer_ratio;
  }

  if(PGraphics_renderer_is) {
    coord.y = 1 -coord.y;
  }

 // vec2 coord_tex = coord;
 //  vec2 coord_inc = coord;
  // flip
 if(flip.x) {
 //   coord_inc.x = 1 -coord_inc.x;
    coord.x = 1 -coord.x;
  } 
  if(flip.y) {
 //   coord_inc.y = 1 -coord_inc.y;
    coord.y = 1 -coord.y;
  } 
  
  vec4 rgba ;
  if(!PGraphics_renderer_is) {
    rgba = vec4(texture2D(texture,coord) *level);
  } else {
    rgba = vec4(texture2D(texture_PGraphics,coord) *level);
  }

  // vec4 rgba = vec4(texture2D(texture,coord_tex) *level);
  gl_FragColor = rgba;
}