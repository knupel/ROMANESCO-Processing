// LEAP COMMAND
///////////////
boolean orderOneLeap, orderTwoLeap ;


void updateLeapCommand() {
  // move the object
  if(finger.activefingers == 1 ) {
    orderOneLeap = true ; 
    orderTwoLeap = false ;
  }
  // rotate the object
  else if(finger.activefingers == 2) {
    orderOneLeap = false ; 
    orderTwoLeap = true ;
  }
  // move and rotate
  else if(finger.activefingers == 3) {
    orderOneLeap = true ; 
    orderTwoLeap = true ;
  } else if(finger.activefingers != 1 || finger.activefingers != 2 || finger.activefingers != 3) {
    orderOneLeap = false ; 
    orderTwoLeap = false ;
  }
    
}






/////////////////////////////
// VOID & FUNCTION LEAPMOTION
// LEAP MOTION
FingerLeap finger ;

void leapMotionSetup() {
  finger = new FingerLeap() ;
}

void leapMotionUpdate() {
  finger.updateLeap() ;
  if(fingerVisibleCheck()) LEAPMOTION_DETECTED = true ; else LEAPMOTION_DETECTED = false ;
}

boolean fingerVisibleCheck() {
  if (finger.activefingers > 0) return true ; else return false ;
}


// DIRECT POS of the fingers in the LEAP FIELD DETECTION
// CLASSIC WORLD
PVector averageFingerPos() {
  PVector pos = new PVector() ;
  if(finger.fingerCheck) {
    for(int i = 0; i < finger.num ; i++) {
      pos = new PVector(finger.averagePos.x *width, height -finger.averagePos.y *height,finger.averagePos.z  *(width+height) -((width+height)/2)) ;
    }
  }
  return pos ;
}


// GIVE the size of your world
PVector averageFingerPos(PVector canvas) {
  PVector pos = new PVector() ;
  if(finger.fingerCheck) {
    for(int i = 0; i < finger.num ; i++) {
      pos = new PVector(finger.averagePos.x *canvas.x, canvas.y -finger.averagePos.y *canvas.y,finger.averagePos.z  *canvas.z -(canvas.z/2)) ;
    }
  }
  return pos ;
}



// POSITION from a direction, by adding info from the leap direction
PVector translatePosition = new PVector() ;
PVector averageTranslatePosition(float speed) {
  if(finger.fingerCheck) {
    for(int i = 0; i < finger.num ; i++) {
      PVector tempDir = new PVector(finger.averageDir.x *speed, finger.averageDir.y *speed, finger.averageDir.z *speed) ; 
      translatePosition.add(tempDir) ;
    }
    return translatePosition ; 
  } else return translatePosition ;
}




///////////////////
//CLASS LEAPMOTION
import com.leapmotion.leap.*;
com.leapmotion.leap.Controller leap;


class FingerLeap {
  //global
  // speed reactivity to update the position of the pointer - cursor in XYZ world - 
  float speed = .05 ;
  // Minimum value to accept finger in the count. The value must be between 0 to 1 ;
  float minValueToCountFinger = .95 ; 
  // range value around the first finger to accepted in the finger count 
  float rangeAroundTheFirstFinger = .2 ;
  //check if the fingers is present or no
  boolean fingerCheck ;
  boolean [] fingerVisible ;
  //for each finger
  int num ;
  int activefingers ;
  int [] ID ;
  int [] IDleap ;
  PVector [] pos ;
  PVector [] dir ;
  float [] magnitude, roll, pitch, yaw ;
  
  // average data
  PVector averagePos, averageDir ;
  PVector addPos = new PVector() ;
  float rangeMin = 0 ; 
  float rangeMax = 0 ;
  PVector findAveragePos = new PVector() ;
  
