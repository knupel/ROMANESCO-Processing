//GLOBAL
import java.awt.event.KeyEvent;
import processing.net.*;
//SLIDER
int numSlider = 350 ;
// Midi
import promidi.*;
MidiIO midiIO;
int sliderMidi, valMidi ;
int numMidi = -1 ;
boolean saveMidi ;
boolean selectMidi = false ;
boolean curtainOpenClose ;
//GLOBAL
byte saveR [] = new byte [2*numSlider]; // byte between -128 and 127 result 256 bytes
byte loadR []  = new byte [2*numSlider] ;

boolean[] clavier = new boolean[526];
boolean loadSliderPos = false ;
boolean ouvrirFichier = false ;

//ANNEXE
void setting() {
  size(550,650); 
  colorSetup() ;  

  frameRate(60) ; 
  noStroke () ; 
  frame.setResizable(true);
  background(gris);
  //init the string value
  for ( int i = 0 ; i < numCol ; i++ ) {
    genTxtGUI[i] = ("") ;
    objTxtGUIone[i] = ("") ;
    objTxtGUItwo[i] = ("") ;
    objTxtGUIthree[i] = ("") ;
    textureTxtGUIone[i] = ("") ;
    textureTxtGUItwo[i] = ("") ;
    textureTxtGUIthree[i] = ("") ;
    typoTxtGUIone[i] = ("") ;
    typoTxtGUItwo[i] = ("") ;
    typoTxtGUIthree[i] = ("") ;
  }
}
