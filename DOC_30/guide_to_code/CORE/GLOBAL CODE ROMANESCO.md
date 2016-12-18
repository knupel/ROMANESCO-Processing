
January 2014 / Romanesco 26
---------------------------
---------------------------


The main sketch is the Prescene, it receive slider information from Contrôleur, mouse, leapmotion, midi-controller, pen apply this one
and send a major part of the result to Scene or Miroir, who're just a slave !


CODE for THE CORE CODER

Be careful is not finish and totaly imcomplete !

Three main sketches :
Controleur, Prescene, and Scene.

The controler is a specific sketch, 
but the prescene, scene and mirroir are very similare.

The main sketch is the Prescene, the Scene and Mirroir is a replic of this one.

The Controller send information to the Prescene about the different instruction that prescene must be execute, 
the Prescene execute all the instruction, and add few instructions like the mouse position, sound effect...
then send all informations to the Scene or the Mirroir for the final work.

Between the Prescene, Scene there are a commom tabs :
Object, Camera, SuperRomanesco




/////////////////////////
// COTROLLER FUNCTION //
///////////////////////

boolean dropdownActivity ; // use to indicate to indicate at the other button, they cannot be used when the user are on the dropdown menu


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////
// PRESENE /// SCENE //
//////////////////////



// PRESCENE CODE
//to opening app
boolean openScene = true ;
boolean openMiroir = true ;
boolean openControleur = true ;

//send the information to the final app : Scene or Miroir
boolean youCanSendToScene = true ;
boolean youCanSendToMiroir = true ;




//SAVE and SETTING Camera and Object orientation and position

whichSetting is 0
afor Romanesco alpha 25 there is only one save setting is 0
for more setting change int numSettingCamera and int numSettingOrientationObject in the void createVarP3D() in the tab Variable_Common


PVector P3DpositionSetting [whichSetting][ID_item] ;
PVector P3DdirectionSetting [whichSetting][ID_item] ;

PVector eyeCameraSetting[whichSetting] ;
PVector sceneCameraSetting[whichSetting] ;








// GLOBAL CODE
//////////////


///////////////////////////////
boolean testRomanesco = false ;
///////////////////////////////
Give the permit to work directly with sketch, without the launcher...
\\\\\\\\\\\\\\\\\\\\\\\\\\
this true by default when you code, don't forget change to false when you ** EXPORT ** your app, 
if you don't do that, the Prescene will not open the Scene.



boolean fullRendering = false ;
This boolean is use to indicate if the object or other algorithm must work at full capacity or not.
Use this one for the rendering Prescene, like a preview to preserve the processor from the big calcul, like shader background or other objects with a lot of particuls.




////////////////////////////
// WHERE are Romanesco work
// if you want use a different rendering on the scene or prescene, you can use this boolean.
indicate if your work on scene or prescene
boolean scene 
boolean prescene





//
boolean internet // say if internet is available



















////////// UTIL /////////////////
////////////////////////////////



// ALGEBRA
/////////////

// CONSTANT MATH
final float PHI = (1 + sqrt(5))/2; // the golden ratio
final float ROOT2 = sqrt(2); // the number of Pythagore
final float EULER = 2.718281828459045235360287471352; // Constant d'auler

// METHOD
float distance(PVector p0, PVector p1 ) calcul distance between two PVectors

float deg360 (PVector dir) // return a 360 direction from PVector direction value between -1 to 1 ;

PVector rotation(PVector ref, PVector lattice, float angle) // return a PVector position, for rotation around an axes

float roots(float valueToRoots, int n) // return the roots value with "n" dimension

float mapLocked(float value, float sourceMin, float sourceMax, float targetMin, float targetMax) // the return value is lock between the min and the max

float mapStartSmooth(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) // the begin of the curve is smoothed by the level

float mapEndSmooth(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) // the end of the curve is smoothed by the level

float mapEndStartSmooth(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) // the begin and the end of the curve is smoothed by the level


// END ALGEBRA
//////////////









