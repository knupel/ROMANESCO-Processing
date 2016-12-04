/**
Here you find 
*/
/**
Camera Engine version 6.0.2
*/
/**
and
*/
/**
Camera RPE 1.1.2
*/







/**
Camera RPE 1.1.2

*/
//travelling
boolean gotoCameraPosition, gotoCameraEye, travellingPriority ;

//speed must be 1 or less
float speedMoveOfCamera = 0.1 ;
//CAMERA Stuff
private boolean moveScene, moveEye ;

Vec3 targetPosCam = Vec3() ;


/**
P3D SETUP
*/
void P3D_setup() {
    camara_setting (NUM_SETTING_CAMERA) ;
    item_manipulation () ;
    item_manipulation_setting(NUM_SETTING_ITEM) ;
    initVariableCamera() ;
    println("P3D setup done") ;
}


// ANNEXE setting object manipulation
void item_manipulation () {
  //P3D for all ROMANESCO object
  for ( int i = 0 ; i < NUM_ITEM ; i++ ) {
    posObj[i] = Vec3() ; 
    dirObj[i] = Vec3() ;
    if(dir_item_final[i] == null) dir_item_final[i] = Vec3() ;
  }
}

void item_manipulation_setting (int num_setting_item) {
  // object orientation
  for ( int i = 0 ; i < num_setting_item ; i++ ) {
    for (int j = 0 ; j < NUM_ITEM ; j++ ) {
       if(item_setting_position [i][j] == null) item_setting_position [i][j] = Vec3() ;
       if(item_setting_direction [i][j] == null) item_setting_direction [i][j] = Vec3() ;
     }
   }
}

// ANNEXE setting camera manipulation
void camara_setting (int numSettingCamera) {
  if (eyeCameraSetting != null && sceneCameraSetting != null ) {
    for ( int i = 0 ; i < numSettingCamera ; i++ ) {
       eyeCameraSetting[i] = Vec3() ;
       sceneCameraSetting[i] = Vec3() ;
    }
  }
}


/**
Start setting position and direction
*/
// direction
void setting_start_direction(int ID, Vec2 dir) {
  int which_setting = 0 ;
  setting_start_direction(ID, which_setting, (int)dir.x, (int)dir.y) ;
}

void setting_start_direction(int ID, int dir_x, int dir_y) {
  int which_setting = 0 ;
  setting_start_direction(ID, which_setting, dir_x, dir_y) ;
}

void setting_start_direction(int ID, int which_setting, int dir_x, int dir_y) {
  if(dir_item_final[ID] == null) dir_item_final[ID] = Vec3() ;
  dir_item_final[ID].set(dir_x, dir_y,0) ;
  if(item_setting_direction [0][ID] == null) item_setting_direction [which_setting][ID] = Vec3() ;
  item_setting_direction [0][ID] = Vec3(dir_item_final[ID]) ;
  if(temp_item_canvas_direction[ID] == null) temp_item_canvas_direction[ID] = Vec3() ;
  temp_item_canvas_direction[ID].x = map(item_setting_direction [which_setting][ID].y, 0, 360, 0, width) ;
  temp_item_canvas_direction[ID].y = map(item_setting_direction [which_setting][ID].x, 0, 360, 0, height) ;
}

// position
void setting_start_position(int ID, Vec3 pos) {
  int which_setting = 0 ;
  setting_start_position(ID, which_setting, (int)pos.x, (int)pos.y, (int)pos.z) ;
}

void setting_start_position(int ID, int pos_x, int pos_y, int pos_z) {
  int which_setting = 0 ;
  setting_start_position(ID, which_setting, pos_x, pos_y, pos_z) ;
}

void setting_start_position(int ID, int which_setting, int pos_x, int pos_y, int pos_z) {
  if(pos_item_final[ID] == null) pos_item_final[ID] = Vec3() ;
  pos_item_final[ID].x = pos_x -(width/2) ;
  pos_item_final[ID].y = pos_y -(height/2) ;
  pos_item_final[ID].z = pos_z ;
  if(item_setting_position [which_setting][ID] == null) item_setting_position [which_setting][ID] = Vec3() ;
  item_setting_position [which_setting][ID] = Vec3(pos_item_final[ID]) ;
  mouse[ID] = Vec3(pos_x, pos_y, pos_z) ;
}
/**
END SETUP
*/