  FingerLeap() {
    leap = new com.leapmotion.leap.Controller();
  }
  
  
  void updateLeap() {
    InteractionBox iBox = leap.frame().interactionBox();
    PointableList objectNum = leap.frame().pointables();
    //check finger
    fingerCheck = !objectNum.isEmpty() ;
    // create and init var ;
    num = objectNum.count() ;
    IDleap = new int[num] ;
    ID = new int[num] ;
    activefingers = 0 ;
    fingerVisible = new boolean [num] ;
    pos = new PVector[num] ;
    dir = new PVector[num] ;
    magnitude = new float [num] ; 
    roll= new float [num] ; 
    pitch= new float [num] ; 
    yaw = new float [num] ;
    
    // give info to variables for each finger display or not
    for(int i = 0; i < objectNum.count(); i++) {
      
      //initialization
      Pointable object = objectNum.get(i);
      com.leapmotion.leap.Vector normalPos = iBox.normalizePoint(object.stabilizedTipPosition());
      fingerVisible[i] = false ;
      
      // catch info
      IDleap[i] = object.id() ;
      ID[i] = i  ;
      // return normal position value between 0 to 1 
      pos[i] = new PVector(normalPos.getX(),normalPos.getY(),normalPos.getZ()) ;
      // return normal direction between - 1 to 1
      dir[i] = new PVector(normalPos.getX() *2 -1.0, normalPos.getY() *2 -1.0, normalPos.getZ() *2 -1.0 ) ;
      
      // misc value
      magnitude[i] = normalPos.magnitude() ; 
      roll[i] = normalPos.roll() ; 
      pitch[i] = normalPos.pitch() ; 
      yaw[i] = normalPos.yaw() ;
      
      
      //Find average position of all visible fingers
      findAveragePos(pos[i], i) ; 
    }
    // write the result
    averagePos = averagePos(addPos).copy() ;
    averageDir = new PVector(averagePos.x *2 -1.0, averagePos.y *2 -1.0,averagePos.z *2 -1.0) ;
  }
  
  
  
  // ANNEXE
  
  //check if the finger is visible or not
  void findAveragePos(PVector normalPos, int whichOne) {
    if(activefingers < 1) {
      if(normalPos.z < minValueToCountFinger) {
        addPos = normalPos.copy() ;
        rangeMin = addPos.z -rangeAroundTheFirstFinger ; 
        rangeMax = addPos.z +rangeAroundTheFirstFinger ;
        activefingers += 1 ;
        fingerVisible[whichOne] = true ;
      }
    // if there is one finger, we compare if the others are close of the firsts fingers  
    } else {
      // check if the next finger is in the range
      if(normalPos.z > rangeMin && normalPos.z < rangeMax) {
        // create a range from the average position Z
        rangeMin = addPos.z -rangeAroundTheFirstFinger ; 
        rangeMax = addPos.z +rangeAroundTheFirstFinger ;
        // check if the finger detected is in the range or not, we must do that because the detection of the finger is not perfect and add finger when the hand is deepness in detector
        // if it's ok we add a visible finger in the count
        // check if the finger detected is in the range or not, we must do that because the detection of the finger is not perfect and add finger when the hand is deepness in detector
        activefingers += 1 ;
        // if it's ok we add value
        addPos.add(normalPos.x,normalPos.y,normalPos.z) ;
        // after we divide by 2 because we've added a value at the end of this checking.
        addPos.div(2) ;
        fingerVisible[whichOne] = true ;
      }
    } 
  }

  
  
  // Function to calcul the average position and smooth this one
  PVector averagePos(PVector infoPos) {
    PVector pos = new PVector() ;
    /*
    Average position of all visible fingers
    Finalize the calcule, and dodge the bad value
    */
    if(infoPos.x > 1.0) infoPos.x /= 2.0 ;
    if(infoPos.y > 1.0) infoPos.y /= 2.0 ;
    if(infoPos.z > 1.0) infoPos.z /= 2.0 ;
    //smooth the result
    // pos = new PVector(follow(pos, speed).x, follow(pos, speed).y, follow(pos, speed).z) ;
    pos = follow(infoPos, speed).copy() ;
    // pos = infoPos.copy() ;
    return pos ;
  }
}
