//GLOBAL
import java.awt.event.KeyEvent;
import processing.net.*;
// CONSTANT VAR
final int NUM_GROUP_SLIDER = 4 ;
final int NUM_SLIDER_GLOBAL = 14 ;
final int NUM_SLIDER = 350 ;
final int SLIDER_BY_GROUP = 30 ;
final int SLIDER_BY_COL = 8 ;



// Obj
int numObj ;

// Midi
import promidi.*;
MidiIO midiIO;
int sliderMidi, valMidi ;
int numMidi = -1 ;
boolean saveMidi ;
boolean selectMidi = false ;
//curtain
boolean curtainOpenClose ;
//GLOBAL

byte saveR [] = new byte [2 *NUM_SLIDER]; // byte between -128 and 127 result 256 bytes
byte loadR []  = new byte [2 *NUM_SLIDER] ;

boolean[] keyboard = new boolean[526];
boolean loadSliderPos = false ;
boolean ouvrirFichier = false ;

//LOAD PICTURE VIGNETTE
int numVignette ;

//ANNEXE
void setting() {
  size(565,650); 
  colorSetup() ;  

  frameRate(60) ; 
  noStroke () ; 
  frame.setResizable(true);
  background(gris);
  //init the string value
  for ( int i = 0 ; i < numCol ; i++ ) {
    genTxtGUI[i] = ("") ;
    sliderNameOne[i] = ("") ;
    sliderNameTwo[i] = ("") ;
    sliderNameThree[i] = ("") ;
  }
}
