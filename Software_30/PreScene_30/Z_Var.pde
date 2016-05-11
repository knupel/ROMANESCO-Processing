/** 
Tab: Z_VAR
Version 1.0.4
*/
// GLOBAL SETTING ////

import java.net.*;
import java.io.*;
import java.util.*;
import java.awt.*;
import java.util.Iterator;
import java.lang.reflect.*; 
import java.awt.image.* ;

import processing.video.*;
import oscP5.*;
import netP5.*;
import processing.net.*;
import processing.pdf.*;
//FLUX RSS or TWITTER ????
import com.sun.syndication.feed.synd.*;
import com.sun.syndication.io.*;
//SOUND
import ddf.minim.*;
import ddf.minim.analysis.*;
//GEOMERATIVE
import geomerative.*;
//TOXIC
import toxi.geom.*;
import toxi.geom.mesh2d.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.processing.*;
// METEO
import com.onformative.yahooweather.*;
// SYPHON
import codeanticode.syphon.*;

//CALLING class or library in Other Class, you must call the PApplet too in your class
PApplet callingClass = this ;
// use for the border of window (top and right)
java.awt.Insets insets; 



int MIN_WINDOW_WIDTH = 128 ; 
int MIN_WINDOW_HEIGHT = 128 ;
// Max value whi is return from the slider controller
int MAX_VALUE_SLIDER = 360 ;
// num obj count in Romanesco Manager
int NUM_OBJ ;




//variable for the tracking
boolean nextPrevious = false ;
int nextPreviousInt = 0 ; // for send to Syphon
int trackerUpdate ; // must be reset after each use
//spectrum for the color mode and more if you need
Vec4 HSBmode = new Vec4 (360,100,100,100) ; // give the color mode in HSB
//path to open the controleur
String findPath ; 



// MOUSE DETECTION
// return if the cursor (mouse) is in the sketch or not
boolean MOUSE_IN_OUT = true ;





// COMMAND BOOLEAN
//BOOLEAN COMMAND
/* command from leap motion, mouse or other devices if we code for that :) */
boolean ORDER, ORDER_ONE, ORDER_TWO, ORDER_THREE ;
boolean LEAPMOTION_DETECTED ;



// SAVE
boolean load_SCENE_Setting_GLOBAL, save_Current_SCENE_Setting_GLOBAL, save_New_SCENE_Setting_GLOBAL ;




// HIGH VAR
boolean modeP3D, modeP2D, modeOPENGL, modeClassic ;
//spectrum band
int NUM_BANDS = 16 ;
//font
int numFont = 50 ;
//quantity of group object slider
int NUM_GROUP = 1 ;

int NUM_SLIDER_MISC = 30 ;
int NUM_SLIDER_OBJ = 48 ;

int numButtonGlobal = 21 ; // group zero
int numButtonObj  ; 
// VAR obj
color COLOR_FILL_OBJ_PREVIEW  ; 
color COLOR_STROKE_OBJ_PREVIEW ;
int THICKNESS_OBJ_PREVIEW = 2 ;
int numObj ;
Table indexObjects ;
TableRow [] rowIndexObject ;
//MISC var
//info object
String [] objectInfo, objectName, objectAuthor, objectVersion, objectPack ;
int [] objectID ;
boolean [] objectInfoDisplay ;
//for the leap motion ?
int objectLeapID[] ;
//BUTTON CONTROLER
boolean objectParameter[] ;

/**
Var item
*/
//raw
int fill_hue_raw, fill_sat_raw, fill_bright_raw, fill_alpha_raw ;
int stroke_hue_raw, stroke_sat_raw, stroke_bright_raw, stroke_alpha_raw ;
float thickness_raw ; 
float size_x_raw, size_y_raw, size_z_raw ;
float canvas_x_raw, canvas_y_raw, canvas_z_raw ;
float font_size_raw ;

float reactivity_raw ;
float speed_x_raw, speed_y_raw, speed_z_raw ;
float spurt_x_raw, spurt_y_raw, spurt_z_raw ;
float dir_x_raw, dir_y_raw, dir_z_raw ;
float jitter_x_raw, jitter_y_raw, jitter_z_raw ;
float swing_x_raw, swing_y_raw, swing_z_raw ;

float quantity_raw, variety_raw ; 
float life_raw, flow_raw, quality_raw ;

float area_raw, angle_raw, scope_raw, scan_raw ;
float alignment_raw, repulsion_raw, attraction_raw, charge_raw ;

float influence_raw, calm_raw, need_raw ;




// String name
String fill_hue_name = "fill_hue" ;     
String fill_sat_name = "fill_sat" ;     
String fill_bright_name= "fill_bright" ;     
String fill_alpha_name = "fill_alpha" ;

String stroke_hue_name = "stroke_hue" ; 
String stroke_sat_name = "stroke_sat" ; 
String stroke_bright_name= "stroke_bright" ; 
String stroke_alpha_name = "stroke_alpha" ;

String thickness_name = "thickness" ; 

String size_x_name = "size_x" ;     
String size_y_name = "size_y" ;     
String size_z_name = "size_z" ;

String font_size_name = "font_size";

String canvas_x_name = "canvas_x" ; 
String canvas_y_name = "canvas_y" ; 
String canvas_z_name = "canvas_z" ;

String reactivity_name = "reactivity" ;

