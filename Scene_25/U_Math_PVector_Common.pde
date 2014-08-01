

// PVECTOR
// PASS THE INFORMATION, but the good !
PVector finishRef ;
boolean initMove ;
PVector currentPos = new PVector() ;

PVector follow(PVector finish, float speed) {
  PVector origin = new PVector() ;
  if(finish != finishRef && initMove ) {
    origin = currentPos.copy() ; 
  } 
  if (!initMove ) {
    origin = new PVector(width/2, height/2, 0 ) ;
    finish = new PVector(width/2, height/2, 0 ) ;
    finishRef = finish.copy() ; 
    initMove = true ;
  }
  currentPos = gotoTarget(origin, finish, speed) ;
  return currentPos ;
}
// END PASS


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
