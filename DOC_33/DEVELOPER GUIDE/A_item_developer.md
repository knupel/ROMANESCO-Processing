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

void info(Object... obj);
> create a field info for the user when this one call this on the rendering window: Scene or Prescene.

item_name = "Unknown" ; // showing in controler
item_author = "Anonymous"; // showing in controler
item_references = "";
item_version = "Alpha"; // showing in controler
item_pack = "Base 2016" ; 
item_costume = "point/ellipse/triangle/rect/cross/pentagon/Star 5/Star 7/Super Star 8/Super Star 12"; 
item_mode = "";


*CAMERA ITEM

void set_item_dir(float x, float y);

void set_item_dir(int which_setting, float x, float y);
> which_setting is not avalaible for now, may be for in the near future ? '0' is the only one

void set_item_pos(float x, float y, float z);

void set_item_pos(int which_setting, float x, float y, float z);
> which_setting is not avalaible for now, may be for in the near future ? '0' is the only one

vec3 get_item_pos();

vec3 get_item_dir();







*method item

*get method

Costume get_costume();
>return a class Costume of the selected costume from dropdown menu

int get_costume().get_name();
>return the String reference of the costume selected for your item

String get_mode_name();

int get_mode_id();

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

R_Image_Manager get_bitmap_collection();
>return R_Image_Manager, give acces to R_Image class. From R_Image you can acces to PImage by using method get_image()
  
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

important all methodes of Varom object

float value();
> return the value mapped

float min();
> return the min of value mapped

float max();
> return the max of value mapped

float raw();
>return the value from slider with a min max from slider value

float min_raw();
> return the min raw value

float max_row(); 
> return the max raw value

float normal();
> return value slider between 0 and 1



int get_fill();

int get_stroke();

Varom get_thickness();
  
Vec3 get_size();

Varom get_size_x();

Varom get_size_y();

Varom get_size_z();

Varom get_diameter();

Vec3 get_canvas();

Varom get_canvas_x();

Varom get_canvas_y();

Varom get_canvas_z();

Varom get_frequence();

Vec3 get_speed();

Varom get_speed_x();

Varom get_speed_y();

Varom get_speed_z();

Vec3 get_jitter();

Varom get_jitter_x();

Varom get_jitter_y();

Varom get_jitter_z();

Vec3 get_spurt();

Varom get_spurt_x();

Varom get_spurt_y();

Varom get_spurt_z();

Vec3 get_swing();

Varom get_swing_x();

Varom get_swing_y();

Varom get_swing_z();

Vec3 get_dir();

Varom get_dir_x();

Varom get_dir_y();

Varom get_dir_z();

float get_quantity();

Varom get_variety();

Varom get_life();

Varom get_flow();

Varom get_quality();

Varom get_area();

Varom get_angle();

Varom get_scope();

Varom get_scan();

Varom get_alignment();

Varom get_repulsion();

Varom get_attraction();

Varom get_density();

Varom get_influence();

Varom get_calm();

Varom get_spectrum();

Varom get_grid();

Varom get_viscosity();

Varom get_diffusion();

Varom get_power();

Varom get_mass();

Varom get_amplitude();

Vec3 get_coord();

Varom get_coord_x();

Varom get_coord_y();

Varom get_coord_z();




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





