/**
Based on rdex project
Copyright (C) 2008,2009 Claude Heiland-Allen <claudiusmaximus@goto10.org>
Stan le punk version
@see https://github.com/StanLepunK
v 0.0.1
2018-2018
*/
#ifdef GL_ES
precision highp float;
#endif
// Processing implementation
#define PROCESSING_TEXTURE_SHADER
uniform vec2 texOffset; // from Processing core don't to pass in sketch vector (1/width, 1/height)
varying vec4 vertColor;
varying vec4 vertTexCoord;


uniform sampler2D texture; // U := r, V := g, other channels ignored

uniform vec3 mat_col_0;
uniform vec3 mat_col_1;
uniform vec3 mat_col_2;


vec3 c[3];

void main(void) {
  // check the case where there is no unirform value pass to shader
  bvec3 is_0 = equal(mat_col_0,vec3(0));
  bvec3 is_1 = equal(mat_col_1,vec3(0));
  bvec3 is_2 = equal(mat_col_2,vec3(0));
  if(all(is_0)) {
    c[0] = vec3(1.0,1.407,0.0); // default value conversion
  } else {
    c[0] = vec3(mat_col_0);
  }

  if(all(is_1)) {
    c[1] = vec3(1.0,-0.677,-0.236); // default value conversion
  } else {
    c[1] = vec3(mat_col_1);
  }

  if(all(is_2)) {
    c[2] = vec3(1.0,0.0,1.848); // default value conversion
  } else {
    c[2] = vec3(mat_col_2);
  }
  
  // LC1C2 Matrix conversion to RGB
  mat3 lcc2rgb = mat3(c[0],c[1],c[2]);

  vec2 p = vertTexCoord.st; // texel coordinates
  vec2 q = texture2D(texture,p).rg; // texel value

  float u = 1.0 - q.r; // reflect in U = 0.5
  float v = q.g;

  float h = 16.0*atan(v,u); // hue   <= angle
  float l = clamp(cos(16.0*(v*v + u*u)),.0,1.); // light <= distance
  vec3 lcc = vec3(l, 0.5*cos(h), 0.5*sin(h)); // LC1C2 colour
  gl_FragColor = vec4(lcc * lcc2rgb, 1.0); // RGB colour
}



