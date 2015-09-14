/*
Romanesco 27 light and shader displacement
source 
https://github.com/processing/processing/blob/master/core/src/processing/opengl/LightVert.glsl
https://processing.org/tutorials/pshader/
*/
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

// the number of light need to be a constant, not uniform from your sketch because there is glitch bug
const int numLight = 8;
const float zero_float = 0.0;
const float one_float = 1.0;

// From Processing
uniform vec3 lightNormal[numLight];
uniform vec4 lightPosition[numLight];
// ambient
uniform vec3 lightAmbient[numLight];
// diffuse is the color element of the light
uniform vec3 lightDiffuse[numLight];
// spot light
uniform vec2 lightSpot[numLight];


// From Romanesco
uniform vec3 colorVertex ;
uniform float alphaVertex ;



varying vec4 vertColor;
varying vec3 ecNormal;
varying vec3 lightDir[numLight];
varying vec3 ecVertex ;

// ANNEXE
/////////

// LIGHT
float spotFactor(vec3 lightPos, vec3 vertPos, vec3 lightNorm, float minCos, float spotExp) {
  vec3 lpv = normalize(lightPos - vertPos);
  vec3 nln = -one_float * lightNorm;
  float spotCos = dot(nln, lpv);
  return spotCos <= minCos ? zero_float : pow(spotCos, spotExp);
}


// COLOR SHAPE
vec4 colorShape() {
	return vec4(colorVertex.xyz, alphaVertex);
}

vec4 ambient(vec3 lightAmb) {
	vec3 tempAmbient = lightAmb ;
	return vec4(tempAmbient, 1);
}






// MAIN
///////

void main() {
	vec4 final_color ;
    
    // spot light
	float spotf;

    // loop for the light
	for(int i = 0 ; i <  numLight ; i++) {
	  vec3 direction = normalize(lightDir[i]);
	  vec3 normal = normalize(ecNormal);

	  // spot light
	  float spotCos = lightSpot[i].x;
	  float spotExp = lightSpot[i].y;
	  vec3 lightPos = lightPosition[i].xyz;
	  spotf = spotExp > zero_float ? spotFactor(lightPos, ecVertex, lightNormal[i], spotCos, spotExp) : one_float;

	  // we code the color in the frag, to separate the color, because if we do that in the vert. The result is an average of the color.
      float intensity = max(0.0, dot(direction, normal));
	  vec3 colorTemp = vec3(lightDiffuse[i].r *intensity, 
	  						lightDiffuse[i].g *intensity, 
	  						lightDiffuse[i].b *intensity) ;
	  final_color += vec4(lightAmbient[i], 1.) +
	  				 vec4(colorTemp, 1.) *spotf  ;
	}

	gl_FragColor = final_color *vertColor *colorShape() ;
}