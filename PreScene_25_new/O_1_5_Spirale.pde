Spirale spirale ; 
//object three
class SpiraleRomanesco extends SuperRomanesco {
  public SpiraleRomanesco() {
    //from the index_objects.csv
    romanescoName = "Spirale" ;
    IDobj = 5 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
  }
  //GLOBAL
     
    float speed ; ;
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    spirale = new Spirale() ;
  }
  //DRAW
  void display() {
    //quantity
    int n ;
    int nMax = 20 + (int)quantityObj[IDobj] *3 ;
    n = nMax ;
    //amplitude
    float ratioScreen = height - 400 ;
    if (ratioScreen < 1 ) ratioScreen = 1 ;
    float ratio = 1.25 + (ratioScreen *.0005) ;  
    float z = map(amplitudeObj[IDobj], 0,100,1.01, ratio)  ;
    //speed
    
    if(motion[IDobj]) {
      float s = map(speedObj[IDobj],0,100,0,8) ;
      s *= s ;
      speed = s *tempo[IDobj] ; 
    } else { 
      speed = 0.0 ;
    }
    //sound volume
    float volumeG = map (left[IDobj], 0,1, 0.5, 1.5 ) ;
    float volumeD = map (right[IDobj], 0,1, 0.5, 1.5 ) ;
    
    float heightObj = width  *sizeYObj[IDobj]  *volumeG *0.0005 *kick[IDobj] ;
    float widthObj = height *sizeXObj[IDobj]  *volumeD *0.0005 *hat[IDobj] ;
    float depthObj = height *sizeZObj[IDobj]  *volumeD *0.0005 *hat[IDobj] ;
    PVector size = new PVector(widthObj, heightObj, depthObj) ;


    //mode
    //display mode
    int mode = modeButton[IDobj] ;
    spirale.actualisation (mouse[IDobj], speed) ;
    spirale.affichage (n, nMax, size, z, fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], mode) ;
    
  }
}





//CLASS
class Spirale extends Rotation {  
  
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
