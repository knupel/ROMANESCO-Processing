// Tab: B_Send_OSC
//GLOBAL
import oscP5.*;
import netP5.*;


// local
String IPadress = ("127.0.0.1") ;
// Message to Prescene
String toPreScene [] = new String [5] ;


OscP5 osc_1, osc_2;
NetAddress target_1, target_2 ;
void sendOSCsetup() {
 osc_1 = new OscP5(this, 10000);
 osc_2 = new OscP5(this, 9000);
 target_1 = new NetAddress(IPadress,10000);
 target_2 = new NetAddress(IPadress,9000);


}

void sendOSCdraw() {
  OscMessage RomanescoController = new OscMessage("Controller");
  
  //int value join in String 
  translateDataToSend() ;
  
  //BUTTON 
  toPreScene[0] = joinIntToString(value_button_G0) ; 
  toPreScene[1] = joinIntToString(value_button_item) ;
  
  
  // SLIDER
  /* Catch the value slider to send to Prescene
  @return value to the prescene between 0 to 99
  */
  // group general
  int[] dataGroupZero = new int[NUM_SLIDER_MISC] ;
  for ( int i = 1   ; i < NUM_SLIDER_MISC -1 ; i++) dataGroupZero[i-1] = floor(valueSlider[i]) ;
    toPreScene[2] = joinIntToString(dataGroupZero) ;

  // group item
  int[] dataGroupOne = new int[NUM_SLIDER_OBJ] ;
  for ( int i = 101   ; i < 101 +NUM_SLIDER_OBJ ; i++) dataGroupOne[i-101] = floor(valueSlider[i]) ; 
  toPreScene[3] = joinIntToString(dataGroupOne);



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
  osc_1.send(RomanescoController, target_1) ; 
  osc_2.send(RomanescoController, target_2) ; 
}



  
  
  
void translateDataToSend() {
  //BUTTON GLOBAL
  //sound
  value_button_G0[1] = state_button_beat ;
  value_button_G0[2] = state_button_kick ;
  value_button_G0[3] = state_button_snare ;
  value_button_G0[4] = state_button_hat ;

  value_button_G0[5] = dropdown_font.getSelection() +1 ; ;
  value_button_G0[6] = state_curtain_button ;
  value_button_G0[7] = state_BackgroundButton ;
  
  value_button_G0[8] = state_LightOneButton ;
  value_button_G0[9] = state_LightTwoButton ;
  value_button_G0[10] = state_LightAmbientButton ;
  value_button_G0[11] = state_LightOneAction ;
  value_button_G0[12] = state_LightTwoAction ;
  value_button_G0[13] = state_LightAmbientAction ;

  
  if(state_bg_shader > SWITCH_VALUE_FOR_DROPDOWN)     value_button_G0[14] = state_bg_shader ;
  if(state_image > SWITCH_VALUE_FOR_DROPDOWN)         value_button_G0[15] = state_image ;
  if(state_file_text > SWITCH_VALUE_FOR_DROPDOWN)     value_button_G0[16] = state_file_text ;
  if(state_camera_video > SWITCH_VALUE_FOR_DROPDOWN)  value_button_G0[17] = ID_camera_video_list[state_camera_video] ;

  
  //BUTTON GROUP ONE
  if(NUM_ITEM > 0 ) {
    for ( int i = 0 ; i < NUM_ITEM   ; i ++) {
      value_button_item[i *10 +1] = on_off_item[i *10 +1] ;
      value_button_item[i *10 +2] = on_off_item[i *10 +2] ;
      value_button_item[i *10 +3] = on_off_item[i *10 +3] ;
      value_button_item[i *10 +4] = on_off_item[i *10 +4] ;
      value_button_item[i *10 +5] = on_off_item[i *10 +5] ;
      if (dropdown[i+1] != null) value_button_item[i *10 +9] = dropdown[i+1].getSelection() ;
    }
  }
}
  





  
