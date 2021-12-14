/**
* Antialiasing FXAA
* @see @stanlepunk
* @see https://github.com/StanLepunK/Shader
* v 0.1.0
* 2019-2019
* @see https://github.com/libretro/glsl-shaders/blob/master/anti-aliasing/shaders/fxaa.glsl
*/


// Processing implementation
#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;
uniform vec2 resolution; // WARNING VERY IMPORTANT // need this name for unknow reason :( here your pass your resolution texture
// vec2 texOffset   = vec2(1) / resolution; // only work with uniform resolution

// Rope implementation
uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform ivec2 flip_source; // can be use to flip texture source



// setting fxaa
// for the fourth seeting i've a feeling nothing happen :(
uniform float edge_threshold; // from 0 to 0.8
uniform float edge_threshold_min; // from 0 to 1

uniform int search_steps; // from 2 to more and more 
uniform float search_threshold; // from 0 to 1 


// here someting visible happen 
uniform float sub_pix_cap; // from 0 to 1
uniform float sub_pix_trim; // from -1 to 1






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



// Return the luma, the estimation of luminance from rgb inputs.
// This approximates luma using one FMA instruction,
// skipping normalization and tossing out blue.
// FxaaLuma() will range 0.0 to 2.963210702.
float fxaa_luma(vec3 rgb) {
  return rgb.y * (0.587/0.299) + rgb.x;
}

vec3 fxaa_lerp_3(vec3 a, vec3 b, float amount_ofa) {
  return (vec3(-amount_ofa) * b) + ((a * vec3(amount_ofa)) + b);
}

vec4 fxaa_tex_off(sampler2D tex, vec2 pos, ivec2 off, vec2 rcp_frame) {
  float x = pos.x + float(off.x) * rcp_frame.x;
  float y = pos.y + float(off.y) * rcp_frame.y;
  return texture2D(tex, vec2(x,y));
}

