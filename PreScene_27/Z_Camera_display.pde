
//travelling
boolean gotoCameraPosition, gotoCameraEye, travellingPriority ;

//speed must be 1 or less
float speedMoveOfCamera = 0.1 ;
//CAMERA Stuff
private boolean moveScene, moveEye ;

PVector targetPosCam = new PVector() ;

//P3D ROMANESCO STUFF
PVector speedDirectionOfObject  ;
// PVector  P3DpositionMouseRef = new PVector() ;


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
    initVariableCamera() ;
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
  //UPDATE
  //position
  if (!movePos)  newObjRefPos = true ;
  PVector newPos = updatePosObj(posObj[ID], ID, movePos) ;
  posObjX[ID] = newPos.x ;
  posObjY[ID] = newPos.y ;
  posObjZ[ID] = newPos.z ;
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
  addRefObj(ID) ;
}




// UPDATE POSITION & DIRECTION obj
//////////////////////////////////

// update direction obj
/////////////////////////////////////////////
PVector  P3DdirectionMouseRef = new PVector() ;

PVector updateDirObj(PVector speed, int ID, boolean authorization) {
  if(authorization) {
    if(newObjRefDir) {
      dirObjRef = tempObjDir.copy() ;
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
// end update direction obj
////////////////////////////



// update position obj
//////////////////////
PVector P3DpositionMouseRef = new PVector() ;

PVector updatePosObj(PVector pos, int ID, boolean authorization) {
  Vec3 deltaObjPos = new Vec3() ;
  // we must re-init the Z value because the behavior of the wheel is different than coordonate of the mouse who are permanent.
  P3DpositionMouseRef.z = 0 ;

  // XY pos
  if(newObjRefPos) {
    posObjRef[ID] = pos.copy() ;
    P3DpositionMouseRef.x = mouse[0].x ;
    P3DpositionMouseRef.y = mouse[0].y ;
    // special op with the wheel value, because this value is not constant
    P3DpositionMouseRef.z -= wheel[0] ;

  }
  // Z position with the wheel
  deltaObjPos.z = wheel[0] -P3DpositionMouseRef.z ;

  // X et Y pos with the mouse coordonate
  if (authorization) {
    //to create a only one ref position
    newObjRefPos = false ;
    //create the delta between the ref and the mouse position
    deltaObjPos.x = mouse[0].x -P3DpositionMouseRef.x ;
    deltaObjPos.y = mouse[0].y -P3DpositionMouseRef.y ;
  } 

  // special op with the wheel value
  deltaObjPos.z *= -1. ;
  /**
  // WORK AROUND CAMERA, to find the position of the camera when we Rotate the camera...
  // VERY HARD !!!!!
  // mag obg
  float magObj = mag(deltaObjPos) ;
  // polar info for the obj and the camera
  Vec3 polarObj = toPolar(deltaObjPos) ;
  
  // info 
  // println("real pos cam ", sceneCamera) ;
  float magCam =  height/2 ;
  Vec3 posCamCorrection = new Vec3( sceneCamera.x, sceneCamera.y, sceneCamera.z + magCam) ;

  
  // polar info for the obj and the camera
  Vec3 polarObj = toPolar(deltaObjPos) ;
  float norm360longitude = mapCycle(eyeCamera.x,0,360) ;
  float norm360latitude = mapCycle(eyeCamera.y ,0,360) ;
  // transform value 0-360 to 0-2PI
  float longitude = map(norm360longitude,0,360, 0, TAU) ;
  float latitude = map(norm360latitude, 0,360,0,TAU) ;
  // finalize calcul for the cartesian position of camera



 
  Vec3 cart_sol_1 = toCartesian(longitude, latitude, magCam) ;
  strokeWeight (10) ;
  stroke (0,0,100) ;
  int ratio = 2 ;
  point(cart_sol_1.x *ratio,cart_sol_1.y *ratio,cart_sol_1.z *ratio) ;
  // cartEye.x *= -1 ;
  
  println("cartesian classic Eye ", (int)cart_sol_1.x, 
                                    (int)cart_sol_1.y, 
                                    (int)cart_sol_1.z ) ;
                                    
                                    Vec3 cart_sol_2 = toCartesian3D ( Vec2 (mouse[0].x,mouse[0].y), Vec2(width,height), magCam) ;
  point(cart_sol_2.x,cart_sol_2.y ,cart_sol_2.z ) ;
  println("cartesian Alternative Eye ",(int)cart_sol_2.x, (int)cart_sol_2.y, (int)cart_sol_2.z) ;
  
  // *************************************
  ///////////////////////////////////
  // TRY THIS SOLUTION, same than sceneCamera ???????
  
  // if(!moveScene) sceneCamera = (follow(origin, target, speed)) ;

  
  // END WORK around the camera
  ////////////////////////////
  */

  PVector delta = deltaObjPos.copyVecToPVector() ;
  // final position
  pos = PVector.add(posObjRef[ID], delta) ;
  return pos ;
}
// end update position obj
//////////////////////////




// local method update position and direction
///////////////////////////////////////////



//go to the new position
void P3DmoveObj(int ID) {
  translate(posObjX[ID], posObjY[ID], posObjZ[ID]) ;
  rotateX(radians(dirObjX[ID])) ;
  rotateY(radians(dirObjY[ID])) ;
}


// END UPDATE POSITION & DIRECTION obj
//////////////////////////////////////










//Create ref position
void addRefObj(int ID) {
  if(modeP3D) {
    posObj[ID] = new PVector (posObjX[ID], posObjY[ID],posObjZ[ID]) ;
    dirObj[ID] = new PVector (dirObjX[ID], dirObjY[ID]);
  }
}



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






// METHOD Variable update variable camera
/////////////////////////////////////////
float dirCamX,dirCamY,dirCamZ,
      centerCamX,centerCamY,centerCamZ,
      upX,upY,upZ ;
float focal, deformation ;

Vec3 finalSceneCamera ;
Vec2 finalEyeCamera ;





// init var
void initVariableCamera() {
  variableCameraPresceneRendering() ;
}










// MOVE CAMERA
//////////////
void cameraDraw() {
  updateCamera(moveScene, moveEye, LEAPMOTION_DETECTED, cLongTouch) ;
  // set camera variable
  /* look if the user is on the Prescene or not, and other stuff to display the good views */
  setVariableCamera(cLongTouch) ;

  // deformation and focal of the lenz camera
  paralaxe(focal, deformation) ;
  
  //camera order from the mouse or from the leap
  controlCamera(cLongTouch) ;

  /*
      //void with speed setting
  float speed = 150.0 ; // 150 is medium speed rotation
  PVector speedRotation = new PVector(speed /(float)width, speed /(float)height) ; 
  */
  startCamera() ;
  
  //to change the scene position with a specific point
  if(gotoCameraPosition || gotoCameraEye ) moveCamera(sceneCamera, targetPosCam, speedMoveOfCamera) ;

  //catch ref camera
  catchCameraInfo() ;
}
//END CAMERA DRAW



















// Annexe method of the method cameraDraw()
///////////////////////////////////////////
void setVariableCamera(boolean authorization) {
  // float focal = map(valueSlider[0][19],0,360,28,200) ;

  /* this method need to be on the Prescene sketch and on the window.
  1. boolean prescene : On prescene, because on Scene we don't need to have a global view : boolean prescene
  2. boolean MOUSE_IN_OUT : because if we mode out the sketch the keyevent is not updated, and the camera stay in camera view */
  if(fullRendering || (cLongTouch && MOUSE_IN_OUT && prescene)) variableCameraFullrendering(authorization) ; else variableCameraPresceneRendering() ;
}

void variableCameraFullrendering(boolean authorization) {
      // world rendering
    focal = map(valueSlider[0][19],0,360,28,200) ;
    deformation = map(valueSlider[0][20],0,360,-1,1) ;
    // camera
    dirCamX = map(valueSlider[0][21],0,360,0,width)  ; // on controler is Eye X
    dirCamY = map(valueSlider[0][22],0,360,0,height)  ; // on controler is Eye Y
    dirCamZ = map(valueSlider[0][23],0,360,0,width)  ; // on controler is Eye Z
    
    centerCamX = map(valueSlider[0][24],0,360,0,width)  ; // on controler is Position X
    centerCamY = map(valueSlider[0][25],0,360,0,height)  ; // on controler is Position Y
    centerCamZ = map(valueSlider[0][26],0,360,0,width)  ; // on controler is Position Z

    upX = map(valueSlider[0][27],0,360,-1,1) ;
    upY = 1 ; // not interesting
    upZ = 0 ; // not interesting


    // final camera position
    if (checkMouseMove(authorization)) {
    finalSceneCamera = new Vec3 (sceneCamera.x +width/2, sceneCamera.y +height/2, sceneCamera.z) ;
  //scene position
    finalEyeCamera = new Vec2 (radians(eyeCamera.x), radians(eyeCamera.y) ) ;
  }
}


void variableCameraPresceneRendering() {
      // default setting camera from Processing.org example, like the camera above
    /*
    float dirCamX = width/2.0 ; // eye X
    float dirCamY = height/2.0 ; // eye Y
    float dirCamZ = (height/2.0) / tan(PI*30.0 / 180.0) ; // // eye Z
    float centerCamX = width/2.0 ; // Position X
    float centerCamY = height/2.0 ; // Position Y
    float centerCamZ = 0 ; // Position Z
    float upX = 0 ;
    float upY = 1 ;
    float upZ = 0 ;
    */
     // world rendering
    focal = 40 ; // 28-200
    deformation = 0 ; // -1 to 1 
    // camera
    dirCamX = width/2.0 ; // eye X
    dirCamY = height/2.0 ; // eye Y
    dirCamZ = (height/2.0) / tan(PI*30.0 / 180.0) ; // eye Z
    
    centerCamX = width/2.0 ; // Position X
    centerCamY = height/2.0 ; // Position Y
    centerCamZ = 0 ; // Position Z
    
    upX = 0 ;
    upY = 1 ;
    upZ = 0 ;
        // final camera position
    finalSceneCamera = new Vec3 (width/2, height, -width) ;
    float longitude = -45 ;
    float latitude = 0 ;
    finalEyeCamera = new Vec2 (longitude, latitude) ;

}



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



//camera order from the mouse or from the leap
void controlCamera(boolean authorazation) {
  if(authorazation) {
    if(ORDER_ONE || ORDER_THREE) moveScene = true ;   else moveScene = false ;
    if(ORDER_TWO || ORDER_THREE) moveEye = true ;   else moveEye = false ;
      
    //update z position of the camera
    sceneCamera.z -= wheel[0] ;
      
    // change camera position
    if(enterTouch) travelling(posCamRef) ;
    if (touch0) {
      changeCameraPosition(0) ;
    }
  } else if (!authorazation || (ORDER_ONE && ORDER_ONE && ORDER_THREE) ) {
    moveScene = false ;
    moveEye = false ;
  }  
}


//startCamera with speed setting
void startCamera() {
  pushMatrix() ;
  camera(dirCamX, dirCamY, dirCamZ, centerCamX, centerCamY, centerCamZ, upX, upY, upZ) ;
  beginCamera() ;
  // scene position
  translate(finalSceneCamera.x, finalSceneCamera.y, finalSceneCamera.z) ;
  // scene orientation direction
  /* eyeCamera, is not a good terminilogy because the real eye camera is not use here. Here we just move the world. */
  rotateX(finalEyeCamera.x) ;
  rotateY(finalEyeCamera.y) ;
  /**  
  // you find popMatrix() in the method stopCamera() ;
  */
}





// update the position of the scene (camera) and the orientation
void updateCamera(boolean scene, boolean eye, boolean leapMotion, boolean authorization) {
  if(authorization) {
    // update the world position

    /* We cannot use the method copy() of the PVector, because we must preserve the "Z" parameter of this PVector to move the Scene with the wheel */
    sceneCamera.x = updatePosCamera(scene, leapMotion, mouse[0]).x ;
    sceneCamera.y = updatePosCamera(scene, leapMotion, mouse[0]).y ;
    eyeCamera = updateEyeCamera(eye, mouse[0]).copy() ;
  }
}


// move camera to target
void moveCamera(PVector origin, PVector target, float speed) {
  if(!moveScene) sceneCamera = (follow(origin, target, speed)) ;
  if(!moveEye && (gotoCameraPosition || gotoCameraEye)) eyeCamera = backEye()  ;
}


// CHANGE CAMERA POSITION
void changeCameraPosition(int ID) {
  eyeCamera = eyeCameraSetting[ID].copy() ;
  sceneCamera = sceneCameraSetting[ID].copy() ;
  gotoCameraPosition = false ;
  gotoCameraEye = false ;
}


//stop
void stopCamera() {
  popMatrix() ;
  endCamera() ;
  stopParalaxe() ;
}


// check if the mouse move or not, it's use to update or not the position of the world.
// we must use that to don't update the scene when we load the save scene setting
Vec3 mouseCheckRef = Vec3() ;
int wheelCheckRef = 0 ;

boolean checkMouseMove( boolean authorization) {
  boolean mouseMove ;
  if( authorization &&    (!equals(mouseCheckRef, Vec3(mouse[0])) || wheelCheckRef != wheel[0])) mouseMove = true ; else mouseMove = false ;
  // create ref
  wheelCheckRef = wheel[0] ;
  mouseCheckRef = Vec3(mouse[0]) ;
  return mouseMove ;
}




















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


void paralaxe(float focal, float deformation) {
  // ratio deformation
  float aspect = float(width)/float(height) ;
  aspect += deformation ;
  // focal
  focal = constrain(focal, 28,200) ;
  focal = map(focal,28,200,140,5) ;
  float fov = radians(focal) ;
  // this algo is from Processing example
  float cameraZ = (height/2.0) / tan(fov/2.0);
  
  // this algo is from Processing example
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
    textAlign(LEFT, BOTTOM);
    //GRID
    grid(size, thickness *.1, colorGrid) ;

    //AXES
    strokeWeight(thickness *.1) ;
    // X LINE
    fill(colorX) ;
    pushMatrix() ;
    text("X LINE XXX", posTxt,-posTxt) ;
    popMatrix() ;
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
