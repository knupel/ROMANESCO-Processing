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

OscP5 osc_prescene_general;
OscP5 osc_prescene_item;
OscP5 osc_scene_general;
OscP5 osc_scene_item;

int port_prescene_general = 10_000;
int port_prescene_item = 10_001;
int port_scene_general = 9_500;
int port_scene_item = 9_501;

NetAddress prescene_net_address_general;
NetAddress prescene_net_address_item;

NetAddress [] scene_net_addresses_general;
NetAddress [] scene_net_addresses_item;

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

  ID_address_scene = new String[num_valid_address];
  scene_net_addresses_general = new NetAddress[num_valid_address];
  scene_net_addresses_item = new NetAddress[num_valid_address] ;

  for(int i = 0 ; i < num_valid_address ; i++) {
    ID_address_scene[i] = temp[i+1] ;
  }  

  osc_prescene_general = new OscP5(this, port_prescene_general);
  osc_prescene_item = new OscP5(this, port_prescene_item);
  osc_scene_general = new OscP5(this, port_scene_general);
  osc_scene_item = new OscP5(this, port_scene_item);

  set_ip_address() ;
}

void set_ip_address() {
  // general
  prescene_net_address_general = new NetAddress(IP_address_prescene,port_prescene_general);
  for(int i = 0 ; i < scene_net_addresses_general.length ; i++) {
     scene_net_addresses_general[i] = new NetAddress(ID_address_scene[i], port_scene_general) ;
  }
  // item
  prescene_net_address_item = new NetAddress(IP_address_prescene,port_prescene_item);
  for(int i = 0 ; i < scene_net_addresses_item.length ; i++) {
     scene_net_addresses_item[i] = new NetAddress(ID_address_scene[i], port_scene_item) ;
  }
}






void update_OSC() {
  total_data_osc_general = 0;
  OscMessage mess_general = new OscMessage("Controller general");
  message_general_osc(mess_general);
  if(send_general_is()) {
    send_OSC(osc_prescene_general,osc_scene_general,prescene_net_address_general,scene_net_addresses_general,mess_general);
  }

  total_data_osc_item = 0;
  OscMessage mess_item = new OscMessage("Controller item");
  message_item_osc(mess_item);

  if(send_item_is()) {
    send_OSC(osc_prescene_item,osc_scene_item,prescene_net_address_item,scene_net_addresses_item,mess_item);
  }
}


void message_general_osc(OscMessage m) {
  add_data_general(m,load_scene_setting);
  add_data_general(m,save_current_scene_setting);
  add_data_general(m,save_new_scene_setting);

  // add menu bar
  add_data_general(m,button_curtain.is());
  // add_data(m,button_midi.is());
 
  // dropdown general
  add_data_general(m,dropdown_bar[0].get_selection()); // font or shader ?
  add_data_general(m,dropdown_bar[1].get_selection()); // filter
  add_data_general(m,dropdown_bar[2].get_selection()); // font ?
  add_data_general(m,dropdown_bar[3].get_selection()); // text
  add_data_general(m,dropdown_bar[4].get_selection()); // bitmap
  add_data_general(m,dropdown_bar[5].get_selection()); // shape
  add_data_general(m,dropdown_bar[6].get_selection()); // movie

  // button general background
  add_data_general(m, button_bg.is());
  // button general light
  add_data_general(m,button_light_ambient.is());
  add_data_general(m,button_light_ambient_action.is());
  add_data_general(m,button_light_1.is());
  add_data_general(m,button_light_1_action.is());
  add_data_general(m,button_light_2.is());
  add_data_general(m,button_light_2_action.is());
  // button general sound
  add_data_general(m,button_kick.is());
  add_data_general(m,button_snare.is());
  add_data_general(m,button_hat.is());

  // add slider general
  for(int i = 0 ; i < value_slider_background.length ; i++) {
    add_data_general(m,value_slider_background[i]);
  }
  for(int i = 0 ; i < value_slider_filter.length ; i++) {
    add_data_general(m,value_slider_filter[i]);
  }
  for(int i = 0 ; i < value_slider_light.length ; i++) {
    add_data_general(m,value_slider_light[i]);
  }
  for(int i = 0 ; i < value_slider_sound.length ; i++) {
    add_data_general(m,value_slider_sound[i]);
  }
  for(int i = 0 ; i < value_slider_sound_setting.length ; i++) {
    add_data_general(m,value_slider_sound_setting[i]);
  }
  for(int i = 0 ; i < value_slider_camera.length ; i++) {
    add_data_general(m,value_slider_camera[i]);
  }
}

