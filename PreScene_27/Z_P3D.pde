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
//travelling
boolean gotoCameraPosition, gotoCameraEye, travellingPriority ;

//speed must be 1 or less
float speedMoveOfCamera = 0.1 ;
//CAMERA Stuff
private boolean moveScene, moveEye ;

PVector targetPosCam = new PVector() ;

//P3D ROMANESCO STUFF
PVector speedDirectionOfObject  ;
PVector  P3DpositionMouseRef = new PVector() ;
PVector deltaObjPos = new PVector() ;
PVector  P3DdirectionMouseRef = new PVector() ;
PVector deltaObjDir = new PVector() ;

PVector tempObjDir = new PVector() ;
PVector sizeBackgroundP3D  ;


// P3D SETUP
////////////
void P3DSetup(boolean modeP3D, int numObj, int numSettingCamera, int numSettingOrientationObject) {
      
  if(modeP3D) {
    sizeBackgroundP3D = new PVector(width *100, height *100, height *7.5) ;
    settingAllCameras (numSettingCamera) ;
    settingObjManipulation (numObj) ;
    settingObjectManipulation(numObj, numSettingCamera, numSettingOrientationObject) ;
  }
}


// ANNEXE setting object manipulation
void settingObjManipulation (int numObj) {
  //P3D for all ROMANESCO object
  for ( int i = 0 ; i < numObj ; i++ ) {
    posObj[i] = new PVector() ; 
    dirObj[i] = new PVector () ;
    dirObjX [i] = 0 ;
    dirObjY [i] = 0 ;
  }
}

void settingObjectManipulation (int numObj, int numSettingCamera, int numSettingOrientationObject) {
  // object orientation
  for ( int i = 0 ; i < numSettingOrientationObject ; i++ ) {
    for (int j = 0 ; j < numObj ; j++ ) {
       posObjSetting [i][j] = new PVector() ;
       dirObjSetting [i][j] = new PVector() ;
     }
   }
}

// ANNEXE setting camera manipulation
void settingAllCameras (int numSettingCamera) {
  for ( int i = 0 ; i < numSettingCamera ; i++ ) {
     eyeCameraSetting[i] = new PVector () ;
     sceneCameraSetting[i] = new PVector () ;
  }
}
  


//END SETUP
///////////













////////////////////////////////
//OBJECT position and direction
// MAIN
// final direction and oriention with object ID
void objectMove(boolean movePos, boolean moveDir, int ID) {
  if(modeP3D) {
    //UPDATE
    //position
    if (!movePos)  newObjRefPos = true ;
    posObjX[ID] = updatePosObj(posObj[ID], ID, movePos).x ;
    posObjY[ID] = updatePosObj(posObj[ID], ID, movePos).y ;
    posObjZ[ID] = updatePosObj(posObj[ID], ID, movePos).z ;
    //rotation
    if (!moveDir) newObjRefDir = true ;
      //speed rotation
    float speed = 100.0 ; // 150 is medium speed rotation
    speedDirectionOfObject = new PVector(speed /(float)width, speed /(float)height) ; 
    dirObjX[ID] = updateDirObj(speedDirectionOfObject, ID, moveDir).x ; 
    dirObjY[ID] = updateDirObj(speedDirectionOfObject, ID, moveDir).y ;
    
    //RESET
    if(touch0) {
      posObjX[ID] = posObjSetting [0][ID].x ;
      posObjY[ID] = posObjSetting [0][ID].y ;
      posObjZ[ID] = posObjSetting [0][ID].z ;
      dirObjX[ID] = dirObjSetting [0][ID].x ;
      dirObjY[ID] = dirObjSetting [0][ID].y ;
    }
  }
  addRefObj(ID) ;
}


//ANNEXE
//direction

PVector updateDirObj(PVector speed, int ID, boolean authorization) {
  
  if(authorization) {
    if(newObjRefDir) {
      dirObjRef = tempObjDir ;
      P3DdirectionMouseRef = mouse[0].copy() ;
    }
    //to create a only one ref position
    newObjRefDir = false ;
    //create the delta between the ref and the mouse position
    deltaObjDir = PVector.sub(mouse[0], P3DdirectionMouseRef) ;
    tempObjDir = PVector.add(deltaObjDir, dirObjRef) ;
    
    //rotation of the camera
    dirObj[ID] = eyeClassic(tempObjDir).copy() ;
  } else {
    newObjRefDir = true ;
  }
  return dirObj[ID] ;
}