String speed_x_name = "speed_x" ; 
String speed_y_name = "speed_y" ; 
String speed_z_name = "speed_z" ;

String spurt_x_name = "spurt_x" ; 
String spurt_y_name= "spurt_y"; 
String spurt_z_name = "spurt_z" ;

String dir_x_name = "dir_x" ; 
String dir_y_name = "dir_y" ; 
String dir_z_name = "dir_z" ;

String jitter_x_name = "jitter_x" ; 
String jitter_y_name = "jitter_y" ; 
String jitter_z_name = "jitter_z" ;

String swing_x_name = "swing_x" ; 
String swing_y_name = "swing_y" ; 
String swing_z_name = "swing_z";

String quantity_name = "quantity" ; 
String variety_name = "variety"; 

String life_name = "life" ; 
String flow_name = "flow" ; 
String quality_name = "quality";

String area_name = "area" ; 
String angle_name = "angle" ; 
String scope_name = "scope" ; 
String scan_name = "scan" ;

String alignment_name = "alignment" ; 
String repulsion_name = "repulsion" ; 
String attraction_name = "attraction" ; 
String charge_name = "charge" ;

String influence_name = "influence" ; 
String calm_name = "calm" ; 
String need_name = "need" ;



// MIN MAX MAP SLIDER
float min_size = .1 ;

Vec2 fill_hue_min_max = Vec2(0,360) ; // data from controller value 0 - 360
Vec2 fill_sat_min_max = Vec2(0,HSBmode.g) ;     
Vec2 fill_bright_min_max = Vec2(0,HSBmode.b) ;     
Vec2 fill_alpha_min_max = Vec2(0,HSBmode.a) ;

Vec2 stroke_hue_min_max = Vec2(0,360) ; // data from controller value 0 - 360
Vec2 stroke_sat_min_max = Vec2(0,HSBmode.g) ; 
Vec2 stroke_bright_min_max = Vec2(0,HSBmode.b); 
Vec2 stroke_alpha_min_max = Vec2(0,HSBmode.a) ;

Vec2 thickness_min_max = Vec2(min_size, height*.33) ; 

Vec2 size_x_min_max = Vec2(min_size, width) ;     
Vec2 size_y_min_max = Vec2(min_size, width) ;     
Vec2 size_z_min_max = Vec2(min_size, width) ;

Vec2 font_size_min_max = Vec2((float)height *.005, (float)height *.05);

Vec2 canvas_x_min_max = Vec2(width *min_size, width) ; 
Vec2 canvas_y_min_max = Vec2(width *min_size, width); 
Vec2 canvas_z_min_max = Vec2(width *min_size, width) ;

Vec2 reactivity_min_max = Vec2(0,1) ;

Vec2 speed_x_min_max = Vec2(0,1) ; 
Vec2 speed_y_min_max = Vec2(0,1) ; 
Vec2 speed_z_min_max = Vec2(0,1) ;

Vec2 spurt_x_min_max = Vec2(0,1) ; 
Vec2 spurt_y_min_max = Vec2(0,1) ; 
Vec2 spurt_z_min_max = Vec2(0,1) ;

Vec2 dir_x_min_max = Vec2(0,360) ; // data from controller value 0 - 360 
Vec2 dir_y_min_max = Vec2(0,360) ; //  data from controller value 0 - 360
Vec2 dir_z_min_max = Vec2(0,360) ; // data from controller value 0 - 360

Vec2 jitter_x_min_max = Vec2(0,1) ; 
Vec2 jitter_y_min_max = Vec2(0,1) ; 
Vec2 jitter_z_min_max = Vec2(0,1) ;

Vec2 swing_x_min_max = Vec2(0,1) ; 
Vec2 swing_y_min_max = Vec2(0,1) ; 
Vec2 swing_z_min_max = Vec2(0,1) ;

Vec2 quantity_min_max = Vec2(0,1) ; 
Vec2 variety_min_max = Vec2(0,1) ; 

Vec2 life_min_max = Vec2(0,1) ; 
Vec2 flow_min_max = Vec2(0,1) ; 
Vec2 quality_min_max = Vec2(0,1) ;

Vec2 area_min_max = Vec2(width *min_size, width) ; 
Vec2 angle_min_max = Vec2(0,360) ;  // data from controller value 0 - 360
Vec2 scope_min_max = Vec2(width *min_size, width) ; 
Vec2 scan_min_max = Vec2(0,360) ; // data from controller value 0 - 360

Vec2 alignment_min_max = Vec2(0,1) ; 
Vec2 repulsion_min_max = Vec2(0,1) ; 
Vec2 attraction_min_max = Vec2(0,1) ; 
Vec2 charge_min_max = Vec2(0,1) ;

Vec2 influence_min_max = Vec2(0,1) ; 
Vec2 calm_min_max = Vec2(0,1) ; 
Vec2 need_min_max = Vec2(0,1) ;





// temp
/* value used to know if the value slider have change or nor */
int fill_hue_temp, fill_sat_temp, fill_bright_temp, fill_alpha_temp ;
int stroke_hue_temp, stroke_sat_temp, stroke_bright_temp, stroke_alpha_temp ;
float thickness_temp; 
float size_x_temp, size_y_temp, size_z_temp ;
float canvas_x_temp, canvas_y_temp, canvas_z_temp ;
float font_size_temp ;

