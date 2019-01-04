/**
Halftone line full refactoring
Stan le Punk 
@see https://github.com/StanLepunK
v 0.0.1
2018-2018
Based https://www.shadertoy.com/view/4dXBRf by Cacheflowe
*/

// Processing implementation
#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_TEXTURE_SHADER
uniform vec2 texOffset; // from Processing core don't to pass in sketch vector (1/width, 1/height)
varying vec4 vertColor;
varying vec4 vertTexCoord;

// sketch implementation
uniform sampler2D texture;
uniform vec2 position;
uniform vec2 resolution;
uniform float angle;
uniform float threshold;
uniform int rows;
uniform int mode;
uniform float quality;



const float PI = 3.1415926535897932384626433832795;

float rgb_to_gray(vec4 rgba) {
	const vec3 W = vec3(0.2125, 0.7154, 0.0721);
    return dot(rgba.xyz, W);
}

float average_gray(vec2 uv, float step_x, float step_y) {
	// get samples around pixel
	vec4 colors[9];
	colors[0] = texture(texture,uv + vec2(-step_x, step_y));
	colors[1] = texture(texture,uv + vec2(0, step_y));
	colors[2] = texture(texture,uv + vec2(step_x, step_y));
	colors[3] = texture(texture,uv + vec2(-step_x, 0));
	colors[4] = texture(texture,uv);
	colors[5] = texture(texture,uv + vec2(step_x, 0));
	colors[6] = texture(texture,uv + vec2(-step_x, -step_y));
	colors[7] = texture(texture,uv + vec2(0, -step_y));
	colors[8] = texture(texture,uv + vec2(step_x, -step_y));
	// sum + return averaged gray
	vec4 result = vec4(0);
	for (int i = 0; i < 9; i++) {
		result += colors[i];
	}
	return rgb_to_gray(result) / 9.0;
}

vec2 rotate_coord(vec2 uv, float rads) {
    uv *= mat2(cos(rads), sin(rads), -sin(rads), cos(rads));
	return uv;
}

void main() {
	// security exception
	float temp_quality = quality;
	int temp_row = rows;
	float temp_threshold = threshold;
	int temp_mode = mode;
	if(temp_quality < 1.) temp_quality = 1.;
	if(temp_row < 5) temp_row = 5;
	if(temp_threshold <= 0.) temp_threshold = .01;
	if(temp_mode <= 0) {
		temp_mode = 0;
	} else if(temp_mode > 7) {
		temp_mode = 7;
	}
	
  
  // current location
	vec2 uv = vertTexCoord.st;
    
  // halftone line coords
  vec2 uv_row = fract(rotate_coord(uv, angle) * temp_row);
  vec2 uv_floor_y = vec2(uv.x, floor(uv.y * temp_row) / temp_row) + vec2(0., (1.0 / temp_row) * 0.5); // add y offset to get center row color

  // get averaged gray for row
  float average_gray = average_gray(uv_floor_y,temp_quality/resolution.x,temp_quality/resolution.y);
  
  // use averaged gray to set line thickness
  vec3 color = vec3(1.);
  if(temp_mode == 1) {
  	if(uv_row.y > average_gray) color = vec3(0.0);
  } else if(mode == 2) {
  	if(distance(uv_row.y + 0.5, average_gray * 2.) < 0.2) color = vec3(0.0);
  } else if(temp_mode == 3) {
  	float dist_from_row_center = 1.0 - distance(uv_row.y, 0.5) * 2.0;
  	color = vec3(1.0 - smoothstep(average_gray - temp_threshold, average_gray + temp_threshold, dist_from_row_center));
  } else if(temp_mode == 4) {
  	vec2 uvRow2 = fract(rotate_coord(uv, -angle) * temp_row);
  	float dist_from_row_center_1 = 1.0 - distance(uv_row.y, 0.5) * 2.0;
  	float dist_from_row_center_2 = 1.0 - distance(uvRow2.y, 0.5) * 2.0;
  	float dist_from_row_center = min(dist_from_row_center_1, dist_from_row_center_2);
  	color = vec3(1.0 - smoothstep(average_gray - temp_threshold, average_gray + temp_threshold, dist_from_row_center));
  } else if(temp_mode == 5) {
  	vec2 uvRow2 = fract(rotate_coord(uv, -angle) * temp_row);
  	float dist_from_row_center_1 = 1.0 - distance(uv_row.y, 0.5) * 2.0;
  	float dist_from_row_center_2 = 1.0 - distance(uvRow2.y, 0.5) * 2.0;
  	float dist_from_row_center = mix(dist_from_row_center_1, dist_from_row_center_2, 0.5);
  	color = vec3(1.0 - smoothstep(average_gray - temp_threshold, average_gray + temp_threshold, dist_from_row_center));
  } else if(temp_mode == 6) {
  	float rot = floor(average_gray * (PI*2)) / (PI*2);
  	rot = rot * 4.;
  	vec2 uv_row = fract(rotate_coord(uv, rot) * temp_row);
  	float dist_from_row_center = 1.0 - distance(uv_row.y, 0.5) * 2.0;
  	color = vec3(1.0 - smoothstep(average_gray - temp_threshold, average_gray + temp_threshold, dist_from_row_center));
  } else if(temp_mode == 7) {
  	vec4 original_color = texture(texture, uv_floor_y);
  	float dist_from_row_center = 1.0 - distance(uv_row.y, 0.5) * 2.0;
  	float mix_val = 1.0 - smoothstep(average_gray - temp_threshold, average_gray + temp_threshold, dist_from_row_center);
  	color = mix(original_color.rgb, vec3(1.), mix_val);
  }
  // draw 
	gl_FragColor = vec4(color, 1.0);
}