// GEOMETRY
///////////

// PRIMITIVE 2D
void primitive(int x, int y, int radius, int summits)
-- create polygone 2D, choice the quantity of summits and the radius.


void triangle(int x1, int y1, int z1, int x2, int y2, int z2, int x3, int y3, int z3)
-- triangle vertex


// PRIMITIVE 3D
-- Polyhedron primitive 3D
  /*
  -- to choice the polyhedron String whichPolyhedron
  "TETRAHEDRON","CUBE", "OCTOHEDRON", "DODECAHEDRON","ICOSAHEDRON","CUBOCTAHEDRON","ICOSI DODECAHEDRON",
  "TRUNCATED CUBE","TRUNCATED OCTAHEDRON","TRUNCATED DODECAHEDRON","TRUNCATED ICOSAHEDRON","TRUNCATED CUBOCTAHEDRON","RHOMBIC CUBOCTAHEDRON",
  "RHOMBIC DODECAHEDRON","RHOMBIC TRIACONTAHEDRON","RHOMBIC COSI DODECAHEDRON SMALL","RHOMBIC COSI DODECAHEDRON GREAT"

  -- to choice the display mode String whichStyleToDraw
  All Polyhedrons can use "POINT" and "LINE" display mode.
  except the "TETRADRON" who can also use "VERTEX" display mode.

  -- to choice the diameter int size
  */
void polyhedron(String whichPolyhedron, String whichStyleToDraw, int size)

// END GEOMETRY
//////////////




////////
// MISC


// PVECTOR
PVector gotoTarget(PVector origin,  PVector finish, float speed) // nice for a static travel when the start and the arrival is knew, work with XYZ

PVector follow(PVector target, float speed) // go to follow something in move like a cursor, works with XYZ


PVector [] circle (PVector pos, int d, int num) // return a list of points xyz to realize a circle, the first param is the position of circle, the second is the diameter, the third is the num of points to do this circle
PVector [] circle (PVector pos, int d, int num, float jitter) // same function with jitter variation

PVector pointOnCirlcle(int r, float angle) // return the position of the point on the perimeter of the circle. The first param is the radius, the second is the angle in radian (PI scale)

float perimeterCircle (int r) return perimeter

float radiusSurface(int surface) return the radius with a speficic surface

float angle(PVector p0, PVector p1) calcul the angle between two PVectors

PVector normalDir(int direction) // return a direction between -1 / 1 from 360° direction






// TIME
///////
float cycle(float add) // return value between -1 et 1 , nice to try with value like 0.1

int timer(float tempo) // return an add value from float <1 ;

int minClock() // return the time of the day in minutes





// COLOR
////////
PVector HSBtoRGB(float hue, float saturation, float brightness) convert color in the HSB world








//CLASS PIXEL
/////////////

//PARAM
this class is define by a lot of parameter and work in HSB, 360,100,100,100
PVector size (x,y,z)
PVector pos (x,y,z)

color colour, newColour ;

PVector wind I must define ?
float field : define the field of life (action) of the pixel, it use like a radius around the origin of the pixel
float life = 1 ; 
float timePast = 0.01 ; // this value is use to remove time from the life.

// parameter use to find the pixel in the mess
PVector gridPos(x,y) in matrix 2D // this value is use to find a specific pixel in the array
int rank
int ID

CONSTRUCTOR
Pixel(PVector pos)
Pixel(PVector pos, color colour)
Pixel(PVector pos, PVector size)
Pixel(PVector pos, PVector size, color colour)
// INK CONTRUCTOR
Pixel(PVector pos, float field, float timePast, color colour)
Pixel(PVector pos, float field, float timePast) 
// RANK CONSTRUCTOR
Pixel(int rank, PVector gridPos) // this one is use to rank the pixel in the array
Pixel(int rank)




// METHOD
// must define what the role
void displayPixel(int diam) 
void displayPixel(int diam, PVector effectColor)

// UPDATE
void drying(float var)

// END CLASS PIXEL
//////////////////