/**
ITEM position and direction
final position and direction for the items
*/

void item_move(boolean movePos, boolean moveDir, int ID) {
  //position
  if (!movePos) {
    update_ref_position_mouse() ;
    update_ref_position(posObj[ID], ID) ;
  }
  Vec3 newPos = update_position_item(posObj[ID], ID, movePos) ;
  pos_item_final[ID].set(newPos) ;

  //direction
  if (!moveDir) {
    update_ref_direction_mouse() ;
    update_ref_direction(ID) ;
  }
  //speed rotation
  float speed = 100.0 ; // 150 is medium speed rotation
  Vec2 speedDirectionOfObject = Vec2(speed /(float)width, speed /(float)height) ;
  
  dir_item_final[ID].set(update_direction_item(speedDirectionOfObject, ID, moveDir)) ;


  //RESET
  if(touch0) {
    pos_item_final[ID].set(item_setting_position [0][ID]);
    dir_item_final[ID].set(item_setting_direction [0][ID]) ;

    temp_item_canvas_direction[ID].set(0) ;
    reset_camera_direction_item[ID] = true ;
    int which = 0 ;
    reset_direction_item(which, ID) ; 
  }
  add_ref_item(ID) ;
}



/**
Create ref position
*/
void add_ref_item(int ID) {
  posObj[ID] = Vec3(pos_item_final[ID]) ;
  dirObj[ID] = Vec3(dir_item_final[ID]);
}

/**
reset
*/
void reset_direction_item (int which_setting, int ID) {
  if(reset_camera_direction_item[ID]) {
    temp_item_canvas_direction[ID].x = map(item_setting_direction [which_setting][ID].y, 0, 360, 0, width) ;
    temp_item_canvas_direction[ID].y = map(item_setting_direction [which_setting][ID].x, 0, 360, 0, height) ;
    update_ref_direction_mouse() ;
  }
}






/**
Update direction item
*/
Vec3 direction_mouse_ref = Vec3() ;

void update_ref_direction_mouse() {
  if(direction_mouse_ref == null) direction_mouse_ref = Vec3() ;
  if(mouse[0] == null) mouse[0] = Vec3() ;

  direction_mouse_ref.x = mouse[0].x ;
  direction_mouse_ref.y = mouse[0].y ;
  // special op with the wheel value, because this value is not constant
  direction_mouse_ref.z = 0 ;
  direction_mouse_ref.z -= wheel[0] ;
}


void update_ref_direction(int ID) {
  if(dir_reference_items[ID] == null) {
    dir_reference_items[ID] = Vec3(temp_item_canvas_direction[ID]) ; 
  } else {
    dir_reference_items[ID].set(temp_item_canvas_direction[ID]) ;
  }
}


Vec3 update_direction_item(Vec2 speed, int ID, boolean authorization) {
  if(authorization) {
  //to create a only one ref position
    //create the delta between the ref and the mouse position
    Vec3 delta = Vec3() ;
    if(!reset_camera_direction_item[ID]) {
      delta = sub(mouse[0], direction_mouse_ref) ;
      temp_item_canvas_direction[ID] = add(delta, dir_reference_items[ID]) ;
      //rotation of the camera
      dirObj[ID].set(direction_canvas_to_polar(temp_item_canvas_direction[ID])) ;
    } else {
      dirObj[ID].set(direction_canvas_to_polar(temp_item_canvas_direction[ID])) ;
      reset_camera_direction_item[ID] = false ;
    }
  } 
  return dirObj[ID] ;
}




/**
Update position item
*/
Vec3 position_mouse_ref = Vec3() ;

void update_ref_position_mouse() {
  position_mouse_ref.x = mouse[0].x ;
  position_mouse_ref.y = mouse[0].y ;
  // special op with the wheel value, because this value is not constant
  position_mouse_ref.z = 0 ;
  position_mouse_ref.z -= wheel[0] ;
}

void update_ref_position(Vec3 pos, int ID) {
  posObjRef[ID].set(pos.x, pos.y, pos.z) ;
}

