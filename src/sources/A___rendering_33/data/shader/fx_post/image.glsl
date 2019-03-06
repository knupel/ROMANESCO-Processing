/**
* Image mapping POST FX
* @see http://stanlepunk.xyz
* @see https://github.com/StanLepunK/Shader
* v 0.0.2
* 2018-2019
*/
// Processing implementation
#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;
uniform ivec2 resolution; // WARNING VERY IMPORTANT // need this name for unknow reason :( here your pass your resolution texture

// Rope implementation
uniform sampler2D texture_source;
uniform ivec2 resolution_source;
uniform bvec2 flip_source; // can be use to flip texture source
uniform vec4 level_source;

uniform vec2 position; // maneep to receive a normal information 0 > 1

uniform vec3 colour;
uniform vec4 curtain;

uniform vec2 scale;
uniform vec2 offset;
// uniform float scale1D;

uniform int mode;
// mode 0 > CENTER
// mode 1 > SCREEN
// MODE 2 > SCALE




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


vec4 curtain_calc(vec2 uv, vec4 rendering) {
  if(uv.x < curtain.w || uv.x > 1.0 -curtain.y) {
    rendering = vec4(colour,1.0);
  }
  if(uv.y < curtain.x || uv.y > 1.0 -curtain.z) {
    rendering = vec4(colour,1.0);
  }
  return rendering;
}








vec4 center(vec2 uv, vec2 res, vec2 res_src) {
  vec2 offset = vec2(0.0);
  vec2 ratio2D = res /res_src;
  vec2 scale2D = res_src /res;

  vec2 norm_miss = vec2(0.0);

  vec2 final_uv = vec2(0.0);  
  if(ratio2D.x > ratio2D.y) {
    float res_src_final_x = res_src.x *ratio2D.y ; // original
    float normal_res_src_final_x = res_src_final_x /res.x;
    norm_miss.x = 1.0 -normal_res_src_final_x;
    offset = vec2(-norm_miss.x *0.5,0.0);
    final_uv = (uv +offset) *ratio2D *scale2D.y;
  } else {
    float res_src_final_y = res_src.y *ratio2D.x;
    float normal_res_src_final_y = res_src_final_y /res.y;
    norm_miss.y = 1.0 -normal_res_src_final_y;
    offset = vec2(0.0,-norm_miss.y *0.5); 
    final_uv = (uv +offset) *ratio2D *scale2D.x;
  }

  vec4 rendering = texture2D(texture_source,final_uv);
  return curtain_calc(final_uv,rendering);
}




vec4 scaling(vec2 uv, vec2 res, vec2 res_src, vec2 pos, vec2 scale) {
  vec2 res_src2D = res_src;
  if(all(notEqual(scale,vec2(0)))) {
    res_src2D = res_src *scale;
  }
  vec2 ratio2D = res /res_src2D;
  vec2 mid_pos =(vec2(1.0) -(vec2(1.0) /ratio2D)) *0.5;
  vec2 pos2D = mid_pos;
  if(all(notEqual(pos,vec2(0.0)))){
    pos2D = mid_pos +(pos -vec2(.5));
  }
  vec2 final_uv = (uv -pos2D) *ratio2D;
  vec4 rendering = texture2D(texture_source,final_uv);
  return curtain_calc(final_uv,rendering);
}

vec4 screen(vec2 uv, vec2 res, vec2 res_src, vec2 pos, vec2 scale) {
  vec2 ratio2D = res /res_src;

  vec2 scale2D = vec2(1.0);
  if(ratio2D.x > ratio2D.y) {
    scale2D = vec2(ratio2D.x);
  } else {
    scale2D = vec2(ratio2D.y);
  }

  return scaling(uv,res,res_src,position,scale2D);
}



void main() {
  vec2 res = vec2(resolution);
  vec2 res_src = vec2(resolution_source);
  vec2 uv = set_uv(flip_source,res_src);
  
  if(mode == 0) {
    gl_FragColor = center(uv,res,res_src);
  } else if(mode == 1) {
    gl_FragColor = screen(uv,res,res_src,position,scale);
  } else if(mode == 2) {
    gl_FragColor = scaling(uv,res,res_src,position,scale);
  } else {
    gl_FragColor = center(uv,res,res_src);
  }
  
  // 
}





