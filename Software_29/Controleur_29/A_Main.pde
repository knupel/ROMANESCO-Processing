/**
Build interface 3.0.3
Romanesco Processing Environment
*/
import java.awt.event.KeyEvent;
import java.awt.image.* ;
import java.awt.* ;

// CONSTANT VAR
final int NUM_MAX_ITEM = 99 ;
final int NUM_COL_SLIDER = 3 ;
final int NUM_SLIDER_ITEM_BY_COL = 16 ;
final int NUM_GROUP_SLIDER = 2 ; // '0' for general / '1' for the item

final int NUM_SLIDER_GENERAL = 30 ;
final int NUM_SLIDER_ITEM = NUM_SLIDER_ITEM_BY_COL *NUM_COL_SLIDER ;
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
int state_font, state_bg_shader, state_image_bitmap, state_image_svg, state_movie, state_file_text, state_camera_video ;
Vec2 pos_button_font, pos_button_bg, pos_button_image_bitmap, pos_button_image_svg, pos_button_movie, pos_button_file_text, pos_button_camera_video ; 

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
int spacingBetweenSlider = 13 ;
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
int height_header = 23 ;

int height_button_top = 44 ;
int pos_y_button_top = height_header ;

int height_dropdown_top = 32 ;
int pos_y_dropdown_top = height_header +height_button_top ;

int height_menu_general = 138 ;
int pos_y_menu_general = height_header +height_button_top +height_dropdown_top ;

int height_menu_sound = 52 ;
int pos_y_menu_sound = height_header +height_button_top +height_dropdown_top +height_menu_general ;

int height_item_button_console = 95 ;
int height_item_selected = spacingBetweenSlider *NUM_SLIDER_ITEM_BY_COL +height_item_button_console;
int pos_y_item_selected = height_header +height_button_top +height_dropdown_top +height_menu_general +height_menu_sound ;

int pos_y_item_list = height_header +height_button_top +height_dropdown_top +height_menu_general +height_menu_sound +height_item_selected ;
// this value depend of the size of the scene, indeed we must calculate this one later.
int height_item_list = 100 ;
// int pos_y_item_list = height_constant ;





// button slider
int sizeTitleButton = 10 ;
int correction_button_txt_y = 1 ;
int correction_slider_txt_y = 1 ;

// CURTAIN
int correctionCurtainX = 0 ;
int correctionCurtainY = 8 ;
// GROUP MIDI
int correctionMidiX = 40 ;
int correctionMidiY = 9 ;
int spacing_midi_info = 13 ;
int correction_info_midi_x = 60 ;
int correction_info_midi_y = 10 ;
int size_x_window_info_midi = 200 ;


// MENU TOP DROPDOWN
int correction_dropdown_top_menu_y = 39 ;
int correction_dropdown_bg_x = -3 ;
int correction_dropdown_font_x = 105 ;
int correction_dropdown_txt_x = 195 ;
int correction_dropdown_image_bitmap_x = 270 ;
int correction_dropdown_image_svg_x = 368 ;
int correction_dropdown_movie_x = 450 ;
int correction_dropdown_camera_x = 520 ;

//GROUP GENERAL
int correction_slider_general_pos_y = 12 ;
int set_item_pos_y = 13 ;

// GROUP BG
int correctionBGX = colOne ;
int correctionBGY = pos_y_menu_general +set_item_pos_y +2 ;

// GROUP LIGHT
// ambient light
int correctionLightAmbientX = colOne ;
int correctionLightAmbientY = pos_y_menu_general +set_item_pos_y +73 ;
// directional light one
int correctionLightOneX = colTwo ;
int correctionLightOneY = pos_y_menu_general +set_item_pos_y +13 ;
// directional light two
int correctionLightTwoX = colTwo ;
int correctionLightTwoY = pos_y_menu_general +set_item_pos_y +73 ;

// GROUP CAMERA
int correctionCameraX = colThree ;
int correctionCameraY = pos_y_menu_general +set_item_pos_y -5 ;

// GROUP SOUND
int correctionSoundX = colOne ;
int correction_menu_sound_y = pos_y_menu_sound +15 ;

