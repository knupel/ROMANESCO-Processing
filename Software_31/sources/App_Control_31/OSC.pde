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

OscP5 osc_prescene ;
OscP5 osc_scene ;

int port_prescene = 10_000;
int port_scene = 9_500;

NetAddress prescene_net_address ;
NetAddress [] scene_net_addresses ;

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
  scene_net_addresses = new NetAddress[num_valid_address] ;

  for(int i = 0 ; i < num_valid_address ; i++) {
    ID_address_scene[i] = temp[i+1] ;
  }  

  osc_prescene = new OscP5(this, port_prescene) ;
  osc_scene = new OscP5(this, port_scene) ;

  set_ip_address() ;
}

void set_ip_address() {
  prescene_net_address = new NetAddress(IP_address_prescene, port_prescene) ;
  for(int i = 0 ; i < scene_net_addresses.length ; i++) {
     scene_net_addresses[i] = new NetAddress(ID_address_scene[i], port_scene) ;
  }
}






void update_OSC() {
  OscMessage mess = new OscMessage("Controller");
  total_data_osc = 0;
  message_general_osc(mess);
  message_item_osc(mess);
  // send
  send_OSC(osc_prescene,osc_scene,prescene_net_address,scene_net_addresses,mess);
}


void message_general_osc(OscMessage m) {
  add_data(m,load_scene_setting);
  add_data(m,save_current_scene_setting);
  add_data(m,save_new_scene_setting);

  // add menu bar
  add_data(m,button_curtain.is());
  // add_data(m,button_midi.is());
 
  // dropdown general
  add_data(m,dropdown_bar[0].get_selection()); // font or shader ?
  add_data(m,dropdown_bar[1].get_selection()); // filter
  add_data(m,dropdown_bar[2].get_selection()); // font ?
  add_data(m,dropdown_bar[3].get_selection()); // text
  add_data(m,dropdown_bar[4].get_selection()); // bitmap
  add_data(m,dropdown_bar[5].get_selection()); // shape
  add_data(m,dropdown_bar[6].get_selection()); // movie

  // button general background
  add_data(m, button_bg.is());
  // button general light
  add_data(m,button_light_ambient.is());
  add_data(m,button_light_ambient_action.is());
  add_data(m,button_light_1.is());
  add_data(m,button_light_1_action.is());
  add_data(m,button_light_2.is());
  add_data(m,button_light_2_action.is());
  // button general sound
  add_data(m,button_kick.is());
  add_data(m,button_snare.is());
  add_data(m,button_hat.is());

  // add slider general
  for(int i = 0 ; i < value_slider_background.length ; i++) {
    add_data(m,value_slider_background[i]);
  }
  for(int i = 0 ; i < value_slider_filter.length ; i++) {
    add_data(m,value_slider_filter[i]);
  }
  for(int i = 0 ; i < value_slider_light.length ; i++) {
    add_data(m,value_slider_light[i]);
  }
  for(int i = 0 ; i < value_slider_sound.length ; i++) {
    add_data(m,value_slider_sound[i]);
  }
  for(int i = 0 ; i < value_slider_sound_setting.length ; i++) {
    add_data(m,value_slider_sound_setting[i]);
  }
  for(int i = 0 ; i < value_slider_camera.length ; i++) {
    add_data(m,value_slider_camera[i]);
  }
}

void message_item_osc(OscMessage m) {
  for ( int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    add_data(m,value_slider_item[i]); 
  }
  // add button item
  for (int i = 0 ; i < item_button_state.length ; i++) {
    add_data(m,item_button_state[i]); 
  }
  // add dropdown mode item
  for(int i = 0 ; i < NUM_ITEM ; i++) {
    int index = i +1;
    add_data(m,dropdown_item_mode[index].get_selection());
  }
}




void send_OSC(OscP5 osc_prescene, OscP5 osc_scene, NetAddress ad_prescene, NetAddress [] ad_scene,  OscMessage m) {
  if(send_is()) {
    osc_prescene.send(m,ad_prescene);
    // println(mess.arguments().length);
    if(LIVE) {
      for(int i = 0 ; i < ad_scene.length ; i++) {
        osc_scene.send(m, ad_scene[i]) ; 
      }
    }
  }
}







boolean send_message_is;
float ref_total_data_osc;
float total_data_osc;
boolean send_is() {
  if(total_data_osc != ref_total_data_osc) {
    send_message_is = true;
    ref_total_data_osc = total_data_osc;
  } else {
    send_message_is = false;
  }
  return send_message_is; 
}


void add_data(OscMessage m, Object obj) {
  boolean cast_float_like_int = true;
  // byte case
  if(obj instanceof Byte) {
    byte by = (byte)obj ;
    m.add(by);
    total_data_osc += by;
  } // int short
  else if(obj instanceof Short) {
    short s = (short)obj ;
    m.add(s);
    total_data_osc += s;
    // int case
  } else if(obj instanceof Integer) {
    int i = (int)obj ;
    m.add(i);
    total_data_osc += i;
  // float case  
  } else if(obj instanceof Float) {
    float f = (float)obj;
    if(cast_float_like_int) {
      int i = round(f);
      m.add(i);
      total_data_osc += i;
    } else {
      m.add(f); 
      total_data_osc += f; 
    }
  // String case
  } else if(obj instanceof String) {
    String s = (String)obj;
    m.add(s);
    total_data_osc += s.length(); 
  // boolean case
  } else if(obj instanceof Boolean) {
    boolean b = (boolean)obj;
    m.add(to_int(b));
    if(b) {
      total_data_osc++;
    } 
  }  
}


int to_int(boolean b) {
  if(b) return 1 ; else return 0;
}



  
  





  
