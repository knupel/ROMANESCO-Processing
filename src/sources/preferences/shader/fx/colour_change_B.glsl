/**
* colour change B 
* by Stan le punk 
* @see https://github.com/StanLepunK
* @see https://github.com/StanLepunK/Filter
* v 0.0.4
2018-2019
*/
// Processing implementation
#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;

// sketch implementation template, uniform use by most of filter Romanesco shader
uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform bvec2 flip_source; // can be use to flip texture


uniform float strength;

uniform float angle;

#define PI 3.1415926535897932384626433832795


// UTIL TEMPLATE
vec2 set_uv(bool flip_vertical, bool flip_horizontal, vec2 res) {
  vec2 uv;
  if(all(equal(vec2(0),res))) {
    uv = vertTexCoord.st;
  } else if(all(greaterThan(res,vertTexCoord.st))) {
    uv = vertTexCoord.st;
  } else {
    uv = res;
  }
  // flip 
  if(!flip_vertical && !flip_horizontal) {
    return uv;
  } else if(flip_vertical && !flip_horizontal) {
    uv.y = 1 -uv.y;
    return uv;
  } else if(!flip_vertical && flip_horizontal) {
    uv.x = 1 -uv.x;
    return uv;
  } else if(flip_vertical && flip_horizontal) {
    return vec2(1) -uv;
  } return uv;
}

vec2 set_uv(bvec2 flip, vec2 res) {
  return set_uv(flip.x,flip.y,res);
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

vec2 cartesian_coord(float angle) {
  float x = cos(angle);
  float y = sin(angle);
  return vec2(x,y);
}

vec2 translate(float angle, float distance) {
	// float angle = mix(0,2*PI,direction);
  return cartesian_coord(angle) *distance;
}

float random(vec2 seed){
	return fract(sin(dot(seed.xy ,vec2(12.9898,78.233))) * 43758.5453);
}




void main() {
	vec2 uv = set_uv(flip_source,resolution_source);
	vec4 color = texture2D(texture_source,uv);
	
	float hue = rgb_to_hsb(color.rgb).x; // hue
	float saturation = rgb_to_hsb(color.rgb).y; // saturation
	float brightness = rgb_to_hsb(color.rgb).z; // brightness
	float red = color.r; // red
	float green = color.g; // red
	float blue = color.b; // red
	
	float distance = brightness *strength;
	vec2 translation = translate(angle,distance);

  gl_FragColor = texture2D(texture_source,translation);
}





