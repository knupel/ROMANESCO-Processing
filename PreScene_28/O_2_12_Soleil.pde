// Tab: O_2_12_Soleil
//object three
class Soleil extends Romanesco {
  public Soleil() {
    //from the index_objects.csv
    romanescoName = "Soleil" ;
    IDobj = 12 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "Version 1.1.1";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Beam/Lie'Bro'One/Lie'Bro'Two/Lie'Bro Noisy" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Canvas X,Quantity,Speed,Angle,Amplitude" ;
  }
  //GLOBAL
  float jitter ;
  float angleRotation ;
  //SETUP
  void setting() {
    startPosition(IDobj, width/2, height/2, 0) ;
    
  }
  PVector pos = new PVector() ;
  //DRAW
  void display() {
    aspect(IDobj) ;
    //
    if(spaceTouch && action[IDobj]) pos = new PVector(mouse[IDobj].x -width/2, mouse[IDobj].y -height/2,0) ; else pos = new PVector(0,0,0) ;
    int diam = int(map(canvasXObj[IDobj], width/10, width, width/10, width *1.2) *allBeats(IDobj) ) ;
    int numBeam = (int)(quantityObj[IDobj] *180 +1) ;
    if(!fullRendering) numBeam /= 20 ;
    if(numBeam < 2 ) numBeam = 2 ;
    // Jitter
    jitter += (angleObj[IDobj] *.001 ) ;
    float jitting = cos(jitter) *tempo[IDobj] ;
     //noise
     PVector noise = new PVector() ;
     float amp = sq(amplitudeObj[IDobj] *10.0) ;
     float rightNoise =  ((right[IDobj] *right[IDobj] *5) *amp) ;
     float leftNoise = ((left[IDobj] *left[IDobj] *5) *amp) ;
     if (sound[IDobj]) noise = new PVector(rightNoise, leftNoise) ; else noise = new PVector(amp,amp) ;
     // rotation direction
     int direction = 1 ;
     if(reverse[IDobj]) direction = 1 ; else direction = -1 ;
     if(!motion[IDobj]) direction = 0 ;
    // rotation speed
    float speedRotation = 0 ;
    speedRotation = sq(speedObj[IDobj] *10.0 *tempo[IDobj]) *direction ;
    angleRotation += speedRotation ;
    rotate (radians(angleRotation)) ;

    // mode
    if(mode[IDobj] == 0) soleil(pos, diam, numBeam) ;
    if(mode[IDobj] == 1) soleil(pos, diam, numBeam, jitting) ;
    if(mode[IDobj] == 2) soleil(pos, diam, numBeam, jitter) ;
    if(mode[IDobj] == 3) soleil(pos, diam, numBeam, jitter, noise) ;
    
    // info display
    String revolution = ("") ;
    if(spaceTouch && action[IDobj]) revolution =("false") ; else revolution = ("true") ;
    objectInfo[IDobj] = ("The sun have " + numBeam + " beams - Motion "+revolution ) ;
    
    
  }
  
  // ANNEXE
  // soleil with jitter
  void soleil(PVector pos, int diam, int numBeam, float jitter, PVector noise) {
    int numPoints = numBeam *2 ;
    for (int i = 0 ; i < numPoints -1 ; i = i +2) {
      float vibration = random(-noise.x, noise.y) ;
      PVector p1 = new PVector() ;
      PVector p2 = new PVector() ;
      p1 = circle(pos, diam, numPoints, jitter)[i].copy() ;
      p2 = circle(pos, diam, numPoints, jitter)[i +1].copy() ;
  
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
      p1 = circle(pos, diam, numPoints, jitter)[i].copy() ;
      p2 = circle(pos, diam, numPoints, jitter)[i +1].copy() ;
  
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
      p1 = circle(pos, diam, numPoints)[i].copy() ;
      p2 = circle(pos, diam, numPoints)[i +1].copy() ;
      beginShape() ;
      vertex(pos.x, pos.y, pos.z) ;
      vertex(p1.x, p1.y, p1.z) ;
      vertex(p2.x, p2.y, p2.z) ;
      endShape(CLOSE) ;
    }
  }
}
