Trame trame ;
//object three
class Damier extends SuperRomanesco {
  public Damier() {
    //from the index_objects.csv
    romanescoName = "Damier" ;
    IDobj = 11 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "1 Rectangle/2 Ellipse/3 Box" ;
  }
  //GLOBAL
  float d, g ;
  PVector size = new PVector(0,0,0) ;
  float angleTrame = 0 ;
  float angle = 0 ;
  float vitesse = 0 ;

  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    trame = new Trame() ;

  }
  //DRAW
  void display() {
    if ( sound[IDobj]) {
      g = left[IDobj] ; 
      d = right[IDobj] ; 
    } else {  
      g = 0.0 ;
      d = 0.0 ;
    }
    size.x = ( sizeXObj[IDobj] + pen[IDobj].z ) * abs(1 + g) ;
    size.y = ( sizeYObj[IDobj] + pen[IDobj].z) * abs(1 + d) ;
    size.z = ( sizeZObj[IDobj] + pen[IDobj].z)  ;
    //size

    //orientation / deg
    translate( mouse[IDobj].x, mouse[IDobj].y) ;
    vitesse = map(speedObj[IDobj], 0,100,0, 0.07 );
    //speed rotation
    if ( vitesse == 0  ) angleTrame = angleObj[IDobj] ; else angleTrame += vitesse *tempo[IDobj] ;
    if (spaceTouch && action[IDobj]) angle = map(angleObj[IDobj], 0,100, 0, TAU) ; else angle = 0 ;
    //quantity
    int q = int(map(quantityObj[IDobj], 0, 100, 2,50)) ;

    //amp
    float amp = map(amplitudeObj[IDobj],0,100, .5, 3) ;
    
    //MODE DISPLAY
    if(mode[IDobj] == 0 || mode[IDobj] == 255) trame.drawTrameRect(mouse[IDobj], angleTrame, angle, size , q, fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], g, d, amp) ;
    else if (mode[IDobj] == 1) trame.drawTrameDisc(mouse[IDobj], angleTrame, angle, size , q, fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], g, d, amp) ;
    else if (mode[IDobj] == 2) trame.drawTrameBox(mouse[IDobj], angleTrame, angle, size , q, fillObj[IDobj], strokeObj[IDobj], thicknessObj[IDobj], g, d, amp) ;
    
  }
}
//end object two





/////////////
//CLASS TRAME
class Trame {
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
        PVector newPosAfterRotation = rotation(pos, axe, angleTrame) ;        
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
        PVector newPosAfterRotation = rotation(pos, axe, angleTrame) ;        
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
        PVector newPosAfterRotation = rotation(pos, axe, angleTrame) ;        
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
