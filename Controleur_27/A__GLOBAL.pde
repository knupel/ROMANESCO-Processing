//GLOBAL
import java.awt.event.KeyEvent;
// import processing.net.*;
// CONSTANT VAR
final int NUM_COL_SLIDER = 3 ;
final int BUTTON_BY_OBJECT = 4 ;
final int NUM_GROUP_SLIDER = 3 ;
final int NUM_SLIDER_MISC = 30 ;
final int NUM_SLIDER_TOTAL = 250 ;
final int NUM_SLIDER_OBJ = 30 ;
final int SLIDER_BY_COL = 9 ;




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
PVector [] infoSlider, infoButton ;

// slider mode display
int sliderModeDisplay = 0 ;


boolean[] keyboard = new boolean[526];
boolean loadSaveSetting = false ;
boolean ouvrirFichier = false ;

//LOAD PICTURE VIGNETTE
int numVignette ;

//ANNEXE
void setting() {
  size(665,840); 
  colorSetup() ;  

  frameRate(60) ; 
  noStroke () ; 
  frame.setResizable(true);
  background(gris);
  //init the string value
  for ( int i = 0 ; i < numCol ; i++ ) {
    genTxtGUI[i] = ("") ;
    sliderNameCamera[i] = ("") ;
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
    sliderModeDisplay += 1 ;
    if(sliderModeDisplay > 2 ) sliderModeDisplay = 0 ;
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
