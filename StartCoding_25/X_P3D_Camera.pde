private PVector posSceneMouseRef, posEyeMouseRef ;
private PVector posSceneCameraRef, posEyeCameraRef ;
private PVector eyeCamera, sceneCamera ;
private PVector deltaScenePos, deltaEyePos ;
private PVector tempEyeCamera ;
private boolean newRefSceneMouse = true ;
private boolean newRefEyeMouse = true ;
//speed must be 1 or less
float speedMoveOfCamera = 0.1 ;
//CAMERA Stuff
boolean moveScene, moveEye ;
PVector newTarget = new PVector(0, 0, 0) ;

float speedDirectionOfObject = 0.1 ;
PVector  P3DpositionMouseRef, deltaObjPos ;
PVector  P3DdirectionMouseRef, deltaObjDir, P3DtempObjDir ;


//SETUP
void P3DSetup()
{
  for ( int i = 0 ; i < numObj + 1 ; i ++ ) {
    P3Dposition [i] = new PVector(-width/2, -height/2, 0) ;
    P3Ddirection [i] = new PVector(0, 0, 0) ;
  }
  //CAMERA
  sceneCamera = new PVector (width/2 , height/2, 0) ;
  sceneCamera = new PVector (0 , 0, 0) ;
  eyeCamera = new PVector (0,0,0) ;
  //
  posSceneCameraRef = new PVector (0,0,0) ;
  posEyeCameraRef = new PVector (0,0,0) ;
  //
  deltaScenePos = new PVector (0,0,0) ;
  deltaEyePos = new PVector (0,0,0) ;
  //
  tempEyeCamera = new PVector(0,0,0) ;
  
  //P3D
  for ( int i = 0 ; i < numObj + 1 ; i ++ ) {
  P3DpositionObjRef[i] = new PVector(0,0,0) ; 
  P3DdirectionObjRef[i] = new PVector(0,0,0) ;
  }
  P3DpositionMouseRef = new PVector(0,0,0) ; deltaObjPos = new PVector(0,0,0) ;
  P3DdirectionMouseRef = new PVector(0,0,0) ; deltaObjDir = new PVector(0,0,0) ;
}
//END SETUP




//P3D OBJECT
PVector P3Dposition(PVector pos, int ID) {
  
  //XY pos
  if (clickLongLeft[0] ) {
    if(P3DrefPos[ID]  ) {
      P3DpositionObjRef[ID] = pos ;
      P3DpositionMouseRef = new PVector(mouse[0].x, mouse[0].y) ;
    }
    //to create a only one ref position
    P3DrefPos[ID] = false ;
    //create the delta between the ref and the mouse position
    deltaObjPos.x = mouse[0].x -P3DpositionMouseRef.x ;
    deltaObjPos.y = mouse[0].y -P3DpositionMouseRef.y ;
    pos = PVector.add(deltaObjPos, P3DpositionObjRef[ID] ) ;
  }
  
  //Z pos
  //zoom
  zoom() ;
  pos.z -= getCountZoom ;
  
  return pos ;
}


PVector P3Ddirection(PVector dir, int ID, float speed) {
  //XY pos
  if (clickLongRight[0] ) {
    if(P3DrefDir[ID]  ) {
      P3DdirectionObjRef[ID] = dir ;
      P3DdirectionMouseRef = new PVector(mouse[0].x, mouse[0].y) ;
    }
    //to create a only one ref position
    P3DrefDir[ID] = false ;
    //create the delta between the ref and the mouse position
    deltaObjDir.x = mouse[0].x -P3DdirectionMouseRef.x ;
    deltaObjDir.y = mouse[0].y -P3DdirectionMouseRef.y ;
    P3DtempObjDir = PVector.add(deltaObjDir, P3DdirectionObjRef[ID] ) ;
    //rotation of the camera
    //solution 2
    dir.x += (pmouse[0].y-mouse[0].y) * speed;
    dir.y += (pmouse[0].x-mouse[0].x) *-speed;
    if(dir.x > 360 ) dir.x = 0 ;
    if(dir.x < 0  ) dir.x = 360 ;
    if(dir.y > 360 ) dir.y = 0 ; 
    if(dir.y < 0   ) dir.y = 360 ; 
    
  }
  return dir ;
}

//final direction and oriention with object ID
void P3Dmanipulation(int ID) {
  if(displayMode.equals("P3D")) {
    if(actionButton[ID] == 1 && vLongTouch ) {
      P3Dposition[ID] = P3Dposition(P3Dposition[ID], ID) ;
      P3Ddirection[ID] = P3Ddirection(P3Ddirection[ID], ID, speedDirectionOfObject) ; 
    }
    else P3DrefPos[ID] = true ;
    translate(P3Dposition[ID].x, P3Dposition[ID].y, P3Dposition[ID].z) ;
    rotateX(radians(P3Ddirection[ID].x)) ;
    rotateY(radians(P3Ddirection[ID].y)) ;
  }
}
//END OF P3D OBJECT







