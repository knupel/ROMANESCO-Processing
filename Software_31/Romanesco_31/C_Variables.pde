


PVector pos_local_adress = new PVector(10,180) ;
PVector pos_name_version = new PVector(10.0, 23.0) ;
PVector pos_pretty_version = new PVector(205.0, 23.0) ;
PVector pos_choice = new PVector(10.0, 60.0) ;


int num_renderer = 3 ;
//Home / Live / Mirror



//which size for window
PVector posSliderWidth = new PVector(10, 134) ;
PVector posMoletteWidth = posSliderWidth ;
PVector posSliderHeight = new PVector(200, 134) ;
PVector posMoletteHeight = posSliderHeight ;
PVector sizeSlider = new PVector (180, 16 ) ;
//button start
/*
PVector posButtonStart = new PVector (10, 190) ;
PVector sizeButtonStart = new PVector (210, 20) ;
*/
// "X" and  "Y" componant give the button position    "Z" componant = space between the button
PVector posWhichScreenButton = new PVector (150, 100, 23) ;

int [] standard_format_for_Processing_bug = {0,640,1024,1280,1600,1920,2560,3840} ;

int [] standard_size_width = {160,240,320,480,640,800,964,1024,1280,1344,1366,1400,1440,1600,1680,1920,2048,2560,2880,3840,4096,5120,6400,7680,8192,16384} ;
int [] standard_size_height = {120,160,240,320,480,544,576,600,640,720,768,800,900,960,1000,1008,1024,1050,1080,1200,1536,1600,1800,2048,2304,2400,2880,3072,4096,4320,4800,6144,12288} ;




boolean test = false ;


PFont FuturaStencil, EmigreEight ;

import java.awt.* ;
GraphicsEnvironment g = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] devices = g.getScreenDevices();


color c1, c2, c3, c4 ;
color colorOUT, colorIN ;

// path
String path_controller;
String path_prescene ;
String path_prescene_window, path_prescene_fullscreen ;
String path_scene ;
String path_scene_window, path_scene_fullscreen ;

boolean open ;

//
String screen = ("") ; // for the saved table information
String bool_open_scene = ("") ; // for the saved table information
// Button buttonScene, buttonMiroir  ;

Button [] renderer = new Button [num_renderer] ;
boolean [] renderer_setting = new boolean[num_renderer] ;

Button buttonWindow, buttonFullscreen  ;

//which screen var
Button [] whichScreenButton ;
//slider var
Slider sliderWidth, sliderHeight ;
int heightSlider =1 ;
int widthSlider = 1 ;
//which mode rendering
Button [] whichModeButton ;
//Button start
Button buttonStart ;