void message_item_osc(OscMessage m) {
  for ( int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    add_data_item(m,value_slider_item[i]); 
  }
  // add button item
  for (int i = 0 ; i < item_button_state.length ; i++) {
    add_data_item(m,item_button_state[i]); 
  }
  // add dropdown mode item
  for(int i = 0 ; i < NUM_ITEM ; i++) {
    int index = i +1;
    add_data_item(m,dd_item_costume[index].get_selection());
  }
}




void send_OSC(OscP5 osc_prescene, OscP5 osc_scene, NetAddress ad_prescene, NetAddress [] ad_scene,  OscMessage m) {
  osc_prescene.send(m,ad_prescene);
  // println(mess.arguments().length);
  if(LIVE) {
    for(int i = 0 ; i < ad_scene.length ; i++) {
      osc_scene.send(m, ad_scene[i]) ; 
    }
  }
}






boolean send_message_item_is;
float ref_total_data_osc_item;
float total_data_osc_item;
boolean send_item_is() {
  if(total_data_osc_item != ref_total_data_osc_item) {
    send_message_item_is = true;
    ref_total_data_osc_item = total_data_osc_item;
  } else {
    send_message_item_is = false;
  }
  return send_message_item_is; 
}



boolean send_message_general_is;
float ref_total_data_osc_general;
float total_data_osc_general;
boolean send_general_is() {
  if(total_data_osc_general != ref_total_data_osc_general) {
    send_message_general_is = true;
    ref_total_data_osc_general = total_data_osc_general;
  } else {
    send_message_general_is = false;
  }
  return send_message_general_is; 
}


void add_data_general(OscMessage m, Object obj) {
  boolean cast_float_like_int = true;
  // byte case
  if(obj instanceof Byte) {
    byte by = (byte)obj ;
    m.add(by);
    total_data_osc_general += by;
  } // int short
  else if(obj instanceof Short) {
    short s = (short)obj ;
    m.add(s);
    total_data_osc_general += s;
    // int case
  } else if(obj instanceof Integer) {
    int i = (int)obj ;
    m.add(i);
    total_data_osc_general += i;
  // float case  
  } else if(obj instanceof Float) {
    float f = (float)obj;
    if(cast_float_like_int) {
      int i = round(f);
      m.add(i);
      total_data_osc_general += i;
    } else {
      m.add(f); 
      total_data_osc_general += f; 
    }
  // String case
  } else if(obj instanceof String) {
    String s = (String)obj;
    m.add(s);
    total_data_osc_general += s.length(); 
  // boolean case
  } else if(obj instanceof Boolean) {
    boolean b = (boolean)obj;
    m.add(to_int(b));
    if(b) {
      total_data_osc_general++;
    } 
  }  
}



void add_data_item(OscMessage m, Object obj) {
  boolean cast_float_like_int = true;
  // byte case
  if(obj instanceof Byte) {
    byte by = (byte)obj ;
    m.add(by);
    total_data_osc_item += by;
  } // int short
  else if(obj instanceof Short) {
    short s = (short)obj ;
    m.add(s);
    total_data_osc_item += s;
    // int case
  } else if(obj instanceof Integer) {
    int i = (int)obj ;
    m.add(i);
    total_data_osc_item += i;
  // float case  
  } else if(obj instanceof Float) {
    float f = (float)obj;
    if(cast_float_like_int) {
      int i = round(f);
      m.add(i);
      total_data_osc_item += i;
    } else {
      m.add(f); 
      total_data_osc_item += f; 
    }
  // String case
  } else if(obj instanceof String) {
    String s = (String)obj;
    m.add(s);
    total_data_osc_item += s.length(); 
  // boolean case
  } else if(obj instanceof Boolean) {
    boolean b = (boolean)obj;
    m.add(to_int(b));
    if(b) {
      total_data_osc_item++;
    } 
  }  
}


int to_int(boolean b) {
  if(b) return 1 ; else return 0;
}



  
  





  
