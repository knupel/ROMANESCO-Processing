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






//BOUTON
int numButton = 100 ;
int numButtonGlobal = 11 ;
int numButtonObj = 120 ;
int numButtonTex = 120 ;
int numButtonTypo = 120 ;
int numButtonDropdown = 100 ;
//BUTTON
int valueButtonGlobal[] = new int[numButtonGlobal] ;
int valueButtonObj[] = new int[numButtonObj] ;
int valueButtonTex[] = new int[numButtonTex] ;
int valueButtonTypo[] = new int[numButtonTypo] ;

Simple  BOmidi, BOcurtain, buttonMeteo,
        Bbeat, Bkick, Bsnare, Bhat;
        
//bouton objet
Simple[] BOf = new Simple[numButton] ;

int transparenceBordBOf[] =      new int[numButton] ;
int epaisseurBordBOf[] =         new int[numButton] ;
int transparenceBoutonBOf[] =    new int[numButton] ;
int posWidthBOf[] =              new int[numButton] ;
int posHeightBOf[] =             new int[numButton] ;
int longueurBOf[] =              new int[numButton] ;
int hauteurBOf[] =               new int[numButton] ;

//bouton texture
Simple[] BTf = new Simple[numButton] ;

int transparenceBordBTf[] =      new int[numButton] ;
int epaisseurBordBTf[] =         new int[numButton] ;
int transparenceBoutonBTf[] =    new int[numButton] ;
int posWidthBTf[] =              new int[numButton] ;
int posHeightBTf[] =             new int[numButton] ;
int longueurBTf[] =              new int[numButton] ;
int hauteurBTf[] =               new int[numButton] ;

//bouton typo
Simple[] BTYf = new Simple[numButton] ;

int transparenceBordBTYf[] =      new int[numButton] ;
int epaisseurBordBTYf[] =         new int[numButton] ;
int transparenceBoutonBTYf[] =    new int[numButton] ;
int posWidthBTYf[] =              new int[numButton] ;
int posHeightBTYf[] =             new int[numButton] ;
int longueurBTYf[] =              new int[numButton] ;
int hauteurBTYf[] =               new int[numButton] ;



int transparenceBordBE1, epaisseurBordBE1, transparenceBoutonBE1, 
    posWidthBE1, posHeightBE1, longueurBE1, hauteurBE1 ;
    


//Variable must be send to Scene
//paramètre bouton
int EtatBOf[] = new int[numButton] ;
int EtatBTf[] = new int[numButton] ;
int EtatBTYf[] = new int[numButton] ;
int EtatBIf[] = new int[numButton] ;

// bouton dropdown font
PVector posButtonFont ; 
//bouton midi
int EtatBOmidi ;
int transparenceBordBOmidi, epaisseurBordBOmidi, transparenceBoutonBOmidi, 
    posWidthBOmidi, posHeightBOmidi, longueurBOmidi, hauteurBOmidi ;

//bouton curtain
int EtatBOcurtain ;
int transparenceBordBOcurtain, epaisseurBordBOcurtain, transparenceBoutonBOcurtain, 
    posWidthBOcurtain, posHeightBOcurtain, longueurBOcurtain, hauteurBOcurtain ;

//bouton Musique
int EtatBbeat, EtatBkick, EtatBsnare, EtatBhat ;
int   posWidthBeat, posHeightBeat, longueurBeat,  hauteurBeat,
  posWidthKick, posHeightKick, longueurKick,  hauteurKick,
  posWidthSnare, posHeightSnare, longueurSnare,  hauteurSnare,
  posWidthHat, posHeightHat, longueurHat,  hauteurHat ;


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
  if ( EtatBOmidi == 1 ) selectMidi = true ; else selectMidi = false ;
}
//END MIDI



//BUTTON

