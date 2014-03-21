  //////////////////////////////////////////////////////////////////////////////////////////
 // Romanesco Préscène Alpha 0.25 work with Processing 211 export with Processing 203  ////
//////////////////////////////////////////////////////////////////////////////////////////

// when you work only with prescene presceneOnly is true, on Prescene in the sketch Prescene
//but in the Miroir and Scene sketch presceneOnly must be true for the final work.
boolean presceneOnly = true ;
//spectrum for the color mode and more if you need
PVector HSBmode = new PVector (360,100,100) ; // give the color mode in HSB
//path to open the controleur
String findPath ; 

//MANAGER CLASS
import java.util.Iterator;
import java.lang.reflect.*; 
ObjectRomanescoManager romanescoManager ;

void setup() {
  romanescoSetup() ;
  createVar() ;
  displaySetup(60) ; // the int give the frameRate
  miroirSetup() ;
  //dropping image from folder on the Scène
  drop = new SDrop(this);
  //load font
  fontSetup() ;
  //GEOMERATIVE
  RG.init(this);

  soundSetup() ;
  cursorSetup() ; // the cursor setup of the Prescene is more complexe
  OSCSetup() ;
  meteoSetup() ;
  P3DSetup() ;
  lightSetup(); // for the Scene only
}

//DRAW
void draw() {
  initDraw() ;
  miroirDraw() ;
  soundDraw() ;
  OSCDraw() ;
  meteoDraw() ;
  updateVar() ;
  backgroundRomanesco() ;
  
  beginSave() ;
  //ROMANESCO
  cameraDraw() ;
  lightDraw() ;
  romanescoManager.displayObject() ;
  stopCamera() ;
  
  endSave() ;
  curtain() ;  
  
  nextPreviousKeypressed() ;
}
//END DRAW

/////KEY/////
//KEYPRESSED
void keyPressed () {
  keySave() ;
}
