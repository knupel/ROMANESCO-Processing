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

// vertical grid
int colOne = 35 ; 
int colTwo = 225 ; 
int colThree = 415 ;
int margeLeft  = colOne +15 ;

// horizontal grid
int lineHeader = 30 ;
int lineGroupZero = 68 ;
int lineGroupOne = 180 ;
int lineGroupTwo = 370 ;
int lineGroupThree = 560 ;
int topMenuPos = lineHeader +10 ;

int spacingBetweenSlider = 12 ;



  
int sliderWidth = 111 ;
int sliderHeight = 10 ;
int roundedSlider = 5 ;

// correction for special button and slider
int correctionMidi = 58 ;
int correctionCurtain = 58 ;
int correctionSliderPosition = 60 ;
int correctionBeatButton = 53 ;
int correctionSliderBG = -32 ;
int correctionSliderSound = +21 ;
int correctionSliderLight = -32 ;




SliderAdjustable [] slider = new SliderAdjustable [NUM_SLIDER] ;
int []suivitSlider ; 
PVector [] sizeSlider = new PVector[NUM_SLIDER] ;
PVector [] posSlider = new PVector[NUM_SLIDER] ; 

float valueSlider[] = new float[NUM_SLIDER] ;

//paramètre généraux interface

/*
int posHeightBO ;  // posWidthBO,
 int   posHeightRO ;  //posWidthRO,
int    posHeightBT ;  //posWidthBT,
 int   posHeightRT ;  //posWidthRT,
int    posHeightBTY ; //posWidthBTY,
int    posHeightRTY ; //posWidthRTY ;
*/




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


//paramètres réglette couleur
int posXSlider[] = new int[NUM_SLIDER *2] ;







//SPECIFIC VOID of INTERFACE









//SETUP
void buttonSliderSetup() {
  
  //GROUP GLOBAL
  
  
  // HEADER
  // DROPDOWN MENU : SHADER BG, FONT, IMAGE, FILE TEXT
  int posDropdownGrobalY = -3 ;
  posButtonBackground = new PVector(colOne -3, lineHeader +posDropdownGrobalY)  ;
  posButtonFont =       new PVector(colTwo -3, lineHeader +posDropdownGrobalY)  ; 
  posButtonImage =      new PVector(colTwo +115, lineHeader +posDropdownGrobalY)  ; 
  posButtonFileText =   new PVector(colThree +60, lineHeader +posDropdownGrobalY)  ; 

  
  /////////////
  // GROUP ZERO
    // background 
  posBackgroundButton = new PVector(colOne, lineGroupZero) ;
  sizeBackgroundButton = new PVector(120,10) ;
  
  // light 
  // one button
  posLightOneButton = new PVector(colTwo, lineGroupZero) ;
  sizeLightOneButton = new PVector(80,10) ;
  posLightOneAction = new PVector(colTwo +90, posLightOneButton.y) ;
  sizeLightOneAction = new PVector(45,10) ;
  // light two button
  posLightTwoButton = new PVector(colThree, lineGroupZero) ;
  sizeLightTwoButton = new PVector(80,10) ;
  posLightTwoAction = new PVector(colThree +90, posLightTwoButton.y) ;
  sizeLightTwoAction = new PVector(45,10) ;
  
  
  // MIDI CURTAIN
  sizeCurtainButton = new PVector(30,30) ;
  sizeMidiButton = new PVector(50,26) ;
  posMidiButton = new PVector(colOne + 40, lineGroupZero +correctionMidi +1) ; 
  posCurtainButton = new PVector(colOne, lineGroupZero +correctionCurtain -1) ; 
  
  //SOUND BUTTON
  sizeBeatButton = new PVector(30,10) ; 
  sizeKickButton = new PVector(30,10) ; 
  sizeSnareButton = new PVector(40,10) ; 
  sizeHatButton = new PVector(30,10) ;
  
  posBeatButton = new PVector(colThree +0, lineGroupZero +correctionBeatButton) ; 
  posKickButton = new PVector(posBeatButton.x +sizeBeatButton.x +5, lineGroupZero +correctionBeatButton) ; 
  posSnareButton = new PVector(posKickButton.x +sizeKickButton.x +5, lineGroupZero +correctionBeatButton) ; 
  posHatButton = new PVector(posSnareButton.x +sizeSnareButton.x +5, lineGroupZero +correctionBeatButton) ;
  // END GROUP ZERO
  ////////////////
  
  
  ////////////
  // GROUP ONE
  //posHeightBO = lineGroupOne  ; 
  //posHeightRO = posHeightBO +60   ;  
  
  ////////////
  //GROUP TWO
  //posHeightBT = lineGroupTwo ;  
  //posHeightRT = posHeightBT +60   ;  
  
  //////////////
  //GROUP THREE
  //posHeightBTY = lineGroupThree ;  
  // posHeightRTY = posHeightBTY +60  ;  
  
  // VOID
  groupZero(lineHeader +80) ;
  groupOne(lineGroupOne, lineGroupOne +correctionSliderPosition ) ;
  groupTwo(lineGroupTwo, lineGroupTwo +correctionSliderPosition ) ;
  groupThree(lineGroupThree, lineGroupThree +correctionSliderPosition ) ;
 
  dropdownSetup() ;
}



