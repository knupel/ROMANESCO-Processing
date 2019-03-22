/**
* warp texture type A
* this warp use two textures, one for direction and other one for intensity
* @see @stanlepunk
* @see https://github.com/StanLepunK/Shader
* v 0.0.8
* 2018-2019
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
uniform ivec2 flip_source;

uniform sampler2D texture_direction;
uniform sampler2D texture_velocity;

uniform int mode;

uniform float strength;


#define PI 3.1415926535897932384626433832795


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





float random(vec2 seed){
	return fract(sin(dot(seed.xy ,vec2(12.9898,78.233))) * 43758.5453);
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

/**
distance arg need to be normal 0 > 1
*/
vec2 translate(float direction, float distance) {
	float angle = mix(0,2*PI,direction); // map from 0 > 1 to 0 > 2*PI
  return cartesian_coord(angle) *distance;
}



void show_warp(vec2 uv_tex, vec2 uv_vel, vec2 uv_dir) {
  // warping direction
	vec4 dir = texture2D(texture_direction,uv_dir);
  // warping velocity
	vec4 vel = texture2D(texture_velocity,uv_vel) *strength;
  // warping
  vec2 proj_r = translate(dir.r,vel.r);
  vec2 proj_g = translate(dir.g,vel.g);
  vec2 proj_b = translate(dir.b,vel.b);
  vec2 proj_a = translate(dir.a,vel.a);
  vec2 uv_r = uv_tex + proj_r;
  vec2 uv_g = uv_tex + proj_g;
  vec2 uv_b = uv_tex + proj_b;
  vec2 uv_a = uv_tex + proj_a;

  float r = texture2D(texture_source,uv_r).r;
	float g = texture2D(texture_source,uv_g).g;
	float b = texture2D(texture_source,uv_b).b;
	float a = texture2D(texture_source,uv_a).a;
  gl_FragColor = vec4(r,g,b,a);
}


void show_direction(vec2 uv_dir) {
	vec4 tex_colour = texture2D(texture_direction,uv_dir);
	gl_FragColor = tex_colour;
}

void show_velocity(vec2 uv_vel) {
	vec4 tex_colour = texture2D(texture_velocity,uv_vel);
	gl_FragColor = tex_colour;
}



void main() {
  vec2 uv_source = set_uv(flip_source,resolution_source);
  vec2 uv_velocilty = set_uv();
  vec2 uv_direction = set_uv();

	if(mode == 0) {
		show_warp(uv_source,uv_velocilty,uv_direction);
	} else if(mode == 500) {
		show_velocity(uv_velocilty);
	} else if(mode == 501) {
		show_direction(uv_direction);
	} else {
		show_warp(uv_source,uv_velocilty,uv_direction);
	}
}







