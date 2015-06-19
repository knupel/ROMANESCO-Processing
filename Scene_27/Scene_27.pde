  //////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.0.2 / version 27 / made with Processing 305 ///
//////////////////////////////////////////////////////////////////
/* 14.750 lines of code the 4th may !!!! */

String nameVersion = ("Romanesco Unu") ;
String IAM = ("Scene") ;
String version = ("27") ;
String prettyVersion = ("1.0.2") ;
String preferencesPath = sketchPath("")+"preferences/" ;
// security must be link with the controler in the next release




void setup() {
  if(fullRendering) frameRateRomanesco = 60 ; else frameRateRomanesco = 15 ;
  romanescoSetup() ;
  RG.init(this); // GEOMERATIVE
  createVar() ;
  initVarScene() ;
  displaySetup(frameRateRomanesco) ; // the int give the frameRate
  colorSetup() ;
  miroirSetup() ;
  fontSetup() ;

  soundSetup() ;
  varObjectSetup() ; // the varObject setup of the Scene is more simple
  OSCSetup() ;

  P3DSetup(modeP3D, numObj, numSettingCamera, numSettingOrientationObject) ;
  lightSetup(); 
  
}

//DRAW
void draw() {
  
  if(!syphon) frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Scéne | FPS: "+round(frameRate)); else frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Miroir | FPS: "+round(frameRate));
  initDraw() ;
  miroirDraw() ;
  soundDraw() ;
  // OSCDraw() ;
  meteoDraw() ;
  updateVarRaw() ;
  backgroundRomanesco() ; 
  shaderDraw() ; // maybe can disable the background shader
  loadScene() ;
  saveScene() ;
  
  //ROMANESCO
  cameraDraw() ;
  lightPosition() ;
  lightDraw() ;
  romanescoManager.displayObject(ORDER_ONE, ORDER_TWO, ORDER_THREE) ;
  if(modeP3D) createGridCamera() ;
  stopCamera() ;
  
  //ANNEXE
  info() ;
  curtain() ;  
  updateVarTemp() ;

  nextPreviousKeypressed() ;

}
//END DRAW

/////KEY/////
//KEYPRESSED
void keyPressed () {
 // info common command with Prescene
  if (key == 'i') displayInfo = !displayInfo ;
  if (key == 'g') displayInfo3D = !displayInfo3D ;
  if (key == 'y') syphon = !syphon ;
}
