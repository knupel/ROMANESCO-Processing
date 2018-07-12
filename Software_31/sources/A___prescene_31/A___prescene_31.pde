/**
Romanesco unu
2013 – 2018
release 31
Processing 3.3.7
*/
/**
2015 may 15_000 lines of code
2016 may 27_500 lines of code
2017 March 40_000 lines of code
 */
String IAM = "prescene";
/* 
Use false when you want:
used sound & maximum possibility of the object
*/
boolean USE_SOUND = true; 
boolean MIROIR = false;

boolean FULL_SCREEN = false;
boolean TABLET = false; // now tablet library don't work in OPENGL renderer
/**
LIVE must change from the launcher, the info must be write in the external loading preference app
*/
boolean LIVE = false;
boolean FULL_RENDERING = true;
boolean DEVELOPMENT_MODE = true;



void settings() {
  size(124,124,P3D); // when the bug will be resolved, return to this config.
  // fullScreen(P3D,2);
  // FULL_SCREEN = true;

  pixelDensity(displayDensity());
  syphon_settings();
}



void setup() {
  path_setting();
  version();
  set_system_specification();
  OSC_send_scene_setup();
  OSC_receive_controller_setup();
  display_setup(60); // the int value is the frameRate
  RG.init(this);  // Geomerative

  romanesco_build_item();

  create_variable();

  P3D_setup();
  //specific setup
  prescene_setup(); 
  leapmotion_setup();

  //common setup
  color_setup();
  syphon_setup();

  init_variable_item_min_max();
  init_variable_item();
  init_slider_variable_world();
  create_font();
  
  // SOUND LIGHT
  if(USE_SOUND) sound_setup();
  light_position_setup();
  light_setup();
  
}










boolean init_app;
void draw() {
  
  if(init_app) {
    romanesco();
    if(width == 1 || height == 1) {
      printErr("width:",width,"heigh:",height, "this window size is not usable the process is stoped,\nplease set preference size via the launcher or directly in file sceneProperty.csv");
      exit();
    }
  } else {
    if(FULL_RENDERING) shader_setup();
    init_app = items_loaded_is(); 
  }
}


void romanesco() {
  surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Préscène | FPS: "+round(frameRate));
  init_romanesco();
  if(FULL_RENDERING) start_PNG("screenshot Romanesco prescene", "Romanesco_"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()) ;

  syphon_draw() ;

  if(USE_SOUND) sound_draw();
  // OSC part
  if(LIVE) {
    if(mousePressed || keyPressed) {
      send_message(true);
    }
  }
  write_osc_event();
  join_osc_data();

  update_raw_item_value();

  background_romanesco();
  updateCommand();
  leapMotionUpdate();
  loadPrescene();

  //ROMANESCO
  camera_romanesco_draw();

  // LIGHT
  light_position_draw(mouse[0], wheel[0]); // not in the conditional because we need to display in the info box
  light_update_position_direction();
  if(FULL_RENDERING) {
    light_call_shader();
    light_display();
    shader_draw();
  }

  //use romanesco object
  rpe_manager.display_item(ORDER_ONE, ORDER_TWO, ORDER_THREE);
  grid_romanesco(displayInfo3D);
  stop_camera();

  //annexe
  info() ;
  // curtain
  if(FULL_RENDERING && !DEVELOPMENT_MODE) curtain();
  // save screenshot
  if(FULL_RENDERING) {
    save_PNG();
  }
  // this method is outside de bracket (FULL_RENDERING) to give the possibility to send the order to Scene
  if(key_p) event_PNG();

  // misc
  update_temp_value();
  device_update();

  // change to false if the information has be sent to Scene...but how ????
  if(LIVE) {
    if(send_message_is()) {
      OSC_send();
      send_message(false);
    }
  }
  key_false();
}













void keyPressed () {
  if(LIVE) send_message(true);
  shortCutsPrescene();
  nextPreviousKeypressed();
  key_true();
}


void keyReleased() {
  if(LIVE) send_message(true);
  key_long_false();
  keyboard[keyCode] = false;
}















void mousePressed() {
  if(LIVE) send_message(true);
  if(mouseButton == LEFT ) {
    clickShortLeft[0] = true;
    clickLongLeft[0] = true;
  }
  if (mouseButton == RIGHT ) {
    clickShortRight[0] = true;
    clickLongRight[0] = true;
  }
}

void mouseReleased() {
  if(LIVE) send_message(true);
  clickLongLeft[0] = false ;
  clickLongRight[0] = false ;
}

// Mouse in or out of the sketch
public void mouseEntered(MouseEvent e) {
  if(LIVE) send_message(true);
  MOUSE_IN_OUT = true ;
}

public void mouseExited(MouseEvent e) {
  if(LIVE) send_message(true);
  MOUSE_IN_OUT = false ;
}

void mouseWheel(MouseEvent e) {
  if(LIVE) send_message(true);
  wheel[0] = e.getCount() *speedWheel;
}
