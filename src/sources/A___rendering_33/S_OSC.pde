/**
OSC CORE 
v 1.6.1
*/
void OSC_setup() {
  OSC_controller_setup();
  if(IAM.equals("prescene") && LIVE) {
    OSC_prescene_setup();
  } else if(IAM.equals("scene")) {
    OSC_scene_setup();
  }
}


void OSC_update() {
  if(IAM.equals("prescene") && LIVE) {
    if(mousePressed || keyPressed) {
      send_message(true);
    }
    write_osc_event();
    join_osc_data();
  } else if(IAM.equals("scene")) {
    update_OSC_data();
  }
}
  

OscP5 osc_receive_controller_general;
OscP5 osc_receive_controller_item;
void OSC_controller_setup() {
  osc_receive_controller_general = new OscP5(this,10000);
  osc_receive_controller_item = new OscP5(this,10001);
  println("receive OSC setup done");
}















/**
EVENT & THREAD
v 0.0.2
*/
int security_to_dont_duplicate_osc_packet ;
void oscEvent(OscMessage receive) {
  if(security_to_dont_duplicate_osc_packet != frameCount) {
    controller_reception(receive) ;
    if(IAM.equals("scene")) prescene_reception(receive); 
  }
  security_to_dont_duplicate_osc_packet = frameCount;
}

boolean controller_osc_is = false ;
void controller_reception(OscMessage receive) {
  if(receive.addrPattern().equals("Controller general")) {
    thread_data_controller_general(receive);
    controller_osc_is = true;
  }

  if(receive.addrPattern().equals("Controller item")) {
    thread_data_controller_item(receive);
    controller_osc_is = true;
  }
}




void thread_data_controller_general(OscMessage receive) {
  int rank = 0 ;
  receive_data_misc(receive,rank); // 3 arg
  // load_SCENE_Setting_GLOBAL > +1;
  // save_Current_SCENE_Setting_GLOBAL > +1;
  // save_New_SCENE_Setting_GLOBAL > +1;
  // total +3
  rank += 3;
  receive_data_menu_bar(receive,rank); 

  rank += NUM_TOP_BUTTON;
  receive_data_general_dropdown(receive,rank);

  rank += NUM_DROPDOWN_GENERAL;
  //rank += 7;
  receive_data_general_button(receive,rank);

  rank += NUM_MID_BUTTON;  
  receive_data_general_slider(receive,rank,rank +NUM_MOLETTE_GENERAL); // NUM_SLIDER_GENERAL 
}


void thread_data_controller_item(OscMessage receive) {
  int rank = 0 ;
  receive_data_slider_item(receive,rank); // num arg = NUM_SLIDER_ITEM
  rank += NUM_SLIDER_ITEM;
  receive_data_button_item(receive,rank); // num arg = NUM_ITEM_PLUS_MASTER *BUTTON_ITEM_CONSOLE
  rank += (NUM_ITEM *BUTTON_ITEM_CONSOLE);
  receive_data_dropdown_costume_item(receive,rank); // num arg = NUM_ITEM_PLUS_MASTER
  rank += NUM_ITEM;
  receive_data_dropdown_mode_item(receive,rank); // num arg = NUM_ITEM_PLUS_MASTER

}



// local method
boolean to_bool(OscMessage receive, int index) {
  Object obj = receive.arguments()[index];
  if(obj instanceof Integer) {
    int i = (int)obj;
    if(i == 0) return false ; else return true;
  } if(obj instanceof Float) {
    float f = (float)obj;
    if(f == 0) return false ; else return true;
  } else {
    if(IAM.equals("prescene")) {
      // not possible to use print when the presne is used because the rendering prescene and scene is from the same sketch
      printErr("OSC message index",index, "cannot be cast by default false value has be used");
    }
    return false;
  }
}

void receive_data_misc(OscMessage receive, int in) {
  load_SCENE_Setting_GLOBAL = to_bool(receive,0+in);
  save_Current_SCENE_Setting_GLOBAL = to_bool(receive,1+in);
  save_New_SCENE_Setting_GLOBAL = to_bool(receive,2+in);
}


