/**
* Based on a Gray Scott Frag shader from rdex-fluxus
* @see https://code.google.com/p/rdex-fluxus/source/browse/trunk/reactiondiffusion.frag
$ @see https://groups.csail.mit.edu/mac/projects/amorphous/GrayScott/
* @see https://en.wikipedia.org/wiki/Reaction%E2%80%93diffusion_system
* Copyright (C) 2008,2009  Claude Heiland-Allen <claudiusmaximus@goto10.org>
* Stan le punk version
* @see https://github.com/StanLepunK
* v 0.0.4
* 2018-2019
*/
// Processing implementation
#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_TEXTURE_SHADER
// uniform vec2 texOffset; // from Processing core don't to pass in sketch vector (1/width, 1/height)
varying vec4 vertColor;
varying vec4 vertTexCoord;

// sketch implementation
#define KERNEL_SIZE 9

float kernel [KERNEL_SIZE];
vec2 offset [KERNEL_SIZE];

uniform sampler2D texture_layer;  // U := r, V := g, other channels ignored
uniform sampler2D texture_source;

uniform vec2 resolution;
uniform vec2 resolution_source;
uniform vec2 resolution_layer;
uniform bvec2 flip_source; // can be use to flip texture
uniform bvec2 flip_layer; // can be use to flip texture

uniform float ru;          // rate of diffusion of U
uniform float rv;          // rate of diffusion of V

uniform float k;           // another coupling parameter
uniform float f;           // some coupling parameter


/*
uniform float red;
uniform float green;
uniform float blue;
*/
uniform vec2 scale;

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



float norm(float src, float value) {
	float result = src + value;
	if(result > 1) result = result - 1;
	else if(result < 0) result = 1 + result;

	if(result > 1) result = 1;
	else if(result < 0) result = 0;
	return result;
}

