  ///////////////////////////////////////////////////////////////
 // Romanesco Préscène Alpha 0.25 work with Processing 211  ////
///////////////////////////////////////////////////////////////
// romanesco release, change this number to open the app
String release =("25") ;
boolean testLauncher = false ;

boolean openScene ;

PFont FuturaStencil ;

import java.awt.* ;
GraphicsEnvironment g = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] devices = g.getScreenDevices();

color gris, grisClair, grisFonce, orange, rouge, vertClair, vertFonce ;
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
int heightSlider, widthSlider ;
//which mode rendering
Button [] whichModeButton ;
//Button start
Button buttonStart ;

Table table;

void setup() {
  diplaySetup() ;
  colorSetup() ;
  structureSetup() ;
  loadSetup() ;
}
void draw() {
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
  if(buttonStart.OnOff ) openApp(openScene) ;
  buttonStart.OnOff = false ;
}


//MOUSELEASED
void mouseReleased() {
  //which Screen display
  if(buttonFullscreen.OnOff) whichScreenReleased() ;
  
  setTable() ;
}



//ANNEXE
