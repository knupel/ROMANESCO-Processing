/**
template fx background
2019-2019
v 0.0.2
*/
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 resolution;

uniform vec3 rgb; 
uniform vec4 rgba;


// uniform vec2 position; // mapped or not that's a question?
// uniform float time;

// uniform int mode;

// uniform int color_mode; // 0 is RGB / 3 is HSB

// uniform int num;
// uniform ivec3 size;
// uniform float strength;
// uniform float speed;

// uniform float angle;
// uniform float threshold;
// uniform float quality;
// uniform vec2 offset;

// uniform int rows;
// uniform int cols;

// uniform bool use_fx_color;
// uniform bool use_fx;




void main() {
	// gl_FragColor = vec4(.5,.5,.5,1);
	gl_FragColor = vec4(rgb.x,rgb.y,rgb.z,1);
}