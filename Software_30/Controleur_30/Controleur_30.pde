/**
Romanesco Unu
2012 – 2017
pretty version 1.2.0.30
version 30
Processing 3.3
*/
/**
Controller 1.0.1

2015 may 4.100 
2016 september 8.700
 */
String version = ("30") ;
String IAM = ("Controller") ;
String prettyVersion = ("1.2.0") ;
String nameVersion = ("Romanesco unu") ;
boolean test = false ;
String preference_path, import_path  ;

void settings() {
  size(670,725);
  size_ref = Vec2(width,height) ;
}

void setup() {
  setting() ;
  init_button_general() ;
  init_midi() ;

  build_item_library() ;
  load_setup() ;

  select_camera_device(30, 100) ; // methode(int min_fps, int min_width)

  check_media_folder() ;

  set_font() ;
  set_display_slider() ;
  set_import_pic_button() ;
  set_slider() ;
  set_button_general() ;
  set_button_item_console() ;
  set_dropdown_general() ;
  set_dropdown_item_selected() ;


  build_button_general() ;
  build_button_item_console() ;
  build_button_item_list() ;
  build_slider() ;

  set_OSC() ;
  set_data_from_save() ;

  reset() ;
}

void draw() {
  check_interface() ;
  check_slider_item() ;
  check_media_folder() ;
  check_button() ;

  init_interface() ;
  init_live_data() ;
  
  surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Controller");

  set_data_from_save() ;

  display_structure_header() ;
  display_structure_top_button() ;
  display_structure_dropdown_menu_general() ;
  display_structure_general() ;
  display_structure_menu_sound() ;
  display_structure_item_selected() ;
  display_structure_item_list() ;

  display_text() ;

  display_slider_general() ;
  display_slider_item() ;
  display_button_and_dropdown() ;

  update_midi() ;
  draw_send_OSC() ;

  display_structure_bottom() ;

  reset() ;


  credit() ;
}



void mousePressed () {
  mousepressed_button_general() ;
  mousepressed_button_item_console() ;
  mousepressed_button_item_list() ;
  mousepressed_dropdown() ;
}

void keyPressed() {
  keypressed_midi() ;
  shortcuts_controller() ;
}


void keyReleased() { 
  key_false() ;
  keyboard[keyCode] = false;
}