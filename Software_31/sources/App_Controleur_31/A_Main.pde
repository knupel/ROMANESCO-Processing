/**
Build interface 
v 3.1.0
2014-2018
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
    slider_item_nameCamera[i] = ("") ;
  }
}

void reset() {
  init_slider_dynamic() ;
  INIT_INTERFACE = false ;
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
  for (TableRow row : inventory_item_table.rows()) {
    int item_group = row.getInt("Group");
    for (int i = 0 ; i < NUM_MAX_ITEM ; i++) {
      if (item_group == i) NUM_ITEM += 1 ;
    }
  }
}




















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

void display_structure_inventory_item() {
  noStroke() ;
  // background
  fill(gris) ;
  rect(0, pos_y_inventory_item , width, height) ; 
  // top decoration
  fill(grisTresFonce) ;
  rect(0, pos_y_inventory_item, width, line_decoration_small) ;
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
    build_button_inventory_item() ;
    set_inventory_item() ;
    size_ref.set(width, height) ;
  }
}






















/**
SLIDER
v 1.0.0
*/
void init_slider() {
  for (int i = 0 ; i < NUM_SLIDER_TOTAL ; i++) {
    sizeSlider[i] = Vec2() ;
    posSlider[i] = Vec2() ; 
  }
}

void build_slider() {
  for ( int i = 1 ; i < NUM_SLIDER_TOTAL ; i++) {
    Vec2 sizeMol = Vec2(sizeSlider[i].y *ratio_size_molette, sizeSlider[i].y *ratio_size_molette) ;
    // we use the var posMol here just to init the Slider, because we load data from save further.
    Vec2 posMol = Vec2() ;
    Vec2 tempPosSlider = Vec2(posSlider[i].x, posSlider[i].y -(slider_height *.6)) ;
    if(info_save_raw_list(infoSlider,i).a > -1 ) {
      slider[i] = new SliderAdjustable(tempPosSlider, posMol, sizeSlider[i], sizeMol, "ELLIPSE");
    }
    if(slider[i] != null) slider[i].setting() ;
  } 
}


// SLIDER SETUP
// MAIN METHOD SLIDER SETUP
void set_slider() {
  set_slider_general(correction_slider_general_pos_y) ;
  set_slider_item_console(height_item_selected +local_pos_y_slider_button) ;
}


// LOCAL SLIDER SETUP METHOD
void set_slider_general(int correction_local_y) {
  // background slider
  int startLoop = 1 ;
  for(int i = startLoop ; i <= startLoop +3 ;i++) {
    float posY = correctionBGY +correction_local_y +((i-1) *spacing_slider);
    posSlider[i] = Vec2(col_1, posY);
    sizeSlider[i] = Vec2(slider_width,slider_height);
  }

  // Directional light one
  startLoop = 7 ;
  for(int i = startLoop ; i <= startLoop +2 ;i++) {
    float posY = correctionLightOneY +correction_local_y +((i-startLoop) *spacing_slider);
    posSlider[i] = Vec2(correctionLightOneX, posY);
    sizeSlider[i] = Vec2(slider_width,slider_height);
  }

  // Directional light two
  startLoop = 10 ;
  for(int i = startLoop ; i <= startLoop +2 ;i++) {
    float posY = correctionLightTwoY +correction_local_y +((i-startLoop) *spacing_slider);
    posSlider[i] = Vec2(correctionLightTwoX, posY);
    sizeSlider[i] = Vec2(slider_width,slider_height);
  }
  
  // Ambient light
  startLoop = 13 ;
  for(int i = startLoop ; i <= startLoop +2 ;i++) {
    float posY = correctionLightAmbientY +correction_local_y +((i-startLoop) *spacing_slider);
    posSlider[i] = Vec2(correctionLightAmbientX, posY);
    sizeSlider[i] = Vec2(slider_width,slider_height);
  }
  
  
  // camera
  startLoop = 20 ;
  for(int i = startLoop ; i <= startLoop +8 ;i++) {
    float posY = correctionCameraY +correction_local_y +((i-startLoop) *spacing_slider) ;
    posSlider[i] = Vec2(correctionCameraX, posY);
    sizeSlider[i] = Vec2(slider_width,slider_height);
  }


  // sound
  startLoop = 5 ;
  for(int i = startLoop ; i <= startLoop +1 ;i++) {
    float posY = correction_menu_sound_y +correction_local_y +((i-startLoop) *spacing_slider) ;
    posSlider[i] = Vec2(correctionSoundX, posY);
    sizeSlider[i] = Vec2(slider_width,slider_height);
  }
}

// item
void set_slider_item_console(int pos_y) {
  // where the controleur must display the slider
  for( int i = 0 ; i < SLIDER_BY_COL ; i++ ) {
    for (int j = 0 ; j < NUM_COL_SLIDER ; j++) {
      // int whichSlider = i +101 +(j*10) ;
      int whichSlider = i +101 +(j *NUM_SLIDER_ITEM_BY_COL) ;
      int pos_x = 0 ;
      switch(j) {
        case 0 : pos_x = col_1; 
        break;
        case 1 : pos_x = col_2;
        break;
        case 2 : pos_x = col_3;
        break ;
      }
      posSlider [whichSlider] = Vec2(pos_x, pos_y +i *spacing_slider);
      sizeSlider [whichSlider] = Vec2(slider_width, slider_height);
    }
  }
}








// SLIDER DRAW
void display_slider_general() {
  int whichGroup = 0 ;
  display_bg_slider_general() ;
  for (int i = 1 ; i < NUM_SLIDER_GENERAL ; i++) {
    update_slider(i) ;
    display_current_slider_engine(i, whichGroup) ;
  }
}