float reactivity_temp ;
float speed_x_temp, speed_y_temp, speed_z_temp ;
float spurt_x_temp, spurt_y_temp, spurt_z_temp ;
float dir_x_temp, dir_y_temp,dir_z_temp ;
float jitter_x_temp, jitter_y_temp, jitter_z_temp ;
float swing_x_temp, swing_y_temp, swing_z_temp ;

float quantity_temp, variety_temp ;
float life_temp, flow_temp, quality_temp ;
float area_temp, angle_temp, scope_temp, scan_temp ;

float alignment_temp, repulsion_temp, attraction_temp, charge_temp ;
float influence_temp, calm_temp, need_temp ;




// item target final
boolean [] first_opening_item ; // used to check if this object is already opening before
color [] fill_item, stroke_item ;
float [] thickness_item ; 
float [] size_x_item, size_y_item, size_z_item ;
float [] font_size_item ;
float [] canvas_x_item, canvas_y_item, canvas_z_item ;


float [] reactivity_item ;
float [] speed_x_item, speed_y_item, speed_z_item ;
float [] spurt_x_item, spurt_y_item, spurt_z_item ;
float [] dir_x_item, dir_y_item, dir_z_item ;
float [] jitter_x_item, jitter_y_item, jitter_z_item ;
float [] swing_x_item, swing_y_item, swing_z_item ;

float [] quantity_item, variety_item ;
float [] life_item, flow_item, quality_item ;

float [] area_item, angle_item, scope_item, scan_item ;
float [] alignment_item, repulsion_item, attraction_item, charge_item ;
float [] influence_item, calm_item, need_item ;

/**
End var item
*/

//font
PFont police ;



//OSC VAR
// button
int whichFont ;

boolean onOffBeat, onOffKick, onOffSnare, onOffHat, onOffCurtain, onOffBackground ;
boolean onOffDirLightOne,       onOffDirLightTwo,       onOffLightAmbient,
        onOffDirLightOneAction, onOffDirLightTwoAction, onOffLightAmbientAction ;


int whichShader ; 
int [] which_bitmap, which_text, which_svg, which_movie ;
/**
No text_path_ref ???????
*/
String [] bitmap_path_ref, svg_path_ref, movie_path_ref  ;

int [] objectButton,soundButton, actionButton, parameterButton ;
boolean [] show_object, sound, action, parameter ;

int mode[]  ;

//BUTTON
int [] valueButtonGlobal, valueButtonObj  ;

//SLIDER
String valueSliderTemp[][]  = new String [NUM_GROUP+1][NUM_SLIDER_OBJ] ;

// becareful if the number of MISC SLIDERS is upper than OBJ SLIDER, that can be a problem in the future.
float valueSlider[][]  = new float [NUM_GROUP+1][NUM_SLIDER_OBJ] ;


//MISC
//var to init the data of the object when is switch ON for the first time
boolean  [] initValueMouse, initValueControleur ;
//parameter for the super class
float [] left, right, mix ;
//beat
float [] beat, kick, snare, hat ;
// spectrum
float band[][] ;
//tempo
float [] tempo, tempoBeat, tempoKick, tempoSnare, tempoHat ;


//P3D OBJECT
//setting and save
int numSettingCamera = 1 ;
int numSettingOrientationObject = 1 ;
PVector [][] posObjSetting, dirObjSetting ;
PVector [] eyeCameraSetting, sceneCameraSetting ;
//position
Vec3 startingPosition [] ;
float [] posObjX, posObjY, posObjZ ;

// PVector posObjRef ;
boolean newObjRefPos ;
PVector [] posObj, dirObj ;
Vec3 [] posObjRef ;
//orientation
float [] dirObjX, dirObjY ;
PVector dirObjRef ;
boolean newObjRefDir ;

//position of object and wheel
Vec3 [] mouse, pen ;
boolean [] clickShortLeft, clickShortRight, clickLongLeft, clickLongRight;
int wheel[] ;
//pen info

//boolean object
boolean [] motion, horizon, setting, reverse, clearList ;

//main font for each object
String [] pathFontTTF, pathFontVLW, pathFontObjTTF ;
PFont font[]  ;



















