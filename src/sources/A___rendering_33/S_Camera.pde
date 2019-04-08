/**
* Camera RENDER
* 2013-2019
* v 1.4.1
*/
//travelling
boolean goto_camera_position_is;
boolean goto_camera_orientation_is;
boolean travelling_priority_is;

//speed must be 1 or less
float speed_follow_camera_romanesco;

//CAMERA Stuff
boolean move_position_camera_is;
boolean move_orientation_camera_is;

vec3 target_pos_camera = vec3();

// motion effect on camera
Motion motion_translate;
Motion motion_rotate;

//float ratio_speed_camera_inertia_rotate = 3;
float acc_camera_rope = .01;
float dec_camera_rope = .01;

float ref_speed_follow_cam;
float ref_cam_deceleration;
float ref_cam_ratio_rotate;
float ref_cam_ratio_translate;


// Camera SETUP
void camera_setup() {
  float speed_cam_follow = ref_speed_follow_cam = .01;
  float dec = ref_cam_deceleration = .1;
  float ratio_rotate = ref_cam_ratio_rotate = 10;
  float ratio_translate = ref_cam_ratio_translate = 3;
  camera_setting(NUM_SETTING_CAMERA,speed_cam_follow,dec,ratio_rotate,ratio_translate);
  item_manipulation();
  item_manipulation_setting(NUM_SETTING_ITEM);
  final_camera_low_rendering();
  println("camera setup done");
}


// ANNEXE setting object manipulation
void item_manipulation () {
  for ( int i = 0 ; i < NUM_ITEM_PLUS_MASTER ; i++ ) {
    pos_item[i] = vec3() ; 
    dir_item[i] = vec3() ;
    if(dir_item_final[i] == null) dir_item_final[i] = vec3() ;
  }
}

void item_manipulation_setting (int num_setting_item) {
  for(int i = 0 ; i < num_setting_item ; i++) {
    for(int j = 0 ; j < NUM_ITEM_PLUS_MASTER ; j++) {
      if(item_setting_position [i][j] == null) {
        item_setting_position [i][j] = vec3();
      }
      if(item_setting_direction [i][j] == null) {
        item_setting_direction [i][j] = vec3();
      }
    }
  }
}

// ANNEXE setting camera manipulation
void camera_setting(int num, float speed_follow, float deceleration, float inertia_rotate, float inertia_translate) {
  if (eye_cameraSetting != null && scene_cameraSetting != null ) {
    for ( int i = 0 ; i < num ; i++ ) {
       eye_cameraSetting[i] = vec3() ;
       scene_cameraSetting[i] = vec3() ;
    }
  }

  speed_follow_camera_romanesco = width / 1000 * speed_follow;

  float max_speed_inertia_rotate = width / 1000 * inertia_rotate;
  motion_rotate = new Motion(max_speed_inertia_rotate);
  motion_rotate.set_deceleration(deceleration);

  float max_speed_inertia_translate = width / 1000 * inertia_translate;
  motion_translate = new Motion(max_speed_inertia_translate);
  motion_translate.set_deceleration(deceleration);

  
  
}



/**
Item
Start setting position and direction 
v 0.0.1
*/
// direction
void setting_start_direction(int ID, vec2 dir) {
  int which_setting = 0 ;
  setting_start_direction(ID, which_setting, (int)dir.x, (int)dir.y) ;
}

void setting_start_direction(int ID, int dir_x, int dir_y) {
  int which_setting = 0 ;
  setting_start_direction(ID, which_setting, dir_x, dir_y) ;
}

void setting_start_direction(int ID, int which_setting, int dir_x, int dir_y) {
  if(dir_item_final[ID] == null) dir_item_final[ID] = vec3();
  dir_item_final[ID].set(dir_x,dir_y,0);
  if(item_setting_direction [0][ID] == null) item_setting_direction [which_setting][ID] = vec3();
  item_setting_direction [0][ID] = vec3(dir_item_final[ID]);
  if(temp_item_canvas_direction[ID] == null) temp_item_canvas_direction[ID] = vec3();
  temp_item_canvas_direction[ID].x = map(item_setting_direction [which_setting][ID].y,0,360,0,width);
  temp_item_canvas_direction[ID].y = map(item_setting_direction [which_setting][ID].x,0,360,0,height);
}

// position
void setting_start_position(int ID, vec3 pos) {
  int which_setting = 0 ;
  setting_start_position(ID, which_setting, (int)pos.x, (int)pos.y, (int)pos.z) ;
}

void setting_start_position(int ID, int pos_x, int pos_y, int pos_z) {
  int which_setting = 0 ;
  setting_start_position(ID, which_setting, pos_x, pos_y, pos_z) ;
}

