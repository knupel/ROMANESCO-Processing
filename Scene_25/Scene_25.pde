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
  // we must write the void loadLiveData, after OSCDraw in cas where the OSC send a file Image or Text don't exist in the Scene or Prescene Folder
  loadLiveData() ; 
  meteoDraw() ;
  updateVar() ;
  backgroundRomanesco(true) ; // the boolean give the authorization do display the shader
  
  beginSave() ;
  //ROMANESCO
  cameraDraw() ;
  lightDraw() ;
  romanescoManager.displayObject() ;
  stopCamera() ;
  
  //ANNEXE
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
