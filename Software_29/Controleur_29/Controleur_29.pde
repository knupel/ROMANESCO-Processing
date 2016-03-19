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
}

void setup() {
  preferencesPath = sketchPath("")+"preferences/" ;
  setting() ;
  build_item_library() ;
  loadSetup() ;
  setDisplaySlider() ;
  checkImageFolder() ;
  checkFileTextFolder() ;
  select_camera_device(30, 100) ; // methode(int min_fps, int min_width)
  set_font() ;
  midi_init() ;
  importPicButtonSetup() ;
  set_slider() ;
  set_button_general() ;
  set_button_item_console() ;
  set_var_dropdown() ;

  build_button_general() ;
  build_button_item_console() ;
  build_button_item_list() ;
  build_slider() ;

  sendOSCsetup() ;
  settingDataFromSave() ;

}


void draw() {
  surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Controller");
  settingDataFromSave() ;
  structureDraw() ;
  check_slider_item() ;
  checkImageFolder() ;
  checkFileTextFolder() ;
  initLiveData() ;
  textDraw() ;
  slider_display() ;
  button_draw() ;
  midi_update() ;
  sendOSCdraw() ;
  init_sliderDynamic() ;
  
  credit() ;
}



////////////////////

void mousePressed () {
  button_mousePressed_general() ;
  button_mousePressed_item_console() ;
  button_mousePressed_item_list() ;
  //dropdown
  dropdownMousepressed() ;
}




//KEYPRESSED
void keyPressed() {
  midi_keyPressed() ;
  //OpenClose save
  shortCutsController() ;
}

//KEYRELEASED
void keyReleased() { 
  keyboard[keyCode] = false;
}