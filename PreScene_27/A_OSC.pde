

OscP5 osc;
NetAddress targetScene, targetMiroir;
//adress to scene information from the OSC sender
String sendToScene = ("127.0.0.1") ;
String sendToMiroir = ("127.0.0.1") ;

//message from controler

//message from pré-Scène
String toScene = ("Message from Préscène") ;


//SETUP
void OSCSetup() {
  osc = new OscP5(this, 10000);
  
  //send to the Scène
  if (youCanSendToScene) targetScene = new NetAddress(sendToScene,10001);
  //send to the miroir
  if (!testRomanesco) {
    String [] addressIP = loadStrings(preferencesPath+"network/IP_local_miroir.txt") ;
    sendToMiroir = join(addressIP, "") ;
    targetMiroir = new NetAddress(sendToMiroir,10002);
  } else if (testRomanesco && youCanSendToMiroir )  {
    targetMiroir = new NetAddress(sendToMiroir,10002);
  }
}







// RECEIVE INFO from CONTROLLER
////////////////////////////////
int numOfPartSendByController = 7 ; 
String fromController [] = new String [numOfPartSendByController] ;
//EVENT to check what else is receive by the receiver

void oscEvent(OscMessage receive) {
  //catch data from controller
  for ( int i = 0 ; i < fromController.length ; i++ ) {
    fromController [i] = receive.get(i).stringValue() ;
  }



  // BUTTON
  //Split data from the String Data
  valueButtonGlobal = int(split(fromController [0], '/')) ;
  // stick the Int(String) chain from the group object "one" and "two" is single chain integer(String).
  String fullChainValueButtonObj =("") ;
  for ( int i = 1 ; i <= NUM_GROUP ; i++ ) {
    fullChainValueButtonObj += fromController [i]+"/" ;
  }
  valueButtonObj = int(split(fullChainValueButtonObj, '/')) ;
  


  //SLIDER
  //split String value from controller
  int numTotalGroup = NUM_GROUP +1 ;
  for ( int i = 0 ; i < numTotalGroup ; i++ ) {
    valueSliderTemp [i] = split(fromController [i +numTotalGroup], '/') ;
  }
  // translate the String value to the float var to use
  for ( int i = 0 ; i < NUM_GROUP +1 ; i++ ) {
    // security because there not same quantity of slider in the group MISC "zero" and OBJECT group "one and two".
    int n = 0 ;
    if ( i < 1 ) n = NUM_SLIDER_MISC ; else n = NUM_SLIDER_OBJ ;
    for (int j = 0 ; j < n ; j++) {
      valueSlider[i][j] = Float.valueOf(valueSliderTemp[i][j]) ;
    }
  }



  // LOAD SAVE

  /*
  +1 for the global group
  *2 because there is one group for the button and an other one for the slider
  */
  int whichOne = (NUM_GROUP +1) *2 ;
  String [] booleanSave  ;

  booleanSave = split(fromController[whichOne], '/') ;
  // convert string to boolean
  load_Scene_Setting = Boolean.valueOf(booleanSave[0]).booleanValue();
  save_Current_Scene_Setting = Boolean.valueOf(booleanSave[1]).booleanValue();
  save_New_Scene_Setting = Boolean.valueOf(booleanSave[2]).booleanValue();
   
  if(load_Scene_Setting)         println ("Prescene ", "load_Scene_Setting",         load_Scene_Setting) ;
  if(save_Current_Scene_Setting) println ("Prescene ", "save_Current_Scene_Setting", save_Current_Scene_Setting) ;
  if(save_New_Scene_Setting)     println ("Prescene ", "save_New_Scene_Setting",     save_New_Scene_Setting) ;
}