void setting_start_position(int ID, int which_setting, int pos_x, int pos_y, int pos_z) {
  if(pos_item_final[ID] == null) pos_item_final[ID] = vec3() ;
  pos_item_final[ID].x = pos_x -(width/2) ;
  pos_item_final[ID].y = pos_y -(height/2) ;
  pos_item_final[ID].z = pos_z ;
  if(item_setting_position [which_setting][ID] == null) item_setting_position [which_setting][ID] = vec3() ;
  item_setting_position [which_setting][ID] = vec3(pos_item_final[ID]) ;
  mouse[ID] = vec3(pos_x, pos_y, pos_z) ;
}



















/**
GET
*/
vec3 get_pos_item(int id_item) {
  vec3 pos = pos_item_final[id_item].copy() ;
  return pos.add(width/2, height/2,0) ;
}

vec3 get_dir_item(int id_item) {
  return dir_item_final[id_item] ;
}



















/**
* ITEM CAMERA
* v 1.0.1
* final position and direction for the items
* Master and follower updating
*/
void item_move(boolean move_pos_is, boolean move_orientation_is, int ID) {
  //position
  if (!move_pos_is) {
    update_ref_position_mouse() ;
    update_ref_position(pos_item[ID], ID) ;
  }
  vec3 newPos = update_position_item(pos_item[ID], ID, move_pos_is) ;
  pos_item_final[ID].set(newPos) ;

  //direction
  if (!move_orientation_is) {
    update_ref_direction_mouse() ;
    update_ref_direction(ID) ;
  }
  //speed rotation
  float speed = width / 10 ; // 150 is medium speed rotation
  vec2 speed_direction_item = vec2(speed /(float)width, speed /(float)height) ;
  
  dir_item_final[ID].set(update_direction_item(speed_direction_item, ID, move_orientation_is)) ;

  //RESET
  if(key_0 || reset_item_on_button_alert_is()) {
    pos_item_final[ID].set(item_setting_position [0][ID]);
    dir_item_final[ID].set(item_setting_direction [0][ID]) ;
    
    temp_item_canvas_direction[ID].set(0) ;
    reset_camera_direction_item[ID] = true ;
    int which = 0 ;
    reset_direction_item(which, ID) ; 
  }
  add_ref_item(ID) ;
}



void item_follower(Romanesco item) {
  if(follower[item.get_id()]) {
    int ID_master = master_ID[item.get_id()];
    Romanesco item_master = rom_manager.get(ID_master);
    item.action_is(item_master.action_is()); 
  }
  add_ref_item(item.get_id()) ;
}

// Create ref position
void add_ref_item(int ID) {
  pos_item[ID] = vec3(pos_item_final[ID]) ;
  dir_item[ID] = vec3(dir_item_final[ID]);
}

// reset
void reset_direction_item (int which_setting, int ID) {
  if(reset_camera_direction_item[ID]) {
    if(item_setting_direction[which_setting][ID] == null) {
      item_setting_direction[which_setting][ID] = vec3() ;
    }
    temp_item_canvas_direction[ID].x = map(item_setting_direction [which_setting][ID].y, 0, 360, 0, width) ;

    temp_item_canvas_direction[ID].y = map(item_setting_direction [which_setting][ID].x, 0, 360, 0, height) ;
    update_ref_direction_mouse() ;
  }
}






// Update direction item
vec3 direction_mouse_ref;
void update_ref_direction_mouse() {
  if(direction_mouse_ref == null) direction_mouse_ref = vec3() ;
  if(mouse[0] == null) mouse[0] = vec3() ;

  direction_mouse_ref.x = mouse[0].x ;
  direction_mouse_ref.y = mouse[0].y ;
  // special op with the wheel value, because this value is not constant
  direction_mouse_ref.z = 0 ;
  direction_mouse_ref.z -= wheel[0] ;
}


void update_ref_direction(int ID) {
  if(dir_item_ref[ID] == null) {
    dir_item_ref[ID] = vec3(temp_item_canvas_direction[ID]) ; 
  } else {
    dir_item_ref[ID].set(temp_item_canvas_direction[ID]) ;
  }
}


vec3 update_direction_item(vec2 speed, int ID, boolean authorization) {
  if(authorization) {
    //to create a only one ref position
    //create the delta between the ref and the mouse position
    vec3 delta = vec3() ;
    if(!reset_camera_direction_item[ID]) {
      delta = sub(mouse[0], direction_mouse_ref) ;
      temp_item_canvas_direction[ID] = add(delta, dir_item_ref[ID]) ;
      //rotation of the camera
      dir_item[ID].set(direction_canvas_to_polar(temp_item_canvas_direction[ID])) ;
    } else {
      dir_item[ID].set(direction_canvas_to_polar(temp_item_canvas_direction[ID])) ;
      reset_camera_direction_item[ID] = false ;
    }
  } 
  return dir_item[ID] ;
}




// Update position item
vec3 position_mouse_ref = vec3() ;