// SLIDER UPDATE
void update_slider(int whichOne) {
  //MIDI update
  update_midi_slider(whichOne) ;

  // MIN and MAX molette
  //check
  if(!slider[whichOne].lockedMol && !slider[whichOne].insideMol ) {
    // min molette
    if(!slider[whichOne].insideMax() && !slider[whichOne].lockedMax) {
      slider[whichOne].insideMin() ;
      slider[whichOne].select_min() ;
      slider[whichOne].update_min() ;
    }
    // max molette
    if(!slider[whichOne].insideMin() && !slider[whichOne].lockedMin) {
      slider[whichOne].insideMax() ;
      slider[whichOne].select_max() ;
      slider[whichOne].update_max() ;
    }
  }
  // update 
  slider[whichOne].update_min_max() ;
  
  
  // CURRENT molette
  // check
  if(!slider[whichOne].lockedMax  && !slider[whichOne].lockedMax) slider[whichOne].insideMol_Ellipse() ;
  // update
  slider[whichOne].select_molette() ;
  slider[whichOne].update_pos_molette() ;
  
  // translate float value to int, to use OSC easily without problem of Array Outbound...blablah
  int valueMax = 360 ;
  valueSlider[whichOne] = constrain(map(slider[whichOne].getValue(), 0, 1, 0,valueMax),0,valueMax)  ;
}

void display_current_slider_engine(int whichOne, int whichGroup) {
  if (whichGroup == 0) {
    display_min_max_slider(whichOne, grisTresFonce, gris) ;
    display_current_mollette(whichOne, blanc, blancGris) ;
  } else {
    display_min_max_slider(whichOne, grisFonce, grisClair) ;
    display_current_mollette(whichOne, blanc, blancGris) ;
  }
}

// local method
void display_min_max_slider(int whichOne,  color colorIn, color colorOut) {
  float thickness = 0 ;
  slider[whichOne].displayMinMax(ratio_pos_slider_adjustable, ratio_size_slider_adjustable, colorIn, colorOut, colorIn, colorOut, thickness) ;
}

void display_current_mollette(int whichOne, color colorMolIn, color colorMolOut) {
  slider[whichOne].displayMolette(colorMolIn,colorMolOut, colorMolIn,colorMolOut, 1) ;
}
// end local method















/**
SLIDER DISPLAY GENERAL
*/
// TEXT slider
void dispay_text_slider_top(int pos) {
  // GROUP ZERO
  textAlign(LEFT);
  textFont(textUsual_1) ; 
  fill (colorTextUsual) ;

  //BACKGROUND
  int correction_local_y = 3 ;
  int correction_local_x = slider_width + 5 ;
  // SOUND
  for(int i = 1 ; i < 7 ; i++ ) {
    text(genTxtGUI[i], posSlider[i].x +correction_local_x, posSlider[i].y +correction_local_y);
  }
  

  // light
  for(int i = 0 ; i < 3 ; i++ ) {
    // directional one
    text(slider_item_nameLight[i+1], posSlider[i +7].x +correction_local_x, posSlider[i+7].y +correction_local_y);
    // directional two
    text(slider_item_nameLight[i+1], posSlider[i +10].x +correction_local_x, posSlider[i+10].y +correction_local_y);
    // ambient
    text(slider_item_nameLight[i+1], posSlider[i +13].x +correction_local_x, posSlider[i+13].y +correction_local_y);
  }
  
  
  // CAMERA
  int numSliderCorrection = 19 ;
  for(int i = 1 ; i < slider_item_nameCamera.length ; i++ ) {
    text(slider_item_nameCamera[i], posSlider[i+numSliderCorrection].x +correction_local_x, posSlider[i+numSliderCorrection].y +correction_local_y);
  }
}






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
  sliderBG(posSlider[4].x, posSlider[4].y, sizeSlider[4].y, sizeSlider[4].x, rounded_slider, blancGris) ;
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
  sliderBG ( posSlider[5].x, posSlider[5].y, sizeSlider[5].y, sizeSlider[5].x, rounded_slider, grisClair) ;
  sliderBG ( posSlider[6].x, posSlider[6].y, sizeSlider[6].y, sizeSlider[6].x, rounded_slider, grisClair) ;
}

void sliderCameraDisplay() {
  // we cannot loop, because we change the color of display at the end of the function
  sliderBG ( posSlider[20].x, posSlider[20].y, sizeSlider[20].y, sizeSlider[20].x, rounded_slider, grisClair) ;
  sliderBG ( posSlider[21].x, posSlider[21].y, sizeSlider[21].y, sizeSlider[21].x, rounded_slider, grisClair) ;
  sliderBG ( posSlider[22].x, posSlider[22].y, sizeSlider[22].y, sizeSlider[22].x, rounded_slider, blancGris) ;
  sliderBG ( posSlider[23].x, posSlider[23].y, sizeSlider[23].y, sizeSlider[23].x, rounded_slider, blancGris) ;
  sliderBG ( posSlider[24].x, posSlider[24].y, sizeSlider[24].y, sizeSlider[24].x, rounded_slider, blancGris) ;
  sliderBG ( posSlider[25].x, posSlider[25].y, sizeSlider[25].y, sizeSlider[25].x, rounded_slider, grisClair) ;
  sliderBG ( posSlider[26].x, posSlider[26].y, sizeSlider[26].y, sizeSlider[26].x, rounded_slider, grisClair) ;
  sliderBG ( posSlider[27].x, posSlider[27].y, sizeSlider[27].y, sizeSlider[27].x, rounded_slider, grisClair) ;
  sliderBG ( posSlider[28].x, posSlider[28].y, sizeSlider[28].y, sizeSlider[28].x, rounded_slider, grisClair) ;
}

