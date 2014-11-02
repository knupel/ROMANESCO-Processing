  ////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.0.1 / version 26 / made with Processing 304 ///
////////////////////////////////////////////////////////////////
String version = ("26") ;
String prettyVersion = ("1.0.1") ;
String nameVersion = ("Romanesco Unu") ;
boolean test = false ;

boolean openScene ;

PFont FuturaStencil, EmigreEight ;

import java.awt.* ;
GraphicsEnvironment g = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] devices = g.getScreenDevices();


color c1, c2, c3, c4 ;
color colorOUT, colorIN ;
String pathControleur;
String pathScene, pathMiroir;
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


void setup() {
  colorSetup() ;
  diplaySetup() ;
  OSMavericksCheck() ;
  
  structureSetup() ;
  loadSetup() ;
}
void draw() {
  frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Launcher");
  displayDraw() ;
  launcherDraw() ;
}
// END DRAW








//MOUSEPRESSED
void mousePressed() {
  //which type of SCENE display full screen or window
  //to re-init the button
  if (buttonFullscreen.inside || buttonWindow.inside || buttonScene.inside || buttonMiroir.inside) {
    buttonScene.OnOff = false ;
    buttonMiroir.OnOff = false ;
    buttonFullscreen.OnOff = false ;
    buttonWindow.OnOff = false ;
  }
  // after the re-init we can check what's happen on the button
  buttonScene.mouseClic() ;
  buttonMiroir.mouseClic() ;
  buttonFullscreen.mouseClic() ;
  buttonWindow.mouseClic() ;
  
  //which screen for the fullscreen mode
  if(buttonFullscreen.OnOff) whichScreenPressed() ;
  
  //button start
  buttonStart.mouseClic() ;
  if(buttonStart.OnOff ) {
    saveProperty() ;
    openApp(openScene) ;
  }
  buttonStart.OnOff = false ;
}


//MOUSELEASED
void mouseReleased() {
  if(buttonFullscreen.OnOff) whichScreenReleased() ;
}



//ANNEXE
