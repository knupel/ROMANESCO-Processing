import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress targetScene, targetMiroir;
//adress to scene information from the OSC sender
String sendToScene = ("127.0.0.1") ;
String sendToMiroir = ("127.0.0.1") ;

//message from controler
String fromControler [] = new String [8] ;
//message from pré-Scène
String toScene = ("Message from Préscène") ;


//SLIDER and BUTTON

int numSliderFamilly = 40 ; // slider by familly object (global, object, trame, typo)

int numSliderGlobal = 10 ;
int numSlider = 30 ;

int numButtonGlobal = 50 ;
int numButtonObj = 150 ;
int numButtonTex = 150 ;
int numButtonTypo = 150 ;

// button
int eBeat, eKick, eSnare, eHat, eCurtain, eMeteo ;
int mainButton [] = new int [numObj] ;
int soundButton [] = new int [numObj] ;
int actionButton[] = new int [numObj] ;
int meteoButton[] = new int [numObj] ;
int parameterButton[] = new int [numObj] ;
int modeButton[] = new int [numObj] ;

//BUTTON
int valueButtonGlobal[] = new int[numButtonGlobal] ;
int valueButtonObj[] = new int[numButtonObj] ;
int valueButtonTex[] = new int[numButtonTex] ;
int valueButtonTypo[] = new int[numButtonTypo] ;
//SLIDER
String valueSliderTempGlobal[]  = new String [numSliderGlobal] ;
String valueSliderTempObj[]  = new String [numSlider] ;
String valueSliderTempTex[]  = new String [numSlider] ;
String valueSliderTempTypo[]  = new String [numSlider] ;

float valueSliderGlobal[]  = new float [numSliderGlobal] ;
float valueSliderObj[]  = new float [numSlider] ;
float valueSliderTex[]  = new float [numSlider] ;
float valueSliderTypo[]  = new float [numSlider] ;


//SETUP
void OSCSetup() {
  osc = new OscP5(this, 10000);
  
  //send to the Scène
  if (youCanSendToScene) targetScene = new NetAddress(sendToScene,10001);
  //send to the miroir
  if (!testRomanesco) {
    String [] addressIP = loadStrings(sketchPath("")+"IP_local_miroir.txt") ;
    sendToMiroir = join(addressIP, "") ;
    targetMiroir = new NetAddress(sendToMiroir,10002);
  } else if (testRomanesco && youCanSendToMiroir )  {
    targetMiroir = new NetAddress(sendToMiroir,10002);
  }
}


//EVENT to check what else is receive by the receiver
void oscEvent(OscMessage receive ) {
  //catch data from controleur
  for ( int i = 0 ; i < fromControler.length ; i++ ) {
    fromControler [i] = receive.get(i).stringValue() ;
  }
    //SPLIT DATA for the Pre-Scene
  //Split data from the String Data
  valueButtonGlobal = int(split(fromControler [0], '/')) ;
  valueButtonObj = int(split(fromControler [1], '/')) ;
  valueButtonTex = int(split(fromControler [2], '/')) ;
  valueButtonTypo = int(split(fromControler [3], '/')) ;
  
  //SLIDER
  //split String
  valueSliderTempGlobal = split(fromControler [4], '/') ;
  valueSliderTempObj = split(fromControler [5], '/') ;
  valueSliderTempTex = split(fromControler [6], '/') ;
  valueSliderTempTypo = split(fromControler [7], '/') ;
  //convert String to float
  for ( int i = 0 ; i < 10 ; i++) {
    valueSliderGlobal[i] = Float.valueOf(valueSliderTempGlobal[i]) ;
  }
  
  for ( int i = 0 ; i < 30 ; i++) { 
    valueSliderObj [i] = Float.valueOf(valueSliderTempObj[i]) ;
    valueSliderTex [i] = Float.valueOf(valueSliderTempTex[i]) ;
    valueSliderTypo[i] = Float.valueOf(valueSliderTempTypo[i]) ;
  }
}


//
String dataPreScene [] = new String [61] ;


