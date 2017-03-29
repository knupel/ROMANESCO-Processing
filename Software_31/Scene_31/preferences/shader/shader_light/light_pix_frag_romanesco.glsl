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
const vec3 zero_vec3 = vec3(0);

// From Processing
uniform vec3 lightNormal[numLight];
uniform vec4 lightPosition[numLight];
// ambient and color element of the light
uniform vec3 lightAmbient[numLight];
// color element of the light
uniform vec3 lightDiffuse[numLight];
uniform vec3 lightSpecular[numLight];  
// spot light
uniform vec2 lightSpot[numLight];


// From Romanesco
uniform vec3 colorVertex ;
uniform float alphaVertex ;



varying vec4 vertColor;
varying vec3 ecNormal;
varying vec3 lightDir[numLight];
varying vec3 ecVertex ;
// tranfert attribute from vert to frag
varying float ambient_occlusion_frag;
varying float shininess_frag;
varying vec4 emissive_frag;
varying vec4 ambient_frag;
varying vec4 specular_frag;



// local parameter
// direction
vec3 lightDirTemp, lightPos ;
// special
float falloff ;
float spotf;
// color param
vec3 colorDiffuse, colorSpecular ; 
vec3 totalAmbient, totalFrontDiffuse, totalBackDiffuse, totalFrontSpecular, totalBackSpecular ;




// ANNEXE
/////////

// LIGHT
float spotFactor(vec3 lightPos, vec3 vertPos, vec3 lightNorm, float minCos, float spotExp) {
  vec3 lpv = normalize(lightPos - vertPos);
  vec3 nln = -one_float * lightNorm;
  float spotCos = dot(nln, lpv);
  return spotCos <= minCos ? zero_float : pow(spotCos, spotExp);
}

float lambertFactor(vec3 lightDir, vec3 vecNormal) {
  return max(zero_float, dot(lightDir, vecNormal));
}

float blinnPhongFactor(vec3 lightDir, vec3 vertPos, vec3 vecNormal, float shine) {
  vec3 np = normalize(vertPos);
  vec3 ldp = normalize(lightDir - np);
  return pow(max(zero_float, dot(ldp, vecNormal)), shine);
}

// COLOR SHAPE
vec4 colorShape() {
	return vec4(colorVertex.xyz, alphaVertex);
}

vec4 ambient(vec3 lightAmb) {
	vec3 tempAmbient = lightAmb ;
	return vec4(tempAmbient, 1);
}

void colorIntensity(int whichOne) {
	vec3 direction = normalize(lightDir[whichOne]);
	vec3 normal = normalize(ecNormal);
	// we code the color in the frag, to separate the color, because if we do that in the vert. The result is an average of the color.
	float intensity = max(0.0, dot(direction, normal));
	// color diffuse
	colorDiffuse = vec3(lightDiffuse[whichOne].r *intensity, 
						lightDiffuse[whichOne].g *intensity, 
						lightDiffuse[whichOne].b *intensity) ;
	 // color specular
	colorSpecular = vec3(lightSpecular[whichOne].r *intensity, 
	  					lightSpecular[whichOne].g *intensity, 
	  					lightSpecular[whichOne].b *intensity) ;

}

void any_greaterThan(int whichOne) {
	if (any(greaterThan(lightAmbient[whichOne], zero_vec3))) {
	  	totalAmbient       += lightAmbient[whichOne] *falloff;
	}

	if (any(greaterThan(lightDiffuse[whichOne], zero_vec3))) {
		totalFrontDiffuse  += colorDiffuse *falloff *spotf *lambertFactor(lightDir[whichOne], ecNormal);
    }
      
    if (any(greaterThan(lightSpecular[whichOne], zero_vec3))) {
      	totalFrontSpecular += colorSpecular * falloff * spotf *blinnPhongFactor(lightDir[whichOne], ecVertex, ecNormal, shininess_frag);
    } 

}





// MAIN
///////

void main() {
	vec4 final_color ;

	// temporary data must be change in the future
	falloff = 1. ;


	// Light calculations for the sub total, musbe re-init after each loop
  	totalAmbient = vec3(0,0,0);
  	//diffuse
  	totalFrontDiffuse = vec3(0,0,0);
  	totalBackDiffuse = vec3(0,0,0);
  	//speculare
    totalFrontSpecular = vec3(0,0,0);
    totalBackSpecular = vec3(0,0,0);
    


    // loop for the light
	for(int i = 0 ; i <  numLight ; i++) {
		lightPos = lightPosition[i].xyz;

		// spot light
		float spotCos = lightSpot[i].x;
		float spotExp = lightSpot[i].y;
		spotf = spotExp > zero_float ? spotFactor(lightPos, ecVertex, lightNormal[i], spotCos, spotExp) : one_float;

		colorIntensity(i) ;

	  	// subtotal
	  	any_greaterThan(i) ;

	  	// total color
	  	/*
	  	final_color += vec4(totalAmbient, 0) * ambient_frag + 
	  				vec4(totalFrontDiffuse, 1.)  *vertColor + 
	  				vec4(totalFrontSpecular, 0)  *specular_frag ;
	  	*/
	}
		  	final_color += vec4(totalAmbient, 1.)  + 
	  				vec4(totalFrontDiffuse, 1.)   + 
	  				vec4(totalFrontSpecular, 1)   ;

    
    gl_FragColor = final_color *vertColor *colorShape()  ;
	// gl_FragColor = final_color *vertColor *colorShape() *ambient_occlusion_frag ;
}