/**
Pixel by Stan le punk 
@see https://github.com/StanLepunK
v 0.0.2
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

uniform vec2 resolution;
// uniform vec2 resolution_pattern;

uniform vec4 color_arg;

uniform int num;
uniform ivec2 size;
// uniform float strength;
// uniform int mode;
// uniform int color_mode;

// uniform vec2 position;
// uniform float angle;
// uniform float threshold;
// uniform int rows;
// uniform int cols;

// uniform float quality;

// uniform vec2 offset;

// uniform float scale;

// uniform float time;

uniform bool use_fx_color;


const int max_palette = 16;

/** 
* HSV <-> RGB functions
* about color field: https://codeitdown.com/hsl-hsb-hsv-color/
* FROM : http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl
* or post https://stackoverflow.com/questions/15095909/from-rgb-to-hsv-in-opengl-glsl
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

vec2 pixel_size() {
	return vec2(1)/(resolution/size.xy);
}


vec3 pixelate() {
	vec2 uv = vertTexCoord.st;
	uv = uv - mod(uv,pixel_size());
	return texture2D(texture,uv).xyz;
}

vec3 palette(vec3 rgb_arg) {
	vec3 palette [max_palette];
	float temp_num = num;
	if(temp_num < 2) {
		temp_num = 2;
	} else if(temp_num > max_palette) {
		temp_num = max_palette;

	}
	float step_brightness = 1./temp_num;
	float hue = color_arg.x;
	float sat = color_arg.y;
	float bright = color_arg.z;

	for(int i = 0 ; i < temp_num ; i++) {
		// palette[i] = vec3(hue,color_rgb.y,step_brightness*i +step_brightness); // interesting but weird
		palette[i] = vec3(hue,1.,step_brightness*i +step_brightness);
	}

	vec3 color_hsb = rgb_to_hsb(rgb_arg);
	
	float brightness = color_hsb.z;
	for(int i = 0 ; i < temp_num ; i++) {
		// check brightness, if that's match select color palette
		if(brightness < palette[i].z) {
			color_hsb = palette[i];
			break;
		} else {
			color_hsb = palette[int(temp_num-1)];
		}
	}
	color_hsb.yz = vec2(color_hsb.yz) *color_arg.yz;

	return hsb_to_rgb(color_hsb);
}


void main() {
	vec3 color_rgb = pixelate();
	if(use_fx_color) {
		gl_FragColor = vec4(palette(color_rgb),color_arg.w);
	} else {
		gl_FragColor = vec4(color_rgb,color_arg.w);
	}	
}




