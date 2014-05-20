  //////////////////////////////////////////////////////////////////////////////////////////
 // Romanesco Préscène Alpha 0.25 work with Processing 211 export with Processing 203  ////
//////////////////////////////////////////////////////////////////////////////////////////
String release =("25") ;
String preferencesPath = sketchPath("")+"preferences/" ;
// security must be link with the controler in the next release
int levelSecurity = 200 ;




void setup() {
  romanescoSetup() ;
  // OSMavericksCheck() ;
  createVar() ;
  initVarScene() ;
  displaySetup(60) ; // the int give the frameRate
  colorSetup() ;
  miroirSetup() ;
  //dropping image from folder on the Scène
  drop = new SDrop(this);
  //load font
  fontSetup() ;
  //GEOMERATIVE
  RG.init(this);

  soundSetup() ;
  varObjectSetup() ; // the varObject setup of the Scene is more simple
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
  backgroundRomanesco(true) ; // the boolean give the authorization do display the shader
  
  beginSave() ;
  //ROMANESCO
  cameraDraw() ;
  lightPosition() ;
  lightDraw() ;
  romanescoManager.displayObject() ;
  repereCamera(sizeBackgroundP3D) ;
  stopCamera() ;
  
  //ANNEXE
  endSave() ;
  info() ;
  curtain() ;  

  nextPreviousKeypressed() ;
}
//END DRAW

/////KEY/////
//KEYPRESSED
void keyPressed () {
  keySave() ;
 // info common command with Prescene
  if (key == 'i') displayInfo = !displayInfo ;
  if (key == 'g') displayInfo3D = !displayInfo3D ;
}
