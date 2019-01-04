/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2017 
* Stan le Punk > http://stanlepunk.xyz/

Shader to warp texture

warp pixel with a texture direction and velocity
v 0.0.2
*/
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

#define PI 3.1415926535897932384626433832795

varying vec4 vertTexCoord;
uniform sampler2D texture;

uniform int mode;

uniform sampler2D vel_texture;
uniform sampler2D dir_texture;

uniform vec2 wh_grid_ratio;
uniform vec2 wh_renderer_ratio;

vec2 cartesian_coord(float angle) {
  float x = cos(angle);
  float y = sin(angle);
  return vec2(x,y);
}


vec2 translate(float fdir, float fvel) {
  float angle = mix(fdir, 0, 2*PI);
  return cartesian_coord(angle) *fvel ;
}



void main() {
  vec2 coord = gl_FragCoord.xy *wh_renderer_ratio;
  coord.y = 1 -coord.y;

  vec4 vel = texture2D(vel_texture, coord);
  vec4 dir = texture2D(dir_texture, coord);

  float direction = dir.x;
  float velocity = vel.x;
  vec2 translation = translate(direction,velocity);
  
  // mode 0 perfect
  // mode 1 interesting
  // mode 2 bizarre, but fun

  // mode 500 warp image direction
  // mode 501 warp image velocity

  // perfect
  if(mode == 0) {
    vec2 scale = gl_FragCoord.xy *wh_renderer_ratio; 
    vec2 coord_dest = vertTexCoord.st +translation /scale;
    float coord_dest_y = mix(coord_dest.y, vertTexCoord.t, 0);
    // float coord_dest_y = mix(coord_dest.y, 0, vertTexCoord.t);
    
    // gl_FragColor = texture2D(texture, vec2(coord_dest.x, coord_dest_y));
    gl_FragColor = texture2D(texture, coord_dest);
  }

   // interesting
  if(mode == 1) {
    vec2 scale = gl_FragCoord.xy *wh_grid_ratio;
    vec2 coord_dest = vertTexCoord.st +translation /scale ;
    gl_FragColor = texture2D(texture, coord_dest);
  }
  
  // bizarre
  if(mode == 2) {
    vec2 coord_dest = vertTexCoord.st +translation /wh_grid_ratio;
    gl_FragColor = texture2D(texture, coord_dest);
  }


  // velocity
  if(mode == 500 ) {
    vec4 tex_colour = texture2D(vel_texture, vertTexCoord.st);;
    gl_FragColor = tex_colour;
  }
  // direction force field
  if(mode == 501) {
    vec4 tex_colour = texture2D(dir_texture, vertTexCoord.st);;
    gl_FragColor = tex_colour;

  }
}



