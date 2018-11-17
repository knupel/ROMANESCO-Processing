/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2017 
* Stan le Punk > http://stanlepunk.xyz/
Shader mix from incrustation to texture
Overlay effect
v 0.0.4
*/
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

varying vec4 vertTexCoord;
uniform sampler2D texture;
uniform sampler2D texture_PGraphics;
uniform sampler2D incrustation;

uniform vec4 ratio;   
uniform vec2 wh_renderer_ratio;
uniform bvec2 flip;
uniform bool PGraphics_renderer_is;



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

  vec2 coord_tex = coord;
  vec2 coord_inc = coord;
  // flip
 if(flip.x) {
    coord_inc.x = 1 -coord_inc.x;
    coord_tex.x = 1 -coord_tex.x;
  } 
  if(flip.y) {
    coord_inc.y = 1 -coord_inc.y;
    coord_tex.y = 1 -coord_tex.y;
  } 

    vec4 a ;
  if(!PGraphics_renderer_is) {
    a = vec4(texture2D(texture,coord_tex));
  } else {
    a = vec4(texture2D(texture_PGraphics,coord_tex));
  }
  vec4 b = vec4(texture2D(incrustation,coord_inc) *ratio);
  vec4 rgba = a+b;
  gl_FragColor = rgba;
}