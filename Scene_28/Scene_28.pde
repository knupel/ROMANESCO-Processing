  ////////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.1.1 / version 28 / made with Processing 3.0b5 ///
////////////////////////////////////////////////////////////////////
/* 14.750 lines of code the 4th may !!!! */

String nameVersion = ("Romanesco Unu") ;
String IAM = ("Scene") ;
String version = ("27") ;
String prettyVersion = ("1.1.0") ;
String preferencesPath  ;
// security must be link with the controler in the next release


void settings() {
  size(256,256,P3D) ;
}




void setup() {
  camera_video_setup() ;
  preferencesPath = sketchPath("")+"preferences/" ;
  if(fullRendering) frameRateRomanesco = 60 ; else frameRateRomanesco = 15 ;
  romanescoSetup() ;
  RG.init(this); // GEOMERATIVE
  createVar() ;
  initVarScene() ;
  displaySetup(frameRateRomanesco) ; // the int give the frameRate
  colorSetup() ;
  // miroirSetup() ;
  fontSetup() ;

  soundSetup() ;
  variables_setup() ; // the varObject setup of the Scene is more simple
  OSCSetup() ;

  P3DSetup(modeP3D, numObj, numSettingCamera, numSettingOrientationObject) ;
  lightSetup(); 
  
}

//DRAW
void draw() {
  
  if(!syphon) surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Scéne | FPS: "+round(frameRate)); else frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Miroir | FPS: "+round(frameRate));
  initDraw() ;
  // miroirDraw() ;
  camera_video_draw() ;
  soundDraw() ;
  meteoDraw() ;
  updateVarRaw() ;
  backgroundRomanesco() ; 
  //shaderDraw() ; // maybe can disable the background shader
  loadScene() ;
  saveScene() ;
  
  //ROMANESCO
  cameraDraw() ;
  lightPosition() ;
  // lightDraw() ;
  romanescoManager.displayObject(ORDER_ONE, ORDER_TWO, ORDER_THREE) ;
  createGridCamera() ;
  stopCamera() ;
  
  //ANNEXE
  info() ;
  curtain() ;  
  updateVarTemp() ;

  nextPreviousKeypressed() ;
  init_value_temp_prescene() ;

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