//position
PVector updatePosObj(PVector pos, int ID, boolean authorization) {
  // XY pos
  if(newObjRefPos) {
    posObjRef = pos.copy() ;
    P3DpositionMouseRef = mouse[0].copy() ;
  }
  if (authorization) {
    //to create a only one ref position
    newObjRefPos = false ;
    //create the delta between the ref and the mouse position
    deltaObjPos.x = mouse[0].x -P3DpositionMouseRef.x ;
    deltaObjPos.y = mouse[0].y -P3DpositionMouseRef.y ;
    deltaObjPos.z = mouse[0].z -P3DpositionMouseRef.z ;
    pos = PVector.add(deltaObjPos, posObjRef ) ;
    
  }
  // we catch the mouseZ info here because we don't need the authorizationv
  pos.z -= wheel[0] ;
  return pos ;
}
//Create ref position
void addRefObj(int ID) {
  if(modeP3D) {
    posObj[ID] = new PVector (posObjX[ID], posObjY[ID],posObjZ[ID]) ;
    dirObj[ID] = new PVector (dirObjX[ID], dirObjY[ID]);
  }
}

//go to the new position
void P3DmoveObj(int ID) {
  translate(posObjX[ID], posObjY[ID], posObjZ[ID]) ;
  rotateX(radians(dirObjX[ID])) ;
  rotateY(radians(dirObjY[ID])) ;
}


//END OF P3D OBJECT ORIENTATION AND DIRECTION


//starting position
void startPosition(int ID, int x, int y, int z) {
  startingPosition[ID] = new PVector(x,y,z) ;
  posObjX[ID] = x -(width/2) ;
  posObjY[ID] = y -(height/2) ;
  posObjZ[ID] = z ;
  
  posObjSetting [0][ID] = new PVector(posObjX[ID], posObjY[ID], posObjZ[ID] ) ;
  mouse[ID] = new PVector (x,y,z) ;
}
// END MOVE OBJECT
///////////////////////////////////////////












///////////////////////////////////////////
// MOVE CAMERA
void cameraDraw() {
  if(modeP3D) {
    paralaxe() ;
    //camera order from the mouse or from the leap
    if(cLongTouch) {
      if(ORDER_ONE || ORDER_THREE) moveScene = true ;   else moveScene = false ;
      if(ORDER_TWO || ORDER_THREE) moveEye = true ;   else moveEye = false ;
      
      //update z position of the camera
      sceneCamera.z -= wheel[0] ;
      
      // change camera position
      if(enterTouch) travelling(posCamRef) ;
      if (touch0) changeCameraPosition(0) ;
    } else if (!cLongTouch || (ORDER_ONE && ORDER_ONE && ORDER_THREE) ) {
      moveScene = false ;
      moveEye = false ;
    }

    //void with speed setting
    float speed = 150.0 ; // 150 is medium speed rotation
    PVector speedRotation = new PVector(speed /(float)width, speed /(float)height) ; 
    startCamera(moveScene, moveEye, LEAPMOTION_DETECTED, speedRotation) ;
    
    //to change the scene position with a specific point
    if(gotoCameraPosition || gotoCameraEye ) updateCamera(sceneCamera, targetPosCam, speedMoveOfCamera) ;

    
    //catch ref camera
    catchCameraInfo() ;
  }
}
//END CAMERA DRAW




//CATCH a ref position and direction of the camera
PVector posCamRef = new PVector() ;
PVector eyeCamRef = new PVector() ;
//boolean security to catch the reference camera when you reset the position of this one
boolean catchCam = true ;

void catchCameraInfo() {
  if(catchCam) {
    posCamRef = getPosCamera() ;
    eyeCamRef = getEyeCamera() ;
  }
  catchCam = false ;
}
//END catch position







