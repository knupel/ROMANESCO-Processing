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

//
/*
//camera
boolean cameraOnOff = false ;
*/
//variable pour le clavier multiple
boolean[] clavier = new boolean[526];
//paramètre chargement
boolean chargement = false ;
boolean ouvrirFichier = false ;
// int media1 ;
//texte importé
String texte = "" ;




//ANNEXE
void setting() {
  size(550,650); 
  colorSetup() ;  

  frameRate(25) ; 
  noStroke () ; // Le frameRate doit être le même dans tous les Sketches
  frame.setResizable(true);
  background(gris);
}
