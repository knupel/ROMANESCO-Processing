// Tab: B_Send_OSC
//GLOBAL
import oscP5.*;
import netP5.*;


// local
String IPadress = ("127.0.0.1") ;
// Message to Prescene
String toPreScene [] = new String [5] ;


OscP5 osc_prescene, osc_scene;
NetAddress target_prescene, target_scene ;
void set_OSC() {
  int address_prescene = 10_000 ;
  int address_scene = 9_500 ;
  osc_prescene = new OscP5(this, address_prescene) ;
  osc_scene = new OscP5(this, address_scene) ;

  target_prescene = new NetAddress(IPadress,address_prescene) ;
  target_scene = new NetAddress(IPadress,address_scene) ;
}


void draw_send_OSC() {
  OscMessage RomanescoController = new OscMessage("Controller");
  
  //int value join in String 
  translateDataToSend() ;
  
  //BUTTON 
  toPreScene[0] = join_int_to_String(value_button_general) ; 
  toPreScene[1] = join_int_to_String(value_button_item) ;
  
  
  // SLIDER
  /* Catch the value slider to send to Prescene
  @return value to the prescene between 0 to 99
  */
  // group general
  int[] data_OSC_general = new int[NUM_SLIDER_GENERAL] ;
  for ( int i = 1   ; i < NUM_SLIDER_GENERAL -1 ; i++) data_OSC_general[i-1] = floor(valueSlider[i]) ;
    toPreScene[2] = join_int_to_String(data_OSC_general) ;

  // group item
  int[] data_OSC_item = new int[NUM_SLIDER_ITEM] ;
  for ( int i = 101   ; i < 101 +NUM_SLIDER_ITEM ; i++) data_OSC_item[i-101] = floor(valueSlider[i]) ; 
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
  //send
  osc_prescene.send(RomanescoController, target_prescene) ; 
  osc_scene.send(RomanescoController, target_scene) ; 
}



  
  
  
void translateDataToSend() {
  //BUTTON GLOBAL
  //sound
  value_button_general[1] = state_button_beat ;
  value_button_general[2] = state_button_kick ;
  value_button_general[3] = state_button_snare ;
  value_button_general[4] = state_button_hat ;

  value_button_general[5] = dropdown_font.getSelection() +1 ; ;
  value_button_general[6] = state_curtain_button ;
  value_button_general[7] = state_BackgroundButton ;
  
  value_button_general[8] = state_LightOneButton ;
  value_button_general[9] = state_LightTwoButton ;
  value_button_general[10] = state_LightAmbientButton ;
  value_button_general[11] = state_LightOneAction ;
  value_button_general[12] = state_LightTwoAction ;
  value_button_general[13] = state_LightAmbientAction ;

  
  if(state_bg_shader > SWITCH_VALUE_FOR_DROPDOWN)     value_button_general[14] = state_bg_shader ;
  if(state_bitmap > SWITCH_VALUE_FOR_DROPDOWN)  value_button_general[15] = state_bitmap ;
  if(state_svg > SWITCH_VALUE_FOR_DROPDOWN)     value_button_general[16] = state_svg ;
  if(state_text > SWITCH_VALUE_FOR_DROPDOWN)     value_button_general[17] = state_text ;
  if(state_movie > SWITCH_VALUE_FOR_DROPDOWN)     value_button_general[18] = state_movie ;
  if(state_camera > SWITCH_VALUE_FOR_DROPDOWN)  value_button_general[19] = ID_camera_video_list[state_camera] ;

  
  //BUTTON GROUP ONE
  if(NUM_ITEM > 0 ) {
    for ( int i = 0 ; i < NUM_ITEM   ; i ++) {
      value_button_item[i *10 +1] = on_off_item_console[i *10 +1] ;
      value_button_item[i *10 +2] = on_off_item_console[i *10 +2] ;
      value_button_item[i *10 +3] = on_off_item_console[i *10 +3] ;
      value_button_item[i *10 +4] = on_off_item_console[i *10 +4] ;
      value_button_item[i *10 +5] = on_off_item_console[i *10 +5] ;
      if (dropdown[i+1] != null) value_button_item[i *10 +9] = dropdown[i+1].getSelection() ;
    }
  }
}
  





  
