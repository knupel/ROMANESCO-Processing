ROMANESC0 1.1.2.29
ROMANESCO PROCESSING ENVIRONMENT 
--
ITEM
--
MISC


IMPORTANT
--
there is TWO MAINS VOID in class ROMANESCO like PROCESSING
--
void setup()
--
void draw()
--
if you use other void you must call this one in one of them






ID item
=======
int ID_item = #
> this ID must be unique

INFO item
=====================
RPE_name = "Unknown" ;
RPE_author = "Anonymous";
RPE_ersion = "Alpha";
RPE_pack = "Base 2016" ; 

romanescoVideo = "NO" or "YES" ; elp the controller to manage the computer camera

RPE_mode = "mode name/mode name" ; separate the name by a slash and write the next mode immadialtly after this one.











_____________________________
LIBRARY OR EXTERNAL CLASSES
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
when you code in the class romanesco and call external class or library need (this) you must write (callingClass) :
example 
* name = new LibraryOrClass(this);) >>>
>>> become >>>
<<< name = new LibraryOrClass(callingClass);)




_________
RENDERING
°°°°°°°°°
boolean fullRendering ;
You can use this boolean to limit your object on the Prescene. It's usefull with object use a lot of particuls.
yhis boolean is false on the Prescene and true on the Scene.











______________________
IMPORT
°°°°°°°°°°°°°°°°°°°°°°
IMAGE IMPORT
–––––––––––––––––––––––
load image from the menu controller:
img_bitmap[ID_item] = loadImage(imagePath[whichImage[ID_item]]) ;

details:
loadImg(ID_item) void use to load and update the image
String imagePath[whichImage] ; image jpg from the dropdown menu
PImage img[ID_item] image selected from dropdown menu and confirm by the Parameter button of the object











_____________________________
MISC
°°°°°°°°°°°°°°°°°°°°°°°°°°°°°


COMMON ASSOCIATION 
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––
between the controler and the prescene
// with action button
// add obj
if(actionButton[ID_item] == 1 && nTouch ) { /* yourList.add( new YourClass ()); */ }
or
int spawnFrequency = 3 ; 
if(actionButton[ID_item] == 1 && nLongTouch && frameCount % spawnFrequency == 0 ) { /* yourList.add( new YourClass ()); */ }
// motion
if(actionButton[ID_item] == 1 && mTouch ) { }
// change stuff like color palette....
if(actionButton[ID_item] == 1 && xTouch ) { }
// stop, move the mouse inside the object
if(actionButton[ID_item] == 1 && spaceTouch ) { }

//with parametter button
open folder
if ( parameterButton[ID_item] == 1 && oTouch ) { }