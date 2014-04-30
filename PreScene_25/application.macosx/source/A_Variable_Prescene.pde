///////////////////////
// GLOBAL SETTING ////
/////////////////////
import codeanticode.tablet.*;




//Web cam activity
// boolean cameraOnOff = false ;
//internet connection
Boolean internet = true ;
String bigBrother = ("BIG BROTHER DON'T WATCHING YOU !!") ;





//fenêtre texte
String texte ;
//Variable CLAVIER



//PDF save picture

boolean savePDF ;
String savePathPDF, savePathPNG ;



Tablet tablet;
PVector cursorRef = new PVector() ;

//SETUP
void varObjectSetup() {
  //LEAP MOTION
  leap = new com.leapmotion.leap.Controller();
  //TABLET
  tablet = new Tablet(this);
  for (int i = 0 ; i < numObj ; i++ ) {
    startingPos[i] = new PVector(height/2, width/2, 0) ;
    pen[i] = new PVector() ;
    // use the 250 value for "z" to keep the position light on the front
    mouse[i] = new PVector(0,0,250) ;
    pmouse[i] = new PVector() ;
    wheel[i] = 0 ;
  }
}








//OPENING the other window
void opening() {
    //OPEN CONTROLEUR and SCENE or MIROIR
  if (!testRomanesco && openControleur) {
    fill(blanc) ;
    stroke(blanc) ;
    textSize(28 ) ;
    text("Take your time, smoke a cigarette", 50,height/2 ) ;
  }
  if (!testRomanesco) { 
    if (openControleur) { open(sketchPath("")+"Controleur_"+release+".app") ; openControleur = false ; } 
    if (openScene)      { open(sketchPath("")+"Scene_"+release+".app") ; openScene = false ; }
    testRomanesco = true ;
  }
}


//INIT in real time and re-init the default setting of the display window


void initDraw() {
  //Default display shape and text
  rectMode (CORNER) ; 
  textAlign(LEFT) ;
  //SCENE ATTRIBUT
  //  if (fullScreen ) sketchPos(0,0, myScreenToDisplayMySketch) ; 
  
  //change the size of displaying if you load an image or a new image
  resizableByImgDrop = true ;
  if ( resizableByImgDrop && displaySizeByImage ) updateSizeDisplay(img) ;
  
  //load text raw for the different object
  importText(preferencesPath+"karaoke/karaoke.txt") ;
  splitText() ;
}









//INFO
void displayInfo3D() {
   String posCam = ( int(sceneCamera.x +width/2) + " / " + int(sceneCamera.y +height/2) + " / " +  int(sceneCamera.z -height/2)) ;
   String eyeDirectionCam = ( int(eyeCamera.x) + " / " + int(eyeCamera.y) ) ;
  fill(blanc) ; 
  textFont(SansSerif10, 10) ;
  textAlign(RIGHT) ;
  text("Position " +posCam, width/2 -30 , height/2 -30) ;
  text("Direction " +eyeDirectionCam, width/2 -30 , height/2 -15) ;
}
