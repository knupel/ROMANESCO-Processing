/**
Romanesco Unu
2012–2018
version 31
Processing 3.3.7
4th may 2015 14.750 lines of code 
*/
String IAM = ("Scene") ;
// security must be link with the controler in the next release
boolean USE_SOUND = true; 
boolean DEVELOPMENT_MODE = false;
boolean OPEN_APP = true ;
boolean TEST_FULL_SCREEN = false ;

boolean FULL_RENDERING = true ;
boolean FULL_SCREEN = false ;



void settings() {
  // When you build Romanesco you must create two versions : fullscreen and normal
  size(124,124,P3D);
  // fullScreen(P3D,2) ;
  FULL_SCREEN = true ;

  pixelDensity(displayDensity()) ;
  syphon_settings() ;
}




void setup() {
  OSC_receive_prescene_setup();
  OSC_receive_controller_setup();
  
  path_setting();
  version();
  set_system_specification();

  int frameRateRomanesco = 60 ;
  display_setup(frameRateRomanesco) ; // the int give the frameRate

  if (!FULL_SCREEN) {
    resize_scene();
  }

  romanesco_build_item();

  RG.init(this); // GEOMERATIVE
  
  P3D_setup();
  create_variable();

  color_setup();
  syphon_setup();

  init_variable_item_min_max();
  init_variable_item();
  init_items();
  // init_slider_variable_world(); // maybe not necessary on Scene sketch
  
  create_font();

  if(USE_SOUND) sound_setup();
  variables_setup(); // the varObject setup of the Scene is more simple

  light_position_setup();
  light_setup();
  if(FULL_RENDERING) shader_setup();
}

/**
DRAW
*/
boolean init_app;
void draw() {
  if(init_app) {
    romanesco();
  } else {
    init_app = true;
  }
}


void romanesco() {
  
  if(!syphon_on_off) surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Scéne | FPS: "+round(frameRate)); else frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Miroir | FPS: "+round(frameRate));
  if (!FULL_SCREEN) resize_scene() ;
  init_romanesco();
  if(FULL_RENDERING) start_PNG("screenshot Romanesco scene", "Romanesco_"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()) ;

  syphon_draw() ;
  if(USE_SOUND) sound_draw();

  update_OSC_data() ;

  update_raw_item_value() ;
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
  grid_romanesco(displayInfo3D) ;
  stop_camera();
  
  //ANNEXE
  info() ;
  curtain() ; 
  // save screenshot
  if(FULL_RENDERING) {
    save_PNG() ;
  }
  // this method is outside de bracket (FULL_RENDERING) to give the possibility to send the order to Scene
  if(key_p) event_PNG() ;

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

}






/**
KEYPRESSED
*/
void keyPressed () {
 // info common command with Prescene
  if (key == 'i') displayInfo = !displayInfo ;
  if (key == 'g') displayInfo3D = !displayInfo3D ;
  if (key == 'y') syphon_on_off = !syphon_on_off ;
}