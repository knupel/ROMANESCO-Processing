/**
* Split RGB
* @see @stanlepunk
* @see https://github.com/StanLepunK/Shader
* v 0.0.4
* 2018-2019
*/

#ifdef GL_ES
precision highp float;
#endif
// from Processing texture
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;

// from Sketch
uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform ivec2 flip_source;

//uniform vec2 position; 
uniform vec2 offset_red;
uniform vec2 offset_green;
uniform vec2 offset_blue;


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
	vec2 uv = set_uv(flip_source,resolution_source);

  vec2 or = offset_red *.1;
  vec2 og = offset_green *.1;
  vec2 ob = offset_blue *.1;
  vec2 red_uv = uv + vec2(or);
  vec2 green_uv = uv + vec2(og);
  vec2 blue_uv = uv + vec2(ob);


	float r = texture2D(texture_source,red_uv).r;
	float g = texture2D(texture_source,green_uv).g;
	float b = texture2D(texture_source,blue_uv).b;
	
	gl_FragColor = vec4(r,g,b,1);
}