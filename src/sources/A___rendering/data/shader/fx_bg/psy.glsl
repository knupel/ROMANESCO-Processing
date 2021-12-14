/**
* PSY FRAG sinus refactoring by Stan le Punk
* 2014-2019
* v 0.0.5
* @see https://github.com/StanLepunK
* @see https://github.com/StanLepunK/Shader
* inspiration maybe sand box ?
*/

#ifdef GL_ES
precision mediump float;
#endif
#define PI 3.14159265359793

// my first raymarching \o/ - thanks to iq and his wonderful tools
uniform vec2 resolution;
uniform float time;
uniform int num;

vec3 rotateX(vec3 p, float f) { 
	return vec3(p.x, cos(f)*p.y - sin(f)*p.z, sin(f)*p.y + cos(f)*p.z); 
}

vec3 rotateY(vec3 p, float f) { 
	return vec3(cos(f)*p.x + sin(f)*p.z, p.y, cos(f)*p.z - sin(f)*p.x); 
}

vec3 rotateZ(vec3 p, float f) { 
	return vec3(cos(f)*p.x - sin(f)*p.y, sin(f)*p.x + cos(f)*p.y, p.z);
}

float round_box_ud(vec3 p, float local_time) { // ray marching objects
	vec3 b = vec3(.3);
	p = rotateZ(rotateY(rotateX(p, 0.22*local_time), 0.33*local_time), 0.11*local_time);
	return length(max(abs(p)-b,0.0))-.01;
}

void main(void) {
	vec2 q = gl_FragCoord.xy/max(resolution.x, resolution.y);
	vec2 vPos = 2.*q;
	vPos += vec2(-1., -.5);

	float time_speed = time;

	// Camera setup
	//vec3 camUp = vec3(resolution.x *mouse.x,resolution.y *mouse.y,0.);
	vec3 camUp = vec3(10., 10. ,0.);
	vec3 camlookAt = vec3(0.);
	vec3 camPos = vec3(1.);
	vec3 camDir = normalize(camlookAt - camPos);
	vec3 u = normalize(cross(camUp, camDir));
	vec3 v = cross(camDir, u);
	vec3 vcv = camPos + camDir;
	vec3 scrCoord = vPos.x*u*1. + vPos.y*v*1.;
	vec3 scp = normalize(scrCoord - camPos);

	// Raymarching
	const vec3 e = vec3(0.0005, 0.005, 0.0005);
	const float maxd = 6.;
	float d = .05;
	vec3 p;

	float f = 0.5;
	// int numLoop =  int(2) ;
	// if(timeTrack > 0.3) numLoop = 3 ; else numLoop = 2 ;
	for(int i = 0; i < num; i++) {
	    	if ((abs(d) < .04) || (f > maxd)) break;
	    	f += d;
	    	p = vec3(2.) + scp*f;
	    	d = round_box_ud(p + .01 * sin(time_speed),time_speed);
	}
  
	if (f < maxd) { // cube
		vec3 col = vec3(abs(sin(time_speed)) *.2 +.5, abs(sin(time_speed -PI /8.))*.2+.5, abs(sin(time_speed +PI /8.)) *.2 +.5);
		vec3 n = vec3(d - round_box_ud(p - e.xyy * cos(time_speed+p.y),time_speed), d - round_box_ud(p - e.yxy * cos(time-p.x),time_speed), d - round_box_ud(p - e.yyx,time_speed));
		float b = dot(normalize(n), normalize(camPos - p));
		gl_FragColor=vec4((p*-b*col + pow(b, 16.))*(1. - f*.01), 1.);
	} else { // background, thanks to: http://glsl.heroku.com/e#15441.0
		
		gl_FragColor = mix ( vec4(vec3(p*15.), 1.), vec4(0.), .5 * sin(time_speed));
	}
}