//SETUP
void buttonSliderSetup() {
 
  //GLOBAL POS
  margeLeft = (int)columnPosVert.x +15 ; // marge left for the first GUI button and slider
  startingTopPosition = 30 ; // marge top to starting position of the GUI button and slider
  mgSliderc1 = (int)columnPosVert.x ; mgSliderc2 = (int)columnPosVert.y ; mgSliderc3 = (int)columnPosVert.z ;
  
  //GROUP ZERO
  //font
  posButtonFont = new PVector(margeLeft -5, startingTopPosition)  ; //
  //midi  
  posWidthBOmidi = margeLeft +85 ; 
  posHeightBOmidi =startingTopPosition ; 
  longueurBOmidi =50 ; 
  hauteurBOmidi =12 ;
  //curtain  
  posWidthBOcurtain = posWidthBOmidi +70 ; 
  posHeightBOcurtain =startingTopPosition  ; 
  longueurBOcurtain =50 ; 
  hauteurBOcurtain =12 ;
  //beat button
  posWidthBeat  = mgSliderc3 +0  ; posHeightBeat  = startingTopPosition  ; longueurBeat  =30  ; hauteurBeat  =10 ;
  posWidthKick  = mgSliderc3 +30 ; posHeightKick  = startingTopPosition  ; longueurKick  =30  ; hauteurKick  =10 ;
  posWidthSnare = mgSliderc3 +58 ; posHeightSnare = startingTopPosition  ; longueurSnare =45  ; hauteurSnare =10 ;
  posWidthHat   = mgSliderc3 +95 ; posHeightHat   = startingTopPosition  ; longueurHat   =30  ; hauteurHat   =10 ;
  
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
  suivitSlider[1] = 1 ; posWidthSlider[1] = mgSliderc1 ; posHeightSlider[1]= pos +10 ; longueurSlider[1] = 111 ; hauteurSlider[1] = sliderHeight ; ; // couleur du fond  
  suivitSlider[2] = 1 ; posWidthSlider[2] = mgSliderc1 ; posHeightSlider[2]= pos +20 ; longueurSlider[2] = 111 ; hauteurSlider[2] = sliderHeight ; ;   
  suivitSlider[3] = 1 ; posWidthSlider[3] = mgSliderc1 ; posHeightSlider[3]= pos +30 ; longueurSlider[3] = 111 ; hauteurSlider[3] = sliderHeight ; ;   
  suivitSlider[4] = 1 ; posWidthSlider[4] = mgSliderc1 ; posHeightSlider[4]= pos +40 ; longueurSlider[4] = 111 ; hauteurSlider[4] = sliderHeight ; ;   
  //sound
  suivitSlider[5] = 1 ; posWidthSlider[5] = mgSliderc3  ; posHeightSlider[5]= pos -35 ; longueurSlider[5] = 111 ; hauteurSlider[5] = sliderHeight ;  ; // sound left
  suivitSlider[6] = 1 ; posWidthSlider[6] = mgSliderc3  ; posHeightSlider[6]= pos -45 ; longueurSlider[6] = 111 ; hauteurSlider[6] = sliderHeight ; ; // sound rigth 
  //LIGHT
  suivitSlider[7] = 1 ; posWidthSlider[7] = mgSliderc2 ; posHeightSlider[7]= pos +10 ; longueurSlider[7] = 111 ; hauteurSlider[7] = sliderHeight ; ; // hue 
  suivitSlider[8] = 1 ; posWidthSlider[8] = mgSliderc2 ; posHeightSlider[8]= pos +20 ; longueurSlider[8] = 111 ; hauteurSlider[8] = sliderHeight ; ;   
  suivitSlider[9] = 1 ; posWidthSlider[9] = mgSliderc2 ; posHeightSlider[9]= pos +30 ; longueurSlider[9] = 111 ; hauteurSlider[9] = sliderHeight ; ; 
 //AMBIENT 
  suivitSlider[10] = 1 ; posWidthSlider[10] = mgSliderc3 ; posHeightSlider[10]= pos +10 ; longueurSlider[10] = 111 ; hauteurSlider[10] = sliderHeight ; ;  // hue ambiance
  suivitSlider[11] = 1 ; posWidthSlider[11] = mgSliderc3 ; posHeightSlider[11]= pos +20 ; longueurSlider[11] = 111 ; hauteurSlider[11] = sliderHeight ; ;
  suivitSlider[12] = 1 ; posWidthSlider[12] = mgSliderc3 ; posHeightSlider[12]= pos +30 ; longueurSlider[12] = 111 ; hauteurSlider[12] = sliderHeight ; ;
}

