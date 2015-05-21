//GLOBAL
import oscP5.*;
import netP5.*;


// local
String IPadress = ("127.0.0.1") ;
// Message to Prescene
String toPreScene [] = new String [7] ;


OscP5 osc_1, osc_2;
NetAddress target_1, target_2 ;
void sendOSCsetup() {
 osc_1 = new OscP5(this, 10000);
 osc_2 = new OscP5(this, 9000);
 target_1 = new NetAddress(IPadress,10000);
 target_2 = new NetAddress(IPadress,9000);


}

void sendOSCdraw() {
  OscMessage RomanescoControleur = new OscMessage("Controller");
  
  //int value join in String 
  translateDataToSend() ;
  
  //BUTTON 
  toPreScene[0] = joinIntToString(valueButtonGroup_0) ; 
  toPreScene[1] = joinIntToString(valueButtonGroup_1) ;
  toPreScene[2] = joinIntToString(valueButtonGroup_2) ;
  
  
  // SLIDER
  /* Catch the value slider to send to Prescene
  @return value to the prescene between 0 to 99
  */
  // group 0
  int[] dataGroupZero = new int[NUM_SLIDER_MISC] ;
  for ( int i = 1   ; i < NUM_SLIDER_MISC -1 ; i++) dataGroupZero[i-1] = floor(valueSlider[i]) ;
    toPreScene[3] = joinIntToString(dataGroupZero) ;

  // group 1
  int[] dataGroupOne = new int[NUM_SLIDER_OBJ] ;
  for ( int i = 101   ; i < 101 +NUM_SLIDER_OBJ ; i++) dataGroupOne[i-101] = floor(valueSlider[i]) ; 
  toPreScene[4] = joinIntToString(dataGroupOne);

  // group 2
  int[] dataGroupTwo = new int[NUM_SLIDER_OBJ] ;
  for ( int i = 201 ; i < 201 +NUM_SLIDER_OBJ ; i++) dataGroupTwo[i-201] = floor(valueSlider[i]) ;
  toPreScene[5] = joinIntToString(dataGroupTwo) ;


  // LOAD SAVE SCENE ORDER
  String load = String.valueOf(load_Scene_Setting) ;
  String  saveCurrent = String.valueOf(save_Current_Scene_Setting) ;
  String  saveNew = String.valueOf(save_New_Scene_Setting) ;
  load_Scene_Setting = save_Current_Scene_Setting = save_New_Scene_Setting = false ;
  toPreScene[6] = load + "/" +  saveCurrent + "/" + saveNew;
  
  //add to OSC
  for ( int i = 0 ; i < toPreScene.length ; i++) {
    RomanescoControleur.add(toPreScene[i]);
  }
  //send
  osc_1.send(RomanescoControleur, target_1) ; 
  osc_2.send(RomanescoControleur, target_2) ; 
}



  
  
  
void translateDataToSend() {
  //BUTTON GLOBAL
  //sound
  valueButtonGroup_0[1] = EtatBbeat ;
  valueButtonGroup_0[2] = EtatBkick ;
  valueButtonGroup_0[3] = EtatBsnare ;
  valueButtonGroup_0[4] = EtatBhat ;

  valueButtonGroup_0[5] = dropdownFont.getSelection() +1 ; ;
  valueButtonGroup_0[6] = EtatCurtainButton ;
  valueButtonGroup_0[7] = EtatBackgroundButton ;
  
  valueButtonGroup_0[8] = EtatLightOneButton ;
  valueButtonGroup_0[9] = EtatLightTwoButton ;
  valueButtonGroup_0[10] = EtatLightAmbientButton ;
  valueButtonGroup_0[11] = EtatLightOneAction ;
  valueButtonGroup_0[12] = EtatLightTwoAction ;
  valueButtonGroup_0[13] = EtatLightAmbientAction ;
  
  valueButtonGroup_0[14] = EtatBackgroundShader ;
  valueButtonGroup_0[15] = EtatImage ;
  valueButtonGroup_0[16] = EtatFileText ;
  /*
  valueButtonGroup_0[12] = EtatBackground ;
  valueButtonGroup_0[13] = EtatImage ;
  valueButtonGroup_0[14] = EtatFileText ;
  */
  
  //BUTTON GROUP ONE
  if(numGroup[1] > 0 ) {
    for ( int i = 0 ; i < numGroup[1]   ; i ++) {
      valueButtonGroup_1[i *10 +1] = EtatBOf[i *10 +1] ;
      valueButtonGroup_1[i *10 +2] = EtatBOf[i *10 +2] ;
      valueButtonGroup_1[i *10 +3] = EtatBOf[i *10 +3] ;
      valueButtonGroup_1[i *10 +4] = EtatBOf[i *10 +4] ;
      valueButtonGroup_1[i *10 +5] = EtatBOf[i *10 +5] ;
      if (dropdown[i+1] != null) valueButtonGroup_1[i *10 +9] = dropdown[i+1].getSelection() ;
    }
  }
  
  //BUTTON GROUP TWO
  if(numGroup[2] > 0 ) {
    for ( int i = 0 ; i < numGroup[2] ; i ++) {
      valueButtonGroup_2[i *10 +1] = EtatBTf[i *10 +1] ;
      valueButtonGroup_2[i *10 +2] = EtatBTf[i *10 +2] ;
      valueButtonGroup_2[i *10 +3] = EtatBTf[i *10 +3] ;
      valueButtonGroup_2[i *10 +4] = EtatBTf[i *10 +4] ;
      valueButtonGroup_2[i *10 +5] = EtatBTf[i *10 +5] ;
      int whichDropdown = i+1 +numGroup[1] ;
      if (dropdown[whichDropdown] != null) valueButtonGroup_2[i *10 +9] = dropdown[whichDropdown].getSelection() ;
    }
  }
}
  





  
