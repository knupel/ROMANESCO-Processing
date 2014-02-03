//SETUP
void romanescoSetup() {
  romanescoYourNumberSetup() ;
  //init the tablet
  for ( int i = 0 ; i < numObj + 1 ; i ++ ) {
    pen[i] = new PVector (1,1,1) ;
    mouse[i] = new PVector (0,0,0) ;
  }
}
//DRAW
void romanescoDraw() {
  //to call the data from contrôleur
  romanescoData() ;
  //check if the object is ON or OFF
  //  ONE
  if ( mainButton[1] == 1 ) {
    if ( getFamillyRomanescoYourNumber() == 1 ) dataControler = dataControlerObj ; 
    romanescoYourNumberDraw(dataControler, dataSoundGlobal) ;
  }
  if ( mainButton[21] == 1 ) {
    if ( getFamillyRomanescoYourNumber() == 2 ) dataControler = dataControlerTrame ; 
    romanescoYourNumberDraw(dataControler, dataSoundGlobal) ;
  }
  if ( mainButton[41] == 1 ) {
    if ( getFamillyRomanescoYourNumber() == 3 ) dataControler = dataControlerTypo ;
    romanescoYourNumberDraw(dataControler, dataSoundGlobal) ;
  }
  /*
  if ( getFamillyRomanescoYourNumber() == 1 ) dataControler = dataControlerObj ; 
  if ( getFamillyRomanescoYourNumber() == 2 ) dataControler = dataControlerTrame ; 
  if ( getFamillyRomanescoYourNumber() == 3 ) dataControler = dataControlerTypo ;
  romanescoYourNumberDraw(dataControler, dataMinim) ;
  */
}




//EMPTY LIST
boolean romanescoEmptyList(int ID) {
  boolean e = false ;
  //global delete
  if (backspaceTouch) e = true ;
  //SPECIFIC DELETE when the paramer button of contrôleur is ON
  else if (deleteTouch) if ( actionButton[ID] == 1 ) e = true ;
  return e ;
}
//END EMPTY LIST

///////
//annexe void
//ROMANESCO DATA
int numDataGlobal = 10 ;
int numDataSlider = 30 ;

//data from controleur
String [] dataGlobal = new String [numDataGlobal] ;
String [] dataControlerObj = new String [numDataSlider +1] ;
String [] dataControlerTrame = new String [numDataSlider +1] ;
String [] dataControlerTypo = new String [numDataSlider +1] ;
String [] dataControler = new String [numDataSlider +1] ;
//data from minim
String [] dataSoundGlobal = new String [26] ;

//
void romanescoData() {
  // collecting value from controler and put in the specific familly String to send to each classes
  for ( int i = 1 ; i < numDataGlobal ; i ++ ) {
    dataGlobal [i] = Float.toString(valueSliderGlobal[i]) ;
  }
  for ( int i = 0 ; i < numDataSlider ; i ++ ) {
    dataControlerObj   [i +1] = Float.toString(valueSliderObj[i]) ;
    dataControlerTrame [i +1] = Float.toString(valueSliderTex[i]) ;
    dataControlerTypo  [i +1] = Float.toString(valueSliderTypo[i]) ;
  }
  //convert minim info
  dataSoundGlobal[0] = Float.toString(gauche[0]) ;
  dataSoundGlobal[1] = Float.toString(droite[0]) ;
  dataSoundGlobal[2] = Float.toString(mix[0]) ;
  dataSoundGlobal[3] = Float.toString(getBeat(beatOnOff)) ;
  dataSoundGlobal[4] = Float.toString(getKick(kickOnOff)) ;
  dataSoundGlobal[5] = Float.toString(getSnare(snareOnOff)) ;
  dataSoundGlobal[6] = Float.toString(getHat(hatOnOff)) ;
  
  for (int i = 0 ; i < numBand ; i++) {
    dataSoundGlobal[10 + i] = Float.toString(bandSprectrum[i]) ;
  }
}
