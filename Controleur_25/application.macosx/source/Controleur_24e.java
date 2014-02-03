import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.awt.event.KeyEvent; 
import processing.net.*; 
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

public class Controleur_24e extends PApplet {

   ////////////////////////////////////////////////////////////////////////
  // Romanesco Contr\u00f4leur Alpha 0.24 work with Processing 203  /////
 ////////////////////////////////////////////////////////////////////////

public void setup() {
  setting() ;
  loadSetup() ;
  interfaceSetup() ;
  sendOSCsetup() ;
}

public void draw() {
  structureDraw() ;
  interfaceDraw() ;
  sendOSCdraw() ;
}
//GLOBAL


// Midi

MidiIO midiIO;
int sliderMidi, valMidi ;
int numMidi = -1 ;
boolean saveMidi ;
boolean selectMidi = false ;
boolean rideauOpenClose ;

//
/*
//camera
boolean cameraOnOff = false ;
*/
//variable pour le clavier multiple
boolean[] clavier = new boolean[526];
//param\u00e8tre chargement
boolean chargement = false ;
boolean ouvrirFichier = false ;
// int media1 ;
//texte import\u00e9
String texte = "" ;




//ANNEXE
public void setting() {
  size(550,650); 
  colorSetup() ;  

  frameRate(25) ; 
  noStroke () ; // Le frameRate doit \u00eatre le m\u00eame dans tous les Sketches
  frame.setResizable(true);
  background(gris);
}
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
int numSlider = 250 ;

//SLIDER
RegletteHorizontale [] RH = new RegletteHorizontale [numSlider] ;
int suivitRH[] = new int[numSlider] ; 
int margeGaucheRH[] = new int[numSlider] ;
int margeHautRH[] = new int[numSlider] ;
int longueurRH[] = new int[numSlider] ;
int hauteurRH[] = new int[numSlider] ;
float valueSlider[] = new float[numSlider] ;
//int dataValeurRH[] = new int[numSlider] ;


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

Simple  BOmidi, BOrideau, buttonMeteo,
        Bbeat, Bkick, Bsnare, Bhat;
        
//bouton objet
Simple[] BOf = new Simple[numButton] ;

int transparenceBordBOf[] =      new int[numButton] ;
int epaisseurBordBOf[] =         new int[numButton] ;
int transparenceBoutonBOf[] =    new int[numButton] ;
int margeGaucheBOf[] =           new int[numButton] ;
int margeHautBOf[] =             new int[numButton] ;
int longueurBOf[] =              new int[numButton] ;
int hauteurBOf[] =               new int[numButton] ;

//bouton texture
Simple[] BTf = new Simple[numButton] ;

int transparenceBordBTf[] =      new int[numButton] ;
int epaisseurBordBTf[] =         new int[numButton] ;
int transparenceBoutonBTf[] =    new int[numButton] ;
int margeGaucheBTf[] =           new int[numButton] ;
int margeHautBTf[] =             new int[numButton] ;
int longueurBTf[] =              new int[numButton] ;
int hauteurBTf[] =               new int[numButton] ;

//bouton typo
Simple[] BTYf = new Simple[numButton] ;

int transparenceBordBTYf[] =      new int[numButton] ;
int epaisseurBordBTYf[] =         new int[numButton] ;
int transparenceBoutonBTYf[] =    new int[numButton] ;
int margeGaucheBTYf[] =           new int[numButton] ;
int margeHautBTYf[] =             new int[numButton] ;
int longueurBTYf[] =              new int[numButton] ;
int hauteurBTYf[] =               new int[numButton] ;

//bouton image
Simple[] BIf = new Simple[numButton] ;

int transparenceBordBIf[] =      new int[numButton] ;
int epaisseurBordBIf[] =         new int[numButton] ;
int transparenceBoutonBIf[] =    new int[numButton] ;
int margeGaucheBIf[] =           new int[numButton] ;
int margeHautBIf[] =             new int[numButton] ;
int longueurBIf[] =              new int[numButton] ;
int hauteurBIf[] =               new int[numButton] ;

int transparenceBordBE1, epaisseurBordBE1, transparenceBoutonBE1, 
    margeGaucheBE1, margeHautBE1, longueurBE1, hauteurBE1 ;
    


//Variable must be send to Scene
//param\u00e8tre bouton
int EtatBOf[] = new int[numButton] ;
int EtatBTf[] = new int[numButton] ;
int EtatBTYf[] = new int[numButton] ;
int EtatBIf[] = new int[numButton] ;

//bouton midi
int EtatButtonMeteo ;
int transparenceBordButtonMeteo, epaisseurButtonMeteo, transparenceButtonMeteo, 
    margeGaucheButtonMeteo, margeHautButtonMeteo, longueurButtonMeteo, hauteurButtonMeteo ;
    
//bouton midi
int EtatBOmidi ;
int transparenceBordBOmidi, epaisseurBordBOmidi, transparenceBoutonBOmidi, 
    margeGaucheBOmidi, margeHautBOmidi, longueurBOmidi, hauteurBOmidi ;

//bouton rideau
int EtatBOrideau ;
int transparenceBordBOrideau, epaisseurBordBOrideau, transparenceBoutonBOrideau, 
    margeGaucheBOrideau, margeHautBOrideau, longueurBOrideau, hauteurBOrideau ;

//bouton Musique
int EtatBbeat, EtatBkick, EtatBsnare, EtatBhat ;
int   margeGaucheBeat, margeHautBeat, longueurBeat,  hauteurBeat,
  margeGaucheKick, margeHautKick, longueurKick,  hauteurKick,
  margeGaucheSnare, margeHautSnare, longueurSnare,  hauteurSnare,
  margeGaucheHat, margeHautHat, longueurHat,  hauteurHat ;


//param\u00e8tres r\u00e9glette couleur
int posXRH[] =      new int[numSlider*2] ;

//param\u00e8tre g\u00e9n\u00e9raux interface
int hauteurRegH,
    mgRHc1, mgRHc2, mgRHc3,
    margeHautBO,  margeGaucheBO,
    margeHautRO,  margeGaucheRO,
    margeHautBT,  margeGaucheBT,
    margeHautRT,  margeGaucheRT,
    margeHautBTY, margeGaucheBTY,
    margeHautRTY, margeGaucheRTY,
    margeHautBI,  margeGaucheBI,
    margeHautRI,  margeGaucheRI ;

//SETUP
public void interfaceSetup() {
  fontSetup() ;
  //Midi System
  midiSetup() ;
  importPicButtonSetup() ;
  //chargementReglette() ;
  buttonSliderSetup() ;
  //call constructor
  constructorSliderButton() ;
  dropdownSetup() ;
}

public void interfaceDraw() {
  textDraw() ;
  midiDraw() ;
  
  sliderDraw() ;
  moletteDraw () ;
  //
  buttonDisplayDraw () ;
  buttonCheckDraw() ;
  
  dropdownDraw() ;
}

//END GLOBAL
///////////





//SPECIFIC VOID of INTERFACE


//MIDI
//SETUP
public void midiSetup() {
  //get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);
  //open the first midi channel of the first device if there Input
  if ( midiIO.numberOfInputDevices() > 0 ) midiIO.openInput(0,0);
}
//DRAW
public void midiDraw() {
  //save midi setting molette
  String [] newSettingMidi = new String[numSlider] ;
  if ( EtatBOmidi == 1 ) selectMidi = true ; else selectMidi = false ;
}
//END MIDI



//BUTTON

//SETUP
public void buttonSliderSetup() {
  //PARAM\u00c8TRE R\u00c9GLETTE & BOUTON
  mgRHc1 = 20 ; mgRHc2 = 190 ; mgRHc3 = 360 ;
  hauteurRegH = 6 ;
  margeHautBO  = 110  ;               margeGaucheBO  =30 ;
  margeHautRO  = margeHautBO +60   ;  margeGaucheRO  =30 ;
  margeHautBT  = 270  ;               margeGaucheBT  =30 ;
  margeHautRT  = margeHautBT +60   ;  margeGaucheRT  =30 ;
  margeHautBTY = 430 ;                margeGaucheBTY =30 ;
  margeHautRTY = margeHautBTY +60  ;  margeGaucheRTY =30 ;
  margeHautBI  = 560 ;                margeGaucheBI  =30 ;
  margeHautRI  = margeHautRI +60   ;  margeGaucheRI  =30 ;
  
  //Param\u00e8tre bouton interface \u00e9cran
  //meteo
  margeGaucheButtonMeteo = 20     ; margeHautButtonMeteo =28   ; longueurButtonMeteo =20  ; hauteurButtonMeteo =11 ;
  //midi  
  margeGaucheBOmidi = 490         ; margeHautBOmidi =27        ; longueurBOmidi =50       ; hauteurBOmidi =12 ;
  //rideau  
  margeGaucheBOrideau = 490       ; margeHautBOrideau =45      ; longueurBOrideau =50     ; hauteurBOrideau =12 ;
  //beat button
  margeGaucheBeat  = mgRHc2 +30   ; margeHautBeat  = 31        ; longueurBeat  =30        ; hauteurBeat  =10 ;
  margeGaucheKick  = mgRHc2 +60   ; margeHautKick  = 31        ; longueurKick  =30        ; hauteurKick  =10 ;
  margeGaucheSnare = mgRHc2 +88   ; margeHautSnare = 31        ; longueurSnare =45        ; hauteurSnare =10 ;
  margeGaucheHat   = mgRHc2 +125  ; margeHautHat   = 31        ; longueurHat   =30        ; hauteurHat   =10 ;
  
  //Param\u00e8tre r\u00e9glette couleur de fond
  suivitRH[1] = 1 ; margeGaucheRH[1] = mgRHc1 ; margeHautRH[1]= 50     ; longueurRH[1] = 111 ; hauteurRH[1] = hauteurRegH ; // couleur du fond  
  suivitRH[2] = 1 ; margeGaucheRH[2] = mgRHc1 ; margeHautRH[2]= 50 +10 ; longueurRH[2] = 111 ; hauteurRH[2] = hauteurRegH ;   
  suivitRH[3] = 1 ; margeGaucheRH[3] = mgRHc1 ; margeHautRH[3]= 50 +20 ; longueurRH[3] = 111 ; hauteurRH[3] = hauteurRegH ;   
  suivitRH[4] = 1 ; margeGaucheRH[4] = mgRHc1 ; margeHautRH[4]= 50 +30 ; longueurRH[4] = 111 ; hauteurRH[4] = hauteurRegH ;   
  
  suivitRH[5] = 1 ; margeGaucheRH[5] = mgRHc2 +30 ; margeHautRH[5]= 50 +7 ; longueurRH[5] = 111 ; hauteurRH[5] = hauteurRegH  ; // sound left
  suivitRH[6] = 1 ; margeGaucheRH[6] = mgRHc2 +30 ; margeHautRH[6]= 50 +31 ; longueurRH[6] = 111 ; hauteurRH[6] = hauteurRegH ; // sound rigth 
   
  
  //OBJECT SIMPLE
  //position and area for the rollover
  for (int i = 1 ; i <= numObjectSimple ; i++ ) {
    margeGaucheBOf[i*10+1] = margeGaucheBO +((i-1)*40)-8 ; margeHautBOf[i*10+1] = margeHautBO -10  ; longueurBOf[i*10+1] = 20 ; hauteurBOf[i*10+1] = 20 ;  //main
    margeGaucheBOf[i*10+2] = margeGaucheBO +((i-1)*40)-8 ; margeHautBOf[i*10+2] = margeHautBO +12  ; longueurBOf[i*10+2] = 19 ; hauteurBOf[i*10+2] = 6 ; //setting
    margeGaucheBOf[i*10+3] = margeGaucheBO +((i-1)*40)-8 ; margeHautBOf[i*10+3] = margeHautBO +21  ; longueurBOf[i*10+3] = 10 ; hauteurBOf[i*10+3] = 6 ; //sound
    margeGaucheBOf[i*10+4] = margeGaucheBO +((i-1)*40)+2 ; margeHautBOf[i*10+4] = margeHautBO +21  ; longueurBOf[i*10+4] = 10 ; hauteurBOf[i*10+4] = 6 ; //action
    margeGaucheBOf[i*10+5] = margeGaucheBO +((i-1)*40)-8 ; margeHautBOf[i*10+5] = margeHautBO +31  ; longueurBOf[i*10+5] = 18 ; hauteurBOf[i*10+5] = 12 ; // meteo
  }


 //Param\u00e8tre Object simple
  suivitRH[11] = 1 ; margeGaucheRH[11] = mgRHc1 ; margeHautRH[11]= margeHautRO      ; longueurRH[11] = 111 ; hauteurRH[11] = hauteurRegH ;   // Hue (main)
  suivitRH[12] = 1 ; margeGaucheRH[12] = mgRHc1 ; margeHautRH[12]= margeHautRO +10  ; longueurRH[12] = 111 ; hauteurRH[12] = hauteurRegH ;   // Saturation  (main)
  suivitRH[13] = 1 ; margeGaucheRH[13] = mgRHc1 ; margeHautRH[13]= margeHautRO +20  ; longueurRH[13] = 111 ; hauteurRH[13] = hauteurRegH ;   // Brightness  (main)
  suivitRH[14] = 1 ; margeGaucheRH[14] = mgRHc1 ; margeHautRH[14]= margeHautRO +30  ; longueurRH[14] = 111 ; hauteurRH[14] = hauteurRegH ;   // Opacity  (main)
  suivitRH[15] = 1 ; margeGaucheRH[15] = mgRHc1 ; margeHautRH[15]= margeHautRO +40  ; longueurRH[15] = 111 ; hauteurRH[15] = hauteurRegH ;   // Hue (outline if there is )
  suivitRH[16] = 1 ; margeGaucheRH[16] = mgRHc1 ; margeHautRH[16]= margeHautRO +50  ; longueurRH[16] = 111 ; hauteurRH[16] = hauteurRegH ;   // Saturation (outline if there is )
  suivitRH[17] = 1 ; margeGaucheRH[17] = mgRHc1 ; margeHautRH[17]= margeHautRO +60  ; longueurRH[17] = 111 ; hauteurRH[17] = hauteurRegH  ;   // Brigthness ( outline if there is)
  suivitRH[18] = 1 ; margeGaucheRH[18] = mgRHc1 ; margeHautRH[18]= margeHautRO +70  ; longueurRH[18] = 111 ; hauteurRH[18] = hauteurRegH  ;   //  Opacity ( if there is)
  //Param\u00e8tre Object simple column 2
  suivitRH[21] = 1 ; margeGaucheRH[21] = mgRHc2 ; margeHautRH[21]= margeHautRO      ; longueurRH[21] = 111 ; hauteurRH[21] = hauteurRegH ;    // Heigth
  suivitRH[22] = 1 ; margeGaucheRH[22] = mgRHc2 ; margeHautRH[22]= margeHautRO +10  ; longueurRH[22] = 111 ; hauteurRH[22] = hauteurRegH ;    // Width
  suivitRH[23] = 1 ; margeGaucheRH[23] = mgRHc2 ; margeHautRH[23]= margeHautRO +20  ; longueurRH[23] = 111 ; hauteurRH[23] = hauteurRegH ;    // Thickness
  suivitRH[24] = 1 ; margeGaucheRH[24] = mgRHc2 ; margeHautRH[24]= margeHautRO +30  ; longueurRH[24] = 111 ; hauteurRH[24] = hauteurRegH ;    // Quantity
  suivitRH[25] = 1 ; margeGaucheRH[25] = mgRHc2 ; margeHautRH[25]= margeHautRO +40  ; longueurRH[25] = 111 ; hauteurRH[25] = hauteurRegH ;    // Life
  suivitRH[26] = 1 ; margeGaucheRH[26] = mgRHc2 ; margeHautRH[26]= margeHautRO +50  ; longueurRH[26] = 111 ; hauteurRH[26] = hauteurRegH ;    // Speed
  suivitRH[27] = 1 ; margeGaucheRH[27] = mgRHc2 ; margeHautRH[27]= margeHautRO +60 ; longueurRH[27] = 111 ; hauteurRH[27] = hauteurRegH ;    // Easing
  suivitRH[28] = 1 ; margeGaucheRH[28] = mgRHc2 ; margeHautRH[28]= margeHautRO +70 ; longueurRH[28] = 111 ; hauteurRH[28] = hauteurRegH ;    // Orientation
  //Param\u00e8tre Object simple column 3
  suivitRH[31] = 1 ; margeGaucheRH[31] = mgRHc3 ; margeHautRH[31]= margeHautRO      ; longueurRH[31] = 111 ; hauteurRH[31] = hauteurRegH ;     //Amplitude
  suivitRH[32] = 1 ; margeGaucheRH[32] = mgRHc3 ; margeHautRH[32]= margeHautRO +10  ; longueurRH[32] = 111 ; hauteurRH[32] = hauteurRegH ;    
  suivitRH[33] = 1 ; margeGaucheRH[33] = mgRHc3 ; margeHautRH[33]= margeHautRO +20  ; longueurRH[33] = 111 ; hauteurRH[33] = hauteurRegH ;   
  suivitRH[34] = 1 ; margeGaucheRH[34] = mgRHc3 ; margeHautRH[34]= margeHautRO +30  ; longueurRH[34] = 111 ; hauteurRH[34] = hauteurRegH ;   
  suivitRH[35] = 1 ; margeGaucheRH[35] = mgRHc3 ; margeHautRH[35]= margeHautRO +40  ; longueurRH[35] = 111 ; hauteurRH[35] = hauteurRegH ;   
  suivitRH[36] = 1 ; margeGaucheRH[36] = mgRHc3 ; margeHautRH[36]= margeHautRO +50  ; longueurRH[36] = 111 ; hauteurRH[36] = hauteurRegH ;   
  suivitRH[37] = 1 ; margeGaucheRH[37] = mgRHc3 ; margeHautRH[37]= margeHautRO +60 ; longueurRH[37] = 111 ; hauteurRH[37] = hauteurRegH ;   
  suivitRH[38] = 1 ; margeGaucheRH[38] = mgRHc3 ; margeHautRH[38]= margeHautRO +70 ; longueurRH[38] = 111 ; hauteurRH[38] = hauteurRegH ;  
  
  
  //OBJECT TEXTURE
  for (int i = 1 ; i <= numObjectTexture ; i++ ) {
    margeGaucheBTf[i*10+1] = margeGaucheBT +((i-1)*40)-8 ; margeHautBTf[i*10+1] = margeHautBT -10  ; longueurBTf[i*10+1] = 20 ; hauteurBTf[i*10+1] = 20 ; //main
    margeGaucheBTf[i*10+2] = margeGaucheBT +((i-1)*40)-8 ; margeHautBTf[i*10+2] = margeHautBT +12  ; longueurBTf[i*10+2] = 19 ; hauteurBTf[i*10+2] = 6 ; //setting
    margeGaucheBTf[i*10+3] = margeGaucheBT +((i-1)*40)-8 ; margeHautBTf[i*10+3] = margeHautBT +21  ; longueurBTf[i*10+3] = 10 ; hauteurBTf[i*10+3] = 6 ; //sound
    margeGaucheBTf[i*10+4] = margeGaucheBT +((i-1)*40)+2 ; margeHautBTf[i*10+4] = margeHautBT +21  ; longueurBTf[i*10+4] = 10 ; hauteurBTf[i*10+4] = 6 ; //action
    margeGaucheBTf[i*10+5] = margeGaucheBT +((i-1)*40)-8 ; margeHautBTf[i*10+5] = margeHautBT +31  ; longueurBTf[i*10+5] = 18 ; hauteurBTf[i*10+5] = 12 ; // meteo
  }
  
  //TEXTURE column 1
  suivitRH[111] = 1 ; margeGaucheRH[111] = mgRHc1 ; margeHautRH[111]= margeHautRT     ; longueurRH[111] = 111 ; hauteurRH[111] = hauteurRegH ;  // Hue (main)
  suivitRH[112] = 1 ; margeGaucheRH[112] = mgRHc1 ; margeHautRH[112]= margeHautRT +10 ; longueurRH[112] = 111 ; hauteurRH[112] = hauteurRegH ;  // Saturation (main) 
  suivitRH[113] = 1 ; margeGaucheRH[113] = mgRHc1 ; margeHautRH[113]= margeHautRT +20 ; longueurRH[113] = 111 ; hauteurRH[113] = hauteurRegH ;  // Brigthness (main)
  suivitRH[114] = 1 ; margeGaucheRH[114] = mgRHc1 ; margeHautRH[114]= margeHautRT +30 ; longueurRH[114] = 111 ; hauteurRH[114] = hauteurRegH ;  // Opacity (main)   
  suivitRH[115] = 1 ; margeGaucheRH[115] = mgRHc1 ; margeHautRH[115]= margeHautRT +40 ; longueurRH[115] = 111 ; hauteurRH[115] = hauteurRegH ;  // Hue ( outline if there is )
  suivitRH[116] = 1 ; margeGaucheRH[116] = mgRHc1 ; margeHautRH[116]= margeHautRT +50 ; longueurRH[116] = 111 ; hauteurRH[116] = hauteurRegH ;  // Saturation ( outline if there is)  
  suivitRH[117] = 1 ; margeGaucheRH[117] = mgRHc1 ; margeHautRH[117]= margeHautRT +60 ; longueurRH[117] = 111 ; hauteurRH[117] = hauteurRegH ;  // Brigthness ( outline if there is)
  suivitRH[118] = 1 ; margeGaucheRH[118] = mgRHc1 ; margeHautRH[118]= margeHautRT +70 ; longueurRH[118] = 111 ; hauteurRH[118] = hauteurRegH ;  // Opcacity ( outline if there is)
  //TEXTURE column 2  
  suivitRH[121] = 1 ; margeGaucheRH[121] = mgRHc2 ; margeHautRH[121]= margeHautRT      ; longueurRH[121] = 111 ; hauteurRH[121] = hauteurRegH ;   // Height
  suivitRH[122] = 1 ; margeGaucheRH[122] = mgRHc2 ; margeHautRH[122]= margeHautRT +10  ; longueurRH[122] = 111 ; hauteurRH[122] = hauteurRegH ;   // Width  
  suivitRH[123] = 1 ; margeGaucheRH[123] = mgRHc2 ; margeHautRH[123]= margeHautRT +20  ; longueurRH[123] = 111 ; hauteurRH[123] = hauteurRegH ;   // Thickness
  suivitRH[124] = 1 ; margeGaucheRH[124] = mgRHc2 ; margeHautRH[124]= margeHautRT +30  ; longueurRH[124] = 111 ; hauteurRH[124] = hauteurRegH ;   // Quantity 
  suivitRH[125] = 1 ; margeGaucheRH[125] = mgRHc2 ; margeHautRH[125]= margeHautRT +40  ; longueurRH[125] = 111 ; hauteurRH[125] = hauteurRegH ;   // Life
  suivitRH[126] = 1 ; margeGaucheRH[126] = mgRHc2 ; margeHautRH[126]= margeHautRT +50  ; longueurRH[126] = 111 ; hauteurRH[126] = hauteurRegH ;   // Speed 
  suivitRH[127] = 1 ; margeGaucheRH[127] = mgRHc2 ; margeHautRH[127]= margeHautRT +60 ; longueurRH[127] = 111 ; hauteurRH[127] = hauteurRegH ;   // Easing
  suivitRH[128] = 1 ; margeGaucheRH[128] = mgRHc2 ; margeHautRH[128]= margeHautRT +70 ; longueurRH[128] = 111 ; hauteurRH[128] = hauteurRegH ;   // Orientation
  //TEXTURE column 3 
  suivitRH[131] = 1 ; margeGaucheRH[131] = mgRHc3 ; margeHautRH[131]= margeHautRT      ; longueurRH[131] = 111 ; hauteurRH[131] = hauteurRegH ;   // Amplitude
  suivitRH[132] = 1 ; margeGaucheRH[132] = mgRHc3 ; margeHautRH[132]= margeHautRT +10  ; longueurRH[132] = 111 ; hauteurRH[132] = hauteurRegH ;    
  suivitRH[133] = 1 ; margeGaucheRH[133] = mgRHc3 ; margeHautRH[133]= margeHautRT +20  ; longueurRH[133] = 111 ; hauteurRH[133] = hauteurRegH ;   
  suivitRH[134] = 1 ; margeGaucheRH[134] = mgRHc3 ; margeHautRH[134]= margeHautRT +30  ; longueurRH[134] = 111 ; hauteurRH[134] = hauteurRegH ;  
  suivitRH[135] = 1 ; margeGaucheRH[135] = mgRHc3 ; margeHautRH[135]= margeHautRT +40  ; longueurRH[135] = 111 ; hauteurRH[135] = hauteurRegH ;  
  suivitRH[136] = 1 ; margeGaucheRH[136] = mgRHc3 ; margeHautRH[136]= margeHautRT +50  ; longueurRH[136] = 111 ; hauteurRH[136] = hauteurRegH ;  
  suivitRH[137] = 1 ; margeGaucheRH[137] = mgRHc3 ; margeHautRH[137]= margeHautRT +60 ; longueurRH[137] = 111 ; hauteurRH[137] = hauteurRegH ;  
  suivitRH[138] = 1 ; margeGaucheRH[138] = mgRHc3 ; margeHautRH[138]= margeHautRT +70 ; longueurRH[138] = 111 ; hauteurRH[138] = hauteurRegH ;  //Analyze


  //TYPOGRAPHY
  //param\u00e8tre habillage couleur du bouton cercle BTY
  for (int i = 1 ; i <= numObjectTypography ; i++ ) {
    margeGaucheBTYf[i*10+1] = margeGaucheBTY +((i-1)*40)-8 ; margeHautBTYf[i*10+1] = margeHautBTY -10  ; longueurBTYf[i*10+1] = 20 ; hauteurBTYf[i*10+1] = 20 ; //main
    margeGaucheBTYf[i*10+2] = margeGaucheBTY +((i-1)*40)-8 ; margeHautBTYf[i*10+2] = margeHautBTY +12  ; longueurBTYf[i*10+2] = 19 ; hauteurBTYf[i*10+2] = 6 ; //setting
    margeGaucheBTYf[i*10+3] = margeGaucheBTY +((i-1)*40)-8 ; margeHautBTYf[i*10+3] = margeHautBTY +21  ; longueurBTYf[i*10+3] = 10 ; hauteurBTYf[i*10+3] = 6 ; //sound
    margeGaucheBTYf[i*10+4] = margeGaucheBTY +((i-1)*40)+2 ; margeHautBTYf[i*10+4] = margeHautBTY +21  ; longueurBTYf[i*10+4] = 10 ; hauteurBTYf[i*10+4] = 6 ; //action
    margeGaucheBTYf[i*10+5] = margeGaucheBTY +((i-1)*40)-8 ; margeHautBTYf[i*10+5] = margeHautBTY +31  ; longueurBTYf[i*10+5] = 18 ; hauteurBTYf[i*10+5] = 12 ; // meteo
  }
  //WHAT'S THIS !!!???
  margeGaucheBE1 = mgRHc3  ; margeHautBE1 = margeHautBTY -6   ; longueurBE1 = 55 ; hauteurBE1 = 14 ;
  
  //TYPOGRAPHY column 1 
  suivitRH[211] = 1 ; margeGaucheRH[211] = mgRHc1 ; margeHautRH[211] = margeHautRTY      ; longueurRH[211] = 111 ; hauteurRH[211] = hauteurRegH ;   // Hue
  suivitRH[212] = 1 ; margeGaucheRH[212] = mgRHc1 ; margeHautRH[212] = margeHautRTY +10  ; longueurRH[212] = 111 ; hauteurRH[212] = hauteurRegH ;   // Saturation  
  suivitRH[213] = 1 ; margeGaucheRH[213] = mgRHc1 ; margeHautRH[213] = margeHautRTY +20  ; longueurRH[213] = 111 ; hauteurRH[213] = hauteurRegH ;   // Brigthness  
  suivitRH[214] = 1 ; margeGaucheRH[214] = mgRHc1 ; margeHautRH[214] = margeHautRTY +30  ; longueurRH[214] = 111 ; hauteurRH[214] = hauteurRegH ;   // Opacity
  suivitRH[215] = 1 ; margeGaucheRH[215] = mgRHc1 ; margeHautRH[215] = margeHautRTY +40  ; longueurRH[215] = 111 ; hauteurRH[215] = hauteurRegH ;     
  suivitRH[216] = 1 ; margeGaucheRH[216] = mgRHc1 ; margeHautRH[216] = margeHautRTY +50  ; longueurRH[216] = 111 ; hauteurRH[216] = hauteurRegH ;   
  suivitRH[217] = 1 ; margeGaucheRH[217] = mgRHc1 ; margeHautRH[217] = margeHautRTY +60  ; longueurRH[217] = 111 ; hauteurRH[217] = hauteurRegH ;      
  suivitRH[218] = 1 ; margeGaucheRH[218] = mgRHc1 ; margeHautRH[218] = margeHautRTY +70  ; longueurRH[218] = 111 ; hauteurRH[218] = hauteurRegH ;   
  //TYPOGRAPHY column 2
  suivitRH[221] = 1 ; margeGaucheRH[221] = mgRHc2 ; margeHautRH[221] = margeHautRTY      ; longueurRH[221] = 111 ; hauteurRH[221] = hauteurRegH ;  // heigth of paragraph 
  suivitRH[222] = 1 ; margeGaucheRH[222] = mgRHc2 ; margeHautRH[222] = margeHautRTY +10  ; longueurRH[222] = 111 ; hauteurRH[222] = hauteurRegH ;  // width of paragraph  
  suivitRH[223] = 1 ; margeGaucheRH[223] = mgRHc2 ; margeHautRH[223] = margeHautRTY +20  ; longueurRH[223] = 111 ; hauteurRH[223] = hauteurRegH ;      
  suivitRH[224] = 1 ; margeGaucheRH[224] = mgRHc2 ; margeHautRH[224] = margeHautRTY +30  ; longueurRH[224] = 111 ; hauteurRH[224] = hauteurRegH ;   
  suivitRH[225] = 1 ; margeGaucheRH[225] = mgRHc2 ; margeHautRH[225] = margeHautRTY +40  ; longueurRH[225] = 111 ; hauteurRH[225] = hauteurRegH ;  
  suivitRH[226] = 1 ; margeGaucheRH[226] = mgRHc2 ; margeHautRH[226] = margeHautRTY +50  ; longueurRH[226] = 111 ; hauteurRH[226] = hauteurRegH ;   
  suivitRH[227] = 1 ; margeGaucheRH[227] = mgRHc2 ; margeHautRH[227] = margeHautRTY +60  ; longueurRH[227] = 111 ; hauteurRH[227] = hauteurRegH ;     
  suivitRH[228] = 1 ; margeGaucheRH[228] = mgRHc2 ; margeHautRH[228] = margeHautRTY +70  ; longueurRH[228] = 111 ; hauteurRH[228] = hauteurRegH ;   // Orientation
  //TYPOGRAPHY column 3
  suivitRH[231] = 1 ; margeGaucheRH[231] = mgRHc3 ; margeHautRH[231] = margeHautRTY      ; longueurRH[231] = 111 ; hauteurRH[231] = hauteurRegH ; //amplitude  
  suivitRH[232] = 1 ; margeGaucheRH[232] = mgRHc3 ; margeHautRH[232] = margeHautRTY +10  ; longueurRH[232] = 111 ; hauteurRH[232] = hauteurRegH ;     
  suivitRH[233] = 1 ; margeGaucheRH[233] = mgRHc3 ; margeHautRH[233] = margeHautRTY +20  ; longueurRH[233] = 111 ; hauteurRH[233] = hauteurRegH ;      
  suivitRH[234] = 1 ; margeGaucheRH[234] = mgRHc3 ; margeHautRH[234] = margeHautRTY +30  ; longueurRH[234] = 111 ; hauteurRH[234] = hauteurRegH ;  
  suivitRH[235] = 1 ; margeGaucheRH[235] = mgRHc3 ; margeHautRH[235] = margeHautRTY +40  ; longueurRH[235] = 111 ; hauteurRH[235] = hauteurRegH ;      
  suivitRH[236] = 1 ; margeGaucheRH[236] = mgRHc3 ; margeHautRH[236] = margeHautRTY +50  ; longueurRH[236] = 111 ; hauteurRH[236] = hauteurRegH ;  
  suivitRH[237] = 1 ; margeGaucheRH[237] = mgRHc3 ; margeHautRH[237] = margeHautRTY +60  ; longueurRH[237] = 111 ; hauteurRH[237] = hauteurRegH ;      
  suivitRH[238] = 1 ; margeGaucheRH[238] = mgRHc3 ; margeHautRH[238] = margeHautRTY +70  ; longueurRH[238] = 111 ; hauteurRH[238] = hauteurRegH ;  //size font
    
}








/////////////
//CONSTRUCTOR
public void constructorSliderButton() {
  //button meteo
  buttonMeteo = new Simple(margeGaucheButtonMeteo,  margeHautButtonMeteo, longueurButtonMeteo, hauteurButtonMeteo) ;
  //button beat
  Bbeat = new Simple(margeGaucheBeat, margeHautBeat, longueurBeat,  hauteurBeat, vertTresFonce, vertFonce, rouge, rougeFonce, gris, grisNoir) ;
  Bkick = new Simple(margeGaucheKick, margeHautKick, longueurKick,  hauteurKick, vertTresFonce, vertFonce, rouge, rougeFonce, gris, grisNoir) ;
  Bsnare = new Simple(margeGaucheSnare, margeHautSnare, longueurSnare,  hauteurSnare, vertTresFonce, vertFonce, rouge, rougeFonce, gris, grisNoir) ;
  Bhat = new Simple(margeGaucheHat, margeHautHat, longueurHat,  hauteurHat, vertTresFonce, vertFonce, rouge, rougeFonce, gris, grisNoir) ;
  //MIDI
  BOmidi  = new Simple ( margeGaucheBOmidi, margeHautBOmidi, longueurBOmidi, hauteurBOmidi, vert, vertFonce, rouge, rougeFonce, gris, grisNoir ) ;
  //RIDEAU
  BOrideau  = new Simple ( margeGaucheBOrideau, margeHautBOrideau, longueurBOrideau, hauteurBOrideau, vert, vertFonce, rouge, rougeFonce, gris, grisNoir ) ;
  
  //button object, texture, typography
  for ( int i = 11 ; i < numButton ; i++) {
    //object
    BOf[i] = new Simple(  margeGaucheBOf[i], margeHautBOf[i], longueurBOf[i], hauteurBOf[i], boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir ) ; 
    //texture
    BTf[i] = new Simple(  margeGaucheBTf[i], margeHautBTf[i], longueurBTf[i], hauteurBTf[i], boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir ) ;
    //typo
    BTYf[i] = new Simple(  margeGaucheBTYf[i], margeHautBTYf[i], longueurBTYf[i], hauteurBTYf[i], boutonONin, boutonONout, boutonOFFin, boutonOFFout, gris, grisNoir ) ;
  }
  
  //slider
  for ( int i = 1 ; i < numSlider ; i++ ) {
    int opacityReglette = 200 ;
    if ( (i < 4) || ( i > 10 && i < 19) || ( i > 110 && i < 119) || ( i > 210 && i < 219) ) opacityReglette = 0 ; else opacityReglette = 200 ;
    RH[i] = new RegletteHorizontale  (margeGaucheRH[i], margeHautRH[i], longueurRH[i], hauteurRH[i], suivitRH[i], orange, rouge, blancGrisClair, opacityReglette, loadR [i], loadR [i+numSlider]);
  } 
}
//END CONSTRUCTOR
/////////////////









//STRUCTURE
//DRAW
public void structureDraw() {
  //background
  fill(grisClair) ; rect(0, 0, width, height ) ;
  fill(blancGris) ; rect(0, 95, width, 160 ) ;
  fill(grisClair) ;      rect(0, 265, width, 140 ) ;
  fill(blancGris) ; rect(0, 415, width, height ) ;
  //the decoration line
  fill (orange) ; 
  rect(0,0, width, 24) ;
  rect(0,92, width, 3) ;
  rect(0,252, width, 3) ;
  rect(0,412, width, 3) ;
  rect(0,height-7, width, 7) ;

}
//END STRUCTURE




//TEXT
//DRAW
public void textDraw() {
  fill (blanc) ; 
  textFont(FuturaStencil_20,20); 
  text("ROMANESCO alpha 24", 5, 20); 
  //CLOCK
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  text(  nf(hour(),2)   + ":" + 
         nf(minute(),2) , 
         width -10, 20);
  fill (typoTitre) ; 
  textFont(texteInterface, sizeTexteInterface) ; textAlign(LEFT);
  fill (typoCourante) ;

  text(genTxtGUI[1],       mgRHc1 +116, 55);
  text(genTxtGUI[2],    mgRHc1 +116, 65);
  text(genTxtGUI[3],       mgRHc1 +116, 75);
  text(genTxtGUI[4],       mgRHc1 +116, 85);

  
  fill (typoCourante) ;
  textFont(texteInterface); 
  text(genTxtGUI[5],    mgRHc2 +30, 50);
  text(genTxtGUI[6],    mgRHc2 +30, 72);
 
   
  //OBJECT SIMPLE
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  fill(blanc, 120) ;
  pushMatrix () ; rotate (-PI/2) ;  text("SIMPLE", -margeHautRO +70, 18); popMatrix() ;
  fill (typoCourante) ;
  textFont(texteInterface);  textAlign(LEFT);
  
  //colonne 1
  text(objTxtGUIone[1], mgRHc1 +116, margeHautRO +4);
  text(objTxtGUIone[2], mgRHc1 +116, margeHautRO +14);
  text(objTxtGUIone[3], mgRHc1 +116, margeHautRO +24);
  text(objTxtGUIone[4], mgRHc1 +116, margeHautRO +34);
  text(objTxtGUIone[5], mgRHc1 +116, margeHautRO +44);
  text(objTxtGUIone[6], mgRHc1 +116, margeHautRO +54);
  text(objTxtGUIone[7], mgRHc1 +116, margeHautRO +64);
  text(objTxtGUIone[8], mgRHc1 +116, margeHautRO +74);
  
  //colonne 2
  text(objTxtGUItwo[1], mgRHc2 +116, margeHautRO +4);
  text(objTxtGUItwo[2], mgRHc2 +116, margeHautRO +14);    
  text(objTxtGUItwo[3], mgRHc2 +116, margeHautRO +24);
  text(objTxtGUItwo[4], mgRHc2 +116, margeHautRO +34);    
  text(objTxtGUItwo[5], mgRHc2 +116, margeHautRO +44);
  text(objTxtGUItwo[6], mgRHc2 +116, margeHautRO +54);
  text(objTxtGUItwo[7], mgRHc2 +116, margeHautRO +64);
  int degreO ;
  float dO = map (valueSlider[28],  0, 100, 0, 360 ) ;
  degreO = round(dO) ;
  text(degreO  + objTxtGUItwo[8],    mgRHc2 +116,  margeHautRO +74); 
  
  //colonne 3
  text(objTxtGUIthree[1],   mgRHc3 +116, margeHautRO +4);
  text(objTxtGUIthree[2],   mgRHc3 +116, margeHautRO +14);
  text(objTxtGUIthree[3],   mgRHc3 +116, margeHautRO +24);
  text(objTxtGUIthree[4],  mgRHc3 +116, margeHautRO +34);
  text(objTxtGUIthree[5],  mgRHc3 +116, margeHautRO +44);
  text(objTxtGUIthree[6],  mgRHc3 +116, margeHautRO +54);   
  text(objTxtGUIthree[7],  mgRHc3 +116, margeHautRO +64);  
  text(objTxtGUIthree[8],  mgRHc3 +116, margeHautRO +74);
  
  //TEXTURE
  textFont(FuturaStencil_20,20);  textAlign(RIGHT);
  fill(blanc, 120) ;
  pushMatrix () ; rotate (-PI/2) ;  text("TEXTURE", -margeHautRT +70, 18); popMatrix() ;
  fill (typoCourante) ;
  textFont(texteInterface);  textAlign(LEFT);
  
  //column 1
  text(textureTxtGUIone[1], mgRHc1 +116, margeHautRT +4);
  text(textureTxtGUIone[2], mgRHc1 +116, margeHautRT +14);
  text(textureTxtGUIone[3], mgRHc1 +116, margeHautRT +24);
  text(textureTxtGUIone[4], mgRHc1 +116, margeHautRT +34);
  text(textureTxtGUIone[5], mgRHc1 +116, margeHautRT +44);
  text(textureTxtGUIone[6], mgRHc1 +116, margeHautRT +54);
  text(textureTxtGUIone[7], mgRHc1 +116, margeHautRT +64);
  text(textureTxtGUIone[8], mgRHc1 +116, margeHautRT +74);
  
  //column 2
  text(textureTxtGUItwo[1], mgRHc2 +116, margeHautRT +4);
  text(textureTxtGUItwo[2], mgRHc2 +116, margeHautRT +14);    
  text(textureTxtGUItwo[3], mgRHc2 +116, margeHautRT +24);
  text(textureTxtGUItwo[4], mgRHc2 +116, margeHautRT +34);
  text(textureTxtGUItwo[5], mgRHc2 +116, margeHautRT +44);
  text(textureTxtGUItwo[6], mgRHc2 +116, margeHautRT +54); 
  text(textureTxtGUItwo[7], mgRHc2 +116, margeHautRT +64);  
  int degreT ;
  float dT = map (valueSlider[128],  0, 100, 0, 360 ) ;
  degreT = round(dT) ; 
  text(degreT + textureTxtGUItwo[8],    mgRHc2 +116,  margeHautRT +74);
  
  //column 3
  text(textureTxtGUIthree[1], mgRHc3 +116, margeHautRT +4);
  text(textureTxtGUIthree[6], mgRHc3 +116, margeHautRT +54);
  text(textureTxtGUIthree[8], mgRHc3 +116, margeHautRT +74);


  //TYPOGRAPHY
  textFont(FuturaStencil_20,20); textAlign(RIGHT);
  fill(blanc, 120) ;
  pushMatrix () ; rotate (-PI/2) ; text("TYPOGRAPHIE", -margeHautRTY +70, 18); popMatrix() ;
  fill (typoCourante) ;
  textFont(texteInterface); textAlign(LEFT);
  
  //column 1
  text(typoTxtGUIone[1], mgRHc1 +116,  margeHautRTY +3);
  text(typoTxtGUIone[2], mgRHc1 +116,  margeHautRTY +13) ;    
  text(typoTxtGUIone[3], mgRHc1 +116,  margeHautRTY +23) ;   
  text(typoTxtGUIone[4], mgRHc1 +116,  margeHautRTY +33) ;
  text(typoTxtGUIone[1], mgRHc1 +116,  margeHautRTY +43);
  text(typoTxtGUIone[2], mgRHc1 +116,  margeHautRTY +53) ;    
  text(typoTxtGUIone[3], mgRHc1 +116,  margeHautRTY +63) ;   
  text(typoTxtGUIone[4], mgRHc1 +116,  margeHautRTY +73) ;   
  
  //column 2
  text(typoTxtGUItwo[1], mgRHc2 +116,  margeHautRTY +3) ;
  text(typoTxtGUItwo[2], mgRHc2 +116,  margeHautRTY +13) ;
  text(typoTxtGUItwo[3], mgRHc2 +116,  margeHautRTY +23) ;
  text(typoTxtGUItwo[4], mgRHc2 +116,  margeHautRTY +33) ;
  text(typoTxtGUItwo[5], mgRHc2 +116,  margeHautRTY +43) ;
  text(typoTxtGUItwo[6], mgRHc2 +116,  margeHautRTY +53) ;
  text(typoTxtGUItwo[7], mgRHc2 +116,  margeHautRTY +63) ;
  int degreTY ; 
  float dTY = map (valueSlider[228], 0, 100, 0, 360 ) ; 
  degreTY = round(dTY) ; 
  text(degreTY + typoTxtGUItwo[8], mgRHc2 +116,  margeHautRTY +73);
  
  //column 3
  text(typoTxtGUIthree[1], mgRHc3 +116,  margeHautRTY +3) ;
  text(typoTxtGUIthree[2], mgRHc3 +116,  margeHautRTY +13) ;
  text(typoTxtGUIthree[3], mgRHc3 +116,  margeHautRTY +23) ;
  text(typoTxtGUIthree[4], mgRHc3 +116,  margeHautRTY +33) ;
  text(typoTxtGUIthree[5], mgRHc3 +116,  margeHautRTY +43) ;
  text(typoTxtGUIthree[6], mgRHc3 +116,  margeHautRTY +53) ;
  text(typoTxtGUIthree[7], mgRHc3 +116,  margeHautRTY +63) ;
  text(typoTxtGUIthree[8], mgRHc3 +116,  margeHautRTY +73) ;

}
//END TEXT



//MOLETTE
public void moletteDraw () {
  //display and update the molette
  for ( int i = 0 ; i < numSlider ; i++) {
    if ( (i>0 && i<7 ) || ( i>10 && i<19) || ( i>20 && i<29) || ( i>30 && i<39) || ( i>110 && i<119) || ( i>120 && i<129) || ( i>130 && i<139) || ( i>210 && i<219) || ( i>220 && i<229) || ( i>230 && i<239) ) { 
      //give which button is active and check is this button have a same IDmidi that Object
      if ( numMidi == RH[i].IDmidi() ) RH[i].updateMidi(valMidi) ;
    //  println(i + " / " + RH[i].IDmidi()) ;
      //to add an IDmidi from the internal setting to object
      if (selectMidi && RH[i].lock() ) { RH[i].selectIDmidi(numMidi) ; }
      //to add an ID midi from the save
      if(chargement) { 
        RH[i].selectIDmidi(PApplet.parseInt(loadR [i + numSlider]) ) ;
      }
    //  if ( numMidi == null ) println ("pas d'activit\u00e9" ) ;
      RH[i].update(mouseX, loadR[i]);    
      RH[i].display();
      
      //save midi setting
      /*
      if (saveMidi) { 
        newSettingMidi[i] = "" + RH[i].IDmidi() ; 
      }
      saveMidi = false ;
      */
      
      //r\u00e9cup\u00e9ration des donn\u00e9es de la r\u00e9glette couleur fond  
      valueSlider[i] = constrain(map(RH[i].getPos(), 0, 104, 0,100),0,100)  ;     
      //dataValeurRH[i] = round (valueSlider[i]) ;  
      saveR [i] = PApplet.parseByte(valueSlider[i] ) ;
      saveR [i + numSlider] = PApplet.parseByte(RH[i].IDmidi() ) ;
    }
  }
  chargement = false ; 
}
//END MOLETTE


//SLIDER
//DRAW
public void sliderDraw()
{
  //Background slider
  if (mouseX > (margeGaucheRH[1] ) && mouseX < ( margeGaucheRH[1] + longueurRH[1]) 
  && mouseY > ( margeHautRH[1] - 5) && mouseY < margeHautRH[1] + 30 ) {
    fondRegletteCouleur    ( margeGaucheRH[1], margeHautRH[1], hauteurRH[1], longueurRH[1]) ;
    fondRegletteSaturation ( margeGaucheRH[2], margeHautRH[2], hauteurRH[2], longueurRH[1], valueSlider[1], valueSlider[2], valueSlider[3] ) ;
    fondRegletteDensite    ( margeGaucheRH[3], margeHautRH[3], hauteurRH[3], longueurRH[1], valueSlider[1], valueSlider[2], valueSlider[3] ) ;
  } else {
    fondReglette    ( margeGaucheRH[1], margeHautRH[1], hauteurRH[1], longueurRH[1], blancGrisClair) ;
    fondReglette    ( margeGaucheRH[2], margeHautRH[2], hauteurRH[2], longueurRH[2], blancGrisClair ) ;
    fondReglette    ( margeGaucheRH[3], margeHautRH[3], hauteurRH[3], longueurRH[3], blancGrisClair ) ;
  }
  
  //simple slider
  // Main color
  if ( mouseX > (margeGaucheRH[11] ) && mouseX < ( margeGaucheRH[11] + longueurRH[11]) 
       && mouseY > ( margeHautRH[11] - 5) && mouseY < margeHautRH[11] +30 ) 
  {
    fondRegletteCouleur     ( margeGaucheRH[11], margeHautRH[11], hauteurRH[11], longueurRH[11]) ; 
    fondRegletteSaturation  ( margeGaucheRH[12], margeHautRH[12], hauteurRH[12], longueurRH[11], valueSlider[11], valueSlider[12], valueSlider[13] ) ;
    fondRegletteDensite     ( margeGaucheRH[13], margeHautRH[13], hauteurRH[13], longueurRH[11], valueSlider[11], valueSlider[12], valueSlider[13] ) ;
  } else {
    fondReglette    ( margeGaucheRH[11], margeHautRH[11], hauteurRH[11], longueurRH[11], blanc) ;
    fondReglette    ( margeGaucheRH[12], margeHautRH[12], hauteurRH[12], longueurRH[12], blanc ) ;
    fondReglette    ( margeGaucheRH[13], margeHautRH[13], hauteurRH[13], longueurRH[13], blanc ) ;
  }
  fondReglette    ( margeGaucheRH[14], margeHautRH[14], hauteurRH[14], longueurRH[14], blanc ) ;
  
  //outline color
  if ( mouseX > (margeGaucheRH[15] ) && mouseX < ( margeGaucheRH[15] + longueurRH[15]) 
       && mouseY > ( margeHautRH[15] - 5) && mouseY < margeHautRH[15] +30 ) 
  {
    fondRegletteCouleur     ( margeGaucheRH[15], margeHautRH[15], hauteurRH[15], longueurRH[15]) ; 
    fondRegletteSaturation  ( margeGaucheRH[16], margeHautRH[16], hauteurRH[16], longueurRH[15], valueSlider[15], valueSlider[16], valueSlider[17] ) ;
    fondRegletteDensite     ( margeGaucheRH[17], margeHautRH[17], hauteurRH[17], longueurRH[15], valueSlider[15], valueSlider[16], valueSlider[17] ) ;
  } else {
    fondReglette    ( margeGaucheRH[15], margeHautRH[15], hauteurRH[15], longueurRH[15], blancGrisClair) ;
    fondReglette    ( margeGaucheRH[16], margeHautRH[16], hauteurRH[16], longueurRH[16], blancGrisClair ) ;
    fondReglette    ( margeGaucheRH[17], margeHautRH[17], hauteurRH[17], longueurRH[17], blancGrisClair) ;
  }
  fondReglette    ( margeGaucheRH[18], margeHautRH[18], hauteurRH[18], longueurRH[18], blancGrisClair ) ;
 
  
  // texture slider
  if ( mouseX > (margeGaucheRH[111] ) && mouseX < ( margeGaucheRH[111] + longueurRH[111]) 
       && mouseY > ( margeHautRH[111] - 5) && mouseY < margeHautRH[111] +30 ) 
  {
    fondRegletteCouleur     ( margeGaucheRH[111], margeHautRH[111], hauteurRH[111], longueurRH[111]) ; 
    fondRegletteSaturation  ( margeGaucheRH[112], margeHautRH[112], hauteurRH[112], longueurRH[111], valueSlider[111], valueSlider[112], valueSlider[113] ) ;
    fondRegletteDensite     ( margeGaucheRH[113], margeHautRH[113], hauteurRH[113], longueurRH[111], valueSlider[111], valueSlider[112], valueSlider[113] ) ;
  } else {
    fondReglette    ( margeGaucheRH[111], margeHautRH[111], hauteurRH[111], longueurRH[111], blanc) ;
    fondReglette    ( margeGaucheRH[112], margeHautRH[112], hauteurRH[112], longueurRH[112], blanc ) ;
    fondReglette    ( margeGaucheRH[113], margeHautRH[113], hauteurRH[113], longueurRH[113], blanc ) ;
  }
  fondReglette    ( margeGaucheRH[114], margeHautRH[114], hauteurRH[114], longueurRH[114], blanc ) ;
  
  //outline color
  if ( mouseX > (margeGaucheRH[115] ) && mouseX < ( margeGaucheRH[115] + longueurRH[115]) 
       && mouseY > ( margeHautRH[115] - 5) && mouseY < margeHautRH[115] +30 ) 
  {
    fondRegletteCouleur     ( margeGaucheRH[115], margeHautRH[115], hauteurRH[115], longueurRH[115]) ; 
    fondRegletteSaturation  ( margeGaucheRH[116], margeHautRH[116], hauteurRH[116], longueurRH[115], valueSlider[115], valueSlider[116], valueSlider[117] ) ;
    fondRegletteDensite     ( margeGaucheRH[117], margeHautRH[117], hauteurRH[117], longueurRH[115], valueSlider[115], valueSlider[116], valueSlider[117] ) ;
  } else {
    fondReglette    ( margeGaucheRH[115], margeHautRH[115], hauteurRH[115], longueurRH[115], blancGrisClair) ;
    fondReglette    ( margeGaucheRH[116], margeHautRH[116], hauteurRH[116], longueurRH[116], blancGrisClair ) ;
    fondReglette    ( margeGaucheRH[117], margeHautRH[117], hauteurRH[117], longueurRH[117], blancGrisClair) ;
  }
  fondReglette    ( margeGaucheRH[118], margeHautRH[118], hauteurRH[118], longueurRH[118], blancGrisClair ) ;
  
  
  
  //TYPOGRAPHY slider color
  if (mouseX > (margeGaucheRH[211] ) && mouseX < ( margeGaucheRH[211] + longueurRH[211]) && mouseY > ( margeHautRH[211] - 5) && mouseY < margeHautRH[211] + 30 ) {
    fondRegletteCouleur    ( margeGaucheRH[211], margeHautRH[211], hauteurRH[211], longueurRH[211]) ;
    fondRegletteSaturation ( margeGaucheRH[212], margeHautRH[212], hauteurRH[212], longueurRH[211], valueSlider[211], valueSlider[212], valueSlider[213] ) ;
    fondRegletteDensite    ( margeGaucheRH[213], margeHautRH[213], hauteurRH[213], longueurRH[211], valueSlider[211], valueSlider[212], valueSlider[213] ) ;
  } else {
    fondReglette    ( margeGaucheRH[211], margeHautRH[211], hauteurRH[211], longueurRH[211], blanc) ;
    fondReglette    ( margeGaucheRH[212], margeHautRH[212], hauteurRH[212], longueurRH[212], blanc) ;
    fondReglette    ( margeGaucheRH[213], margeHautRH[213], hauteurRH[213], longueurRH[213], blanc ) ;
  }
  fondReglette    ( margeGaucheRH[214], margeHautRH[214], hauteurRH[214], longueurRH[214], blanc ) ;
  //outline color
  if ( mouseX > (margeGaucheRH[215] ) && mouseX < ( margeGaucheRH[215] + longueurRH[215]) && mouseY > ( margeHautRH[215] - 5) && mouseY < margeHautRH[215] +30 ) {
    fondRegletteCouleur     ( margeGaucheRH[215], margeHautRH[215], hauteurRH[215], longueurRH[215]) ; 
    fondRegletteSaturation  ( margeGaucheRH[216], margeHautRH[216], hauteurRH[216], longueurRH[215], valueSlider[215], valueSlider[216], valueSlider[217] ) ;
    fondRegletteDensite     ( margeGaucheRH[217], margeHautRH[217], hauteurRH[217], longueurRH[215], valueSlider[215], valueSlider[216], valueSlider[217] ) ;
  } else {
    fondReglette    ( margeGaucheRH[215], margeHautRH[215], hauteurRH[215], longueurRH[215], blancGrisClair) ;
    fondReglette    ( margeGaucheRH[216], margeHautRH[216], hauteurRH[216], longueurRH[216], blancGrisClair ) ;
    fondReglette    ( margeGaucheRH[217], margeHautRH[217], hauteurRH[217], longueurRH[217], blancGrisClair) ;
  }
  fondReglette    ( margeGaucheRH[218], margeHautRH[218], hauteurRH[218], longueurRH[218], blancGrisClair ) ;
  //end TYPO
}



/////////////////////
public void buttonDisplayDraw ()
{
  textFont(texteInterface) ;
  
  Bbeat.boutonTexte("BEAT",    margeGaucheBeat,  margeHautBeat  +6) ;
  Bkick.boutonTexte("KICK",    margeGaucheKick,  margeHautKick  +6) ;
  Bsnare.boutonTexte("SNARE",  margeGaucheSnare, margeHautSnare +6) ;
  Bhat.boutonTexte("HAT",      margeGaucheHat,   margeHautHat   +6) ;
  
  //METEO
  buttonMeteo.boutonMeteo () ;
  //MIDI 
  PVector posTxtMidi = new PVector ( 15, 10 ) ;
  BOmidi.boutonCarreEcran  ("MIDI", posTxtMidi) ;
  //RIDEAU
  PVector posTxtRideau = new PVector ( 10, 10 ) ; 
  BOrideau.boutonCarreEcran  (genTxtGUI[8], posTxtRideau) ;
  
  
  //DISPLAY INTERFACE SIMPLE
  for( int i = 1 ; i <= numObjectSimple ; i++ ) {
    BOf[i*10 +1].boutonVignette(vignette_OFF_in_simple, vignette_OFF_out_simple, vignette_ON_in_simple, vignette_ON_out_simple, i) ; 
    BOf[i*10 +2].boutonCarre () ; BOf[i*10 +3].boutonSonPetit () ; BOf[i*10 +4].boutonAction () ;
    //display or not the meteo weather button
    if(objectSimpleWeather[i -1] )  BOf[i*10 +5].boutonMeteo() ;
    PVector pos = new PVector (margeGaucheBOf[i*10 +2], margeHautBOf[i*10 +1] +10) ;
    PVector size = new PVector (20, 30) ;
    rolloverInfoVignette(pos, size, i, 1) ;
  }
  //DISPLAY INTERFACE TEXTURE
  for( int i = 1 ; i <= numObjectTexture ; i++ ) {
    BTf[i*10 +1].boutonVignette(vignette_OFF_in_texture, vignette_OFF_out_texture, vignette_ON_in_texture, vignette_ON_out_texture, i) ; 
    BTf[i*10 +2].boutonCarre () ; BTf[i*10 +3].boutonSonPetit () ; BTf[i*10 +4].boutonAction () ;     
    //display or not the meteo weatehr button
    if(objectTextureWeather[i -1] )  BTf[i*10 +5].boutonMeteo() ;
    PVector pos = new PVector (margeGaucheBTf[i*10 +2], margeHautBTf[i*10 +1] +10) ;
    PVector size = new PVector (20, 30) ;
    rolloverInfoVignette(pos, size, i, 2) ;
  }
  
  //DISPLAY INTERFACE TYPOGRAPHY
  for( int i = 1 ; i <= numObjectTypography ; i++ ) {
    BTYf[i*10 +1].boutonVignette(vignette_OFF_in_typography, vignette_OFF_out_typography, vignette_ON_in_typography, vignette_ON_out_typography, i) ; 
    BTYf[i*10 +2].boutonCarre () ; BTYf[i*10 +3].boutonSonPetit () ; BTYf[i*10 +4].boutonAction () ; 
    //display or not the meteo weather button
    if(objectTypographyWeather[i -1] )  BTYf[i*10 +5].boutonMeteo() ;
    PVector pos = new PVector (margeGaucheBTYf[i*10 +2], margeHautBTYf[i*10 +1] +10) ;
    PVector size = new PVector (20, 30) ;
    rolloverInfoVignette(pos, size, i, 3) ;
  }
 
}




public void buttonCheckDraw() {
  //R\u00c9CUP\u00c9RATION DES VALEURS
  //meteo
  EtatButtonMeteo = buttonMeteo.getEtatBoutonCarre() ;
  //SON
  EtatBbeat = Bbeat.getEtatBoutonCarre() ;
  EtatBkick = Bkick.getEtatBoutonCarre() ;
  EtatBsnare = Bsnare.getEtatBoutonCarre() ;
  EtatBhat = Bhat.getEtatBoutonCarre() ;
  //Check position of button
  EtatBOmidi = BOmidi.getEtatBoutonCarre() ;
  EtatBOrideau = BOrideau.getEtatBoutonCarre() ;


  //Statement button, if are OFF or ON
  for( int i = 11 ; i < 100 ; i++) {
    //catch the statement of button object
    EtatBOf[i] = BOf[i].getEtatBoutonCarre() ;
    //catch the statement of button texture
    EtatBTf[i] = BTf[i].getEtatBoutonCarre() ;
    //catch the statement of button typography
    EtatBTYf[i] = BTYf[i].getEtatBoutonCarre() ;
  }
  ///////////
}



//ANNEXE VOID
//ROLLOVER vignette
//show image
public void rolloverVignette ( int posX, int posY , int hauteur, int largeur, int numero, int posXimage, int posYimage) {
  if (mouseX > posX && mouseX < (largeur + posX ) && mouseY > posY - 10 && mouseY <  (hauteur + posY) -20 ) { 
      image(vignette[numero],posXimage , posYimage ) ;
    }
}

//show info
public void rolloverInfoVignette(PVector pos, PVector size, int IDname, int IDfamily) {
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
public void fondReglette ( int posX, int posY, int hauteur, int largeur, int couleur ) {
  float hx ;
  hx = hauteur ;
  fill ( couleur ) ;
  rect ( posX  , posY - (hx /2.0f )  , largeur , hauteur ) ;
}

//hue
public void fondRegletteCouleur ( int posX, int posY, int hauteur, int largeur ) {
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
public void fondRegletteSaturation ( int posX, int posY, int hauteur, int largeur, float couleur, float s, float d ) {
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
public void fondRegletteDensite ( int posX, int posY, int hauteur, int largeur, float couleur, float s, float d ) {
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

public void dropdownSetup() {
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
  posDropdown[99] = new PVector(405, 28, 0.1f)  ; // x y is pos anz z is marge between the dropdown and the header
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
    
    posDropdown[i] = new PVector(margeGaucheBO -8 + space, margeHautBO +43, 0.1f)  ; // x y is pos anz z is marge between the dropdown and the header
    dropdown[i] = new Dropdown(listDropdown,   posDropdown[i] , sizeDropdownMode, posTextDropdown, colorBG, colorBoxIn, colorBoxOut, colorBoxText, texteInterface, sizeTexteInterface) ;
  }
  //Texture line
  for ( int i = startLoopTexture ; i < endLoopTexture ; i ++ ) {
    int space = ((i - startLoopTexture +1) * 40) - 40 ;
    //Split the dropdown to display in the dropdown
    listDropdown = split(modeListRomanesco[i], "/" ) ;
    //to change the title of the header dropdown
    listDropdown[0] = "M"  ; 
    
    posDropdown[i] = new PVector(margeGaucheBT -8 + space, margeHautBT +43, 0.1f)  ; // x y is pos anz z is marge between the dropdown and the header
    dropdown[i] = new Dropdown(listDropdown,   posDropdown[i] , sizeDropdownMode, posTextDropdown, colorBG, colorBoxIn, colorBoxOut, colorBoxText, texteInterface, sizeTexteInterface) ;
  }
  //Typo line
  for ( int i = startLoopTypo ; i < endLoopTypo ; i ++ ) {
    int space = ((i - startLoopTypo +1) * 40) - 40 ;
    //Split the dropdown to display in the dropdown
    listDropdown = split(modeListRomanesco[i], "/" ) ;
    //to change the title of the header dropdown
    listDropdown[0] = "M"  ; 
    
    posDropdown[i] = new PVector(margeGaucheBTY -8 + space, margeHautBTY +43, 0.1f)  ; // x y is pos anz z is marge between the dropdown and the header
    dropdown[i] = new Dropdown(listDropdown,   posDropdown[i] , sizeDropdownMode, posTextDropdown, colorBG, colorBoxIn, colorBoxOut, colorBoxText, texteInterface, sizeTexteInterface) ;
  }
  

}
//DRAW
public void dropdownDraw() {
  //FONT dropdown
  dropdown[99].dropdownUpdate();
  margeAroundDropdown = sizeDropdownFont.y  ;
  //give the size of menu recalculate with the size of the word inside
  PVector newSizeFont = dropdown[99].sizeDropdownMenu() ;
  totalSizeDropdown = new PVector ( newSizeFont.x + (margeAroundDropdown *1.5f) , sizeDropdownFont.y * (sizeDropdownFont.z +1)  + margeAroundDropdown   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  newPosDropdown = new PVector ( posDropdown[99].x - margeAroundDropdown  , posDropdown[99].y ) ;
  // println( posModeDropdown[i].y) ;
  if ( !insideRect(newPosDropdown, totalSizeDropdown) ) dropdown[99].locked = false;
  //give the value for sending to Sc\u00e8ne and save
  //valueSlider[7] = dropdown[99].getSelection() +1 ;
 // dataValeurRH[7] = int(valueSlider[7]) ;  
  saveR [7] = PApplet.parseByte(dropdown[99].getSelection() +1 ) ;

  
  //MODE dropdown
  //object line
  for ( int i = startLoopObject ; i < endLoopObject ; i ++ ) {
    String m [] = split(modeListRomanesco[i], "/") ;
    if ( m.length > 1) {
      dropdown[i].dropdownUpdate();
      margeAroundDropdown = sizeDropdownMode.y  ;
      //give the size of menu recalculate with the size of the word inside
      PVector newSizeModeObj = dropdown[i].sizeDropdownMenu() ;
      totalSizeDropdown = new PVector ( newSizeModeObj.x + (margeAroundDropdown *1.5f) , sizeDropdownMode.y * (sizeDropdownMode.z +1)  + margeAroundDropdown   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
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
      totalSizeDropdown = new PVector ( newSizeModeTexture.x + (margeAroundDropdown *1.5f) , sizeDropdownMode.y * (sizeDropdownMode.z +1)  + margeAroundDropdown   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
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
      totalSizeDropdown = new PVector ( newSizeModeTypo.x + (margeAroundDropdown *1.5f) , sizeDropdownMode.y * (sizeDropdownMode.z +1)  + margeAroundDropdown   ) ; // we must add +1 to the size of the dropdown for the title plus the item list
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
public void dropdownMousepressed() {
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
//GLOBAL
int sizeTexteInterface = 14 ;

public PFont 
      //controleur font
      police, texteInterface,
      EmigreEight, FuturaStencil_20,

      
      //sc\u00e8ne Font
      AmericanTypewriter, AmericanTypewriterBold,
      Banco, 
      ContainerRegular, Cinquenta,
      Diesel, 
      DinRegular, DinBold,
      EastBloc,
      FetteFraktur, FuturaStencil,
      Juanita, JuanitaOutline,
      Komikahuna,
      Mesquite,
      Minion, MinionBold,
      NanumBrush, 
      Rosewood,
      TheHardwayRMX,
      TokyoOne, TokyoOneSolid ;
      
      
//SETUP
public void fontSetup() {
  //controleur Font
  EmigreEight = loadFont ("typo/EmigreEight-14.vlw") ;
  FuturaStencil_20 = loadFont("typo/FuturaStencilICG-20.vlw");
  //Sc\u00e8ne Font  
  AmericanTypewriter=loadFont       ("typo/AmericanTypewriter-96.vlw");
  AmericanTypewriterBold=loadFont   ("typo/AmericanTypewriter-Bold-96.vlw");
  Banco=loadFont                    ("typo/BancoITCStd-Heavy-96.vlw");
  Cinquenta=loadFont                ("typo/CinquentaMilMeticais-96.vlw");
  ContainerRegular=loadFont         ("typo/Container-Regular-96.vlw");
  Diesel=loadFont                   ("typo/Diesel-96.vlw");
  DinRegular=loadFont               ("typo/DIN-Regular-96.vlw");

  DinBold=loadFont                  ("typo/DIN-Bold-96.vlw");
  EastBloc=loadFont                 ("typo/EastBlocICGClosed-96.vlw");
  FuturaStencil=loadFont            ("typo/FuturaStencilICG-96.vlw");
  FetteFraktur=loadFont             ("typo/FetteFraktur-96.vlw");
  JuanitaOutline=loadFont           ("typo/JuanitaDecoITCStd-96.vlw");
  Komikahuna=loadFont               ("typo/Komikahuna-96.vlw");
  Mesquite=loadFont                ("typo/MesquiteStd-96.vlw");
  Minion=loadFont                   ("typo/MinionPro-Regular-96.vlw");
  MinionBold=loadFont               ("typo/MinionPro-Bold-96.vlw");
  NanumBrush=loadFont              ("typo/NanumBrush-96.vlw");
  Rosewood=loadFont                ("typo/RosewoodStd-Regular-96.vlw");
  TheHardwayRMX=loadFont            ("typo/3theHardwayRMX-96.vlw");
  TokyoOne=loadFont                ("typo/Tokyo-One-96.vlw");
  
  //Typo for the interface
  texteInterface = EmigreEight ;
  


}
//GLOBAL



OscP5 osc;
NetAddress targetPreScene ;
// local
String IPadress = ("127.0.0.1") ;
// Message to pr\u00e9Sc\u00e8ne
String toPreScene [] = new String [8] ;



public void sendOSCsetup() {
  
 osc = new OscP5(this, 10000);
 //To Pr\u00e9sc\u00e8ne
 targetPreScene = new NetAddress(IPadress,10000);

  
}

public void sendOSCdraw()
{
  OscMessage RomanescoControleur = new OscMessage("ROMANESCO contr\u00f4leur");
  
  //int value join in one String 
  translateDataToSend() ;
  
  //BUTTON to String
  toPreScene[0] = joinIntToString(valueButtonGlobal) ; 
  toPreScene[1] = joinIntToString(valueButtonObj) ;
  toPreScene[2] = joinIntToString(valueButtonTex) ;
  toPreScene[3] = joinIntToString(valueButtonTypo) ;
  
  //SLIDER to String
  int[] dataIntGlobal = new int[10] ;
  for ( int i = 1   ; i < 11 ; i++) { dataIntGlobal[i-1] = floor(valueSlider[i]) ; }
  toPreScene[4] = joinIntToString(dataIntGlobal) ;
  //float value slider obj
  int[] dataIntObj = new int[30] ;
  for ( int i = 11   ; i < 41 ; i++) { dataIntObj[i-11] = floor(valueSlider[i]) ; }
  toPreScene[5] = joinIntToString(dataIntObj);
  //float value slider tex
  int[] dataIntTex = new int[30] ;
  for ( int i = 111   ; i < 141 ; i++) { dataIntTex[i-111] = floor(valueSlider[i]) ; }
  toPreScene[6] = joinIntToString(dataIntTex) ;
  //float value slider typo
  int[] dataIntTypo = new int[30] ;
  for ( int i = 211   ; i < 241 ; i++) { dataIntTypo[i-211] = floor(valueSlider[i]) ; }
  toPreScene[7] = joinIntToString(dataIntTypo) ;
  
  //add to OSC
  for ( int i = 0 ; i < toPreScene.length ; i++) {
    RomanescoControleur.add(toPreScene[i]);
  }
  
  //send
  osc.send(RomanescoControleur, targetPreScene ); 
}



  
  
  
public void translateDataToSend()
{
  //BUTTON GLOBAL
  //sound
  valueButtonGlobal[1] = EtatBbeat ;
  valueButtonGlobal[2] = EtatBkick ;
  valueButtonGlobal[3] = EtatBsnare ;
  valueButtonGlobal[4] = EtatBhat ;
  //meteo
  valueButtonGlobal[5] = EtatButtonMeteo ;
  //dropdown typo
  valueButtonGlobal[7] = dropdown[99].getSelection() +1 ; ;
  //rideau
  valueButtonGlobal[10] = EtatBOrideau ;
  
  //BUTTON OBJ
  int numObj = 9 ;
  for ( int i = 0 ; i < numObj ; i ++) {
    valueButtonObj[i *10 +1] = EtatBOf[i *10 +11] ;
    valueButtonObj[i *10 +2] = EtatBOf[i *10 +12] ;
    valueButtonObj[i *10 +3] = EtatBOf[i *10 +13] ;
    valueButtonObj[i *10 +4] = EtatBOf[i *10 +14] ;
    valueButtonObj[i *10 +5] = EtatBOf[i *10 +15] ;
    
    valueButtonObj[i *10 +9] = dropdown[i +1].getSelection() ;
  }
  //BUTTON TEX
  int numTex = 7 ;
  for ( int i = 0 ; i < numTex ; i ++) {
    valueButtonTex[i *10 +1] = EtatBTf[i *10 +11] ;
    valueButtonTex[i *10 +2] = EtatBTf[i *10 +12] ;
    valueButtonTex[i *10 +3] = EtatBTf[i *10 +13] ;
    valueButtonTex[i *10 +4] = EtatBTf[i *10 +14] ;
    valueButtonTex[i *10 +5] = EtatBTf[i *10 +15] ;
    valueButtonTex[i *10 +9] = dropdown[i +21].getSelection() ;
  }
  //BUTTON TYPO
  int numTypo = 5 ;
  for ( int i = 0 ; i < numTypo ; i ++) {
    valueButtonTypo[i *10 +1] = EtatBTYf[i *10 +11] ;
    valueButtonTypo[i *10 +2] = EtatBTYf[i *10 +12] ;
    valueButtonTypo[i *10 +3] = EtatBTYf[i *10 +13] ;
    valueButtonTypo[i *10 +4] = EtatBTYf[i *10 +14] ;
    valueButtonTypo[i *10 +5] = EtatBTYf[i *10 +15] ;
    
    valueButtonTypo[i *10 +9] = dropdown[i +41].getSelection() ;
  }

}
  





  

//LOAD PICTURE VIGNETTE

int numVignette ;
public void importPicButtonSetup()
{
  //load button vignette GUI general
  for(int j=0 ;  j<bouton.length ; j++ ) bouton[j] = loadImage ("bouton/bouton"+j+".png") ;
  
  //load simple vignette
  numVignette = numObjectSimple +1  ;
  vignette_OFF_in_simple = new PImage[numVignette] ;
  vignette_OFF_out_simple = new PImage[numVignette] ;
  vignette_ON_in_simple = new PImage[numVignette] ;
  vignette_ON_out_simple = new PImage[numVignette] ;

  for(int i=0 ;  i<numVignette ; i++ )  {
    vignette_OFF_in_simple[i] = loadImage ("vignette_simple/vignette_OFF_in_simple_"+i+".png") ;
    vignette_OFF_out_simple[i] = loadImage ("vignette_simple/vignette_OFF_out_simple_"+i+".png") ;
    vignette_ON_in_simple[i] = loadImage ("vignette_simple/vignette_ON_in_simple_"+i+".png") ;
    vignette_ON_out_simple[i] = loadImage ("vignette_simple/vignette_ON_out_simple_"+i+".png") ;
  }
  //load texture vignette
  numVignette = numObjectTexture +1  ;
  vignette_OFF_in_texture = new PImage[numVignette] ;
  vignette_OFF_out_texture = new PImage[numVignette] ;
  vignette_ON_in_texture = new PImage[numVignette] ;
  vignette_ON_out_texture = new PImage[numVignette] ;

  for(int i=0 ;  i<numVignette ; i++ )  {
    vignette_OFF_in_texture[i] = loadImage ("vignette_texture/vignette_OFF_in_texture_"+i+".png") ;
    vignette_OFF_out_texture[i] = loadImage ("vignette_texture/vignette_OFF_out_texture_"+i+".png") ;
    vignette_ON_in_texture[i] = loadImage ("vignette_texture/vignette_ON_in_texture_"+i+".png") ;
    vignette_ON_out_texture[i] = loadImage ("vignette_texture/vignette_ON_out_texture_"+i+".png") ;
  }
  //load typography vignette
  numVignette = numObjectTypography +1  ;
  vignette_OFF_in_typography = new PImage[numVignette] ;
  vignette_OFF_out_typography = new PImage[numVignette] ;
  vignette_ON_in_typography = new PImage[numVignette] ;
  vignette_ON_out_typography = new PImage[numVignette] ;

  for(int i=0 ;  i<numVignette ; i++ )  {
    vignette_OFF_in_typography[i] = loadImage ("vignette_typography/vignette_OFF_in_typography_"+i+".png") ;
    vignette_OFF_out_typography[i] = loadImage ("vignette_typography/vignette_OFF_out_typography_"+i+".png") ;
    vignette_ON_in_typography[i] = loadImage ("vignette_typography/vignette_ON_in_typography_"+i+".png") ;
    vignette_ON_out_typography[i] = loadImage ("vignette_typography/vignette_ON_out_typography_"+i+".png") ;
  }
}




//SAVE SLIDER SETTING
//GLOBALE
byte saveR [] = new byte [2*numSlider]; // byte sur cette -128 \u00e0 127 soit 256 bytes
byte loadR []  = new byte [2*numSlider] ;
//END GLOBAL

//SETUP
public void loadSetup()
{
  //////////// ATTENTION ////////////////
  // put the folder "Sauvegarde" in the folder "data", if you don't do that, it is not export when you make your application.
  // loadR = loadBytes("Sauvegarde"+java.io.File.separator+"Reglage.dat");
  loadR = loadBytes("setting/BasicSetting.dat");
  
  //load data object
  objectTableSetup() ;
  //load text interface 
  // 0 is French
  // 1 is english
  textGUI() ;
}
//END SETUP



//DRAW
public void OpenCloseSave()
{
  //raccourcit clavier, 
  ////////  propl\u00e8me : apr\u00e8s un CTRL + "touche", il n'y a plus besoin du CTRL pour faire fonctionner le tout....
  clavier[keyCode] = true;
  if(checkClavier(CONTROL ) && checkClavier(KeyEvent.VK_S) ) { 
    selectOutput("Sauvegarde R\u00e9glette", "sauvegardeReglette");
    println("CTRL+S");
    clavier[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
  if(checkClavier(CONTROL ) && checkClavier(KeyEvent.VK_O) ) { 
    selectInput("Chargement R\u00e9glette", "chargementReglette"); // ("display info in the window" , "name of the void calling" )
    println("CTRL+O");
    clavier[keyCode] = false;   // 
  }
}


//////
public void sauvegardeReglette(File selection) {
  // opens file chooser
  String sauvegardeCheminReglette = selection.getAbsolutePath() ;
  
  if (selection != null) {
    if (!sauvegardeCheminReglette.endsWith(".dat")) sauvegardeCheminReglette += ".dat";
    saveBytes(sauvegardeCheminReglette, saveR);
  } else {
    println("Aucune sauvegarde") ;
  }
}


//////
public void chargementReglette(File selection) {
  // opens file chooser
  String chargementCheminReglette = selection.getAbsolutePath();
  
  if (selection != null) {
    chargement = true ;
    loadR = loadBytes(chargementCheminReglette);
  } else {
    chargement = false ;
  }
}


//LOAD INFO OBJECT
Table objectList;
int numObjectSimple, numObjectTexture, numObjectTypography ;
int [] objectSimpleID, objectTextureID, objectTypographyID ;
String [] objectSimpleName, objectTextureName, objectTypographyName ;
String [] objectSimpleAuthor, objectTextureAuthor, objectTypographyAuthor ;
boolean [] objectSimpleWeather, objectTextureWeather, objectTypographyWeather ;
boolean [] objectSimpleClassic, objectTextureClassic, objectTypographyClassic ;
boolean [] objectSimpleP2D, objectTextureP2D, objectTypographyP2D ;
boolean [] objectSimpleP3D, objectTextureP3D, objectTypographyP3D ;


public void objectTableSetup()
{
  
    objectList = loadTable("objectList.csv", "header") ;
  /*
  println(objectList.getRowCount() + " total rows in table"); 
  println(objectList.getColumnCount() + " total columns in table");
  */
  
  //find the quantity of object in each family
  for (TableRow row : objectList.rows()) {
  //  int objectID = row.getInt("ID");
    String objectFamily = row.getString("family");
  //  String objectName = row.getString("name");
 //   String objectAuthor = row.getString("author");
  //  String objectWeather = row.getString("weather") ;
    if (objectFamily.equals("simple")) numObjectSimple += 1 ;
    if (objectFamily.equals("texture")) numObjectTexture += 1 ;
    if (objectFamily.equals("typography")) numObjectTypography += 1 ;
    //  println(objectID + ": " + objectName + " by " + objectAuthor ) ;
  }
  
  //generate the array var for each component 
  //Simple object
  objectSimpleID  = new int[numObjectSimple] ;
  objectSimpleName = new String[numObjectSimple] ;
  objectSimpleAuthor = new String[numObjectSimple] ;
  //meteo button
  objectSimpleWeather = new boolean[numObjectSimple] ;
  //render
  objectSimpleClassic = new boolean[numObjectSimple] ;
  objectSimpleP2D = new boolean[numObjectSimple] ;
  objectSimpleP3D = new boolean[numObjectSimple] ;
  
  //Texture object
  objectTextureID = new int[numObjectTexture] ;
  objectTextureName = new String[numObjectTexture] ;
  objectTextureAuthor = new String[numObjectTexture] ;
  //meteo button
  objectTextureWeather = new boolean[numObjectSimple] ;
  //render
  objectTextureClassic = new boolean[numObjectSimple] ;
  objectTextureP2D = new boolean[numObjectSimple] ;
  objectTextureP3D = new boolean[numObjectSimple] ;
  
  //Typography object
  objectTypographyID = new int[numObjectTypography] ;
  objectTypographyName = new String[numObjectTypography] ;
  objectTypographyAuthor = new String[numObjectTypography] ;
  //meteo button
  objectTypographyWeather = new boolean[numObjectSimple] ;
  //render
  objectTypographyClassic = new boolean[numObjectSimple] ;
  objectTypographyP2D = new boolean[numObjectSimple] ;
  objectTypographyP3D = new boolean[numObjectSimple] ;
  
  //reInit the counter
  numObjectSimple = numObjectTexture = numObjectTypography = 0 ; 
  //write the name object
  for (TableRow row : objectList.rows()) {
    int objectID = row.getInt("ID");
    String objectFamily = row.getString("family");
    String objectName = row.getString("name");
    String objectAuthor = row.getString("author");
    //weather (meteo) button
    String objectWeather = row.getString("weather") ;
    
    //check by familly
    if (objectFamily.equals("simple")) {
      objectSimpleID[numObjectSimple] = objectID ;
      objectSimpleName[numObjectSimple] = objectName ;
      objectSimpleAuthor[numObjectSimple] = objectAuthor ;
      if (objectWeather.equals("true") ) objectSimpleWeather[numObjectSimple] = true ; else objectSimpleWeather[numObjectSimple] = false ;
      numObjectSimple += 1 ;
    }
    if (objectFamily.equals("texture")) 
    {
      objectTextureID[numObjectTexture] = objectID ;
      objectTextureName[numObjectTexture] = objectName ;
      objectTextureAuthor[numObjectTexture] = objectAuthor ;
      if (objectWeather.equals("true") ) objectTextureWeather[numObjectTexture] = true ; else objectTextureWeather[numObjectTexture] = false ;
      numObjectTexture += 1 ;
    }
    if (objectFamily.equals("typography")) 
    {
      objectTypographyID[numObjectTypography] = objectID ;
      objectTypographyName[numObjectTypography] = objectName ;
      objectTypographyAuthor[numObjectTypography] = objectAuthor ;
      if (objectWeather.equals("true") ) objectTypographyWeather[numObjectTypography] = true ; else objectTypographyWeather[numObjectTypography] = false ;
      numObjectTypography += 1 ;
    }
  }
}


//LOAD text Interface
Table textGUI;
int numCol = 9 ;
String[] genTxtGUI = new String[numCol] ;
String[] objTxtGUIone = new String[numCol] ;
String[] objTxtGUItwo = new String[numCol] ;
String[] objTxtGUIthree = new String[numCol] ;
String[] textureTxtGUIone = new String[numCol] ;
String[] textureTxtGUItwo = new String[numCol] ;
String[] textureTxtGUIthree = new String[numCol] ;
String[] typoTxtGUIone = new String[numCol] ;
String[] typoTxtGUItwo = new String[numCol] ;
String[] typoTxtGUIthree = new String[numCol] ;

TableRow [] row = new TableRow[10] ;

public void textGUI() 
{
  String lang[] = loadStrings(sketchPath("") +"preference/language.txt") ;
  String l = join(lang,"") ;
  int language = Integer.parseInt(l);

  
  if( language == 0 ) { 
    textGUI = loadTable("sliderListFR.csv", "header") ;
  } else if (language == 1 ) {
    textGUI = loadTable("sliderListEN.csv", "header") ;
  } else {
    textGUI = loadTable("sliderListEN.csv", "header") ;
  }
    
  for ( int i = 0 ; i < 10 ; i++) {

    row[i] = textGUI.getRow(i) ;
    for ( int j = 1 ; j < numCol ; j++) {
      String numCol = Integer.toString(j) ;
      if ( i == 0 ) genTxtGUI[j] = row[i].getString("Column "+numCol) ;
      if ( i == 1 ) objTxtGUIone[j] = row[i].getString("Column "+numCol) ;
      if ( i == 2 ) objTxtGUItwo[j] = row[i].getString("Column "+numCol) ;
      if ( i == 3 ) objTxtGUIthree[j] = row[i].getString("Column "+numCol) ;
      if ( i == 4 ) textureTxtGUIone[j] = row[i].getString("Column "+numCol) ;
      if ( i == 5 ) textureTxtGUItwo[j] = row[i].getString("Column "+numCol) ;
      if ( i == 6 ) textureTxtGUIthree[j] = row[i].getString("Column "+numCol) ;
      if ( i == 7 ) typoTxtGUIone[j] = row[i].getString("Column "+numCol) ;
      if ( i == 8 ) typoTxtGUItwo[j ] = row[i].getString("Column "+numCol) ;
      if ( i == 9 ) typoTxtGUIthree[j] = row[i].getString("Column "+numCol) ;
    }
  }
}
class Bouton
{
//............................Param\u00e8tre superClasse...............................
  int couleurBouton, couleurONoffCarre, couleurONoffCercle ;
  int mGB, mHB, lB, hB , etatBoutonCercle, etatBoutonCarre ;
  
  boolean dedansBoutonCercle = false ;
  boolean JouerBoutonCercle = false ;
  boolean JouerBoutonCarre = false ;  
  boolean dedansBoutonCarre = false ;
  
  //Constructor
  //simple
  Bouton () {}
  //complexe
  Bouton ( int margeGaucheB, int margeHautB, int longueurB, int hauteurB ) {
    mGB =  margeGaucheB ; mHB = margeHautB ; lB = longueurB ; hB = hauteurB ;
  }
  

  
  
  
  //ROLLOVER
  //rectangle
  float newhB = 1  ;
  public boolean detectionCarre() {
    
    if (hB < 10 ) newhB = hB *1.8f ; 
    else if (hB >= 10 && hB < 20  ) newhB = hB *1.2f ;  
    else if (hB >= 20 ) newhB = hB ;
    
   if ( mouseX > mGB && mouseX < mGB + lB && mouseY > mHB  && mouseY < mHB + newhB ) { 
     return true ; 
   } else { 
     return false ; 
   }
  }
  //ellipse
  public boolean detectionCercle() {
    float disX = mGB -mouseX ; 
    float disY = mHB -mouseY  ; 
    if (sqrt(sq(disX) + sq(disY)) < lB/2 ) return true ; else return false ; 
  } 
  
  
  
  //CLIC
  public void mousePressed () {
    //rect
    if ( detectionCarre() ) {
      dedansBoutonCarre = true ;
      if ( JouerBoutonCarre ) {
        JouerBoutonCarre = false ;
        etatBoutonCarre = 0 ;
      } else {
        JouerBoutonCarre = true ;
        etatBoutonCarre = 1 ; 
      }
    }
    //ellipse
    if ( detectionCercle() ) {
      dedansBoutonCercle = true ;
      if ( JouerBoutonCercle ) {
        JouerBoutonCercle = false ;
        etatBoutonCercle = 0 ;
      } else {
        JouerBoutonCercle = true ;
        etatBoutonCercle = 1 ;
      }
    }
  }
  
  public void mouseReleased () 
  {
    //rect
    if ( detectionCarre() ) {
      dedansBoutonCarre = true ;
      if ( JouerBoutonCarre ) {
        JouerBoutonCarre = false ;
        etatBoutonCarre = 0 ;
      } else {
        JouerBoutonCarre = true ;
        etatBoutonCarre = 1 ; 
      }
    }
    //ellipse
    if ( detectionCercle() ) {
      dedansBoutonCercle = true ;
      if ( JouerBoutonCercle ) {
        JouerBoutonCercle = false ;
        etatBoutonCercle = 0 ;
      } else {
        JouerBoutonCercle = true ;
        etatBoutonCercle = 1 ;
      }
    }
  } 
}


////////
//BUTTON
class Simple extends Bouton
{
  int cBINonBO, cBOUTonBO, cBINoffBO, cBOUToffBO, cBEinBO, cBEoutBO ;
  
  //CONSTRUCTOR
  Simple(int mGB,  int mHB, int lB, int hB) {
    super(mGB, mHB, lB, hB) ;
  }
  
  //
  Simple (  int mGB,  int mHB, int lB, int hB, 
            int BoutonINonBO, int BoutonOUTonBO, int BoutonINoffBO, int BoutonOUToffBO,
            int BoutonEnsembleINBO, int BoutonEnsembleOUTBO)                  
 {
   super(mGB, mHB, lB, hB) ;
   cBINonBO = BoutonINonBO ; cBOUTonBO = BoutonOUTonBO ; cBINoffBO = BoutonINoffBO ; cBOUToffBO = BoutonOUToffBO ;
   cBEinBO = BoutonEnsembleINBO ; cBEoutBO = BoutonEnsembleOUTBO ;
 }
 
 
 
 //VOID
 public void boutonFond () {
   fill(couleurBouton) ;
   rect(mGB, mHB, lB, hB) ;
 }
 
 
 ////////////////
 //BUTTON CLASSIC
 
 ///Bouton carre
 public void boutonCarre () {
   strokeWeight (1) ;
   if ( JouerBoutonCarre ) {
     stroke(vertTresFonce) ;
     if ( detectionCarre() ) { 
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
     stroke(rougeTresFonce) ; 
     if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINoffBO ;
     } else {
       couleurONoffCarre = cBOUToffBO ;
     }
   }
   fill(couleurONoffCarre) ;
   rect(mGB, mHB, lB, hB) ;
   noStroke() ;
 }
 ////////////////////////////////////
 public void boutonCercle () {
   strokeWeight (1) ;
   if ( JouerBoutonCercle ) {
     stroke(vertTresFonce) ;
     if ( detectionCercle() ) {
       dedansBoutonCercle = true ;
       couleurONoffCercle = cBINonBO ;
     } else {
       couleurONoffCercle = cBOUTonBO ;
     }
   } else {
     stroke(rougeTresFonce) ;
     if ( detectionCercle() ) {
       dedansBoutonCercle = true ;
       couleurONoffCercle = cBINoffBO ;
     } else {
       couleurONoffCercle = cBOUToffBO ;
     }
   }
   fill(couleurONoffCercle) ;
   ellipse(mGB, mHB, lB, lB) ;
   noStroke() ;
 }
 
 /*
 /////////////////////////////////////////
 void boutonJouer ()
 {
   smooth() ;
   pushMatrix() ;
   translate ( -lB/2 , -lB/2 ) ;
   
   if ( JouerBoutonCercle ) {
     if ( detectionCercle() ) {
       dedansBoutonCercle = true ;
       couleurONoffCercle = cBINonBO ;
       image(bouton[6],mGB , mHB ) ;
     } else {
       couleurONoffCercle = cBOUTonBO ;
       image(bouton[7],mGB , mHB ) ;
     }
   } else {
       if ( detectionCercle() ) {
       dedansBoutonCercle = true ;
       couleurONoffCercle = cBINoffBO ;
       image(bouton[4],mGB , mHB ) ;
     } else {
       couleurONoffCercle = cBOUToffBO ;
       image(bouton[5],mGB , mHB ) ;
     }
   }
   fill(couleurONoffCercle, 30) ;
   popMatrix() ;
 }
 */
 ///////////////////////////////////////
 /*
 void boutonRetour ()
 {
   smooth() ;
   pushMatrix() ;
   translate ( -lB/2 , -lB/2 ) ;
   
   if ( JouerBoutonCercle ) {
     if ( detectionCercle() ) {
       dedansBoutonCercle = true ;
       couleurONoffCercle = cBINonBO ;
       image(bouton[8],mGB , mHB ) ;
     } else {
       couleurONoffCercle = cBOUTonBO ;
       image(bouton[8],mGB , mHB ) ;
     }
   } else {
       if ( detectionCercle() ) {
       dedansBoutonCercle = true ;
       couleurONoffCercle = cBINoffBO ;
       image(bouton[9],mGB , mHB ) ;
     } else {
       couleurONoffCercle = cBOUToffBO ;
       image(bouton[9],mGB , mHB ) ;
     }
   }
   fill(couleurONoffCercle, 30) ;
   popMatrix() ;
 }
 */
 
 //////////////
 //IMAGE BUTTON
 
 //VIGNETTE Button
 // vignette_OFF_in_simple, vignette_OFF_out_simple, vignette_ON_in_simple, vignette_ON_out_simple
 public void boutonVignette(PImage[] vignette_OFF_in, PImage[] vignette_OFF_out, PImage[] vignette_ON_in, PImage[] vignette_ON_out, int wichVignette) {
   
   if ( JouerBoutonCarre ) {
     if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(vignette_ON_in[wichVignette],mGB , mHB ) ;
     } else {
       image(vignette_ON_out[wichVignette],mGB , mHB ) ;
     }
   } else {
       if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(vignette_OFF_in[wichVignette],mGB , mHB ) ;
     } else {
       image(vignette_OFF_out[wichVignette],mGB , mHB ) ;
     }
   }
 }
 
 
 //SOUND button
 public void boutonSonPetit () {
   if ( JouerBoutonCarre ) {
     if ( detectionCarre() ) {
       //ON
       dedansBoutonCarre = true ;
       image(bouton[1],mGB , mHB ) ;
     } else {
       image(bouton[0],mGB , mHB ) ;
     }
   } else {
     //OFF
       if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(bouton[3],mGB , mHB ) ;
     } else {
       image(bouton[2],mGB , mHB ) ;
     }
   }
 }
 
 //ACTION Button
 public void boutonAction ()
 {
   if ( JouerBoutonCarre ) {
     if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(bouton[11],mGB , mHB ) ;
     } else {
       image(bouton[10],mGB , mHB ) ;
     }
   } else {
       if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(bouton[13],mGB , mHB ) ;
     } else {
       image(bouton[12],mGB , mHB ) ;
     }
   }
 }
 
 //METEO Button
 public void boutonMeteo()
 {
   if ( JouerBoutonCarre ) {
     if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(bouton[15],mGB , mHB ) ;
     } else {
       image(bouton[14],mGB , mHB ) ;
     }
   } else {
       if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       image(bouton[17],mGB , mHB ) ;
     } else {
       image(bouton[16],mGB , mHB ) ;
     }
   }
 }
 
 ///Bouton Texte
 public void boutonTexte(String s, int x, int y)
 {
   if ( JouerBoutonCarre ) {
     stroke(vertTresFonce) ;
     if ( detectionCarre() ) { 
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
      stroke(rougeTresFonce) ; 
     if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINoffBO ;
     } else {
       couleurONoffCarre = cBOUToffBO ;
     }
   }

   fill(couleurONoffCarre) ;
  // rect(x, y, 50, 50) ;
   text(s, x, y) ;
   //noStroke() ;
 }
 
 ////////////////////////////////////
 public void boutonCarreEcran (String s, PVector pos)
 {
   strokeWeight (1) ;
   if ( JouerBoutonCarre ) {
     stroke(vertTresFonce) ;
     if ( detectionCarre() ) { 
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINonBO ;
     } else {
       couleurONoffCarre = cBOUTonBO ;
     }
   } else {
     stroke(rougeTresFonce) ; 
     if ( detectionCarre() ) {
       dedansBoutonCarre = true ;
       couleurONoffCarre = cBINoffBO ;
     } else {
       couleurONoffCarre = cBOUToffBO ;
     }
   }

   fill(couleurONoffCarre) ;
   rect(mGB, mHB, lB, hB) ;
   fill(blanc) ;
   text(s, mGB +pos.x, mHB + pos.y) ;
   noStroke() ;
 }


//.........................................................................................
  public int getEtatBoutonCercle() { // nom de variable et () permet de r\u00e9cup\u00e9rer les donn\u00e9es d'un return
    return etatBoutonCercle ;
  }
  public int getEtatBoutonCarre() { // nom de variable et () permet de r\u00e9cup\u00e9rer les donn\u00e9es d'un return
    return etatBoutonCarre ;
  }
}

// CLASS
public class Dropdown {
  //Slider dropdown
  Slider sliderDropdown ;
  private PFont fontDropdown ;
  private PVector posSliderDropdown, sizeSliderDropdown, posMoletteDropdown, sizeMoletteDropdown, sizeBoxDropdownMenu ;
  //dropdown
  private int line = 0;
  private String [] listItem ;
  private boolean locked, slider ;
  private final int colorBG, boxIn, boxOut, colorText ;
  private PVector pos, size, posText;
  private float factorPos  ; // use to calculate the margin between the box
  private int sizeFont ;
  private int startingDropdown = 1 ;
  private int endingDropdown = 1 ;
  private int updateDropdown = 0 ; //for the slider update
  private float missing ;

  //CONSTRUCTOR
  public Dropdown(String [] listItem, PVector pos, PVector size, PVector posText, int colorBG, int boxIn, int boxOut, int colorText, PFont fontDropdown, int sizeFont ) {
    //dropdown
    this.listItem = listItem;
    this.pos = pos;
    this.posText = posText ;

    this.size = size; // header size
    this.sizeFont = sizeFont ;
    this.fontDropdown = fontDropdown ;
    this.colorBG = colorBG ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;
    this.colorText = colorText ;
    endingDropdown = PApplet.parseInt(size.z + 1) ;
    // security if the size of dropdown is superior of the item list
    if (endingDropdown > listItem.length ) endingDropdown = listItem.length ;
    // difference betweel the total list item and what is possible to display
    missing = listItem.length - endingDropdown  ;
   
    //size of the dropdow, for the bottom part
    sizeBoxDropdownMenu = new PVector (longestWord( listItem, 1, listItem.length ) *sizeFont *.46f, size.y) ; 
    
    
    //slider dropdown
    //condition to display the slider
    if ( listItem.length > endingDropdown  ) slider = true ; else slider = false ;
    
    if (slider) {
      sizeSliderDropdown = new PVector (  size.y / 2.0f, ((endingDropdown -1) * size.y ) -pos.z) ;
      posSliderDropdown = new PVector( pos.x - sizeSliderDropdown.x - (pos.z *2.0f) , pos.y + size.y + (1.8f *pos.z) ) ;
      posMoletteDropdown = posSliderDropdown ;
      
      float factorSizeMolette = PApplet.parseFloat(listItem.length) / PApplet.parseFloat(endingDropdown -1 ) ;
  
      
      sizeMoletteDropdown =  new PVector ( sizeSliderDropdown.x, sizeSliderDropdown.y / factorSizeMolette) ;
      sliderDropdown = new Slider(posSliderDropdown, posMoletteDropdown, sizeSliderDropdown, sizeMoletteDropdown, colorBG, boxIn, boxOut ) ;
      sliderDropdown.sliderSetting() ;
    }
  }
  
  //DRAW
  public void dropdownUpdate() {
    //to be sure of the position
    rectMode(CORNER);
    
    //Dropdown
    if (locked) {
      renderBox(listItem[0] ,1, size);
      //give the position of dropdown
      int step = 2 ;
      //give the position in list of Item with the position from the slider's molette
      if (slider) updateDropdown = round(map (sliderDropdown.getValue(), 0,1, 0, missing)) ;
      

      
      //loop to display the item list
      for ( int i = startingDropdown + updateDropdown ; i < endingDropdown + updateDropdown ; i++) {
        //bottom rendering
        renderBox(listItem[i] , step++,  sizeBoxDropdownMenu);
        //Slider dropdown
        if (slider) {
          sliderDropdown.sliderUpdate() ;
          fill(colorBG) ;
          rect ( posMoletteDropdown.x, pos.y, sizeMoletteDropdown.x, size.y ) ; 
        }
      }
    } else {
      //header rendering
      renderBox(listItem[0],1, size);
    }
  }


  //DISPLAY
  public void renderBox(String label, int step, PVector sizeBoxDropdown) {
    //
    noStroke() ;
    factorPos = step + pos.z -1 ;
    
    float yLevel = step == 1 ? pos.y  : (pos.y + (sizeBoxDropdown.y * (factorPos )));
    
    PVector newPosDropdown = new PVector (pos.x, yLevel  ) ;
    if (insideRect(newPosDropdown, sizeBoxDropdown)) {
      fill(boxIn); 
    } else { 
      fill(boxOut ) ;
    }
    
    rect(pos.x, yLevel , sizeBoxDropdown.x, sizeBoxDropdown.y );
    
    fill(colorText);
    textFont(fontDropdown);
    textSize(sizeFont) ;
    text(label, pos.x +posText.x , yLevel +posText.y );

  }
  
  //RETURN
  //Check the dropdown when this one is open
  public int selectDropdownLine() {
    if(mouseX >= pos.x && mouseX <= pos.x + size.x && mouseY >= pos.y && mouseY <= (listItem.length *size.y) +pos.y ) {
      //choice the line
      int line = floor( (mouseY - (pos.y +size.y )) / size.y ) + updateDropdown;
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
  //return the size of menu box, not header size
  public PVector sizeDropdownMenu() {
    return sizeBoxDropdownMenu ;
  }
}



//COLOR
//GLOBAL
int rouge, rougeFonce, rougeTresFonce,   
      orange, 
      jaune, 
      vert, vertClair, vertFonce, vertTresFonce,
      bleu,
      violet,
      noir, noirGris,
      blanc, blancGrisClair, blancGris,  
      gris, grisClair , grisFonce, grisNoir, 
      
      typoCourante, typoTitre,
      //bouton
      boutonOFFin, boutonOFFout, boutonONin, boutonONout,
      //for the dropdown
      colorBoxIn, colorBoxOut, colorBoxText, colorBG ;


//SETUP
public void colorSetup()
{
   colorMode (HSB, 360,100,100 ) ; 
   blanc = color(0,0,95) ;            blancGrisClair = color( 0,0,85) ;  blancGris = color( 0,0,75) ; 
   grisClair = color(0,0, 65) ;       gris = color(0,0,50) ;             grisFonce = color(0,0,40)  ;     grisNoir = color(0,0,30) ;      
   noirGris = color (0,0,20) ;         noir = color (0,0,5) ;  
   vertClair = color (100,20,100) ;     vert = color(100,35,80) ;           vertFonce = color(100,100,50) ;     vertTresFonce = color(100,100,30) ;
   rougeTresFonce = color(10, 100, 50) ; rougeFonce = color (10, 100, 70) ;  rouge = color(10,100,100) ;           orange = color (35,100,100) ; 
   
   typoCourante = grisNoir ; typoTitre = noirGris ;
   boutonOFFin = orange ; boutonOFFout = rougeFonce ;
   boutonONin = vert ; boutonONout = vertFonce ;
   
   //dropdown
   colorBG = rougeTresFonce ;
   colorBoxIn =orange ; 
   colorBoxOut = rougeFonce ;
   colorBoxText = blancGrisClair ;
}
//END COLOR



//DRAW
//////RETURN////////////
public boolean checkClavier(int c)
{
  if (clavier.length >= c) {
    return clavier[c];  
  }
  return false;
}
////////VOID/////////////

////MIDI/////////////////
public void controllerIn(promidi.Controller controller, int device, int channel){
  numMidi = controller.getNumber();
  valMidi = controller.getValue();
}

////////////////////
public void mousePressed ()
{
  //object
  for( int i = 11 ; i < 96 ; i++ ) BOf[i].mousePressed()  ;
  //texture
  for ( int i = 11 ; i < 76 ; i++)  BTf[i].mousePressed() ;
  //typo
  for ( int i = 11 ; i < 56 ; i++)  BTYf[i].mousePressed() ;

  //
  buttonMeteo.mousePressed() ;
  //son
  Bbeat.mousePressed() ;
  Bkick.mousePressed() ;
  Bsnare.mousePressed() ;
  Bhat.mousePressed() ;
  //midi
  BOmidi.mousePressed() ;
  //rideau
  BOrideau.mousePressed() ;
  //dropdown
  dropdownMousepressed() ;

}


//KEYPRESSED
public void keyPressed() {
  //boxKeypressed() ;
  //OpenClose save
  OpenCloseSave() ;
}

//KEYRELEASED
public void keyReleased() { 
  clavier[keyCode] = false;
}



//BOX WRITING
/*
void Texte (int posX, int posY, color couleur)
{
  //............boite
  boite (posX -3, posY -2, 70, width/3, 175 ) ; //x, y, hauteur boite, largeur boite, longueur bloc titre)
  fill (orange) ;
  textFont(DinBold,13);
  text("ZONE D'\u00c9CRITURE ", posX+59, posY+11);
  //...........Bouton 'envoi
  //BE1.boutonCarre () ;
  fill (blancGris) ;
  textFont(DinBold,11);
  text("Envoyer ", posX+7, posY+10); 
  //...........champs texte............................

  textFont(DinRegular,12);
  if((millis() % 1000) < 500) {  // Clignotement du curseur texte
    fill (couleur) ;
  }
  else {
    noFill();
  }

  float curseurPos;
  // Store the cursor rectangle's position
  curseurPos = textWidth(texte) + posX+2 ;
  // line( curseurPos+1 , posY -12 , curseurPos+1, posY);
  rect( curseurPos+1 , posY+18 , 1, 12);

  fill(0) ;
  pushMatrix() ;
  translate (curseurPos, posY+28 ) ;
  char t ;
  for(int i = 0 ; i < texte.length(); i++) {
    t = texte.charAt(i);
    //translate(textWidth(t),0);
    translate(-textWidth(t), 0) ;
    text(t,0,0);
  }
  popMatrix() ;

}
//box
void boite (int px, int py, int hb, int lb, int lt)
{
  pushMatrix() ;
  translate (px, py ) ;
  fill (rougeFonce ) ;  rect (0,0, lt, 17 ) ;      // place titre
                        rect (0,15, lb, hb ) ;     // place info
  fill (orange ) ;      rect (2,17, lb-4, hb-4 ) ;
  popMatrix() ;
}

//box keypressed
void boxKeypressed()
{
    //.........Fonction pour l'\u00e9criture du texte
  char k ;
  k = (char)key ;
  switch(k) 
  {
    case 8: //la touche delete
    if(texte.length() > 0)
    {
      texte = texte.substring(1);
    }
    break ;
      case 13:  // Avoid special keys
      case 10:
      case 65535:
      case 127:
      case 27:
    break;
    default :
    texte = k + texte ;
    break ;
  }
  
}
*/
//END BOX WRITING





//CHECK ACTIVITY
//GLOBAL
// Activity processor setting
boolean activity ;
int activityCount = 0 ;
int activityMidi = 0 ;
//DRAW
public void activity()
{
  // activityCount = valMidi ;
  if (activityCount > 1000  ) activity = false ; else activity = true ;
  if (activity == false ) {
    noLoop() ;
  }
  //restart the activity of the controler
  if (mousePressed ) {
    loop() ; 
    activityCount = 0 ;
    activity = true ;
  //  chargement = false ;
  }
  activityCount ++ ;
}

//restart the activity after stop
public void restart()
{
  loop() ; 
  activityCount = 0 ;
  activity = true ;
}
class Slider
{
  private PVector pos, size, posText, posMol, sizeMol, newPosMol, posMin, posMax ;
  private int slider, boxIn, boxOut, colorText ;
  private boolean molLocked ;
  private PFont p ;
  
  //CONSTRUCTOR with title
  public Slider(PVector pos, PVector posMol , PVector size, PVector posText, int slider, int boxIn, int boxOut, int colorText, PFont p)
  {
    this.pos = pos ;
    this.posMol = posMol ;
    this.size = size ;
    this.posText = posText ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;
    this.colorText = colorText ;
    this.p = p ;

    newPosMol = new PVector (0, 0) ;
    //which molette for slider horizontal or vertical
    if ( size.x >= size.y ) sizeMol = new PVector (size.y, size.y ) ; else sizeMol = new PVector (size.x, size.x ) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
  
  //CONSTRUCTOR minimum
  public Slider(PVector pos, PVector posMol , PVector size,  int slider, int boxIn, int boxOut )
  {
    this.pos = pos ;
    this.posMol = posMol ;
    this.size = size ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;

    newPosMol = new PVector (0, 0) ;
    //which molette for slider horizontal or vertical
    if ( size.x >= size.y ) sizeMol = new PVector (size.y, size.y ) ; else sizeMol = new PVector (size.x, size.x ) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
  
  
  //slider with external molette
  public Slider(PVector pos, PVector posMol , PVector size, PVector sizeMol,  int slider, int boxIn, int boxOut )
  {
    this.pos = pos ;
    this.posMol = posMol ;
    this.sizeMol = sizeMol ;
    this.size = size ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;

    newPosMol = new PVector (0, 0) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
  
  //SETTING
  public void sliderSetting()
  {
    noStroke() ;
    
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    
    //MOLETTE
    fill(boxOut) ;
    newPosMol = new PVector (posMol.x, posMol.y  ) ;
    rect(posMol.x, posMol.y, sizeMol.x, sizeMol.y ) ;
    
  }
  
  //Slider update with title
  public void sliderUpdate(String s, boolean t)
  {
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    if (t) {
      fill(colorText) ;
      textFont (p ) ;
      textSize (posText.z) ;
      text(s, posText.x, posText.y ) ;
    }
    //MOLETTE
    if (insideRect(newPosMol, sizeMol)) fill(boxIn); else fill(boxOut ) ;
    moletteUpdate() ;
    rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
  }
  //Slider update simple
  public void sliderUpdate()
  {
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    //MOLETTE
    if (insideRect(newPosMol, sizeMol)) fill(boxIn); else fill(boxOut ) ;
    moletteUpdate() ;
    rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
  }
  
  public void moletteUpdate()
  {
    if (locked (insideRect(newPosMol, sizeMol) )  ) molLocked = true ;
    if (!mousePressed)  molLocked = false ; 
      
    if ( molLocked ) {  
      if ( size.x >= size.y ) newPosMol.x = constrain(mouseX -(sizeMol.x / 2.0f ), posMin.x, posMax.x)  ; else newPosMol.y = constrain(mouseY -(sizeMol.y / 2.0f ), posMin.y, posMax.y) ;
    }
  }
  
  //RETURN
  public float getValue()
  {
    float value ;
    if ( size.x >= size.y ) value = map (newPosMol.x, posMin.x, posMax.x, 0,1) ; else value = map (newPosMol.y, posMin.y, posMax.y, 0,1) ;
    return value ;
  }
}
class RegletteHorizontale
{
  int posX ;
  int longueurRH, hauteurRH;    // width et height de la r\u00e9glette
  int xpos, ypos;         // x and y position de la r\u00e9glette
  float spos, newspos;    // x position de la molette
  int sposMin, sposMax;   // valeurs maximales et mininmales de la r\u00e9glette
  int suivit, posCur;              // how loose/heavy
  int transp ;
  boolean dedans, locked ;           
  int bOUT, bIN, rglt ;
  float rapportDepart = 80.0f ;
  float rapportChargement = 1.0f ;
  //MIDI
  int newValMidi ;
  int IDmidi = -2 ;

  RegletteHorizontale (int xp, int yp, int LRH, int HRH, int s, int boutonOUT, int boutonIN, int reglette, int transparence, int pC, int IDmidi) 
  {
    this.IDmidi = IDmidi ;
    int widthtoheight = LRH - HRH;
    
    longueurRH = LRH;   hauteurRH = HRH;              suivit = s;
    xpos = xp;          ypos = yp-hauteurRH/2;
    float h = PApplet.parseFloat(hauteurRH) ;
    float lh = PApplet.parseFloat(longueurRH) ;
    
    //molette position
    spos = xpos + (pC / (100.0f + ( (11.0f/lh)*rapportDepart) ) * LRH); 
    newspos = spos;
    
    sposMin = xpos;    sposMax = xpos + longueurRH - hauteurRH;
    bOUT = boutonOUT ;  bIN = boutonIN ; rglt = reglette   ; transp = transparence ;
    
  }
  //DISPLAY
  public void display() {
    fill(rglt, transp);
    rect(xpos, ypos, longueurRH, hauteurRH); // affichage de la r\u00e9glette
    stroke(blanc) ; strokeWeight(1) ;
    if(dedans || locked) {
      fill(bIN);
      chargement = false ;
    } else {
      fill(bOUT);
    }
    //affichage molette   
    rect(spos, ypos-3, hauteurRH-2, hauteurRH+4);
    noStroke() ;   
  }


  

  
  public void update(int curseurX, int loadX ) {
    int NLX ;
    float NloadX ;
    float lh = PApplet.parseFloat(longueurRH) ;
    NloadX = xpos + (loadX / (100.0f + ( (11.0f/lh)*rapportChargement) ) * longueurRH);
    NLX = round(NloadX) ;
    // Choix entre le chargement des sauvegarde de position ou les coordonn\u00e9es de la souris
    if(chargement ) {
      posX = NLX ; 
    } else { 
      posX = curseurX ; 
    }
   
   if(dedans()) dedans = true ; else dedans = false ;
   if(mousePressed && dedans) locked = true ;
   if(!mousePressed) locked = false ;
   
   if(locked || chargement) {
      newspos = constrain(posX-hauteurRH/2, sposMin, sposMax);
    }

    if(abs(newspos - spos) > 1) {
      restart() ; // this line is from the main program to make a activityCount to zero
      spos = spos + (newspos-spos)/suivit;
    }
  }

  public int constrain(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }
  
  // update position from midi controller
  public void updateMidi(int val) {
    //update the Midi position only if the Midi Button move
    if ( newValMidi != val ) { 
      newValMidi = val ; 
      newspos = map(val, 1, 127, sposMin, sposMax ) ;
      posX = newValMidi ; 
    }
    // val = map(val,1,128, 0, width ) ; 

  }
  
  //////
  //VOID
  public void load(int loadX) {
    float lh = PApplet.parseFloat(longueurRH) ;
    spos = xpos + (loadX / (100.0f + ( (11.0f/lh)*rapportChargement) ) * longueurRH);
    println(loadX + " / " + spos) ;
  }
  // give the ID from the controller Midi
  public void selectIDmidi(int num) { IDmidi = num ; }
  
  ////////
  //RETURN
  //give the IDmidi 
  public int IDmidi() { return IDmidi ; }
  //return the state
  public boolean lock() { return locked ; }
  //rollover
  public boolean dedans() {
    if(mouseX > spos && mouseX < spos+hauteurRH &&
       mouseY > ypos && mouseY < ypos+hauteurRH) {  
      return true;
    } else {
      return false;
    }
  }
  //return pos
  public float getPos() { // nom de variable et () permet de r\u00e9cup\u00e9rer les donn\u00e9es d'un return
    return (((spos-xpos)/longueurRH)-0.004f) *111 ;
  }


  
}
//UTIL
//STRING LIST SORT
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



//INSIDE
//CIRLCLE
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
/*
Interface Control Stanislas Mar\u00e7ais
Web site Romanesco
http://romanescoproject.wordpress.com/
Web site Stanislas Mar\u00e7ais
http://stanislas-marcais.blogspot.fr/ 


Un grand Merci \u00e0 Laetitia, ma femme pour son soutient moral et financier pendant toutes ces semaines, ces mois de d\u00e9veloppement

Un Grand merci \u00e9galement \u00e0 la communaut\u00e9 Processing : 
Daniel Shiffman for the slider, 
Marius Waltz pour les saved Data, 

Mark Webster pour ses ateliers Processing Cities.
Nicopter et sa th\u00e9orie "Tout doit \u00eatre compris entre 0 et 1"

aux particpants du Forum Processing et Github qui ont pris le temps de r\u00e9pondre
Philo, AmnonP5, Datguy, R.Brauer pour les conseils via le Forum, 
*/
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Controleur_24e" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