void receive_data_menu_bar(OscMessage receive, int in) {
  curtain_button_is(to_bool(receive,0+in));
  // reset button alert
  reset_camera_button_alert_is(to_bool(receive,1+in));
  reset_item_on_button_alert_is(to_bool(receive,2+in));
  reset_fx_button_alert_is(to_bool(receive,3+in));
  // misc
  birth_button_alert_is(to_bool(receive,4+in));
  dimension_button_alert_is(to_bool(receive,5+in));
/*
  if(birth_button_is()) println("receive_data_menu_bar() :birth",birth_button_is(),frameCount);
  if(dimension_button_is()) println("receive_data_menu_bar: dimension",dimension_button_is(),frameCount);
  */
}

void receive_data_general_dropdown(OscMessage receive, int in) {
  which_shader = receive.get(0+in).intValue(); // shader
  which_fx = receive.get(1+in).intValue(); // filter
  select_font(receive.get(2+in).intValue()); // font
  which_text[0] = receive.get(3+in).intValue(); // text
  which_bitmap[0] = receive.get(4+in).intValue(); // bitmap
  which_shape[0] = receive.get(5+in).intValue(); // shape
  which_movie[0] = receive.get(6+in).intValue(); // movie
}


void receive_data_general_button(OscMessage receive, int in) {
  int target = 0;
  background_button_is(to_bool(receive,target+in));
  target++;
  for(int i = 0 ; i < fx_button_is.length ; i++) {
    fx_button_is(i,to_bool(receive,target+in));
    target++;
  }
  ambient_button_is(to_bool(receive,target+in));
  target++;
  ambient_action_button_is(to_bool(receive,target+in));
  target++;
  light_1_button_is(to_bool(receive,target+in));
  target++;
  light_1_action_button_is(to_bool(receive,target+in));
  target++;
  light_2_button_is(to_bool(receive,target+in));
  target++;
  light_2_action_button_is(to_bool(receive,target+in));
  target++;
  for(int i = 1 ; i < transient_button_is.length ; i++) {
    transient_button_is(i,to_bool(receive,target+in));
    target++;
  }
  // index_osc finish at 12
}

void receive_data_general_slider(OscMessage receive, int in, int out) {
  int in_background = in ;
  int out_background = in_background +NUM_MOLETTE_BACKGROUND;

  int in_fx =  out_background;
  int out_fx = in_fx +NUM_MOLETTE_FX;

  int in_light =  out_fx;
  int out_light = in_light +NUM_MOLETTE_LIGHT;

  int in_sound =  out_light;
  int out_sound = in_sound +NUM_MOLETTE_SOUND;

  int in_sound_setting =  out_sound;
  int out_sound_setting = in_sound_setting +NUM_MOLETTE_SOUND_SETTING;

  int in_camera =  out_sound_setting;
  int out_camera = in_camera +NUM_MOLETTE_CAMERA;

  for (int i = in ; i < out ; i++) {
    if(i < out_background) {
      value_slider_background[i -in] = receive.get(i).intValue();
    } else if(i >= in_fx && i < out_fx) {
      value_slider_fx[i -in_fx] = receive.get(i).intValue();
    } else if(i >= in_light && i < out_light) {
      value_slider_light[i -in_light] = receive.get(i).intValue();
    } else if(i >= in_sound && i < out_sound) {
      value_slider_sound[i -in_sound] = receive.get(i).intValue();
    } else if(i >= in_sound_setting && i < out_sound_setting) {
      value_slider_sound_setting[i -in_sound_setting] = receive.get(i).intValue();
    } else if(i >= in_camera && i < out_camera) {
      value_slider_camera[i -in_camera] = receive.get(i).intValue();
    }
  } 
}


void receive_data_slider_item(OscMessage receive, int in) {
  for (int i = 0 ; i < NUM_MOLETTE_ITEM ; i++) {
    int index = in + i;
    value_slider_item[i] = Float.valueOf(receive.get(index).intValue());
  }
}


