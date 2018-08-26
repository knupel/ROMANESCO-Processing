/**
OSC Prescene 
2014 - 2018
v 1.3.0.1
*/
NetAddress [] ad_scene ;
String [] ID_address_scene ;
String toScene = ("Message from Prescene to Scene") ;
OscP5 osc_send_scene;

int port_send_scene = 9_100 ;

void OSC_send_scene_setup() {
  OSC_thread_send_scene_setup();
  println("send OSC setup done");
}

void OSC_thread_send_scene_setup() {
  osc_send_scene = new OscP5(this, port_send_scene);
  //send
  if (!DEV_MODE) {
    String [] addressIP = loadStrings(preference_path+"network/IP_address_mirror.txt") ;
    String join_address = join(addressIP,"") ;
    String [] temp = split(join_address,"/") ;

    int num_valid_address = 0 ;
    for(int i = 0 ; i < temp.length ; i++) {
      if(temp[i].equals("IP_address") || temp[i].equals("")) {
        // nothing happens
      } else {
        num_valid_address ++ ;
      }   
    }
    if (youCanSendToScene) {
      ID_address_scene = new String[num_valid_address] ;
      ad_scene = new NetAddress[num_valid_address] ;
    }
    
    for(int i = 0 ; i < num_valid_address ; i++) {
      ID_address_scene[i] = temp[i+1] ;
    }

    for(int i = 0 ; i < ad_scene.length ; i++) {
      ad_scene[i] = new NetAddress(ID_address_scene[i], port_send_scene);
    }
  }

  if(LIVE) {
    for(int i = 0 ; i < data_osc_prescene.length ; i++) {
      data_osc_prescene[i] = "0";
    }
  }
}


boolean send_message_is ;
boolean send_message_is() {
  return send_message_is;
}

void send_message(boolean send_message_is) {
  this.send_message_is = send_message_is;
}

/*
void oscEvent(OscMessage receive) {
  println("void oscEvent(OscMessage receive):",receive.addrPattern(),frameCount);
  if(receive.addrPattern().equals("Controller general")) {
    thread_data_controller_general(receive);
  }

  if(receive.addrPattern().equals("Controller item")) {
    thread_data_controller_item(receive);
  }
}
*/







/**
OSC send
v 1.0.1
*/
void OSC_send() {
  OscMessage RomanescoScene = new OscMessage("Prescene");
  bool_load_save_scene() ;

  //SEND data to SCENE
  RomanescoScene.add(toScene);

  // send the load path to the scene to also open the save setting in the scene with only one opening window input
  RomanescoScene.add(path_to_load_scene_setting) ;
  // reset the path for the next send, because the Scene check this path, to know if this one is not null,
  // and if this one is not null, the Scene load data.
  path_to_load_scene_setting = ("") ;

  RomanescoScene.add(booleanLoadSave) ;

  //send
 // if(target_scene);
  if(ad_scene == null) {
    printErr("Prescene app exit because the global variable 'DEVELOPMENT_MODE' must be false");
    exit();
  } else {
    if(MIROIR) {
      for(int i = 0 ; i < ad_scene.length ; i++) {
        println("void OSC_send():",ad_scene[i]);
        osc_send_scene.send(RomanescoScene, ad_scene[i]);
      } 
    } else if(!MIROIR) {
      osc_send_scene.send(RomanescoScene, ad_scene[0]);
    }  
  }
}











/**
OSC load
V 1.0.0
*/
String booleanLoadSave = ("") ;

void bool_load_save_scene() {
  boolean load, save_current, save_new ;

  if (load_SCENE_Setting_GLOBAL || load_Scene_Setting_local) {
    load = true ; 
  } else {
    load = false ;
  }

  if (save_Current_SCENE_Setting_GLOBAL || save_Current_Scene_Setting_local) {
    save_current = true ; 
  } else {
    save_current = false ;
  }

  if (save_New_SCENE_Setting_GLOBAL || save_New_Scene_Setting_local) {
    save_new = true ;
  } else {
    save_new = false ;
  }

  String load_string = String.valueOf(load) ;
  String saveCurrent_string = String.valueOf(save_current) ;
  String saveNew_string = String.valueOf(save_new) ;

  // we change to false boolean load and data to false each 1 second to have a time to load and save
  if(frameCount%60 == 0) { 
    load_SCENE_Setting_GLOBAL = save_Current_SCENE_Setting_GLOBAL = save_New_SCENE_Setting_GLOBAL = false ;
    load_Scene_Setting_local = save_Current_Scene_Setting_local = save_New_Scene_Setting_local = false ;
  }

  booleanLoadSave = load_string + "/" +  saveCurrent_string + "/" + saveNew_string ;
}















