/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2017 
* Stan le Punk > http://stanlepunk.xyz/

Shader mix from incrustation to texture
v 0.0.7
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
uniform bvec2 flip_inc;
uniform bvec2 flip_tex;
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
 if(flip_tex.x) {
    coord_tex.x = 1 -coord_tex.x;
  } 
  if(flip_tex.y) {
    coord_tex.y = 1 -coord_tex.y;
  }
  if(flip_inc.x) {
    coord_inc.x = 1 -coord_inc.x;
  } 
  if(flip_inc.y) {
    coord_inc.y = 1 -coord_inc.y;
  }   

	vec4 a ;
	if(!PGraphics_renderer_is) {
		a = vec4(texture2D(texture,coord_tex) *ratio);
	} else {
		a = vec4(texture2D(texture_PGraphics,coord_tex) *ratio);
	}

  vec4 inverse_ratio = 1.0 -ratio;
  vec4 b = vec4(texture2D(incrustation,coord_inc) *inverse_ratio);
  vec4 rgba = a+b;
  gl_FragColor = rgba;
}
