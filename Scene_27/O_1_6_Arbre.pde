Arbre arbre ;
//object three
class ArbreRomanesco extends SuperRomanesco {
  public ArbreRomanesco() {
    //from the index_objects.csv
    romanescoName = "Arbre" ;
    IDobj = 6 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.3";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "Line/Disc/Disc line/Rectangle/Rectangle line/Box" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Width,Height,Depth,Quantity,Speed,Direction,Amplitude" ;
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
    int maxFork ;
    if(fullRendering) maxFork = 8 ; else maxFork = 4 ; // we can go beyond but by after the calcul slowing too much the computer... 14 is a good limit
    // int maxNode = 32 ; // 
    // num fork for the tree
    int forkA = maxFork ; 
    int forkB = maxFork ;
    
    int n = int(map(quantityObj[IDobj],0,1,2,maxFork*2)) ;
    
    float epaisseur = thicknessObj[IDobj] ;
    float ratioLeft = map(left[IDobj], 0, 1, 0, 1.5) ;
    float ratioRight = map(right[IDobj], 0, 1, 0, 1.5) ;
    float ratioMix = ratioLeft + ratioRight ;
    // quantity of the shape

    //size of the shape
    float divA = .66 ;
    float divB = .66 ;
    if(sound[IDobj]) {
      divA = ratioLeft ;
      divB = ratioRight  ;
    } else {
      divA = .66 ;
      divB = .66 ;
    }
      
    
    //size
    float x = map(sizeXObj[IDobj],.1,width,.1,width/2) *ratioMix ;
    float y = map(sizeYObj[IDobj],.1,width,.1,width/2) *ratioMix ;
    float z = map(sizeZObj[IDobj],.1,width,.1,width/2) *ratioMix ;
    PVector size  = new PVector(x,y,z) ;
    //orientation
    float direction = directionObj[IDobj] ;
    //amplitude
    float amplitude = map(amplitudeObj[IDobj], 0,1, 0.1,height *.5) *allBeats(IDobj) ;
    



    // angle
    // float angle = map(angleObj[IDobj],0,360,0,180);
    float angle = 90 ; // but this function must be remove because it give no effect
    // speed
    if(motion[IDobj]) {
      float s = map(speedObj[IDobj],0,1,0,2) ;
      s *= s ;
      speed = s *tempo[IDobj] ; 
    } else { 
      speed = 0.0 ;
    }
    
    aspect(IDobj) ;
    
    arbre.affichage (direction) ;
    arbre.actualisation(posArbre, epaisseur, size, divA, divB, forkA, forkB, amplitude, n, mode[IDobj], angle, speed, IDobj) ;
    
    //info
    objectInfo[IDobj] = ("Nodes " +(n-1) + " - Amplitude " + (int)amplitude + " - Orientation " +direction +  " - Speed " + (int)map(speed,0,4,0,100) );
    
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
  void actualisation (PVector posArbre, float e, PVector size, float divA, float divB, int forkA, int forkB, float amplitude, int n, int mode, float angle, float speed, int ID) {
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
    branch(e, size, divA, divB, forkA, forkB, amplitude, n, mode, ID);
    popMatrix () ;

    
  }
  
  
  //float fourche = 10.0 ; 
  void branch(float t, PVector proportion, float divA, float divB, int forkA, int forkB, float amplitude, int n, int mode, int ID) {
    PVector newSize = proportion.copy() ;
    newSize.x = proportion.x *divA ;
    newSize.y = proportion.y *divB;
    newSize.z = proportion.z *((divA +divB) *.5) ;
    if(newSize.x < 0.1 ) newSize.x = 0.1 ;
    
    float newThickness = t ;
    newThickness = t *.66 ;
    
    // recursice need a end  !
    n = n-1 ;
    if (n >0) {
     displayBranch(newThickness, newSize, divA, divB, forkA, forkB, amplitude, n, -theta, mode, ID) ; 
     displayBranch(newThickness, newSize, divA, divB, forkA, forkB, amplitude, n, theta, mode, ID) ;
    }
  }
  
  //annexe branch
  void displayBranch(float e, PVector newSize, float propA, float propB, int fourcheA, int fourcheB, float amplitude, int n, float t, int mode, int ID) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(t);   // Rotate by theta

    strokeWeight (e) ;
    
    if (mode == 0  ) line(0, 0, 0, -amplitude);  // Draw the branch
    if (mode == 2  ) { ellipse(0,0, newSize.x, newSize.y) ; line(0, 0, 0, -amplitude); }
    if (mode == 4  ) { rect(0,0, newSize.x, newSize.y) ; line(0, 0, 0, -amplitude); }
    
    if (mode == 1 || mode == 3 || mode == 5 ) {
      if (mode == 1 )  ellipse(0,0, newSize.x , newSize.y) ;
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
