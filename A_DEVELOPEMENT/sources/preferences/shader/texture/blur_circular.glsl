/**
blur circular
Stan le punk version
@see https://github.com/StanLepunK
v 0.0.2
2018-2018
refactoring from project
https://github.com/spite/Wagner/tree/master/fragment-shaders
*/

#ifdef GL_ES
precision highp float;
#endif
// Processing implementation
#define PROCESSING_TEXTURE_SHADER
uniform vec2 texOffset; // The inverse of the texture dimensions along X and Y
varying vec4 vertColor;
varying vec4 vertTexCoord;

#define PI 3.1415926535897932384626433832795


uniform sampler2D texture;

uniform vec2 resolution;
uniform float strength;
uniform int mode;

// varying vec2 vUv; > vertTexCoord

/*
float nrand( vec2 n ) {
	return fract(sin(dot(n.xy, vec2(12.9898, 78.233)))* 43758.5453);
}
*/
float random(vec2 seed){
	return fract(sin(dot(seed.xy ,vec2(12.9898,78.233))) * 43758.5453);
}


vec2 rot2d( vec2 p, float a) {
	vec2 sc = vec2(sin(a),cos(a));
	return vec2(dot(p,vec2(sc.y,-sc.x)),dot(p,sc.xy));
}

void main() {
	vec2 uv = gl_FragCoord.xy / resolution.xy;

	const int NUM_SAMPLES = 16;
	const int NUM_SAMPLES_HALF = NUM_SAMPLES/2;
	const float NUM_SAMPLES_F = float(NUM_SAMPLES);
	const float step_angle = 6.28 / NUM_SAMPLES_F;
	const float MIPBIAS = -8.0; //note: make sure we always pick mip0
	// const float MIPBIAS = -1.0; //note: make sure we always pick mip0


	//note: rand
	float render;
	if(mode == 0) {
		render = random(.01*gl_FragCoord.xy);//+ fract(iGlobalTime) );
	} else if(mode == 1) {
		render = texture2D(texture, gl_FragCoord.xy / 8.0 ).r;
	}

	//note: create halfcircle of offsets
	float max_ofs = strength;
	vec2 ofs[NUM_SAMPLES];
	float angle = PI*render;
	for(int i = 0; i < NUM_SAMPLES_HALF ; i++) {
		ofs[i] = rot2d(vec2(max_ofs,0), angle ) / resolution.xy;
		angle += step_angle;
	}

	
	vec4 sum = vec4(0);
	//note: sample positive half-circle
	for(int i = 0 ; i < NUM_SAMPLES_HALF ;i++)
		sum += texture2D(texture,vec2(uv.x,uv.y)+ofs[i],MIPBIAS);

	//note: sample negative half-circle
	for( int i=0;i<NUM_SAMPLES_HALF;++i )
		sum += texture2D(texture,vec2(uv.x, uv.y)-ofs[i],MIPBIAS);

	gl_FragColor.rgb = sum.rgb / NUM_SAMPLES_F;
	gl_FragColor.a = texture2D(texture,vertTexCoord.xy).a;
}


















