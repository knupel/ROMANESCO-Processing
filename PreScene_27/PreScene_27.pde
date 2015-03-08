
  //////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.0.2 / version 27 / made with Processing 305 ///
//////////////////////////////////////////////////////////////////
String version = ("27") ;
String prettyVersion = ("1.0.2") ;
String nameVersion = ("Romanesco Unu") ;
String preferencesPath = sketchPath("")+"preferences/" ;
//to work in dev, test phase
boolean testRomanesco = false ;
boolean fullRendering = false ;


void setup() {
  int frameRateRomanesco ;
  if(fullRendering) frameRateRomanesco = 60 ; else frameRateRomanesco = 15 ;
  displaySetup(frameRateRomanesco) ; // the int value is the frameRate
  // common setup
  romanescoSetup() ;
  createVar() ;
  //specific setup
  presceneSetup() ; // the varObject setup of the Scene is more simple
  leapMotionSetup() ;
  OSCSetup() ;
  //common setup
  colorSetup() ;
  RG.init(this);  // Geomerative
  varObjSetup() ;
  fontSetup() ;
  soundSetup() ;
  P3DSetup(modeP3D, numObj, numSettingCamera, numSettingOrientationObject) ;
}



//DRAW
void draw() {
  frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Prescene");
  //setting
  initDraw() ;
  soundDraw() ;
  updateVar() ;
  OSCDraw() ;
  backgroundRomanesco() ;
  updateCommand() ;
  leapMotionUpdate() ;
  
  //ROMANESCO
  cameraDraw() ;
  lightPosition() ;
  //use romanesco object
  romanescoManager.displayObject(ORDER_ONE, ORDER_TWO, ORDER_THREE) ;
  if(modeP3D) createGridCamera() ;
  // gridCamera(sizeBackgroundP3D) ;
  stopCamera() ;
  
  //annexe
  info() ;
  // curtain() ;
  
  // misc
  cursorDraw() ;
  keyboardFalse() ;
  opening() ;
  

}
//END DRAW









/////MOUSE////
//MOUSEPRESSED

void mousePressed() {
  if(mouseButton == LEFT ) { 
    clickShortLeft[0] = true ; 
    clickLongLeft[0] = true ;
  }
  if (mouseButton == RIGHT ) {
    clickShortRight[0] = true ; 
    clickLongRight[0] = true ;
  }
}

//MOUSE RELEASED
void mouseReleased() {
  clickLongLeft[0] = false ; 
  clickLongRight[0] = false ;
}



//MOUSE WHEEL
void mouseWheel(MouseEvent event) {
  wheel[0] = event.getCount() *speedWheel ; 
}
//END MOUSEWHEEL


/////KEY/////
//KEYPRESSED
void keyPressed () {
  nextPreviousKeypressed() ;
  keyboardTrue() ;
  //save
  if (key == 's') selectOutput("Enregistrez le PDF et le PNG ", "saveImg") ;
  // info common command with Scene
  if (key == 'i') displayInfo = !displayInfo ;
  if (key == 'g') displayInfo3D = !displayInfo3D ;
}
//END KEYPRESSED


//KEYRELEASED
void keyReleased() {
  //special touch need to be long
  keyboardLongFalse() ;
}
//END KEYRELEASED