// CLASS CANVAS
///////////////
PARAM
PVector size (x,y,z)
PVector pos (x,y,z)
// X coord
float left, right ;
// Y coord
float top, bottom ;
// Z coord
float front, back ;

// CONSTRUTOR
Canvas(PVector pos, PVector size)

// METHOD
void update() use to change the size

void canvasLine() use to display the canvas in line mode



// END CLASS CANVAS
///////////////////












//KEYBOARD BOOLEAN command
//ATTENTION////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Don't use DELETE and the letter 'i' and 's' from the keyboard this touch is use for the main CODE for empty  all the list, display information and save picture
//ATTENTION////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//// Dedicaced and reserved key ////
///////////////////////
// P3D move
boolean cLongTouch //  use to move the camera in P3D world with the mouse function
boolean vLongTouch // use to move the object in P3D world with the mouse function
//ADD objects
boolean nTouch, nLongTouch // ADD OBJECT use this keyboard touch it's suggestion for sure !

// generaric keyborad command, it's better to don't use for others commands
boolean spaceTouch      // give the boolean condition of the space touch to active the XY mouse, pen and Leap coordinate

// backspace and delete it's better to use resetAction(ID) or resetParameter(ID)
boolean backspaceTouch  // generaly to empty a specific list of object or to reset object
boolean deleteTouch  //  specific to empty list or reset object or to reset object

boolean nTouch 			- generaly use to add a new particule like a clic depends what you want
boolean nLongTouch		- generaly use to add a new particule like a clic depends what you want
boolean mTouch		- boolean motion[ID_item] 	- generaly use to move the object, close to spaceTouch but different.
boolean oTouch 			- genrally open folder to choice a file for a specific object
boolean pTouch 			- to open an other folder, if the object already use "oTouch"
boolean hTouch 		- boolean horizon[ID_item] 	- generaly use to change the ground position for the P3D object, for example test it on the Boxolyzer object.
boolean rTouch 			- generaly use to reverse value, or to change the canvas size of object.
boolean xTouch 			- generaly use to change the colour palette

// Free touch
boolean aTouch, bTouch, cTouch, dTouch, eTouch, fTouch, gTouch,  jTouch, kTouch, lTouch, qTouch, tTouch, uTouch, vTouch, wTouch, yTouch, zTouch,
leftTouch, rightTouch, upTouch, downTouch, 
touch0, touch1, touch2, touch3, touch4, touch5, touch6, touch7, touch8, touch9, 
enterTouch, returnTouch, shiftTouch, altTouch, escTouch ;

//END of KEYBOARD
/////////////////














// TEXT
///////

loadText(ID_item) use to load and update the text

String textImport[ID_item] raw text selected from the folder preferences/Karaoke

textPath[whichText] ; text from the dropdown menu

int numChapters(String textImport[ID_item]) give the number of the chapter of your raw text

int numMaxSentencesByChapter(String textImport[ID_item]) give the number of sentences of the chapter have the most sentences

String whichSentence(String txt, int whichChapter, int whichSentence) return String

Romanesco call fileText.txt from the folder Karaoke from the preferences folder,
so you can write on it when you use Romanesco split function
"*" to separate the chapter 
"/" to separate the sentence





** When you code take a care to save the karaoke.txt in each folder of dev (Scene, Prescene, Mirroir) **

// END TEXT
///////////










//SECURITY LAG
///////////////
int levelSecurity = 200 ; is not finish, this value can be use to block the function, this value must be control from the Controler
////////////////////////








///////////////////////
// DISPLAY MODE render
Usualy Romanesco work in P3D mode, if one of the object is in P3D mode all the rendering is in P3D


for P3D 
if (displayMode.equals("P3D") ) {}
or
boolean modeP3D

for P2D
if (displayMode.equals("P2D") ) {}

for OPENGL
if (displayMode.equals("OPENGL") ) {}

for CLASSIC rendering
if (displayMode.equals("Classic") ) {}

//END DISPLAY MODE
//////////////////

