// GROUP ZERO Setting
///////////////////////
void groupZero(int pos) {
  
  // background slider
  int startLoop = 1 ;
  for(int i = startLoop ; i <= startLoop +3 ;i++) {
    float posY = pos +correctionSliderBG +((i-1) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(colOne, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
  // SOUND
  startLoop = 5 ;
  for(int i = startLoop ; i <= startLoop +1 ;i++) {
    float posY = pos +correctionSliderSound +((i-startLoop) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(colThree, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
  
  
  //LIGHT
  // LIGHT ONE
  startLoop = 7 ;
  for(int i = startLoop ; i <= startLoop +2 ;i++) {
    float posY = pos +correctionSliderLight +((i-startLoop) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(colTwo, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
 // LIGHT TWO
   startLoop = 10 ;
  for(int i = startLoop ; i <= startLoop +2 ;i++) {
    float posY = pos +correctionSliderLight +((i-startLoop) *spacingBetweenSlider) ;
    posSlider[i] = new PVector(colThree, posY) ;
    sizeSlider[i] = new PVector(sliderWidth,sliderHeight) ;
  }
  
  
}

PVector posRelativeMainButton = new PVector (-8, -10) ;
PVector posRelativeSettingButton = new PVector (-8,14) ;
PVector posRelativeSoundButton = new PVector (-8,25) ;
PVector posRelativeActionButton = new PVector (4,25) ;
//////////////
void groupOne(int buttonPositionY, int sliderPositionY) {
  //position and area for the rollover
  for (int i = 1 ; i <= numGroup[1] ; i++) {
    posWidthBOf[i*10+1] = margeLeft +((i-1)*40) +(int)posRelativeMainButton.x    ; posHeightBOf[i*10+1] = buttonPositionY +(int)posRelativeMainButton.y     ; longueurBOf[i*10+1] = 20 ; hauteurBOf[i*10+1] = 20 ;  //main
    posWidthBOf[i*10+2] = margeLeft +((i-1)*40) +(int)posRelativeSettingButton.x ; posHeightBOf[i*10+2] = buttonPositionY +(int)posRelativeSettingButton.y  ; longueurBOf[i*10+2] = 19 ; hauteurBOf[i*10+2] = 6 ; //setting
    posWidthBOf[i*10+3] = margeLeft +((i-1)*40) +(int)posRelativeSoundButton.x   ; posHeightBOf[i*10+3] = buttonPositionY +(int)posRelativeSoundButton.y    ; longueurBOf[i*10+3] = 10 ; hauteurBOf[i*10+3] = 6 ; //sound
    posWidthBOf[i*10+4] = margeLeft +((i-1)*40) +(int)posRelativeActionButton.x  ; posHeightBOf[i*10+4] = buttonPositionY +(int)posRelativeActionButton.y   ; longueurBOf[i*10+4] = 10 ; hauteurBOf[i*10+4] = 6 ; //action
  }

  // where the controleur must display the slider
  for( int i = 0 ; i < SLIDER_BY_COL ; i++ ) {
    for (int j = 0 ; j < 3 ; j++) {
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

//////////////////
void groupTwo(int buttonPositionY, int sliderPositionY) {
  for (int i = 1 ; i <= numGroup[2] ; i++ ) {
    posWidthBTf[i*10+1] = margeLeft +((i-1)*40) +(int)posRelativeMainButton.x    ; posHeightBTf[i*10+1] = buttonPositionY +(int)posRelativeMainButton.y     ; longueurBTf[i*10+1] = 20 ; hauteurBTf[i*10+1] = 20 ; //main
    posWidthBTf[i*10+2] = margeLeft +((i-1)*40) +(int)posRelativeSettingButton.x ; posHeightBTf[i*10+2] = buttonPositionY +(int)posRelativeSettingButton.y  ; longueurBTf[i*10+2] = 19 ; hauteurBTf[i*10+2] = 6 ; //setting
    posWidthBTf[i*10+3] = margeLeft +((i-1)*40) +(int)posRelativeSoundButton.x   ; posHeightBTf[i*10+3] = buttonPositionY +(int)posRelativeSoundButton.y    ; longueurBTf[i*10+3] = 10 ; hauteurBTf[i*10+3] = 6 ; //sound
    posWidthBTf[i*10+4] = margeLeft +((i-1)*40) +(int)posRelativeActionButton.x  ; posHeightBTf[i*10+4] = buttonPositionY +(int)posRelativeActionButton.y   ; longueurBTf[i*10+4] = 10 ; hauteurBTf[i*10+4] = 6 ; //action
  }
  // where the controle must display the slider
  for( int i = 0 ; i < SLIDER_BY_COL ; i++ ) {
    for (int j = 0 ; j < 3 ; j++) {
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

/////////////////
void groupThree(int buttonPositionY, int sliderPositionY) {
  //paramètre habillage couleur du bouton cercle BTY
  for (int i = 1 ; i <= numGroup[3] ; i++ ) {
    posWidthBTYf[i*10+1] = margeLeft +((i-1)*40) +(int)posRelativeMainButton.x    ; posHeightBTYf[i*10+1] = buttonPositionY +(int)posRelativeMainButton.y     ; longueurBTYf[i*10+1] = 20 ; hauteurBTYf[i*10+1] = 20 ; //main
    posWidthBTYf[i*10+2] = margeLeft +((i-1)*40) +(int)posRelativeSettingButton.x ; posHeightBTYf[i*10+2] = buttonPositionY +(int)posRelativeSettingButton.y  ; longueurBTYf[i*10+2] = 19 ; hauteurBTYf[i*10+2] = 6 ; //setting
    posWidthBTYf[i*10+3] = margeLeft +((i-1)*40) +(int)posRelativeSoundButton.x   ; posHeightBTYf[i*10+3] = buttonPositionY +(int)posRelativeSoundButton.y    ; longueurBTYf[i*10+3] = 10 ; hauteurBTYf[i*10+3] = 6 ; //sound
    posWidthBTYf[i*10+4] = margeLeft +((i-1)*40) +(int)posRelativeActionButton.x  ; posHeightBTYf[i*10+4] = buttonPositionY +(int)posRelativeActionButton.y   ; longueurBTYf[i*10+4] = 10 ; hauteurBTYf[i*10+4] = 6 ; //action
  }
  
  // where the controleur must display the slider
  // where the controle must display the slider
  for( int i = 0 ; i < SLIDER_BY_COL ; i++ ) {
    for (int j = 0 ; j < 3 ; j++) {
      int whichSlider = i +301 +(j*10) ;
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






/////////////
//CONSTRUCTOR





//END CONSTRUCTOR
/////////////////











//STRUCTURE
//DRAW
void structureDraw() {
  //background
  fill(grisNoir) ; rect(0, 24, width, 31) ; // main band
  fill(gris) ; rect(0, 24+31, width, 100 ) ; // //GROUP ZERO
  int heightOfGroup = lineGroupTwo -lineGroupOne ;
  fill(grisClair) ; rect(0, lineGroupOne -15, width, heightOfGroup) ;   //GROUP ONE
  fill(grisClair) ; rect(0, lineGroupTwo -15, width, heightOfGroup) ;   //GROUP TWO
  fill(grisClair) ; rect(0, lineGroupThree -15, width, height ) ; //GROUP THREE
  
  //the decoration line
  fill (rougeFonce) ; 
  rect(0,0, width, 22) ;
  fill(orange) ;
  rect(0,22, width, 2) ;
  fill (grisNoir) ;
  rect(0,height-9, width, 2) ;
  fill (rougeFonce) ;
  rect(0,height-7, width, 7) ;
  
  // LINE DECORATION
  // GROUP ZERO
  int thicknessDecoration = 5 ;
  fill(noir) ;
  rect(0,54 , width, 2) ; 
  //GROUP ONE
  fill(grisFonce) ;
  rect(0, lineGroupOne -22, width, 8) ; 
  fill(grisNoir) ;
  rect(0, lineGroupOne -20, width, 4) ; 
  // GROUP TWO
  fill(gris) ;
  rect(0, lineGroupTwo -24 +thicknessDecoration, width, thicknessDecoration) ; 
  fill(grisTresFonce) ;
  rect(0, lineGroupTwo -16, width, 2) ;
  // GROUP THREE
  fill(gris) ;
  rect(0, lineGroupThree -24 +thicknessDecoration, width, thicknessDecoration) ; 
  fill(grisTresFonce) ;
  rect(0, lineGroupThree -16, width, 2) ;
  

}
//END STRUCTURE




//TEXT
//DRAW
void textDraw() {
  if(insideNameversion) fill (jaune) ; else fill(orange) ;
  int posTextY = 18 ;
  textFont(FuturaStencil_20,16); 
  text(nameVersion, 5, posTextY);
  //CLOCK
  fill (orange) ; 
  textFont(FuturaStencil_20,16); textAlign(RIGHT);
  text(nf(hour(),2)   + ":" +nf(minute(),2) , width -10, posTextY);
  
  dispayTextSliderGroupZero(lineHeader +64) ;
  
  dislayTextSlider() ;
}
















///////////////////
// SLIDER
void constructorSlider() {
  //slider
  for ( int i = 1 ; i < NUM_SLIDER ; i++ ) {
    PVector sizeMol = new PVector (sizeSlider[i].y, sizeSlider[i].y) ;
    PVector posMol = new PVector(.5,0) ;
    if(infoSaveFromRawList(infoSlider,i).x > -1 ) slider[i] = new SliderAdjustable  (posSlider[i], posMol, sizeSlider[i], sizeMol, "ELLIPSE");

    if(slider[i] != null) slider[i].sliderSetting() ;
  } 
}


void sliderDraw() {
  // UPDATE GROUP ZERO
  sliderDrawGroupZero() ;
  
  /* Loop to display the false background slider instead the usual class Slider background,
  we use it the methode to display a particular background, like the rainbowcolor... */
  for(int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
    sliderBackground(i) ;
  }
  

  // UPDATE and DISPLAY SLIDER GROUP ONE, TWO, THREE
  /* different way to display depend the displaying mode, who can be change with "ctrl+x" */
  int whichGroup = 0 ;
  for (int i = 1 ; i < NUM_SLIDER_GLOBAL ; i++) {
     sliderUpdate(i) ;
     sliderAdvancedDisplay(i, whichGroup) ;
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
                sliderUpdate(k +(objectGroup[i] *100)) ; 
                sliderAdvancedDisplay(k +(objectGroup[i] *100), whichGroup) ; 
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
        sliderUpdate(j +(i *100)) ;
        sliderAdvancedDisplay(j +(i *100), whichGroup) ;
      }
    }
  }
}







// SLIDER UPDATE
void sliderUpdate(int whichOne) {
  // PVector sizeMoletteSlider = new PVector (8,10, 1.2) ; // width, height, thickness
  
  //MIDI update
  sliderMidiUpdate(whichOne) ;
  if(!slider[whichOne].lockedMax  && !slider[whichOne].lockedMax) slider[whichOne].insideMolette() ;
  slider[whichOne].moletteUpdate() ;
  
  //return value to the prescene between 0 to 99
  int valueMax = 99 ;
  valueSlider[whichOne] = constrain(map(slider[whichOne].getValue(), 0, 1, 0,valueMax),0,valueMax)  ;
}


void sliderAdvancedDisplay(int whichOne, int whichGroup) {
    PVector correctionPosMoletteY = new PVector(-2,2)  ;
    float thicknessMolette = 1 ;
    
    if (whichGroup == 0) {
      color colorMolIn = rouge ;
      color colorMolOut = gris ;
      color colorMolStrokeIn = noir ;
      color colorMolStrokeOut = grisFonce ;
      slider[whichOne].moletteDisplay(colorMolIn,colorMolOut, colorMolStrokeIn, colorMolStrokeOut, thicknessMolette) ;
    } else {
      color colorMolIn = rouge ;
      color colorMolOut = grisClair ;
      color colorMolStrokeIn = grisTresFonce ;
      color colorMolStrokeOut = gris ;
      slider[whichOne].moletteDisplay(colorMolIn,colorMolOut, colorMolStrokeIn, colorMolStrokeOut, thicknessMolette) ;
    }
}



// TEXT
void dispayTextSliderGroupZero(int pos) {
  // GROUP ZERO
  textFont(FuturaStencil_20,20); 
  textAlign(LEFT);
  fill (colorTitle) ; 
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
  text(genTxtGUI[1], posSlider[1].x +correctionX, posSlider[1].y +correctionY);
  text(genTxtGUI[2], posSlider[2].x +correctionX, posSlider[2].y +correctionY);
  text(genTxtGUI[3], posSlider[3].x +correctionX, posSlider[3].y +correctionY);
  text(genTxtGUI[4], posSlider[4].x +correctionX, posSlider[4].y +correctionY);
  // LIGHT
  text(genTxtGUI[9], posSlider[7].x +correctionX, posSlider[7].y +correctionY);
  text(genTxtGUI[10], posSlider[8].x +correctionX, posSlider[8].y +correctionY);
  text(genTxtGUI[11], posSlider[9].x +correctionX, posSlider[9].y +correctionY);
  //AMBIENT
  text(genTxtGUI[12], posSlider[10].x +correctionX, posSlider[10].y +correctionY);
  text(genTxtGUI[13], posSlider[11].x +correctionX, posSlider[11].y +correctionY);
  text(genTxtGUI[14], posSlider[12].x +correctionX, posSlider[12].y +correctionY);
  
  fill (colorTextUsual) ;
  textFont(textUsual_1); 
  text(genTxtGUI[5], posSlider[5].x +correctionX, posSlider[5].y +correctionY);
  text(genTxtGUI[6], posSlider[6].x +correctionX, posSlider[6].y +correctionY);
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
  
  //GROUP THREE
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  fill(grisFonce) ;
  pushMatrix () ; rotate (-PI/2) ; text("GROUP THREE", -lineGroupThree, 20); popMatrix() ;
  fill (colorTextUsual) ;
  textFont(textUsual_1); textAlign(LEFT);
  
  // Legend text slider position
  int correctionY = correctionSliderPosition +4 ;
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
    //group Three
    text(sliderNameOne[i +1], colOne +correctionX, lineGroupThree +correctionY +(i*spacingBetweenSlider));
    text(sliderNameTwo[i +1], colTwo +correctionX, lineGroupThree +correctionY +(i*spacingBetweenSlider));
    text(sliderNameThree[i +1], colThree +correctionX, lineGroupThree +correctionY +(i*spacingBetweenSlider));
  }
}




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
// SLIDER special BACKGROUND
/* Loop to display the false background slider instead the usual class Slider background,
we use it the methode to display a particular background, like the rainbowcolor... */
void sliderBackground(int whichOne) {
  // to find the good slider in the array
  int whichGroup = whichOne ;
  whichOne *= 100 ;
  //
  if ( mouseX > (posSlider[whichOne +hueFillRank].x ) && mouseX < (posSlider[whichOne +hueFillRank].y +sizeSlider[whichOne +hueFillRank].x) 
       && mouseY > ( posSlider[whichOne +hueFillRank].y - 5) && mouseY < posSlider[whichOne +hueFillRank].y +30 ) 
  {
    if (displaySlider[whichGroup][hueFillRank])        fondRegletteCouleur    (posSlider[whichOne +hueFillRank].x, posSlider[whichOne +hueFillRank].y, sizeSlider[whichOne +hueFillRank].y, sizeSlider[whichOne +hueFillRank].x) ; 
    if (displaySlider[whichGroup][saturationFillRank]) fondRegletteSaturation (posSlider[whichOne +saturationFillRank].x, posSlider[whichOne +saturationFillRank].y, sizeSlider[whichOne +saturationFillRank].y, sizeSlider[whichOne +hueFillRank].x, valueSlider[whichOne +hueFillRank], valueSlider[whichOne +saturationFillRank], valueSlider[whichOne +brightnessFillRank] ) ;
    if (displaySlider[whichGroup][brightnessFillRank]) fondRegletteDensite    (posSlider[whichOne +brightnessFillRank].x, posSlider[whichOne +brightnessFillRank].y, sizeSlider[whichOne +brightnessFillRank].y, sizeSlider[whichOne +hueFillRank].x, valueSlider[whichOne +hueFillRank], valueSlider[whichOne +saturationFillRank], valueSlider[whichOne +brightnessFillRank] ) ;
  } else {
    if (displaySlider[whichGroup][hueFillRank])        fondReglette (posSlider[whichOne +hueFillRank].x, posSlider[whichOne +hueFillRank].y, sizeSlider[whichOne +hueFillRank].y, sizeSlider[whichOne +hueFillRank].x, roundedSlider, blanc) ;
    if (displaySlider[whichGroup][saturationFillRank]) fondReglette (posSlider[whichOne +saturationFillRank].x, posSlider[whichOne +saturationFillRank].y, sizeSlider[whichOne +saturationFillRank].y, sizeSlider[whichOne +saturationFillRank].x, roundedSlider, blanc ) ;
    if (displaySlider[whichGroup][brightnessFillRank]) fondReglette (posSlider[whichOne +brightnessFillRank].x, posSlider[whichOne +brightnessFillRank].y, sizeSlider[whichOne +brightnessFillRank].y, sizeSlider[whichOne +brightnessFillRank].x, roundedSlider, blanc ) ;
  }
  if (displaySlider[whichGroup][alphaFillRank]) fondReglette (posSlider[whichOne +alphaFillRank].x, posSlider[whichOne +alphaFillRank].y, sizeSlider[whichOne +alphaFillRank].y, sizeSlider[whichOne +alphaFillRank].x, roundedSlider, blanc ) ;
  
  //outline color
  if ( mouseX > (posSlider[whichOne +hueStrokeRank].x) && mouseX < ( posSlider[whichOne +hueStrokeRank].x +sizeSlider[whichOne +hueStrokeRank].x) 
       && mouseY > ( posSlider[whichOne +hueStrokeRank].y - 5) && mouseY < posSlider[whichOne +hueStrokeRank].y +30 ) 
  {
    if (displaySlider[whichGroup][hueStrokeRank])        fondRegletteCouleur    (posSlider[whichOne +hueStrokeRank].x, posSlider[whichOne +hueStrokeRank].y, sizeSlider[whichOne +hueStrokeRank].y, sizeSlider[whichOne +hueStrokeRank].x) ; 
    if (displaySlider[whichGroup][saturationStrokeRank]) fondRegletteSaturation (posSlider[whichOne +saturationStrokeRank].x, posSlider[whichOne +saturationStrokeRank].y, sizeSlider[whichOne +saturationStrokeRank].y, sizeSlider[whichOne +hueStrokeRank].x, valueSlider[whichOne +hueStrokeRank], valueSlider[whichOne +saturationStrokeRank], valueSlider[whichOne +brightnessStrokeRank] ) ;
    if (displaySlider[whichGroup][brightnessStrokeRank]) fondRegletteDensite    (posSlider[whichOne +brightnessStrokeRank].x, posSlider[whichOne +brightnessStrokeRank].y, sizeSlider[whichOne +brightnessStrokeRank].y, sizeSlider[whichOne +hueStrokeRank].x, valueSlider[whichOne +hueStrokeRank], valueSlider[whichOne +saturationStrokeRank], valueSlider[whichOne +brightnessStrokeRank] ) ;
  } else {
    if (displaySlider[whichGroup][hueStrokeRank])        fondReglette (posSlider[whichOne +hueStrokeRank].x, posSlider[whichOne +hueStrokeRank].y, sizeSlider[whichOne +hueStrokeRank].y, sizeSlider[whichOne +hueStrokeRank].x, roundedSlider, blancGrisClair) ;
    if (displaySlider[whichGroup][saturationStrokeRank]) fondReglette (posSlider[whichOne +saturationStrokeRank].x, posSlider[whichOne +saturationStrokeRank].y, sizeSlider[whichOne +saturationStrokeRank].y, sizeSlider[whichOne +saturationStrokeRank].x, roundedSlider, blancGrisClair ) ;
    if (displaySlider[whichGroup][brightnessStrokeRank]) fondReglette (posSlider[whichOne +brightnessStrokeRank].x, posSlider[whichOne +brightnessStrokeRank].y, sizeSlider[whichOne +brightnessStrokeRank].y, sizeSlider[whichOne +brightnessStrokeRank].x, roundedSlider, blancGrisClair) ;
  }
  if (displaySlider[whichGroup][alphaStrokeRank]) fondReglette (posSlider[whichOne +alphaStrokeRank].x, posSlider[whichOne +alphaStrokeRank].y, sizeSlider[whichOne +alphaStrokeRank].y, sizeSlider[whichOne +alphaStrokeRank].x, roundedSlider, blancGrisClair) ;
  //  thickness
  if( displaySlider[whichGroup][thicknessRank]) fondReglette (posSlider[whichOne +thicknessRank].x, posSlider[whichOne +thicknessRank].y, sizeSlider[whichOne +thicknessRank].y, sizeSlider[whichOne +thicknessRank].x, roundedSlider, blancGrisClair) ;
  // width, height, depth
  if(displaySlider[whichGroup][widthObjRank])  fondReglette (posSlider[whichOne +widthObjRank].x, posSlider[whichOne +widthObjRank].y, sizeSlider[whichOne +widthObjRank].y, sizeSlider[whichOne +widthObjRank].x, roundedSlider, blanc) ;
  if(displaySlider[whichGroup][heightObjRank]) fondReglette (posSlider[whichOne +heightObjRank].x, posSlider[whichOne +heightObjRank].y, sizeSlider[whichOne +heightObjRank].y, sizeSlider[whichOne +heightObjRank].x, roundedSlider, blanc) ;
  if(displaySlider[whichGroup][depthObjRank])  fondReglette (posSlider[whichOne +depthObjRank].x, posSlider[whichOne +depthObjRank].y, sizeSlider[whichOne +depthObjRank].y, sizeSlider[whichOne +depthObjRank].x, roundedSlider, blanc) ;
  // canvas
  if(displaySlider[whichGroup][canvasXRank]) fondReglette (posSlider[whichOne +canvasXRank].x, posSlider[whichOne +canvasXRank].y, sizeSlider[whichOne +canvasXRank].y, sizeSlider[whichOne +canvasXRank].x, roundedSlider, blancGrisClair) ;
  if(displaySlider[whichGroup][canvasYRank]) fondReglette (posSlider[whichOne +canvasYRank].x, posSlider[whichOne +canvasYRank].y, sizeSlider[whichOne +canvasYRank].y, sizeSlider[whichOne +canvasYRank].x, roundedSlider, blancGrisClair) ;
  if(displaySlider[whichGroup][canvasZRank]) fondReglette (posSlider[whichOne +canvasZRank].x, posSlider[whichOne +canvasZRank].y, sizeSlider[whichOne +canvasZRank].y, sizeSlider[whichOne +canvasZRank].x, roundedSlider, blancGrisClair) ;
  // quantity
  if(displaySlider[whichGroup][quantityRank]) fondReglette (posSlider[whichOne +quantityRank].x, posSlider[whichOne +quantityRank].y, sizeSlider[whichOne +quantityRank].y, sizeSlider[whichOne +quantityRank].x, roundedSlider, blanc) ;
  // speed
  if(displaySlider[whichGroup][speedRank]) fondReglette ( posSlider[whichOne +speedRank].x, posSlider[whichOne +speedRank].y, sizeSlider[whichOne +speedRank].y, sizeSlider[whichOne +speedRank].x, roundedSlider, blanc) ;
  // direction angle
  if(displaySlider[whichGroup][directionRank]) fondReglette ( posSlider[whichOne +directionRank].x, posSlider[whichOne +directionRank].y, sizeSlider[whichOne +directionRank].y, sizeSlider[whichOne +directionRank].x, roundedSlider, blancGrisClair) ;
  if(displaySlider[whichGroup][angleRank]) fondReglette ( posSlider[whichOne +angleRank].x, posSlider[whichOne +angleRank].y, sizeSlider[whichOne +angleRank].y, sizeSlider[whichOne +angleRank].x, roundedSlider, blancGrisClair) ;
  // amplitude
  if(displaySlider[whichGroup][amplitudeRank]) fondReglette (posSlider[whichOne +amplitudeRank].x, posSlider[whichOne +amplitudeRank].y, sizeSlider[whichOne +amplitudeRank].y, sizeSlider[whichOne +amplitudeRank].x, roundedSlider, blanc) ;
  // analyze
  if(displaySlider[whichGroup][analyzeRank])  fondReglette ( posSlider[whichOne +analyzeRank].x, posSlider[whichOne +analyzeRank].y, sizeSlider[whichOne +analyzeRank].y, sizeSlider[whichOne +analyzeRank].x, roundedSlider, blancGrisClair) ;
  // Family Life
  if(displaySlider[whichGroup][familyRank]) fondReglette ( posSlider[whichOne +familyRank].x, posSlider[whichOne +familyRank].y, sizeSlider[whichOne +familyRank].y, sizeSlider[whichOne +familyRank].x, roundedSlider, blanc) ;
  if(displaySlider[whichGroup][lifeRank]) fondReglette ( posSlider[whichOne +lifeRank].x, posSlider[whichOne +lifeRank].y, sizeSlider[whichOne +lifeRank].y, sizeSlider[whichOne +lifeRank].x, roundedSlider, blanc) ;
  // force
  if(displaySlider[whichGroup][forceRank]) fondReglette ( posSlider[whichOne +forceRank].x, posSlider[whichOne +forceRank].y, sizeSlider[whichOne +forceRank].y, sizeSlider[whichOne +forceRank].x, roundedSlider, blancGrisClair) ;
}



// global slider
void sliderDrawGroupZero () {
  //Background slider
  if (mouseX > (posSlider[1].x ) && mouseX < ( posSlider[1].x + sizeSlider[1].x) 
      && mouseY > ( posSlider[1].y - 5) && mouseY < posSlider[1].y + 30 ) {
    fondRegletteCouleur    ( posSlider[1].x, posSlider[1].y, sizeSlider[1].y, sizeSlider[1].x) ;
    fondRegletteSaturation ( posSlider[2].x, posSlider[2].y, sizeSlider[2].y, sizeSlider[1].x, valueSlider[1], valueSlider[2], valueSlider[3] ) ;
    fondRegletteDensite    ( posSlider[3].x, posSlider[3].y, sizeSlider[3].y, sizeSlider[1].x, valueSlider[1], valueSlider[2], valueSlider[3] ) ;
  } else {
    fondReglette    ( posSlider[1].x, posSlider[1].y, sizeSlider[1].y, sizeSlider[1].x, roundedSlider, grisClair) ;
    fondReglette    ( posSlider[2].x, posSlider[2].y, sizeSlider[2].y, sizeSlider[2].x, roundedSlider, grisClair) ;
    fondReglette    ( posSlider[3].x, posSlider[3].y, sizeSlider[3].y, sizeSlider[3].x, roundedSlider, grisClair) ;
  }
  fondReglette ( posSlider[4].x, posSlider[4].y, sizeSlider[4].y, sizeSlider[4].x, roundedSlider, grisClair) ;
  // light ONE slider
  if (mouseX > (posSlider[7].x ) && mouseX < ( posSlider[7].x +sizeSlider[7].x) 
      && mouseY > ( posSlider[7].y - 5) && mouseY < posSlider[1].y +40) {
    fondRegletteCouleur    ( posSlider[7].x, posSlider[7].y, sizeSlider[7].y, sizeSlider[7].x) ;
    fondRegletteSaturation ( posSlider[8].x, posSlider[8].y, sizeSlider[8].y, sizeSlider[7].x, valueSlider[7], valueSlider[8], valueSlider[9] ) ;
    fondRegletteDensite    ( posSlider[9].x, posSlider[9].y, sizeSlider[9].y, sizeSlider[7].x, valueSlider[7], valueSlider[8], valueSlider[9] ) ;
  } else {
    fondReglette    ( posSlider[7].x, posSlider[7].y, sizeSlider[7].y, sizeSlider[7].x, roundedSlider, grisClair) ;
    fondReglette    ( posSlider[8].x, posSlider[8].y, sizeSlider[8].y, sizeSlider[8].x, roundedSlider, grisClair) ;
    fondReglette    ( posSlider[9].x, posSlider[9].y, sizeSlider[9].y, sizeSlider[9].x, roundedSlider, grisClair) ;
  }
  // light TWO slider
  if (mouseX > (posSlider[10].x ) && mouseX < ( posSlider[10].x + sizeSlider[10].x) 
      && mouseY > ( posSlider[10].y - 5) && mouseY < posSlider[1].y + 40 ) {
    fondRegletteCouleur    ( posSlider[10].x, posSlider[10].y, sizeSlider[10].y, sizeSlider[10].x) ;
    fondRegletteSaturation ( posSlider[11].x, posSlider[11].y, sizeSlider[11].y, sizeSlider[10].x, valueSlider[10], valueSlider[11], valueSlider[9] ) ;
    fondRegletteDensite    ( posSlider[12].x, posSlider[12].y, sizeSlider[12].y, sizeSlider[10].x, valueSlider[10], valueSlider[11], valueSlider[12] ) ;
  } else {
    fondReglette    ( posSlider[10].x, posSlider[10].y, sizeSlider[10].y, sizeSlider[10].x, roundedSlider, grisClair) ;
    fondReglette    ( posSlider[11].x, posSlider[11].y, sizeSlider[11].y, sizeSlider[11].x, roundedSlider, grisClair) ;
    fondReglette    ( posSlider[12].x, posSlider[12].y, sizeSlider[12].y, sizeSlider[12].x, roundedSlider, grisClair) ;
  }
  // music
  fondReglette ( posSlider[5].x, posSlider[5].y, sizeSlider[5].y, sizeSlider[5].x, roundedSlider, grisClair) ;
  fondReglette ( posSlider[6].x, posSlider[6].y, sizeSlider[6].y, sizeSlider[6].x, roundedSlider, grisClair) ;
}






//SLIDER COLOR
void fondReglette (float posX, float posY, float heightSlider, float widthslider, int rounded, color coulour) {
  fill (coulour) ;
  rect (posX, posY -(heightSlider *.5), widthslider, heightSlider, rounded) ;
}

//hue
void fondRegletteCouleur (float posX, float posY, float heightSlider, float widthSlider) {
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

//saturation
void fondRegletteSaturation (float posX, float posY, float heightSlider, float widthSlider, float coulour, float s, float d) {
  pushMatrix () ;
  translate (posX , posY-(heightSlider *.5)) ;
  for ( int i=0 ; i < widthSlider ; i++ ) {
    for ( int j=0 ; j <=heightSlider ; j++ ) {
      float cr = map(i, 0, widthSlider, 0, 100 ) ;
      float coul = map(coulour, 0, widthSlider, 0, 360 ) ;
      // float sat = map(s, 0, largeur, 0, 100 ) ;
      float dens = map(d, 0, widthSlider, 0, 100 ) ;
      fill (coul, cr, dens) ;
      rect ( i, j, 1,1 ) ;
    }
  }
  popMatrix() ;
}

//density
void fondRegletteDensite (float posX, float posY, float heightSlider, float widthSlider, float coulour, float s, float d) {
  pushMatrix () ;
  translate (posX , posY-(heightSlider *.5)) ;
  for ( int i=0 ; i < widthSlider ; i++ ) {
    for ( int j=0 ; j <=heightSlider ; j++ ) {
      float cr = map(i, 0, widthSlider, 0, 100 ) ;
      float coul = map(coulour, 0, widthSlider, 0, 360 ) ;
      float sat = map(s, 0, widthSlider, 0, 100 ) ;
      // float dens = map(d, 0, largeur, 0, 100 ) ;
      fill (coul, sat, cr) ;
      rect (i, j, 1,1) ;
    }
  }
  popMatrix() ;
}
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
}





// BUTTON DRAW
void buttonDraw() {
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






void buttonInfoOnTheTop() {
  fill(jaune) ;
   textFont(FuturaStencil_20) ;
  if(BOmidi.rollover()) text("Midi Setting",   mouseX -20, mouseY -20 ) ;
  if(BOcurtain.rollover()) text("Cut",   mouseX -20, mouseY -20 ) ;
}

// DETAIL
// GROUP ZERO
void buttonDrawGroupZero() {
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

//GROUP THREE
void buttonDrawGroupThree() {
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



void buttonCheckDraw() {
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













// DROPDOWN
////////////
int refSizeImageDropdown, refSizeFileTextDropdown ;
PVector posTextDropdownImage, posTextDropdownFileText ; 
color selectedText ;
color colorBoxIn, colorBoxOut, colorBoxText, colorDropdownBG, colorDropdownTitleIn, colorDropdownTitleOut ;
int sizeToRenderTheBoxDropdown = 15 ;

void dropdownSetup() {
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
  sizeDropdownMode = new PVector (20, sizeToRenderTheBoxDropdown, 8) ;
  PVector newPos = new PVector( -8, 40 ) ;
  // group one
  checkTheDropdownSetupObject(startLoopObject, endLoopObject, margeLeft +newPos.x, lineGroupOne +newPos.y) ;
  // group two
  checkTheDropdownSetupObject(startLoopTexture, endLoopTexture, margeLeft +newPos.x, lineGroupTwo +newPos.y) ;
  // group three
  checkTheDropdownSetupObject(startLoopTypo, endLoopTypo, margeLeft +newPos.x, lineGroupThree +newPos.y) ;
}

void checkTheDropdownSetupObject( int start, int end, float posWidth, float posHeight) {
  for ( int i = start ; i < end ; i ++ ) {
    if(modeListRomanesco[i] != null ) {
      int space = ((i - start +1) * 40) - 40 ;
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
  
  dropdownBackground.dropdownUpdate(FuturaStencil_10, textUsual_1);
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
    EtatBackground = dropdownBackground.getSelection() ;
    if (dropdownBackground.getSelection() != 0 ) {
      text(shaderBackgroundName[EtatBackground] +" by " +shaderBackgroundAuthor[dropdownBackground.getSelection()], posDropdownBackground.x +3 , posDropdownBackground.y +22) ;
    } else {
      text(shaderBackgroundName[EtatBackground], posDropdownBackground.x +3 , posDropdownBackground.y +22) ;
    }
      
  }
}

// FONT
void dropdownFont() {
  dropdownFont.dropdownUpdate(FuturaStencil_10, textUsual_1);
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
  
  dropdownImage.dropdownUpdate(FuturaStencil_10, textUsual_1);
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
void dropdownFileText() {
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
  totalSizeDropdown = new PVector ( newSizeFileText.x +(margeAroundDropdown *1.5), sizeDropdownFileText.y *(heightDropdown +1) +margeAroundDropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
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
void checkTheDropdownDrawObject( int start, int end ) {
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
        totalSizeDropdown = new PVector (newSizeModeTypo.x + (margeAroundDropdown *1.5) , sizeDropdownMode.y * (heightDropdown +1)  + margeAroundDropdown   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
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
