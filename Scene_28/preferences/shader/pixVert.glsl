/*
Romanesco 27 light and shader displacement
source 
https://github.com/processing/processing/blob/master/core/src/processing/opengl/LightVert.glsl
https://processing.org/tutorials/pshader/
*/
#define PROCESSING_LIGHT_SHADER

// the number of light need to be a constant, not uniform from our sketch, because there is glitch bug
const int numLight = 8 ;
const float zero_float = 0.0;
const float one_float = 1.0;

//from Processing univers
uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;

//from Processing light
uniform int lightCount;
uniform vec4 lightPosition[numLight];
uniform vec3 lightNormal[numLight];



// From Romanesco
uniform vec3 canvas ;
uniform float zoom ;



vec3 colorLight[numLight] ;

// explain to the computer where or what is use by the GPU
attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;

attribute vec4 ambient_occlusion;
attribute float shininess;
attribute vec4 emissive;
attribute vec4 ambient;
attribute vec4 specular;



// bridge between the vertex and fragment code GLSL
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

// ANNEXE
/////////
vec4 canvas() {
	return vec4(canvas.xyz, zoom) *vertex;
}



// MAIN
//////

void main() {
	ecVertex = vec3(modelview *vertex);  
	ecNormal = normalize(normalMatrix *normal);   
    

    // light control
	for(int i = 0 ;i < numLight ;i++) {
		// we calculate the normal position in the vertex to have dynamic position for the lights
		lightDir[i] = -one_float *lightNormal[i] ;
		lightDir[i] *= normalize(lightPosition[i].xyz - ecVertex) ;
	}


	// final data
	vertColor = color ;
	ambient_occlusion_frag = ambient_occlusion.w;
	shininess_frag = shininess;
    emissive_frag = emissive ;
	ambient_frag = ambient ;
	specular_frag = specular ;
	gl_Position = transform *canvas(); 
}


