  ///////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.1.1 / version 28 / made with Processing 3.0b5 ///
////////////////////////////////////////////////////////////////////
/* 4.100 lines of code the 4th may !!!! */
String version = ("28") ;
String IAM = ("Controller") ;
String prettyVersion = ("1.1.1") ;
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
  buttonDraw() ;
  midi_update() ;
  sendOSCdraw() ;
  initVarSliderDynamic() ;
  
  credit() ;
}



////////////////////

void mousePressed () {
  //object
  if(!dropdownActivity) {
    if(numGroup[1] > 0 ) for( int i = 11 ; i < numGroup[1] *10 + 6 ; i++ ) button_G1[i].mousePressed()  ;
    if(numGroup[2] > 0 ) for( int i = 11 ; i < numGroup[2] *10 + 6 ; i++)  button_G2[i].mousePressed() ;
  
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