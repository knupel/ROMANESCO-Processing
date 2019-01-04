/**
Template by Stan le punk 
@see https://github.com/StanLepunK
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

// uniform vec2 resolution;
// uniform vec2 resolution_pattern;

// uniform vec2 position; // mapped or not that's a question?
// uniform float time;

// uniform int mode;

// uniform vec4 color_arg;
uniform int color_mode; // 0 is RGB / 3 is HSB

// uniform int num;
// uniform iVec3 size;
// uniform float strength;

// uniform float angle;
// uniform float threshold;
// uniform float quality;
// uniform vec2 offset;
// uniform float scale;

// uniform int rows;
// uniform int cols;

// uniform bool use_fx_color;
// uniform bool use_fx;


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




void main() {
	vec2 uv = vertTexCoord.st;
	vec4 color = texture2D(texture,uv);
	color.a = color_arg.a;
	if(color_mode == 3) {
		vec3 hsb = rgb_to_hsb(color.rgb);
		hsb.x = color_arg.x;
		color.xyz = hsb_to_rgb(hsb);
	} else {
		color.x = color_arg.x;
	}
  gl_FragColor = color;
}





