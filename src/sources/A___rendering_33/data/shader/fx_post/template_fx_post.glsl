/**
* Template POST FX
* @see @stanlepunk
* @see https://github.com/StanLepunK/Shader
* v 0.1.0
* 2018-2019
*/
// Processing implementation
#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;
uniform vec2 resolution; // WARNING VERY IMPORTANT // need this name for unknow reason :( here your pass your resolution texture
// vec2 texOffset   = vec2(1) / resolution; // only work with uniform resolution

// Rope implementation
uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform ivec2 flip_source; // can be use to flip texture source
uniform vec4 level_source;

// uniform sampler2D texture_layer;
// uniform vec2 resolution_layer;
// uniform ivec2 flip_layer; // can be use to flip texture layer
// uniform vec4 level_layer;

// uniform vec2 position; // maneep to receive a normal information 0 > 1

// uniform float time;
// uniform int mode;

uniform int color_mode; // 0 is RGB / 3 is HSB

// uniform int num;
// uniform ivec3 size;
// uniform float strength;

// uniform float angle;
// uniform float threshold;
// uniform float quality;
// uniform vec2 offset;
// uniform float scale;

// uniform int rows;
// uniform int cols;x

// uniform bool use_fx_color;
// uniform bool use_fx;



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






vec4 set_color(vec4 color, vec4 mix) {
  vec4 ratio = mix;
  if(ratio.x < 0) ratio.x = 0;
  if(ratio.y < 0) ratio.y = 0;
  if(ratio.z < 0) ratio.z = 0;
  if(ratio.w < 0) ratio.w = 0;
  bvec4 state = equal(ratio,vec4(0));
  bool use_ratio_is = true;
  if(all(state)) {
    ratio = vec4(1);
    use_ratio_is = false;
  }
  
  if(use_ratio_is) {
    return mix(vec4(0),color,ratio);;
  } else return color;
}

/** 
* HSV <-> RGB functions
* about color field: https://codeitdown.com/hsl-hsb-hsv-color/
* FROM : http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl
* or post https://stackoverflow.com/questions/15095909/from-rgb-to-hsv-in-opengl-glsl
*
* All components are in the range [0 > 1], including hue.
*/

vec3 rgb_to_hsb(vec3 c) {
  vec4 K = vec4(0, -1./3., 2./3., -1.);
  vec4 p = mix(vec4(c.bg,K.wz),vec4(c.gb,K.xy),step(c.b,c.g));
  vec4 q = mix(vec4(p.xyw,c.r),vec4(c.r,p.yzx),step(p.x,c.r));

  float d = q.x-min(q.w,q.y);
  float e = 1.0e-10;
  return vec3(abs(q.z+(q.w-q.y)/(6.*d+e)),d/(q.x+e),q.x);
}

vec3 hsb_to_rgb(vec3 c) {
  vec4 K = vec4(1, 2./3., 1./3., 3);
  vec3 p = abs(fract(c.xxx+K.xyz)*6.-K.www);
  return c.z*mix(K.xxx,clamp(p-K.xxx, 0., 1.),c.y);
}
/**
END UTIL TEMPLATE
*/





// example
vec4 change_hue(vec2 uv) {
	vec4 color = texture2D(texture_source,uv);
	color.a = level_source.a;
	if(color_mode == 3) {
		vec3 hsb = rgb_to_hsb(color.rgb);
		hsb.x = level_source.x;
		color.xyz = hsb_to_rgb(hsb);
	} else {
		color.x = level_source.x;
	}
  return color;
}






void main() {
  vec2 uv = set_uv(flip_source,resolution_source);
  gl_FragColor = texture2D(texture_source,uv);
	// gl_FragColor = change_hue(uv);
}