void OSCDraw() {
   //CATCH data from preScene to Scene
   if (spaceTouch) dataPreScene [0] = ("1") ; else dataPreScene [0] =("0") ;
   if (aTouch)     dataPreScene [1] = ("1") ; else dataPreScene [1] = ("0") ;
   if (bTouch)     dataPreScene [2] = ("1") ; else dataPreScene [2] = ("0") ;
   if (cTouch)     dataPreScene [3] = ("1") ; else dataPreScene [3] = ("0") ;
   if (dTouch)     dataPreScene [4] = ("1") ; else dataPreScene [4] = ("0") ;
   if (eTouch)     dataPreScene [5] = ("1") ; else dataPreScene [5] = ("0") ;
   if (fTouch)     dataPreScene [6] = ("1") ; else dataPreScene [6] = ("0") ;
   if (gTouch)     dataPreScene [7] = ("1") ; else dataPreScene [7] = ("0") ;
   if (hTouch)     dataPreScene [8] = ("1") ; else dataPreScene [8] = ("0") ;
   if (iTouch)     dataPreScene [9] = ("1") ; else dataPreScene [9] = ("0") ;
   if (jTouch)     dataPreScene [10] = ("1") ; else dataPreScene [10] = ("0") ;
   if (kTouch)     dataPreScene [11] = ("1") ; else dataPreScene [11] = ("0") ;
   if (lTouch)     dataPreScene [12] = ("1") ; else dataPreScene [12] = ("0") ;
   if (mTouch)     dataPreScene [13] = ("1") ; else dataPreScene [13] = ("0") ;
   if (nTouch)     dataPreScene [14] = ("1") ; else dataPreScene [14] = ("0") ;
   if (oTouch)     dataPreScene [15] = ("1") ; else dataPreScene [15] = ("0") ;
   if (pTouch)     dataPreScene [16] = ("1") ; else dataPreScene [16] = ("0") ;
   if (qTouch)     dataPreScene [17] = ("1") ; else dataPreScene [17] = ("0") ;
   if (rTouch)     dataPreScene [18] = ("1") ; else dataPreScene [18] = ("0") ;
   if (sTouch)     dataPreScene [19] = ("1") ; else dataPreScene [19] = ("0") ;
   if (tTouch)     dataPreScene [20] = ("1") ; else dataPreScene [20] = ("0") ;
   if (uTouch)     dataPreScene [21] = ("1") ; else dataPreScene [21] = ("0") ;
   if (vTouch)     dataPreScene [22] = ("1") ; else dataPreScene [22] = ("0") ;
   if (wTouch)     dataPreScene [23] = ("1") ; else dataPreScene [23] = ("0") ;
   if (xTouch)     dataPreScene [24] = ("1") ; else dataPreScene [24] = ("0") ;
   if (yTouch)     dataPreScene [25] = ("1") ; else dataPreScene [25] = ("0") ;
   if (zTouch)     dataPreScene [26] = ("1") ; else dataPreScene [26] = ("0") ;
   //longtouch
   if (cLongTouch) dataPreScene [27] = ("1") ; else dataPreScene [27] = ("0") ;
   if (nLongTouch) dataPreScene [28] = ("1") ; else dataPreScene [28] = ("0") ;
   if (vLongTouch) dataPreScene [29] = ("1") ; else dataPreScene [29] = ("0") ;
   
   if (enterTouch)    dataPreScene [30] = ("1") ; else dataPreScene [30] = ("0") ;
   if (deleteTouch)    dataPreScene [31] = ("1") ; else dataPreScene [31] = ("0") ;
   if (backspaceTouch) dataPreScene [32] = ("1") ; else dataPreScene [32] = ("0") ;
   if (upTouch) dataPreScene [33] = ("1") ; else dataPreScene [33] = ("0") ;
   if (downTouch) dataPreScene [34] = ("1") ; else dataPreScene [34] = ("0") ;
   if (rightTouch) dataPreScene [35] = ("1") ; else dataPreScene [35] = ("0") ;
   if (leftTouch) dataPreScene [36] = ("1") ; else dataPreScene [36] = ("0") ;
   if (ctrlTouch) dataPreScene [37] = ("1") ; else dataPreScene [37] = ("0") ;
   //cursor
   dataPreScene[38] = FloatToStringWithThree(norm(pmouse[0].x, 0, width)) ; 
   dataPreScene[39] = FloatToStringWithThree(norm(pmouse[0].y,0,height)) ;
   dataPreScene[40] = FloatToStringWithThree(pen[0].x) ; dataPreScene[41] = FloatToStringWithThree(pen[0].y) ; dataPreScene[42] = FloatToString(pen[0].z) ; 
   dataPreScene[43] = FloatToStringWithThree(norm(mouse[0].x, 0, width)) ; 
   dataPreScene[44] = FloatToStringWithThree(norm(mouse[0].y,0,height)) ;
   dataPreScene[45] = FloatToStringWithThree(norm(mouse[0].z,-750,750)) ;
   if (clickShortLeft[0]) dataPreScene [46] = ("1") ; else dataPreScene [46] = ("0") ;
   if (clickShortRight[0]) dataPreScene [47] = ("1") ; else dataPreScene [47] = ("0") ;
   if (clickLongLeft[0]) dataPreScene [48] = ("1") ; else dataPreScene [48] = ("0") ;
   if (clickLongRight[0]) dataPreScene [49] = ("1") ; else dataPreScene [49] = ("0") ;
   dataPreScene[50] = IntToString(wheel[0]) ;
   if (touch1)     dataPreScene [51] = ("1") ; else dataPreScene [51] = ("0") ;
   if (touch2)     dataPreScene [52] = ("1") ; else dataPreScene [52] = ("0") ;
   if (touch3)     dataPreScene [53] = ("1") ; else dataPreScene [53] = ("0") ;
   if (touch4)     dataPreScene [54] = ("1") ; else dataPreScene [54] = ("0") ;
   if (touch5)     dataPreScene [55] = ("1") ; else dataPreScene [55] = ("0") ;
   if (touch6)     dataPreScene [56] = ("1") ; else dataPreScene [56] = ("0") ;
   if (touch7)     dataPreScene [57] = ("1") ; else dataPreScene [57] = ("0") ;
   if (touch8)     dataPreScene [58] = ("1") ; else dataPreScene [58] = ("0") ;
   if (touch9)     dataPreScene [59] = ("1") ; else dataPreScene [59] = ("0") ;
   if (touch0)     dataPreScene [60] = ("1") ; else dataPreScene [60] = ("0") ;
   
   
  
   toScene = join(dataPreScene, "/") ;
   
   //PROBLEM with packet to send we must join the smaller pack with the new one
   // fromControler[4] = fromControler[4] + "/" + toScene ;
   fromControler[4] = fromControler[4] + "/" +dataPreScene[0] + "/" +dataPreScene[1] + "/" +dataPreScene[2] + "/" +dataPreScene[3] + "/" +dataPreScene[4] + "/" +dataPreScene[10] ;
   
   
   
   
  
  //SEND data to SCENE
  //send info from scene
  OscMessage RomanescoScene = new OscMessage("ROMANESCO PréScène");
  //add info to send
  for ( int i = 0 ; i < fromControler.length ; i++ ) {
    if (fromControler[i] == null ) fromControler[i] = ("") ;
    RomanescoScene.add(fromControler[i]);
  }
  RomanescoScene.add(toScene);
  //send
  if(Scene) if (youCanSendToScene)osc.send(RomanescoScene, targetScene); 
  if(Miroir) if (youCanSendToMiroir) osc.send(RomanescoScene, targetMiroir);
 
   
 
  
  
  
  //TRANSFORM info from controler to use in the preScene
  //GLOBAL
  eBeat = valueButtonGlobal[1] ;
  eKick = valueButtonGlobal[2] ;
  eSnare = valueButtonGlobal[3] ;
  eHat = valueButtonGlobal[4] ;
  //meteo
  eMeteo = valueButtonGlobal[5] ;
  //dropdown typo
  whichFont(valueButtonGlobal[7]) ;
  //rideau
  eCurtain = valueButtonGlobal[10] ;
  
  //OBJ
  for ( int i = 0 ; i < 9 ; i++) {
    mainButton     [i +1] = valueButtonObj[i *10 +1] ;
    parameterButton[i +1] = valueButtonObj[i *10 +2] ;
    soundButton    [i +1] = valueButtonObj[i *10 +3] ;
    actionButton   [i +1] = valueButtonObj[i *10 +4] ;
    meteoButton    [i +1] = valueButtonObj[i *10 +5] ;
    modeButton     [i +1] = valueButtonObj[i *10 +9] ;
  }
  //TEXTURE
  for ( int i = 0 ; i < 7 ; i++) {
    mainButton     [i +21] = valueButtonTex[i *10 +1] ;
    parameterButton[i +21] = valueButtonTex[i *10 +2] ;
    soundButton    [i +21] = valueButtonTex[i *10 +3] ;
    actionButton   [i +21] = valueButtonTex[i *10 +4] ;
    meteoButton    [i +21] = valueButtonTex[i *10 +5] ;
    modeButton     [i +21] = valueButtonTex[i *10 +9] ;
  }
  
  //TYPO
  for ( int i = 0 ; i < 5 ; i++) {
    mainButton     [i +41] = valueButtonTypo[i *10 +1] ;
    parameterButton[i +41] = valueButtonTypo[i *10 +2] ;
    soundButton    [i +41] = valueButtonTypo[i *10 +3] ;
    actionButton   [i +41] = valueButtonTypo[i *10 +4] ;
    meteoButton    [i +41] = valueButtonTypo[i *10 +5] ;
    modeButton     [i +41] = valueButtonTypo[i *10 +9] ;
  }
}
