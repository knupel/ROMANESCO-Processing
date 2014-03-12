  //////////////////////////////////////////////////////////////////////////////////////////
 // Romanesco Préscène Alpha 0.25 work with Processing 211 export with Processing 203  ////
//////////////////////////////////////////////////////////////////////////////////////////
String release =("25") ;
//to work in dev, test phase
boolean testRomanesco = true ;

boolean Controleur = true ;
boolean Scene = true ;
boolean Miroir = true ;

//MANAGER CLASS
import java.util.Iterator;
import java.lang.reflect.*; 
ObjectRomanescoManager romanescoManager ;

//to opening app
boolean openScene = true ;
boolean openMiroir = true ;
boolean openControleur = true ;
//send to the other sketches
boolean youCanSendToScene = true ;
boolean youCanSendToMiroir = true ;


// when you work only with "Prescene" boolean presceneOnly must be true to give at the Prescene the internet acces
boolean presceneOnly = false ;
//spectrum for the color mode and more if you need
PVector HSBmode = new PVector (360,100,100) ; // give the color mode in HSB



//path to open the controleur
String findPath ; 

void setup() {
  romanescoSetup() ;
  createVar() ;
    
  displaySetup(60) ; // the int value is the frameRate

  colorSetup() ;
  //dropping image from folder on the Scène
  drop = new SDrop(this);
  
  fontSetup() ;
  //GEOMERATIVE
  RG.init(this);

  soundSetup() ;
  cursorSetup() ;
  OSCSetup() ;
  meteoSetup() ;
  P3DSetup() ;
  //OBJECT SETTING
  romanescoSetup() ;
}



//DRAW
void draw() {
  //setting
  initDraw() ;
  soundDraw() ;
  meteoDraw() ;
  updateVar() ;
  OSCDraw() ;
  backgroundRomanescoPrescene() ;
  
  //ROMANESCO
  cameraDraw() ;
    //use romanesco object
  romanescoManager.displayObject() ;
  repereCamera(sizeBG) ;
  stopCamera() ;
  
  //annexe
  info() ;
  curtain() ; 

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
  //nextPrevious  
  nextPreviousKeypressed() ;
  //keyboard
  keyboardTrue() ;
  //save
  if(key == 's' ) selectOutput("Enregistrez le PDF et le PNG ", "saveImg") ;

}
//END KEYPRESSED


//KEYRELEASED
void keyReleased() {
  //special touch need to be long
  keyboardLongFalse() ;
}
//END KEYRELEASED