//init var
void createVar() {
  numObj = rpe_manager.numClasses + 1 ;
  //BUTTON CONTROLER
  numButtonObj = numObj*10 ;
  createMiscVar() ;
  createVarButton() ;
  createVarSound() ;
  createVarP3D(numObj, numSettingCamera, numSettingOrientationObject) ;
  createVarCursor() ;
  create_var_item() ;
  rpe_manager.initObj() ;
  println("createVar done") ;
}
// misc var
void createMiscVar() {
  objectLeapID = new int[numObj] ;
  objectInfoDisplay = new boolean[numObj] ;

  setting = new boolean [numObj]  ;
  // boolean clear
  clearList = new boolean[numObj] ;
  motion = new boolean [numObj]  ;
  horizon = new boolean [numObj]  ;
  reverse = new boolean [numObj] ;

  // IMAGE
  bitmap_import = new PImage[numObj] ;
  which_bitmap = new int[numObj] ;
  bitmap_path_ref = new String[numObj] ;
  // SVG
  svg_import = new RPEsvg[numObj] ;
  which_svg = new int[numObj] ;
  svg_path_ref = new String[numObj] ;

  // Movie
  movieImport = new Movie[numObj] ;
  movieImportPath = new String[numObj] ;
  which_movie = new int[numObj] ;
  movie_path_ref = new String[numObj] ;
  // TEXT
  text_import = new String [numObj] ;
  which_text = new int[numObj] ;
  //main font for each object
  font = new PFont[numObj] ;
  pathFontObjTTF = new String[numObj] ;
  pathFontTTF = new String [numFont] ;  
  pathFontVLW = new String [numFont] ;
  font = new PFont[numFont] ;
  //MISC
  //var to init the data of the object when is switch ON for the first time
  initValueMouse = new boolean [numObj]  ;
  initValueControleur = new boolean [numObj]  ;
}
// var cursor
void createVarCursor() {
  //position of object and wheel
   mouse  = new Vec3[numObj] ;
   clickShortLeft = new boolean [numObj] ;
   clickShortRight = new boolean [numObj] ;
   clickLongLeft = new boolean [numObj] ;
   clickLongRight = new boolean [numObj] ;
   wheel = new int [numObj] ;
  //pen info
   pen = new Vec3[numObj] ;
}
// P3D
void createVarP3D(int numObj, int numSettingCamera, int numSettingOrientationObject) {
   // setting and save
   eyeCameraSetting = new PVector [numSettingCamera] ;
   sceneCameraSetting = new PVector [numSettingCamera] ;

   posObjSetting = new PVector [numSettingOrientationObject] [numObj] ;
   dirObjSetting = new PVector [numSettingOrientationObject] [numObj] ;
   //
   startingPosition = new Vec3[numObj] ;
   posObjX = new float[numObj] ;
   posObjY = new float[numObj] ;
   posObjZ = new float[numObj] ;
   
   // orientation
   dirObjX = new float[numObj] ;
   dirObjY = new float[numObj] ;
   posObjRef = new Vec3[numObj] ;
   posObj = new PVector[numObj] ;
   dirObj = new PVector[numObj] ;
}

void createVarSound() {
  // volume 
   left = new float [numObj] ;
   right = new float [numObj] ;
   mix  = new float [numObj] ;
   // beat
   beat  = new float [numObj] ;
   kick  = new float [numObj] ;
   snare  = new float [numObj] ;
   hat  = new float [numObj] ;
   // spectrum
   band = new float [numObj][NUM_BANDS] ;
   // tempo
   tempo = new float [numObj] ;
   tempoBeat = new float [numObj] ;
   tempoKick = new float [numObj] ;
   tempoSnare = new float [numObj] ;
   tempoHat = new float [numObj] ;
}
//

//
void createVarButton() {
  objectButton = new int [numObj] ;
  soundButton = new int [numObj] ;
  actionButton = new int [numObj] ;
  parameterButton = new int [numObj] ;
  show_object = new boolean [numObj] ;
  sound = new boolean [numObj] ;
  action = new boolean [numObj] ;
  parameter = new boolean [numObj] ;
  mode = new int [numObj] ;
  
  // you must init this var, because we launch this part of code before the controller. And if we don't init the value is NaN and return an error.
  valueButtonGlobal = new int[numButtonGlobal] ;
  valueButtonObj = new int[numObj*10] ;

}

void create_var_item() {
 
  // VAR object
  first_opening_item = new boolean[numObj] ; // used to check if this object is already opening before
  fill_item = new color[numObj] ;
  stroke_item = new color[numObj] ;
  // column 2
  thickness_item = new float[numObj] ; 

  size_x_item = new float[numObj] ; 
  size_y_item = new float[numObj] ; 
  size_z_item = new float[numObj] ;

  font_size_item = new float[numObj] ;

  canvas_x_item = new float[numObj] ; 
  canvas_y_item = new float[numObj] ; 
  canvas_z_item = new float[numObj] ;

   //column 3
  reactivity_item = new float[numObj] ;

  speed_x_item = new float[numObj] ; 
  speed_y_item = new float[numObj] ;
  speed_z_item = new float[numObj] ;

  spurt_x_item = new float[numObj] ; 
  spurt_y_item = new float[numObj] ;
  spurt_z_item = new float[numObj] ;

  dir_x_item = new float[numObj] ; 
  dir_y_item = new float[numObj] ;
  dir_z_item = new float[numObj] ;

  jitter_x_item = new float[numObj] ; 
  jitter_y_item = new float[numObj] ;
  jitter_z_item = new float[numObj] ;

  swing_x_item = new float[numObj] ; 
  swing_y_item = new float[numObj] ;
  swing_z_item = new float[numObj] ;

  quantity_item = new float[numObj] ; 
  variety_item = new float[numObj] ; 

  life_item = new float[numObj] ;
  flow_item = new float[numObj] ;
  quality_item = new float[numObj] ;

  area_item = new float[numObj] ;
  angle_item = new float[numObj] ;
  scope_item = new float[numObj] ;
  scan_item = new float[numObj] ;

  alignment_item = new float[numObj] ;
  repulsion_item = new float[numObj] ;
  attraction_item = new float[numObj] ;
  charge_item = new float[numObj] ;


  influence_item = new float[numObj] ;
  calm_item = new float[numObj] ;
  need_item = new float[numObj] ;
}
// END CREATE VAR
//////////////////



