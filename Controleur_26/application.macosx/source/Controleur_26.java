import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.awt.event.KeyEvent; 
import processing.net.*; 
import promidi.*; 
import oscP5.*; 
import netP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Controleur_26 extends PApplet {

  //////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.0.1 / version 26 / made with Processing 304 ///
//////////////////////////////////////////////////////////////////
String version = ("26") ;
String prettyVersion = ("1.0.1") ;
String nameVersion = ("Romanesco Unu") ;
boolean test = false ;
String preferencesPath = sketchPath("")+"preferences/" ;

public void setup() {
  setting() ;
  buildLibrary() ;
  loadSetup() ;
  setDisplaySlider() ;
  checkImageFolder() ;
  checkFileTextFolder() ;
  fontSetup() ;
  midiSetup() ;
  importPicButtonSetup() ;
  buttonSliderSetup() ;
  constructorSliderButton() ;
  sendOSCsetup() ;
  
  //button
  settingDataFromSave() ;
}


public void draw() {
  frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Controller");
  settingDataFromSave() ;
  structureDraw() ;
  checkSlider() ;
  checkImageFolder() ;
  checkFileTextFolder() ;
  initLiveData() ;
  textDraw() ;
  midiDraw() ;
  sliderDraw() ;
  buttonDraw() ;
  sendOSCdraw() ;
  initVarSliderDynamic() ;
  
  credit() ;
}



////////////////////

public void mousePressed () {
  //object
  if(!dropdownActivity) {
    if(numGroup[1] > 0 ) for( int i = 11 ; i < numGroup[1] *10 + 6 ; i++ ) BOf[i].mousePressed()  ;
    if(numGroup[2] > 0 ) for( int i = 11 ; i < numGroup[2] *10 + 6 ; i++)  BTf[i].mousePressed() ;
    if(numGroup[3] > 0 ) for( int i = 11 ; i < numGroup[3] *10 + 6 ; i++)  BTYf[i].mousePressed() ;
  
    buttonBackground.mousePressedText() ;
    //LIGHT ONE
    buttonLightOne.mousePressedText() ;
    buttonLightOneAction.mousePressedText() ;
    // LIGHT TWO
    buttonLightTwo.mousePressedText() ;
    buttonLightTwoAction.mousePressedText() ;
    //son
    Bbeat.mousePressedText() ;
    Bkick.mousePressedText() ;
    Bsnare.mousePressedText() ;
    Bhat.mousePressedText() ;
    //midi
    BOmidi.mousePressed() ;
    //curtain
    BOcurtain.mousePressed() ;
  }
  //dropdown
  dropdownMousepressed() ;
}


//KEYPRESSED
public void keyPressed() {
  //OpenClose save
  shortCuts() ;
}

//KEYRELEASED
public void keyReleased() { 
  keyboard[keyCode] = false;
}
//GLOBAL


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
public void setting() {
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
public void shortCuts() {
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
//GLOBAL
PImage[] OFF_in_thumbnail ;
PImage[] OFF_out_thumbnail ;
PImage[] ON_in_thumbnail ;
PImage[] ON_out_thumbnail ;

PImage[] picSetting = new PImage[4] ;
PImage[] picSound = new PImage[4] ;
PImage[] picAction = new PImage[4] ;
PImage[] picCurtain = new PImage[4] ;
PImage[] picMidi = new PImage[4] ;


/////////
//SLIDER





// POSITION GLOBAL button and Slider


PVector columnPosVert = new PVector(25,205, 385) ; // give the pos of the column on the axis "x"
int margeLeft  ; // marge left for the first GUI button and slider
int startingTopPosition  ; // marge top to starting position of the GUI button and slider

int sliderHeight = 8 ;
int roundedSlider = 5 ;
SliderHorizontal [] Slider = new SliderHorizontal [NUM_SLIDER] ;
int suivitSlider[] = new int[NUM_SLIDER] ; 
int posWidthSlider[] = new int[NUM_SLIDER] ;
int posHeightSlider[] = new int[NUM_SLIDER] ;
int longueurSlider[] = new int[NUM_SLIDER] ;
int hauteurSlider[] = new int[NUM_SLIDER] ;
float valueSlider[] = new float[NUM_SLIDER] ;

//param\u00e8tre g\u00e9n\u00e9raux interface

int   mgSliderc1, mgSliderc2, mgSliderc3,
    posHeightBO,  posWidthBO,
    posHeightRO,  posWidthRO,
    posHeightBT,  posWidthBT,
    posHeightRT,  posWidthRT,
    posHeightBTY, posWidthBTY,
    posHeightRTY, posWidthRTY ;





//Background / light one / light two
int EtatBackgroundButton, 
    EtatLightOneButton, EtatLightOneAction, 
    EtatLightTwoButton, EtatLightTwoAction ;
PVector posBackgroundButton, sizeBackgroundButton,
        posLightOneAction, sizeLightOneAction, posLightOneButton, sizeLightOneButton,
        posLightTwoAction, sizeLightTwoAction, posLightTwoButton, sizeLightTwoButton ;


// DROPDOWN button font and shader background
int EtatFont, EtatBackground, EtatImage, EtatFileText ;
PVector posButtonFont, posButtonBackground, posButtonImage, posButtonFileText ; 

// MIDI, CURTAIN
int EtatMidiButton, EtatCurtainButton, EtatBbeat, EtatBkick, EtatBsnare, EtatBhat ; ;
PVector posMidiButton, sizeMidiButton,
        posCurtainButton, sizeCurtainButton,
        posBeatButton, sizeBeatButton,
        posKickButton, sizeKickButton,
        posSnareButton, sizeSnareButton,
        posHatButton, sizeHatButton ;


//param\u00e8tres r\u00e9glette couleur
int posXSlider[] = new int[NUM_SLIDER *2] ;







//SPECIFIC VOID of INTERFACE









//SETUP
public void buttonSliderSetup() {
 
  //GLOBAL POS
  margeLeft = (int)columnPosVert.x +15 ; // marge left for the first GUI button and slider
  startingTopPosition = 30 ; // marge top to starting position of the GUI button and slider
  mgSliderc1 = (int)columnPosVert.x ; mgSliderc2 = (int)columnPosVert.y ; mgSliderc3 = (int)columnPosVert.z ;
  int topMenuPos = startingTopPosition +10 ;
  
  //GROUP GLOBAL
  
  // DROPDOWN MENU : SHADER BG, FONT, IMAGE, FILE TEXT
  int posDropdownGrobalY = -3 ;
  posButtonBackground = new PVector(mgSliderc1 -3, startingTopPosition +posDropdownGrobalY)  ;
  posButtonFont =       new PVector(mgSliderc2 -3, startingTopPosition +posDropdownGrobalY)  ; 
  posButtonImage =      new PVector(mgSliderc2 +115, startingTopPosition +posDropdownGrobalY)  ; 
  posButtonFileText =   new PVector(mgSliderc3 +60, startingTopPosition +posDropdownGrobalY)  ; 

  
  // MIDI CURTAIN
  int correctionMidiCurtain = 78 ;
  sizeCurtainButton = new PVector(30,30) ;
  sizeMidiButton = new PVector(50,26) ;
  posMidiButton = new PVector(mgSliderc1 + 40, topMenuPos +correctionMidiCurtain +1) ; 
  posCurtainButton = new PVector(mgSliderc1, topMenuPos +correctionMidiCurtain -1) ; 
  
  //SOUND BUTTON
  sizeBeatButton = new PVector(30,10) ; 
  sizeKickButton = new PVector(30,10) ; 
  sizeSnareButton = new PVector(40,10) ; 
  sizeHatButton = new PVector(30,10) ;
  
  int correctionBeat = 79 ;
  posBeatButton = new PVector(mgSliderc3 +0, topMenuPos +correctionBeat) ; 
  posKickButton = new PVector(posBeatButton.x +sizeBeatButton.x +5, topMenuPos +correctionBeat) ; 
  posSnareButton = new PVector(posKickButton.x +sizeKickButton.x +5, topMenuPos +correctionBeat) ; 
  posHatButton = new PVector(posSnareButton.x +sizeSnareButton.x +5, topMenuPos +correctionBeat) ;

  // background 
  int correctionButtonBG = 38 ;
  posBackgroundButton = new PVector(mgSliderc1, startingTopPosition +correctionButtonBG) ;
  sizeBackgroundButton = new PVector(120,10) ;
  
  // light 
  int correctionButtonLight = 38 ;
  // one button
  posLightOneButton = new PVector(mgSliderc2, startingTopPosition +correctionButtonLight) ;
  sizeLightOneButton = new PVector(80,10) ;
  posLightOneAction = new PVector(mgSliderc2 +90, posLightOneButton.y) ;
  sizeLightOneAction = new PVector(45,10) ;
  // light two button
  posLightTwoButton = new PVector(mgSliderc3, startingTopPosition +correctionButtonLight) ;
  sizeLightTwoButton = new PVector(80,10) ;
  posLightTwoAction = new PVector(mgSliderc3 +90, posLightTwoButton.y) ;
  sizeLightTwoAction = new PVector(45,10) ;
  
  // GROUP ONE
  posHeightBO = startingTopPosition +140  ; 
  posWidthBO  = margeLeft ;
  posHeightRO = posHeightBO +60   ;  
  posWidthRO  = margeLeft ;
  
  //GROUP TWO
  posHeightBT = posHeightBO +160 ;  
  posWidthBT  = margeLeft ;
  posHeightRT = posHeightBT +60   ;  
  posWidthRT  =margeLeft ;
  
  //GROUP THREE
  posHeightBTY = posHeightBT +160 ;  
  posWidthBTY = margeLeft ;
  posHeightRTY = posHeightBTY +60  ;  
  posWidthRTY = margeLeft ;
  
  // VOID
  groupZero(startingTopPosition +80) ;
  groupOne(posHeightBO, posHeightRO ) ;
  groupTwo(posHeightBT, posHeightRT ) ;
  groupThree(posHeightBTY, posHeightRTY ) ;
 
  dropdownSetup() ;
}



/////////////////////
public void groupZero(int pos) {
  //Background
  int correctionSliderBG = -32 ;
  suivitSlider[1] = 1 ; posWidthSlider[1] = mgSliderc1 ; posHeightSlider[1]= pos +correctionSliderBG +0 ; longueurSlider[1] = 111 ; hauteurSlider[1] = sliderHeight ; ; // couleur du fond  
  suivitSlider[2] = 1 ; posWidthSlider[2] = mgSliderc1 ; posHeightSlider[2]= pos +correctionSliderBG +10 ; longueurSlider[2] = 111 ; hauteurSlider[2] = sliderHeight ; ;   
  suivitSlider[3] = 1 ; posWidthSlider[3] = mgSliderc1 ; posHeightSlider[3]= pos +correctionSliderBG +20 ; longueurSlider[3] = 111 ; hauteurSlider[3] = sliderHeight ; ;   
  suivitSlider[4] = 1 ; posWidthSlider[4] = mgSliderc1 ; posHeightSlider[4]= pos +correctionSliderBG +30 ; longueurSlider[4] = 111 ; hauteurSlider[4] = sliderHeight ; ;
  //LIGHT
  int correctionSliderLight = -32 ;
  // LIGHT ONE
  suivitSlider[7] = 1 ; posWidthSlider[7] = mgSliderc2 ; posHeightSlider[7]= pos +correctionSliderLight +0 ; longueurSlider[7] = 111 ; hauteurSlider[7] = sliderHeight ; ; // hue 
  suivitSlider[8] = 1 ; posWidthSlider[8] = mgSliderc2 ; posHeightSlider[8]= pos +correctionSliderLight +10 ; longueurSlider[8] = 111 ; hauteurSlider[8] = sliderHeight ; ;   
  suivitSlider[9] = 1 ; posWidthSlider[9] = mgSliderc2 ; posHeightSlider[9]= pos +correctionSliderLight +20 ; longueurSlider[9] = 111 ; hauteurSlider[9] = sliderHeight ; ; 
 // LIGHT TWO
  suivitSlider[10] = 1 ; posWidthSlider[10] = mgSliderc3 ; posHeightSlider[10]= pos +correctionSliderLight +0 ; longueurSlider[10] = 111 ; hauteurSlider[10] = sliderHeight ; ;  // hue ambiance
  suivitSlider[11] = 1 ; posWidthSlider[11] = mgSliderc3 ; posHeightSlider[11]= pos +correctionSliderLight +10 ; longueurSlider[11] = 111 ; hauteurSlider[11] = sliderHeight ; ;
  suivitSlider[12] = 1 ; posWidthSlider[12] = mgSliderc3 ; posHeightSlider[12]= pos +correctionSliderLight +20 ; longueurSlider[12] = 111 ; hauteurSlider[12] = sliderHeight ; ;
  // SOUND
  int correctionSliderSound = +19 ;
  suivitSlider[5] = 1 ; posWidthSlider[5] = mgSliderc3  ; posHeightSlider[5]= pos +correctionSliderSound +0 ; longueurSlider[5] = 111 ; hauteurSlider[5] = sliderHeight ;  ; // sound left
  suivitSlider[6] = 1 ; posWidthSlider[6] = mgSliderc3  ; posHeightSlider[6]= pos +correctionSliderSound +10 ; longueurSlider[6] = 111 ; hauteurSlider[6] = sliderHeight ; ; // sound rigth 
}

PVector posRelativeMainButton = new PVector (-8, -10) ;
PVector posRelativeSettingButton = new PVector (-8,14) ;
PVector posRelativeSoundButton = new PVector (-8,25) ;
PVector posRelativeActionButton = new PVector (4,25) ;
//////////////
public void groupOne( int posButton, int posSlider) {
  //position and area for the rollover
  for (int i = 1 ; i <= numGroup[1] ; i++ ) {
    posWidthBOf[i*10+1] = posWidthBO +((i-1)*40) +(int)posRelativeMainButton.x    ; posHeightBOf[i*10+1] = posButton +(int)posRelativeMainButton.y     ; longueurBOf[i*10+1] = 20 ; hauteurBOf[i*10+1] = 20 ;  //main
    posWidthBOf[i*10+2] = posWidthBO +((i-1)*40) +(int)posRelativeSettingButton.x ; posHeightBOf[i*10+2] = posButton +(int)posRelativeSettingButton.y  ; longueurBOf[i*10+2] = 19 ; hauteurBOf[i*10+2] = 6 ; //setting
    posWidthBOf[i*10+3] = posWidthBO +((i-1)*40) +(int)posRelativeSoundButton.x   ; posHeightBOf[i*10+3] = posButton +(int)posRelativeSoundButton.y    ; longueurBOf[i*10+3] = 10 ; hauteurBOf[i*10+3] = 6 ; //sound
    posWidthBOf[i*10+4] = posWidthBO +((i-1)*40) +(int)posRelativeActionButton.x  ; posHeightBOf[i*10+4] = posButton +(int)posRelativeActionButton.y   ; longueurBOf[i*10+4] = 10 ; hauteurBOf[i*10+4] = 6 ; //action
  }

  // where the controleur must display the slider
  for( int i = 0 ; i < SLIDER_BY_COL ; i++ ) {
    suivitSlider[i+101] = 1 ; posWidthSlider[i+101] = mgSliderc1 ; posHeightSlider[i+101] = posSlider +i*10 ; longueurSlider[i+101] = 111 ; hauteurSlider[i+101] = sliderHeight ; ;
    suivitSlider[i+111] = 1 ; posWidthSlider[i+111] = mgSliderc2 ; posHeightSlider[i+111] = posSlider +i*10 ; longueurSlider[i+111] = 111 ; hauteurSlider[i+111] = sliderHeight ; ;
    suivitSlider[i+121] = 1 ; posWidthSlider[i+121] = mgSliderc3 ; posHeightSlider[i+121] = posSlider +i*10 ; longueurSlider[i+121] = 111 ; hauteurSlider[i+121] = sliderHeight ; ;
  }
}

//////////////////
public void groupTwo(int posButton, int posSlider) {
  for (int i = 1 ; i <= numGroup[2] ; i++ ) {
    posWidthBTf[i*10+1] = posWidthBT +((i-1)*40) +(int)posRelativeMainButton.x    ; posHeightBTf[i*10+1] = posButton +(int)posRelativeMainButton.y     ; longueurBTf[i*10+1] = 20 ; hauteurBTf[i*10+1] = 20 ; //main
    posWidthBTf[i*10+2] = posWidthBT +((i-1)*40) +(int)posRelativeSettingButton.x ; posHeightBTf[i*10+2] = posButton +(int)posRelativeSettingButton.y  ; longueurBTf[i*10+2] = 19 ; hauteurBTf[i*10+2] = 6 ; //setting
    posWidthBTf[i*10+3] = posWidthBT +((i-1)*40) +(int)posRelativeSoundButton.x   ; posHeightBTf[i*10+3] = posButton +(int)posRelativeSoundButton.y    ; longueurBTf[i*10+3] = 10 ; hauteurBTf[i*10+3] = 6 ; //sound
    posWidthBTf[i*10+4] = posWidthBT +((i-1)*40) +(int)posRelativeActionButton.x  ; posHeightBTf[i*10+4] = posButton +(int)posRelativeActionButton.y   ; longueurBTf[i*10+4] = 10 ; hauteurBTf[i*10+4] = 6 ; //action
  }
  // where the controle must display the slider
  for( int i = 0 ; i < SLIDER_BY_COL ; i++ ) {
    suivitSlider[i+201] = 1 ; posWidthSlider[i+201] = mgSliderc1 ; posHeightSlider[i+201] = posSlider +i*10 ; longueurSlider[i+201] = 111 ; hauteurSlider[i+201] = sliderHeight ; ;
    suivitSlider[i+211] = 1 ; posWidthSlider[i+211] = mgSliderc2 ; posHeightSlider[i+211] = posSlider +i*10 ; longueurSlider[i+211] = 111 ; hauteurSlider[i+211] = sliderHeight ; ;
    suivitSlider[i+221] = 1 ; posWidthSlider[i+221] = mgSliderc3 ; posHeightSlider[i+221] = posSlider +i*10 ; longueurSlider[i+221] = 111 ; hauteurSlider[i+221] = sliderHeight ; ;
  }
}

/////////////////
public void groupThree(int posButton, int posSlider) {
  //param\u00e8tre habillage couleur du bouton cercle BTY
  for (int i = 1 ; i <= numGroup[3] ; i++ ) {
    posWidthBTYf[i*10+1] = posWidthBTY +((i-1)*40) +(int)posRelativeMainButton.x    ; posHeightBTYf[i*10+1] = posButton +(int)posRelativeMainButton.y     ; longueurBTYf[i*10+1] = 20 ; hauteurBTYf[i*10+1] = 20 ; //main
    posWidthBTYf[i*10+2] = posWidthBTY +((i-1)*40) +(int)posRelativeSettingButton.x ; posHeightBTYf[i*10+2] = posButton +(int)posRelativeSettingButton.y  ; longueurBTYf[i*10+2] = 19 ; hauteurBTYf[i*10+2] = 6 ; //setting
    posWidthBTYf[i*10+3] = posWidthBTY +((i-1)*40) +(int)posRelativeSoundButton.x   ; posHeightBTYf[i*10+3] = posButton +(int)posRelativeSoundButton.y    ; longueurBTYf[i*10+3] = 10 ; hauteurBTYf[i*10+3] = 6 ; //sound
    posWidthBTYf[i*10+4] = posWidthBTY +((i-1)*40) +(int)posRelativeActionButton.x  ; posHeightBTYf[i*10+4] = posButton +(int)posRelativeActionButton.y   ; longueurBTYf[i*10+4] = 10 ; hauteurBTYf[i*10+4] = 6 ; //action
  }
  
  // where the controleur must display the slider
  for( int i = 0 ; i < SLIDER_BY_COL ; i++ ) {
    suivitSlider[i+301] = 1 ; posWidthSlider[i+301] = mgSliderc1 ; posHeightSlider[i+301] = posSlider +i*10 ; longueurSlider[i+301] = 111 ; hauteurSlider[i+301] = sliderHeight ; ;
    suivitSlider[i+311] = 1 ; posWidthSlider[i+311] = mgSliderc2 ; posHeightSlider[i+311] = posSlider +i*10 ; longueurSlider[i+311] = 111 ; hauteurSlider[i+311] = sliderHeight ; ;
    suivitSlider[i+321] = 1 ; posWidthSlider[i+321] = mgSliderc3 ; posHeightSlider[i+321] = posSlider +i*10 ; longueurSlider[i+321] = 111 ; hauteurSlider[i+321] = sliderHeight ; ;
  } 
}






/////////////
//CONSTRUCTOR
public void constructorSliderButton() {
  int OnInColor = vert ;
  int OnOutColor = vertTresFonce ;
  int OffInColor = orange ;
  int OffOutColor = rougeFonce ;
  
  buttonBackground = new Simple(posBackgroundButton, sizeBackgroundButton, OnInColor, OnOutColor, OffInColor, OffOutColor, true) ;
  // LIGHT ONE
  buttonLightOne = new Simple(posLightOneButton, sizeLightOneButton, OnInColor, OnOutColor, OffInColor, OffOutColor, false) ;
  buttonLightOneAction = new Simple(posLightOneAction, sizeLightOneAction, OnInColor, OnOutColor, OffInColor, OffOutColor, false) ;
  // LIGHT TWO 
  buttonLightTwo = new Simple(posLightTwoButton, sizeLightTwoButton, OnInColor, OnOutColor, OffInColor, OffOutColor, false) ;
  buttonLightTwoAction = new Simple(posLightTwoAction, sizeLightTwoAction, OnInColor, OnOutColor, OffInColor, OffOutColor, false) ;
  //button beat
  Bbeat = new Simple(posBeatButton, sizeBeatButton, OnInColor, OnOutColor, OffInColor, OffOutColor, false) ;
  Bkick = new Simple(posKickButton, sizeKickButton, OnInColor, OnOutColor, OffInColor, OffOutColor, false) ;
  Bsnare = new Simple(posSnareButton, sizeSnareButton, OnInColor, OnOutColor, OffInColor, OffOutColor, false) ;
  Bhat = new Simple(posHatButton, sizeHatButton, OnInColor, OnOutColor, OffInColor, OffOutColor, false) ;
  //MIDI
  BOmidi  = new Simple(posMidiButton, sizeMidiButton, false) ;
  //curtain
  BOcurtain  = new Simple(posCurtainButton, sizeCurtainButton, false) ;
  
  //button object, texture, typography
  PVector pos = new PVector() ;
  PVector size = new PVector() ;
  // we don't use the BOf[0], BTf[0] and BTYf[0] must he must be init in case we add object in Scene and this one has never use before and don't exist in the save pref
  BOf[0] = new Simple(pos, size, boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir, false) ;
  BTf[0] = new Simple(pos, size, boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir, false) ;
  BTYf[0] = new Simple(pos, size, boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir, false) ;
  // init the object library
  for(int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
    int num = numButton[i] ;
    for ( int j = 11 ; j < 10+num ; j++) {
      if(numGroup[1] > 0 && i == 1) {
        pos = new PVector(posWidthBOf[j], posHeightBOf[j]) ;
        size = new PVector(longueurBOf[j], hauteurBOf[j]) ; 
        BOf[j] = new Simple(pos, size, boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir, false) ;
      } 
      if(numGroup[2] > 0 && i == 2) {
        pos = new PVector(posWidthBTf[j], posHeightBTf[j]) ;
        size = new PVector(longueurBTf[j], hauteurBTf[j]) ; 
        BTf[j] = new Simple(pos, size, boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir, false) ;
      }
      if(numGroup[3] > 0 && i == 3) {
        pos = new PVector(posWidthBTYf[j], posHeightBTYf[j]) ;
        size = new PVector(longueurBTYf[j], hauteurBTYf[j]) ;
        BTYf[j] = new Simple(pos, size, boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir, false) ;
      }
    }

  }
  
  
  
  //slider
  for ( int i = 1 ; i < NUM_SLIDER ; i++ ) {
    int opacity = 100 ;
    if(infoSaveFromRawList(infoSlider,i).x > -1 ) Slider[i] = new SliderHorizontal  (posWidthSlider[i], posHeightSlider[i], longueurSlider[i], hauteurSlider[i], suivitSlider[i], orange, rouge, blancGrisClair, opacity, infoSaveFromRawList(infoSlider, i).z, (int)infoSaveFromRawList(infoSlider, i).y);
  } 
}
//END CONSTRUCTOR
/////////////////











//STRUCTURE
//DRAW
public void structureDraw() {
  //background
  fill(grisNoir) ; rect(0, 24, width, 31) ; // main band
  fill(gris) ; rect(0, 24+31, width, 100 ) ; // //GROUP ZERO
  fill(grisClair) ; rect(0, posHeightBO -15, width, 160 ) ;   //GROUP ONE
  fill(grisClair) ; rect(0, posHeightBT -15, width, 160 ) ;   //GROUP TWO
  fill(grisClair) ; rect(0, posHeightBTY -15, width, height ) ; //   //GROUP THREE
  //the decoration line
  fill (rougeFonce) ; 
  rect(0,0, width, 22) ;
  fill(orange) ;
  rect(0,22, width, 2) ;
  fill (grisNoir) ;
  rect(0,height-9, width, 2) ;
  fill (rougeFonce) ;
  rect(0,height-7, width, 7) ;
  
  
  
  //LINE
  int thicknessDecoration = 5 ;
  fill(noir) ;
  rect(0,54 , width, 2) ; 
  
  fill(grisFonce) ;
  rect(0,posHeightBO -22, width, 8) ; //GROUP ONE
  fill(grisNoir) ;
  rect(0,posHeightBO -20, width, 4) ; //GROUP ONE
  
  fill(gris) ;
  rect(0,posHeightBT -24 +thicknessDecoration, width, thicknessDecoration) ; //GROUP TWO
  fill(grisTresFonce) ;
  rect(0,posHeightBT -16, width, 2) ; //GROUP TWO
  
  fill(gris) ;
  rect(0,posHeightBTY -24 +thicknessDecoration, width, thicknessDecoration) ; //GROUP THREE
  fill(grisTresFonce) ;
  rect(0,posHeightBTY -16, width, 2) ; //GROUP TWO
  

}
//END STRUCTURE




//TEXT
//DRAW
public void textDraw() {
  if(insideNameversion) fill (jaune) ; else fill(orange) ;
  int posTextY = 18 ;
  textFont(FuturaStencil_20,16); 
  text(nameVersion, 5, posTextY);
  //CLOCK
  fill (orange) ; 
  textFont(FuturaStencil_20,16); textAlign(RIGHT);
  text(nf(hour(),2)   + ":" +nf(minute(),2) , width -10, posTextY);
  
  dispayTextSliderGroupZero(startingTopPosition +64) ;
  
  dislayTextSlider() ;
}



public void dispayTextSliderGroupZero(int pos) {
  int correction = 3 ;
  // GROUP ZERO
  textFont(FuturaStencil_20,20); textAlign(LEFT);
  //fill(blanc, 120) ;

  fill (colorTitle) ; 
  textFont(textUsual_1) ; textAlign(LEFT);
  fill (colorTextUsual) ;
  //BACKGROUND
  text(genTxtGUI[1], posWidthSlider[1] +116, posHeightSlider[1] +correction);
  text(genTxtGUI[2], posWidthSlider[2] +116, posHeightSlider[2] +correction);
  text(genTxtGUI[3], posWidthSlider[3] +116, posHeightSlider[3] +correction);
  text(genTxtGUI[4], posWidthSlider[4] +116, posHeightSlider[4] +correction);
  // LIGHT
  text(genTxtGUI[9], posWidthSlider[7] +116, posHeightSlider[7] +correction);
  text(genTxtGUI[10], posWidthSlider[8] +116,posHeightSlider[8] +correction);
  text(genTxtGUI[11], posWidthSlider[9] +116, posHeightSlider[9] +correction);
  //AMBIENT
  text(genTxtGUI[12], posWidthSlider[10] +116, posHeightSlider[10] +correction);
  text(genTxtGUI[13], posWidthSlider[11] +116, posHeightSlider[11] +correction);
  text(genTxtGUI[14], posWidthSlider[12] +116, posHeightSlider[12] +correction);
  
  fill (colorTextUsual) ;
  textFont(textUsual_1); 
  text(genTxtGUI[5], posWidthSlider[5] +116, posHeightSlider[5] +correction);
  text(genTxtGUI[6], posWidthSlider[6] +116, posHeightSlider[6] +correction);
}



public void dislayTextSlider() {
  //GROUP ONE
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  fill(grisFonce) ;
  pushMatrix () ; rotate (-PI/2) ;  text("GROUP ONE", -posHeightRO +70, 20); popMatrix() ;
  fill (colorTextUsual) ;
  textFont(textUsual_1);  textAlign(LEFT);
  
  // GROUP TWO
  textFont(FuturaStencil_20,20);  textAlign(RIGHT);
  fill(grisFonce) ;
  pushMatrix () ; rotate (-PI/2) ;  text("GROUP TWO", -posHeightRT +70, 20); popMatrix() ;
  fill (colorTextUsual) ;
  textFont(textUsual_1);  textAlign(LEFT);
  
  //GROUP THREE
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  fill(grisFonce) ;
  pushMatrix () ; rotate (-PI/2) ; text("GROUP THREE", -posHeightRTY +70, 20); popMatrix() ;
  fill (colorTextUsual) ;
  textFont(textUsual_1); textAlign(LEFT);
  
  // Legend text slider position
  int correctionPos = 3 ;
  for ( int i = 0 ; i < SLIDER_BY_COL ; i++) {
    //group one
    text(sliderNameOne[i+1], mgSliderc1 +116, posHeightRO +correctionPos +(i*10));
    text(sliderNameTwo[i+1], mgSliderc2 +116, posHeightRO +correctionPos +(i*10));
    text(sliderNameThree[i+1],   mgSliderc3 +116, posHeightRO +correctionPos +(i*10));
    //group two
    text(sliderNameOne[i+1], mgSliderc1 +116, posHeightRT +correctionPos +(i*10));
    text(sliderNameTwo[i+1], mgSliderc2 +116, posHeightRT +correctionPos +(i*10));
    text(sliderNameThree[i+1], mgSliderc3 +116, posHeightRT +correctionPos +(i*10));
    //group Three
    text(sliderNameOne[i+1], mgSliderc1 +116,  posHeightRTY +correctionPos +(i*10));
    text(sliderNameTwo[i+1], mgSliderc2 +116,  posHeightRTY +correctionPos +(i*10));
    text(sliderNameThree[i+1], mgSliderc3 +116,  posHeightRTY +correctionPos +(i*10));
  }
}

//END TEXT














///////////////////
// SLIDER & MOLETTE


public void sliderDraw() {
  // DISPLAY BAR
  // global
  sliderDrawGroupZero() ;
  // group one, two, three
  for(int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
    sliderObject(i) ;
  }
  // END DISPLAY BAR
  

  // DISPLAY MOLETTE
  // global
  int whichGroup = 0 ;
  for (int i = 1 ; i < NUM_SLIDER_GLOBAL ; i++) {
     updateMolette(i, whichGroup) ;
  }
  // group one, two, three
  whichGroup = 1 ;
  if(!showAllSliders) {
    for (int i = 1 ; i <= numObj ; i++) {
      if (objectActive[i] ) {
        for (int j = 1 ; j < NUM_GROUP_SLIDER ; j++) {
          if (showSliderGroup[j] && objectGroup[i] == j) { 
            for(int k = 1 ; k < SLIDER_BY_GROUP ; k++) {
              if (displaySlider[j][k]) {
                // ???? weird here we work only on the group one because whichGroup is one and don't change ??????
                updateMolette(k +(objectGroup[i] *100), whichGroup) ; 
              }
            }
          }
        }
      }
    }
  // if it ask to show all slider  
  } else {
    for (int i = 1 ; i < NUM_GROUP_SLIDER ; i++) { 
      for(int j = 1 ; j < SLIDER_BY_GROUP ; j++) {
        updateMolette(j +(i *100), whichGroup) ; 
      }
    }
  }
  // END  DISPLAY MOLETTE
}







// annexe void molette
public void updateMolette(int whichOne, int whichGroup) {
  PVector sizeMoletteSlider = new PVector (8,10, 1.2f) ; // width, height, thickness
  
  //MIDI slider update
  sliderMidiUpdate(whichOne) ;
  
  // Slider update and display
  Slider[whichOne].update(mouseX, (int)infoSaveFromRawList(infoSlider, whichOne).z, loadSaveSetting); 
  PVector correctionPosMoletteY = new PVector(-2,2)  ;
  
  // choice the property display depending the group slider
  if (whichGroup == 0) 
  Slider[whichOne].displayMolette(blancGris, grisFonce, grisNoir, sizeMoletteSlider, correctionPosMoletteY); 
  else Slider[whichOne].displayMolette(blanc, grisClair, grisTresFonce, sizeMoletteSlider, correctionPosMoletteY);

  //return value between 0 / 100
  valueSlider[whichOne] = constrain(map(Slider[whichOne].getPos(), 0, 104, 0,100),0,100)  ;
}


//END MOLETTE
////////////






// DETAIL GROUP SLIDER DRAW
///////////////////////////
/* info rank slider by name
int hueFillRank = 1 ;
int saturationFillRank = 2 ;
int brightnessFillRank = 3 ;
int alphaFillRank = 4 ;
int hueStrokeRank = 5 ;
int saturationStrokeRank = 6 ;
int brightnessStrokeRank = 7 ;
int alphaStrokeRank = 8 ;

int thicknessRank = 11 ;
int widthObjRank = 12 ;
int heightObjRank = 13 ;
int depthObjRank = 14 ;
int canvasXRank = 15 ;
int canvasYRank = 16 ;
int canvasZRank = 17 ;
int quantityRank = 18 ;

int speedRank = 21 ;
int directionRank = 22 ;
int angleRank = 23 ;
int amplitudeRank = 24 ;
int analyzeRank = 25 ;
int famillyRank = 26 ;
int lifeRank = 27 ;
int forceRank = 28 ;
*/

/////////////////////////////
///object slider
public void sliderObject(int whichOne) {
  // to find the good slider in the array
  int whichGroup = whichOne ;
  whichOne *= 100 ;
  //
  if ( mouseX > (posWidthSlider[whichOne +hueFillRank] ) && mouseX < ( posWidthSlider[whichOne +hueFillRank] + longueurSlider[whichOne +hueFillRank]) 
       && mouseY > ( posHeightSlider[whichOne +hueFillRank] - 5) && mouseY < posHeightSlider[whichOne +hueFillRank] +30 ) 
  {
    if (displaySlider[whichGroup][hueFillRank])        fondRegletteCouleur    (posWidthSlider[whichOne +hueFillRank], posHeightSlider[whichOne +hueFillRank], hauteurSlider[whichOne +hueFillRank], longueurSlider[whichOne +hueFillRank]) ; 
    if (displaySlider[whichGroup][saturationFillRank]) fondRegletteSaturation (posWidthSlider[whichOne +saturationFillRank], posHeightSlider[whichOne +saturationFillRank], hauteurSlider[whichOne +saturationFillRank], longueurSlider[whichOne +hueFillRank], valueSlider[whichOne +hueFillRank], valueSlider[whichOne +saturationFillRank], valueSlider[whichOne +brightnessFillRank] ) ;
    if (displaySlider[whichGroup][brightnessFillRank]) fondRegletteDensite    (posWidthSlider[whichOne +brightnessFillRank], posHeightSlider[whichOne +brightnessFillRank], hauteurSlider[whichOne +brightnessFillRank], longueurSlider[whichOne +hueFillRank], valueSlider[whichOne +hueFillRank], valueSlider[whichOne +saturationFillRank], valueSlider[whichOne +brightnessFillRank] ) ;
  } else {
    if (displaySlider[whichGroup][hueFillRank])        fondReglette (posWidthSlider[whichOne +hueFillRank], posHeightSlider[whichOne +hueFillRank], hauteurSlider[whichOne +hueFillRank], longueurSlider[whichOne +hueFillRank], roundedSlider, blanc) ;
    if (displaySlider[whichGroup][saturationFillRank]) fondReglette (posWidthSlider[whichOne +saturationFillRank], posHeightSlider[whichOne +saturationFillRank], hauteurSlider[whichOne +saturationFillRank], longueurSlider[whichOne +saturationFillRank], roundedSlider, blanc ) ;
    if (displaySlider[whichGroup][brightnessFillRank]) fondReglette (posWidthSlider[whichOne +brightnessFillRank], posHeightSlider[whichOne +brightnessFillRank], hauteurSlider[whichOne +brightnessFillRank], longueurSlider[whichOne +brightnessFillRank], roundedSlider, blanc ) ;
  }
  if (displaySlider[whichGroup][alphaFillRank]) fondReglette (posWidthSlider[whichOne +alphaFillRank], posHeightSlider[whichOne +alphaFillRank], hauteurSlider[whichOne +alphaFillRank], longueurSlider[whichOne +alphaFillRank], roundedSlider, blanc ) ;
  
  //outline color
  if ( mouseX > (posWidthSlider[whichOne +hueStrokeRank] ) && mouseX < ( posWidthSlider[whichOne +hueStrokeRank] + longueurSlider[whichOne +hueStrokeRank]) 
       && mouseY > ( posHeightSlider[whichOne +hueStrokeRank] - 5) && mouseY < posHeightSlider[whichOne +hueStrokeRank] +30 ) 
  {
    if (displaySlider[whichGroup][hueStrokeRank])        fondRegletteCouleur    (posWidthSlider[whichOne +hueStrokeRank], posHeightSlider[whichOne +hueStrokeRank], hauteurSlider[whichOne +hueStrokeRank], longueurSlider[whichOne +hueStrokeRank]) ; 
    if (displaySlider[whichGroup][saturationStrokeRank]) fondRegletteSaturation (posWidthSlider[whichOne +saturationStrokeRank], posHeightSlider[whichOne +saturationStrokeRank], hauteurSlider[whichOne +saturationStrokeRank], longueurSlider[whichOne +hueStrokeRank], valueSlider[whichOne +hueStrokeRank], valueSlider[whichOne +saturationStrokeRank], valueSlider[whichOne +brightnessStrokeRank] ) ;
    if (displaySlider[whichGroup][brightnessStrokeRank]) fondRegletteDensite    (posWidthSlider[whichOne +brightnessStrokeRank], posHeightSlider[whichOne +brightnessStrokeRank], hauteurSlider[whichOne +brightnessStrokeRank], longueurSlider[whichOne +hueStrokeRank], valueSlider[whichOne +hueStrokeRank], valueSlider[whichOne +saturationStrokeRank], valueSlider[whichOne +brightnessStrokeRank] ) ;
  } else {
    if (displaySlider[whichGroup][hueStrokeRank])        fondReglette (posWidthSlider[whichOne +hueStrokeRank], posHeightSlider[whichOne +hueStrokeRank], hauteurSlider[whichOne +hueStrokeRank], longueurSlider[whichOne +hueStrokeRank], roundedSlider, blancGrisClair) ;
    if (displaySlider[whichGroup][saturationStrokeRank]) fondReglette (posWidthSlider[whichOne +saturationStrokeRank], posHeightSlider[whichOne +saturationStrokeRank], hauteurSlider[whichOne +saturationStrokeRank], longueurSlider[whichOne +saturationStrokeRank], roundedSlider, blancGrisClair ) ;
    if (displaySlider[whichGroup][brightnessStrokeRank]) fondReglette (posWidthSlider[whichOne +brightnessStrokeRank], posHeightSlider[whichOne +brightnessStrokeRank], hauteurSlider[whichOne +brightnessStrokeRank], longueurSlider[whichOne +brightnessStrokeRank], roundedSlider, blancGrisClair) ;
  }
  if (displaySlider[whichGroup][alphaStrokeRank]) fondReglette (posWidthSlider[whichOne +alphaStrokeRank], posHeightSlider[whichOne +alphaStrokeRank], hauteurSlider[whichOne +alphaStrokeRank], longueurSlider[whichOne +alphaStrokeRank], roundedSlider, blancGrisClair) ;
  //  thickness
  if( displaySlider[whichGroup][thicknessRank]) fondReglette ( posWidthSlider[whichOne +thicknessRank], posHeightSlider[whichOne +thicknessRank], hauteurSlider[whichOne +thicknessRank], longueurSlider[whichOne +thicknessRank], roundedSlider, blancGrisClair) ;
  // width, height, depth
  if(displaySlider[whichGroup][widthObjRank])  fondReglette (posWidthSlider[whichOne +widthObjRank], posHeightSlider[whichOne +widthObjRank], hauteurSlider[whichOne +widthObjRank], longueurSlider[whichOne +widthObjRank], roundedSlider, blanc) ;
  if(displaySlider[whichGroup][heightObjRank]) fondReglette (posWidthSlider[whichOne +heightObjRank], posHeightSlider[whichOne +heightObjRank], hauteurSlider[whichOne +heightObjRank], longueurSlider[whichOne +heightObjRank], roundedSlider, blanc) ;
  if(displaySlider[whichGroup][depthObjRank])  fondReglette (posWidthSlider[whichOne +depthObjRank], posHeightSlider[whichOne +depthObjRank], hauteurSlider[whichOne +depthObjRank], longueurSlider[whichOne +depthObjRank], roundedSlider, blanc) ;
  // canvas
  if(displaySlider[whichGroup][canvasXRank]) fondReglette (posWidthSlider[whichOne +canvasXRank], posHeightSlider[whichOne +canvasXRank], hauteurSlider[whichOne +canvasXRank], longueurSlider[whichOne +canvasXRank], roundedSlider, blancGrisClair) ;
  if(displaySlider[whichGroup][canvasYRank]) fondReglette (posWidthSlider[whichOne +canvasYRank], posHeightSlider[whichOne +canvasYRank], hauteurSlider[whichOne +canvasYRank], longueurSlider[whichOne +canvasYRank], roundedSlider, blancGrisClair) ;
  if(displaySlider[whichGroup][canvasZRank]) fondReglette (posWidthSlider[whichOne +canvasZRank], posHeightSlider[whichOne +canvasZRank], hauteurSlider[whichOne +canvasZRank], longueurSlider[whichOne +canvasZRank], roundedSlider, blancGrisClair) ;
  // quantity
  if(displaySlider[whichGroup][quantityRank]) fondReglette ( posWidthSlider[whichOne +quantityRank], posHeightSlider[whichOne +quantityRank], hauteurSlider[whichOne +quantityRank], longueurSlider[whichOne +quantityRank], roundedSlider, blanc) ;
  // speed
  if(displaySlider[whichGroup][speedRank]) fondReglette ( posWidthSlider[whichOne +speedRank], posHeightSlider[whichOne +speedRank], hauteurSlider[whichOne +speedRank], longueurSlider[whichOne +speedRank], roundedSlider, blanc) ;
  // direction angle
  if(displaySlider[whichGroup][directionRank]) fondReglette ( posWidthSlider[whichOne +directionRank], posHeightSlider[whichOne +directionRank], hauteurSlider[whichOne +directionRank], longueurSlider[whichOne +directionRank], roundedSlider, blancGrisClair) ;
  if(displaySlider[whichGroup][angleRank]) fondReglette ( posWidthSlider[whichOne +angleRank], posHeightSlider[whichOne +angleRank], hauteurSlider[whichOne +angleRank], longueurSlider[whichOne +angleRank], roundedSlider, blancGrisClair) ;
  // amplitude
  if(displaySlider[whichGroup][amplitudeRank]) fondReglette ( posWidthSlider[whichOne +amplitudeRank], posHeightSlider[whichOne +amplitudeRank], hauteurSlider[whichOne +amplitudeRank], longueurSlider[whichOne +amplitudeRank], roundedSlider, blanc) ;
  // analyze
  if(displaySlider[whichGroup][analyzeRank])  fondReglette ( posWidthSlider[whichOne +analyzeRank], posHeightSlider[whichOne +analyzeRank], hauteurSlider[whichOne +analyzeRank], longueurSlider[whichOne +analyzeRank], roundedSlider, blancGrisClair) ;
  // Family Life
  if(displaySlider[whichGroup][familyRank]) fondReglette ( posWidthSlider[whichOne +familyRank], posHeightSlider[whichOne +familyRank], hauteurSlider[whichOne +familyRank], longueurSlider[whichOne +familyRank], roundedSlider, blanc) ;
  if(displaySlider[whichGroup][lifeRank]) fondReglette ( posWidthSlider[whichOne +lifeRank], posHeightSlider[whichOne +lifeRank], hauteurSlider[whichOne +lifeRank], longueurSlider[whichOne +lifeRank], roundedSlider, blanc) ;
  // force
  if(displaySlider[whichGroup][forceRank]) fondReglette ( posWidthSlider[whichOne +forceRank], posHeightSlider[whichOne +forceRank], hauteurSlider[whichOne +forceRank], longueurSlider[whichOne +forceRank], roundedSlider, blancGrisClair) ;
}



// global slider
public void sliderDrawGroupZero () {
  //Background slider
  if (mouseX > (posWidthSlider[1] ) && mouseX < ( posWidthSlider[1] + longueurSlider[1]) 
  && mouseY > ( posHeightSlider[1] - 5) && mouseY < posHeightSlider[1] + 30 ) {
    fondRegletteCouleur    ( posWidthSlider[1], posHeightSlider[1], hauteurSlider[1], longueurSlider[1]) ;
    fondRegletteSaturation ( posWidthSlider[2], posHeightSlider[2], hauteurSlider[2], longueurSlider[1], valueSlider[1], valueSlider[2], valueSlider[3] ) ;
    fondRegletteDensite    ( posWidthSlider[3], posHeightSlider[3], hauteurSlider[3], longueurSlider[1], valueSlider[1], valueSlider[2], valueSlider[3] ) ;
  } else {
    fondReglette    ( posWidthSlider[1], posHeightSlider[1], hauteurSlider[1], longueurSlider[1], roundedSlider, grisClair) ;
    fondReglette    ( posWidthSlider[2], posHeightSlider[2], hauteurSlider[2], longueurSlider[2], roundedSlider, grisClair) ;
    fondReglette    ( posWidthSlider[3], posHeightSlider[3], hauteurSlider[3], longueurSlider[3], roundedSlider, grisClair) ;
  }
  fondReglette ( posWidthSlider[4], posHeightSlider[4], hauteurSlider[4], longueurSlider[4], roundedSlider, grisClair) ;
  // light ONE slider
  if (mouseX > (posWidthSlider[7] ) && mouseX < ( posWidthSlider[7] + longueurSlider[7]) 
  && mouseY > ( posHeightSlider[7] - 5) && mouseY < posHeightSlider[1] + 40 ) {
    fondRegletteCouleur    ( posWidthSlider[7], posHeightSlider[7], hauteurSlider[7], longueurSlider[7]) ;
    fondRegletteSaturation ( posWidthSlider[8], posHeightSlider[8], hauteurSlider[8], longueurSlider[7], valueSlider[7], valueSlider[8], valueSlider[9] ) ;
    fondRegletteDensite    ( posWidthSlider[9], posHeightSlider[9], hauteurSlider[9], longueurSlider[7], valueSlider[7], valueSlider[8], valueSlider[9] ) ;
  } else {
    fondReglette    ( posWidthSlider[7], posHeightSlider[7], hauteurSlider[7], longueurSlider[7], roundedSlider, grisClair) ;
    fondReglette    ( posWidthSlider[8], posHeightSlider[8], hauteurSlider[8], longueurSlider[8], roundedSlider, grisClair) ;
    fondReglette    ( posWidthSlider[9], posHeightSlider[9], hauteurSlider[9], longueurSlider[9], roundedSlider, grisClair) ;
  }
  // light TWO slider
  if (mouseX > (posWidthSlider[10] ) && mouseX < ( posWidthSlider[10] + longueurSlider[10]) 
  && mouseY > ( posHeightSlider[10] - 5) && mouseY < posHeightSlider[1] + 40 ) {
    fondRegletteCouleur    ( posWidthSlider[10], posHeightSlider[10], hauteurSlider[10], longueurSlider[10]) ;
    fondRegletteSaturation ( posWidthSlider[11], posHeightSlider[11], hauteurSlider[11], longueurSlider[10], valueSlider[10], valueSlider[11], valueSlider[9] ) ;
    fondRegletteDensite    ( posWidthSlider[12], posHeightSlider[12], hauteurSlider[12], longueurSlider[10], valueSlider[10], valueSlider[11], valueSlider[12] ) ;
  } else {
    fondReglette    ( posWidthSlider[10], posHeightSlider[10], hauteurSlider[10], longueurSlider[10], roundedSlider, grisClair) ;
    fondReglette    ( posWidthSlider[11], posHeightSlider[11], hauteurSlider[11], longueurSlider[11], roundedSlider, grisClair) ;
    fondReglette    ( posWidthSlider[12], posHeightSlider[12], hauteurSlider[12], longueurSlider[12], roundedSlider, grisClair) ;
  }
  // music
  fondReglette ( posWidthSlider[5], posHeightSlider[5], hauteurSlider[5], longueurSlider[5], roundedSlider, grisClair) ;
  fondReglette ( posWidthSlider[6], posHeightSlider[6], hauteurSlider[6], longueurSlider[6], roundedSlider, grisClair) ;
}


// END SLIDER DRAW
//////////////////




/////////////////////
public void buttonDraw() {
  textFont(textUsual_1) ;
  buttonDrawGroupZero() ;
  buttonDrawGroupOne() ;
  buttonDrawGroupTwo() ;
  buttonDrawGroupThree() ;
  buttonCheckDraw() ;
  dropdownDraw() ;
  buttonInfoOnTheTop() ;
  midiButtonManager(false) ;
}






public void buttonInfoOnTheTop() {
  fill(jaune) ;
   textFont(FuturaStencil_20) ;
  if(BOmidi.rollover()) text("Midi Setting",   mouseX -20, mouseY -20 ) ;
  if(BOcurtain.rollover()) text("Cut",   mouseX -20, mouseY -20 ) ;
}

// DETAIL
// GROUP ZERO
public void buttonDrawGroupZero() {
  buttonBackground.boutonTexte(shaderBackgroundName[EtatBackground] + " on/off", posBackgroundButton, FuturaStencil_10, 10) ;
  //LIGHT ONE
  buttonLightOne.boutonTexte("Light on/off", posLightOneButton, FuturaStencil_10, 10) ;
  buttonLightOneAction.boutonTexte("action", posLightOneAction, FuturaStencil_10, 10) ;
  // LIGHT TWO
  buttonLightTwo.boutonTexte("Light on/off",  posLightTwoButton, FuturaStencil_10, 10) ;
  buttonLightTwoAction.boutonTexte("action",  posLightTwoAction, FuturaStencil_10, 10) ;
  
  // SOUND
  Bbeat.boutonTexte("BEAT", posBeatButton, FuturaStencil_10, 10) ;
  Bkick.boutonTexte("KICK", posKickButton, FuturaStencil_10, 10) ;
  Bsnare.boutonTexte("SNARE", posSnareButton, FuturaStencil_10, 10) ;
  Bhat.boutonTexte("HAT", posHatButton, FuturaStencil_10, 10) ;
  
  //MIDI / CURTAIN
  BOmidi.buttonPic(picMidi) ;
  BOcurtain.buttonPic(picCurtain) ;
}
//GROUP ONE
public void buttonDrawGroupOne() {
  int rankThumbnail = 0 ;
  for( int i = 1 ; i <= numGroup[1] ; i++ ) {
    BOf[i*10 +1].buttonPicSerie(OFF_in_thumbnail, OFF_out_thumbnail, ON_in_thumbnail, ON_out_thumbnail, i +rankThumbnail ) ; 
    BOf[i*10 +2].buttonPic(picSetting) ;
    BOf[i*10 +3].buttonPic(picSound) ; 
    BOf[i*10 +4].buttonPic(picAction) ; 
    PVector pos = new PVector (posWidthBOf[i*10 +2], posHeightBOf[i*10 +1] +10) ;
    PVector size = new PVector (20, 30) ;
    rolloverInfoVignette(pos, size, i, 1) ;
  }
}
// GROUP TWO
public void buttonDrawGroupTwo() {
  // var use to find the good thumbnail
  int rankThumbnail = numGroup[1] ;
  for( int i = 1 ; i <= numGroup[2] ; i++ ) {
    BTf[i*10 +1].buttonPicSerie(OFF_in_thumbnail, OFF_out_thumbnail, ON_in_thumbnail, ON_out_thumbnail, i +rankThumbnail) ; 
    BTf[i*10 +2].buttonPic(picSetting) ;
    BTf[i*10 +3].buttonPic(picSound) ; 
    BTf[i*10 +4].buttonPic(picAction) ;     
    PVector pos = new PVector (posWidthBTf[i*10 +2], posHeightBTf[i*10 +1] +10) ;
    PVector size = new PVector (20, 30) ;
    rolloverInfoVignette(pos, size, i, 2) ;
  }
}

//GROUP THREE
public void buttonDrawGroupThree() {
  // var use to find the good thumbnail
  int rankThumbnail = numGroup[1] + numGroup[2] ;
  for( int i = 1 ; i <= numGroup[3] ; i++ ) {
    BTYf[i*10 +1].buttonPicSerie(OFF_in_thumbnail, OFF_out_thumbnail, ON_in_thumbnail, ON_out_thumbnail, i +rankThumbnail) ; 
    BTYf[i*10 +2].buttonPic(picSetting) ;
    BTYf[i*10 +3].buttonPic(picSound) ; 
    BTYf[i*10 +4].buttonPic(picAction) ; 
    PVector pos = new PVector (posWidthBTYf[i*10 +2], posHeightBTYf[i*10 +1] +10) ;
    PVector size = new PVector (20, 30) ;
    rolloverInfoVignette(pos, size, i, 3) ;
  }
}



public void buttonCheckDraw() {
  EtatBackgroundButton = buttonBackground.getOnOff() ;
  //LIGHT ONE
  EtatLightOneButton = buttonLightOne.getOnOff() ;
  EtatLightOneAction = buttonLightOneAction.getOnOff() ;
  // LIGHT TWO
  EtatLightTwoButton = buttonLightTwo.getOnOff() ;
  EtatLightTwoAction = buttonLightTwoAction.getOnOff() ;
  //SOUND
  EtatBbeat = Bbeat.getOnOff() ;
  EtatBkick = Bkick.getOnOff() ;
  EtatBsnare = Bsnare.getOnOff() ;
  EtatBhat = Bhat.getOnOff() ;
  //Check position of button
  EtatMidiButton = BOmidi.getOnOff() ;
  EtatCurtainButton = BOcurtain.getOnOff() ;


  //Statement button, if are OFF or ON
  for(int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
    int num = numButton[i] +10 ;
    for( int j = 11 ; j < num ; j++) {
      if(numGroup[1] > 0 && i == 1 ) EtatBOf[j-10] = BOf[j].getOnOff() ;
      if(numGroup[2] > 0 && i == 2 ) EtatBTf[j-10] = BTf[j].getOnOff() ;
      if(numGroup[3] > 0 && i == 3 ) EtatBTYf[j-10] = BTYf[j].getOnOff() ;
    }
  }
}





//ANNEXE VOID
//show info
public void rolloverInfoVignette(PVector pos, PVector size, int IDorder, int IDfamily) {
  if (mouseX > pos.x && mouseX < (size.x + pos.x ) && mouseY > pos.y - 10 && mouseY <  (size.y + pos.y) -20 ) {
    PVector fontPos = new PVector(-10, -20 ) ;
    
    for ( int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
      if (IDfamily == i && numGroup[i]>0 ) {
        int rank = 0 ;
        if ( IDfamily == 1 ) rank = IDorder ;
        if ( IDfamily == 2 ) rank = IDorder +numGroup[1] ;
        if ( IDfamily == 3 ) rank = IDorder +numGroup[1] +numGroup[2] ;  
        lookAndDisplayInfo(rank, fontPos) ;
      }
    }
  }
}

public void lookAndDisplayInfo(int IDorder, PVector pos) {
  int whichLine = 0 ;
  int num = objectList.getRowCount() ;
  for ( int j = 0 ; j < num ; j++) {
    TableRow lookFor = objectList.getRow(j);
    int ID = lookFor.getInt("ID") ;
    if ( ID == IDorder ) {
      whichLine = j ;
    }
  }
  TableRow displayInfo = objectList.getRow(whichLine) ;
  String NameObj = displayInfo.getString("Name") ;
  String AuthorObj = displayInfo.getString("Author") ;
  String VersionObj = displayInfo.getString("Version") ;
  String PackObj = displayInfo.getString("Pack") ; 
  fill(jaune) ;  
  textSize(20 ) ;
  textFont(FuturaStencil_20) ;
  text(NameObj, mouseX +pos.x, mouseY +pos.y -25) ;
  textSize(15 ) ;
  text(AuthorObj, mouseX +pos.x, mouseY +pos.y -10) ;
  textSize(10 ) ;
  text(VersionObj, mouseX +pos.x, mouseY +pos.y +0) ;
  text(PackObj, mouseX +pos.x, mouseY +pos.y +10) ;
}
// END DISPLAY INFO OBJECT
//////////////////////////


//SLIDER COLOR
public void fondReglette ( int posX, int posY, int heightSlider, int widthslider, int rounded, int couleur) {
  fill ( couleur ) ;
  rect ( posX  , posY - (heightSlider *.5f) ,widthslider ,heightSlider, rounded) ;
}

//hue
public void fondRegletteCouleur ( int posX, int posY, int heightSlider, int widthslider) {
  pushMatrix () ;
  translate (posX , posY-(heightSlider *.5f)) ;
  for ( int i=0 ; i < widthslider ; i++ ) {
    for ( int j=0 ; j <=heightSlider ; j++ ) {
      float cr = map(i, 0, widthslider, 0, 360 ) ;
      fill (cr, 100, 100) ;
      rect ( i, j, 1,1 ) ;
    }
  }
  popMatrix() ;
}

//saturation
public void fondRegletteSaturation ( int posX, int posY, int heightSlider, int widthslider, float couleur, float s, float d) {
  pushMatrix () ;
  translate (posX , posY-(heightSlider *.5f)) ;
  for ( int i=0 ; i < widthslider ; i++ ) {
    for ( int j=0 ; j <=heightSlider ; j++ ) {
      float cr = map(i, 0, widthslider, 0, 100 ) ;
      float coul = map(couleur, 0, widthslider, 0, 360 ) ;
      // float sat = map(s, 0, largeur, 0, 100 ) ;
      float dens = map(d, 0, widthslider, 0, 100 ) ;
      fill (coul, cr, dens) ;
      rect ( i, j, 1,1 ) ;
    }
  }
  popMatrix() ;
}

//density
public void fondRegletteDensite ( int posX, int posY, int heightSlider, int widthslider, float couleur, float s, float d) {
  pushMatrix () ;
  translate (posX , posY-(heightSlider *.5f)) ;
  for ( int i=0 ; i < widthslider ; i++ ) {
    for ( int j=0 ; j <=heightSlider ; j++ ) {
      float cr = map(i, 0, widthslider, 0, 100 ) ;
      float coul = map(couleur, 0, widthslider, 0, 360 ) ;
      float sat = map(s, 0, widthslider, 0, 100 ) ;
      // float dens = map(d, 0, largeur, 0, 100 ) ;
      fill (coul, sat, cr) ;
      rect (i, j, 1,1) ;
    }
  }
  popMatrix() ;
}



// DROPDOWN
int refSizeImageDropdown, refSizeFileTextDropdown ;
PVector posTextDropdownImage, posTextDropdownFileText ; 
int selectedText ;
int colorBoxIn, colorBoxOut, colorBoxText, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut ;
int sizeToRenderTheBoxDropdown = 15 ;

public void dropdownSetup() {
   //dropdown
   colorDropdownBG = rougeTresFonce ;
   colorDropdownTitleIn = jaune ;
   colorDropdownTitleOut = orange ;
   colorBoxIn = jaune ; 
   colorBoxOut = orange ;
   colorBoxText = rougeFonce ;
   selectedText = vertFonce ;

  //load the external list  for each mode and split to read in the interface
  for (int i = 0 ; i<objectList.getRowCount() ; i++) {
    TableRow row = objectList.getRow(i);
    modeListRomanesco [row.getInt("ID")] = row.getString("Mode"); 
  }
  //font
  String pList [] = loadStrings(sketchPath("")+"preferences/Font/fontList.txt") ;
  String policeList = join(pList, "") ;
  policeDropdownList = split(policeList, "/") ;
  
  //image
  initLiveData() ;
 
  //SHADER backgorund dropdown
  
  ///////////////
  posDropdownBackground = new PVector(posButtonBackground.x, posButtonBackground.y, 0.1f)  ; // x y is pos anz z is marge between the dropdown and the header
  sizeDropdownBackground = new PVector (75, sizeToRenderTheBoxDropdown, 10) ; // z is the num of line you show
  PVector posTextDropdownBackground = new PVector(3, 10)  ;
  dropdownBackground = new Dropdown("Background", shaderBackgroundName, posDropdownBackground, sizeDropdownBackground, posTextDropdownBackground, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  
  //FONT dropdown
  ///////////////
  posDropdownFont = new PVector(posButtonFont.x, posButtonFont.y, 0.1f)  ; // x y is pos anz z is marge between the dropdown and the header
  sizeDropdownFont = new PVector (40, sizeToRenderTheBoxDropdown, 10 ) ; // z is the num of line you show
  PVector posTextDropdownTypo = new PVector(3, 10)  ;
  dropdownFont = new Dropdown("Font", policeDropdownList,   posDropdownFont , sizeDropdownFont, posTextDropdownTypo, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  // Image Dropdown
  //////////////////
  posDropdownImage = new PVector(posButtonImage.x, posButtonImage.y, 0.1f)  ; // x y is pos anz z is marge between the dropdown and the header
  sizeDropdownImage = new PVector (60, sizeToRenderTheBoxDropdown, 10 ) ; // z is the num of line you show
  posTextDropdownImage = new PVector(3, 10)  ;
  refSizeImageDropdown = imageDropdownList.length ;
  dropdownImage = new Dropdown("Image", imageDropdownList, posDropdownImage, sizeDropdownImage, posTextDropdownImage, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  // File text Dropdown
  //////////////////
  posDropdownFileText = new PVector(posButtonFileText.x, posButtonFileText.y, 0.1f)  ; // x y is pos anz z is marge between the dropdown and the header
  sizeDropdownFileText = new PVector (40, sizeToRenderTheBoxDropdown, 10 ) ; // z is the num of line you show
  posTextDropdownFileText = new PVector(3, 10)  ;
  refSizeFileTextDropdown = fileTextDropdownList.length ;
  dropdownFileText = new Dropdown("Text", fileTextDropdownList, posDropdownFileText, sizeDropdownFileText, posTextDropdownFileText, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  
  
  //MODE Dropdown
  ///////////////
  colorDropdownTitleIn = rouge ;
  colorDropdownTitleOut = rougeFonce ;
  //common param
  sizeDropdownMode = new PVector (20, sizeToRenderTheBoxDropdown, 8) ;
  PVector newPos = new PVector( -8, 40 ) ;
  //object line
  checkTheDropdownSetupObject(startLoopObject, endLoopObject, posWidthBO +newPos.x, posHeightBO +newPos.y) ;
  //Texture line
  checkTheDropdownSetupObject(startLoopTexture, endLoopTexture, posWidthBT +newPos.x, posHeightBT +newPos.y) ;
  //Typo line
  checkTheDropdownSetupObject(startLoopTypo, endLoopTypo, posWidthBTY +newPos.x, posHeightBTY +newPos.y) ;
}

public void checkTheDropdownSetupObject( int start, int end, float posWidth, float posHeight) {
  for ( int i = start ; i < end ; i ++ ) {
    if(modeListRomanesco[i] != null ) {
      int space = ((i - start +1) * 40) - 40 ;
      //Split the dropdown to display in the dropdown
      listDropdown = split(modeListRomanesco[i], "/" ) ;
      //to change the title of the header dropdown

      posDropdown[i] = new PVector(posWidth +space, posHeight , 0.1f)  ; // x y is pos anz z is marge between the dropdown and the header
      dropdown[i] = new Dropdown("M", listDropdown, posDropdown[i], sizeDropdownMode, posTextDropdown, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
    }
  }
}








//DRAW DROPDOWN
boolean dropdownActivity ;
int dropdownActivityCount ;

public void dropdownDraw() {
  checkTheDropdownDrawObject(startLoopObject, endLoopObject) ;
  checkTheDropdownDrawObject(startLoopTexture, endLoopTexture) ;
  checkTheDropdownDrawObject(startLoopTypo, endLoopTypo) ;
  dropdownBackground() ;
  dropdownFont() ;
  dropdownImage() ;
  dropdownFileText() ;
  // check the activity o the dropdown
  if(dropdownActivityCount > 0 ) dropdownActivity = true ; else dropdownActivity = false ;
  dropdownActivityCount = 0 ;
}
// END MAIN

// SHADER Background
public void dropdownBackground() {
  
  dropdownBackground.dropdownUpdate(FuturaStencil_10, textUsual_1);
  if (dropdownOpen) dropdownActivityCount = +1 ;
  margeAroundDropdown = sizeDropdownFont.y  ;
  //give the size of menu recalculate with the size of the word inside
  PVector newSizeFont = dropdownBackground.sizeBoxDropdownMenu ;
  //compare the standard size of dropdown with the number of element of the list.
  int heightDropdown = 0 ;
  if(shaderBackgroundName.length < sizeDropdownBackground.z ) heightDropdown = shaderBackgroundName.length ; else heightDropdown = (int)sizeDropdownBackground.z ;
  totalSizeDropdown = new PVector ( newSizeFont.x +(margeAroundDropdown *1.5f), sizeDropdownBackground.y *(heightDropdown +1) +margeAroundDropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  newPosDropdown = new PVector (posDropdownBackground.x -margeAroundDropdown, posDropdownBackground.y) ;
  if (!insideRect(newPosDropdown, totalSizeDropdown)) dropdownBackground.locked = false ;
  // display the selection
  
  if(!dropdownBackground.locked) {
    fill(selectedText) ;
    textFont(textUsual_2) ;
    EtatBackground = dropdownBackground.getSelection() ;
    if (dropdownBackground.getSelection() != 0 ) {
      text(shaderBackgroundName[EtatBackground] +" by " +shaderBackgroundAuthor[dropdownBackground.getSelection()], posDropdownBackground.x +3 , posDropdownBackground.y +22) ;
    } else {
      text(shaderBackgroundName[EtatBackground], posDropdownBackground.x +3 , posDropdownBackground.y +22) ;
    }
      
  }
}

// FONT
public void dropdownFont() {
  dropdownFont.dropdownUpdate(FuturaStencil_10, textUsual_1);
  if (dropdownOpen) dropdownActivityCount = +1 ;
  margeAroundDropdown = sizeDropdownFont.y  ;
  //give the size of menu recalculate with the size of the word inside
  PVector newSizeFont = dropdownFont.sizeBoxDropdownMenu ;
  //compare the standard size of dropdown with the number of element of the list.
  int heightDropdown = 0 ;
  if(policeDropdownList.length < sizeDropdownFont.z ) heightDropdown = policeDropdownList.length ; else heightDropdown = (int)sizeDropdownFont.z ;
  totalSizeDropdown = new PVector (newSizeFont.x +(margeAroundDropdown *1.5f), sizeDropdownFont.y *(heightDropdown +1) +margeAroundDropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  newPosDropdown = new PVector (posDropdownFont.x -margeAroundDropdown, posDropdownFont.y) ;
  if (!insideRect(newPosDropdown, totalSizeDropdown)) dropdownFont.locked = false ;
  
  if(!dropdownFont.locked) {
    fill(selectedText) ;
    // display the selection
    textFont(textUsual_2) ;
    text(policeDropdownList[dropdownFont.getSelection()], posDropdownFont.x +3 , posDropdownFont.y +22) ;
  }
}

// IMAGE

public void dropdownImage() {
  // live update of the content
  if(imageDropdownList.length != refSizeImageDropdown ) {
    dropdownImage = new Dropdown("Image", imageDropdownList, posDropdownImage, sizeDropdownImage, posTextDropdownImage, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
    refSizeImageDropdown = imageDropdownList.length ;
  }
  
  dropdownImage.dropdownUpdate(FuturaStencil_10, textUsual_1);
  if (dropdownOpen) dropdownActivityCount = +1 ;
  margeAroundDropdown = sizeDropdownImage.y  ;
  //give the size of menu recalculate with the size of the word inside
  PVector newSizeImage = dropdownImage.sizeBoxDropdownMenu ;
  //compare the standard size of dropdown with the number of element of the list.
  int heightDropdown = 0 ;
  if(imageDropdownList.length < sizeDropdownImage.z ) heightDropdown = imageDropdownList.length ; else heightDropdown = (int)sizeDropdownImage.z ;
  totalSizeDropdown = new PVector (newSizeImage.x +(margeAroundDropdown *1.5f), sizeDropdownImage.y *(heightDropdown +1) +margeAroundDropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  newPosDropdown = new PVector (posDropdownImage.x -margeAroundDropdown, posDropdownImage.y) ;
  if (!insideRect(newPosDropdown, totalSizeDropdown)) dropdownImage.locked = false ;
  
  if(!dropdownImage.locked) {
    fill(selectedText) ;
    //give the value for the save
  //  saveR [7] = byte(dropdownImage.getSelection() +1) ;
    // display the selection
    EtatImage = dropdownImage.getSelection() ;
    textFont(textUsual_2) ;
    text(imageDropdownList[dropdownImage.getSelection()], posDropdownImage.x +3, posDropdownImage.y +22) ;
  }
}


// FILE TEXT
public void dropdownFileText() {
  // live update of the content
  if(fileTextDropdownList.length != refSizeFileTextDropdown ) {
    dropdownFileText = new Dropdown("Text", fileTextDropdownList, posDropdownFileText, sizeDropdownFileText, posTextDropdownFileText, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
    refSizeFileTextDropdown = fileTextDropdownList.length ;
  }
  
  dropdownFileText.dropdownUpdate(FuturaStencil_10, textUsual_1);
  if (dropdownOpen) dropdownActivityCount = +1 ;
  margeAroundDropdown = sizeDropdownFileText.y  ;
  //give the size of menu recalculate with the size of the word inside
  PVector newSizeFileText = dropdownFileText.sizeBoxDropdownMenu ;
  //compare the standard size of dropdown with the number of element of the list.
  int heightDropdown = 0 ;
  if(fileTextDropdownList.length < sizeDropdownFileText.z ) heightDropdown = fileTextDropdownList.length ; else heightDropdown = (int)sizeDropdownFileText.z ;
  totalSizeDropdown = new PVector ( newSizeFileText.x +(margeAroundDropdown *1.5f), sizeDropdownFileText.y *(heightDropdown +1) +margeAroundDropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  newPosDropdown = new PVector (posDropdownFileText.x -margeAroundDropdown, posDropdownFileText.y) ;
  if (!insideRect(newPosDropdown, totalSizeDropdown)) dropdownFileText.locked = false ;
  
  if(!dropdownFileText.locked) {
    fill(selectedText) ;
      //give the value for the save
    //saveR [7] = byte(dropdownFileText.getSelection() +1) ;
    // display the selection
    EtatFileText = dropdownFileText.getSelection() ;
    textFont(textUsual_2) ;
    text(fileTextDropdownList[dropdownFileText.getSelection()], posDropdownFileText.x +3 , posDropdownFileText.y +22) ;
  }
}

// OBJECT
public void checkTheDropdownDrawObject( int start, int end ) {
  for ( int i = start ; i < end ; i ++ ) {
    if(modeListRomanesco[i] != null ) {
      String m [] = split(modeListRomanesco[i], "/") ;
      if ( m.length > 1) {
        dropdown[i].dropdownUpdate(FuturaStencil_10, textUsual_1);
        if (dropdownOpen) dropdownActivityCount = +1 ;
        margeAroundDropdown = sizeDropdownMode.y  ;
        //give the size of menu recalculate with the size of the word inside
        PVector newSizeModeTypo = dropdown[i].sizeBoxDropdownMenu ;
         int heightDropdown = 0 ;
        if(dropdown[i].listItem.length < sizeDropdownMode.z ) heightDropdown = dropdown[i].listItem.length ; else heightDropdown = (int)sizeDropdownMode.z ;
        totalSizeDropdown = new PVector (newSizeModeTypo.x + (margeAroundDropdown *1.5f) , sizeDropdownMode.y * (heightDropdown +1)  + margeAroundDropdown   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
         //new pos to include the slider
        newPosDropdown = new PVector (posDropdown[i].x - margeAroundDropdown, posDropdown[i].y) ;
        if ( !insideRect(newPosDropdown, totalSizeDropdown)) {
          dropdown[i].locked = false;
        }
      }
      if (dropdown[i].getSelection() > -1 && m.length > 1) {
        textFont(FuturaStencil_10) ;
        text(dropdown[i].getSelection() +1, posDropdown[i].x +12 , posDropdown[i].y +8) ;
      }
    }
  }
}
//END DROPDOWN DRAW



//MOUSEPRESSED
public void dropdownMousepressed() {
  checkDropdownBackground() ;
  checkDropdownFont() ;
  checkDropdownImage() ;
  checkDropdownFileText() ;
  // group One
  checkTheDropdownObjectMousepressed(startLoopObject, endLoopObject ) ;
  // group Two
  checkTheDropdownObjectMousepressed(startLoopTexture, endLoopTexture ) ;
  //group one
  checkTheDropdownObjectMousepressed(startLoopTypo, endLoopTypo ) ;
}
// END MAIN


public void checkDropdownBackground() {
  if (dropdownBackground != null) {
    if (insideRect(posDropdownBackground, sizeDropdownBackground) && !dropdownBackground.locked  ) {
      dropdownBackground.locked = true;
    } else if (dropdownBackground.locked) {
      float newWidthDropdown = dropdownBackground.sizeBoxDropdownMenu.x ;
      int line = dropdownBackground.selectDropdownLine(newWidthDropdown);
      if (line > -1 ) {
        dropdownBackground.whichDropdownLine(line);
        //to close the dropdown
        dropdownBackground.locked = false;        
      } 
    }
  }
}

// FONT
public void checkDropdownFont() {
  if (dropdownFont != null) {
    if (insideRect(posDropdownFont, sizeDropdownFont) && !dropdownFont.locked  ) {
      dropdownFont.locked = true;
    } else if (dropdownFont.locked) {
      float newWidthDropdown = dropdownFont.sizeBoxDropdownMenu.x ;
      int line = dropdownFont.selectDropdownLine(newWidthDropdown);
      if (line > -1 ) {
        dropdownFont.whichDropdownLine(line);
        //to close the dropdown
        dropdownFont.locked = false;        
      } 
    }
  }
}

// IMAGE
public void checkDropdownImage() {
  if (dropdownImage != null) {
    if (insideRect(posDropdownImage, sizeDropdownImage) && !dropdownImage.locked  ) {
      dropdownImage.locked = true;
    } else if (dropdownImage.locked) {
      float newWidthDropdown = dropdownImage.sizeBoxDropdownMenu.x ;
      int line = dropdownImage.selectDropdownLine(newWidthDropdown);
      if (line > -1 ) {
        dropdownImage.whichDropdownLine(line);
        //to close the dropdown
        dropdownImage.locked = false;        
      } 
    }
  }
}

// FILE TEXT
public void checkDropdownFileText() {
  if (dropdownFileText != null) {
    if (insideRect(posDropdownFileText, sizeDropdownFileText) && !dropdownFileText.locked  ) {
      dropdownFileText.locked = true;
    } else if (dropdownFileText.locked) {
      float newWidthDropdown = dropdownFileText.sizeBoxDropdownMenu.x ;
      int line = dropdownFileText.selectDropdownLine(newWidthDropdown);
      if (line > -1 ) {
        dropdownFileText.whichDropdownLine(line);
        //to close the dropdown
        dropdownFileText.locked = false;        
      } 
    }
  }
}

public void checkTheDropdownObjectMousepressed( int start, int end ) {
  for ( int i = start ; i < end ; i ++ ) { 
    if (dropdown[i] != null) {
      if (insideRect(posDropdown[i], sizeDropdownMode) && !dropdown[i].locked  ) {
        dropdown[i].locked = true;
      } else if (dropdown[i].locked) {
        float newWidthDropdown = dropdown[i].sizeBoxDropdownMenu.x ;
        int line = dropdown[i].selectDropdownLine(newWidthDropdown);
        if (line > -1 ) {
          dropdown[i].whichDropdownLine(line);
          //to close the dropdown
          dropdown[i].locked = false;        
        } 
      }
    }
  }
}
//GLOBAL


public PFont 
      //controleur font
      textUsual_1, textUsual_2, textUsual_3,
      title_1, title_2,
      FuturaCondLight_10, FuturaCondLight_11,FuturaCondLight_12,
      FuturaStencil_20, FuturaStencil_10 ;
      
//SETUP
public void fontSetup() {
  //controleur Font
  String fontPathVLW = sketchPath("")+"preferences/Font/typoVLW/" ;
  FuturaStencil_20 = loadFont(fontPathVLW+"FuturaStencilICG-20.vlw");
  FuturaStencil_10 = loadFont(fontPathVLW+"FuturaStencilICG-10.vlw");
  FuturaCondLight_10 = loadFont(fontPathVLW+"Futura-CondensedLight-10.vlw");
  FuturaCondLight_11 = loadFont(fontPathVLW+"Futura-CondensedLight-11.vlw");
  FuturaCondLight_12 = loadFont(fontPathVLW+"Futura-CondensedLight-12.vlw");
  
  textUsual_1 = FuturaCondLight_10 ;
  textUsual_2 = FuturaCondLight_11 ;
  textUsual_3 = FuturaCondLight_12 ;
  title_1 = FuturaStencil_10 ;
  title_2 = FuturaStencil_20 ;
}
//MIDI
//SETUP
public void midiSetup() {
  //get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);
  //open the first midi channel of the first device if there Input
  if (midiIO.numberOfInputDevices() > 0 ) midiIO.openInput(0,0);
  indexMidiButton() ;
}
//DRAW
public void midiDraw() {
  //save midi setting molette
  if (EtatMidiButton == 1) selectMidi = true ; else selectMidi = false ;
}




// MIDI SETTING


public void midiButtonManager(boolean saveButton) {
  // close loop for load save button
  // see void buttonSetSaveSetting()
  int rank = 0 ;
  midiButton(buttonBackground, rank++, saveButton) ;
  midiButton(BOcurtain, rank++, saveButton) ;
  
  midiButton(buttonLightOne, rank++, saveButton) ;
  midiButton(buttonLightOneAction, rank++, saveButton) ;
  midiButton(buttonLightTwo, rank++, saveButton) ;
  midiButton(buttonLightTwoAction, rank++, saveButton) ;
  
  midiButton(Bbeat, rank++, saveButton) ;
  midiButton(Bkick, rank++, saveButton) ;
  midiButton(Bsnare, rank++, saveButton) ;
  midiButton(Bhat, rank++, saveButton) ;
  
  int whichGroup = 1 ;
  for( int i = 1 ; i <= numGroup[whichGroup ] ; i++ ) {
    rank = 1 ;
    midiButton(BOf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(BOf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(BOf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(BOf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ;
  }
  whichGroup = 2 ; 
  for( int i = 1 ; i <= numGroup[whichGroup] ; i++ ) {
    rank = 1 ;
    midiButton(BTf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(BTf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(BTf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ; 
    midiButton(BTf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ;     
  }
  whichGroup = 3 ;
  for( int i = 1 ; i <= numGroup[whichGroup] ; i++ ) {
    rank = 1 ;
    midiButton(BTYf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(BTYf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(BTYf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ; rank++ ;
    midiButton(BTYf[posRankButton(i,rank)], posRankButton(i,rank), saveButton) ;
  }
}


//
public int posRankButton(int pos, int rank) {
  return pos*10 +rank ;
}

//
public void midiButton(Button b, int IDbutton, boolean saveButton) {
  setttingMidiButton(b) ;
  updateMidiButton(b) ;
  if(saveButton) setButton(IDbutton, b.IDmidi(), b.onOff) ;
}

//
public void setttingMidiButton(Button b) {
  if(selectMidi && b.inside && mousePressed) b.selectIDmidi(numMidi) ;
}

//
public void updateMidiButton(Button b) {
   if(valMidi == 127 && numMidi == b.IDmidi()) {
    b.onOff = !b.onOff ;
    valMidi = 0 ;
  }
}



//SLIDER MIDI SETTING


//give which button is active and check is this button have a same IDmidi that Object
public void sliderMidiUpdate(int whichOne) {
  // update info from midi controller
  if (numMidi == Slider[whichOne].IDmidi()) Slider[whichOne].updateMidi(valMidi) ;

  
  if(selectMidi && Slider[whichOne].lock()) {
    for(int i = 0 ; i <infoSlider.length ; i++) {
      if(whichOne == (int)infoSlider[i].x) {
        infoSlider[i].y = numMidi  ;
        //println(infoSlider[i]) ;
      }
    }

    //println(infoSlider) ;
    // println(whichOne, numMidi) ;
  }
  
  //ID midi from controller midi button setting
  if (selectMidi && Slider[whichOne].lock()) Slider[whichOne].selectIDmidi(numMidi) ;
  
  //ID midi from save
  if(loadSaveSetting) Slider[whichOne].selectIDmidi((int)infoSaveFromRawList(infoSlider, whichOne).y) ;
}
// END MIDI
//GLOBAL



OscP5 osc;
NetAddress targetPreScene ;
// local
String IPadress = ("127.0.0.1") ;
// Message to pr\u00e9Sc\u00e8ne
String toPreScene [] = new String [8] ;



public void sendOSCsetup() {
  osc = new OscP5(this, 10000);
 targetPreScene = new NetAddress(IPadress,10000);
}

public void sendOSCdraw() {
  OscMessage RomanescoControleur = new OscMessage("ROMANESCO contr\u00f4leur");
  
  //int value join in one String 
  translateDataToSend() ;
  
  //BUTTON to String
  toPreScene[0] = joinIntToString(valueButtonGlobal) ; 
  toPreScene[1] = joinIntToString(valueButtonObj) ;
  toPreScene[2] = joinIntToString(valueButtonTex) ;
  toPreScene[3] = joinIntToString(valueButtonTypo) ;
  //SLIDER to String
  int[] dataIntGlobal = new int[NUM_SLIDER_GLOBAL] ;
  for ( int i = 1   ; i < NUM_SLIDER_GLOBAL-1 ; i++) { 
    dataIntGlobal[i-1] = floor(valueSlider[i]) ; 
  }
  toPreScene[4] = joinIntToString(dataIntGlobal) ;
  //float value slider obj
  int[] dataIntObj = new int[SLIDER_BY_GROUP] ;
  for ( int i = 101   ; i < 101 +SLIDER_BY_GROUP ; i++) { dataIntObj[i-101] = floor(valueSlider[i]) ; }
  toPreScene[5] = joinIntToString(dataIntObj);
  //float value slider tex
  int[] dataIntTex = new int[SLIDER_BY_GROUP] ;
  for ( int i = 201   ; i < 201 +SLIDER_BY_GROUP ; i++) { dataIntTex[i-201] = floor(valueSlider[i]) ; }
  toPreScene[6] = joinIntToString(dataIntTex) ;
  //float value slider typo
  int[] dataIntTypo = new int[SLIDER_BY_GROUP] ;
  for ( int i = 301   ; i < 301 +SLIDER_BY_GROUP ; i++) { dataIntTypo[i-301] = floor(valueSlider[i]) ; }
  toPreScene[7] = joinIntToString(dataIntTypo) ;
  
  //add to OSC
  for ( int i = 0 ; i < toPreScene.length ; i++) {
    RomanescoControleur.add(toPreScene[i]);
  }
  
  //send
  osc.send(RomanescoControleur, targetPreScene ); 
}



  
  
  
public void translateDataToSend() {
  //BUTTON GLOBAL
  //sound
  valueButtonGlobal[1] = EtatBbeat ;
  valueButtonGlobal[2] = EtatBkick ;
  valueButtonGlobal[3] = EtatBsnare ;
  valueButtonGlobal[4] = EtatBhat ;
  /*
  valueButtonGlobal[7] = dropdownFont.getSelection() +1 ; ;
  valueButtonGlobal[10] = EtatCurtainButton ;
  */
  valueButtonGlobal[5] = dropdownFont.getSelection() +1 ; ;
  valueButtonGlobal[6] = EtatCurtainButton ;
  valueButtonGlobal[7] = EtatBackgroundButton ;
  valueButtonGlobal[8] = EtatLightOneButton ;
  valueButtonGlobal[9] = EtatLightTwoButton ;
  valueButtonGlobal[10] = EtatLightOneAction ;
  valueButtonGlobal[11] = EtatLightTwoAction ;
  
  valueButtonGlobal[12] = EtatBackground ;
  valueButtonGlobal[13] = EtatImage ;
  valueButtonGlobal[14] = EtatFileText ;
  
  //BUTTON OBJ
  if(numGroup[1] > 0 ) {
    for ( int i = 0 ; i < numGroup[1]   ; i ++) {
      valueButtonObj[i *10 +1] = EtatBOf[i *10 +1] ;
      valueButtonObj[i *10 +2] = EtatBOf[i *10 +2] ;
      valueButtonObj[i *10 +3] = EtatBOf[i *10 +3] ;
      valueButtonObj[i *10 +4] = EtatBOf[i *10 +4] ;
      valueButtonObj[i *10 +5] = EtatBOf[i *10 +5] ;
      if (dropdown[i+1] != null) valueButtonObj[i *10 +9] = dropdown[i+1].getSelection() ;
    }
  }
  //BUTTON TEX

  if(numGroup[2] > 0 ) {
    for ( int i = 0 ; i < numGroup[2] ; i ++) {
      valueButtonTex[i *10 +1] = EtatBTf[i *10 +1] ;
      valueButtonTex[i *10 +2] = EtatBTf[i *10 +2] ;
      valueButtonTex[i *10 +3] = EtatBTf[i *10 +3] ;
      valueButtonTex[i *10 +4] = EtatBTf[i *10 +4] ;
      valueButtonTex[i *10 +5] = EtatBTf[i *10 +5] ;
      int whichDropdown = i+1 +numGroup[1] ;
      if (dropdown[whichDropdown] != null) valueButtonTex[i *10 +9] = dropdown[whichDropdown].getSelection() ;
    }
  }

  //BUTTON TYPO
  if(numGroup[3] > 0 ) {
    for ( int i = 0 ; i < numGroup[3] ; i ++) {
      valueButtonTypo[i *10 +1] = EtatBTYf[i *10 +1] ;
      valueButtonTypo[i *10 +2] = EtatBTYf[i *10 +2] ;
      valueButtonTypo[i *10 +3] = EtatBTYf[i *10 +3] ;
      valueButtonTypo[i *10 +4] = EtatBTYf[i *10 +4] ;
      valueButtonTypo[i *10 +5] = EtatBTYf[i *10 +5] ;
      int whichDropdown = i+1 +numGroup[1] +numGroup[2] ;
      if (dropdown[whichDropdown] != null)  valueButtonTypo[i *10 +9] = dropdown[whichDropdown].getSelection() ;
    }
  }
}
  





  
StringList sliderControler = new StringList() ;

StringList [] sliderObj  ;
String [] sliderObjRaw  ;

String [][] sliderObjListRaw  ;
boolean [] objectActive ;
boolean [][] displaySlider  ;

boolean [] showSliderGroup = new boolean[NUM_GROUP_SLIDER] ;

boolean resetSlider = true ;
boolean allSliderUsed = false ;
boolean showAllSliders = false ;

//these sliders name are not used for the interface but for the display analyze slider
String hueFill = ("Hue fill") ;
String saturationFill = ("Saturation fill") ;
String brightnessFill = ("Brightness fill") ;
String alphaFill = ("Alpha fill") ;
String hueStroke = ("Hue stroke") ;
String saturationStroke = ("Saturation stroke") ;
String brightnessStroke = ("Brightness stroke") ;
String alphaStroke = ("Alpha stroke") ;
String thickness = ("Thickness") ;
String widthObj = ("Width") ;
String heightObj = ("Height") ;
String depthObj = ("Depth") ;
String canvasX = ("Canvas X") ;
String canvasY = ("Canvas Y") ;
String canvasZ = ("Canvas Z") ;
String quantity = ("Quantity") ;
String speed = ("Speed") ;
String direction = ("Direction") ;
String angle = ("Angle") ;
String amplitude = ("Amplitude") ;
String analyze = ("Analyze") ;
String family = ("Family") ;
String life = ("Life") ;
String force = ("Force") ;


int hueFillRank = 1 ;
int saturationFillRank = 2 ;
int brightnessFillRank = 3 ;
int alphaFillRank = 4 ;
int hueStrokeRank = 5 ;
int saturationStrokeRank = 6 ;
int brightnessStrokeRank = 7 ;
int alphaStrokeRank = 8 ;

int thicknessRank = 11 ;
int widthObjRank = 12 ;
int heightObjRank = 13 ;
int depthObjRank = 14 ;
int canvasXRank = 15 ;
int canvasYRank = 16 ;
int canvasZRank = 17 ;
int quantityRank = 18 ;

int speedRank = 21 ;
int directionRank = 22 ;
int angleRank = 23 ;
int amplitudeRank = 24 ;
int analyzeRank = 25 ;
int familyRank = 26 ;
int lifeRank = 27 ;
int forceRank = 28 ;






public void setDisplaySlider() {
  setSliderDynamic() ;
  listSliderInterface() ;
  recoverActiveSliderFromObj() ;
  listSliderObject() ;
}

public void setSliderDynamic() {
  sliderObj = new StringList [numObj +1] ;
  sliderObjRaw = new String [numObj +1] ;
  sliderObjListRaw = new String [numObj +1][SLIDER_BY_GROUP +1] ;
  objectActive = new boolean[numObj +1] ;
  displaySlider = new boolean [NUM_GROUP_SLIDER] [SLIDER_BY_GROUP +1] ;
}


public void recoverActiveSliderFromObj() {
  sliderObjRaw[0] = ("not used") ;
  for(int i = 1 ; i <= numObj ; i++) {
    sliderObjRaw[i] = objectSlider[objectID[i]] ;
  }
}


public void initVarSliderDynamic() {
  for ( int j = 1 ; j < NUM_GROUP_SLIDER ; j++) {
    showSliderGroup[j] = false ;
  }
  loadSaveSetting = false ;
}




public void listSliderObject() {
  //create the String list for each object
  for ( int i = 0 ; i < sliderObj.length ; i++) {
    sliderObj[i] = new  StringList() ;
  }

  //setting the list to don't have a null value
  for (int i = 0 ; i < sliderObj.length ; i++) {
    for( int j = 0 ; j < SLIDER_BY_GROUP ; j++ ) {
      sliderObj[i].append("") ;
    }
  }
  // had value to the slider list object
  for (int i = 0 ; i <= numObj ; i++) {
    String [] listSliderTemp = splitText(sliderObjRaw[i], (",")) ;
    for( int j = 0 ; j < SLIDER_BY_GROUP ; j++ ) {
      for ( int k = 0 ; k < listSliderTemp.length ; k++ ) {
        if(listSliderTemp[k].equals(sliderControler.get(j))) {
          sliderObj[i].set(j,listSliderTemp[k]) ;
        } else if(listSliderTemp[k].equals("all") ) {
          sliderObj[i].set(j,"all") ;
        }
      }
    }
  }
}



public void listSliderInterface() {
  sliderControler.append("not used") ;
  // col one
  sliderControler.append(hueFill) ;
  sliderControler.append(saturationFill) ;
  sliderControler.append(brightnessFill) ;
  sliderControler.append(alphaFill) ;
  sliderControler.append(hueStroke) ;
  sliderControler.append(saturationStroke) ;
  sliderControler.append(brightnessStroke) ;
  sliderControler.append(alphaStroke) ;
  sliderControler.append("not used") ;
  sliderControler.append("not used") ;
  // col two
  sliderControler.append(thickness) ;
  sliderControler.append(widthObj) ;
  sliderControler.append(heightObj) ;
  sliderControler.append(depthObj) ;
  sliderControler.append(canvasX) ;
  sliderControler.append(canvasY) ;
  sliderControler.append(canvasZ) ;
  sliderControler.append(quantity) ;
  sliderControler.append("not used") ;
  sliderControler.append("not used") ;
  // col three
  sliderControler.append(speed) ;
  sliderControler.append(direction) ;
  sliderControler.append(angle) ;
  sliderControler.append(amplitude) ;
  sliderControler.append(analyze) ;
  sliderControler.append(family) ;
  sliderControler.append(life) ;
  sliderControler.append(force) ;
  sliderControler.append("not used") ;
  sliderControler.append("not used") ;
}



// DRAW
public void checkSlider() {
   checkObjectOnOff() ;
   whichSliderMustBeDisplay() ;
   // check the group slider
   for ( int i = 1 ; i <= numObj ; i++) {
    if (objectActive[i]) {
      showSliderGroup[objectGroup[i]] = true ;
    }
  }
  
  
  
   //check if the slider must be display
  if (resetSlider) {
    // use this boolean to have a boolean slider true, if don't use thi boolean no onr slider can be true and active
    boolean [] firstCheck = new boolean [NUM_GROUP_SLIDER] ; // true ;
    //reset slider for new check
    for(int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
      firstCheck [i] = true ;
      for(int j = 0 ; j <SLIDER_BY_GROUP ; j++) {
        displaySlider[i][j] = false ;
      }
    }
   
    //active slider
    int IDgroup = 0 ;
     if (showAllSliders) {
      for ( int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
        for ( int j = 1 ; j < SLIDER_BY_GROUP ; j++) {
        displaySlider[i][j] = true ;
        }
      }
    } else {
      for ( int i = 1 ; i <= numObj ; i++) {
        if (objectActive[i]) {
          for (int j = 1 ; j < NUM_GROUP_SLIDER ; j++) {
           if (objectGroup[i] == j) { IDgroup = j ;
              for(int k = 1 ; k < SLIDER_BY_GROUP ; k++) {
                if (firstCheck[j])  {
                  if((sliderControler.get(k).equals(sliderObj[i].get(k)) || sliderObj[i].get(k).equals("all"))) displaySlider[IDgroup][k] = true ; else displaySlider[IDgroup][k] = false ;
                } else {
                  if (!allSliderUsed) { 
                    if((sliderControler.get(k).equals(sliderObj[i].get(k)) || sliderObj[i].get(k).equals("all")) && displaySlider[IDgroup][k]) displaySlider[IDgroup][k] = true ; else displaySlider[IDgroup][k] = false ;
                  } else if (allSliderUsed) {
                    if (!displaySlider[IDgroup][k]) if (sliderControler.get(k).equals(sliderObj[i].get(k)) || sliderObj[i].get(k).equals("all")) displaySlider[IDgroup][k] = true ; else displaySlider[IDgroup][k] = false ;
                  }
                }
              }
            }
          }
        }
        // wait the first cross of active object to change
        if (objectActive[i]) firstCheck[IDgroup] = false ;
      }
    }
    //firstCheck = false ;
    resetSlider = false ;  
  }
}



// CHOICE which slider must be display after checking the keyboard
public void whichSliderMustBeDisplay() {
  switch(sliderModeDisplay) {
    case 0 : 
    resetSlider = true ;
    showAllSliders = true ;
    break ;
    case 1 : 
    resetSlider = true ;
    showAllSliders = false ;
    allSliderUsed = true ;
    break ;
    case 2 : 
    resetSlider = true ;
    showAllSliders = false ;
    allSliderUsed = false ;
    break ;
  }
}

boolean activityButtonParameter, witnessActivity, activityParameter ; 

public void checkObjectOnOff() {
  for(int i = 0 ; i < numGroup[1] ; i++ ) {
    int whichOne = i*10 +2 ;
    witnessActivity = activityButtonParameter ;
    if (EtatBOf[whichOne] == 1) {
      objectActive[i+1] = true ; 
      if(mousePressed)  activityButtonParameter = !activityButtonParameter ;
    } else { 
      objectActive[i+1] = false ;
      if(mousePressed) activityButtonParameter = !activityButtonParameter  ;
      
    }
    //check ctivity
    if(witnessActivity != activityButtonParameter ) activityParameter = true ;
  }
  for(int i = 0 ; i < numGroup[2] ; i++ ) {
    int whichOne = i*10 +2 ;
    if (EtatBTf[whichOne] == 1) { 
      objectActive[i +numGroup[1] +1] = true ; 
      if(mousePressed)  activityButtonParameter = !activityButtonParameter ;
      } else { 
      objectActive[i+numGroup[1] +1] = false ; 
      if(mousePressed)  activityButtonParameter = !activityButtonParameter ;
    }
  }
  for(int i = 0 ; i < numGroup[3] ; i++ ) {
    int whichOne = i*10 +2 ;
    if (EtatBTYf[whichOne] == 1) {
      objectActive[i +numGroup[1] +numGroup[2] +1] = true ; 
      if(mousePressed)  activityButtonParameter = !activityButtonParameter ;
    } else { 
      objectActive[i +numGroup[1] +numGroup[2] +1] = false ;
      if(mousePressed)  activityButtonParameter = !activityButtonParameter ;
    }
  }
  
  if(activityParameter) resetSlider = true ;
  activityParameter = false ;
}




//END GLOBAL

//SETUP
public void loadSetup() {
  createInfoButtonAndSlider(sketchPath("")+"preferences/setting/defaultSetting.csv") ;
  loadSave(sketchPath("")+"preferences/setting/defaultSetting.csv") ;
  
  //load text interface 
  // 0 is French
  // 1 is english
  textGUI() ;
}
//END SETUP






// LOAD INFO OBJECT from the PRESCENE
/////////////////////////////////////
Table objectList, shaderBackgroundList;
int numGroup [] ; 
int [] objectLibraryOrder, objectID, objectGroup ;
String  [] objectName , objectAuthor, objectVersion, objectPack, objectRender, objectLoadName, objectSlider ; 
boolean [] objectClassic, objectP2D, objectP3D ;
//int [][] objectLibraryOrder, objectID, objectGroup ;
//String  [][] objectName , objectAuthor, objectVersion, objectPack, objectRender, objectLoadName, objectSlider ; 
//boolean [][] objectClassic, objectP2D, objectP3D ;
String [] shaderBackgroundName, shaderBackgroundAuthor ;



//BOUTON
int numButton [] ;
int numButtonTotalObjects ;
int lastDropdown, numDropdown ;
//BUTTON
int valueButtonGlobal[], valueButtonObj[], valueButtonTex[], valueButtonTypo[]  ;
Simple  BOmidi, BOcurtain,
        buttonBackground, 
        buttonLightOne, buttonLightOneAction,
        buttonLightTwo, buttonLightTwoAction,
        Bbeat, Bkick, Bsnare, Bhat;
        
//bouton objet
Simple[] BOf  ;
int transparenceBordBOf[], epaisseurBordBOf[], transparenceBoutonBOf[], posWidthBOf[], posHeightBOf[], longueurBOf[], hauteurBOf[]  ;
//bouton texture
Simple[] BTf  ;
int transparenceBordBTf[], epaisseurBordBTf[], transparenceBoutonBTf[], posWidthBTf[],posHeightBTf[], longueurBTf[], hauteurBTf[]  ;
//bouton typo
Simple[] BTYf  ;
int transparenceBordBTYf[], epaisseurBordBTYf[], transparenceBoutonBTYf[], posWidthBTYf[], posHeightBTYf[], longueurBTYf[], hauteurBTYf[]  ;


//Variable must be send to Scene
//param\u00e8tre bouton
int EtatBOf[], EtatBTf[], EtatBTYf[] ; 
// int EtatBIf[] ;


//////////
//DROPDOWN
int startLoopObject, endLoopObject, startLoopTexture, endLoopTexture, startLoopTypo, endLoopTypo ;
//GLOBAL
Dropdown dropdown[], dropdownFont, dropdownBackground, dropdownImage, dropdownFileText  ;

PVector posDropdownFont, posDropdownBackground, posDropdownImage, posDropdownFileText, posDropdown[] ;
PVector sizeDropdownFont, sizeDropdownBackground, sizeDropdownImage, sizeDropdownFileText, sizeDropdownMode ;
PVector posTextDropdown = new PVector(2,8)  ;

PVector totalSizeDropdown = new PVector () ;
PVector newPosDropdown = new PVector () ;

String [] modeListRomanesco, policeDropdownList, imageDropdownList, fileTextDropdownList, listDropdown, listDropdownBackground;

float margeAroundDropdown ;


//SETTING
 /////////
public void buildLibrary() {
  objectList = loadTable(sketchPath("")+"preferences/objects/index_romanesco_objects.csv", "header") ;
  shaderBackgroundList = loadTable(sketchPath("")+"preferences/shaderBackgroundList.csv", "header") ;
  numByGroup() ;
  initVarObject() ;
  initVarButton() ;
  infoByObject() ;
  infoShaderBackground() ;
}

public void initVarObject() {

  objectLibraryOrder = new int [numObj +1] ;
  objectID = new int [numObj +1] ;
  objectGroup = new int [numObj +1] ;
  objectName = new String [numObj +1] ;
  objectAuthor = new String [numObj +1] ;
  objectVersion = new String [numObj +1] ;
  objectPack = new String [numObj +1] ;
  objectRender = new String [numObj +1] ;
  objectLoadName = new String [numObj +1] ;
  objectClassic = new boolean [numObj +1] ;
  objectP2D = new boolean [numObj +1] ;
  objectP3D = new boolean [numObj +1] ;
  objectSlider = new String [numObj +1] ;
}



public void initVarButton() {
  numButton = new int[NUM_GROUP_SLIDER] ;
  
  numButton[0] = 15 ;
  for (int i = 1 ; i < NUM_GROUP_SLIDER ; i++ ) {
    numButton[i] = numGroup[i]*10 ;
    numButtonTotalObjects += numGroup[i] ;
  }

  numDropdown = numObj +1 ; // add one for the dropdownmenu
  lastDropdown = numDropdown -1 ;
  
  valueButtonGlobal = new int[numButton[0]] ;
  valueButtonObj = new int[numButton[1]] ;
  valueButtonTex = new int[numButton[2]] ;
  valueButtonTypo = new int[numButton[3]] ;
  //bouton objet
  BOf = new Simple[numButton[1] +10] ;
  transparenceBordBOf =      new int[numButton[1] +10] ;
  epaisseurBordBOf =         new int[numButton[1] +10] ;
  transparenceBoutonBOf =    new int[numButton[1] +10] ;
  posWidthBOf =              new int[numButton[1] +10] ;
  posHeightBOf =             new int[numButton[1] +10] ;
  longueurBOf =              new int[numButton[1] +10] ;
  hauteurBOf =               new int[numButton[1] +10] ;
  
  //bouton texture
  BTf = new Simple[numButton[2] +10] ;
  transparenceBordBTf =      new int[numButton[2] +10] ;
  epaisseurBordBTf =         new int[numButton[2] +10] ;
  transparenceBoutonBTf =    new int[numButton[2] +10] ;
  posWidthBTf =              new int[numButton[2] +10] ;
  posHeightBTf =             new int[numButton[2] +10] ;
  longueurBTf =              new int[numButton[2] +10] ;
  hauteurBTf =               new int[numButton[2] +10] ;
  
  //bouton typo
  BTYf = new Simple[numButton[3] +10] ;
  transparenceBordBTYf =      new int[numButton[3] +10] ;
  epaisseurBordBTYf =         new int[numButton[3] +10] ;
  transparenceBoutonBTYf =    new int[numButton[3] +10] ;
  posWidthBTYf =              new int[numButton[3] +10] ;
  posHeightBTYf =             new int[numButton[3] +10] ;
  longueurBTYf =              new int[numButton[3] +10] ;
  hauteurBTYf =               new int[numButton[3] +10] ;
  
  //param\u00e8tre bouton
  EtatBOf = new int[numButton[1]] ;
  EtatBTf = new int[numButton[2]] ;
  EtatBTYf = new int[numButton[3]] ;
  // EtatBIf = new int[numButton] ;
  
  //dropdown
  modeListRomanesco = new String[numDropdown] ;
  dropdown = new Dropdown[numDropdown] ;
  posDropdown = new PVector[numDropdown] ;
  startLoopObject = 1 ;
  endLoopObject = 1 +numGroup[1] ;
  startLoopTexture = endLoopObject ; 
  endLoopTexture = startLoopTexture +numGroup[2] ;
  startLoopTypo = endLoopTexture ; 
  endLoopTypo = startLoopTypo +numGroup[3] ;

}


public void infoShaderBackground() {
  int n = shaderBackgroundList.getRowCount() ;
  shaderBackgroundName = new String[n] ;
  shaderBackgroundAuthor = new String[n] ;
  for (int i = 0 ; i < n ; i++ ) {
     TableRow row = shaderBackgroundList.getRow(i) ;
     shaderBackgroundName[i] = row.getString("Name") ;
     shaderBackgroundAuthor[i] = row.getString("Author") ;
  }
}

public void infoByObject() {
  for(int i = 0 ; i < numObj ; i++) {
    TableRow lookFor = objectList.getRow(i) ;
    int ID = lookFor.getInt("ID") ;
    for(int j = 0 ; j <= numObj ; j++) {
      if(ID == j ) { 
        objectLibraryOrder[j] =lookFor.getInt("Library Order") ;
        objectID [j] = lookFor.getInt("ID") ;
        objectGroup[j] = lookFor.getInt("Group");
        objectPack[j] = lookFor.getString("Pack");
        objectRender[j] = lookFor.getString("Render");
        objectAuthor[j] = lookFor.getString("Author");
        objectVersion[j] = lookFor.getString("Version");
        objectLoadName[j] = lookFor.getString("Class name");
        objectName[j] = lookFor.getString("Name");
        objectSlider[j] = lookFor.getString("Slider") ;
      }
    }
  }
}



public void numByGroup() {
  numGroup  = new int[NUM_GROUP_SLIDER] ;
  for (TableRow row : objectList.rows()) {
    int objectGroup = row.getInt("Group");
    for (int i = 0 ; i < NUM_SLIDER ;i++) {
      if (objectGroup == i) numGroup[i] += 1 ;
    }
  }
  //give the num total of objects
  numObj = numGroup[1] +numGroup[2] +numGroup[3] ;
}
// END BUILD LIBRARY
////////////////////











//////////////////////////////////
// SETTING INFO BUTTON AND SLIDER

// create var info for the button and the slider

public void createInfoButtonAndSlider(String path) {
  Table table = loadTable(path, "header");
  // create the good num of Var info about slider and button
  int countButton = 0 ;
  int countSlider = 0 ;
  
  for (TableRow row : table.rows()) {
    String s = row.getString("Type") ;
    if( s.equals("Slider")) countSlider++ ; 
  }
  infoSlider = new PVector [countSlider] ;
  
  // we don't count from the save in case we add object and this one has never use before and he don't exist in the data base
  infoButton = new PVector [numObj*4 +10] ; 
  for(int i = 0 ; i < infoButton.length ; i++) infoButton[i] = new PVector() ;
}
//////////////////////////////////
/////////////////////////////////









/////////////
// SAVE LOAD

// SAVE
///////
public void saveSetting(File selection) {
  // opens file chooser
  String savePathSetting = selection.getAbsolutePath() ;
  
  if (selection != null) {
    saveInfoSlider() ;
    midiButtonManager(true) ;
    saveTable(saveSetting, savePathSetting+".csv");
    saveSetting.clearRows() ;
  } 
}


// SAVE SLIDERS
// save the position and the ID of the slider molette
public void saveInfoSlider() {
  //group zero
  for (int i = 1 ; i < NUM_SLIDER_GLOBAL ; i++) {
     // set PVector info Slider
     int temp = i-1 ;
     infoSlider[temp].z = valueSlider[i] ;
     setSlider(i, (int)infoSlider[temp].y, infoSlider[temp].z) ;

  }
  
  // the group one, two, three
  for (int i = 1 ; i < NUM_GROUP_SLIDER ; i++) { 
    for(int j = 1 ; j < SLIDER_BY_GROUP ; j++) {
      // set PVector info Slider
      int IDslider = j +(i *100) ;
      // third loop to check and foinf the good PVector array in the list
      for(int k = 0 ; k < infoSlider.length ;k++) {
        if( (int)infoSlider[k].x ==IDslider) {
          infoSlider[k].z = valueSlider[IDslider] ;
          setSlider(IDslider, (int)infoSlider[k].y, infoSlider[i].z) ;
        }
      }
    }
  }
  showAllSliders = false ;
}




// BUTTON SAVE
Table saveSetting ;
//write the value in the table
public void setButton(int IDbutton, int IDmidi, boolean b) {
  TableRow buttonSetting = saveSetting.addRow() ;
  buttonSetting.setString("Type", "Button") ;
  buttonSetting.setInt("ID button", IDbutton) ;
  buttonSetting.setInt("ID midi", IDmidi) ;
  if(b) buttonSetting.setInt("On Off", 1) ; else buttonSetting.setInt("On Off", 0) ;
}
public void setSlider(int IDslider, int IDmidi, float value) {
  TableRow sliderSetting = saveSetting.addRow() ;
  sliderSetting.setString("Type", "Slider") ;
  sliderSetting.setInt("ID slider", IDslider) ;
  sliderSetting.setInt("ID midi", IDmidi) ;
  sliderSetting.setFloat("Value slider", value) ; 
}

public void indexMidiButton() {
  saveSetting = new Table() ;
  saveSetting.addColumn("Type") ;
  saveSetting.addColumn("ID slider") ;
  saveSetting.addColumn("Value slider") ;
  saveSetting.addColumn("ID button") ;
  saveSetting.addColumn("On Off") ;
  saveSetting.addColumn("ID midi") ;
}


// END SAVE
///////////







//LOAD
//////
public void loadSetting(File selection) {
  // opens file chooser
  String loadPathSetting = selection.getAbsolutePath();
  
  if (selection != null) {
    loadSaveSetting = true ;
    loadSave(loadPathSetting) ;
    setSave = true ;
  } 
}









// loadSave(path) read info from save file
public void loadSave(String path) {
  Table settingTable = loadTable(path, "header");
  // re-init the counter for the new loop
  int countButton = 0 ;
  int countSlider = 0 ;
  for (TableRow row : settingTable.rows()) {
    String s = row.getString("Type") ;
    //
    if( s.equals("Button")  ){ 
     int IDbutton = row.getInt("ID button") ;
     int IDmidi = row.getInt("ID midi") ;
     int onOff = row.getInt("On Off") ;
     infoButton[countButton] = new PVector(IDbutton,IDmidi,onOff) ;
     countButton++ ; 
    }
    //
    if( s.equals("Slider")  ){
     int IDslider = row.getInt("ID slider") ;
     int IDmidi = row.getInt("ID midi") ;
     int valueSlider = row.getInt("Value slider") ; 
     infoSlider[countSlider] = new PVector(IDslider,IDmidi,valueSlider) ; 
     countSlider++ ;
    }
  }
}















//SETTING SAVE
Boolean setSave = true ;
public void settingDataFromSave() {
  if(setSave) {
    buttonSetSaveSetting() ;
    sliderSetSaveSetting() ;
    setSave = false ;
  }
}


//setting SLIDER from save
public void sliderSetSaveSetting() {
  for (int i = 1 ; i < NUM_SLIDER_GLOBAL ; i++) {
    int whichOne = i ;
    PVector info = infoSaveFromRawList(infoSlider, whichOne).copy() ;
    Slider[whichOne].updateFromSave((int)info.z, (int)info.y) ; // (pos, IDmidi) ;
    // Slider[whichOne].update(mouseX, (int)info.z, true);
  }
  for (int i = 1 ; i < NUM_GROUP_SLIDER ; i++) { 
    for(int j = 1 ; j < SLIDER_BY_GROUP ; j++) {
      int whichOne = j +(i *100) ;
      PVector info = infoSaveFromRawList(infoSlider, whichOne).copy() ;
      println(info) ;
      Slider[whichOne].updateFromSave((int)info.z, (int)info.y) ; // (pos, IDmidi) ;
    }
  }
}




//setting BUTTON from save
public void buttonSetSaveSetting() {
  // close loop to save the button statement, 
  // see void midiButtonManager(boolean saveButton)
  int rank = 0 ;
  // Background and Curtain
  if(infoButton[rank].z  == 1.0f) buttonBackground.onOff = true ; else buttonBackground.onOff = false ;
  buttonBackground.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0f) BOcurtain.onOff = true ; else BOcurtain.onOff = false ;
  BOcurtain.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  //LIGHT ONE
  if(infoButton[rank].z == 1.0f) buttonLightOne.onOff = true ; else buttonLightOne.onOff = false ;
  buttonLightOne.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0f) buttonLightOneAction.onOff = true ; else buttonLightOneAction.onOff = false ;
  buttonLightOneAction.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  // LIGHT TWO
  if(infoButton[rank].z == 1.0f) buttonLightTwo.onOff = true ; else buttonLightTwo.onOff = false ;
  buttonLightTwo.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0f) buttonLightTwoAction.onOff = true ; else buttonLightTwoAction.onOff = false ;
  buttonLightTwoAction.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  //SOUND
  if(infoButton[rank].z == 1.0f) Bbeat.onOff = true ; else Bbeat.onOff = false ;
  Bbeat.IDmidi = (int)infoButton[rank].y ;
 rank++ ; 
  if(infoButton[rank].z == 1.0f) Bkick.onOff = true ; else Bkick.onOff = false ;
  Bkick.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0f) Bsnare.onOff = true ; else Bsnare.onOff = false ;
  Bsnare.IDmidi = (int)infoButton[rank].y ;
  rank++ ;
  if(infoButton[rank].z == 1.0f) Bhat.onOff = true ; else Bhat.onOff = false ;
  Bhat.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  
  //
  rank--  ;
  //
  
  int whichGroup = 1 ;
  int buttonRank ;
  for( int i = 1 ; i <= numGroup[whichGroup] ; i++ ) {
    for (int j = 1 ; j <= BUTTON_BY_OBJECT ; j++) {
      rank++ ;
      buttonRank = (int)infoButton[rank].x ;
      if(infoButton[rank].z == 1.0f && buttonRank == (i*10)+j) BOf[buttonRank].onOff = true ; else BOf[buttonRank].onOff = false ; 
      BOf[buttonRank].IDmidi = (int)infoButton[rank].y ; 
    }
  }
  whichGroup = 2 ; 
  for( int i = 1 ; i <= numGroup[whichGroup] ; i++ ) {
    for (int j = 1 ; j <= BUTTON_BY_OBJECT ; j++) {
      rank++ ;
      buttonRank = (int)infoButton[rank].x ;
      if(infoButton[rank].z == 1.0f && buttonRank == (i*10)+j) BTf[buttonRank].onOff = true ; else BTf[buttonRank].onOff = false ; 
      BTf[buttonRank].IDmidi = (int)infoButton[rank].y ; 
    } 
  }
  whichGroup = 3 ;
  for( int i = 1 ; i <= numGroup[whichGroup] ; i++ ) {
    for (int j = 1 ; j <= BUTTON_BY_OBJECT ; j++) {
      rank++ ;
      buttonRank = (int)infoButton[rank].x ;
      if(infoButton[rank].z == 1.0f && buttonRank == (i*10)+j) BTYf[buttonRank].onOff = true ; else BTYf[buttonRank].onOff = false ; 
      BTYf[buttonRank].IDmidi = (int)infoButton[rank].y ; 
    }
  }
}




// infoSaveFromRawList read info to translate and give a good position
public PVector infoSaveFromRawList(PVector [] list, int pos) {
  PVector info = new PVector() ;
  float v = 0 ;
  float IDmidi = 0 ;
  for(int i = 0 ; i < list.length ;i++) {
    
  if(list[i] != null ) if((int)list[i].x == pos) {
      v = list[i].z ;
      IDmidi = list[i].y ;
      info = new PVector(pos, IDmidi,v) ;
      break;
    } else {
      info = new PVector(-1,-1,-1) ;
    }
  }
  return info ;
}

// SAVE LOAD






//LOAD text Interface
Table textGUI;
int numCol = 15 ;
String[] genTxtGUI = new String[numCol] ;
String[] sliderNameOne = new String[numCol] ;
String[] sliderNameTwo = new String[numCol] ;
String[] sliderNameThree = new String[numCol] ;

TableRow [] row = new TableRow[numCol+1] ;

String lang[] ;

public void textGUI() {
  if (!test)lang = loadStrings(sketchPath("") +"preferences/language.txt") ; else lang = loadStrings("preferences/language.txt") ;
  String l = join(lang,"") ;
  int language = Integer.parseInt(l);

  
  if( language == 0 ) { 
    textGUI = loadTable(sketchPath("")+"preferences/sliderListFR.csv", "header") ;
  } else if (language == 1 ) {
    textGUI = loadTable(sketchPath("")+"preferences/sliderListEN.csv", "header") ;
  } else {
    textGUI = loadTable(sketchPath("")+"preferences/sliderListEN.csv", "header") ;
  }
    
  for ( int i = 0 ; i < numCol ; i++) {

    row[i] = textGUI.getRow(i) ;
    for ( int j = 1 ; j < numCol ; j++) {
      String numCol = Integer.toString(j) ;
      if ( i == 0 ) genTxtGUI[j] = row[i].getString("Column "+numCol) ;
      if ( i == 1 ) sliderNameOne[j] = row[i].getString("Column "+numCol) ;
      if ( i == 2 ) sliderNameTwo[j] = row[i].getString("Column "+numCol) ;
      if ( i == 3 ) sliderNameThree[j] = row[i].getString("Column "+numCol) ;
    }
  }
}





//IMPORT VIGNETTE
public void importPicButtonSetup() {

  
  //picto setting
  for(int i = 0 ; i<4 ; i++) {
    picCurtain[i]   = loadImage("picto/picto_curtain_"+i+".png") ;
    picMidi[i]   = loadImage("picto/picto_midi_"+i+".png") ;
    picSetting[i] = loadImage("picto/picto_setting_"+i+".png") ;
    picSound[i]   = loadImage("picto/picto_sound_"+i+".png") ;
    picAction[i]   = loadImage("picto/picto_action_"+i+".png") ;
  }
  // load thumbnail
  int num = numGroup[1] + numGroup[2] + numGroup[3] +1 ;
  OFF_in_thumbnail = new PImage[num] ;
  OFF_out_thumbnail = new PImage[num] ;
  ON_in_thumbnail = new PImage[num] ;
  ON_out_thumbnail = new PImage[num] ;
  for(int i=0 ;  i<num ; i++ ) {
    OFF_in_thumbnail[i] = loadImage("thumbnail/OFF_in/OFF_in_"+i+".png") ;
    OFF_out_thumbnail[i] = loadImage("thumbnail/OFF_out/OFF_out_"+i+".png") ;
    ON_in_thumbnail[i] = loadImage("thumbnail/ON_in/ON_in_"+i+".png") ;
    ON_out_thumbnail[i] = loadImage("thumbnail/ON_out/ON_out_"+i+".png") ;
  }
  
}
class Button {
  int couleurBouton, couleurONoffCarre, couleurONoffCercle ;
  PVector pos = new PVector() ; 
  PVector size = new PVector() ;
  
  boolean inside ;
  boolean onOff = false ;  
  //MIDI
  int newValMidi ;
  //int IDbutton ;
  int IDmidi = -2 ;
  
  
  //Constructor
  //simple
  Button () {}
  //complexe
  Button (int posWidth, int posHeight, int widthButton, int heightButton, boolean onOff) {
    this.onOff = onOff ;
    pos.x = posWidth ;
    pos.y = posHeight ;
    size.x = widthButton ;
    size.y = heightButton ;
    pos.x =  posWidth ; pos.y = posHeight ; size.x = widthButton ; size.y = heightButton ;
  }
  Button (PVector pos, PVector size, boolean onOff) {
    this.onOff = onOff ;
    this.pos = pos.copy() ;
    this.size = size.copy() ;
  }
  

  
  
  
  //ROLLOVER
  //rectangle
  float newSize = 1  ;
  //
  public boolean rollover() {
    if (size.y < 10 ) newSize = size.y *1.8f ; 
    else if (size.y >= 10 && size.y < 20  ) newSize = size.y *1.2f ;  
    else if (size.y >= 20 ) newSize = size.y ;
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y  && mouseY < pos.y + newSize ) { 
      inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }
  // with correction for the font position
  public boolean rollover(int correction) {
    if (size.y < 10 ) newSize = size.y *1.8f ; 
    else if (size.y >= 10 && size.y < 20  ) newSize = size.y *1.2f ;  
    else if (size.y >= 20 ) newSize = size.y ;
    
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y -correction  && mouseY < pos.y +newSize -correction) { 
      inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }
  
  
  
  //CLIC
  public void mousePressedText() {
    if (rollover((int)size.y) ) if (onOff) onOff = false ; else onOff = true ; 
  }
  //
  public void mousePressed() {
    if (rollover()) if (onOff) onOff = false ; else onOff = true ;
  }
  
  // MIDI
  public int IDmidi() { return IDmidi ; }
  
  public void selectIDmidi(int num) { IDmidi = num ; }
}




////////
//BUTTON
class Simple extends Button {
  int cBINonBO, cBOUTonBO, cBINoffBO, cBOUToffBO, cBEinBO, cBEoutBO ;
  
  //CONSTRUCTOR
  Simple(PVector pos, PVector size, boolean onOff) {
    super(pos, size, onOff) ;
  }
  
  //
  Simple (PVector pos, PVector size,
          int BoutonINonBO, int BoutonOUTonBO, int BoutonINoffBO, int BoutonOUToffBO,
           int BoutonEnsembleINBO, int BoutonEnsembleOUTBO, boolean onOff)                  
 {
   super(pos, size, onOff) ;
   cBINonBO = BoutonINonBO ; cBOUTonBO = BoutonOUTonBO ; cBINoffBO = BoutonINoffBO ; cBOUToffBO = BoutonOUToffBO ;
   cBEinBO = BoutonEnsembleINBO ; cBEoutBO = BoutonEnsembleOUTBO ;
 }
 
 Simple (PVector pos, PVector size, int BoutonINonBO, int BoutonOUTonBO, int BoutonINoffBO, int BoutonOUToffBO, boolean onOff)  {
   super(pos, size, onOff) ;
   cBINonBO = BoutonINonBO ; cBOUTonBO = BoutonOUTonBO ; cBINoffBO = BoutonINoffBO ; cBOUToffBO = BoutonOUToffBO ;
 }
 
 
 
 //VOID
 public void boutonFond () {
   fill(couleurBouton) ;
   rect(pos.x, pos.y, size.x, size.y) ;
 }
 
 
 ////////////////
 //BUTTON CLASSIC
 


 
 
 //////////////
 //IMAGE BUTTON
 
 //VIGNETTE Button
 // vignette_OFF_in_simple, vignette_OFF_out_simple, vignette_ON_in_simple, vignette_ON_out_simple
 public void buttonPicSerie(PImage[] OFF_in, PImage[] OFF_out, PImage[] ON_in, PImage[] ON_out, int whichOne) {
   int correctionX = -1 ;
   if (onOff ) {
     if (rollover() && !dropdownActivity) image(ON_in[whichOne],pos.x +correctionX, pos.y) ; else image(ON_out[whichOne],pos.x +correctionX, pos.y) ;
   } else {
     if (rollover() && !dropdownActivity) image(OFF_in[whichOne],pos.x +correctionX, pos.y) ; else image(OFF_out[whichOne],pos.x +correctionX, pos.y) ;
   }
 }
 public void buttonPic(PImage [] pic) {
   int correctionX = -1 ;
   if ( onOff ) {
     if (rollover() && !dropdownActivity) image(pic[1],pos.x +correctionX, pos.y ) ; else image(pic[0],pos.x +correctionX, pos.y ) ;
   } else {
     if (rollover() && !dropdownActivity) image(pic[3],pos.x +correctionX, pos.y ) ; else image(pic[2],pos.x +correctionX, pos.y) ;
   }
 }
 public void buttonPicText(PImage [] pic, String text) {
   fill(jaune) ;
   textFont(FuturaStencil_20) ;
   int correctionX = -1 ;
   if ( onOff ) {
     if (rollover() && !dropdownActivity) {
       image(pic[1],pos.x +correctionX, pos.y ) ;
       text(text,   mouseX -20, mouseY -20 ) ;
     } else image(pic[0],pos.x +correctionX, pos.y ) ;
   } else {
     if (rollover() && !dropdownActivity) { 
       image(pic[3],pos.x +correctionX, pos.y ) ; 
       text(text,   mouseX -20, mouseY -20 ) ;
     } else image(pic[2],pos.x +correctionX, pos.y) ;
   }
 }

 ///BUTTON Texte
 public void boutonTexte(String s, int x, int y) {
   if (onOff) {
     stroke(vertTresFonce) ;
     if (rollover() && !dropdownActivity) couleurONoffCarre = cBINonBO ; else couleurONoffCarre = cBOUTonBO ;
   } else {
      stroke(rougeTresFonce) ; 
     if (rollover() && !dropdownActivity) couleurONoffCarre = cBINoffBO ; else couleurONoffCarre = cBOUToffBO ;
   }

   fill(couleurONoffCarre) ;
   text(s, x, y) ;
 }
 
 public void boutonTexte(String s, PVector pos, PFont font, int sizeFont) {
   if (onOff) {
     if (rollover(sizeFont) && !dropdownActivity) couleurONoffCarre = cBINonBO ; else couleurONoffCarre = cBOUTonBO ;
   } else {
     if (rollover(sizeFont) && !dropdownActivity) couleurONoffCarre = cBINoffBO ; else couleurONoffCarre = cBOUToffBO ;
   }
   fill(couleurONoffCarre) ;
   textFont(font) ;
   textSize(sizeFont) ;
   text(s, pos.x, pos.y) ;
 }
 
 ////////////////////////////////////
 public void boutonCarreEcran (String s, PVector localpos) {
   strokeWeight (1) ;
   if (onOff) {
     stroke(vertTresFonce) ;
     if (rollover() && !dropdownActivity)couleurONoffCarre = cBINonBO ; else couleurONoffCarre = cBOUTonBO ;
   } else {
     stroke(rougeTresFonce) ; 
     if (rollover() && !dropdownActivity) couleurONoffCarre = cBINoffBO ; else couleurONoffCarre = cBOUToffBO ;
   }

   fill(couleurONoffCarre) ;
   rect(pos.x, pos.y, size.x, size.y) ;
   fill(blanc) ;
   text(s, pos.x +localpos.x, pos.y + localpos.y) ;
   noStroke() ;
 }


  // return the statement of the button is this one is ON or OFF
  public int getOnOff() { 
    if (!onOff) return 0 ; else return 1 ;
  }
  
  //MIDI
  public int IDmidi() { return IDmidi ; }
}
//
boolean dropdownOpen ; // use to indicate to indicate at the other button, they cannot be used when the user are on the dropdown menu

// CLASS
public class Dropdown {
  //Slider dropdown
  Slider sliderDropdown ;
  // private PFont fontDropdown ;
  private PVector posSliderDropdown, sizeSliderDropdown, posMoletteDropdown, sizeMoletteDropdown, sizeBoxDropdownMenu ;
  //dropdown
  private int line = 0;
  private String listItem[] , title ;
  private boolean locked, slider ;
  private final int colorTitleIn, colorTitleOut, colorBG, colorTextBox ; 
  private final int boxIn, boxOut ;
  private PVector pos, size, posText;
  private float factorPos  ; // use to calculate the margin between the box
  int sizeBox ;
  private int startingDropdown = 0 ;
  private int endingDropdown = 1 ;
  private int updateDropdown = 0 ; //for the slider update
  private float missing ;

  //CONSTRUCTOR
  public Dropdown(String title, String [] listItem, PVector pos, PVector size, PVector posText, int colorBG, int colorTitleIn, int colorTitleOut, int boxIn, int boxOut, int colorTextBox, int sizeBox ) {
    //dropdown
    this.title = title ;
    this.listItem = listItem;
    this.pos = pos;
    this.posText = posText ;

    this.size = size; // header size
    this.sizeBox = sizeBox ;
    this.colorTitleIn = colorTitleIn ;
    this.colorTitleOut = colorTitleOut ;
    this.colorTextBox = colorTextBox ;
    this.colorBG = colorBG ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;
    endingDropdown = PApplet.parseInt(size.z + 1) ;
    // security if the size of dropdown is superior of the item list
    if (endingDropdown > listItem.length ) endingDropdown = listItem.length ;
    // difference between the total list item and what is possible to display
    missing = listItem.length - endingDropdown  ;
   
    //size of the dropdow, for the bottom part
    sizeBoxDropdownMenu = new PVector (longestWord(listItem, 1, listItem.length) *sizeBox *.46f, sizeBox) ; 
    
    
    //slider dropdown
    //condition to display the slider
    if (listItem.length > endingDropdown) slider = true ; else slider = false ;
    
    if (slider) {
      sizeSliderDropdown = new PVector (sizeBox *.5f, ((endingDropdown ) *sizeBox ) -pos.z) ;
      posSliderDropdown = new PVector(pos.x -sizeSliderDropdown.x -(pos.z *2.0f), pos.y +sizeBox +(1.8f *pos.z)) ;
      posMoletteDropdown = posSliderDropdown ;
      
      float factorSizeMolette = PApplet.parseFloat(listItem.length) / PApplet.parseFloat(endingDropdown -1 ) ;
      
      sizeMoletteDropdown =  new PVector (sizeSliderDropdown.x, sizeSliderDropdown.y /factorSizeMolette) ;
      
      sliderDropdown = new Slider(posSliderDropdown, posMoletteDropdown, sizeSliderDropdown, sizeMoletteDropdown, colorBG, boxIn, boxOut) ;
      sliderDropdown.sliderSetting() ;
    }
  }
  
  //DRAW
  public void dropdownUpdate(PFont titleFont, PFont dropdownFont) {
    //to be sure of the position
    rectMode(CORNER);
    //Dropdown
    if (locked) {
      dropdownOpen = true ;
      titleWithoutBox(title, 1, size, titleFont);
      //give the position of dropdown
      int step = 2 ;
      //give the position in list of Item with the position from the slider's molette
      if (slider) updateDropdown = round(map (sliderDropdown.getValue(), 0,1, 0, missing)) ;
      //loop to display the item list
      for ( int i = startingDropdown + updateDropdown ; i < endingDropdown + updateDropdown ; i++) {
        //bottom rendering
        renderBox(listItem[i], step++, sizeBoxDropdownMenu, dropdownFont, colorTextBox);
        //Slider dropdown
        if (slider) {
          sliderDropdown.sliderUpdate() ;
          fill(colorBG) ;
        }
      }
    } else {
      //header rendering
      dropdownOpen = false ;
      titleWithoutBox(title, 1, size, titleFont);
    }
  }


  //DISPLAY
  public void titleWithoutBox(String title, int step, PVector size, PFont font) {
    //update
    factorPos = step + pos.z -1 ;
    float yLevel = step == 1 ? pos.y  : (pos.y + (size.y *(factorPos )));
    PVector newPosDropdown = new PVector (pos.x, yLevel) ;
    if (insideRect(newPosDropdown, size)) fill(colorTitleIn); else fill(colorTitleOut) ;
    textFont(font);
    text(title, pos.x +posText.x , yLevel +posText.y);
  }
  
  public void renderBox(String label, int step, PVector sizeBoxDropdown, PFont font, int textColor) {
    //update
    factorPos = step + pos.z -1 ;
    float yLevel = step == 1 ? pos.y  : (pos.y + (sizeBoxDropdown.y *(factorPos)));
    PVector newPosDropdown = new PVector (pos.x, yLevel) ;
    if (insideRect(newPosDropdown, sizeBoxDropdown)) fill(boxIn); else fill(boxOut) ;
    //display
    noStroke() ;
    if (insideRect(newPosDropdown, size)) fill(boxIn); else fill(boxOut) ;
    int sizeWidthMin = 60 ;
    int sizeWidthMax = 120 ;
    if (sizeBoxDropdown.x < sizeWidthMin ) sizeBoxDropdown.x = sizeWidthMin ; else if(sizeBoxDropdown.x > sizeWidthMax ) sizeBoxDropdown.x = sizeWidthMax ;
    rect(pos.x, yLevel, sizeBoxDropdown.x, sizeBoxDropdown.y);
    fill(textColor);
    textFont(font);
    text(label, pos.x +posText.x , yLevel +sizeBox -(ceil(sizeBox*.2f)));
  }
  
  

  
  //RETURN
  //Check the dropdown when this one is open
  public int selectDropdownLine(float newWidth) {
    if(mouseX >= pos.x && mouseX <= pos.x +newWidth && mouseY >= pos.y && mouseY <= ((listItem.length+1) *size.y) +pos.y) {
      //choice the line
      int line = floor( (mouseY - (pos.y +size.y )) / size.y ) +updateDropdown;
      return line;
    } else {
      return -1; 
    }
  }
  //return which line is selected
  public void whichDropdownLine(int l ) {
    line = l ;
  }
  //return which line of dropdown is selected
  public int getSelection() {
    return line ;
  }
}



//COLOR
//GLOBAL
int rouge, rougeFonce, rougeTresFonce,   
      orange, 
      jaune, 
      vert, vertClair, vertFonce, vertTresFonce,
      bleu,
      violet,
       
      blanc, blancGrisClair, blancGris, gris, grisClair, grisFonce, grisTresFonce, grisNoir, noirGris, noir,
      
      colorTextUsual, colorTitle,
      //bouton
      boutonOFFin, boutonOFFout, boutonONin, boutonONout ;
      //for the dropdown



//SETUP
public void colorSetup() {
   colorMode (HSB, 360,100,100 ) ; 
   blanc = color(0,0,95) ;            
   blancGrisClair = color( 0,0,85) ;  
   blancGris = color( 0,0,75) ; 
   grisClair = color(0,0, 65) ;       
   gris = color(0,0,50) ;             
   grisFonce = color(0,0,40)  ;     
   grisTresFonce = color(0,0,30) ; 
   grisNoir = color(0,0,20) ;      
   noirGris = color (0,0,15) ;         
   noir = color (0,0,5) ;  
   vertClair = color (100,20,100) ;     vert = color(100,50,70) ;           vertFonce = color(100,100,50) ;     vertTresFonce = color(100,100,30) ;
   rougeTresFonce = color(10, 100, 50) ; rougeFonce = color (10, 100, 70) ;  rouge = color(10,100,100) ;           orange = color (35,100,100) ; 
   jaune = color(50,100,100) ;
   
   colorTextUsual = grisNoir ; colorTitle = noirGris ;
   boutonOFFin = orange ; boutonOFFout = rougeFonce ;
   boutonONin = vert ; boutonONout = vertFonce ;
   

}
//END COLOR



//DRAW
//////RETURN////////////
public boolean checkKeyboard(int c) {
  if (keyboard.length >= c) {
    return keyboard[c];  
  }
  return false;
}
////////VOID/////////////

////MIDI/////////////////
public void controllerIn(promidi.Controller controller, int device, int channel){
  numMidi = controller.getNumber();
  valMidi = controller.getValue();
}


//////////////
//CHECK FOLDER
ArrayList imageFiles = new ArrayList();
ArrayList textFiles = new ArrayList();
boolean folderImageIsSelected = true ;
boolean folderFileTextIsSelected = true ;
int countImageSelection, countFileTextSelection ;


// main void
// check what's happen in the selected folder
public void checkImageFolder() {
  if(frameCount%180 == 0) {
    countImageSelection++ ;
    imageFiles.clear() ;
    String path = sketchPath +"/" +preferencesPath +"Images" ; 
    
    ArrayList allFiles = listFilesRecursive(path);
  
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("PNG") || lastThree.equals("png") || lastThree.equals("JPG") || lastThree.equals("jpg") || lastThree.equals("GIF") || lastThree.equals("gif")) {
          imageFiles.add(f);
        }
      }
    }
    // show the info name file
    for (int i = 0; i < imageFiles.size(); i++) {
      File f = (File) imageFiles.get(i); 
    }
    // to don't loop with this void
    folderImageIsSelected = false ;
  }
}

public void checkFileTextFolder() {
  if(frameCount%180 == 0) {
    countFileTextSelection++ ;
    textFiles.clear() ;
    String path = sketchPath +"/" +preferencesPath +"Karaoke" ; 
    
    ArrayList allFiles = listFilesRecursive(path);
  
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("TXT") || lastThree.equals("txt")) {
          textFiles.add(f);
        }
      }
    }
    // show the info name file
    for (int i = 0; i < textFiles.size(); i++) {
      File f = (File) textFiles.get(i); 
    }
    
    // to don't loop with this void
    folderFileTextIsSelected = false ;
  }
}
// end main void



public void initLiveData() {
  imageDropdownList = new String[imageFiles.size()] ;
  for(int i = 0 ; i< imageDropdownList.length ; i++) {
    File f = (File) imageFiles.get(i);
    imageDropdownList[i] = f.getName() ;
    imageDropdownList[i] = imageDropdownList[i].substring(0,imageDropdownList[i].length() -4) ;
  }
  
  //text
  fileTextDropdownList = new String[textFiles.size()] ;
  for(int i = 0 ; i< fileTextDropdownList.length ; i++) {
    File f = (File) textFiles.get(i);
    fileTextDropdownList[i] = f.getName() ;
    fileTextDropdownList[i] = fileTextDropdownList[i].substring(0, fileTextDropdownList[i].length() -4) ;
  }
}




// This function returns all the files in a directory as an array of Strings  
public String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
public File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// Function to get a list ofall files in a directory and all subdirectories
public ArrayList listFilesRecursive(String dir) {
  ArrayList fileList = new ArrayList(); 
  recurseDir(fileList, dir);
  return fileList;
}

// Recursive function to traverse subdirectories
public void recurseDir(ArrayList a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a, subfiles[i].getAbsolutePath());
    }
  } 
  else {
    a.add(file);
  }
}
//END CHECK FOLDER
/////////////////




/////////
// CREDIT
boolean insideNameversion ;
public void credit() {
  if(mouseX > 2 && mouseX < 160 && mouseY > 3 && mouseY < 26 ) insideNameversion = true ; else insideNameversion = false ;
  if(insideNameversion && mousePressed) {
  String credit[] = loadStrings("credit.txt");
  
  fill(grisNoir,225) ; 
  int startBloc = 24 ;
  rect(0, startBloc, width, height - startBloc -9 ) ; // //GROUP ZERO
  for (int i = 0 ; i < credit.length; i++) {
    textFont(textUsual_3) ;
    fill(blanc) ;
    text(credit[i], 10,startBloc + 12 + ((i+1)*14));
  }
  }
}
// END CREDIT

class Slider {
  private PVector pos, size, posText, posMol, sizeMol, newPosMol, posMin, posMax ;
  private int slider, boxIn, boxOut, colorText ;
  private boolean molLocked ;
  private PFont p ;
  
  //CONSTRUCTOR with title
  public Slider(PVector pos, PVector posMol , PVector size, PVector posText, int slider, int boxIn, int boxOut, int colorText, PFont p) {
    this.pos = pos ;
    this.posMol = posMol ;
    this.size = size ;
    this.posText = posText ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;
    this.colorText = colorText ;
    this.p = p ;

    newPosMol = new PVector (0, 0) ;
    //which molette for slider horizontal or vertical
    if ( size.x >= size.y ) sizeMol = new PVector (size.y, size.y ) ; else sizeMol = new PVector (size.x, size.x ) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
  
  //CONSTRUCTOR minimum
  public Slider(PVector pos, PVector posMol , PVector size,  int slider, int boxIn, int boxOut ) {
    this.pos = pos ;
    this.posMol = posMol ;
    this.size = size ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;

    newPosMol = new PVector (0, 0) ;
    //which molette for slider horizontal or vertical
    if ( size.x >= size.y ) sizeMol = new PVector (size.y, size.y ) ; else sizeMol = new PVector (size.x, size.x ) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
  
  
  //slider with external molette
  public Slider(PVector pos, PVector posMol , PVector size, PVector sizeMol,  int slider, int boxIn, int boxOut ) {
    this.pos = pos ;
    this.posMol = posMol ;
    this.sizeMol = sizeMol ;
    this.size = size ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;

    newPosMol = new PVector (0, 0) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
  
  //SETTING
  public void sliderSetting() {
    noStroke() ;
    
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y) ;
    
    //MOLETTE
    fill(boxOut) ;
    newPosMol = new PVector (posMol.x, posMol.y  ) ;
    rect(posMol.x, posMol.y, sizeMol.x, sizeMol.y ) ;
    
  }
  
  //Slider update with title
  public void sliderUpdate(String s, boolean t) {
    //SLIDER
    fill(slider) ;
    //rect(pos.x, pos.y, size.x, size.y) ;
    if (t) {
      fill(colorText) ;
      textFont (p ) ;
      textSize (posText.z) ;
      text(s, posText.x, posText.y) ;
    }
    //MOLETTE
    if (insideRect(newPosMol, sizeMol)) fill(boxIn); else fill(boxOut) ; 

    moletteUpdate() ;
    rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y) ;
  }
  //Slider update simple
  public void sliderUpdate() {
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y) ;
    //MOLETTE
    if (insideRect(newPosMol, sizeMol)) fill(boxIn); else fill(boxOut) ;
    moletteUpdate() ;
    rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y) ;
  }
  
  public void moletteUpdate() {
    if (locked (insideRect(newPosMol, sizeMol))) molLocked = true ;
    if (!mousePressed)  molLocked = false ; 
    if (molLocked) if (size.x >= size.y) newPosMol.x = constrain(mouseX -(sizeMol.x /2.0f), posMin.x, posMax.x)  ; else newPosMol.y = constrain(mouseY -(sizeMol.y /2.0f), posMin.y, posMax.y) ;
  }
  
  //RETURN
  public float getValue() {
    float value ;
    if (size.x >= size.y) value = map (newPosMol.x, posMin.x, posMax.x, 0,1) ; else value = map (newPosMol.y, posMin.y, posMax.y, 0,1) ;
    return value ;
  }
}
class SliderHorizontal {
  int posX ;
  int longueurSlider, hauteurSlider;    // width et height de la r\u00e9glette
  int xpos, ypos;         // x and y position de la r\u00e9glette
  float spos, newspos;    // x position de la molette
  int sposMin, sposMax;   // valeurs maximales et mininmales de la r\u00e9glette
  int suivit, posCur;              // how loose/heavy
  int transp ;
  boolean dedans, locked ;           
  int bOUT, bIN, rglt ;
  float rapportDepart = 80.0f ;
  float rapportChargement = 1.0f ;
  //MIDI
  int newValMidi ;
  int IDmidi = -2 ;

  SliderHorizontal (int xp, int yp, int LSlider, int HSlider, int s, int boutonOUT, int boutonIN, int reglette, int transparence, float pC, int IDmidi) {
    this.IDmidi = IDmidi ;
    longueurSlider = LSlider;   
    hauteurSlider = HSlider;              
    suivit = s;
    xpos = xp;          
    ypos = yp-hauteurSlider/2;
    float lh = PApplet.parseFloat(longueurSlider) ;
    
    //molette position
    spos = xpos + (pC / (100.0f + ((11.0f/lh)*rapportDepart)) *LSlider); 
    newspos = spos;
    
    sposMin = xpos;    sposMax = xpos + longueurSlider - hauteurSlider;
    bOUT = boutonOUT ;  bIN = boutonIN ; rglt = reglette   ; transp = transparence ;
    
  }
  
  //DISPLAY MOLETTE
  public void displayMolette(int cIn, int cOut, int colorOutline, PVector size, PVector correctionPos) {
    
    if( xpos != 0 && ypos != 0) {
      fill(rglt, transp);
      stroke(colorOutline) ; 
      strokeWeight(size.z) ;
      //noStroke() ;
      if(dedans || locked) fill(cIn); else fill(cOut);
      //display  
      float factorSize = 1.0f ;
      ellipse(spos +(size.y *.5f) +correctionPos.x, ypos-3 +(size.y *.5f) +correctionPos.y, size.y *factorSize, size.y *factorSize);
      noStroke() ;
    }   
  }

  
  
  


  
  public void update(int currentX, int saveX, boolean save) {
    int NLX ;
    float NloadX ;
    float lh = PApplet.parseFloat(longueurSlider) ;
    NloadX = xpos + (saveX / (100.0f + ( (11.0f/lh)*rapportChargement) ) *longueurSlider);
    NLX = round(NloadX) ;
    // Choix entre le chargement des sauvegarde de position ou les coordonn\u00e9es de la souris
    if(save) posX = NLX ; else posX = currentX ;
   
   if(dedans()) dedans = true ; else dedans = false ;
   if(mousePressed && dedans) locked = true ;
   if(!mousePressed) locked = false ;
   
   if(locked || save)newspos = constrain(posX-hauteurSlider/2, sposMin, sposMax);

    if(abs(newspos - spos) > 1) {
      spos = spos +(newspos-spos)/suivit;
    }
  }

  public int constrain(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }
  
  //update from save file
  public void updateFromSave(int pos, int IDmidi) {
    // update position
    int NLX ;
    float NloadX ;
    float lh = PApplet.parseFloat(longueurSlider) ;
    NloadX = xpos + (pos / (100.0f + ( (11.0f/lh)*rapportChargement) ) *longueurSlider);
    NLX = round(NloadX) ;
    posX = NLX ;
    // IDmidi
    this.IDmidi = IDmidi ;
  }
  
  
  
  
  
  
  
  // update position from midi controller
  public void updateMidi(int val) {
    //update the Midi position only if the Midi Button move
    if (newValMidi != val) { 
      newValMidi = val ; 
      newspos = map(val, 1, 127, sposMin, sposMax ) ;
      posX = newValMidi ; 
    }
  }
  
  //////
  //VOID
  public void load(int loadX) {
    float lh = PApplet.parseFloat(longueurSlider) ;
    spos = xpos + (loadX / (100.0f + ( (11.0f/lh)*rapportChargement) ) * longueurSlider);
  }
  
  
  
  // give the ID from the controller Midi
  public void selectIDmidi(int num) { IDmidi = num ; }
  
  
  
  
  ////////
  //RETURN
  //give the IDmidi 
  public int IDmidi() { return IDmidi ; }
  
  
  
  //return the state
  public boolean lock() { return locked ; }
  
  
  
  //rollover
  public boolean dedans() {
    if(mouseX > spos && mouseX < spos+hauteurSlider && mouseY > ypos && mouseY < ypos+hauteurSlider) return true ; else return false ;
  }
  
  
  
  //return pos
  public float getPos() { // nom de variable et () permet de r\u00e9cup\u00e9rer les donn\u00e9es d'un return
    return (((spos-xpos)/longueurSlider)-0.004f) *111 ;
  }
}
//UTIL
//STRING SPLIT
public String [] splitText(String textToSplit, String separator) {
  String [] text = textToSplit.split(separator) ;
  return text  ;
}
//STRING COMPARE LIST SORT
//raw compare
public int longestWord( String[] listWordsToSort) {
  int sizeWord = 0 ;
  for ( int i = 0 ; i < listWordsToSort.length ; i++) {
    if (listWordsToSort[i].length() > sizeWord )  sizeWord = listWordsToSort[i].length() ;
  }
  return  sizeWord ;
}
//with starting and end keypoint in the String must be sort
public int longestWord( String[] listWordsToSort, int start, int finish ) {
  int sizeWord = 0 ;
  for ( int i = start ; i < finish ; i++) {
    if (listWordsToSort[i].length() > sizeWord )  sizeWord = listWordsToSort[i].length() ;
  }
  return  sizeWord ;
}
//END STRING COMPARE
////////////////////



//INSIDE
//CIRLCLE
public boolean insideCircle (PVector pos, int diam) {
  if (dist(pos.x, pos.y, mouseX, mouseY) < diam) return true  ; else return false ;
}

//RECTANGLE
public boolean insideRect(PVector pos, PVector size) { 
    if(mouseX > pos.x && mouseX < pos.x + size.x && mouseY >  pos.y && mouseY < pos.y + size.y) return true ; else return false ;
}

//LOCKED
public boolean locked ( boolean inside ) {
  if ( inside  && mousePressed ) return true ; else return false ;
}




//EQUATION
public float perimeterCircle ( float r ){
  //calcul du perimetre
  float p = r*TWO_PI  ;
  return p ;
}

//EQUATION
public float radiusSurface(int s) {
  // calcul du rayon par rapport au nombre de point
  float  r = sqrt(s/PI) ;
  return r ;
}

int colorW ;
//ROLLOVER TEXT ON BACKGROUNG CHANGE
public int colorWrite(int colorRef, int threshold, int clear, int deep) {
  if( brightness( colorRef ) < threshold ) {
    colorW = color(clear) ;
  } else {
    colorW = color(deep) ;
  }
  return colorW ;
}


//TIME
public int minClock() {
  return hour()*60 + minute() ;
}



//TRANSLATOR to String
public String joinIntToString(int []data) {
  String intString ;
  String [] dataString = new String [data.length] ;
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = Integer.toString(data[i]) ;
  intString = join(dataString,"/") ;
  
  return intString ;
}

public String joinFloatToString(float []data) {
  String floatString ;
  String [] dataString = new String [data.length] ;
  //for ( int i = 0 ; i < data.length ; i++) dataString[i] = Float.toString(data[i]) ;
  //we must use just one decimal after coma, to dodge the outBoundIndex blablabla
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = String.format("%.1f" ,data[i]) ;
  floatString = join(dataString,"/") ;
  
  return floatString ;
}

//Translater to String
public String FloatToString(float data) {
  String newData ;
  newData = String.format("%.2f", data ) ;
  return newData ;
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Controleur_26" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
