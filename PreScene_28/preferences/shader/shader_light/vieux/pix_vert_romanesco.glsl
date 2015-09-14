/*
Romanesco 27 light and shader displacement
source 
https://github.com/processing/processing/blob/master/core/src/processing/opengl/LightVert.glsl
https://processing.org/tutorials/pshader/
*/
#define PROCESSING_LIGHT_SHADER

// the number of light need to be a constant, not uniform from our sketch, because there is glitch bug
const int numLight = 8 ;

//from Processing univers
uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;

//from Processing light
uniform int lightCount;
uniform vec4 lightPosition[numLight];
// uniform vec3 lightNormal[8];



// From Romanesco
uniform vec3 canvas ;
uniform float zoom ;



vec3 colorLight[numLight] ;

// explain to the computer where or what is use by the GPU
attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;

// bridge between the vertex and fragment code GLSL
varying vec4 vertColor;
varying vec3 ecNormal;
varying vec3 lightDir[numLight];
varying vec3 ecVertex ;

// ANNEXE
/////////
vec4 canvas_4D() {
	return vec4(canvas.xyz, zoom) *vertex;
}



// MAIN
//////

void main() {
	ecVertex = vec3(modelview *vertex);  
	ecNormal = normalize(normalMatrix *normal);   
    

    // light control
	for(int i = 0 ;i < numLight ;i++) { 
		lightDir[i] = normalize(lightPosition[i].xyz - ecVertex);
	}


	// final data
	vertColor = color ;
	gl_Position = transform *canvas_4D(); 
}


