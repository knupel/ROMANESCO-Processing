
  ////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.0 / version 25 / made with Processing 303 ///
////////////////////////////////////////////////////////////////
String release = ("25") ;
String version = ("1.0") ;
String preferencesPath = sketchPath("")+"preferences/" ;
//to work in dev, test phase
boolean testRomanesco = false ;
boolean fullRendering = false ;


void setup() {
  romanescoSetup() ;
  createVar() ;
  displaySetup(60) ; // the int value is the frameRate
  colorSetup() ;
  
  // GEOMERATIVE
  RG.init(this);
  
  presceneSetup() ; // the varObject setup of the Scene is more simple
  
  varObjSetup() ;
  fontSetup() ;
  soundSetup() ;
  OSCSetup() ;
  P3DSetup() ;
}



//DRAW
void draw() {
  //setting
  initDraw() ;
  soundDraw() ;
  updateVar() ;
  OSCDraw() ;
  backgroundRomanesco() ;
  
  //ROMANESCO
  cameraDraw() ;
  lightPosition() ;
  //use romanesco object
  romanescoManager.displayObject() ;
  repereCamera(sizeBackgroundP3D) ;
  stopCamera() ;
  
  //annexe
  info() ;
  curtain() ;
  
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