void update_ref_position_mouse() {
  position_mouse_ref.x = mouse[0].x;
  position_mouse_ref.y = mouse[0].y;
  // special op with the wheel value, because this value is not constant
  position_mouse_ref.z = 0;
  position_mouse_ref.z -= wheel[0];
}

void update_ref_position(vec3 pos, int ID) {
  pos_item_ref[ID].set(pos.x, pos.y, pos.z) ;
}

vec3 update_position_item(vec3 pos, int ID, boolean authorization) {
  vec3 delta = vec3() ;
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

  pos = add(pos_item_ref[ID], delta) ;
  return pos ;
}





// FINAL POSITION
void final_pos_item(Romanesco item) {
  int id = item.get_id();
  translate(pos_item_final[id]);
  rotateX(radians(dir_item_final[id].x));
  rotateY(radians(dir_item_final[id].y));
}

































































/**
* MOVE CAMERA GLOBAL 
* v 1.2.1
*/
vec2 final_orientation_render_camera;
float orientation_camera_x;
float orientation_camera_y;
float orientation_camera_z;

vec3 final_position_render_camera;
float position_camera_x;
float position_camera_y;
float position_camera_z;

float up_camera_x;
float up_camera_y;
float up_camera_z;

float focal;
float deformation;

boolean reset_camera_romanesco ;

/**
Main method camera draw
*/
void camera_romanesco_draw() {
  set_var_camera_romanesco();
  update_camera_romanesco(LEAPMOTION_DETECTED) ;

  // deformation and focal of the lenz camera
  paralaxe(focal,deformation);
  
  //camera order from the mouse or from the leap
  order_camera();

  start_camera();
  
  //to change the scene position with a specific point
  if(goto_camera_position_is || goto_camera_orientation_is ) {
    move_camera(scene_camera, target_pos_camera, speed_follow_camera_romanesco) ;
  }

  //catch ref camera
  catch_camera_info();
}






void set_var_camera_romanesco() { 
  /* 
  this method need to be on the Prescene sketch and on the window.
  1. boolean prescene : On prescene, because on Scene we don't need to have a global view : boolean prescene
  2. boolean MOUSE_IN_OUT : because if we mode out the sketch the keyevent is not updated, and the camera stay in camera view 
  */
  if(FULL_RENDERING || (camera_global_is() && (MOUSE_IN_OUT || clickLongLeft[0] || clickLongRight[0]) && prescene)) {
    final_camera_full_rendering(); 
  } else {
    final_camera_low_rendering();
  }
}


void final_camera_full_rendering() {
  // world rendering
  focal = map(value_slider_camera[0],0,360,28,200);
  deformation = map(value_slider_camera[1],0,360,-1,1);
  // camera
  orientation_camera_x = map(value_slider_camera[2],0,360,0,width); // on controler is Eye X
  orientation_camera_y = map(value_slider_camera[3],0,360,0,height); // on controler is Eye Y
  // orientation_camera_z = map(value_slider_camera[4],0,360,0,width)  ; // on controler is Eye Z
  
  position_camera_x = map(value_slider_camera[4],0,360,0,width); // on controler is Position X
  position_camera_y = map(180,0,360,0,height); // on controler is Position Y
  // position_camera_z = map(value_slider_camera[7],0,360,0,width)  ; // on controler is Position Z

  up_camera_x = map(value_slider_camera[5],0,360,-1,1);
  up_camera_y = 1 ; // not interesting
  up_camera_z = 0 ; // not interesting

  // displacement of the scene
  vec3 displacement_scene = vec3(width/2, height/2, 0);
  
  // Check the special move camera
  vec3 compare_pos_scene = sub(final_position_render_camera, scene_camera);

  // intertia camera
  float speed_follow_cam = .01;
  float deceleration = map(value_slider_camera[7],0,360,.0001,.02);
  float ratio_rotate = map(value_slider_camera[8],0,360,0,10);
  float ratio_translate = map(value_slider_camera[9],0,360,0,10);


  if(ref_speed_follow_cam != speed_follow_cam || ref_cam_deceleration != deceleration || ref_cam_ratio_rotate != ratio_rotate || ref_cam_ratio_translate != ratio_translate) {
    camera_setting(NUM_SETTING_CAMERA,speed_follow_cam,deceleration,ratio_rotate,ratio_translate);
    ref_speed_follow_cam = speed_follow_cam;
    ref_cam_deceleration = deceleration;
    ref_cam_ratio_rotate = ratio_rotate;
    ref_cam_ratio_translate = ratio_translate;
  }

  boolean move_camera_is = false ; ;
  // displacement scene
  if(!compare_pos_scene.equals(displacement_scene)) {
    move_camera_is = true ; 
  } 
  // inertia
  if(motion_translate.velocity_is() || motion_rotate.velocity_is()) {
    move_camera_is = true ; 
  }

  if(reset_camera_romanesco) {
    move_camera_is = true ; 
    reset_camera_romanesco = false ;
  }
  

  // final camera position
  if (check_cursor_rotate(camera_global_is()) || move_camera_is) { 
    // eye
    if(final_orientation_render_camera == null) {
      final_orientation_render_camera = vec2(radians(eye_camera.x),radians(eye_camera.y) ) ;
    } else {
      final_orientation_render_camera.set(radians(eye_camera.x),radians(eye_camera.y) ) ;
    }
    // translate scene
    if(final_position_render_camera == null) {
      final_position_render_camera = vec3(add(scene_camera, displacement_scene)) ;
    } else {
      final_position_render_camera.set(add(scene_camera, displacement_scene)) ;
    } 
  }
}


