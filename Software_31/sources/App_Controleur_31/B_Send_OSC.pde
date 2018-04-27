/**
OSC Controller
2014 - 2018
v 1.1.0
*/
import oscP5.*;
import netP5.*;
String ID_address_local = ("127.0.0.1") ;

String IP_address_prescene = ID_address_local ;
String [] ID_address_scene ;
// String ID_adress_scene = ("192.168.1.10") ;
// Message to Prescene
String toPreScene [] = new String [5] ;


OscP5 osc_prescene ;
OscP5 osc_scene ;

int port_prescene = 10_000 ;
int port_scene = 9_500 ;

NetAddress target_prescene ;
NetAddress [] target_scene ;

void set_OSC() {
  int num_address = 1 ;
  String [] address = loadStrings(preference_path+"network/IP_address_mirror.txt") ;
  String [] temp = split(address[0],"/") ;
  

  int num_valid_address = 0 ;
  for(int i = 0 ; i < temp.length ; i++) {
    if(temp[i].equals("IP_address") || temp[i].equals("")) {
      // nothing happens
    } else {
      num_valid_address ++ ;
    }   
  }  

  ID_address_scene = new String[num_valid_address] ;
  target_scene = new NetAddress[num_valid_address] ;

  for(int i = 0 ; i < num_valid_address ; i++) {
    ID_address_scene[i] = temp[i+1] ;
  }  

  osc_prescene = new OscP5(this, port_prescene) ;
  osc_scene = new OscP5(this, port_scene) ;

  set_ip_address() ;
}


void set_ip_address() {
  target_prescene = new NetAddress(IP_address_prescene, port_prescene) ;
  for(int i = 0 ; i < target_scene.length ; i++) {
     target_scene[i] = new NetAddress(ID_address_scene[i], port_scene) ;
  }
  // target_scene = new NetAddress(ID_adress_scene,address_scene) ;
}

float ref_send_osc;
void send_OSC() {
  OscMessage RomanescoController = new OscMessage("Controller");
  
  //int value join in String 
  data_to_send() ;
  
  //BUTTON 
  toPreScene[0] = join_int_to_String(value_button_general) ; 
  toPreScene[1] = join_int_to_String(value_button_item) ;
  
  
  // SLIDER
  /* Catch the value slider to send to Prescene
  @return value to the prescene between 0 to 99
  */
  // group general
  int[] data_OSC_general = new int[NUM_SLIDER_GENERAL] ;
  for ( int i = 1 ; i < NUM_SLIDER_GENERAL -1 ; i++) {
    data_OSC_general[i-1] = floor(value_slider_general[i]);
  }
  toPreScene[2] = join_int_to_String(data_OSC_general);

  // group item
  int[] data_OSC_item = new int[NUM_SLIDER_ITEM] ;
  for ( int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    data_OSC_item[i] = floor(value_slider_item[i]); 
  }
  toPreScene[3] = join_int_to_String(data_OSC_item);



  // LOAD SAVE SCENE ORDER
  String load = String.valueOf(load_Scene_Setting) ;
  String  saveCurrent = String.valueOf(save_Current_Scene_Setting) ;
  String  saveNew = String.valueOf(save_New_Scene_Setting) ;
  // we change to false boolean load and data to false each 2 second to have a time to load and save
  if(frameCount%60 == 0) load_Scene_Setting = save_Current_Scene_Setting = save_New_Scene_Setting = false ;

  toPreScene[4] = load + "/" +  saveCurrent + "/" + saveNew;
  
  //add to OSC
  for ( int i = 0 ; i < toPreScene.length ; i++) {
    RomanescoController.add(toPreScene[i]);
  }

  // send or not to send
  float total_send_osc = 0;
  for(int i = 0 ; i < value_button_general.length ; i++) {
     total_send_osc += value_button_general[i];
  }
  for(int i = 0 ; i < value_button_item.length ; i++) {
     total_send_osc += value_button_item[i];
  }

  for ( int i = 1 ; i < NUM_SLIDER_GENERAL -1 ; i++) {
    total_send_osc += data_OSC_general[i-1];
  }

  for ( int i = 101   ; i < 101 +NUM_SLIDER_ITEM ; i++) {
    total_send_osc += data_OSC_item[i-101]; 
  }

  //send
  if(ref_send_osc != total_send_osc) {
    osc_prescene.send(RomanescoController, target_prescene) ; 
    for(int i = 0 ; i < target_scene.length ; i++) {
      osc_scene.send(RomanescoController, target_scene[i]) ; 
    }
    ref_send_osc = total_send_osc;
  } 
}



  
  
  
void data_to_send() {
  //sound
  value_button_general[1] = state_button_beat;
  value_button_general[2] = state_button_kick;
  value_button_general[3] = state_button_snare;
  value_button_general[4] = state_button_hat;
  /**
  Here find method to get to a list of dropdown by name when there is a list of dropdown.
  easyer te read the code after a long time when we forget the number
  */
  value_button_general[5] = dropdown_bar[0].get_content_line() +1; // font
  value_button_general[6] = state_curtain_button;
  value_button_general[7] = state_BackgroundButton;
  
  value_button_general[8] = state_LightOneButton;
  value_button_general[9] = state_LightTwoButton;
  value_button_general[10] = state_LightAmbientButton;
  value_button_general[11] = state_LightOneAction;
  value_button_general[12] = state_LightTwoAction;
  value_button_general[13] = state_LightAmbientAction;

  
  if(which_bg_shader > SWITCH_VALUE_FOR_DROPDOWN) value_button_general[14] = which_bg_shader;
  // if(which_filter > SWITCH_VALUE_FOR_DROPDOWN) value_button_general[14] = which_filter;
  if(which_bitmap > SWITCH_VALUE_FOR_DROPDOWN) value_button_general[15] = which_bitmap;
  if(which_shape > SWITCH_VALUE_FOR_DROPDOWN) value_button_general[16] = which_shape;
  if(which_text > SWITCH_VALUE_FOR_DROPDOWN) value_button_general[17] = which_text;
  if(which_movie > SWITCH_VALUE_FOR_DROPDOWN) value_button_general[18] = which_movie;
  /**
  value_button_general[19] is free
  */
  // if(state_camera > SWITCH_VALUE_FOR_DROPDOWN)  value_button_general[19] = ID_camera_video_list[state_camera] ;

  
  // ITEM BUTTON
  if(NUM_ITEM > 0 ) {
    for ( int i = 0 ; i < NUM_ITEM ; i ++) {
      value_button_item[i *10 +1] = on_off_item_console[i *10 +1];
      value_button_item[i *10 +2] = on_off_item_console[i *10 +2];
      value_button_item[i *10 +3] = on_off_item_console[i *10 +3];
      value_button_item[i *10 +4] = on_off_item_console[i *10 +4];
      value_button_item[i *10 +5] = on_off_item_console[i *10 +5];
      if (dropdown_item_mode[i+1] != null) {
        value_button_item[i *10 +9] = dropdown_item_mode[i+1].get_content_line();
      }
    }
  }
}
  





  
