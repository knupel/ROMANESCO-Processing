/**
* GLitch FXAA
* Glitch effect besed on bad algorithm FXAA
* @see @stanlepunk
* @see https://github.com/StanLepunK/Shader
* v 0.0.1
* 2019-2019
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

uniform vec2 nw;
uniform vec2 ne;
uniform vec2 sw;
uniform vec2 se;



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





#define FXAA_REDUCE_MIN (1.0/ 128.0)
#define FXAA_REDUCE_MUL (1.0 / 8.0)
#define FXAA_SPAN_MAX 8.0

vec4 fxaa(sampler2D tex, vec2 uv, vec2 res) {  
  // vec2 inverseVP = vec2(1.0 / res.x, 1.0 / res.y);
  vec2 inverseVP = vec2(1.0,1.0);

  vec3 rgbNW = texture2D(tex, uv + nw * inverseVP).xyz;
  // vec3 rgbNE = textureOffset(tex, uv + ne * inverseVP,ivec2(1,0)).xyz;
  // vec3 rgbSW = textureOffset(tex, uv + sw * inverseVP,ivec2(0,1)).xyz;
  // vec3 rgbSE = textureOffset(tex, uv + se * inverseVP,ivec2(1,1)).xyz;
  
  vec3 rgbNE = texture2D(tex, uv + ne * inverseVP).xyz;
  vec3 rgbSW = texture2D(tex, uv + sw * inverseVP).xyz;
  vec3 rgbSE = texture2D(tex, uv + se * inverseVP).xyz;
  

  vec4 texColor = texture2D(tex, uv * inverseVP);
  vec3 rgbM  = texColor.xyz;
  //---------------------------------------------------
  vec3 luma = vec3(0.299, 0.587, 0.114);
  float lumaNW = dot(rgbNW, luma);
  float lumaNE = dot(rgbNE, luma);
  float lumaSW = dot(rgbSW, luma);
  float lumaSE = dot(rgbSE, luma);
  float lumaM  = dot(rgbM,  luma);
  //----------------------------------------------------
  float luma_min = min(lumaM, min(min(lumaNW, lumaNE), min(lumaSW, lumaSE)));
  float luma_max = max(lumaM, max(max(lumaNW, lumaNE), max(lumaSW, lumaSE)));
  //---------------------------------------
  mediump vec2 dir;
  dir.x = -((lumaNW + lumaNE) - (lumaSW + lumaSE));
  dir.y =  ((lumaNW + lumaSW) - (lumaNE + lumaSE));
  //------------------------------------------
  float dirReduce = max((lumaNW + lumaNE + lumaSW + lumaSE) *
                        (0.25 * FXAA_REDUCE_MUL), FXAA_REDUCE_MIN);
  
  float rcpDirMin = 1.0 / (min(abs(dir.x), abs(dir.y)) + dirReduce);
  dir = min(vec2(FXAA_SPAN_MAX, FXAA_SPAN_MAX),
            max(vec2(-FXAA_SPAN_MAX, -FXAA_SPAN_MAX),
            dir * rcpDirMin)) * inverseVP;
  //-------------------------------------------------------
  vec3 rgbA = 0.5 * (
      texture2D(tex, uv * inverseVP + dir * (1.0 / 3.0 - 0.5)).xyz +
      texture2D(tex, uv * inverseVP + dir * (2.0 / 3.0 - 0.5)).xyz);
  vec3 rgbB = rgbA * 0.5 + 0.25 * (
      texture2D(tex, uv * inverseVP + dir * -0.5).xyz +
      texture2D(tex, uv * inverseVP + dir * 0.5).xyz);

  float lumaB = dot(rgbB, luma);
  if ((lumaB < luma_min) || (lumaB > luma_max)) {
    return vec4(rgbA, texColor.a);
  } else {
    return vec4(rgbB, texColor.a);
  } 
}


void main()  { 
  vec2 uv = set_uv(flip_source,resolution_source);
  gl_FragColor = fxaa(texture_source, uv, resolution_source);
}





