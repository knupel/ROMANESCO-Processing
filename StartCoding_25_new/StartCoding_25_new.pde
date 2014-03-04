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

//
ObjectRomanescoManager romanescoManager ;

void setup() {
  size(400,400) ;
  colorMode(HSB,360,100,100,100) ;
  //setting romanesco manager
  // loadInfoObject() ;
  

  romanescoManager = new ObjectRomanescoManager(this);
  romanescoManager.addObjectRomanesco() ;
  romanescoManager.finishTheIndex() ;
  
  initVarObject() ;
  cursorSetup() ;
  OSCSetup() ;
}

void draw() {
  OSCDraw() ;
  updateData() ;
  //use romanesco object
  romanescoManager.displayObject() ;
  
  cursorDraw() ;
  
  

}
