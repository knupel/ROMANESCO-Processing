/**
Romanesco Unu
2012–2018
v 1.3.0.31
version 31
Processing 3.3.7
*/
/**
Controller 
V 1.2.0
2015 may 4_100 lines of code
2016 september 8_700 lines of code
2017 March 11_100 lines of code
2018 June 5_000 lines of code without CROPE and ROPE internal library who have around 18_000 lines
*/
String IAM = "Controller";
/**
LIVE must change from the launcher, the info must be write in the external loading preference app
*/
boolean LIVE = false;
boolean KEEP_BUTTON_ITEM_STATE = true;


void settings() {
  size(670,725);
  size_window_ref = iVec2(width,height);
  set_design();
}

void setup() {
  colorMode (HSB,360,100,100);
  // surface.setLocation(0,20);
  path_setting();
  version();
  setting_misc();
  init_button_general();
  init_midi();
  create_and_initialize_data(); 
  load_setup();
  check_media_folder();
  set_system_specification();
  set_font();
  set_display_slider();
  set_import_pic_button();
  set_console();
  set_button_item_console();  
  build_console();
  build_dropdown_bar();
  build_dropdown_item_selected();
  build_button_item_console();
  build_inventory();
  set_OSC();
  set_data();
  reset() ;
}

void draw() {
  check_size_window();
  check_slider_item();
  check_media_folder();
  check_button();

  manage_autosave( );
  
  update_media();
  
  surface.setTitle(nameVersion + ": " +prettyVersion+"."+version+ " - Controller");

  set_data();

  display_structure();

  show_misc_text();
  show_slider_controller();
  show_button();
  show_dropdown();
  
  midi_manager(false);
  update_midi();
  update_OSC();

  reset();

  credit();

}


void mouseWheel(MouseEvent e) {
  scroll(e);
}

void mousePressed () {
  mousepressed_button_general();
  mousepressed_button_item_console();
  mousepressed_button_inventory();
}

void keyPressed() {
  keypressed_midi();
  shortcuts_controller();
}


void keyReleased() { 
  key_false();
  keyboard[keyCode] = false;
}