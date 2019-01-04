/**
Stan le punk version
@see https://github.com/StanLepunK
v 0.0.1
2018-2018
based on work of Raphaël de Courville 
@see https://github.com/SableRaf/Filters4Processing
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
uniform sampler2D texture_pattern;

uniform vec2 resolution;
uniform vec2 resolution_pattern;




void main() {
		
	vec2 uv = gl_FragCoord.xy / resolution;
	uv.y = uv.y;
	
	vec3 sourcePixel = texture2D(texture, uv).rgb;
	float grayscale = length(sourcePixel*vec3(0.2126,0.7152,0.0722));
	
	// vec3 ditherPixel = texture2D(texture_pattern, vec2(mod(gl_FragCoord.xy/vec2(8.0,8.0),1.0))).xyz;
	vec3 ditherPixel = texture2D(texture_pattern, vec2(mod(gl_FragCoord.xy/resolution_pattern,1.0))).xyz;
	float ditherGrayscale = (ditherPixel.x + ditherPixel.y + ditherPixel.z) / 3.0;
	ditherGrayscale -= 0.5;
	
	float ditheredResult = grayscale + ditherGrayscale;
	
	float bit = ditheredResult >= 0.5 ? 1.0 : 0.0;
	gl_FragColor = vec4(bit,bit,bit,1);
}