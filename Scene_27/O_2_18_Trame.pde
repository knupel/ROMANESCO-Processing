Trame trame ;
//object three
class Damier extends Romanesco {
  public Damier() {
    //from the index_objects.csv
    romanescoName = "Damier" ;
    IDobj = 18 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "Rectangle/Ellipse/Box" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Width,Height,Depth,Quantity,Speed,Amplitude" ;
  }
  //GLOBAL
  float d, g, m ;
  PVector size = new PVector(0,0,0) ;
  float angleTrame = 0 ;
  float angle = 0 ;
  float speed = 0 ;
  boolean reverse = false ;

  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    trame = new Trame() ;

  }
  //DRAW
  void display() {
    // color and thickness
    aspect(IDobj) ;
    
    if ( sound[IDobj]) {
      g = map(left[IDobj],0,1,1,5) ; 
      d = map(right[IDobj],0,1,1,5) ; 
      m = map(mix[IDobj],0,1,1,5) ;
    } else {  
      g = 1.0 ;
      d = 1.0 ;
      m = 1.0 ;
    }
    float penPressure = map(pen[IDobj].z,0,1,1,width/100) ;
    float sizeXtemp = map(sizeXObj[IDobj],.1,width,.1,width/33) ;
    float sizeYtemp = map(sizeYObj[IDobj],.1,width,.1,width/33) ;
    float sizeZtemp = map(sizeZObj[IDobj],.1,width,.1,width/33) ;
    size.x = ((sizeXtemp *sizeXtemp) *penPressure *allBeats(IDobj) ) *g ;
    size.y = ((sizeYtemp *sizeYtemp) *penPressure *allBeats(IDobj)) *d ;
    size.z = ((sizeZtemp *sizeZtemp) *penPressure *allBeats(IDobj)) *m  ;
    //size

    //orientation / deg
    //speed
    speed = map(speedObj[IDobj], 0,1,0, 0.5 );
    if(rTouch) reverse = !reverse ;
    if(reverse) speed = speed *1 ; else speed = speed * -1 ;
    if (speed != 0 && motion[IDobj]) angleTrame += speed *tempo[IDobj] ;
    
    
    //rotation of the single shape
    if (action[IDobj]) angle = map(angleObj[IDobj], 0,100, 0, TAU) ; 
    
    //quantity
    int q = int(map(quantityObj[IDobj], 0, 1, 2, 15)) ;

    //amp
    float amp = map(amplitudeObj[IDobj],0,1, .1, height /200) ;
    
    //MODE DISPLAY
    if(mode[IDobj] == 0 || mode[IDobj] == 255) trame.drawTrameRect(mouse[IDobj], angleTrame, angle, size , q, g, d, amp) ;
    else if (mode[IDobj] == 1) trame.drawTrameDisc(mouse[IDobj], angleTrame, angle, size , q, g, d, amp) ;
    else if (mode[IDobj] == 2) trame.drawTrameBox(mouse[IDobj], angleTrame, angle, size , q, g, d, amp) ;
    
    //INFO
    objectInfo[IDobj] =("Quantity " + q + " shapes / Angle " + (int)angle + " Speed " + int(speed *100) + " Amplitude " + int(amp *100)) ;
    
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
  void drawTrameRect (PVector axe, float angleTrame, float angleObj, PVector size, int nbrlgn, float gauche, float droite, float amp ) {
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
  void drawTrameDisc (PVector axe, float angleTrame, float angleObj, PVector size, int nbrlgn, float gauche, float droite, float amp   ) {
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
  void drawTrameBox (PVector axe, float angleTrame, float angleObj, PVector size, int nbrlgn, float gauche, float droite, float amp   ) {
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
