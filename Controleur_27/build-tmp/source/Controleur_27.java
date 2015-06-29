import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.awt.event.KeyEvent; 
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

public class Controleur_27 extends PApplet {

  //////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.0.2 / version 27 / made with Processing 305 ///
//////////////////////////////////////////////////////////////////
/* 4.100 lines of code the 4th may !!!! */
String version = ("27") ;
String IAM = ("Controller") ;
String prettyVersion = ("1.0.2") ;
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
  sliderSettingVar() ;
  buttonSetup() ;
  dropdownSetup() ;
  constructorButton() ;
  constructorSlider() ;
  sendOSCsetup() ;
  settingDataFromSave() ;
}


public void draw() {
  /*
  for(int whichOne = 1 ; whichOne < 10 ;whichOne++) {
         sliderUpdate(whichOne) ;
         int whichGroup = 0 ;
    // sliderAdvancedDisplay(i, whichGroup) ;
           slider[whichOne].insideMin() ;
      slider[whichOne].updateMin() ;
  //  }
    // max molette
  //  if(!slider[whichOne].insideMin && !slider[whichOne].lockedMin) {
      slider[whichOne].insideMax() ;
      slider[whichOne].updateMax() ;
  }
  */
  
  frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Controller");
  // settingDataFromSave() ;
  structureDraw() ;
  checkSliderObject() ;
  checkImageFolder() ;
  checkFileTextFolder() ;
  initLiveData() ;
  textDraw() ;
  sliderDraw() ;
  buttonDraw() ;
  midiDraw() ;
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
  
    buttonBackground.mousePressedText() ;
        //LIGHT ONE
    buttonLightAmbient.mousePressedText() ;
    buttonLightAmbientAction.mousePressedText() ;
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
  midi_keyPressed() ;
  //OpenClose save
  shortCutsController() ;
}

//KEYRELEASED
public void keyReleased() { 
  keyboard[keyCode] = false;
}
//GLOBAL

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

MidiIO midiIO;
int sliderMidi, valMidi ;
int numMidi = -1 ;
boolean saveMidi ;
boolean selectMidi = false ;
//curtain
boolean curtainOpenClose ;
//GLOBAL

// Save Setting var
Vec5 [] infoSlider ; 
PVector [] infoButton ;

// slider mode display
int sliderModeDisplay = 0 ;


boolean[] keyboard = new boolean[526];
boolean loadSaveSetting = false ;
boolean ouvrirFichier = false ;

//LOAD PICTURE VIGNETTE
int numVignette ;

