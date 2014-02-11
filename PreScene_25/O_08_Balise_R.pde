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
  Balise balise ;
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
    balise = new Balise() ;
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
    float thickness = map(valueObj[IDobj][13],0,100,0.1, height*.1 ) ;
    //amplitude
    float amp = map(valueObj[IDobj][17], 0,100, 0, width *20) ;
    //color
    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    //hauteur / largeur
    float tempoEffect = 1 + ((beat[IDobj] -1  ) + (kick[IDobj] -1  ) + (snare[IDobj] -1  ) + (hat[IDobj] -1  ) );
    PVector sizeBalise  = new PVector (map(valueObj[IDobj][21], 0, 100, 0, height) *tempoEffect,map(valueObj[IDobj][22],0,100, 0, height) *tempoEffect ) ;
    // variable position
    float vx = gauche[IDobj] ;
    float vy = droite[IDobj] ;
    //quantity
    float radiusBalise = map(valueObj[IDobj][14], 0,100, 0, 511); // here the value max is 511 because we work with buffersize with 512 field
    
    balise.actualisation (mouse[IDobj].x , mouse[IDobj].y , speed) ;
    if (modeButton[IDobj] == 0 || modeButton[IDobj] == 255 ) {
      balise.baliseDisc (colorIn, colorOut, thickness, amp, vx, vy, sizeBalise, int(radiusBalise)) ;
    } else if (modeButton[IDobj] == 1 ) {
     balise.baliseRect (colorIn, colorOut, thickness, amp, vx, vy, sizeBalise, int(radiusBalise)) ;
    } 
    
    
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





// CLASS BALISE
class Balise extends Rotation 
{  
  
  Balise () { 
    super () ;
  }


  void baliseDisc (color cIn, color cOut, float e, float amp, float varx, float vary, PVector sizeBalise, int max ) {
    pushMatrix() ;
    rectMode(CENTER) ;
    
    if ( max > 512 ) max = 512 ;
    for(int i = 0 ; i < max ; i++) {
      PVector inputResult = new PVector ( (input.left.get(i)*varx), (input.right.get(i)*vary) ) ;
      // PVector inputResult = new PVector ( 10, 10 ) ;
      PVector posBalise = new PVector ( amp * inputResult.x, amp * inputResult.y ) ;
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
      ellipse(posBalise.x, posBalise.y, sizeBalise.x *abs(inputResult.x*50), sizeBalise.y * abs(inputResult.y*50) ) ;
    }
    rectMode(CORNER) ;
    popMatrix() ;
    noStroke() ;
  }
  
  void baliseRect (color cIn, color cOut, float e, float amp, float varx, float vary, PVector sizeBalise, int max ) {
    pushMatrix() ;
    rectMode(CENTER) ;
    
    if ( max > 512 ) max = 512 ;
    for(int i = 0 ; i < max ; i++) {
      PVector inputResult = new PVector ( (input.left.get(i)*varx), (input.right.get(i)*vary) ) ;
      PVector posBalise = new PVector ( amp * inputResult.x, amp * inputResult.y ) ;
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
      rect(posBalise.x, posBalise.y, sizeBalise.x *abs(inputResult.x*50), sizeBalise.y * abs(inputResult.y*50) ) ;
    }
    rectMode(CORNER) ;
    popMatrix() ;
    noStroke() ;
  }
}
