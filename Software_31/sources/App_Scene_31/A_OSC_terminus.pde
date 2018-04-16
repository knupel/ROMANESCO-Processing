/**
OSC TERMINUS 
v 1.2.0
*/

OscP5 osc_receive_controller, osc_receive_prescene ;

/**
OSC setup 
v 1.1.0
*/
void OSC_setup() {
  int port_controller = 9_500 ;
  int port_receive_scene = 9_100 ;

  osc_receive_controller = new OscP5(this, port_controller);
  osc_receive_prescene = new OscP5(this, port_receive_scene) ;

  try { 
    Thread.sleep(6000); 
  } 
  catch (InterruptedException e) { 
  }
  println("OSC setup done") ;
}


/**
OSC receive
*/

int security_to_dont_duplicate_osc_packet ;

void oscEvent(OscMessage receive) {
 
 if(security_to_dont_duplicate_osc_packet != frameCount) {
    controller_reception(receive) ;
    prescene_reception(receive) ; 
  }
  security_to_dont_duplicate_osc_packet = frameCount ;
}

boolean controller_osc_is = false ;
void controller_reception(OscMessage m) {
  if(m.addrPattern().equals("Controller")) {
    catchDataFromController(m) ;
    splitDataButton() ;
    splitDataSlider() ;
    splitDataLoadSaveController() ;
    controller_osc_is = true ;
  } 
}




void prescene_reception(OscMessage m) {
  if(m.addrPattern().equals("Prescene")) {
    catchDataFromPrescene(m) ;
    splitDataFromPrescene() ;
    splitDataLoadSavePrescene() ;
  } 
}


void update_OSC_data() {
  translateDataFromController_buttonGlobal() ;
  translateDataFromController_buttonItem() ;

  translate_short_event_prescene() ;
  translate_other_event_prescene() ;
}




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




/**
translate event
*/
void translate_short_event_prescene() {

  if(valueTempPrescene[0].equals("0") ) key_space_long = false ; else key_space_long = true ;  
  
  if(valueTempPrescene[1].equals("0") ) key_a = false ; else key_a = true ;
  if(valueTempPrescene[2].equals("0") ) key_b = false ; else key_b = true ;
  if(valueTempPrescene[3].equals("0") ) key_c = false ; else key_c = true ;
  if(valueTempPrescene[4].equals("0") ) key_d = false ; else key_d = true ;
  if(valueTempPrescene[5].equals("0") ) key_e = false ; else key_e = true ;
  if(valueTempPrescene[6].equals("0") ) key_f = false ; else key_f = true ;
  if(valueTempPrescene[7].equals("0") ) key_g = false ; else key_g = true ;
  if(valueTempPrescene[8].equals("0") ) key_h = false ; else key_h = true ;
  if(valueTempPrescene[9].equals("0") ) key_i = false ; else key_i = true ;
  if(valueTempPrescene[10].equals("0") ) key_j = false ; else key_j = true ;
  if(valueTempPrescene[11].equals("0") ) key_k = false ; else key_k = true ;
  if(valueTempPrescene[12].equals("0") ) key_l = false ; else key_l = true ;
  if(valueTempPrescene[13].equals("0") ) key_m = false ; else key_m = true ;
  if(valueTempPrescene[14].equals("0") ) key_n = false ; else key_n = true ;
  if(valueTempPrescene[15].equals("0") ) key_o = false ; else key_o = true ;
  if(valueTempPrescene[16].equals("0") ) key_p = false ; else key_p = true ;
  if(valueTempPrescene[17].equals("0") ) key_q = false ; else key_q = true ;
  if(valueTempPrescene[18].equals("0") ) key_r = false ; else key_r = true ;
  if(valueTempPrescene[19].equals("0") ) key_s = false ; else key_s = true ;
  if(valueTempPrescene[20].equals("0") ) key_t = false ; else key_t = true ;
  if(valueTempPrescene[21].equals("0") ) key_u = false ; else key_u = true ;
  if(valueTempPrescene[22].equals("0") ) key_v = false ; else key_v = true ;
  if(valueTempPrescene[23].equals("0") ) key_w = false ; else key_w = true ;
  if(valueTempPrescene[24].equals("0") ) key_x = false ; else key_x = true ;
  if(valueTempPrescene[25].equals("0") ) key_y = false ; else key_y = true ;
  if(valueTempPrescene[26].equals("0") ) key_z = false ; else key_z = true ;
 
  if(valueTempPrescene[30].equals("0") ) key_enter = false ; else key_enter = true ;
  if(valueTempPrescene[31].equals("0") ) key_delete = false ; else key_delete = true ;
  if(valueTempPrescene[32].equals("0") ) key_backspace = false ; else key_backspace = true ;
  if(valueTempPrescene[33].equals("0") ) key_up = false ; else key_up = true ;
  if(valueTempPrescene[34].equals("0") ) key_down = false ; else key_down = true ;
  if(valueTempPrescene[35].equals("0") ) key_right = false ; else key_right = true ;
  if(valueTempPrescene[36].equals("0") ) key_left = false ; else key_left = true ;
  if(valueTempPrescene[37].equals("0") ) key_ctrl = false ; else key_ctrl = true ;

  /*
  from 40
  to 50
  it's other event method
  */

  if(valueTempPrescene[51].equals("0") ) key_1 = false ; else key_1 = true ;
  if(valueTempPrescene[52].equals("0") ) key_2 = false ; else key_2 = true ;
  if(valueTempPrescene[53].equals("0") ) key_3 = false ; else key_3 = true ;
  if(valueTempPrescene[54].equals("0") ) key_4 = false ; else key_4 = true ;
  if(valueTempPrescene[55].equals("0") ) key_5 = false ; else key_5 = true ;
  if(valueTempPrescene[56].equals("0") ) key_6 = false ; else key_6 = true ;
  if(valueTempPrescene[57].equals("0") ) key_7 = false ; else key_7 = true ;
  if(valueTempPrescene[58].equals("0") ) key_8 = false ; else key_8 = true ;
  if(valueTempPrescene[59].equals("0") ) key_9 = false ; else key_9 = true ;
  if(valueTempPrescene[60].equals("0") ) key_0 = false ; else key_0 = true ;

  /*
  from 61
  to 73
  it's other event method
  */
}



void translate_other_event_prescene() {
  // long mouse event
  if(valueTempPrescene[48].equals("0") ) clickLongLeft[0] = false ; else clickLongLeft[0] = true ;
  if(valueTempPrescene[49].equals("0") ) clickLongRight[0] = false ; else clickLongRight[0] = true ;
  // long key event
  if(valueTempPrescene[61].equals("0")) key_c_long = false ; else key_c_long = true ;
  if(valueTempPrescene[62].equals("0")) key_l_long = false ; else key_l_long = true ;
  if(valueTempPrescene[63].equals("0")) key_n_long = false ; else key_n_long = true ;
  if(valueTempPrescene[64].equals("0")) key_v_long = false ; else key_v_long = true ;

  if(valueTempPrescene[65].equals("0")) key_shift_long = false ; else key_shift_long = true ;
  
  


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

 //  if(key_c_long) mouseCamera.set(mouse[0]) ;


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