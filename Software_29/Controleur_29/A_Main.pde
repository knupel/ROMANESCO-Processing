/**
Build interface 3.0.3
Romanesco Processing Environment
*/
import java.awt.event.KeyEvent;
import java.awt.image.* ;
import java.awt.* ;

// CONSTANT VAR
final int NUM_COL_SLIDER = 3 ;
final int NUM_GROUP_SLIDER = 2 ; // '0' for general / '1' for the item

final int NUM_SLIDER_GENERAL = 30 ;
final int NUM_SLIDER_ITEM = 45 ;
final int NUM_SLIDER_TOTAL = 1 +100 +NUM_SLIDER_ITEM ;
final int SLIDER_BY_COL = NUM_SLIDER_ITEM / NUM_COL_SLIDER ;
final int SLIDER_BY_COL_PLUS_ONE = SLIDER_BY_COL +1 ;





Vec2 size_ref ;

int sliderMidi, midi_value_romanesco, midi_channel_romanesco ;
int midi_CC_romanesco = -1 ;
boolean saveMidi ;
boolean selectMidi = false ;
//curtain
boolean curtainOpenClose ;
//GLOBAL

// Save Setting var
Vec5 [] infoSlider ; 


// slider mode display
int sliderModeDisplay = 0 ;

boolean[] keyboard = new boolean[526];
boolean loadSaveSetting = false ;
boolean ouvrirFichier = false ;
boolean INIT_INTERFACE = true ;

//LOAD PICTURE VIGNETTE
int numVignette ;
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
Vec2  pos_midi_button, size_midi_button, pos_midi_info,
      pos_curtain_button, size_curtain_button,
      pos_beat_button, size_beat_button,
      pos_kick_button, size_kick_button,
      pos_snare_button, size_snare_button,
      pos_hat_button, size_hat_button ;


// END variables declaration
////////////////////////////////////


/**
GUI VARIABLE SETTING
*/
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
int line_item_menu_text = line_item_button_slider +260 ;


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

//GROUP GENERAL
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

// GROUP MIDI
int correctionMidiX = 40 ;
int correctionMidiY = 0 ;
int spacing_midi_info = 13 ;
int correction_info_midi_x = 60 ;
int correction_info_midi_y = 10 ;
int size_x_window_info_midi = 200 ;

// GROUP ITEM
int correction_slider_item = 65 ;
int correction_button_item = 3 ;
int correction_dropdown_item = 43 ;

/**
END VARIABLES declaration
*/



















/**
SETTING
*/

void setting() {
  colorSetup() ;  

  frameRate(60) ; 
  noStroke () ; 
  surface.setResizable(true);
  background(gris);
  // general
  for ( int i = 0 ; i <  SLIDER_BY_COL ; i++ ) {
    genTxtGUI[i] = ("") ;
    sliderNameCamera[i] = ("") ;
  }
  // item
  for ( int i = 0 ; i <  SLIDER_BY_COL_PLUS_ONE ; i++ ) {
    slider_name_col_one[i] = ("") ;
    slider_name_col_two[i] = ("") ;
    slider_name_col_three[i] = ("") ;
  }
}




void info_bg_shader() {
  int n = shaderBackgroundList.getRowCount() ;
  shader_bg_name = new String[n] ;
  shader_bg_author = new String[n] ;
  for (int i = 0 ; i < n ; i++ ) {
     TableRow row = shaderBackgroundList.getRow(i) ;
     shader_bg_name[i] = row.getString("Name") ;
     shader_bg_author[i] = row.getString("Author") ;
  }
}