// FROM PRESCENE to SCENE
String dataPreScene [] = new String [74] ;


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
   
   //FREE
   dataPreScene [27] = ("") ;
   dataPreScene [28] = ("") ;
   dataPreScene [29] = ("") ;
   
   // SPECIAL TOUCH
   if (enterTouch)    dataPreScene [30] = ("1") ; else dataPreScene [30] = ("0") ;
   if (deleteTouch)    dataPreScene [31] = ("1") ; else dataPreScene [31] = ("0") ;
   if (backspaceTouch) dataPreScene [32] = ("1") ; else dataPreScene [32] = ("0") ;
   if (upTouch) dataPreScene [33] = ("1") ; else dataPreScene [33] = ("0") ;
   if (downTouch) dataPreScene [34] = ("1") ; else dataPreScene [34] = ("0") ;
   if (rightTouch) dataPreScene [35] = ("1") ; else dataPreScene [35] = ("0") ;
   if (leftTouch) dataPreScene [36] = ("1") ; else dataPreScene [36] = ("0") ;
   if (ctrlTouch) dataPreScene [37] = ("1") ; else dataPreScene [37] = ("0") ;
   
   // MOUSE
   dataPreScene[38] = FloatToStringWithThree(norm(pmouse[0].x, 0, width)) ; 
   dataPreScene[39] = FloatToStringWithThree(norm(pmouse[0].y,0,height)) ;
   dataPreScene[40] = FloatToStringWithThree(pen[0].x) ; dataPreScene[41] = FloatToStringWithThree(pen[0].y) ; dataPreScene[42] = FloatToString(pen[0].z) ; 
   dataPreScene[43] = FloatToStringWithThree(norm(mouse[0].x, 0, width)) ; 
   dataPreScene[44] = FloatToStringWithThree(norm(mouse[0].y,0,height)) ;
   dataPreScene[45] = FloatToStringWithThree(norm(mouse[0].z,-depth,depth)) ;
   if (clickShortLeft[0]) dataPreScene [46] = ("1") ; else dataPreScene [46] = ("0") ;
   if (clickShortRight[0]) dataPreScene [47] = ("1") ; else dataPreScene [47] = ("0") ;
   if (clickLongLeft[0]) dataPreScene [48] = ("1") ; else dataPreScene [48] = ("0") ;
   if (clickLongRight[0]) dataPreScene [49] = ("1") ; else dataPreScene [49] = ("0") ;
   dataPreScene[50] = IntToString(wheel[0]) ;
   
   // NUMBER
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
   
   //longtouch
   if (cLongTouch) dataPreScene [61] = ("1") ; else dataPreScene [61] = ("0") ;
   if (lLongTouch) dataPreScene [62] = ("1") ; else dataPreScene [62] = ("0") ;
   if (nLongTouch) dataPreScene [63] = ("1") ; else dataPreScene [63] = ("0") ;
   if (vLongTouch) dataPreScene [64] = ("1") ; else dataPreScene [64] = ("0") ;
   
   // FREE
   dataPreScene [65] = ("") ;
   dataPreScene [66] = ("") ;
   dataPreScene [67] = ("") ;
   dataPreScene [68] = ("") ;
   dataPreScene [69] = ("") ;
   
   // ORDER
   if (ORDER_ONE) dataPreScene [70] = ("1") ; else dataPreScene [70] = ("0") ;
   if (ORDER_TWO) dataPreScene [71] = ("1") ; else dataPreScene [71] = ("0") ;
   if (ORDER_THREE) dataPreScene [72] = ("1") ; else dataPreScene [72] = ("0") ;
   if (LEAPMOTION_DETECTED) dataPreScene [73] = ("1") ; else dataPreScene [73] = ("0") ;

   
   toScene = join(dataPreScene, "/") ;
   
   
   
   ////////////// WEIRD /////////////////////////////////////////////////////////
   fromController[NUM_GROUP +1] = fromController[NUM_GROUP +1] + "/" +dataPreScene[0] + "/" +dataPreScene[1] + "/" +dataPreScene[2] + "/" +dataPreScene[3] + "/" +dataPreScene[4] + "/" +dataPreScene[10] ;
   /** 
   println("after ", fromController[NUM_GROUP +1]) ;
     I don't understand this line  why we must  add this data dataPreScene[0], dataPreScene[1], dataPreScene[2], dataPreScene[3], dataPreScene[4], dataPreScene[10] here, this not real interesting dateindexObjects
     plus  we add all data at th end.
     see line : RomanescoScene.add(toScene);
   In the test just dataPreScene[0] change the value between 1 and 0
   
   But if we don't add ths line below the Scene crash
   in the method OSCdraw() {
    ...
    eBeat = valueButtonGlobal[1]
    ... }
    with this error message
    nullpointer : Arrayover flows...
    method in charge OSCevent
    javalangreflect.Invokation target Exception

   */
  
  
  
  
  //SEND data to SCENE
  OscMessage RomanescoScene = new OscMessage("ROMANESCO Prescene");
  //add info to send
  String sizeDataLengthFromPrescene = ("") ;
  for ( int i = 0 ; i < fromController.length ; i++ ) {
    if (fromController[i] == null ) fromController[i] = ("") ;
    RomanescoScene.add(fromController[i]);
    sizeDataLengthFromPrescene += fromController[i] ;
  }
  RomanescoScene.add(toScene);
  
  

  //send
  if (youCanSendToScene)osc.send(RomanescoScene, targetScene); 
  if (youCanSendToMiroir) osc.send(RomanescoScene, targetMiroir);
  
  //TRANSFORM info from controler to use in the preScene
  // sound option on/off
  if(valueButtonGlobal[1] == 1 ) onOffBeat = true ; else onOffBeat = false ;
  if(valueButtonGlobal[2] == 1 ) onOffKick = true ; else onOffKick = false ;
  if(valueButtonGlobal[3] == 1 ) onOffSnare = true ; else onOffSnare = false ;
  if(valueButtonGlobal[4] == 1 ) onOffHat = true ; else onOffHat = false ;
  // backgound option on/off
  if(valueButtonGlobal[6] == 1 ) onOffCurtain = true ; else onOffCurtain = false ;
  if(valueButtonGlobal[7] == 1 ) onOffBackground = true ; else onOffBackground = false ;
  // light on/off
  if(valueButtonGlobal[8] == 1 ) onOffDirLightOne = true ; else onOffDirLightOne = false ;
  if(valueButtonGlobal[9] == 1 ) onOffDirLightTwo = true ; else onOffDirLightTwo = false ;
  if(valueButtonGlobal[10] == 1 ) onOffLightAmbient = true ; else onOffLightAmbient = false ;
  // light move light on/off
  if(valueButtonGlobal[11] == 1 ) onOffDirLightOneAction = true ; else onOffDirLightOneAction = false ;
  if(valueButtonGlobal[12] == 1 ) onOffDirLightTwoAction = true ; else onOffDirLightTwoAction = false ;
  if(valueButtonGlobal[13] == 1 ) onOffLightAmbientAction = true ; else onOffLightAmbientAction = false ;
  
  // list choice
   whichShader = valueButtonGlobal[14] ;
  choiceFont(valueButtonGlobal[5]) ;
  whichImage[0] = valueButtonGlobal[15] ;
  whichText[0] = valueButtonGlobal[16] ;
  
  //OBJECTS
  for ( int i = 0 ; i < numObj-1 ; i++) {
    int iPlusOne = i+1 ;
    objectButton   [iPlusOne] = valueButtonObj[i *10 +1] ;
    parameterButton[iPlusOne] = valueButtonObj[i *10 +2] ;
    soundButton    [iPlusOne] = valueButtonObj[i *10 +3] ;
    actionButton   [iPlusOne] = valueButtonObj[i *10 +4] ;
    mode     [iPlusOne] = valueButtonObj[i *10 +9] ;
    if (objectButton[iPlusOne] == 1 ) object[iPlusOne] = true ; else object[iPlusOne] = false ;
    if (parameterButton[iPlusOne] == 1 ) parameter[iPlusOne] = true ; else parameter[iPlusOne] = false ;
    if (soundButton[iPlusOne] == 1 ) sound[iPlusOne] = true ; else sound[iPlusOne] = false ;
    if (actionButton[iPlusOne] == 1 ) action[iPlusOne] = true ; else action[iPlusOne] = false ;
  }
}