// SETTING VAR
//SETUP
void varObjSetup() {
  dirObjRef = new PVector() ;
  for (int i = 0 ; i < numObj ; i++ ) {
    pen[i] = Vec3() ;
    // use the 250 value for "z" to keep the position light on the front
    mouse[i] = Vec3() ;
    wheel[i] = 0 ;

  }
    // init global var for the color obj preview mode display
  COLOR_FILL_OBJ_PREVIEW = color (0,0,100,30) ; 
  COLOR_STROKE_OBJ_PREVIEW = color (0,0,100,30) ;
}
// END SETTING AR


/* 
UPDATE DATA from CONTROLER and PRESCENE
Those value are used to updated the object data value, and updated at the end of the loop the temp value
*/
void update_raw_value() {
   int minSource = 0 ;
    // fill
    fill_hue_raw = (int)map(valueSlider[1][0], minSource, MAX_VALUE_SLIDER, fill_hue_min_max.x, fill_hue_min_max.y);
    fill_sat_raw = (int)map(valueSlider[1][1], minSource, MAX_VALUE_SLIDER, fill_sat_min_max.x, fill_sat_min_max.y);    
    fill_bright_raw = (int)map(valueSlider[1][2], minSource, MAX_VALUE_SLIDER, fill_bright_min_max.x, fill_bright_min_max.y) ;   
    fill_alpha_raw = (int)map(valueSlider[1][3], minSource, MAX_VALUE_SLIDER, fill_alpha_min_max.x, fill_alpha_min_max.y);
    // stroke
    stroke_hue_raw = (int)map(valueSlider[1][4], minSource, MAX_VALUE_SLIDER, stroke_hue_min_max.x,stroke_hue_min_max.y);   
    stroke_sat_raw = (int)map(valueSlider[1][5], minSource, MAX_VALUE_SLIDER, stroke_sat_min_max.x,stroke_sat_min_max.y);  
    stroke_bright_raw = (int)map(valueSlider[1][6], minSource, MAX_VALUE_SLIDER, stroke_bright_min_max.x, stroke_bright_min_max.y) ; 
    stroke_alpha_raw = (int)map(valueSlider[1][7], minSource, MAX_VALUE_SLIDER, stroke_alpha_min_max.x, stroke_alpha_min_max.y);
    // 
    int smooth_slider = 2 ;
    thickness_raw = mapStartSmooth(valueSlider[1][8], minSource, MAX_VALUE_SLIDER, thickness_min_max.x, thickness_min_max.y, smooth_slider) ;

    // size
    size_x_raw = map(valueSlider[1][9], minSource, MAX_VALUE_SLIDER, size_x_min_max.x, size_x_min_max.y) ;
    size_y_raw = map(valueSlider[1][10], minSource, MAX_VALUE_SLIDER, size_y_min_max.x, size_y_min_max.y) ;
    size_z_raw = map(valueSlider[1][11], minSource, MAX_VALUE_SLIDER, size_z_min_max.x, size_z_min_max.y) ;
    // size font
    font_size_raw = map(valueSlider[1][12], minSource, MAX_VALUE_SLIDER, font_size_min_max.x, font_size_min_max.y) ;
    // canvas
    canvas_x_raw = map(valueSlider[1][13], minSource, MAX_VALUE_SLIDER, canvas_x_min_max.x, canvas_x_min_max.y) ;
    canvas_y_raw = map(valueSlider[1][14], minSource, MAX_VALUE_SLIDER, canvas_y_min_max.x, canvas_y_min_max.y) ;
    canvas_z_raw = map(valueSlider[1][15], minSource, MAX_VALUE_SLIDER, canvas_z_min_max.x, canvas_z_min_max.y) ;

    // size font
    reactivity_raw = map(valueSlider[1][16], minSource, MAX_VALUE_SLIDER, reactivity_min_max.x, reactivity_min_max.y) ;
    // speed
    speed_x_raw = map(valueSlider[1][17], minSource, MAX_VALUE_SLIDER, speed_x_min_max.x, speed_x_min_max.y) ;
    speed_y_raw = map(valueSlider[1][18], minSource, MAX_VALUE_SLIDER, speed_y_min_max.x, speed_y_min_max.y) ;
    speed_z_raw = map(valueSlider[1][19], minSource, MAX_VALUE_SLIDER, speed_z_min_max.x, speed_z_min_max.y) ;
    // spurt
    spurt_x_raw = map(valueSlider[1][20], minSource, MAX_VALUE_SLIDER, spurt_x_min_max.x, spurt_x_min_max.y) ;
    spurt_y_raw = map(valueSlider[1][21], minSource, MAX_VALUE_SLIDER, spurt_y_min_max.x, spurt_y_min_max.y) ;
    spurt_z_raw = map(valueSlider[1][22], minSource, MAX_VALUE_SLIDER, spurt_z_min_max.x, spurt_z_min_max.y) ;
    // direction
    dir_x_raw = map(valueSlider[1][23], minSource, MAX_VALUE_SLIDER, dir_x_min_max.x, dir_x_min_max.y) ;
    dir_y_raw = map(valueSlider[1][24], minSource, MAX_VALUE_SLIDER, dir_y_min_max.x, dir_y_min_max.y) ;
    dir_z_raw = map(valueSlider[1][25], minSource, MAX_VALUE_SLIDER, dir_z_min_max.x, dir_z_min_max.y) ;
    // jitter
    jitter_x_raw = map(valueSlider[1][26], minSource, MAX_VALUE_SLIDER, jitter_x_min_max.x, jitter_x_min_max.y) ;
    jitter_y_raw = map(valueSlider[1][27], minSource, MAX_VALUE_SLIDER, jitter_y_min_max.x, jitter_y_min_max.y) ;
    jitter_z_raw = map(valueSlider[1][28], minSource, MAX_VALUE_SLIDER, jitter_z_min_max.x, jitter_z_min_max.y) ;
    // spurt
    swing_x_raw = map(valueSlider[1][29], minSource, MAX_VALUE_SLIDER, swing_x_min_max.x, swing_x_min_max.y) ;
    swing_y_raw = map(valueSlider[1][30], minSource, MAX_VALUE_SLIDER, swing_y_min_max.x, swing_y_min_max.y) ;
    swing_z_raw = map(valueSlider[1][31], minSource, MAX_VALUE_SLIDER, swing_z_min_max.x, swing_z_min_max.y) ;

    // misc
    quantity_raw = map(valueSlider[1][32], minSource, MAX_VALUE_SLIDER, quantity_min_max.x, quantity_min_max.y) ;
    variety_raw = map(valueSlider[1][33], minSource, MAX_VALUE_SLIDER, variety_min_max.x, variety_min_max.y) ;
    // bio
    life_raw = map(valueSlider[1][34], minSource, MAX_VALUE_SLIDER, life_min_max.x, life_min_max.y) ;
    flow_raw = map(valueSlider[1][35], minSource, MAX_VALUE_SLIDER, flow_min_max.x, flow_min_max.y) ;
    quality_raw = map(valueSlider[1][36], minSource, MAX_VALUE_SLIDER, quality_min_max.x, quality_min_max.y) ;
    // radar
    area_raw = map(valueSlider[1][37], minSource, MAX_VALUE_SLIDER, area_min_max.x, area_min_max.y) ;
    angle_raw = map(valueSlider[1][38], minSource, MAX_VALUE_SLIDER, angle_min_max.x, angle_min_max.y) ;
    scope_raw = map(valueSlider[1][39], minSource, MAX_VALUE_SLIDER, scope_min_max.x, scope_min_max.y) ;
    scan_raw = map(valueSlider[1][40], minSource, MAX_VALUE_SLIDER, scan_min_max.x, scan_min_max.y) ;

    // force or behavior
    alignment_raw = map(valueSlider[1][41], minSource, MAX_VALUE_SLIDER, alignment_min_max.x, alignment_min_max.y) ;
    repulsion_raw = map(valueSlider[1][42], minSource, MAX_VALUE_SLIDER, repulsion_min_max.x, repulsion_min_max.y) ;
    attraction_raw = map(valueSlider[1][43], minSource, MAX_VALUE_SLIDER, attraction_min_max.x, attraction_min_max.y) ;
    charge_raw = map(valueSlider[1][44], minSource, MAX_VALUE_SLIDER, charge_min_max.x, charge_min_max.y) ;


    influence_raw = map(valueSlider[1][45], minSource, MAX_VALUE_SLIDER, influence_min_max.x, influence_min_max.y) ;
    calm_raw = map(valueSlider[1][46], minSource, MAX_VALUE_SLIDER, calm_min_max.x, calm_min_max.y) ;
    need_raw = map(valueSlider[1][47], minSource, MAX_VALUE_SLIDER, need_min_max.x, need_min_max.y) ; 

}


