// Tab: A_interface
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


//paramètres réglette couleur
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
void structureDraw() {
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
void textDraw() {
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
void constructorSlider() {
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
void sliderSettingVar() {
  groupZeroSlider (correctionSliderPos) ;
  groupOneSlider (lineGroupOne +correctionSliderObject) ;
  groupTwoSlider (lineGroupTwo +correctionSliderObject) ;
}


// LOCAL SLIDER SETUP METHOD

// group zero, global slider for camera, sound, light, background...
////////////////////////////////////////////////////////////////////
void groupZeroSlider(int correctionY) {
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
void groupOneSlider(int sliderPositionY) {
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
void groupTwoSlider(int sliderPositionY) {
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
void sliderDraw() {
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
void sliderUpdate(int whichOne) {
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
void dispayTextSliderGroupZero(int pos) {
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



void dislayTextSlider() {
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
      // float sat = map(s, 0, largeur, 0, 100 ) ;
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
void constructorButton() {
  color OnInColor = vert ;
  color OnOutColor = vertTresFonce ;
  color OffInColor = orange ;
  color OffOutColor = rougeFonce ;
  
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
void buttonSetup() {
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
void groupOneButton(int buttonPositionY) {
  //position and area for the rollover
  for (int i = 1 ; i <= numGroup[1] ; i++) {
    posWidthBOf[i*10+1] = margeLeft +((i-1)*40) +(int)posRelativeMainButton.x    ; posHeightBOf[i*10+1] = buttonPositionY +(int)posRelativeMainButton.y     ; longueurBOf[i*10+1] = 20 ; hauteurBOf[i*10+1] = 20 ;  //main
    posWidthBOf[i*10+2] = margeLeft +((i-1)*40) +(int)posRelativeSettingButton.x ; posHeightBOf[i*10+2] = buttonPositionY +(int)posRelativeSettingButton.y  ; longueurBOf[i*10+2] = 19 ; hauteurBOf[i*10+2] = 6 ; //setting
    posWidthBOf[i*10+3] = margeLeft +((i-1)*40) +(int)posRelativeSoundButton.x   ; posHeightBOf[i*10+3] = buttonPositionY +(int)posRelativeSoundButton.y    ; longueurBOf[i*10+3] = 10 ; hauteurBOf[i*10+3] = 6 ; //sound
    posWidthBOf[i*10+4] = margeLeft +((i-1)*40) +(int)posRelativeActionButton.x  ; posHeightBOf[i*10+4] = buttonPositionY +(int)posRelativeActionButton.y   ; longueurBOf[i*10+4] = 10 ; hauteurBOf[i*10+4] = 6 ; //action
  }
}
void groupTwoButton(int buttonPositionY) {
  for (int i = 1 ; i <= numGroup[2] ; i++ ) {
    posWidthBTf[i*10+1] = margeLeft +((i-1)*40) +(int)posRelativeMainButton.x    ; posHeightBTf[i*10+1] = buttonPositionY +(int)posRelativeMainButton.y     ; longueurBTf[i*10+1] = 20 ; hauteurBTf[i*10+1] = 20 ; //main
    posWidthBTf[i*10+2] = margeLeft +((i-1)*40) +(int)posRelativeSettingButton.x ; posHeightBTf[i*10+2] = buttonPositionY +(int)posRelativeSettingButton.y  ; longueurBTf[i*10+2] = 19 ; hauteurBTf[i*10+2] = 6 ; //setting
    posWidthBTf[i*10+3] = margeLeft +((i-1)*40) +(int)posRelativeSoundButton.x   ; posHeightBTf[i*10+3] = buttonPositionY +(int)posRelativeSoundButton.y    ; longueurBTf[i*10+3] = 10 ; hauteurBTf[i*10+3] = 6 ; //sound
    posWidthBTf[i*10+4] = margeLeft +((i-1)*40) +(int)posRelativeActionButton.x  ; posHeightBTf[i*10+4] = buttonPositionY +(int)posRelativeActionButton.y   ; longueurBTf[i*10+4] = 10 ; hauteurBTf[i*10+4] = 6 ; //action
  }
}

void groupThreeButton(int buttonPositionY) {
  //paramètre habillage couleur du bouton cercle BTY
  for (int i = 1 ; i <= numGroup[3] ; i++ ) {
    posWidthBTYf[i*10+1] = margeLeft +((i-1)*40) +(int)posRelativeMainButton.x    ; posHeightBTYf[i*10+1] = buttonPositionY +(int)posRelativeMainButton.y     ; longueurBTYf[i*10+1] = 20 ; hauteurBTYf[i*10+1] = 20 ; //main
    posWidthBTYf[i*10+2] = margeLeft +((i-1)*40) +(int)posRelativeSettingButton.x ; posHeightBTYf[i*10+2] = buttonPositionY +(int)posRelativeSettingButton.y  ; longueurBTYf[i*10+2] = 19 ; hauteurBTYf[i*10+2] = 6 ; //setting
    posWidthBTYf[i*10+3] = margeLeft +((i-1)*40) +(int)posRelativeSoundButton.x   ; posHeightBTYf[i*10+3] = buttonPositionY +(int)posRelativeSoundButton.y    ; longueurBTYf[i*10+3] = 10 ; hauteurBTYf[i*10+3] = 6 ; //sound
    posWidthBTYf[i*10+4] = margeLeft +((i-1)*40) +(int)posRelativeActionButton.x  ; posHeightBTYf[i*10+4] = buttonPositionY +(int)posRelativeActionButton.y   ; longueurBTYf[i*10+4] = 10 ; hauteurBTYf[i*10+4] = 6 ; //action
  }
}



// BUTTON DRAW
// DRAW MAIN METHOD
void buttonDraw() {
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
void buttonInfoOnTheTop() {
  fill(jaune) ;
   textFont(FuturaStencil_20) ;
  if(BOmidi.rollover()) text("Midi Setting",   mouseX -20, mouseY -20 ) ;
  if(BOcurtain.rollover()) text("Cut",   mouseX -20, mouseY -20 ) ;
}

// GROUP ZERO
void buttonDrawGroupZero() {
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
void buttonDrawGroupOne() {
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
void buttonDrawGroupTwo() {
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




void buttonCheckDraw() {
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
color selectedText ;
color colorBoxIn, colorBoxOut, colorBoxText, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut ;
int sizeToRenderTheBoxDropdown = 15 ;

void dropdownSetup() {

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
  posDropdownBackground = new PVector(posButtonBackground.x, posButtonBackground.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  sizeDropdownBackground = new PVector (75, sizeToRenderTheBoxDropdown, 10) ; // z is the num of line you show
  PVector posTextDropdownBackground = new PVector(3, 10)  ;
  dropdownBackground = new Dropdown("Background", shaderBackgroundName, posDropdownBackground, sizeDropdownBackground, posTextDropdownBackground, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  
  //FONT dropdown
  ///////////////
  posDropdownFont = new PVector(posButtonFont.x, posButtonFont.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  sizeDropdownFont = new PVector (40, sizeToRenderTheBoxDropdown, 10 ) ; // z is the num of line you show
  PVector posTextDropdownTypo = new PVector(3, 10)  ;
  dropdownFont = new Dropdown("Font", policeDropdownList,   posDropdownFont , sizeDropdownFont, posTextDropdownTypo, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  // Image Dropdown
  //////////////////
  posDropdownImage = new PVector(posButtonImage.x, posButtonImage.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  sizeDropdownImage = new PVector (60, sizeToRenderTheBoxDropdown, 10 ) ; // z is the num of line you show
  posTextDropdownImage = new PVector(3, 10)  ;
  refSizeImageDropdown = imageDropdownList.length ;
  dropdownImage = new Dropdown("Image", imageDropdownList, posDropdownImage, sizeDropdownImage, posTextDropdownImage, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
  
  // File text Dropdown
  //////////////////
  posDropdownFileText = new PVector(posButtonFileText.x, posButtonFileText.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
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

void checkTheDropdownSetupObject( int start, int end, float posWidth, float posHeight) {
  for ( int i = start ; i < end ; i++ ) {
    if(modeListRomanesco[i] != null ) {
      int space = ((i -start +1) * 40) -40 ;
      //Split the dropdown to display in the dropdown
      listDropdown = split(modeListRomanesco[i], "/" ) ;
      //to change the title of the header dropdown

      posDropdown[i] = new PVector(posWidth +space, posHeight , 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
      dropdown[i] = new Dropdown("M", listDropdown, posDropdown[i], sizeDropdownMode, posTextDropdown, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut, colorBoxIn, colorBoxOut, colorBoxText, sizeToRenderTheBoxDropdown) ;
    }
  }
}








//DRAW DROPDOWN
boolean dropdownActivity ;
int dropdownActivityCount ;

void dropdownDraw() {
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
void dropdownBackground() {
  
  dropdownBackground.dropdownUpdate(titleDropdownMedium, textUsual_1);
  if (dropdownOpen) dropdownActivityCount = +1 ;
  margeAroundDropdown = sizeDropdownFont.y  ;
  //give the size of menu recalculate with the size of the word inside
  PVector newSizeFont = dropdownBackground.sizeBoxDropdownMenu ;
  //compare the standard size of dropdown with the number of element of the list.
  int heightDropdown = 0 ;
  if(shaderBackgroundName.length < sizeDropdownBackground.z ) heightDropdown = shaderBackgroundName.length ; else heightDropdown = (int)sizeDropdownBackground.z ;
  totalSizeDropdown = new PVector ( newSizeFont.x +(margeAroundDropdown *1.5), sizeDropdownBackground.y *(heightDropdown +1) +margeAroundDropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
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
void dropdownFont() {
  dropdownFont.dropdownUpdate(titleDropdownMedium, textUsual_1);
  if (dropdownOpen) dropdownActivityCount = +1 ;
  margeAroundDropdown = sizeDropdownFont.y  ;
  //give the size of menu recalculate with the size of the word inside
  PVector newSizeFont = dropdownFont.sizeBoxDropdownMenu ;
  //compare the standard size of dropdown with the number of element of the list.
  int heightDropdown = 0 ;
  if(policeDropdownList.length < sizeDropdownFont.z ) heightDropdown = policeDropdownList.length ; else heightDropdown = (int)sizeDropdownFont.z ;
  totalSizeDropdown = new PVector (newSizeFont.x +(margeAroundDropdown *1.5), sizeDropdownFont.y *(heightDropdown +1) +margeAroundDropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
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

void dropdownImage() {
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
  totalSizeDropdown = new PVector (newSizeImage.x +(margeAroundDropdown *1.5), sizeDropdownImage.y *(heightDropdown +1) +margeAroundDropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  newPosDropdown = new PVector (posDropdownImage.x -margeAroundDropdown, posDropdownImage.y) ;
  if (!insideRect(newPosDropdown, totalSizeDropdown)) dropdownImage.locked = false ;
  
  if(!dropdownImage.locked && imageDropdownList.length > 0) {
    fill(selectedText) ;
    EtatImage = dropdownImage.getSelection() ;
    textFont(textUsual_2) ;
    text(imageDropdownList[dropdownImage.getSelection()], posDropdownImage.x +3, posDropdownImage.y +22) ;
  }
}


// FILE TEXT
void dropdownFileText() {
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
  totalSizeDropdown = new PVector ( newSizeFileText.x +(margeAroundDropdown *1.5), sizeDropdownFileText.y *(heightDropdown +1) +margeAroundDropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  newPosDropdown = new PVector (posDropdownFileText.x -margeAroundDropdown, posDropdownFileText.y) ;
  if (!insideRect(newPosDropdown, totalSizeDropdown)) dropdownFileText.locked = false ;
  
  if(!dropdownFileText.locked && fileTextDropdownList.length > 0) {
    fill(selectedText) ;
    // display the selection
    EtatFileText = dropdownFileText.getSelection() ;
    textFont(textUsual_2) ;
    text(fileTextDropdownList[dropdownFileText.getSelection()], posDropdownFileText.x +3 , posDropdownFileText.y +22) ;
  }
}

// OBJECT
void checkTheDropdownDrawObject( int start, int end ) {
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
        totalSizeDropdown = new PVector (newSizeModeTypo.x + (margeAroundDropdown *1.5) , sizeDropdownMode.y * (heightDropdown +1)  + margeAroundDropdown   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
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
void dropdownMousepressed() {
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


void checkDropdownBackground() {
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
void checkDropdownFont() {
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
void checkDropdownImage() {
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
void checkDropdownFileText() {
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

void checkTheDropdownObjectMousepressed( int start, int end ) {
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
void rolloverInfoVignette(PVector pos, PVector size, int IDorder, int IDfamily) {
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

void lookAndDisplayInfo(int IDorder, PVector pos) {
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