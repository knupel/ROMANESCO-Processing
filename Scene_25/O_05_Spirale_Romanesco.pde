//GLOBAL
RomanescoFive romanescoFive ;




//SETUP
void romanescoFiveSetup() {
    //MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 5 ; // 0 is Ref you must use a number is the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 1 ; // 0 is global // 1 is single object // 2 is trame // 3 is typo
  romanescoFive = new RomanescoFive (ID, IDfamilly) ;

  romanescoFive.setting() ;
}

//DRAW
void romanescoFiveDraw(String [] dataControleur, String [] dataMinim) {
  romanescoFive.getID() ;
  romanescoFive.data(dataControleur, dataMinim) ;
  romanescoFive.display() ;
}

//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoFive() { return romanescoFive.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
// here you can put your array list for example

//////////////////////////////////////////
class RomanescoFive extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  // class
  Spirale spirale ;
  //speed
  float speed ;
  //CONSTRUCTOR
  RomanescoFive(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
  }
  //END CONSTRUCTOR
  
  ////SETUP
  /////////
  void setting() {
    spirale = new Spirale() ;
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
    //quantity
    int n ;
    int nMax = 20 + ( int(valueObj[IDobj][14]) * 3 ) ;
    n = nMax ;
    //amplitude
    float ratioScreen = height - 400 ;
    if (ratioScreen < 1 ) ratioScreen = 1 ;
    float ratio = 1.25 + (ratioScreen *.0005) ;  
    float z = map(valueObj[IDobj][17], 0,100,1.01, ratio)  ;
    //speed
    if(motion[IDobj]) {
      float s = map(valueObj[IDobj][16],0,100,0,8) ;
      s *= s ;
      speed = s *tempo[IDobj] ; 
    } else { 
      speed = 0.0 ;
    }
    //sound volume
    float volumeG = map (gauche[IDobj], 0,1, 0.5, 1.5 ) ;
    float volumeD = map (droite[IDobj], 0,1, 0.5, 1.5 ) ;
    
    
    float heightObj = width  *valueObj[IDobj][21]  *volumeG *0.0005 *kick[IDobj] ;
    float widthObj = height *valueObj[IDobj][22]  *volumeD *0.0005 *hat[IDobj] ;
    float depthObj = height *valueObj[IDobj][23]  *volumeD *0.0005 *hat[IDobj] ;
    PVector size = new PVector(heightObj, widthObj, depthObj) ;
    //thickness
    float thickness = map(valueObj[IDobj][13],0,100,0.1, height*.2 ) ;
    //color
    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    //mode
    //display mode
    int mode = modeButton[IDobj] ;
    
    spirale.actualisation (mouse[IDobj].x , mouse[IDobj].y, speed) ;
    spirale.affichage (n, nMax, size, z, colorIn, colorOut, thickness, mode) ;
    
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






 

class Spirale extends Rotation 
{  
  
  Spirale () { 
    super () ;
  }
  void affichage (int n, int nMax, PVector size, float z, color cIn, color cOut, float e, int mode) {
    n = n-1 ;
    int puissance = nMax-n ;
    float ap = pow (z,puissance) ;
    
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
      strokeWeight ( e / ap) ;
    }
    
    //display Mode
    if (mode == 0 )      rect (0,0, size.x, size.y ) ;
    else if (mode == 1 ) ellipse (0,0,size.x,size.y) ;
    else if (mode == 2 ) box (size.x,size.y,size.z) ;
    //
    
    translate (2,0 ) ;
    rotate ( PI/6 ) ;
    scale(z) ; 

    if ( n > 0) { affichage (n, nMax, size, z, cIn, cOut, e, mode ) ; }
  }
  
  
  
  //DIFFERENT DISPLAY MODE
  void baliseDisc (color cIn, color cOut, float e, float amp, float varx, float vary, PVector sizeBalise, int max ) {
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