void final_camera_low_rendering() {
  // default setting camera from Processing.org example, like the camera above
  /*
  float orientation_camera_x = width/2.0 ; // eye X
  float orientation_camera_y = height/2.0 ; // eye Y
  float orientation_camera_z = (height/2.0) / tan(PI*30.0 / 180.0) ; // // eye Z
  float position_camera_x = width/2.0 ; // Position X
  float position_camera_y = height/2.0 ; // Position Y
  float position_camera_z = 0 ; // Position Z
  float up_camera_x = 0 ;
  float up_camera_y = 1 ;
  float up_camera_z = 0 ;
  */
   // world rendering
  focal = 40; // 28-200
  deformation = 0; // -1 to 1 
  // camera
  orientation_camera_x = width/2.0; // eye X
  orientation_camera_y = height/2.0; // eye Y
  orientation_camera_z = (height/2.0) / tan(PI*30.0 /180.0); // eye Z
  
  position_camera_x = width/2.0 ; // Position X
  position_camera_y = height/2.0 ; // Position Y
  position_camera_z = 0 ; // Position Z
  
  up_camera_x = 0;
  up_camera_y = 1;
  up_camera_z = 0;
  // final camera position
  final_position_render_camera = new vec3 (width/2,height,-width);
  float longitude = -45;
  float latitude = 0;
  final_orientation_render_camera = new vec2(longitude,latitude);
}



//CATCH a ref position and direction of the camera
vec3 posCamRef = vec3();
vec3 eyeCamRef = vec3();
//boolean security to catch the reference camera when you reset the position of this one
boolean catchCam = true ;
void catch_camera_info() {
  if(catchCam) {
    posCamRef = get_pos_camera();
    eyeCamRef = get_eye_camera();
  }
  catchCam = false;
}




//camera order from the mouse or from the leap
void order_camera() {
  boolean authorization = camera_global_is();
  if(authorization || reset_camera_button_alert_is()) {
    if(ORDER_ONE || ORDER_THREE) {
      move_position_camera_is = true; 
    } else {
      move_position_camera_is = false;
    } 
    if(ORDER_TWO || ORDER_THREE) {
      move_orientation_camera_is = true; 
    } else {
      move_orientation_camera_is = false;
    }
      
    //update z position of the camera
    scene_camera.z -= wheel[0];
      
    // change camera position
    if (key_enter) {
      travelling(posCamRef);
    }

    if (key_0 || reset_camera_button_alert_is()) {
      reset_camera(0);
    }
  } else if (!authorization || (ORDER_ONE && ORDER_ONE && ORDER_THREE)) {
    move_position_camera_is = false;
    move_orientation_camera_is = false;
  }  
}


//start camera with speed setting
boolean switch_rotate_YZ;
void start_camera() {
  pushMatrix();
  camera(orientation_camera_x, orientation_camera_y, orientation_camera_z, position_camera_x, position_camera_y, position_camera_z, up_camera_x, up_camera_y, up_camera_z);
  beginCamera();
  // scene position
  translate(final_position_render_camera);
  // scene orientation direction
  /* 
  eye_camera, is not a good terminilogy 
  because the real eye camera is not use here. Here we just move the world. 
  */
  rotateX(final_orientation_render_camera.x);
  if(key_b) {
    if(switch_rotate_YZ) {
      switch_rotate_YZ = false; 
    } else {
      switch_rotate_YZ = true;
    }
  }

  if(switch_rotate_YZ) {
    rotateY(final_orientation_render_camera.y);
    rotateZ(0) ;
  } else {
    rotateY(0) ;
    rotateZ(final_orientation_render_camera.y);
  }
}

//stop
void stop_camera() {
  popMatrix();
  endCamera();
  stop_paralaxe();
}





// update the position of the scene (camera) and the orientation
vec3 cursor_final_translate;
vec3 cursor_final_rotate;
vec3 mouse_ref_inertia_translate;
vec3 mouse_ref_inertia_rotate;

int wheelCheckRef = 0;

boolean reset_inertia = true;
boolean cursor_move_scene_is = false;
boolean cursor_move_eye_is = false;

