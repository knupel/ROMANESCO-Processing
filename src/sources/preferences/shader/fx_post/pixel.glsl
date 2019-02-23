/**
* Pixel by Stan le punk 
* @see http://stanlepunk.xyz
* @see https://github.com/StanLepunK/Shader
* v 0.0.4
* 2018-2019
*/
// Processing implementation
#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;
/**
WARNING VERY IMPORTANT
*/
uniform vec2 resolution; // need this name for unknow reason :( here your pass your resolution texture

// sketch implementation template, uniform use by most of filter Romanesco shader
uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform bvec2 flip_source; // can be use to flip texture
uniform vec4 level_source;

uniform int num;
uniform ivec2 size;

uniform bool use_fx_color;


const int max_palette = 16;

/** 
* HSV <-> RGB functions
* about color field: https://codeitdown.com/hsl-hsb-hsv-color/
* FROM : http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl
* or post https://stackoverflow.com/questions/15095909/from-rgb-to-hsv-in-opengl-glsl
* All components are in the range [0 > 1], including hue.
*/
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

vec2 pixel_size(vec2 res) {
	return vec2(1)/(res/size.xy);
}


vec3 pixelate(vec2 uv, sampler2D tex, vec2 res) {
	//return texture2D(tex,uv).xyz;
	// uv = uv - mod(uv,size);
	// uv = uv - mod(uv,.01);
	// uv = uv - mod(uv,vec2(1)/size.xy);
	uv = uv - mod(uv,vec2(1)/(res/size.xy));
	// uv = uv - mod(uv,pixel_size(res));
	return texture2D(tex,uv).xyz;
	
}

vec3 palette(vec3 rgb_arg, vec3 level) {
	vec3 palette [max_palette];
	float temp_num = num;
	if(temp_num < 2) {
		temp_num = 2;
	} else if(temp_num > max_palette) {
		temp_num = max_palette;

	}
	float step_brightness = 1./temp_num;
	float hue = level.x;
	float sat = level.y;
	float bright = level.z;

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
	color_hsb.yz = vec2(color_hsb.yz) *level.yz;

	return hsb_to_rgb(color_hsb);
}


void main() {
	vec2 uv = set_uv(flip_source,resolution_source);
	vec3 color_rgb = pixelate(uv,texture_source,resolution);
	
	if(use_fx_color) {
		gl_FragColor = vec4(palette(color_rgb,level_source.xyz),1);
	} else {
		gl_FragColor = vec4(color_rgb,1);
	}	
}




