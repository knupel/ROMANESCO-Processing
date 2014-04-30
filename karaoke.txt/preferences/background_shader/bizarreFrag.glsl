#ifdef GL_ES
precision highp float;
#endif

//circle tracer
//sphinx

uniform float time;
uniform vec2 mouse; 
uniform vec2 resolution;

//circle tracer

//visualizing the effect of noise on ray marching
//sphinx

#define phi .05
#define delta .05
#define maxl 8
#define steps 8
#define rays 8

#define addnoise

struct ray{
	vec3 c;
	vec2 o, p, d, n, uv;
	float l;
	bool h;
};

struct circle{
	vec2  p;
	float r;
};
	
struct scene{
	circle c0, c1, c2, c3;	
};

ray trace(ray r, scene s);
float line(vec2 a, vec2 b, vec2 uv, float w);
vec2  derivate(vec2 p, float l, scene s);
float map(vec2 p, scene s);
float stepvis(ray r);
vec4  scenevis(scene s, vec2 uv);
float phivis(ray r, scene s);
float hash(float v);
float noise(vec2 v);
float fbm(vec2 v);

vec4 result = vec4(0.);

void main( void ) {
	float a = resolution.x / resolution.y;
	float z = 4.;
	
	vec2 uv = (gl_FragCoord.xy / resolution.xy);
	uv 		= uv * z - z * .5;
	uv.x 	*= a;

	vec2 m 	= mouse.xy-.5;
	m  	*= z;
	m.x 	*= a;
	
	vec2 o 	= vec2(-2., 0.);
	vec2 t 	= m;
	
	ray r;
	r.uv    = uv;
	r.o 	= vec2(-2., 0.);
	r.p 	= r.o;
	r.d 	= normalize(m-r.o);
	r.c 	= vec3(0.);
	r.l 	= 0.;
	r.n		= vec2(0.);
	r.h 	= true;
	
	float ts = time * .3;
	vec2 w   = vec2(cos(ts), sin(ts)+.5);

	float n = 0.;
	#ifdef addnoise
	n += fbm(uv * 2. - 1.) * 2.25;
	#endif
	
	scene s;
	s.c0.p = vec2(1.3,  -.5 + n) + w.xy;
	s.c0.r = .5;
	s.c1.p = vec2(2.4, -0.2 + n) - w.xy;
	s.c1.r = .25;
	s.c2.p = vec2(3.1,  1.3 + n) + w.xx;
	s.c2.r = .15;
	s.c3.p = vec2(3.8, -1.7 + n) - w.yy;
	s.c3.r = 1.5;
	
	result  += scenevis(s, uv) * .5;
	r.c.z 	= result.z;

	float v = 0.;
	for(int i = 0; i < rays; i++)
	{
		v 	= float(i)/float(rays);
		v 	= (v - .5) * 2.;
		r.d 	= normalize(m+vec2(m.x, v));
		r 	= trace(r, s);
		if(r.h)
		{
			result.y += line(o, r.p, uv, .005) * .5;
		}
		else
		{
			result.x += line(o, r.p, uv, .005) * .5;
		}
		r.h 	= false;
		r.p 	= r.o;
		r.l 	= 0.;
	
	}
	
	result.xyz += r.c;
	
	gl_FragColor = vec4(result);
}

ray trace(ray r, scene s){
	for(int i = 0; i < steps; i++){
		r.c.x 	+= stepvis(r) * .5;

		r.l 	= map(r.p, s);		
		r.p 	+= r.d*r.l;
		
		if(r.l < phi){
			vec2 n 	= derivate(r.p, r.l, s);			
			n.x		= length(r.p+-vec2(delta, 0.)-r.uv-r.d*r.l)-r.l;
			n.y		= length(r.p+-vec2(0., delta)-r.uv-r.d*r.l)-r.l;
			n		= 1.-smoothstep(-n+.01, vec2(0.01), n);	

			r.n 	= n;
			r.c.x   += n.x;
			r.c.y   += n.y;
			r.c 	+= line(r.p, r.p+r.n*.2, r.uv, .005) * abs(vec3(r.n, 0.));	
			r.h 	= true;
			break;
		}
	}
	
	return r;
}

float map(vec2 p, scene s){
	float r;

	r = 999.;
	r = length(p - s.c0.p) - s.c0.r;
	r = min(r, length(p - s.c1.p) - s.c1.r);
	r = min(r, length(p - s.c2.p) - s.c2.r);
	r = min(r, length(p - s.c3.p) - s.c3.r);
	
	
	return r;
}

vec2 derivate(vec2 p, float l, scene s){
	vec2 d 	= vec2(delta, 0.);
	vec2 n 	= vec2(0.);
	n.x 	= map(p+d.xy,s)-map(p-d.xy,s);
	n.y 	= map(p+d.yx,s)-map(p-d.yx,s);	
	return normalize(n);
}

	
float stepvis(ray r){
	float p	= (1.-smoothstep(0., 0.01, length(r.uv-r.p)-.025))*.5;
	float l	= length(r.p-r.uv-r.d*r.l)-r.l;
	l		= 1.-smoothstep(-l+.01, 0.01, l);	
	return l + p;
}

vec4 scenevis(scene s, vec2 uv){
	vec4 r = vec4(0.);
	
	float l0 = length(uv-s.c0.p)-s.c0.r;
	float l1 = length(uv-s.c1.p)-s.c1.r;
	float l2 = length(uv-s.c2.p)-s.c2.r;
	float l3 = length(uv-s.c3.p)-s.c3.r;
	
	r.z = clamp(1.-abs(l0*l1*l2*l3), 0., 1.);
	
	float f = l0;
	f = min(f, l1);	
	f = min(f, l2);
	f = min(f, l3);

	r.z = 1.-abs(f)*.5;
	
	r 	+= step(f, 0.);
	r.y += step(f, phi) * .5;
	
	return max(vec4(0.), r);
}

float phivis(ray r, scene s){
	float l	= length(r.uv-map(r.p, s))-phi;
	l 		= 1.-smoothstep(-l+.01, 0.01, l);
	
	return max(0., l);
}	

float line(vec2 a, vec2 b, vec2 uv, float s)
{
	vec2 v 	= a - b;
	vec2 w 	= uv - b;
	float l = dot(w,v) / dot(v,v);
	
	v 		*= clamp(l, 0.0, 1.0);
	return smoothstep(s, 0., distance(w,v));
}

	
float hash(float v)
{
    return fract(sin(v)*43758.5453123);
}

float noise(vec2 v)
{
    vec2 p = floor(v);
    vec2 f = fract(v);
    f = f*f*(3.0-2.0*f);
    float n = p.x + p.y*57.0;
    p.x = mix(hash(n+ 0.), hash(n+  1.), f.x);
    p.y = mix(hash(n+57.), hash(n+ 58.), f.x);
    float res = mix(p.x, p.y, f.y);
    return res;
}


float fbm(vec2 uv)
{
    float n = 0.;
    uv += 32.;
    n += noise(uv)*.5;
    n += noise(uv*1.5) *.25;
    n += noise(uv*3.)  *.15;
    n += noise(uv*6.)  *.075;
    n += noise(uv*12.) *.0325;
    n += noise(uv*24.) *.015125;
    return n;
}