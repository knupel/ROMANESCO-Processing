/**
* warp procedural refactoring by Stan le punk 
* @see https://github.com/StanLepunK/Filter
* inspired by ushiostarfish https://www.shadertoy.com/user/ushiostarfish
*@see https://www.shadertoy.com/view/4sX3RN

v 0.0.3
2018-2018
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

uniform vec2 resolution_direction;
uniform vec2 resolution_velocity;


// uniform vec2 position; // mapped or not that's a question?
// uniform float time;

// uniform int mode;

// uniform vec4 color_arg;
// uniform int color_mode; // 0 is RGB / 3 is HSB

// uniform int num;
// uniform iVec3 size;
uniform float strength;

uniform float time;
// uniform float angle;
// uniform float threshold;
// uniform float quality;
// uniform vec2 offset;
// uniform float scale;

// uniform int rows;
// uniform int cols;

// uniform bool use_fx_color;
// uniform bool use_fx;






float mod289(float x) {
	return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 mod289(vec4 x) {
	return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 perm(vec4 x) {
	return mod289(((x * 34.0) + 1.0) * x);
}

float noise3d(vec3 p) {
  vec3 a = floor(p);
  vec3 d = p - a;
  d = d * d * (3.0 - 2.0 * d);

  vec4 b = a.xxyy + vec4(0.0, 1.0, 0.0, 1.0);
  vec4 k1 = perm(b.xyxy);
  vec4 k2 = perm(k1.xyxy + b.zzww);

  vec4 c = k2 + a.zzzz;
  vec4 k3 = perm(c);
  vec4 k4 = perm(c + 1.0);

  vec4 o1 = fract(k3 * (1.0 / 41.0));
  vec4 o2 = fract(k4 * (1.0 / 41.0));

  vec4 o3 = o2 * d.z + o1 * (1.0 - d.z);
  vec2 o4 = o3.yw * d.x + o3.xz * (1.0 - d.x);

  return o4.y * d.y + o4.x * (1.0 - d.y);
}

void main() {
	vec2 uv = vertTexCoord.st;
	float v1 = noise3d(vec3(uv * strength, 0.0));
	float v2 = noise3d(vec3(uv * strength, 1.0));
	
	vec4 color  = texture(texture, uv + vec2(v1,v2) * 0.1);
	gl_FragColor = color;
}











