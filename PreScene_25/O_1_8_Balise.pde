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
    romanescoMode = "1 Disc/2 Rectangle" ;
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
    float amp = map(amplitudeObj[IDobj], 0,100, 0, width) ;

    //hauteur / largeur
    float tempoEffect = 1 + ((beat[IDobj] -1  ) + (kick[IDobj] -1  ) + (snare[IDobj] -1  ) + (hat[IDobj] -1  ) );
    PVector sizeBalise  = new PVector (sizeXObj[IDobj] *tempoEffect, sizeYObj[IDobj] *tempoEffect ) ;
    // variable position
    PVector var = new PVector(left[IDobj],right[IDobj]) ; 
    //quantity
    float radiusBalise = map(quantityObj[IDobj], 1,100, 2, 511); // here the value max is 511 because we work with buffersize with 512 field
    
    balise.actualisation (mouse[IDobj] , speed) ;
    if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
      balise.baliseDisc (fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], amp, var, sizeBalise, int(radiusBalise), sound[IDobj]) ;
    } else if (mode[IDobj] == 1 ) {
     balise.baliseRect (fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], amp, var, sizeBalise, int(radiusBalise), sound[IDobj]) ;
    } 
    
  }
}
//end object two







// CLASS BALISE
class Balise extends Rotation {  
  
  Balise () { super () ; }
  
  void baliseDisc (color cIn, color cOut, float e, float amp, PVector var, PVector sizeBalise, int max, boolean sound ) {
    pushMatrix() ;
    rectMode(CENTER) ;
    
    PVector inputResult = new PVector(0,0,0) ;
    if ( max > 512 ) max = 512 ;
    for(int i = 0 ; i < max ; i++) {
      PVector v = new PVector(input( i,max,var,sound).x, input(i,max,var,sound).y) ;
      PVector posBalise = new PVector ( amp * v.x, amp * v.y ) ;
      
      stroke(cOut) ;
      fill(cIn) ;
      strokeWeight(e) ;
      ellipse(posBalise.x, posBalise.y, sizeBalise.x *abs(v.x*50), sizeBalise.y * abs(v.y*50) ) ;
    }
    rectMode(CORNER) ;
    popMatrix() ;
    noStroke() ;
  }
  
  void baliseRect (color cIn, color cOut, float e, float amp, PVector var, PVector sizeBalise, int max, boolean sound ) {
    pushMatrix() ;
    rectMode(CENTER) ;
    PVector inputResult = new PVector(0,0,0) ;
    if ( max > 512 ) max = 512 ;
    for(int i = 0 ; i < max ; i++) {
      PVector v = new PVector(input( i,max,var,sound).x, input(i,max,var,sound).y) ;
      PVector posBalise = new PVector ( amp * v.x, amp * v.y ) ;
      //check the opacity of color
      stroke(cOut) ;
      fill(cIn) ;
      strokeWeight(e) ;
      rect(posBalise.x, posBalise.y, sizeBalise.x *abs(v.x*50), sizeBalise.y * abs(v.y*50) ) ;
    }
    rectMode(CORNER) ;
    popMatrix() ;
    noStroke() ;
  }
  
  //calculate and return the position for each brick of the balise
  PVector input( int whichOne, int max, PVector var, boolean b) {
    PVector value = new PVector(0,0,0) ;
    if(b) {
      value = new PVector ( (input.left.get(whichOne)*var.x), (input.right.get(whichOne)*var.y) ) ; 
    } else {
      float n = (float)whichOne ;
      n = n - (max/2) ;
      value = new PVector ( n*var.x *.01, n*var.y *.01 ) ; 
    }
    return value ;
  }
}
