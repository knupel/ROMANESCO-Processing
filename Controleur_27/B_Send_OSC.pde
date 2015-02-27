//GLOBAL
import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress targetPreScene ;
// local
String IPadress = ("127.0.0.1") ;
// Message to préScène
String toPreScene [] = new String [8] ;



void sendOSCsetup() {
  osc = new OscP5(this, 10000);
 targetPreScene = new NetAddress(IPadress,10000);
}

void sendOSCdraw() {
  OscMessage RomanescoControleur = new OscMessage("ROMANESCO contrôleur");
  
  //int value join in one String 
  translateDataToSend() ;
  
  //BUTTON to String
  toPreScene[0] = joinIntToString(valueButtonGlobal) ; 
  toPreScene[1] = joinIntToString(valueButtonObj) ;
  toPreScene[2] = joinIntToString(valueButtonTex) ;
  toPreScene[3] = joinIntToString(valueButtonTypo) ;
  
  // Catch the value slider to send to Prescene
    //return value to the prescene between 0 to 99

  // GROUP ZERO
  int[] dataGroupZero = new int[NUM_SLIDER_GLOBAL] ;
  for ( int i = 1   ; i < NUM_SLIDER_GLOBAL-1 ; i++) dataGroupZero[i-1] = floor(valueSlider[i]) ;
  // println(dataGroupZero) ;
  toPreScene[4] = joinIntToString(dataGroupZero) ;
  // GROUP ONE
  int[] dataGroupOne = new int[SLIDER_BY_GROUP] ;
  for ( int i = 101   ; i < 101 +SLIDER_BY_GROUP ; i++) dataGroupOne[i-101] = floor(valueSlider[i]) ; 
  toPreScene[5] = joinIntToString(dataGroupOne);
  // GROUP TWO
  int[] dataGroupTwo = new int[SLIDER_BY_GROUP] ;
  for ( int i = 201 ; i < 201 +SLIDER_BY_GROUP ; i++) dataGroupTwo[i-201] = floor(valueSlider[i]) ;
  toPreScene[6] = joinIntToString(dataGroupTwo) ;
  // GROUP THREE
  int[] dataGroupThree = new int[SLIDER_BY_GROUP] ;
  for ( int i = 301   ; i < 301 +SLIDER_BY_GROUP ; i++) dataGroupThree[i-301] = floor(valueSlider[i]) ;
  toPreScene[7] = joinIntToString(dataGroupThree) ;
  
  //add to OSC
  for ( int i = 0 ; i < toPreScene.length ; i++) {
    RomanescoControleur.add(toPreScene[i]);
  }
  
  //send
  osc.send(RomanescoControleur, targetPreScene ); 
}



  
  
  
void translateDataToSend() {
  //BUTTON GLOBAL
  //sound
  valueButtonGlobal[1] = EtatBbeat ;
  valueButtonGlobal[2] = EtatBkick ;
  valueButtonGlobal[3] = EtatBsnare ;
  valueButtonGlobal[4] = EtatBhat ;
  /*
  valueButtonGlobal[7] = dropdownFont.getSelection() +1 ; ;
  valueButtonGlobal[10] = EtatCurtainButton ;
  */
  valueButtonGlobal[5] = dropdownFont.getSelection() +1 ; ;
  valueButtonGlobal[6] = EtatCurtainButton ;
  valueButtonGlobal[7] = EtatBackgroundButton ;
  valueButtonGlobal[8] = EtatLightOneButton ;
  valueButtonGlobal[9] = EtatLightTwoButton ;
  valueButtonGlobal[10] = EtatLightOneAction ;
  valueButtonGlobal[11] = EtatLightTwoAction ;
  
  valueButtonGlobal[12] = EtatBackground ;
  valueButtonGlobal[13] = EtatImage ;
  valueButtonGlobal[14] = EtatFileText ;
  
  //BUTTON OBJ
  if(numGroup[1] > 0 ) {
    for ( int i = 0 ; i < numGroup[1]   ; i ++) {
      valueButtonObj[i *10 +1] = EtatBOf[i *10 +1] ;
      valueButtonObj[i *10 +2] = EtatBOf[i *10 +2] ;
      valueButtonObj[i *10 +3] = EtatBOf[i *10 +3] ;
      valueButtonObj[i *10 +4] = EtatBOf[i *10 +4] ;
      valueButtonObj[i *10 +5] = EtatBOf[i *10 +5] ;
      if (dropdown[i+1] != null) valueButtonObj[i *10 +9] = dropdown[i+1].getSelection() ;
    }
  }
  //BUTTON TEX

  if(numGroup[2] > 0 ) {
    for ( int i = 0 ; i < numGroup[2] ; i ++) {
      valueButtonTex[i *10 +1] = EtatBTf[i *10 +1] ;
      valueButtonTex[i *10 +2] = EtatBTf[i *10 +2] ;
      valueButtonTex[i *10 +3] = EtatBTf[i *10 +3] ;
      valueButtonTex[i *10 +4] = EtatBTf[i *10 +4] ;
      valueButtonTex[i *10 +5] = EtatBTf[i *10 +5] ;
      int whichDropdown = i+1 +numGroup[1] ;
      if (dropdown[whichDropdown] != null) valueButtonTex[i *10 +9] = dropdown[whichDropdown].getSelection() ;
    }
  }

  //BUTTON TYPO
  if(numGroup[3] > 0 ) {
    for ( int i = 0 ; i < numGroup[3] ; i ++) {
      valueButtonTypo[i *10 +1] = EtatBTYf[i *10 +1] ;
      valueButtonTypo[i *10 +2] = EtatBTYf[i *10 +2] ;
      valueButtonTypo[i *10 +3] = EtatBTYf[i *10 +3] ;
      valueButtonTypo[i *10 +4] = EtatBTYf[i *10 +4] ;
      valueButtonTypo[i *10 +5] = EtatBTYf[i *10 +5] ;
      int whichDropdown = i+1 +numGroup[1] +numGroup[2] ;
      if (dropdown[whichDropdown] != null)  valueButtonTypo[i *10 +9] = dropdown[whichDropdown].getSelection() ;
    }
  }
}
  





  
