/**
Grain scatter refactoring
Stan le Punk 
@see https://github.com/StanLepunK
v 0.0.1
2018-2018
Based https://www.shadertoy.com/view/XtsBz8 by FlexMonkey
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
uniform vec2 resolution;
uniform float strenght;
uniform float time;


float noise(vec2 co) {
  vec2 seed = vec2(cos(co.x),sin(co.y));
  // return fract(sin(dot(seed ,vec2(12.9898,78.233))) * 43758.5453);
  return fract(cos(dot(seed ,vec2(12.9898,78.233))) * 43758.5453);
}

void main() {
  float value = strenght;
  // float radius = abs(25.0 * sin(value));

  vec2 offset = -value + vec2(noise(vertTexCoord.st), noise(vertTexCoord.yx)) *value;
  // vec2 offset = -radius + vec2(noise(vertTexCoord.st), noise(vertTexCoord.yx)) *radius;  
    
  //vec2 uv = (vertTexCoord.st + offset ) / resolution.xy;
  vec2 uv = vertTexCoord.st + (offset / resolution);
    
  gl_FragColor = texture(texture,uv);
}

/*
vec3 grain(vec2 uv, float offset) {
    vec4 uvs;
    uvs.xy = uv + vec2(offset);
    uvs.zw = uvs.xy + vec2(1.0 / resolution.x, 1.0 / resolution.y);

    uvs = fract(uvs * vec2(21.5932, 21.77156).xyxy);

    vec2 shift = vec2(21.5351, 14.3137);
    vec2 temp0 = uvs.xy + dot(uvs.yx, uvs.xy + shift);
    vec2 temp1 = uvs.xw + dot(uvs.wx, uvs.xw + shift);
    vec2 temp2 = uvs.zy + dot(uvs.yz, uvs.zy + shift);
    vec2 temp3 = uvs.zw + dot(uvs.wz, uvs.zw + shift);

    vec3 r = vec3(0);
    r += fract(temp0.x * temp0.y * vec3(95.4337, 96.4337, 97.4337));
    r += fract(temp1.x * temp1.y * vec3(95.4337, 96.4337, 97.4337));
    r += fract(temp2.x * temp2.y * vec3(95.4337, 96.4337, 97.4337));
    r += fract(temp3.x * temp3.y * vec3(95.4337, 96.4337, 97.4337));

    return r * 0.25;
}

void main() {
  vec2 uv = vertTexCoord.xy;
  vec3 img = texture2D(texture,uv).rgb;
  vec3 grain = grain(uv,offset).xyz;

  vec3 color = grain; // grain RVB
  if (mode == 0) {
    color = color.xxx; // black and white
  }

  color = img *color;

  gl_FragColor = vec4(color, 1.0);
}
*/





