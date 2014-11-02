// LEAP MOTION
FingerLeap finger ;

void leapMotionSetup() {
  finger = new FingerLeap() ;
}

void leapMotionUpdate() {
  finger.updateLeap() ;
  if(finger.activefingers == 1 ) {
    println("clic gauche") ;
   // clickLongLeft[0] = true ;
    //clickShortLeft[0] = true ;
  } else {
   //  clickLongLeft[0] = false ;
  } 
  if(finger.activefingers == 2 ) {
    println("clic droit") ;
   // clickLongRight[0] = true ;
   // clickShortRight[0] = true ;
  }
}

boolean fingerVisibleCheck() {
  if (finger.activefingers > 0) return true ; else return false ;
}

PVector averageFingerPos() {
  PVector pos = new PVector() ;
  if(finger.fingerCheck) {
    for(int i = 0; i < finger.num ; i++) {
      pos = new PVector(finger.averageNormPos.x *width, height -finger.averageNormPos.y *height,finger.averageNormPos.z  *(width+height) -((width+height)/2)) ;
    }
  }
  return pos ;
}
