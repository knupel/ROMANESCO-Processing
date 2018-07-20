/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2017 
* Stan le Punk > http://stanlepunk.xyz/

Shader to warp texture

warp pixel with a texture direction and velocity
v 0.0.3
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

uniform float intensity;


vec2 cartesian_coord(float angle) {
  float x = cos(angle);
  float y = sin(angle);
  return vec2(x,y);
}

float map(float value,
          float start1, float stop1,
          float start2, float stop2) {
    float outgoing = start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
    return outgoing;
  }


vec2 translate(float fdir, float fvel) {
  //float angle = mix(fdir, 0, 2*PI);
  // float angle = mix(fdir, -PI, PI);
  // float angle = map(fdir, 0, 1, -PI, PI);
 float angle = mix(-PI, PI,fdir);
  /** 
  problem on the vertical
  same result if we go down or up ??? 
  Texture direction problem ?

  mix et map, on l'air de donner le même résultat.
  */
  return cartesian_coord(angle) *fvel ;
}



void main() {
  vec2 coord_transform = gl_FragCoord.xy *wh_renderer_ratio;
  coord_transform.y = 1 -coord_transform.y;


  float velocity = texture2D(vel_texture, coord_transform).x *intensity;
  float direction = texture2D(dir_texture, coord_transform).x;
  

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

    // gl_FragColor = texture2D(texture, coord_dest);

    gl_FragColor = texture2D(texture,vec2(coord_dest.x,coord_dest_y));
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
    vec4 tex_colour = texture2D(vel_texture, vertTexCoord.st);
    gl_FragColor = tex_colour;
  }
  // direction force field
  if(mode == 501) { 
    vec4 tex_colour = texture2D(dir_texture, vertTexCoord.st);

    gl_FragColor = tex_colour;

  }
}



