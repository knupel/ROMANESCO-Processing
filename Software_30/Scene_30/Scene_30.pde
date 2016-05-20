  ////////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.2.0 / version 30 / made with Processing 3.1.1 ///
////////////////////////////////////////////////////////////////////
/* 14.750 lines of code the 4th may !!!! */


String nameVersion = ("Romanesco Unu") ;
String IAM = ("Scene") ;
String version = ("30") ;
String prettyVersion = ("1.2.0") ;
String preference_path, import_path ;
// security must be link with the controler in the next release
boolean TEST_ROMANESCO = false ;
boolean FULL_RENDERING = true ;
boolean FULL_SCREEN = false ;


void settings() {
  // When you build Romanesco you must create two versions : fullscreen and normal
  
  //fullScreen(P3D,2) ;
  size(124,124,P3D) ;
  pixelDensity(displayDensity()) ;
  syphon_settings() ;
}




void setup() {
  // if(TEST_ROMANESCO) FULL_SCREEN = true ;
  
  camera_video_setup() ;
  preference_path = sketchPath("")+"preferences/" ;
  import_path = sketchPath("")+"import/" ;
  int frameRateRomanesco = 60 ;
  display_setup(frameRateRomanesco) ; // the int give the frameRate
  if (!FULL_SCREEN) size_scene() ;

  romanesco_setup() ;

  RG.init(this); // GEOMERATIVE
  
  P3D_setup(numObj, numSettingCamera, numSettingOrientationObject) ;
  create_variable() ;

  color_setup() ;
  syphon_setup() ;

  init_variable_item_min_max() ;
  
  font_setup() ;

  if(!TEST_ROMANESCO) soundSetup() ;
  variables_setup() ; // the varObject setup of the Scene is more simple


  
  // LIGHT AND SHADER
  light_position_setup() ;
  light_setup() ;
  if(FULL_RENDERING) shader_setup() ;

  OSC_setup() ;
}

//DRAW
void draw() {
  if(!syphon_on_off) surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Scéne | FPS: "+round(frameRate)); else frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Miroir | FPS: "+round(frameRate));
  if (!FULL_SCREEN) size_scene() ;
  init_and_update_diplay_var() ;

  syphon_draw() ;
  camera_video_draw() ;
  if(!TEST_ROMANESCO) soundDraw() ;
  meteoDraw() ;
  update_OSC_data() ;
  update_raw_value() ;
  background_romanesco() ; 

  loadScene() ;
  saveScene() ;
  
  //ROMANESCO
  cameraDraw() ;
  // LIGHT
  light_position_draw(mouse[0], wheel[0]) ; // not in the conditional because we need to display in the info box
  light_update_position_direction() ;
  if(FULL_RENDERING) {
    light_call_shader() ;
    light_display() ;
    shader_draw() ;
  }

  rpe_manager.displayObject(ORDER_ONE, ORDER_TWO, ORDER_THREE) ;
  createGridCamera(displayInfo3D) ;
  stopCamera() ;
  
  //ANNEXE
  info() ;
  curtain() ;  
  update_temp_value() ;

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