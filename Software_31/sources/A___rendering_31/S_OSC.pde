/**
OSC CORE 
v 1.5.2
*/

void OSC_setup() {
  OSC_receive_controller_setup();
  if(IAM.equals("prescene") && LIVE) {
    OSC_send_scene_setup();
  } else if(IAM.equals("scene")) {
    OSC_receive_prescene_setup();
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
void OSC_receive_controller_setup() {
  osc_receive_controller_general = new OscP5(this,10000);
  osc_receive_controller_item = new OscP5(this,10001);
  println("receive OSC setup done");
}






/**
EVENT
v 0.0.1
*/
int security_to_dont_duplicate_osc_packet ;
void oscEvent(OscMessage receive) {
 println(receive.addrPattern(),frameCount);
 if(security_to_dont_duplicate_osc_packet != frameCount) {
    controller_reception(receive) ;
    if(IAM.equals("scene")) prescene_reception(receive) ; 
  }
  security_to_dont_duplicate_osc_packet = frameCount ;
}

// CONTROLLER RECEPTION
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

// PRESCENE RECEPTION
void prescene_reception(OscMessage m) {
  if(m.addrPattern().equals("Prescene")) {
    catchDataFromPrescene(m);
    data_osc_prescene = split(dataPrescene, '/') ;
    data_save_prescene();
  } 
}


/**
PRESCENE OSC
v 0.0.1
*/












/**
SCENE OSC
v 0.0.1
*/

String dataPrescene = ("") ;
String from_prescene_boolean_load_save = ("") ;

void catchDataFromPrescene(OscMessage receive) {
  dataPrescene = receive.get(0).stringValue() ;
  path_to_load_scene_setting = receive.get(1).stringValue() ;
  from_prescene_boolean_load_save = receive.get(2).stringValue() ;
}

void data_save_prescene() {
  String [] booleanSave  ;
  booleanSave = split(from_prescene_boolean_load_save, '/') ;
  // convert string to boolean
  load_SCENE_Setting_order_from_presecene = Boolean.valueOf(booleanSave[0]).booleanValue();
  save_Current_SCENE_Setting_order_from_presecene = Boolean.valueOf(booleanSave[1]).booleanValue();
  save_New_SCENE_Setting_order_from_presecene = Boolean.valueOf(booleanSave[2]).booleanValue();
}







































/**
GLOBAL OSC
*/
// main method
void thread_data_controller_general(OscMessage receive) {
  int rank = 0 ;
  receive_data_misc(receive,rank); // 3 arg
  rank += 3;
  /*
  * curtain x 1
  * 1 arg
  */
  receive_data_menu_bar(receive,rank); 
  rank += 1;
  /*
  * dropdown menu general x7
  *  7 arg
  */
  receive_data_general_dropdown(receive,rank); 
  rank += 7;
  /*
  * background x1
  * fx x2
  * light x6
  * beat x4
  * 13 arg
  */
  receive_data_general_button(receive,rank); 
  rank += 13;  
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
}

void receive_data_general_dropdown(OscMessage receive, int in) {
  which_shader = receive.get(0+in).intValue();
  which_filter = receive.get(1+in).intValue();
  select_font(receive.get(2+in).intValue());
  which_text[0] = receive.get(3+in).intValue();
  which_bitmap[0] = receive.get(4+in).intValue();
  which_shape[0] = receive.get(5+in).intValue();
  which_movie[0] = receive.get(6+in).intValue();
}


void receive_data_general_button(OscMessage receive, int in) {
  background_button_is(to_bool(receive,0+in));
  int index_osc = 1 ;
  for(int i = 0 ; i < fx_button_is.length ; i++) {
    fx_button_is(i,to_bool(receive,index_osc+in));
    index_osc++;
  }

  ambient_button_is(to_bool(receive,3+in));
  ambient_action_button_is(to_bool(receive,4+in));
  light_1_button_is(to_bool(receive,5+in));
  light_1_action_button_is(to_bool(receive,6+in));
  light_2_button_is(to_bool(receive,7+in));
  light_2_action_button_is(to_bool(receive,8+in));
  
  index_osc = 9 ;
  for(int i = 1 ; i < transient_button_is.length ; i++) {
    transient_button_is(i,to_bool(receive,index_osc+in));
    index_osc++;
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
    int target = i;

    value_slider_item[target] = Float.valueOf(receive.get(index).intValue());
  }
}


void receive_data_button_item(OscMessage receive, int in) {
  int num = BUTTON_ITEM_CONSOLE;
  for (int i = 0 ; i < NUM_ITEM ; i++) {
    int index = in + (i*num);
    int target = i+1;
    show_item[target] = to_bool(receive,index +0);
    parameter[target] = to_bool(receive,index +1);
    sound[target] = to_bool(receive,index +2);
    action[target] = to_bool(receive,index +3);
  }
}

void receive_data_dropdown_mode_item(OscMessage receive, int in) {
  for (int i = 0 ; i < NUM_ITEM ; i++) {
    int index = i+in;
    int target = i+1;
    mode[target] = receive.get(index).intValue();
  }
}

void receive_data_dropdown_costume_item(OscMessage receive, int in) {
  for (int i = 0 ; i < NUM_ITEM ; i++) {
    int index = i+in;
    int target = i+1;
    costume_controller_selection[target] = receive.get(index).intValue();
  }
}