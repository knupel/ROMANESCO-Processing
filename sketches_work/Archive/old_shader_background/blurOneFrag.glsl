/**
Blur one
2013-2018
v 0.0.2
*/
#ifdef GL_ES
precision mediump float;
#endif

uniform vec4 rgba; 
uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;
 
float hash( float n ){return fract( sin( n ) * 43758.5453 );}

float noise( in vec3 x ){
	vec3 p = floor( x );vec3 q = fract( x );
	q = q * q * (3.0 - 2.0 * q);
	float n = p.x + p.y * 57.0 + p.z * 113.0;
	float a = hash( n );float b = hash( n + 1.0 );float c = hash( n + 57.0 );float d = hash( n + 58.0 );
	float e = hash( n + 113.0 );float f = hash( n + 114.0 );float g = hash( n + 170.0 );float h = hash( n + 171.0 );	
	float result = mix( mix( mix( a, b, q.x ), mix( c, d, q.x ), q.y ), mix( mix( e, f, q.x ), mix( g, h, q.x ), q.y ), q.z );
	return result;
}

// rotation matrix, propotional to a right triangle, rotates octaves ~36°
const mat2 m = mat2( 0.8, 0.6, -0.6, 0.8 );

float fbm( in vec2 point )
{
	vec2 p = point;float f = 0.0;	
	//amplitude * noise( frequency )
	//f += 0.5000 * noise( vec3( p, 1.0 ) ); 
	p *= m * 2.02; // octaves...
	f += 0.2500 * noise( vec3( p, 1.0 ) ); 
	p *= m * 2.03;
	f += 0.1250 * noise( vec3( p, 1.0 ) ); p *= m * 2.01;
	f += 0.0625 * noise( vec3( p, 1.0 ) ); p *= m * 2.005;
	f += 0.03125 * noise( vec3( p, 1.0 ) ); p *= m * 2.00;
	f += 0.015625 * noise( vec3( p, 1.0 ) );
	f /= 0.984375-.5;
	return f;
}


float fbm(in float x, in float y){return fbm(vec2(x,y));}
void main( void ) {
 
	vec2 pos = ( gl_FragCoord.xy / resolution.xy );
	vec2 uv = pos;
	pos-=.5;
	pos*=2.;
	//pos.x+=mouse.y;
	vec4 col;
	
	col=vec4(rgba.x,rgba.y,rgba.z,1.)*1.;
	float f = mix(0.0,fbm(pos.x*mouse.x*5.,time*.09-pos.y/100.0),1.);
	
	f=mix(0.0,f,1.-abs(pos.y)*abs(pos.y)*abs(pos.y));
	//f=smoothstep(0.0,1.0)
	//f+=.1-abs(pos.y/10.);
	f=smoothstep(0.,1.,f);
	col*=f;
	//smoothstep(.0,1.0,f);
	
	
	
	
	col.a = 1.;
	gl_FragColor = col;
 
}