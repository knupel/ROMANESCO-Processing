/*
From Sand Box
Stan le Punk modification 
v 0.0.2
2014-2018
*/
#ifdef GL_ES
precision lowp float;
#endif


uniform vec4 colorBG;
uniform vec2 mouse;
uniform vec2 resolution;
uniform float quantity;

uniform float time;
uniform float speed;
uniform float size;
#define PI 3.14159265359793
/*
#define M  0.9
#define D  0.6
*/

#define M  1.5
#define D  1.5



void main(){

	vec2 newMouse = vec2(mouse.x, 1.0 -mouse.y) ;

	vec2 p = (gl_FragCoord.xy -newMouse.xy *resolution) / min(resolution.x, resolution.y);
	vec2 t = vec2(gl_FragCoord.xy /resolution);

	vec3 c = vec3(0);
	float y = 0.;
	float x = 0.;

	int maxRound = int(quantity *200.) ;
	if(maxRound < 5) maxRound = 5;

	float size_x = M *size;
	float size_y = D *size;
  
  float speed_time = time*speed;
	for(int i = 0; i < maxRound ; i++) {
		float t = 1.9 *PI *float(i *8) /50. *speed_time *.5;
		x = size_x *cos(t+x+y);
		y = size_y *sin(t+y+x);
		vec2 o = 0.3 *vec2(x, y);
		float r = fract(y+x);
		float g = 1. - r;
		c += 0.0015 / (length(p-o)) *vec3(r, g, x+y);
	}

	gl_FragColor = vec4(c, colorBG.w);
}