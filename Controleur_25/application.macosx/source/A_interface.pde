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


//paramètres réglette couleur
int posXSlider[] =      new int[numSlider*2] ;



//SETUP
void interfaceSetup() {
  fontSetup() ;
  midiSetup() ;
  importPicButtonSetup() ;
  buttonSliderSetup() ;
  constructorSliderButton() ;
}

void interfaceDraw() {
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
void midiSetup() {
  //get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);
  //open the first midi channel of the first device if there Input
  if ( midiIO.numberOfInputDevices() > 0 ) midiIO.openInput(0,0);
}
//DRAW
void midiDraw() {
  //save midi setting molette
  String [] newSettingMidi = new String[numSlider] ;
  if ( EtatMidiButton == 1 ) selectMidi = true ; else selectMidi = false ;
}
//END MIDI



//BUTTON

//SETUP
void buttonSliderSetup() {
 
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
void groupZero(int pos) {
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
void groupOne( int posButton, int posSlider) {
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
void groupTwo(int posButton, int posSlider) {
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
void groupThree(int posButton, int posSlider) {
  //paramètre habillage couleur du bouton cercle BTY
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
void constructorSliderButton() {
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
void structureDraw() {
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
void textDraw() {
  fill (blanc) ; 
  textFont(FuturaStencil_20,20); 
  text("ROMANESCO alpha "+release, 5, 20); 
  //CLOCK
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  text(  nf(hour(),2)   + ":" +nf(minute(),2) , width -10, 20);
  
  dispayTextSliderGroupZero(startingTopPosition +64) ;
  
  dislayTextSlider() ;
}



void dispayTextSliderGroupZero(int pos) {
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



void dislayTextSlider() {
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
void moletteDraw() {
  PVector sizeMoletteSlider = new PVector (8,10, 1.5) ; // width, height, thickness
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
        Slider[i].selectIDmidi(int(loadR [i + numSlider]) ) ;
      }
      Slider[i].update(mouseX, loadR[i]);    
      Slider[i].displayMolette(rouge, orange, blanc, sizeMoletteSlider);

      //value from the slider
      valueSlider[i] = constrain(map(Slider[i].getPos(), 0, 104, 0,100),0,100)  ;     
      saveR [i] = byte(valueSlider[i] ) ;
      saveR [i + numSlider] = byte(Slider[i].IDmidi() ) ;
    }
  }
  loadSliderPos = false ; 
}
//END MOLETTE



//SLIDER DRAW
/////////////
void sliderDraw() {
  sliderDrawGroupZero () ;
  sliderDrawGroupOne () ;
  sliderDrawGroupTwo () ;
  sliderDrawGroupThree () ;
}

// DETAIL GROUP SLIDER DRAW
///////////////////////////
void sliderDrawGroupZero () {
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
void sliderDrawGroupOne () {
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
void sliderDrawGroupTwo () {
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
void sliderDrawGroupThree () {
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
void buttonDraw () {
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
void buttonDrawGroupZero() {
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
void rolloverVignette ( int posX, int posY , int hauteur, int largeur, int numero, int posXimage, int posYimage) {
  if (mouseX > posX && mouseX < (largeur + posX ) && mouseY > posY - 10 && mouseY <  (hauteur + posY) -20 ) { 
    image(vignette[numero],posXimage , posYimage ) ;
  }
}

//show info
void rolloverInfoVignette(PVector pos, PVector size, int IDorder, int IDfamily) {
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

void lookAndDisplayInfo(int IDorder, PVector pos) {
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
      float sat = map(s, 0, largeur, 0, 100 ) ;
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
      float dens = map(d, 0, largeur, 0, 100 ) ;
      fill (coul, sat, cr) ;
      rect ( i, j, 1,1 ) ;
    }
  }
  popMatrix() ;
}






void dropdownSetup() {
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
  posDropdownShaderBG = new PVector(posButtonShaderBG.x, posButtonShaderBG.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  sizeDropdownShaderBG = new PVector (75, 13, 15 ) ;
  PVector posTextDropdownShaderBG = new PVector(3, 10)  ;
  dropdownShaderBG = new Dropdown("Shader background", shaderBackgroundName, posDropdownShaderBG, sizeDropdownShaderBG, posTextDropdownShaderBG, colorBG, colorBoxIn, colorBoxOut, colorBoxText, sizeTexteInterface) ;
  
  
  //FONT dropdown
  ///////////////
  posDropdownFont = new PVector(posButtonFont.x, posButtonFont.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
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

void checkTheDropdownSetupObject( int start, int end, float posWidth, float posHeight) {
  for ( int i = start ; i < end ; i ++ ) {
    if(modeListRomanesco[i] != null ) {
      int space = ((i - start +1) * 40) - 40 ;
      //Split the dropdown to display in the dropdown
      listDropdown = split(modeListRomanesco[i], "/" ) ;
      //to change the title of the header dropdown

      posDropdown[i] = new PVector(posWidth +space, posHeight , 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
      dropdown[i] = new Dropdown("M", listDropdown, posDropdown[i], sizeDropdownMode, posTextDropdown, colorBG, colorBoxIn, colorBoxOut, colorBoxText, sizeTexteInterface) ;
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
  dropdownShaderBG() ;
  dropdownFontDraw() ;
  // check the activity o the dropdown
  if(dropdownActivityCount > 0 ) dropdownActivity = true ; else dropdownActivity = false ;
  dropdownActivityCount = 0 ;
}
// END MAIN

// SHADER Background
void dropdownShaderBG() {
  dropdownShaderBG.dropdownUpdate(FuturaStencil_10, textInterface);
  if (dropdownOpen) dropdownActivityCount = +1 ;
  margeAroundDropdown = sizeDropdownFont.y  ;
  //give the size of menu recalculate with the size of the word inside
  PVector newSizeFont = dropdownShaderBG.sizeDropdownMenu() ;
  totalSizeDropdown = new PVector ( newSizeFont.x +(margeAroundDropdown *1.5), sizeDropdownShaderBG.y *(sizeDropdownShaderBG.z +1) +margeAroundDropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
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
void dropdownFontDraw() {
  dropdownFont.dropdownUpdate(FuturaStencil_10, textInterface);
  if (dropdownOpen) dropdownActivityCount = +1 ;
  margeAroundDropdown = sizeDropdownFont.y  ;
  //give the size of menu recalculate with the size of the word inside
  PVector newSizeFont = dropdownFont.sizeDropdownMenu() ;
  totalSizeDropdown = new PVector ( newSizeFont.x +(margeAroundDropdown *1.5), sizeDropdownFont.y *(sizeDropdownFont.z +1) +margeAroundDropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  newPosDropdown = new PVector (posDropdownFont.x -margeAroundDropdown, posDropdownFont.y) ;
  if (!insideRect(newPosDropdown, totalSizeDropdown)) dropdownFont.locked = false ;
  //give the value for the save
  saveR [7] = byte(dropdownFont.getSelection() +1) ;
  // display the selection
  textFont(FuturaStencil_10) ;
  text(policeDropdownList[dropdownFont.getSelection()], posDropdownFont.x +35 , posDropdownFont.y +10) ;
}

// OBJECT
void checkTheDropdownDrawObject( int start, int end ) {
  for ( int i = start ; i < end ; i ++ ) {
    if(modeListRomanesco[i] != null ) {
      String m [] = split(modeListRomanesco[i], "/") ;
      if ( m.length > 1) {
        dropdown[i].dropdownUpdate(FuturaStencil_10, textInterface);
        if (dropdownOpen) dropdownActivityCount = +1 ;
        margeAroundDropdown = sizeDropdownMode.y  ;
        //give the size of menu recalculate with the size of the word inside
        PVector newSizeModeTypo = dropdown[i].sizeDropdownMenu() ;
        totalSizeDropdown = new PVector ( newSizeModeTypo.x + (margeAroundDropdown *1.5) , sizeDropdownMode.y * (sizeDropdownMode.z +1)  + margeAroundDropdown   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
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
void dropdownMousepressed() {
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


void checkDropdownShaderBG() {
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


void checkDropdownFont() {
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

void checkTheDropdownObjectMousepressed( int start, int end ) {
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
