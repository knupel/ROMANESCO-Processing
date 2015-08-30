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
  fontSetup() ;
  // midiSetup() ;
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
  // midiDraw() ;
  sendOSCdraw() ;
  initVarSliderDynamic() ;
  
  credit() ;
}



////////////////////

void mousePressed () {
  //object
  if(!dropdownActivity) {
    if(numGroup[1] > 0 ) for( int i = 11 ; i < numGroup[1] *10 + 6 ; i++ ) BOf[i].mousePressed()  ;
    if(numGroup[2] > 0 ) for( int i = 11 ; i < numGroup[2] *10 + 6 ; i++)  BTf[i].mousePressed() ;
  
    buttonBackground.mousePressedText() ;
        //LIGHT ONE
    buttonLightAmbient.mousePressedText() ;
    buttonLightAmbientAction.mousePressedText() ;
    //LIGHT ONE
    buttonLightOne.mousePressedText() ;
    buttonLightOneAction.mousePressedText() ;
    // LIGHT TWO
    buttonLightTwo.mousePressedText() ;
    buttonLightTwoAction.mousePressedText() ;
    //son
    Bbeat.mousePressedText() ;
    Bkick.mousePressedText() ;
    Bsnare.mousePressedText() ;
    Bhat.mousePressedText() ;
    //midi
    BOmidi.mousePressed() ;
    //curtain
    BOcurtain.mousePressed() ;
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