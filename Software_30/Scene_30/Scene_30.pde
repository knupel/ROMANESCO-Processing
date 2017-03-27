/**
Romanesco Unu
2012 – 2017
pretty version 1.2.0 
version 30 
Processing 3.3.0
*/
/* 14.750 lines of code the 4th may !!!! */


String nameVersion = ("Romanesco unu") ;
String IAM = ("Scene") ;
String version = ("30") ;
String prettyVersion = ("1.2.0") ;
String preference_path, import_path ;
// security must be link with the controler in the next release
boolean TEST_ROMANESCO = false ;
boolean OPEN_APP = true ;
boolean TEST_FULL_SCREEN = false ;

boolean FULL_RENDERING = true ;
boolean FULL_SCREEN = false ;

boolean resize_bug = true ;


void settings() {
  // When you build Romanesco you must create two versions : fullscreen and normal
  // size(124,124,P3D) ; // when the bug will be resolved, return to this config.

  size(640,360,P3D) ; // 640
  // size(1024,576,P3D) ; // 1024
 //  size(1280,720,P3D) ; // 1280
 // size(1600,900,P3D) ; // 1600
  // size(1920,1080,P3D) ; // 1920
  // size(2560,1440) ; // 2560
  // size(3840,2160) ; // 3840

  // fullScreen(P3D,2) ;
 // FULL_SCREEN = true ;

  pixelDensity(displayDensity()) ;
  syphon_settings() ;
}




void setup() {
  OSC_setup() ;
  camera_video_setup() ;
  preference_path = sketchPath("")+"preferences/" ;
  import_path = sketchPath("")+"import/" ;

  /**
  // The fullscreen option from the external file is disable, because the fullScreen() method cannot be choice in second time, that be must the first line of programm
  // So I disable the line in loadPropertyScene() in display_setup()
  */
  int frameRateRomanesco = 60 ;
  display_setup(frameRateRomanesco) ; // the int give the frameRate

  if (!FULL_SCREEN && !resize_bug) {
    resize_scene() ;
  }

  romanesco_build_item() ;

  RG.init(this); // GEOMERATIVE
  
  P3D_setup() ; ;
  create_variable() ;

  color_setup() ;
  syphon_setup() ;

  init_variable_item_min_max() ;
  init_variable_item() ;
  init_items() ;
  
  create_font() ;

  if(!TEST_ROMANESCO) sound_setup() ;
  variables_setup() ; // the varObject setup of the Scene is more simple

  light_position_setup() ;
  light_setup() ;
  if(FULL_RENDERING) shader_setup() ;


}

//DRAW
void draw() {
  
  if(!syphon_on_off) surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Scéne | FPS: "+round(frameRate)); else frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Miroir | FPS: "+round(frameRate));
  if (!FULL_SCREEN && !resize_bug) resize_scene() ;
  init_RPE() ;
  if(FULL_RENDERING) start_PNG("screenshot Romanesco scene", "Romanesco_"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()) ;

  syphon_draw() ;
  if(!TEST_ROMANESCO) soundDraw() ;
  meteoDraw() ;
  update_OSC_data() ;

  update_raw_value() ;
  background_romanesco() ; 

  loadScene() ;
  saveScene() ;
  
  //ROMANESCO
  camera_romanesco_draw() ;
  // LIGHT
  light_position_draw(mouse[0], wheel[0]) ; // not in the conditional because we need to display in the info box
  light_update_position_direction() ;
  if(FULL_RENDERING) {
    light_call_shader() ;
    light_display() ;
    shader_draw() ;
  }

  rpe_manager.display_item(ORDER_ONE, ORDER_TWO, ORDER_THREE) ;
  createGridCamera(displayInfo3D) ;
  stopCamera() ;
  
  //ANNEXE
  info() ;
  curtain() ; 
  // save screenshot
  if(FULL_RENDERING) {
    save_PNG() ;
  }
  // this method is outside de bracket (FULL_RENDERING) to give the possibility to send the order to Scene
  if(pTouch) event_PNG() ;

  update_temp_value() ;

  nextPreviousKeypressed() ;
  init_value_temp_prescene() ;
  

  if(!controller_osc_is) message_opening() ;
  if (!miroir_on_off && OPEN_APP) {
    opening() ;
  }



  // TEST 
  if(TEST_FULL_SCREEN) {
    int c = int(map(mouseX,0,width,0,360)) ;
    fill(c,100,100,100) ;
    rect(0,0, width,height) ;
  }

  if(TEST_ROMANESCO) {
    printTempo(60, "TEST_ROMANESCO, printempo 60", frameCount) ;
  }

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