/**
Romanesco Unu
2013 – 2018
version 1.2.1 
release 31 
Processing 3.3.7
*/
/**
Scene - Prescene 1.3.0

2015 may 15_000 lines of code
2016 may 27_500 lines of code
2017 March 40_000 lines of code
 */

String version = "31";
String IAM = "Prescene";
String prettyVersion = "1.3.0";
String nameVersion = "Romanesco unu";




boolean TEST_ROMANESCO = false; /* Use true when you want:
                                    display color
                                    used sound
                                    maximum possibility of the object
                                    full frame rate
                                    and resize window
                                  */
boolean FULL_RENDERING = false;
boolean TABLET = false; // now tablet library don't work in OPENGL renderer

boolean HOME = false;
/**
SETTINGS
*/
void settings() {
  size(124,124,P3D) ; // when the bug will be resolved, return to this config.
  
  // size(550,350,P3D) ; // PREVIEWccc
  // size(1280,720,P3D) ; // 1280
  // fullScreen(P3D,2);
  pixelDensity(displayDensity()) ;
  syphon_settings() ;
}






/**
SETUP
*/
void setup() {
  /**
  futur bug
  sketchPath("") or sketchPath() or sketchPath(1)
  */
  preference_path = sketchPath(1)+"/preferences/";
  import_path = sketchPath(1)+"/import/";
  items_path = sketchPath(1)+"/items/";

  println("preference_path",preference_path);
  println("import_path",import_path);
  println("items_path",items_path);

  
  OSC_setup();
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



/**
DRAW
*/
void draw() {
  surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Préscène | FPS: "+round(frameRate));
  init_romanesco();
  if(FULL_RENDERING) start_PNG("screenshot Romanesco prescene", "Romanesco_"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()) ;

  syphon_draw() ;
  // video_camera() ;
  // camera_video_draw() ;
  // here we ask for the TEST_ROMANESCO true, because the Minim Library talk too much in the consol
  if(!TEST_ROMANESCO) sound_draw();
  
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
// boolean keyboard_new_event = false ;












/**
KEY 
*/
void keyPressed () {
 // keyboard_new_event = true ;
  shortCutsPrescene() ;
  nextPreviousKeypressed() ;
  keyboardTrue() ;
}


void keyReleased() {
  //special touch need to be long
  keyboardLongFalse() ;
  keyboard[keyCode] = false ;
}









/**
MOUSE 
*/
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