void numByGroup() {
  // numGroup  = new int[NUM_GROUP_SLIDER] ;
  for (TableRow row : item_list_table.rows()) {
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
STRUCTURE DESIGN

*/
void display_structure() {
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



}

//TEXT
void display_text() {
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


void finish_decoration() {
  noStroke() ;
  fill (jauneOrange) ;
  rect(0,height-9, width, 2) ;
  fill (rougeFonce) ;
  rect(0,height-7, width, 7) ;

}



void check_interface() {
  if(size_ref.x != width || size_ref.y != height) INIT_INTERFACE = true ;
}

void init_interface() {
  if(INIT_INTERFACE) {
    build_button_item_list() ;
    set_item_list() ;
    size_ref.set(width, height) ;
  }
}
/**
END STRUCTURE DESIGN

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
void set_slider() {
  set_slider_general(correctionSliderPos) ;
  set_slider_item_console(line_item_button_slider +correction_slider_item) ;
}


// LOCAL SLIDER SETUP METHOD

// group zero, global slider for camera, sound, light, background...
////////////////////////////////////////////////////////////////////
void set_slider_general(int correctionY) {
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
void set_slider_item_console(int sliderPositionY) {
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
void display_slider() {
  /* different way to display depend the displaying mode. 
  Can change with "ctrl+x" */
  int whichGroup = 0 ;
  display_bg_slider_general() ;
  for (int i = 1 ; i < NUM_SLIDER_GENERAL ; i++) {
     sliderUpdate(i) ;
     sliderDisplayMoletteCurrentMinMax(i, whichGroup) ;
  }
  // group item
  display_bg_slider_item() ;
  whichGroup = 1 ;
  if(!showAllSliders) {
    for (int i = 1 ; i <= NUM_ITEM ; i++) {
      if (item_active[i]) {
        if (showSliderGroup[1] && item_group[i] == 1) { 
          for(int j = 1 ; j < NUM_SLIDER_ITEM ; j++) {
            if (display_slider[1][j]) {
              int whichOne = item_group[i] *100 +j ;
              sliderUpdate(whichOne) ; 
              sliderDisplayMoletteCurrentMinMax(whichOne, whichGroup) ; 
            }
          }
        }
      }
    }
  // if it ask to show all slider  
  } else {
    for(int i = 1 ; i < NUM_SLIDER_ITEM ; i++) {
      int which_one = i +100 ;
      sliderUpdate(which_one) ;
      sliderDisplayMoletteCurrentMinMax(which_one, whichGroup) ;
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
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  fill (colorTextUsual) ;
  textFont(textUsual_1);  textAlign(LEFT);
  
  
  // Legend text slider position for the item
  int correctionY = correction_slider_item +4 ;
  int correctionX = sliderWidth + 5 ;
  for ( int i = 0 ; i < SLIDER_BY_COL_PLUS_ONE ; i++) {
    text(slider_name_col_one[i], colOne +correctionX, line_item_button_slider +correctionY +(i*spacingBetweenSlider));
    text(slider_name_col_two[i], colTwo +correctionX, line_item_button_slider +correctionY +(i*spacingBetweenSlider));
    text(slider_name_col_three[i], colThree +correctionX, line_item_button_slider +correctionY +(i*spacingBetweenSlider));
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
void display_bg_slider_general() {
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
void display_bg_slider_item() {
  // to find the good slider in the array
  int whichGroup = 1 ;
  int whichOne = 100 ;

  // COL ONE
  sliderHSBobjectDisplay(whichOne, whichGroup, hueFillRank, saturationFillRank, brightnessFillRank) ;
  if (display_slider[whichGroup][alphaFillRank]) sliderBG (posSlider[whichOne +alphaFillRank].x, posSlider[whichOne +alphaFillRank].y, sizeSlider[whichOne +alphaFillRank].y, sizeSlider[whichOne +alphaFillRank].x, roundedSlider, blanc ) ;
  
  //outline color
  sliderHSBobjectDisplay(whichOne, whichGroup, hueStrokeRank, saturationStrokeRank, brightnessStrokeRank) ;
  if (display_slider[whichGroup][alphaStrokeRank]) sliderBG (posSlider[whichOne +alphaStrokeRank].x, posSlider[whichOne +alphaStrokeRank].y, sizeSlider[whichOne +alphaStrokeRank].y, sizeSlider[whichOne +alphaStrokeRank].x, roundedSlider, blancGrisClair) ;
  //  thickness
  if( display_slider[whichGroup][thicknessRank]) sliderBG (posSlider[whichOne +thicknessRank].x, posSlider[whichOne +thicknessRank].y, sizeSlider[whichOne +thicknessRank].y, sizeSlider[whichOne +thicknessRank].x, roundedSlider, blanc) ;
  
  // COL TWO

  // width, height, depth
  if(display_slider[whichGroup][widthObjRank])  sliderBG (posSlider[whichOne +widthObjRank].x, posSlider[whichOne +widthObjRank].y, sizeSlider[whichOne +widthObjRank].y, sizeSlider[whichOne +widthObjRank].x, roundedSlider, blanc) ;
  if(display_slider[whichGroup][heightObjRank]) sliderBG (posSlider[whichOne +heightObjRank].x, posSlider[whichOne +heightObjRank].y, sizeSlider[whichOne +heightObjRank].y, sizeSlider[whichOne +heightObjRank].x, roundedSlider, blanc) ;
  if(display_slider[whichGroup][depthObjRank])  sliderBG (posSlider[whichOne +depthObjRank].x, posSlider[whichOne +depthObjRank].y, sizeSlider[whichOne +depthObjRank].y, sizeSlider[whichOne +depthObjRank].x, roundedSlider, blanc) ;
  // canvas
  if(display_slider[whichGroup][canvasXRank]) sliderBG (posSlider[whichOne +canvasXRank].x, posSlider[whichOne +canvasXRank].y, sizeSlider[whichOne +canvasXRank].y, sizeSlider[whichOne +canvasXRank].x, roundedSlider, blancGrisClair) ;
  if(display_slider[whichGroup][canvasYRank]) sliderBG (posSlider[whichOne +canvasYRank].x, posSlider[whichOne +canvasYRank].y, sizeSlider[whichOne +canvasYRank].y, sizeSlider[whichOne +canvasYRank].x, roundedSlider, blancGrisClair) ;
  if(display_slider[whichGroup][canvasZRank]) sliderBG (posSlider[whichOne +canvasZRank].x, posSlider[whichOne +canvasZRank].y, sizeSlider[whichOne +canvasZRank].y, sizeSlider[whichOne +canvasZRank].x, roundedSlider, blancGrisClair) ;
  // Family
  if(display_slider[whichGroup][familyRank]) sliderBG ( posSlider[whichOne +familyRank].x, posSlider[whichOne +familyRank].y, sizeSlider[whichOne +familyRank].y, sizeSlider[whichOne +familyRank].x, roundedSlider, blanc) ;
  if(display_slider[whichGroup][quantityRank]) sliderBG (posSlider[whichOne +quantityRank].x, posSlider[whichOne +quantityRank].y, sizeSlider[whichOne +quantityRank].y, sizeSlider[whichOne +quantityRank].x, roundedSlider, blanc) ;
  if(display_slider[whichGroup][lifeRank]) sliderBG ( posSlider[whichOne +lifeRank].x, posSlider[whichOne +lifeRank].y, sizeSlider[whichOne +lifeRank].y, sizeSlider[whichOne +lifeRank].x, roundedSlider, blanc) ;

  
  // COL THREE
  // speed
  if(display_slider[whichGroup][speedRank]) sliderBG ( posSlider[whichOne +speedRank].x, posSlider[whichOne +speedRank].y, sizeSlider[whichOne +speedRank].y, sizeSlider[whichOne +speedRank].x, roundedSlider, blanc) ;
  // direction angle
  if(display_slider[whichGroup][directionRank]) sliderBG ( posSlider[whichOne +directionRank].x, posSlider[whichOne +directionRank].y, sizeSlider[whichOne +directionRank].y, sizeSlider[whichOne +directionRank].x, roundedSlider, blancGrisClair) ;
  if(display_slider[whichGroup][angleRank]) sliderBG ( posSlider[whichOne +angleRank].x, posSlider[whichOne +angleRank].y, sizeSlider[whichOne +angleRank].y, sizeSlider[whichOne +angleRank].x, roundedSlider, blancGrisClair) ;
  // Forces
  if(display_slider[whichGroup][amplitudeRank]) sliderBG (posSlider[whichOne +amplitudeRank].x, posSlider[whichOne +amplitudeRank].y, sizeSlider[whichOne +amplitudeRank].y, sizeSlider[whichOne +amplitudeRank].x, roundedSlider, blanc) ;
  if(display_slider[whichGroup][attractionRank]) sliderBG (posSlider[whichOne +attractionRank].x, posSlider[whichOne +attractionRank].y, sizeSlider[whichOne +attractionRank].y, sizeSlider[whichOne +attractionRank].x, roundedSlider, blanc) ;
  if(display_slider[whichGroup][repulsionRank]) sliderBG (posSlider[whichOne +repulsionRank].x, posSlider[whichOne +repulsionRank].y, sizeSlider[whichOne +repulsionRank].y, sizeSlider[whichOne +repulsionRank].x, roundedSlider, blanc) ;
  if(display_slider[whichGroup][influenceRank]) sliderBG ( posSlider[whichOne +influenceRank].x, posSlider[whichOne +influenceRank].y, sizeSlider[whichOne +influenceRank].y, sizeSlider[whichOne +influenceRank].x, roundedSlider, blancGrisClair) ;
  // Misc
  if(display_slider[whichGroup][alignmentRank]) sliderBG ( posSlider[whichOne +alignmentRank].x, posSlider[whichOne +alignmentRank].y, sizeSlider[whichOne +alignmentRank].y, sizeSlider[whichOne +alignmentRank].x, roundedSlider, blancGrisClair) ;
  if(display_slider[whichGroup][analyzeRank])  sliderBG ( posSlider[whichOne +analyzeRank].x, posSlider[whichOne +analyzeRank].y, sizeSlider[whichOne +analyzeRank].y, sizeSlider[whichOne +analyzeRank].x, roundedSlider, blancGrisClair) ;
}

// local void to display the HSB slider and display the specific color of this one
void sliderHSBobjectDisplay(int whichOne, int whichGroup, int hueRank, int satRank, int brightRank) {
    if ( mouseX > (posSlider[whichOne +hueRank].x ) && mouseX < (posSlider[whichOne +hueRank].x +sizeSlider[whichOne +hueRank].x) 
       && mouseY > ( posSlider[whichOne +hueRank].y - 5) && mouseY < posSlider[whichOne +hueRank].y +30 ) 
  {
    if (display_slider[whichGroup][hueRank])    hueSliderBG        (posSlider[whichOne +hueRank].x,    posSlider[whichOne +hueRank].y,    sizeSlider[whichOne +hueRank].y,    sizeSlider[whichOne +hueRank].x) ; 
    if (display_slider[whichGroup][satRank])    saturationSliderBG (posSlider[whichOne +satRank].x,    posSlider[whichOne +satRank].y,    sizeSlider[whichOne +satRank].y,    sizeSlider[whichOne +hueRank].x, valueSlider[whichOne +hueRank], valueSlider[whichOne +satRank], valueSlider[whichOne +brightRank] ) ;
    if (display_slider[whichGroup][brightRank]) brightnessSliderBG (posSlider[whichOne +brightRank].x, posSlider[whichOne +brightRank].y, sizeSlider[whichOne +brightRank].y, sizeSlider[whichOne +hueRank].x, valueSlider[whichOne +hueRank], valueSlider[whichOne +satRank], valueSlider[whichOne +brightRank] ) ;
  } else {
    if (display_slider[whichGroup][hueRank])    sliderBG (posSlider[whichOne +hueRank].x,    posSlider[whichOne +hueRank].y,    sizeSlider[whichOne +hueRank].y,    sizeSlider[whichOne +hueRank].x,    roundedSlider, blanc) ;
    if (display_slider[whichGroup][satRank])    sliderBG (posSlider[whichOne +satRank].x,    posSlider[whichOne +satRank].y,    sizeSlider[whichOne +satRank].y,    sizeSlider[whichOne +satRank].x,    roundedSlider, blanc ) ;
    if (display_slider[whichGroup][brightRank]) sliderBG (posSlider[whichOne +brightRank].x, posSlider[whichOne +brightRank].y, sizeSlider[whichOne +brightRank].y, sizeSlider[whichOne +brightRank].x, roundedSlider, blanc ) ;
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
Button  button_midi, button_curtain,
        button_bg, 
        button_light_ambient, button_light_ambient_action,
        button_light_1, button_light_1_action,
        button_light_2, button_light_2_action,
        button_beat, button_kick, button_snare, button_hat;


// init button
void init_button_general() {
  numButton = new int[NUM_GROUP_SLIDER] ;
  // General
  numButton[0] = 18 ;
  value_button_G0 = new int[numButton[0]] ;
}


// build button
void build_button_general() {

  /**
  General
  */  
  button_bg = new Button(pos_bg_button, size_bg_button) ;
  button_bg.set_on_off(true) ;
  button_bg.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  // LIGHT AMBIENT
  button_light_ambient = new Button(posLightAmbientButton, sizeLightAmbientButton) ;
  button_light_ambient.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_light_ambient_action = new Button(posLightAmbientAction, sizeLightAmbientAction) ;
  button_light_ambient_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  // LIGHT ONE
  button_light_1 = new Button(posLightOneButton, sizeLightOneButton) ;
  button_light_1.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_light_1_action = new Button(posLightOneAction, sizeLightOneAction) ;
  button_light_1_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  // LIGHT TWO 
  button_light_2 = new Button(posLightTwoButton, sizeLightTwoButton) ;
  button_light_2.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  button_light_2_action = new Button(posLightTwoAction, sizeLightTwoAction) ;
  button_light_2_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  //button beat
  button_beat = new Button(pos_beat_button, size_beat_button) ;
  button_beat.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_kick = new Button(pos_kick_button, size_kick_button) ;
  button_kick.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_snare = new Button(pos_snare_button, size_snare_button) ;
  button_snare.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_hat = new Button(pos_hat_button, size_hat_button) ;
  button_hat.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  //MIDI
  button_midi  = new Button(pos_midi_button, size_midi_button) ;
  //curtain
  button_curtain  = new Button(pos_curtain_button, size_curtain_button) ;
}













/**
Setting button
*/
// Main METHOD SETUP
void set_button_general() {
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
}






/**
Display Button
*/
/**
MAIN METHOD
*/
void display_button() {
  display_button_general() ;
  display_button_item_console() ;
  display_button_item_list() ;
  display_dropdown() ;

  buttonInfoOnTheTop() ;
  midiButtonManager(false) ;
}

void check_button() {
  check_button_general() ;
  check_button_item_console() ;
  check_button_item_list() ;
}

void mousepressed_button_general() {
  if(!dropdownActivity) {
    button_bg.mousePressedText() ;
    //LIGHT ONE
    button_light_ambient.mousePressedText() ;
    button_light_ambient_action.mousePressedText() ;
    //LIGHT ONE
    button_light_1.mousePressedText() ;
    button_light_1_action.mousePressedText() ;
    // LIGHT TWO
    button_light_2.mousePressedText() ;
    button_light_2_action.mousePressedText() ;
    //son
    button_beat.mousePressedText() ;
    button_kick.mousePressedText() ;
    button_snare.mousePressedText() ;
    button_hat.mousePressedText() ;
    //midi
    button_midi.mousePressed() ;
    //curtain
    button_curtain.mousePressed() ;
  }
}






/**
DRAW LOCAL METHOD
*/
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




void display_button_general() {
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



void check_button_general() {
  /* Check to send by OSC to Scene and Prescene */
  if(button_bg.on_off) state_BackgroundButton = 1 ; else state_BackgroundButton = 0 ;
  //LIGHT ONE
  if(button_light_ambient.on_off)  state_LightAmbientButton = 1 ; else  state_LightAmbientButton = 0 ;
  if(button_light_ambient_action.on_off) state_LightAmbientAction = 1 ; else state_LightAmbientAction =  0 ;
  //LIGHT ONE
  if(button_light_1.on_off) state_LightOneButton = 1 ; else state_LightOneButton = 0 ;
  if(button_light_1_action.on_off) state_LightOneAction = 1 ; else state_LightOneAction = 0 ;
  // LIGHT TWO
  if(button_light_2.on_off) state_LightTwoButton = 1 ; else state_LightTwoButton = 0 ;
  if(button_light_2_action.on_off) state_LightTwoAction = 1 ; else state_LightTwoAction = 0 ;
  //SOUND
  if(button_beat.on_off) state_button_beat = 1 ; else state_button_beat = 0 ;
  if(button_kick.on_off) state_button_kick = 1 ; else state_button_kick = 0 ;
  if(button_snare.on_off) state_button_snare = 1 ; else state_button_snare = 0 ;
  if(button_hat.on_off) state_button_hat = 1 ; else state_button_hat = 0 ;
  //Check position of button
  if(button_midi.on_off) state_midi_button = 1 ; else state_midi_button = 0 ;
  if(button_curtain.on_off) state_curtain_button = 1 ; else state_curtain_button = 0 ;
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


void init_dropdown() {
  // dropdown
  numDropdown = NUM_ITEM +1 ; // add one for the dropdownmenu
  lastDropdown = numDropdown -1 ;
  //dropdown
  modeListRomanesco = new String[numDropdown] ;
  dropdown = new Dropdown[numDropdown] ;
  pos_dropdown = new PVector[numDropdown] ;
}

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
  for (int i = 0 ; i<item_list_table.getRowCount() ; i++) {
    TableRow row = item_list_table.getRow(i);
    modeListRomanesco [row.getInt("ID")] = row.getString("Mode"); 
  }
  //font
  String pList [] = loadStrings(sketchPath("")+"preferences/Font/fontList.txt") ;
  String policeList = join(pList, "") ;
  font_dropdown_list = split(policeList, "/") ;
  
  //image
  init_live_data() ;
 
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

void display_dropdown() {
  // update content
  update_dropdown_content() ;
  // update dropdown item
  update_dropdown_item() ;


  update_dropdown_background() ;
  state_file_text       = update_dropdown_general(size_dropdown_file_text, pos_dropdown_file_text, dropdown_file_text, file_text_dropdown_list, title_dropdown_medium) ;
  state_image           = update_dropdown_general(size_dropdown_image, pos_dropdown_image, dropdown_image, image_dropdown_list, title_dropdown_medium) ;
  state_font            = update_dropdown_general(size_dropdown_font, pos_dropdown_font, dropdown_font, font_dropdown_list, title_dropdown_medium) ;
  state_camera_video    = update_dropdown_general(size_dropdown_camera_video, pos_dropdown_camera_video, dropdown_camera_video, name_camera_video_dropdown_list, title_dropdown_medium) ;

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

int update_dropdown_general(PVector size, PVector pos, Dropdown dropdown_menu, String [] menu_list, PFont font) {
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
void update_dropdown_background() {
  
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


void update_dropdown_item() {
  int pointer = 0 ;
  for ( int i = 1 ; i <= NUM_ITEM ; i ++ ) {
    if(modeListRomanesco[i] != null && on_off_item_list[i] ) {
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
  }
}

//END DROPDOWN DRAW
///////////////////







// DROPDOWN MOUSEPRESSED
////////////////////////
void mousepressed_dropdown() {
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
  int num = item_list_table.getRowCount() ;
  for ( int j = 0 ; j < num ; j++) {
    TableRow lookFor = item_list_table.getRow(j);
    int ID = lookFor.getInt("ID") ;
    if ( ID == IDorder ) {
      whichLine = j ;
    }
  }
  TableRow displayInfo = item_list_table.getRow(whichLine) ;
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






