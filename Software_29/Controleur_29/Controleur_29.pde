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
  buildLibrary() ;
  loadSetup() ;
  setDisplaySlider() ;
  checkImageFolder() ;
  checkFileTextFolder() ;
  select_camera_device(30, 100) ; // methode(int min_fps, int min_width)
  fontSetup() ;
  midi_init() ;
  importPicButtonSetup() ;
  sliderSettingVar() ;
  buttonSetup() ;
  dropdownSetup() ;
  constructorButton() ;
  constructorSlider() ;
  sendOSCsetup() ;
  settingDataFromSave() ;

}


void draw() {
  surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Controller");
  settingDataFromSave() ;
  structureDraw() ;
  checkSliderObject() ;
  checkImageFolder() ;
  checkFileTextFolder() ;
  initLiveData() ;
  textDraw() ;
  sliderDraw() ;
  button_draw() ;
  midi_update() ;
  sendOSCdraw() ;
  initVarSliderDynamic() ;
  
  credit() ;
}



////////////////////

void mousePressed () {
  //object
  if(!dropdownActivity) {
    if(NUM_ITEM > 0 ) for( int i = 11 ; i < NUM_ITEM *10 + 6 ; i++ ) button_item[i].mousePressed()  ;
  
    button_bg.mousePressedText() ;
    //LIGHT ONE
    button_light_ambient.mousePressedText() ;
    button_light_ambient_action.mousePressedText() ;
    //LIGHT ONE
    button_light_1.mousePressedText() ;
    button_light_1_action.mousePressedText() ;
    // LIGHT TWO
    button_light_2.mousePressedText() ;
    button_light_2_action.mousePressedText() ;
    //son
    button_beat.mousePressedText() ;
    button_kick.mousePressedText() ;
    button_snare.mousePressedText() ;
    button_hat.mousePressedText() ;
    //midi
    button_midi.mousePressed() ;
    //curtain
    button_curtain.mousePressed() ;
  }
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