//////////////
void groupOne( int posButton, int posSlider) {
  //position and area for the rollover
  for (int i = 1 ; i <= numObjectSimple ; i++ ) {
    posWidthBOf[i*10+1] = posWidthBO +((i-1)*40)-8 ; posHeightBOf[i*10+1] = posButton -10  ; longueurBOf[i*10+1] = 20 ; hauteurBOf[i*10+1] = 20 ;  //main
    posWidthBOf[i*10+2] = posWidthBO +((i-1)*40)-8 ; posHeightBOf[i*10+2] = posButton +12  ; longueurBOf[i*10+2] = 19 ; hauteurBOf[i*10+2] = 6 ; //setting
    posWidthBOf[i*10+3] = posWidthBO +((i-1)*40)-8 ; posHeightBOf[i*10+3] = posButton +21  ; longueurBOf[i*10+3] = 10 ; hauteurBOf[i*10+3] = 6 ; //sound
    posWidthBOf[i*10+4] = posWidthBO +((i-1)*40)+2 ; posHeightBOf[i*10+4] = posButton +21  ; longueurBOf[i*10+4] = 10 ; hauteurBOf[i*10+4] = 6 ; //action
  }

  // where the controleur must display the slider
  for( int i = 0 ; i < 8 ; i++ ) {
    suivitSlider[i+101] = 1 ; posWidthSlider[i+101] = mgSliderc1 ; posHeightSlider[i+101] = posSlider +i*10 ; longueurSlider[i+101] = 111 ; hauteurSlider[i+101] = sliderHeight ; ;
    suivitSlider[i+111] = 1 ; posWidthSlider[i+111] = mgSliderc2 ; posHeightSlider[i+111] = posSlider +i*10 ; longueurSlider[i+111] = 111 ; hauteurSlider[i+111] = sliderHeight ; ;
    suivitSlider[i+121] = 1 ; posWidthSlider[i+121] = mgSliderc3 ; posHeightSlider[i+121] = posSlider +i*10 ; longueurSlider[i+121] = 111 ; hauteurSlider[i+121] = sliderHeight ; ;
  }
}

//////////////////
void groupTwo(int posButton, int posSlider) {
  for (int i = 1 ; i <= numObjectTexture ; i++ ) {
    posWidthBTf[i*10+1] = posWidthBT +((i-1)*40)-8 ; posHeightBTf[i*10+1] = posButton -10  ; longueurBTf[i*10+1] = 20 ; hauteurBTf[i*10+1] = 20 ; //main
    posWidthBTf[i*10+2] = posWidthBT +((i-1)*40)-8 ; posHeightBTf[i*10+2] = posButton +12  ; longueurBTf[i*10+2] = 19 ; hauteurBTf[i*10+2] = 6 ; //setting
    posWidthBTf[i*10+3] = posWidthBT +((i-1)*40)-8 ; posHeightBTf[i*10+3] = posButton +21  ; longueurBTf[i*10+3] = 10 ; hauteurBTf[i*10+3] = 6 ; //sound
    posWidthBTf[i*10+4] = posWidthBT +((i-1)*40)+2 ; posHeightBTf[i*10+4] = posButton +21  ; longueurBTf[i*10+4] = 10 ; hauteurBTf[i*10+4] = 6 ; //action
  }
  // where the controle must display the slider
  for( int i = 0 ; i < 8 ; i++ ) {
    suivitSlider[i+201] = 1 ; posWidthSlider[i+201] = mgSliderc1 ; posHeightSlider[i+201] = posSlider +i*10 ; longueurSlider[i+201] = 111 ; hauteurSlider[i+201] = sliderHeight ; ;
    suivitSlider[i+211] = 1 ; posWidthSlider[i+211] = mgSliderc2 ; posHeightSlider[i+211] = posSlider +i*10 ; longueurSlider[i+211] = 111 ; hauteurSlider[i+211] = sliderHeight ; ;
    suivitSlider[i+221] = 1 ; posWidthSlider[i+221] = mgSliderc3 ; posHeightSlider[i+221] = posSlider +i*10 ; longueurSlider[i+221] = 111 ; hauteurSlider[i+221] = sliderHeight ; ;
  }
}

