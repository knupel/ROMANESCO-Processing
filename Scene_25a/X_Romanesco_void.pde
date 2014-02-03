//Special var for the Scene and the Miroir
PVector mouseCamera, pmouseCamera, mouseSuperRomanesco, pmouseSuperRomanesco ;

//SETUP
void romanescoSetup()
{
  romanescoOneSetup() ;       romanescoTwoSetup() ;        romanescoThreeSetup() ;       romanescoFourSetup() ;       romanescoFiveSetup() ;       romanescoSixSetup() ;       romanescoSevenSetup() ; romanescoHeightSetup() ; romanescoNineSetup() ;
  romanescoTwentyOneSetup() ; romanescoTwentyTwoSetup() ;  romanescoTwentyThreeSetup() ; romanescoTwentyFourSetup() ; romanescoTwentyFiveSetup() ; romanescoTwentySixSetup() ; romanescoTwentySevenSetup() ;
  romanescoFortyOneSetup() ;  romanescoFortyTwoSetup() ;   romanescoFortyThreeSetup() ;  romanescoFortyFourSetup() ;  romanescoFortyFiveSetup() ;
  
  //init the tablet and the mouse
  for ( int i = 0 ; i < numObj + 1 ; i++ ) {
    pen[i] = new PVector (1,1,1) ;
    mouse[i] = new PVector (0,0,0) ;
    pmouse[i] = new PVector (0,0,0) ;
    motion[i] = true ;
    startingPosition[i] = true ;
    startingPos[i] = new PVector(0,0,0) ;
    pathFontObjTTF[i] = pathFontTTF[0] ;
    
  }
  //init the mouse Reference
  pmouse[0] = new PVector (0,0,0) ;
  mouse[0] = new PVector (0,0,0) ;
  mouseSuperRomanesco = new PVector(0,0,0) ;
  mouseCamera = new PVector(0,0,0) ;
  pmouseSuperRomanesco = new PVector(0,0,0) ;
  pmouseCamera = new PVector(0,0,0) ;
}


