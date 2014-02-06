//GLOBAL
import java.awt.event.KeyEvent;
import processing.net.*;
// Midi
import promidi.*;
MidiIO midiIO;
int sliderMidi, valMidi ;
int numMidi = -1 ;
boolean saveMidi ;
boolean selectMidi = false ;
boolean rideauOpenClose ;

boolean[] clavier = new boolean[526];
boolean chargement = false ;
boolean ouvrirFichier = false ;

//ANNEXE
void setting() {
  size(550,650); 
  colorSetup() ;  

  frameRate(25) ; 
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
