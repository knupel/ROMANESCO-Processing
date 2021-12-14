/**
* Palette shader
* 2021-2021
* v 0.0.3
* @author @stanlepunk
* @see https://github.com/StanLepunK/Rope
*/

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 resolution;

uniform float hue = -1.0;
uniform vec2 range;
uniform float min_hue = 0.0;
uniform float max_hue = 1.0;

uniform float start_sat = 0.5;
uniform float min_sat = 0.0;
uniform float max_sat = 1.0;

uniform float start_bri = 0.5;
uniform float min_bri = 0.0;
uniform float max_bri = 1.0;
uniform int mode = 0;
uniform bool vert_is = false;

/**
* @see https://thebookofshaders.com/05/?lan=fr
* Function from Iñigo Quiles
* @see https://www.shadertoy.com/view/MsS3Wc
*/
vec3 hsb_to_rgb(vec3 c){
	vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
	rgb = rgb*rgb*(3.0-2.0*rgb);
	return c.z * mix( vec3(1.0), rgb, c.y);
}

float map(float value, float min_0, float max_0, float min_1, float max_1) {
  return min_1 + (max_1 - min_1) * (value - min_0) / (max_0 - min_0);
}

void main(void) {
	vec2 uv = gl_FragCoord.xy/resolution.xy;
	vec3 color = vec3(hue,1.0,1.0);
	float val = uv.x;
	if(vert_is) {
		 val = uv.y;
	}
	vec3 color_sat;
	vec3 color_bri;
	vec3 color_hue;
	if(hue == -1.0) {
		val = map(val, 0, 1.0, min_hue, max_hue);
		color = hsb_to_rgb(vec3(val,1.0,1.0));
	} else {
		float sat = 1.0;
		float bri = 1.0;

		if(val < start_bri) bri = map(val, 
																	0, start_bri,
																	min_bri, max_bri);		
		if(val > start_sat) sat = map(val,
																	start_sat, 1.0, 
																	max_sat, min_sat);


		color = hsb_to_rgb(vec3(hue,sat,bri)); // from white to color to black
		
	}
	gl_FragColor = vec4(color, 1.0); // ok
}