void receive_data_button_item(OscMessage receive, int in) {
  int num = BUTTON_ITEM_CONSOLE;
  for (int i = 0 ; i < NUM_ITEM ; i++) {
    int index = in + (i*num);
    Romanesco item = rom_manager.get(i);
    item.show_is(to_bool(receive,index+0));
    item.parameter_is(to_bool(receive,index+1));
    item.sound_is(to_bool(receive,index+2));
    item.action_is(to_bool(receive,index+3));
  }
}

void receive_data_dropdown_mode_item(OscMessage receive, int in) {
  for (int i = 0 ; i < NUM_ITEM ; i++) {
    int index = i+in;
    Romanesco item = rom_manager.get(i);
    item.mode.set_id(receive.get(index).intValue());
  }
}

void receive_data_dropdown_costume_item(OscMessage receive, int in) {
  for (int i = 0 ; i < NUM_ITEM ; i++) {
    int index = i+in;
    int target = i+1;
    Romanesco item = rom_manager.get(i);
    item.set_costume_id(receive.get(index).intValue());
  }
}











































/**
OSC Prescene 
2014-2018
v 1.4.0
* this part is used when the sketch is build like a prescene
*/
NetAddress [] ad_scene ;
String [] ID_address_scene ;
String toScene = ("Message from Prescene to Scene") ;
OscP5 osc_send_scene;

int port_send_scene = 9_100 ;

void OSC_prescene_setup() {
  OSC_thread_send_scene_setup();
  println("send OSC setup done");
}

void OSC_thread_send_scene_setup() {
  osc_send_scene = new OscP5(this, port_send_scene);
  //send
  if (DEV_MODE == false) {
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
  } else if(DEV_MODE == true) {
    ad_scene = new NetAddress[1];
    ad_scene[0] = new NetAddress("127.0.0.1", port_send_scene);
  }

  if(IAM.equals("prescene") && LIVE) {
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



// OSC prescene send
void OSC_send() {
  OscMessage RomanescoScene = new OscMessage("Prescene");

  //SEND data to SCENE
  RomanescoScene.add(toScene);

  //send
  if(ad_scene == null) {
    printErr("OSC_send(): prescene app exit because the global variable 'DEV_MODE' must be false");
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







// OSC prescene write
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







































































/**
SCENE OSC
2013-2018
v 1.0.1
* this part is used when the sketch is build like a scene
*/
String dataPrescene = ("") ;
String from_prescene_boolean_load_save = ("") ;


OscP5 osc_receive_prescene ;


// OSC prescene setup 
void OSC_scene_setup() {
  int port_receive_prescene = 9_100 ;

  osc_receive_prescene = new OscP5(this, port_receive_prescene);
  println("OSC Scene setup done");
}



void prescene_reception(OscMessage m) {
  if(m.addrPattern().equals("Prescene")) {
    catchDataFromPrescene(m);
    data_osc_prescene = split(dataPrescene, '/') ;
    data_save_osc_prescene_reception();
  } 
}


void catchDataFromPrescene(OscMessage receive) {
  dataPrescene = receive.get(0).stringValue() ;
  from_prescene_boolean_load_save = receive.get(2).stringValue() ;
}





void data_save_osc_prescene_reception() {
  String [] booleanSave  ;
  booleanSave = split(from_prescene_boolean_load_save, '/') ;
  // convert string to boolean
  load_SCENE_Setting_order_from_presecene = Boolean.valueOf(booleanSave[0]).booleanValue();
  save_Current_SCENE_Setting_order_from_presecene = Boolean.valueOf(booleanSave[1]).booleanValue();
  save_New_SCENE_Setting_order_from_presecene = Boolean.valueOf(booleanSave[2]).booleanValue();
}





void update_OSC_data() {
  translate_event_prescene() ;
}

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
  if(data_osc_prescene[131].equals("0")) ORDER_ONE = false; else ORDER_ONE = true;
  if(data_osc_prescene[132].equals("0")) ORDER_TWO = false; else ORDER_TWO = true;
  if(data_osc_prescene[133].equals("0")) ORDER_THREE = false; else ORDER_THREE = true;
  if(data_osc_prescene[134].equals("0")) LEAPMOTION_DETECTED = false; else LEAPMOTION_DETECTED = true;
}

















