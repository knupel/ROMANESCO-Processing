  //////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.0.2 / version 27 / made with Processing 305 ///
//////////////////////////////////////////////////////////////////
/* 4.100 lines of code the 4th may !!!! */
String version = ("27") ;
String IAM = ("Controller") ;
String prettyVersion = ("1.0.2") ;
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
  sliderSettingVar() ;
  buttonSetup() ;
  dropdownSetup() ;
  constructorButton() ;
  constructorSlider() ;
  sendOSCsetup() ;
  settingDataFromSave() ;
}


void draw() {
  /*
  for(int whichOne = 1 ; whichOne < 10 ;whichOne++) {
         sliderUpdate(whichOne) ;
         int whichGroup = 0 ;
    // sliderAdvancedDisplay(i, whichGroup) ;
           slider[whichOne].insideMin() ;
      slider[whichOne].updateMin() ;
  //  }
    // max molette
  //  if(!slider[whichOne].insideMin && !slider[whichOne].lockedMin) {
      slider[whichOne].insideMax() ;
      slider[whichOne].updateMax() ;
  }
  */
  
  frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Controller");
  // settingDataFromSave() ;
  structureDraw() ;
  checkSliderObject() ;
  checkImageFolder() ;
  checkFileTextFolder() ;
  initLiveData() ;
  textDraw() ;
  sliderDraw() ;
  buttonDraw() ;
  midiDraw() ;
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
