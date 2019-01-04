/**
* warp texture by Stan le punk 
* @see https://github.com/StanLepunK/Filter
* v 0.0.6
* 2018-2019
*/
// Processing implementation
#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_TEXTURE_SHADER
uniform vec2 texOffset; // from Processing core don't to pass in sketch vector (1/width, 1/height)
varying vec4 vertColor;
varying vec4 vertTexCoord;

// sketch implementation template, uniform use by most of filter Romanesco shader
uniform sampler2D texture;
// uniform sampler2D texture_pattern;
uniform sampler2D texture_direction;
uniform sampler2D texture_velocity;

// uniform vec2 resolution;
// uniform vec2 resolution_pattern;

// uniform vec2 resolution_direction;
// uniform vec2 resolution_velocity;


// uniform vec2 position; // mapped or not that's a question?
// uniform float time;

uniform int mode;

// uniform vec4 color_arg;
// uniform int color_mode; // 0 is RGB / 3 is HSB

// uniform int num;
// uniform iVec3 size;
uniform float strength;

// uniform float time;
// uniform float angle;
// uniform float threshold;
// uniform float quality;
// uniform vec2 offset;
// uniform float scale;

// uniform int rows;
// uniform int cols;

// uniform bool use_fx_color;
// uniform bool use_fx;


#define PI 3.1415926535897932384626433832795



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



void show_warp() {
  // warping direction
  vec4 dir = texture2D(texture_direction,vertTexCoord.st);
  // warping velocity
  vec4 vel = texture2D(texture_velocity,vertTexCoord.st) *strength;
  // warping
  vec2 proj_r = translate(dir.r,vel.r);
  vec2 proj_g = translate(dir.g,vel.g);
  vec2 proj_b = translate(dir.b,vel.b);
  vec2 proj_a = translate(dir.a,vel.a);
  vec2 uv_r = vertTexCoord.st + proj_r;
  vec2 uv_g = vertTexCoord.st + proj_g;
  vec2 uv_b = vertTexCoord.st + proj_b;
  vec2 uv_a = vertTexCoord.st + proj_a;

  float r = texture2D(texture,uv_r).r;
  float g = texture2D(texture,uv_g).g;
  float b = texture2D(texture,uv_b).b;
  float a = texture2D(texture,uv_a).a;
  gl_FragColor = vec4(r,g,b,a);
}


void show_direction() {
  vec4 tex_colour = texture2D(texture_direction,vertTexCoord.st);
  gl_FragColor = tex_colour;
}

void show_velocity() {
  vec4 tex_colour = texture2D(texture_velocity,vertTexCoord.st);
  gl_FragColor = tex_colour;
}



void main() {
  if(mode == 0) {
    show_warp();
  } else if(mode == 500) {
    show_velocity();
  } else if(mode == 501) {
    show_direction();
  } else {
    show_warp();
  }
}







