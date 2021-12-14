/**
* Threshold
* @see @stanlepunk
* @see https://github.com/StanLepunK/Shader
v 0.2.3
2018-2019
* based on work of Raphaël de Courville and for the other better method - with dFdy and dFdx... I don't remember :)
*/
// Processing implementation
#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;

// sketch implementation
uniform sampler2D texture_source;
uniform ivec2 flip_source; // can be use to flip texture
uniform vec2 resolution_source;



uniform int mode;
uniform vec3 level_source;




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


/*
* other option to threshold, better or not I don't know
*/
/*
vec3 threshold(vec3 threshold, vec3 col) {
  float af_x = length(vec2(dFdx(col.x), dFdy(col.x))) * 0.2126;
  float af_y = length(vec2(dFdx(col.y), dFdy(col.y))) * 0.70710678118654757;
  float af_z = length(vec2(dFdx(col.z), dFdy(col.z))) * 0.0722;

  vec3 af = vec3(af_x,af_y,af_z);
  return smoothstep(threshold-af, threshold+af, col);
}
*/

void main() {	
	vec2 uv_source = set_uv(flip_source,resolution_source);
	uv_source.y = uv_source.y;
	
	vec3 pixel_src = texture2D(texture_source, uv_source).rgb;
	float gray_scale = length(pixel_src *vec3(0.2126,0.7152,0.0722));
  
  // second pass to have a better and finest result
	vec3 threshold_pix = texture2D(texture_source, vec2(mod(uv_source,1.0))).xyz;
	float threshold_average = (threshold_pix.x + threshold_pix.y + threshold_pix.z) / 3.0;
	
	float threshold_result = gray_scale + threshold_average;

	if(mode == 0) {
		float bit_gray = threshold_result >= level_source.x ? 1.0 : 0.0;
		gl_FragColor = vec4(bit_gray,bit_gray,bit_gray,1);
	} else if(mode == 1) {
		float bit_red = threshold_result >= level_source.x ? 1.0 : 0.0;
		float bit_green = threshold_result >= level_source.y ? 1.0 : 0.0;
		float bit_blue = threshold_result >= level_source.z ? 1.0 : 0.0;
		gl_FragColor = vec4(bit_red,bit_green,bit_blue,1);
	} else {
		float bit_gray = threshold_result >= level_source.x ? 1.0 : 0.0;
		gl_FragColor = vec4(bit_gray,bit_gray,bit_gray,1);
	}
}




