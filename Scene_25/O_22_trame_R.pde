//GLOBAL
RomanescoTwentyTwo romanescoTwentyTwo ;
//SETUP
void romanescoTwentyTwoSetup() {
    //MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 22 ; // 0 is Ref you must use a number is the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 2 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoTwentyTwo = new RomanescoTwentyTwo (ID, IDfamilly) ;

  romanescoTwentyTwo.setting() ;
}

//DRAW
void romanescoTwentyTwoDraw(String [] dataControleur, String [] dataMinim) {
  romanescoTwentyTwo.getID() ;
  romanescoTwentyTwo.data(dataControleur, dataMinim) ;
  romanescoTwentyTwo.display() ;
}



//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoTwentyTwo() { return romanescoTwentyTwo.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
//////////////////////////////////////////
class RomanescoTwentyTwo extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //class
  Trame trame ;

  
  
  //CONSTRUCTOR
  RomanescoTwentyTwo(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
  }
  //END CONSTRUCTOR
  
  ////SETUP
  //the setting that's stuff that you'r put usually in the void setup() 
  void setting() {
    //class
    trame = new Trame() ;
    // motion
    motion[IDobj] = true ; 
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  float d, g ;
  PVector size = new PVector(0,0,0) ;
  float angleTrame = 0 ;
  float angleObj = 0 ;
  float vitesse = 0 ;
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
    if ( soundButton[IDobj] != 0 ) { 
      g = gauche[IDobj] ; 
      d = droite[IDobj] ; 
    } else {  
      g = 0 ;
      d = 0 ;
    }
    size.x = ( valueObj[IDobj][21] + pen[IDobj].z ) * abs(1 + g) ;
    size.y = ( valueObj[IDobj][22] + pen[IDobj].z) * abs(1 + d) ;
    size.z = ( valueObj[IDobj][23] + pen[IDobj].z)  ;
    //size

    //orientation / deg
    translate( mouse[IDobj].x, mouse[IDobj].y) ;
    vitesse = map(valueObj[IDobj][16], 0,100,0, 0.07 );
    //speed rotation
    if ( vitesse == 0 || !motion[IDobj]  ) angleTrame = map(valueObj[IDobj][18], 0,100, 0, TAU) ; else angleTrame += vitesse *tempo[IDobj] ;
    if (spaceTouch && actionButton[IDobj] == 1 ) angleObj = map(valueObj[IDobj][18], 0,100, 0, TAU) ; else angleObj = 0 ;
    //quantity
    int q = int(map(valueObj[IDobj][14], 0, 100, 2,50)) ;
    //color
    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    //thickness / épaisseur
    float thickness = map(valueObj[IDobj][13],0,100,0.1, height*.2 ) ;
    //amp
    float amp = map(valueObj[IDobj][17],0,100, .5, 3) ;
    
    //MODE DISPLAY
    if(modeButton[IDobj] == 0 || modeButton[IDobj] == 255) trame.drawTrameRect(mouse[IDobj], angleTrame, angleObj, size , q, colorIn, colorOut, thickness, g, d, amp) ;
    else if (modeButton[IDobj] == 1) trame.drawTrameDisc(mouse[IDobj], angleTrame, angleObj, size , q, colorIn, colorOut, thickness, g, d, amp) ;
    else if (modeButton[IDobj] == 2) trame.drawTrameBox(mouse[IDobj], angleTrame, angleObj, size , q, colorIn, colorOut, thickness, g, d, amp) ;

    
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
  //////////
  

  
  
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
/////////////
//END ROMANESCO







/////////////
//CLASS TRAME
class Trame 
{
  Trame(){}
  
  float nbrlgn ; 
  int vitesse ;
  
  //TRAME RECTANGLEe multiple
  void drawTrameRect (PVector axe, float angleTrame, float angleObj, PVector size, int nbrlgn, color cIn, color cOut, float e, float gauche, float droite, float amp ) {
    //check the opacity of color
    shapeProperty(cIn, cOut, e) ;
    
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    //calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) { 
        PVector pos = new PVector (  (i *width *amp) / nbrlgn, (j *height *amp ) / nbrlgn )  ;
        PVector newPosAfterRotation = rotation (pos, axe, angleTrame) ;        
        rectangleTrame (newPosAfterRotation, size.x, size.y, gauche, droite, angleObj ) ;      
      }
    }
    popMatrix() ;  
  }
  
  
  
  
  //TRAME DISC multiple
  void drawTrameDisc (PVector axe, float angleTrame, float angleObj, PVector size, int nbrlgn, color cIn, color cOut, float e, float gauche, float droite, float amp   ) {
    //check the opacity of color
    
    shapeProperty(cIn, cOut, e) ;
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    //calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) {
        PVector pos = new PVector (  (i *width *amp ) / nbrlgn, (j * height *amp ) / nbrlgn )  ;
        PVector newPosAfterRotation = rotation (pos, axe, angleTrame) ;        
        disqueTrame (newPosAfterRotation, size.x, size.y, gauche, droite, angleObj ) ;      
      }
    }
    popMatrix() ;  
  }
  
  
  //TRAME BOX
  void drawTrameBox (PVector axe, float angleTrame, float angleObj, PVector size, int nbrlgn, color cIn, color cOut, float e, float gauche, float droite, float amp   ) {
    //check the opacity of color
    
    shapeProperty(cIn, cOut, e) ;
    pushMatrix() ;
    translate(axe.x, axe.y) ;
    //calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) {
        PVector pos = new PVector (  (i *width *amp ) / nbrlgn, (j * height *amp ) / nbrlgn )  ;
        PVector newPosAfterRotation = rotation (pos, axe, angleTrame) ;        
        boxTrame (newPosAfterRotation, size, gauche, droite, angleObj ) ;      
      }
    }
    popMatrix() ;  
  }
  
  
  

  
  
  
  //Display 
  void shapeProperty(color cIn, color cOut, float e) {
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
  }
  
  
  void rectangleTrame( PVector pos, float h, float l, float gauche, float droite, float aObj) {
    pushMatrix() ;
    rectMode(CENTER) ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    rect (0, 0, pow(l,1.4), pow(h,1.4)) ;
    rectMode(CORNER) ;
    popMatrix() ;
  }
  
  void disqueTrame( PVector pos, float h, float l, float gauche, float droite, float aObj) {
    pushMatrix() ;
    ellipseMode(CENTER) ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    ellipse (0, 0, pow(l,1.4), pow(h,1.4)) ;
    ellipseMode(CORNER) ;
    popMatrix() ;
  }
  
  void boxTrame( PVector pos, PVector size, float gauche, float droite, float aObj) {
    pushMatrix() ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    box (pow(size.x,1.4), pow(size.y,1.4), pow(size.z,1.4)) ;
    popMatrix() ;
  }
}
