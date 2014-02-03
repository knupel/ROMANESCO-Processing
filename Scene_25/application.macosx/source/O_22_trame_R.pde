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

//MOUSEPRESSED
void romanescoTwentyTwoMousepressed() { romanescoTwentyTwo.mousepressed() ; }
//MOUSERELEASED
void romanescoTwentyTwoMousereleased() { romanescoTwentyTwo.mousereleased() ; }
//MOUSE DRAGGED
void romanescoTwentyTwoMousedragged() { romanescoTwentyTwo.mousedragged() ; }
//KEYPRESSED
void romanescoTwentyTwoKeypressed() { romanescoTwentyTwo.keypressed() ; }
//KEY RELEASED
void romanescoTwentyTwoKeyreleased() { romanescoTwentyTwo.keyreleased() ; }

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
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  float d, g, h, l ;
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
    h = ( valueObj[IDobj][11] + pen[IDobj].z ) * abs(1 + g) ;
    l = ( valueObj[IDobj][12] + pen[IDobj].z) * abs(1 + d) ;
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
    float e = valueObj[IDobj][13] ;
    //amp
    float amp = map(valueObj[IDobj][17],0,100, .5, 3) ;
    
    //MODE DISPLAY
    if(modeButton[IDobj] == 0 || modeButton[IDobj] == 255) trame.drawTrameRect(mouse[IDobj], angleTrame, angleObj, h , l , q, colorIn, colorOut, e, g, d, amp) ;
    else if (modeButton[IDobj] == 1) trame.drawTrameDisc(mouse[IDobj], angleTrame, angleObj, h , l , q, colorIn, colorOut, e, g, d, amp) ;

    
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
/////////////
//END ROMANESCO







/////////////
//CLASS TRAME
class Trame 
{
  Trame()  { }
  
  float nbrlgn ; 
  int vitesse ;
  float vd, vg ;
  
  void drawTrameLine ( float v, float q, color cOut, float e) 
  {
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
  //TRAME RECTANGLEe multiple
  void drawTrameRect (PVector axe, float angleTrame, float angleObj, float hauteur, float largeur, int nbrlgn, color cIn, color cOut, float e, float gauche, float droite, float amp ) {
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
    
    pushMatrix() ;

    translate(axe.x, axe.y) ;
    //calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) { 
        PVector pos = new PVector (  (i *width *amp) / nbrlgn, (j *height *amp ) / nbrlgn )  ;
        PVector newPosAfterRotation = rotation (pos, axe, angleTrame) ;        
        rectangleTrame (newPosAfterRotation, hauteur, largeur, gauche, droite, angleObj ) ;      
      }
    }
    popMatrix() ;  
  }
  //engine rectangle  //engine rectangle
  void rectangleTrame( PVector pos, float h, float l, float gauche, float droite, float aObj)
  {
    pushMatrix() ;
    vg += gauche ;
    vd += droite ;
    //position of each object
    //...........
    if (vg>360) vg =0 ; 
    if (vd>360) vd =0 ;
    //display
    rectMode(CENTER) ;

    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    
    rect (0, 0, pow(l,1.4), pow(h,1.4)) ;
    rectMode(CORNER) ;
    popMatrix() ;
  }
  
  
  //TRAME DISC multiple
  void drawTrameDisc (PVector axe, float angleTrame, float angleObj, float hauteur, float largeur, int nbrlgn, color cIn, color cOut, float e, float gauche, float droite, float amp   )
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
    
    pushMatrix() ;
    
    translate(axe.x, axe.y) ;
    //calcul the position of each object
    for (int i=1 ; i < nbrlgn ; i++) {
      for (int j=1 ; j < nbrlgn ; j++) {
        PVector pos = new PVector (  (i *width *amp ) / nbrlgn, (j * height *amp ) / nbrlgn )  ;
        PVector newPosAfterRotation = rotation (pos, axe, angleTrame) ;        
        disqueTrame (newPosAfterRotation, hauteur, largeur, gauche, droite, angleObj ) ;      
      }
    }
    popMatrix() ;  
  }
  
  void disqueTrame( PVector pos, float h, float l, float gauche, float droite, float aObj)
  {
    pushMatrix() ;
    vg += gauche ;
    vd += droite ;
    //position of each object
    //...........
    if (vg>360) vg =0 ; 
    if (vd>360) vd =0 ;
    //display
    ellipseMode(CENTER) ;
    translate(pos.x, pos.y) ;
    rotate(aObj) ;
    ellipse (0, 0, pow(l,1.4), pow(h,1.4)) ;
    ellipseMode(CORNER) ;
    popMatrix() ;
  }

}
