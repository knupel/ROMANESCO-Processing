Balise balise ;
//object three
class BaliseRomanesco extends SuperRomanesco {
  public BaliseRomanesco() {
    //from the index_objects.csv
    romanescoName = "Balise" ;
    IDobj = 8 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
  }
  //GLOBAL
  float speed ;
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    balise = new Balise() ;
  }
  //DRAW
  void display() {
    if (motion[IDobj]) speed = (map(speedObj[IDobj], 0,100, 0,20)) *tempo[IDobj] ; else speed = 0.0 ;

    //amplitude
    float amp = map(amplitudeObj[IDobj], 0,100, 0, width *20) ;

    //hauteur / largeur
    float tempoEffect = 1 + ((beat[IDobj] -1  ) + (kick[IDobj] -1  ) + (snare[IDobj] -1  ) + (hat[IDobj] -1  ) );
    PVector sizeBalise  = new PVector (sizeXObj[IDobj] *tempoEffect, sizeYObj[IDobj] *tempoEffect ) ;
    // variable position
    float vx = left[IDobj] ;
    float vy = right[IDobj] ;
    //quantity
    float radiusBalise = map(quantityObj[IDobj], 1,100, 1, 511); // here the value max is 511 because we work with buffersize with 512 field
    
    balise.actualisation (mouse[IDobj] , speed) ;
    if (modeButton[IDobj] == 0 || modeButton[IDobj] == 255 ) {
      balise.baliseDisc (fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], amp, vx, vy, sizeBalise, int(radiusBalise)) ;
    } else if (modeButton[IDobj] == 1 ) {
     balise.baliseRect (fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], amp, vx, vy, sizeBalise, int(radiusBalise)) ;
    } 
    
  }
}
//end object two







// CLASS BALISE
class Balise extends Rotation {  
  
  Balise () { super () ; }
  
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
