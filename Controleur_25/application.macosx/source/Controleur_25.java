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

public class Controleur_25 extends PApplet {

  ///////////////////////////////////////////////////////////////////////////////////////////////////
 // Romanesco Contr\u00f4leur Alpha 0.25 work with Processing 211 export with Processing 203  ///////////
///////////////////////////////////////////////////////////////////////////////////////////////////
String release = ("25") ;
boolean test = false ;

public void setup() {
  setting() ;
  loadSetup() ;
  interfaceSetup() ;
  sendOSCsetup() ;
}

public void draw() {
  structureDraw() ;
  interfaceDraw() ;
  sendOSCdraw() ;

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
    BOmidi.mousePressedText() ;
    //curtain
    BOcurtain.mousePressedText() ;
  }
  //dropdown
  dropdownMousepressed() ;

}


//KEYPRESSED
public void keyPressed() {
  //OpenClose save
  OpenCloseSave() ;
}

//KEYRELEASED
public void keyReleased() { 
  clavier[keyCode] = false;
}
//GLOBAL


//SLIDER
int numSlider = 350 ;
int numGroupSlider = 4 ;
int sliderByColumn = 8 ;
// Midi

MidiIO midiIO;
int sliderMidi, valMidi ;
int numMidi = -1 ;
boolean saveMidi ;
boolean selectMidi = false ;
//curtain
boolean curtainOpenClose ;
//GLOBAL

byte saveR [] = new byte [2*numSlider]; // byte between -128 and 127 result 256 bytes
byte loadR []  = new byte [2*numSlider] ;

boolean[] clavier = new boolean[526];
boolean loadSliderPos = false ;
boolean ouvrirFichier = false ;