// GROUP ITEM
int correction_button_item_selected = 20 ;
int correction_dropdown_item_selected = 50 ;
int correction_slider_item_selected = 73 ;


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
  for (TableRow row : item_list_table.rows()) {
    int item_group = row.getInt("Group");
    for (int i = 0 ; i < NUM_MAX_ITEM ; i++) {
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

int line_decoration_small = 2 ;
int line_decoration_medium = 4 ;
int line_decoration_big = 6 ;

void display_structure_header() {
  noStroke() ;

  fill (rougeFonce) ; 
  rect(0,0, width, height_header) ;
}
void display_structure_top_button() {
 //  int height_button_top = 55 ;
  noStroke() ;
  //background
  fill(gris) ; 
  rect(0, pos_y_button_top, width, height_button_top) ; // main band
  //decoration
  fill(jauneOrange) ;
  rect(0,pos_y_button_top, width, line_decoration_small) ;
}
void display_structure_dropdown_menu_general() {
  noStroke() ;
  // backgorund
  fill(grisNoir) ; 
  rect(0, pos_y_dropdown_top, width, height_dropdown_top) ; // main band
  //decoration
  fill (jauneOrange) ;
  rect(0,pos_y_dropdown_top, width, line_decoration_small) ;
}


void display_structure_general() {
  noStroke() ;
  // background
  fill(gris) ; 
  rect(0,pos_y_menu_general , width, height_menu_general) ;
  // LINE DECORATION
  fill(noir) ;
  rect(0,pos_y_menu_general , width, line_decoration_small) ;
}


void display_structure_menu_sound() {
  noStroke() ;
    // background
  fill(gris) ;
  rect(0, pos_y_menu_sound, width, height_menu_sound) ; 
  // top decoration
  fill(grisTresFonce) ;
  rect(0, pos_y_menu_sound, width, line_decoration_medium) ; 
  fill(grisFonce) ;
  rect(0, pos_y_menu_sound, width, line_decoration_small) ; 
}

void display_structure_item_selected() {
  noStroke() ;
  // background
  fill(grisFonce) ;
  rect(0, pos_y_item_selected, width, height_item_selected) ; 
  // top decoration
  fill(jauneOrange) ;
  rect(0, pos_y_item_selected, width, line_decoration_medium) ; 
  fill(rougeFonce) ;
  rect(0, pos_y_item_selected, width, line_decoration_small) ; 
}
void display_structure_item_list() {
  noStroke() ;
  // background
  fill(gris) ;
  rect(0, pos_y_item_list , width, height) ; 
  // top decoration
  fill(grisTresFonce) ;
  rect(0, pos_y_item_list, width, line_decoration_small) ;
}

void display_structure_bottom() {
  noStroke() ;
  // bottom decoration
  fill (jauneOrange) ;
  rect(0,height-9, width, 2) ;
  fill (rougeFonce) ;
  rect(0,height-7, width, 7) ;
}

/**
TEXT
*/
void display_text() {
  if(insideNameversion) fill (jaune) ; else fill(orange) ;
  int posTextY = 18 ;
  textFont(FuturaStencil_20,16); 
  text(nameVersion, 5, posTextY);
  //CLOCK
  fill (orange) ; 
  textFont(FuturaStencil_20,16); textAlign(RIGHT);
  text(nf(hour(),2)   + ":" +nf(minute(),2) , width -10, posTextY);
  
  dispay_text_slider_top( height_menu_general +64) ;
  
  dislay_text_slider_item() ;
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
  set_slider_general(correction_slider_general_pos_y) ;
  set_slider_item_console(height_item_selected +correction_slider_item_selected) ;
}


// LOCAL SLIDER SETUP METHOD

// group zero, global slider for camera, sound, light, background...
////////////////////////////////////////////////////////////////////
void set_slider_general(int correction_local_y) {
  // background slider
  int startLoop = 1 ;
  for(int i = startLoop ; i <= startLoop +3 ;i++) {
    float posY = correctionBGY +correction_local_y +((i-1) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(colOne, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }

  
  
  //LIGHT
  /////////////
  // Directional light one
  startLoop = 7 ;
  for(int i = startLoop ; i <= startLoop +2 ;i++) {
    float posY = correctionLightOneY +correction_local_y +((i-startLoop) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(correctionLightOneX, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
  // Directional light two
  startLoop = 10 ;
  for(int i = startLoop ; i <= startLoop +2 ;i++) {
    float posY = correctionLightTwoY +correction_local_y +((i-startLoop) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(correctionLightTwoX, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
  
  // Ambient light
  startLoop = 13 ;
  for(int i = startLoop ; i <= startLoop +2 ;i++) {
    float posY = correctionLightAmbientY +correction_local_y +((i-startLoop) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(correctionLightAmbientX, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
  
  
  // CAMERA
  //////////
//  int correctionCameraX = colThree ;
//int correctionCameraY = height_menu_general +15 ;
   startLoop = 20 ;
  for(int i = startLoop ; i <= startLoop +8 ;i++) {
    float posY = correctionCameraY +correction_local_y +((i-startLoop) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(correctionCameraX, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }


    // SOUND
  startLoop = 5 ;
  for(int i = startLoop ; i <= startLoop +1 ;i++) {
    float posY = correction_menu_sound_y +correction_local_y +((i-startLoop) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(correctionSoundX, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
}



// Object group
///////////////////////////////////////////
void set_slider_item_console(int sliderPositionY) {
  // where the controleur must display the slider
  for( int i = 0 ; i < SLIDER_BY_COL ; i++ ) {
    for (int j = 0 ; j < NUM_COL_SLIDER ; j++) {
      // int whichSlider = i +101 +(j*10) ;
      int whichSlider = i +101 +(j *NUM_SLIDER_ITEM_BY_COL) ;
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
void display_slider_general() {
  int whichGroup = 0 ;
  display_bg_slider_general() ;
  for (int i = 1 ; i < NUM_SLIDER_GENERAL ; i++) {
     sliderUpdate(i) ;
     sliderDisplayMoletteCurrentMinMax(i, whichGroup) ;
  }
}

void display_slider_item() {
  /* different way to display depend the displaying mode. 
  Can change with "ctrl+x" */
  display_bg_slider_item() ;
  int whichGroup = 1 ;
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
  int correction_local_y = 3 ;
  int correction_local_x = sliderWidth + 5 ;
  // SOUND
  for(int i = 1 ; i < 7 ; i++ ) {
    text(genTxtGUI[i], posSlider[i].x +correction_local_x, posSlider[i].y +correction_local_y);
  }
  

  // light
  for(int i = 0 ; i < 3 ; i++ ) {
    // directional one
    text(sliderNameLight[i+1], posSlider[i +7].x +correction_local_x, posSlider[i+7].y +correction_local_y);
    // directional two
    text(sliderNameLight[i+1], posSlider[i +10].x +correction_local_x, posSlider[i+10].y +correction_local_y);
    // ambient
    text(sliderNameLight[i+1], posSlider[i +13].x +correction_local_x, posSlider[i+13].y +correction_local_y);
  }
  
  
  // CAMERA
  int numSliderCorrection = 19 ;
  for(int i = 1 ; i < sliderNameCamera.length ; i++ ) {
    text(sliderNameCamera[i], posSlider[i+numSliderCorrection].x +correction_local_x, posSlider[i+numSliderCorrection].y +correction_local_y);
  }
}



void dislay_text_slider_item() {
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  fill (colorTextUsual) ;
  textFont(textUsual_1);  textAlign(LEFT);
  
  
  // Legend text slider position for the item
  int correction_local_y = correction_slider_item_selected +4 ;
  int correction_local_x = sliderWidth + 5 ;
  for ( int i = 0 ; i < SLIDER_BY_COL_PLUS_ONE ; i++) {
    text(slider_name_col_one[i], colOne +correction_local_x, height_item_selected +correction_local_y +(i*spacingBetweenSlider));
    text(slider_name_col_two[i], colTwo +correction_local_x, height_item_selected +correction_local_y +(i*spacingBetweenSlider));
    text(slider_name_col_three[i], colThree +correction_local_x, height_item_selected +correction_local_y +(i*spacingBetweenSlider));
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
  slider_HSB_general_display(start) ;
  sliderBG(posSlider[4].x, posSlider[4].y, sizeSlider[4].y, sizeSlider[4].x, roundedSlider, blancGris) ;
}

// light local variable display
void sliderAmbientLight() {
  int start = 12;
  slider_HSB_general_display(start) ;
}

void sliderDirectionalLightOne() {
  int start = 6 ;
  slider_HSB_general_display(start) ;
}

void sliderDirectionalLightTwo() {
  int start = 9 ;
  slider_HSB_general_display(start) ;
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
void slider_HSB_general_display(int start) {
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







/**
Slider display for the item slider
*/
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

  // COL 1
  slider_HSB_item_display(whichOne, whichGroup, hue_fill_rank, sat_fill_rank, bright_fill_rank) ;
  if (display_slider[whichGroup][alpha_fill_rank]) sliderBG (posSlider[whichOne +alpha_fill_rank].x, posSlider[whichOne +alpha_fill_rank].y, sizeSlider[whichOne +alpha_fill_rank].y, sizeSlider[whichOne +alpha_fill_rank].x, roundedSlider, blanc ) ;
  
  //outline color
  slider_HSB_item_display(whichOne, whichGroup, hue_stroke_rank, sat_stroke_rank, bright_stroke_rank) ;
  if (display_slider[whichGroup][alpha_stroke_rank]) sliderBG (posSlider[whichOne +alpha_stroke_rank].x, posSlider[whichOne +alpha_stroke_rank].y, sizeSlider[whichOne +alpha_stroke_rank].y, sizeSlider[whichOne +alpha_stroke_rank].x, roundedSlider, blancGrisClair) ;
  //  thickness
  if( display_slider[whichGroup][thickness_rank]) sliderBG (posSlider[whichOne +thickness_rank].x, posSlider[whichOne +thickness_rank].y, sizeSlider[whichOne +thickness_rank].y, sizeSlider[whichOne +thickness_rank].x, roundedSlider, blanc) ;
  // size
  if(display_slider[whichGroup][size_x_rank])  sliderBG (posSlider[whichOne +size_x_rank].x, posSlider[whichOne +size_x_rank].y, sizeSlider[whichOne +size_x_rank].y, sizeSlider[whichOne +size_x_rank].x, roundedSlider, blancGrisClair) ;
  if(display_slider[whichGroup][size_y_rank]) sliderBG (posSlider[whichOne +size_y_rank].x, posSlider[whichOne +size_y_rank].y, sizeSlider[whichOne +size_y_rank].y, sizeSlider[whichOne +size_y_rank].x, roundedSlider, blancGrisClair) ;
  if(display_slider[whichGroup][size_z_rank])  sliderBG (posSlider[whichOne +size_z_rank].x, posSlider[whichOne +size_z_rank].y, sizeSlider[whichOne +size_z_rank].y, sizeSlider[whichOne +size_z_rank].x, roundedSlider, blancGrisClair) ;
  // canvas
  if(display_slider[whichGroup][canvas_x_rank]) sliderBG (posSlider[whichOne +canvas_x_rank].x, posSlider[whichOne +canvas_x_rank].y, sizeSlider[whichOne +canvas_x_rank].y, sizeSlider[whichOne +canvas_x_rank].x, roundedSlider, blanc) ;
  if(display_slider[whichGroup][canvas_y_rank]) sliderBG (posSlider[whichOne +canvas_y_rank].x, posSlider[whichOne +canvas_y_rank].y, sizeSlider[whichOne +canvas_y_rank].y, sizeSlider[whichOne +canvas_y_rank].x, roundedSlider, blanc) ;
  if(display_slider[whichGroup][canvas_z_rank]) sliderBG (posSlider[whichOne +canvas_z_rank].x, posSlider[whichOne +canvas_z_rank].y, sizeSlider[whichOne +canvas_z_rank].y, sizeSlider[whichOne +canvas_z_rank].x, roundedSlider, blanc) ;
  

  // COL 2
  // reactivity
  if(display_slider[whichGroup][reactivity_rank]) sliderBG ( posSlider[whichOne +reactivity_rank].x, posSlider[whichOne +reactivity_rank].y, sizeSlider[whichOne +reactivity_rank].y, sizeSlider[whichOne +reactivity_rank].x, roundedSlider, blancGrisClair) ;
  // speed
  if(display_slider[whichGroup][speed_x_rank]) sliderBG (posSlider[whichOne +speed_x_rank].x, posSlider[whichOne +speed_x_rank].y, sizeSlider[whichOne +speed_x_rank].y, sizeSlider[whichOne +speed_x_rank].x, roundedSlider, blanc) ;
  if(display_slider[whichGroup][speed_y_rank]) sliderBG ( posSlider[whichOne +speed_y_rank].x, posSlider[whichOne +speed_y_rank].y, sizeSlider[whichOne +speed_y_rank].y, sizeSlider[whichOne +speed_y_rank].x, roundedSlider, blanc) ;
  if(display_slider[whichGroup][speed_z_rank]) sliderBG ( posSlider[whichOne +speed_z_rank].x, posSlider[whichOne +speed_z_rank].y, sizeSlider[whichOne +speed_z_rank].y, sizeSlider[whichOne +speed_z_rank].x, roundedSlider, blanc) ;
  // spurt
  if(display_slider[whichGroup][spurt_x_rank]) sliderBG ( posSlider[whichOne +spurt_x_rank].x, posSlider[whichOne +spurt_x_rank].y, sizeSlider[whichOne +spurt_x_rank].y, sizeSlider[whichOne +spurt_x_rank].x, roundedSlider, blancGrisClair) ;
  if(display_slider[whichGroup][spurt_y_rank]) sliderBG ( posSlider[whichOne +spurt_y_rank].x, posSlider[whichOne +spurt_y_rank].y, sizeSlider[whichOne +spurt_y_rank].y, sizeSlider[whichOne +spurt_y_rank].x, roundedSlider, blancGrisClair) ;
  if(display_slider[whichGroup][spurt_z_rank]) sliderBG (posSlider[whichOne +spurt_z_rank].x, posSlider[whichOne +spurt_z_rank].y, sizeSlider[whichOne +spurt_z_rank].y, sizeSlider[whichOne +spurt_z_rank].x, roundedSlider, blancGrisClair) ;
  // direction
  if(display_slider[whichGroup][dir_x_rank]) sliderBG (posSlider[whichOne +dir_x_rank].x, posSlider[whichOne +dir_x_rank].y, sizeSlider[whichOne +dir_x_rank].y, sizeSlider[whichOne +dir_x_rank].x, roundedSlider, blanc) ;
  if(display_slider[whichGroup][dir_y_rank]) sliderBG (posSlider[whichOne +dir_y_rank].x, posSlider[whichOne +dir_y_rank].y, sizeSlider[whichOne +dir_y_rank].y, sizeSlider[whichOne +dir_y_rank].x, roundedSlider, blanc) ;
  if(display_slider[whichGroup][dir_z_rank]) sliderBG ( posSlider[whichOne +dir_z_rank].x, posSlider[whichOne +dir_z_rank].y, sizeSlider[whichOne +dir_z_rank].y, sizeSlider[whichOne +dir_z_rank].x, roundedSlider, blanc) ;
  // jitter
  if(display_slider[whichGroup][jitter_x_rank]) sliderBG ( posSlider[whichOne +jitter_x_rank].x, posSlider[whichOne +jitter_x_rank].y, sizeSlider[whichOne +jitter_x_rank].y, sizeSlider[whichOne +jitter_x_rank].x, roundedSlider, blancGrisClair) ;
  if(display_slider[whichGroup][jitter_y_rank])  sliderBG ( posSlider[whichOne +jitter_y_rank].x, posSlider[whichOne +jitter_y_rank].y, sizeSlider[whichOne +jitter_y_rank].y, sizeSlider[whichOne +jitter_y_rank].x, roundedSlider, blancGrisClair) ;
  if(display_slider[whichGroup][jitter_z_rank])  sliderBG ( posSlider[whichOne +jitter_z_rank].x, posSlider[whichOne +jitter_z_rank].y, sizeSlider[whichOne +jitter_z_rank].y, sizeSlider[whichOne +jitter_z_rank].x, roundedSlider, blancGrisClair) ;
  // swing
  if(display_slider[whichGroup][swing_x_rank]) sliderBG ( posSlider[whichOne +swing_x_rank].x, posSlider[whichOne +swing_x_rank].y, sizeSlider[whichOne +swing_x_rank].y, sizeSlider[whichOne +swing_x_rank].x, roundedSlider, blancGrisClair) ;
  if(display_slider[whichGroup][swing_y_rank])  sliderBG ( posSlider[whichOne +swing_y_rank].x, posSlider[whichOne +swing_y_rank].y, sizeSlider[whichOne +swing_y_rank].y, sizeSlider[whichOne +swing_y_rank].x, roundedSlider, blancGrisClair) ;
  if(display_slider[whichGroup][swing_z_rank])  sliderBG ( posSlider[whichOne +swing_z_rank].x, posSlider[whichOne +swing_z_rank].y, sizeSlider[whichOne +swing_z_rank].y, sizeSlider[whichOne +swing_z_rank].x, roundedSlider, blancGrisClair) ;

  
  // COL 3
  // quantity
  if(display_slider[whichGroup][quantity_rank]) sliderBG ( posSlider[whichOne +quantity_rank].x, posSlider[whichOne +quantity_rank].y, sizeSlider[whichOne +quantity_rank].y, sizeSlider[whichOne +quantity_rank].x, roundedSlider, blancGrisClair) ;
  // variety
  if(display_slider[whichGroup][variety_rank]) sliderBG ( posSlider[whichOne +variety_rank].x, posSlider[whichOne +variety_rank].y, sizeSlider[whichOne +variety_rank].y, sizeSlider[whichOne +variety_rank].x, roundedSlider, blancGrisClair) ;
  
  // life
  if(display_slider[whichGroup][life_rank]) sliderBG ( posSlider[whichOne +life_rank].x, posSlider[whichOne +life_rank].y, sizeSlider[whichOne +life_rank].y, sizeSlider[whichOne +life_rank].x, roundedSlider, blancGrisClair) ;
  // fertility
  if(display_slider[whichGroup][fertility_rank]) sliderBG ( posSlider[whichOne +fertility_rank].x, posSlider[whichOne +fertility_rank].y, sizeSlider[whichOne +fertility_rank].y, sizeSlider[whichOne +fertility_rank].x, roundedSlider, blancGrisClair) ;
  // quality
  if(display_slider[whichGroup][quality_rank]) sliderBG ( posSlider[whichOne +quality_rank].x, posSlider[whichOne +quality_rank].y, sizeSlider[whichOne +quality_rank].y, sizeSlider[whichOne +quality_rank].x, roundedSlider, blancGrisClair) ;
  
  // area
  if(display_slider[whichGroup][area_rank]) sliderBG ( posSlider[whichOne +area_rank].x, posSlider[whichOne +area_rank].y, sizeSlider[whichOne +area_rank].y, sizeSlider[whichOne +area_rank].x, roundedSlider, blancGrisClair) ;
  // angle
  if(display_slider[whichGroup][angle_rank]) sliderBG ( posSlider[whichOne +angle_rank].x, posSlider[whichOne +angle_rank].y, sizeSlider[whichOne +angle_rank].y, sizeSlider[whichOne +angle_rank].x, roundedSlider, blancGrisClair) ;
  // scope
  if(display_slider[whichGroup][scope_rank]) sliderBG ( posSlider[whichOne +scope_rank].x, posSlider[whichOne +scope_rank].y, sizeSlider[whichOne +scope_rank].y, sizeSlider[whichOne +scope_rank].x, roundedSlider, blancGrisClair) ;
  // scan
  if(display_slider[whichGroup][scan_rank]) sliderBG ( posSlider[whichOne +scan_rank].x, posSlider[whichOne +scan_rank].y, sizeSlider[whichOne +scan_rank].y, sizeSlider[whichOne +scan_rank].x, roundedSlider, blancGrisClair) ;
  
  // alignment
  if(display_slider[whichGroup][alignment_rank]) sliderBG ( posSlider[whichOne +alignment_rank].x, posSlider[whichOne +alignment_rank].y, sizeSlider[whichOne +alignment_rank].y, sizeSlider[whichOne +alignment_rank].x, roundedSlider, blancGrisClair) ;
  // repulsion
  if(display_slider[whichGroup][repulsion_rank]) sliderBG ( posSlider[whichOne +repulsion_rank].x, posSlider[whichOne +repulsion_rank].y, sizeSlider[whichOne +repulsion_rank].y, sizeSlider[whichOne +repulsion_rank].x, roundedSlider, blancGrisClair) ;
  // attraction
  if(display_slider[whichGroup][attraction_rank]) sliderBG ( posSlider[whichOne +attraction_rank].x, posSlider[whichOne +attraction_rank].y, sizeSlider[whichOne +attraction_rank].y, sizeSlider[whichOne +attraction_rank].x, roundedSlider, blancGrisClair) ;
  // charge
  if(display_slider[whichGroup][charge_rank]) sliderBG ( posSlider[whichOne +charge_rank].x, posSlider[whichOne +charge_rank].y, sizeSlider[whichOne +charge_rank].y, sizeSlider[whichOne +charge_rank].x, roundedSlider, blancGrisClair) ;
  
  // influence
  if(display_slider[whichGroup][influence_rank]) sliderBG ( posSlider[whichOne +influence_rank].x, posSlider[whichOne +influence_rank].y, sizeSlider[whichOne +influence_rank].y, sizeSlider[whichOne +influence_rank].x, roundedSlider, blancGrisClair) ;
  // calm
  if(display_slider[whichGroup][calm_rank]) sliderBG ( posSlider[whichOne +calm_rank].x, posSlider[whichOne +calm_rank].y, sizeSlider[whichOne +calm_rank].y, sizeSlider[whichOne +calm_rank].x, roundedSlider, blancGrisClair) ;
  // appetit
  if(display_slider[whichGroup][appetit_rank]) sliderBG ( posSlider[whichOne +appetit_rank].x, posSlider[whichOne +appetit_rank].y, sizeSlider[whichOne +appetit_rank].y, sizeSlider[whichOne +appetit_rank].x, roundedSlider, blancGrisClair) ;
}

// local void to display the HSB slider and display the specific color of this one
void slider_HSB_item_display(int whichOne, int whichGroup, int hueRank, int satRank, int brightRank) {
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
  numButton[0] = 20 ;
  value_button_G0 = new int[numButton[0]] ;
}


// build button
void build_button_general() {

  /**
  Top menu
  */

    //MIDI
  button_midi  = new Button(pos_midi_button, size_midi_button) ;
  //curtain
  button_curtain  = new Button(pos_curtain_button, size_curtain_button) ;
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
  
  /**
  Sound
  *///button beat
  button_beat = new Button(pos_beat_button, size_beat_button) ;
  button_beat.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_kick = new Button(pos_kick_button, size_kick_button) ;
  button_kick.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_snare = new Button(pos_snare_button, size_snare_button) ;
  button_snare.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_hat = new Button(pos_hat_button, size_hat_button) ;
  button_hat.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

}













/**
Setting button
*/
// Main METHOD SETUP
void set_button_general() {
  // MIDI

  size_midi_button = Vec2(50,26) ;
  pos_midi_button = Vec2(colOne +correctionMidiX, pos_y_button_top +correctionMidiY) ;
  pos_midi_info =Vec2(pos_midi_button.x +correction_info_midi_x, pos_midi_button.y +correction_info_midi_y) ;
  // CURTAIN
  size_curtain_button = Vec2(30,30) ;
  pos_curtain_button = Vec2(colOne +correctionCurtainX, pos_y_button_top +correctionCurtainY) ; 
  
  
  // BACKGROUND
  pos_bg_button = Vec2(correctionBGX, correctionBGY +correction_button_txt_y) ;
  size_bg_button = Vec2(120,10) ;
  
  // LIGHT
  // ambient button
  posLightAmbientButton = Vec2(correctionLightAmbientX, correctionLightAmbientY +correction_button_txt_y) ;
  sizeLightAmbientButton = Vec2(80,10) ;
  posLightAmbientAction = Vec2(correctionLightAmbientX +90, posLightAmbientButton.y) ; // for the y we take the y of the button
  sizeLightAmbientAction = Vec2(45,10) ;
  // light one button
  posLightOneButton = Vec2(correctionLightOneX, correctionLightOneY +correction_button_txt_y) ;
  sizeLightOneButton = Vec2(80,10) ;
  posLightOneAction = Vec2(correctionLightOneX +90, posLightOneButton.y) ; // for the y we take the y of the button
  sizeLightOneAction = Vec2(45,10) ;
  // light two button
  posLightTwoButton = Vec2(correctionLightTwoX, correctionLightTwoY +correction_button_txt_y) ;
  sizeLightTwoButton = Vec2(80,10) ;
  posLightTwoAction = Vec2(correctionLightTwoX +90, posLightTwoButton.y) ; // for the y we take the y of the button
  sizeLightTwoAction = Vec2(45,10) ;
  
  //SOUND BUTTON
  size_beat_button = Vec2(30,10) ; 
  size_kick_button = Vec2(30,10) ; 
  size_snare_button = Vec2(40,10) ; 
  size_hat_button = Vec2(30,10) ;
  
  pos_beat_button = Vec2(correctionSoundX, correction_menu_sound_y +correction_button_txt_y) ; 
  pos_kick_button = Vec2(pos_beat_button.x +size_beat_button.x +5, correction_menu_sound_y +correction_button_txt_y) ; 
  pos_snare_button = Vec2(pos_kick_button.x +size_kick_button.x +5, correction_menu_sound_y +correction_button_txt_y) ; 
  pos_hat_button = Vec2(pos_snare_button.x +size_snare_button.x +5, correction_menu_sound_y +correction_button_txt_y) ;
}






/**
Display Button
*/
/**
MAIN METHOD
*/
void display_button_and_dropdown() {
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
int ref_size_image_bitmap_dropdown, ref_size_image_svg_dropdown, ref_size_movie_dropdown, refSizeFileTextDropdown, refSizeCameraVideoDropdown ;
PVector pos_text_dropdown_image_bitmap, pos_text_dropdown_image_svg, pos_text_dropdown_movie, posTextdropdown_file_text, posTextdropdown_camera_video ; 
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

  for(int i = 0 ; i < numDropdown  ; i++) {
    pos_dropdown[i] = new PVector() ;
  }
}

void set_dropdown_general() {

  pos_button_bg = Vec2(colOne +correction_dropdown_bg_x,      height_dropdown_top +correction_dropdown_top_menu_y)  ;
  pos_button_font = Vec2(colOne +correction_dropdown_font_x,            height_dropdown_top +correction_dropdown_top_menu_y)  ; 
  pos_button_image_bitmap =  Vec2(colOne +correction_dropdown_image_bitmap_x,           height_dropdown_top +correction_dropdown_top_menu_y)  ; 
  pos_button_image_svg =  Vec2(colOne +correction_dropdown_image_svg_x,           height_dropdown_top +correction_dropdown_top_menu_y)  ; 
  pos_button_movie =  Vec2(colOne +correction_dropdown_movie_x,           height_dropdown_top +correction_dropdown_top_menu_y)  ; 
  pos_button_file_text = Vec2(colOne +correction_dropdown_txt_x,        height_dropdown_top +correction_dropdown_top_menu_y)  ; 
  pos_button_camera_video = Vec2(colOne +correction_dropdown_camera_x,     height_dropdown_top +correction_dropdown_top_menu_y)  ; 
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
  String pList [] = loadStrings(sketchPath("")+"import/font/fontList.txt") ;
  String policeList = join(pList, "") ;
  font_dropdown_list = split(policeList, "/") ;
  
  //image
  init_live_data() ;
 
  //SHADER backgorund dropdown
  
  ///////////////
  pos_dropdown_bg = new PVector(pos_button_bg.x, pos_button_bg.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  size_dropdown_bg = new PVector (75, sizeToRenderTheBoxDropdown, 10) ; // z is the num of line you show
  PVector posTextDropdownBackground = new PVector(3, 10)  ;
  dropdown_bg = new Dropdown("Background", shader_bg_name, pos_dropdown_bg, size_dropdown_bg, posTextDropdownBackground, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  
  // FONT dropdown
  ///////////////
  pos_dropdown_font = new PVector(pos_button_font.x, pos_button_font.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  size_dropdown_font = new PVector (40, sizeToRenderTheBoxDropdown, 10 ) ; // z is the num of line you show
  PVector posTextDropdownTypo = new PVector(3, 10)  ;
  dropdown_font = new Dropdown("Font", font_dropdown_list,   pos_dropdown_font , size_dropdown_font, posTextDropdownTypo, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  // Image bitmap Dropdown
  //////////////////
  pos_dropdown_image_bitmap = new PVector(pos_button_image_bitmap.x, pos_button_image_bitmap.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  size_dropdown_image_bitmap = new PVector (60, sizeToRenderTheBoxDropdown, 10 ) ; // z is the num of line you show
  pos_text_dropdown_image_bitmap = new PVector(3, 10)  ;
  ref_size_image_bitmap_dropdown = image_bitmap_dropdown_list.length ;
  dropdown_image_bitmap = new Dropdown("Image bitmap", image_bitmap_dropdown_list, pos_dropdown_image_bitmap, size_dropdown_image_bitmap, pos_text_dropdown_image_bitmap, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  // Image svg Dropdown
  //////////////////
  pos_dropdown_image_svg = new PVector(pos_button_image_svg.x, pos_button_image_svg.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  size_dropdown_image_svg = new PVector (60, sizeToRenderTheBoxDropdown, 10 ) ; // z is the num of line you show
  pos_text_dropdown_image_svg = new PVector(3, 10)  ;
  ref_size_image_svg_dropdown = image_svg_dropdown_list.length ;
  dropdown_image_svg = new Dropdown("Image svg", image_svg_dropdown_list, pos_dropdown_image_svg, size_dropdown_image_svg, pos_text_dropdown_image_svg, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
 
  // Movie Dropdown
  //////////////////
  pos_dropdown_movie = new PVector(pos_button_movie.x, pos_button_movie.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  size_dropdown_movie = new PVector (60, sizeToRenderTheBoxDropdown, 10 ) ; // z is the num of line you show
  pos_text_dropdown_movie = new PVector(3, 10)  ;
  ref_size_movie_dropdown = movie_dropdown_list.length ;
  dropdown_movie = new Dropdown("Movie", movie_dropdown_list, pos_dropdown_movie, size_dropdown_movie, pos_text_dropdown_movie, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
 
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
}

void set_dropdown_item_selected() {
  colorDropdownTitleIn = rouge ;
  colorDropdownTitleOut = rougeFonce ;
  //common param
  int numLineDisplayByTheDropdownObj = 8 ;
  size_dropdown_mode = new PVector (20, sizeToRenderTheBoxDropdown, numLineDisplayByTheDropdownObj) ;
  // int correction_dropdown_item_selected +correction_button_item
  PVector newPos = new PVector(margeLeft + -8, height_item_selected +correction_dropdown_item_selected, .1 ) ;
  // group item
  for ( int i = 0 ; i <= NUM_ITEM ; i++ ) {
    if(modeListRomanesco[i] != null) {
      //Split the dropdown to display in the dropdown
      list_dropdown = split(modeListRomanesco[i], "/" ) ;
      //to change the title of the header dropdown
      pos_dropdown[i].set(newPos.x, newPos.y, newPos.z) ; // x y is pos anz z is marge between the dropdown and the header
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
  state_image_bitmap           = update_dropdown_general(size_dropdown_image_bitmap, pos_dropdown_image_bitmap, dropdown_image_bitmap, image_bitmap_dropdown_list, title_dropdown_medium) ;
  state_image_svg           = update_dropdown_general(size_dropdown_image_svg, pos_dropdown_image_svg, dropdown_image_svg, image_svg_dropdown_list, title_dropdown_medium) ;
  state_movie          = update_dropdown_general(size_dropdown_movie, pos_dropdown_movie, dropdown_movie, movie_dropdown_list, title_dropdown_medium) ;
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
  // update content bitmap
  if(image_bitmap_dropdown_list.length != ref_size_image_bitmap_dropdown ) {
    dropdown_image_bitmap = new Dropdown("Image bitmap", image_bitmap_dropdown_list, pos_dropdown_image_bitmap, size_dropdown_image_bitmap, pos_text_dropdown_image_bitmap, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
    ref_size_image_bitmap_dropdown = image_bitmap_dropdown_list.length ;
  }
  // update content svg
  if(image_svg_dropdown_list.length != ref_size_image_svg_dropdown ) {
    dropdown_image_svg = new Dropdown("Image svg", image_svg_dropdown_list, pos_dropdown_image_svg, size_dropdown_image_svg, pos_text_dropdown_image_svg, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
    ref_size_image_svg_dropdown = image_svg_dropdown_list.length ;
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
  if(shader_bg_name.length < size_dropdown_bg.z ) heightDropdown = shader_bg_name.length ; else heightDropdown = (int)size_dropdown_bg.z ;
  PVector total_size = new PVector ( newSizeFont.x +(marge_around_dropdown *1.5), size_dropdown_bg.y *(heightDropdown +1) +marge_around_dropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  PVector new_pos = new PVector (pos_dropdown_bg.x -marge_around_dropdown, pos_dropdown_bg.y) ;
  if (!insideRect(new_pos, total_size)) dropdown_bg.locked = false ;
  // display the selection
  
  if(!dropdown_bg.locked) {
    fill(selectedText) ;
    textFont(textUsual_2) ;
    state_bg_shader = dropdown_bg.getSelection() ;
    if (dropdown_bg.getSelection() != 0 ) {
      text(shader_bg_name[state_bg_shader] +" by " +shader_bg_author[dropdown_bg.getSelection()], pos_dropdown_bg.x +3 , pos_dropdown_bg.y +22) ;
    } else {
      text(shader_bg_name[state_bg_shader], pos_dropdown_bg.x +3 , pos_dropdown_bg.y +22) ;
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
  check_dropdown_mousepressed (pos_dropdown_bg,  size_dropdown_bg,  dropdown_bg) ;
  check_dropdown_mousepressed (pos_dropdown_font,        size_dropdown_font,        dropdown_font) ;
  check_dropdown_mousepressed (pos_dropdown_image_bitmap,       size_dropdown_image_bitmap,       dropdown_image_bitmap) ;
  check_dropdown_mousepressed (pos_dropdown_image_svg,       size_dropdown_image_svg,       dropdown_image_svg) ;
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







