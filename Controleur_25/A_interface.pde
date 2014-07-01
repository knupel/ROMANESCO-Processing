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

/////////
//SLIDER





// POSITION GLOBAL button and Slider


PVector columnPosVert = new PVector(25,205, 385) ; // give the pos of the column on the axis "x"
int margeLeft  ; // marge left for the first GUI button and slider
int startingTopPosition  ; // marge top to starting position of the GUI button and slider

int sliderHeight = 6 ;
SliderHorizontal [] Slider = new SliderHorizontal [NUM_SLIDER] ;
int suivitSlider[] = new int[NUM_SLIDER] ; 
int posWidthSlider[] = new int[NUM_SLIDER] ;
int posHeightSlider[] = new int[NUM_SLIDER] ;
int longueurSlider[] = new int[NUM_SLIDER] ;
int hauteurSlider[] = new int[NUM_SLIDER] ;
float valueSlider[] = new float[NUM_SLIDER] ;

//paramètre généraux interface
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


//paramètres réglette couleur
int posXSlider[] =      new int[NUM_SLIDER *2] ;







//SPECIFIC VOID of INTERFACE


//MIDI
//SETUP
void midiSetup() {
  //get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);
  //open the first midi channel of the first device if there Input
  if ( midiIO.numberOfInputDevices() > 0 ) midiIO.openInput(0,0);
  indexMidiButton() ;
}
//DRAW
void midiDraw() {
  //save midi setting molette
  // String [] newSettingMidi = new String[numSlider] ;
  if (EtatMidiButton == 1) selectMidi = true ; else selectMidi = false ;
  

}




