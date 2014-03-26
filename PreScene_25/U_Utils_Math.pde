//EQUATION
// EQUATION CIRLCE
float perimeterCircle ( int r ) {
  float p = 2*r*PI  ;
  return p ;
}
//EQUATION
float radiusSurface(int s) {
  float  r = sqrt(s/PI) ;
  return r ;
}
// END EQUATION CIRCLE
// normal direction 0-360 to -1, 1 PVector
PVector normalDir(int direction) {
  int numPoints = 360;
  float angle = TWO_PI/(float)numPoints;
  direction = 360-direction;
  direction += 180;
  return new PVector(sin(angle*direction), cos(angle*direction));
}
// degre direction from PVector direction
float deg360 (PVector dir) {
  float deg360 ;
  deg360 = 360 -(degrees(atan2(dir.x, dir.y)) +180)   ;
  return deg360 ;
}

//ROTATION
//GLOBAL
PVector resultPositionOfRotation = new PVector() ;
//DRAW

PVector rotation(PVector ref, PVector lattice, float angle) {
  float a = angle( lattice, ref ) + angle;
  float d = distance( lattice, ref );
  
  resultPositionOfRotation.x = lattice.x + cos( a ) * d;
  resultPositionOfRotation.y = lattice.y + sin( a ) * d;
  //
  return resultPositionOfRotation;
}

float angle(PVector p0, PVector p1) {
  return atan2( p1.y - p0.y, p1.x - p0.x );
}
  
float distance(PVector p0, PVector p1) {
  return sqrt( ( p0.x - p1.x ) * ( p0.x - p1.x ) + ( p0.y - p1.y ) * ( p0.y - p1.y ) );
}

//other Rotation
//Rotation Objet

void rotation (float angle, float posX, float posY ) {
  translate(posX, posY ) ;
  rotate (radians(angle) ) ;
}

//END OF ROTATION


// END EQUATION





//DISC
void disc( PVector pos, int diam, color c ) {
  for ( int i = 1 ; i < diam +1 ; i++) {
    circle(c, pos, i) ;
  }
}

void chromaticDisc( PVector pos, int diam ) {
  for ( int i = 1 ; i < diam +1 ; i++) {
    chromaticCircle(pos, i) ;
  }
}



//CIRCLE
void chromaticCircle(PVector pos, int d) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radiusSurface(surface)) ;
  int numPoints = ceil(perimeterCircle( radius)) ;
  for(int i=0; i < numPoints; i++) {
      //circle
      float stepAngle = map(i, 0, numPoints, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      //color
      color c = color (i, 100,100) ;
      //display
      set(int(pointOnCirlcle(radius, angle).x + pos.x) , int(pointOnCirlcle(radius, angle).y + pos.y), c);
  }
}

// END DISC





//full cirlce
void circle(color c, PVector pos, int d) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radiusSurface(surface)) ;
  int numPoints = ceil(perimeterCircle(radius)) ;
  for(int i=0; i < numPoints; i++) {
      float stepAngle = map(i, 0, numPoints, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      set(int(pointOnCirlcle(radius, angle).x + pos.x) , int(pointOnCirlcle(radius, angle).y + pos.y), c);
  }
}

//circle with a specific quantity points
void circle(color c, PVector pos, int d, int num) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radiusSurface(surface)) ;
  for(int i=0; i < num; i++) {
      float stepAngle = map(i, 0, num, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      set(int(pointOnCirlcle(radius, angle).x + pos.x) , int(pointOnCirlcle(radius, angle).y + pos.y), c);
  }
}


//circle with a specific quantity points and specific shape for each point
void circle(PVector pos, int d, int num, PVector size, String shape) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?
  int whichShape = 0 ;
  if (shape.equals("point") )  whichShape = 0;
  else if (shape.equals("ellipse") )  whichShape = 1 ;
  else if (shape.equals("rect") )  whichShape = 2 ;
  else if (shape.equals("box") )  whichShape = 3 ;
  else if (shape.equals("sphere") )  whichShape = 4 ;
  else whichShape = 0 ;

  int radius = ceil(radiusSurface(surface)) ;
  for(int i=0; i < num; i++) {
    float stepAngle = map(i, 0, num, 0, 2*PI) ; 
    float angle =  2*PI - stepAngle;
    PVector newPos = new PVector(pointOnCirlcle(radius, angle).x + pos.x, pointOnCirlcle(radius, angle).y + pos.y) ;
    if(whichShape == 0 ) point(newPos.x, newPos.y) ;
    if(whichShape == 1 ) ellipse(newPos.x, newPos.y, size.x, size.y) ;
    if(whichShape == 2 ) rect(newPos.x, newPos.y, size.x, size.y) ;
    if(whichShape == 3 ) {
      pushMatrix() ;
      translate(newPos.x, newPos.y,0) ;
      box(size.x, size.y, size.z) ;
      popMatrix() ;
    }
    if(whichShape == 4 ) {
      pushMatrix() ;
      translate(newPos.x, newPos.y,0) ;
      int detail = (int)size.x /4 ;
      if (detail > 10 ) detail = 10 ;
      sphereDetail(detail) ;
      sphere(size.x) ;
      popMatrix() ;
    }
  }
}


PVector pointOnCirlcle(int r, float angle) {
  PVector posPix = new PVector () ;
  posPix.x = cos(angle) *r ;
  posPix.y = sin(angle) *r ;
  return posPix ;
}