//ANNEXE
public void setting() {
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
public void shortCutsController() {
  keyboard[keyCode] = true;
  // slider display command
  if(checkKeyboard(CONTROL) && checkKeyboard(KeyEvent.VK_X) ) {
    sliderModeDisplay += 1 ;
    if(sliderModeDisplay > 2 ) sliderModeDisplay = 0 ;
  }

  // save Scene
  check_Keyboard_save_scene_CURRENT_path() ;
  check_Keyboard_save_scene_NEW_path() ;
  // save controller
  check_Keyboard_save_controller_CURRENT_path() ;
  check_Keyboard_save_controller_NEW_path() ;
  // load
  check_Keyboard_load_scene() ;
  check_Keyboard_load_controller() ;
}




// ANNEXE shortcut method
//////////////////////////

// SCENE
///////////////////
boolean load_Scene_Setting, save_Current_Scene_Setting, save_New_Scene_Setting ;
// Scene load
// CTRL + O
public void check_Keyboard_load_scene() {
  if(checkKeyboard(CONTROL) && !checkKeyboard(SHIFT) && checkKeyboard(KeyEvent.VK_O) ) { 
    load_Scene_Setting = true ;
    // println("load scene", load_Scene_Setting) ;
    keyboard[keyCode] = false;   //
    
  }
}

// Scene current save
// CTRL + S
public void check_Keyboard_save_scene_CURRENT_path() {
  if(checkKeyboard(CONTROL) && !checkKeyboard(SHIFT) && checkKeyboard(KeyEvent.VK_S) ) {
    save_Current_Scene_Setting = true ;
    //println("save scene on the current path",  save_Current_Scene_Setting) ;
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
   }
}
// Scene new save
// CTRL + SHIFT + S
public void check_Keyboard_save_scene_NEW_path() {
  if(checkKeyboard(CONTROL) && checkKeyboard(SHIFT) && checkKeyboard(KeyEvent.VK_S) ) {
    save_New_Scene_Setting = true ;
   //  println("save scene on a new path", save_New_Scene_Setting) ;
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
}








// CONTROLLER 
//////////////////
// Controller load

// CTRL + SHIFT + O
public void check_Keyboard_load_controller() {
  if(checkKeyboard(CONTROL) && checkKeyboard(SHIFT) && checkKeyboard(KeyEvent.VK_O) ) { 
    println("load controller") ;
    selectInput("Load setting controller", "loadSettingController"); // ("display info in the window" , "name of the method callingBack" )
    keyboard[keyCode] = false;   //
    
  }
}

// Controller current save
// CTRL + E
public void check_Keyboard_save_controller_CURRENT_path() {
  if(checkKeyboard(CONTROL) && !checkKeyboard(SHIFT) && checkKeyboard(KeyEvent.VK_E) ) {
    showAllSliders = true ;
    // println("save controler on the same path",savePathSetting) ;
    if (savePathSetting.equals("")) {
      File tempFileName = new File ("your_controller_setting.csv");
      selectOutput("Save setting", "saveSetting", tempFileName);
    } else saveSetting(savePathSetting) ;

    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
}
// Controller new save
// CTRL + SHIFT + E
public void check_Keyboard_save_controller_NEW_path() {
  if(checkKeyboard(CONTROL) && checkKeyboard(SHIFT) && checkKeyboard(KeyEvent.VK_E) ) {
    println(savePathSetting) ;
    showAllSliders = true ; 
    println("save controler on a new path") ;
    File tempFileName = new File ("your_controller_setting.csv");
    selectOutput("Save setting", "saveSetting", tempFileName);
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }

}


// END SHORTCUTS
/////////////////




// VARIABLE declaration
////////////////////////////////////
PImage[] OFF_in_thumbnail ;
PImage[] OFF_out_thumbnail ;
PImage[] ON_in_thumbnail ;
PImage[] ON_out_thumbnail ;

PImage[] picSetting = new PImage[4] ;
PImage[] picSound = new PImage[4] ;
PImage[] picAction = new PImage[4] ;
PImage[] picCurtain = new PImage[4] ;
PImage[] picMidi = new PImage[4] ;



SliderAdjustable [] slider = new SliderAdjustable [NUM_SLIDER_TOTAL] ;
int []suivitSlider ; 
PVector [] sizeSlider = new PVector[NUM_SLIDER_TOTAL] ;
PVector [] posSlider = new PVector[NUM_SLIDER_TOTAL] ; 

float valueSlider[] = new float[NUM_SLIDER_TOTAL] ;



//Background / light one / light two
int EtatBackgroundButton,
    EtatLightAmbientButton, EtatLightAmbientAction,
    EtatLightOneButton, EtatLightOneAction, 
    EtatLightTwoButton, EtatLightTwoAction ;
PVector posBackgroundButton, sizeBackgroundButton,
        posLightAmbientAction, sizeLightAmbientAction, posLightAmbientButton, sizeLightAmbientButton,
        posLightOneAction, sizeLightOneAction, posLightOneButton, sizeLightOneButton,
        posLightTwoAction, sizeLightTwoAction, posLightTwoButton, sizeLightTwoButton ;


// DROPDOWN button font and shader background
int EtatFont, EtatBackgroundShader, EtatImage, EtatFileText ;
PVector posButtonFont, posButtonBackground, posButtonImage, posButtonFileText ; 

// MIDI, CURTAIN
int EtatMidiButton, EtatCurtainButton, EtatBbeat, EtatBkick, EtatBsnare, EtatBhat ; ;
PVector posMidiButton, sizeMidiButton, pos_midi_info,
        posCurtainButton, sizeCurtainButton,
        posBeatButton, sizeBeatButton,
        posKickButton, sizeKickButton,
        posSnareButton, sizeSnareButton,
        posHatButton, sizeHatButton ;


//param\u00e8tres r\u00e9glette couleur
int posXSlider[] = new int[NUM_SLIDER_TOTAL *2] ;

// END variables declaration
////////////////////////////////////














// PARAMETER
/////////////////////////////////
float ratioNormSizeMolette = 1.3f ; 
int sliderWidth = 140 ;
int sliderHeight = 10 ;
int roundedSlider = 5 ;
/*  the position is calculated in ratio of the slider position. Not optimize for the vertical slider */
float normPosSliderAdjustable = .5f ; 
/*the height size is calculated in ratio of the slider height size.  Not optimize for the vertical slider */
float normSizeSliderAdjustable =.2f ; 

// vertical grid
int colOne = 35 ; 
int colTwo = PApplet.parseInt(1.5f *sliderWidth +colOne)  ; 
int colThree = PApplet.parseInt(1.5f *sliderWidth +colTwo) ;
int margeLeft  = colOne +15 ;

// horizontal grid

// this not a position but the height of the rectangle
int lineHeader = 30 ;
int lineMenuTopDropdown = 65 ;
int lineGroupZero = 95 ;
int lineGroupOne = 320 ;
int lineGroupTwo = lineGroupOne +205 ;


int spacingBetweenSlider = 13 ;

// button slider
int sizeTitleButton = 10 ;
int correctionButtonSliderTextY = 1 ;



// CURTAIN
int correctionCurtainX = 0 ;
int correctionCurtainY = 0 ;




// MENU TOP DROPDOWN
int correctionHeaderDropdownY = +4 ;
int correctionHeaderDropdownBackgroundX = -3 ;
int correctionHeaderDropdownFontX = 100 ;
int correctionHeaderDropdownImageX = 200 ;
int correctionHeaderDropdownFileTextX = 255 ;


//GROUP ZERO
int correctionSliderPos = 12 ;
int correctionGroupZeroY = 13 ;
// GROUP BG
int correctionBGX = colOne ;
int correctionBGY = lineGroupZero +correctionGroupZeroY +2 ;

// GROUP LIGHT

// ambient light
int correctionLightAmbientX = colOne ;
int correctionLightAmbientY = lineGroupZero +correctionGroupZeroY +73 ;

// directional light one
int correctionLightOneX = colTwo ;
int correctionLightOneY = lineGroupZero +correctionGroupZeroY +13 ;
// directional light two
int correctionLightTwoX = colTwo ;
int correctionLightTwoY = lineGroupZero +correctionGroupZeroY +73 ;

// GROUP CAMERA
int correctionCameraX = colThree ;
int correctionCameraY = lineGroupZero +correctionGroupZeroY -5 ;




// GROUP SOUND
int correctionSoundX = colOne ;
int correctionSoundY = lineGroupZero +160 ;



// GROUP OBJECT
int correctionSliderObject = 65 ;
int correctionButtonObject = 3 ;
int correctionDropdownObject = 43 ;


// GROUP MIDI
int correctionMidiX = 40 ;
int correctionMidiY = 0 ;
int spacing_midi_info = 13 ;
int correction_info_midi_x = 60 ;
int correction_info_midi_y = 10 ;
int size_x_window_info_midi = 200 ;





// END PARAMETER
//////////////////////////////////




















// STRUCTURE DRAW
////////////////////////
public void structureDraw() {
  //background
  
  int correctionheight = 14 ;
  fill(grisClair) ; rect(0, 0, width, height ) ; //GROUP object  ONE and TWO
  fill(gris) ; rect(0, 0, width, lineGroupOne -correctionheight) ; // //GROUP global ZERO
  fill(grisNoir) ; rect(0, lineMenuTopDropdown, width, lineGroupZero -lineMenuTopDropdown) ; // main band
  
  //the decoration line
  fill(jauneOrange) ;
  rect(0,0, width, lineHeader-6) ;
  fill (rougeFonce) ; 
  rect(0,0, width, lineHeader-8) ;
  
  // bottom line
  fill (jauneOrange) ;
  rect(0,height-9, width, 2) ;
  fill (rougeFonce) ;
  rect(0,height-7, width, 7) ;
  
  // LINE MENU TOP DROPDOWN
    fill (jauneOrange) ;
  rect(0,lineMenuTopDropdown, width, 2) ;
  
  // LINE DECORATION
  // GROUP ZERO
  int thicknessDecoration = 5 ;
  fill(noir) ;
  rect(0,lineGroupZero , width, 2) ;
  
  // LINE SOUND
  fill(grisFonce) ;
  rect(0, correctionSoundY -26 +thicknessDecoration, width, thicknessDecoration) ; 
  fill(grisTresFonce) ;
  rect(0, correctionSoundY -18, width, 2) ;
  
  //GROUP ONE
  fill(jauneOrange) ;
  rect(0, lineGroupOne -22, width, 8) ; 
  fill(rougeFonce) ;
  rect(0, lineGroupOne -20, width, 4) ; 
  
  // GROUP TWO
  fill(gris) ;
  rect(0, lineGroupTwo -24 +thicknessDecoration, width, thicknessDecoration) ; 
  fill(grisTresFonce) ;
  rect(0, lineGroupTwo -16, width, 2) ;
  
  

}

//TEXT
public void textDraw() {
  if(insideNameversion) fill (jaune) ; else fill(orange) ;
  int posTextY = 18 ;
  textFont(FuturaStencil_20,16); 
  text(nameVersion, 5, posTextY);
  //CLOCK
  fill (orange) ; 
  textFont(FuturaStencil_20,16); textAlign(RIGHT);
  text(nf(hour(),2)   + ":" +nf(minute(),2) , width -10, posTextY);
  
  dispayTextSliderGroupZero( lineGroupZero +64) ;
  
  dislayTextSlider() ;
}

//END STRUCTURE DRAW
////////////////////////






















///////////////////
// SLIDER
public void constructorSlider() {
  //slider
  for ( int i = 1 ; i < NUM_SLIDER_TOTAL ; i++ ) {
    PVector sizeMol = new PVector (sizeSlider[i].y *ratioNormSizeMolette, sizeSlider[i].y *ratioNormSizeMolette) ;
    // we use the var posMol here just to init the Slider, because we load data from save further.
    PVector posMol = new PVector() ;
    PVector tempPosSlider = new PVector(posSlider[i].x, posSlider[i].y -(sliderHeight *.6f)) ;
    if(infoSaveFromRawList(infoSlider,i).a > -1 ) {
      slider[i] = new SliderAdjustable  (tempPosSlider, posMol, sizeSlider[i], sizeMol, "ELLIPSE");
    }
    if(slider[i] != null) slider[i].setting() ;
  } 
}


// SLIDER SETUP
// MAIN METHOD SLIDER SETUP
public void sliderSettingVar() {
  groupZeroSlider (correctionSliderPos) ;
  groupOneSlider (lineGroupOne +correctionSliderObject) ;
  groupTwoSlider (lineGroupTwo +correctionSliderObject) ;
}


// LOCAL SLIDER SETUP METHOD

// group zero, global slider for camera, sound, light, background...
////////////////////////////////////////////////////////////////////
public void groupZeroSlider(int correctionY) {
  // background slider
  int startLoop = 1 ;
  for(int i = startLoop ; i <= startLoop +3 ;i++) {
    float posY = correctionBGY +correctionY +((i-1) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(colOne, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
  // SOUND
  startLoop = 5 ;
  for(int i = startLoop ; i <= startLoop +1 ;i++) {
    float posY = correctionSoundY +correctionY +((i-startLoop) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(correctionSoundX, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
  
  
  //LIGHT
  /////////////
  // Directional light one
  startLoop = 7 ;
  for(int i = startLoop ; i <= startLoop +2 ;i++) {
    float posY = correctionLightOneY +correctionY +((i-startLoop) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(correctionLightOneX, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
  // Directional light two
  startLoop = 10 ;
  for(int i = startLoop ; i <= startLoop +2 ;i++) {
    float posY = correctionLightTwoY +correctionY +((i-startLoop) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(correctionLightTwoX, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
  
  // Ambient light
  startLoop = 13 ;
  for(int i = startLoop ; i <= startLoop +2 ;i++) {
    float posY = correctionLightAmbientY +correctionY +((i-startLoop) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(correctionLightAmbientX, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
  
  
  // CAMERA
  //////////
//  int correctionCameraX = colThree ;
//int correctionCameraY = lineGroupZero +15 ;
   startLoop = 20 ;
  for(int i = startLoop ; i <= startLoop +8 ;i++) {
    float posY = correctionCameraY +correctionY +((i-startLoop) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(correctionCameraX, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
}



// Object group
///////////////////////////////////////////
public void groupOneSlider(int sliderPositionY) {
  // where the controleur must display the slider
  for( int i = 0 ; i < SLIDER_BY_COL ; i++ ) {
    for (int j = 0 ; j < NUM_COL_SLIDER ; j++) {
      int whichSlider = i +101 +(j*10) ;
      int posX = 0 ;
      switch(j) {
        case 0 : posX = colOne; 
        break;
        case 1 : posX = colTwo;
        break;
        case 2 : posX = colThree;
        break ;
      }
      posSlider   [whichSlider] = new PVector(posX, sliderPositionY +i *spacingBetweenSlider ) ;
      sizeSlider  [whichSlider] = new PVector(sliderWidth, sliderHeight) ;
    }
  }
}

//
public void groupTwoSlider(int sliderPositionY) {
  // where the controller must display the slider
  for( int i = 0 ; i < SLIDER_BY_COL ; i++ ) {
    for (int j = 0 ; j < NUM_COL_SLIDER ; j++) {
      int whichSlider = i +201 +(j*10) ;
      int posX = 0 ;
      switch(j) {
        case 0 : posX = colOne; 
        break;
        case 1 : posX = colTwo;
        break;
        case 2 : posX = colThree;
        break ;
      }
    posSlider   [whichSlider] = new PVector(posX, sliderPositionY +i *spacingBetweenSlider) ;
    sizeSlider  [whichSlider] = new PVector(sliderWidth, sliderHeight) ;
    }
  }
}
// END SLIDER SETUP




// SLIDER DRAW
public void sliderDraw() {
  // sliderDisplayGroupZero() ;
  displayBackgroundSliderGroupZero() ;
  
  /* Loop to display the false background slider instead the usual class Slider background,
  we use it the methode to display a particular background, like the rainbowcolor... */
  for(int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
    // sliderDisplayObject(i) ;
    displayBackgroundSliderGroupObject(i) ;
  }
  

  // UPDATE and DISPLAY SLIDER GROUP ONE, TWO, THREE
  /* different way to display depend the displaying mode, who can be change with "ctrl+x" */
  int whichGroup = 0 ;
  for (int i = 1 ; i < NUM_SLIDER_MISC ; i++) {
     sliderUpdate(i) ;
     sliderDisplayMoletteCurrentMinMax(i, whichGroup) ;
  }
  // group one, two, three
  whichGroup = 1 ;
  if(!showAllSliders) {
    for (int i = 1 ; i <= numObj ; i++) {
      if (objectActive[i] ) {
        for (int j = 1 ; j < NUM_GROUP_SLIDER ; j++) {
          if (showSliderGroup[j] && objectGroup[i] == j) { 
            for(int k = 1 ; k < NUM_SLIDER_OBJ ; k++) {
              if (displaySlider[j][k]) {
                int whichOne = objectGroup[i] *100 +k ;
                sliderUpdate(whichOne) ; 
                sliderDisplayMoletteCurrentMinMax(whichOne, whichGroup) ; 
              }
            }
          }
        }
      }
    }
  // if it ask to show all slider  
  } else {
    for (int i = 1 ; i < NUM_GROUP_SLIDER ; i++) { 
      for(int j = 1 ; j < NUM_SLIDER_OBJ ; j++) {
        int whichOne = i *100 +j ;
        sliderUpdate(whichOne) ;
        sliderDisplayMoletteCurrentMinMax(whichOne, whichGroup) ;
      }
    }
  }
}







// SLIDER UPDATE
public void sliderUpdate(int whichOne) {
  // PVector sizeMoletteSlider = new PVector (8,10, 1.2) ; // width, height, thickness
  
  //MIDI update
  sliderMidiUpdate(whichOne) ;
  

   // MIN and MAX molette
  //check
  if(!slider[whichOne].lockedMol && !slider[whichOne].insideMol ) {
    // min molette
    if(!slider[whichOne].insideMax() && !slider[whichOne].lockedMax) {
      slider[whichOne].insideMin() ;
      slider[whichOne].updateMin() ;
    }
    // max molette
    if(!slider[whichOne].insideMin() && !slider[whichOne].lockedMin) {
      slider[whichOne].insideMax() ;
      slider[whichOne].updateMax() ;
    }
  }
  // update 
  slider[whichOne].updateMinMax() ;
  
  
  // CURRENT molette
  // check
  if(!slider[whichOne].lockedMax  && !slider[whichOne].lockedMax) slider[whichOne].insideMol_Ellipse() ;
  // update
  slider[whichOne].updateMolette() ;
  
  // translate float value to int, to use OSC easily without problem of Array Outbound...blablah
  int valueMax = 360 ;
  valueSlider[whichOne] = constrain(map(slider[whichOne].getValue(), 0, 1, 0,valueMax),0,valueMax)  ;
  

}


public void sliderDisplayMoletteCurrentMinMax(int whichOne, int whichGroup) {
  if (whichGroup == 0) {
    sliderDisplayMinMaxMolette(whichOne, grisTresFonce, gris) ;
    sliderDisplayCurrentMolette(whichOne, blanc, blancGris) ;
  } else {
    sliderDisplayMinMaxMolette(whichOne, grisFonce, grisClair) ;
    sliderDisplayCurrentMolette(whichOne, blanc, blancGris) ;
  }
}
// local method
public void sliderDisplayMinMaxMolette(int whichOne,  int colorIn, int colorOut) {
  float thickness = 0 ;
  slider[whichOne].displayMinMax(normPosSliderAdjustable, normSizeSliderAdjustable, colorIn, colorOut, colorIn, colorOut, thickness) ;
}
public void sliderDisplayCurrentMolette(int whichOne, int colorMolIn, int colorMolOut) {
  slider[whichOne].displayMolette(colorMolIn,colorMolOut, colorMolIn,colorMolOut, 1) ;
}
// end local method




// TEXT slider
///////////////
public void dispayTextSliderGroupZero(int pos) {
  // GROUP ZERO
  textAlign(LEFT);
  textFont(textUsual_1) ; 
  //textAlign(LEFT);
  fill (colorTextUsual) ;
  /** Must rework the array String for the title the order is wrong
  for(int i = 0 ; i < 14 ; i++) {
    int whichOne = i +1 ;
    text(genTxtGUI[whichOne], posSlider[whichOne].x +sizeSlider[whichOne].x +correction, posSlider[whichOne].y +correction);
  }
  */
  //BACKGROUND
  int correctionY = 3 ;
  int correctionX = sliderWidth + 5 ;
  // BACKGROUND and SOUND
  for(int i = 1 ; i < 7 ; i++ ) {
    text(genTxtGUI[i], posSlider[i].x +correctionX, posSlider[i].y +correctionY);
  }
  

  // light
  for(int i = 0 ; i < 3 ; i++ ) {
    // directional one
    text(sliderNameLight[i+1], posSlider[i +7].x +correctionX, posSlider[i+7].y +correctionY);
    // directional two
    text(sliderNameLight[i+1], posSlider[i +10].x +correctionX, posSlider[i+10].y +correctionY);
    // ambient
    text(sliderNameLight[i+1], posSlider[i +13].x +correctionX, posSlider[i+13].y +correctionY);
  }
  
  
  // CAMERA
  int numSliderCorrection = 19 ;
  for(int i = 1 ; i < sliderNameCamera.length ; i++ ) {
    text(sliderNameCamera[i], posSlider[i+numSliderCorrection].x +correctionX, posSlider[i+numSliderCorrection].y +correctionY);
  }
}



public void dislayTextSlider() {
  //GROUP ONE
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  fill(grisFonce) ;
  pushMatrix () ; rotate (-PI/2) ;  text("GROUP ONE", -lineGroupOne, 20); popMatrix() ;
  fill (colorTextUsual) ;
  textFont(textUsual_1);  textAlign(LEFT);
  
  // GROUP TWO
  textFont(FuturaStencil_20,20);  textAlign(RIGHT);
  fill(grisFonce) ;
  pushMatrix () ; rotate (-PI/2) ;  text("GROUP TWO", -lineGroupTwo, 20); popMatrix() ;
  fill (colorTextUsual) ;
  textFont(textUsual_1);  textAlign(LEFT);
  
  
  // Legend text slider position
  int correctionY = correctionSliderObject +4 ;
  int correctionX = sliderWidth + 5 ;
  for ( int i = 0 ; i < SLIDER_BY_COL ; i++) {
    //group one
    text(sliderNameOne[i +1], colOne +correctionX, lineGroupOne +correctionY +(i*spacingBetweenSlider));
    text(sliderNameTwo[i +1], colTwo +correctionX, lineGroupOne +correctionY +(i*spacingBetweenSlider));
    text(sliderNameThree[i +1], colThree +correctionX, lineGroupOne +correctionY +(i*spacingBetweenSlider));
    //group two
    text(sliderNameOne[i +1], colOne +correctionX, lineGroupTwo +correctionY +(i*spacingBetweenSlider));
    text(sliderNameTwo[i +1], colTwo +correctionX, lineGroupTwo +correctionY +(i*spacingBetweenSlider));
    text(sliderNameThree[i +1], colThree +correctionX, lineGroupTwo +correctionY +(i*spacingBetweenSlider));
  }
}
// end text
///////////




/////////////////
// SLIDER DISPLAY
////////////////////////////////////////////////////////////////////////////////
// Slider display for the global slider background, camera, light, sound....
/*
When you add a new sliders, you must change the starting value from 'NAN' to a value between 0 and 1 in the file 'defaultSetting.csv' in the 'preferences/setting' folder.
And you must add the name of this one in the 'preferences/'  folder sliderListEN.csv' and in the 'sliderListFR' file
*/
public void displayBackgroundSliderGroupZero() {
  sliderBackgroundDisplay() ;
  sliderDirectionalLightOne() ;
  sliderDirectionalLightTwo() ;
  sliderAmbientLight() ;
  sliderSoundDisplay() ;
  sliderCameraDisplay() ;
}

// local void for slider display group zero
public void sliderBackgroundDisplay() {
  int start = 0 ;
  sliderHSBglobalDisplay(start) ;
  sliderBG(posSlider[4].x, posSlider[4].y, sizeSlider[4].y, sizeSlider[4].x, roundedSlider, blancGris) ;
}

// light local variable display
public void sliderAmbientLight() {
  int start = 12;
  sliderHSBglobalDisplay(start) ;
}

public void sliderDirectionalLightOne() {
  int start = 6 ;
  sliderHSBglobalDisplay(start) ;
}

public void sliderDirectionalLightTwo() {
  int start = 9 ;
  sliderHSBglobalDisplay(start) ;
}
//
public void sliderSoundDisplay() {
  sliderBG ( posSlider[5].x, posSlider[5].y, sizeSlider[5].y, sizeSlider[5].x, roundedSlider, grisClair) ;
  sliderBG ( posSlider[6].x, posSlider[6].y, sizeSlider[6].y, sizeSlider[6].x, roundedSlider, grisClair) ;
}

public void sliderCameraDisplay() {
    // we cannot loop, because we change the color of display at the end of the function
  sliderBG ( posSlider[20].x, posSlider[20].y, sizeSlider[20].y, sizeSlider[20].x, roundedSlider, grisClair) ;
  sliderBG ( posSlider[21].x, posSlider[21].y, sizeSlider[21].y, sizeSlider[21].x, roundedSlider, grisClair) ;
  sliderBG ( posSlider[22].x, posSlider[22].y, sizeSlider[22].y, sizeSlider[22].x, roundedSlider, blancGris) ;
  sliderBG ( posSlider[23].x, posSlider[23].y, sizeSlider[23].y, sizeSlider[23].x, roundedSlider, blancGris) ;
  sliderBG ( posSlider[24].x, posSlider[24].y, sizeSlider[24].y, sizeSlider[24].x, roundedSlider, blancGris) ;
  sliderBG ( posSlider[25].x, posSlider[25].y, sizeSlider[25].y, sizeSlider[25].x, roundedSlider, grisClair) ;
  sliderBG ( posSlider[26].x, posSlider[26].y, sizeSlider[26].y, sizeSlider[26].x, roundedSlider, grisClair) ;
  sliderBG ( posSlider[27].x, posSlider[27].y, sizeSlider[27].y, sizeSlider[27].x, roundedSlider, grisClair) ;
  sliderBG ( posSlider[28].x, posSlider[28].y, sizeSlider[28].y, sizeSlider[28].x, roundedSlider, grisClair) ;
}

// supra local void
public void sliderHSBglobalDisplay(int start) {
  if (mouseX > (posSlider[1 +start].x ) && mouseX < ( posSlider[1 +start].x +sizeSlider[1 +start].x) 
      && mouseY > ( posSlider[1 +start].y - 5) && mouseY < posSlider[1 +start].y +40) {
    hueSliderBG    ( posSlider[1 +start].x, posSlider[1 +start].y, sizeSlider[1 +start].y, sizeSlider[1 +start].x) ;
    saturationSliderBG ( posSlider[2 +start].x, posSlider[2 +start].y, sizeSlider[2 +start].y, sizeSlider[1 +start].x, valueSlider[1 +start], valueSlider[2 +start], valueSlider[3 +start] ) ;
    brightnessSliderBG ( posSlider[3 +start].x, posSlider[3 +start].y, sizeSlider[3 +start].y, sizeSlider[1 +start].x, valueSlider[1 +start], valueSlider[2 +start], valueSlider[3 +start] ) ;
  } else {
    sliderBG    ( posSlider[1 +start].x, posSlider[1 +start].y, sizeSlider[1 +start].y, sizeSlider[1 +start].x, roundedSlider, grisClair) ;
    sliderBG    ( posSlider[2 +start].x, posSlider[2 +start].y, sizeSlider[2 +start].y, sizeSlider[2 +start].x, roundedSlider, grisClair) ;
    sliderBG    ( posSlider[3 +start].x, posSlider[3 +start].y, sizeSlider[3 +start].y, sizeSlider[3 +start].x, roundedSlider, grisClair) ;
  }
}
// end slider display for group zero
////////////////////////////////////


















// Slider display for the Object slider
////////////////////////////////////////
/*
When you add a new sliders, you must change the starting value from 'NAN' to a value between 0 and 1 in the file 'defaultSetting.csv' in the 'preferences/setting' folder.
And you must add the name of this one in the 'preferences/'  folder sliderListEN.csv' and in the 'sliderListFR' file
*/

/* Loop to display the false background slider instead the usual class Slider background,
we use it the methode to display a particular background, like the rainbowcolor... */
public void displayBackgroundSliderGroupObject(int whichOne) {
  // to find the good slider in the array
  int whichGroup = whichOne ;
  whichOne *= 100 ;
  
  // COL ONE
  sliderHSBobjectDisplay(whichOne, whichGroup, hueFillRank, saturationFillRank, brightnessFillRank) ;
  if (displaySlider[whichGroup][alphaFillRank]) sliderBG (posSlider[whichOne +alphaFillRank].x, posSlider[whichOne +alphaFillRank].y, sizeSlider[whichOne +alphaFillRank].y, sizeSlider[whichOne +alphaFillRank].x, roundedSlider, blanc ) ;
  
  //outline color
  sliderHSBobjectDisplay(whichOne, whichGroup, hueStrokeRank, saturationStrokeRank, brightnessStrokeRank) ;
  if (displaySlider[whichGroup][alphaStrokeRank]) sliderBG (posSlider[whichOne +alphaStrokeRank].x, posSlider[whichOne +alphaStrokeRank].y, sizeSlider[whichOne +alphaStrokeRank].y, sizeSlider[whichOne +alphaStrokeRank].x, roundedSlider, blancGrisClair) ;
  //  thickness
  if( displaySlider[whichGroup][thicknessRank]) sliderBG (posSlider[whichOne +thicknessRank].x, posSlider[whichOne +thicknessRank].y, sizeSlider[whichOne +thicknessRank].y, sizeSlider[whichOne +thicknessRank].x, roundedSlider, blanc) ;
  
  // COL TWO

  // width, height, depth
  if(displaySlider[whichGroup][widthObjRank])  sliderBG (posSlider[whichOne +widthObjRank].x, posSlider[whichOne +widthObjRank].y, sizeSlider[whichOne +widthObjRank].y, sizeSlider[whichOne +widthObjRank].x, roundedSlider, blanc) ;
  if(displaySlider[whichGroup][heightObjRank]) sliderBG (posSlider[whichOne +heightObjRank].x, posSlider[whichOne +heightObjRank].y, sizeSlider[whichOne +heightObjRank].y, sizeSlider[whichOne +heightObjRank].x, roundedSlider, blanc) ;
  if(displaySlider[whichGroup][depthObjRank])  sliderBG (posSlider[whichOne +depthObjRank].x, posSlider[whichOne +depthObjRank].y, sizeSlider[whichOne +depthObjRank].y, sizeSlider[whichOne +depthObjRank].x, roundedSlider, blanc) ;
  // canvas
  if(displaySlider[whichGroup][canvasXRank]) sliderBG (posSlider[whichOne +canvasXRank].x, posSlider[whichOne +canvasXRank].y, sizeSlider[whichOne +canvasXRank].y, sizeSlider[whichOne +canvasXRank].x, roundedSlider, blancGrisClair) ;
  if(displaySlider[whichGroup][canvasYRank]) sliderBG (posSlider[whichOne +canvasYRank].x, posSlider[whichOne +canvasYRank].y, sizeSlider[whichOne +canvasYRank].y, sizeSlider[whichOne +canvasYRank].x, roundedSlider, blancGrisClair) ;
  if(displaySlider[whichGroup][canvasZRank]) sliderBG (posSlider[whichOne +canvasZRank].x, posSlider[whichOne +canvasZRank].y, sizeSlider[whichOne +canvasZRank].y, sizeSlider[whichOne +canvasZRank].x, roundedSlider, blancGrisClair) ;
  // Family
  if(displaySlider[whichGroup][familyRank]) sliderBG ( posSlider[whichOne +familyRank].x, posSlider[whichOne +familyRank].y, sizeSlider[whichOne +familyRank].y, sizeSlider[whichOne +familyRank].x, roundedSlider, blanc) ;
  if(displaySlider[whichGroup][quantityRank]) sliderBG (posSlider[whichOne +quantityRank].x, posSlider[whichOne +quantityRank].y, sizeSlider[whichOne +quantityRank].y, sizeSlider[whichOne +quantityRank].x, roundedSlider, blanc) ;
  if(displaySlider[whichGroup][lifeRank]) sliderBG ( posSlider[whichOne +lifeRank].x, posSlider[whichOne +lifeRank].y, sizeSlider[whichOne +lifeRank].y, sizeSlider[whichOne +lifeRank].x, roundedSlider, blanc) ;

  
  // COL THREE
  // speed
  if(displaySlider[whichGroup][speedRank]) sliderBG ( posSlider[whichOne +speedRank].x, posSlider[whichOne +speedRank].y, sizeSlider[whichOne +speedRank].y, sizeSlider[whichOne +speedRank].x, roundedSlider, blanc) ;
  // direction angle
  if(displaySlider[whichGroup][directionRank]) sliderBG ( posSlider[whichOne +directionRank].x, posSlider[whichOne +directionRank].y, sizeSlider[whichOne +directionRank].y, sizeSlider[whichOne +directionRank].x, roundedSlider, blancGrisClair) ;
  if(displaySlider[whichGroup][angleRank]) sliderBG ( posSlider[whichOne +angleRank].x, posSlider[whichOne +angleRank].y, sizeSlider[whichOne +angleRank].y, sizeSlider[whichOne +angleRank].x, roundedSlider, blancGrisClair) ;
  // Forces
  if(displaySlider[whichGroup][amplitudeRank]) sliderBG (posSlider[whichOne +amplitudeRank].x, posSlider[whichOne +amplitudeRank].y, sizeSlider[whichOne +amplitudeRank].y, sizeSlider[whichOne +amplitudeRank].x, roundedSlider, blanc) ;
  if(displaySlider[whichGroup][attractionRank]) sliderBG (posSlider[whichOne +attractionRank].x, posSlider[whichOne +attractionRank].y, sizeSlider[whichOne +attractionRank].y, sizeSlider[whichOne +attractionRank].x, roundedSlider, blanc) ;
  if(displaySlider[whichGroup][repulsionRank]) sliderBG (posSlider[whichOne +repulsionRank].x, posSlider[whichOne +repulsionRank].y, sizeSlider[whichOne +repulsionRank].y, sizeSlider[whichOne +repulsionRank].x, roundedSlider, blanc) ;
  if(displaySlider[whichGroup][influenceRank]) sliderBG ( posSlider[whichOne +influenceRank].x, posSlider[whichOne +influenceRank].y, sizeSlider[whichOne +influenceRank].y, sizeSlider[whichOne +influenceRank].x, roundedSlider, blancGrisClair) ;
  // Misc
  if(displaySlider[whichGroup][alignmentRank]) sliderBG ( posSlider[whichOne +alignmentRank].x, posSlider[whichOne +alignmentRank].y, sizeSlider[whichOne +alignmentRank].y, sizeSlider[whichOne +alignmentRank].x, roundedSlider, blancGrisClair) ;
  if(displaySlider[whichGroup][analyzeRank])  sliderBG ( posSlider[whichOne +analyzeRank].x, posSlider[whichOne +analyzeRank].y, sizeSlider[whichOne +analyzeRank].y, sizeSlider[whichOne +analyzeRank].x, roundedSlider, blancGrisClair) ;


}

// local void to display the HSB slider and display the specific color of this one
public void sliderHSBobjectDisplay(int whichOne, int whichGroup, int hueRank, int satRank, int brightRank) {
    if ( mouseX > (posSlider[whichOne +hueRank].x ) && mouseX < (posSlider[whichOne +hueRank].x +sizeSlider[whichOne +hueRank].x) 
       && mouseY > ( posSlider[whichOne +hueRank].y - 5) && mouseY < posSlider[whichOne +hueRank].y +30 ) 
  {
    if (displaySlider[whichGroup][hueRank])    hueSliderBG        (posSlider[whichOne +hueRank].x,    posSlider[whichOne +hueRank].y,    sizeSlider[whichOne +hueRank].y,    sizeSlider[whichOne +hueRank].x) ; 
    if (displaySlider[whichGroup][satRank])    saturationSliderBG (posSlider[whichOne +satRank].x,    posSlider[whichOne +satRank].y,    sizeSlider[whichOne +satRank].y,    sizeSlider[whichOne +hueRank].x, valueSlider[whichOne +hueRank], valueSlider[whichOne +satRank], valueSlider[whichOne +brightRank] ) ;
    if (displaySlider[whichGroup][brightRank]) brightnessSliderBG (posSlider[whichOne +brightRank].x, posSlider[whichOne +brightRank].y, sizeSlider[whichOne +brightRank].y, sizeSlider[whichOne +hueRank].x, valueSlider[whichOne +hueRank], valueSlider[whichOne +satRank], valueSlider[whichOne +brightRank] ) ;
  } else {
    if (displaySlider[whichGroup][hueRank])    sliderBG (posSlider[whichOne +hueRank].x,    posSlider[whichOne +hueRank].y,    sizeSlider[whichOne +hueRank].y,    sizeSlider[whichOne +hueRank].x,    roundedSlider, blanc) ;
    if (displaySlider[whichGroup][satRank])    sliderBG (posSlider[whichOne +satRank].x,    posSlider[whichOne +satRank].y,    sizeSlider[whichOne +satRank].y,    sizeSlider[whichOne +satRank].x,    roundedSlider, blanc ) ;
    if (displaySlider[whichGroup][brightRank]) sliderBG (posSlider[whichOne +brightRank].x, posSlider[whichOne +brightRank].y, sizeSlider[whichOne +brightRank].y, sizeSlider[whichOne +brightRank].x, roundedSlider, blanc ) ;
  }
}






// super local variable
//SLIDER COLOR
public void sliderBG (float posX, float posY, float heightSlider, float widthslider, int rounded, int coulour) {
  fill (coulour) ;
  rect (posX, posY -(heightSlider *.5f), widthslider, heightSlider, rounded) ;
}

// hue
public void hueSliderBG (float posX, float posY, float heightSlider, float widthSlider) {
  pushMatrix () ;
  translate (posX , posY-(heightSlider *.5f)) ;
  for ( int i=0 ; i < widthSlider ; i++ ) {
    for ( int j=0 ; j <=heightSlider ; j++ ) {
      float cr = map(i, 0, widthSlider, 0, 360 ) ;
      fill (cr, 100, 100) ;
      rect ( i, j, 1,1 ) ;
    }
  }
  popMatrix() ;
}

// saturation
public void saturationSliderBG (float posX, float posY, float heightSlider, float widthSlider, float colour, float s, float d) {
  pushMatrix () ;
  translate (posX , posY-(heightSlider *.5f)) ;
  for ( int i=0 ; i < widthSlider ; i++ ) {
    for ( int j=0 ; j <=heightSlider ; j++ ) {
      float cr = map(i, 0, widthSlider, 0, 100 ) ;
      // float sat = map(s, 0, largeur, 0, 100 ) ;
      float dens = map(d, 0, widthSlider, 0, 100 ) ;
      fill (colour, cr, dens) ;
      rect ( i, j, 1,1 ) ;
    }
  }
  popMatrix() ;
}

// brightness
public void brightnessSliderBG (float posX, float posY, float heightSlider, float widthSlider, float colour, float s, float d) {
  pushMatrix () ;
  translate (posX , posY-(heightSlider *.5f)) ;
  for ( int i=0 ; i < widthSlider ; i++ ) {
    for ( int j=0 ; j <=heightSlider ; j++ ) {
      float cr = map(i, 0, widthSlider, 0, 100 ) ;
      float sat = map(s, 0, widthSlider, 0, 100 ) ;
      // float dens = map(d, 0, largeur, 0, 100 ) ;
      fill (colour, sat, cr) ;
      rect (i, j, 1,1) ;
    }
  }
  popMatrix() ;
}
// End SLIDER background


// END SLIDER
//////////////////


















/////////////////////
// BUTTON

// BUTTON CONSTRUCTOR
public void constructorButton() {
  int OnInColor = vert ;
  int OnOutColor = vertTresFonce ;
  int OffInColor = orange ;
  int OffOutColor = rougeFonce ;
  
  buttonBackground = new Simple(posBackgroundButton, sizeBackgroundButton, OnInColor, OnOutColor, OffInColor, OffOutColor, true) ;
  // LIGHT AMBIENT
  buttonLightAmbient =       new Simple(posLightAmbientButton, sizeLightAmbientButton, OnInColor, OnOutColor, OffInColor, OffOutColor, false) ;
  buttonLightAmbientAction = new Simple(posLightAmbientAction, sizeLightAmbientAction, OnInColor, OnOutColor, OffInColor, OffOutColor, false) ;
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
    }

  }
}

// BUTTON SETUP
//////////////////
// Main METHOD SETUP
public void buttonSetup() {
  // MIDI CURTAIN
  sizeCurtainButton = new PVector(30,30) ;
  sizeMidiButton = new PVector(50,26) ;
  posMidiButton = new PVector(colOne +correctionMidiX, lineHeader +correctionMidiY +1) ;
  pos_midi_info = new PVector(posMidiButton.x +correction_info_midi_x, posMidiButton.y +correction_info_midi_y) ;
  posCurtainButton = new PVector(colOne +correctionCurtainX, lineHeader +correctionCurtainY -1) ; 
  
  
  // GROUP ZERO
  // background 
  posBackgroundButton = new PVector(correctionBGX, correctionBGY +correctionButtonSliderTextY) ;
  sizeBackgroundButton = new PVector(120,10) ;
  
  // light
  // ambient button
  posLightAmbientButton = new PVector(correctionLightAmbientX, correctionLightAmbientY +correctionButtonSliderTextY) ;
  sizeLightAmbientButton = new PVector(80,10) ;
  posLightAmbientAction = new PVector(correctionLightAmbientX +90, posLightAmbientButton.y) ; // for the y we take the y of the button
  sizeLightAmbientAction = new PVector(45,10) ;
  // one button
  posLightOneButton = new PVector(correctionLightOneX, correctionLightOneY +correctionButtonSliderTextY) ;
  sizeLightOneButton = new PVector(80,10) ;
  posLightOneAction = new PVector(correctionLightOneX +90, posLightOneButton.y) ; // for the y we take the y of the button
  sizeLightOneAction = new PVector(45,10) ;
  // light two button
  posLightTwoButton = new PVector(correctionLightTwoX, correctionLightTwoY +correctionButtonSliderTextY) ;
  sizeLightTwoButton = new PVector(80,10) ;
  posLightTwoAction = new PVector(correctionLightTwoX +90, posLightTwoButton.y) ; // for the y we take the y of the button
  sizeLightTwoAction = new PVector(45,10) ;
  
  

  
  //SOUND BUTTON
  sizeBeatButton = new PVector(30,10) ; 
  sizeKickButton = new PVector(30,10) ; 
  sizeSnareButton = new PVector(40,10) ; 
  sizeHatButton = new PVector(30,10) ;
  
  posBeatButton = new PVector(correctionSoundX, correctionSoundY +correctionButtonSliderTextY) ; 
  posKickButton = new PVector(posBeatButton.x +sizeBeatButton.x +5, correctionSoundY +correctionButtonSliderTextY) ; 
  posSnareButton = new PVector(posKickButton.x +sizeKickButton.x +5, correctionSoundY +correctionButtonSliderTextY) ; 
  posHatButton = new PVector(posSnareButton.x +sizeSnareButton.x +5, correctionSoundY +correctionButtonSliderTextY) ;
  
  

  groupOneButton(lineGroupOne +correctionButtonObject) ;
  groupTwoButton(lineGroupTwo +correctionButtonObject) ;
}

// LOCAL METHOD SETUP
PVector posRelativeMainButton = new PVector (-8, -10) ;
PVector posRelativeSettingButton = new PVector (-8,14) ;
PVector posRelativeSoundButton = new PVector (-8,25) ;
PVector posRelativeActionButton = new PVector (4,25) ;
//////////////
public void groupOneButton(int buttonPositionY) {
  //position and area for the rollover
  for (int i = 1 ; i <= numGroup[1] ; i++) {
    posWidthBOf[i*10+1] = margeLeft +((i-1)*40) +(int)posRelativeMainButton.x    ; posHeightBOf[i*10+1] = buttonPositionY +(int)posRelativeMainButton.y     ; longueurBOf[i*10+1] = 20 ; hauteurBOf[i*10+1] = 20 ;  //main
    posWidthBOf[i*10+2] = margeLeft +((i-1)*40) +(int)posRelativeSettingButton.x ; posHeightBOf[i*10+2] = buttonPositionY +(int)posRelativeSettingButton.y  ; longueurBOf[i*10+2] = 19 ; hauteurBOf[i*10+2] = 6 ; //setting
    posWidthBOf[i*10+3] = margeLeft +((i-1)*40) +(int)posRelativeSoundButton.x   ; posHeightBOf[i*10+3] = buttonPositionY +(int)posRelativeSoundButton.y    ; longueurBOf[i*10+3] = 10 ; hauteurBOf[i*10+3] = 6 ; //sound
    posWidthBOf[i*10+4] = margeLeft +((i-1)*40) +(int)posRelativeActionButton.x  ; posHeightBOf[i*10+4] = buttonPositionY +(int)posRelativeActionButton.y   ; longueurBOf[i*10+4] = 10 ; hauteurBOf[i*10+4] = 6 ; //action
  }
}
public void groupTwoButton(int buttonPositionY) {
  for (int i = 1 ; i <= numGroup[2] ; i++ ) {
    posWidthBTf[i*10+1] = margeLeft +((i-1)*40) +(int)posRelativeMainButton.x    ; posHeightBTf[i*10+1] = buttonPositionY +(int)posRelativeMainButton.y     ; longueurBTf[i*10+1] = 20 ; hauteurBTf[i*10+1] = 20 ; //main
    posWidthBTf[i*10+2] = margeLeft +((i-1)*40) +(int)posRelativeSettingButton.x ; posHeightBTf[i*10+2] = buttonPositionY +(int)posRelativeSettingButton.y  ; longueurBTf[i*10+2] = 19 ; hauteurBTf[i*10+2] = 6 ; //setting
    posWidthBTf[i*10+3] = margeLeft +((i-1)*40) +(int)posRelativeSoundButton.x   ; posHeightBTf[i*10+3] = buttonPositionY +(int)posRelativeSoundButton.y    ; longueurBTf[i*10+3] = 10 ; hauteurBTf[i*10+3] = 6 ; //sound
    posWidthBTf[i*10+4] = margeLeft +((i-1)*40) +(int)posRelativeActionButton.x  ; posHeightBTf[i*10+4] = buttonPositionY +(int)posRelativeActionButton.y   ; longueurBTf[i*10+4] = 10 ; hauteurBTf[i*10+4] = 6 ; //action
  }
}

public void groupThreeButton(int buttonPositionY) {
  //param\u00e8tre habillage couleur du bouton cercle BTY
  for (int i = 1 ; i <= numGroup[3] ; i++ ) {
    posWidthBTYf[i*10+1] = margeLeft +((i-1)*40) +(int)posRelativeMainButton.x    ; posHeightBTYf[i*10+1] = buttonPositionY +(int)posRelativeMainButton.y     ; longueurBTYf[i*10+1] = 20 ; hauteurBTYf[i*10+1] = 20 ; //main
    posWidthBTYf[i*10+2] = margeLeft +((i-1)*40) +(int)posRelativeSettingButton.x ; posHeightBTYf[i*10+2] = buttonPositionY +(int)posRelativeSettingButton.y  ; longueurBTYf[i*10+2] = 19 ; hauteurBTYf[i*10+2] = 6 ; //setting
    posWidthBTYf[i*10+3] = margeLeft +((i-1)*40) +(int)posRelativeSoundButton.x   ; posHeightBTYf[i*10+3] = buttonPositionY +(int)posRelativeSoundButton.y    ; longueurBTYf[i*10+3] = 10 ; hauteurBTYf[i*10+3] = 6 ; //sound
    posWidthBTYf[i*10+4] = margeLeft +((i-1)*40) +(int)posRelativeActionButton.x  ; posHeightBTYf[i*10+4] = buttonPositionY +(int)posRelativeActionButton.y   ; longueurBTYf[i*10+4] = 10 ; hauteurBTYf[i*10+4] = 6 ; //action
  }
}



// BUTTON DRAW
// DRAW MAIN METHOD
public void buttonDraw() {
  textFont(textUsual_1) ;
  buttonDrawGroupZero() ;
  buttonDrawGroupOne() ;
  buttonDrawGroupTwo() ;
  buttonCheckDraw() ;
  dropdownDraw() ;
  buttonInfoOnTheTop() ;
  midiButtonManager(false) ;
}





// DRAW LOCAL METHOD
public void buttonInfoOnTheTop() {
  fill(jaune) ;
   textFont(FuturaStencil_20) ;
  if(BOmidi.rollover()) text("Midi Setting",   mouseX -20, mouseY -20 ) ;
  if(BOcurtain.rollover()) text("Cut",   mouseX -20, mouseY -20 ) ;
}

// GROUP ZERO
public void buttonDrawGroupZero() {
  buttonBackground.buttonText(shaderBackgroundName[EtatBackgroundShader] + " on/off", posBackgroundButton, titleButtonMedium, sizeTitleButton) ;
  buttonBackground.buttonText(shaderBackgroundName[EtatBackgroundShader] + " on/off", posBackgroundButton, titleButtonMedium, sizeTitleButton) ;
  // Light ambient
  buttonLightAmbient.buttonText("Ambient on/off", posLightAmbientButton, titleButtonMedium, sizeTitleButton) ;
  buttonLightAmbientAction.buttonText("action", posLightAmbientAction, titleButtonMedium, sizeTitleButton) ;
  //LIGHT ONE
  buttonLightOne.buttonText("Light on/off", posLightOneButton, titleButtonMedium, sizeTitleButton) ;
  buttonLightOneAction.buttonText("action", posLightOneAction, titleButtonMedium, sizeTitleButton) ;
  // LIGHT TWO
  buttonLightTwo.buttonText("Light on/off",  posLightTwoButton, titleButtonMedium, sizeTitleButton) ;
  buttonLightTwoAction.buttonText("action",  posLightTwoAction, titleButtonMedium, sizeTitleButton) ;
  
  // SOUND
  Bbeat.buttonText("BEAT", posBeatButton, titleButtonMedium, sizeTitleButton) ;
  Bkick.buttonText("KICK", posKickButton, titleButtonMedium, sizeTitleButton) ;
  Bsnare.buttonText("SNARE", posSnareButton, titleButtonMedium, sizeTitleButton) ;
  Bhat.buttonText("HAT", posHatButton, titleButtonMedium, sizeTitleButton) ;
  
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




public void buttonCheckDraw() {
  EtatBackgroundButton = buttonBackground.getOnOff() ;
    //LIGHT ONE
  EtatLightAmbientButton = buttonLightAmbient.getOnOff() ;
  EtatLightAmbientAction = buttonLightAmbientAction.getOnOff() ;
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
    }
  }
}

// END BUTTON
/////////////



























// DROPDOWN
////////////
int refSizeImageDropdown, refSizeFileTextDropdown ;
PVector posTextDropdownImage, posTextDropdownFileText ; 
int selectedText ;
int colorBoxIn, colorBoxOut, colorBoxText, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut ;
int sizeToRenderTheBoxDropdown = 15 ;

public void dropdownSetup() {

  posButtonBackground = new PVector(colOne +correctionHeaderDropdownBackgroundX, lineMenuTopDropdown +correctionHeaderDropdownY)  ;
  posButtonFont =       new PVector(colOne +correctionHeaderDropdownFontX,  lineMenuTopDropdown +correctionHeaderDropdownY)  ; 
  posButtonImage =      new PVector(colOne +correctionHeaderDropdownImageX,  lineMenuTopDropdown +correctionHeaderDropdownY)  ; 
  posButtonFileText =   new PVector(colOne +correctionHeaderDropdownFileTextX,  lineMenuTopDropdown +correctionHeaderDropdownY)  ; 
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
  int numLineDisplayByTheDropdownObj = 8 ;
  sizeDropdownMode = new PVector (20, sizeToRenderTheBoxDropdown, numLineDisplayByTheDropdownObj) ;
  // int correctionDropdownObject +correctionButtonObject
  PVector newPos = new PVector( -8, correctionDropdownObject ) ;
  // group one
  checkTheDropdownSetupObject(startLoopObject, endLoopObject, margeLeft +newPos.x, lineGroupOne +newPos.y) ;
  // group two
  checkTheDropdownSetupObject(startLoopTexture, endLoopTexture, margeLeft +newPos.x, lineGroupTwo +newPos.y) ;
}

public void checkTheDropdownSetupObject( int start, int end, float posWidth, float posHeight) {
  for ( int i = start ; i < end ; i++ ) {
    if(modeListRomanesco[i] != null ) {
      int space = ((i -start +1) * 40) -40 ;
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
  
  dropdownBackground.dropdownUpdate(titleDropdownMedium, textUsual_1);
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
    EtatBackgroundShader = dropdownBackground.getSelection() ;
    if (dropdownBackground.getSelection() != 0 ) {
      text(shaderBackgroundName[EtatBackgroundShader] +" by " +shaderBackgroundAuthor[dropdownBackground.getSelection()], posDropdownBackground.x +3 , posDropdownBackground.y +22) ;
    } else {
      text(shaderBackgroundName[EtatBackgroundShader], posDropdownBackground.x +3 , posDropdownBackground.y +22) ;
    }
      
  }
}

// FONT
public void dropdownFont() {
  dropdownFont.dropdownUpdate(titleDropdownMedium, textUsual_1);
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
  
  dropdownImage.dropdownUpdate(titleDropdownMedium, textUsual_1);
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
  
  dropdownFileText.dropdownUpdate(titleDropdownMedium, textUsual_1);
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
        dropdown[i].dropdownUpdate(titleDropdownMedium, textUsual_1);
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
        textFont(titleDropdownMedium) ;
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

// END DROPDOWN
///////////////


















// OTHER METHOD 
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
//GLOBAL


public PFont 
      //controleur font
      textUsual_1, textUsual_2, textUsual_3,
      titleMedium, titleBig,
      
      titleButtonMedium,
      titleDropdownMedium,
      
      FuturaExtraBold_9, FuturaExtraBold_10,
      FuturaCondLight_10, FuturaCondLight_11,FuturaCondLight_12,
      FuturaStencil_20 ;
      
//SETUP
public void fontSetup() {
  //controleur Font
  String fontPathVLW = sketchPath("")+"preferences/Font/typoVLW/" ;
  FuturaStencil_20 = loadFont(fontPathVLW+"FuturaStencilICG-20.vlw");
  FuturaExtraBold_9 = loadFont(fontPathVLW+"Futura-ExtraBold-9.vlw");
  FuturaExtraBold_10 = loadFont(fontPathVLW+"Futura-ExtraBold-10.vlw");
  FuturaCondLight_10 = loadFont(fontPathVLW+"Futura-CondensedLight-10.vlw");
  FuturaCondLight_11 = loadFont(fontPathVLW+"Futura-CondensedLight-11.vlw");
  FuturaCondLight_12 = loadFont(fontPathVLW+"Futura-CondensedLight-12.vlw");
  
  textUsual_1 = FuturaCondLight_10 ;
  textUsual_2 = FuturaCondLight_11 ;
  textUsual_3 = FuturaCondLight_12 ;

  
  titleMedium = FuturaExtraBold_10 ;
  titleBig = FuturaStencil_20 ;
  
  titleButtonMedium = titleMedium ;
  titleDropdownMedium = titleMedium ;
}
//MIDI
//SETUP
public void midiSetup() {
  midiIO = MidiIO.getInstance(this);
}

//DRAW
boolean init_midi ;

public void midiDraw() {
  /* 
  Button to activate the midi setting > mapping + choice the midi deveice
  */
   if(selectMidi || !init_midi) {
    check_midi_input() ;
    int midi_channel = 0 ;
    open_input_midi(which_midi_input, midi_channel) ;
    init_midi = true ;
  }

  if(selectMidi) {
    
    if(midiIO.numberOfInputDevices() < 1 ) fill(rougeFonce) ; else fill(grisTresFonce) ;
    stroke(jaune) ;
    strokeWeight(1.5f) ;
    window_midi_info(pos_midi_info, size_x_window_info_midi, spacing_midi_info) ;
    noStroke() ;

    textFont(textUsual_1);  textAlign(LEFT);
    if(midiIO.numberOfInputDevices() < 1 ) fill(blanc) ; else fill(grisClair) ;
    display_select_midi_device(pos_midi_info, spacing_midi_info) ;
    midi_device_choice(pos_midi_info, spacing_midi_info) ;
  }

  if (EtatMidiButton == 1) selectMidi = true ; else selectMidi = false ;

}









// ANNEXE METHODE
/////////////////

// DISPLAY INFO MIDI INPUT
//////////////////////////
public void midi_device_choice(PVector pos, int spacing) {
  int num_line = 0 ;
  if (!choice_midi_device || !choice_midi_default_device) {
    text("Press the ID number to select an input Midi", pos.x, pos.y) ;

    text(midiIO.numberOfInputDevices() + " device(s) available(s)", pos.x, pos.y +spacing) ;
    for (int i = 0; i < midiIO.numberOfInputDevices(); i++) {
      num_line = i +2 ;
      // to make something clean for the reading
      String ID_input = "" +i ;
      if (i > 9 ) ID_input = nf(i, 2) ;
      //
      text("input device "+ID_input+": "+midiIO.getInputDeviceName(i), pos.x, pos.y +(num_line *spacing));
    }
  }
}



public void display_select_midi_device(PVector pos, int spacing) {
  if(which_midi_input < midiIO.numberOfInputDevices() ) {
    if (which_midi_input >= 0 && (choice_midi_device || choice_midi_default_device)) {
      text("Current midi device is " + midiIO.getInputDeviceName(which_midi_input), pos.x, pos.y) ;
      text("If you want choice an other input press \u201cN\u201c ", pos.x, pos.y + spacing) ;
    }
  } else {
    choice_midi_device = false ;
  }
}



public void window_midi_info(PVector pos, int size_x, int spacing) {
  int pos_x = (int)pos.x -(spacing/2) ;
  int pos_y = (int)pos.y -spacing ;
  int size_y = 0 ;
  if (!choice_midi_device || !choice_midi_default_device) {
    size_y = PApplet.parseInt(spacing *2.5f +(spacing *(midiIO.numberOfInputDevices() *1.2f))) ;
  } else {
    size_y = PApplet.parseInt(spacing *2.5f) ;
  }
  rect(pos_x, pos_y, size_x, size_y) ;
}
// END DISPLAY INFO MIDI INPUT
//////////////////////////////









// SELECT MIDI DEVICE
/////////////////////
// check midi input
boolean choice_midi_device, choice_midi_default_device ;
int which_midi_input = -1 ;
public void check_midi_input() {
  if (midiIO.numberOfInputDevices() > 0 && !choice_midi_device && !choice_midi_default_device) {
    for (int i = 0; i < midiIO.numberOfInputDevices (); i++) {
      which_midi_input = i ;
      break ;
    }
  }
}

public void select_midi_device() {
  if (key == '0') which_midi_input = 0 ;
  if (key == '1') which_midi_input = 1 ;
  if (key == '2') which_midi_input = 2 ;
  if (key == '3') which_midi_input = 3 ;
  if (key == '4') which_midi_input = 4 ;
  if (key == '5') which_midi_input = 5 ;
  if (key == '6') which_midi_input = 6 ;
  if (key == '7') which_midi_input = 7 ;
  if (key == '8') which_midi_input = 8 ;
  if (key == '9') which_midi_input = 9 ;
}

public void midi_keyPressed() {
  if (!choice_midi_device) select_midi_device() ;
  if (key =='n' && choice_midi_device) open_new_input_midi() ;
}

// END SELECT MIDI DEVICE
/////////////////////////




// OPEN AND CLOSE INPUT MIDI
/////////////////////////////////////////////////////
public void open_input_midi(int whichOne, int whichChannel) {
  if ((!choice_midi_device || !choice_midi_default_device) &&  whichOne != -1 && whichOne < midiIO.numberOfInputDevices() ) {
    midiIO.openInput(whichOne, whichChannel);
    choice_midi_default_device = true ;
    choice_midi_device = true ;
  }
}
//
public void open_new_input_midi() {
  if (which_midi_input >= 0 ) {
    which_midi_input = -1 ;
    choice_midi_device = false ;
  }
}
// END OPEN AND CLOSE INPUT MIDI
////////////////////////////////






// MIDI MANAGER
/////////////////
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
  if (numMidi == slider[whichOne].IDmidi()) slider[whichOne].updateMidi(valMidi) ;

  
  if(selectMidi && slider[whichOne].lockedMol()) {
    for(int i = 0 ; i <infoSlider.length ; i++) {
      if(whichOne == (int)infoSlider[i].a) {
        infoSlider[i].b = numMidi  ;
      }
    }
  }
  
  //ID midi from controller midi button setting
  if (selectMidi && slider[whichOne].lockedMol()) slider[whichOne].selectIDmidi(numMidi) ;
  
  //ID midi from save
  if(loadSaveSetting) slider[whichOne].selectIDmidi((int)infoSaveFromRawList(infoSlider, whichOne).b) ;
}
// END MIDI MANAGER
///////////////////
//GLOBAL




// local
String IPadress = ("127.0.0.1") ;
// Message to Prescene
String toPreScene [] = new String [7] ;


OscP5 osc_1, osc_2;
NetAddress target_1, target_2 ;
public void sendOSCsetup() {
 osc_1 = new OscP5(this, 10000);
 osc_2 = new OscP5(this, 9000);
 target_1 = new NetAddress(IPadress,10000);
 target_2 = new NetAddress(IPadress,9000);


}

public void sendOSCdraw() {
  OscMessage RomanescoController = new OscMessage("Controller");
  
  //int value join in String 
  translateDataToSend() ;
  
  //BUTTON 
  toPreScene[0] = joinIntToString(valueButtonGroup_0) ; 
  toPreScene[1] = joinIntToString(valueButtonGroup_1) ;
  toPreScene[2] = joinIntToString(valueButtonGroup_2) ;
  
  
  // SLIDER
  /* Catch the value slider to send to Prescene
  @return value to the prescene between 0 to 99
  */
  // group 0
  int[] dataGroupZero = new int[NUM_SLIDER_MISC] ;
  for ( int i = 1   ; i < NUM_SLIDER_MISC -1 ; i++) dataGroupZero[i-1] = floor(valueSlider[i]) ;
    toPreScene[3] = joinIntToString(dataGroupZero) ;

  // group 1
  int[] dataGroupOne = new int[NUM_SLIDER_OBJ] ;
  for ( int i = 101   ; i < 101 +NUM_SLIDER_OBJ ; i++) dataGroupOne[i-101] = floor(valueSlider[i]) ; 
  toPreScene[4] = joinIntToString(dataGroupOne);

  // group 2
  int[] dataGroupTwo = new int[NUM_SLIDER_OBJ] ;
  for ( int i = 201 ; i < 201 +NUM_SLIDER_OBJ ; i++) dataGroupTwo[i-201] = floor(valueSlider[i]) ;
  toPreScene[5] = joinIntToString(dataGroupTwo) ;


  // LOAD SAVE SCENE ORDER
  String load = String.valueOf(load_Scene_Setting) ;
  String  saveCurrent = String.valueOf(save_Current_Scene_Setting) ;
  String  saveNew = String.valueOf(save_New_Scene_Setting) ;
  // we change to false boolean load and data to false each 2 second to have a time to load and save
  if(frameCount%60 == 0) load_Scene_Setting = save_Current_Scene_Setting = save_New_Scene_Setting = false ;

  toPreScene[6] = load + "/" +  saveCurrent + "/" + saveNew;
  
  //add to OSC
  for ( int i = 0 ; i < toPreScene.length ; i++) {
    RomanescoController.add(toPreScene[i]);
  }
  //send
  osc_1.send(RomanescoController, target_1) ; 
  osc_2.send(RomanescoController, target_2) ; 
}



  
  
  
public void translateDataToSend() {
  //BUTTON GLOBAL
  //sound
  valueButtonGroup_0[1] = EtatBbeat ;
  valueButtonGroup_0[2] = EtatBkick ;
  valueButtonGroup_0[3] = EtatBsnare ;
  valueButtonGroup_0[4] = EtatBhat ;

  valueButtonGroup_0[5] = dropdownFont.getSelection() +1 ; ;
  valueButtonGroup_0[6] = EtatCurtainButton ;
  valueButtonGroup_0[7] = EtatBackgroundButton ;
  
  valueButtonGroup_0[8] = EtatLightOneButton ;
  valueButtonGroup_0[9] = EtatLightTwoButton ;
  valueButtonGroup_0[10] = EtatLightAmbientButton ;
  valueButtonGroup_0[11] = EtatLightOneAction ;
  valueButtonGroup_0[12] = EtatLightTwoAction ;
  valueButtonGroup_0[13] = EtatLightAmbientAction ;
  
  valueButtonGroup_0[14] = EtatBackgroundShader ;
  valueButtonGroup_0[15] = EtatImage ;
  valueButtonGroup_0[16] = EtatFileText ;
  /*
  valueButtonGroup_0[12] = EtatBackground ;
  valueButtonGroup_0[13] = EtatImage ;
  valueButtonGroup_0[14] = EtatFileText ;
  */
  
  //BUTTON GROUP ONE
  if(numGroup[1] > 0 ) {
    for ( int i = 0 ; i < numGroup[1]   ; i ++) {
      valueButtonGroup_1[i *10 +1] = EtatBOf[i *10 +1] ;
      valueButtonGroup_1[i *10 +2] = EtatBOf[i *10 +2] ;
      valueButtonGroup_1[i *10 +3] = EtatBOf[i *10 +3] ;
      valueButtonGroup_1[i *10 +4] = EtatBOf[i *10 +4] ;
      valueButtonGroup_1[i *10 +5] = EtatBOf[i *10 +5] ;
      if (dropdown[i+1] != null) valueButtonGroup_1[i *10 +9] = dropdown[i+1].getSelection() ;
    }
  }
  
  //BUTTON GROUP TWO
  if(numGroup[2] > 0 ) {
    for ( int i = 0 ; i < numGroup[2] ; i ++) {
      valueButtonGroup_2[i *10 +1] = EtatBTf[i *10 +1] ;
      valueButtonGroup_2[i *10 +2] = EtatBTf[i *10 +2] ;
      valueButtonGroup_2[i *10 +3] = EtatBTf[i *10 +3] ;
      valueButtonGroup_2[i *10 +4] = EtatBTf[i *10 +4] ;
      valueButtonGroup_2[i *10 +5] = EtatBTf[i *10 +5] ;
      int whichDropdown = i+1 +numGroup[1] ;
      if (dropdown[whichDropdown] != null) valueButtonGroup_2[i *10 +9] = dropdown[whichDropdown].getSelection() ;
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






int hueFillRank = 1 ;
int saturationFillRank = 2 ;
int brightnessFillRank = 3 ;
int alphaFillRank = 4 ;
int hueStrokeRank = 5 ;
int saturationStrokeRank = 6 ;
int brightnessStrokeRank = 7 ;
int alphaStrokeRank = 8 ;
int thicknessRank = 9 ;

int widthObjRank = 11 ;
int heightObjRank = 12 ;
int depthObjRank = 13 ;
int canvasXRank = 14 ;
int canvasYRank = 15 ;
int canvasZRank = 16 ;
int familyRank = 17 ;
int quantityRank = 18 ;
int lifeRank = 19 ;

int speedRank = 21 ;
int directionRank = 22 ;
int angleRank = 23 ;
int amplitudeRank = 24 ;
int attractionRank = 25 ;
int repulsionRank = 26 ;
int influenceRank = 27 ;
int alignmentRank = 28 ;
int analyzeRank = 29 ;








public void setDisplaySlider() {
  setSliderDynamic() ;
  giveNameSliderUsedByObject() ;
  listSliderInterface() ;
  recoverActiveSliderFromObj() ;
  listSliderObject() ;
}

public void setSliderDynamic() {
  sliderObj = new StringList [numObj +1] ;
  sliderObjRaw = new String [numObj +1] ;
  sliderObjListRaw = new String [numObj +1][NUM_SLIDER_OBJ +1] ;
  objectActive = new boolean[numObj +1] ;
  displaySlider = new boolean [NUM_GROUP_SLIDER] [NUM_SLIDER_OBJ +1] ;
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
    for( int j = 0 ; j < NUM_SLIDER_OBJ ; j++ ) {
      sliderObj[i].append("") ;
    }
  }
  // had value to the slider list object
  for (int i = 0 ; i <= numObj ; i++) {
    String [] listSliderTemp = splitText(sliderObjRaw[i], (",")) ;
    for( int j = 0 ; j < NUM_SLIDER_OBJ ; j++ ) {
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


String  sliderName [] = new String[NUM_SLIDER_TOTAL +1] ;


public void giveNameSliderUsedByObject() {
  sliderName[0] = ("not used") ;
  sliderName[1] = ("Hue fill") ;
  sliderName[2] = ("Saturation fill") ;
  sliderName[3] = ("Brightness fill") ;
  sliderName[4] = ("Alpha fill") ;
  sliderName[5] = ("Hue stroke") ;
  sliderName[6] = ("Saturation stroke") ;
  sliderName[7] = ("Brightness stroke") ;
  sliderName[8] = ("Alpha stroke") ;
  sliderName[9] = ("Thickness") ;
  sliderName[10] = ("not used") ;

  sliderName[11] = ("Size X") ;
  sliderName[12] = ("Size Y") ;
  sliderName[13] = ("Size Z") ;
  sliderName[14] = ("Canvas X") ;
  sliderName[15] = ("Canvas Y") ;
  sliderName[16] = ("Canvas Z") ;
  sliderName[17] = ("Family") ;
  sliderName[18] = ("Quantity") ;
  sliderName[19] = ("Life") ;
  sliderName[20] = ("not used") ;

  sliderName[21] = ("Speed") ;
  sliderName[22] = ("Direction") ;
  sliderName[23] = ("Angle") ;
  sliderName[24] = ("Amplitude") ;
  sliderName[25] = ("Attraction") ;
  sliderName[26] = ("Repulsion") ;
  sliderName[27] = ("Alignment") ;
  sliderName[28] = ("Influence") ;
  sliderName[29] = ("Analyze") ;
  sliderName[30] = ("not used") ;
}


public void listSliderInterface() {
  for(int i = 0 ; i <NUM_SLIDER_TOTAL ; i++) {
    sliderControler.append(sliderName[i]) ;
  }
}



// DRAW
public void checkSliderObject() {
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
      for(int j = 0 ; j <NUM_SLIDER_OBJ ; j++) {
        displaySlider[i][j] = false ;
      }
    }
   
    //active slider
    int IDgroup = 0 ;
     if (showAllSliders) {
      for ( int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
        for ( int j = 1 ; j < NUM_SLIDER_OBJ ; j++) {
        displaySlider[i][j] = true ;
        }
      }
    } else {
      for ( int i = 1 ; i <= numObj ; i++) {
        if (objectActive[i]) {
          for (int j = 1 ; j < NUM_GROUP_SLIDER ; j++) {
           if (objectGroup[i] == j) { IDgroup = j ;
              for(int k = 1 ; k < NUM_SLIDER_OBJ ; k++) {
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
  
  if(activityParameter) resetSlider = true ;
  activityParameter = false ;
}




//END GLOBAL

//SETUP
public void loadSetup() {
  buildSaveTable() ;
  createInfoButtonAndSlider(sketchPath("")+"preferences/setting/defaultSetting.csv") ;
  loadSaveController(sketchPath("")+"preferences/setting/defaultSetting.csv") ;
  
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
int valueButtonGroup_0[], valueButtonGroup_1[], valueButtonGroup_2[] ; 
Simple  BOmidi, BOcurtain,
        buttonBackground, 
        buttonLightAmbient, buttonLightAmbientAction,
        buttonLightOne, buttonLightOneAction,
        buttonLightTwo, buttonLightTwoAction,
        Bbeat, Bkick, Bsnare, Bhat;
        
//button group one
Simple[] BOf  ;
int transparenceBordBOf[], epaisseurBordBOf[], transparenceBoutonBOf[], posWidthBOf[], posHeightBOf[], longueurBOf[], hauteurBOf[]  ;
//button group two
Simple[] BTf  ;
int transparenceBordBTf[], epaisseurBordBTf[], transparenceBoutonBTf[], posWidthBTf[],posHeightBTf[], longueurBTf[], hauteurBTf[]  ;
//bouton group three
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
  initVarSlider() ;
  initVarButton() ;
  infoByObject() ;
  infoShaderBackground() ;
}

public void initVarSlider() {
  for (int i = 0 ; i < NUM_SLIDER_TOTAL ;i++) {
    sizeSlider[i] = new PVector() ;
    posSlider[i] = new PVector() ; 
  }
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
  
  numButton[0] = 18 ;
  for (int i = 1 ; i < NUM_GROUP_SLIDER ; i++ ) {
    numButton[i] = numGroup[i]*10 ;
    numButtonTotalObjects += numGroup[i] ;
  }

  numDropdown = numObj +1 ; // add one for the dropdownmenu
  lastDropdown = numDropdown -1 ;
  
  valueButtonGroup_0 = new int[numButton[0]] ;
  valueButtonGroup_1 = new int[numButton[1]] ;
  valueButtonGroup_2 = new int[numButton[2]] ;
  // Group one
  BOf = new Simple[numButton[1] +10] ;
  transparenceBordBOf =      new int[numButton[1] +10] ;
  epaisseurBordBOf =         new int[numButton[1] +10] ;
  transparenceBoutonBOf =    new int[numButton[1] +10] ;
  posWidthBOf =              new int[numButton[1] +10] ;
  posHeightBOf =             new int[numButton[1] +10] ;
  longueurBOf =              new int[numButton[1] +10] ;
  hauteurBOf =               new int[numButton[1] +10] ;
  
  // group two
  BTf = new Simple[numButton[2] +10] ;
  transparenceBordBTf =      new int[numButton[2] +10] ;
  epaisseurBordBTf =         new int[numButton[2] +10] ;
  transparenceBoutonBTf =    new int[numButton[2] +10] ;
  posWidthBTf =              new int[numButton[2] +10] ;
  posHeightBTf =             new int[numButton[2] +10] ;
  longueurBTf =              new int[numButton[2] +10] ;
  hauteurBTf =               new int[numButton[2] +10] ;
  

  
  //param\u00e8tre bouton
  EtatBOf = new int[numButton[1]] ;
  EtatBTf = new int[numButton[2]] ;
  
  //dropdown
  modeListRomanesco = new String[numDropdown] ;
  dropdown = new Dropdown[numDropdown] ;
  posDropdown = new PVector[numDropdown] ;
  startLoopObject = 1 ;
  endLoopObject = 1 +numGroup[1] ;
  startLoopTexture = endLoopObject ; 
  endLoopTexture = startLoopTexture +numGroup[2] ;

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
    for (int i = 0 ; i < NUM_SLIDER_TOTAL ;i++) {
      if (objectGroup == i) numGroup[i] += 1 ;
    }
  }
  //give the num total of objects
  numObj = numGroup[1] +numGroup[2] ;
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
  infoSlider = new Vec5 [countSlider] ;
  
  // we don't count from the save in case we add object and this one has never use before and he don't exist in the data base
  infoButton = new PVector [numObj*4 +10] ; 
  for(int i = 0 ; i < infoButton.length ; i++) infoButton[i] = new PVector() ;
}
//////////////////////////////////









/////////////
// SAVE LOAD

// SAVE
///////
String savePathSetting = ("") ;
public void saveSetting(File selection) {
  savePathSetting = selection.getAbsolutePath() ;
  if (selection != null) saveSetting(savePathSetting) ;
}

public void saveSetting(String path) {
  saveInfoSlider() ;
  midiButtonManager(true) ;
  saveTable(saveSetting, path+".csv");
  saveSetting.clearRows() ;
}



// SAVE SLIDERS
// save the position and the ID of the slider molette
public void saveInfoSlider() {
  //group zero
  for (int i = 1 ; i < NUM_SLIDER_MISC ; i++) {
     // set PVector info Slider
     int temp = i-1 ;
     infoSlider[temp].c = slider[i].getValue() ;
     infoSlider[temp].d = slider[i].getValueMin() ;
     infoSlider[temp].e = slider[i].getValueMax() ;
     setSlider(i, (int)infoSlider[temp].b, infoSlider[temp].c,infoSlider[temp].d,infoSlider[temp].e) ;
   }
  
  // the group one, two, three
  for (int i = 1 ; i < NUM_GROUP_SLIDER ; i++) { 
    for(int j = 1 ; j < NUM_SLIDER_OBJ ; j++) {
      // set PVector info Slider
      int IDslider = j +(i *100) ;
      // third loop to check and find the good PVector array in the list
      for(int k = 0 ; k < infoSlider.length ;k++) {
        if( (int)infoSlider[k].a ==IDslider) {
          infoSlider[k].c = slider[IDslider].getValue() ;
          infoSlider[k].d = slider[IDslider].getValueMin() ;
          infoSlider[k].e = slider[IDslider].getValueMax() ;
          setSlider(IDslider, (int)infoSlider[k].b, infoSlider[k].c,infoSlider[k].d,infoSlider[k].e) ;
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
//
public void setSlider(int IDslider, int IDmidi, float value, float min, float max) {
  TableRow sliderSetting = saveSetting.addRow() ;
  sliderSetting.setString("Type", "Slider") ;
  sliderSetting.setInt("ID slider", IDslider) ;
  sliderSetting.setInt("ID midi", IDmidi) ;
  sliderSetting.setFloat("Value slider", value) ; 
  sliderSetting.setFloat("Min slider", min) ; 
  sliderSetting.setFloat("Max slider", max) ; 
}

public void buildSaveTable() {
  saveSetting = new Table() ;
  saveSetting.addColumn("Type") ;
  saveSetting.addColumn("ID slider") ;
  saveSetting.addColumn("Min slider") ;
  saveSetting.addColumn("Max slider") ;
  saveSetting.addColumn("Value slider") ;
  saveSetting.addColumn("ID button") ;
  saveSetting.addColumn("On Off") ;
  saveSetting.addColumn("ID midi") ;
}


// END SAVE
///////////







//LOAD setting
//////
public void loadSettingController(File selection) {
  if (selection != null) {
    String loadPathControllerSetting = selection.getAbsolutePath();
    loadSaveSetting = true ;
    loadSaveController(loadPathControllerSetting) ;
    setSave = true ;
  } 
}









// loadSave(path) read info from save file
public void loadSaveController(String path) {
  Table settingTable = loadTable(path, "header");
  // re-init the counter for the new loop
  int countButton = 0 ;
  int countSlider = 0 ;
  for (TableRow row : settingTable.rows()) {
    String s = row.getString("Type") ;
    // button
    if( s.equals("Button")){ 
     int IDbutton = row.getInt("ID button") ;
     int IDmidi = row.getInt("ID midi") ;
     int onOff = row.getInt("On Off") ;
     /* if(countButton < infoButton.length) is used in case that the number is inferior at the number of object in save file */
     if(countButton < infoButton.length) infoButton[countButton] = new PVector(IDbutton,IDmidi,onOff) ;
     countButton++ ; 
    }
    // slider
    if( s.equals("Slider")){
     int IDslider = row.getInt("ID slider") ;
     int IDmidi = row.getInt("ID midi") ;
     float valueSlider = row.getFloat("Value slider") ; 
     float min = row.getFloat("Min slider") ;
     float max = row.getFloat("Max slider") ;
     infoSlider[countSlider] = new Vec5(IDslider,IDmidi,valueSlider,min,max) ;
     countSlider++ ;
    }
  }
}















// SETTING SAVE
/////////////////////////
Boolean setSave = true ;
public void settingDataFromSave() {
  if(setSave) {
    setButtonSave() ;
    setSliderSave() ;
    setSave = false ;
  }
}


// Setting SLIDER from save
public void setSliderSave() {
  for (int i = 1 ; i < NUM_SLIDER_MISC ; i++) {
    setttingSliderSave(i) ;
  }
  for (int i = 1 ; i < NUM_GROUP_SLIDER ; i++) { 
    for(int j = 1 ; j < NUM_SLIDER_OBJ ; j++) {
      int whichOne = j +(i *100) ;
      setttingSliderSave(whichOne) ;
    }
  }
}
// local method of setSliderSave()
public void setttingSliderSave(int whichOne) {
  Vec5 infoSliderTemp = infoSaveFromRawList(infoSlider, whichOne).copy() ;
  slider[whichOne].setMidi((int)infoSliderTemp.b) ; 
  slider[whichOne].setMolette(infoSliderTemp.c) ; 
  slider[whichOne].setMinMax(infoSliderTemp.d, infoSliderTemp.e) ;
  /*
  slider[whichOne].insideMin() ;
  slider[whichOne].insideMax() ;
  slider[whichOne].updateMinMax() ;
  */
}




//setting BUTTON from save
public void setButtonSave() {
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
}




// infoSaveFromRawList read info to translate and give a good position
public Vec5 infoSaveFromRawList(Vec5[] list, int pos) {
  Vec5 info = new Vec5() ;
  float valueSlider = 0 ;
  float valueSliderMin = 0 ;
  float valueSliderMax = 1 ;
  float IDmidi = 0 ;
  for(int i = 0 ; i < list.length ;i++) {
    if(list[i] != null ) if((int)list[i].a == pos) {
      valueSlider = list[i].c ;
      valueSliderMin = list[i].d ;
      valueSliderMax = list[i].e ;
      IDmidi = list[i].b ;
      info = new Vec5(pos, IDmidi,valueSlider,valueSliderMin,valueSliderMax) ;
      break;
    } else {
      info = new Vec5(-1,-1,-1,-1,-1) ;
    }
  }
  return info ;
}
// END SETTING SAVE
///////////////////











//LOAD text Interface
Table textGUI;
int numCol = 15 ;
String[] genTxtGUI = new String[numCol] ;
String[] sliderNameLight = new String[numCol] ;
String[] sliderNameCamera = new String[numCol] ;
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
      String whichCol = Integer.toString(j) ;
      if ( i == 0 ) genTxtGUI[j] = row[i].getString("Column "+whichCol) ;
      if ( i == 1 ) sliderNameLight[j] = row[i].getString("Column "+whichCol) ;
      if ( i == 2 ) sliderNameCamera[j] = row[i].getString("Column "+whichCol) ;
      if ( i == 3 ) sliderNameOne[j] = row[i].getString("Column "+whichCol) ;
      if ( i == 4 ) sliderNameTwo[j] = row[i].getString("Column "+whichCol) ;
      if ( i == 5 ) sliderNameThree[j] = row[i].getString("Column "+whichCol) ;
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
  int num = numGroup[1] +numGroup[2] +1 ;
  OFF_in_thumbnail = new PImage[num] ;
  OFF_out_thumbnail = new PImage[num] ;
  ON_in_thumbnail = new PImage[num] ;
  ON_out_thumbnail = new PImage[num] ;
  for(int i=0 ;  i<num ; i++ ) {
    String className = ("0") ;
    if (objectLoadName[i] != null ) className = objectLoadName[i] ;
    OFF_in_thumbnail[i] = loadImage("thumbnail/OFF_in/OFF_in_"+className+".png") ;
    OFF_out_thumbnail[i] = loadImage("thumbnail/OFF_out/OFF_out_"+className+".png") ;
    ON_in_thumbnail[i] = loadImage("thumbnail/ON_in/ON_in_"+className+".png") ;
    ON_out_thumbnail[i] = loadImage("thumbnail/ON_out/ON_out_"+className+".png") ;
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
   if(ON_in[whichOne] != null && ON_out[whichOne] != null && OFF_in[whichOne] != null && OFF_out[whichOne] != null ) {
     if (onOff) {
       if (rollover() && !dropdownActivity) image(ON_in[whichOne],pos.x +correctionX, pos.y) ; else image(ON_out[whichOne],pos.x +correctionX, pos.y) ;
     } else {
       if (rollover() && !dropdownActivity) image(OFF_in[whichOne],pos.x +correctionX, pos.y) ; else image(OFF_out[whichOne],pos.x +correctionX, pos.y) ;
     }
   }
 }
 public void buttonPic(PImage [] pic) {
   int correctionX = -1 ;
   if(pic[0] != null && pic[1] != null && pic[2] != null && pic[3] != null ) {
     if (onOff) {
       if (rollover() && !dropdownActivity) image(pic[1],pos.x +correctionX, pos.y ) ; else image(pic[0],pos.x +correctionX, pos.y ) ;
     } else {
       if (rollover() && !dropdownActivity) image(pic[3],pos.x +correctionX, pos.y ) ; else image(pic[2],pos.x +correctionX, pos.y) ;
     }
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

 ///BUTTON Text
 public void buttonText(String s, int x, int y) {
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
 
 public void buttonText(String s, PVector pos, PFont font, int sizeFont) {
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
// DROPDOWN february 2015 adaptation of version 2c work with SLIDER 5g by Stan le Punk


boolean dropdownOpen ; // use to indicate to indicate at the other button, they cannot be used when the user are on the dropdown menu

// CLASS
public class Dropdown {
  //Slider dropdown
  Slider sliderDropdown ;
  // private PFont fontDropdown ;
  private PVector posSliderDropdown, sizeSliderDropdown, sizeMoletteDropdown, sizeBoxDropdownMenu ; 
  private PVector posMoletteDropdown = new PVector(0,0) ; 
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
      
      float factorSizeMolette = PApplet.parseFloat(listItem.length) / PApplet.parseFloat(endingDropdown -1 ) ;
      
      sizeMoletteDropdown =  new PVector (sizeSliderDropdown.x, sizeSliderDropdown.y /factorSizeMolette) ;
      
      sliderDropdown = new Slider(posSliderDropdown, posMoletteDropdown, sizeSliderDropdown, sizeMoletteDropdown, "RECT") ;
       sliderDropdown.setting() ;
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
      for ( int i = startingDropdown +updateDropdown ; i < endingDropdown +updateDropdown ; i++) {
        //bottom rendering
        renderBox(listItem[i], step++, sizeBoxDropdownMenu, dropdownFont, colorTextBox);
        //Slider dropdown
        if (slider) {
          sliderDropdown.insideMol_Rect() ;
          sliderDropdown.updateMolette() ;
          sliderDropdown.sliderDisplay(colorBG,colorBG,0) ;
          sliderDropdown.displayMolette(jaune, orange, jaune, orange, 0) ;
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
      orange, jauneOrange, jaune, 
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
   vertClair = color (100,20,100) ;     
   vert = color(100,50,70) ; 
   vertFonce = color(100,100,50) ; 
   vertTresFonce = color(100,100,30) ;
   rougeTresFonce = color(10, 100, 50) ; 
   rougeFonce = color (10, 100, 70) ;  
   rouge = color(10,100,100) ;            
   orange = color (35,100,100) ; 
   jauneOrange = color (42,100,100) ; 
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
    String path = sketchPath("") +"/" +preferencesPath +"Images" ; 
    
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
    String path = sketchPath("") +"/" +preferencesPath +"Karaoke" ; 
    
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
// SLIDER may 2015 version 5g by Stan le Punk
////////////////
// CLASS SLIDER
public class Slider {
  protected PVector pos, size, posMol, posText, sizeMol, posMin, posMax ;
  protected PVector newPosMol = new PVector() ;
  protected int sliderColor = color(60) ;
  protected int molIn = color(255) ;
  protected int molOut = color(125) ;
  protected int colorText = color(0) ; ;
  protected boolean lockedMol, insideMol ;
  protected PFont p ;
  protected float minNorm = 0 ;
  protected float maxNorm = 1 ;
  // advance slider
  protected int newValMidi ;
  protected int IDmidi = -2 ;
  protected String moletteShapeType = ("") ;
  
  // CLASSIC CONSTRUCTOR
  //CONSTRUCTOR with title
  public Slider(PVector pos, PVector posMol , PVector size, PVector posText, PFont p) {
    this.pos = pos.copy() ;
    this.posMol = new PVector(pos.x + (posMol.x*size.x), pos.y +(posMol.y*size.y)) ;
    this.size = size.copy() ;
    this.posText = posText ;
    this.p = p ;

    //which molette for slider horizontal or vertical
    if (size.x >= size.y) sizeMol = new PVector (size.y, size.y) ; else sizeMol = new PVector (size.x, size.x ) ;
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      posMin = new PVector (pos.x, pos.y) ;
      posMax = new PVector (pos.x +size.x +size.y,  pos.y) ;
    } else {
      posMin = new PVector (pos.x, pos.y) ;
      float correction = sizeMol.y  + sizeMol.x ;
      posMax = new PVector (pos.x,  pos.y  +size.x +size.y -correction) ;
    }
  }
  
  //CONSTRUCTOR minimum
  public Slider(PVector pos, PVector posMol, PVector size) {
    this.pos = pos.copy() ;
    this.posMol = new PVector(pos.x + (posMol.x*size.x), pos.y +(posMol.y*size.y)) ;
    this.size = size.copy() ;

    //which molette for slider horizontal or vertical
    if (size.x >= size.y) sizeMol = new PVector (size.y, size.y) ; else sizeMol = new PVector (size.x, size.x) ;
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      posMin = new PVector (pos.x, pos.y) ;
      posMax = new PVector (pos.x +size.x +size.y,  pos.y) ;
    } else {
      posMin = new PVector (pos.x, pos.y) ;
      float correction = sizeMol.y  + sizeMol.x ;
      posMax = new PVector (pos.x,  pos.y  +size.x +size.y -correction) ;
    }
  }
  
  //slider with external molette
  public Slider(PVector pos, PVector posMol , PVector size, PVector sizeMol, String moletteShapeType) {
    this.pos = pos.copy() ;
    this.posMol = new PVector(pos.x +(posMol.x *size.x), pos.y +(posMol.y *size.y)) ;
    this.sizeMol = sizeMol.copy() ;
    this.size = size.copy() ;
    this.moletteShapeType = moletteShapeType ;
    // calculate minimum and maxium position of the molette
    if(size.x > size.y) {
      posMin = new PVector (pos.x, pos.y) ;
      posMax = new PVector (pos.x +size.x +size.y,  pos.y) ;
    } else {
      posMin = new PVector (pos.x, pos.y) ;
      float correction = sizeMol.y  + sizeMol.x ;
      posMax = new PVector (pos.x,  pos.y  +size.x +size.y -correction) ;
    }
  }
  
  // END CONSTRUCTOR
  
  

  
  
  
  
  
  // METHODES
  //SETTING
  
  public void setting() {
    /* May be it's possible to remove this method to includ that in the constructor ?
    but now we need that to init the molette */
    this.newPosMol = posMol.copy() ;
  }
  
  

  public void setMidi(int IDmidi) {
    this.IDmidi = IDmidi ;
  }
  
  
  // setting the position from a specific value
  public void setMolette(float normPos) {
    // security to constrain the value in normalizing range.
    if(normPos > 1.f) normPos = 1.f ;
    if(normPos < 0) normPos = 0 ;
    // check if it's horizontal or vertical slider
    if(size.x >= size.y) newPosMol.x = size.x *normPos +posMin.x -(sizeMol.y *normPos)  ; else newPosMol.y = size.y *normPos +posMin.y -(sizeMol.x *normPos);
  }
  // END SETTING
  
  
  
  // UPDATE
  // update molette position
  public void updateMolette() {
    // move the molette is this one is locked
    // security
    if(size.x >= size.y) {
      // for the horizontal slider
      if (newPosMol.x < posMin.x ) newPosMol.x = posMin.x ;
      if (newPosMol.x > posMax.x ) newPosMol.x = posMax.x ;
    } else {
      // for the vertical slider
      if (newPosMol.y < posMin.y ) newPosMol.y = posMin.y ;
      if (newPosMol.y > posMax.y ) newPosMol.y = posMax.y ;
    }
    
    
    if (lockedMol()) lockedMol = true ;
    if (!mousePressed) lockedMol = false ; 
    if (lockedMol) {  
      if (size.x >= size.y) newPosMol.x = constrain(mouseX -(sizeMol.x *.5f), posMin.x, posMax.x) ; else newPosMol.y = constrain(mouseY -(sizeMol.y *.5f), posMin.y, posMax.y) ;
    }
  }
  

  
  
  
  
  
  
  // DISPLAY SLIDER
  //Slider display classic
  public void sliderDisplay() {
    fill(sliderColor) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
  }
  
  // slider display advanced
  public void sliderDisplay(int sliderColor, int sliderStrokeColor, float thickness) {
    this.sliderColor = sliderColor ;
    fill(sliderColor) ;
    stroke(sliderStrokeColor) ;
    strokeWeight(thickness) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    noStroke() ;
  }
  //Slider update with title
  public void sliderDisplayText(String s, boolean t) {
    //SLIDER
    fill(sliderColor) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    if (t) {
      fill(colorText) ;
      textFont (p) ;
      textSize (posText.z) ;
      text(s, posText.x, posText.y ) ;
    }
  }
  
  
  // DISPLAY MOLETTE
  //display molette
  public void displayMolette() {
    if(lockedMol || insideMol) fill(molIn); else fill(molOut ) ;
     shapeMolette() ;
  }
  
  // display molette advanced
  public void displayMolette(int molIn, int molOut, int strokeIn, int strokeOut, float thickness) {
    this.molIn = molIn ;
    this.molOut = molOut ;

    strokeWeight(thickness) ;
    if(lockedMol || insideMol) {
      fill(molIn);
      stroke(strokeIn) ;
    } else {
      fill(molOut ) ;
      stroke(strokeOut) ;
    }
    shapeMolette() ;
    
    noStroke() ;
  }
  
  
 


  

  
  
  
  
  
  

  //ANNEXE VOID
  // display the molette
  public void shapeMolette() {
    if(moletteShapeType.equals("ELLIPSE") ) {
      ellipse(sizeMol.x *.5f +newPosMol.x, size.y *.5f +newPosMol.y, sizeMol.x , sizeMol.y) ;
    } else if(moletteShapeType.equals("RECT")) {
      rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
    } else rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
  }
  
  
  /* return the position of the molette, the minium and the maximum between 0 and 1
  @ return float
  */
  public float getValue() {
    float value ;
    if (size.x >= size.y) value = map (newPosMol.x, posMin.x, posMax.x, minNorm, maxNorm) ; 
                          else value = map (newPosMol.y, posMin.y, posMax.y, minNorm, maxNorm) ;
    return value ;
  }
  
  public float getValueMin() {
    return minNorm ;
  }
  public float getValueMax() {
    return maxNorm ;
  }
  
  
  // check if the mouse is inside the molette or not
  //rect
  public boolean insideSlider() { 
    if(insideRect(pos, size)) insideMol = true ; else insideMol = false ;
    return insideMol ;
  }
  
  
  public boolean insideMol_Rect() {
    if(insideRect(newPosMol, sizeMol)) insideMol = true ; else insideMol = false ;
    return insideMol ;
  }
  

  //ellipse
  public boolean insideMol_Ellipse() {
    float radius = sizeMol.x ;
    int posX = PApplet.parseInt(radius *.5f +newPosMol.x ) ; 
    int posY = PApplet.parseInt(size.y *.5f +newPosMol.y) ;
    if(pow((posX -mouseX),2) + pow((posY -mouseY),2) < pow(radius,sqrt(3))) insideMol = true ; else insideMol = false ;
   return insideMol ;
  }
  
  
  
  //locked
  public boolean lockedMol() {
    if (insideMol && mousePressed ) return true ; else return false ;
  }
  
  // END CLASSIC METHOD
  /////////////////////
  
 
 
 
 
 
 
 
 
 
 ///////////////////
 // ADVANCED METHOD
 // update position from midi controller
  public void updateMidi(int val) {
    //update the Midi position only if the Midi Button move
    if (newValMidi != val) { 
      newValMidi = val ; 
      newPosMol.x = map(val, 1, 127, posMin.x, posMax.x) ;
    }
  }

  
  //////
  //VOID
  public void load(int load) {
    newPosMol.x = load ;
  }
  
  // give the ID from the controller Midi
  public void selectIDmidi(int num) { IDmidi = num ; }
  
  //give the IDmidi 
  public int IDmidi() { return IDmidi ; }
}

// END SLIDER
/////////////

















////////////////////////////////////////////////////
// SLIDER ADJUSTABLE : extends class of class Slider
public class SliderAdjustable extends Slider {
  // size
  protected PVector sizeMinMax = new PVector() ;
  protected PVector sizeMolMinMax = new PVector() ;
  int widthMinMax = 10 ;
  // pos  
  protected PVector posMinMax = new PVector() ;
  protected PVector newPosMin = new PVector() ;
  protected PVector newPosMax = new PVector() ;
  // color
  protected int adjIn = color(255) ;
  protected int adjOut = color(125) ; ;

  boolean lockedMin, lockedMax ;
  
  // CLASSIC CONSTRUCTOR
  SliderAdjustable (PVector pos, PVector posMol , PVector size, PVector posText, PFont p) {
    super(pos, posMol, size, posText, p) ;
    this.posMinMax = pos.copy() ;
    this.newPosMin = posMinMax.copy() ;
    this.sizeMinMax = size.copy() ;
    this.sizeMolMinMax = new PVector(widthMinMax, size.y) ;
  }
  
  SliderAdjustable(PVector pos, PVector posMol , PVector size) {
    super(pos, posMol, size) ;
    this.posMinMax = pos.copy() ;
    this.newPosMin = posMinMax.copy() ;
    this.sizeMinMax = size.copy() ;
    this.sizeMolMinMax = new PVector(widthMinMax, size.y) ;
  }
  
  //slider with external molette
  SliderAdjustable(PVector pos, PVector posMol , PVector size, PVector sizeMol, String moletteShapeType) {
    super(pos, posMol, size, sizeMol, moletteShapeType) ;
    this.posMinMax = pos.copy() ;
   // this.newPosMin = posMinMax.copy() ;
    this.sizeMinMax = size.copy() ;
    this.sizeMolMinMax = new PVector(widthMinMax, size.y) ;
  }
  // END CLASSIC CONSTRUCTOR
  /////////////////////////

  
  
  
  /////////
  // METHOD
  
  public void updateMinMax() {
    float newNormSize = maxNorm -minNorm ;
    
    if (size.x >= size.y) sizeMinMax = new PVector (size.x *newNormSize, size.y) ; else sizeMinMax = new PVector (size.y *newNormSize, size.x) ;
    
    posMin = new PVector (pos.x +(size.x *minNorm), pos.y) ;
    // in this case the detection is translate on to and left of the size of molette
    posMax = new PVector (pos.x -sizeMol.x +(size.x *maxNorm), pos.y) ;
  }
  
  // update Min and Max value
  // update min value
  public void updateMin() {
    float range = sizeMol.x *1.5f ;
    //
    if (lockedMin()) lockedMin = true ;
    if (!mousePressed) lockedMin = false ; 
    
    if (lockedMin) {  
      if (size.x >= size.y) {
        // security
        if (newPosMin.x < posMin.x ) newPosMin.x = posMin.x ;
        else if (newPosMin.x > posMax.x -range) newPosMin.x = posMax.x -range ;
        
        newPosMin.x = constrain(mouseX, pos.x, pos.x+size.x -range) ; 
        // norm the value to return to method minMaxSliderUpdate
        minNorm = map(newPosMin.x, posMin.x, posMax.x, minNorm,maxNorm) ;
      } else newPosMin.y = constrain(mouseY -sizeMinMax.y, posMin.y, posMax.y) ; // this line is not reworking for the vertical slider
    }
  }
  
  
  // update maxvalue
  public void updateMax() {
    float range = sizeMol.x *1.5f ;
    //
    if (lockedMax()) lockedMax = true ;
    if (!mousePressed) lockedMax = false ; 
    
    if (lockedMax) {  // this line is not reworking for the vertical slider
      if (size.x >= size.y) {
        // security
        if (newPosMax.x < posMin.x +range)  newPosMax.x = posMin.x +range ;
        else if (newPosMax.x > posMax.x ) newPosMax.x = posMax.x ;
         newPosMax.x = constrain(mouseX -(size.y *.5f) , pos.x +range, pos.x +size.x -(size.y *.5f)) ; 
         // norm the value to return to method minMaxSliderUpdate
        posMax = new PVector (pos.x -sizeMol.x +(size.x *maxNorm), pos.y) ;
        // we use a temporary position for a good display of the max slider 
        PVector tempPosMax = new PVector(pos.x -(size.y *.5f) +(size.x *maxNorm), posMax.y) ;
        maxNorm = map(newPosMax.x, posMin.x, tempPosMax.x, minNorm, maxNorm) ;
      } else newPosMax.y = constrain(mouseY -sizeMinMax.y, posMin.y, posMax.y) ; // this line is not reworking for the vertical slider
    }
    
  }
  
  // set min and max position
  public void setMinMax(float newNormMin, float newNormMax) {
    minNorm = newNormMin ;
    maxNorm = newNormMax ;
  }
  
  
  
  
  
  
  
  
  
  // Display classic
  public void displayMinMax() {
    if(lockedMin || lockedMax || insideMax() || insideMin()) fill(adjIn) ; else fill(adjOut) ;
    noStroke() ;
    rect(posMin.x, posMin.y +sizeMinMax.y *.4f, sizeMinMax.x, sizeMinMax.y *.3f) ;
    //  rect(newPosMin.x, newPosMin.y +sizeMinMax.y *.4, sizeMinMax.x, sizeMinMax.y *.3) ;
  }
  
  // Display advanced
 public void displayMinMax(float normPos, float normSize, int adjIn, int adjOut, int strokeIn, int strokeOut, float thickness) {
    this.adjIn = adjIn ;
    this.adjOut = adjOut ;
    strokeWeight(thickness) ;
    if(lockedMin || lockedMax || insideMax() || insideMin()) {
      fill(adjIn) ;
      stroke(strokeIn) ;
    } else {
      fill(adjOut) ;
      stroke(strokeOut) ;
    }
    rect(posMin.x, posMin.y +sizeMinMax.y *normPos, sizeMinMax.x, sizeMinMax.y *normSize) ;
    // rect(newPosMin.x, newPosMin.y +sizeMinMax.y *normPos, sizeMinMax.x, sizeMinMax.y *normSize) ;
    noStroke() ;
  }
  
  
  
  
  
  
  // ANNEXE
  // INSIDE
  public boolean insideMin() {
    if(insideRect(posMin, sizeMolMinMax)) return true ; else return false ;
  }
  
  public boolean insideMax() {
    PVector tempPosMax = new PVector(pos.x -(size.y *.5f) +(size.x *maxNorm), posMax.y) ;
    if(insideRect(tempPosMax, sizeMolMinMax)) return true ; else return false ;
  }
  
  //LOCKED
  public boolean lockedMin () {
    if (insideMin() && mousePressed) return true ; else return false ;
  }
  
  public boolean lockedMax () {
    if (insideMax() && mousePressed) return true ; else return false ;
  }
}
// END Extends class SLIDER
///////////////////////////
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



// MOUSE DETECTION
// CIRLCLE

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
// CLASS VEC 0.1.9
//////////////////
// inspireted by GLSL code and PVector

// VEC 2
////////////////
class Vec2 {
  float x,y = 0;
  float s,t = 0;
  float u,v = 0;
  
  Vec2() {
  }
  
  Vec2(float value) {
    this.x = this.y = this.s = this.t = this.u = this.v = value ;
  }
  
  Vec2(float x, float y) {
    this.x = this.s = this.u = x ;
    this.y = this.t = this.v = y ;
  }
  
  
  // multiplication
  /* multiply Vector by a float value */
  public void mult(float mult) {
    x *= mult ; y *= mult ;
    // update value
    s = u = x ;
    t = v = y ;
  }
  
  // mult by vector
  public void mult(Vec2 v_a) {
    x *= v_a.x ; y *= v_a.y ; 
    // update value
    s = u = x ;
    t = v = y ;
  }
  
  
    // division
  ///////////
  /*
  @ return Vec
  divide Vector by a float value */
  public void div(float div) {
    x /= div ; y /= div ; 
    // update value
    s = u = x ;
    t = v = y ;
  }
  
  // divide by vector
  public void div(Vec2 v_a) {
    x /= v_a.x ; y /= v_a.y ;  
    // update value
    s = u = x ;
    t = v = y ;
  }
  
  
  // addition
  ///////////
  /* add two Vector together */
  public Vec2 add(Vec2 v_a, Vec2 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y)  ;
  }
  
  /* mapping
  return mapping vector
  @return Vec2
  */
  public Vec2 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x,minIn, maxIn, minOut, maxOut) ;
    y = map(y,minIn, maxIn, minOut, maxOut) ;
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y) ;
  }
  
  /* magnitude or length of Vec2
  @ return float
  */
  /////////////////////
  public float mag() {
    x *= x ;
    y *= y ; 
    return sqrt(x+y) ;
  }

  public float mag(Vec2 v_target) {
    float new_x = (v_target.x -x) *(v_target.x -x) ;
    float new_y = (v_target.y -y) *(v_target.y -y) ;
    return sqrt(new_x +new_y) ;
  }
  
  
  // Distance
  ////////////
  /*
  @ return float
  distance between himself and an other vector
  */
  public float dist(Vec2 v_target) {
    float dx = x - v_target.x;
    float dy = y - v_target.y;
    return (float) Math.sqrt(dx*dx + dy*dy);
  }
  
  
  
  /*catch info
  /////////////
  return all the componant of Vec
  @return Vec2
  */
  public Vec2 copy() {
    return new Vec2(x,y) ;
  }
  /*
  return all the componant of Vec in type PVector
  @return PVector
  */
  public PVector copyVecToPVector() {
    return new PVector(x,y) ;
  }
  

}
// END VEC 2
////////////









// VEC 3
////////////////
class Vec3 {
  float x,y,z  = 0 ;
  float r, g, b = 0 ;
  float s, t, p = 0 ;
  Vec3() {}
  
  Vec3(float value) {
    this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = value ;
  }
  
  Vec3(float x, float y, float z) {
    this.x = this.r =this.s = x ;
    this.y = this.g =this.t = y ;
    this.z = this.b = this.p =z ;
  }
  
  // multiplication
  /* multiply Vector by a float value */
  public void mult(float mult) {
    x *= mult ; y *= mult ; z *= mult ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
  }
  
  // mult by vector
  public void mult(Vec3 v_a) {
    x *= v_a.x ; y *= v_a.y ; z *= v_a.z ; 
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
  }
  
  
  
  // division
  ///////////
  /*
  @ return Vec
  divide Vector by a float value */
  public void div(float div) {
    x /= div ; y /= div ; z /= div ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
  }
  
  // divide by vector
  public void div(Vec3 v_a) {
    x /= v_a.x ; y /= v_a.y ; z /= v_a.z ; 
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
  }
  
  
  
  // addition
  /* add two Vector together */
  public Vec3 add(Vec3 v_a, Vec3 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    z = v_a.z + v_b.z ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z)  ;
  }
  
  
  
  /*
  mapping
  return mapping vector
  @return Vec3
  */
  public Vec3 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x, minIn, maxIn, minOut, maxOut) ;
    y = map(y, minIn, maxIn, minOut, maxOut) ;
    z = map(z, minIn, maxIn, minOut, maxOut) ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z) ;
  }
  
  
  
  // Magnitude
  ////////////
  /* Magnitude or length of Vec3
  @ return float
  */
  /////////////////////
  public float mag() {
    x *= x ;
    y *= y ; 
    z *= z ;
    return sqrt(x+y+z) ;
  }

  public float mag(Vec3 v_target) {
    float new_x = (v_target.x -x) *(v_target.x -x) ;
    float new_y = (v_target.y -y) *(v_target.y -y) ;
    float new_z = (v_target.z -z) *(v_target.z -z) ;
    return sqrt(new_x +new_y +new_z) ;
  }
  
  // Distance
  ////////////
  /*
  @ return float
  distance himself and an other vector
  */
  public float dist(Vec3 v_target) {
    float dx = x - v_target.x;
    float dy = y - v_target.y;
    float dz = z - v_target.z;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
  }
  
  // catch info
  /////////////
  /*
  return all the component of Vec
  @return Vec3
  */
  public Vec3 copy() {
    return new Vec3(x,y,z) ;
  }
  /*
  return all the component of Vec in type PVector
  @return PVector
  */
  public PVector copyVecToPVector() {
    return new PVector(x,y,z) ;
  }
  
  
}
// END VEC 3
////////////






// VEC 4
////////
class Vec4 {
  float x,y,z,w = 0 ;
  float r, g, b, a = 0 ;
  float s, t, p, q = 0 ;
  
  Vec4 () {}
  
  Vec4(float value) {
    this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = value ;
  }
  
  Vec4(float x, float y, float z, float w) {
    this.x = this.r = this.s = x ;
    this.y = this.g = this.t =y ;
    this.z = this.b = this.p =z ;
    this.w = this.a = this.q = w ;
  }
  
  
  // multiplication
  // mult by float
  public void mult(float mult) {
    x *= mult ; y *= mult ; z *= mult ; w *= mult ;
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
  }
  
  // mult by vector
  public void mult(Vec4 v_a) {
    x *= v_a.x ; y *= v_a.y ; z *= v_a.z ; w *= v_a.w ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
  }
  
  
    // division
  ///////////
  /*
  @ return Vec
  divide Vector by a float value */
  public void div(float div) {
    x /= div ; y /= div ; z /= div ; w /= div ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
  }
  
  // divide by vector
  public void div(Vec4 v_a) {
    x /= v_a.x ; y /= v_a.y ; z /= v_a.z ; w /= v_a.w ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
  }
  
  // addition
  /* add two Vector together */
  public Vec4 add(Vec4 v_a, Vec4 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    z = v_a.z + v_b.z ;
    w = v_a.w + v_b.w ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w)  ;
  }
  
  /* mapping
  return mapping vector
  @return Vec4
  */
  public Vec4 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x, minIn, maxIn, minOut, maxOut) ;
    y = map(y, minIn, maxIn, minOut, maxOut) ;
    z = map(z, minIn, maxIn, minOut, maxOut) ;
    w = map(w, minIn, maxIn, minOut, maxOut) ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w) ;
  }
  
  // magnitude or length
  /////////////////////
  public float mag() {
    x *= x ;
    y *= y ; 
    z *= z ;
    w *= w ;  ;
    return sqrt(x+y+z+w) ;
  }

  public float mag(Vec4 v_target) {
    float new_x = (v_target.x -x) *(v_target.x -x) ;
    float new_y = (v_target.y -y) *(v_target.y -y) ;
    float new_z = (v_target.z -z) *(v_target.z -z) ;
    float new_w = (v_target.w -w) *(v_target.w -w) ;
    return sqrt(new_x +new_y +new_z +new_w) ;
  }
  
  // Distance
  ////////////
  // distance himself and an other vector
  public float dist(Vec4 v_target) {
    float dx = x - v_target.x;
    float dy = y - v_target.y;
    float dz = z - v_target.z;
    float dw = w - v_target.w;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
  }
    
  // catch info
  /////////////
  public Vec4 copy() {
    return new Vec4(x,y,z,w) ;
  }
}
// END VEC 4
////////////



// CLASS Vec5
/////////////

class Vec5 {
  float a,b,c,d,e = 0 ;

  
  Vec5 () {}
  
  Vec5(float value) {
    this.a = this.b = this.c = this.d = this.e = value ;
  }
  
  Vec5(float a, float b, float c, float d, float e) {
    this.a = a ;
    this.b = b ;
    this.c = c ;
    this.d = d ;
    this.e = e ;
  }
  // catch info
  /////////////
  public Vec5 copy() {
    return new Vec5(a,b,c,d,e) ;
  }
}

// END VEC 5
////////////












// External Methods VEC
///////////////////////



// Addition
// return the resultat of vector addition
public Vec2 add(Vec2 v_a, Vec2 v_b) {
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    return new Vec2(x,y) ;
}
public Vec3 add(Vec3 v_a, Vec3 v_b) {
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    float z = v_a.z + v_b.z ;
    return new Vec3(x,y,z)  ;
}
public Vec4 add(Vec4 v_a, Vec4 v_b) {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    float z = v_a.z * v_b.z ;
    float w = v_a.w * v_b.w ;
    return new Vec4(x,y,z, w)  ;
}


// Multiplication
// return the resultat of vector multiplication
public Vec2 mult(Vec2 v_a, Vec2 v_b) {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    return new Vec2(x,y) ;
}
public Vec3 mult(Vec3 v1, Vec3 v_b) {
    float x = v1.x * v_b.x ;
    float y = v1.y * v_b.y ;
    float z = v1.z * v_b.z ;
    return new Vec3(x,y,z)  ;
}
public Vec4 mult(Vec4 v_a, Vec4 v_b) {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    float z = v_a.z * v_b.z ;
    float w = v_a.w * v_b.w ;
    return new Vec4(x,y,z, w)  ;
}


// Division
// return the resultat of vector addition
public Vec2 div(Vec2 v_a, Vec2 v_b) {
    float x = v_a.x / v_b.x ;
    float y = v_a.y / v_b.y ;
    return new Vec2(x,y) ;
}
public Vec3 div(Vec3 v1, Vec3 v_b) {
    float x = v1.x / v_b.x ;
    float y = v1.y / v_b.y ;
    float z = v1.z / v_b.z ;
    return new Vec3(x,y,z)  ;
}
public Vec4 div(Vec4 v_a, Vec4 v_b) {
    float x = v_a.x / v_b.x ;
    float y = v_a.y / v_b.y ;
    float z = v_a.z / v_b.z ;
    float w = v_a.w / v_b.w ;
    return new Vec4(x,y,z, w)  ;
}


// compare two vectors Vec
/*
@ return boolean
*/
// Vec method
// Vec2 compare
public boolean compare(Vec2 v_a, Vec2 v_b) {
  if( v_a != null && v_b != null ) {
    if((v_a.x == v_b.x) && (v_a.y == v_b.y)) {
      return true ; 
    } else return false ;
  } else return false ;
}
// Vec3 compare
public boolean compare(Vec3 v_a, Vec3 v_b) {
  if( v_a != null && v_b != null ) {
    if((v_a.x == v_b.x) && (v_a.y == v_b.y) && (v_a.z == v_b.z)) {
            return true ; 
    } else return false ;
  } else return false ;
}
// Vec4 compare
public boolean compare(Vec4 v_a, Vec4 v_b) {
  if( v_a != null && v_b != null ) {
    if((v_a.x == v_b.x) && (v_a.y == v_b.y) && (v_a.z == v_b.z) && (v_a.w == v_b.w)) {
            return true ; 
    } else return false ;
  } else return false ;
}



/* Map
return mapping vector
@return Vec2, Vec3 or Vec4
*/
public Vec2 mapVec(Vec2 v,float minIn, float maxIn, float minOut, float maxOut) {
  float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
  float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
  return new Vec2(x,y) ;
}
public Vec3 mapVec(Vec3 v,float minIn, float maxIn, float minOut, float maxOut) {
  float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
  float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
  float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
  return new Vec3(x,y,z) ;
}
public Vec4 mapVec(Vec4 v,float minIn, float maxIn, float minOut, float maxOut) {
  float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
  float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
  float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
  float w = map(v.w, minIn, maxIn, minOut, maxOut) ;
  return new Vec4(x,y,z,w) ;
}


// Magnitude or Length Vector
/*
@return float
*/
// mag Vec2
public float mag(Vec2 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  return sqrt(x+y) ;
}

public float mag(Vec2 v_a, Vec2 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  return sqrt(x+y) ;
}
// mag Vec3
public float mag(Vec3 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  float z = v_a.z *v_a.z ;
  return sqrt(x+y+z) ;
}

public float mag(Vec3 v_a, Vec3 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  float z = (v_b.z -v_a.z)*(v_b.z -v_a.z) ;
  return sqrt(x+y+z) ;
}
// mag Vec4
public float mag(Vec4 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  float z = v_a.z *v_a.z ;
  float w = v_a.w *v_a.w ;
  return sqrt(x+y+z+w) ;
}

public float mag(Vec4 v_a, Vec4 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  float z = (v_b.z -v_a.z)*(v_b.z -v_a.z) ;
  float w = (v_b.w -v_a.w)*(v_b.w -v_a.w) ;
  return sqrt(x+y+z+w) ;
}



// Distance
/*
return float
return the distance beatwen two vectors
*/
public float dist(Vec2 v_a, Vec2 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    return (float) Math.sqrt(dx*dx + dy*dy);
}
public float dist(Vec3 v_a, Vec3 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    float dz = v_a.z - v_b.z;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
}
public float dist(Vec4 v_a, Vec4 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    float dz = v_a.z - v_b.z;
    float dw = v_a.w - v_b.w;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
}


// Middle
////////
/*
@ return Vec2, Vec3 or Vec4
return the middle between two Vector
*/
public Vec4 middle(Vec4 p1, Vec4 p2)  {
  Vec4 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}

public Vec3 middle(Vec3 p1, Vec3 p2)  {
  Vec3 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}

public Vec2 middle(Vec2 p1, Vec2 p2)  {
  Vec2 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}


// Copy 
/*
@ return Vec3
Transform PVector in Vec
*/
public Vec3 copyPVectorToVec(PVector p) {
  return new Vec3(p.x,p.y,p.z) ;
}







// return a Vec value
// Vec 5
////////
public Vec5 Vec5(float a, float b, float c, float d, float e) {
  return new Vec5(a,b,c,d,e) ;
}

public Vec5 Vec5(float v) {
  return new Vec5(v) ;
}

public Vec5 Vec5() {
  return new Vec5(0.f) ;
}

// Vec 4
////////
public Vec4 Vec4(float x, float y, float z, float w) {
  return new Vec4(x,y,z,w) ;
}

public Vec4 Vec4(float v) {
  return new Vec4(v) ;
}

public Vec4 Vec4() {
  return new Vec4(0.f) ;
}

// Vec 3
////////
public Vec3 Vec3(float x, float y, float z) {
  return new Vec3(x,y,z) ;
}

public Vec3 Vec3(float v) {
  return new Vec3(v) ;
}

public Vec3 Vec3(PVector p) {
  return new Vec3(p.x, p.y, p.z) ;
}

public Vec3 Vec3() {
  return new Vec3(0.f) ;
}

// Vec 2
////////
public Vec2 Vec2(float x, float y) { 
  return new Vec2(x,y) ;
}

public Vec2 Vec2(float v) {
  return new Vec2(v) ;
}

public Vec2 Vec2(PVector p) {
  return new Vec2(p.x, p.y) ;
}

public Vec2 Vec2() {
  return new Vec2(0.f) ;
}
// END CLASS VEC
///////////////
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Controleur_27" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
