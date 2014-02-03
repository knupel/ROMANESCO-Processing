  ////////////////////////////////////////////////////////////////////////
 // Romanesco Startcoding Alpha 0.25 work with Processing 211  //////////
////////////////////////////////////////////////////////////////////////

//GLOBAL
boolean modeP3D = true ;

int numObj = 99 ; // minimum 2 object because sur first Object is Zero and it use like ref. So the "1" is the real first object.
int numBand = 16 ;
 
//sound
import ddf.minim.*;
import ddf.minim.analysis.*;
//tablet
import codeanticode.tablet.*;
//GEOMERATIVE
import geomerative.*;
//METEO
import com.onformative.yahooweather.*;
//LEAP MOTION
import com.leapmotion.leap.*;
com.leapmotion.leap.Controller leap;



///////IMPORTANT//////////////////////////////////////////////////////////////////////
//CALLING class or library in Other Class, you must call the PApplet too in your class
PApplet callingClass = this ;
///////IMPORTANT////////////

///////
//SETUP
PFont police ;

//SETUP 
void setup() {
  displaySetup() ;
  cursorSetup() ;
  soundSetup() ;
  fontSetup() ;
  //GEOMERATIVE
  RG.init(this);
  //OBJECT ROMANESCO
  romanescoSetup() ;
  //controler
  OSCSetup() ;
}


//DRAW
void draw() {
  defaultSetting() ;
  soundDraw() ;
  romanescoDraw() ;
  
  //stop the camera if we're in P3D world
  if(modeP3D) stopCamera() ;
  
  //tablet, pen and mouse
  cursorDraw() ;
  keyboardFalse() ;
  //to change in false after one shot click
  clickShortLeft[0] = false ; 
  clickShortRight[0] = false ;
  //OSC
  startcodingOSCDraw() ;
}






// ANNEXE

void displaySetup() {
  colorMode(HSB, 360,100,100 ) ;
  if(modeP3D) { size(800,400,P3D); P3DSetup() ; } 
  else { size(800,400) ; }
}


void defaultSetting() {
    //background and camera 3D
  if(modeP3D) { 
    backgroundP3D() ; 
    cameraDraw() ; 
  } else { 
    backgroundClassic() ; 
  }
}



//
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
//
void mouseReleased() { 
  clickLongLeft[0] = false ; 
  clickLongRight[0] = false ;
}


//MOUSE WHEEL
void mouseWheel(MouseEvent event) {
  wheel[0] = event.getCount()  ;
}
//
void keyReleased() { 
  //special touch need to be long
  keyboardLongFalse() ;
}
//
void keyPressed() {
  //keyboard
  keyboardTrue() ;
}
