/**
* Colour change A
* Stan le Punk refactoring
* v 0.0.5
* 2018-2019
* Based on rdex project
* Copyright (C) 2008,2009 Claude Heiland-Allen <claudiusmaximus@goto10.org>
* @see https://github.com/StanLepunK
*/
#ifdef GL_ES
precision highp float;
#endif
// Processing implementation
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform sampler2D texture_source;
uniform bvec2 flip_source; // can be use to flip texture
uniform vec2 resolution_source;

uniform float num;

uniform vec3 mat_0;
uniform vec3 mat_1;
uniform vec3 mat_2;

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




vec3 c[3];

void main() {
  // check the case where there is no unirform value pass to shader
  bvec3 is_0 = equal(mat_0,vec3(0));
  bvec3 is_1 = equal(mat_1,vec3(0));
  bvec3 is_2 = equal(mat_2,vec3(0));
  if(all(is_0)) {
    c[0] = vec3(1.0,1.407,0.0); // default value conversion
  } else {
    c[0] = vec3(mat_0);
  }

  if(all(is_1)) {
    c[1] = vec3(1.0,-0.677,-0.236); // default value conversion
  } else {
    c[1] = vec3(mat_1);
  }

  if(all(is_2)) {
    c[2] = vec3(1.0,0.0,1.848); // default value conversion
  } else {
    c[2] = vec3(mat_2);
  }
  
  // LC1C2 Matrix conversion to RGB
  mat3 lcc_to_rgb = mat3(c[0],c[1],c[2]);

  vec2 uv = set_uv(flip_source,resolution_source);
  
  vec2 q = texture2D(texture_source,uv).rg; // texel value


  float u = 1.0 - q.r; // reflect in U = 0.5
  float v = q.g;
  
  float temp_step = num;
  if(temp_step == 0) temp_step = 16.;
  float h = temp_step*atan(v,u); // hue   <= angle
  float l = clamp(cos(temp_step*(v*v + u*u)),.0,1.); // light <= distance
  vec3 lcc = vec3(l, 0.5*cos(h), 0.5*sin(h)); // LC1C2 colour

  gl_FragColor = vec4(lcc * lcc_to_rgb, 1.0); // RGB colour
}



