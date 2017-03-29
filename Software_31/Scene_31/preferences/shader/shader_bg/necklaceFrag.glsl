/*
From Sand Box
Stan le Punk modification 2014
*/
#ifdef GL_ES
precision lowp float;
#endif


uniform vec4 colorBG ;
uniform vec2 mouse;
uniform vec2 resolution;

uniform float time;
// #define PI 3.1414159265359
#define PI 3.14159265359793
#define M  0.9
#define D  0.6


void main(){

	vec2 newMouse = vec2(mouse.x, 1.0 -mouse.y) ;

	vec2 p = (gl_FragCoord.xy -newMouse.xy *resolution) / min(resolution.x, resolution.y);
	vec2 t = vec2(gl_FragCoord.xy /resolution);

	vec3 c = vec3(0);
	float y=0.;
	float x=0.;

	int maxRound = int(colorBG.z *700.) ;
	if(maxRound < 10) maxRound = 10 ;

	for(int i = 0; i < maxRound ; i++) {
		float t = 1.9 *PI *float(i *8) /50. *time *.5;
		x = D *cos(t+x+y);
		y = M *sin(t+y+x);
		vec2 o = 0.3 *vec2(x, y);
		float r = fract(y+x);
		float g = 1. - r;
		c += 0.0015 / (length(p-o)) *vec3(r, g, x+y);
	}

	gl_FragColor = vec4(c, colorBG.w);
}