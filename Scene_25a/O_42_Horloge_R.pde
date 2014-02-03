



//GLOBAL
RomanescoFortyTwo romanescoFortyTwo ;
////////////////////////////////////////////////////////////////////
// Just in case you use a class must use an ArrayList in your object, 
// if it's not call the class in the class RomanescoFortyTwo just bellow
/*
ArrayList<YourClass> yourList ;
*/



//SETUP
void romanescoFortyTwoSetup() {
  // YOU MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 42 ; // 0 is Ref you must use a number in the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 3 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoFortyTwo = new RomanescoFortyTwo (ID, IDfamilly) ;

  romanescoFortyTwo.setting() ;
}

//DRAW
void romanescoFortyTwoDraw(String [] dataControleur, String [] dataMinim) {
  romanescoFortyTwo.getID() ;
  romanescoFortyTwo.data(dataControleur, dataMinim) ;
  romanescoFortyTwo.display() ;
}

//MOUSEPRESSED
void romanescoFortyTwoMousepressed() { romanescoFortyTwo.mousepressed() ; }
//MOUSERELEASED
void romanescoFortyTwoMousereleased() { romanescoFortyTwo.mousereleased() ; }
//MOUSE DRAGGED
void romanescoFortyTwoMousedragged() { romanescoFortyTwo.mousedragged() ; }
//KEYPRESSED
void romanescoFortyTwoKeypressed() { romanescoFortyTwo.keypressed() ; }
//KEY RELEASED
void romanescoFortyTwoKeyreleased() { romanescoFortyTwo.keyreleased() ; }

//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoFortyTwo() { return romanescoFortyTwo.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
//////////////////////////////////////////
class RomanescoFortyTwo extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //CONSTRUCTOR
  RomanescoFortyTwo(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
  }
  //END CONSTRUCTOR
  
  ////SETUP
  //the setting that's stuff that you'r put usually in the void setup() 
  void setting() {
    //If you use font
    font[IDobj] = font[0] ;
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  //display
  void display() {
    // starting position
    if (startingPosition[IDobj]) startPosition(IDobj, width/2, height/2, 0) ;
    // if you use font in your object
    if (parameterButton[IDobj] == 1 ) font[IDobj] = font[0] ;
    
    
    //ENGINE OF VOID
     textAlign(CENTER);
    // typo
    float corps ;
    //size letter / corps
    corps = map(valueObj[IDobj][28], 0, 100, 6, 2 *height) ;
    textFont(font[IDobj], corps + (mix[IDobj] *30));
    
    // couleur du texte
    float t = valueObj[IDobj][4] * abs(mix[IDobj]) ;
    if ( soundButton[IDobj] != 1 ) { t = valueObj[IDobj][4] ; } 
    color c = color(map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3], t ) ;
    
    
    //DISPLAY OBJECT
    ///////////////
    //DON'T TOUCH
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    //END OF DON'T TOUCH
    
    //rotation / deg
    float angle = map(valueObj[IDobj][18], 0,100, 0, TAU) ;
    //amplitude
    float amp = map(valueObj[IDobj][17],0,100,0, width *.75) ;
    
    //CHANGE MODE DISPLAY
    /////////////////////
    if (modeButton[IDobj] == 0 || modeButton[IDobj] == 255 ) {
     horlogeCercle (mouse[IDobj], angle, amp, c, 12 ) ; // on 12 hours model english clock
    } else if (modeButton[IDobj] == 1 ) {
      horlogeCercle (mouse[IDobj], angle,  amp, c, 24 ) ; // on 24 hours model international clock
    } else if (modeButton[IDobj] == 2 ) {
      horlogeLigne  (mouse[IDobj], angle, amp, c, 12 ) ; // on 12 hours model english clock
    } else if (modeButton[IDobj] == 3 ) {
      horlogeLigne  (mouse[IDobj], angle, amp, c, 24 ) ; // on 24 hours model international clock
    } else if (modeButton[IDobj] == 4 ) {
      horlogeMinute(mouse[IDobj], angle, c) ;
    } else if (modeButton[IDobj] == 5 ) {
      horlogeSeconde(mouse[IDobj], angle, c) ;
    }
    
    //DON'T TOUCH
    popMatrix() ;
    //END OF DON'T TOUCH
  }
  //END DRAW
  ///////////
  
  
  
  
  
  //KEYPRESSED
  void keypressed() {}
  //KEY RELEASED
  void keyreleased() {}
  //MOUSEPRESSED
  void mousepressed() {}
  //MOUSE RELEASED
  void mousereleased() {}
  //MOUSE DRAGGED
  void mousedragged() {}
  
  
  //ANNEXE VOID
  void annexe() {}
  ////
  void horlogeCercle(PVector posHorloge, float angle, float  amp, color colorHorloge, int timeMode)
  {
    //Angles pour sin() et cos() départ à 3h, enlever PI/2 pour un départ à midi
    float s = map (second(), 0, 60, 0,    TWO_PI ) - HALF_PI ;
    float m = map (minute(), 0, 60, 0,    TWO_PI ) - HALF_PI ;
    float h = map (hour() % 12, 0, 12, 0, TWO_PI ) - HALF_PI ;
    
    fill (colorHorloge) ;
    //seconde
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
    rotate(angle) ;
    text (nf(second(),2), cos(s)*amp*8 , sin(s)*amp*8 ) ;
    //minute
    text (nf(minute(),2), cos(m)*amp*6 , sin(m)*amp*6  ) ;
    //heure
    text(nf(hour()%timeMode ,2), cos(h)*amp*4 , sin(h)*amp*4  ) ;
    // text
    if ( timeMode == 12 ) if (hour() < 12 ) text("AM", 0, 0) ; else  text("PM", 0, 0 ) ; else text("TIME", 0, 0) ;
    
    textAlign(LEFT, TOP) ;
  }
  
  
  ////
  void horlogeLigne(PVector posHorloge, float angle, float amp, color colorHorloge, int timeMode)
  {
  
    fill (colorHorloge) ;
    //seconde
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
    rotate(angle) ;
    text( nf(hour()%timeMode,2)   + "." + 
          nf(minute(),2)   + "." + 
          nf(second(),2), 
          0, 0);
    textAlign(LEFT, TOP) ;
  }
  
  ////
  void horlogeMinute(PVector posHorloge, float angle, color colorHorloge ) 
  {
    
    fill (colorHorloge) ;
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
    rotate(angle) ;
    text(hour() *60 + minute() + " MINUTES", 0,0) ;
    textAlign(LEFT, TOP) ;
  }
  
  ////
  void horlogeSeconde(PVector posHorloge, float angle, color colorHorloge ) 
  {
    
    fill (colorHorloge) ;
    textAlign(CENTER, CENTER) ;
    translate(posHorloge.x, posHorloge.y) ;
    rotate(angle) ;
    text((hour() *3600) + (minute() *60) + second() + " SECONDES", 0,0) ;
    textAlign(LEFT, TOP) ;
  }
  
  
  
  
  
  /////////////////////////////
  //FORDIDEN TO TOUCH THIS VOID
  /////////////////////////////
  //DATA VOID
  void data( String [] dataControler, String [] dataMinin) {
    super.data(dataControler, dataMinin) ;
  }
  ////////////
  //Return ID
  int getID() {
    return IDobj ;
  }
  int getIDfamilly() {
    return IDfamilly ;
  }
  ///////////////////////////
  //////////////////////////
}
