
SCENE
--



Font
--
The font use are 'ttf' or 'otf' format
int numFont = 50 ;
String [] path_font_library, path_font_item ;

PFont [] font_library, font_item ;

There is default font, for the library like geomerative just use "ttf" font 
> String path_font_default_ttf ;







SAVE and SETTING 
--
Camera and Object orientation and position

whichSetting is 0

afor Romanesco alpha 25 there is only one save setting is 0

for more setting change int numSettingCamera and int numSettingOrientationObject in the void createVarP3D() in the tab Variable_Common

PVector eyeCameraSetting[whichSetting] ;

PVector sceneCameraSetting[whichSetting] ;



CANVAS
--
CONSTRUTOR
--
Canvas(PVector pos, PVector size)

PARAM
--
PVector size (x,y,z) ;

PVector pos (x,y,z) ;

coord X
--
float left, right ;

coord Y
--
float top, bottom ;

coord Z
--
float front, back ;


METHOD
--
void update() ;
>use to change the size

void canvasLine() ; 
>use to display the canvas in line mode













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



