// supra local void
void slider_HSB_general_display(int start) {
  if (mouseX > (posSlider[1 +start].x ) && mouseX < ( posSlider[1 +start].x +sizeSlider[1 +start].x) 
      && mouseY > ( posSlider[1 +start].y - 5) && mouseY < posSlider[1 +start].y +40) {
    hueSliderBG    ( posSlider[1 +start].x, posSlider[1 +start].y, sizeSlider[1 +start].y, sizeSlider[1 +start].x) ;
    saturationSliderBG ( posSlider[2 +start].x, posSlider[2 +start].y, sizeSlider[2 +start].y, sizeSlider[1 +start].x, valueSlider[1 +start], valueSlider[2 +start], valueSlider[3 +start] ) ;
    brightnessSliderBG ( posSlider[3 +start].x, posSlider[3 +start].y, sizeSlider[3 +start].y, sizeSlider[1 +start].x, valueSlider[1 +start], valueSlider[2 +start], valueSlider[3 +start] ) ;
  } else {
    sliderBG    ( posSlider[1 +start].x, posSlider[1 +start].y, sizeSlider[1 +start].y, sizeSlider[1 +start].x, rounded_slider, grisClair) ;
    sliderBG    ( posSlider[2 +start].x, posSlider[2 +start].y, sizeSlider[2 +start].y, sizeSlider[2 +start].x, rounded_slider, grisClair) ;
    sliderBG    ( posSlider[3 +start].x, posSlider[3 +start].y, sizeSlider[3 +start].y, sizeSlider[3 +start].x, rounded_slider, grisClair) ;
  }
}







/**
Item selected slider
*/
/*
When you add a new sliders, you must change the starting value from 'NAN' to a value between 0 and 1 in the file 'defaultSetting.csv' in the 'preferences/setting' folder.
And you must add the name of this one in the 'preferences/'  folder sliderListEN.csv' and in the 'sliderListFR' file
*/
void display_slider_item() {
  /* different way to display depend the displaying mode. 
  Can change with "ctrl+x" */
  display_bg_slider_item() ;
  
  int whichGroup = 1 ;
  if(!showAllSliders) {
    for (int i = 1 ; i <= NUM_ITEM ; i++) {
      if (item_active[i]) {
        if (showSliderGroup[1] && item_group[i] == 1) { 
          for(int j = 1 ; j <= NUM_SLIDER_ITEM ; j++) {
            if (display_slider[1][j]) {
              int whichOne = item_group[i] *100 +j ;
              update_slider(whichOne) ; 
              display_current_slider_engine(whichOne, whichGroup) ; 
            }
          }
        }
      }
    }
  // if it ask to show all slider  
  } else {
    for(int i = 1 ; i <= NUM_SLIDER_ITEM ; i++) {
      int which_one = i +100 ;
      update_slider(which_one) ;
      display_current_slider_engine(which_one, whichGroup) ;
    }
  } 
}