// MIDI SETTING
void midiButtonManager(boolean saveButton) {
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
int posRankButton(int pos, int rank) {
  return pos*10 +rank ;
}
///////////


boolean loadButton = true ;
void midiButton(Button b, int IDbutton, boolean saveButton) {

  setttingMidiButton(b) ;
  updateMidiButton(b) ;
  if(saveButton) setButton(IDbutton, b.IDmidi(), b.onOff) ;
  
}
void setttingMidiButton(Button b) {
  // setting midi
  if(selectMidi && b.inside && mousePressed) b.selectIDmidi(numMidi) ;
}
void updateMidiButton(Button b) {
  // update midi
   if(valMidi == 127 && numMidi == b.IDmidi()) {
    b.onOff = !b.onOff ;
    valMidi = 0 ;
  }
}

// SLIDER SAVE
void saveSlider() {
  for (int i = 1 ; i < NUM_SLIDER_GLOBAL ; i++) {
     float v = valueSlider[i] ;
     setSlider(i, -2, v) ;
  }
  for (int i = 1 ; i < NUM_GROUP_SLIDER ; i++) { 
    for(int j = 1 ; j < SLIDER_BY_GROUP ; j++) {
      float v =  valueSlider[j +(i *100)] ; 
      setSlider(j +(i *100), -2, v) ;
    }
  }
  showAllSliders = false ;
}




// BUTTON SAVE
Table saveSetting ;
//write the value in the table
void setButton(int IDbutton, int IDmidi, boolean b) {
  TableRow buttonSetting = saveSetting.addRow() ;
  buttonSetting.setString("Type", "Button") ;
  buttonSetting.setInt("ID button", IDbutton) ;
  buttonSetting.setInt("ID midi", IDmidi) ;
  if(b) buttonSetting.setInt("On Off", 1) ; else buttonSetting.setInt("On Off", 0) ;
}
void setSlider(int IDslider, int IDmidi, float value) {
  TableRow sliderSetting = saveSetting.addRow() ;
  sliderSetting.setString("Type", "Slider") ;
  sliderSetting.setInt("ID slider", IDslider) ;
  sliderSetting.setInt("ID midi", IDmidi) ;
  sliderSetting.setFloat("Value slider", value) ; 
}

void indexMidiButton() {
  saveSetting = new Table() ;
  saveSetting.addColumn("Type") ;
  saveSetting.addColumn("ID slider") ;
  saveSetting.addColumn("Value slider") ;
  saveSetting.addColumn("ID button") ;
  saveSetting.addColumn("On Off") ;
  saveSetting.addColumn("ID midi") ;
  
  
  
  //saveButton [whichOne] = byte(valueSlider[whichOne] ) ;
  //saveButton [whichOne + NUM_SLIDER] = byte(Slider[whichOne].IDmidi() ) ;
}
// END MIDI






//SETUP
void buttonSliderSetup() {
 
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

  int posSmallButtonY = 28 ;
  // MIDI CURTAIN
  sizeCurtainButton = new PVector(30,12) ;
  sizeMidiButton = new PVector(30,12) ;
  posMidiButton = new PVector(mgSliderc2, topMenuPos +posSmallButtonY ) ; 
  posCurtainButton = new PVector(mgSliderc1, topMenuPos +posSmallButtonY ) ; 
  
  //SOUND BUTTON
  sizeBeatButton = new PVector(30,10) ; 
  sizeKickButton = new PVector(30,10) ; 
  sizeSnareButton = new PVector(40,10) ; 
  sizeHatButton = new PVector(30,10) ;
  
  posBeatButton = new PVector(mgSliderc3 +0, topMenuPos +posSmallButtonY) ; 
  posKickButton = new PVector(posBeatButton.x +sizeBeatButton.x +5, topMenuPos +posSmallButtonY) ; 
  posSnareButton = new PVector(posKickButton.x +sizeKickButton.x +5, topMenuPos +posSmallButtonY) ; 
  posHatButton = new PVector(posSnareButton.x +sizeSnareButton.x +5, topMenuPos +posSmallButtonY) ;

  // background 
  posBackgroundButton = new PVector(mgSliderc1, startingTopPosition +70) ;
  sizeBackgroundButton = new PVector(95,10) ;
  // light one button
  posLightOneButton = new PVector(mgSliderc2, startingTopPosition +80) ;
  sizeLightOneButton = new PVector(80,10) ;
  posLightOneAction = new PVector(mgSliderc2 +90, posLightOneButton.y) ;
  sizeLightOneAction = new PVector(45,10) ;
  // light two button
  posLightTwoButton = new PVector(mgSliderc3, startingTopPosition +80) ;
  sizeLightTwoButton = new PVector(80,10) ;
  posLightTwoAction = new PVector(mgSliderc3 +90, posLightTwoButton.y) ;
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
  groupZero(startingTopPosition +80) ;
  groupOne(posHeightBO, posHeightRO ) ;
  groupTwo(posHeightBT, posHeightRT ) ;
  groupThree(posHeightBTY, posHeightRTY ) ;
 
  dropdownSetup() ;
}



/////////////////////
void groupZero(int pos) {
  //Background
  suivitSlider[1] = 1 ; posWidthSlider[1] = mgSliderc1 ; posHeightSlider[1]= pos +0 ; longueurSlider[1] = 111 ; hauteurSlider[1] = sliderHeight ; ; // couleur du fond  
  suivitSlider[2] = 1 ; posWidthSlider[2] = mgSliderc1 ; posHeightSlider[2]= pos +10 ; longueurSlider[2] = 111 ; hauteurSlider[2] = sliderHeight ; ;   
  suivitSlider[3] = 1 ; posWidthSlider[3] = mgSliderc1 ; posHeightSlider[3]= pos +20 ; longueurSlider[3] = 111 ; hauteurSlider[3] = sliderHeight ; ;   
  suivitSlider[4] = 1 ; posWidthSlider[4] = mgSliderc1 ; posHeightSlider[4]= pos +30 ; longueurSlider[4] = 111 ; hauteurSlider[4] = sliderHeight ; ;   
  // SOUND
  suivitSlider[5] = 1 ; posWidthSlider[5] = mgSliderc3  ; posHeightSlider[5]= pos -30 ; longueurSlider[5] = 111 ; hauteurSlider[5] = sliderHeight ;  ; // sound left
  suivitSlider[6] = 1 ; posWidthSlider[6] = mgSliderc3  ; posHeightSlider[6]= pos -20 ; longueurSlider[6] = 111 ; hauteurSlider[6] = sliderHeight ; ; // sound rigth 
  // LIGHT ONE
  suivitSlider[7] = 1 ; posWidthSlider[7] = mgSliderc2 ; posHeightSlider[7]= pos +10 ; longueurSlider[7] = 111 ; hauteurSlider[7] = sliderHeight ; ; // hue 
  suivitSlider[8] = 1 ; posWidthSlider[8] = mgSliderc2 ; posHeightSlider[8]= pos +20 ; longueurSlider[8] = 111 ; hauteurSlider[8] = sliderHeight ; ;   
  suivitSlider[9] = 1 ; posWidthSlider[9] = mgSliderc2 ; posHeightSlider[9]= pos +30 ; longueurSlider[9] = 111 ; hauteurSlider[9] = sliderHeight ; ; 
 // LIGHT TWO
  suivitSlider[10] = 1 ; posWidthSlider[10] = mgSliderc3 ; posHeightSlider[10]= pos +10 ; longueurSlider[10] = 111 ; hauteurSlider[10] = sliderHeight ; ;  // hue ambiance
  suivitSlider[11] = 1 ; posWidthSlider[11] = mgSliderc3 ; posHeightSlider[11]= pos +20 ; longueurSlider[11] = 111 ; hauteurSlider[11] = sliderHeight ; ;
  suivitSlider[12] = 1 ; posWidthSlider[12] = mgSliderc3 ; posHeightSlider[12]= pos +30 ; longueurSlider[12] = 111 ; hauteurSlider[12] = sliderHeight ; ;
}

PVector posRelativeMainButton = new PVector (-8, -10) ;
PVector posRelativeSettingButton = new PVector (-8,14) ;
PVector posRelativeSoundButton = new PVector (-8,25) ;
PVector posRelativeActionButton = new PVector (4,25) ;
//////////////
void groupOne( int posButton, int posSlider) {
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
void groupTwo(int posButton, int posSlider) {
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
void groupThree(int posButton, int posSlider) {
  //paramètre habillage couleur du bouton cercle BTY
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
void constructorSliderButton() {
  color OnInColor = vertFonce ;
  color OnOutColor = vertTresFonce ;
  color OffInColor = rouge ;
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
  BOmidi  = new Simple (posMidiButton, sizeMidiButton, OnInColor, OnOutColor, OffInColor, OffOutColor, false) ;
  //curtain
  BOcurtain  = new Simple (posCurtainButton, sizeCurtainButton, OnInColor, OnOutColor, OffInColor, OffOutColor, true) ;
  
  //button object, texture, typography
  for(int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
    int num = numButton[i] ;
    for ( int j = 11 ; j < 10+num ; j++) {
      if(numGroup[1] > 0 && i == 1) BOf[j] = new Simple(  posWidthBOf[j], posHeightBOf[j], longueurBOf[j], hauteurBOf[j], boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir, false) ; 
      if(numGroup[2] > 0 && i == 2) BTf[j] = new Simple(  posWidthBTf[j], posHeightBTf[j], longueurBTf[j], hauteurBTf[j], boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir, false) ;
      if(numGroup[3] > 0 && i == 3) BTYf[j] = new Simple(  posWidthBTYf[j], posHeightBTYf[j], longueurBTYf[j], hauteurBTYf[j], boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir, false) ;
    }

  }
  
  
  
  //slider
  for ( int i = 1 ; i < NUM_SLIDER ; i++ ) {
    int opacity = 100 ;
    if(infoSave(infoSlider,i).x > -1 ) Slider[i] = new SliderHorizontal  (posWidthSlider[i], posHeightSlider[i], longueurSlider[i], hauteurSlider[i], suivitSlider[i], orange, rouge, blancGrisClair, opacity, infoSave(infoSlider, i).z, (int)infoSave(infoSlider, i).y);
  } 
}
//END CONSTRUCTOR
/////////////////











//STRUCTURE
//DRAW
void structureDraw() {
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
void textDraw() {
  fill (blanc) ; 
  int posTextY = 18 ;
  textFont(FuturaStencil_20,16); 
  text(nameVersion, 5, posTextY);
  textFont(textUsual_1) ;
  text("Edition " + edition + " Version " + version, 160,posTextY -1) ; 
  //CLOCK
  textFont(FuturaStencil_20,16); textAlign(RIGHT);
  text(nf(hour(),2)   + ":" +nf(minute(),2) , width -10, posTextY);
  
  dispayTextSliderGroupZero(startingTopPosition +64) ;
  
  dislayTextSlider() ;
}



void dispayTextSliderGroupZero(int pos) {
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



void dislayTextSlider() {
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


void sliderDraw() {
  // DISPLAY BAR
  // global
  sliderDrawGroupZero () ;
  // group one, two, three
  for(int i = 1 ; i < NUM_GROUP_SLIDER ; i++) {
    sliderObject(i) ;
  }
  // END DISPLAY BAR
  

  // DISPLAY MOLETTE
  // global
  for (int i = 1 ; i < NUM_SLIDER_GLOBAL ; i++) {
     updateMolette(i) ;
  }
  // group one, two, three
  if(!showAllSliders) {
    for (int i = 1 ; i <= numObj ; i++) {
      if (objectActive[i] ) {
        for (int j = 1 ; j < NUM_GROUP_SLIDER ; j++) {
          if (showSliderGroup[j] && objectGroup[i] == j) { 
            for(int k = 1 ; k < SLIDER_BY_GROUP ; k++) {
              if (displaySlider[j][k]) {
                updateMolette(k +(objectGroup[i] *100)) ; 
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
        updateMolette(j +(i *100)) ; 
      }
    }
  }
  // END  DISPLAY MOLETTE
}







// annexe void molette
void updateMolette(int whichOne) {
  PVector sizeMoletteSlider = new PVector (8,10, 1.5) ; // width, height, thickness
  
  //MIDI function
  //give which button is active and check is this button have a same IDmidi that Object
  if (numMidi == Slider[whichOne].IDmidi() ) Slider[whichOne].updateMidi(valMidi) ;
  //to add an IDmidi from the internal setting to object
  if (selectMidi && Slider[whichOne].lock() ) Slider[whichOne].selectIDmidi(numMidi) ; 
  //to add an ID midi from the save
  if(loadSaveSetting) Slider[whichOne].selectIDmidi((int)infoSave(infoSlider, whichOne).y ) ;

  
  // update and display
  Slider[whichOne].update(mouseX, (int)infoSave(infoSlider, whichOne).z, loadSaveSetting); 
  Slider[whichOne].displayMolette(rouge, orange, blanc, sizeMoletteSlider);

  //return value between 0 / 100
  valueSlider[whichOne] = constrain(map(Slider[whichOne].getPos(), 0, 104, 0,100),0,100)  ;
  // save data
  //  
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
void sliderObject(int whichOne) {
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
    if (displaySlider[whichGroup][hueFillRank])        fondReglette (posWidthSlider[whichOne +hueFillRank], posHeightSlider[whichOne +hueFillRank], hauteurSlider[whichOne +hueFillRank], longueurSlider[whichOne +hueFillRank], blanc) ;
    if (displaySlider[whichGroup][saturationFillRank]) fondReglette (posWidthSlider[whichOne +saturationFillRank], posHeightSlider[whichOne +saturationFillRank], hauteurSlider[whichOne +saturationFillRank], longueurSlider[whichOne +saturationFillRank], blanc ) ;
    if (displaySlider[whichGroup][brightnessFillRank]) fondReglette (posWidthSlider[whichOne +brightnessFillRank], posHeightSlider[whichOne +brightnessFillRank], hauteurSlider[whichOne +brightnessFillRank], longueurSlider[whichOne +brightnessFillRank], blanc ) ;
  }
  if (displaySlider[whichGroup][alphaFillRank]) fondReglette (posWidthSlider[whichOne +alphaFillRank], posHeightSlider[whichOne +alphaFillRank], hauteurSlider[whichOne +alphaFillRank], longueurSlider[whichOne +alphaFillRank], blanc ) ;
  
  //outline color
  if ( mouseX > (posWidthSlider[whichOne +hueStrokeRank] ) && mouseX < ( posWidthSlider[whichOne +hueStrokeRank] + longueurSlider[whichOne +hueStrokeRank]) 
       && mouseY > ( posHeightSlider[whichOne +hueStrokeRank] - 5) && mouseY < posHeightSlider[whichOne +hueStrokeRank] +30 ) 
  {
    if (displaySlider[whichGroup][hueStrokeRank])        fondRegletteCouleur    (posWidthSlider[whichOne +hueStrokeRank], posHeightSlider[whichOne +hueStrokeRank], hauteurSlider[whichOne +hueStrokeRank], longueurSlider[whichOne +hueStrokeRank]) ; 
    if (displaySlider[whichGroup][saturationStrokeRank]) fondRegletteSaturation (posWidthSlider[whichOne +saturationStrokeRank], posHeightSlider[whichOne +saturationStrokeRank], hauteurSlider[whichOne +saturationStrokeRank], longueurSlider[whichOne +hueStrokeRank], valueSlider[whichOne +hueStrokeRank], valueSlider[whichOne +saturationStrokeRank], valueSlider[whichOne +brightnessStrokeRank] ) ;
    if (displaySlider[whichGroup][brightnessStrokeRank]) fondRegletteDensite    (posWidthSlider[whichOne +brightnessStrokeRank], posHeightSlider[whichOne +brightnessStrokeRank], hauteurSlider[whichOne +brightnessStrokeRank], longueurSlider[whichOne +hueStrokeRank], valueSlider[whichOne +hueStrokeRank], valueSlider[whichOne +saturationStrokeRank], valueSlider[whichOne +brightnessStrokeRank] ) ;
  } else {
    if (displaySlider[whichGroup][hueStrokeRank])        fondReglette (posWidthSlider[whichOne +hueStrokeRank], posHeightSlider[whichOne +hueStrokeRank], hauteurSlider[whichOne +hueStrokeRank], longueurSlider[whichOne +hueStrokeRank], blancGrisClair) ;
    if (displaySlider[whichGroup][saturationStrokeRank]) fondReglette (posWidthSlider[whichOne +saturationStrokeRank], posHeightSlider[whichOne +saturationStrokeRank], hauteurSlider[whichOne +saturationStrokeRank], longueurSlider[whichOne +saturationStrokeRank], blancGrisClair ) ;
    if (displaySlider[whichGroup][brightnessStrokeRank]) fondReglette (posWidthSlider[whichOne +brightnessStrokeRank], posHeightSlider[whichOne +brightnessStrokeRank], hauteurSlider[whichOne +brightnessStrokeRank], longueurSlider[whichOne +brightnessStrokeRank], blancGrisClair) ;
  }
  if (displaySlider[whichGroup][alphaStrokeRank]) fondReglette (posWidthSlider[whichOne +alphaStrokeRank], posHeightSlider[whichOne +alphaStrokeRank], hauteurSlider[whichOne +alphaStrokeRank], longueurSlider[whichOne +alphaStrokeRank], blancGrisClair) ;
  //  thickness
  if( displaySlider[whichGroup][thicknessRank]) fondReglette ( posWidthSlider[whichOne +thicknessRank], posHeightSlider[whichOne +thicknessRank], hauteurSlider[whichOne +thicknessRank], longueurSlider[whichOne +thicknessRank], blancGrisClair) ;
  // width, height, depth
  if(displaySlider[whichGroup][widthObjRank])  fondReglette (posWidthSlider[whichOne +widthObjRank], posHeightSlider[whichOne +widthObjRank], hauteurSlider[whichOne +widthObjRank], longueurSlider[whichOne +widthObjRank], blanc) ;
  if(displaySlider[whichGroup][heightObjRank]) fondReglette (posWidthSlider[whichOne +heightObjRank], posHeightSlider[whichOne +heightObjRank], hauteurSlider[whichOne +heightObjRank], longueurSlider[whichOne +heightObjRank], blanc) ;
  if(displaySlider[whichGroup][depthObjRank])  fondReglette (posWidthSlider[whichOne +depthObjRank], posHeightSlider[whichOne +depthObjRank], hauteurSlider[whichOne +depthObjRank], longueurSlider[whichOne +depthObjRank], blanc) ;
  // canvas
  if(displaySlider[whichGroup][canvasXRank]) fondReglette (posWidthSlider[whichOne +canvasXRank], posHeightSlider[whichOne +canvasXRank], hauteurSlider[whichOne +canvasXRank], longueurSlider[whichOne +canvasXRank], blancGrisClair) ;
  if(displaySlider[whichGroup][canvasYRank]) fondReglette (posWidthSlider[whichOne +canvasYRank], posHeightSlider[whichOne +canvasYRank], hauteurSlider[whichOne +canvasYRank], longueurSlider[whichOne +canvasYRank], blancGrisClair) ;
  if(displaySlider[whichGroup][canvasZRank]) fondReglette (posWidthSlider[whichOne +canvasZRank], posHeightSlider[whichOne +canvasZRank], hauteurSlider[whichOne +canvasZRank], longueurSlider[whichOne +canvasZRank], blancGrisClair) ;
  // quantity
  if(displaySlider[whichGroup][quantityRank]) fondReglette ( posWidthSlider[whichOne +quantityRank], posHeightSlider[whichOne +quantityRank], hauteurSlider[whichOne +quantityRank], longueurSlider[whichOne +quantityRank], blanc) ;
  // speed
  if(displaySlider[whichGroup][speedRank]) fondReglette ( posWidthSlider[whichOne +speedRank], posHeightSlider[whichOne +speedRank], hauteurSlider[whichOne +speedRank], longueurSlider[whichOne +speedRank], blanc) ;
  // direction angle
  if(displaySlider[whichGroup][directionRank]) fondReglette ( posWidthSlider[whichOne +directionRank], posHeightSlider[whichOne +directionRank], hauteurSlider[whichOne +directionRank], longueurSlider[whichOne +directionRank], blancGrisClair) ;
  if(displaySlider[whichGroup][angleRank]) fondReglette ( posWidthSlider[whichOne +angleRank], posHeightSlider[whichOne +angleRank], hauteurSlider[whichOne +angleRank], longueurSlider[whichOne +angleRank], blancGrisClair) ;
  // amplitude
  if(displaySlider[whichGroup][amplitudeRank]) fondReglette ( posWidthSlider[whichOne +amplitudeRank], posHeightSlider[whichOne +amplitudeRank], hauteurSlider[whichOne +amplitudeRank], longueurSlider[whichOne +amplitudeRank], blanc) ;
  // analyze
  if(displaySlider[whichGroup][analyzeRank])  fondReglette ( posWidthSlider[whichOne +analyzeRank], posHeightSlider[whichOne +analyzeRank], hauteurSlider[whichOne +analyzeRank], longueurSlider[whichOne +analyzeRank], blancGrisClair) ;
  // Family Life
  if(displaySlider[whichGroup][familyRank]) fondReglette ( posWidthSlider[whichOne +familyRank], posHeightSlider[whichOne +familyRank], hauteurSlider[whichOne +familyRank], longueurSlider[whichOne +familyRank], blanc) ;
  if(displaySlider[whichGroup][lifeRank]) fondReglette ( posWidthSlider[whichOne +lifeRank], posHeightSlider[whichOne +lifeRank], hauteurSlider[whichOne +lifeRank], longueurSlider[whichOne +lifeRank], blanc) ;
  // force
  if(displaySlider[whichGroup][forceRank]) fondReglette ( posWidthSlider[whichOne +forceRank], posHeightSlider[whichOne +forceRank], hauteurSlider[whichOne +forceRank], longueurSlider[whichOne +forceRank], blancGrisClair) ;
}



// global slider
void sliderDrawGroupZero () {
  //Background slider
  if (mouseX > (posWidthSlider[1] ) && mouseX < ( posWidthSlider[1] + longueurSlider[1]) 
  && mouseY > ( posHeightSlider[1] - 5) && mouseY < posHeightSlider[1] + 30 ) {
    fondRegletteCouleur    ( posWidthSlider[1], posHeightSlider[1], hauteurSlider[1], longueurSlider[1]) ;
    fondRegletteSaturation ( posWidthSlider[2], posHeightSlider[2], hauteurSlider[2], longueurSlider[1], valueSlider[1], valueSlider[2], valueSlider[3] ) ;
    fondRegletteDensite    ( posWidthSlider[3], posHeightSlider[3], hauteurSlider[3], longueurSlider[1], valueSlider[1], valueSlider[2], valueSlider[3] ) ;
  } else {
    fondReglette    ( posWidthSlider[1], posHeightSlider[1], hauteurSlider[1], longueurSlider[1], grisClair) ;
    fondReglette    ( posWidthSlider[2], posHeightSlider[2], hauteurSlider[2], longueurSlider[2], grisClair) ;
    fondReglette    ( posWidthSlider[3], posHeightSlider[3], hauteurSlider[3], longueurSlider[3], grisClair) ;
  }
  fondReglette ( posWidthSlider[4], posHeightSlider[4], hauteurSlider[4], longueurSlider[4], grisClair) ;
  // light ONE slider
  if (mouseX > (posWidthSlider[7] ) && mouseX < ( posWidthSlider[7] + longueurSlider[7]) 
  && mouseY > ( posHeightSlider[7] - 5) && mouseY < posHeightSlider[1] + 40 ) {
    fondRegletteCouleur    ( posWidthSlider[7], posHeightSlider[7], hauteurSlider[7], longueurSlider[7]) ;
    fondRegletteSaturation ( posWidthSlider[8], posHeightSlider[8], hauteurSlider[8], longueurSlider[7], valueSlider[7], valueSlider[8], valueSlider[9] ) ;
    fondRegletteDensite    ( posWidthSlider[9], posHeightSlider[9], hauteurSlider[9], longueurSlider[7], valueSlider[7], valueSlider[8], valueSlider[9] ) ;
  } else {
    fondReglette    ( posWidthSlider[7], posHeightSlider[7], hauteurSlider[7], longueurSlider[7], grisClair) ;
    fondReglette    ( posWidthSlider[8], posHeightSlider[8], hauteurSlider[8], longueurSlider[8], grisClair) ;
    fondReglette    ( posWidthSlider[9], posHeightSlider[9], hauteurSlider[9], longueurSlider[9], grisClair) ;
  }
  // light TWO slider
  if (mouseX > (posWidthSlider[10] ) && mouseX < ( posWidthSlider[10] + longueurSlider[10]) 
  && mouseY > ( posHeightSlider[10] - 5) && mouseY < posHeightSlider[1] + 40 ) {
    fondRegletteCouleur    ( posWidthSlider[10], posHeightSlider[10], hauteurSlider[10], longueurSlider[10]) ;
    fondRegletteSaturation ( posWidthSlider[11], posHeightSlider[11], hauteurSlider[11], longueurSlider[10], valueSlider[10], valueSlider[11], valueSlider[9] ) ;
    fondRegletteDensite    ( posWidthSlider[12], posHeightSlider[12], hauteurSlider[12], longueurSlider[10], valueSlider[10], valueSlider[11], valueSlider[12] ) ;
  } else {
    fondReglette    ( posWidthSlider[10], posHeightSlider[10], hauteurSlider[10], longueurSlider[10], grisClair) ;
    fondReglette    ( posWidthSlider[11], posHeightSlider[11], hauteurSlider[11], longueurSlider[11], grisClair) ;
    fondReglette    ( posWidthSlider[12], posHeightSlider[12], hauteurSlider[12], longueurSlider[12], grisClair) ;
  }
  // music
  fondReglette ( posWidthSlider[5], posHeightSlider[5], hauteurSlider[5], longueurSlider[5], grisClair) ;
  fondReglette ( posWidthSlider[6], posHeightSlider[6], hauteurSlider[6], longueurSlider[6], grisClair) ;
}


// END SLIDER DRAW
//////////////////




/////////////////////
void buttonDraw() {
  textFont(textUsual_1) ;
  buttonDrawGroupZero() ;
  buttonDrawGroupOne() ;
  buttonDrawGroupTwo() ;
  buttonDrawGroupThree() ;
  buttonCheckDraw() ;
  dropdownDraw() ;
  midiButtonManager(false) ;
}








// DETAIL
// GROUP ZERO
void buttonDrawGroupZero() {
  buttonBackground.boutonTexte("Background on/off", posBackgroundButton, FuturaStencil_10, 10) ;
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
void buttonDrawGroupOne() {
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
void buttonDrawGroupTwo() {
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
void buttonDrawGroupThree() {
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
//ROLLOVER vignette
//show image
void rolloverVignette ( int posX, int posY , int hauteur, int largeur, int numero, int posXimage, int posYimage) {
  if (mouseX > posX && mouseX < (largeur + posX ) && mouseY > posY - 10 && mouseY <  (hauteur + posY) -20 ) { 
    image(vignette[numero],posXimage , posYimage ) ;
  }
}

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


//SLIDER COLOR
void fondReglette ( int posX, int posY, int hauteur, int largeur, color couleur ) {
  float hx ;
  hx = hauteur ;
  fill ( couleur ) ;
  rect ( posX  , posY - (hx /2.0 )  , largeur , hauteur ) ;
}

//hue
void fondRegletteCouleur ( int posX, int posY, int hauteur, int largeur ) {
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
void fondRegletteSaturation ( int posX, int posY, int hauteur, int largeur, float couleur, float s, float d ) {
  pushMatrix () ;
  translate (posX , posY-(hauteur/2) ) ;
  for ( int i=0 ; i < largeur ; i++ ) {
    for ( int j=0 ; j <=hauteur ; j++ ) {
      float cr = map(i, 0, largeur, 0, 100 ) ;
      float coul = map(couleur, 0, largeur, 0, 360 ) ;
      // float sat = map(s, 0, largeur, 0, 100 ) ;
      float dens = map(d, 0, largeur, 0, 100 ) ;
      fill (coul, cr, dens) ;
      rect ( i, j, 1,1 ) ;
    }
  }
  popMatrix() ;
}

//density
void fondRegletteDensite ( int posX, int posY, int hauteur, int largeur, float couleur, float s, float d ) {
  pushMatrix () ;
  translate (posX , posY-(hauteur/2) ) ;
  for ( int i=0 ; i < largeur ; i++ ) {
    for ( int j=0 ; j <=hauteur ; j++ ) {
      float cr = map(i, 0, largeur, 0, 100 ) ;
      float coul = map(couleur, 0, largeur, 0, 360 ) ;
      float sat = map(s, 0, largeur, 0, 100 ) ;
      // float dens = map(d, 0, largeur, 0, 100 ) ;
      fill (coul, sat, cr) ;
      rect ( i, j, 1,1 ) ;
    }
  }
  popMatrix() ;
}



// DROPDOWN
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
  //object line
  checkTheDropdownSetupObject(startLoopObject, endLoopObject, posWidthBO +newPos.x, posHeightBO +newPos.y) ;
  //Texture line
  checkTheDropdownSetupObject(startLoopTexture, endLoopTexture, posWidthBT +newPos.x, posHeightBT +newPos.y) ;
  //Typo line
  checkTheDropdownSetupObject(startLoopTypo, endLoopTypo, posWidthBTY +newPos.x, posHeightBTY +newPos.y) ;
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
    if (dropdownBackground.getSelection() != 0 ) fill(selectedText) ; else fill(rougeFonce) ;
    textFont(textUsual_2) ;
    EtatBackground = dropdownBackground.getSelection() ;
    // text(shaderBackgroundName[EtatBackground], posDropdownBackground.x +3 , posDropdownBackground.y +22) ;
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
