/**
* Derivative POST FX
* @see @stanlepunk
* @see https://github.com/StanLepunK/Shader
* v 0.0.1
* 2019-2019
*/




/**
* https://www.shadertoy.com/view/Msl3RH
* Abusing the derivative functions of GLSL to do dirty 
* emboss/bump/cartoon shading. Typically you want 
*to use these functions for antialiasing procedural patterns 
* by taking derivatives of the domain of your procedural function and removing detail.
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

uniform float time;


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




void main() {
  vec2 uv = set_uv(flip_source,resolution_source);
  uv.y = 1.0 - uv.y;
  // vec2 uv = fragCoord.xy / iResolution.xy;
  
  vec3  col = texture2D(texture_source, vec2(uv.x,1.0-uv.y) ).xyz;
  float lum = dot(col,vec3(0.333));
  vec3 ocol = col;
  
  if( uv.x>0.5 )
  {
    // right side: changes in luminance
        float f = fwidth( lum );
        col *= 1.5*vec3( clamp(1.0-8.0*f,0.0,1.0) );
  }
    else
  {
    // bottom left: emboss
        vec3  nor = normalize( vec3( dFdx(lum), 64.0/resolution_source.x, dFdy(lum) ) );
    if( uv.y<0.5 )
    {
      float lig = 0.5 + dot(nor,vec3(0.7,0.2,-0.7));
            col = vec3(lig);
    }
    // top left: bump
        else
    {
            float lig = clamp( 0.5 + 1.5*dot(nor,vec3(0.7,0.2,-0.7)), 0.0, 1.0 );
            col *= vec3(lig);
    }
  }

    col *= smoothstep( 0.003, 0.004, abs(uv.x-0.5) );
  col *= 1.0 - (1.0-smoothstep( 0.007, 0.008, abs(uv.y-0.5) ))*(1.0-smoothstep(0.49,0.5,uv.x));
    col = mix( col, ocol, pow( 0.5 + 0.5*sin(time), 4.0 ) );
  
  gl_FragColor = vec4( col, 1.0 );
}