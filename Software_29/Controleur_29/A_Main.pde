/**
Build interface 3.0.2
Romanesco Processing Environment
*/
/**
VARIABLE declaration

*/


import java.awt.event.KeyEvent;
import java.awt.image.* ;
import java.awt.* ;

// CONSTANT VAR
final int NUM_COL_SLIDER = 3 ;
final int BUTTON_BY_OBJECT = 4 ;
final int NUM_GROUP_SLIDER = 2 ; // '1' for the global, an other for the item
final int NUM_SLIDER_MISC = 30 ;
final int NUM_SLIDER_TOTAL = 200 ;
final int NUM_SLIDER_OBJ = 30 ;
final int SLIDER_BY_COL = 9 ;
// Obj
int NUM_ITEM ;
int STEP_ITEM = 40 ;



int sliderMidi, midi_value_romanesco, midi_channel_romanesco ;
int midi_CC_romanesco = -1 ;
boolean saveMidi ;
boolean selectMidi = false ;
//curtain
boolean curtainOpenClose ;
//GLOBAL

// Save Setting var
int [] info_list_item_ID ; 
Vec5 [] infoSlider ; 
PVector [] infoButton ;

// slider mode display
int sliderModeDisplay = 0 ;


boolean[] keyboard = new boolean[526];
boolean loadSaveSetting = false ;
boolean ouvrirFichier = false ;

//LOAD PICTURE VIGNETTE
int numVignette ;








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

PVector [] sizeSlider = new PVector[NUM_SLIDER_TOTAL] ;
PVector [] posSlider = new PVector[NUM_SLIDER_TOTAL] ; 

float valueSlider[] = new float[NUM_SLIDER_TOTAL] ;


int SWITCH_VALUE_FOR_DROPDOWN = -2 ;



//Background / light one / light two
int state_BackgroundButton,
    state_LightAmbientButton, state_LightAmbientAction,
    state_LightOneButton, state_LightOneAction, 
    state_LightTwoButton, state_LightTwoAction ;
Vec2 pos_bg_button, size_bg_button,
        posLightAmbientAction, sizeLightAmbientAction, posLightAmbientButton, sizeLightAmbientButton,
        posLightOneAction, sizeLightOneAction, posLightOneButton, sizeLightOneButton,
        posLightTwoAction, sizeLightTwoAction, posLightTwoButton, sizeLightTwoButton ;


// DROPDOWN button font and shader background
int state_font, state_bg_shader, state_image, state_file_text, state_camera_video ;
Vec2 pos_button_font, pos_button_bg, pos_button_image, pos_button_file_text, pos_button_camera_video ; 

// MIDI, CURTAIN
int state_midi_button, state_curtain_button, state_button_beat, state_button_kick, state_button_snare, state_button_hat ; ;
Vec2 pos_midi_button, size_midi_button, pos_midi_info,
        pos_curtain_button, size_curtain_button,
        pos_beat_button, size_beat_button,
        pos_kick_button, size_kick_button,
        pos_snare_button, size_snare_button,
        pos_hat_button, size_hat_button ;


// slider position column
int posXSlider[] = new int[NUM_SLIDER_TOTAL *2] ;

// END variables declaration
////////////////////////////////////














// PARAMETER
/////////////////////////////////
float ratioNormSizeMolette = 1.3 ; 
int sliderWidth = 140 ;
int sliderHeight = 10 ;
int roundedSlider = 5 ;
/*  the position is calculated in ratio of the slider position. Not optimize for the vertical slider */
float normPosSliderAdjustable = .5 ; 
/*the height size is calculated in ratio of the slider height size.  Not optimize for the vertical slider */
float normSizeSliderAdjustable =.2 ; 

// vertical grid
int colOne = 35 ; 
int colTwo = int(1.5 *sliderWidth +colOne)  ; 
int colThree = int(1.5 *sliderWidth +colTwo) ;
int margeLeft  = colOne +15 ;

// horizontal grid

// this not a position but the height of the rectangle
int lineHeader = 30 ;
int lineMenuTopDropdown = 65 ;
int line_global = 95 ;
int line_item_button_slider = 320 ;
int line_item_menu_text = line_item_button_slider +230 ;


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
int correctionHeaderdropdown_fontX = 110 ;
int correctionHeaderdropdown_imageX = 220 ;
int correctionHeaderdropdown_file_textX = 330 ;
int correctionHeaderdropdown_camera_videoX = 440 ;

//GROUP ZERO
int correctionSliderPos = 12 ;
int set_item_pos_y = 13 ;
// GROUP BG
int correctionBGX = colOne ;
int correctionBGY = line_global +set_item_pos_y +2 ;

// GROUP LIGHT

// ambient light
int correctionLightAmbientX = colOne ;
int correctionLightAmbientY = line_global +set_item_pos_y +73 ;

// directional light one
int correctionLightOneX = colTwo ;
int correctionLightOneY = line_global +set_item_pos_y +13 ;
// directional light two
int correctionLightTwoX = colTwo ;
int correctionLightTwoY = line_global +set_item_pos_y +73 ;

// GROUP CAMERA
int correctionCameraX = colThree ;
int correctionCameraY = line_global +set_item_pos_y -5 ;




// GROUP SOUND
int correctionSoundX = colOne ;
int correctionSoundY = line_global +160 ;



// GROUP ITEM
int correction_slider_item = 65 ;
int correction_button_item = 3 ;
int correction_dropdown_item = 43 ;


// GROUP MIDI
int correctionMidiX = 40 ;
int correctionMidiY = 0 ;
int spacing_midi_info = 13 ;
int correction_info_midi_x = 60 ;
int correction_info_midi_y = 10 ;
int size_x_window_info_midi = 200 ;

/**
END VARIABLES declaration
*/



















/**
SETTING
*/

