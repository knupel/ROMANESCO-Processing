/**
 OLD Method deprecated
*/
//////////////////////////////////////////////
// THIS PART MUST BE DEPRECATED in the future
PVector rotation (PVector ref, PVector lattice, float angle) {
  float a = angle(lattice, ref) + angle;
  float d = distance( lattice, ref );
  float x = lattice.x + cos( a ) * d;
  float y = lattice.y + sin( a ) * d;
  return new PVector(x,y);
}
float distance( PVector p0, PVector p1) {
  return sqrt((p0.x - p1.x) *(p0.x - p1.x) +(p0.y - p1.y ) *(p0.y - p1.y ) );
}
float angle( PVector p0, PVector p1) {
  return atan2( p1.y -p0.y, p1.x -p0.x );
}


// CALCULATE THE POS of PVector Traveller
PVector gotoTarget(PVector origin,  PVector finish, float speed) {
  PVector pos = new PVector() ;
  if(origin.x > finish.x) pos.x = origin.x  -distanceDone(origin, finish, speed).x ; else pos.x = origin.x  +distanceDone(origin, finish, speed).x ; 
  if(origin.y > finish.y) pos.y = origin.y  -distanceDone(origin, finish, speed).y ; else pos.y = origin.y  +distanceDone(origin, finish, speed).y ; 
  if(origin.z > finish.z) pos.z = origin.z  -distanceDone(origin, finish, speed).z ; else pos.z = origin.z  +distanceDone(origin, finish, speed).z ; 
  return pos ;
}
// end calcultate




// DISTANCE DONE
PVector distance, distanceToDo ;
PVector distanceDone = new PVector() ;

PVector distanceDone(PVector origin,  PVector finish, float speedRef) {
  PVector dist = new PVector() ;
  PVector distance = new PVector() ;
  boolean stopX = false ;
  boolean stopY = false ;
  boolean stopZ = false ;
  distance.x = abs(finish.x - origin.x) ;
  distance.y = abs(finish.y - origin.y) ;
  distance.z = abs(finish.z - origin.z) ;
  //calcul the speed for XYZ
  PVector speed = new PVector(speedMoveTo(distance.x, speedRef), speedMoveTo(distance.y, speedRef), speedMoveTo(distance.z, speedRef)) ;
  // for the X
  dist.x = distance.x -distanceDone.x ;
  if(dist.x <= 0 ) stopX = true ; else stopX = false ;
  if(speed.x > dist.x ) speed.x = dist.x ;
  if(!stopX) distanceDone.x += speed.x ; else distanceDone.x = distance.x ;
  // for the Y
  dist.y = distance.y -distanceDone.y ;
  if(dist.y <= 0 ) stopY = true ; else stopY = false ;
  if(speed.y > dist.y ) speed.y = dist.y ;
  if(!stopY) distanceDone.y += speed.y ; else distanceDone.y = distance.y ;
  // for the Z
  dist.z = distance.z -distanceDone.z ;
  if(dist.z <= 0 ) stopZ = true ; else stopZ = false ;
  if(speed.z > dist.z ) speed.z = dist.z ;
  if(!stopZ) distanceDone.z += speed.z ; else distanceDone.z = distance.z ;
  //
  return distanceDone ;
}


float speedMoveTo(float distance, float speed) {
  return distance *1 *speed ;
}



// PVector goToPosFollow = = new PVector() ;
// CALCULATE THE POS of PVector Traveller, give the target pos and the speed to go.
PVector follow(PVector target, float speed) {
  PVector goToPosFollow = new PVector() ;
  // calcul X pos
  float targetX = target.x;
  float dx = targetX - goToPosFollow.x;
  if(abs(dx) != 0) {
    goToPosFollow.x += dx * speed;
  }
  // calcul Y pos
  float targetY = target.y;
  float dy = targetY - goToPosFollow.y;
  if(abs(dy) != 0) {
    goToPosFollow.y += dy * speed;
  }
  // calcul Z pos
  float targetZ = target.z;
  float dz = targetZ - goToPosFollow.z;
  if(abs(dz) != 0) {
    goToPosFollow.z += dz * speed;
  }
  return goToPosFollow ;
}





