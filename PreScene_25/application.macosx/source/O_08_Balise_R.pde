//GLOBAL
RomanescoHeight romanescoHeight ;




//SETUP
void romanescoHeightSetup() {
    //MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 8 ; // 0 is Ref you must use a number is the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 1 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoHeight = new RomanescoHeight (ID, IDfamilly) ;

  romanescoHeight.setting() ;
}

//DRAW
void romanescoHeightDraw(String [] dataControleur, String [] dataMinim) {
  romanescoHeight.getID() ;
  romanescoHeight.data(dataControleur, dataMinim) ;
  romanescoHeight.display() ;
}

//MOUSEPRESSED
void romanescoHeightMousepressed() { romanescoHeight.mousepressed() ; }
//MOUSERELEASED
void romanescoHeightMousereleased() { romanescoHeight.mousereleased() ; }
//MOUSE DRAGGED
void romanescoHeightMousedragged() { romanescoHeight.mousedragged() ; }
//KEYPRESSED
void romanescoHeightKeypressed() { romanescoHeight.keypressed() ; }
//KEY RELEASED
void romanescoHeightKeyreleased() { romanescoHeight.keyreleased() ; }

//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoHeight() { return romanescoHeight.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
// here you can put your array list for example

//////////////////////////////////////////
class RomanescoHeight extends SuperRomanesco 
{
  int IDfamilly ;
  // class
  Spirale balise ;
  //speed
  float speed ;
  //CONSTRUCTOR
  RomanescoHeight(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
  }
  //END CONSTRUCTOR
  
  ////SETUP
  /////////
  void setting() {
    //motion
    motion[IDobj] = true ;
    // class
    balise = new Spirale() ;
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

    // speed
    if (motion[IDobj]) speed = (map(valueObj[IDobj][16], 0,100, 0,20)) *tempo[IDobj] ; else speed = 0.0 ;
    //thickness
    float e = 1 + valueObj[IDobj][13] ;
    //amplitude
    float amp = map(valueObj[IDobj][17], 0,100, 0, width *20) ;
    //color
    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    //hauteur / largeur
    float tempoEffect = 1 + ((beat[IDobj] -1  ) + (kick[IDobj] -1  ) + (snare[IDobj] -1  ) + (hat[IDobj] -1  ) );
    PVector sizeBalise  = new PVector (map(valueObj[IDobj][11], 0, 100, 0, height) *tempoEffect,map(valueObj[IDobj][12],0,100, 0, height) *tempoEffect ) ;
    // variable position
    float vx = gauche[IDobj] ;
    float vy = droite[IDobj] ;
    //quantity
    float radiusBalise = map(valueObj[IDobj][14], 0,100, 0, 511); // here the value max is 511 because we work with buffersize with 512 field
    
    balise.actualisation (mouse[IDobj].x , mouse[IDobj].y , speed) ;
    if (modeButton[IDobj] == 0 || modeButton[IDobj] == 255 ) {
      balise.baliseDisc (colorIn, colorOut, e, amp, vx, vy, sizeBalise, int(radiusBalise)) ;
    } else if (modeButton[IDobj] == 1 ) {
     balise.baliseRect (colorIn, colorOut, e, amp, vx, vy, sizeBalise, int(radiusBalise)) ;
    } 
    
    
    //IT'S THE END FOR YOU
    //////////////////////
    
    //DON'T TOUCH
    popMatrix() ;
    //END OF DON'T TOUCH
  }
  //END DRAW
  
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