void main() {
	vec2 uv_source	= set_uv(flip_source,resolution_source); // center coordinates
	vec2 uv_layer	= set_uv(flip_layer,resolution_layer); // center coordinates
  
  vec2 tex_offset = vec2(1) / resolution;
  float w = tex_offset.s; // horizontal distance between texels
	float h = tex_offset.t; 

	// vertical distance between texels
	kernel[0] = 0.707106781;
	kernel[1] = 1.0;
	kernel[2] = 0.707106781;
	kernel[3] = 1.0;
	kernel[4] =-6.82842712;
	kernel[5] = 1.0;
	kernel[6] = 0.707106781;
	kernel[7] = 1.0;
	kernel[8] = 0.707106781;

	offset[0] = vec2( -w, -h);
	offset[1] = vec2(0.0, -h);
	offset[2] = vec2(  w, -h);
	
	offset[3] = vec2( -w, 0.0);
	offset[4] = vec2(0.0, 0.0);
	offset[5] = vec2(  w, 0.0);

	offset[6] = vec2( -w, h);
	offset[7] = vec2(0.0, h);
	offset[8] = vec2(  w, h);

	vec2 colour_source = texture2D(texture_source,vec2(uv_source.s,1. -uv_source.t)).rg; // flip vertically to compensate for OpenGL's coordinate system
	vec2 colour_layer = texture2D(texture_layer,uv_source).rb; // red and green channel

	vec2 sum = vec2(0);
	// Loop through the neighbouring pixels and compute Laplacian
	for( int i = 0 ; i < KERNEL_SIZE; i++) {
		vec2 tmp = texture2D(texture_layer,uv_layer +offset[i]).rb;
		sum += tmp * kernel[i];
	}
	
	// Flavour the two coupling parameters with a hint of the seed image
	float F = f + colour_source.x *.025 -.0005;
	float K	= k + colour_source.y *.025 -.0005;

  // Get the u (red channel) and v (green channel) values from the previous pass (blue and alpha channels are ignored)
	float u = colour_layer.x;
	float v = colour_layer.y;

	float uvv = u * v * v;

	// Gray-Scott equation
	float du = ru * sum.r - uvv + F * (1. - u);
	// diffusion+-reaction
	float dv = rv * sum.g + uvv - (F + K) * v;

  // semi-arbitrary scaling (reduces blow-ups?)
	u += du *scale.x; 
	v += dv *scale.y;
  
	float r = clamp(u,.0,1.); 
	float g = 1.0 - u/v; //  ???
	float b = clamp(v,.0,1.); 
	float a = 1.;

	gl_FragColor = vec4(r,g,b,a); // output new (U,V)
}


	



	/*
  // KERNEL 9
  kernel[0] = 0.707106781;
	kernel[1] = 1.0;
	kernel[2] = 0.707106781;
	kernel[3] = 1.0;
	kernel[4] =-6.82842712;
	kernel[5] = 1.0;
	kernel[6] = 0.707106781;
	kernel[7] = 1.0;
	kernel[8] = 0.707106781;
	
	offset[0] = vec2( -w, -h);
	offset[1] = vec2(0.0, -h);
	offset[2] = vec2(  w, -h);
	
	offset[3] = vec2( -w, 0.0);
	offset[4] = vec2(0.0, 0.0);
	offset[5] = vec2(  w, 0.0);
	offset[6] = vec2( -w, h);
	offset[7] = vec2(0.0, h);
	offset[8] = vec2(  w, h);
  // KERNEL 25
  float w2		= w*2.0;
	float h2		= h*2.0;
	kernel[0]  = 1.0/331.0;
	kernel[1]  = 4.0/331.0;
	kernel[2]  = 7.0/331.0;
	kernel[3]  = 4.0/331.0;
	kernel[4]  = 1.0/331.0;
	kernel[5]  = 4.0/331.0;
	kernel[6]  = 20.0/331.0;
	kernel[7]  = 33.0/331.0;
	kernel[8]  = 20.0/331.0;
	kernel[9]  = 4.0/331.0;
	kernel[10] = 7.0/331.0;
	kernel[11] = 33.0/331.0;
	kernel[12] = -55.0/331.0;
	kernel[13] = 33.0/331.0;
	kernel[14] = 7.0/331.0;
	kernel[15] = 4.0/331.0;
	kernel[16] = 20.0/331.0;
	kernel[17] = 33.0/331.0;
	kernel[18] = 20.0/331.0;
	kernel[19] = 4.0/331.0;
	kernel[20] = 1.0/331.0;
	kernel[21] = 4.0/331.0;
	kernel[22] = 7.0/331.0;
	kernel[23] = 4.0/331.0;
	kernel[24] = 1.0/331.0;
	
	offset[0]  = vec2(-w2, -h2);
	offset[1]  = vec2( -w, -h2);
	offset[2]  = vec2(0.0, -h2);
	offset[3]  = vec2(  w, -h2);
	offset[4]  = vec2( w2, -h2);
	
	offset[5]  = vec2(-w2, -h);
	offset[6]  = vec2( -w, -h);
	offset[7]  = vec2(0.0, -h);
	offset[8]  = vec2(  w, -h);
	offset[9]  = vec2( w2, -h);
	
	offset[10] = vec2(-w2, 0.0);
	offset[11] = vec2( -w, 0.0);
	offset[12] = vec2(0.0, 0.0);
	offset[13] = vec2(  w, 0.0);
	offset[14] = vec2( w2, 0.0);
	offset[15] = vec2(-w2, h);
	offset[16] = vec2( -w, h);
	offset[17] = vec2(0.0, h);
	offset[18] = vec2(  w, h);
	offset[19] = vec2( w2, h);
	
	offset[20] = vec2(-w2, h2);
	offset[21] = vec2( -w, h2);
	offset[22] = vec2(0.0, h2);
	offset[23] = vec2(  w, h2);
	offset[24] = vec2( w2, h2);
	*/





