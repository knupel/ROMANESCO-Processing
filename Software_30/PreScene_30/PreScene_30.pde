
  ////////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.2.0 / version 30 / made with Processing 3.2.4 ///
////////////////////////////////////////////////////////////////////
/**
Scene - Prescene 1.2.0.7

2015 may 15.000 lines
2016 may 27.500 lines of code the 4th may 2016 !!!!
 */

String version = ("30") ;
String IAM = ("Prescene") ;
String prettyVersion = ("1.2.0") ;
String nameVersion = ("Romanesco Unu") ;
String preference_path, import_path ;


/*
Use true when you want 
display color
used sound
 maximum possibility of the object
 full frame rate
*/
boolean TEST_ROMANESCO = false ;
boolean FULL_RENDERING = true ;
boolean TABLET = false ; // now tablet library don't work in OPENGL renderer

boolean HOME = true ;

void settings() {
  // size(600,400,P3D) ;
  // size(1200,700,P3D) ;
  fullScreen(P3D,2) ;
  pixelDensity(displayDensity()) ;
  syphon_settings() ;
}

  
void setup() {
  preference_path = sketchPath("")+"preferences/" ;
  import_path = sketchPath("")+"import/" ;
  
  OSC_setup() ;
  camera_video_setup() ;
  display_setup(60) ; // the int value is the frameRate
  RG.init(this);  // Geomerative

  romanesco_build_item() ;

  create_variable() ;

  P3D_setup() ;
  //specific setup
  prescene_setup() ; // the varObject setup of the Scene is more simple
  leapmotion_setup() ;
  
  //common setup
  color_setup() ;
  syphon_setup() ;

  init_variable_item_min_max() ; 
  init_variable_item() ;
  init_items() ;

  create_font() ;

  // here we ask for the TEST_ROMANESCO true, because the Minim Library talk too much in the consol
  if(!TEST_ROMANESCO) sound_setup() ;
 //  P3D_setup(numObj, numSettingCamera, numSettingOrientationObject) ;
  // Light and shader setup
  light_position_setup() ;
  light_setup() ;
  if(FULL_RENDERING) shader_setup() ;
}



//DRAW
void draw() {
  surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Préscène | FPS: "+round(frameRate));
  init_RPE() ;
  if(FULL_RENDERING) start_PNG("screenshot Romanesco prescene", "Romanesco_"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()) ;

  syphon_draw() ;
  camera_video_draw() ;
  // here we ask for the TEST_ROMANESCO true, because the Minim Library talk too much in the consol
  if(!TEST_ROMANESCO) soundDraw() ;
  
  update_OSC_data_controller() ;

  // if(keyboard_new_event) {
    write_osc_keyboard_short_event() ;
 //   keyboard_new_event = false ;
 //  }
  write_osc_other_event() ;
  join_osc_data() ;

  update_raw_value() ;

  background_romanesco() ;
  updateCommand() ;
  leapMotionUpdate() ;
  loadPrescene() ;
  
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


  //use romanesco object
  rpe_manager.display_item(ORDER_ONE, ORDER_TWO, ORDER_THREE) ;
  createGridCamera(displayInfo3D) ;
  stopCamera() ;

  
  //annexe
  info() ;
  // curtain
  if(FULL_RENDERING && !TEST_ROMANESCO) curtain() ;
  // save screenshot
  if(FULL_RENDERING) {
    save_PNG() ;
  }
  // this method is outside de bracket (FULL_RENDERING) to give the possibility to send the order to Scene
  if(pTouch) event_PNG() ;
  
  // misc
  update_temp_value() ;
  device_update() ;
  
  // change to false if the information has be sent to Scene...but how ????
  OSC_send() ;
  keyboardFalse() ;
}

//END DRAW
// boolean keyboard_new_event = false ;



//
void keyPressed () {
 // keyboard_new_event = true ;
  shortCutsPrescene() ;
  nextPreviousKeypressed() ;
  keyboardTrue() ;
}
//
void keyReleased() {
  //special touch need to be long
  keyboardLongFalse() ;
  keyboard[keyCode] = false ;
}




// 
void mousePressed() {
  if(mouseButton == LEFT ) { 
    clickShortLeft[0] = true ; 
    clickLongLeft[0] = true ;
  }
  if (mouseButton == RIGHT ) {
    clickShortRight[0] = true ; 
    clickLongRight[0] = true ;
  }
}
//
void mouseReleased() {
  clickLongLeft[0] = false ; 
  clickLongRight[0] = false ;
}

// Mouse in or out of the sketch
public void mouseEntered(MouseEvent e) {
  MOUSE_IN_OUT = true ;
}

public void mouseExited(MouseEvent e) {
  MOUSE_IN_OUT = false ;
}



//MOUSE WHEEL
void mouseWheel(MouseEvent event) {
  wheel[0] = event.getCount() *speedWheel ; 
}
//END MOUSEWHEEL