//CAMERA
void cameraDraw()
{
  //camera order
  if(clickLongLeft[0] && cLongTouch) moveScene = true ;   else moveScene = false ;
  if(clickLongRight[0] && cLongTouch) moveEye = true ;   else moveEye = false ;
  
  //void with speed setting
  float speedRotation = .5 ; // for example 3.0 is very fast, and 0.01 is very slow
  startCamera(moveScene, moveEye, speedRotation) ;
  //to change the scene position with the creature position
  if(gotoTarget) updateCamera(sceneCamera, newTarget, speedMoveOfCamera) ;
}
//END CAMERA DRAW





//startCamera with speed setting
void startCamera(boolean scene, boolean eye, float speed)
{
  pushMatrix() ;
  //Move the Scene
  if(scene) {
    //create the ref to calcul the new position of the Scene
    if(newRefSceneMouse) {
      posSceneCameraRef = sceneCamera ;
      posSceneMouseRef = new PVector(mouse[0].x, mouse[0].y) ;
    }
    //to create a only one ref position
    newRefSceneMouse = false ;
    //create the delta between the ref and the mouse position
    deltaScenePos.x = mouse[0].x -posSceneMouseRef.x ;
    deltaScenePos.y = mouse[0].y -posSceneMouseRef.y ;
    sceneCamera = PVector.add(deltaScenePos, posSceneCameraRef ) ;
  } else {
    //change the boolean to true for the next mousepressed
    newRefSceneMouse = true ;
  }
  
  //move the eye camera
  if(eye) {
    //create the ref to calcul the new position of the Scene
    if(newRefEyeMouse) {
      posEyeCameraRef = tempEyeCamera ;
      posEyeMouseRef = new PVector(mouse[0].x, mouse[0].y) ;
    }
    //to create a only one ref position
    newRefEyeMouse = false ;
    //create the delta between the ref and the mouse position
    deltaEyePos.x = mouse[0].x -posEyeMouseRef.x ;
    deltaEyePos.y = mouse[0].y -posEyeMouseRef.y ;
    tempEyeCamera = PVector.add(deltaEyePos, posEyeCameraRef ) ;

    //rotation of the camera
    //solution 2
    eyeCamera.x += (pmouse[0].y-mouse[0].y) * speed;
    eyeCamera.y += (pmouse[0].x-mouse[0].x) *-speed;
    if(eyeCamera.x > 360 ) eyeCamera.x = 0 ;
    if( eyeCamera.x < 0  ) eyeCamera.x = 360 ;
    if(eyeCamera.y > 360 ) eyeCamera.y = 0 ; 
    if(eyeCamera.y < 0   ) eyeCamera.y = 360 ; 
  } else {
    //change the boolean to true for the next mousepressed
    newRefEyeMouse = true ;
  }
  //zoom
  if(cLongTouch) { 
    zoom() ;
    sceneCamera.z -= getCountZoom ;
  }

  //CAMERA
  camera() ;
  beginCamera() ;

  //scene position
  translate(sceneCamera.x +width/2, sceneCamera.y +height/2, sceneCamera.z) ;
  //eye direction
  rotateX(radians(eyeCamera.x)) ;
  rotateY(radians(eyeCamera.y)) ;

}
//end camera with speed setting
///////////////////////////////

/*
///////////////////////////////////
//startCamera without speed setting
void startCamera(boolean scene, boolean eye)
{
  if (cLongTouch) zoom() ;
  
  pushMatrix() ;
  //Move the Scene
  if(scene) {
    //create the ref to calcul the new position of the Scene
    if(newRefSceneMouse) {
      posSceneCameraRef = sceneCamera ;
      posSceneMouseRef = new PVector(mouse[0].x, mouse[0].y) ;
    }
    //to create a only one ref position
    newRefSceneMouse = false ;
    //create the delta between the ref and the mouse position
    deltaScenePos.x = mouse[0].x -posSceneMouseRef.x ;
    deltaScenePos.y = mouse[0].y -posSceneMouseRef.y ;
    sceneCamera = PVector.add(deltaScenePos, posSceneCameraRef ) ;
  } else {
    //change the boolean to true for the next mousepressed
    newRefSceneMouse = true ;
  }
    
  
  //move the eye camera
  if(eye) {
    //create the ref to calcul the new position of the Scene
    if(newRefEyeMouse) {
      posEyeCameraRef = tempEyeCamera ;
      posEyeMouseRef = new PVector(mouse[0].x, mouse[0].y) ;
    }
    //to create a only one ref position
    newRefEyeMouse = false ;
    //create the delta between the ref and the mouse position
    deltaEyePos.x = mouse[0].x -posEyeMouseRef.x ;
    deltaEyePos.y = mouse[0].y -posEyeMouseRef.y ;
    tempEyeCamera = PVector.add(deltaEyePos, posEyeCameraRef ) ;

    //rotation of the camera
    //solution 1
    eyeCamera.x = map(tempEyeCamera.y, 0, height, 0, 360) ;
    eyeCamera.y = map(tempEyeCamera.x, 0, width, 0, 360) ;
  } else {
    //change the boolean to true for the next mousepressed
    newRefEyeMouse = true ;
  }
  //zoom
  sceneCamera.z -= getCountZoom ;
  //getCountZoom =0 ;
  
  //CAMERA
  camera() ;
  beginCamera() ;

  //scene position
  translate(sceneCamera.x, sceneCamera.y, sceneCamera.z) ;
  //eye direction
  rotateX(radians(eyeCamera.x)) ;
  rotateY(radians(eyeCamera.y)) ;
}
*/






