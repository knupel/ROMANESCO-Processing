RomanescoOne romanescoOne ;

//SETUP
void romanescoOneSetup(int ID) {
  romanescoOne = new RomanescoOne (ID) ;
  romanescoOne.setting() ;
}

//DRAW
void romanescoOneDraw(String [] dataControleur, String [] dataMinim) {
  romanescoOne.getID() ;
  romanescoOne.data(dataControleur, dataMinim) ;
  romanescoOne.display() ;
}


//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoOne() { return romanescoOne.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
// here you can put your array list for example

//////////////////////////////////////////
class RomanescoOne extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly = 1 ; // 0 is global // 1 is single object // 2 is trame // 3 is typo
  //END OF FORBIDEN ZONE
  
  /////////////////////////
  // YOUR VARIABLE OBJECT :
  Tri triangle1, triangle2 ;
  // END YOUR VARIABLE OBJECT
  ///////////////////////////
  
  
  //CONSTRUCTOR
  RomanescoOne(int ID) {
    super(ID) ;
  }
  //END CONSTRUCTOR
  
  ////SETUP
  /////////
  void setting() {
    // class
    triangle1 = new Tri ();
    triangle2 = new Tri ();
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  float e ; 
  float vitesse ;
  //display
  void display() {
    // starting position
    // if (startingPosition[IDobj]) startPosition(IDobj, width, height, 0) ;
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    
    //thickness
    if (soundButton[IDobj] != 0 ) e = map(valueObj[IDobj][13],0,100,0,height *.1) * abs(sq(mix[1]) *20) ; else e = map(valueObj[IDobj][13],0,100,0,height *.1) ;
    // speed
    if (soundButton[IDobj] != 0 ) {
      if (getTimeTrack() > 1 ) vitesse = valueObj[IDobj][16] * tempo[IDobj] *.3 ; else vitesse =  valueObj[IDobj][16] * .01 ;
    } else {
      vitesse = valueObj[IDobj][16] * .2 ;
    }
    float vX = vitesse ;
    float vY = vitesse ;
    //color
    color colorIn = color  (map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color (map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    
    //DISPLAY
    triangle1.triangles(width, 0,  mouse[IDobj], 0, colorIn, colorOut, e, vX, vY ) ;
    triangle2.triangles(0, height, mouse[IDobj], 0, colorIn, colorOut, -e, vX, vY ) ;
    popMatrix() ;
  }
  //END DRAW
  
  
  //ANNEXE VOID
  void annexe() {}

  
  
  /////////////////////////////
  //FORDIDEN DON'T TOUCH THIS VOID
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





//////////////
//CLASS TRIANGLE
class Tri
{
  float pX, pY ;
  float dirX = 1.0 ;
  float dirY = 1.0 ;
  float newVX, newVY ;
  //constructor
  Tri () { }
 
  //Paramètre superClass  
  //speed move
  void actualisation(float vitesseX, float vitesseY) {
    if (pX > width || pX < 0 ) dirX*=-1.0 ;
    if (pY > height || pY < 0) dirY*=-1.0 ;

    newVX = vitesseX *dirX  ;
    newVY = vitesseY *dirY  ;
    
    pX += newVX  ;
    pY += newVY  ;
  }
  
  
  //DISPLAY
  void triangles (int coteA, int coteB, PVector pos, int coteC, color cIn, color cOut, float e, float vitesseX, float vitesseY) {
    
    float marge = e ;  
    //check the opacity of color
    int alphaIn = (cIn >> 24) & 0xFF; 
    int alphaOut = (cOut >> 24) & 0xFF; 
    // to display or not
    if ( alphaIn == 0 ) noFill() ; else fill (cIn) ;
    if ( alphaOut == 0) {
      noStroke() ;
    } else {
      stroke ( cOut ) ;
     
      if (e < 0 ) e = abs(e) ;
      if( e < 0.1 ) e = 0.1 ; //security for the negative value
      
      strokeWeight (e) ;
    }
    
    //update
    actualisation(vitesseX, vitesseY) ;
    
    //display
    beginShape () ;
    strokeCap(ROUND);
    vertex (pos.x, pos.y);
    vertex (pX, coteB -marge) ;
    vertex (coteA +marge, coteB -marge ) ;
    vertex (coteA +marge, pY ) ;
    endShape(CLOSE) ;
  }
}
