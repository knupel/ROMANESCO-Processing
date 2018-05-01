/**
OSC TERMINUS 
v 1.3.0
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
    catchDataFromController(m);
    data_controller_button();
    data_controller_slider();
    data_controller_save();
    controller_osc_is = true;
  } 
}

void prescene_reception(OscMessage m) {
  if(m.addrPattern().equals("Prescene")) {
    catchDataFromPrescene(m);
    data_osc_prescene = split(dataPrescene, '/') ;
    data_save_prescene();
  } 
}


void update_OSC_data() {
  translateDataFromController_buttonGlobal() ;
  translateDataFromController_buttonItem() ;
  translate_event_prescene() ;
}




// FROM PRESCENE
String dataPrescene = ("") ;
String from_prescene_boolean_load_save = ("") ;


void catchDataFromPrescene(OscMessage receive) {
  dataPrescene = receive.get(0).stringValue() ;
  path_to_load_scene_setting = receive.get(1).stringValue() ;
  from_prescene_boolean_load_save = receive.get(2).stringValue() ;
}







boolean load_SCENE_Setting_order_from_presecene, save_Current_SCENE_Setting_order_from_presecene, save_New_SCENE_Setting_order_from_presecene ;
void data_save_prescene() {
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
void translate_event_prescene() {
  if(data_osc_prescene[1].equals("0") ) key_a = false; else key_a = true;
  if(data_osc_prescene[2].equals("0") ) key_b = false; else key_b = true;
  if(data_osc_prescene[3].equals("0") ) key_c = false; else key_c = true;
  if(data_osc_prescene[4].equals("0") ) key_d = false; else key_d = true;
  if(data_osc_prescene[5].equals("0") ) key_e = false; else key_e = true;
  if(data_osc_prescene[6].equals("0") ) key_f = false; else key_f = true;
  if(data_osc_prescene[7].equals("0") ) key_g = false; else key_g = true;
  if(data_osc_prescene[8].equals("0") ) key_h = false; else key_h = true;
  if(data_osc_prescene[9].equals("0") ) key_i = false; else key_i = true;
  if(data_osc_prescene[10].equals("0") ) key_j = false; else key_j = true;
  if(data_osc_prescene[11].equals("0") ) key_k = false; else key_k = true;
  if(data_osc_prescene[12].equals("0") ) key_l = false; else key_l = true;
  if(data_osc_prescene[13].equals("0") ) key_m = false; else key_m = true;
  if(data_osc_prescene[14].equals("0") ) key_n = false; else key_n = true;
  if(data_osc_prescene[15].equals("0") ) key_o = false; else key_o = true;
  if(data_osc_prescene[16].equals("0") ) key_p = false; else key_p = true;
  if(data_osc_prescene[17].equals("0") ) key_q = false; else key_q = true;
  if(data_osc_prescene[18].equals("0") ) key_r = false; else key_r = true;
  if(data_osc_prescene[19].equals("0") ) key_s = false; else key_s = true;
  if(data_osc_prescene[20].equals("0") ) key_t = false; else key_t = true;
  if(data_osc_prescene[21].equals("0") ) key_u = false; else key_u = true;
  if(data_osc_prescene[22].equals("0") ) key_v = false; else key_v = true;
  if(data_osc_prescene[23].equals("0") ) key_w = false; else key_w = true;
  if(data_osc_prescene[24].equals("0") ) key_x = false; else key_x = true;
  if(data_osc_prescene[25].equals("0") ) key_y = false; else key_y = true;
  if(data_osc_prescene[26].equals("0") ) key_z = false; else key_z = true;

  if(data_osc_prescene[27].equals("0") ) key_A = false; else key_A = true;
  if(data_osc_prescene[28].equals("0") ) key_B = false; else key_B = true;
  if(data_osc_prescene[29].equals("0") ) key_C = false; else key_C = true;
  if(data_osc_prescene[30].equals("0") ) key_D = false; else key_D = true;
  if(data_osc_prescene[31].equals("0") ) key_E = false; else key_E = true;
  if(data_osc_prescene[32].equals("0") ) key_F = false; else key_F = true;
  if(data_osc_prescene[33].equals("0") ) key_G = false; else key_G = true;
  if(data_osc_prescene[34].equals("0") ) key_H = false; else key_H = true;
  if(data_osc_prescene[35].equals("0") ) key_I = false; else key_I = true;
  if(data_osc_prescene[36].equals("0") ) key_J = false; else key_J = true;
  if(data_osc_prescene[37].equals("0") ) key_K = false; else key_K = true;
  if(data_osc_prescene[38].equals("0") ) key_L = false; else key_L = true;
  if(data_osc_prescene[39].equals("0") ) key_M = false; else key_M = true;
  if(data_osc_prescene[40].equals("0") ) key_N = false; else key_N = true;
  if(data_osc_prescene[41].equals("0") ) key_O = false; else key_O = true;
  if(data_osc_prescene[42].equals("0") ) key_P = false; else key_P = true;
  if(data_osc_prescene[43].equals("0") ) key_Q = false; else key_Q = true;
  if(data_osc_prescene[44].equals("0") ) key_R = false; else key_R = true;
  if(data_osc_prescene[45].equals("0") ) key_S = false; else key_S = true;
  if(data_osc_prescene[46].equals("0") ) key_T = false; else key_T = true;
  if(data_osc_prescene[47].equals("0") ) key_U = false; else key_U = true;
  if(data_osc_prescene[48].equals("0") ) key_V = false; else key_V = true;
  if(data_osc_prescene[49].equals("0") ) key_W = false; else key_W = true;
  if(data_osc_prescene[50].equals("0") ) key_X = false; else key_X = true;
  if(data_osc_prescene[51].equals("0") ) key_Y = false; else key_Y = true;
  if(data_osc_prescene[52].equals("0") ) key_Z = false; else key_Z = true;
 
  if(data_osc_prescene[53].equals("0") ) key_1 = false; else key_1 = true;
  if(data_osc_prescene[54].equals("0") ) key_2 = false; else key_2 = true;
  if(data_osc_prescene[55].equals("0") ) key_3 = false; else key_3 = true;
  if(data_osc_prescene[56].equals("0") ) key_4 = false; else key_4 = true;
  if(data_osc_prescene[57].equals("0") ) key_5 = false; else key_5 = true;
  if(data_osc_prescene[58].equals("0") ) key_6 = false; else key_6 = true;
  if(data_osc_prescene[59].equals("0") ) key_7 = false; else key_7 = true;
  if(data_osc_prescene[60].equals("0") ) key_8 = false; else key_8 = true;
  if(data_osc_prescene[61].equals("0") ) key_9 = false; else key_9 = true;
  if(data_osc_prescene[62].equals("0") ) key_0 = false; else key_0 = true;

  if(data_osc_prescene[65].equals("0")) key_c_long = false; else key_c_long = true;
  if(data_osc_prescene[74].equals("0")) key_l_long = false; else key_l_long = true;
  if(data_osc_prescene[76].equals("0")) key_n_long = false; else key_n_long = true;
  if(data_osc_prescene[84].equals("0")) key_v_long = false; else key_v_long = true;
   
  // SPECIAL TOUCH
  if(data_osc_prescene[89].equals("0") ) key_space_long = false; else key_space_long = true;
  if(data_osc_prescene[90].equals("0")) key_shift_long = false; else key_shift_long = true;
  
  if(data_osc_prescene[100].equals("0") ) key_space = false; else key_space = true;
  if(data_osc_prescene[101].equals("0") ) key_enter = false; else key_enter = true;
  if(data_osc_prescene[102].equals("0") ) key_return = false; else key_return = true;
  if(data_osc_prescene[103].equals("0") ) key_delete = false; else key_delete = true;
  if(data_osc_prescene[104].equals("0") ) key_backspace = false; else key_backspace = true;
  if(data_osc_prescene[105].equals("0") ) key_alt = false; else key_alt = true;
  if(data_osc_prescene[106].equals("0") ) key_ctrl = false; else key_ctrl = true;
  if(data_osc_prescene[107].equals("0") ) key_cmd = false; else key_cmd = true;

  if(data_osc_prescene[108].equals("0") ) key_up = false; else key_up = true;
  if(data_osc_prescene[109].equals("0") ) key_down = false; else key_down = true;
  if(data_osc_prescene[110].equals("0") ) key_right = false; else key_right = true;
  if(data_osc_prescene[111].equals("0") ) key_left = false; else key_left = true;



  //PEN
  pen[0].x = Float.valueOf(data_osc_prescene[120].replaceAll(",",".")) ;
  pen[0].y = Float.valueOf(data_osc_prescene[121].replaceAll(",",".")) ;
  pen[0].z = Float.valueOf(data_osc_prescene[122].replaceAll(",",".")) ;
  // create a temp mouse pos, to temporize the difference of the frame rate between the Préscène and the Scène.

  float x = map(Float.valueOf(data_osc_prescene[123].replaceAll(",",".")),0,1,0, width);
  float y = map(Float.valueOf(data_osc_prescene[124].replaceAll(",",".")),0,1,0,height);
  float z = map(Float.valueOf(data_osc_prescene[125].replaceAll(",",".")),0,1,-750,750);
  // absolute mouse pos
  mouse[0].x = x +mouse[0].x *.5 ;
  mouse[0].y = y +mouse[0].y *.5 ;
  mouse[0].z = z +mouse[0].z *.5 ;
  // Mouse button
  if(data_osc_prescene[126].equals("0")) clickShortLeft[0] = false; else clickShortLeft[0] = true;
  if(data_osc_prescene[127].equals("0")) clickShortRight[0] = false; else clickShortRight[0] = true;
  if(data_osc_prescene[128].equals("0")) clickLongLeft[0] = false; else clickLongLeft[0] = true;
  if(data_osc_prescene[129].equals("0")) clickLongRight[0] = false; else clickLongRight[0] = true;
  //WHEEL
  wheel[0] = Integer.parseInt(data_osc_prescene[130]);
  

  // ORDER
  ///////////////
  if(data_osc_prescene[131].equals("0")) ORDER_ONE = false; else ORDER_ONE = true;
  if(data_osc_prescene[132].equals("0")) ORDER_TWO = false; else ORDER_TWO = true;
  if(data_osc_prescene[133].equals("0")) ORDER_THREE = false; else ORDER_THREE = true;
  if(data_osc_prescene[134].equals("0")) LEAPMOTION_DETECTED = false; else LEAPMOTION_DETECTED = true;
}


/*
void translate_other_event_prescene() {
  // long mouse event

}
*/