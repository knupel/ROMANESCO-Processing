  ////////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.2.0 / version 29 / made with Processing 3.0.2 ///
////////////////////////////////////////////////////////////////////
/* 14.750 lines of code the 4th may !!!! */


String nameVersion = ("Romanesco Unu") ;
String IAM = ("Scene") ;
String version = ("29") ;
String prettyVersion = ("1.2.0") ;
String preferencesPath  ;
// security must be link with the controler in the next release
boolean testRomanesco = false ;
boolean fullRendering = true ;


void settings() {
  // When you build Romanesco you must create two versions : fullscreen and normal
  //fullScreen(P3D,2) ;
  size(124,124,P3D) ;
  syphon_settings() ;
}




void setup() {
  camera_video_setup() ;
  preferencesPath = sketchPath("")+"preferences/" ;

  romanescoSetup() ;
  RG.init(this); // GEOMERATIVE
  createVar() ;
  initVarScene() ;
  int frameRateRomanesco = 60 ;
  displaySetup(frameRateRomanesco) ; // the int give the frameRate
  colorSetup() ;
  syphon_setup() ;
  fontSetup() ;

  if(!testRomanesco) soundSetup() ;
  variables_setup() ; // the varObject setup of the Scene is more simple
  OSCSetup() ;

  P3D_setup(numObj, numSettingCamera, numSettingOrientationObject) ;
  
  // Light and shader setup
  light_position_setup() ;
  light_setup() ;
  if(fullRendering) {
    shader_setup() ;
  }
  size_scene() ;
}

//DRAW
void draw() {
  if(!syphon_on_off) surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Scéne | FPS: "+round(frameRate)); else frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Miroir | FPS: "+round(frameRate));
  // size_scene() ;
  init_and_update_diplay_var() ;

  syphon_draw() ;
  camera_video_draw() ;
  if(!testRomanesco) soundDraw() ;
  meteoDraw() ;
  updateVarRaw() ;
  background_romanesco() ; 
  loadScene() ;
  saveScene() ;
  
  //ROMANESCO
  cameraDraw() ;
  // LIGHT
  light_position_draw(mouse[0], wheel[0]) ; // not in the conditional because we need to display in the info box
  light_update_position_direction() ;
  if(fullRendering) {
    light_call_shader() ;
    light_display() ;
    shader_draw() ;
  }

  romanescoManager.displayObject(ORDER_ONE, ORDER_TWO, ORDER_THREE) ;
  createGridCamera(displayInfo3D) ;
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
  if (key == 'y') syphon_on_off = !syphon_on_off ;
}