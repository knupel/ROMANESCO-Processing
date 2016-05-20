/**
OSC TERMINUS 1.0.1
*/

OscP5 osc_1, osc_2;
//SETUP
void OSC_setup() {
  osc_1 = new OscP5(this, 9000);
  if(miroir_on_off) osc_2 = new OscP5(this, 9002); 
  else osc_2 = new OscP5(this, 9001);
}

void oscEvent(OscMessage receive) {
  if(receive.addrPattern().equals("Controller")) {
    catchDataFromController(receive) ;
    splitDataButton() ;
    splitDataSlider() ;
    splitDataLoadSaveController() ;
  }
  if(receive.addrPattern().equals("Prescene")) {
    catchDataFromPrescene(receive) ;
    splitDataFromPrescene() ;
    splitDataLoadSavePrescene() ;
  }
}

void update_OSC_data() {
  translateDataFromController_buttonGlobal() ;
  translateDataFromController_buttonItem() ;
  translateDataFromPrescene() ;
}

// FROM CONTROLLER
/**
look in the tab Z_OSC
*/


// FROM PRESCENE
String dataPrescene = ("") ;
String from_prescene_boolean_load_save = ("") ;

void catchDataFromPrescene(OscMessage receive) {
  dataPrescene = receive.get(0).stringValue() ;
  path_to_load_scene_setting = receive.get(1).stringValue() ;
  from_prescene_boolean_load_save = receive.get(2).stringValue() ;
}



void splitDataFromPrescene() {
  valueTempPrescene = split(dataPrescene, '/') ;
  // translate the String value to the float var to use
  for ( int i = 0 ; i < NUM_GROUP+1 ; i++ ) {
    // security because there not same quantity of slider in the group one and the other group
    int n = 0 ;
    if ( i < 1 ) n = NUM_SLIDER_MISC ; else n = NUM_SLIDER_OBJ ;
    for (int j = 0 ; j < n ; j++) {
      valueSlider[i][j] = Float.valueOf(valueSliderTemp[i][j]) ;
    }
  }
}


boolean load_SCENE_Setting_order_from_presecene, save_Current_SCENE_Setting_order_from_presecene, save_New_SCENE_Setting_order_from_presecene ;
void splitDataLoadSavePrescene() {
  String [] booleanSave  ;
  
  booleanSave = split(from_prescene_boolean_load_save, '/') ;
  // convert string to boolean
  load_SCENE_Setting_order_from_presecene = Boolean.valueOf(booleanSave[0]).booleanValue();
  save_Current_SCENE_Setting_order_from_presecene = Boolean.valueOf(booleanSave[1]).booleanValue();
  save_New_SCENE_Setting_order_from_presecene = Boolean.valueOf(booleanSave[2]).booleanValue();
}







