/*
Find here the BASIC PARAMETERS slider to write your ROMANESCO OBJECT.

IMPORTANT
Use the parameters in this form to integrate easily in the Romanesco Class in the next step.
Don't change the name nameParam[IDobj], it used in the Scene and Prescene Sketch to identify the object.

color fillObj[IDobj] ; you can separate with hue(fillObj[IDobj]), saturation(fillObj[IDobj]), brightness(fillObj[IDobj]) and alpha(fillObj[IDobj])
color strokeObj[IDobj] ; you can separate with hue(strokeObj[IDobj]), saturation(strokeObj[IDobj]), brightness(strokeObj[IDobj]) and alpha(strokeObj[IDobj])
float thicknessObj[IDobj] ; value from 0.1 to height/3

this parameters is use for the object or particule size
float sizeXObj[IDobj] ; 
float sizeYObj[IDobj] ; 
float sizeZObj[IDobj] ; value from 0.1 to width


this parameter is use to space where the particule object, or the object can growth or move...
float canvasXObj[IDobj] ; 
float canvasYObj[IDobj] ; 
float canvasZObj[IDobj] value from width/10  to width

float quantityObj[IDobj] ; value from 1 to 100 ;

float speedObj[IDobj] ; value from 0 to 1
float directionObj[IDobj] ; value from 0 to 360
float angleObj[IDobj] ; value from 0 to 360
float amplitudeObj[IDobj] ; value from 0 to 1
float analyzeObj[IDobj] ; value from 0 to 1
float familyObj[IDobj] ; value from 1 to 118, it's atomic choice 118 is the last atom knew in 2006!
float lifeObj[IDobj] ; value from 0 to 1
float forceObj[IDobj] ; value from 0 to 1
*/

int widthOfYourSketch = 400 ;
int heightOfYourSketch = 400 ;
color colorBackground = 0 ;


// SETUP
void setting() {
  // write here your method who must be write in the Processing SETUP
}


// DRAW
void display() {
  // write here your method who must be write in the Processing DRAW
}


/*
FOR MOUSE, PEN, LEPMOTION, KEYBOARD and SOUND behavior read the different method in the file "CODE OBJECT.txt"
*/
