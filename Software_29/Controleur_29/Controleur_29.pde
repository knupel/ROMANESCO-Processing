  ////////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.2.0 / version 29 / made with Processing 3.0.2 ///
////////////////////////////////////////////////////////////////////
/* 4.100 lines of code the 4th may 2015 !!!! */
String version = ("29") ;
String IAM = ("Controller") ;
String prettyVersion = ("1.2.0") ;
String nameVersion = ("Romanesco Unu") ;
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
  loadSetup() ;

  check_image_bitmap_folder() ;
  check_image_svg_folder() ;
  check_file_text_folder() ;
  select_camera_device(30, 100) ; // methode(int min_fps, int min_width)
  
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

  set_item_list() ;
  set_OSC() ;
  set_data_from_save() ;

  reset() ;
  //INIT_INTERFACE = false ;
}

void draw() {
  check_interface() ;
  check_slider_item() ;
  check_image_bitmap_folder() ;
  check_image_svg_folder() ;
  check_movie_folder() ;
  check_file_text_folder() ;
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
  //OpenClose save
  shortcuts_controller() ;
}


void keyReleased() { 
  keyboard[keyCode] = false;
}