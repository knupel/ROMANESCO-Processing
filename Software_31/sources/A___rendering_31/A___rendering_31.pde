/**
ROMANESCO
romanesco dui rendering
2013–2018
release 31
Processing 3.4.0
*/

/**
* WARNING
* Is not possible to use method print when the prescene is used because the rendering prescene and scene is from the same sketch
* Using in print in DEV_MOD cause a crash.
*/

/**
2015 may 15_000 lines of code
2016 may 27_500 lines of code
2017 March 40_000 lines of code
*/
boolean DEV_MODE = true; 

/**
* RENDRING
* Here you can choice between the three common rendering mode
*/
 // Prescene full rendering
String IAM = "prescene";
boolean LIVE = false;
boolean FULL_RENDERING = true;


// Prescene control
/*
String IAM = "prescene";
boolean LIVE = true;
boolean FULL_RENDERING = false;
*/
/*
String IAM = "scene";
boolean LIVE = false;
boolean FULL_RENDERING = true;
*/







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

// DEV_MODE : rank folder, curtain, OSC thread




void settings() {
  size(124,124,P3D); // when the bug will be resolved, return to this config.
  // fullScreen(P3D,2);
  // FULL_SCREEN = true;

  pixelDensity(displayDensity());
  syphon_settings();

  if(IAM.equals("prescene")) {
    scene = false;
    prescene = true;
  } else if(IAM.equals("scene")) {
    OPEN_APP = true;
    scene = true;
    prescene = false;
  }
}



void setup() {
  path_setting();
  shader_folder_filter(preference_path+"shader/filter/");
  load_save(preference_path+"setting/defaultSetting.csv");
  version();
  set_system_specification();
  
  OSC_setup();

  display_setup(60); // the int value is the frameRate
  RG.init(this);  // Geomerative

  romanesco_build_item();

  create_variable();
  P3D_setup();

  if(IAM.equals("prescene")){
    prescene_setup(); 
    leapmotion_setup();
  } else if(IAM.equals("scene")) {
    scene_variables_setup();
  }

  color_setup();
  syphon_setup();

  init_variable_item_min_max();
  init_variable_item();
  init_slider_variable_world();
  create_font();
  
  if(USE_SOUND) sound_setup();

  light_position_setup();
  light_setup();

  init_filter();
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
  String title = nameVersion + " " +prettyVersion+"."+version+ " | "+ IAM + " | FPS: "+round(frameRate);
  if(MIROIR) title = nameVersion + " " +prettyVersion+"."+version+ " | "+ "miroir" + " | FPS: "+round(frameRate);
  surface.setTitle(title);
  init_romanesco();
  if(FULL_RENDERING) start_PNG("screenshot Romanesco prescene", "Romanesco_"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()) ;

  syphon_draw();

  if(USE_SOUND) sound_draw();

  OSC_update();

  update_raw_item_value();

  background_romanesco();
  
  if(IAM.equals("prescene")) {
    updateCommand();
    leapMotionUpdate();
    load_prescene();
  } else if (IAM.equals("scene")) {
    load_scene();
    save_scene();
  }
  


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
  rpe_manager.show_item_3D(ORDER_ONE, ORDER_TWO, ORDER_THREE);
  grid_romanesco(displayInfo3D);
  stop_camera();

  rpe_manager.show_item_2D();

  force();
  filter();


  //annexe
  info() ;
  // curtain
  if(FULL_RENDERING && !DEV_MODE) curtain();
  // save screenshot
  if(FULL_RENDERING) {
    save_PNG();
  }
  // this method is outside de bracket (FULL_RENDERING) to give the possibility to send the order to Scene
  if(key_p) event_PNG();

  // misc
  puppet_master(false); // use to resset puppet for the force field
  update_temp_value();
  media_update();
  nextPreviousKeypressed(); // check if this method is always used or not


  if(IAM.equals("scene")) {
    init_value_temp_prescene();
    if (!miroir_on_off && OPEN_APP) {
      opening();
    }
  } else if(IAM.equals("prescene")) {
    device_update();
    if(LIVE) {
      if(send_message_is()) {
        OSC_send();
        send_message(false);
      }
    }
  }

  
  if(IAM.equals("prescene")) {
    // change to false if the information has be sent to Scene...but how ????
    key_false();
  }

  if(!controller_osc_is) {
    background(0);
    message_opening();
  }
  
}












/**
EVENT
v 1.0.0
2014-2018
*/
void keyPressed () {
  if (key == 'i') displayInfo = !displayInfo;
  if (key == 'g') displayInfo3D = !displayInfo3D;

  if(IAM.equals("prescene")) {
    if(LIVE) {
      send_message(true);
    }
    shortCutsPrescene();
    nextPreviousKeypressed();
    key_true();
  }
}


void keyReleased() {
  if(IAM.equals("prescene")) {
    if(LIVE) {
      send_message(true);
    }
    key_long_false();
    keyboard[keyCode] = false;
  }
}




void mousePressed() {
  if(IAM.equals("prescene")) {
    if(LIVE) {
      send_message(true);
    }
    if(mouseButton == LEFT ) {
      clickShortLeft[0] = true;
      clickLongLeft[0] = true;
    }
    if (mouseButton == RIGHT ) {
      clickShortRight[0] = true;
      clickLongRight[0] = true;
    }
  }
}

void mouseReleased() {
  if(IAM.equals("prescene")){
    if(LIVE) {
      send_message(true);
    }
    clickLongLeft[0] = false;
    clickLongRight[0] = false;
  }
}

// Mouse in or out of the sketch
public void mouseEntered(MouseEvent e) {
  if(IAM.equals("prescene")){
    if(LIVE) {
      send_message(true);
    }
    MOUSE_IN_OUT = true ;
  }
}

public void mouseExited(MouseEvent e) {
  if(IAM.equals("prescene")) {
    if(LIVE) {
      send_message(true);
    }
    MOUSE_IN_OUT = false ;
  }
}

void mouseWheel(MouseEvent e) {
  if(IAM.equals("prescene")) {
    if(LIVE) {
      send_message(true);
    }
    wheel[0] = e.getCount() *speedWheel;
  } 
}
