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
String toScene = ("Message from PréScène") ;
//if the miroir is ON
boolean miroir ; 

//SLIDER and BUTTON




//SETUP
void OSCSetup() {
  osc = new OscP5(this, 10000);
  //send to the miroir
  targetScene = new NetAddress(sendToMiroir,10001);
  if (miroir ) targetMiroir = new NetAddress(sendToMiroir,10001);
}


// to check what else is receive by the receiver
void oscEvent(OscMessage receive ) {
  //catch data from controleur
  for ( int i = 0 ; i < fromControler.length ; i++ ) {
    fromControler [i] = receive.get(i).stringValue() ;
  }
    //SPLIT DATA for the Pre-Scene
  //Split data from the String Data
  valueButtonGlobal = int(split(fromControler [0], '/')) ;
  valueButtonObj = int(split(fromControler [1], '/')) ;
  
  //SLIDER
  //split String
  valueSliderTempGlobal = split(fromControler [4], '/') ;
  valueSliderTempObj = split(fromControler [5], '/') ;
  valueSliderTempTex = split(fromControler [6], '/') ;
  valueSliderTempTypo = split(fromControler [7], '/') ;
  //convert String to float
  for ( int i = 0 ; i < numSliderGlobal ; i++) {
    valueSliderGlobal[i] = Float.valueOf(valueSliderTempGlobal[i]) ;
  }
  
  for ( int i = 0 ; i < numSlider ; i++) { 
    valueSliderObj [i] = Float.valueOf(valueSliderTempObj[i]) ;
    valueSliderTex [i] = Float.valueOf(valueSliderTempTex[i]) ;
    valueSliderTypo[i] = Float.valueOf(valueSliderTempTypo[i]) ;
  }
}


//
String dataPreScene [] = new String [51] ;


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
   dataPreScene [27] = ("0") ;
   dataPreScene [28] = ("0") ;
   dataPreScene [29] = ("0") ;
   dataPreScene [30] = ("0") ;
   if (deleteTouch)    dataPreScene [31] = ("1") ; else dataPreScene [31] = ("0") ;
   if (backspaceTouch) dataPreScene [32] = ("1") ; else dataPreScene [32] = ("0") ;
   if (upTouch) dataPreScene [33] = ("1") ; else dataPreScene [33] = ("0") ;
   if (downTouch) dataPreScene [34] = ("1") ; else dataPreScene [34] = ("0") ;
   if (rightTouch) dataPreScene [35] = ("1") ; else dataPreScene [35] = ("0") ;
   if (leftTouch) dataPreScene [36] = ("1") ; else dataPreScene [36] = ("0") ;
   dataPreScene [37] = ("0") ;
   dataPreScene [38] = ("0") ;
   dataPreScene [39] = ("0") ;
   dataPreScene[40] = FloatToStringWithThree(pen[0].x) ; 
   dataPreScene[41] = FloatToStringWithThree(pen[0].y) ; 
   dataPreScene[42] = FloatToString(pen[0].z) ; 
   dataPreScene[43] = FloatToStringWithThree(norm(mouse[0].x, 0, width)) ; 
   dataPreScene[44] = FloatToStringWithThree(norm(mouse[0].y,0,height)) ;
   dataPreScene[45] = FloatToStringWithThree(norm(mouse[0].z,-750,750)) ;
   if (clickShortLeft[0]) dataPreScene [46] = ("1") ; else dataPreScene [46] = ("0") ;
   if (clickShortRight[0]) dataPreScene [47] = ("1") ; else dataPreScene [47] = ("0") ;
   if (clickLongLeft[0]) dataPreScene [48] = ("1") ; else dataPreScene [48] = ("0") ;
   if (clickLongRight[0]) dataPreScene [49] = ("1") ; else dataPreScene [49] = ("0") ;
   dataPreScene[50] = IntToString(wheel[0]) ;
   
   
  
   toScene = join(dataPreScene, "/") ;
   
   //PROBLEM with packet to send we must join the smaller pack with the new one
   // fromControler[4] = fromControler[4] + "/" + toScene ;
   fromControler[4] = fromControler[4] + "/" +dataPreScene[0] + "/" +dataPreScene[1] + "/" +dataPreScene[2] + "/" +dataPreScene[3] + "/" +dataPreScene[4] + "/" +dataPreScene[10] ;
   
   
   
   
  
  //SEND data to SCENE
  //send info from scene
  OscMessage RomanescoScene = new OscMessage("ROMANESCO Startcoding");
  //add info to send
  for ( int i = 0 ; i < fromControler.length ; i++ ) {
    if (fromControler[i] == null ) fromControler[i] = ("") ;
    RomanescoScene.add(fromControler[i]);
  }
  RomanescoScene.add(toScene);
  //send
  osc.send(RomanescoScene, targetScene); 
  if (miroir) osc.send(RomanescoScene, targetMiroir);
 
   
 
  
  
  
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
  for ( int i = 0 ; i < numObj-1 ; i++) {
    int iPlusOne = i+1 ;
    objectButton   [iPlusOne] = valueButtonObj[i *10 +1] ;
    parameterButton[iPlusOne] = valueButtonObj[i *10 +2] ;
    soundButton    [iPlusOne] = valueButtonObj[i *10 +3] ;
    actionButton   [iPlusOne] = valueButtonObj[i *10 +4] ;
    modeButton     [iPlusOne] = valueButtonObj[i *10 +9] ;
    if (objectButton[iPlusOne] == 1 ) object[iPlusOne] = true ; else object[iPlusOne] = false ;
    if (parameterButton[iPlusOne] == 1 ) parameter[iPlusOne] = true ; else parameter[iPlusOne] = false ;
    if (soundButton[iPlusOne] == 1 ) sound[iPlusOne] = true ; else sound[iPlusOne] = false ;
    if (actionButton[iPlusOne] == 1 ) action[iPlusOne] = true ; else action[iPlusOne] = false ;
    
  }
}
