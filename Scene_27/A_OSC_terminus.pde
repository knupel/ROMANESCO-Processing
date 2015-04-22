OscP5 osc;
//SETUP
void OSCSetup() {
   if(syphon) osc = new OscP5(this, 10002); else osc = new OscP5(this, 10001);
}

//EVENT
int numOfPartSendByPrescene = 7 ; 
// this num is equal of the part from Controller plus One part of the prescene with information catch in Prescene : mouse, leap...
String dataPreScene [] = new String[numOfPartSendByPrescene] ;




// to check what else is receive by the receiver
void oscEvent(OscMessage receive ) {
  
  
  // split all info from Prescene
  String sizeInfoReception = ("") ;
  for (int i = 0 ; i < dataPreScene.length ; i++ ) {
    dataPreScene [i] = receive.get(i).stringValue() ;
    sizeInfoReception += dataPreScene [i] ;
    
  }
  
    
  // Catch the particular info 
  //BUTTON
  /* split String value from controler */
  valueButtonGlobal = int(split(dataPreScene[0], '/')) ;
  // stick the Int(String) chain from the group one, two and three is single chain integer(String).
  String fullChainValueButtonObj =("") ;
  for ( int i = 1 ; i <= NUM_GROUP ; i++ ) {
    fullChainValueButtonObj += dataPreScene[i]+"/" ;
  }
  valueButtonObj = int(split(fullChainValueButtonObj, '/')) ;
  
  //SLIDER
  /* split String value from controler */
  int numGroupTotal = NUM_GROUP+1 ;
  for ( int i = 0 ; i < numGroupTotal ; i++ ) {
    valueSliderTemp [i] = split(dataPreScene[i+numGroupTotal], '/') ;
    
  }
  
  //PRESCENE
  /* split info, we catch here the lat port of OSC info */
  valueTempPreScene = split(dataPreScene[numOfPartSendByPrescene -1], '/') ;
  // translate the String value to the float var to use
  for ( int i = 0 ; i < NUM_GROUP+1 ; i++ ) {
    // security because there not same quantity of slider in the group one and the other group
    int n = 0 ;
    if ( i < 1 ) n = NUM_SLIDER_MISC ; else n = NUM_SLIDER_OBJ ;
    for (int j = 0 ; j < n ; j++) {
      valueSlider[i][j] = Float.valueOf(valueSliderTemp[i][j]) ;
    }
  }
  


  
  // Info distribution
  if(valueTempPreScene[0].equals("0") ) spaceTouch = false ; else spaceTouch = true ;  
  
  if(valueTempPreScene[1].equals("0") ) aTouch = false ; else aTouch = true ;
  if(valueTempPreScene[2].equals("0") ) bTouch = false ; else bTouch = true ;
  if(valueTempPreScene[3].equals("0") ) cTouch = false ; else cTouch = true ;
  if(valueTempPreScene[4].equals("0") ) dTouch = false ; else dTouch = true ;
  if(valueTempPreScene[5].equals("0") ) eTouch = false ; else eTouch = true ;
  if(valueTempPreScene[6].equals("0") ) fTouch = false ; else fTouch = true ;
  if(valueTempPreScene[7].equals("0") ) gTouch = false ; else gTouch = true ;
  if(valueTempPreScene[8].equals("0") ) hTouch = false ; else hTouch = true ;
  if(valueTempPreScene[9].equals("0") ) iTouch = false ; else iTouch = true ;
  if(valueTempPreScene[10].equals("0") ) jTouch = false ; else jTouch = true ;
  if(valueTempPreScene[11].equals("0") ) kTouch = false ; else kTouch = true ;
  if(valueTempPreScene[12].equals("0") ) lTouch = false ; else lTouch = true ;
  if(valueTempPreScene[13].equals("0") ) mTouch = false ; else mTouch = true ;
  if(valueTempPreScene[14].equals("0") ) nTouch = false ; else nTouch = true ;
  if(valueTempPreScene[15].equals("0") ) oTouch = false ; else oTouch = true ;
  if(valueTempPreScene[16].equals("0") ) pTouch = false ; else pTouch = true ;
  if(valueTempPreScene[17].equals("0") ) qTouch = false ; else qTouch = true ;
  if(valueTempPreScene[18].equals("0") ) rTouch = false ; else rTouch = true ;
  if(valueTempPreScene[19].equals("0") ) sTouch = false ; else sTouch = true ;
  if(valueTempPreScene[20].equals("0") ) tTouch = false ; else tTouch = true ;
  if(valueTempPreScene[21].equals("0") ) uTouch = false ; else uTouch = true ;
  if(valueTempPreScene[22].equals("0") ) vTouch = false ; else vTouch = true ;
  if(valueTempPreScene[23].equals("0") ) wTouch = false ; else wTouch = true ;
  if(valueTempPreScene[24].equals("0") ) xTouch = false ; else xTouch = true ;
  if(valueTempPreScene[25].equals("0") ) yTouch = false ; else yTouch = true ;
  if(valueTempPreScene[26].equals("0") ) zTouch = false ; else zTouch = true ;

  
  if(valueTempPreScene[30].equals("0") ) enterTouch = false ; else enterTouch = true ;
  if(valueTempPreScene[31].equals("0") ) deleteTouch = false ; else deleteTouch = true ;
  if(valueTempPreScene[32].equals("0") ) backspaceTouch = false ; else backspaceTouch = true ;
  if(valueTempPreScene[33].equals("0") ) upTouch = false ; else upTouch = true ;
  if(valueTempPreScene[34].equals("0") ) downTouch = false ; else downTouch = true ;
  if(valueTempPreScene[35].equals("0") ) rightTouch = false ; else rightTouch = true ;
  if(valueTempPreScene[36].equals("0") ) leftTouch = false ; else leftTouch = true ;
  if(valueTempPreScene[37].equals("0") ) ctrlTouch = false ; else ctrlTouch = true ;

  //MOUSE, CURSOR, PEN
  //PMOUSE
  // line for the camera Pmouse, i don't understand why we need this temp var
  if(cLongTouch) {
    pmouseCamera.x = map(Float.valueOf(valueTempPreScene[38].replaceAll(",", ".")), 0,1,0, width) ;
    pmouseCamera.y = map(Float.valueOf(valueTempPreScene[39].replaceAll(",", ".")), 0,1,0,height) ;
  }
  //
  pmouse[0].x = map(Float.valueOf(valueTempPreScene[38].replaceAll(",", ".")), 0,1,0, width) ;
  pmouse[0].y = map(Float.valueOf(valueTempPreScene[39].replaceAll(",", ".")), 0,1,0,height) ;

  //PEN
  pen[0].x = Float.valueOf(valueTempPreScene[40].replaceAll(",", ".")) ;
  pen[0].y = Float.valueOf(valueTempPreScene[41].replaceAll(",", ".")) ;
  pen[0].z = Float.valueOf(valueTempPreScene[42].replaceAll(",", ".")) ;
  
  //MOUSE
  // line for the camera
  if(cLongTouch) {
    mouseCamera.x = map(Float.valueOf(valueTempPreScene[43].replaceAll(",", ".")), 0,1,0, width) ;
    mouseCamera.y = map(Float.valueOf(valueTempPreScene[44].replaceAll(",", ".")), 0, 1, 0,height) ;
    mouseCamera.z = map(Float.valueOf(valueTempPreScene[45].replaceAll(",", ".")), 0, 1, -750,750) ;
  }
  mouse[0].x = map(Float.valueOf(valueTempPreScene[43].replaceAll(",", ".")), 0,1,0, width) ;
  mouse[0].y = map(Float.valueOf(valueTempPreScene[44].replaceAll(",", ".")), 0, 1, 0,height) ;
  mouse[0].z = map(Float.valueOf(valueTempPreScene[45].replaceAll(",", ".")), 0, 1, -750,750) ;
  
  //BUTTON
  if(valueTempPreScene[46].equals("0") ) clickShortLeft[0] = false ; else clickShortLeft[0] = true ;
  if(valueTempPreScene[47].equals("0") ) clickShortRight[0] = false ; else clickShortRight[0] = true ;
  if(valueTempPreScene[48].equals("0") ) clickLongLeft[0] = false ; else clickLongLeft[0] = true ;
  if(valueTempPreScene[49].equals("0") ) clickLongRight[0] = false ; else clickLongRight[0] = true ;
  
  //WHEEL
  wheel[0] = Integer.parseInt(valueTempPreScene[50]) ;
  //END MOUSE, CURSOR, PEN
  
  //number key
  if(valueTempPreScene[51].equals("0") ) touch1 = false ; else touch1 = true ;
  if(valueTempPreScene[52].equals("0") ) touch2 = false ; else touch2 = true ;
  if(valueTempPreScene[53].equals("0") ) touch3 = false ; else touch3 = true ;
  if(valueTempPreScene[54].equals("0") ) touch4 = false ; else touch4 = true ;
  if(valueTempPreScene[55].equals("0") ) touch5 = false ; else touch5 = true ;
  if(valueTempPreScene[56].equals("0") ) touch6 = false ; else touch6 = true ;
  if(valueTempPreScene[57].equals("0") ) touch7 = false ; else touch7 = true ;
  if(valueTempPreScene[58].equals("0") ) touch8 = false ; else touch8 = true ;
  if(valueTempPreScene[59].equals("0") ) touch9 = false ; else touch9 = true ;
  if(valueTempPreScene[60].equals("0") ) touch0 = false ; else touch0 = true ;
  
  // Long Touch
  if(valueTempPreScene[61].equals("0")) cLongTouch = false ; else cLongTouch = true ;
  if(valueTempPreScene[62].equals("0")) lLongTouch = false ; else lLongTouch = true ;
  if(valueTempPreScene[63].equals("0")) nLongTouch = false ; else nLongTouch = true ;
  if(valueTempPreScene[64].equals("0")) vLongTouch = false ; else vLongTouch = true ;
  
  //ORDER
  if(valueTempPreScene[70].equals("0")) ORDER_ONE = false ; else ORDER_ONE = true ;
  if(valueTempPreScene[71].equals("0")) ORDER_TWO = false ; else ORDER_TWO = true ;
  if(valueTempPreScene[72].equals("0")) ORDER_THREE = false ; else ORDER_THREE = true ;
  if(valueTempPreScene[73].equals("0")) LEAPMOTION_DETECTED = false ; else LEAPMOTION_DETECTED = true ;

}