void update_camera_romanesco(boolean leapMotion) {
  if(cursor_final_translate == null) {
    cursor_final_translate = mouse[0].copy();
  } 

  if(cursor_final_rotate == null) {
    cursor_final_rotate = mouse[0].copy();
  } 

  if(mouse_ref_inertia_translate == null) {
    mouse_ref_inertia_translate = mouse[0].copy();
  } 

  if(mouse_ref_inertia_rotate == null) {
    mouse_ref_inertia_translate = mouse[0].copy();
  } 

  // make ref
  if(camera_global_is) {
    // position
    if(move_position_camera_is) {
      // ok when it's a direct render
      // bug in LIVE for the case where the mouse go outside og preview window
      // the reset shorcut via prescene work only when the iniertia is not finish
      // STOP the inertia when the mouse is not clicked and restart when the mouse is out of the preview window...
      if(mouse_ref_inertia_translate == null) {
        mouse_ref_inertia_translate = mouse[0].copy(); 
      } else {
        mouse_ref_inertia_translate.set(mouse[0]); 
      }
    }
    
    // orienttion
    if (move_orientation_camera_is) {
      if(mouse_ref_inertia_rotate == null) {
        mouse_ref_inertia_rotate = mouse[0].copy(); 
      } else {
        mouse_ref_inertia_rotate.set(mouse[0]); 
      }
    }
  } 


  
  // create new pos
  if(camera_global_is) { 
    // scene / translate

    if(move_position_camera_is || motion_translate.velocity_is()) {
      cursor_final_translate.set(update_cursor(motion_translate, mouse_ref_inertia_translate, cursor_final_translate));
      cursor_move_scene_is = true;
    } else {
      cursor_move_scene_is = false;
    }

    // eye / rotate
    if(move_orientation_camera_is || motion_rotate.velocity_is()) {
      cursor_final_rotate.set(update_cursor(motion_rotate, mouse_ref_inertia_rotate, cursor_final_rotate));
      cursor_move_eye_is = true;
    } else {
      cursor_move_eye_is = false;
    }
  } else {
    if(motion_translate.velocity_is()) {
      cursor_final_translate.set(update_cursor(motion_translate, mouse_ref_inertia_translate, cursor_final_translate));
    }

    // eye / rotate
    if(motion_rotate.velocity_is()) {
      cursor_final_rotate.set(update_cursor(motion_rotate, mouse_ref_inertia_rotate, cursor_final_rotate));
    } 
  }
  
  //update pos
  update_position_camera(cursor_move_scene_is, leapMotion, cursor_final_translate);
  update_direction_camera(cursor_move_eye_is, cursor_final_rotate);
 

  // reset inertia
  if(reset_inertia) {
    motion_translate.reset();
    motion_rotate.reset();
    reset_inertia = false;
  } 

  if(key_space_long) {
    reset_inertia = true;   
  } 
}

vec3 update_cursor(Motion motion, vec3 ref, vec3 cursor_final) {
  return motion.leading(ref, cursor_final);
}

/**
check camera
*/
// check if the mouse move or not, it's use to update or not the position of the world.
// we must use that to don't update the scene when we load the save scene setting

// translate
vec3 mouse_camera_translate_ref;
boolean check_cursor_translate(boolean authorization) {
  boolean cursor_move_is;
  if(authorization && (!compare(mouse_camera_translate_ref, cursor_final_translate) || wheelCheckRef != wheel[0])) {
    cursor_move_is = true; 
  } else {
    cursor_move_is = false;
  }

  // create ref
  wheelCheckRef = wheel[0];
  if(mouse_camera_translate_ref == null) {
    mouse_camera_translate_ref = cursor_final_translate.copy();
  } else {
    mouse_camera_translate_ref.set(cursor_final_translate);
  }
  return cursor_move_is;
}

// rotate
vec3 mouse_camera_rotate_ref  ;
boolean check_cursor_rotate(boolean authorization) {
  boolean cursor_move_is ;
  if(authorization && (!compare(mouse_camera_rotate_ref, cursor_final_rotate) || wheelCheckRef != wheel[0])) {
    cursor_move_is = true; 
  } else {
    cursor_move_is = false;
  }

  // create ref
  wheelCheckRef = wheel[0];
  if(cursor_final_rotate == null) {
    cursor_final_rotate = vec3();
  }

  if(mouse_camera_rotate_ref == null) {
    mouse_camera_rotate_ref = cursor_final_rotate.copy();
  } else {
    mouse_camera_rotate_ref.set(cursor_final_rotate);
  }
  return cursor_move_is;
}





// move camera to target
void move_camera(vec3 origin, vec3 target, float speed_follow) {
  if(!move_position_camera_is) {
    scene_camera.set(follow(origin,target,speed_follow));
  }
  if(!move_orientation_camera_is && (goto_camera_position_is || goto_camera_orientation_is)) {
    eye_camera.set(back_eye());
  }
}


