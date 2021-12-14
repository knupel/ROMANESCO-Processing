/**
* voronoi three P
* @see https://www.interactiveshaderformat.com/sketches/3454
* @see https://www.shadertoy.com/view/4tsXRH
* @see https://www.shadertoy.com/view/4lBSzW
* 2019-2019
* v 0.0.2
* mode 0 is from  // by mojo Video Tech on adapation of Mackycheese https://www.interactiveshaderformat.com/sketches/3454
* mode 1 is from 	// by mackycheese21 https://www.shadertoy.com/view/4lBSzW
*/
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 resolution;

uniform vec3 rgb; 
uniform float size; // from 1 to 10++
uniform float speed_mutation; // from 0 to 1
uniform float speed_colour; // from 0 to 1
//uniform vec4 rgba;

uniform float time;

uniform int mode;
uniform float strength; // from -0.05 to 0.05
uniform float threshold; // from 0.1 to 0.3

// uniform int color_mode; // 0 is RGB / 3 is HSB

// uniform int num;
// uniform ivec3 size;

// uniform float angle;

// uniform float quality;
// uniform vec2 offset;
// uniform float scale;

// uniform int rows;
// uniform int cols;

// uniform bool use_fx_color;
// uniform bool use_fx;


#define TAU 6.283185307
#define PI 3.141592653
#define	PI_TWELFTH 0.26179938779915


#define SEED_A 435.56
#define SEED_B 12.56
#define SEED_C 262144.03


vec2 hash22(vec2 p) { 
	float n = sin(dot(p,vec2(1, 113))); 
	p = fract(vec2(8.*n, n)*262144.);
	return sin(p *TAU + time *speed_mutation);
	/*
	float n = sin(dot(p,vec2(SEED_A,SEED_B))); 
	p *= fract(vec2(PI *n, n) *SEED_C);
	vec2 e = fract(sin(p) *43758.5453);
	return sin(e *TAU +time *speed);
	*/
}





float voronoi_hex(vec2 p){
	vec2 s = floor(p +(p.x +p.y) *.3660254);
	p -= s -(s.x + s.y)*.2113249;
	float i = p.x<p.y? 0. : 1.;
	float g = .125 -strength;
	// Vectors to the other two triangle vertices.
	vec2 p1 = p - vec2(i, 1. -i) +.2113249, p2 = p -.5773502;
	// Add some random gradient offsets to the three vectors above.
	p += hash22(s) *g;
	p1 += hash22(s + vec2(i, 1. -i)) *g;
	p2 += hash22(s +1.) *g;
	// Determine the minimum Euclidean distance. You could try other distance metrics, 
	float d = min(min(dot(p,p),dot(p1,p1)),dot(p2,p2)) /.425;
	return sqrt(d);
}





vec4 mode_0() {
	vec3 rgb_primary = rgb;
	vec3 rgb_secondary = vec3(1) -rgb_primary;	
	vec2 pos = (gl_FragCoord.xy -resolution.xy *.5) /resolution.y;
	vec2 uv = pos * mat2(cos(PI_TWELFTH), sin(PI_TWELFTH), -sin(PI_TWELFTH), cos(PI_TWELFTH)) *(11.25 -size);

	float c = voronoi_hex(uv *5.);
	float c2 = voronoi_hex(uv *5. -size /resolution.y);
	vec2 r = normalize(hash22(pos));

	float pattern = cos(PI *r.x) *sin(r.y *PI) *.125 +.125;

	vec4 col_1 = vec4(0.,0.,0.,1.);
	float final_size = 20. - size;
	col_1.rgb = mix(vec3(c *1.3, c *c, pow(c,final_size)), rgb_primary, pattern);

	vec3 col2 = mix(rgb_secondary, vec3(c *1.3, c *c, pow(c,final_size)), pattern);
	float colour_time = cos(time) *speed_colour;
	col_1.rgb = mix(col_1.rgb, col2, smoothstep(.2, .8, sin(colour_time +1. /length(r.xy)) *.333 -speed_colour));
	// col_1.rgb = mix(col_1.rgb, col2, smoothstep(.2, .8, sin(colour_time +1. /length(r.xy)) *.333 -speed_colour));  
	col_1.rgb += rgb_primary *(c2 *c2 *c2 -c *c *c) *5.;
	col_1.rgb -= (length(hash22(uv +colour_time)) *.06 -.03) *rgb_secondary;
  
	return sqrt(max(col_1, 0.0)-0.2+threshold);
}



vec4 mode_1() {
	vec2 pos = (gl_FragCoord.xy -resolution.xy *.5) /resolution.y;
	vec2 uv = pos * mat2(cos(PI_TWELFTH), sin(PI_TWELFTH), -sin(PI_TWELFTH), cos(PI_TWELFTH)) *(11.25 -size);
	// vec2 uv = (gl_FragCoord.xy - resolution*.5)/resolution.y;

	float c = voronoi_hex(uv *5.);
	float c2 = voronoi_hex(uv *5. -size /resolution.y);

	// Coloring the cell.
	float pattern = cos(uv.x *.75 *PI - .9) *cos(uv.y *1.5 *PI -.75)*.5 +.5;

	// Color 
	float final_size = 20. - size;
	vec3 col_1 = mix(vec3(c *1.3, c *c, pow(c,final_size)), vec3(c *c *.8, c, c *c *.35), pattern);

	vec3 col_2 = mix(vec3(c *1.2, pow(c, 8.), c *c), vec3(c *1.3, c *c, pow(c,final_size)), pattern);

	// Alternating between the two color schemes.
	col_1 = mix(col_1, col_2, smoothstep(.4, .6, sin(time *speed_colour *.01)*.5 +.5)); // 

	// Highlighting colour
	col_1 += vec3(.5, .8, 1)*(c2*c2*c2 - c*c*c)*5.;

	// Speckles.
	// Adding subtle speckling to break things up and give it a less plastic feel.
	col_1 += (length(hash22(uv +time))*.06 - .03)*vec3(1, .5, 0);

	// Vignette.
	uv = gl_FragCoord.xy /resolution;
	col_1 *= smoothstep(0., .5, pow(16. *uv.x *uv.y *(1. -uv.x)*(1. -uv.y), .25)) *vec3(1.1,1.07,1.01);
  vec4 result = vec4(sqrt(max(col_1, 0.)), 1);
	return result;
}

void main() {
	if(mode == 0) {
		gl_FragColor = mode_0();
	} else {
		gl_FragColor = mode_1();
	}
}