//UPDATE CAMERA POSITION
void updateCamera(PVector origin, PVector target, float speed)
{
  if(!moveScene) sceneCamera = (follow(origin, target, speed)) ;
  if(!moveEye && gotoTarget) eyeCamera = backEye()  ;
}
//stop
void stopCamera()
{
  popMatrix() ;
  endCamera() ;
}
//END of CAMERA move
















//CHANGE the position of the CAMERA
///////////////////////////////////
//RAW
void cameraGoto(PVector newPos ) {
  sceneCamera = newPos ;
}


//END of change position of CAMERA
//////////////////////////////////


//GET
PVector getEyeCamera() { return eyeCamera ; }


//INIT FOLLOW
float distFollowRef = 0 ;
PVector eyeBackRef = new PVector(0,0,0 ) ;

void initFollow() {
  absPosition = new PVector(0,0,0) ;
  gotoTarget = true ;
}

void initFollow(PVector target, PVector eye) {
  distFollowRef = PVector.dist(target, sceneCamera) ;
  //println(distFollowRef) ;
  //println(targetName) ;
  eyeBackRef = eye ;
  absPosition = new PVector(0,0,0) ;
  gotoTarget = true ;
}
//END INIT FOLLOW


PVector backEye()
{
  PVector eye = new PVector(0,0) ;
  if(eyeBackRef.x < 180 ) eye.x = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.x, 0) ; else eye.x = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.x, 360) ;
  if(eyeBackRef.y < 180 ) eye.y = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.y, 0) ; else eye.y = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.y, 360) ;
  //println(currentDistToTarget, distFollowRef, eye) ;
  //println("Eye " + eye, "Eye Ref " + eyeBackRef) ;
  // eye.x = map(currentDistToTarget,0,distFollowRef,0,eyeBackRef.x) ;
  // eye.y = map(currentDistToTarget,0,distFollowRef,0,eyeBackRef.y) ;
  return eye ;
}


//MAIN VOID
PVector speedByAxes = new PVector(0,0,0) ;
boolean gotoTarget ;
//
/*
void cameraGoto(PVector newPos, float speed) {
  cameraSpeedMove = speed ;
  newDistanceToTarget = new PVector(0,0,0) ;
  distToCamera = PVector.sub(sceneCamera, newPos) ;
  speedByAxes = PVector.div(distToCamera, 1.0 / speed) ;
  // println(distToCamera, speedByAxes ) ;
}
*/
//calculate new position to go at the new target camera
PVector distToTargetUpdated = new PVector (0,0,0) ;
float currentDistToTarget = 0 ;
PVector currentPosition = new PVector(0,0,0) ;
PVector absPosition = new PVector(0,0,0) ;
// PVector targetPoint ;

