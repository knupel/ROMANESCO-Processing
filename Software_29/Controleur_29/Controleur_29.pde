  ////////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.2.0 / version 29 / made with Processing 3.0.2 ///
////////////////////////////////////////////////////////////////////
/* 4.100 lines of code the 4th may 2015 !!!! */
String version = ("29") ;
String IAM = ("Controller") ;
String prettyVersion = ("1.2.0") ;
String nameVersion = ("Romanesco Unu") ;
boolean test = false ;
String preferencesPath  ;

void settings() {
  size(670,725);
  size_ref = Vec2(width,height) ;
}

void setup() {
  preferencesPath = sketchPath("")+"preferences/" ;
  setting() ;
  init_button_general() ;
  build_item_library() ;
  loadSetup() ;
  set_display_slider() ;
  check_image_folder() ;
  check_file_text_folder() ;
  select_camera_device(30, 100) ; // methode(int min_fps, int min_width)
  set_font() ;
  init_midi() ;
  set_import_pic_button() ;
  set_slider() ;
  set_button_general() ;
  set_button_item_console() ;
  set_var_dropdown() ;

  build_button_general() ;
  build_button_item_console() ;
  build_button_item_list() ;
  build_slider() ;

  set_item_list() ;

  set_OSC() ;
  set_data_from_save() ;
  INIT_INTERFACE = false ;
}


void draw() {
  init_interface() ;
  surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Controller");
  set_data_from_save() ;
  display_structure() ;
  check_slider_item() ;
  check_image_folder() ;
  check_file_text_folder() ;
  check_button() ;

  init_live_data() ;
  display_text() ;
  display_slider() ;
  display_button() ;

  update_midi() ;
  draw_send_OSC() ;
  init_slider_dynamic() ;

  finish_decoration() ;
  
  credit() ;
}



////////////////////

void mousePressed () {
  mousepressed_button_general() ;
  mousepressed_button_item_console() ;
  mousepressed_button_item_list() ;
  mousepressed_dropdown() ;
}




//KEYPRESSED
void keyPressed() {
  keypressed_midi() ;
  //OpenClose save
  shortcuts_controller() ;
}

//KEYRELEASED
void keyReleased() { 
  keyboard[keyCode] = false;
}