/**
SOLEIL || 2012 || 1.1.1
*/

class Soleil extends Romanesco {
  public Soleil() {
    //from the index_objects.csv
    RPE_name = "Soleil" ;
    ID_item = 12 ;
    ID_group = 1 ;
    RPE_author  = "Stan le Punk";
    RPE_version = "Version 1.1.1";
    RPE_pack = "Base" ;
    RPE_mode = "Beam/Lie'Bro'One/Lie'Bro'Two/Lie'Bro Noisy" ;
    RPE_slider = "Fill hue,Fill sat,Fill bright,Fill alpha,Stroke hue,Stroke sat,Stroke bright,Stroke alpha,Thickness,Canvas X,Quantity,Speed X,Angle,Canvas X" ;
  }
  //GLOBAL
  float jitter ;
  float angleRotation ;
  //SETUP
  void setting() {
    startPosition(ID_item, width/2, height/2, 0) ;
    
  }
  PVector pos = new PVector() ;
  //DRAW
  void display() {
    aspect_rpe(ID_item) ;
    //
    if(spaceTouch && action[ID_item]) pos = new PVector(mouse[ID_item].x -width/2, mouse[ID_item].y -height/2,0) ; else pos = new PVector(0,0,0) ;
    int diam = int(map(canvas_x_item[ID_item], width/10, width, width/10, width *1.2) *allBeats(ID_item) ) ;
    int numBeam = (int)(quantity_item[ID_item] *180 +1) ;
    if(!fullRendering) numBeam /= 20 ;
    if(numBeam < 2 ) numBeam = 2 ;
    // Jitter
    jitter += (angle_item[ID_item] *.001 ) ;
    float jitting = cos(jitter) *tempo[ID_item] ;
     //noise
     PVector noise = new PVector() ;
     float amp = sq(swing_x_item[ID_item] *10.0) ;
     float rightNoise =  ((right[ID_item] *right[ID_item] *5) *amp) ;
     float leftNoise = ((left[ID_item] *left[ID_item] *5) *amp) ;
     if (sound[ID_item]) noise = new PVector(rightNoise, leftNoise) ; else noise = new PVector(amp,amp) ;
     // rotation direction
     int direction = 1 ;
     if(reverse[ID_item]) direction = 1 ; else direction = -1 ;
     if(!motion[ID_item]) direction = 0 ;
    // rotation speed
    float speedRotation = 0 ;
    speedRotation = sq(speed_x_item[ID_item] *10.0 *tempo[ID_item]) *direction ;
    angleRotation += speedRotation ;
    rotate (radians(angleRotation)) ;

    // mode
    if(mode[ID_item] == 0) soleil(pos, diam, numBeam) ;
    if(mode[ID_item] == 1) soleil(pos, diam, numBeam, jitting) ;
    if(mode[ID_item] == 2) soleil(pos, diam, numBeam, jitter) ;
    if(mode[ID_item] == 3) soleil(pos, diam, numBeam, jitter, noise) ;
    
    // info display
    String revolution = ("") ;
    if(spaceTouch && action[ID_item]) revolution =("false") ; else revolution = ("true") ;
    objectInfo[ID_item] = ("The sun have " + numBeam + " beams - Motion "+revolution ) ;
    
    
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
