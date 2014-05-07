import codeanticode.syphon.*;
import japplemenubar.*;
// remove menu bar apple
JAppleMenuBar instance;


// In the Miroir and Scene sketch presceneOnly must be true for the final work.
boolean presceneOnly = true ;
Boolean internet = true ;
String bigBrother = (" BIG BROTHER DON'T WATCHING YOU !!") ;

//specific at the Scene
String valueTempPreScene[] = new String [61] ;
//Special var for the Scene and the Miroir
PVector mouseCamera, pmouseCamera ; 




//Variable CLAVIER
boolean displayInfo ;

boolean savePDF ;
String savePathPDF, savePathPNG ;


void initVarScene() {
  mouseCamera = new PVector(0,0,0) ;
  pmouseCamera = new PVector(0,0,0) ;
}


//init var
void initDraw() {
  rectMode (CORNER) ; 
  if(mavericks && fullScreen) sketchPosition(whichScreen) ;
}



////////////////////
//SAVE SCENE PICTURE
void beginSave() {
    if (countSave == 1 ) savePDF = true ;
  if (savePDF) beginRecord(PDF, savePathPDF) ; 
}
void endSave() {
    //SAVE IMAGE END
  if (savePDF ) {
    endRecord();
    savePDF = false ;
    countSave = 0 ;
  }
}
void keySave() {
  if(key == 's' ) selectOutput("Enregistrez le PDF et le PNG ", "saveImg") ;
}



//GLOBAL
void varObjectSetup() {
  for (int i = 0 ; i < numObj ; i++ ) {
    startingPos[i] = new PVector(height/2, width/2, 0) ;
    pen[i] = new PVector() ;
    mouse[i] = new PVector(0,0,0) ;
    pmouse[i] = new PVector() ;
    wheel[i] = 0 ;
  }
}