//startCamera with speed setting
void startCamera(boolean scene, boolean eye, boolean leapMotionDetected, PVector speed) {
  pushMatrix() ;
  //Move the Scene
  // We cannot use the method copy of the PVector, because we must preserve the "Z" parameter of this PVector to move the Scene with the wheel
  sceneCamera.x = updatePosCamera(scene, leapMotionDetected, mouse[0]).x ;
  sceneCamera.y = updatePosCamera(scene, leapMotionDetected, mouse[0]).y ;
  eyeCamera = updateEyeCamera(eye, mouse[0]).copy() ;
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







// CAMERA ENGINE
// CAMERA version 5.b


// Update POS CAMERA
// Update Camera position
PVector refPosCamera = new PVector() ;
PVector updatePosCamera(boolean authorization, boolean leapMotionDetected, PVector pos) {
  // MOVE SCENE
  ////////////////
  if(authorization) {
    //create the ref to calcul the new position of the Scene
    if(newRefSceneMouse) {
      posSceneCameraRef = sceneCamera.copy() ;
      posSceneMouseRef = pos.copy() ;
      //to create a only one ref position
      newRefSceneMouse = false ;
    }

    //create the delta between the ref and the mouse position
    deltaScenePos = PVector.sub(pos, posSceneMouseRef) ;
    if (leapMotionDetected) refPosCamera = PVector.add(PVector.mult(deltaScenePos,-1), posSceneCameraRef ) ; else refPosCamera = PVector.add(deltaScenePos, posSceneCameraRef ) ;
  } else {
    //change the boolean to true for the next mousepressed

    newRefSceneMouse = true ;
  }
  return refPosCamera ;
}




/////////////////////
// UPDATE EYE CAMERA
PVector refEyeCamera = new PVector()  ;
PVector updateEyeCamera(boolean authorization, PVector posMouse) {
  if(authorization) {
    //create the ref to calcul the new position of the Scene
    if(newRefEyeMouse) {
      posEyeCameraRef = tempEyeCamera.copy() ;
      posEyeMouseRef = posMouse.copy() ;
    }
    //to create a only one ref position
    newRefEyeMouse = false ;
    //create the delta between the ref and the mouse position
    deltaEyePos = PVector.sub(posMouse, posEyeMouseRef) ;
    tempEyeCamera = PVector.add(deltaEyePos, posEyeCameraRef ) ;

    //rotation of the camera
    refEyeCamera = eyeClassic(tempEyeCamera).copy() ;
  } else {
    //change the boolean to true for the next mousepressed
    newRefEyeMouse = true ;
  }
  return refEyeCamera ;
}



//UPDATE CAMERA POSITION
void updateCamera(PVector origin, PVector target, float speed) {
  if(!moveScene) sceneCamera = (follow(origin, target, speed)) ;
  if(!moveEye && (gotoCameraPosition || gotoCameraEye)) eyeCamera = backEye()  ;
}
//stop
void stopCamera() {
  if(modeP3D) {
    popMatrix() ;
    endCamera() ;
    stopParalaxe() ;
  }
}

// END CAMERA
/////////////














// EYE POSITION two solutions
/*
Solution 1
We must use this one with le leapmotion information, because with the leapmotion device
there is no "pmouse" information.
*/
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
// END CAMERA version 5.a
/////////////////////////












// CHANGE CAMERA POSITION
void changeCameraPosition(int ID) {
  eyeCamera = eyeCameraSetting[ID].copy() ;
  sceneCamera = sceneCameraSetting[ID].copy() ;
  gotoCameraPosition = false ;
  gotoCameraEye = false ;
}
//END of change position of CAMERA
//////////////////////////////////











//GET
PVector getEyeCamera() { return eyeCamera ; }
PVector getPosCamera() { return sceneCamera ; }




//INIT FOLLOW
float distFollowRef = 0 ;
PVector eyeBackRef = new PVector() ;
//travelling with only camera position
void travelling(PVector target) {
  distFollowRef = PVector.dist(target, sceneCamera) ;
  
  targetPosCam = target ; 
  eyeBackRef = getEyeCamera() ;
  absPosition = new PVector() ;
  gotoCameraPosition = true ;
  gotoCameraEye = true ;
}
//END INIT FOLLOW



float speedX  ;
float speedY  ;
    
PVector backEye() {
  PVector eye = new PVector() ;

  if(gotoCameraEye) {
    if(currentDistToTarget > 2 ) {
      travellingPriority = true ;
      if (eyeBackRef.x < 180 ) eye.x = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.x, 0) ; else eye.x = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.x, 360) ;
      if (eyeBackRef.y < 180 ) eye.y = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.y, 0) ; else eye.y = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.y, 360) ;
      //stop the calcul
      if(eye.x < 2 || eye.x > 358 ) eye.x = 0 ;
      if(eye.y < 2 || eye.y > 358 ) eye.y = 0 ; 
      if(eye.x == 0  && eye.y == 0) {
        gotoCameraEye = false ;
        travellingPriority = false ;
      }
    } else {
      //speed of the eye to return to original position
      float speedBackEye = 0.2 ;
      float ratioX = eyeBackRef.x / frameRate *speedBackEye ;
      float ratioY = eyeBackRef.y / frameRate *speedBackEye ;
      speedX += ratioX ;
      speedY += ratioY ;
      if (eyeBackRef.x < 180 && !travellingPriority ) eye.x = eyeBackRef.x -speedX ; else eye.x  = eyeBackRef.x +speedX ;
      if (eyeBackRef.y < 180 && !travellingPriority ) eye.y = eyeBackRef.y -speedY ; else eye.y  = eyeBackRef.y +speedY ;
      // to stop the calcul
      if(eye.x < 2 || eye.x > 358 ) eye.x = 0 ;
      if(eye.y < 2 || eye.y > 358 ) eye.y = 0 ;  
      
      if(eye.x == 0  && eye.y == 0) {
        travellingPriority = false ;
        gotoCameraEye = false ;
        speedX = 0 ;
        speedY = 0 ;
      }
    }
  } 
  return eye ;
}