PVector follow(PVector origin, PVector target, float speed)
{
  //very weird I must inverse the value to have the good result !
  //and change again at the end of the algorithm
  target.x = -target.x ;
  target.y = -target.y ;
  target.z = -target.z ;
  
  //updated the distance in realtime
  distToTargetUpdated = PVector.sub(currentPosition, target) ;
  currentDistToTarget = PVector.dist(currentPosition, target) ;
  
  
  //calculate the speed to go to target
  PVector absValueOfDist = new PVector (abs(distToTargetUpdated.x),abs(distToTargetUpdated.y),abs(distToTargetUpdated.z));
  absValueOfDist.normalize() ;
  //speedByAxes = PVector.div(absValueOfDist, 1.0 / speed) ; 
  speedByAxes = PVector.mult(absValueOfDist, speed) ;
  // println(speedByAxes.x, distToTargetUpdated.x, distToTargetUpdated.x / speedByAxes.x ) ;
  // PVector rangeStop = PVector.mult(speedByAxes,5000) ;
  PVector rangeStop = new PVector(5,5,5) ; 
  //calculate the new absolute position

  //XYZ
  if ( (distToTargetUpdated.x > rangeStop.x || distToTargetUpdated.x < -rangeStop.x) && 
        (distToTargetUpdated.y > rangeStop.y || distToTargetUpdated.y < -rangeStop.y) && 
        (distToTargetUpdated.y > rangeStop.z || distToTargetUpdated.y < -rangeStop.z))  {
    if (origin.x < target.x )  absPosition.x += speedByAxes.x ;  else absPosition.x -= speedByAxes.x ;
    if (origin.y < target.y )  absPosition.y += speedByAxes.y ;  else absPosition.y -= speedByAxes.y ;
    if (origin.z < target.z )  absPosition.z += speedByAxes.z ;  else absPosition.z -= speedByAxes.z ;
  //XY  
  } else if ( (distToTargetUpdated.x > rangeStop.x || distToTargetUpdated.x < -rangeStop.x) && 
              (distToTargetUpdated.y > rangeStop.y || distToTargetUpdated.y < -rangeStop.y)) {
    if (origin.x < target.x )  absPosition.x += speedByAxes.x ;  else absPosition.x -= speedByAxes.x ;
    if (origin.y < target.y )  absPosition.y += speedByAxes.y ;  else absPosition.y -= speedByAxes.y ;
    absPosition.z += 0 ;
  //XZ
  } else if ( (distToTargetUpdated.x > rangeStop.x || distToTargetUpdated.x < -rangeStop.x) && 
              (distToTargetUpdated.y > rangeStop.z || distToTargetUpdated.y < -rangeStop.z))  {
    if (origin.x < target.x )  absPosition.x += speedByAxes.x ;  else absPosition.x -= speedByAxes.x ;
    absPosition.y += 0 ;
    if (origin.z < target.z )  absPosition.z += speedByAxes.z ;  else absPosition.z -= speedByAxes.z ;
  //YZ
  } else if ( (distToTargetUpdated.y > rangeStop.y || distToTargetUpdated.y < -rangeStop.y) && 
              (distToTargetUpdated.y > rangeStop.z || distToTargetUpdated.y < -rangeStop.z))  {
    absPosition.x += 0 ;
    if (origin.y < target.y )  absPosition.y += speedByAxes.y ;  else absPosition.y -= speedByAxes.y ;
    if (origin.z < target.z )  absPosition.z += speedByAxes.z ;  else absPosition.z -= speedByAxes.z ;
  //X
  } else if ( (distToTargetUpdated.x > rangeStop.x || distToTargetUpdated.x < -rangeStop.x)) {
    if (origin.x < target.x )  absPosition.x += speedByAxes.x ;  else absPosition.x -= speedByAxes.x ;
    absPosition.y += 0 ;
    absPosition.z += 0 ;
  //Y  
  } else if ( (distToTargetUpdated.y > rangeStop.y || distToTargetUpdated.y < -rangeStop.y))  {
    absPosition.x += 0 ;
    if (origin.y < target.y )  absPosition.y += speedByAxes.y ;  else absPosition.y -= speedByAxes.y ;
    absPosition.z += 0 ;
  //Z
  } else if ( (distToTargetUpdated.y > rangeStop.z || distToTargetUpdated.y < -rangeStop.z))  {
    absPosition.x += 0 ;
    absPosition.y += 0 ;
    if (origin.z < target.z )  absPosition.z += speedByAxes.z ;  else absPosition.z -= speedByAxes.z ;
  //IT'S DONE, NOTHING TO DO NOW
  } else {  
    absPosition.x += 0 ;
    absPosition.y += 0 ;
    absPosition.z += 0 ;
    gotoTarget = false ;
  }
  
  //very weird I must inverse the value to have the good result !
  target.x = -target.x ;
  target.y = -target.y ;
  target.z = -target.z ;


  //finalize the newposition of the point
  currentPosition = PVector.add(origin, absPosition) ;
  /*
  currentPosition.x = origin.x + absPosition.x  ; 
  currentPosition.y = origin.y + absPosition.y ; 
  currentPosition.z = origin.z + absPosition.z  ; 
  */
  /*
  println("         Origine " + origin  ) ;
  println("       Final Pos " + currentPosition  ) ;
  println("          Target " + target) ;
  */
  //println("        Distance " + distToTarget ) ;
  //println("Distance updated " + distToTargetUpdated ) ;
  // println("         Vitesse " + speedByAxes ) ;
  
  return currentPosition ;
}