void setting() {
  // size(670,725); 
  colorSetup() ;  

  frameRate(60) ; 
  noStroke () ; 
  surface.setResizable(true);
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





void buildLibrary() {
  objectList = loadTable(sketchPath("")+"preferences/objects/index_romanesco_objects.csv", "header") ;
  shaderBackgroundList = loadTable(sketchPath("")+"preferences/shader/shaderBackgroundList.csv", "header") ;
  numByGroup() ;
  initVarObject() ;
  init_slider() ;
  init_button() ;
  infoByObject() ;
  infoShaderBackground() ;
}



void initVarObject() {

  item_library_sort = new int [NUM_ITEM +1] ;
  item_ID = new int [NUM_ITEM +1] ;
  item_group = new int [NUM_ITEM +1] ;
  item_GUI_on_off = new int [NUM_ITEM +1] ;

  item_name = new String [NUM_ITEM +1] ;
  item_author = new String [NUM_ITEM +1] ;
  item_version = new String [NUM_ITEM +1] ;
  item_pack = new String [NUM_ITEM +1] ;
  item_load_name = new String [NUM_ITEM +1] ;
  item_slider = new String [NUM_ITEM +1] ;

}






void infoShaderBackground() {
  int n = shaderBackgroundList.getRowCount() ;
  shader_bg_name = new String[n] ;
  shader_bg_author = new String[n] ;
  for (int i = 0 ; i < n ; i++ ) {
     TableRow row = shaderBackgroundList.getRow(i) ;
     shader_bg_name[i] = row.getString("Name") ;
     shader_bg_author[i] = row.getString("Author") ;
  }
}

void infoByObject() {
  for(int i = 0 ; i < NUM_ITEM ; i++) {
    TableRow lookFor = objectList.getRow(i) ;
    int ID = lookFor.getInt("ID") ;
    for(int j = 0 ; j <= NUM_ITEM ; j++) {
      if(ID == j ) { 
        item_library_sort[j] =lookFor.getInt("Library Order") ;
        item_ID [j] = lookFor.getInt("ID") ;
        item_group[j] = lookFor.getInt("Group");
        item_pack[j] = lookFor.getString("Pack");
        // object_render[j] = lookFor.getString("Render");
        item_author[j] = lookFor.getString("Author");
        item_version[j] = lookFor.getString("Version");
        item_load_name[j] = lookFor.getString("Class name");
        if (item_ID [j] < 10 ) item_name[j] =  "0" + item_ID [j] + lookFor.getString("Name") ; else item_name[j] = item_ID [j] + lookFor.getString("Name")  ;
        item_slider[j] = lookFor.getString("Slider") ;
      }
    }
  }
}



void numByGroup() {
  // numGroup  = new int[NUM_GROUP_SLIDER] ;
  for (TableRow row : objectList.rows()) {
    int item_group = row.getInt("Group");
    for (int i = 0 ; i < NUM_SLIDER_TOTAL ; i++) {
      if (item_group == i) NUM_ITEM += 1 ;
    }
  }
}
// END BUILD LIBRARY
////////////////////
/**
END setting

*/
























/**
STRUCTURE DRAW

*/
void structureDraw() {
  noStroke() ;
  
  int correctionheight = 14 ;
  fill(grisClair) ; rect(0, 0, width, height ) ; //GROUP ITEM
  fill(gris) ; rect(0, 0, width, line_item_button_slider -correctionheight) ; // //GROUP CONTROLLER
  fill(grisNoir) ; rect(0, lineMenuTopDropdown, width, line_global -lineMenuTopDropdown) ; // main band
  
  //the decoration line
  fill(jauneOrange) ;
  rect(0,0, width, lineHeader-6) ;
  fill (rougeFonce) ; 
  rect(0,0, width, lineHeader-8) ;
  

  
  // LINE MENU TOP DROPDOWN
  fill (jauneOrange) ;
  rect(0,lineMenuTopDropdown, width, 2) ;
  
  // LINE DECORATION
  // GROUP GENERAL
  int thicknessDecoration = 5 ;
  fill(noir) ;
  rect(0,line_global , width, 2) ;
  
  // LINE SOUND
  fill(grisFonce) ;
  rect(0, correctionSoundY -26 +thicknessDecoration, width, thicknessDecoration) ; 
  fill(grisTresFonce) ;
  rect(0, correctionSoundY -18, width, 2) ;
  
  //GROUP ITEM
  fill(jauneOrange) ;
  rect(0, line_item_button_slider -22, width, 8) ; 
  fill(rougeFonce) ;
  rect(0, line_item_button_slider -20, width, 4) ; 
  
  // MENU ITEM
  fill(gris) ;
  rect(0, line_item_menu_text , width, height) ; 
  fill(grisTresFonce) ;
  rect(0, line_item_menu_text +2, width, 2) ;


  // bottom line
  fill (jauneOrange) ;
  rect(0,height-9, width, 2) ;
  fill (rougeFonce) ;
  rect(0,height-7, width, 7) ;
}

//TEXT
void textDraw() {
  if(insideNameversion) fill (jaune) ; else fill(orange) ;
  int posTextY = 18 ;
  textFont(FuturaStencil_20,16); 
  text(nameVersion, 5, posTextY);
  //CLOCK
  fill (orange) ; 
  textFont(FuturaStencil_20,16); textAlign(RIGHT);
  text(nf(hour(),2)   + ":" +nf(minute(),2) , width -10, posTextY);
  
  dispay_text_slider_top( line_global +64) ;
  
  dislay_text_slider_item() ;

}
/**
END STRUCTURE DRAW

*/






















/**
SLIDER

*/

void init_slider() {
  for (int i = 0 ; i < NUM_SLIDER_TOTAL ;i++) {
    sizeSlider[i] = new PVector() ;
    posSlider[i] = new PVector() ; 
  }
}


void build_slider() {
  //slider
  for ( int i = 1 ; i < NUM_SLIDER_TOTAL ; i++ ) {
    PVector sizeMol = new PVector (sizeSlider[i].y *ratioNormSizeMolette, sizeSlider[i].y *ratioNormSizeMolette) ;
    // we use the var posMol here just to init the Slider, because we load data from save further.
    PVector posMol = new PVector() ;
    PVector tempPosSlider = new PVector(posSlider[i].x, posSlider[i].y -(sliderHeight *.6)) ;
    if(infoSaveFromRawList(infoSlider,i).a > -1 ) {
      slider[i] = new SliderAdjustable  (tempPosSlider, posMol, sizeSlider[i], sizeMol, "ELLIPSE");
    }
    if(slider[i] != null) slider[i].setting() ;
  } 
}


// SLIDER SETUP
// MAIN METHOD SLIDER SETUP
void set_var_slider() {
  group_top_slider (correctionSliderPos) ;
  group_item_slider (line_item_button_slider +correction_slider_item) ;
}


// LOCAL SLIDER SETUP METHOD

// group zero, global slider for camera, sound, light, background...
////////////////////////////////////////////////////////////////////
void group_top_slider(int correctionY) {
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
//int correctionCameraY = line_global +15 ;
   startLoop = 20 ;
  for(int i = startLoop ; i <= startLoop +8 ;i++) {
    float posY = correctionCameraY +correctionY +((i-startLoop) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(correctionCameraX, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
}



// Object group
///////////////////////////////////////////
void group_item_slider(int sliderPositionY) {
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
// END SLIDER SETUP




// SLIDER DRAW
void sliderDraw() {
  // sliderDisplayGroupZero() ;
  displayBackgroundSliderGroupZero() ;
  
  /* Loop to display the false background slider instead the usual class Slider background,
  we use it the methode to display a particular background, like the rainbowcolor... */
  displayBackgroundSliderGroupObject(1) ;

  // UPDATE and DISPLAY SLIDER GROUP ONE, TWO, THREE
  /* different way to display depend the displaying mode, who can be change with "ctrl+x" */
  int whichGroup = 0 ;
  for (int i = 1 ; i < NUM_SLIDER_MISC ; i++) {
     sliderUpdate(i) ;
     sliderDisplayMoletteCurrentMinMax(i, whichGroup) ;
  }
  // group item
  whichGroup = 1 ;
  if(!showAllSliders) {
    for (int i = 1 ; i <= NUM_ITEM ; i++) {
      if (objectActive[i] ) {
        for (int j = 1 ; j < NUM_GROUP_SLIDER ; j++) {
          if (showSliderGroup[j] && item_group[i] == j) { 
            for(int k = 1 ; k < NUM_SLIDER_OBJ ; k++) {
              if (displaySlider[j][k]) {
                int whichOne = item_group[i] *100 +k ;
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
void sliderUpdate(int whichOne) {
  
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


void sliderDisplayMoletteCurrentMinMax(int whichOne, int whichGroup) {
  if (whichGroup == 0) {
    sliderDisplayMinMaxMolette(whichOne, grisTresFonce, gris) ;
    sliderDisplayCurrentMolette(whichOne, blanc, blancGris) ;
  } else {
    sliderDisplayMinMaxMolette(whichOne, grisFonce, grisClair) ;
    sliderDisplayCurrentMolette(whichOne, blanc, blancGris) ;
  }
}
// local method
void sliderDisplayMinMaxMolette(int whichOne,  color colorIn, color colorOut) {
  float thickness = 0 ;
  slider[whichOne].displayMinMax(normPosSliderAdjustable, normSizeSliderAdjustable, colorIn, colorOut, colorIn, colorOut, thickness) ;
}
void sliderDisplayCurrentMolette(int whichOne, color colorMolIn, color colorMolOut) {
  slider[whichOne].displayMolette(colorMolIn,colorMolOut, colorMolIn,colorMolOut, 1) ;
}
// end local method




// TEXT slider
///////////////
void dispay_text_slider_top(int pos) {
  // GROUP ZERO
  textAlign(LEFT);
  textFont(textUsual_1) ; 
  //textAlign(LEFT);
  fill (colorTextUsual) ;

  //BACKGROUND
  int correctionY = 3 ;
  int correctionX = sliderWidth + 5 ;
  // SOUND
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



void dislay_text_slider_item() {
  //GROUP ONE
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  fill (colorTextUsual) ;
  textFont(textUsual_1);  textAlign(LEFT);
  
  
  // Legend text slider position for the item
  int correctionY = correction_slider_item +4 ;
  int correctionX = sliderWidth + 5 ;
  for ( int i = 0 ; i < SLIDER_BY_COL ; i++) {
    text(sliderNameOne[i +1], colOne +correctionX, line_item_button_slider +correctionY +(i*spacingBetweenSlider));
    text(sliderNameTwo[i +1], colTwo +correctionX, line_item_button_slider +correctionY +(i*spacingBetweenSlider));
    text(sliderNameThree[i +1], colThree +correctionX, line_item_button_slider +correctionY +(i*spacingBetweenSlider));
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
void displayBackgroundSliderGroupZero() {
  sliderBackgroundDisplay() ;
  sliderDirectionalLightOne() ;
  sliderDirectionalLightTwo() ;
  sliderAmbientLight() ;
  sliderSoundDisplay() ;
  sliderCameraDisplay() ;
}

// local void for slider display group zero
void sliderBackgroundDisplay() {
  int start = 0 ;
  sliderHSBglobalDisplay(start) ;
  sliderBG(posSlider[4].x, posSlider[4].y, sizeSlider[4].y, sizeSlider[4].x, roundedSlider, blancGris) ;
}

// light local variable display
void sliderAmbientLight() {
  int start = 12;
  sliderHSBglobalDisplay(start) ;
}

void sliderDirectionalLightOne() {
  int start = 6 ;
  sliderHSBglobalDisplay(start) ;
}

void sliderDirectionalLightTwo() {
  int start = 9 ;
  sliderHSBglobalDisplay(start) ;
}
//
void sliderSoundDisplay() {
  sliderBG ( posSlider[5].x, posSlider[5].y, sizeSlider[5].y, sizeSlider[5].x, roundedSlider, grisClair) ;
  sliderBG ( posSlider[6].x, posSlider[6].y, sizeSlider[6].y, sizeSlider[6].x, roundedSlider, grisClair) ;
}

void sliderCameraDisplay() {
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
void sliderHSBglobalDisplay(int start) {
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
void displayBackgroundSliderGroupObject(int whichOne) {
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
void sliderHSBobjectDisplay(int whichOne, int whichGroup, int hueRank, int satRank, int brightRank) {
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
void sliderBG (float posX, float posY, float heightSlider, float widthslider, int rounded, color coulour) {
  fill (coulour) ;
  rect (posX, posY -(heightSlider *.5), widthslider, heightSlider, rounded) ;
}

// hue
void hueSliderBG (float posX, float posY, float heightSlider, float widthSlider) {
  pushMatrix () ;
  translate (posX , posY-(heightSlider *.5)) ;
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
void saturationSliderBG (float posX, float posY, float heightSlider, float widthSlider, float colour, float s, float d) {
  pushMatrix () ;
  translate (posX , posY-(heightSlider *.5)) ;
  for ( int i=0 ; i < widthSlider ; i++ ) {
    for ( int j=0 ; j <=heightSlider ; j++ ) {
      float cr = map(i, 0, widthSlider, 0, 100 ) ;
      float dens = map(d, 0, widthSlider, 0, 100 ) ;
      fill (colour, cr, dens) ;
      rect ( i, j, 1,1 ) ;
    }
  }
  popMatrix() ;
}

// brightness
void brightnessSliderBG (float posX, float posY, float heightSlider, float widthSlider, float colour, float s, float d) {
  pushMatrix () ;
  translate (posX , posY-(heightSlider *.5)) ;
  for ( int i=0 ; i < widthSlider ; i++ ) {
    for ( int j=0 ; j <=heightSlider ; j++ ) {
      float cr = map(i, 0, widthSlider, 0, 100 ) ;
      float sat = map(s, 0, widthSlider, 0, 100 ) ;
      fill (colour, sat, cr) ;
      rect (i, j, 1,1) ;
    }
  }
  popMatrix() ;
}
/**
END SLIDER

*/






























/**
BUTTON

*/
/**
BUTTON BUILD
*/
Button_plus  button_midi, button_curtain,
        button_bg, 
        button_light_ambient, button_light_ambient_action,
        button_light_1, button_light_1_action,
        button_light_2, button_light_2_action,
        button_beat, button_kick, button_snare, button_hat;
Button_plus[] button_item, button_item_menu ;

// init button
void init_button() {
  numButton = new int[NUM_GROUP_SLIDER] ;
  
  // General
  numButton[0] = 18 ;
  value_button_G0 = new int[numButton[0]] ;

 // for (int i = 1 ; i < NUM_GROUP_SLIDER ; i++ ) {

//  }
  
  // dropdown
  numDropdown = NUM_ITEM +1 ; // add one for the dropdownmenu
  lastDropdown = numDropdown -1 ;
  
    // item
  numButton[1] = NUM_ITEM *10 ;
  numButtonTotalObjects = NUM_ITEM ;
  value_button_item = new int[numButton[1]] ;
  // button main menu
  button_item = new Button_plus[numButton[1] +10] ;
  pos_button_width_item = new int[numButton[1] +10] ;
  pos_button_height_item = new int[numButton[1] +10] ;
  width_button_item = new int[numButton[1] +10] ;
  height_button_item = new int[numButton[1] +10] ;

  // button menu list to choice which item you want display on the controller
  button_item_menu = new Button_plus[NUM_ITEM +1] ;



  // button param
  on_off_item = new int[numButton[1]] ;
  on_off_item_menu = new boolean[NUM_ITEM +1] ;

  
  //dropdown
  modeListRomanesco = new String[numDropdown] ;
  dropdown = new Dropdown[numDropdown] ;
  pos_dropdown = new PVector[numDropdown] ;
}

// build button
void build_button() {
  color col_on_in = vert ;
  color col_on_out = vertTresFonce ;
  color col_off_in = orange ;
  color col_off_out = rougeFonce ;
  /**
  General
  */  
  button_bg = new Button_plus(pos_bg_button, size_bg_button) ;
  button_bg.set_on_off(true) ;
  button_bg.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  // LIGHT AMBIENT
  button_light_ambient = new Button_plus(posLightAmbientButton, sizeLightAmbientButton) ;
  button_light_ambient.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_light_ambient_action = new Button_plus(posLightAmbientAction, sizeLightAmbientAction) ;
  button_light_ambient_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  // LIGHT ONE
  button_light_1 = new Button_plus(posLightOneButton, sizeLightOneButton) ;
  button_light_1.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_light_1_action = new Button_plus(posLightOneAction, sizeLightOneAction) ;
  button_light_1_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  // LIGHT TWO 
  button_light_2 = new Button_plus(posLightTwoButton, sizeLightTwoButton) ;
  button_light_2.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  button_light_2_action = new Button_plus(posLightTwoAction, sizeLightTwoAction) ;
  button_light_2_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  //button beat
  button_beat = new Button_plus(pos_beat_button, size_beat_button) ;
  button_beat.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_kick = new Button_plus(pos_kick_button, size_kick_button) ;
  button_kick.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_snare = new Button_plus(pos_snare_button, size_snare_button) ;
  button_snare.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_hat = new Button_plus(pos_hat_button, size_hat_button) ;
  button_hat.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  //MIDI
  button_midi  = new Button_plus(pos_midi_button, size_midi_button) ;
  //curtain
  button_curtain  = new Button_plus(pos_curtain_button, size_curtain_button) ;

  //button Object
  Vec2 pos = Vec2() ;
  Vec2 size = Vec2() ;

  button_item[0] = new Button_plus(pos, size) ;
  button_item[0].set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  button_item[0].set_color_bg(gris, grisNoir) ;
  

  /**
  // item setting
  */
  int num = numButton[1] ;
  for ( int j = 11 ; j < 10 +num ; j++) {
    if(NUM_ITEM > 0) {
      pos = Vec2(pos_button_width_item[j], pos_button_height_item[j]) ;
      size = Vec2(width_button_item[j], height_button_item[j]) ; 
      button_item[j] = new Button_plus(pos, size) ;
      button_item[j].set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
      button_item[j].set_color_bg(gris, grisNoir) ;
    } 
  }


  /**
  // Item menu list
  */
  int text_size = 12 ;
  int max_by_col = 10 ;
  int spacing = text_size + (text_size /4 ) ;
  int max_size_col =  max_by_col *spacing;
  int col_size_list_item = 80 ;
  int left_flag = colOne +10 ;
  int top_text =  line_item_menu_text -5 ;
  int ratio_rollover_x = 9 ;

  color col_off_out_menu_item = rougeTresTresFonce ;


  for( int i = 0 ; i < button_item_menu.length ; i++) {
    int step = i *spacing;
    if(item_name[i] != null ) {
      if(i <= max_by_col ) {
        pos = Vec2(left_flag, top_text +step) ;
        size = Vec2(length_String_in_pixel(item_name[i], ratio_rollover_x ), text_size) ;
        button_item_menu[i] = new Button_plus(pos, size) ;
        button_item_menu[i].set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out_menu_item) ;
        button_item_menu[i].set_on_off(on_off_item_menu[i]) ;

      } else if (i > max_by_col && i <= max_by_col *2)  {
        pos = Vec2(left_flag +col_size_list_item, top_text +step -max_size_col) ;
        size = Vec2(length_String_in_pixel(item_name[i], ratio_rollover_x ), text_size) ;
        button_item_menu[i] = new Button_plus(pos, size) ;
        button_item_menu[i].set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out_menu_item) ;
        button_item_menu[i].set_on_off(on_off_item_menu[i]) ;
        
      } else if (i > max_by_col*2 && i <= max_by_col *3)  {
        pos = Vec2(left_flag +(col_size_list_item *2), top_text +step -(max_size_col *2)) ;
        size = Vec2(length_String_in_pixel(item_name[i], ratio_rollover_x ), text_size) ;
        button_item_menu[i] = new Button_plus(pos, size) ;
        button_item_menu[i].set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out_menu_item) ;
        button_item_menu[i].set_on_off(on_off_item_menu[i]) ;
      }

    }
  }
}







/**
Setting button
*/
// Main METHOD SETUP
void set_var_button() {
  // MIDI CURTAIN
  size_curtain_button = Vec2(30,30) ;
  size_midi_button = Vec2(50,26) ;
  pos_midi_button = Vec2(colOne +correctionMidiX, lineHeader +correctionMidiY +1) ;
  pos_midi_info =Vec2(pos_midi_button.x +correction_info_midi_x, pos_midi_button.y +correction_info_midi_y) ;
  pos_curtain_button = Vec2(colOne +correctionCurtainX, lineHeader +correctionCurtainY -1) ; 
  
  
  // BACKGROUND
  pos_bg_button = Vec2(correctionBGX, correctionBGY +correctionButtonSliderTextY) ;
  size_bg_button = Vec2(120,10) ;
  
  // LIGHT
  // ambient button
  posLightAmbientButton = Vec2(correctionLightAmbientX, correctionLightAmbientY +correctionButtonSliderTextY) ;
  sizeLightAmbientButton = Vec2(80,10) ;
  posLightAmbientAction = Vec2(correctionLightAmbientX +90, posLightAmbientButton.y) ; // for the y we take the y of the button
  sizeLightAmbientAction = Vec2(45,10) ;
  // light one button
  posLightOneButton = Vec2(correctionLightOneX, correctionLightOneY +correctionButtonSliderTextY) ;
  sizeLightOneButton = Vec2(80,10) ;
  posLightOneAction = Vec2(correctionLightOneX +90, posLightOneButton.y) ; // for the y we take the y of the button
  sizeLightOneAction = Vec2(45,10) ;
  // light two button
  posLightTwoButton = Vec2(correctionLightTwoX, correctionLightTwoY +correctionButtonSliderTextY) ;
  sizeLightTwoButton = Vec2(80,10) ;
  posLightTwoAction = Vec2(correctionLightTwoX +90, posLightTwoButton.y) ; // for the y we take the y of the button
  sizeLightTwoAction = Vec2(45,10) ;
  
  

  
  //SOUND BUTTON
  size_beat_button = Vec2(30,10) ; 
  size_kick_button = Vec2(30,10) ; 
  size_snare_button = Vec2(40,10) ; 
  size_hat_button = Vec2(30,10) ;
  
  pos_beat_button = Vec2(correctionSoundX, correctionSoundY +correctionButtonSliderTextY) ; 
  pos_kick_button = Vec2(pos_beat_button.x +size_beat_button.x +5, correctionSoundY +correctionButtonSliderTextY) ; 
  pos_snare_button = Vec2(pos_kick_button.x +size_kick_button.x +5, correctionSoundY +correctionButtonSliderTextY) ; 
  pos_hat_button = Vec2(pos_snare_button.x +size_snare_button.x +5, correctionSoundY +correctionButtonSliderTextY) ;
  
  group_item_button(line_item_button_slider +correction_button_item) ;
}

/**
Setting item button
*/
// LOCAL METHOD SETUP
PVector posRelativeMainButton = new PVector (-8, -10) ;
PVector posRelativeSettingButton = new PVector (-8,14) ;
PVector posRelativeSoundButton = new PVector (-8,25) ;
PVector posRelativeActionButton = new PVector (4,25) ;

void group_item_button(int pos_y) {
  //position and area for the rollover
  for (int i = 1 ; i <= NUM_ITEM ; i++) {
    //main
    //pos_button_width_item[i*10+1] = margeLeft +(int)posRelativeMainButton.x +((i-1) *step) ; 
    pos_button_width_item[i*10+1] = margeLeft +(int)posRelativeMainButton.x ; 
    pos_button_height_item[i*10+1] = pos_y +(int)posRelativeMainButton.y ; 
    width_button_item[i*10+1] = 20 ; 
    height_button_item[i*10+1] = 20 ;  
    //setting
    // pos_button_width_item[i*10+2] = margeLeft +(int)posRelativeSettingButton.x +((i-1) *step) ; 
    pos_button_width_item[i*10+2] = margeLeft +(int)posRelativeSettingButton.x ; 
    pos_button_height_item[i*10+2] = pos_y +(int)posRelativeSettingButton.y  ; 
    width_button_item[i*10+2] = 19 ; 
    height_button_item[i*10+2] = 6 ; 
    //sound
    // pos_button_width_item[i*10+3] = margeLeft +(int)posRelativeSoundButton.x +((i-1) *step) ; 
    pos_button_width_item[i*10+3] = margeLeft +(int)posRelativeSoundButton.x ; 
    pos_button_height_item[i*10+3] = pos_y +(int)posRelativeSoundButton.y ; 
    width_button_item[i*10+3] = 10 ; 
    height_button_item[i*10+3] = 6 ; 
    //action
    // pos_button_width_item[i*10+4] = margeLeft +(int)posRelativeActionButton.x +((i-1) *step) ; 
    pos_button_width_item[i*10+4] = margeLeft +(int)posRelativeActionButton.x ; 
    pos_button_height_item[i*10+4] = pos_y +(int)posRelativeActionButton.y ; 
    width_button_item[i*10+4] = 10 ; 
    height_button_item[i*10+4] = 6 ; 

  }
}


/**
Display Button
*/
// DRAW MAIN METHOD
void button_draw() {
  button_draw_general() ;
  button_draw_selected_item() ;
  button_draw_list_item() ;

  button_check() ;
  dropdown_draw() ;
  buttonInfoOnTheTop() ;
  midiButtonManager(false) ;
}





// DRAW LOCAL METHOD
void buttonInfoOnTheTop() {
    // background window
  Vec2 pos_window = Vec2(mouseX , mouseY -20) ;
  Vec2 ratio_size = Vec2( 1.6, 1.3) ;
  int speed = 7 ;
  int size_angle = 2 ;
  Vec2 range_check = Vec2(0,0) ;
  String [] text = new String[1] ;
  int [] size_text = new int[1] ;
  size_text [0] = 20 ;
  textFont(FuturaStencil_20) ;

  if(button_midi.rollover()) {
    text [0] = ("MIDI") ;
    fill(grisTresFonce, 180) ;
    background_text_list(Vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check) ;
    fill(jaune) ;
    text(text [0],pos_window.x, pos_window.y) ;
  }

  if(button_curtain.rollover()) {

    text [0] = ("CUT") ;
    fill(grisTresFonce, 180) ;
    background_text_list(Vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size,range_check) ;
    fill(jaune) ;
    text(text [0], pos_window.x, pos_window.y) ;
  }
}










/**
// GROUP General
*/
void button_draw_general() {
  button_bg.button_text(shader_bg_name[state_bg_shader] + " on/off", pos_bg_button, titleButtonMedium, sizeTitleButton) ;
  button_bg.button_text(shader_bg_name[state_bg_shader] + " on/off", pos_bg_button, titleButtonMedium, sizeTitleButton) ;
  // Light ambient
  button_light_ambient.button_text("Ambient on/off", posLightAmbientButton, titleButtonMedium, sizeTitleButton) ;
  button_light_ambient_action.button_text("action", posLightAmbientAction, titleButtonMedium, sizeTitleButton) ;
  //LIGHT ONE
  button_light_1.button_text("Light on/off", posLightOneButton, titleButtonMedium, sizeTitleButton) ;
  button_light_1_action.button_text("action", posLightOneAction, titleButtonMedium, sizeTitleButton) ;
  // LIGHT TWO
  button_light_2.button_text("Light on/off",  posLightTwoButton, titleButtonMedium, sizeTitleButton) ;
  button_light_2_action.button_text("action",  posLightTwoAction, titleButtonMedium, sizeTitleButton) ;
  
  // SOUND
  button_beat.button_text("BEAT", pos_beat_button, titleButtonMedium, sizeTitleButton) ;
  button_kick.button_text("KICK", pos_kick_button, titleButtonMedium, sizeTitleButton) ;
  button_snare.button_text("SNARE", pos_snare_button, titleButtonMedium, sizeTitleButton) ;
  button_hat.button_text("HAT", pos_hat_button, titleButtonMedium, sizeTitleButton) ;
  
  //MIDI / CURTAIN
  button_midi.button_pic(picMidi) ;
  button_curtain.button_pic(picCurtain) ;
}

/**
// ITEM 
*/
void button_draw_selected_item() {
  int rankThumbnail = 0 ;
  int pointer = 0 ;


  for( int i = 1 ; i <= NUM_ITEM ; i++ ) {
    if(on_off_item_menu[i]) {
    //  if(info_item[i].y == 1) {
        int distance = pointer *STEP_ITEM ;
        // update pos 
        button_item[i *10 + 1].change_pos(distance, 0) ;
        button_item[i *10 + 2].change_pos(distance, 0) ;
        button_item[i *10 + 3].change_pos(distance, 0) ;
        button_item[i *10 + 4].change_pos(distance, 0) ;
        // display
        button_item[i*10 +1].button_pic_serie(OFF_in_thumbnail, OFF_out_thumbnail, ON_in_thumbnail, ON_out_thumbnail, i +rankThumbnail ) ; 
        button_item[i*10 +2].button_pic(picSetting) ;
        button_item[i*10 +3].button_pic(picSound) ; 
        button_item[i*10 +4].button_pic(picAction) ; 
        PVector pos = new PVector (pos_button_width_item[i*10 +2], pos_button_height_item[i*10 +1] +10) ;
        PVector size = new PVector (20, 30) ;
        text_info_object(pos, size, i, 1) ;
        pointer ++ ;
    //  }
    }
  }
}
/**
ITEM LIST
*/
// Display the list of all the item available
void button_draw_list_item() {
  textFont(textUsual_3) ;
  int text_size = 12 ;
  textSize(text_size) ;
  String temp_item_name [] = new String[item_name.length] ;

  if(item_name.length > 0  ) {
    for(int i = 0 ; i < item_name.length ; i++) {
      temp_item_name[i] = "" ;
      if(item_name[i] != null ) {
        temp_item_name[i] = item_name[i].substring(2) ;
        button_item_menu[i].button_text(temp_item_name[i], (int)button_item_menu[i].pos.x , (int)button_item_menu[i].pos.y +text_size) ;
      }
    }
  }
}



void button_check() {
  /*
  Check to send by OSC to Scene and Prescene
  */
  if(button_bg.get_on_off()) state_BackgroundButton = 1 ; else state_BackgroundButton = 0 ;
  //LIGHT ONE
  if(button_light_ambient.get_on_off())  state_LightAmbientButton = 1 ; else  state_LightAmbientButton = 0 ;
  if(button_light_ambient_action.get_on_off()) state_LightAmbientAction = 1 ; else state_LightAmbientAction =  0 ;
  //LIGHT ONE
  if(button_light_1.get_on_off()) state_LightOneButton = 1 ; else state_LightOneButton = 0 ;
  if(button_light_1_action.get_on_off() ) state_LightOneAction = 1 ; else state_LightOneAction = 0 ;
  // LIGHT TWO
  if(button_light_2.get_on_off()) state_LightTwoButton = 1 ; else state_LightTwoButton = 0 ;
  if(button_light_2_action.get_on_off()) state_LightTwoAction = 1 ; else state_LightTwoAction = 0 ;
  //SOUND
  if(button_beat.get_on_off()) state_button_beat = 1 ; else state_button_beat = 0 ;
  if(button_kick.get_on_off()) state_button_kick = 1 ; else state_button_kick = 0 ;
  if(button_snare.get_on_off()) state_button_snare = 1 ; else state_button_snare = 0 ;
  if(button_hat.get_on_off()) state_button_hat = 1 ; else state_button_hat = 0 ;
  //Check position of button
  if(button_midi.get_on_off()) state_midi_button = 1 ; else state_midi_button = 0 ;
  if(button_curtain.get_on_off()) state_curtain_button = 1 ; else state_curtain_button = 0 ;


  // Item check
  if( NUM_ITEM > 0){
    // item available
    int num = numButton[1] +10 ;
    for( int i = 11 ; i < num ; i++) {
       // on_off_item[i-10] = button_item[i].get_on_off() ;
       if(button_item[i].get_on_off()) on_off_item[i-10] = 1 ; else on_off_item[i-10] = 0 ;
    }
  }

  /*
  Check to display or not the item in the controller
  */
  if( NUM_ITEM > 0) {
    for(int i = 1 ; i < button_item_menu.length ; i++) {
      // here it's boolean not an int because we don't need to send it via OSC.
       on_off_item_menu[i] = button_item_menu[i].get_on_off() ;
    }
  }


}

/**
END BUTTON

*/


























/**
DROPDOWN

*/
int refSizeImageDropdown, refSizeFileTextDropdown, refSizeCameraVideoDropdown ;
PVector posTextdropdown_image, posTextdropdown_file_text, posTextdropdown_camera_video ; 
color selectedText ;
color colorBoxIn, colorBoxOut, colorBoxText, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut ;
int sizeToRenderTheBoxDropdown = 15 ;

void set_var_dropdown() {

  pos_button_bg = Vec2(colOne +correctionHeaderDropdownBackgroundX,      lineMenuTopDropdown +correctionHeaderDropdownY)  ;
  pos_button_font = Vec2(colOne +correctionHeaderdropdown_fontX,            lineMenuTopDropdown +correctionHeaderDropdownY)  ; 
  pos_button_image =  Vec2(colOne +correctionHeaderdropdown_imageX,           lineMenuTopDropdown +correctionHeaderDropdownY)  ; 
  pos_button_file_text = Vec2(colOne +correctionHeaderdropdown_file_textX,        lineMenuTopDropdown +correctionHeaderDropdownY)  ; 
  pos_button_camera_video = Vec2(colOne +correctionHeaderdropdown_camera_videoX,     lineMenuTopDropdown +correctionHeaderDropdownY)  ; 
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
  font_dropdown_list = split(policeList, "/") ;
  
  //image
  initLiveData() ;
 
  //SHADER backgorund dropdown
  
  ///////////////
  pos_dropdownBackground = new PVector(pos_button_bg.x, pos_button_bg.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  sizeDropdownBackground = new PVector (75, sizeToRenderTheBoxDropdown, 10) ; // z is the num of line you show
  PVector posTextDropdownBackground = new PVector(3, 10)  ;
  dropdown_bg = new Dropdown("Background", shader_bg_name, pos_dropdownBackground, sizeDropdownBackground, posTextDropdownBackground, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  
  //FONT dropdown
  ///////////////
  pos_dropdown_font = new PVector(pos_button_font.x, pos_button_font.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  size_dropdown_font = new PVector (40, sizeToRenderTheBoxDropdown, 10 ) ; // z is the num of line you show
  PVector posTextDropdownTypo = new PVector(3, 10)  ;
  dropdown_font = new Dropdown("Font", font_dropdown_list,   pos_dropdown_font , size_dropdown_font, posTextDropdownTypo, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  // Image Dropdown
  //////////////////
  pos_dropdown_image = new PVector(pos_button_image.x, pos_button_image.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  size_dropdown_image = new PVector (60, sizeToRenderTheBoxDropdown, 10 ) ; // z is the num of line you show
  posTextdropdown_image = new PVector(3, 10)  ;
  refSizeImageDropdown = image_dropdown_list.length ;
  dropdown_image = new Dropdown("Image", image_dropdown_list, pos_dropdown_image, size_dropdown_image, posTextdropdown_image, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  // File text Dropdown
  //////////////////
  pos_dropdown_file_text = new PVector(pos_button_file_text.x, pos_button_file_text.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  size_dropdown_file_text = new PVector (40, sizeToRenderTheBoxDropdown, 10 ) ; // z is the num of line you show
  posTextdropdown_file_text = new PVector(3, 10)  ;
  refSizeFileTextDropdown = file_text_dropdown_list.length ;
  dropdown_file_text = new Dropdown("Text", file_text_dropdown_list, pos_dropdown_file_text, size_dropdown_file_text, posTextdropdown_file_text, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  // Camera Video Dropdown
  //////////////////
  pos_dropdown_camera_video = new PVector(pos_button_camera_video.x, pos_button_camera_video.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  size_dropdown_camera_video = new PVector (100, sizeToRenderTheBoxDropdown, 10 ) ; // z is the num of line you show
  posTextdropdown_camera_video = new PVector(3, 10)  ;
  refSizeCameraVideoDropdown = name_camera_video_dropdown_list.length ;
  dropdown_camera_video = new Dropdown("Camera Video", name_camera_video_dropdown_list, pos_dropdown_camera_video, size_dropdown_camera_video, posTextdropdown_camera_video, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  
  
  //MODE Dropdown
  ///////////////
  colorDropdownTitleIn = rouge ;
  colorDropdownTitleOut = rougeFonce ;
  //common param
  int numLineDisplayByTheDropdownObj = 8 ;
  size_dropdown_mode = new PVector (20, sizeToRenderTheBoxDropdown, numLineDisplayByTheDropdownObj) ;
  // int correction_dropdown_item +correction_button_item
  PVector newPos = new PVector( -8, correction_dropdown_item ) ;
  // group item
  dropdown_setting_item(margeLeft +newPos.x, line_item_button_slider +newPos.y) ;
}

void dropdown_setting_item(float posWidth, float posHeight) {
  for ( int i = 0 ; i <= NUM_ITEM ; i++ ) {
    if(modeListRomanesco[i] != null) {
      //Split the dropdown to display in the dropdown
      list_dropdown = split(modeListRomanesco[i], "/" ) ;
      //to change the title of the header dropdown
      pos_dropdown[i] = new PVector(posWidth, posHeight , 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
      dropdown[i] = new Dropdown("M", list_dropdown, pos_dropdown[i], size_dropdown_mode, posTextDropdown, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
    }
  }
}







/**
//DRAW DROPDOWN
*/
boolean dropdownActivity ;
int dropdownActivityCount ;

void dropdown_draw() {
  // update content
  update_dropdown_content() ;
  // update dropdown item
  dropdown_update_item() ;


  dropdown_update_background() ;
  state_file_text       = dropdown_update_general(size_dropdown_file_text, pos_dropdown_file_text, dropdown_file_text, file_text_dropdown_list, title_dropdown_medium) ;
  state_image           = dropdown_update_general(size_dropdown_image, pos_dropdown_image, dropdown_image, image_dropdown_list, title_dropdown_medium) ;
  state_font            = dropdown_update_general(size_dropdown_font, pos_dropdown_font, dropdown_font, font_dropdown_list, title_dropdown_medium) ;
  state_camera_video    = dropdown_update_general(size_dropdown_camera_video, pos_dropdown_camera_video, dropdown_camera_video, name_camera_video_dropdown_list, title_dropdown_medium) ;

  // check the activity o the dropdown
  if(dropdownActivityCount > 0 ) dropdownActivity = true ; else dropdownActivity = false ;
  dropdownActivityCount = 0 ;
}
// END MAIN





// Annexe method

void update_dropdown_content() {
    // update file text content
  if(file_text_dropdown_list.length != refSizeFileTextDropdown ) {
    dropdown_file_text = new Dropdown("Text", file_text_dropdown_list, pos_dropdown_file_text, size_dropdown_file_text, posTextdropdown_file_text, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
    refSizeFileTextDropdown = file_text_dropdown_list.length ;
  }
   // update content picture
  if(image_dropdown_list.length != refSizeImageDropdown ) {
    dropdown_image = new Dropdown("Image", image_dropdown_list, pos_dropdown_image, size_dropdown_image, posTextdropdown_image, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
    refSizeImageDropdown = image_dropdown_list.length ;
  }
}



// global update for the classic dropdown

int dropdown_update_general(PVector size, PVector pos, Dropdown dropdown_menu, String [] menu_list, PFont font) {
  int state = SWITCH_VALUE_FOR_DROPDOWN  ;
  dropdown_menu.dropdownUpdate(font, textUsual_1);
  if (dropdownOpen) dropdownActivityCount = +1 ;
  marge_around_dropdown = size.y  ;
  //give the size of menu recalculate with the size of the word inside
  PVector new_size = dropdown_menu.sizeBoxDropdownMenu ;
  //compare the standard size of dropdown with the number of element of the list.
  int heightDropdown = 0 ;
  if(menu_list.length < size.z ) heightDropdown = menu_list.length ; else heightDropdown = (int)size.z ;
  PVector total_size = new PVector ( new_size.x +(marge_around_dropdown *1.5), size.y *(heightDropdown +1) +marge_around_dropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  PVector new_pos = new PVector (pos.x -marge_around_dropdown, pos.y) ;
  if (!insideRect(new_pos, total_size)) dropdown_menu.locked = false ;
  
  if(!dropdown_menu.locked && menu_list.length > 0) {
    fill(selectedText) ;
    // display the selection
    state = dropdown_menu.getSelection() ;
    textFont(textUsual_2) ;
    text(menu_list[dropdown_menu.getSelection()], pos.x +3 , pos.y +22) ;
  }
  return state ;
}




// update for the special content dropdown
void dropdown_update_background() {
  
  dropdown_bg.dropdownUpdate(title_dropdown_medium, textUsual_1);
  if (dropdownOpen) dropdownActivityCount = +1 ;
  marge_around_dropdown = size_dropdown_font.y  ;
  //give the size of menu recalculate with the size of the word inside
  PVector newSizeFont = dropdown_bg.sizeBoxDropdownMenu ;
  //compare the standard size of dropdown with the number of element of the list.
  int heightDropdown = 0 ;
  if(shader_bg_name.length < sizeDropdownBackground.z ) heightDropdown = shader_bg_name.length ; else heightDropdown = (int)sizeDropdownBackground.z ;
  PVector total_size = new PVector ( newSizeFont.x +(marge_around_dropdown *1.5), sizeDropdownBackground.y *(heightDropdown +1) +marge_around_dropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  PVector new_pos = new PVector (pos_dropdownBackground.x -marge_around_dropdown, pos_dropdownBackground.y) ;
  if (!insideRect(new_pos, total_size)) dropdown_bg.locked = false ;
  // display the selection
  
  if(!dropdown_bg.locked) {
    fill(selectedText) ;
    textFont(textUsual_2) ;
    state_bg_shader = dropdown_bg.getSelection() ;
    if (dropdown_bg.getSelection() != 0 ) {
      text(shader_bg_name[state_bg_shader] +" by " +shader_bg_author[dropdown_bg.getSelection()], pos_dropdownBackground.x +3 , pos_dropdownBackground.y +22) ;
    } else {
      text(shader_bg_name[state_bg_shader], pos_dropdownBackground.x +3 , pos_dropdownBackground.y +22) ;
    }
      
  }
}


void dropdown_update_item() {
  int pointer = 0 ;
  for ( int i = 1 ; i <= NUM_ITEM ; i ++ ) {
    //if(on_off_item_menu[i]) {
      if(modeListRomanesco[i] != null && on_off_item_menu[i] ) {
        int distance = pointer *STEP_ITEM ;
        pointer ++ ;
        // update pos 
        dropdown[i].change_pos(distance, 0) ;


        String m [] = split(modeListRomanesco[i], "/") ;
        if ( m.length > 1) {
          dropdown[i].dropdownUpdate(title_dropdown_medium, textUsual_1);
          if (dropdownOpen) dropdownActivityCount = +1 ;
          marge_around_dropdown = size_dropdown_mode.y  ;
          //give the size of menu recalculate with the size of the word inside
          PVector newSizeModeTypo = dropdown[i].sizeBoxDropdownMenu ;
           int heightDropdown = 0 ;

          if(dropdown[i].listItem.length < size_dropdown_mode.z ) {
            heightDropdown = dropdown[i].listItem.length ; 
          } else {
            heightDropdown = (int)size_dropdown_mode.z ;
          }

          PVector total_size = new PVector (newSizeModeTypo.x + (marge_around_dropdown *1.5) , size_dropdown_mode.y * (heightDropdown +1)  + marge_around_dropdown   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
           //new pos to include the slider
          PVector new_pos = new PVector (pos_dropdown[i].x -marge_around_dropdown, pos_dropdown[i].y) ;
          if ( !insideRect(new_pos, total_size)) {
            dropdown[i].locked = false;
          }
        }
        // display which element is selected
        if (dropdown[i].getSelection() > -1 && m.length > 1) {
          textFont(title_dropdown_medium) ;
          text(dropdown[i].getSelection() +1, pos_dropdown[i].x +12 , pos_dropdown[i].y +8) ;
        }
      }
  //  }
  }
}

//END DROPDOWN DRAW
///////////////////







// DROPDOWN MOUSEPRESSED
////////////////////////
void dropdownMousepressed() {
  // global menu
  check_dropdown_mousepressed (pos_dropdownBackground,  sizeDropdownBackground,  dropdown_bg) ;
  check_dropdown_mousepressed (pos_dropdown_font,        size_dropdown_font,        dropdown_font) ;
  check_dropdown_mousepressed (pos_dropdown_image,       size_dropdown_image,       dropdown_image) ;
  check_dropdown_mousepressed (pos_dropdown_file_text,    size_dropdown_file_text,    dropdown_file_text) ;
  check_dropdown_mousepressed (pos_dropdown_camera_video, size_dropdown_camera_video, dropdown_camera_video) ;
  
  // Item menu
  check_dropdown_object_mousepressed() ;
}
// END MAIN





void check_dropdown_mousepressed(PVector pos, PVector size, Dropdown dropdown_menu) {
  if (dropdown_menu != null) {
    if (insideRect(pos, size) && !dropdown_menu.locked  ) {
      dropdown_menu.locked = true;
    } else if (dropdown_menu.locked) {
      float new_width = dropdown_menu.sizeBoxDropdownMenu.x ;
      int line = dropdown_menu.selectDropdownLine(new_width);
      if (line > -1 ) {
        dropdown_menu.whichDropdownLine(line);
        //to close the dropdown
        dropdown_menu.locked = false;        
      } 
    }
  }
}



// OBJECT dropdown
//////////////////
void check_dropdown_object_mousepressed() {
  for ( int i = 0 ; i <= NUM_ITEM ; i ++ ) { 
    if (dropdown[i] != null) {
      if (insideRect(pos_dropdown[i], size_dropdown_mode) && !dropdown[i].locked  ) {
        dropdown[i].locked = true;
      } else if (dropdown[i].locked) {
        float new_width = dropdown[i].sizeBoxDropdownMenu.x ;
        int line = dropdown[i].selectDropdownLine(new_width);
        if (line > -1 ) {
          dropdown[i].whichDropdownLine(line);
          //to close the dropdown
          dropdown[i].locked = false;        
        } 
      }
    }
  }
}

/**
END DROPDOWN

*/






























/**
OTHER METHOD 

*/
//show info
void text_info_object(PVector pos, PVector size, int IDorder, int IDfamily) {
  if (mouseX > pos.x && mouseX < (size.x + pos.x ) && mouseY > pos.y - 10 && mouseY <  (size.y + pos.y) -20 ) {
    PVector fontPos = new PVector(-10, -20 ) ;
    
    if (NUM_ITEM > 0 ) {
      display_info_object(IDorder, fontPos) ;
    }
  }
}





void display_info_object(int IDorder, PVector pos) {
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
  int num_line = 4 ;
  String [] text = new String[num_line] ;
  int [] size_text = new int[num_line] ;
  text[0] = displayInfo.getString("Name") ;
  text[1] = displayInfo.getString("Author") ;
  text[2] = displayInfo.getString("Version") ;
  text[3] = displayInfo.getString("Pack") ;
  size_text [0] = 20 ;
  size_text [1] = 15 ;
  size_text [2] = 10 ;
  size_text [3] = 10 ;

  // background window
  int pos_correction_y = -30 ;
  Vec2 pos_window = Vec2(pos.x +mouseX , pos.y + mouseY +pos_correction_y) ;
  Vec2 ratio_size = Vec2( 1.4, 1.3) ;
  int speed = 7 ;
  int size_angle = 2 ;
  fill(rougeFonce, 150) ;
  Vec2 range_check = Vec2(0,1) ;
  background_text_list(Vec2(pos_window.x +2, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check) ;


  // text
  fill(jaune) ;  
  textSize(size_text [0] ) ;
  textFont(FuturaStencil_20) ;
  text(text[0], pos_window.x, pos_window.y +5) ;
  textSize(size_text [1] ) ;
  text(text[1], pos_window.x, pos_window.y +20) ;
  textSize(size_text [2] ) ;
  text(text[2], pos_window.x, pos_window.y +30) ;
  text(text[3], pos_window.x, pos_window.y +40) ;
}







// ANNEXE METHODE
/////////////////

void background_text_list(Vec2 pos, String [] list, int [] size_text, int size_angle, int speed_rotation, Vec2 ratio_size, Vec2 start_end) {
  // create the starting point of the shape
  pos = Vec2(pos.x -(size_text[0] *.5), pos.y -size_text[0]) ;

  // spacing
  float spacing = 0 ;
  for(int i = 0 ; i < size_text.length ; i++) {
    spacing += size_text[i] ;
  }
  spacing /= size_text.length ;
  spacing *= ratio_size.y;

  //define the size of the background
  int start_point_list = int(start_end.x) ;
  int end_point_list = int(start_end.y) ;
  
  int size_word = int(longest_word_in_pixel(list, size_text, start_point_list, end_point_list)) ;
  float width_rect =  size_word *ratio_size.x ;
  int height_rect = list.length *(int)spacing ;
  
  // create the point to build the background
  int diam = size_angle ;
  int speed = speed_rotation ;
  Vec2 a = Vec2(pos.x + 0,pos.y + 0).revolution(diam *3, speed/2) ;
  Vec2 b = Vec2(pos.x + width_rect, pos.y + 0).revolution(int(diam *1.5), speed) ;
  Vec2 c = Vec2(pos.x + width_rect, pos.y + height_rect).revolution(diam *2, int(speed *1.2)) ;
  Vec2 d = Vec2(pos.x + 0, pos.y + height_rect).revolution(diam, int(speed *.7)) ;
  
  // display background
  beginShape() ;
  vertex(a.x, a.y) ;
  vertex(b.x, b.y) ;
  vertex(c.x, c.y) ;
  vertex(d.x, d.y) ;
  endShape(CLOSE) ;
}







