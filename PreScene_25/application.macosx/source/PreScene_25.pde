  ///////////////////////////////////////////////////////////////
 // Romanesco Préscène Alpha 0.25 work with Processing 212  ////
///////////////////////////////////////////////////////////////
String release =("25") ;
String preferencesPath = sketchPath("")+"preferences/" ;
// security must be link with the controler in the next release
int levelSecurity = 200 ;
//to work in dev, test phase
boolean testRomanesco = false ;
// when you work only with "Prescene" boolean presceneOnly must be true to give at the Prescene the internet acces
boolean presceneOnly = false ;


void setup() {
  romanescoSetup() ;
  createVar() ;
  displaySetup(60) ; // the int value is the frameRate
  colorSetup() ;
  
  //MISC SETUP
  // dropping image from folder on the Scène
  drop = new SDrop(this);
  // GEOMERATIVE
  RG.init(this);
  
  presceneSetup() ; // the varObject setup of the Scene is more simple
  
  varObjSetup() ;
  fontSetup() ;
  soundSetup() ;
  OSCSetup() ;
  meteoSetup() ;
  P3DSetup() ;
}



//DRAW
void draw() {
  //setting
  initDraw() ;
  soundDraw() ;
  meteoDraw() ;
  updateVar() ;
  OSCDraw() ;
  // we must write the void loadLiveData, after OSCDraw in cas where the OSC send a file Image or Text don't exist in the Scene or Prescene Folder
  // loadLiveData() ; 
  backgroundRomanescoPrescene(presceneOnly) ;
  
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
