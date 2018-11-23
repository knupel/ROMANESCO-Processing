

Romanesco dui 2.0.1.32
2011-2018
Guide to code the item Class Romanesco.

WARNING

all the method below can be use only in Romanesco class

This guide is not finish and not really exaustive :(


*IMPORTANT

there is TWO MAINS VOID in class ROMANESCO like PROCESSING

void setup()
> set your item

void draw();
> all code write here be display in 3D

void draw_2D()
>all code write here be display in 2D



*INFO item

RPE_name = "Unknown" ;
RPE_author = "Anonymous";
RPE_ersion = "Alpha";
RPE_pack = "Base 2016" ; 





*method item

*get method

int get_costume();
>return the reference of the costume selected for your item

String get_name();
>return the name of your item

int get_id()
>return the ID of your item

int get_id_group()
>return the group of your item

Movie get_movie()
> return the current item movie

PImage get_bitmap();
>return the current item image
  
String get_text()
>return the current item text

ROPE_svg get_svg();
>return the current item vectorial file



*is method from prescene

boolean birth_is();

boolean colour_is();

boolean dimension_is();
  
boolean horizon_is();

boolean motion_is();

boolean orbit_is();

boolean reverse_is();

boolean special_is();

boolean wire_is();

boolean fill_is();

boolean stroke_is();

boolean setting_is();

boolean clear_list_is();

*get slider method


Vec3 get_pos();

float get_pos_x();

float get_pos_y();

float get_pos_z();


*is method

boolean show_is();
  
boolean sound_is();

boolean action_is();

boolean parameter_is();

*misc method

int pad_inc(int target, int pad);
>the method is linked with the ARROW key

>parameter
int target : is incremented and returned
int pad
if pad == UP or pad == RIGHT target += 1
if pad == DOWN or pad == LEFT target += 1


void info(Object... info);
>write the message display when the user ask for information on the Scene

int which_movie();
>return the rank of current movie 

void load_movie(boolean is, int ID_item) {
>load the current movie

void load_bitmap(ID_item)
>load the current bitmap;










*PASS Processing PAplet in class Romanesco

when you code in the class romanesco and call external class or library need method(this) you must write method(papplet) :
example 
* name = new LibraryOrClass(this);) >>>
become >>>
name = new LibraryOrClass(paaplet);)

















*IMPORT

IMAGE IMPORT
–––––––––––––––––––––––
load image from the menu controller:
img_bitmap[ID_item] = loadImage(imagePath[whichImage[ID_item]]) ;

details:
loadImg(ID_item) void use to load and update the image
String imagePath[whichImage] ; image jpg from the dropdown menu
PImage img[ID_item] image selected from dropdown menu and confirm by the Parameter button of the object












*MISC



*COMMON ASSOCIATION 

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