  ////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.0.2 / version 27 / made with Processing 305 ///
////////////////////////////////////////////////////////////////
String nameVersion = ("Romanesco Unu") ;
String version = ("27") ;
String prettyVersion = ("1.0.2") ;
String preferencesPath = sketchPath("")+"preferences/" ;
// security must be link with the controler in the next release




void setup() {
  
  romanescoSetup() ;
  createVar() ;
  initVarScene() ;
  displaySetup(60) ; // the int give the frameRate
  colorSetup() ;
  miroirSetup() ;
  fontSetup() ;
  //GEOMERATIVE
  RG.init(this);

  soundSetup() ;
  varObjectSetup() ; // the varObject setup of the Scene is more simple
  OSCSetup() ;

  P3DSetup(modeP3D, numObj, numSettingCamera, numSettingOrientationObject) ;
  lightSetup(); // for the Scene only
  
  // module
  // meteoSetup() ;
  
  //option
  // OSMavericksCheck() 

}

//DRAW
void draw() {
  
  if(!syphon) frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Scene"); else frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Miroir");
  initDraw() ;
  miroirDraw() ;
  soundDraw() ;
  OSCDraw() ;
  meteoDraw() ;
  updateVar() ;
  backgroundRomanesco() ; 
  
  //ROMANESCO
  cameraDraw() ;
  lightPosition() ;
  lightDraw() ;
  romanescoManager.displayObject(ORDER_ONE, ORDER_TWO, ORDER_THREE) ;
  repereCamera(sizeBackgroundP3D) ;
  stopCamera() ;
  
  //ANNEXE
  info() ;
  curtain() ;  

  nextPreviousKeypressed() ;

}
//END DRAW

/////KEY/////
//KEYPRESSED
void keyPressed () {
 // info common command with Prescene
  if (key == 'i') displayInfo = !displayInfo ;
  if (key == 'g') displayInfo3D = !displayInfo3D ;
}
