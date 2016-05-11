// Tab: Z_Camera_Engine
/////////////////////////////
// Camera Engine version 6.a
////////////////////////////
private PVector posSceneMouseRef = new PVector() ;
private PVector posEyeMouseRef = new PVector() ;
private PVector posSceneCameraRef= new PVector() ;
private PVector posEyeCameraRef = new PVector() ;
private PVector eyeCamera = new PVector() ;
private PVector sceneCamera = new PVector() ;
private PVector deltaScenePos = new PVector() ;
private PVector deltaEyePos = new PVector() ;
private PVector tempEyeCamera = new PVector() ;
private boolean newRefSceneMouse = true ;
private boolean newRefEyeMouse = true ;

// Update Camera position
/* We move the scene 
*/

PVector updatePosCamera(boolean authorization, boolean leapMotionDetected, Vec3 posDevice) {
  if(authorization) {
    //create the ref to calcul the new position of the Scene
    if(newRefSceneMouse) {
      posSceneCameraRef.set(sceneCamera) ;
      posSceneMouseRef.set(new PVector(posDevice.x,posDevice.y,posDevice.z)) ;
      //to create a only one ref position
      newRefSceneMouse = false ;
    }

    //create the delta between the ref and the mouse position
    deltaScenePos = PVector.sub(new PVector(posDevice.x,posDevice.y,posDevice.z), posSceneMouseRef) ;
    if (leapMotionDetected) return      PVector.add(PVector.mult(deltaScenePos,-1), posSceneCameraRef ) ; 
                            else return PVector.add(deltaScenePos, posSceneCameraRef ) ;
  } else {
    //change the boolean to true for the next mousepressed
    newRefSceneMouse = true ;
    return sceneCamera ;
  }
}
//


// Update Camera EYE position
PVector updateEyeCamera(boolean authorization, PVector posMouse) {
  // PVector refEyeCamera = new PVector()  ;
  if(authorization) {
    //create the ref to calcul the new position of the Scene
    if(newRefEyeMouse) {
      posEyeCameraRef = tempEyeCamera ;
      posEyeMouseRef = posMouse.copy() ;
    }
    //to create a only one ref position
    newRefEyeMouse = false ;
    //create the delta between the ref and the mouse position
    deltaEyePos = PVector.sub(posMouse, posEyeMouseRef) ;
    tempEyeCamera = PVector.add(deltaEyePos, posEyeCameraRef ) ;

    //rotation of the camera
    // return eyeClassic(tempEyeCamera) ;
    return eyeClassic(tempEyeCamera).copy() ;
  } else {
    //change the boolean to true for the next mousepressed
    newRefEyeMouse = true ;
    return eyeCamera ;
  }
  
}




// EYE POSITION two solutions
/*
Solution 1
We must use this one with le leapmotion information, because with the leapmotion device
there is no "pmouse" information.
*/
PVector eyeMemory ;
PVector eyeClassic(PVector tempEye) {
  PVector eyeP3D = new PVector() ;
  eyeP3D = new PVector(map(tempEye.y, 0, width, 0, 360), map(tempEye.x, 0, height, 0, 360)) ; 
  return eyeP3D ;
}


/*
solution 2
we can use this better void when we don't use the leapmotion */

// Solution interesting but there is problem with it ??????????
PVector eyeAdvanced(PVector PreviousPos, PVector pos, PVector speed) {
  PVector eyeP3D = new PVector() ;
  // eyeP3D.x += (PreviousPos.y -pos.y) *speed.y;
  // eyeP3D.y += (PreviousPos.x -pos.x) *-speed.x;
  eyeP3D.x += (PreviousPos.y -pos.y) *speed.y;
  eyeP3D.y += (PreviousPos.x -pos.x) *-speed.x;
  
  if(eyeP3D.x > 360) eyeP3D.x = 0 ;
  if(eyeP3D.x < 0) eyeP3D.x = 360 ;
  if(eyeP3D.y > 360) eyeP3D.y = 0 ; 
  if(eyeP3D.y < 0) eyeP3D.y = 360 ;
  return eyeP3D ;
}

// END EYE POSITION
/////////////////////
