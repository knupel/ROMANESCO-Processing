/**
* Neon sinus refactoring by Stan le Punk
* 2014-2019
* v 0.0.2
* @see https://github.com/StanLepunK
* @see https://github.com/StanLepunK/Shader
* inspiration maybe sand box ?
*/
#ifdef GL_ES
precision mediump float;
#endif

// uniform float varOne;
uniform float time;
uniform vec2 position;
uniform vec2 resolution;



void main() {
	// for a fullscreen
	float mouseXnorm = (position.x / gl_FragCoord.x) ;
	vec2 p = ( gl_FragCoord.xy / resolution.xy ) -(1.0 -position.y);
     
	float sx = 0.2 * (p.x + 0.5) * sin( 25.0 * p.x - 10. * time);
	
	float dy = 1./ ( 50. * abs(p.y - sx));
	
	dy += 1./ (20. * length(p - vec2(p.x, 0.)));
	
	gl_FragColor = vec4( (p.x + 0.5) * dy, 0.5 * dy, dy, 1.0 );
}