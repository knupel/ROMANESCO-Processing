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
//MANAGER CLASS
import java.util.Iterator;
import java.lang.reflect.*; 
ObjectRomanescoManager romanescoManager ;
//CALLING class or library in Other Class, you must call the PApplet too in your class
PApplet callingClass = this ;
//


void setup() {
  romanescoSetup() ;
  createVar() ;
  OSCSetup() ;
  displaySetup() ;
  cursorSetup() ;
  soundSetup() ;
  fontSetup() ;
}

void draw() {
  OSCDraw() ;
  updateVar() ;
  defaultSetting() ;
  soundDraw() ;
  //use romanesco object
  romanescoManager.displayObject() ;
  
  //stop the camera if we're in P3D world
  if(modeP3D) stopCamera() ;
  
  cursorDraw() ;
  keyboardFalse() ;
}


//SETTING
void displaySetup() {
  colorMode(HSB, 360,100,100,100 ) ;
  if(modeP3D) { size(800,400,P3D); P3DSetup() ; } 
  else { size(800,400) ; }
}
//
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