// CHANGE CAMERA POSITION
void reset_camera(int ID) {
  reset_camera_romanesco = true;

  eye_camera.set(eye_cameraSetting[ID]);
  scene_camera.set(scene_cameraSetting[ID]);

  temp_eye_camera.set(0);
  goto_camera_position_is = false;
  goto_camera_orientation_is = false;

  motion_translate.reset();
  motion_rotate.reset();

  cursor_final_translate.set(mouse[0]);
  cursor_final_rotate.set(mouse[0]);
  mouse_ref_inertia_translate.set(mouse[0]);

  update_direction_camera(!reset_camera_romanesco,eye_camera);
  update_position_camera(!reset_camera_romanesco,false,scene_camera);
}













//GET
vec3 get_eye_camera() { 
  return eye_camera; 
}

vec3 get_pos_camera() { 
  return scene_camera; 
}




//INIT FOLLOW
float dist_follow_cam_ref = 0;
vec3 eye_back_ref;
//travelling with only camera position
void travelling(vec3 target) {
  dist_follow_cam_ref = dist(target, scene_camera);
  
  target_pos_camera = target;
  if(eye_back_ref == null) {
    eye_back_ref = get_eye_camera().copy();
  } else {
    eye_back_ref.set(get_eye_camera());
  }
  
  if(abs_position == null) {
    abs_position = vec3();
  } else {
    abs_position.set(0);
  }
  goto_camera_position_is = true;
  goto_camera_orientation_is = true;
}
//END INIT FOLLOW



float speed_eye_x;
float speed_eye_y;
vec3 back_eye() {
  vec3 eye = vec3();

  if(goto_camera_orientation_is) {
    if(current_dist_to_target > 2 ) {
      travelling_priority_is = true ;
      if (eye_back_ref.x < 180) {
        eye.x = map(current_dist_to_target,dist_follow_cam_ref,0,eye_back_ref.x,0); 
      } else {
        eye.x = map(current_dist_to_target,dist_follow_cam_ref,0,eye_back_ref.x,360);
      }
      if (eye_back_ref.y < 180) {
        eye.y = map(current_dist_to_target,dist_follow_cam_ref,0,eye_back_ref.y,0); 
      } else {
        eye.y = map(current_dist_to_target,dist_follow_cam_ref,0,eye_back_ref.y,360);
      }
      //stop the calcul
      if(eye.x < 2 || eye.x > 358 ) eye.x = 0;
      if(eye.y < 2 || eye.y > 358 ) eye.y = 0; 
      if(eye.x == 0  && eye.y == 0) {
        goto_camera_orientation_is = false ;
        travelling_priority_is = false ;
      }
    } else {
      //speed of the eye to return to original position
      // float speed_back_eye = 3.;
      float speed_back_eye = .2;
      float ratio_x = eye_back_ref.x / frameRate *speed_back_eye;
      float ratio_y = eye_back_ref.y / frameRate *speed_back_eye;
      speed_eye_x += ratio_x;
      speed_eye_y += ratio_y;
      if (eye_back_ref.x < 180 && !travelling_priority_is ) {
        eye.x = eye_back_ref.x -speed_eye_x; 
      } else {
        eye.x = eye_back_ref.x +speed_eye_x;
      }
      if (eye_back_ref.y < 180 && !travelling_priority_is ) {
        eye.y = eye_back_ref.y -speed_eye_y; 
      } else {
        eye.y = eye_back_ref.y +speed_eye_y;
      }
      // to stop the calcul
      if(eye.x < 2 || eye.x > 358 ) eye.x = 0;
      if(eye.y < 2 || eye.y > 358 ) eye.y = 0;  
      
      if(eye.x == 0  && eye.y == 0) {
        travelling_priority_is = false;
        goto_camera_orientation_is = false;
        speed_eye_x = 0;
        speed_eye_y = 0;
      }
    }
  } 
  return eye;
}


//MAIN VOID
vec3 speed_by_axes;
//calculate new position to go at the new target camera
vec3 dist_to_target_updated;
float current_dist_to_target = 0 ;
vec3 current_pos_camera;
vec3 abs_position;
/*
vec3 follow(vec3 origin, vec3 target, float speed) {
  vec3 PVorigin = new PVector(origin.x, origin.y, origin.z) ;
  vec3 PVtarget = new PVector(target.x, target.y, target.z) ;
  return vec3(follow(PVorigin, PVtarget, speed)) ;
}
*/

