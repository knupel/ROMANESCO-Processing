import codeanticode.syphon.*;
// remove menu bar apple
/*
import japplemenubar.*;
JAppleMenuBar instance;
*/
boolean scene = true ;
boolean prescene = false ;
boolean testRomanesco = false ;


// In the Miroir and Scene sketch presceneOnly must be true for the final work.
boolean fullRendering = true ;
Boolean internet = true ;
String bigBrother = ("BIG BROTHER DON'T WATCHING YOU !!") ;

//specific at the Scene
String valueTempPreScene[] = new String [71] ;
//Special var for the Scene and the Miroir
PVector mouseCamera ; 


void initVarScene() {
  mouseCamera = new PVector(0,0,0) ;
}


//init var
//GLOBAL
void varObjectSetup() {
  for (int i = 0 ; i < numObj ; i++ ) {
    pen[i] = new PVector() ;
    mouse[i] = new PVector(0,0,0) ;
    wheel[i] = 0 ;
  }
}
