// Tab: Z_OSC
/////////////////////////
// RECEIVE INFO from CONTROLLER
////////////////////////////////
int numOfPartSendByController = 7 ; 
String fromController [] = new String [numOfPartSendByController] ;
//EVENT to check what else is receive by the receiver





// ANNEXE VOID of OSC RECEIVE

// catch raw osc data
void catchDataFromController(OscMessage receive) {
  for ( int i = 0 ; i < fromController.length ; i++ ) {
    fromController [i] = receive.get(i).stringValue() ;
  }
}

// split data button
void splitDataButton() {
  //Split data from the String Data
  valueButtonGlobal = int(split(fromController [0], '/')) ;
  // stick the Int(String) chain from the group object "one" and "two" is single chain integer(String).
  String fullChainValueButtonObj =("") ;
  for ( int i = 1 ; i <= NUM_GROUP ; i++ ) {
    fullChainValueButtonObj += fromController [i]+"/" ;
  }
  valueButtonObj = int(split(fullChainValueButtonObj, '/')) ;
}

// split data slider
void splitDataSlider() {
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
}


// split data boolean to give load or save order
void splitDataLoadSaveController() {
    // LOAD SAVE

  /*
  +1 for the global group
  *2 because there is one group for the button and an other one for the slider
  */
  int whichOne = (NUM_GROUP +1) *2 ;
  String [] booleanSave  ;

  booleanSave = split(fromController[whichOne], '/') ;
  // convert string to boolean
  load_SCENE_Setting_GLOBAL = Boolean.valueOf(booleanSave[0]).booleanValue();
  save_Current_SCENE_Setting_GLOBAL = Boolean.valueOf(booleanSave[1]).booleanValue();
  save_New_SCENE_Setting_GLOBAL = Boolean.valueOf(booleanSave[2]).booleanValue();
}



// TRANSFORM info from controler to use in the PRESCENE
void translateDataFromController () {

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
  which_cam = valueButtonGlobal[17] ;
  
  //OBJECTS
  for ( int i = 0 ; i < numObj-1 ; i++) {
    int iPlusOne = i+1 ;
    objectButton   [iPlusOne] = valueButtonObj[i *10 +1] ;
    parameterButton[iPlusOne] = valueButtonObj[i *10 +2] ;
    soundButton    [iPlusOne] = valueButtonObj[i *10 +3] ;
    actionButton   [iPlusOne] = valueButtonObj[i *10 +4] ;
    mode     [iPlusOne] = valueButtonObj[i *10 +9] ;
    if (objectButton[iPlusOne] == 1 ) show_object[iPlusOne] = true ; else show_object[iPlusOne] = false ;
    if (parameterButton[iPlusOne] == 1 ) parameter[iPlusOne] = true ; else parameter[iPlusOne] = false ;
    if (soundButton[iPlusOne] == 1 ) sound[iPlusOne] = true ; else sound[iPlusOne] = false ;
    if (actionButton[iPlusOne] == 1 ) action[iPlusOne] = true ; else action[iPlusOne] = false ;
  }

}

// END OSC RECEIVE
///////////////////