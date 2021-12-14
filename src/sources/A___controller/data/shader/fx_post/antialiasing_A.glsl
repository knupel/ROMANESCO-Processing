/**
* Antialiasing block POST FX
* @see @stanlepunk
* @see https://github.com/StanLepunK/Shader
* v 0.0.1
* 2018-2019
*/




// from https://www.shadertoy.com/view/ltfXWS PERMUTATOR
/* There are a few shaders on this site already that attempt to do this (most notably
 * <https://www.shadertoy.com/view/ldlSzS>), but none of them were quite what I wanted,
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
uniform vec4 level_source;

// uniform sampler2D texture_layer;
// uniform vec2 resolution_layer;
// uniform ivec2 flip_layer; // can be use to flip texture layer
// uniform vec4 level_layer;

// uniform vec2 position; // maneep to receive a normal information 0 > 1

// uniform float time;


// 0: antialiased blocky interpolation
// 1: linear interpolation
// 2: aliased blocky interpolation
uniform int mode;

// uniform int color_mode; // 0 is RGB / 3 is HSB

// uniform int num;
// uniform ivec3 size;
// uniform float strength;

// uniform float angle;
// uniform float threshold;
// uniform float quality;
// uniform vec2 offset;
// uniform float scale;

// uniform int rows;
// uniform int cols;x

// uniform bool use_fx_color;
// uniform bool use_fx;



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







// basically calculates the lengths of (a.x, b.x) and (a.y, b.y) at the same time
vec2 v2len(in vec2 a, in vec2 b) {
    return sqrt(a*a+b*b);
}


// samples from a linearly-interpolated texture to produce an appearance similar to
// nearest-neighbor interpolation, but with resolution-dependent antialiasing
// 
// this function's interface is exactly the same as texture's, aside from the 'res'
// parameter, which represents the resolution of the texture 'tex'.
vec4 textureBlocky(in sampler2D tex, in vec2 uv, in vec2 res) {
    uv *= res; // enter texel coordinate space.
    
    
    vec2 seam = floor(uv+.5); // find the nearest seam between texels.
    
    // here's where the magic happens. scale up the distance to the seam so that all
    // interpolation happens in a one-pixel-wide space.
    uv = (uv-seam)/v2len(dFdx(uv),dFdy(uv))+seam;
    
    uv = clamp(uv, seam-.5, seam+.5); // clamp to the center of a texel.
    
    
    return texture(tex, uv/res, -1000.).xxxx; // convert back to 0..1 coordinate space.
}



// simulates nearest-neighbor interpolation on a linearly-interpolated texture
// 
// this function's interface is exactly the same as textureBlocky's.
vec4 textureUgly(in sampler2D tex, in vec2 uv, in vec2 res) {
    return textureLod(tex, (floor(uv*res)+.5)/res, 0.0).xxxx;
}



void main() {
    vec2 uv = set_uv(flip_source,resolution_source);
    // vec2 uv = (fragCoord.xy * 2. - iResolution.xy) / min(iResolution.x, iResolution.y);
    float theta = iTime / 12.;
    vec2 trig = vec2(sin(theta), cos(theta));
    uv *= mat2(trig.y, -trig.x, trig.x, trig.y) / 8.;
    
    #if mode == 0
    gl_FragColor = textureBlocky(texture_source, uv, resolution_source);
    #elif mode == 1
    gl_FragColor = texture(texture_source, uv);
    #elif mode == 2
    gl_FragColor = textureUgly(texture_source, uv, resolution_source);
    #endif
}
