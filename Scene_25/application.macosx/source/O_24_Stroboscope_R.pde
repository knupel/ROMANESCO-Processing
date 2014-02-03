//GLOBAL
RomanescoTwentyFour romanescoTwentyFour ;
////////////////////////////////////////////////////////////////////
// Just in case you use a class must use an ArrayList in your object, 
// if it's not call the class in the class RomanescoTwentyFour just bellow




//SETUP
void romanescoTwentyFourSetup() {
    //MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 24 ; // 0 is Ref you must use a number is the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 2 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoTwentyFour = new RomanescoTwentyFour (ID, IDfamilly) ;

  romanescoTwentyFour.setting() ;
}

//DRAW
void romanescoTwentyFourDraw(String [] dataControleur, String [] dataMinim) {
  romanescoTwentyFour.getID() ;
  romanescoTwentyFour.data(dataControleur, dataMinim) ;
  romanescoTwentyFour.display() ;
}

//MOUSEPRESSED
void romanescoTwentyFourMousepressed() { romanescoTwentyFour.mousepressed() ; }
//MOUSERELEASED
void romanescoTwentyFourMousereleased() { romanescoTwentyFour.mousereleased() ; }
//MOUSE DRAGGED
void romanescoTwentyFourMousedragged() { romanescoTwentyFour.mousedragged() ; }
//KEYPRESSED
void romanescoTwentyFourKeypressed() { romanescoTwentyFour.keypressed() ; }
//KEY RELEASED
void romanescoTwentyFourKeyreleased() { romanescoTwentyFour.keyreleased() ; }

//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoTwentyFour() { return romanescoTwentyFour.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
//////////////////////////////////////////
class RomanescoTwentyFour extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //END OF FORBIDEN ZONE

  
  
  //CONSTRUCTOR
  RomanescoTwentyFour(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
    ///////IMPORTANT////////////////////////////////////
    //to call external class or library in class, now we must use "callingClass" like "this"
    /*
    name = new LibraryOrClass(callingClass);
    */
  }
  //END CONSTRUCTOR
  
  ////SETUP
  //the setting that's stuff that you'r put usually in the void setup() 
  void setting() {
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  //display
  void display() {
    // starting position
    if (startingPosition[IDobj]) startPosition(IDobj, width/2, height/2, 0) ;
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    //END OF DON'T TOUCH
    
    //////////////////////
    //HERE IT'S FOR YOU
    rectMode(CENTER) ;
    //thickness / épaisseur
    int thickness = 1 + (int(valueObj[IDobj][13]) ) ;
    //size / width and height of the object
    PVector sizeStrobo = new PVector (map(valueObj[IDobj][11], 0, 100, 0, 2 *width), map(valueObj[IDobj][12], 0, 100, 0, 2 *width) ) ;
    //orientation / degré
    rotation(valueObj[IDobj][18], mouse[IDobj].x, mouse[IDobj].y) ;
    //color
    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    //display the obj

    ////////////////////////////////////////////////////////////////////////////
    //MODE OF DISPLAY
    if (modeButton[IDobj] == 0 || modeButton[IDobj] == 255 ) {
      if (mix[IDobj]*15 > 5 ) {
        stroboRect(int(sizeStrobo.x),int(sizeStrobo.y), thickness, colorIn, colorOut) ;
        stroboRect(int(sizeStrobo.y),int(sizeStrobo.x), thickness, colorIn, colorOut) ;
      }
    } else if (modeButton[IDobj] == 1 ) {
      if (gauche[IDobj]*15 > 5 ) stroboRect(int(sizeStrobo.x),int(sizeStrobo.y), thickness, colorIn, colorOut) ;
      if (droite[IDobj]*15 > 5 ) stroboRect(int(sizeStrobo.y),int(sizeStrobo.x), thickness, colorIn, colorOut) ;
    } else if (modeButton[IDobj] == 2 ) {
      if ( beatEnergy.isOnset() || beatFrequency.isKick() || beatFrequency.isSnare() || beatFrequency.isHat() ) {
        stroboRect(int(sizeStrobo.x),int(sizeStrobo.y), thickness, colorIn, colorOut) ;
        stroboRect(int(sizeStrobo.y),int(sizeStrobo.x), thickness, colorIn, colorOut) ;
      }
    } else if (modeButton[IDobj] == 3 ) {
      if ( beatEnergy.isOnset() ) {
        stroboRect(int(sizeStrobo.x),int(sizeStrobo.y), thickness, colorIn, colorOut) ;
        stroboRect(int(sizeStrobo.y),int(sizeStrobo.x), thickness, colorIn, colorOut) ;
        }
    } else if (modeButton[IDobj] == 4 ) {
      if ( beatFrequency.isKick() ) {
        stroboRect(int(sizeStrobo.x),int(sizeStrobo.y), thickness, colorIn, colorOut) ;
        stroboRect(int(sizeStrobo.y),int(sizeStrobo.x), thickness, colorIn, colorOut) ;
      }
    } else if (modeButton[IDobj] == 5 ) {
      if ( beatFrequency.isSnare() ) {
        stroboRect(int(sizeStrobo.x),int(sizeStrobo.y), thickness, colorIn, colorOut) ;
        stroboRect(int(sizeStrobo.y),int(sizeStrobo.x), thickness, colorIn, colorOut) ;
      }
    } else if (modeButton[IDobj] == 6 ) {
      if ( beatFrequency.isHat() ) {
        stroboRect(int(sizeStrobo.x),int(sizeStrobo.y), thickness, colorIn, colorOut) ;
        stroboRect(int(sizeStrobo.y),int(sizeStrobo.x), thickness, colorIn, colorOut) ;
      }
    }

    
    ////////////////////////////////////////////////
    //add object from keyboard, press "N" for new one
    if(actionButton[IDobj] == 1 && nTouch ) {
      // yourList.add( new YourClass ());
    }
    /////////////////////////////
    //CLEAR THE LIST IF NECESSARY 
    if (romanescoEmptyList(IDobj)) {}
    
    
    
    //IT'S THE END FOR YOU
    //////////////////////
    
    //DON'T TOUCH
    popMatrix() ;
    //END OF DON'T TOUCH
  }
  //END DRAW
  ///////////
  
  
    void annexe() {}
  
  void stroboRect(int l, int h, float e, color cIn, color cOut)
  {
    //check the opacity of color
    int alphaIn = (cIn >> 24) & 0xFF; 
    int alphaOut = (cOut >> 24) & 0xFF; 
    // to display or not
    if ( alphaIn == 0 ) noFill() ; else fill (cIn) ;
    if ( alphaOut == 0) {
      noStroke() ;
    } else {
      stroke ( cOut ) ; 
      if( e < 0.1 ) e = 0.1 ; //security for the negative value
      strokeWeight (e) ;
    }
    rect (0, 0, l, h ) ;
  }
  //END ANNEXE
  ////////////
  
  
  
  
  
  
  
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
