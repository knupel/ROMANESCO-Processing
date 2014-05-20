//LEAP MOTION
import com.leapmotion.leap.*;
com.leapmotion.leap.Controller leap;

//boolean delayBetweenThePos ;
//int numFingerRef ;
PVector AveragePosFinal = new PVector() ;
// AVERAGE WITHOUT RANGE
PVector averagePosition(boolean leapMotionConnected) {
  if( numFingers() > 1 ) {
    InteractionBox iBox = leap.frame().interactionBox();
    PointableList objectNum = leap.frame().pointables();
    if(leapMotionConnected) {
      AveragePosFinal = averageFingersPosition(objectNum, iBox) ;
    } else {
      //leapMotion is not active
      AveragePosFinal = new PVector (mouseX,mouseY) ;
    }
    float speed = 0.00001 ;
    AveragePosFinal = new PVector(follow(AveragePosFinal, speed).x, follow(AveragePosFinal, speed).y, follow(AveragePosFinal, speed).z) ;
  }
  return AveragePosFinal ;
}

// ANNEXE
PVector averageFingersPosition(PointableList objectNum, InteractionBox iBox) {
  PVector averagePosOfTheFinger = new PVector (0,0,0) ;
  averagePosOfTheFinger = addFingerPosition(objectNum, iBox) ;
  //calculate the average position of all the fingers
  // security, in case all the finger is equal to zero
  if(averagePosOfTheFinger.x <= 0 ) averagePosOfTheFinger.x = 0.0001 ; 
  if(averagePosOfTheFinger.y <= 0 ) averagePosOfTheFinger.y = 0.0001 ; 
  if(averagePosOfTheFinger.x != 0 || averagePosOfTheFinger.x != 0  ) averagePosOfTheFinger.div(objectNum.count()) ;
  return averagePosOfTheFinger ;
}

PVector addFingerPosition(PointableList objectNum, InteractionBox iBox) {
    //quantity of finger in the area
  PVector addPos = new PVector() ;
  for(int p = 0; p < objectNum.count(); p++) {
    //initialization
    Pointable object = objectNum.get(p);
    com.leapmotion.leap.Vector normPos = iBox.normalizePoint(object.stabilizedTipPosition());
    //return the ID
    int objectLeapID = object.id()  ;
    
    //3D position
    float posX = normPos.getX() * width;
    float posY = height - normPos.getY() * height;
    int depth = (width + height) / 4 ;
    float ratioZoom = 1.0 ;
    float posZ = map(normPos.getZ(), 1,0, -depth *ratioZoom, depth *ratioZoom) ;
    //put position info in PVector
    PVector pos = new PVector (posX, posY, -posZ) ;
    //add pos finger by finger
    addPos.add(pos) ;
  }
  return addPos ;
}










// WITH RANGE
PVector AveragePosFinalRange = new PVector() ;

PVector averagePosition(boolean leapMotionConnected, PVector vertRange) {
  if( numFingers() > 1 ) {
    InteractionBox iBox = leap.frame().interactionBox();
    PointableList objectNum = leap.frame().pointables();
    if(leapMotionConnected) {
      AveragePosFinalRange = averageFingersPosition(objectNum, iBox, vertRange) ;
    } else {
      //leapMotion is not active
      AveragePosFinalRange = new PVector (mouseX,mouseY) ;
    }
    float speed = 0.00001 ;
    AveragePosFinalRange = new PVector(follow(AveragePosFinalRange, speed).x, follow(AveragePosFinalRange, speed).y, follow(AveragePosFinalRange, speed).z) ;
  }
  return AveragePosFinalRange ;
}


// ANNEXE
PVector averageFingersPosition(PointableList objectNum, InteractionBox iBox, PVector vertRange) {
  PVector averagePosOfTheFinger = new PVector (0,0,0) ;
  averagePosOfTheFinger = addFingerPosition(objectNum, iBox, vertRange) ;
  //calculate the average position of all the fingers
  // security, in case all the finger is equal to zero
  if(averagePosOfTheFinger.x <= 0 ) averagePosOfTheFinger.x = 0.0001 ; 
  if(averagePosOfTheFinger.y <= 0 ) averagePosOfTheFinger.y = 0.0001 ; 
  if(averagePosOfTheFinger.x != 0 || averagePosOfTheFinger.x != 0  ) averagePosOfTheFinger.div(objectNum.count()) ;
  return averagePosOfTheFinger ;
}


// ANNEXE
//add all the finger with range
PVector addFingerPosition(PointableList objectNum, InteractionBox iBox, PVector vertRange) {
    //quantity of finger in the area
  PVector addPos = new PVector() ;
  for(int p = 0; p < objectNum.count(); p++) {
    //initialization
    Pointable object = objectNum.get(p);
    com.leapmotion.leap.Vector normPos = iBox.normalizePoint(object.stabilizedTipPosition());
    //return the ID
    int objectLeapID = object.id()  ;
    
    //3D position
      float posX = normPos.getX() *width;
      float newNormPosY = changeTheRangeVert(vertRange,normPos.getY()) ;
      
      float posY = height - newNormPosY *height;
      int depth = (width + height) / 4 ;
      float ratioZoom = 1.0 ;
      float posZ = map(normPos.getZ(), 1,0, -depth *ratioZoom, depth *ratioZoom) ;
      //put position info in PVector
      PVector pos = new PVector (posX, posY, posZ) ;
    
    //add pos finger by finger
    addPos.add(pos) ;
    
  }
  return addPos ;
}







// ANNEXE

//return the num of finger
int numFingers() {
  int num ;
  InteractionBox iBox = leap.frame().interactionBox();
  PointableList objectNum = leap.frame().pointables();
  num = objectNum.count() ;
  return num ;
}

/*
//check is there is Finger in the field
boolean fingerCheck() {
  Boolean test ;
  InteractionBox iBox = leap.frame().interactionBox();
  PointableList objectNum = leap.frame().pointables();
  // PointableList objectNum = leap.frame().isValid();
  if (objectNum.isEmpty()) test = false ; else test = true ;
  return test ;
}
*/
boolean fingerCheck() {
  Boolean test ;InteractionBox iBox = leap.frame().interactionBox();
  PointableList objectNum = leap.frame().pointables();
  // PointableList objectNum = leap.frame().isValid();
  test = objectNum.isEmpty() ;
  return test ;
}

// ANNEXE
float changeTheRangeVert(PVector range , float axe) {
  if (axe > range.y ) axe = range.y ;
  if (axe < range.x ) axe = range.x ;
  axe = (axe - range.x) * (1 / (range.y -range.x)) ;
  return axe ;
}