Vec3 update_position_item(Vec3 pos, int ID, boolean authorization) {
  Vec3 delta = Vec3() ;
  // Z position with the wheel
  delta.z = wheel[0] -position_mouse_ref.z ;
  // X et Y pos with the mouse coordonate
  if (authorization) {
    //to create a only one ref position
    //create the delta between the ref and the mouse position
    delta.x = mouse[0].x -position_mouse_ref.x ;
    delta.y = mouse[0].y -position_mouse_ref.y ;
  } 

  // special op with the wheel value
  delta.z *= -1. ;

  // PVector temp_pos = PVector.add(new PVector(posObjRef[ID].x,posObjRef[ID].y,posObjRef[ID].z), delta) ;
  pos = add(posObjRef[ID], delta) ;
  return pos ;
}


/**
nd update position item
*/




/**
FINAL POSITION
*/
void final_pos_item(int ID) {
  translate(pos_item_final[ID]) ;
  rotateX(radians(dir_item_final[ID].x)) ;
  rotateY(radians(dir_item_final[ID].y)) ;
}














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
  if(gotoCameraPosition || gotoCameraEye ) {
    moveCamera(sceneCamera, targetPosCam, speedMoveOfCamera) ;
  }

  //catch ref camera
  catchCameraInfo() ;
}
//END CAMERA DRAW


















/**
// Annexe method of the method cameraDraw()
///////////////////////////////////////////
*/
void setVariableCamera(boolean authorization) {
  // float focal = map(valueSlider[0][19],0,360,28,200) ;

  /* this method need to be on the Prescene sketch and on the window.
  1. boolean prescene : On prescene, because on Scene we don't need to have a global view : boolean prescene
  2. boolean MOUSE_IN_OUT : because if we mode out the sketch the keyevent is not updated, and the camera stay in camera view */
  if(FULL_RENDERING || (cLongTouch && (MOUSE_IN_OUT || clickLongLeft[0] || clickLongRight[0]) && prescene)) variableCameraFullrendering(authorization) ; else variableCameraPresceneRendering() ;
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

  // displacement of the scene
  int displacement_scene_x = width/2 ;
  int displacement_scene_y = height/2 ;
  int displacement_scene_z = 0 ;
  
  // Check the special move camera
  float compare_pos_scene_x = finalSceneCamera.x - sceneCamera.x ;
  float compare_pos_scene_y = finalSceneCamera.y - sceneCamera.y ;
  float compare_pos_scene_z = finalSceneCamera.z - sceneCamera.z ;
  boolean specialMoveCamera ;
  if( compare_pos_scene_x != displacement_scene_x || 
      compare_pos_scene_y != displacement_scene_y || 
      compare_pos_scene_z != displacement_scene_y ) specialMoveCamera = true ; else specialMoveCamera = false ;
  
  // final camera position
  if (checkMouseMove(authorization) || specialMoveCamera) {
    finalSceneCamera = new Vec3 (sceneCamera.x +displacement_scene_x, sceneCamera.y +displacement_scene_y, sceneCamera.z +displacement_scene_z) ;
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
Vec3 posCamRef = Vec3() ;
Vec3 eyeCamRef = Vec3() ;
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
    sceneCamera.x = update_position_camera(scene, leapMotion, mouse[0]).x ;
    sceneCamera.y = update_position_camera(scene, leapMotion, mouse[0]).y ;
    eyeCamera.set(update_direction_camera(eye, mouse[0])) ;
  }
}


// move camera to target
void moveCamera(Vec3 origin, Vec3 target, float speed) {
  if(!moveScene) sceneCamera = follow(origin, target, speed) ;
  if(!moveEye && (gotoCameraPosition || gotoCameraEye)) eyeCamera = backEye()  ;
}


// CHANGE CAMERA POSITION
void changeCameraPosition(int ID) {
  eyeCamera.set(eyeCameraSetting[ID]) ;
  sceneCamera.set(sceneCameraSetting[ID]) ;
  update_direction_camera(true, Vec3()) ;
  tempEyeCamera.set(0,0,0) ;
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
  if( authorization && (!compare(mouseCheckRef, Vec3(mouse[0])) || wheelCheckRef != wheel[0])) mouseMove = true ; else mouseMove = false ;
  // create ref
  wheelCheckRef = wheel[0] ;
  mouseCheckRef = Vec3(mouse[0]) ;
  return mouseMove ;
}




















