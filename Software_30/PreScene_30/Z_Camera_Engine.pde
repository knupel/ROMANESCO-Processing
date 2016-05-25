/**
Camera Engine version 6.0.2
*/
private Vec3 posSceneMouseRef = Vec3 () ;
private Vec3 posEyeMouseRef = Vec3 () ;
private Vec3 posSceneCameraRef= Vec3 () ;
private Vec3 posEyeCameraRef = Vec3 () ;
private Vec3 eyeCamera = Vec3 () ;
private Vec3 sceneCamera = Vec3 () ;
private Vec3 deltaScenePos = Vec3 () ;
private Vec3 deltaEyePos = Vec3 () ;
private Vec3 tempEyeCamera = Vec3 () ;
private boolean newRefSceneMouse = true ;
private boolean newRefEyeMouse = true ;

// Update Camera position
/* We move the scene 
*/

Vec3 updatePosCamera(boolean authorization, boolean leapMotionDetected, Vec3 posDevice) {
  if(authorization) {
    //create the ref to calcul the new position of the Scene
    if(newRefSceneMouse) {
      posSceneCameraRef.set(sceneCamera) ;
      posSceneMouseRef.set(posDevice) ;
      //to create a only one ref position
      newRefSceneMouse = false ;
    }

    //create the delta between the ref and the mouse position
    deltaScenePos = sub(posDevice, posSceneMouseRef) ;
    if (leapMotionDetected) {
      //return add(mult(deltaScenePos,-1), posSceneCameraRef ) ; 
      return add(deltaScenePos.mult(-1), posSceneCameraRef ) ; 
    } else {
      return add(deltaScenePos, posSceneCameraRef ) ;
    }
  } else {
    //change the boolean to true for the next mousepressed
    newRefSceneMouse = true ;
    return sceneCamera ;
  }
}
//


// Update Camera EYE position
Vec3 updateEyeCamera(boolean authorization, Vec3 pos) {
  if(authorization) {
    //create the ref to calcul the new position of the Scene
    if(newRefEyeMouse) {
      posEyeCameraRef.set(tempEyeCamera) ;
      posEyeMouseRef.set(pos) ;
    }
    //to create a only one ref position
    newRefEyeMouse = false ;
    
    //create the delta between the ref and the mouse position
    deltaEyePos = sub(pos, posEyeMouseRef) ;
    tempEyeCamera = add(deltaEyePos, posEyeCameraRef ) ;

    //rotation of the camera
    // return eyeClassic(tempEyeCamera) ;
    return eyeClassic(tempEyeCamera) ;
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
Vec3 eyeMemory ;
Vec3 eyeClassic(Vec3 tempEye) {
  float temp_eye_x = map(tempEye.y, 0, width, 0, 360) ;
  float temp_eye_y = map(tempEye.x, 0, height, 0, 360) ;
  Vec3 eyeP3D =Vec3(temp_eye_x, temp_eye_y, 0) ;
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