void dislay_text_slider_item() {
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  fill (colorTextUsual) ;
  textFont(textUsual_1);  textAlign(LEFT);
  
  
  // Legend text slider position for the item
  int correction_local_y = local_pos_y_slider_button +4 ;
  int correction_local_x = slider_width + 5 ;
  for ( int i = 1 ; i <= SLIDER_BY_COL ; i++) {
    int which_one = i+(SLIDER_BY_COL *0);
    int which_two = i+(SLIDER_BY_COL *1);
    int which_three = i+(SLIDER_BY_COL *2);
    int factor = i -1 ;
    text(slider_item_name[which_one], col_1 +correction_local_x, height_item_selected +correction_local_y +(factor *spacing_slider));
    text(slider_item_name[which_two], col_2 +correction_local_x, height_item_selected +correction_local_y +(factor *spacing_slider));
    text(slider_item_name[which_three], col_3 +correction_local_x, height_item_selected +correction_local_y +(factor *spacing_slider));
  }
}
/* Loop to display the false background slider instead the usual class Slider background,
we use it the methode to display a particular background, like the rainbowcolor... */
void display_bg_slider_item() {
  // to find the good slider in the array
  int whichGroup = 1 ;
  int whichOne = 100 ;

  // COL 1
  slider_HSB_item_display(whichOne, whichGroup, hue_fill_rank, sat_fill_rank, bright_fill_rank) ;
  if (display_slider[whichGroup][alpha_fill_rank]) sliderBG (posSlider[whichOne +alpha_fill_rank].x, posSlider[whichOne +alpha_fill_rank].y, sizeSlider[whichOne +alpha_fill_rank].y, sizeSlider[whichOne +alpha_fill_rank].x, rounded_slider, blanc ) ;
  
  //outline color
  slider_HSB_item_display(whichOne, whichGroup, hue_stroke_rank, sat_stroke_rank, bright_stroke_rank) ;
  if (display_slider[whichGroup][alpha_stroke_rank]) sliderBG (posSlider[whichOne +alpha_stroke_rank].x, posSlider[whichOne +alpha_stroke_rank].y, sizeSlider[whichOne +alpha_stroke_rank].y, sizeSlider[whichOne +alpha_stroke_rank].x, rounded_slider, blancGrisClair) ;
  //  thickness
  if (display_slider[whichGroup][thickness_rank]) sliderBG (posSlider[whichOne +thickness_rank].x, posSlider[whichOne +thickness_rank].y, sizeSlider[whichOne +thickness_rank].y, sizeSlider[whichOne +thickness_rank].x, rounded_slider, blanc) ;
  // size
  if (display_slider[whichGroup][size_x_rank])  sliderBG (posSlider[whichOne +size_x_rank].x, posSlider[whichOne +size_x_rank].y, sizeSlider[whichOne +size_x_rank].y, sizeSlider[whichOne +size_x_rank].x, rounded_slider, blancGrisClair) ;
  if (display_slider[whichGroup][size_y_rank]) sliderBG (posSlider[whichOne +size_y_rank].x, posSlider[whichOne +size_y_rank].y, sizeSlider[whichOne +size_y_rank].y, sizeSlider[whichOne +size_y_rank].x, rounded_slider, blancGrisClair) ;
  if (display_slider[whichGroup][size_z_rank])  sliderBG (posSlider[whichOne +size_z_rank].x, posSlider[whichOne +size_z_rank].y, sizeSlider[whichOne +size_z_rank].y, sizeSlider[whichOne +size_z_rank].x, rounded_slider, blancGrisClair) ;
  // Font size
  if(display_slider[whichGroup][font_size_rank]) sliderBG (posSlider[whichOne +font_size_rank].x, posSlider[whichOne +font_size_rank].y, sizeSlider[whichOne +font_size_rank].y, sizeSlider[whichOne +font_size_rank].x, rounded_slider, blancGrisClair) ;
  // canvas
  if (display_slider[whichGroup][canvas_x_rank]) sliderBG (posSlider[whichOne +canvas_x_rank].x, posSlider[whichOne +canvas_x_rank].y, sizeSlider[whichOne +canvas_x_rank].y, sizeSlider[whichOne +canvas_x_rank].x, rounded_slider, blanc) ;
  if (display_slider[whichGroup][canvas_y_rank]) sliderBG (posSlider[whichOne +canvas_y_rank].x, posSlider[whichOne +canvas_y_rank].y, sizeSlider[whichOne +canvas_y_rank].y, sizeSlider[whichOne +canvas_y_rank].x, rounded_slider, blanc) ;
  if (display_slider[whichGroup][canvas_z_rank]) sliderBG (posSlider[whichOne +canvas_z_rank].x, posSlider[whichOne +canvas_z_rank].y, sizeSlider[whichOne +canvas_z_rank].y, sizeSlider[whichOne +canvas_z_rank].x, rounded_slider, blanc) ;

  

  // COL 2
  // reactivity
  if(display_slider[whichGroup][reactivity_rank]) sliderBG ( posSlider[whichOne +reactivity_rank].x, posSlider[whichOne +reactivity_rank].y, sizeSlider[whichOne +reactivity_rank].y, sizeSlider[whichOne +reactivity_rank].x, rounded_slider, blancGrisClair) ;
  // speed
  if(display_slider[whichGroup][speed_x_rank]) sliderBG (posSlider[whichOne +speed_x_rank].x, posSlider[whichOne +speed_x_rank].y, sizeSlider[whichOne +speed_x_rank].y, sizeSlider[whichOne +speed_x_rank].x, rounded_slider, blanc) ;
  if(display_slider[whichGroup][speed_y_rank]) sliderBG ( posSlider[whichOne +speed_y_rank].x, posSlider[whichOne +speed_y_rank].y, sizeSlider[whichOne +speed_y_rank].y, sizeSlider[whichOne +speed_y_rank].x, rounded_slider, blanc) ;
  if(display_slider[whichGroup][speed_z_rank]) sliderBG ( posSlider[whichOne +speed_z_rank].x, posSlider[whichOne +speed_z_rank].y, sizeSlider[whichOne +speed_z_rank].y, sizeSlider[whichOne +speed_z_rank].x, rounded_slider, blanc) ;
  // spurt
  if(display_slider[whichGroup][spurt_x_rank]) sliderBG ( posSlider[whichOne +spurt_x_rank].x, posSlider[whichOne +spurt_x_rank].y, sizeSlider[whichOne +spurt_x_rank].y, sizeSlider[whichOne +spurt_x_rank].x, rounded_slider, blancGrisClair) ;
  if(display_slider[whichGroup][spurt_y_rank]) sliderBG ( posSlider[whichOne +spurt_y_rank].x, posSlider[whichOne +spurt_y_rank].y, sizeSlider[whichOne +spurt_y_rank].y, sizeSlider[whichOne +spurt_y_rank].x, rounded_slider, blancGrisClair) ;
  if(display_slider[whichGroup][spurt_z_rank]) sliderBG (posSlider[whichOne +spurt_z_rank].x, posSlider[whichOne +spurt_z_rank].y, sizeSlider[whichOne +spurt_z_rank].y, sizeSlider[whichOne +spurt_z_rank].x, rounded_slider, blancGrisClair) ;
  // direction
  if(display_slider[whichGroup][dir_x_rank]) sliderBG (posSlider[whichOne +dir_x_rank].x, posSlider[whichOne +dir_x_rank].y, sizeSlider[whichOne +dir_x_rank].y, sizeSlider[whichOne +dir_x_rank].x, rounded_slider, blanc) ;
  if(display_slider[whichGroup][dir_y_rank]) sliderBG (posSlider[whichOne +dir_y_rank].x, posSlider[whichOne +dir_y_rank].y, sizeSlider[whichOne +dir_y_rank].y, sizeSlider[whichOne +dir_y_rank].x, rounded_slider, blanc) ;
  if(display_slider[whichGroup][dir_z_rank]) sliderBG ( posSlider[whichOne +dir_z_rank].x, posSlider[whichOne +dir_z_rank].y, sizeSlider[whichOne +dir_z_rank].y, sizeSlider[whichOne +dir_z_rank].x, rounded_slider, blanc) ;
  // jitter
  if(display_slider[whichGroup][jitter_x_rank]) sliderBG ( posSlider[whichOne +jitter_x_rank].x, posSlider[whichOne +jitter_x_rank].y, sizeSlider[whichOne +jitter_x_rank].y, sizeSlider[whichOne +jitter_x_rank].x, rounded_slider, blancGrisClair) ;
  if(display_slider[whichGroup][jitter_y_rank])  sliderBG ( posSlider[whichOne +jitter_y_rank].x, posSlider[whichOne +jitter_y_rank].y, sizeSlider[whichOne +jitter_y_rank].y, sizeSlider[whichOne +jitter_y_rank].x, rounded_slider, blancGrisClair) ;
  if(display_slider[whichGroup][jitter_z_rank])  sliderBG ( posSlider[whichOne +jitter_z_rank].x, posSlider[whichOne +jitter_z_rank].y, sizeSlider[whichOne +jitter_z_rank].y, sizeSlider[whichOne +jitter_z_rank].x, rounded_slider, blancGrisClair) ;
  // swing
  if(display_slider[whichGroup][swing_x_rank]) sliderBG ( posSlider[whichOne +swing_x_rank].x, posSlider[whichOne +swing_x_rank].y, sizeSlider[whichOne +swing_x_rank].y, sizeSlider[whichOne +swing_x_rank].x, rounded_slider, blancGrisClair) ;
  if(display_slider[whichGroup][swing_y_rank])  sliderBG ( posSlider[whichOne +swing_y_rank].x, posSlider[whichOne +swing_y_rank].y, sizeSlider[whichOne +swing_y_rank].y, sizeSlider[whichOne +swing_y_rank].x, rounded_slider, blancGrisClair) ;
  if(display_slider[whichGroup][swing_z_rank])  sliderBG ( posSlider[whichOne +swing_z_rank].x, posSlider[whichOne +swing_z_rank].y, sizeSlider[whichOne +swing_z_rank].y, sizeSlider[whichOne +swing_z_rank].x, rounded_slider, blancGrisClair) ;

  
  // COL 3
  // quantity
  if(display_slider[whichGroup][quantity_rank]) sliderBG ( posSlider[whichOne +quantity_rank].x, posSlider[whichOne +quantity_rank].y, sizeSlider[whichOne +quantity_rank].y, sizeSlider[whichOne +quantity_rank].x, rounded_slider, blancGrisClair) ;
  // variety
  if(display_slider[whichGroup][variety_rank]) sliderBG ( posSlider[whichOne +variety_rank].x, posSlider[whichOne +variety_rank].y, sizeSlider[whichOne +variety_rank].y, sizeSlider[whichOne +variety_rank].x, rounded_slider, blancGrisClair) ;
  
  // life
  if(display_slider[whichGroup][life_rank]) sliderBG ( posSlider[whichOne +life_rank].x, posSlider[whichOne +life_rank].y, sizeSlider[whichOne +life_rank].y, sizeSlider[whichOne +life_rank].x, rounded_slider, blancGrisClair) ;
  // fertility
  if(display_slider[whichGroup][flow_rank]) sliderBG ( posSlider[whichOne +flow_rank].x, posSlider[whichOne +flow_rank].y, sizeSlider[whichOne +flow_rank].y, sizeSlider[whichOne +flow_rank].x, rounded_slider, blancGrisClair) ;
  // quality
  if(display_slider[whichGroup][quality_rank]) sliderBG ( posSlider[whichOne +quality_rank].x, posSlider[whichOne +quality_rank].y, sizeSlider[whichOne +quality_rank].y, sizeSlider[whichOne +quality_rank].x, rounded_slider, blancGrisClair) ;
  
  // area
  if(display_slider[whichGroup][area_rank]) sliderBG ( posSlider[whichOne +area_rank].x, posSlider[whichOne +area_rank].y, sizeSlider[whichOne +area_rank].y, sizeSlider[whichOne +area_rank].x, rounded_slider, blancGrisClair) ;
  // angle
  if(display_slider[whichGroup][angle_rank]) sliderBG ( posSlider[whichOne +angle_rank].x, posSlider[whichOne +angle_rank].y, sizeSlider[whichOne +angle_rank].y, sizeSlider[whichOne +angle_rank].x, rounded_slider, blancGrisClair) ;
  // scope
  if(display_slider[whichGroup][scope_rank]) sliderBG ( posSlider[whichOne +scope_rank].x, posSlider[whichOne +scope_rank].y, sizeSlider[whichOne +scope_rank].y, sizeSlider[whichOne +scope_rank].x, rounded_slider, blancGrisClair) ;
  // scan
  if(display_slider[whichGroup][scan_rank]) sliderBG ( posSlider[whichOne +scan_rank].x, posSlider[whichOne +scan_rank].y, sizeSlider[whichOne +scan_rank].y, sizeSlider[whichOne +scan_rank].x, rounded_slider, blancGrisClair) ;
  
  // alignment
  if(display_slider[whichGroup][alignment_rank]) sliderBG ( posSlider[whichOne +alignment_rank].x, posSlider[whichOne +alignment_rank].y, sizeSlider[whichOne +alignment_rank].y, sizeSlider[whichOne +alignment_rank].x, rounded_slider, blancGrisClair) ;
  // repulsion
  if(display_slider[whichGroup][repulsion_rank]) sliderBG ( posSlider[whichOne +repulsion_rank].x, posSlider[whichOne +repulsion_rank].y, sizeSlider[whichOne +repulsion_rank].y, sizeSlider[whichOne +repulsion_rank].x, rounded_slider, blancGrisClair) ;
  // attraction
  if(display_slider[whichGroup][attraction_rank]) sliderBG ( posSlider[whichOne +attraction_rank].x, posSlider[whichOne +attraction_rank].y, sizeSlider[whichOne +attraction_rank].y, sizeSlider[whichOne +attraction_rank].x, rounded_slider, blancGrisClair) ;
  // density
  if(display_slider[whichGroup][density_rank]) sliderBG ( posSlider[whichOne +density_rank].x, posSlider[whichOne +density_rank].y, sizeSlider[whichOne +density_rank].y, sizeSlider[whichOne +density_rank].x, rounded_slider, blancGrisClair) ;
  
  // influence
  if(display_slider[whichGroup][influence_rank]) sliderBG ( posSlider[whichOne +influence_rank].x, posSlider[whichOne +influence_rank].y, sizeSlider[whichOne +influence_rank].y, sizeSlider[whichOne +influence_rank].x, rounded_slider, blancGrisClair) ;
  // calm
  if(display_slider[whichGroup][calm_rank]) sliderBG ( posSlider[whichOne +calm_rank].x, posSlider[whichOne +calm_rank].y, sizeSlider[whichOne +calm_rank].y, sizeSlider[whichOne +calm_rank].x, rounded_slider, blancGrisClair) ;
  // spectrum
  if(display_slider[whichGroup][spectrum_rank]) sliderBG ( posSlider[whichOne +spectrum_rank].x, posSlider[whichOne +spectrum_rank].y, sizeSlider[whichOne +spectrum_rank].y, sizeSlider[whichOne +spectrum_rank].x, rounded_slider, blancGrisClair) ;
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
    if (display_slider[whichGroup][hueRank])    sliderBG (posSlider[whichOne +hueRank].x,    posSlider[whichOne +hueRank].y,    sizeSlider[whichOne +hueRank].y,    sizeSlider[whichOne +hueRank].x,    rounded_slider, blanc) ;
    if (display_slider[whichGroup][satRank])    sliderBG (posSlider[whichOne +satRank].x,    posSlider[whichOne +satRank].y,    sizeSlider[whichOne +satRank].y,    sizeSlider[whichOne +satRank].x,    rounded_slider, blanc ) ;
    if (display_slider[whichGroup][brightRank]) sliderBG (posSlider[whichOne +brightRank].x, posSlider[whichOne +brightRank].y, sizeSlider[whichOne +brightRank].y, sizeSlider[whichOne +brightRank].x, rounded_slider, blanc ) ;
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
BUTTON
v 1.0.0
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
  value_button_general = new int[numButton[0]] ;
}


