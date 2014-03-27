Arbre arbre ;
//object three
class ArbreRomanesco extends SuperRomanesco {
  public ArbreRomanesco() {
    //from the index_objects.csv
    romanescoName = "Arbre" ;
    IDobj = 6 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 2.0";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "1 Trait/2 Disc/3 Disc trait/4 Rectangle/5 Rectangle trait/6 Box" ;
  }
  //GLOBAL
  float speed ;
  PVector posArbre = new PVector (random(width), random(height) ) ;
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    arbre = new Arbre () ;
  }
  //DRAW
  void display() {
    float epaisseur = thicknessObj[IDobj] ;
    float g = map(left[IDobj], -1, 1, 0, 5) ;
    float d = map(right[IDobj], -1, 1, 2, 7) ;
    int ng = round(g);
    int nd = round( d );
    int propA = ng ;
    int propB =  nd ;
    
    //size
    float x = sizeXObj[IDobj] * (ng + nd ) ;
    float y = sizeYObj[IDobj] * (ng + nd ) ;
    float z = sizeZObj[IDobj] * (ng + nd ) ;
    PVector size  = new PVector(x,y,z  ) ;
    int fourcheA = nd  ; 
    int fourcheB = ng ;
    //orientation
    float direction = directionObj[IDobj] ;
    //amplitude
    float ampSon ;
    if(sound[IDobj]) ampSon = map (abs(mix[IDobj]), 0, 1, .1 ,4) ; else ampSon = 1.0 ;
    float amplitude = map(amplitudeObj[IDobj], 0,100, 0,height *.2) *ampSon ;
    int n = (ng+nd) ;
    //quantity
    float quantityNode = map(quantityObj[IDobj],1,100,2,32) ;
    int maxNode = int(quantityNode) ;
    if ( n>maxNode ) { n = maxNode ; } ;


    // angle
    float angle = map(angleObj[IDobj],0,360,0,90);
    // speed
    if(motion[IDobj]) {
      float s = map(speedObj[IDobj],0,100,0,2) ;
      s *= s ;
      speed = s *tempo[IDobj] ; 
    } else { 
      speed = 0.0 ;
    }
    
    arbre.affichage (direction) ;
    posArbre = new PVector (mouse[IDobj].x, mouse[IDobj].y) ;
    arbre.actualisation(posArbre, fillObj[IDobj], strokeObj[IDobj], epaisseur, size, propA, propB, fourcheA, fourcheB, amplitude, n, mode[IDobj], angle, speed) ;
    
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
  void actualisation (PVector posArbre, color cIn, color cOut, float e, PVector size, int propA, int propB, int fourcheA, int fourcheB, float amplitude, int n, int mode, float angle, float speed) {
    rotation += speed ;
    // float newAngle = 180 - angle ;
    if ( rotation > angle + 90  ) speed*=-1 ; else if ( rotation < angle ) speed*=-1 ; 
    angle = rotation ; // de 0 à 180
    // Convert it to radians
    theta = radians(angle);
  
    angleDirection = radians (direction) ;
    pushMatrix () ;
    translate(posArbre.x,posArbre.y);
    // Start the recursive branching
    rotate (angleDirection) ;
    branch(cIn, cOut, e, size, propA, propB, fourcheA, fourcheB, amplitude, n, mode);
    popMatrix () ;
    
  }
//::::::::::::::::::::::::::::  
  void branch(color colorIn, color colorOut, float e, PVector proportion, int propA, int propB, int fourcheA, int fourcheB, float amplitude, int n, int mode) {
    proportion.x *= random (propA, propB ) / 10 ;
    float fourche = random (0,10) ;
    stroke ( colorOut ) ;
    fill ( colorIn ) ;
    
    //En cours pour vérifier la fin de la boucle qui bug qd celle-ci est trop grande.
    if ( e < 0.1 ) e = 0.1 ;
    if( proportion.x < 1 ) proportion.x = 1 ;
    
    
    n = n-1 ;
    // Toutes fonctions répétitives doit posséder une sortie, ici une taille inférieure à 2
    if (n > 0) {
      if (fourche < fourcheA  ) displayBranch(colorIn, colorOut, e, proportion, propA, propB, fourcheA, fourcheB, amplitude, n, -theta, mode) ; 
                           else displayBranch(colorIn, colorOut,e, proportion, propA, propB, fourcheA, fourcheB, amplitude, n, theta, mode) ;
    }
  }
  
  //annexe branch
  void displayBranch(color colorIn, color colorOut,float e, PVector proportion, int propA, int propB, int fourcheA, int fourcheB, float amplitude, int n, float t, int mode) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(t);   // Rotate by theta

    strokeWeight (e ) ;
     if (mode == 0  ) line(0, 0, 0, -amplitude);  // Draw the branch
    if (mode == 1 ) ellipse(0,0, proportion.x  , proportion.x  ) ;
    if (mode == 2  ) {  ellipse(0,0, proportion.x  , proportion.x  ) ; line(0, 0, 0, -amplitude); }
    if (mode == 3 ) rect(0,0, proportion.x  , proportion.x  ) ;
    if (mode == 4  ) {  rect(0,0, proportion.x  , proportion.x  ) ; line(0, 0, 0, -amplitude); }
    if (mode == 5  ) box(proportion.x  , proportion.x  , proportion.x  ) ;
    translate(0, -amplitude); // Move to the end of the branch
    branch(colorIn, colorOut, e, proportion, propA, propB, fourcheA, fourcheB, amplitude, n, mode);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
  }
}