/* Those temp value are used to know is the object value must be updated */
void update_temp_value() {
  // fill
  fill_hue_temp = fill_hue_raw ;
  fill_sat_temp = fill_sat_raw ;    
  fill_bright_temp = fill_bright_raw ;   
  fill_alpha_temp = fill_alpha_raw ;
  // stroke
  stroke_hue_temp = stroke_hue_raw ; 
  stroke_sat_temp = stroke_sat_raw ;  
  stroke_bright_temp = stroke_bright_raw ; 
  stroke_alpha_temp = stroke_alpha_raw ;
  //
  thickness_temp= thickness_raw ;
  //size
  size_x_temp = size_x_raw ;
  size_y_temp = size_y_raw ;
  size_z_temp = size_z_raw ;
  // font size
  font_size_temp = font_size_raw ;
  // canvas
  canvas_x_temp = canvas_x_raw ;
  canvas_y_temp = canvas_y_raw ;
  canvas_z_temp = canvas_z_raw ;
  // misc
  reactivity_temp = reactivity_raw ;
  // speed
  speed_x_temp = speed_x_raw ;
  speed_y_temp = speed_y_raw ;
  speed_z_temp = speed_z_raw ;
  // spurt
  spurt_x_temp = spurt_x_raw ;
  spurt_y_temp = spurt_y_raw ;
  spurt_z_temp = spurt_z_raw ;
  // direction
  dir_x_temp = dir_x_raw ;
  dir_y_temp = dir_y_raw ;
  dir_z_temp = dir_z_raw ;
  // jitter
  jitter_x_temp = jitter_x_raw ;
  jitter_y_temp = jitter_y_raw ;
  jitter_z_temp = jitter_z_raw ;
  // direction
  swing_x_temp = swing_x_raw ;
  swing_y_temp = swing_y_raw ;
  swing_z_temp = swing_z_raw ;

  quantity_temp = quantity_raw ;
  variety_temp = variety_raw ;

  life_temp = life_raw ;
  flow_temp = flow_raw ;
  quality_temp = quality_raw ;

  area_temp = area_raw ;
  angle_temp = angle_raw ;
  scope_temp = scope_raw ;
  scan_temp = scan_raw ;
  // force
  alignment_temp = alignment_raw ;
  repulsion_temp = repulsion_raw ;
  attraction_temp = attraction_raw ;
  charge_temp = charge_raw ;

  influence_temp = influence_raw ;
  calm_temp = calm_raw ;
  need_temp = need_raw ;
}


