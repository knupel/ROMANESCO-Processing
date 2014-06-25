  ////////////////////////////////////////////////////////////
 // Romanesco Unu Bêta 1.0 work with Processing 221 /////////
////////////////////////////////////////////////////////////
String release = ("25") ;
String version = ("1.0") ;
boolean test = false ;
String preferencesPath = sketchPath("")+"preferences/" ;

void setup() {
  setting() ;
  loadSetup() ;
  setDisplaySlider() ;
  interfaceSetup() ;
  sendOSCsetup() ;
}

void draw() {
  structureDraw() ;
  checkSlider() ;
  interfaceDraw() ;
  sendOSCdraw() ;
  initVarSliderDynamic() ;
  
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
    BOmidi.mousePressedText() ;
    //curtain
    BOcurtain.mousePressedText() ;
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
