Arbre arbre ;
//object three
class ArbreRomanesco extends SuperRomanesco {
  public ArbreRomanesco() {
    //from the index_objects.csv
    romanescoName = "Arbre" ;
    IDobj = 6 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 1.2";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "1 Trait/2 Disc/3 Disc trait/4 Rectangle/5 Rectangle trait/6 Box" ;
  }
  //GLOBAL
  float speed ;
  PVector posArbre = new PVector () ;
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/3, 0) ;
    arbre = new Arbre () ;
  }
  //DRAW
  void display() {
    float epaisseur = thicknessObj[IDobj] ;
    float g = map(left[IDobj], -1, 1, 0, 5) ;
    float d = map(right[IDobj], -1, 1, 2, 4) ;
    // quantity of the shape
    int ng = round(g);
    int nd = round( d );
    //size of the shape
    float propA = g  ;
    float propB = d  ;
    
    //size
    float x = sizeXObj[IDobj] *(g+d) *.1 ;
    float y = sizeYObj[IDobj] *(g+d) *.1 ;
    float z = sizeZObj[IDobj] *(g+d) *.1 ;
    PVector size  = new PVector(x,y,z) ;
    int fourcheA = nd  ; 
    int fourcheB = ng ;
    //orientation
    float direction = directionObj[IDobj] ;
    //amplitude
    float amplitude = map(amplitudeObj[IDobj], 0,1, 0,height *.5) *allBeats(IDobj) ;
    
    // "n" what is it ?
    int n = (ng+nd) ;
    //quantity
    float quantityNode = map(quantityObj[IDobj],1,100,2,32) ;
    int maxNode = int(quantityNode) ;
    if ( n>maxNode ) n = maxNode ;


    // angle
    float angle = map(angleObj[IDobj],0,360,0,180);
    // speed
    if(motion[IDobj]) {
      float s = map(speedObj[IDobj],0,100,0,2) ;
      s *= s ;
      speed = s *tempo[IDobj] ; 
    } else { 
      speed = 0.0 ;
    }
    
    aspect(IDobj) ;
    
    arbre.affichage (direction) ;
    arbre.actualisation(posArbre, epaisseur, size, propA, propB, fourcheA, fourcheB, amplitude, n, mode[IDobj], angle, speed, IDobj) ;
    
    //info
    objectInfo[IDobj] = ("Nodes " + maxNode + " Amplitude " + (int)amplitude + " Orientation " +direction +  " Speed " + (int)map(speed,0,4,0,100) );
    
  }
}
//end object two







/////////////////
//CLASS ARBRE
class Arbre {
  Arbre() {}
  // int vR = 1 ;  ;
  float theta, angleDirection ;
  float rotation = 90.0  ;
  float direction   ;
 
//::::::::::::::::::::  
  void affichage (float d) {
    direction = d ;
  }
//::::::::::::::::::::::::::::  
  void actualisation (PVector posArbre, float e, PVector size, float propA, float propB, int fourcheA, int fourcheB, float amplitude, int n, int mode, float angle, float speed, int ID) {
    rotation += speed ;
    if (rotation > angle +90) speed*=-1 ; else if ( rotation < angle ) speed*=-1 ; 
    angle = rotation ; // de 0 à 180
    // Convert it to radians
    theta = radians(angle);
    angleDirection = radians (direction) ;
    pushMatrix () ;
    translate(posArbre.x,posArbre.y, 0) ;
    // Start the recursive branching
    rotate (angleDirection) ;
    branch(e, size, propA, propB, fourcheA, fourcheB, amplitude, n, mode, ID);
    popMatrix () ;

    
  }
  
  
  //float fourche = 10.0 ; 
  void branch(float e, PVector proportion, float propA, float propB, int fourcheA, int fourcheB, float amplitude, int n, int mode, int ID) {
    PVector newSize = proportion.get() ;
    newSize.x = proportion.x /(random(propA, propB)*.3) ;
    newSize.y = proportion.y /(random(propA, propB)*.3) ;
    newSize.z = proportion.z /(random(propA, propB)*.3) ;
    
    if(newSize.x < 1 ) newSize.x = 1 ;
    
    
    // recursice need a end  !
    n = n-1 ;
    if (n >0) {
     displayBranch(e, newSize, propA, propB, fourcheA, fourcheB, amplitude, n, -theta, mode, ID) ; 
     displayBranch(e, newSize, propA, propB, fourcheA, fourcheB, amplitude, n, theta, mode, ID) ;
    }
  }
  
  //annexe branch
  void displayBranch(float e, PVector newSize, float propA, float propB, int fourcheA, int fourcheB, float amplitude, int n, float t, int mode, int ID) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(t);   // Rotate by theta

    strokeWeight (e) ;
    
    if (mode == 0  ) line(0, 0, 0, -amplitude);  // Draw the branch
    if (mode == 2  ) { ellipse(0,0, newSize.x, newSize.x) ; line(0, 0, 0, -amplitude); }
    if (mode == 4  ) { rect(0,0, newSize.x, newSize.y) ; line(0, 0, 0, -amplitude); }
    if (mode == 1 || mode == 3 || mode == 5 ) {
    if (mode == 1 )  ellipse(0,0, newSize.x , newSize.x) ;
    if (mode == 3 )  rect(0,0, newSize.x, newSize.y) ;
    if (mode == 5  ) box(newSize.x, newSize.y, newSize.z) ;
      if (!horizon[ID]) {
        //pushMatrix() ;
        float factor = 0.0 ;
        if(!vTouch && pen[0].z != 0) factor = map(pen[0].z,0.01,1, -.5,.5) ; else factor = 0 ;
        translate(0,0, -newSize.z *factor) ; 
      } else {
        //pushMatrix() ;
        float factor = 0.0 ;
        if(!vTouch && pen[0].z != 0)factor = .15 + map(pen[0].z,0.01,1, 1.2,-1.2) ; else factor = .15 ;
        translate(0,0, -newSize.z *factor) ;
        //popMatrix() ;
      }
    }
    translate(0, -amplitude); // Move to the end of the branch
    branch(e, newSize, propA, propB, fourcheA, fourcheB, amplitude, n, mode, ID);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
  }
}