//SHORTCUT VAR
//SOUND
float allBeats(int ID) {
  return (beat[ID]*.25) +(kick[ID]*.25) +(hat[ID]*.25) +(snare[ID]*.25) ;
}
// ASPECT

void aspect_rpe(int ID) {
  if(alpha(fill_item[ID]) == 0 ) noFill() ; else fill(fill_item[ID]) ;
  if(alpha(stroke_item[ID]) == 0 ) noStroke() ; else stroke(stroke_item[ID]) ;
  strokeWeight(thickness_item[ID]) ;
}












////////////////////////
// FONT and TEXT MANAGER

//FONT
PFont SansSerif10,

      AmericanTypewriter, AmericanTypewriterBold,
      Banco, 
      ContainerRegular, Cinquenta,
      Diesel,
      Digital, 
      DinRegular10 ,DinRegular, DinBold,
      EastBloc,
      FetteFraktur, FuturaStencil,
      GangBangCrime,
      Juanita, JuanitaOutline,
      Komikahuna,
      Mesquite,
      Minion, MinionBold,
      NanumBrush, 
      Rosewood,
      TheHardwayRMX,
      TokyoOne, TokyoOneSolid ;
      


      
//SETUP
void fontSetup() {
  String fontPathVLW = import_path +"font/typoVLW/" ;
  //write font path
  pathFontVLW[1] = fontPathVLW+"AmericanTypewriter-96.vlw";
  pathFontVLW[2] = fontPathVLW+"AmericanTypewriter-Bold-96.vlw";
  pathFontVLW[3] = fontPathVLW+"BancoITCStd-Heavy-96.vlw";
  pathFontVLW[4] = fontPathVLW+"CinquentaMilMeticais-96.vlw";
  pathFontVLW[5] = fontPathVLW+"Container-Regular-96.vlw";
  pathFontVLW[6] = fontPathVLW+"Diesel-96.vlw";
  pathFontVLW[7] = fontPathVLW+"Digital2-96.vlw";
  pathFontVLW[8] = fontPathVLW+"DIN-Regular-96.vlw";
  pathFontVLW[9] = fontPathVLW+"DIN-Bold-96.vlw";
  pathFontVLW[10] = fontPathVLW+"EastBlocICGClosed-96.vlw";
  pathFontVLW[11] = fontPathVLW+"FuturaStencilICG-96.vlw";
  pathFontVLW[12] = fontPathVLW+"FetteFraktur-96.vlw";
  pathFontVLW[13] = fontPathVLW+"GANGBANGCRIME-96.vlw";
  pathFontVLW[14] = fontPathVLW+"JuanitaDecoITCStd-96.vlw";
  pathFontVLW[15] = fontPathVLW+"Komikahuna-96.vlw";
  pathFontVLW[16] = fontPathVLW+"MesquiteStd-96.vlw";
  pathFontVLW[17] = fontPathVLW+"NanumBrush-96.vlw";
  pathFontVLW[18] = fontPathVLW+"RosewoodStd-Regular-96.vlw";
  pathFontVLW[19] = fontPathVLW+"3theHardwayRMX-96.vlw";
  pathFontVLW[20] = fontPathVLW+"Tokyo-One-96.vlw";
  pathFontVLW[21] = fontPathVLW+"MinionPro-Regular-96.vlw";
  pathFontVLW[22] = fontPathVLW+"MinionPro-Bold-96.vlw";
  // special font
  pathFontVLW[49] = fontPathVLW+"DIN-Regular-10.vlw";
  SansSerif10 = loadFont(fontPathVLW+"SansSerif-10.vlw" );
  // write font path for TTF
  String prefixTTF = preference_path +"Font/typoTTF/" ;
  //by default
  pathFontTTF[0] = prefixTTF+"FuturaStencil.ttf";
  // type
  pathFontTTF[1] = prefixTTF+"AmericanTypewriter.ttf";
  pathFontTTF[2] = prefixTTF+"AmericanTypewriter.ttf";
  pathFontTTF[3] = prefixTTF+"Banco.ttf";
  pathFontTTF[4] = prefixTTF+"Cinquenta.ttf";
  pathFontTTF[5] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[6] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[7] = prefixTTF+"Digital2.ttf";
  pathFontTTF[8] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[9] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[10] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[11] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[12] = prefixTTF+"FetteFraktur.ttf";
  pathFontTTF[13] = prefixTTF+"GangBangCrime.ttf";
  pathFontTTF[14] = prefixTTF+"JuanitaITC.ttf";
  pathFontTTF[15] = prefixTTF+"Komikahuna.ttf";
  pathFontTTF[16] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[17] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[18] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[19] = prefixTTF+"3Hardway.ttf";
  pathFontTTF[20] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[21] = prefixTTF+"MinionWebPro.ttf";
  pathFontTTF[22] = prefixTTF+"MinionWebPro.ttf";
  // special font
  pathFontTTF[49] = prefixTTF+"FuturaStencil.ttf";
  // load
  AmericanTypewriter=loadFont      (pathFontVLW[1]);
  println(5) ;
  AmericanTypewriterBold=loadFont  (pathFontVLW[2]);
  Banco=loadFont                   (pathFontVLW[3]);
  Cinquenta=loadFont               (pathFontVLW[4]);
  ContainerRegular=loadFont        (pathFontVLW[5]);
  Diesel=loadFont                  (pathFontVLW[6]);
  Digital=loadFont                 (pathFontVLW[7]);
  DinRegular=loadFont              (pathFontVLW[8]);
  DinBold=loadFont                 (pathFontVLW[9]);
  EastBloc=loadFont                (pathFontVLW[10]);
  FuturaStencil=loadFont           (pathFontVLW[11]);
  FetteFraktur=loadFont            (pathFontVLW[12]);
  GangBangCrime=loadFont           (pathFontVLW[13]);
  JuanitaOutline=loadFont          (pathFontVLW[14]);
  Komikahuna=loadFont              (pathFontVLW[15]);
  Mesquite=loadFont                (pathFontVLW[16]);
  NanumBrush=loadFont              (pathFontVLW[17]);
  Rosewood=loadFont                (pathFontVLW[18]);
  TheHardwayRMX=loadFont           (pathFontVLW[19]);
  TokyoOne=loadFont                (pathFontVLW[20]);
  Minion=loadFont                  (pathFontVLW[21]);
  MinionBold=loadFont              (pathFontVLW[22]);

  // default and special font
  DinRegular10=loadFont            (pathFontVLW[49]);
  font[0] = FuturaStencil ;
  pathFontObjTTF[0] = pathFontTTF[0] ;
  // 
  println("font setup done") ;
}