/**
OSC write
v 1.0.1
*/
void write_osc_event() {
  if (key_a) data_osc_prescene [1] = ("1"); else data_osc_prescene [1] = ("0");
  if (key_b) data_osc_prescene [2] = ("1"); else data_osc_prescene [2] = ("0");
  if (key_c) data_osc_prescene [3] = ("1"); else data_osc_prescene [3] = ("0");
  if (key_d) data_osc_prescene [4] = ("1"); else data_osc_prescene [4] = ("0");
  if (key_e) data_osc_prescene [5] = ("1"); else data_osc_prescene [5] = ("0");
  if (key_f) data_osc_prescene [6] = ("1"); else data_osc_prescene [6] = ("0");
  if (key_g) data_osc_prescene [7] = ("1"); else data_osc_prescene [7] = ("0");
  if (key_h) data_osc_prescene [8] = ("1"); else data_osc_prescene [8] = ("0");
  if (key_i) data_osc_prescene [9] = ("1"); else data_osc_prescene [9] = ("0");
  if (key_j) data_osc_prescene [10] = ("1"); else data_osc_prescene [10] = ("0");
  if (key_k) data_osc_prescene [11] = ("1"); else data_osc_prescene [11] = ("0");
  if (key_l) data_osc_prescene [12] = ("1"); else data_osc_prescene [12] = ("0");
  if (key_m) data_osc_prescene [13] = ("1"); else data_osc_prescene [13] = ("0");
  if (key_n) data_osc_prescene [14] = ("1"); else data_osc_prescene [14] = ("0");
  if (key_o) data_osc_prescene [15] = ("1"); else data_osc_prescene [15] = ("0");
  if (key_p) data_osc_prescene [16] = ("1"); else data_osc_prescene [16] = ("0");
  if (key_q) data_osc_prescene [17] = ("1"); else data_osc_prescene [17] = ("0");
  if (key_r) data_osc_prescene [18] = ("1"); else data_osc_prescene [18] = ("0");
  if (key_s) data_osc_prescene [19] = ("1"); else data_osc_prescene [19] = ("0");
  if (key_t) data_osc_prescene [20] = ("1"); else data_osc_prescene [20] = ("0");
  if (key_u) data_osc_prescene [21] = ("1"); else data_osc_prescene [21] = ("0");
  if (key_v) data_osc_prescene [22] = ("1"); else data_osc_prescene [22] = ("0");
  if (key_w) data_osc_prescene [23] = ("1"); else data_osc_prescene [23] = ("0");
  if (key_x) data_osc_prescene [24] = ("1"); else data_osc_prescene [24] = ("0");
  if (key_y) data_osc_prescene [25] = ("1"); else data_osc_prescene [25] = ("0");
  if (key_z) data_osc_prescene [26] = ("1"); else data_osc_prescene [26] = ("0");

  if (key_A) data_osc_prescene[27] = ("1"); else data_osc_prescene[27] = ("0");
  if (key_B) data_osc_prescene[28] = ("1"); else data_osc_prescene[28] = ("0");
  if (key_C) data_osc_prescene[29] = ("1"); else data_osc_prescene[29] = ("0");
  if (key_D) data_osc_prescene[30] = ("1"); else data_osc_prescene[30] = ("0");
  if (key_E) data_osc_prescene[31] = ("1"); else data_osc_prescene[31] = ("0");
  if (key_F) data_osc_prescene[32] = ("1"); else data_osc_prescene[32] = ("0");
  if (key_G) data_osc_prescene[33] = ("1"); else data_osc_prescene[33] = ("0");
  if (key_H) data_osc_prescene[34] = ("1"); else data_osc_prescene[34] = ("0");
  if (key_I) data_osc_prescene[35] = ("1"); else data_osc_prescene[35] = ("0");
  if (key_J) data_osc_prescene[36] = ("1"); else data_osc_prescene[36] = ("0");
  if (key_K) data_osc_prescene[37] = ("1"); else data_osc_prescene[37] = ("0");
  if (key_L) data_osc_prescene[38] = ("1"); else data_osc_prescene[38] = ("0");
  if (key_M) data_osc_prescene[39] = ("1"); else data_osc_prescene[39] = ("0");
  if (key_N) data_osc_prescene[40] = ("1"); else data_osc_prescene[40] = ("0");
  if (key_O) data_osc_prescene[41] = ("1"); else data_osc_prescene[41] = ("0");
  if (key_P) data_osc_prescene[42] = ("1"); else data_osc_prescene[42] = ("0");
  if (key_Q) data_osc_prescene[43] = ("1"); else data_osc_prescene[43] = ("0");
  if (key_R) data_osc_prescene[44] = ("1"); else data_osc_prescene[44] = ("0");
  if (key_S) data_osc_prescene[45] = ("1"); else data_osc_prescene[45] = ("0");
  if (key_T) data_osc_prescene[46] = ("1"); else data_osc_prescene[46] = ("0");
  if (key_U) data_osc_prescene[47] = ("1"); else data_osc_prescene[47] = ("0");
  if (key_V) data_osc_prescene[48] = ("1"); else data_osc_prescene[48] = ("0");
  if (key_W) data_osc_prescene[49] = ("1"); else data_osc_prescene[49] = ("0");
  if (key_X) data_osc_prescene[50] = ("1"); else data_osc_prescene[50] = ("0");
  if (key_Y) data_osc_prescene[51] = ("1"); else data_osc_prescene[51] = ("0");
  if (key_Z) data_osc_prescene[52] = ("1"); else data_osc_prescene[52] = ("0");
  //FREE

  if (key_1) data_osc_prescene[53] = ("1"); else data_osc_prescene[53] = ("0");
  if (key_2) data_osc_prescene[54] = ("1"); else data_osc_prescene[54] = ("0");
  if (key_3) data_osc_prescene[55] = ("1"); else data_osc_prescene[55] = ("0");
  if (key_4) data_osc_prescene[56] = ("1"); else data_osc_prescene[56] = ("0");
  if (key_5) data_osc_prescene[57] = ("1"); else data_osc_prescene[57] = ("0");
  if (key_6) data_osc_prescene[58] = ("1"); else data_osc_prescene[58] = ("0");
  if (key_7) data_osc_prescene[59] = ("1"); else data_osc_prescene[59] = ("0");
  if (key_8) data_osc_prescene[60] = ("1"); else data_osc_prescene[60] = ("0");
  if (key_9) data_osc_prescene[61] = ("1"); else data_osc_prescene[61] = ("0");
  if (key_0) data_osc_prescene[62] = ("1"); else data_osc_prescene[62] = ("0");
  

  // if (key_a_long) data_osc_prescene[63] = ("1"); else data_osc_prescene[63] = ("0");
  //if (key_b_long) data_osc_prescene[64] = ("1"); else data_osc_prescene[64] = ("0");
  if (key_c_long) data_osc_prescene[65] = ("1"); else data_osc_prescene[65] = ("0");
  //if (key_d_long) data_osc_prescene[66] = ("1"); else data_osc_prescene[66] = ("0");
  //if (key_e_long) data_osc_prescene[67] = ("1"); else data_osc_prescene[67] = ("0");
  //if (key_f_long) data_osc_prescene[68] = ("1"); else data_osc_prescene[68] = ("0");
  //if (key_g_long) data_osc_prescene[69] = ("1"); else data_osc_prescene[69] = ("0");
  //if (key_h_long) data_osc_prescene[70] = ("1"); else data_osc_prescene[70] = ("0");
  //if (key_i_long) data_osc_prescene[71] = ("1"); else data_osc_prescene[71] = ("0");
  //if (key_j_long) data_osc_prescene[72] = ("1"); else data_osc_prescene[72] = ("0");
  //if (key_k_long) data_osc_prescene[73] = ("1"); else data_osc_prescene[73] = ("0");
  if (key_l_long) data_osc_prescene[74] = ("1"); else data_osc_prescene[74] = ("0");
  //if (key_m_long) data_osc_prescene[75] = ("1"); else data_osc_prescene[75] = ("0");
  if (key_n_long) data_osc_prescene[76] = ("1"); else data_osc_prescene[76] = ("0");
  //if (key_o_long) data_osc_prescene[77] = ("1"); else data_osc_prescene[77] = ("0");
  //if (key_p_long) data_osc_prescene[78] = ("1"); else data_osc_prescene[78] = ("0");
  //if (key_q_long) data_osc_prescene[79] = ("1"); else data_osc_prescene[79] = ("0");
  //if (key_r_long) data_osc_prescene[80] = ("1"); else data_osc_prescene[80] = ("0");
  //if (key_s_long) data_osc_prescene[81] = ("1"); else data_osc_prescene[81] = ("0");
  //if (key_t_long) data_osc_prescene[82] = ("1"); else data_osc_prescene[82] = ("0");
  //if (key_u_long) data_osc_prescene[83] = ("1"); else data_osc_prescene[83] = ("0");
  if (key_v_long) data_osc_prescene[84] = ("1"); else data_osc_prescene[84] = ("0");
  //if (key_w_long) data_osc_prescene[85] = ("1"); else data_osc_prescene[85] = ("0");
  //if (key_x_long) data_osc_prescene[86] = ("1"); else data_osc_prescene[86] = ("0");
  //if (key_y_long) data_osc_prescene[87] = ("1"); else data_osc_prescene[87] = ("0");
  //if (key_z_long) data_osc_prescene[88] = ("1"); else data_osc_prescene[88] = ("0");
  

  // SPECIAL TOUCH
  if (key_space_long) data_osc_prescene[89] = ("1"); else data_osc_prescene[89] =("0");
  if (key_shift_long) data_osc_prescene[90] = ("1"); else data_osc_prescene[90] = ("0");

  //data_osc_prescene [91] = ("");
  // .../...
  //data_osc_prescene [99] = ("");

  if (key_space) data_osc_prescene[100] = ("1") ; else data_osc_prescene[100] =("0") ;
  if (key_enter) data_osc_prescene[101] = ("1") ; else data_osc_prescene[101] = ("0") ;
  if (key_return) data_osc_prescene[102] = ("1") ; else data_osc_prescene[102] = ("0") ;
  if (key_delete) data_osc_prescene[103] = ("1") ; else data_osc_prescene[103] = ("0") ;
  if (key_backspace) data_osc_prescene[104] = ("1") ; else data_osc_prescene[104] = ("0") ;
  if (key_alt) data_osc_prescene[105] = ("1") ; else data_osc_prescene[105] = ("0") ;
  if (key_ctrl) data_osc_prescene[106] = ("1") ; else data_osc_prescene[106] = ("0") ;
  if (key_cmd) data_osc_prescene[107] = ("1") ; else data_osc_prescene[107] = ("0") ;

  if (key_up) data_osc_prescene[108] = ("1") ; else data_osc_prescene[108] = ("0") ;
  if (key_down) data_osc_prescene[109] = ("1") ; else data_osc_prescene[109] = ("0") ;
  if (key_right) data_osc_prescene[110] = ("1") ; else data_osc_prescene[110] = ("0") ;
  if (key_left) data_osc_prescene[111] = ("1") ; else data_osc_prescene[111] = ("0") ;

  
  //data_osc_prescene [112] = ("");
  // .../...
  //data_osc_prescene [119] = ("");

  data_osc_prescene[120] = float_to_String_3(pen[0].x); 
  data_osc_prescene[121] = float_to_String_3(pen[0].y); 
  data_osc_prescene[122] = float_to_String_1(pen[0].z); 

  data_osc_prescene[123] = float_to_String_3(norm(mouse[0].x, 0, width)); 
  data_osc_prescene[124] = float_to_String_3(norm(mouse[0].y,0,height));
  data_osc_prescene[125] = float_to_String_3(norm(mouse[0].z,-depth_scene,depth_scene));

  if (clickShortLeft[0]) data_osc_prescene[126] = ("1"); else data_osc_prescene[126] = ("0");
  if (clickShortRight[0]) data_osc_prescene[127] = ("1"); else data_osc_prescene[127] = ("0");
  if (clickLongLeft[0]) data_osc_prescene[128] = ("1"); else data_osc_prescene[128] = ("0");
  if (clickLongRight[0]) data_osc_prescene[129] = ("1"); else data_osc_prescene[129] = ("0");

  data_osc_prescene[130] = int_to_String(wheel[0]);


  // ORDER
  if (ORDER_ONE) data_osc_prescene[131] = ("1") ; else data_osc_prescene[131] = ("0");
  if (ORDER_TWO) data_osc_prescene[132] = ("1") ; else data_osc_prescene[132] = ("0");
  if (ORDER_THREE) data_osc_prescene[133] = ("1") ; else data_osc_prescene[133] = ("0");
  if (LEAPMOTION_DETECTED) data_osc_prescene[134] = ("1") ; else data_osc_prescene[134] = ("0");
}


void join_osc_data() {
  toScene = join(data_osc_prescene, "/") ;
}


