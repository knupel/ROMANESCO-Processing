/**
OSC CORE 
v 1.3.0
*/
OscP5 osc_receive_controller_general;
OscP5 osc_receive_controller_item;
void OSC_receive_controller_setup() {
  osc_receive_controller_general = new OscP5(this,10000);
  osc_receive_controller_item = new OscP5(this,10001);
  println("receive OSC setup done");
}



// main method
void thread_data_controller_general(OscMessage receive) {
  int rank = 0 ;
  receive_data_misc(receive,rank); // 3 arg
  rank += 3;
  receive_data_menu_bar(receive,rank); // 1 arg
  rank += 1;
  receive_data_general_dropdown(receive,rank); // 7 arg
  rank += 7;
  receive_data_general_button(receive,rank); // 10 arg
  rank += 10;  
  receive_data_general_slider(receive,rank,rank +NUM_SLIDER_GENERAL); // NUM_SLIDER_GENERAL 
  rank += NUM_SLIDER_GENERAL;
  /*
  receive_data_slider_item(receive,rank); // num arg = NUM_SLIDER_ITEM
  rank += NUM_SLIDER_ITEM;
  receive_data_button_item(receive,rank); // num arg = NUM_ITEM_PLUS_MASTER *BUTTON_ITEM_CONSOLE
  rank += (NUM_ITEM *BUTTON_ITEM_CONSOLE);
  receive_data_dropdown_item(receive,rank); // num arg = NUM_ITEM_PLUS_MASTER
  */
}


void thread_data_controller_item(OscMessage receive) {
  int rank = 0 ;
  /*
  receive_data_misc(receive,rank); // 3 arg
  rank += 3;
  receive_data_menu_bar(receive,rank); // 1 arg
  rank += 1;
  receive_data_general_dropdown(receive,rank); // 7 arg
  rank += 7;
  receive_data_general_button(receive,rank); // 10 arg
  rank += 10;  
  receive_data_general_slider(receive,rank,rank +NUM_SLIDER_GENERAL); // NUM_SLIDER_GENERAL 
  rank += NUM_SLIDER_GENERAL;
  */
  
  receive_data_slider_item(receive,rank); // num arg = NUM_SLIDER_ITEM
  rank += NUM_SLIDER_ITEM;
  receive_data_button_item(receive,rank); // num arg = NUM_ITEM_PLUS_MASTER *BUTTON_ITEM_CONSOLE
  rank += (NUM_ITEM *BUTTON_ITEM_CONSOLE);
  receive_data_dropdown_item(receive,rank); // num arg = NUM_ITEM_PLUS_MASTER
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
    printErr("OSC message index",index, "cannot be cast by default fase value has be used");
    return false;
  }
}

void receive_data_misc(OscMessage receive, int in) {
  load_SCENE_Setting_GLOBAL = to_bool(receive,0+in);
  save_Current_SCENE_Setting_GLOBAL = to_bool(receive,1+in);
  save_New_SCENE_Setting_GLOBAL = to_bool(receive,2+in);
}


void receive_data_menu_bar(OscMessage receive, int in) {
  curtain_is(to_bool(receive,0+in));
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
  background_is(to_bool(receive,0+in));

  light_ambient_is(to_bool(receive,1+in));
  light_ambient_action_is(to_bool(receive,2+in));
  light_1_is(to_bool(receive,3+in));
  light_1_action_is(to_bool(receive,4+in));
  light_2_is(to_bool(receive,5+in));
  light_2_action_is(to_bool(receive,6+in));

  kick_romanesco_is(to_bool(receive,7+in));
  snare_romanesco_is(to_bool(receive,8+in));
  hat_romanesco_is(to_bool(receive,9+in));
}

void receive_data_general_slider(OscMessage receive, int in, int out) {
  int in_background = in ;
  int out_background = in_background +NUM_SLIDER_BACKGROUND;

  int in_filter =  out_background;
  int out_filter = in_filter +NUM_SLIDER_FILTER;

  int in_light =  out_filter;
  int out_light = in_light +NUM_SLIDER_LIGHT;

  int in_sound =  out_light;
  int out_sound = in_sound +NUM_SLIDER_SOUND;

  int in_sound_setting =  out_sound;
  int out_sound_setting = in_sound_setting +NUM_SLIDER_SOUND_SETTING;

  int in_camera =  out_sound_setting;
  int out_camera = in_camera +NUM_SLIDER_CAMERA;

  for (int i = in ; i < out ; i++) {
    if(i < out_background) {
      value_slider_background[i -in_background] = Float.valueOf(receive.get(i).intValue());
      // println("background",value_slider_background[i -in_background]);
    } else if(i >= in_filter && i < out_filter) {
      value_slider_filter[i -in_filter] = Float.valueOf(receive.get(i).intValue());
      // println("filter",value_slider_filter[i -in_filter]);
    } else if(i >= in_light && i < out_light) {
      value_slider_light[i -in_light] = Float.valueOf(receive.get(i).intValue());
      // println("light",value_slider_light[i -in_light]);
    } else if(i >= in_sound && i < out_sound) {
      value_slider_sound[i -in_sound] = Float.valueOf(receive.get(i).intValue());
      // println("sound",value_slider_sound[i -in_sound]);
    } else if(i >= in_sound_setting && i < out_sound_setting) {
      value_slider_sound_setting[i -in_sound_setting] = Float.valueOf(receive.get(i).intValue());
      // println("sound setting",value_slider_sound_setting[i -in_sound_setting]);
    } else if(i >= in_camera && i < out_camera) {
      value_slider_camera[i -in_camera] = Float.valueOf(receive.get(i).intValue());
      //println("camera",value_slider_camera[i -in_camera]);
    }
  } 
}

void receive_data_slider_item(OscMessage receive, int in) {
  for (int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
   int index = in + i;
    int target = i;
    value_slider_item[target] = Float.valueOf(receive.get(index).intValue());
    // println("item slider",value_slider_item[target]);
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
    // println("show",show_item[target]);
    // println("param",parameter[target]);
    // println("sound",sound[target]);
    // println("action",action[target]);
  }
}

void receive_data_dropdown_item(OscMessage receive, int in) {
  for (int i = 0 ; i < NUM_ITEM ; i++) {
    int index = i+in;
    int target = i+1;
    mode[target] = receive.get(index).intValue();
    // println("mode",mode[target]);
  }
}