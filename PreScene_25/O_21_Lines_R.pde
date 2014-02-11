//GLOBAL
RomanescoTwentyOne romanescoTwentyOne ;
//Just in case you use a class must use an ArrayList in your object, if it's not call the class in the class RomanescoTwentyOne just bellow




//SETUP
void romanescoTwentyOneSetup() {
    //MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 21 ; // 0 is Ref you must use a number is the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 2 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoTwentyOne = new RomanescoTwentyOne (ID, IDfamilly) ;

  romanescoTwentyOne.setting() ;
}

//DRAW
void romanescoTwentyOneDraw(String [] dataControleur, String [] dataMinim) {
  romanescoTwentyOne.getID() ;
  romanescoTwentyOne.data(dataControleur, dataMinim) ;
  romanescoTwentyOne.display() ;
}



//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoTwentyOne() { return romanescoTwentyOne.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
//////////////////////////////////////////
class RomanescoTwentyOne extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //END OF FORBIDEN ZONE
  
  ////////////////////////////////////////////////
  // YOUR VARIABLE OBJECT and CALL YOUR OWN CLASS HERE if it's not class that use an ArrayList
  Line line ;
  // CLASS_WITHOUT_ARRAYLIST class_without_arraylist
   /*
  ///////IMPORTANT////////////////////////////////////
  //to call external class or library in class
  //we have write this line at the top of code : 
  PApplet callingClass = this ;
  //and here you call call your class
  LibraryOrClass name ; 
  */
  float ampLine  =1.0 ;
  // speed
  float speed ;
  
  
  // END YOUR VARIABLE OBJECT
  ///////////////////////////
  
  
  //CONSTRUCTOR
  RomanescoTwentyOne(int ID, int IDfamilly) {
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
   //motion
   motion[IDobj] = true ;
    //class_without_arraylist = new CLASS_WITHOUT_ARRAYLIST() ;
    line = new Line() ;
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  float thicknessLine ;
  //display
  void display() {
    // starting position
    //if (startingPosition[IDobj]) startPosition(IDobj, 0, 0, 0) ;
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    //END OF DON'T TOUCH
    //////////////////////
    
    
    //HERE IT'S FOR YOU
    //thickness / épaisseur
    if( beat[IDobj] > 1 ) {
      ampLine = beat[IDobj] *(map(valueObj[IDobj][17], 0,100, 0, 3)) ;
      thicknessLine = (valueObj[IDobj][13] *ampLine ) ;
    } else {
      thicknessLine = valueObj[IDobj][13] ;
    }

    //speed
    if(motion[IDobj]) speed = map(valueObj[IDobj][16], 0,100, -25,25 ) * tempo[IDobj]  ; else speed = 0.0 ;
    //to stop the move
    if (actionButton[IDobj] == 1  && spaceTouch ) speed = 0.0 ;
    
    rotation(valueObj[IDobj][18], mouse[IDobj].x, mouse[IDobj].y ) ;
    
    //quantité
    float q = map(valueObj[IDobj][14], 0, 100, width , height *.2) ;
    //color
    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    // color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;


    line.drawLine (speed, q , colorIn,  thicknessLine) ;   //PARAMETER THAT YOU CAN USE

    
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






// CLASS LINE
/////////////
/////////////
//CLASS TRAME
class Line 
{
  Line()  { }
  
  float nbrlgn ; 
  int vitesse ;
  float vd, vg ;
  
  void drawLine ( float v, float q, color cOut, float e) {
    if( e < 0.1 ) e = 0.1 ; //security for the negative value
    stroke (cOut) ; strokeWeight(e) ;
    float quantite = q*q *.001 ;
    //nbrlgn = quantite ;
   nbrlgn = (width + height) / quantite  ;
    vitesse += (v) ;
    if ( abs(vitesse) > quantite ) {
      vitesse = 0 ; 
    }
    for (int i=0 ; i < nbrlgn +1 ; i++) {
      float x1 = ( -(height) +i*( (width+ height ) /nbrlgn) ) +vitesse -e ;
      float y1 = -e ;
      float x2 =  ( 0 +i*( (width + height )  /nbrlgn) ) +vitesse +e ;
      float y2 = width+height +e ; 
      line ( x1 , y1 , x2 , y2);
    }
  }

}