vec3 follow(vec3 origin, vec3 target, float speed) {
  //very weird I must inverse the value to have the good result !
  //and change again at the end of the algorithm
  target.x = -target.x ;
  target.y = -target.y ;
  target.z = -target.z ;
  
  //updated the distance in realtime
  if(dist_to_target_updated == null) {
    dist_to_target_updated = sub(current_pos_camera,target).copy();
  } else {
    dist_to_target_updated.set(sub(current_pos_camera,target));
  }

  current_dist_to_target = dist(current_pos_camera,target);

  
  //calculate the speed to go to target
  vec3 abs_dist_value = vec3(abs(dist_to_target_updated.x),abs(dist_to_target_updated.y),abs(dist_to_target_updated.z));
  abs_dist_value.normalize() ;
  //speed_by_axes = PVector.div(abs_dist_value, 1.0 / speed) ; 
  if(speed_by_axes == null) {
    speed_by_axes = mult(abs_dist_value, speed);
  } else {
    speed_by_axes.set(mult(abs_dist_value, speed));
  }



  vec3 range_to_stop = vec3(5); 
  //calculate the new absolute position
  // XYZ
  if ( (dist_to_target_updated.x > range_to_stop.x || dist_to_target_updated.x < -range_to_stop.x) && 
       (dist_to_target_updated.y > range_to_stop.y || dist_to_target_updated.y < -range_to_stop.y) && 
       (dist_to_target_updated.y > range_to_stop.z || dist_to_target_updated.y < -range_to_stop.z))  {
    if (origin.x < target.x )  abs_position.x += speed_by_axes.x ;  else abs_position.x -= speed_by_axes.x ;
    if (origin.y < target.y )  abs_position.y += speed_by_axes.y ;  else abs_position.y -= speed_by_axes.y ;
    if (origin.z < target.z )  abs_position.z += speed_by_axes.z ;  else abs_position.z -= speed_by_axes.z ;
  // XY  
  } else if ( (dist_to_target_updated.x > range_to_stop.x || dist_to_target_updated.x < -range_to_stop.x) && 
              (dist_to_target_updated.y > range_to_stop.y || dist_to_target_updated.y < -range_to_stop.y)) {
    if (origin.x < target.x )  abs_position.x += speed_by_axes.x ;  else abs_position.x -= speed_by_axes.x ;
    if (origin.y < target.y )  abs_position.y += speed_by_axes.y ;  else abs_position.y -= speed_by_axes.y ;
    abs_position.z += 0 ;
  // XZ
  } else if ( (dist_to_target_updated.x > range_to_stop.x || dist_to_target_updated.x < -range_to_stop.x) && 
              (dist_to_target_updated.y > range_to_stop.z || dist_to_target_updated.y < -range_to_stop.z))  {
    if (origin.x < target.x )  abs_position.x += speed_by_axes.x ;  else abs_position.x -= speed_by_axes.x ;
    abs_position.y += 0 ;
    if (origin.z < target.z )  abs_position.z += speed_by_axes.z ;  else abs_position.z -= speed_by_axes.z ;
  // YZ
  } else if ( (dist_to_target_updated.y > range_to_stop.y || dist_to_target_updated.y < -range_to_stop.y) && 
              (dist_to_target_updated.y > range_to_stop.z || dist_to_target_updated.y < -range_to_stop.z))  {
    abs_position.x += 0 ;
    if (origin.y < target.y )  abs_position.y += speed_by_axes.y ;  else abs_position.y -= speed_by_axes.y ;
    if (origin.z < target.z )  abs_position.z += speed_by_axes.z ;  else abs_position.z -= speed_by_axes.z ;
  // X
  } else if ( (dist_to_target_updated.x > range_to_stop.x || dist_to_target_updated.x < -range_to_stop.x)) {
    if (origin.x < target.x )  abs_position.x += speed_by_axes.x ;  else abs_position.x -= speed_by_axes.x;
    abs_position.y += 0;
    abs_position.z += 0;
  // Y  
  } else if ( (dist_to_target_updated.y > range_to_stop.y || dist_to_target_updated.y < -range_to_stop.y))  {
    abs_position.x += 0;
    if (origin.y < target.y )  abs_position.y += speed_by_axes.y ;  else abs_position.y -= speed_by_axes.y;
    abs_position.z += 0;
  // Z
  } else if ( (dist_to_target_updated.y > range_to_stop.z || dist_to_target_updated.y < -range_to_stop.z))  {
    abs_position.x += 0;
    abs_position.y += 0;
    if (origin.z < target.z )  abs_position.z += speed_by_axes.z ;  else abs_position.z -= speed_by_axes.z;
  // IT'S DONE, NOTHING TO DO NOW
  } else {  
    abs_position.x += 0;
    abs_position.y += 0;
    abs_position.z += 0;
    goto_camera_position_is = false;
  }
  
  //very weird I must inverse the value to have the good result !
  target.x = -target.x;
  target.y = -target.y;
  target.z = -target.z;

  //finalize the newposition of the point
  current_pos_camera.set(add(origin,abs_position));
  
  return current_pos_camera ;
}

































