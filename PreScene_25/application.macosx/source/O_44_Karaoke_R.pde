//GLOBAL
RomanescoFortyFour romanescoFortyFour ;
////////////////////////////////////////////////////////////////////
// Just in case you use a class must use an ArrayList in your object, 
// if it's not call the class in the class RomanescoFortyFour just bellow
/*
ArrayList<YourClass> yourList ;
*/



//SETUP
void romanescoFortyFourSetup() {
  // YOU MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 44 ; // 0 is Ref you must use a number in the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 3 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoFortyFour = new RomanescoFortyFour (ID, IDfamilly) ;

  romanescoFortyFour.setting() ;
}

//DRAW
void romanescoFortyFourDraw(String [] dataControleur, String [] dataMinim) {
  romanescoFortyFour.getID() ;
  romanescoFortyFour.data(dataControleur, dataMinim) ;
  romanescoFortyFour.display() ;
}



//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoFortyFour() { return romanescoFortyFour.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
//////////////////////////////////////////
class RomanescoFortyFour extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //END OF FORBIDEN ZONE
  
  ////////////////////////////////////////////////
  // YOUR VARIABLE OBJECT 
  // and CALL YOUR OWN CLASS HERE 
  // if it's not class that use an ArrayList
  /*
  int var ; float var ; // etc
  YourClass yourClass ;
  */
  int chapter, sentence ;
  
  // CLASS_WITHOUT_ARRAYLIST class_without_arraylist
   /*
  ///////IMPORTANT////////////////////////////////////
  //to call external class or library in class
  //we have write this line at the top of code : 
  PApplet callingClass = this ;
  //and here you call call your class
  LibraryOrClass name ; 
  */
  
  
  // END YOUR VARIABLE OBJECT
  ///////////////////////////
  
  
  //CONSTRUCTOR
  RomanescoFortyFour(int ID, int IDfamilly) {
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
    font[IDobj] = font[0] ;
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  //display
  void display() {
    // starting position
    if (startingPosition[IDobj]) startPosition(IDobj, width/2, height/2, 0) ;

    //DON'T TOUCH
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    //END OF DON'T TOUCH
    
    //////////////////////
    //HERE IT'S FOR YOU

    
    if (parameterButton[IDobj] == 1 ) font[IDobj] = font[0] ;
    
    
    //ENGINE OF VOID
    float corps ;
    //size text / corps
    corps = map(valueObj[IDobj][28], 0, 100, 1, height *0.1) ;
    // couleur du texte
    float t = valueObj[IDobj][4] * abs(mix[IDobj]) ;
    if ( soundButton[IDobj] != 1 ) { t = valueObj[IDobj][4] ; } 
    color colorIn = color (map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3], t ) ;
    //hauteur largeur, height and width
    float h = map (valueObj[IDobj][11], 0, 100, 0, height *3 ) ;
    float l = map (valueObj[IDobj][12], 0, 100, 0, width *5 ) ;
    
    
    //tracking chapter
    String karaokeChapters [] = split(textRaw, "*") ;
    //security button
    if(actionButton[IDobj] == 1 && nLongTouch ) {
      
      if (chapter > -1 && chapter < karaokeChapters.length  && nextPrevious && (leftTouch || rightTouch  )) {
        chapter = chapter + tracking(chapter, karaokeChapters.length ) ;
        sentence = 0 ; // reset to start the chapter at the begin, and display the first sentence
        trackerUpdate = 0 ;
      // to choice a texte with the keyboard number 1 to 10 the zero is ten
      } else if (nextPrevious && touch0 && karaokeChapters.length > 9 ) {
        chapter = 0 ;  sentence = 0 ;
      } else if (nextPrevious && touch9 && karaokeChapters.length > 8 ) {
        chapter = 9 ;  sentence = 0 ;
      } else if (nextPrevious && touch8 && karaokeChapters.length > 7 ) {
        chapter = 8 ;  sentence = 0 ;
      } else if (nextPrevious && touch7 && karaokeChapters.length > 6 ) {
        chapter = 7 ;  sentence = 0 ;
      } else if (nextPrevious && touch6 && karaokeChapters.length > 5 ) {
        chapter = 6 ;  sentence = 0 ;
      } else if (nextPrevious && touch5 && karaokeChapters.length > 4 ) {
        chapter = 5 ;  sentence = 0 ;
      } else if (nextPrevious && touch4 && karaokeChapters.length > 3 ) {
        chapter = 4 ;  sentence = 0 ;
      } else if (nextPrevious && touch3  && karaokeChapters.length > 2 ) {
        chapter = 3 ; sentence = 0 ;
      } else if (nextPrevious && touch2 && karaokeChapters.length > 1 ) {
        chapter = 2 ; sentence = 0 ;
      } else if (nextPrevious && touch1 && karaokeChapters.length > 0 ) {
        chapter = 1 ; sentence = 0 ;
      }
    }
    
    //tracking sentence
    if ( chapter < karaokeChapters.length) {
      String karaokeSentences [] = split(karaokeChapters[chapter], "/") ;
      if (sentence > -1 && sentence < karaokeSentences.length  && nextPrevious && (downTouch || upTouch) ) {
        sentence = sentence + tracking(sentence, karaokeSentences.length ) ;
        trackerUpdate = 0 ;
      }
      rotation(valueObj[IDobj][18], mouse[IDobj].x, mouse[IDobj].y) ;
      //DISPLAY
      textAlign(CORNER);
      textFont(font[IDobj], corps + (mix[IDobj]) *6 *beat[IDobj]);
      fill(colorIn) ;
      text(karaokeSentences[sentence], 0 , 0 , l, h ) ;
    }
    
    
    //DISPLAY OBJECT
    // you can use a direct display or mode display to switch what you want display with a same engine object
    //CLASSIC DISPLAY
    ////////////////


    
    
    //CHANGE MODE DISPLAY
    /////////////////////
    if (modeButton[IDobj] == 0 || modeButton[IDobj] == 255 ) {
      //
    } else if (modeButton[IDobj] == 1 ) {
      //
    } else if (modeButton[IDobj] == 2 ) {
      //
    }
    //END of MODE DISPLAY
    /////////////////////

    ////////////////////////////////////////////////
    //add object from keyboard, press "N" for new one
    if(actionButton[IDobj] == 1 && nTouch ) {
      //yourList.add( new YourClass ());
    }
    
    
    //CLEAR THE LIST IF NECESSARY 
    if (romanescoEmptyList(IDobj)) {}
    //IT'S THE END FOR YOU
    //////////////////////
    
    
    
    
    //DON'T TOUCH
    popMatrix() ;
    //END OF DON'T TOUCH
  }
  //END DRAW
  /////////

  
  
  //ANNEXE VOID
  void annexe() {}
  
  
  
  
  
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