// pos is the output of FxaaVertexShader interpolated across screen.
// xy -> actual texture position {0.0 to 1.0}
// rcp_frame should be a uniform equal to  {1.0/frameWidth, 1.0/frameHeight}
vec3 fxaa_pixel_shader(sampler2D tex, vec2 pos, vec2 rcp_frame) {
  float FXAA_EDGE_THRESHOLD = edge_threshold;
  float FXAA_EDGE_THRESHOLD_MIN = edge_threshold_min;
  float FXAA_SEARCH_STEPS  = search_steps;
  float FXAA_SEARCH_THRESHOLD = search_threshold;
  float FXAA_SUBPIX_CAP = sub_pix_cap;
  float FXAA_SUBPIX_TRIM = sub_pix_trim;
  float FXAA_SUBPIX_TRIM_SCALE = 1.0/(1.0 - FXAA_SUBPIX_TRIM);

  vec3 rgbN = fxaa_tex_off(tex, pos.xy, ivec2( 0,-1), rcp_frame).xyz;
  vec3 rgbW = fxaa_tex_off(tex, pos.xy, ivec2(-1, 0), rcp_frame).xyz;
  vec3 rgbM = fxaa_tex_off(tex, pos.xy, ivec2( 0, 0), rcp_frame).xyz;
  vec3 rgbE = fxaa_tex_off(tex, pos.xy, ivec2( 1, 0), rcp_frame).xyz;

  vec3 rgbS = fxaa_tex_off(tex, pos.xy, ivec2( 0, 1), rcp_frame).xyz;
  
  float lumaN = fxaa_luma(rgbN);
  float lumaW = fxaa_luma(rgbW);
  float lumaM = fxaa_luma(rgbM);
  float lumaE = fxaa_luma(rgbE);

  float lumaS = fxaa_luma(rgbS);

  float range_min = min(lumaM, min(min(lumaN, lumaW), min(lumaS, lumaE)));
  float range_max = max(lumaM, max(max(lumaN, lumaW), max(lumaS, lumaE)));
  
  float range = range_max - range_min;
  if(range < max(FXAA_EDGE_THRESHOLD_MIN, range_max * FXAA_EDGE_THRESHOLD)) {
      return rgbM;
  }
  
  vec3 rgbL = rgbN + rgbW + rgbM + rgbE + rgbS;
  
  float lumaL = (lumaN + lumaW + lumaE + lumaS) * 0.25;
  float rangeL = abs(lumaL - lumaM);
  float blendL = max(0.0, (rangeL / range) - FXAA_SUBPIX_TRIM) * FXAA_SUBPIX_TRIM_SCALE; 
  blendL = min(FXAA_SUBPIX_CAP, blendL);
  
  vec3 rgbNW = fxaa_tex_off(tex, pos.xy, ivec2(-1,-1), rcp_frame).xyz;
  vec3 rgbNE = fxaa_tex_off(tex, pos.xy, ivec2( 1,-1), rcp_frame).xyz;
  vec3 rgbSW = fxaa_tex_off(tex, pos.xy, ivec2(-1, 1), rcp_frame).xyz;
  vec3 rgbSE = fxaa_tex_off(tex, pos.xy, ivec2( 1, 1), rcp_frame).xyz;
  rgbL += (rgbNW + rgbNE + rgbSW + rgbSE);
  rgbL *= vec3(1.0/9.0);
  
  float lumaNW = fxaa_luma(rgbNW);
  float lumaNE = fxaa_luma(rgbNE);
  float lumaSW = fxaa_luma(rgbSW);
  float lumaSE = fxaa_luma(rgbSE);
  
  float edgeVert = 
      abs((0.25 * lumaNW) + (-0.5 * lumaN) + (0.25 * lumaNE)) +
      abs((0.50 * lumaW ) + (-1.0 * lumaM) + (0.50 * lumaE )) +
      abs((0.25 * lumaSW) + (-0.5 * lumaS) + (0.25 * lumaSE));
  float edgeHorz = 
      abs((0.25 * lumaNW) + (-0.5 * lumaW) + (0.25 * lumaSW)) +
      abs((0.50 * lumaN ) + (-1.0 * lumaM) + (0.50 * lumaS )) +
      abs((0.25 * lumaNE) + (-0.5 * lumaE) + (0.25 * lumaSE));
      
  bool horz_span = edgeHorz >= edgeVert;
  float length_sign = horz_span ? -rcp_frame.y : -rcp_frame.x;
  
  if(!horz_span) {
    lumaN = lumaW;
    lumaS = lumaE;
  }
  
  float gradientN = abs(lumaN - lumaM);
  float gradientS = abs(lumaS - lumaM);
  lumaN = (lumaN + lumaM) * 0.5;
  lumaS = (lumaS + lumaM) * 0.5;
  
  if (gradientN < gradientS) {
    lumaN = lumaS;
    lumaN = lumaS;
    gradientN = gradientS;
    length_sign *= -1.0;
  }
  
  vec2 posN;
  posN.x = pos.x + (horz_span ? 0.0 : length_sign * 0.5);
  posN.y = pos.y + (horz_span ? length_sign * 0.5 : 0.0);
  
  gradientN *= FXAA_SEARCH_THRESHOLD;
  
  vec2 posP = posN;
  vec2 offNP = horz_span ? vec2(rcp_frame.x, 0.0) : vec2(0.0, rcp_frame.y); 
  float luma_end_N = lumaN;
  float luma_end_P = lumaN;
  bool doneN = false;
  bool doneP = false;
  posN += offNP * vec2(-1.0, -1.0);
  posP += offNP * vec2( 1.0,  1.0);
  
  for(int i = 0; i < FXAA_SEARCH_STEPS; i++) {
    if(!doneN) {
      luma_end_N = fxaa_luma(texture2D(tex, posN.xy).xyz);
    }
    if(!doneP) {
      luma_end_P = fxaa_luma(texture2D(tex, posP.xy).xyz);
    }
    
    doneN = doneN || (abs(luma_end_N - lumaN) >= gradientN);
    doneP = doneP || (abs(luma_end_P - lumaN) >= gradientN);
    
    if(doneN && doneP) {
      break;
    } 
    if(!doneN) {
      posN -= offNP;
    }
    if(!doneP) {
      posP += offNP;
    }
  }
  
  float dstN = horz_span ? pos.x - posN.x : pos.y - posN.y;
  float dstP = horz_span ? posP.x - pos.x : posP.y - pos.y;
  bool directionN = dstN < dstP;
  luma_end_N = directionN ? luma_end_N : luma_end_P;
  
  if(((lumaM - lumaN) < 0.0) == ((luma_end_N - lumaN) < 0.0)) {
    length_sign = 0.0;
  }


  float spanLength = (dstP + dstN);
  dstN = directionN ? dstN : dstP;
  float sub_pixel_offset = (0.5 + (dstN * (-1.0/spanLength))) * length_sign;
  
  vec3 rgbF = texture2D(tex, vec2(
      pos.x + (horz_span ? 0.0 : sub_pixel_offset),
      pos.y + (horz_span ? sub_pixel_offset : 0.0))).xyz;
      
  return fxaa_lerp_3(rgbL, rgbF, blendL); 
}




void main() {
  vec2 uv = set_uv(flip_source,resolution_source);
  vec2 inverseVP = vec2(1.0 / resolution_source.x, 1.0 / resolution_source.y);
  gl_FragColor = vec4(fxaa_pixel_shader(texture_source, uv, inverseVP), 1.0) * 1.0;
} 

