/**
Stan le punk version
@see https://github.com/StanLepunK
v 0.0.1
2018-2018
based on work of Raphaël de Courville 
@see https://github.com/SableRaf/Filters4Processing
*/
// Processing implementation
#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;

// sketch implementation
// sketch implementation template, uniform use by most of filter Romanesco shader
uniform sampler2D texture_source;
uniform bvec2 flip_source; // can be use to flip texture
uniform vec2 resolution_source;

// sketch implementation template, uniform use by most of filter Romanesco shader
uniform sampler2D texture_layer;
uniform bvec2 flip_layer; // can be use to flip texture
uniform vec2 resolution_layer;

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




void main() {
		
	vec2 uv_source = set_uv(flip_source,resolution_source);
	vec2 uv_layer = set_uv(flip_layer,resolution_layer);
	uv_source.y = uv_source.y;
	
	vec3 sourcePixel = texture2D(texture_source, uv_source).rgb;
	float grayscale = length(sourcePixel*vec3(0.2126,0.7152,0.0722));
	
	// vec3 ditherPixel = texture2D(texture_pattern, vec2(mod(gl_FragCoord.xy/vec2(8.0,8.0),1.0))).xyz;
	vec3 ditherPixel = texture2D(texture_layer, vec2(mod(uv_layer,1.0))).xyz;
	float ditherGrayscale = (ditherPixel.x + ditherPixel.y + ditherPixel.z) / 3.0;
	ditherGrayscale -= 0.5;
	
	float ditheredResult = grayscale + ditherGrayscale;
	
	float bit = ditheredResult >= 0.5 ? 1.0 : 0.0;
	gl_FragColor = vec4(bit,bit,bit,1);
}







/*
uniform sampler2D texture;
uniform sampler2D texture_pattern;

uniform vec2 resolution;
uniform vec2 resolution_pattern;




void main() {
		
	vec2 uv = gl_FragCoord.xy / resolution;
	uv.y = uv.y;
	
	vec3 sourcePixel = texture2D(texture, uv).rgb;
	float grayscale = length(sourcePixel*vec3(0.2126,0.7152,0.0722));
	
	// vec3 ditherPixel = texture2D(texture_pattern, vec2(mod(gl_FragCoord.xy/vec2(8.0,8.0),1.0))).xyz;
	vec3 ditherPixel = texture2D(texture_pattern, vec2(mod(gl_FragCoord.xy/resolution_pattern,1.0))).xyz;
	float ditherGrayscale = (ditherPixel.x + ditherPixel.y + ditherPixel.z) / 3.0;
	ditherGrayscale -= 0.5;
	
	float ditheredResult = grayscale + ditherGrayscale;
	
	float bit = ditheredResult >= 0.5 ? 1.0 : 0.0;
	gl_FragColor = vec4(bit,bit,bit,1);
}
*/