// build button
void build_button_general() {
  //MIDI
  button_midi  = new Button(pos_midi_button, size_midi_button) ;
  //curtain
  button_curtain  = new Button(pos_curtain_button, size_curtain_button) ;
  // General
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
  pos_midi_button = Vec2(col_1 +correctionMidiX, pos_y_button_top +correctionMidiY) ;
  pos_midi_info =Vec2(pos_midi_button.x +correction_info_midi_x, pos_midi_button.y +correction_info_midi_y) ;
  // CURTAIN
  size_curtain_button = Vec2(30,30) ;
  pos_curtain_button = Vec2(col_1 +correctionCurtainX, pos_y_button_top +correctionCurtainY) ; 
  
  
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
  display_button_inventory_item() ;
  display_dropdown() ;

  button_header() ;
  midiButtonManager(false) ;
}

void check_button() {
  check_button_general() ;
  check_button_item_console() ;
  check_button_inventory_item() ;
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
void button_header() {
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

  noStroke() ;
  int alpha_bg_rollover = int(g.colorModeA *.8) ;

  if(button_midi.rollover()) {
    text [0] = ("MIDI") ;    
    fill(grisTresFonce, alpha_bg_rollover) ;
    background_text_list(Vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check) ;
    fill(jaune) ;
    text(text [0],pos_window.x, pos_window.y) ;
  }

  if(button_curtain.rollover()) {
    text [0] = ("CUT") ;
    noStroke() ;
    fill(grisTresFonce, alpha_bg_rollover) ;
    background_text_list(Vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size,range_check) ;
    fill(jaune) ;
    text(text [0], pos_window.x, pos_window.y) ;
  }
}

void display_button_general() {
  button_bg.button_text(shader_bg_name[which_bg_shader] + " on/off", pos_bg_button, titleButtonMedium, sizeTitleButton) ;
  //button_bg.button_text(shader_bg_name[state_bg_shader] + " on/off", pos_bg_button, titleButtonMedium, sizeTitleButton) ;
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
DROPDOWN 
v 1.1.0
*/
// int ref_size_image_bitmap_dropdown, ref_size_image_svg_dropdown, ref_size_movie_dropdown, refSizeFileTextDropdown, refSizeCameraVideoDropdown ;
PVector pos_text_dropdown_image_bitmap, pos_text_dropdown_image_svg, pos_text_dropdown_movie, posTextdropdown_file_text, posTextdropdown_camera_video ; 
color selectedText ;
color colorBoxIn, colorBoxOut, colorBoxText ;
color colorDropdownBG ;
color color_dropdown_header_in, color_dropdown_header_out ;
color color_dropdown_item_in, color_dropdown_item_out ;

void init_dropdown() {
  // dropdown bar
  dropdown_bar = new Dropdown[num_dropdown_bar];
  dropdown_bar_pos = new Vec3[num_dropdown_bar];
  dropdown_bar_size = new Vec2[num_dropdown_bar];
  dropdown_bar_pos_text = new Vec2[num_dropdown_bar];
  dropdown_content = new String[num_dropdown_bar][0];

  // dropdown item
  num_dropdown_item = NUM_ITEM +1 ; // add one for the dropdownmenu
  lastDropdown = num_dropdown_item -1 ;
  mode_list_RPE = new String[num_dropdown_item] ;
  dropdown_item_mode = new Dropdown[num_dropdown_item] ;
  pos_dropdown = new Vec3[num_dropdown_item] ;

  for(int i = 0 ; i < num_dropdown_item  ; i++) {
    pos_dropdown[i] = Vec3() ;
  }
}




void set_dropdown_general() {
  colorDropdownBG = rougeTresFonce ;
  color_dropdown_header_in = jaune ;
  color_dropdown_header_out = orange ;
  color_dropdown_item_in = rouge ;
  color_dropdown_item_out = rougeTresFonce ;
  colorBoxIn = jaune ; 
  colorBoxOut = orange ;
  colorBoxText = rougeFonce ;
  selectedText = vertFonce ;

  //load the external list  for each mode and split to read in the interface
  for (int i = 0 ; i<inventory_item_table.getRowCount() ; i++) {
    TableRow row = inventory_item_table.getRow(i);
    mode_list_RPE [row.getInt("ID")] = row.getString("Mode"); 
  }
  //font
  String pList [] = loadStrings(import_path+"font/fontList.txt") ;
  String policeList = join(pList, "") ;
  font_dropdown_list = split(policeList, "/") ;
  
  //image
  update_media() ;
 
  for(int i = 0 ; i < dropdown_bar.length ; i++) {
    dropdown_bar_pos[i] = Vec3(pos_x_dropdown_bar[i],pos_y_dropdown_bar, .1);
    dropdown_bar_size[i] = Vec2(width_dropdown_bar[i],height_dropdown_header_bar);
    int num_box = 7;
    dropdown_bar_pos_text[i] = Vec2(3,10);
    ROPE_color dropdown_color_bar = new ROPE_color(colorDropdownBG, colorBoxIn, colorBoxOut, color_dropdown_header_in, color_dropdown_header_out, colorBoxText);
    dropdown_bar[i] = new Dropdown(name_dropdown_bar[i],dropdown_content[i],dropdown_bar_pos[i],dropdown_bar_size[i],dropdown_bar_pos_text[i], dropdown_color_bar,num_box, height_box_dropdown);
  }
}

void set_dropdown_item_selected() {
  //common param
  int num_box = 7;
  size_dropdown_mode = Vec2(20,15);
  float x = offset_y_item + -8;
  float y = height_item_selected +local_pos_y_dropdown_item_selected;
  float z = .1;

  ROPE_color dropdown_color_item = new ROPE_color(colorDropdownBG, colorBoxIn, colorBoxOut, color_dropdown_item_in, color_dropdown_item_out, colorBoxText);
  // group item
  for (int i = 0 ; i <= NUM_ITEM ; i++ ) {
    if(mode_list_RPE[i] != null) {
      //Split the dropdown to display in the dropdown
      String [] item_mode_dropdown_list = split(mode_list_RPE[i], "/" ) ;
      //to change the title of the header dropdown
      pos_dropdown[i].set(x, y, z) ; // x y is pos anz z is marge between the dropdown and the header
      dropdown_item_mode[i] = new Dropdown("M", 
                                  item_mode_dropdown_list, 
                                  pos_dropdown[i], 
                                  size_dropdown_mode, 
                                  posTextDropdown, 
                                  dropdown_color_item,
                                  num_box, 
                                  height_box_dropdown) ;
    }
  }
}









// DRAW DROPDOWN
boolean dropdownActivity ;
int dropdownActivityCount ;
void display_dropdown() {
  update_dropdown_bar_content() ;
  
  // update_dropdown_background() ;
  for(int i = 0 ; i < dropdown_bar.length ; i++) {
    dropdown_bar[i].set_content(dropdown_content[i]);
    // dropdown_bar[i].update(title_dropdown_medium, textUsual_1);
    update_dropdown_bar(dropdown_bar[i], textUsual_1);
  }

  // item
  update_dropdown_item() ;
  
  which_bg_shader = dropdown_bar[0].get_content_line();
  which_filter = dropdown_bar[1].get_content_line();
  which_font = dropdown_bar[2].get_content_line();
  which_text = dropdown_bar[3].get_content_line();
  which_bitmap = dropdown_bar[4].get_content_line();
  which_shape = dropdown_bar[5].get_content_line();
  which_movie = dropdown_bar[6].get_content_line();

  // check the activity o the dropdown
  if(dropdownActivityCount > 0 ) {
    dropdownActivity = true; 
  } else {
    dropdownActivity = false;
  }
  dropdownActivityCount = 0;
}










// Annexe method
int update_dropdown_bar(Dropdown dd, PFont font) {
  int content_line = SWITCH_VALUE_FOR_DROPDOWN ;
  dd.update(font, textUsual_1);
  if (dropdownOpen) dropdownActivityCount = +1 ;
  marge_around_dropdown = dd.get_size().y  ;
  //give the size of menu recalculate with the size of the word inside
  Vec2 new_size = dd.size_box.copy();
  //compare the standard size of dropdown with the number of element of the list.
  int heightDropdown = 0 ;
  if(dd.get_content().length < dd.get_num_box()) {
    heightDropdown = dd.get_content().length; 
  } else {
    heightDropdown = dd.get_num_box();
  }
  Vec2 temp_size = Vec2(new_size.x +(marge_around_dropdown *1.5), dd.get_size().y *(heightDropdown +1) +marge_around_dropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  Vec2 temp_pos = Vec2(dd.get_pos().x -marge_around_dropdown, dd.get_pos().y);
  if(!inside(temp_pos,temp_size,Vec2(mouseX,mouseY),RECT)) dd.locked = false;
  
  if(!dd.locked && dd.get_content().length > 0) {
    fill(selectedText) ;
    // display the selection
    content_line = dd.get_content_line() ;
    textFont(textUsual_2) ;
    text(dd.get_content()[dd.get_content_line()], dd.get_pos().x +3 , dd.get_pos().y +22) ;
  }
  return content_line ;
}

void update_dropdown_bar_content() {
  dropdown_content [0] = shader_bg_name;
  dropdown_content [1] = filter_dropdown_list;
  dropdown_content [2] = font_dropdown_list;
  dropdown_content [3] = file_text_dropdown_list;
  
  dropdown_content [4] = bitmap_dropdown_list;
  dropdown_content [5] = shape_dropdown_list;
  dropdown_content [6] = movie_dropdown_list;
}




// update for the special content dropdown
void update_dropdown_background() { 
  /*
  dropdown_bg.dropdownUpdate(title_dropdown_medium, textUsual_1);
  if (dropdownOpen) dropdownActivityCount = +1 ;
  marge_around_dropdown = size_dropdown_font.y  ;
  //give the size of menu recalculate with the size of the word inside
  Vec2 newSizeFont = dropdown_bg.size_box.copy();
  //compare the standard size of dropdown with the number of element of the list.
  int heightDropdown = 0 ;
  if(shader_bg_name.length < size_dropdown_bg.z ) heightDropdown = shader_bg_name.length ; else heightDropdown = (int)size_dropdown_bg.z ;
  Vec2 temp_size = Vec2(newSizeFont.x +(marge_around_dropdown *1.5), size_dropdown_bg.y *(heightDropdown +1) +marge_around_dropdown); // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  Vec2 temp_pos = Vec2(pos_dropdown_bg.x -marge_around_dropdown, pos_dropdown_bg.y) ;
  if (!inside(temp_pos,temp_size,Vec2(mouseX,mouseY),RECT)) dropdown_bg.locked = false ;
  // display the selection

  if(!dropdown_bg.locked) {
    fill(selectedText) ;
    textFont(textUsual_2) ;
    state_bg_shader = dropdown_bg.get_content_line() ;
    if (dropdown_bg.get_content_line() != 0 ) {
      text(shader_bg_name[state_bg_shader] +" by " +shader_bg_author[dropdown_bg.get_content_line()], pos_dropdown_bg.x +3 , pos_dropdown_bg.y +22) ;
    } else {
      text(shader_bg_name[state_bg_shader], pos_dropdown_bg.x +3 , pos_dropdown_bg.y +22) ;
    }    
  }
  */
}


void update_dropdown_item() {
  int pointer = 0 ;
  for (int i = 1 ; i <= NUM_ITEM ; i++) {
    if(mode_list_RPE[i] != null && on_off_inventory_item[i].on_off) {
      int distance = pointer *STEP_ITEM ;
      pointer ++ ;

      dropdown_item_mode[i].change_pos(distance, 0) ;

      String m [] = split(mode_list_RPE[i], "/") ;
      if ( m.length > 1) {
        dropdown_item_mode[i].update(title_dropdown_medium, textUsual_1);
        if (dropdownOpen) dropdownActivityCount++ ;
        marge_around_dropdown = size_dropdown_mode.y  ;

        //give the size of menu recalculate with the size of the word inside
        Vec2 newSizeModeTypo = dropdown_item_mode[i].size_box.copy();
        int heightDropdown = 0 ;

        if(dropdown_item_mode[i].content.length <  dropdown_item_mode[i].get_num_box()) {
          heightDropdown = dropdown_item_mode[i].content.length ; 
        } else {
          heightDropdown = dropdown_item_mode[i].get_num_box();
        }

        Vec2 temp_size = Vec2(newSizeModeTypo.x +(marge_around_dropdown *1.5), size_dropdown_mode.y *(heightDropdown +1) +marge_around_dropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
        
        //new pos to include the slider
        Vec2 temp_pos = Vec2(dropdown_item_mode[i].get_pos().x -marge_around_dropdown, dropdown_item_mode[i].get_pos().y) ;
        if (!inside(temp_pos,temp_size,Vec2(mouseX,mouseY),RECT)) {
          dropdown_item_mode[i].locked = false;
        }
      }
      // display which element is selected
      if (dropdown_item_mode[i].get_content_line() > -1 && m.length > 1) {
        textFont(title_dropdown_medium);      
        text(dropdown_item_mode[i].get_content_line() +1, dropdown_item_mode[i].get_pos().x +12, dropdown_item_mode[i].get_pos().y +8) ;
      }
    }
  }
}









// DROPDOWN MOUSEPRESSED
void mousepressed_dropdown() {
  // dropdown bar
  for(int i = 0 ; i < dropdown_bar.length ; i++) {
    check_dropdown_mousepressed (dropdown_bar[i]);
  }
  // Item menu
  for(int i = 0 ; i < dropdown_item_mode.length ; i++) {
    check_dropdown_mousepressed(dropdown_item_mode[i]);
  } 
}

void check_dropdown_mousepressed(Dropdown dd) {
  if (dd != null) {
    if (inside(dd.get_pos(), dd.get_size(),Vec2(mouseX,mouseY),RECT) && !dd.locked) {
      dd.locked = true;
    } else if (dd.locked) {
      // println("locked",dd.get_name(),frameCount);
      float new_width = dd.size_box.x ;
      int line = dd.selectDropdownLine(new_width);
      if (line > -1 ) {
        dd.whichDropdownLine(line);
        dd.locked = false;        
      } 
    }
  }
}

























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
  int num = inventory_item_table.getRowCount() ;
  for ( int j = 0 ; j < num ; j++) {
    TableRow lookFor = inventory_item_table.getRow(j);
    int ID = lookFor.getInt("ID") ;
    if ( ID == IDorder ) {
      whichLine = j ;
    }
  }
  TableRow displayInfo = inventory_item_table.getRow(whichLine) ;
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