//GET
Vec3 getEyeCamera() { return eyeCamera ; }
Vec3 getPosCamera() { return sceneCamera ; }




//INIT FOLLOW
float distFollowRef = 0 ;
Vec3 eyeBackRef = Vec3() ;
//travelling with only camera position
void travelling(Vec3 target) {
  distFollowRef = dist(target, sceneCamera) ;
  
  targetPosCam = target ; 
  eyeBackRef = getEyeCamera() ;
  absPosition = new PVector() ;
  gotoCameraPosition = true ;
  gotoCameraEye = true ;
}
//END INIT FOLLOW



float speedX  ;
float speedY  ;
    
Vec3 backEye() {
  Vec3 eye = Vec3() ;

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

Vec3 follow(Vec3 origin, Vec3 target, float speed) {
  PVector PVorigin = new PVector(origin.x, origin.y, origin.z) ;
  PVector PVtarget = new PVector(target.x, target.y, target.z) ;
  return Vec3(follow(PVorigin, PVtarget, speed)) ;
}

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



























/**
// PERSPECTIVE
//////////////
*/
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











/**
// GRID CAMERA WORLD
/////////////////////
*/
//repere camera
void createGridCamera(boolean showGrid) {
  if(showGrid)  {
    float thickness = .1 ;


    // Very weird it's necessary to pass by PVector, if we don't do that when we use camera the grid disappear
    PVector size =  PVector.mult(SIZE_BG,.2) ;
    Vec3 size_grid = Vec3(size) ;
    size_grid.mult(1,1,5) ;

    int posTxt = 10 ;
    
    textSize(10) ;
    textAlign(LEFT, BOTTOM);
    strokeWeight(thickness) ;

    grid(size_grid) ;
    axe_x(size_grid, posTxt) ;
    axe_y(size_grid, posTxt) ;
    axe_z(size_grid, posTxt) ;
  }
}

// void axe_x(PVector size, int pos) {
void axe_x(Vec3 size, int pos) {
  fill(#D31216) ;
  stroke(#D31216) ; 

  text("X LINE XXX", pos,-pos) ;

  noFill() ;
  line( -size.x,0,0,
        size.x,0,0) ;

}
// void axe_y(PVector size, int pos) {
void axe_y(Vec3 size, int pos) {
    fill(#2DA308) ;
    stroke(#2DA308) ; 

    pushMatrix() ;
    rotateZ(radians(-90)) ;
    text("Y LINE YYY", pos, -pos) ;
    popMatrix() ;

    noFill() ;
    line( 0,-size.y,0,
          0,size.y,0) ;

}
// void axe_z(PVector size, int pos) {
void axe_z(Vec3 size, int pos) {
    fill(#EFB90F) ;
    stroke(#EFB90F) ; 

    pushMatrix() ;
    rotateY(radians(90)) ;
    text("Z LINE ZZZ", pos, -pos) ;
    popMatrix() ;

    noFill() ;
    line( 0,0,-size.z,
          0,0,size.z) ;

}

// void grid(PVector size) {
void grid(Vec3 size) {
  noFill() ;
  stroke(#596F91) ;
  // int size_grid = (int)size.z ;
  int step = 50 ;
  //horizontal grid
  for ( float i = -size.z ; i <= size.z ; i = i+step ) {
    if(i != 0 ) line( i, 0, -size.z, 
                      i, 0, size.z) ;
  }
}
/**
END display camera
*/




























/**
Camera Engine version 6.0.3
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

Vec3 update_position_camera(boolean authorization, boolean leapMotionDetected, Vec3 posDevice) {
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
Vec3 update_direction_camera(boolean authorization, Vec3 pos) {
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

    // direction of the camera
    return direction_canvas_to_polar(tempEyeCamera) ;
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
Vec3 direction_canvas_to_polar(Vec3 direction_canvas) {
  float temp_dir_x = map(direction_canvas.y, 0, height, 0, 360) ;
  float temp_dir_y = map(direction_canvas.x, 0, width, 0, 360) ;
  Vec3 eyeP3D =Vec3(temp_dir_x, temp_dir_y, 0) ;
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
/**
END Camera Engine version 6.0.2

*/
