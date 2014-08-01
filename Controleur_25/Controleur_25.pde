  ////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.0 / version 25 / made with Processing 301 ///
////////////////////////////////////////////////////////////////
String nameVersion = ("Romanesco Unu") ;
boolean test = false ;
String preferencesPath = sketchPath("")+"preferences/" ;

void setup() {
  setting() ;
  buildLibrary() ;
  loadSetup() ;
  setDisplaySlider() ;
  checkImageFolder() ;
  checkFileTextFolder() ;
  fontSetup() ;
  midiSetup() ;
  importPicButtonSetup() ;
  buttonSliderSetup() ;
  constructorSliderButton() ;
  sendOSCsetup() ;
  buttonSetSaveSetting() ;
}

void draw() {
  structureDraw() ;
  checkSlider() ;
  checkImageFolder() ;
  checkFileTextFolder() ;
  initLiveData() ;
  textDraw() ;
  midiDraw() ;
  sliderDraw() ;
  buttonDraw() ;
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
    if(numGroup[3] > 0 ) for( int i = 11 ; i < numGroup[3] *10 + 6 ; i++)  BTYf[i].mousePressed() ;
  
    buttonBackground.mousePressedText() ;
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
  //OpenClose save
  shortCuts() ;
}

//KEYRELEASED
void keyReleased() { 
  keyboard[keyCode] = false;
}