/**
PERSPECTIVE
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
void stop_paralaxe() {
  perspective();
}

























/**
GRID 
v 0.0.2
*/
void grid_romanesco(boolean showGrid) {
  if(showGrid)  {
    float thickness = .1;
    // Very weird it's necessary to pass by PVector, if we don't do that when we use camera the grid disappear
    vec3 size_background = vec3(width *100, height *100, height *7.5) ;
    vec3 size_grid = mult(size_background,vec3(.2,.2,1));

    int posTxt = 10 ;
    
    textSize(10) ;
    textAlign(LEFT, BOTTOM);
    strokeWeight(thickness);

    grid(size_grid) ;
    axe_x(size_grid, posTxt) ;
    axe_y(size_grid, posTxt) ;
    axe_z(size_grid, posTxt) ;
  }
}

// void axe_x(PVector size, int pos) {
void axe_x(vec3 size, int pos) {
  fill(#D31216) ;
  stroke(#D31216) ; 

  text("X LINE XXX", pos,-pos) ;

  noFill() ;
  line( -size.x,0,0,
        size.x,0,0) ;

}
// void axe_y(PVector size, int pos) {
void axe_y(vec3 size, int pos) {
    fill(#2DA308);
    stroke(#2DA308); 

    pushMatrix();
    rotateZ(radians(-90)) ;
    text("Y LINE YYY", pos,-pos);
    popMatrix();

    noFill();
    line(0,-size.y,0, 0,size.y,0);

}
// void axe_z(PVector size, int pos) {
void axe_z(vec3 size, int pos) {
    fill(#EFB90F);
    stroke(#EFB90F); 

    pushMatrix() ;
    rotateY(radians(90));
    text("Z LINE ZZZ", pos, -pos) ;
    popMatrix();

    noFill() ;
    line( 0,0,-size.z, 0,0,size.z);

}

// void grid(PVector size) {
void grid(vec3 size) {
  noFill() ;
  stroke(#596F91);
  // int size_grid = (int)size.z ;
  int step = 50;
  //horizontal grid
  for ( float i = -size.z ; i <= size.z ; i = i+step ) {
    if(i != 0 ) line( i, 0, -size.z, 
                      i, 0, size.z) ;
  }
}





























/**
* Camera Engine version 
* v 6.0.3
* 2014-2019
*/

// Update Camera position
private vec3 pos_scene_mouse_ref = vec3();
private boolean new_ref_scene_mouse = true;
private vec3 pos_scene_camera_ref= vec3();
private vec3 scene_camera = vec3();
private vec3 delta_scene_pos = vec3();
void update_position_camera(boolean authorization, boolean leapMotionDetected, vec3 pos_cursor) {
  if(authorization) {
    //create the ref to calcul the new position of the Scene
    if(new_ref_scene_mouse) {
      pos_scene_camera_ref.set(scene_camera);
      pos_scene_mouse_ref.set(pos_cursor);
      //to create a only one ref position
      new_ref_scene_mouse = false;
    }

    //create the delta between the ref and the mouse position
    delta_scene_pos = sub(pos_cursor, pos_scene_mouse_ref);
    if (leapMotionDetected) {
      scene_camera = add(delta_scene_pos.mult(-1), pos_scene_camera_ref);
    } else {
      scene_camera = add(delta_scene_pos, pos_scene_camera_ref);
    }
  } else {
    //change the boolean to true for the next mousepressed
    new_ref_scene_mouse = true;
  }
}
//


// Update Camera EYE position
private boolean new_ref_eye_mouse = true;
private vec3 pos_eye_mouse_ref = vec3();
private vec3 pos_eye_camera_ref = vec3();
private vec3 eye_camera = vec3();
private vec3 delta_eye_pos = vec3();
private vec3 temp_eye_camera = vec3();
void update_direction_camera(boolean authorization, vec3 pos_cursor) {
  if(authorization) {
    //create the ref to calcul the new position of the Scene
    if(new_ref_eye_mouse) {
      pos_eye_camera_ref.set(temp_eye_camera);
      pos_eye_mouse_ref.set(pos_cursor);
    }
    //to create a only one ref position
    new_ref_eye_mouse = false ;
    
    //create the delta between the ref and the mouse position
    delta_eye_pos = sub(pos_cursor, pos_eye_mouse_ref);
    temp_eye_camera = add(delta_eye_pos, pos_eye_camera_ref);

    // direction of the camera
   //  return direction_canvas_to_polar(temp_eye_camera) ;
    eye_camera.set(direction_canvas_to_polar(temp_eye_camera));
  } else {
    //change the boolean to true for the next mousepressed
    new_ref_eye_mouse = true;
  }  
}


/**
* EYE POSITION
* We must use this one with le leapmotion information, because with the leapmotion device
* there is no "pmouse" information.
*/
vec3 direction_canvas_to_polar(vec3 direction_canvas) {
  float temp_dir_x = map(direction_canvas.y,0,height,0,360);
  float temp_dir_y = map(direction_canvas.x,0,width,0,360);
  vec3 eyeP3D = vec3(temp_dir_x,temp_dir_y,0);
  return eyeP3D;
}








