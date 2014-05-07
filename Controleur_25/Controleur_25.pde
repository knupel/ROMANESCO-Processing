  ///////////////////////////////////////////////////////////////////////////////////////////////////
 // Romanesco Contrôleur Alpha 0.25 work with Processing 211 export with Processing 203  ///////////
///////////////////////////////////////////////////////////////////////////////////////////////////
String release = ("25") ;
boolean test = false ;
String preferencesPath = sketchPath("")+"preferences/" ;

void setup() {
  setting() ;
  loadSetup() ;
  interfaceSetup() ;
  sendOSCsetup() ;
}

void draw() {
  structureDraw() ;
  interfaceDraw() ;
  sendOSCdraw() ;
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
  OpenCloseSave() ;
}

//KEYRELEASED
void keyReleased() { 
  clavier[keyCode] = false;
}
