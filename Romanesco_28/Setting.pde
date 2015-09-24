


PVector pos_local_adress = new PVector(10,180) ;
PVector pos_name_version = new PVector(10.0, 23.0) ;
PVector pos_pretty_version = new PVector(205.0, 23.0) ;
PVector pos_choice = new PVector(10.0, 60.0) ;


//which size SCENE for the MIROIR
PVector posButtonScene = new PVector ( 99, 40 ) ;
PVector sizeButtonScene = new PVector ( 85, 20 ) ;
PVector posButtonMiroir = new PVector ( 210, 40 ) ;
PVector sizeButtonMiroir = new PVector ( 85, 20 ) ;
//which size WINDOW or FULL SCREEN
PVector posButtonWindow = new PVector ( 10, 70 ) ;
PVector sizeButtonWindow = new PVector ( 180, 20 ) ;
PVector posButtonFullscreen = new PVector ( 200, 70 ) ;
PVector sizeButtonFullscreen = new PVector ( 180, 20 ) ;
//which size for window
PVector posSliderWidth = new PVector( 10, 134 ) ;
PVector posMoletteWidth = posSliderWidth ;
PVector posSliderHeight = new PVector( 200, 134 ) ;
PVector posMoletteHeight = posSliderHeight ;
PVector sizeSlider = new PVector ( 180, 16 ) ;
//button start
PVector posButtonStart = new PVector (10, 190) ;
PVector sizeButtonStart = new PVector (210, 20 ) ;
// "X" and  "Y" componant give the button position    "Z" componant = space between the button
PVector posWhichScreenButton = new PVector (150, 100, 23 ) ;

int [] standardSizeWidth = {0,160,240,320,480,640,800,964,1024,1280,1344,1366,1400,1600,1920,2048,2560,3840,4096,5120,6400,7680,8192,16384} ;
int [] standardSizeHeight = {0,120,160,240,320,480,544,576,600,720,768,800,960,1000,1008,1024,1050,1080,1200,1536,2048,2400,3072,4096,4320,4800,6144,12288} ;




boolean test = false ;

boolean openScene ;

PFont FuturaStencil, EmigreEight ;

import java.awt.* ;
GraphicsEnvironment g = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] devices = g.getScreenDevices();


color c1, c2, c3, c4 ;
color colorOUT, colorIN ;
String pathControleur;
String pathPrescene, pathScene, pathScene_window, pathScene_fullscreen;
boolean open ;

//
String screen = ("") ; // for the saved table information
String whichAppOpeningTheScene = ("") ; // for the saved table information
Button buttonScene, buttonMiroir  ;
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