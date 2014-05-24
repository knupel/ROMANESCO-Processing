///////////////////////
// GLOBAL SETTING ////
/////////////////////
import codeanticode.tablet.*;


boolean scene = false ;
boolean prescene = true ;

//to opening app
boolean openScene = true ;
boolean openMiroir = true ;
boolean openControleur = true ;
//send to the other sketches
boolean youCanSendToScene = true ;
boolean youCanSendToMiroir = true ;

//Web cam activity
// boolean cameraOnOff = false ;
//internet connection
Boolean internet = true ;
String bigBrother = ("BIG BROTHER DON'T WATCHING YOU !!") ;





//fenêtre texte
//String texte ;
//Variable CLAVIER



//PDF save picture

boolean savePDF ;
String savePathPDF, savePathPNG ;



Tablet tablet;
PVector cursorRef = new PVector() ;
void presceneSetup() {
  leap = new com.leapmotion.leap.Controller();
  tablet = new Tablet(this);
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
  if ( resizableByImgDrop && displaySizeByImage ) updateSizeDisplay(imgDefault) ;
  

}
