/**
* Level by Stan le punk 
* @see http://stanlepunk.xyz
* @see https://github.com/StanLepunK/Shader
v 0.2.1
2019-2019
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
uniform bvec2 flip_source; // can be use to flip texture source
uniform vec4 level_source;

uniform int mode;





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

vec2 set_uv() {
  return set_uv(false,false,vec2(0));
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

vec4 to_black(vec2 uv) {
  vec4 color = texture2D(texture_source,uv);
  vec4 ratio = level_source;
  if(ratio.x < 0) ratio.x = 0;
  if(ratio.y < 0) ratio.y = 0;
  if(ratio.z < 0) ratio.z = 0;
  if(ratio.w < 0) ratio.w = 0;
  bvec4 state = equal(ratio,vec4(0));
  if(all(state)) {
    ratio = vec4(1);
  }
  // return color * ratio
  vec4 result = mix(vec4(0),color,ratio);
  return result;
}

vec4 to_white(vec2 uv) {
  vec3 color = texture2D(texture_source,uv).xyz;
  vec3 missing = vec3(1) - color;
  vec3 ratio = vec3(1) - level_source.xyz;

  if(ratio.x < .001) {
    ratio.x = .001;
  } else if (ratio.x > 1) {
    ratio.x = 1;
  }

  if(ratio.y < .001) {
    ratio.y = .001;
  } else if (ratio.y > .999) {
    ratio.y = 1;
  }

  if(ratio.z < .001) {
    ratio.z = .001;
  } else if(ratio.z > 1) {
    ratio.z = 1;
  }

  bvec3 state = equal(ratio,vec3(0));
  if(all(state)) {
    ratio = vec3(1);
  }
  // return color * ratio
  vec3 result = mix(vec3(0),missing,ratio) + color;
  return vec4(result,1);
}



void main() {
  vec2 uv = set_uv(flip_source,resolution_source);
  // vec4 colour = vec4(1);
  
  if(mode == 0) gl_FragColor = to_black(uv);
  else gl_FragColor = to_white(uv);
}