//MAIN VOID
PVector speedByAxes = new PVector() ;
//calculate new position to go at the new target camera
PVector distToTargetUpdated = new PVector () ;
float currentDistToTarget = 0 ;
PVector currentPosition = new PVector() ;
PVector absPosition = new PVector() ;

PVector follow(PVector origin, PVector target, float speed) {
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
    gotoCameraPosition = false ;
  }
  
  //very weird I must inverse the value to have the good result !
  target.x = -target.x ;
  target.y = -target.y ;
  target.z = -target.z ;


  //finalize the newposition of the point
  currentPosition = PVector.add(origin, absPosition) ;
  
  return currentPosition ;
}


// END CAMERA P3D
/////////////////



























// PERSPECTIVE
//////////////
void paralaxe() {
  float aspect = float(width)/float(height) ;
  float fov = 1.0 ;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, aspect, cameraZ *.02, cameraZ*100.0);
}

// use to stop perspective correction for the info display
void stopParalaxe() {
  perspective() ;
}
// END PERSPECTIVE
//////////////////












// GRID CAMERA WORLD
/////////////////////
void createGridCamera() {
  // PVector sizeGrid = new PVector(width *20, height *20, width *20) ;
  float thickness = .5 ;
  color rougeX = #D31216 ;
  color vertY = #2DA308 ;
  color jauneY = #EFB90F ;
  color bleuGrid = #596F91 ;
  PFont font = createFont("SansSerif",10) ;
  gridCamera(sizeBackgroundP3D, thickness, rougeX, vertY, jauneY, bleuGrid, font, displayInfo3D) ;

}



//repere camera
void gridCamera(PVector size, float thickness, color colorX, color colorY,color colorZ, color colorGrid, PFont font, boolean showGrid) {
  if(showGrid)  {
    PVector newSize =  PVector.mult(size,.2) ;

    int posTxt = 10 ;
    
    textFont(font, 10) ;
    //GRID
    grid(size, thickness *.1, colorGrid) ;

    //AXES
    strokeWeight(thickness *.1) ;
    // X LINE
    fill(colorX) ;
    text("X LINE XXX", posTxt,-posTxt) ;
    stroke(colorX) ; noFill() ;
    line(-newSize.x,0,0,newSize.x,0,0) ;

    // Y LINE
    fill(colorY) ;
    pushMatrix() ;
    rotateZ(radians(-90)) ;
    text("Y LINE YYY", posTxt,-posTxt) ;
    popMatrix() ;
    stroke(colorY) ; noFill() ;
    line(0,-newSize.y,0,0,newSize.y,0) ;
    
    // Z LINE
    fill(colorZ) ;
    pushMatrix() ;
    rotateY(radians(90)) ;
    text("Z LINE ZZZ", posTxt,-posTxt) ;
    popMatrix() ;
    stroke(colorZ) ; noFill() ;
    line(0,0,-newSize.z,0,0,newSize.z) ;
  }
}


void grid(PVector s, float thickness, color colorGrid) {
  strokeWeight(thickness) ;
  noFill() ;
  stroke(colorGrid) ;
  int sizeX = (int)s.z ;
  //horizontal grid
  for ( int i = -sizeX ; i<= sizeX ; i = i+10 ) {
    if(i != 0 ) line(i,0,-sizeX,i,0,sizeX) ;
  }
}
//END CAMERA GRID WORLD
///////////////////////