void translateDataFromPrescene() {
    // Info distribution

  // SHORT EVENT
  ///////////////
  if(valueTempPrescene[0].equals("0") ) spaceTouch = false ; else spaceTouch = true ;  
  
  if(valueTempPrescene[1].equals("0") ) aTouch = false ; else aTouch = true ;
  if(valueTempPrescene[2].equals("0") ) bTouch = false ; else bTouch = true ;
  if(valueTempPrescene[3].equals("0") ) cTouch = false ; else cTouch = true ;
  if(valueTempPrescene[4].equals("0") ) dTouch = false ; else dTouch = true ;
  if(valueTempPrescene[5].equals("0") ) eTouch = false ; else eTouch = true ;
  if(valueTempPrescene[6].equals("0") ) fTouch = false ; else fTouch = true ;
  if(valueTempPrescene[7].equals("0") ) gTouch = false ; else gTouch = true ;
  if(valueTempPrescene[8].equals("0") ) hTouch = false ; else hTouch = true ;
  if(valueTempPrescene[9].equals("0") ) iTouch = false ; else iTouch = true ;
  if(valueTempPrescene[10].equals("0") ) jTouch = false ; else jTouch = true ;
  if(valueTempPrescene[11].equals("0") ) kTouch = false ; else kTouch = true ;
  if(valueTempPrescene[12].equals("0") ) lTouch = false ; else lTouch = true ;
  if(valueTempPrescene[13].equals("0") ) mTouch = false ; else mTouch = true ;
  if(valueTempPrescene[14].equals("0") ) nTouch = false ; else nTouch = true ;
  if(valueTempPrescene[15].equals("0") ) oTouch = false ; else oTouch = true ;
  if(valueTempPrescene[16].equals("0") ) pTouch = false ; else pTouch = true ;
  if(valueTempPrescene[17].equals("0") ) qTouch = false ; else qTouch = true ;
  if(valueTempPrescene[18].equals("0") ) rTouch = false ; else rTouch = true ;
  if(valueTempPrescene[19].equals("0") ) sTouch = false ; else sTouch = true ;
  if(valueTempPrescene[20].equals("0") ) tTouch = false ; else tTouch = true ;
  if(valueTempPrescene[21].equals("0") ) uTouch = false ; else uTouch = true ;
  if(valueTempPrescene[22].equals("0") ) vTouch = false ; else vTouch = true ;
  if(valueTempPrescene[23].equals("0") ) wTouch = false ; else wTouch = true ;
  if(valueTempPrescene[24].equals("0") ) xTouch = false ; else xTouch = true ;
  if(valueTempPrescene[25].equals("0") ) yTouch = false ; else yTouch = true ;
  if(valueTempPrescene[26].equals("0") ) zTouch = false ; else zTouch = true ;
  /**
  Change the valueTempPrescene[n] to be independant of the Prescene ans the his low frameRate for the boolean refresh
  */
  //println("Scene", rTouch, valueTempPrescene[18], frameCount) ;

  
  if(valueTempPrescene[30].equals("0") ) enterTouch = false ; else enterTouch = true ;
  if(valueTempPrescene[31].equals("0") ) deleteTouch = false ; else deleteTouch = true ;
  if(valueTempPrescene[32].equals("0") ) backspaceTouch = false ; else backspaceTouch = true ;
  if(valueTempPrescene[33].equals("0") ) upTouch = false ; else upTouch = true ;
  if(valueTempPrescene[34].equals("0") ) downTouch = false ; else downTouch = true ;
  if(valueTempPrescene[35].equals("0") ) rightTouch = false ; else rightTouch = true ;
  if(valueTempPrescene[36].equals("0") ) leftTouch = false ; else leftTouch = true ;
  if(valueTempPrescene[37].equals("0") ) ctrlTouch = false ; else ctrlTouch = true ;

    //number key
  if(valueTempPrescene[51].equals("0") ) touch1 = false ; else touch1 = true ;
  if(valueTempPrescene[52].equals("0") ) touch2 = false ; else touch2 = true ;
  if(valueTempPrescene[53].equals("0") ) touch3 = false ; else touch3 = true ;
  if(valueTempPrescene[54].equals("0") ) touch4 = false ; else touch4 = true ;
  if(valueTempPrescene[55].equals("0") ) touch5 = false ; else touch5 = true ;
  if(valueTempPrescene[56].equals("0") ) touch6 = false ; else touch6 = true ;
  if(valueTempPrescene[57].equals("0") ) touch7 = false ; else touch7 = true ;
  if(valueTempPrescene[58].equals("0") ) touch8 = false ; else touch8 = true ;
  if(valueTempPrescene[59].equals("0") ) touch9 = false ; else touch9 = true ;
  if(valueTempPrescene[60].equals("0") ) touch0 = false ; else touch0 = true ;
  // END SHORT KEY EVENT
  //////////////////////




  

  
  


  // Longtime event
  /////////////////
  // long mouse event
  if(valueTempPrescene[48].equals("0") ) clickLongLeft[0] = false ; else clickLongLeft[0] = true ;
  if(valueTempPrescene[49].equals("0") ) clickLongRight[0] = false ; else clickLongRight[0] = true ;
  // long key event
  if(valueTempPrescene[61].equals("0")) cLongTouch = false ; else cLongTouch = true ;
  if(valueTempPrescene[62].equals("0")) lLongTouch = false ; else lLongTouch = true ;
  if(valueTempPrescene[63].equals("0")) nLongTouch = false ; else nLongTouch = true ;
  if(valueTempPrescene[64].equals("0")) vLongTouch = false ; else vLongTouch = true ;

  if(valueTempPrescene[65].equals("0")) shiftLongTouch = false ; else shiftLongTouch = true ;
  
  





  // MOUSE EVENT
  //PEN
  pen[0].x = Float.valueOf(valueTempPrescene[40].replaceAll(",", ".")) ;
  pen[0].y = Float.valueOf(valueTempPrescene[41].replaceAll(",", ".")) ;
  pen[0].z = Float.valueOf(valueTempPrescene[42].replaceAll(",", ".")) ;
  
  //MOUSE
  // create a temp mouse pos, to temporize the difference of the frame rate between the Préscène and the Scène.
  PVector target_pos = new PVector() ;
  target_pos.x = map(Float.valueOf(valueTempPrescene[43].replaceAll(",", ".")), 0,1,0, width) ;
  target_pos.y = map(Float.valueOf(valueTempPrescene[44].replaceAll(",", ".")), 0, 1, 0,height) ;
  target_pos.z = map(Float.valueOf(valueTempPrescene[45].replaceAll(",", ".")), 0, 1, -750,750) ;
  // absolute mouse pos
  mouse[0].x = target_pos.x +mouse[0].x *.5 ;
  mouse[0].y = target_pos.y +mouse[0].y *.5 ;
  mouse[0].z = target_pos.z +mouse[0].z *.5 ;

 //  if(cLongTouch) mouseCamera.set(mouse[0]) ;


  // Mouse button
  if(valueTempPrescene[46].equals("0") ) clickShortLeft[0] = false ; else clickShortLeft[0] = true ;
  if(valueTempPrescene[47].equals("0") ) clickShortRight[0] = false ; else clickShortRight[0] = true ;

  
  //WHEEL
  wheel[0] = Integer.parseInt(valueTempPrescene[50]) ;
  //END MOUSE, CURSOR, PEN


  







  // ORDER
  ///////////////
  if(valueTempPrescene[70].equals("0")) ORDER_ONE = false ; else ORDER_ONE = true ;
  if(valueTempPrescene[71].equals("0")) ORDER_TWO = false ; else ORDER_TWO = true ;
  if(valueTempPrescene[72].equals("0")) ORDER_THREE = false ; else ORDER_THREE = true ;
  if(valueTempPrescene[73].equals("0")) LEAPMOTION_DETECTED = false ; else LEAPMOTION_DETECTED = true ;
}