//DRAW
void OSCDraw() {
  //GLOBAL
  if(valueButtonGlobal.length > 0 || valueButtonObj.length > 0 ) {
    eBeat = valueButtonGlobal[1] ;
    eKick = valueButtonGlobal[2] ;
    eSnare = valueButtonGlobal[3] ;
    eHat = valueButtonGlobal[4] ;
    
    whichFont(valueButtonGlobal[5]) ;
    eCurtain = valueButtonGlobal[6] ;
    
    eBackground = valueButtonGlobal[7] ;
    
    eLightOne = valueButtonGlobal[8] ;
    eLightTwo = valueButtonGlobal[9] ;
    eLightAmbient = valueButtonGlobal[10] ;
    eLightOneAction = valueButtonGlobal[11] ;
    eLightTwoAction = valueButtonGlobal[12] ;
    eLightAmbientAction = valueButtonGlobal[13] ;
    
    whichShader = valueButtonGlobal[14] ;
    whichImage [0] = valueButtonGlobal[15] ;
    whichText [0] = valueButtonGlobal[16] ;
  
    //OBJECT
    for ( int i = 0 ; i < numObj-1 ; i++) {
      int iPlusOne = i+1 ;
      objectButton   [i +1] = valueButtonObj[i *10 +1] ;
      parameterButton[i +1] = valueButtonObj[i *10 +2] ;
      soundButton    [i +1] = valueButtonObj[i *10 +3] ;
      actionButton   [i +1] = valueButtonObj[i *10 +4] ;
      mode           [i +1] = valueButtonObj[i *10 +9] ;
      //create the boolean
      if (objectButton[iPlusOne] == 1 ) object[iPlusOne] = true ; else object[iPlusOne] = false ;
      if (parameterButton[iPlusOne] == 1 ) parameter[iPlusOne] = true ; else parameter[iPlusOne] = false ;
      if (soundButton[iPlusOne] == 1 ) sound[iPlusOne] = true ; else sound[iPlusOne] = false ;
      if (actionButton[iPlusOne] == 1 ) action[iPlusOne] = true ; else action[iPlusOne] = false ;
    }
  }
}