/////////////////
void groupThree(int posButton, int posSlider) {
    //TYPOGRAPHY
  //paramètre habillage couleur du bouton cercle BTY
  for (int i = 1 ; i <= numObjectTypography ; i++ ) {
    posWidthBTYf[i*10+1] = posWidthBTY +((i-1)*40)-8 ; posHeightBTYf[i*10+1] = posButton -10  ; longueurBTYf[i*10+1] = 20 ; hauteurBTYf[i*10+1] = 20 ; //main
    posWidthBTYf[i*10+2] = posWidthBTY +((i-1)*40)-8 ; posHeightBTYf[i*10+2] = posButton +12  ; longueurBTYf[i*10+2] = 19 ; hauteurBTYf[i*10+2] = 6 ; //setting
    posWidthBTYf[i*10+3] = posWidthBTY +((i-1)*40)-8 ; posHeightBTYf[i*10+3] = posButton +21  ; longueurBTYf[i*10+3] = 10 ; hauteurBTYf[i*10+3] = 6 ; //sound
    posWidthBTYf[i*10+4] = posWidthBTY +((i-1)*40)+2 ; posHeightBTYf[i*10+4] = posButton +21  ; longueurBTYf[i*10+4] = 10 ; hauteurBTYf[i*10+4] = 6 ; //action
  }
  
  // where the controleur must display the slider
  for( int i = 0 ; i < 8 ; i++ ) {
    suivitSlider[i+301] = 1 ; posWidthSlider[i+301] = mgSliderc1 ; posHeightSlider[i+301] = posSlider +i*10 ; longueurSlider[i+301] = 111 ; hauteurSlider[i+301] = sliderHeight ; ;
    suivitSlider[i+311] = 1 ; posWidthSlider[i+311] = mgSliderc2 ; posHeightSlider[i+311] = posSlider +i*10 ; longueurSlider[i+311] = 111 ; hauteurSlider[i+311] = sliderHeight ; ;
    suivitSlider[i+321] = 1 ; posWidthSlider[i+321] = mgSliderc3 ; posHeightSlider[i+321] = posSlider +i*10 ; longueurSlider[i+321] = 111 ; hauteurSlider[i+321] = sliderHeight ; ;
  } 
}