void choiceFont( int whichOne)  { 
  if (whichOne == 1 )     { pathFontObjTTF[0] = pathFontTTF[1] ; font[0] = AmericanTypewriter ;  }
  else if (whichOne ==2 ) { pathFontObjTTF[0] = pathFontTTF[2] ; font[0] = AmericanTypewriterBold ; }
  else if (whichOne == 3) { pathFontObjTTF[0] = pathFontTTF[3] ; font[0] = Banco ; }
  else if (whichOne ==4)  { pathFontObjTTF[0] = pathFontTTF[4] ; font[0] = Cinquenta ; }
  else if (whichOne ==5)  { pathFontObjTTF[0] = pathFontTTF[5] ; font[0] = ContainerRegular ; }
  else if (whichOne ==6)  { pathFontObjTTF[0] = pathFontTTF[6] ; font[0] = Diesel ; }
  else if (whichOne ==7)  { pathFontObjTTF[0] = pathFontTTF[7] ; font[0] = Digital ; }
  else if (whichOne ==8)  { pathFontObjTTF[0] = pathFontTTF[8] ; font[0] = DinRegular ; }
  else if (whichOne ==9)  { pathFontObjTTF[0] = pathFontTTF[9] ; font[0] = DinBold ; }
  else if (whichOne ==10) { pathFontObjTTF[0] = pathFontTTF[10] ; font[0] = EastBloc ; }
  else if (whichOne ==11) { pathFontObjTTF[0] = pathFontTTF[11] ; font[0] = FetteFraktur ; }
  else if (whichOne ==12) { pathFontObjTTF[0] = pathFontTTF[12] ; font[0] = FuturaStencil ; }
  else if (whichOne ==13) { pathFontObjTTF[0] = pathFontTTF[13] ; font[0] = GangBangCrime ; }
  else if (whichOne ==14) { pathFontObjTTF[0] = pathFontTTF[14] ; font[0] = JuanitaOutline ; }   
  else if (whichOne ==15) { pathFontObjTTF[0] = pathFontTTF[15] ; font[0] = Komikahuna ; }
  else if (whichOne ==16) { pathFontObjTTF[0] = pathFontTTF[16] ; font[0] = Mesquite ; }
  else if (whichOne ==17) { pathFontObjTTF[0] = pathFontTTF[17] ; font[0] = Minion ; }
  else if (whichOne ==18) { pathFontObjTTF[0] = pathFontTTF[18] ; font[0] = MinionBold ; }
  else if (whichOne ==19) { pathFontObjTTF[0] = pathFontTTF[19] ; font[0] = NanumBrush ; }
  else if (whichOne ==20) { pathFontObjTTF[0] = pathFontTTF[20] ; font[0] = Rosewood ; }
  else if (whichOne ==21) { pathFontObjTTF[0] = pathFontTTF[21] ; font[0] = TheHardwayRMX ; }
  else if (whichOne ==22) { pathFontObjTTF[0] = pathFontTTF[22] ; font[0] = TokyoOne ; } 
  else                     { pathFontObjTTF[0] = pathFontTTF[49]  ; font[0] = AmericanTypewriter ; }
}
//END FONT




// END FONT and TEXT MANAGER
////////////////////////////