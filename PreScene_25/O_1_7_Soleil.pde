
//object three
class Soleil extends SuperRomanesco {
  public Soleil() {
    //from the index_objects.csv
    romanescoName = "Soleil" ;
    IDobj = 7 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Alpha 1.0";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "1 Beam/2 Lie'Bro'One/3 Lie'Bro'Two/4 Lie'Bro Noisy" ;
  }
  //GLOBAL
  float jitter ;
  float angleRotation ;
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height -height/3, 0) ;
    
  }
  //DRAW
  void display() {
    aspect(IDobj) ;
    //
    PVector pos = new PVector(mouse[IDobj].x, mouse[IDobj].y,0) ;
    int diam = int(map(canvasXObj[IDobj], width/10, width, width/10, width *1.2) *allBeats(IDobj) ) ;
    int numBeam = (int)(quantityObj[IDobj] +1) ;
    // Jitter
    jitter += (angleObj[IDobj] *.001 ) ;
    float jitting = cos(jitter) *tempo[IDobj] ;
     //noise
     float noise = 0 ;
     if (sound[IDobj]) noise = (mix[IDobj] *mix[IDobj]) *50.0 ; else noise = sq(amplitudeObj[IDobj] *10.0) ;
    // rotation speed
    float speedRotation = 0 ;
    speedRotation = sq(speedObj[IDobj] *10.0 *tempo[IDobj]) ;
    angleRotation += speedRotation ;
    rotate (radians(angleRotation)) ;

    // mode
    if(mode[IDobj] == 0) soleil(pos, diam, numBeam) ;
    if(mode[IDobj] == 1) soleil(pos, diam, numBeam, jitting) ;
    if(mode[IDobj] == 2) soleil(pos, diam, numBeam, jitter) ;
    if(mode[IDobj] == 3) soleil(pos, diam, numBeam, jitter, noise) ;
    
    
  }
  
  // ANNEXE
  // soleil with jitter
  void soleil(PVector pos, int diam, int numBeam, float jitter, float noise) {
    int numPoints = numBeam *2 ;
    for (int i = 0 ; i < numPoints -1 ; i = i +2) {
      float vibration = random(-noise, noise) ;
      PVector p1 = new PVector() ;
      PVector p2 = new PVector() ;
      p1 = circle(pos, diam, numPoints, jitter)[i].get() ;
      p2 = circle(pos, diam, numPoints, jitter)[i +1].get() ;
  
      beginShape() ;
      vertex(pos.x, pos.y, pos.z) ;
      vertex(p1.x +vibration, p1.y +vibration, p1.z +vibration) ;
      vertex(p2.x +vibration, p2.y +vibration, p2.z +vibration) ;
      endShape(CLOSE) ;
    }
  }
  
  
  // soleil with jitter
  void soleil(PVector pos, int diam, int numBeam, float jitter) {
    int numPoints = numBeam *2 ;
    for (int i = 0 ; i < numPoints -1 ; i = i +2) {
      PVector p1 = new PVector() ;
      PVector p2 = new PVector() ;
      p1 = circle(pos, diam, numPoints, jitter)[i].get() ;
      p2 = circle(pos, diam, numPoints, jitter)[i +1].get() ;
  
      beginShape() ;
      vertex(pos.x, pos.y, pos.z) ;
      vertex(p1.x, p1.y, p1.z) ;
      vertex(p2.x, p2.y, p2.z) ;
      endShape(CLOSE) ;
    }
  }
  
  // classic soleil
  void soleil(PVector pos, int diam, int numBeam) {
    int numPoints = numBeam *2 ;
    for (int i = 0 ; i < numPoints -1 ; i = i +2) {
      PVector p1 = new PVector() ;
      PVector p2 = new PVector() ;
      p1 = circle(pos, diam, numPoints)[i].get() ;
      p2 = circle(pos, diam, numPoints)[i +1].get() ;
      beginShape() ;
      vertex(pos.x, pos.y, pos.z) ;
      vertex(p1.x, p1.y, p1.z) ;
      vertex(p2.x, p2.y, p2.z) ;
      endShape(CLOSE) ;
    }
  }
}
//end object two
