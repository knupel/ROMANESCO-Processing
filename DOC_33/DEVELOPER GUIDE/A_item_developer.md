*
* DEVOLOPER ITEM
* Romanesco dui 
* 2013-2019
* v 2.1.0.33
* Processing 3.5.3.269
* Rope Library 0.7.1.25
* 
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



*INFO

item_name = "Unknown" ; // showing in controler
item_author = "Anonymous"; // showing in controler
item_references = "";
item_version = "Alpha"; // showing in controler
item_pack = "Base 2016" ; 
item_costume = "point/ellipse/triangle/rect/cross/pentagon/Star 5/Star 7/Super Star 8/Super Star 12"; 
item_mode = "";





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



*is method

*is from controller

boolean show_is();
  
boolean sound_is();

boolean action_is();

boolean parameter_is();

*is from prescene

boolean alpha_is();

boolean fill_is();

boolean stroke_is();

boolean birth_is();

boolean colour_is();

boolean dimension_is();
  
boolean horizon_is();

boolean motion_is();

boolean follow_is();

boolean reverse_is();

boolean special_is();

boolean wire_is();

boolean clear_list_is();


*set boolean state

void alpha_is(boolean is);

void fill_is(boolean is);

void stroke_is(boolean is);

void birth_is(boolean is);

void colour_is(boolean is);

void dimension_is(boolean is);
  
void horizon_is(boolean is);

void motion_is(boolean is);

void follow_is(boolean is);

void reverse_is(boolean is);

void special_is(boolean is);

void wire_is(boolean is);


*set boolean state

void switch_alpha();

void switch_fill();

void switch_stroke();

void switch_birth();

void switch_colour();

void switch_dimension();
  
void switch_horizon();

void switch_motion();

void switch_follow();

void switch_reverse();

void switch_special();

void switch_wire();



*get slider method

important all those method work with min() or max() or raw()
like method_name_min(), method_name_max() that's return the min and the max value of the slider.
like method_name_raw() return value before formating.


int get_fill();

int get_stroke();

float get_thickness();
  
Vec3 get_size();

float get_size_x();

float get_size_y();

float get_size_z();

float get_diameter();

Vec3 get_canvas();

float get_canvas_x();

float get_canvas_y();

float get_canvas_z();

get_frequence();

Vec3 get_speed();

float get_speed_x();

float get_speed_y();

float get_speed_z();

Vec3 get_jitter();

float get_jitter_x();

float get_jitter_y();

float get_jitter_z();

Vec3 get_spurt();

float get_spurt_x();

float get_spurt_y();

float get_spurt_z();

Vec3 get_swing();

float get_swing_x();

float get_swing_y();

float get_swing_z();

Vec3 get_dir();

float get_dir_x();

float get_dir_y();

float get_dir_z();

float get_quantity();

float get_variety();

float get_life();

float get_flow();

float get_quality();

float get_area();

float get_angle();

float get_scope();

float get_scan();

float get_alignment();

float get_repulsion();

float get_attraction();

float get_density();

float get_influence();

float get_calm();

float get_spectrum();

float get_grid();

float get_viscosity();

float get_diffusion();

float get_power();

float get_mass();

float get_amplitude();

Vec3 get_coord();

float get_coord_x();

float get_coord_y();

float get_coord_z();




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