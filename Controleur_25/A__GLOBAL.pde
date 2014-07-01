//GLOBAL
import java.awt.event.KeyEvent;
import processing.net.*;
// CONSTANT VAR
final int BUTTON_BY_OBJECT = 4 ;
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

// Save Setting var
// byte saveSlider [] = new byte  [2 *NUM_SLIDER]; // byte between -128 and 127 result 256 bytes
// byte loadSlider []  = new byte [2 *NUM_SLIDER] ; // there is no reason to used 2*NUM_SLIDER except to mcreat a big num of saved, and it's important :)
PVector [] infoSlider, infoButton ;

/*
byte saveButton []  = new byte [2 *NUM_SLIDER] ;
byte loadButton []  = new byte [2 *NUM_SLIDER] ;
*/
boolean[] keyboard = new boolean[526];
boolean loadSaveSetting = false ;
boolean ouvrirFichier = false ;

//LOAD PICTURE VIGNETTE
int numVignette ;

//ANNEXE
void setting() {
  size(565,640); 
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




// SHORTCUTS & KEYBOARD ACTION
//////////////////////////////
void shortCuts() {
  keyboard[keyCode] = true;
  // slider display command
  if(checkKeyboard(CONTROL) && checkKeyboard(KeyEvent.VK_X) ) {
    resetSlider = true ;
    allSliderUsed = !allSliderUsed ;
    keyboard[keyCode] = false ;
  }

  if(checkKeyboard(CONTROL ) && checkKeyboard(KeyEvent.VK_C)) {
    resetSlider = true ;
    showAllSliders = !showAllSliders ;
    keyboard[keyCode] = false ;
  }
  
  // save slider
  if(checkKeyboard(CONTROL) && checkKeyboard(KeyEvent.VK_S) ) {
    showAllSliders = true ; 
    selectOutput("Save setting", "saveSetting");
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
  // open saved slider
  if(checkKeyboard(CONTROL) && checkKeyboard(KeyEvent.VK_O) ) { 
    selectInput("Load setting", "loadSetting"); // ("display info in the window" , "name of the void calling" )
    keyboard[keyCode] = false;   // 
  }
}