//DRAW
void romanescoDraw() {
  if (eCurtain != 1) {
    //MODEL
      //YOUR NUMBER
      /*
    if ( mainButton[9] == 1 ) {
      if ( getFamillyRomanescoNine() == 1 ) dataControler = dataControlerObj ; 
      if ( getFamillyRomanescoNine() == 2 ) dataControler = dataControlerTrame ; 
      if ( getFamillyRomanescoNine() == 3 ) dataControler = dataControlerTypo ;
      romanescoNineDraw(dataControler, dataSoundGlobal) ;
    }
    */
    //call the data from contrôleur
    romanescoData() ;
    //check if the object is ON or OFF
    //  ONE
    if ( mainButton[1] == 1 ) {
      if ( getFamillyRomanescoOne() == 1 ) dataControler = dataControlerObj ; 
      romanescoOneDraw(dataControler, dataSoundGlobal) ;
    }  
    //  TWO
    if ( mainButton[2] == 1 ) {
      if ( getFamillyRomanescoTwo() == 1 ) dataControler = dataControlerObj ; 
      romanescoTwoDraw(dataControler, dataSoundGlobal) ;
    }
    // THREE
    if ( mainButton[3] == 1 ) {
      if ( getFamillyRomanescoThree() == 1 ) dataControler = dataControlerObj ; 
      romanescoThreeDraw(dataControler, dataSoundGlobal) ;
    }
    //  FOUR
    if ( mainButton[4] == 1 ) {
      if ( getFamillyRomanescoFour() == 1 ) dataControler = dataControlerObj ; 
      romanescoFourDraw(dataControler, dataSoundGlobal) ;
    }
    //  FIVE
    if ( mainButton[5] == 1 ) {
      if ( getFamillyRomanescoFive() == 1 ) dataControler = dataControlerObj ; 
      romanescoFiveDraw(dataControler, dataSoundGlobal) ;
    }
    // SIX
    if ( mainButton[6] == 1 ) {
      if ( getFamillyRomanescoSix() == 1 ) dataControler = dataControlerObj ; 
      romanescoSixDraw(dataControler, dataSoundGlobal) ;
    }
      // SEVEN
    if ( mainButton[7] == 1 ) {
      if ( getFamillyRomanescoSeven() == 1 ) dataControler = dataControlerObj ; 
      romanescoSevenDraw(dataControler, dataSoundGlobal) ;
    }
    // HEIGHT
    if ( mainButton[8] == 1 ) {
      if ( getFamillyRomanescoHeight() == 1 ) dataControler = dataControlerObj ; 
      romanescoHeightDraw(dataControler, dataSoundGlobal) ;
    }
    //Nine
    if ( mainButton[9] == 1 ) {
      if ( getFamillyRomanescoNine() == 1 ) dataControler = dataControlerObj ; 
      romanescoNineDraw(dataControler, dataSoundGlobal) ;
    }
    
    //TEXTURE familly is  2
    //TWENTY ONE
    if ( mainButton[21] == 1 ) {
      if ( getFamillyRomanescoTwentyOne() == 2 ) dataControler = dataControlerTrame ; 
      romanescoTwentyOneDraw(dataControler, dataSoundGlobal) ;
    }
      //TWENTY TWO
    if ( mainButton[22] == 1 ) {
      if ( getFamillyRomanescoTwentyTwo() == 2 ) dataControler = dataControlerTrame ; 
      romanescoTwentyTwoDraw(dataControler, dataSoundGlobal) ;
    }
    //TWENTY THREE
    if ( mainButton[23] == 1 ) {
      if ( getFamillyRomanescoTwentyThree() == 2 ) dataControler = dataControlerTrame ; 
      romanescoTwentyThreeDraw(dataControler, dataSoundGlobal) ;
    }
    //TWENTY FOUR
    if ( mainButton[24] == 1 ) {
      if ( getFamillyRomanescoTwentyFour() == 2 ) dataControler = dataControlerTrame ; 
      romanescoTwentyFourDraw(dataControler, dataSoundGlobal) ;
    }
    //TWENTY FIVE
    if ( mainButton[25] == 1 ) {
      if ( getFamillyRomanescoTwentyFive() == 2 ) dataControler = dataControlerTrame ; 
      romanescoTwentyFiveDraw(dataControler, dataSoundGlobal) ;
    }
    //TWENTY SIX
    if ( mainButton[26] == 1 ) {
      if ( getFamillyRomanescoTwentySix() == 2 ) dataControler = dataControlerTrame ; 
      romanescoTwentySixDraw(dataControler, dataSoundGlobal) ;
    }
    //TWENTY SEVEN
    if ( mainButton[27] == 1 ) {
      if ( getFamillyRomanescoTwentySeven() == 2 ) dataControler = dataControlerTrame ; 
      romanescoTwentySevenDraw(dataControler, dataSoundGlobal) ;
    }
    
    //TYPO
    //FORTY ONE
    if ( mainButton[41] == 1 ) {
      if ( getFamillyRomanescoFortyOne() == 3 ) dataControler = dataControlerTypo ;
      romanescoFortyOneDraw(dataControler, dataSoundGlobal) ;
    }
    //FORTY TWO
    if ( mainButton[42] == 1 ) {
      if ( getFamillyRomanescoFortyTwo() == 3 ) dataControler = dataControlerTypo ;
      romanescoFortyTwoDraw(dataControler, dataSoundGlobal) ;
    }
    //FORTY THREE
    if ( mainButton[43] == 1 ) {
      if ( getFamillyRomanescoFortyThree() == 3 ) dataControler = dataControlerTypo ;
      romanescoFortyThreeDraw(dataControler, dataSoundGlobal) ;
    }
    //FORTY FOUR
    if ( mainButton[44] == 1 ) {
      if ( getFamillyRomanescoFortyFour() == 3 ) dataControler = dataControlerTypo ;
      romanescoFortyFourDraw(dataControler, dataSoundGlobal) ;
    }
    //FORTY FIVE
    if ( mainButton[45] == 1 ) {
      if ( getFamillyRomanescoFortyFive() == 3 ) dataControler = dataControlerTypo ;
      romanescoFortyFiveDraw(dataControler, dataSoundGlobal) ;
    }
  }

}




////////////
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
///////////////



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
