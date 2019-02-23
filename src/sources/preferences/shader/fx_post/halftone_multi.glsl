/**
* Multi haltone 
* refactoring by Stan le Punk
* original by VIDVOX
* @see https://www.interactiveshaderformat.com/sketches/3719
* v 0.0.1
* 2019-2019

* @see http://stanlepunk.xyz
* @see https://github.com/StanLepunK/Shader
*/
// Processing implementation
#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_TEXTURE_SHADER
varying vec4 vertColor;
varying vec4 vertTexCoord;
uniform vec2 resolution;
// Rope implementation
uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform bvec2 flip_source;


/** 
processing part
*/
uniform vec2 position; 
uniform float saturation;
uniform float angle;
uniform float scale;
uniform float divs;
uniform float sharpness;
uniform int mode;

const float TAU = 6.28318530718;

vec3 rgb2hsv(vec3 c)  {
  vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
  // vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
  // vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
  vec4 p = c.g < c.b ? vec4(c.bg, K.wz) : vec4(c.gb, K.xy);
  vec4 q = c.r < p.x ? vec4(p.xyw, c.r) : vec4(c.r, p.yzx);
  
  float d = q.x - min(q.w, q.y);
  float e = 1.0e-10;
  return vec3(abs(q.z +(q.w -q.y) /(6. *d +e)), d /(q.x +e), q.x);
}

vec3 hsv2rgb(vec3 c)  {
  vec4 K = vec4(1., 2. /3., 1. /3., 3.);
  vec3 p = abs(fract(c.xxx +K.xyz) *6. -K.www);
  return c.z * mix(K.xxx, clamp(p -K.xxx, 0., 1.), c.y);
}

float halftone_dot(vec2 uv, vec2 res, float ang, float sca, vec2 cent) {
  float s = sin(ang *TAU), c = cos(ang *TAU);
  vec2 tex = uv *res -cent *res;
  vec2 point = vec2(c *tex.x -s *tex.y, s *tex.x +c *tex.y) *max(sca,.001);
  return (sin(point.x) *sin( point.y)) *4.;
}

float halftone_circle(vec2 uv, vec2 res, float ang, float sca, vec2 cent) {
  float s = 0.;
  float c = 1.;
  vec2 tex = uv *res;
  vec2 point = vec2(c *tex.x -s *tex.y, s *tex.x +c *tex.y);
  float d = distance(point,cent *res) *max(sca,.001);
  return (sin(d +ang *TAU) ) *4.;
}

float halftone_line(vec2 uv, vec2 res, float ang, float sca, vec2 cent) {
  float s = sin(TAU *ang *.5);
  float c = cos(TAU *ang *.5);
  vec2 tex = uv * res;
  vec2 point = vec2( c *tex.x -s *tex.y, s *tex.x + c *tex.y ) * max(sca,.001);
  float d = point.y;

  return ( cent.x +sin(d +cent.y * TAU)) *4.;
}


vec2 left_coord(vec2 texc, vec2 d) {
  return clamp(vec2(texc.xy + vec2(-d.x,0)),0.,1.);
}

vec2 right_coord(vec2 texc, vec2 d) {
  return clamp(vec2(texc.xy + vec2(d.x,0)),0.,1.);
}

vec2 above_coord(vec2 texc, vec2 d) {
  return clamp(vec2(texc.xy + vec2(0,d.y)),0.,1.);
}

vec2 below_coord(vec2 texc, vec2 d) {
  return clamp(vec2(texc.xy + vec2(0,-d.y)),0.,1.);
}

vec2 left_a_coord(vec2 texc, vec2 d) {
  return clamp(vec2(texc.xy + vec2(-d.x,d.x)),0.,1.);
}

vec2 right_a_coord(vec2 texc, vec2 d) {
  return clamp(vec2(texc.xy + vec2(d.x,d.x)),0.,1.);
}

vec2 left_b_coord(vec2 texc, vec2 d) {
  return clamp(vec2(texc.xy + vec2(-d.x,-d.x)),0.,1.);
}

vec2 right_b_coord(vec2 texc, vec2 d) {
  return clamp(vec2(texc.xy + vec2(d.x,-d.x)),0.,1.);
}


float rand(vec2 co){
  return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}



void main() {
  vec2 uv = vertTexCoord.st;
  vec4 color = texture2D(texture_source,uv);
  vec2 d = 1.0/resolution;
  vec4 colorL = texture2D(texture_source,left_coord(uv,d));
  vec4 colorR = texture2D(texture_source,right_coord(uv,d));
  vec4 colorA = texture2D(texture_source,above_coord(uv,d));
  vec4 colorB = texture2D(texture_source,below_coord(uv,d));

  vec4 colorLA = texture2D(texture_source,left_a_coord(uv,d));
  vec4 colorRA = texture2D(texture_source,right_a_coord(uv,d));
  vec4 colorLB = texture2D(texture_source,left_b_coord(uv,d));
  vec4 colorRB = texture2D(texture_source,right_b_coord(uv,d));


  vec4 final = color + sharpness * (8.*color -colorL -colorR -colorA -colorB -colorLA -colorRA -colorLB -colorRB);
  vec3 hsv = rgb2hsv(final.rgb);
  float ang = floor(hsv.r * divs +.5) / divs;
  float sca = floor(hsv.b * divs +.5) / divs;
  float col = max(min(saturation + floor(hsv.g *divs +.5) /divs,1.),0.);;
  
  float average = (final.r +final.g + final.b) / 3.0;

  // random selection for the case 0, the choice depend of the stuff under the pixel... that's huge
  int pattern_type = mode;
  if (pattern_type == 0) {
    pattern_type = int(2.9999 * rand(vec2(ang,sca)))+1;
  }

  float final_angle = angle +ang;
  float final_scale = scale *sca;
  vec2 pos = vec2(position.x, 1-position.y);

  if (pattern_type == 1) {
    final = vec4( vec3(average *10. -5. +halftone_dot(uv,resolution,final_angle,final_scale,pos)),color.a);
  } else if (pattern_type == 2)  {
    final = vec4( vec3(average *10. -5. +halftone_circle(uv,resolution,final_angle,final_scale,pos)),color.a);
  } else if (pattern_type == 3)  {
    final = vec4( vec3(average *10. -5. +halftone_line(uv,resolution,final_angle,final_scale,pos)),color.a);
  }

  gl_FragColor = mix(color*final,final,1.-col);
}