//ANNEXE
public void setting() {
  size(565,650); 
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
//GLOBAL
// interface picture      
PImage[] vignette = new PImage[49] ;
//simple
PImage[] vignette_OFF_in_simple ;
PImage[] vignette_OFF_out_simple ;
PImage[] vignette_ON_in_simple ;
PImage[] vignette_ON_out_simple ;
//texture
PImage[] vignette_OFF_in_texture ;
PImage[] vignette_OFF_out_texture ;
PImage[] vignette_ON_in_texture ;
PImage[] vignette_ON_out_texture ;
//typography
PImage[] vignette_OFF_in_typography ;
PImage[] vignette_OFF_out_typography ;
PImage[] vignette_ON_in_typography ;
PImage[] vignette_ON_out_typography ;
PImage[] bouton = new PImage[18] ;

//SLIDER

// POSITION GLOBAL button and Slider
int numSliderGroupZero = 14 ;
int numSliderGroupOne = 30 ;
int numSliderGroupTwo = 30 ;
int numSliderGroupThree = 30 ;
PVector columnPosVert = new PVector(25,205, 385) ; // give the pos of the column on the axis "x"
int margeLeft  ; // marge left for the first GUI button and slider
int startingTopPosition  ; // marge top to starting position of the GUI button and slider

int sliderHeight = 6 ;
RegletteHorizontale [] Slider = new RegletteHorizontale [numSlider] ;
int suivitSlider[] = new int[numSlider] ; 
int posWidthSlider[] = new int[numSlider] ;
int posHeightSlider[] = new int[numSlider] ;
int longueurSlider[] = new int[numSlider] ;
int hauteurSlider[] = new int[numSlider] ;
float valueSlider[] = new float[numSlider] ;

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
int EtatFont, EtatShaderBG ;
PVector posButtonFont, posButtonShaderBG ; 

// MIDI, CURTAIN
int EtatMidiButton, EtatCurtainButton, EtatBbeat, EtatBkick, EtatBsnare, EtatBhat ; ;
PVector posMidiButton, sizeMidiButton,
        posCurtainButton, sizeCurtainButton,
        posBeatButton, sizeBeatButton,
        posKickButton, sizeKickButton,
        posSnareButton, sizeSnareButton,
        posHatButton, sizeHatButton ;


//param\u00e8tres r\u00e9glette couleur
int posXSlider[] =      new int[numSlider*2] ;



//SETUP
public void interfaceSetup() {
  fontSetup() ;
  midiSetup() ;
  importPicButtonSetup() ;
  buttonSliderSetup() ;
  constructorSliderButton() ;
}

public void interfaceDraw() {
  textDraw() ;
  midiDraw() ;
  sliderDraw() ;
  moletteDraw() ;
  buttonDraw() ;
}

//END GLOBAL
///////////





//SPECIFIC VOID of INTERFACE


//MIDI
//SETUP
public void midiSetup() {
  //get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);
  //open the first midi channel of the first device if there Input
  if ( midiIO.numberOfInputDevices() > 0 ) midiIO.openInput(0,0);
}
//DRAW
public void midiDraw() {
  //save midi setting molette
  String [] newSettingMidi = new String[numSlider] ;
  if ( EtatMidiButton == 1 ) selectMidi = true ; else selectMidi = false ;
}
//END MIDI



//BUTTON

//SETUP
public void buttonSliderSetup() {
 
  //GLOBAL POS
  margeLeft = (int)columnPosVert.x +15 ; // marge left for the first GUI button and slider
  startingTopPosition = 30 ; // marge top to starting position of the GUI button and slider
  mgSliderc1 = (int)columnPosVert.x ; mgSliderc2 = (int)columnPosVert.y ; mgSliderc3 = (int)columnPosVert.z ;
  int topMenuPos = startingTopPosition +10 ;
  
  //GROUP GLOBAL
  // FONT
  posButtonFont = new PVector(mgSliderc3 -3, startingTopPosition +30)  ; 
  // SHADER BACKGROUNG
  posButtonShaderBG = new PVector(mgSliderc1 -3, startingTopPosition)  ;
  
  // MIDI CURTAIN
  sizeCurtainButton = new PVector(30,12) ;
  sizeMidiButton = new PVector(30,12) ;
  posMidiButton = new PVector(mgSliderc3, topMenuPos) ; 
  posCurtainButton = new PVector(mgSliderc3, topMenuPos +15) ; 
  
  //SOUND BUTTON
  sizeBeatButton = new PVector(30,10) ; 
  sizeKickButton = new PVector(30,10) ; 
  sizeSnareButton = new PVector(40,10) ; 
  sizeHatButton = new PVector(30,10) ;
  posBeatButton = new PVector(mgSliderc3 +0, topMenuPos +60) ; 
  posKickButton = new PVector(posBeatButton.x +sizeBeatButton.x +5, topMenuPos +60) ; 
  posSnareButton = new PVector(posKickButton.x +sizeKickButton.x +5, topMenuPos +60) ; 
  posHatButton = new PVector(posSnareButton.x +sizeSnareButton.x +5, topMenuPos +60) ;

  // background 
  posBackgroundButton = new PVector(mgSliderc1, startingTopPosition +50) ;
  sizeBackgroundButton = new PVector(95,10) ;
  // light button
  posLightOneButton = new PVector(mgSliderc2, startingTopPosition +10) ;
  sizeLightOneButton = new PVector(80,10) ;
  posLightOneAction = new PVector(mgSliderc2 +90, posLightOneButton.y) ;
  sizeLightOneAction = new PVector(45,10) ;
  //
  posLightTwoButton = new PVector(mgSliderc2, startingTopPosition +60) ;
  sizeLightTwoButton = new PVector(80,10) ;
  posLightTwoAction = new PVector(mgSliderc2 +90, posLightTwoButton.y) ;
  sizeLightTwoAction = new PVector(45,10) ;
  
  // GROUP ONE
  posHeightBO  = startingTopPosition + 140  ;               posWidthBO  =margeLeft ;
  posHeightRO  = posHeightBO +60   ;  posWidthRO  =margeLeft ;
  
  //GROUP TWO
  posHeightBT  = posHeightBO + 160 ;  posWidthBT  =margeLeft ;
  posHeightRT  = posHeightBT +60   ;  posWidthRT  =margeLeft ;
  
  //GROUP THREE
  posHeightBTY = posHeightBT + 160 ;  posWidthBTY =margeLeft ;
  posHeightRTY = posHeightBTY +60  ;  posWidthRTY =margeLeft ;
  
  // VOID
  groupZero(startingTopPosition +62) ;
  groupOne(posHeightBO, posHeightRO ) ;
  groupTwo(posHeightBT, posHeightRT ) ;
  groupThree(posHeightBTY, posHeightRTY ) ;
 
  dropdownSetup() ;
}



/////////////////////
public void groupZero(int pos) {
  //Background
  suivitSlider[1] = 1 ; posWidthSlider[1] = mgSliderc1 ; posHeightSlider[1]= pos +0 ; longueurSlider[1] = 111 ; hauteurSlider[1] = sliderHeight ; ; // couleur du fond  
  suivitSlider[2] = 1 ; posWidthSlider[2] = mgSliderc1 ; posHeightSlider[2]= pos +10 ; longueurSlider[2] = 111 ; hauteurSlider[2] = sliderHeight ; ;   
  suivitSlider[3] = 1 ; posWidthSlider[3] = mgSliderc1 ; posHeightSlider[3]= pos +20 ; longueurSlider[3] = 111 ; hauteurSlider[3] = sliderHeight ; ;   
  suivitSlider[4] = 1 ; posWidthSlider[4] = mgSliderc1 ; posHeightSlider[4]= pos +30 ; longueurSlider[4] = 111 ; hauteurSlider[4] = sliderHeight ; ;   
  // SOUND
  suivitSlider[5] = 1 ; posWidthSlider[5] = mgSliderc3  ; posHeightSlider[5]= pos +20 ; longueurSlider[5] = 111 ; hauteurSlider[5] = sliderHeight ;  ; // sound left
  suivitSlider[6] = 1 ; posWidthSlider[6] = mgSliderc3  ; posHeightSlider[6]= pos +30 ; longueurSlider[6] = 111 ; hauteurSlider[6] = sliderHeight ; ; // sound rigth 
  // LIGHT ONE
  suivitSlider[7] = 1 ; posWidthSlider[7] = mgSliderc2 ; posHeightSlider[7]= pos -40 ; longueurSlider[7] = 111 ; hauteurSlider[7] = sliderHeight ; ; // hue 
  suivitSlider[8] = 1 ; posWidthSlider[8] = mgSliderc2 ; posHeightSlider[8]= pos -30 ; longueurSlider[8] = 111 ; hauteurSlider[8] = sliderHeight ; ;   
  suivitSlider[9] = 1 ; posWidthSlider[9] = mgSliderc2 ; posHeightSlider[9]= pos -20 ; longueurSlider[9] = 111 ; hauteurSlider[9] = sliderHeight ; ; 
 // LIGHT TWO
  suivitSlider[10] = 1 ; posWidthSlider[10] = mgSliderc2 ; posHeightSlider[10]= pos +10 ; longueurSlider[10] = 111 ; hauteurSlider[10] = sliderHeight ; ;  // hue ambiance
  suivitSlider[11] = 1 ; posWidthSlider[11] = mgSliderc2 ; posHeightSlider[11]= pos +20 ; longueurSlider[11] = 111 ; hauteurSlider[11] = sliderHeight ; ;
  suivitSlider[12] = 1 ; posWidthSlider[12] = mgSliderc2 ; posHeightSlider[12]= pos +30 ; longueurSlider[12] = 111 ; hauteurSlider[12] = sliderHeight ; ;
}

//////////////
public void groupOne( int posButton, int posSlider) {
  //position and area for the rollover
  for (int i = 1 ; i <= numGroup[1] ; i++ ) {
    posWidthBOf[i*10+1] = posWidthBO +((i-1)*40)-8 ; posHeightBOf[i*10+1] = posButton -10  ; longueurBOf[i*10+1] = 20 ; hauteurBOf[i*10+1] = 20 ;  //main
    posWidthBOf[i*10+2] = posWidthBO +((i-1)*40)-8 ; posHeightBOf[i*10+2] = posButton +12  ; longueurBOf[i*10+2] = 19 ; hauteurBOf[i*10+2] = 6 ; //setting
    posWidthBOf[i*10+3] = posWidthBO +((i-1)*40)-8 ; posHeightBOf[i*10+3] = posButton +21  ; longueurBOf[i*10+3] = 10 ; hauteurBOf[i*10+3] = 6 ; //sound
    posWidthBOf[i*10+4] = posWidthBO +((i-1)*40)+2 ; posHeightBOf[i*10+4] = posButton +21  ; longueurBOf[i*10+4] = 10 ; hauteurBOf[i*10+4] = 6 ; //action
  }

  // where the controleur must display the slider
  for( int i = 0 ; i < sliderByColumn ; i++ ) {
    suivitSlider[i+101] = 1 ; posWidthSlider[i+101] = mgSliderc1 ; posHeightSlider[i+101] = posSlider +i*10 ; longueurSlider[i+101] = 111 ; hauteurSlider[i+101] = sliderHeight ; ;
    suivitSlider[i+111] = 1 ; posWidthSlider[i+111] = mgSliderc2 ; posHeightSlider[i+111] = posSlider +i*10 ; longueurSlider[i+111] = 111 ; hauteurSlider[i+111] = sliderHeight ; ;
    suivitSlider[i+121] = 1 ; posWidthSlider[i+121] = mgSliderc3 ; posHeightSlider[i+121] = posSlider +i*10 ; longueurSlider[i+121] = 111 ; hauteurSlider[i+121] = sliderHeight ; ;
  }
}

//////////////////
public void groupTwo(int posButton, int posSlider) {
  for (int i = 1 ; i <= numGroup[2] ; i++ ) {
    posWidthBTf[i*10+1] = posWidthBT +((i-1)*40)-8 ; posHeightBTf[i*10+1] = posButton -10  ; longueurBTf[i*10+1] = 20 ; hauteurBTf[i*10+1] = 20 ; //main
    posWidthBTf[i*10+2] = posWidthBT +((i-1)*40)-8 ; posHeightBTf[i*10+2] = posButton +12  ; longueurBTf[i*10+2] = 19 ; hauteurBTf[i*10+2] = 6 ; //setting
    posWidthBTf[i*10+3] = posWidthBT +((i-1)*40)-8 ; posHeightBTf[i*10+3] = posButton +21  ; longueurBTf[i*10+3] = 10 ; hauteurBTf[i*10+3] = 6 ; //sound
    posWidthBTf[i*10+4] = posWidthBT +((i-1)*40)+2 ; posHeightBTf[i*10+4] = posButton +21  ; longueurBTf[i*10+4] = 10 ; hauteurBTf[i*10+4] = 6 ; //action
  }
  // where the controle must display the slider
  for( int i = 0 ; i < sliderByColumn ; i++ ) {
    suivitSlider[i+201] = 1 ; posWidthSlider[i+201] = mgSliderc1 ; posHeightSlider[i+201] = posSlider +i*10 ; longueurSlider[i+201] = 111 ; hauteurSlider[i+201] = sliderHeight ; ;
    suivitSlider[i+211] = 1 ; posWidthSlider[i+211] = mgSliderc2 ; posHeightSlider[i+211] = posSlider +i*10 ; longueurSlider[i+211] = 111 ; hauteurSlider[i+211] = sliderHeight ; ;
    suivitSlider[i+221] = 1 ; posWidthSlider[i+221] = mgSliderc3 ; posHeightSlider[i+221] = posSlider +i*10 ; longueurSlider[i+221] = 111 ; hauteurSlider[i+221] = sliderHeight ; ;
  }
}

/////////////////
public void groupThree(int posButton, int posSlider) {
  //param\u00e8tre habillage couleur du bouton cercle BTY
  for (int i = 1 ; i <= numGroup[3] ; i++ ) {
    posWidthBTYf[i*10+1] = posWidthBTY +((i-1)*40)-8 ; posHeightBTYf[i*10+1] = posButton -10  ; longueurBTYf[i*10+1] = 20 ; hauteurBTYf[i*10+1] = 20 ; //main
    posWidthBTYf[i*10+2] = posWidthBTY +((i-1)*40)-8 ; posHeightBTYf[i*10+2] = posButton +12  ; longueurBTYf[i*10+2] = 19 ; hauteurBTYf[i*10+2] = 6 ; //setting
    posWidthBTYf[i*10+3] = posWidthBTY +((i-1)*40)-8 ; posHeightBTYf[i*10+3] = posButton +21  ; longueurBTYf[i*10+3] = 10 ; hauteurBTYf[i*10+3] = 6 ; //sound
    posWidthBTYf[i*10+4] = posWidthBTY +((i-1)*40)+2 ; posHeightBTYf[i*10+4] = posButton +21  ; longueurBTYf[i*10+4] = 10 ; hauteurBTYf[i*10+4] = 6 ; //action
  }
  
  // where the controleur must display the slider
  for( int i = 0 ; i < sliderByColumn ; i++ ) {
    suivitSlider[i+301] = 1 ; posWidthSlider[i+301] = mgSliderc1 ; posHeightSlider[i+301] = posSlider +i*10 ; longueurSlider[i+301] = 111 ; hauteurSlider[i+301] = sliderHeight ; ;
    suivitSlider[i+311] = 1 ; posWidthSlider[i+311] = mgSliderc2 ; posHeightSlider[i+311] = posSlider +i*10 ; longueurSlider[i+311] = 111 ; hauteurSlider[i+311] = sliderHeight ; ;
    suivitSlider[i+321] = 1 ; posWidthSlider[i+321] = mgSliderc3 ; posHeightSlider[i+321] = posSlider +i*10 ; longueurSlider[i+321] = 111 ; hauteurSlider[i+321] = sliderHeight ; ;
  } 
}






/////////////
//CONSTRUCTOR
public void constructorSliderButton() {
  buttonBackground = new Simple(posBackgroundButton, sizeBackgroundButton, vertTresFonce, vertFonce, rouge, rougeFonce) ;
  // LIGHT ONE
  buttonLightOne = new Simple(posLightOneButton, sizeLightOneButton, vertTresFonce, vertFonce, rouge, rougeFonce) ;
  buttonLightOneAction = new Simple(posLightOneAction, sizeLightOneAction, vertTresFonce, vertFonce, rouge, rougeFonce) ;
  // LIGHT TWO 
  buttonLightTwo = new Simple(posLightTwoButton, sizeLightTwoButton, vertTresFonce, vertFonce, rouge, rougeFonce) ;
  buttonLightTwoAction = new Simple(posLightTwoAction, sizeLightTwoAction, vertTresFonce, vertFonce, rouge, rougeFonce) ;
  //button beat
  Bbeat = new Simple(posBeatButton, sizeBeatButton, vertTresFonce, vertFonce, rouge, rougeFonce) ;
  Bkick = new Simple(posKickButton, sizeKickButton, vertTresFonce, vertFonce, rouge, rougeFonce) ;
  Bsnare = new Simple(posSnareButton, sizeSnareButton, vertTresFonce, vertFonce, rouge, rougeFonce) ;
  Bhat = new Simple(posHatButton, sizeHatButton, vertTresFonce, vertFonce, rouge, rougeFonce) ;
  //MIDI
  BOmidi  = new Simple (posMidiButton, sizeMidiButton, vert, vertFonce, rouge, rougeFonce) ;
  //curtain
  BOcurtain  = new Simple (posCurtainButton, sizeCurtainButton, vert, vertFonce, rouge, rougeFonce) ;
  
  //button object, texture, typography
  for(int i = 1 ; i < numGroupSlider ; i++) {
    int num = numButton[i] ;
    for ( int j = 11 ; j < 10+num ; j++) {
      if(numGroup[1] > 0 && i == 1) BOf[j] = new Simple(  posWidthBOf[j], posHeightBOf[j], longueurBOf[j], hauteurBOf[j], boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir ) ; 
      if(numGroup[2] > 0 && i == 2) BTf[j] = new Simple(  posWidthBTf[j], posHeightBTf[j], longueurBTf[j], hauteurBTf[j], boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir ) ;
      if(numGroup[3] > 0 && i == 3) BTYf[j] = new Simple(  posWidthBTYf[j], posHeightBTYf[j], longueurBTYf[j], hauteurBTYf[j], boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir ) ;
    }

  }
  
  
  
  //slider
  for ( int i = 1 ; i < numSlider ; i++ ) {
    //exception for the slider who must show the color
    int opacityReglette = 200 ;
    if ( (i < 4) || ( i > 6 && i < 13) || ( i > 100 && i < 109) || ( i > 200 && i < 209) || ( i > 300 && i < 309) ) opacityReglette = 0 ; else opacityReglette = 200 ;
    Slider[i] = new RegletteHorizontale  (posWidthSlider[i], posHeightSlider[i], longueurSlider[i], hauteurSlider[i], suivitSlider[i], orange, rouge, blancGrisClair, opacityReglette, loadR [i], loadR [i+numSlider]);
  } 
}
//END CONSTRUCTOR
/////////////////









//STRUCTURE
//DRAW
public void structureDraw() {
  //background
  fill(grisClair) ; rect(0, 0, width, height ) ;
  fill(blancGris) ; rect(0, posHeightBO -15, width, 160 ) ;   //GROUP ONE
  fill(grisClair) ; rect(0, posHeightBT -15, width, 140 ) ;   //GROUP TWO
  fill(blancGris) ; rect(0, posHeightBTY -15, width, height ) ; //   //GROUP THREE
  //the decoration line
  fill (orange) ; 
  rect(0,0, width, 24) ;
  rect(0,posHeightBO -18, width, 3) ; //GROUP ONE
  rect(0,posHeightBT -18, width, 3) ; //GROUP TWO
  rect(0,posHeightBTY -18, width, 3) ; //GROUP THREE
  rect(0,height-7, width, 7) ;

}
//END STRUCTURE




//TEXT
//DRAW
public void textDraw() {
  fill (blanc) ; 
  textFont(FuturaStencil_20,20); 
  text("ROMANESCO alpha "+release, 5, 20); 
  //CLOCK
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  text(  nf(hour(),2)   + ":" +nf(minute(),2) , width -10, 20);
  
  dispayTextSliderGroupZero(startingTopPosition +64) ;
  
  dislayTextSlider() ;
}



public void dispayTextSliderGroupZero(int pos) {
  int correction = 3 ;
  // GROUP ZERO
  textFont(FuturaStencil_20,20); textAlign(LEFT);
  //fill(blanc, 120) ;

  fill (typoTitre) ; 
  textFont(textInterface, sizeTexteInterface) ; textAlign(LEFT);
  fill (typoCourante) ;
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
  
  fill (typoCourante) ;
  textFont(textInterface); 
  text(genTxtGUI[5], posWidthSlider[5] +116, posHeightSlider[5] +correction);
  text(genTxtGUI[6], posWidthSlider[6] +116, posHeightSlider[6] +correction);
}



public void dislayTextSlider() {
  //GROUP ONE
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  fill(blanc, 120) ;
  pushMatrix () ; rotate (-PI/2) ;  text("GROUP ONE", -posHeightRO +70, 20); popMatrix() ;
  fill (typoCourante) ;
  textFont(textInterface);  textAlign(LEFT);
  
  // GROUP TWO
  textFont(FuturaStencil_20,20);  textAlign(RIGHT);
  fill(blanc, 120) ;
  pushMatrix () ; rotate (-PI/2) ;  text("GROUP TWO", -posHeightRT +70, 20); popMatrix() ;
  fill (typoCourante) ;
  textFont(textInterface);  textAlign(LEFT);
  
  //GROUP THREE
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  fill(blanc, 120) ;
  pushMatrix () ; rotate (-PI/2) ; text("GROUP THREE", -posHeightRTY +70, 20); popMatrix() ;
  fill (typoCourante) ;
  textFont(textInterface); textAlign(LEFT);
  
  // Legend text slider position
  int correctionPos = 3 ;
  for ( int i = 0 ; i < sliderByColumn ; i++) {
    //group one
    text(objTxtGUIone[i+1], mgSliderc1 +116, posHeightRO +correctionPos +(i*10));
    text(objTxtGUItwo[i+1], mgSliderc2 +116, posHeightRO +correctionPos +(i*10));
    text(objTxtGUIthree[i+1],   mgSliderc3 +116, posHeightRO +correctionPos +(i*10));
    //group two
    text(textureTxtGUIone[i+1], mgSliderc1 +116, posHeightRT +correctionPos +(i*10));
    text(textureTxtGUItwo[i+1], mgSliderc2 +116, posHeightRT +correctionPos +(i*10));
    text(textureTxtGUIthree[i+1], mgSliderc3 +116, posHeightRT +correctionPos +(i*10));
    //group Three
    text(typoTxtGUIone[i+1], mgSliderc1 +116,  posHeightRTY +correctionPos +(i*10));
    text(typoTxtGUItwo[i+1], mgSliderc2 +116,  posHeightRTY +correctionPos +(i*10));
    text(typoTxtGUIthree[i+1], mgSliderc3 +116,  posHeightRTY +correctionPos +(i*10));
  }
}

//END TEXT








//MOLETTE
public void moletteDraw() {
  PVector sizeMoletteSlider = new PVector (8,10, 1.5f) ; // width, height, thickness
  //display and update the molette
  for ( int i = 0 ; i < numSlider ; i++) {
    if (    (i>0 && i<19) 
         || ( i>100 && i<109) || ( i>110 && i<119) || ( i>120 && i<129)
         || ( i>200 && i<209) || ( i>210 && i<219) || ( i>220 && i<229) 
         || ( i>300 && i<309) || ( i>310 && i<319) || ( i>320 && i<329) ) { 
      //give which button is active and check is this button have a same IDmidi that Object
      if ( numMidi == Slider[i].IDmidi() ) Slider[i].updateMidi(valMidi) ;
      //to add an IDmidi from the internal setting to object
      if (selectMidi && Slider[i].lock() ) { Slider[i].selectIDmidi(numMidi) ; }
      //to add an ID midi from the save
      if(loadSliderPos) { 
        Slider[i].selectIDmidi(PApplet.parseInt(loadR [i + numSlider]) ) ;
      }
      Slider[i].update(mouseX, loadR[i]);    
      Slider[i].displayMolette(rouge, orange, blanc, sizeMoletteSlider);

      //value from the slider
      valueSlider[i] = constrain(map(Slider[i].getPos(), 0, 104, 0,100),0,100)  ;     
      saveR [i] = PApplet.parseByte(valueSlider[i] ) ;
      saveR [i + numSlider] = PApplet.parseByte(Slider[i].IDmidi() ) ;
    }
  }
  loadSliderPos = false ; 
}
//END MOLETTE



//SLIDER DRAW
/////////////
public void sliderDraw() {
  sliderDrawGroupZero () ;
  sliderDrawGroupOne () ;
  sliderDrawGroupTwo () ;
  sliderDrawGroupThree () ;
}

// DETAIL GROUP SLIDER DRAW
///////////////////////////
public void sliderDrawGroupZero () {
  //Background slider
  if (mouseX > (posWidthSlider[1] ) && mouseX < ( posWidthSlider[1] + longueurSlider[1]) 
  && mouseY > ( posHeightSlider[1] - 5) && mouseY < posHeightSlider[1] + 30 ) {
    fondRegletteCouleur    ( posWidthSlider[1], posHeightSlider[1], hauteurSlider[1], longueurSlider[1]) ;
    fondRegletteSaturation ( posWidthSlider[2], posHeightSlider[2], hauteurSlider[2], longueurSlider[1], valueSlider[1], valueSlider[2], valueSlider[3] ) ;
    fondRegletteDensite    ( posWidthSlider[3], posHeightSlider[3], hauteurSlider[3], longueurSlider[1], valueSlider[1], valueSlider[2], valueSlider[3] ) ;
  } else {
    fondReglette    ( posWidthSlider[1], posHeightSlider[1], hauteurSlider[1], longueurSlider[1], blancGrisClair) ;
    fondReglette    ( posWidthSlider[2], posHeightSlider[2], hauteurSlider[2], longueurSlider[2], blancGrisClair ) ;
    fondReglette    ( posWidthSlider[3], posHeightSlider[3], hauteurSlider[3], longueurSlider[3], blancGrisClair ) ;
  }
  // light ONE slider
  if (mouseX > (posWidthSlider[7] ) && mouseX < ( posWidthSlider[7] + longueurSlider[7]) 
  && mouseY > ( posHeightSlider[7] - 5) && mouseY < posHeightSlider[1] + 40 ) {
    fondRegletteCouleur    ( posWidthSlider[7], posHeightSlider[7], hauteurSlider[7], longueurSlider[7]) ;
    fondRegletteSaturation ( posWidthSlider[8], posHeightSlider[8], hauteurSlider[8], longueurSlider[7], valueSlider[7], valueSlider[8], valueSlider[9] ) ;
    fondRegletteDensite    ( posWidthSlider[9], posHeightSlider[9], hauteurSlider[9], longueurSlider[7], valueSlider[7], valueSlider[8], valueSlider[9] ) ;
  } else {
    fondReglette    ( posWidthSlider[7], posHeightSlider[7], hauteurSlider[7], longueurSlider[7], blancGrisClair) ;
    fondReglette    ( posWidthSlider[8], posHeightSlider[8], hauteurSlider[8], longueurSlider[8], blancGrisClair ) ;
    fondReglette    ( posWidthSlider[9], posHeightSlider[9], hauteurSlider[9], longueurSlider[9], blancGrisClair ) ;
  }
  // light TWO slider
  if (mouseX > (posWidthSlider[10] ) && mouseX < ( posWidthSlider[10] + longueurSlider[10]) 
  && mouseY > ( posHeightSlider[10] - 5) && mouseY < posHeightSlider[1] + 40 ) {
    fondRegletteCouleur    ( posWidthSlider[10], posHeightSlider[10], hauteurSlider[10], longueurSlider[10]) ;
    fondRegletteSaturation ( posWidthSlider[11], posHeightSlider[11], hauteurSlider[11], longueurSlider[10], valueSlider[10], valueSlider[11], valueSlider[9] ) ;
    fondRegletteDensite    ( posWidthSlider[12], posHeightSlider[12], hauteurSlider[12], longueurSlider[10], valueSlider[10], valueSlider[11], valueSlider[12] ) ;
  } else {
    fondReglette    ( posWidthSlider[10], posHeightSlider[10], hauteurSlider[10], longueurSlider[10], blancGrisClair) ;
    fondReglette    ( posWidthSlider[11], posHeightSlider[11], hauteurSlider[11], longueurSlider[11], blancGrisClair ) ;
    fondReglette    ( posWidthSlider[12], posHeightSlider[12], hauteurSlider[12], longueurSlider[12], blancGrisClair ) ;
  }
}



/////////////////////////////
public void sliderDrawGroupOne () {
  if ( mouseX > (posWidthSlider[101] ) && mouseX < ( posWidthSlider[101] + longueurSlider[101]) 
       && mouseY > ( posHeightSlider[101] - 5) && mouseY < posHeightSlider[101] +30 ) 
  {
    fondRegletteCouleur     ( posWidthSlider[101], posHeightSlider[101], hauteurSlider[101], longueurSlider[101]) ; 
    fondRegletteSaturation  ( posWidthSlider[102], posHeightSlider[102], hauteurSlider[102], longueurSlider[101], valueSlider[101], valueSlider[102], valueSlider[103] ) ;
    fondRegletteDensite     ( posWidthSlider[103], posHeightSlider[103], hauteurSlider[103], longueurSlider[101], valueSlider[101], valueSlider[102], valueSlider[103] ) ;
  } else {
    fondReglette    ( posWidthSlider[101], posHeightSlider[101], hauteurSlider[101], longueurSlider[101], blanc) ;
    fondReglette    ( posWidthSlider[102], posHeightSlider[102], hauteurSlider[102], longueurSlider[102], blanc ) ;
    fondReglette    ( posWidthSlider[103], posHeightSlider[103], hauteurSlider[103], longueurSlider[103], blanc ) ;
  }
  fondReglette    ( posWidthSlider[104], posHeightSlider[104], hauteurSlider[104], longueurSlider[104], blanc ) ;
  
  //outline color
  if ( mouseX > (posWidthSlider[105] ) && mouseX < ( posWidthSlider[105] + longueurSlider[105]) 
       && mouseY > ( posHeightSlider[105] - 5) && mouseY < posHeightSlider[105] +30 ) 
  {
    fondRegletteCouleur     ( posWidthSlider[105], posHeightSlider[105], hauteurSlider[105], longueurSlider[105]) ; 
    fondRegletteSaturation  ( posWidthSlider[106], posHeightSlider[106], hauteurSlider[106], longueurSlider[105], valueSlider[105], valueSlider[106], valueSlider[107] ) ;
    fondRegletteDensite     ( posWidthSlider[107], posHeightSlider[107], hauteurSlider[107], longueurSlider[105], valueSlider[105], valueSlider[106], valueSlider[107] ) ;
  } else {
    fondReglette    ( posWidthSlider[105], posHeightSlider[105], hauteurSlider[105], longueurSlider[105], blancGrisClair) ;
    fondReglette    ( posWidthSlider[106], posHeightSlider[106], hauteurSlider[106], longueurSlider[106], blancGrisClair ) ;
    fondReglette    ( posWidthSlider[107], posHeightSlider[107], hauteurSlider[107], longueurSlider[107], blancGrisClair) ;
  }
  fondReglette    ( posWidthSlider[108], posHeightSlider[108], hauteurSlider[108], longueurSlider[108], blancGrisClair ) ;
}


////////////////////////////
public void sliderDrawGroupTwo () {
  if ( mouseX > (posWidthSlider[201] ) && mouseX < ( posWidthSlider[201] + longueurSlider[201]) 
       && mouseY > ( posHeightSlider[201] - 5) && mouseY < posHeightSlider[201] +30 ) 
  {
    fondRegletteCouleur     ( posWidthSlider[201], posHeightSlider[201], hauteurSlider[201], longueurSlider[201]) ; 
    fondRegletteSaturation  ( posWidthSlider[202], posHeightSlider[202], hauteurSlider[202], longueurSlider[201], valueSlider[201], valueSlider[202], valueSlider[203] ) ;
    fondRegletteDensite     ( posWidthSlider[203], posHeightSlider[203], hauteurSlider[203], longueurSlider[201], valueSlider[201], valueSlider[202], valueSlider[203] ) ;
  } else {
    fondReglette    ( posWidthSlider[201], posHeightSlider[201], hauteurSlider[201], longueurSlider[201], blanc) ;
    fondReglette    ( posWidthSlider[202], posHeightSlider[202], hauteurSlider[202], longueurSlider[202], blanc ) ;
    fondReglette    ( posWidthSlider[203], posHeightSlider[203], hauteurSlider[203], longueurSlider[203], blanc ) ;
  }
  fondReglette    ( posWidthSlider[204], posHeightSlider[204], hauteurSlider[204], longueurSlider[204], blanc ) ;
  
  //outline color
  if ( mouseX > (posWidthSlider[205] ) && mouseX < ( posWidthSlider[205] + longueurSlider[205]) 
       && mouseY > ( posHeightSlider[205] - 5) && mouseY < posHeightSlider[205] +30 ) 
  {
    fondRegletteCouleur     ( posWidthSlider[205], posHeightSlider[205], hauteurSlider[205], longueurSlider[205]) ; 
    fondRegletteSaturation  ( posWidthSlider[206], posHeightSlider[206], hauteurSlider[206], longueurSlider[205], valueSlider[205], valueSlider[206], valueSlider[207] ) ;
    fondRegletteDensite     ( posWidthSlider[207], posHeightSlider[207], hauteurSlider[207], longueurSlider[205], valueSlider[205], valueSlider[206], valueSlider[207] ) ;
  } else {
    fondReglette    ( posWidthSlider[205], posHeightSlider[205], hauteurSlider[205], longueurSlider[205], blancGrisClair) ;
    fondReglette    ( posWidthSlider[206], posHeightSlider[206], hauteurSlider[206], longueurSlider[206], blancGrisClair ) ;
    fondReglette    ( posWidthSlider[207], posHeightSlider[207], hauteurSlider[207], longueurSlider[207], blancGrisClair) ;
  }
  fondReglette    ( posWidthSlider[208], posHeightSlider[208], hauteurSlider[208], longueurSlider[208], blancGrisClair ) ;
}


//////////////////////////////
public void sliderDrawGroupThree () {
  if (mouseX > (posWidthSlider[301] ) && mouseX < ( posWidthSlider[301] + longueurSlider[301]) && mouseY > ( posHeightSlider[301] - 5) && mouseY < posHeightSlider[301] + 30 ) {
    fondRegletteCouleur    ( posWidthSlider[301], posHeightSlider[301], hauteurSlider[301], longueurSlider[301]) ;
    fondRegletteSaturation ( posWidthSlider[302], posHeightSlider[302], hauteurSlider[302], longueurSlider[301], valueSlider[301], valueSlider[302], valueSlider[303] ) ;
    fondRegletteDensite    ( posWidthSlider[303], posHeightSlider[303], hauteurSlider[303], longueurSlider[301], valueSlider[301], valueSlider[302], valueSlider[303] ) ;
  } else {
    fondReglette    ( posWidthSlider[301], posHeightSlider[301], hauteurSlider[301], longueurSlider[301], blanc) ;
    fondReglette    ( posWidthSlider[302], posHeightSlider[302], hauteurSlider[302], longueurSlider[302], blanc) ;
    fondReglette    ( posWidthSlider[303], posHeightSlider[303], hauteurSlider[303], longueurSlider[303], blanc ) ;
  }
  fondReglette    ( posWidthSlider[304], posHeightSlider[304], hauteurSlider[304], longueurSlider[304], blanc ) ;
  //outline color
  if ( mouseX > (posWidthSlider[305] ) && mouseX < ( posWidthSlider[305] + longueurSlider[305]) && mouseY > ( posHeightSlider[305] - 5) && mouseY < posHeightSlider[305] +30 ) {
    fondRegletteCouleur     ( posWidthSlider[305], posHeightSlider[305], hauteurSlider[305], longueurSlider[305]) ; 
    fondRegletteSaturation  ( posWidthSlider[306], posHeightSlider[306], hauteurSlider[306], longueurSlider[305], valueSlider[305], valueSlider[306], valueSlider[307] ) ;
    fondRegletteDensite     ( posWidthSlider[307], posHeightSlider[307], hauteurSlider[307], longueurSlider[305], valueSlider[305], valueSlider[306], valueSlider[307] ) ;
  } else {
    fondReglette    ( posWidthSlider[305], posHeightSlider[305], hauteurSlider[305], longueurSlider[305], blancGrisClair) ;
    fondReglette    ( posWidthSlider[306], posHeightSlider[306], hauteurSlider[306], longueurSlider[306], blancGrisClair ) ;
    fondReglette    ( posWidthSlider[307], posHeightSlider[307], hauteurSlider[307], longueurSlider[307], blancGrisClair) ;
  }
  fondReglette    ( posWidthSlider[308], posHeightSlider[308], hauteurSlider[308], longueurSlider[308], blancGrisClair ) ;
  //end TYPO
}

// END SLIDER DRAW
//////////////////




/////////////////////
public void buttonDraw () {
  textFont(textInterface) ;
  buttonDrawGroupZero() ;
  buttonDrawGroupOne() ;
  buttonDrawGroupTwo() ;
  buttonDrawGroupThree() ;
  buttonCheckDraw() ;
  dropdownDraw() ;
}

// DETAIL
// GROUP ZERO
public void buttonDrawGroupZero() {
  buttonBackground.boutonTexte("Background", posBackgroundButton, FuturaStencil_10, 10) ;
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
  BOmidi.boutonTexte  ("MIDI", posMidiButton, FuturaStencil_10, 10) ;
  BOcurtain.boutonTexte  (genTxtGUI[8], posCurtainButton, FuturaStencil_10, 10) ;
}
//GROUP ONE
public void buttonDrawGroupOne() {
    for( int i = 1 ; i <= numGroup[1] ; i++ ) {
    BOf[i*10 +1].boutonVignette(vignette_OFF_in_simple, vignette_OFF_out_simple, vignette_ON_in_simple, vignette_ON_out_simple, i) ; 
    BOf[i*10 +2].boutonCarre () ; 
    BOf[i*10 +3].boutonSonPetit () ; 
    BOf[i*10 +4].boutonAction () ;
    PVector pos = new PVector (posWidthBOf[i*10 +2], posHeightBOf[i*10 +1] +10) ;
    PVector size = new PVector (20, 30) ;
    rolloverInfoVignette(pos, size, i, 1) ;
  }
}
// GROUP TWO
public void buttonDrawGroupTwo() {
    for( int i = 1 ; i <= numGroup[2] ; i++ ) {
    BTf[i*10 +1].boutonVignette(vignette_OFF_in_texture, vignette_OFF_out_texture, vignette_ON_in_texture, vignette_ON_out_texture, i) ; 
    BTf[i*10 +2].boutonCarre () ; 
    BTf[i*10 +3].boutonSonPetit () ; 
    BTf[i*10 +4].boutonAction () ;     
    PVector pos = new PVector (posWidthBTf[i*10 +2], posHeightBTf[i*10 +1] +10) ;
    PVector size = new PVector (20, 30) ;
    rolloverInfoVignette(pos, size, i, 2) ;
  }
}

//GROUP THREE
public void buttonDrawGroupThree() {
    for( int i = 1 ; i <= numGroup[3] ; i++ ) {
    BTYf[i*10 +1].boutonVignette(vignette_OFF_in_typography, vignette_OFF_out_typography, vignette_ON_in_typography, vignette_ON_out_typography, i) ; 
    BTYf[i*10 +2].boutonCarre () ; 
    BTYf[i*10 +3].boutonSonPetit () ; 
    BTYf[i*10 +4].boutonAction () ; 
    PVector pos = new PVector (posWidthBTYf[i*10 +2], posHeightBTYf[i*10 +1] +10) ;
    PVector size = new PVector (20, 30) ;
    rolloverInfoVignette(pos, size, i, 3) ;
  }
}



public void buttonCheckDraw() {
  EtatBackgroundButton = buttonBackground.getEtatBoutonCarre() ;
  //LIGHT ONE
  EtatLightOneButton = buttonLightOne.getEtatBoutonCarre() ;
  EtatLightOneAction = buttonLightOneAction.getEtatBoutonCarre() ;
  // LIGHT TWO
  EtatLightTwoButton = buttonLightTwo.getEtatBoutonCarre() ;
  EtatLightTwoAction = buttonLightTwoAction.getEtatBoutonCarre() ;
  //SOUND
  EtatBbeat = Bbeat.getEtatBoutonCarre() ;
  EtatBkick = Bkick.getEtatBoutonCarre() ;
  EtatBsnare = Bsnare.getEtatBoutonCarre() ;
  EtatBhat = Bhat.getEtatBoutonCarre() ;
  //Check position of button
  EtatMidiButton = BOmidi.getEtatBoutonCarre() ;
  EtatCurtainButton = BOcurtain.getEtatBoutonCarre() ;


  //Statement button, if are OFF or ON
  for(int i = 1 ; i < numGroupSlider ; i++) {
    int num = numButton[i] +10 ;
    for( int j = 11 ; j < num ; j++) {
      if(numGroup[1] > 0 && i == 1 ) EtatBOf[j-10] = BOf[j].getEtatBoutonCarre() ;
      if(numGroup[2] > 0 && i == 2 ) EtatBTf[j-10] = BTf[j].getEtatBoutonCarre() ;
      if(numGroup[3] > 0 && i == 3 ) EtatBTYf[j-10] = BTYf[j].getEtatBoutonCarre() ;
    }
  }

}



//ANNEXE VOID
//ROLLOVER vignette
//show image
public void rolloverVignette ( int posX, int posY , int hauteur, int largeur, int numero, int posXimage, int posYimage) {
  if (mouseX > posX && mouseX < (largeur + posX ) && mouseY > posY - 10 && mouseY <  (hauteur + posY) -20 ) { 
    image(vignette[numero],posXimage , posYimage ) ;
  }
}

//show info
public void rolloverInfoVignette(PVector pos, PVector size, int IDorder, int IDfamily) {
  if (mouseX > pos.x && mouseX < (size.x + pos.x ) && mouseY > pos.y - 10 && mouseY <  (size.y + pos.y) -20 ) {
    PVector fontPos = new PVector(-10, -20 ) ;
    
    for ( int i = 1 ; i<numGroupSlider ; i++) {
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
  int whichOne = 0 ;
  int whichLine = 0 ;
  int num = objectList.getRowCount() ;
  for ( int j = 0 ; j < num ; j++) {
    TableRow lookFor = objectList.getRow(j);
    int ID = lookFor.getInt("ID") ;
    if ( ID == IDorder ) {
      whichOne = ID ;
      whichLine = j ;
    }
  }
  TableRow displayInfo = objectList.getRow(whichLine) ;
  String NameObj = displayInfo.getString("Name") ;
  String AuthorObj = displayInfo.getString("Author") ;
  String VersionObj = displayInfo.getString("Version") ;
  String PackObj = displayInfo.getString("Pack") ;    
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
public void fondReglette ( int posX, int posY, int hauteur, int largeur, int couleur ) {
  float hx ;
  hx = hauteur ;
  fill ( couleur ) ;
  rect ( posX  , posY - (hx /2.0f )  , largeur , hauteur ) ;
}

//hue
public void fondRegletteCouleur ( int posX, int posY, int hauteur, int largeur ) {
  pushMatrix () ;
  translate (posX , posY-(hauteur/2) ) ;
  for ( int i=0 ; i < largeur ; i++ ) {
    for ( int j=0 ; j <=hauteur ; j++ ) {
      float cr = map(i, 0, largeur, 0, 360 ) ;
      fill (cr, 100, 100) ;
      rect ( i, j, 1,1 ) ;
    }
  }
  popMatrix() ;
}

//saturation
public void fondRegletteSaturation ( int posX, int posY, int hauteur, int largeur, float couleur, float s, float d ) {
  pushMatrix () ;
  translate (posX , posY-(hauteur/2) ) ;
  for ( int i=0 ; i < largeur ; i++ ) {
    for ( int j=0 ; j <=hauteur ; j++ ) {
      float cr = map(i, 0, largeur, 0, 100 ) ;
      float coul = map(couleur, 0, largeur, 0, 360 ) ;
      float sat = map(s, 0, largeur, 0, 100 ) ;
      float dens = map(d, 0, largeur, 0, 100 ) ;
      fill (coul, cr, dens) ;
      rect ( i, j, 1,1 ) ;
    }
  }
  popMatrix() ;
}

//density
public void fondRegletteDensite ( int posX, int posY, int hauteur, int largeur, float couleur, float s, float d ) {
  pushMatrix () ;
  translate (posX , posY-(hauteur/2) ) ;
  for ( int i=0 ; i < largeur ; i++ ) {
    for ( int j=0 ; j <=hauteur ; j++ ) {
      float cr = map(i, 0, largeur, 0, 100 ) ;
      float coul = map(couleur, 0, largeur, 0, 360 ) ;
      float sat = map(s, 0, largeur, 0, 100 ) ;
      float dens = map(d, 0, largeur, 0, 100 ) ;
      fill (coul, sat, cr) ;
      rect ( i, j, 1,1 ) ;
    }
  }
  popMatrix() ;
}






public void dropdownSetup() {
  //load the external list  for each mode and split to read in the interface
  for (int i = 0 ; i<objectList.getRowCount() ; i++) {
    TableRow row = objectList.getRow(i);
    modeListRomanesco [row.getInt("ID")] = row.getString("Mode"); 
  }
  //typography
  String pList [] = loadStrings(sketchPath("")+"preferences/Font/fontList.txt") ;
  String policeList = join(pList, "") ;
  policeDropdownList = split(policeList, "/") ;
  
  //SHADER backgorund dropdown
  ///////////////
  posDropdownShaderBG = new PVector(posButtonShaderBG.x, posButtonShaderBG.y, 0.1f)  ; // x y is pos anz z is marge between the dropdown and the header
  sizeDropdownShaderBG = new PVector (75, 13, 15 ) ;
  PVector posTextDropdownShaderBG = new PVector(3, 10)  ;
  dropdownShaderBG = new Dropdown("Shader background", shaderBackgroundName, posDropdownShaderBG, sizeDropdownShaderBG, posTextDropdownShaderBG, colorBG, colorBoxIn, colorBoxOut, colorBoxText, sizeTexteInterface) ;
  
  
  //FONT dropdown
  ///////////////
  posDropdownFont = new PVector(posButtonFont.x, posButtonFont.y, 0.1f)  ; // x y is pos anz z is marge between the dropdown and the header
  sizeDropdownFont = new PVector (75, 13, 15 ) ;
  PVector posTextDropdownTypo = new PVector(3, 10)  ;
  dropdownFont = new Dropdown("Font", policeDropdownList,   posDropdownFont , sizeDropdownFont, posTextDropdownTypo, colorBG, colorBoxIn, colorBoxOut, colorBoxText, sizeTexteInterface) ;
  
  
  
  //MODE Dropdown
  ///////////////
  //common param
  sizeDropdownMode = new PVector (20, 10, 9 ) ;
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
      dropdown[i] = new Dropdown("M", listDropdown, posDropdown[i], sizeDropdownMode, posTextDropdown, colorBG, colorBoxIn, colorBoxOut, colorBoxText, sizeTexteInterface) ;
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
  dropdownShaderBG() ;
  dropdownFontDraw() ;
  // check the activity o the dropdown
  if(dropdownActivityCount > 0 ) dropdownActivity = true ; else dropdownActivity = false ;
  dropdownActivityCount = 0 ;
}
// END MAIN

// SHADER Background
public void dropdownShaderBG() {
  dropdownShaderBG.dropdownUpdate(FuturaStencil_10, textInterface);
  if (dropdownOpen) dropdownActivityCount = +1 ;
  margeAroundDropdown = sizeDropdownFont.y  ;
  //give the size of menu recalculate with the size of the word inside
  PVector newSizeFont = dropdownShaderBG.sizeDropdownMenu() ;
  totalSizeDropdown = new PVector ( newSizeFont.x +(margeAroundDropdown *1.5f), sizeDropdownShaderBG.y *(sizeDropdownShaderBG.z +1) +margeAroundDropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  newPosDropdown = new PVector (posDropdownShaderBG.x -margeAroundDropdown, posDropdownShaderBG.y) ;
  if (!insideRect(newPosDropdown, totalSizeDropdown)) dropdownShaderBG.locked = false ;
  // display the selection
  if(!dropdownShaderBG.locked) {
    textFont(FuturaStencil_10) ;
    EtatShaderBG = dropdownShaderBG.getSelection() ;
    text(shaderBackgroundName[EtatShaderBG], posDropdownShaderBG.x +3 , posDropdownShaderBG.y +22) ;
    if (dropdownShaderBG.getSelection() != 0 ) text("by " +shaderBackgroundAuthor[dropdownShaderBG.getSelection()], posDropdownShaderBG.x +3 , posDropdownShaderBG.y +32) ;
  }
}

// FONT
public void dropdownFontDraw() {
  dropdownFont.dropdownUpdate(FuturaStencil_10, textInterface);
  if (dropdownOpen) dropdownActivityCount = +1 ;
  margeAroundDropdown = sizeDropdownFont.y  ;
  //give the size of menu recalculate with the size of the word inside
  PVector newSizeFont = dropdownFont.sizeDropdownMenu() ;
  totalSizeDropdown = new PVector ( newSizeFont.x +(margeAroundDropdown *1.5f), sizeDropdownFont.y *(sizeDropdownFont.z +1) +margeAroundDropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  newPosDropdown = new PVector (posDropdownFont.x -margeAroundDropdown, posDropdownFont.y) ;
  if (!insideRect(newPosDropdown, totalSizeDropdown)) dropdownFont.locked = false ;
  //give the value for the save
  saveR [7] = PApplet.parseByte(dropdownFont.getSelection() +1) ;
  // display the selection
  textFont(FuturaStencil_10) ;
  text(policeDropdownList[dropdownFont.getSelection()], posDropdownFont.x +35 , posDropdownFont.y +10) ;
}

// OBJECT
public void checkTheDropdownDrawObject( int start, int end ) {
  for ( int i = start ; i < end ; i ++ ) {
    if(modeListRomanesco[i] != null ) {
      String m [] = split(modeListRomanesco[i], "/") ;
      if ( m.length > 1) {
        dropdown[i].dropdownUpdate(FuturaStencil_10, textInterface);
        if (dropdownOpen) dropdownActivityCount = +1 ;
        margeAroundDropdown = sizeDropdownMode.y  ;
        //give the size of menu recalculate with the size of the word inside
        PVector newSizeModeTypo = dropdown[i].sizeDropdownMenu() ;
        totalSizeDropdown = new PVector ( newSizeModeTypo.x + (margeAroundDropdown *1.5f) , sizeDropdownMode.y * (sizeDropdownMode.z +1)  + margeAroundDropdown   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
         //new pos to include the slider
        newPosDropdown = new PVector ( posDropdown[i].x - margeAroundDropdown  , posDropdown[i].y ) ;
        if ( !insideRect(newPosDropdown, totalSizeDropdown) ) {
          dropdown[i].locked = false;
        }
      }
      if (dropdown[i].getSelection() > -1 && m.length > 1 ) {
        textFont(FuturaStencil_10) ;
        text(dropdown[i].getSelection() +1, posDropdown[i].x +12 , posDropdown[i].y +8) ;
      }
    }
  }
}
//END DROPDOWN DRAW



//MOUSEPRESSED
public void dropdownMousepressed() {
  checkDropdownShaderBG() ;
  checkDropdownFont() ;
  // group One
  checkTheDropdownObjectMousepressed(startLoopObject, endLoopObject ) ;
  // group Two
  checkTheDropdownObjectMousepressed(startLoopTexture, endLoopTexture ) ;
  //group one
  checkTheDropdownObjectMousepressed(startLoopTypo, endLoopTypo ) ;
}
// END MAIN


public void checkDropdownShaderBG() {
  if (dropdownShaderBG != null) {
    if (insideRect(posDropdownShaderBG, sizeDropdownShaderBG) && !dropdownShaderBG.locked  ) {
      dropdownShaderBG.locked = true;
    } else if (dropdownShaderBG.locked) {
      float newWidthDropdown = dropdownShaderBG.sizeDropdownMenu().x ;
      int line = dropdownShaderBG.selectDropdownLine(newWidthDropdown);
      if (line > -1 ) {
        dropdownShaderBG.whichDropdownLine(line);
        //to close the dropdown
        dropdownShaderBG.locked = false;        
      } 
    }
  }
}


public void checkDropdownFont() {
  if (dropdownFont != null) {
    if (insideRect(posDropdownFont, sizeDropdownFont) && !dropdownFont.locked  ) {
      dropdownFont.locked = true;
    } else if (dropdownFont.locked) {
      float newWidthDropdown = dropdownFont.sizeDropdownMenu().x ;
      int line = dropdownFont.selectDropdownLine(newWidthDropdown);
      if (line > -1 ) {
        dropdownFont.whichDropdownLine(line);
        //to close the dropdown
        dropdownFont.locked = false;        
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
        float newWidthDropdown = dropdown[i].sizeDropdownMenu().x ;
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
int sizeTexteInterface = 14 ;

public PFont 
      //controleur font
      police, textInterface,
      EmigreEight, FuturaStencil_20, FuturaStencil_10,

      
      //sc\u00e8ne Font
      AmericanTypewriter, AmericanTypewriterBold,
      Banco, 
      ContainerRegular, Cinquenta,
      Diesel, 
      DinRegular, DinBold,
      EastBloc,
      FetteFraktur, FuturaStencil,
      Juanita, JuanitaOutline,
      Komikahuna,
      Mesquite,
      Minion, MinionBold,
      NanumBrush, 
      Rosewood,
      TheHardwayRMX,
      TokyoOne, TokyoOneSolid ;
      
      
//SETUP
public void fontSetup() {
  //controleur Font
  String fontPathVLW = sketchPath("")+"preferences/Font/typoVLW/" ;
  EmigreEight = loadFont (fontPathVLW+"EmigreEight-14.vlw") ;
  FuturaStencil_20 = loadFont(fontPathVLW+"FuturaStencilICG-20.vlw");
  FuturaStencil_10 = loadFont(fontPathVLW+"FuturaStencilICG-10.vlw");
  //Sc\u00e8ne Font  
  AmericanTypewriter=loadFont       (fontPathVLW+"AmericanTypewriter-96.vlw");
  AmericanTypewriterBold=loadFont   (fontPathVLW+"AmericanTypewriter-Bold-96.vlw");
  Banco=loadFont                    (fontPathVLW+"BancoITCStd-Heavy-96.vlw");
  Cinquenta=loadFont                (fontPathVLW+"CinquentaMilMeticais-96.vlw");
  ContainerRegular=loadFont         (fontPathVLW+"Container-Regular-96.vlw");
  Diesel=loadFont                   (fontPathVLW+"Diesel-96.vlw");
  DinRegular=loadFont               (fontPathVLW+"DIN-Regular-96.vlw");

  DinBold=loadFont                  (fontPathVLW+"DIN-Bold-96.vlw");
  EastBloc=loadFont                 (fontPathVLW+"EastBlocICGClosed-96.vlw");
  FuturaStencil=loadFont            (fontPathVLW+"FuturaStencilICG-96.vlw");
  FetteFraktur=loadFont             (fontPathVLW+"FetteFraktur-96.vlw");
  JuanitaOutline=loadFont           (fontPathVLW+"JuanitaDecoITCStd-96.vlw");
  Komikahuna=loadFont               (fontPathVLW+"Komikahuna-96.vlw");
  Mesquite=loadFont                (fontPathVLW+"MesquiteStd-96.vlw");
  Minion=loadFont                   (fontPathVLW+"MinionPro-Regular-96.vlw");
  MinionBold=loadFont               (fontPathVLW+"MinionPro-Bold-96.vlw");
  NanumBrush=loadFont              (fontPathVLW+"NanumBrush-96.vlw");
  Rosewood=loadFont                (fontPathVLW+"RosewoodStd-Regular-96.vlw");
  TheHardwayRMX=loadFont            (fontPathVLW+"3theHardwayRMX-96.vlw");
  TokyoOne=loadFont                (fontPathVLW+"Tokyo-One-96.vlw");
  
  //Typo for the interface
  textInterface = EmigreEight ;
  


}
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
  int[] dataIntGlobal = new int[numSliderGroupZero] ;
  for ( int i = 1   ; i < numSliderGroupZero-1 ; i++) { 
    dataIntGlobal[i-1] = floor(valueSlider[i]) ; 
  }
  toPreScene[4] = joinIntToString(dataIntGlobal) ;
  //float value slider obj
  int[] dataIntObj = new int[numSliderGroupOne] ;
  for ( int i = 101   ; i < 101+numSliderGroupOne ; i++) { dataIntObj[i-101] = floor(valueSlider[i]) ; }
  toPreScene[5] = joinIntToString(dataIntObj);
  //float value slider tex
  int[] dataIntTex = new int[numSliderGroupTwo] ;
  for ( int i = 201   ; i < 201+numSliderGroupTwo ; i++) { dataIntTex[i-201] = floor(valueSlider[i]) ; }
  toPreScene[6] = joinIntToString(dataIntTex) ;
  //float value slider typo
  int[] dataIntTypo = new int[numSliderGroupThree] ;
  for ( int i = 301   ; i < 301+numSliderGroupThree ; i++) { dataIntTypo[i-301] = floor(valueSlider[i]) ; }
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
  
  valueButtonGlobal[12] = EtatShaderBG ;

 
  
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
  





  

//LOAD PICTURE VIGNETTE

int numVignette ;

//END GLOBAL

//SETUP
public void loadSetup() {
  loadR = loadBytes(sketchPath("")+"preferences/MidiSetting/defaultSetting.dat");
  //load data object
  buildLibrary() ;
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
int [][] objectLibraryOrder, objectID, objectGroup ;
String  [][] objectName , objectAuthor, objectVersion, objectPack, objectRender, objectLoadName ;
boolean [][] objectClassic, objectP2D, objectP3D ;
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
int EtatBOf[], EtatBTf[], EtatBTYf[], EtatBIf[] ;


//////////
//DROPDOWN
int startLoopObject, endLoopObject, startLoopTexture, endLoopTexture, startLoopTypo, endLoopTypo ;
//GLOBAL
Dropdown dropdown[], dropdownFont, dropdownShaderBG  ;

PVector posDropdownFont, posDropdownShaderBG, posDropdown[] ;
PVector sizeDropdownFont, sizeDropdownShaderBG, sizeDropdownMode ;
PVector posTextDropdown = new PVector(2, 8)  ;

PVector totalSizeDropdown = new PVector () ;
PVector newPosDropdown = new PVector () ;

String [] modeListRomanesco, policeDropdownList, listDropdown, listDropdownShaderBG;

float margeAroundDropdown ;


//SETUP
 
//////////////////////////////////


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
  int [] num = new int[numGroupSlider] ;
  for ( int i = 0 ; i<num.length ; i++) {
    num[i] = numGroup[i] ;
  }
  num = sort(num) ;
  int numMaxObj = num[num.length-1] +1 ;
  
  objectLibraryOrder = new int [numGroupSlider][numMaxObj] ;
  objectID = new int [numGroupSlider][numMaxObj] ;
  objectGroup = new int [numGroupSlider][numMaxObj] ;
  objectName = new String [numGroupSlider][numMaxObj] ;
  objectAuthor = new String [numGroupSlider][numMaxObj] ;
  objectVersion = new String [numGroupSlider][numMaxObj] ;
  objectPack = new String [numGroupSlider][numMaxObj] ;
  objectRender = new String [numGroupSlider][numMaxObj] ;
  objectLoadName = new String [numGroupSlider][numMaxObj] ;
  objectClassic = new boolean [numGroupSlider][numMaxObj] ;
  objectP2D = new boolean [numGroupSlider][numMaxObj] ;
  objectP3D = new boolean [numGroupSlider][numMaxObj] ;
}



public void initVarButton() {
  numButton = new int[numGroupSlider] ;
  
  numButton[0] = 13 ;
  for (int i = 1 ; i < numGroupSlider ; i++ ) {
    numButton[i] = numGroup[i]*10 ;
    numButtonTotalObjects += numGroup[i] ;
  }

  numDropdown = numGroup[0] +1 ; // add one for the dropdownmenu
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
  int libraryRank = 0 ;
  int numObjByGroup = 0 ;
  for (int i = 1 ; i < numGroupSlider ; i++) {
    if ( i == 1 ) numObjByGroup = numGroup[i] ;
    if ( i == 2 ) numObjByGroup = numGroup[i] ;
    if ( i == 3 ) numObjByGroup = numGroup[i] ;
    for ( int j = 1 ; j <= numObjByGroup ; j++) {
      libraryRank += 1 ;
      TableRow row = objectList.getRow(libraryRank-1);
      objectLibraryOrder [i][j] = row.getInt("Library Order") ;
      objectID [i][j] = row.getInt("ID") ;
      objectGroup[i][j] = row.getInt("Group");
      objectPack[i][j] = row.getString("Pack");
      objectRender[i][j] = row.getString("Render");
      objectAuthor[i][j] = row.getString("Author");
      objectVersion[i][j] = row.getString("Version");
      objectLoadName[i][j] = row.getString("Class name");
      objectName[i][j] = row.getString("Name");
    }
  }
}



public void numByGroup() {
  numGroup  = new int[numGroupSlider] ;
  for (TableRow row : objectList.rows()) {
    int objectGroup = row.getInt("Group");
    for (int i = 0 ; i < numSlider ;i++) {
      if (objectGroup == i) numGroup[i] += 1 ;
    }
  }
  //give the num total of objects
  numGroup[0] = numGroup[1] +numGroup[2] +numGroup[3] ;
}
// END BUILD LIBRARY
////////////////////








//DRAW
public void OpenCloseSave() {
  //raccourcit clavier, 
  ////////  propl\u00e8me : apr\u00e8s un CTRL + "touche", il n'y a plus besoin du CTRL pour faire fonctionner le tout....
  clavier[keyCode] = true;
  if(checkClavier(CONTROL ) && checkClavier(KeyEvent.VK_S) ) { 
    selectOutput("Sauvegarde R\u00e9glette", "sauvegardeReglette");
    clavier[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
  if(checkClavier(CONTROL ) && checkClavier(KeyEvent.VK_O) ) { 
    selectInput("Chargement R\u00e9glette", "chargementReglette"); // ("display info in the window" , "name of the void calling" )
    clavier[keyCode] = false;   // 
  }
}


//////
public void sauvegardeReglette(File selection) {
  // opens file chooser
  String sauvegardeCheminReglette = selection.getAbsolutePath() ;
  
  if (selection != null) {
    if (!sauvegardeCheminReglette.endsWith(".dat")) sauvegardeCheminReglette += ".dat";
    saveBytes(sauvegardeCheminReglette, saveR);
  } else {
    println("Aucune sauvegarde") ;
  }
}


//////
public void chargementReglette(File selection) {
  // opens file chooser
  String chargementCheminReglette = selection.getAbsolutePath();
  
  if (selection != null) {
    loadSliderPos = true ;
    loadR = loadBytes(chargementCheminReglette);
  } else {
    loadSliderPos = false ;
  }
}







//LOAD text Interface
Table textGUI;
int numCol = 15 ;
String[] genTxtGUI = new String[numCol] ;
String[] objTxtGUIone = new String[numCol] ;
String[] objTxtGUItwo = new String[numCol] ;
String[] objTxtGUIthree = new String[numCol] ;
String[] textureTxtGUIone = new String[numCol] ;
String[] textureTxtGUItwo = new String[numCol] ;
String[] textureTxtGUIthree = new String[numCol] ;
String[] typoTxtGUIone = new String[numCol] ;
String[] typoTxtGUItwo = new String[numCol] ;
String[] typoTxtGUIthree = new String[numCol] ;

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
      if ( i == 1 ) objTxtGUIone[j] = row[i].getString("Column "+numCol) ;
      if ( i == 2 ) objTxtGUItwo[j] = row[i].getString("Column "+numCol) ;
      if ( i == 3 ) objTxtGUIthree[j] = row[i].getString("Column "+numCol) ;
      if ( i == 4 ) textureTxtGUIone[j] = row[i].getString("Column "+numCol) ;
      if ( i == 5 ) textureTxtGUItwo[j] = row[i].getString("Column "+numCol) ;
      if ( i == 6 ) textureTxtGUIthree[j] = row[i].getString("Column "+numCol) ;
      if ( i == 7 ) typoTxtGUIone[j] = row[i].getString("Column "+numCol) ;
      if ( i == 8 ) typoTxtGUItwo[j ] = row[i].getString("Column "+numCol) ;
      if ( i == 9 ) typoTxtGUIthree[j] = row[i].getString("Column "+numCol) ;
    }
  }
}





//IMPORT VIGNETTE
public void importPicButtonSetup() {
  //load button vignette GUI general
  for(int j=0 ;  j<bouton.length ; j++ ) bouton[j] = loadImage ("bouton/bouton"+j+".png") ;
  
  //load simple vignette
  
  numVignette = numGroup[1] +1  ;
  vignette_OFF_in_simple = new PImage[numVignette] ;
  vignette_OFF_out_simple = new PImage[numVignette] ;
  vignette_ON_in_simple = new PImage[numVignette] ;
  vignette_ON_out_simple = new PImage[numVignette] ;

  for(int i=0 ;  i<numVignette ; i++ )  {
    vignette_OFF_in_simple[i] = loadImage ("vignette_simple/vignette_OFF_in_simple_"+i+".png") ;
    vignette_OFF_out_simple[i] = loadImage ("vignette_simple/vignette_OFF_out_simple_"+i+".png") ;
    vignette_ON_in_simple[i] = loadImage ("vignette_simple/vignette_ON_in_simple_"+i+".png") ;
    vignette_ON_out_simple[i] = loadImage ("vignette_simple/vignette_ON_out_simple_"+i+".png") ;
  }
  //load texture vignette
  numVignette = numGroup[2] +1  ;
  vignette_OFF_in_texture = new PImage[numVignette] ;
  vignette_OFF_out_texture = new PImage[numVignette] ;
  vignette_ON_in_texture = new PImage[numVignette] ;
  vignette_ON_out_texture = new PImage[numVignette] ;

  for(int i=0 ;  i<numVignette ; i++ )  {
    vignette_OFF_in_texture[i] = loadImage ("vignette_texture/vignette_OFF_in_texture_"+i+".png") ;
    vignette_OFF_out_texture[i] = loadImage ("vignette_texture/vignette_OFF_out_texture_"+i+".png") ;
    vignette_ON_in_texture[i] = loadImage ("vignette_texture/vignette_ON_in_texture_"+i+".png") ;
    vignette_ON_out_texture[i] = loadImage ("vignette_texture/vignette_ON_out_texture_"+i+".png") ;
  }
  //load typography vignette
  numVignette = numGroup[3] +1  ;
  vignette_OFF_in_typography = new PImage[numVignette] ;
  vignette_OFF_out_typography = new PImage[numVignette] ;
  vignette_ON_in_typography = new PImage[numVignette] ;
  vignette_ON_out_typography = new PImage[numVignette] ;

  for(int i=0 ;  i<numVignette ; i++ )  {
    vignette_OFF_in_typography[i] = loadImage ("vignette_typography/vignette_OFF_in_typography_"+i+".png") ;
    vignette_OFF_out_typography[i] = loadImage ("vignette_typography/vignette_OFF_out_typography_"+i+".png") ;
    vignette_ON_in_typography[i] = loadImage ("vignette_typography/vignette_ON_in_typography_"+i+".png") ;
    vignette_ON_out_typography[i] = loadImage ("vignette_typography/vignette_ON_out_typography_"+i+".png") ;
  }
}
class Bouton {
  int couleurBouton, couleurONoffCarre, couleurONoffCercle ;
  int etatBoutonCercle, etatBoutonCarre ;
  PVector pos = new PVector() ; 
  PVector size = new PVector() ;
  
  boolean dedansBoutonCercle = false ;
  boolean JouerBoutonCercle = false ;
  boolean JouerBoutonCarre = false ;  
  boolean dedansBoutonCarre = false ;
  
  //Constructor
  //simple
  Bouton () {}
  //complexe
  Bouton (int posWidth, int posHeight, int widthButton, int heightButton) {
    pos.x = posWidth ;
    pos.y = posHeight ;
    size.x = widthButton ;
    size.y = heightButton ;
    pos.x =  posWidth ; pos.y = posHeight ; size.x = widthButton ; size.y = heightButton ;
  }
  Bouton ( PVector pos, PVector size ) {
    this.pos = pos.get() ;
    this.size = size.get() ;
  }
  

  
  
  
  //ROLLOVER
  //rectangle
  float newSize = 1  ;
  //
  public boolean detectionCarre() {
    if (size.y < 10 ) newSize = size.y *1.8f ; 
    else if (size.y >= 10 && size.y < 20  ) newSize = size.y *1.2f ;  
    else if (size.y >= 20 ) newSize = size.y ;
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y  && mouseY < pos.y + newSize ) { 
      return true ; 
    } else { 
      return false ; 
    }
  }
  // with correction for the font position
  public boolean detectionCarre(int correction) {
    if (size.y < 10 ) newSize = size.y *1.8f ; 
    else if (size.y >= 10 && size.y < 20  ) newSize = size.y *1.2f ;  
    else if (size.y >= 20 ) newSize = size.y ;
    
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y -correction  && mouseY < pos.y +newSize -correction) { 
      return true ; 
    } else { 
      return false ; 
    }
  }
  //ellipse
  public boolean detectionCercle() {
    float disX = pos.x -mouseX ; 
    float disY = pos.y -mouseY  ; 
    if (sqrt(sq(disX) + sq(disY)) < size.x/2 ) return true ; else return false ; 
  } 
  
  
  
  //CLIC
  public void mousePressedText() {
    //rect
    if (detectionCarre((int)size.y) ) {
      dedansBoutonCarre = true ;
      if ( JouerBoutonCarre ) {
        JouerBoutonCarre = false ;
        etatBoutonCarre = 0 ;
      } else {
        JouerBoutonCarre = true ;
        etatBoutonCarre = 1 ; 
      }
    }
  }
  //
  public void mousePressed() {
    //rect
    if (detectionCarre() ) {
      dedansBoutonCarre = true ;
      if (JouerBoutonCarre) {
        JouerBoutonCarre = false ;
        etatBoutonCarre = 0 ;
      } else {
        JouerBoutonCarre = true ;
        etatBoutonCarre = 1 ; 
      }
    }
    //ellipse
    if (detectionCercle()) {
      dedansBoutonCercle = true ;
      if (JouerBoutonCercle) {
        JouerBoutonCercle = false ;
        etatBoutonCercle = 0 ;
      } else {
        JouerBoutonCercle = true ;
        etatBoutonCercle = 1 ;
      }
    }
  }
  /*
  void mouseReleased () {
    //rect
    if (detectionCarre() ) {
      dedansBoutonCarre = true ;
      if ( JouerBoutonCarre ) {
        JouerBoutonCarre = false ;
        etatBoutonCarre = 0 ;
      } else {
        JouerBoutonCarre = true ;
        etatBoutonCarre = 1 ; 
      }
    }
    //ellipse
    if ( detectionCercle() ) {
      dedansBoutonCercle = true ;
      if ( JouerBoutonCercle ) {
        JouerBoutonCercle = false ;
        etatBoutonCercle = 0 ;
      } else {
        JouerBoutonCercle = true ;
        etatBoutonCercle = 1 ;
      }
    }
  } 
  */
}


////////
//BUTTON
class Simple extends Bouton {
  int cBINonBO, cBOUTonBO, cBINoffBO, cBOUToffBO, cBEinBO, cBEoutBO ;
  
  //CONSTRUCTOR
  Simple(int posWidth, int posHeight, int widthButton, int heightButton) {
    super(posWidth, posHeight, widthButton, heightButton) ;
  }
  
  //
  Simple (int posWidth, int posHeight, int widthButton, int heightButton, 
          int BoutonINonBO, int BoutonOUTonBO, int BoutonINoffBO, int BoutonOUToffBO,
           int BoutonEnsembleINBO, int BoutonEnsembleOUTBO)                  
 {
   super(posWidth, posHeight,  widthButton, heightButton) ;
   cBINonBO = BoutonINonBO ; cBOUTonBO = BoutonOUTonBO ; cBINoffBO = BoutonINoffBO ; cBOUToffBO = BoutonOUToffBO ;
   cBEinBO = BoutonEnsembleINBO ; cBEoutBO = BoutonEnsembleOUTBO ;
 }
 
 Simple (PVector pos, PVector size, int BoutonINonBO, int BoutonOUTonBO, int BoutonINoffBO, int BoutonOUToffBO )  {
   super(pos, size) ;
   cBINonBO = BoutonINonBO ; cBOUTonBO = BoutonOUTonBO ; cBINoffBO = BoutonINoffBO ; cBOUToffBO = BoutonOUToffBO ;
 }
 
 
 
 //VOID
 public void boutonFond () {
   fill(couleurBouton) ;
   rect(pos.x, pos.y, size.x, size.y) ;
 }
 
 
 ////////////////
 //BUTTON CLASSIC
 
 ///Bouton carre
 public void boutonCarre () {
   strokeWeight (1) ;
   if (JouerBoutonCarre ) {
     stroke(vertTresFonce) ;
     if (detectionCarre() && !dropdownActivity) { 
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
     stroke(rougeTresFonce) ; 
     if (detectionCarre() && !dropdownActivity) {
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINoffBO ;
     } else {
       couleurONoffCarre = cBOUToffBO ;
     }
   }
   fill(couleurONoffCarre) ;
   rect(pos.x, pos.y, size.x, size.y) ;
   noStroke() ;
 }
 ////////////////////////////////////
 public void boutonCercle () {
   strokeWeight (1) ;
   if (JouerBoutonCercle ) {
     stroke(vertTresFonce) ;
     if ( detectionCercle() && !dropdownActivity) {
       dedansBoutonCercle = true ;
       couleurONoffCercle = cBINonBO ;
     } else {
       couleurONoffCercle = cBOUTonBO ;
     }
   } else {
     stroke(rougeTresFonce) ;
     if (detectionCercle() && !dropdownActivity) {
       dedansBoutonCercle = true ;
       couleurONoffCercle = cBINoffBO ;
     } else {
       couleurONoffCercle = cBOUToffBO ;
     }
   }
   fill(couleurONoffCercle) ;
   ellipse(pos.x, pos.y, size.x, size.x) ;
   noStroke() ;
 }
 


 
 
 //////////////
 //IMAGE BUTTON
 
 //VIGNETTE Button
 // vignette_OFF_in_simple, vignette_OFF_out_simple, vignette_ON_in_simple, vignette_ON_out_simple
 public void boutonVignette(PImage[] vignette_OFF_in, PImage[] vignette_OFF_out, PImage[] vignette_ON_in, PImage[] vignette_ON_out, int wichVignette) {
   
   if (JouerBoutonCarre ) {
     if (detectionCarre() && !dropdownActivity) {
       dedansBoutonCarre = true ;
       image(vignette_ON_in[wichVignette],pos.x, pos.y) ;
     } else {
       image(vignette_ON_out[wichVignette],pos.x, pos.y) ;
     }
   } else {
       if (detectionCarre() && !dropdownActivity) {
       dedansBoutonCarre = true ;
       image(vignette_OFF_in[wichVignette],pos.x, pos.y) ;
     } else {
       image(vignette_OFF_out[wichVignette],pos.x, pos.y) ;
     }
   }
 }
 
 
 //SOUND button
 public void boutonSonPetit () {
   if ( JouerBoutonCarre ) {
     if (detectionCarre() && !dropdownActivity) {
       //ON
       dedansBoutonCarre = true ;
       image(bouton[1],pos.x, pos.y ) ;
     } else {
       image(bouton[0],pos.x, pos.y ) ;
     }
   } else {
     //OFF
       if (detectionCarre() && !dropdownActivity) {
       dedansBoutonCarre = true ;
       image(bouton[3],pos.x, pos.y ) ;
     } else {
       image(bouton[2],pos.x, pos.y) ;
     }
   }
 }
 
 //ACTION Button
 public void boutonAction () {
   if ( JouerBoutonCarre ) {
     if (detectionCarre() && !dropdownActivity) {
       dedansBoutonCarre = true ;
       image(bouton[11],pos.x, pos.y) ;
     } else {
       image(bouton[10],pos.x, pos.y) ;
     }
   } else {
       if (detectionCarre() && !dropdownActivity) {
       dedansBoutonCarre = true ;
       image(bouton[13],pos.x, pos.y) ;
     } else {
       image(bouton[12],pos.x, pos.y) ;
     }
   }
 }
 
 ///BUTTON Texte
 public void boutonTexte(String s, int x, int y) {
   if (JouerBoutonCarre) {
     stroke(vertTresFonce) ;
     if ( detectionCarre() && !dropdownActivity) { 
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
      stroke(rougeTresFonce) ; 
     if ( detectionCarre() && !dropdownActivity) {
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINoffBO ;
     } else {
       couleurONoffCarre = cBOUToffBO ;
     }
   }

   fill(couleurONoffCarre) ;
   text(s, x, y) ;
 }
 
 public void boutonTexte(String s, PVector pos, PFont font, int sizeFont) {
   if (JouerBoutonCarre) {
     if (detectionCarre(sizeFont) && !dropdownActivity) {
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
     if (detectionCarre(sizeFont) && !dropdownActivity) {
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINoffBO ;
     } else {
       couleurONoffCarre = cBOUToffBO ;
     }
   }
   fill(couleurONoffCarre) ;
   textFont(font) ;
   textSize(sizeFont) ;
   text(s, pos.x, pos.y) ;
 }
 
 ////////////////////////////////////
 public void boutonCarreEcran (String s, PVector localpos) {
   strokeWeight (1) ;
   if ( JouerBoutonCarre ) {
     stroke(vertTresFonce) ;
     if (detectionCarre() && !dropdownActivity) { 
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
     stroke(rougeTresFonce) ; 
     if (detectionCarre() && !dropdownActivity) {
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINoffBO ;
     } else {
       couleurONoffCarre = cBOUToffBO ;
     }
   }

   fill(couleurONoffCarre) ;
   rect(pos.x, pos.y, size.x, size.y) ;
   fill(blanc) ;
   text(s, pos.x +localpos.x, pos.y + localpos.y) ;
   noStroke() ;
 }


//.........................................................................................
  public int getEtatBoutonCercle() { // nom de variable et () permet de r\u00e9cup\u00e9rer les donn\u00e9es d'un return
    return etatBoutonCercle ;
  }
  public int getEtatBoutonCarre() { // nom de variable et () permet de r\u00e9cup\u00e9rer les donn\u00e9es d'un return
    return etatBoutonCarre ;
  }
}
//
boolean dropdownOpen ; // use to indicate to indicate at the other button, they cannot be used when the user are on the dropdown menu

// CLASS
public class Dropdown {
  //Slider dropdown
  Slider sliderDropdown ;
  private PFont fontDropdown ;
  private PVector posSliderDropdown, sizeSliderDropdown, posMoletteDropdown, sizeMoletteDropdown, sizeBoxDropdownMenu ;
  //dropdown
  private int line = 0;
  private String listItem[] , title ;
  private boolean locked, slider ;
  private final int colorBG, boxIn, boxOut, colorText ;
  private PVector pos, size, posText;
  private float factorPos  ; // use to calculate the margin between the box
  private int sizeFont ;
  private int startingDropdown = 0 ;
  private int endingDropdown = 1 ;
  private int updateDropdown = 0 ; //for the slider update
  private float missing ;

  //CONSTRUCTOR
  public Dropdown(String title, String [] listItem, PVector pos, PVector size, PVector posText, int colorBG, int boxIn, int boxOut, int colorText, int sizeFont ) {
    //dropdown
    this.title = title ;
    this.listItem = listItem;
    this.pos = pos;
    this.posText = posText ;

    this.size = size; // header size
    this.sizeFont = sizeFont ;
    this.fontDropdown = fontDropdown ;
    this.colorBG = colorBG ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;
    this.colorText = colorText ;
    endingDropdown = PApplet.parseInt(size.z + 1) ;
    // security if the size of dropdown is superior of the item list
    if (endingDropdown > listItem.length ) endingDropdown = listItem.length ;
    // difference between the total list item and what is possible to display
    missing = listItem.length - endingDropdown  ;
   
    //size of the dropdow, for the bottom part
    sizeBoxDropdownMenu = new PVector (longestWord( listItem, 1, listItem.length ) *sizeFont *.46f, size.y) ; 
    
    
    //slider dropdown
    //condition to display the slider
    if ( listItem.length > endingDropdown  ) slider = true ; else slider = false ;
    
    if (slider) {
      sizeSliderDropdown = new PVector (  size.y / 2.0f, ((endingDropdown ) * size.y ) -pos.z) ;
      posSliderDropdown = new PVector( pos.x - sizeSliderDropdown.x - (pos.z *2.0f) , pos.y + size.y + (1.8f *pos.z) ) ;
      posMoletteDropdown = posSliderDropdown ;
      
      float factorSizeMolette = PApplet.parseFloat(listItem.length) / PApplet.parseFloat(endingDropdown -1 ) ;
  
      
      sizeMoletteDropdown =  new PVector ( sizeSliderDropdown.x, sizeSliderDropdown.y / factorSizeMolette) ;
      sliderDropdown = new Slider(posSliderDropdown, posMoletteDropdown, sizeSliderDropdown, sizeMoletteDropdown, colorBG, boxIn, boxOut ) ;
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
        renderBox(listItem[i], step++, sizeBoxDropdownMenu, dropdownFont);
        //dropdownActivity = true ;
        //Slider dropdown
        if (slider) {
          sliderDropdown.sliderUpdate() ;
          fill(colorBG) ;
          rect (posMoletteDropdown.x, pos.y, sizeMoletteDropdown.x, size.y ) ; 
        }
      }
    } else {
      //header rendering
      dropdownOpen = false ;
      titleWithoutBox(title, 1, size, titleFont);
    }
    //println("je ne suis plus l\u00e0 niveau deux") ;
    //dropdownActivity = false ;
  }


  //DISPLAY
  public void titleWithoutBox(String title, int step, PVector size, PFont font) {
    //update
    factorPos = step + pos.z -1 ;
    float yLevel = step == 1 ? pos.y  : (pos.y + (size.y * (factorPos )));
    PVector newPosDropdown = new PVector (pos.x, yLevel) ;
    if (insideRect(newPosDropdown, size)) fill(boxIn); else fill(boxOut ) ;
    //dropdownActivity = false ;
    textFont(font);
    text(title, pos.x +posText.x , yLevel +posText.y );
  }
  
  public void renderBox(String label, int step, PVector sizeBoxDropdown, PFont font) {
    //update
    factorPos = step + pos.z -1 ;
    float yLevel = step == 1 ? pos.y  : (pos.y + (sizeBoxDropdown.y * (factorPos )));
    PVector newPosDropdown = new PVector (pos.x, yLevel) ;
    if (insideRect(newPosDropdown, sizeBoxDropdown)) fill(boxIn); else fill(boxOut ) ;
    //display
    noStroke() ;
    rect(pos.x, yLevel , sizeBoxDropdown.x, sizeBoxDropdown.y );
    fill(colorText);
    textFont(font);
    textSize(sizeFont) ;
    text(label, pos.x +posText.x , yLevel +posText.y );
  }
  
  

  
  //RETURN
  //Check the dropdown when this one is open
  public int selectDropdownLine(float newWidth) {
    if(mouseX >= pos.x && mouseX <= pos.x + newWidth && mouseY >= pos.y && mouseY <= ((listItem.length+1) *size.y) +pos.y ) {
      //choice the line
      int line = floor( (mouseY - (pos.y +size.y )) / size.y ) + updateDropdown;
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
  //return the size of menu box, not header size
  public PVector sizeDropdownMenu() {
    return sizeBoxDropdownMenu ;
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
      noir, noirGris,
      blanc, blancGrisClair, blancGris,  
      gris, grisClair , grisFonce, grisNoir, 
      
      typoCourante, typoTitre,
      //bouton
      boutonOFFin, boutonOFFout, boutonONin, boutonONout,
      //for the dropdown
      colorBoxIn, colorBoxOut, colorBoxText, colorBG ;


//SETUP
public void colorSetup() {
   colorMode (HSB, 360,100,100 ) ; 
   blanc = color(0,0,95) ;            blancGrisClair = color( 0,0,85) ;  blancGris = color( 0,0,75) ; 
   grisClair = color(0,0, 65) ;       gris = color(0,0,50) ;             grisFonce = color(0,0,40)  ;     grisNoir = color(0,0,30) ;      
   noirGris = color (0,0,20) ;         noir = color (0,0,5) ;  
   vertClair = color (100,20,100) ;     vert = color(100,35,80) ;           vertFonce = color(100,100,50) ;     vertTresFonce = color(100,100,30) ;
   rougeTresFonce = color(10, 100, 50) ; rougeFonce = color (10, 100, 70) ;  rouge = color(10,100,100) ;           orange = color (35,100,100) ; 
   
   typoCourante = grisNoir ; typoTitre = noirGris ;
   boutonOFFin = orange ; boutonOFFout = rougeFonce ;
   boutonONin = vert ; boutonONout = vertFonce ;
   
   //dropdown
   colorBG = rougeTresFonce ;
   colorBoxIn =rouge ; 
   colorBoxOut = rougeFonce ;
   colorBoxText = blancGrisClair ;
}
//END COLOR



//DRAW
//////RETURN////////////
public boolean checkClavier(int c) {
  if (clavier.length >= c) {
    return clavier[c];  
  }
  return false;
}
////////VOID/////////////

////MIDI/////////////////
public void controllerIn(promidi.Controller controller, int device, int channel){
  numMidi = controller.getNumber();
  valMidi = controller.getValue();
}


class Slider
{
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
    rect(pos.x, pos.y, size.x, size.y ) ;
    
    //MOLETTE
    fill(boxOut) ;
    newPosMol = new PVector (posMol.x, posMol.y  ) ;
    rect(posMol.x, posMol.y, sizeMol.x, sizeMol.y ) ;
    
  }
  
  //Slider update with title
  public void sliderUpdate(String s, boolean t) {
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    if (t) {
      fill(colorText) ;
      textFont (p ) ;
      textSize (posText.z) ;
      text(s, posText.x, posText.y ) ;
    }
    //MOLETTE
    if (insideRect(newPosMol, sizeMol)) fill(boxIn); else fill(boxOut ) ;
    moletteUpdate() ;
    rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
  }
  //Slider update simple
  public void sliderUpdate() {
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    //MOLETTE
    if (insideRect(newPosMol, sizeMol)) fill(boxIn); else fill(boxOut ) ;
    moletteUpdate() ;
    rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
  }
  
  public void moletteUpdate() {
    if (locked (insideRect(newPosMol, sizeMol) )  ) molLocked = true ;
    if (!mousePressed)  molLocked = false ; 
      
    if ( molLocked ) {  
      if ( size.x >= size.y ) newPosMol.x = constrain(mouseX -(sizeMol.x / 2.0f ), posMin.x, posMax.x)  ; else newPosMol.y = constrain(mouseY -(sizeMol.y / 2.0f ), posMin.y, posMax.y) ;
    }
  }
  
  //RETURN
  public float getValue() {
    float value ;
    if ( size.x >= size.y ) value = map (newPosMol.x, posMin.x, posMax.x, 0,1) ; else value = map (newPosMol.y, posMin.y, posMax.y, 0,1) ;
    return value ;
  }
}
class RegletteHorizontale
{
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

  RegletteHorizontale (int xp, int yp, int LSlider, int HSlider, int s, int boutonOUT, int boutonIN, int reglette, int transparence, int pC, int IDmidi) {
    this.IDmidi = IDmidi ;
    longueurSlider = LSlider;   hauteurSlider = HSlider;              suivit = s;
    xpos = xp;          ypos = yp-hauteurSlider/2;
    float lh = PApplet.parseFloat(longueurSlider) ;
    
    //molette position
    spos = xpos + (pC / (100.0f + ( (11.0f/lh)*rapportDepart) ) * LSlider); 
    newspos = spos;
    
    sposMin = xpos;    sposMax = xpos + longueurSlider - hauteurSlider;
    bOUT = boutonOUT ;  bIN = boutonIN ; rglt = reglette   ; transp = transparence ;
    
  }
  
  //DISPLAY MOLETTE
  public void displayMolette(int cIn, int cOut, int colorOutline, PVector size) {
    fill(rglt, transp);
    if( xpos != 0 && ypos != 0) {
      rect(xpos, ypos, longueurSlider, hauteurSlider); 
      stroke(colorOutline) ; strokeWeight(size.z) ;
      if(dedans || locked) {
        fill(cIn);
        loadSliderPos = false ;
      } else {
        fill(cOut);
      }
      //display  
      rect(spos, ypos-3, size.x, size.y);
      // ellipse(spos +(size.y *.5), ypos-3 +(size.y *.5), size.y *1.2, size.y *1.2);
      noStroke() ;
    }   
  }


  

  
  public void update(int curseurX, int loadX ) {
    int NLX ;
    float NloadX ;
    float lh = PApplet.parseFloat(longueurSlider) ;
    NloadX = xpos + (loadX / (100.0f + ( (11.0f/lh)*rapportChargement) ) * longueurSlider);
    NLX = round(NloadX) ;
    // Choix entre le chargement des sauvegarde de position ou les coordonn\u00e9es de la souris
    if(loadSliderPos ) {
      posX = NLX ; 
    } else { 
      posX = curseurX ; 
    }
   
   if(dedans()) dedans = true ; else dedans = false ;
   if(mousePressed && dedans) locked = true ;
   if(!mousePressed) locked = false ;
   
   if(locked || loadSliderPos) {
      newspos = constrain(posX-hauteurSlider/2, sposMin, sposMax);
    }

    if(abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/suivit;
    }
  }

  public int constrain(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }
  
  // update position from midi controller
  public void updateMidi(int val) {
    //update the Midi position only if the Midi Button move
    if ( newValMidi != val ) { 
      newValMidi = val ; 
      newspos = map(val, 1, 127, sposMin, sposMax ) ;
      posX = newValMidi ; 
    }
    // val = map(val,1,128, 0, width ) ; 

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
    if(mouseX > spos && mouseX < spos+hauteurSlider &&
       mouseY > ypos && mouseY < ypos+hauteurSlider) {  
      return true;
    } else {
      return false;
    }
  }
  //return pos
  public float getPos() { // nom de variable et () permet de r\u00e9cup\u00e9rer les donn\u00e9es d'un return
    return (((spos-xpos)/longueurSlider)-0.004f) *111 ;
  }
}
//UTIL
//STRING LIST SORT
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
/*
Interface Control Stanislas Mar\u00e7ais
Web site Romanesco
http://romanescoproject.wordpress.com/
Web site Stanislas Mar\u00e7ais
http://stanislas-marcais.blogspot.fr/ 


Un grand Merci \u00e0 Laetitia, ma femme pour son soutient moral et financier pendant toutes ces semaines, ces mois de d\u00e9veloppement

Un Grand merci \u00e9galement \u00e0 la communaut\u00e9 Processing : 
Daniel Shiffman for the slider, 
Marius Waltz pour les saved Data, 

Mark Webster pour ses ateliers Processing Cities.
Nicopter et sa th\u00e9orie "Tout doit \u00eatre compris entre 0 et 1"

aux particpants du Forum Processing et Github qui ont pris le temps de r\u00e9pondre
Philo, AmnonP5, Datguy, R.Brauer pour les conseils via le Forum, 
*/
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Controleur_25" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