/////////////
//CONSTRUCTOR
void constructorSliderButton() {
  //button beat
  Bbeat = new Simple(posWidthBeat, posHeightBeat, longueurBeat,  hauteurBeat, vertTresFonce, vertFonce, rouge, rougeFonce, gris, grisNoir) ;
  Bkick = new Simple(posWidthKick, posHeightKick, longueurKick,  hauteurKick, vertTresFonce, vertFonce, rouge, rougeFonce, gris, grisNoir) ;
  Bsnare = new Simple(posWidthSnare, posHeightSnare, longueurSnare,  hauteurSnare, vertTresFonce, vertFonce, rouge, rougeFonce, gris, grisNoir) ;
  Bhat = new Simple(posWidthHat, posHeightHat, longueurHat,  hauteurHat, vertTresFonce, vertFonce, rouge, rougeFonce, gris, grisNoir) ;
  //MIDI
  BOmidi  = new Simple ( posWidthBOmidi, posHeightBOmidi, longueurBOmidi, hauteurBOmidi, vert, vertFonce, rouge, rougeFonce, gris, grisNoir ) ;
  //curtain
  BOcurtain  = new Simple ( posWidthBOcurtain, posHeightBOcurtain, longueurBOcurtain, hauteurBOcurtain, vert, vertFonce, rouge, rougeFonce, gris, grisNoir ) ;
  
  //button object, texture, typography
  for ( int i = 11 ; i < numButton ; i++) {
    // group one
    BOf[i] = new Simple(  posWidthBOf[i], posHeightBOf[i], longueurBOf[i], hauteurBOf[i], boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir ) ; 
    // group two
    BTf[i] = new Simple(  posWidthBTf[i], posHeightBTf[i], longueurBTf[i], hauteurBTf[i], boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir ) ;
    // group Three
    BTYf[i] = new Simple(  posWidthBTYf[i], posHeightBTYf[i], longueurBTYf[i], hauteurBTYf[i], boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir ) ;
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
  fill(blanc, 120) ;
  text("BACKGROUND", mgSliderc1, posHeightSlider[1] -(correction*4));
  text("LIGHT", mgSliderc2, posHeightSlider[7] -(correction*4));
  text("AMBIENT", mgSliderc3, posHeightSlider[10] -(correction*4));
  fill (typoTitre) ; 
  textFont(texteInterface, sizeTexteInterface) ; textAlign(LEFT);
  fill (typoCourante) ;
  //BACKGROUND
  text(genTxtGUI[1], mgSliderc1 +116, posHeightSlider[1] +correction);
  text(genTxtGUI[2], mgSliderc1 +116, posHeightSlider[2] +correction);
  text(genTxtGUI[3], mgSliderc1 +116, posHeightSlider[3] +correction);
  text(genTxtGUI[4], mgSliderc1 +116, posHeightSlider[4] +correction);
  // LIGHT
  text(genTxtGUI[9], mgSliderc2 +116, posHeightSlider[7] +correction);
  text(genTxtGUI[10], mgSliderc2 +116,posHeightSlider[8] +correction);
  text(genTxtGUI[11], mgSliderc2 +116, posHeightSlider[9] +correction);
  //AMBIENT
  text(genTxtGUI[12], mgSliderc3 +116, posHeightSlider[10] +correction);
  text(genTxtGUI[13], mgSliderc3 +116, posHeightSlider[11] +correction);
  text(genTxtGUI[14], mgSliderc3 +116, posHeightSlider[12] +correction);
  
  fill (typoCourante) ;
  textFont(texteInterface); 
  text(genTxtGUI[5], mgSliderc3 +116, posHeightSlider[5] +correction);
  text(genTxtGUI[6], mgSliderc3 +116, posHeightSlider[6] +correction);
}



void dislayTextSlider() {
  //GROUP ONE
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  fill(blanc, 120) ;
  pushMatrix () ; rotate (-PI/2) ;  text("SIMPLE", -posHeightRO +70, 18); popMatrix() ;
  fill (typoCourante) ;
  textFont(texteInterface);  textAlign(LEFT);
  
  // GROUP TWO
  textFont(FuturaStencil_20,20);  textAlign(RIGHT);
  fill(blanc, 120) ;
  pushMatrix () ; rotate (-PI/2) ;  text("TEXTURE", -posHeightRT +70, 18); popMatrix() ;
  fill (typoCourante) ;
  textFont(texteInterface);  textAlign(LEFT);
  
  //GROUP THREE
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  fill(blanc, 120) ;
  pushMatrix () ; rotate (-PI/2) ; text("TYPOGRAPHIE", -posHeightRTY +70, 18); popMatrix() ;
  fill (typoCourante) ;
  textFont(texteInterface); textAlign(LEFT);
  
  // Legend text slider position
  int correctionPos = 3 ;
  for ( int i = 0 ; i < 8 ; i++) {
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
  
  // for information degre is value of rotation
  /*
  float degregroupOne = map (valueSlider[28],  0, 100, 0, 360 ) ;
  float degregroupTwo = map (valueSlider[128],  0, 100, 0, 360 ) ;
  float degregroupThree = map (valueSlider[228],  0, 100, 0, 360 ) ;
  */
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
  // light slider
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
  // ambient slider
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
  textFont(texteInterface) ;
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
    Bbeat.boutonTexte("BEAT",    posWidthBeat,  posHeightBeat  +6) ;
  Bkick.boutonTexte("KICK",    posWidthKick,  posHeightKick  +6) ;
  Bsnare.boutonTexte("SNARE",  posWidthSnare, posHeightSnare +6) ;
  Bhat.boutonTexte("HAT",      posWidthHat,   posHeightHat   +6) ;
  //MIDI 
  PVector posTxtMidi = new PVector ( 15, 10 ) ;
  BOmidi.boutonCarreEcran  ("MIDI", posTxtMidi) ;
  //curtain
  PVector posTxtcurtain = new PVector ( 10, 10 ) ; 
  BOcurtain.boutonCarreEcran  (genTxtGUI[8], posTxtcurtain) ;
}
//GROUP ONE
void buttonDrawGroupOne() {
    for( int i = 1 ; i <= numObjectSimple ; i++ ) {
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
    for( int i = 1 ; i <= numObjectTexture ; i++ ) {
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
    for( int i = 1 ; i <= numObjectTypography ; i++ ) {
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
  //SOUND
  EtatBbeat = Bbeat.getEtatBoutonCarre() ;
  EtatBkick = Bkick.getEtatBoutonCarre() ;
  EtatBsnare = Bsnare.getEtatBoutonCarre() ;
  EtatBhat = Bhat.getEtatBoutonCarre() ;
  //Check position of button
  EtatBOmidi = BOmidi.getEtatBoutonCarre() ;
  EtatBOcurtain = BOcurtain.getEtatBoutonCarre() ;


  //Statement button, if are OFF or ON
  for( int i = 11 ; i < 100 ; i++) {
    //catch the statement of button object
    EtatBOf[i] = BOf[i].getEtatBoutonCarre() ;
    //catch the statement of button texture
    EtatBTf[i] = BTf[i].getEtatBoutonCarre() ;
    //catch the statement of button typography
    EtatBTYf[i] = BTYf[i].getEtatBoutonCarre() ;
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
void rolloverInfoVignette(PVector pos, PVector size, int IDname, int IDfamily) {
  if (mouseX > pos.x && mouseX < (size.x + pos.x ) && mouseY > pos.y - 10 && mouseY <  (size.y + pos.y) -20 ) {
    textSize(20 ) ;
    textFont(FuturaStencil_20) ;
    PVector fontPos = new PVector(-10, -20 ) ;
    if (IDfamily == 1 ) {
      text(objectSimpleName[IDname -1], mouseX   +fontPos.x, mouseY +fontPos.y) ;
      text(objectSimpleAuthor[IDname -1], mouseX +fontPos.x, mouseY +fontPos.y -20) ;
    }
    if (IDfamily == 2 ) {
      text(objectTextureName[IDname -1], mouseX   +fontPos.x, mouseY +fontPos.y) ;
      text(objectTextureAuthor[IDname -1], mouseX +fontPos.x, mouseY +fontPos.y -20) ;
    }
    if (IDfamily == 3 ) {
      text(objectTypographyName[IDname -1], mouseX   +fontPos.x, mouseY +fontPos.y) ;
      text(objectTypographyAuthor[IDname -1], mouseX +fontPos.x, mouseY +fontPos.y -20) ;
    }
  }
}


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





//////////
//DROPDOWN
int startLoopObject = 1 ;   int endLoopObject = 10 ;
int startLoopTexture = 21 ; int endLoopTexture = 28 ;
int startLoopTypo = 41 ;    int endLoopTypo = 46 ;
//GLOBAL
Dropdown[] dropdown = new Dropdown[numButton] ;
PVector posDropdown[] = new PVector[numButton] ;
PVector sizeDropdownFont, sizeDropdownMode ;
PVector posTextDropdown = new PVector( 2, 8 )  ;

PVector totalSizeDropdown = new PVector (0,0) ;
PVector newPosDropdown = new PVector (0,0) ;

String [] modeListRomanesco ;
String [] policeDropdownList ;
String [] listDropdown ;

float margeAroundDropdown ;


//SETUP

void dropdownSetup() {
  //load the external list  for each mode and split to read in the interface
  //mode
  String mode [] = loadStrings("setting/mode.txt") ;
  String modeListGlobal = join(mode, "") ;
  modeListRomanesco = split(modeListGlobal, "///") ; 
  //typography
  String pList [] = loadStrings("setting/police.txt") ;
  String policeList = join(pList, "") ;
  policeDropdownList = split(policeList, "/") ;
  
  //FONT dropdown
  ///////////////
  posDropdown[99] = new PVector(posButtonFont.x, posButtonFont.y, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
  sizeDropdownFont = new PVector (75, 13, 15 ) ;
  PVector posTextDropdownTypo = new PVector( 3, 10 )  ;
  dropdown[99] = new Dropdown(policeDropdownList,   posDropdown[99] , sizeDropdownFont, posTextDropdownTypo, colorBG, colorBoxIn, colorBoxOut, colorBoxText, texteInterface, sizeTexteInterface) ;
  
  
  
  //MODE Dropdown
  ///////////////
  //common param
  sizeDropdownMode = new PVector (20, 10, 9 ) ;
  //object line
  for ( int i = startLoopObject ; i < endLoopObject ; i ++ ) {
    int space = ((i - startLoopObject +1) * 40) - 40 ;
    //Split the dropdown to display in the dropdown
    listDropdown = split(modeListRomanesco[i], "/" ) ;
    //to change the title of the header dropdown
    listDropdown[0] = "M"  ; 
    
    posDropdown[i] = new PVector(posWidthBO -8 + space, posHeightBO +43, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
    dropdown[i] = new Dropdown(listDropdown,   posDropdown[i] , sizeDropdownMode, posTextDropdown, colorBG, colorBoxIn, colorBoxOut, colorBoxText, texteInterface, sizeTexteInterface) ;
  }
  //Texture line
  for ( int i = startLoopTexture ; i < endLoopTexture ; i ++ ) {
    int space = ((i - startLoopTexture +1) * 40) - 40 ;
    //Split the dropdown to display in the dropdown
    listDropdown = split(modeListRomanesco[i], "/" ) ;
    //to change the title of the header dropdown
    listDropdown[0] = "M"  ; 
    
    posDropdown[i] = new PVector(posWidthBT -8 + space, posHeightBT +43, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
    dropdown[i] = new Dropdown(listDropdown,   posDropdown[i] , sizeDropdownMode, posTextDropdown, colorBG, colorBoxIn, colorBoxOut, colorBoxText, texteInterface, sizeTexteInterface) ;
  }
  //Typo line
  for ( int i = startLoopTypo ; i < endLoopTypo ; i ++ ) {
    int space = ((i - startLoopTypo +1) * 40) - 40 ;
    //Split the dropdown to display in the dropdown
    listDropdown = split(modeListRomanesco[i], "/" ) ;
    //to change the title of the header dropdown
    listDropdown[0] = "M"  ; 
    
    posDropdown[i] = new PVector(posWidthBTY -8 + space, posHeightBTY +43, 0.1)  ; // x y is pos anz z is marge between the dropdown and the header
    dropdown[i] = new Dropdown(listDropdown,   posDropdown[i] , sizeDropdownMode, posTextDropdown, colorBG, colorBoxIn, colorBoxOut, colorBoxText, texteInterface, sizeTexteInterface) ;
  }
  

}
//DRAW
void dropdownDraw() {
  //FONT dropdown
  dropdown[99].dropdownUpdate();
  margeAroundDropdown = sizeDropdownFont.y  ;
  //give the size of menu recalculate with the size of the word inside
  PVector newSizeFont = dropdown[99].sizeDropdownMenu() ;
  totalSizeDropdown = new PVector ( newSizeFont.x + (margeAroundDropdown *1.5) , sizeDropdownFont.y * (sizeDropdownFont.z +1)  + margeAroundDropdown   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  newPosDropdown = new PVector ( posDropdown[99].x - margeAroundDropdown  , posDropdown[99].y ) ;
  // println( posModeDropdown[i].y) ;
  if ( !insideRect(newPosDropdown, totalSizeDropdown) ) dropdown[99].locked = false;
  //give the value for sending to Scène and save
  saveR [7] = byte(dropdown[99].getSelection() +1 ) ;

  
  //MODE dropdown
  //object line
  for ( int i = startLoopObject ; i < endLoopObject ; i ++ ) {
    String m [] = split(modeListRomanesco[i], "/") ;
    if ( m.length > 1) {
      dropdown[i].dropdownUpdate();
      margeAroundDropdown = sizeDropdownMode.y  ;
      //give the size of menu recalculate with the size of the word inside
      PVector newSizeModeObj = dropdown[i].sizeDropdownMenu() ;
      totalSizeDropdown = new PVector ( newSizeModeObj.x + (margeAroundDropdown *1.5) , sizeDropdownMode.y * (sizeDropdownMode.z +1)  + margeAroundDropdown   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
      //new pos to include the slider
      newPosDropdown = new PVector ( posDropdown[i].x - margeAroundDropdown  , posDropdown[i].y ) ;
      // println( posModeDropdown[i].y) ;
      if ( !insideRect(newPosDropdown, totalSizeDropdown) ) dropdown[i].locked = false;
    }
    if (dropdown[i].getSelection() > -1 && m.length > 2 ) text( (dropdown[i].getSelection() +1), posDropdown[i].x +12 , posDropdown[i].y +8) ;
  }
  
  //texture line
  for ( int i = startLoopTexture ; i < endLoopTexture ; i ++ ) {
    String m [] = split(modeListRomanesco[i], "/") ;
    if ( m.length > 1) {
      dropdown[i].dropdownUpdate();
      margeAroundDropdown = sizeDropdownMode.y  ;
      //give the size of menu recalculate with the size of the word inside
      PVector newSizeModeTexture = dropdown[i].sizeDropdownMenu() ;
      totalSizeDropdown = new PVector ( newSizeModeTexture.x + (margeAroundDropdown *1.5) , sizeDropdownMode.y * (sizeDropdownMode.z +1)  + margeAroundDropdown   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
      //new pos to include the slider
      newPosDropdown = new PVector ( posDropdown[i].x - margeAroundDropdown  , posDropdown[i].y ) ;
      // println( posModeDropdown[i].y) ;
      if ( !insideRect(newPosDropdown, totalSizeDropdown) ) dropdown[i].locked = false;
    }
    if (dropdown[i].getSelection() > -1 && m.length > 2 ) text( (dropdown[i].getSelection() +1), posDropdown[i].x +12 , posDropdown[i].y +8) ;
  }
  
  //typo line
  for ( int i = startLoopTypo ; i < endLoopTypo ; i ++ ) {
    String m [] = split(modeListRomanesco[i], "/") ;
    if ( m.length > 1) {
      dropdown[i].dropdownUpdate();
      margeAroundDropdown = sizeDropdownMode.y  ;
      //give the size of menu recalculate with the size of the word inside
      PVector newSizeModeTypo = dropdown[i].sizeDropdownMenu() ;
      totalSizeDropdown = new PVector ( newSizeModeTypo.x + (margeAroundDropdown *1.5) , sizeDropdownMode.y * (sizeDropdownMode.z +1)  + margeAroundDropdown   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
      //new pos to include the slider
      newPosDropdown = new PVector ( posDropdown[i].x - margeAroundDropdown  , posDropdown[i].y ) ;
      if ( !insideRect(newPosDropdown, totalSizeDropdown) ) dropdown[i].locked = false;
    }
    // println(dropdown[i].getSelection()) ;
    if (dropdown[i].getSelection() > -1 && m.length > 2 ) text( (dropdown[i].getSelection() +1), posDropdown[i].x +12 , posDropdown[i].y +8) ;
  }
}

//END DROPDOWN
//MOUSEPRESSED
void dropdownMousepressed() {
  //typographie dropdown
  if (dropdown[99] != null) {
    if (insideRect(posDropdown[99], sizeDropdownFont) && !dropdown[99].locked  ) {
      dropdown[99].locked = true;
    } else if (dropdown[99].locked) {
      int line = dropdown[99].selectDropdownLine();
      if (line > -1 ) {
        dropdown[99].whichDropdownLine(line);
        //to close the dropdown
        dropdown[99].locked = false;        
      } 
    }
  }
  
  //line object
  for ( int i = startLoopObject ; i < endLoopObject ; i ++ ) { 
    if (dropdown[i] != null) {
      if (insideRect(posDropdown[i], sizeDropdownMode) && !dropdown[i].locked  ) {
        dropdown[i].locked = true;
      } else if (dropdown[i].locked) {
        int line = dropdown[i].selectDropdownLine();
        if (line > -1 ) {
          dropdown[i].whichDropdownLine(line);
          //to close the dropdown
          dropdown[i].locked = false;        
        } 
      }
    }
  }
  //texture object
  for ( int i = startLoopTexture ; i < endLoopTexture ; i ++ ) { 
    if (dropdown[i] != null) {
      if (insideRect(posDropdown[i], sizeDropdownMode) && !dropdown[i].locked  ) {
        dropdown[i].locked = true;
      } else if (dropdown[i].locked) {
        int line = dropdown[i].selectDropdownLine();
        if (line > -1 ) {
          dropdown[i].whichDropdownLine(line);
          //to close the dropdown
          dropdown[i].locked = false;        
        } 
      }
    }
  }
  //typo object
  for ( int i = startLoopTypo ; i < endLoopTypo ; i ++ ) { 
    if (dropdown[i] != null) {
      if (insideRect(posDropdown[i], sizeDropdownMode) && !dropdown[i].locked  ) {
        dropdown[i].locked = true;
      } else if (dropdown[i].locked) {
        int line = dropdown[i].selectDropdownLine();
        if (line > -1 ) {
          dropdown[i].whichDropdownLine(line);
          //to close the dropdown
          dropdown[i].locked = false;        
        } 
      }
    }
  }
}
