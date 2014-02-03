//GLOBAL
RomanescoYourNumber romanescoYourNumber ;
////////////////////////////////////////////////////////////////////
// Just in case you use a class must use an ArrayList in your object, 
// if it's not call the class in the class RomanescoYourNumber just bellow
/*
ArrayList<YourClass> yourList ;
*/



//SETUP
void romanescoYourNumberSetup() {
  // YOU MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 1 ; // 0 is Ref you must use a number in the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 1 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoYourNumber = new RomanescoYourNumber (ID, IDfamilly) ;

  romanescoYourNumber.setting() ;
}

//DRAW
void romanescoYourNumberDraw(String [] dataControleurLocal, String [] soundDataLocal) {
  romanescoYourNumber.getID() ;
  romanescoYourNumber.data(dataControleurLocal, soundDataLocal) ;
  romanescoYourNumber.display() ;
}



//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoYourNumber() { return romanescoYourNumber.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
//////////////////////////////////////////
class RomanescoYourNumber extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //END OF FORBIDEN ZONE
  
  ////////////////////////////////////////////////////////////////////////////////////////////////
  // YOUR VARIABLE OBJECT and CALL YOUR OWN CLASS HERE if it's not class that use an ArrayList //
  //////////////////////////////////////////////////////////////////////////////////////////////
  /*
  int var ; float var ; // etc
  YourClass yourClass ;
  */
  
  // CLASS_WITHOUT_ARRAYLIST class_without_arraylist
  ///////IMPORTANT///////////////////////////////////////////////////////////////////////////////////////////////////////////
  //to call external class or library in class we have write this line at the top of code : PApplet callingClass = this ////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //and here you call call your class
  /*
  LibraryOrClass name ; 
  */
  
  
  // END YOUR VARIABLE OBJECT
  ///////////////////////////
  
  
  //CONSTRUCTOR
  RomanescoYourNumber(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
    ///////IMPORTANT/////////////////////////////////////////////////////////////////////////////
    //to call external class or library in class, now we must use "callingClass" like "this" ///
    ///////////////////////////////////////////////////////////////////////////////////////////
    /*
    name = new LibraryOrClass(callingClass);
    */
  }
  //END CONSTRUCTOR
  
  ////SETUP
  //the setting that's stuff that you'r put usually in the void setup() 
  void setting() {
    // If you use font
    font[IDobj] = font[0] ;
    //motion is true by default is better the object move when you switch on this one
    motion[IDobj] = true ;
    
    // YOUR SETTING OBJECT :
    ////////////////////////    
    // by default is (0,0,0) if you want a specficic starting position, you can give coordonate here
    mouse[IDobj] = new PVector (30, height *.33, 0) ;
    // Just in case you use a class need to be clear in your object
     /*
    yourList = new ArrayList<YourClass>() ;
    */
    //class_without_arraylist = new CLASS_WITHOUT_ARRAYLIST() ;
    
    //CLASS who don't need use a list, genrally it's for single object
    /*
    yourClass = new YourClass() ;
    */

    

    
    //////////////////////////
    // END YOUR SETTING OBJECT
    
  }
  ///////////
  //END SETUP
  
  
  /////////
  //DISPLAY 
  void display() {
    // if you use font in your object
    if (parameterButton[IDobj] == 1 ) font[IDobj] = font[0] ;
    
    //DISPLAY OBJECT
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    //END OF DON'T TOUCH
    
    // CHECK INTERNET ACCESS
    /* if (internet ) { } */
    
    //CLASSIC DISPLAY
    // you can use a direct display or mode display to switch what you want display with a same engine object
    
    //EXAMPLE OBJECT
    example() ;
    //END YOUR WORK
    
    // MODE DISPLAY with the dropdown menu of controler
    /////////////////////
    if (modeButton[IDobj] == 0 || modeButton[IDobj] == 255 ) {
      //// just for information we use 0 to display the mode 1...same for the next mode +1...
    } else if (modeButton[IDobj] == 1 ) {
    } else if (modeButton[IDobj] == 2 ) {
    // and same for the next
    }
    
    //DON'T TOUCH
    // translate(P3Dposition[IDobj].x, P3Dposition[IDobj].y, P3Dposition[IDobj].z) ;

    popMatrix() ;
    //END of MODE DISPLAY
    /////////////////////
    
    
    //ADD OBJECT from keyboard, press "N" for new one
    //to spawn one thing
    if(actionButton[IDobj] == 1 && nTouch) { /* yourList.add( new YourClass ()); */ }
    //to spaw few things, you can add a modulo if you want
    int spawnFrequency = 3 ; 
    if(actionButton[IDobj] == 1 && nLongTouch && frameCount % spawnFrequency == 0 ) { /* yourList.add( new YourClass ()); */ }
    //END ADD OBJECT
    
    
    //CLEAR THE LIST IF NECESSARY 
    if (romanescoEmptyList(IDobj)) { 
    // yourList.clear() ; 
    }
  }
  //END DRAW
  //////////
  
  //ANNEXE VOID
  void annexe() {}
  //EXAMPLE
  float headPosition ;
  void example() {
    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    
    stroke(colorIn) ;
    strokeWeight(3) ;
    headPosition += tempo[IDobj] ;
    line(0,height *.5, headPosition,height *.5 );
    if (headPosition > width ) headPosition = 0 ;
    
    fill(colorOut) ; 
    textSize( 12 * (0.8 +pen[0].z)) ;
    int interlignage = int(15* (0.8 +pen[0].z)) ;
    text("Romanesco say press the space touch and use your pen",                                                                                                                         mouse[0].x +10, mouse[0].y + 20  ) ;
    
    text("La chanson dure depuis " + getTimeTrack() + " secondes",                                                                                                                       mouse[IDobj].x +10, mouse[IDobj].y + 20 + ( 2 * interlignage)  ) ;
    text("Volume Mix " + mix[IDobj]     + " Gauche "     + gauche[IDobj]    + " Droite "     + droite[IDobj] ,                                                                           mouse[IDobj].x +10, mouse[IDobj].y + 20 + ( 3 * interlignage) ) ;
    text("Beat "       + beat[IDobj]    + " Kick "       + kick[IDobj]      + " Snare "      + snare[IDobj]     + " Hat "         + hat[IDobj] ,                                         mouse[IDobj].x +10, mouse[IDobj].y + 20 + ( 4 * interlignage)) ;
    text("Tempo "      + tempo[IDobj]   + " Tempo Beat " + tempoBeat[IDobj] + " Tempo Kick " + tempoKick[IDobj] + " Tempo Snare " + tempoSnare[IDobj] + " Tempo Hat " + tempoHat[IDobj], mouse[IDobj].x +10, mouse[IDobj].y + 20 + ( 5 * interlignage)) ;
    text("Spectrum Band " +band[IDobj][0] ,                                                                                                                                              mouse[IDobj].x +10, mouse[IDobj].y + 20 + ( 6 * interlignage)) ;
    text("Cursor X "    + mouse[IDobj].x + " cursor Y "          + mouse[IDobj].y   + " cursor Z "    + mouse[IDobj].z  + " Molette " + wheel[0]  ,                                      mouse[IDobj].x +10, mouse[IDobj].y + 20 + ( 7 * interlignage)) ;
    text("Pen X "      + pen[IDobj].x   + " Y "          + pen[IDobj].y     + " Pression "   + pen[IDobj].z  ,                                                                           mouse[IDobj].x +10, mouse[IDobj].y + 20 + ( 8 * interlignage)) ;
  }
  //END EXAMPLE
  
  
  

  
  
  
  
  
  /////////////////////////////
  //FORDIDEN TO TOUCH THIS VOID
  /////////////////////////////
  //DATA VOID
  void data( String [] dataControlerLocal, String [] dataSoundLocal) {
    super.data(dataControlerLocal, dataSoundLocal) ;
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
