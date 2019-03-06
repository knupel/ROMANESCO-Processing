/**
* Dither Bayer 8
* @see http://stanlepunk.xyz
* @see https://github.com/StanLepunK/Shader
* inspired by Mattias 
* @see https://www.shadertoy.com/view/4dS3D1
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

// Rope Shader FX implementation
uniform sampler2D texture_source;
uniform vec2 resolution_source;
uniform bvec2 flip_source; // can be use to flip texture source

uniform vec3 level_source;
uniform int mode; // 0 is RGB / 3 is HSB




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


const mat4 bayer_tl = mat4( 
 0.0/64.0, 32.0/64.0,  8.0/64.0, 40.0/64.0,
48.0/64.0, 16.0/64.0, 56.0/64.0, 24.0/64.0,
12.0/64.0, 44.0/64.0,  4.0/64.0, 36.0/64.0,
60.0/64.0, 28.0/64.0, 52.0/64.0, 20.0/64.0
);

const mat4 bayer_br = mat4( 
 1.0/64.0, 33.0/64.0,  9.0/64.0, 41.0/64.0,
49.0/64.0, 17.0/64.0, 57.0/64.0, 25.0/64.0,
13.0/64.0, 45.0/64.0,  5.0/64.0, 37.0/64.0,
61.0/64.0, 29.0/64.0, 53.0/64.0, 21.0/64.0
);

const mat4 bayer_tr = mat4( 
 2.0/64.0, 34.0/64.0, 10.0/64.0, 42.0/64.0,
50.0/64.0, 18.0/64.0, 58.0/64.0, 26.0/64.0,
14.0/64.0, 46.0/64.0,  6.0/64.0, 38.0/64.0,
62.0/64.0, 30.0/64.0, 54.0/64.0, 22.0/64.0
);

const mat4 bayer_bl = mat4( 
 3.0/64.0, 35.0/64.0, 11.0/64.0, 43.0/64.0,
51.0/64.0, 19.0/64.0, 59.0/64.0, 27.0/64.0,
15.0/64.0, 47.0/64.0,  7.0/64.0, 39.0/64.0,
63.0/64.0, 31.0/64.0, 55.0/64.0, 23.0/64.0
);
  


float dither(mat4 m, ivec2 p) {
  if(p.y == 0) {
    if(p.x == 0) return m[0][0];
    else if(p.x == 1) return m[1][0];
    else if(p.x == 2) return m[2][0];
    else return m[3][0];  
  } else if(p.y == 1) {
    if(p.x == 0) return m[0][1];
    else if(p.x == 1) return m[1][1];
    else if(p.x == 2) return m[2][1];
    else return m[3][1];  
  } else if(p.y == 2) {
    if(p.x == 0) return m[0][1];
    else if(p.x == 1) return m[1][2];
    else if(p.x == 2) return m[2][2];
    else return m[3][2];  
  } else {
    if(p.x == 0) return m[0][3];
    else if(p.x == 1) return m[1][3];
    else if(p.x == 2) return m[2][3];
    else return m[3][3];  
  } 
}

float get_brightness(vec3 color) {
  return (0.2126*color.r + 0.7152*color.g + 0.0722*color.b);
}

void main() {
  vec2 uv = set_uv(flip_source,resolution_source);
  // return 4x4
  ivec2 p = ivec2(mod(uv *resolution,8.0));
  vec3 colour = texture2D(texture_source,uv).xyz;

  if(mode == 0) {
    colour = vec3(get_brightness(colour));
  }

  if(colour.x < level_source.x) {
    colour.x = 0;
  }

  if(colour.y < level_source.y) {
    colour.y = 0;
  }

  if(colour.y < level_source.y) {
    colour.y = 0;
  }
  // don't understand this two lines
  colour = pow(colour,vec3(2.2));  
  colour -= 1.0/255.0; // ? why 255 the colour is not from 0 to 1 ???
  
  vec3 d = vec3(0);
  if(p.x <= 3 && p.y <= 3) {
    d.r = float(colour.r > dither(bayer_tl,p));
    d.g = float(colour.g > dither(bayer_tl,p));
    d.b = float(colour.b > dither(bayer_tl,p));
  } else if (p.x > 3 && p.y <= 3) {
    d.r = float(colour.r > dither(bayer_tr,p -ivec2(4,0)));
    d.g = float(colour.g > dither(bayer_tr,p -ivec2(4,0)));
    d.b = float(colour.b > dither(bayer_tr,p -ivec2(4,0)));
  } else if(p.x <= 3 && p.y > 3) {
    d.r = float(colour.r > dither(bayer_bl,p-ivec2(0,4)));
    d.g = float(colour.g > dither(bayer_bl,p-ivec2(0,4)));
    d.b = float(colour.b > dither(bayer_bl,p-ivec2(0,4)));
  } else if (p.x > 3 && p.y > 3) {
    d.r = float(colour.r > dither(bayer_br,p -ivec2(4,4)));
    d.g = float(colour.g > dither(bayer_br,p -ivec2(4,4)));
    d.b = float(colour.b > dither(bayer_br,p -ivec2(4,4)));
  }
  // 1 it's white
  // 0 it's black

  gl_FragColor = vec4(d,1.0);
}





