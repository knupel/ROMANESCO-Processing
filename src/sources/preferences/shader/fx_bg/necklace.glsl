/**
* NECKLACE refactoring by Stan le Punk
* v 0.1.0
* 2014-2019
* @see https://github.com/StanLepunK
* @see https://github.com/StanLepunK/Shader
* original shader Sandox
*/
#ifdef GL_ES
precision lowp float;
#endif


uniform vec2 resolution;

uniform float time;
uniform vec2 position;
uniform vec2 size;
uniform float alpha;
uniform int num;
uniform float speed;


#define PI 3.14159265359793
/*
#define M  0.9
#define D  0.6
*/

#define M  1.5
#define D  1.5



void main(){

	vec2 new_pos = vec2(position.x, 1.0 -position.y);

	vec2 pos = (gl_FragCoord.xy -new_pos.xy *resolution) / min(resolution.x, resolution.y) + vec2(.5,.5);

	vec2 t = vec2(gl_FragCoord.xy /resolution);

	vec3 c = vec3(0);
	float y = 0.;
	float x = 0.;

	int pearl = num;
	if(pearl < 5) pearl = 5;

	float size_x = M *size.x;
	float size_y = D *size.y;
  
  float speed_time = time*speed;



	for(int i = 0; i < pearl ; i++) {
		float t = 1.9 *PI *float(i *8) /50. *speed_time *.5;
		x = size_x *cos(t+x+y);
		y = size_y *sin(t+y+x);
		// vec2 pearl_position = 0.3 *vec2(x, y);
		vec2 pearl_position = vec2(x,y);
		float r = fract(y+x);
		float g = 1. - r;
		c += 0.0015 / (length(pos - pearl_position)) *vec3(r, g, x+y);
	}

	gl_FragColor = vec4(c,alpha);
}