/**
Core Prescene
v 1.3.0
2013-2018
* Here you find
* variable Prescene
* update command for the mouse, cursor...
* tablet
* open method for the scene and controller
* keyboard command
*/

//to opening app
boolean openScene = true ;
boolean openMiroir = true ;
boolean openControleur = true ;
//send to the other sketches
boolean youCanSendToScene = true ;
// boolean youCanSendToMiroir = true ;


// CURSOR SPEED
int speedWheel = 4 ; // 5 is too quick
float speedLeapmotion = .15 ; // between 0.000001 and 1 : can be good between 0.1 and 0.4

float mouse_reactivity = .8;





import codeanticode.tablet.*;
Tablet tablet;

void prescene_setup() {
  leap = new com.leapmotion.leap.Controller();
  if(TABLET) tablet = new Tablet(this);
  if(FULL_RENDERING) displayInfo3D = false ; else displayInfo3D = true;
}



/**
command
*/
void updateCommand() {
  // move the object
  if(clickLongLeft[0] || finger.activefingers == 1 ) {
    ORDER_ONE = true ; 
    ORDER_TWO = false ;
    ORDER_THREE = false ;
  }
  // rotate the object
  else if(clickLongRight[0] || finger.activefingers == 2) {
    ORDER_ONE = false ; 
    ORDER_TWO = true ;
    ORDER_THREE = false ;
  }
  // move and rotate
  else if(finger.activefingers == 3) {
    ORDER_ONE = false ; 
    ORDER_TWO = false ;
    ORDER_THREE = true ;
  }

  if(!clickLongLeft[0] && !clickLongRight[0] && finger.activefingers != 2 && finger.activefingers != 1 && finger.activefingers != 3)  {
  // false
    ORDER_ONE = false ;
    ORDER_TWO = false ;
    ORDER_THREE = false ;
  }
}



/**
update cursor 1.2.0
*/
Vec3 mouse_ref;
int mouseZ ;
void device_update() {
  update_leap_command();
  update_wheel();
  
  //mousePressed
  if(ORDER_ONE || ORDER_TWO || ORDER_THREE) {
    ORDER = true; 
  } else {
    ORDER = false;
  }
  
  update_tablet();

  if(orderOneLeap || orderTwoLeap) {
    update_leapmotion();
  } else if (mouse_ref == null || mouse_ref.x != mouseX || mouse_ref.y != mouseY) {
    update_mouse();
  }

  //re-init the wheel value to be sure this one is stopped
  wheel[0] = 0;
  //re-init the mouse button for the short click
  clickShortLeft[0] = false; 
  clickShortRight[0] = false;
}


// ANNEXE VOID
void update_wheel() {
  mouseZ -= wheel[0];
}

void update_tablet() {
  if(pen[0] == null) {
    pen[0] = Vec3(0,0,.02);
  }

  if(TABLET) {
    float x = tablet.getTiltX();
    float y = tablet.getTiltY();
    float z = tablet.getPressure();
    pen[0].set(x,y,z);
  } else {
    pen[0].set(0,0,.02);
  }
}

void update_mouse() {
  if(mouse[0] == null) {
    mouse[0] = follow(mouseX,mouseY,0,mouse_reactivity);
  } else {
    mouse[0].set(follow(mouseX,mouseY,0,mouse_reactivity));
  }

  if(mouse_ref == null) {
    mouse_ref = Vec3(mouse[0]);
  } else mouse_ref.set(mouse[0]);
}

void update_leapmotion() {
  float x = averageTranslatePosition(speedLeapmotion).x;
  float y = -averageTranslatePosition(speedLeapmotion).y;
  float z = averageTranslatePosition(speedLeapmotion).z;
  if(mouse[0] == null) {
    mouse[0] = Vec3(x,y,z);
  } else mouse[0].set(x,y,z);
}




/**
load dialogue prescene
*/
void load_dial() {
  if(frameCount%240 == 0) {
    Table dial_table = loadTable(preference_path +"dialogue.csv","header");
    TableRow row = dial_table.getRow(0);
    float temp_reactivity = row.getFloat("mouse reactivity");
    mouse_reactivity = temp_reactivity *temp_reactivity;
  }
}








/**
KEYBOARD & SHORTCUTS
*/
import java.awt.event.KeyEvent;
boolean[] keyboard = new boolean[526];

void shortcuts_prescene() {
  keyboard[keyCode] = true ;
  // save Scene
  check_keyboard_save_scene_CURRENT_path();
  check_keyboard_save_scene_NEW_path();
  check_keyboard_load_scene();
}



// SCENE
// Scene load
// CTRL + O
void check_keyboard_load_scene() {
  if(check_keyboard(CONTROL) && !check_keyboard(SHIFT) && check_keyboard(KeyEvent.VK_O) ) { 
    load_Scene_Setting_local = true ;
    keyboard[keyCode] = false;    
  }
}

// Scene current save
// CTRL + S
void check_keyboard_save_scene_CURRENT_path() {
  if(check_keyboard(CONTROL) && !check_keyboard(SHIFT) && check_keyboard(KeyEvent.VK_S) ) {
    save_Current_Scene_Setting_local = true ;
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
   }
}

// Scene new save
// CTRL + SHIFT + S
void check_keyboard_save_scene_NEW_path() {
  if(check_keyboard(CONTROL) && check_keyboard(SHIFT) && check_keyboard(KeyEvent.VK_S) ) {
    save_New_Scene_Setting_local = true ;
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
}



boolean check_keyboard(int c) {
  if (keyboard.length >= c) {
    return keyboard[c];  
  }
  return false;
}


     
void key_true() {
  if (key == ' ') key_space = true ; 
  
  if (key == 'a') key_a = true;
  if (key == 'b') key_b = true;
  if (key == 'c') key_c = true;
  if (key == 'd') key_d = true;
  if (key == 'e') key_e = true;
  if (key == 'f') key_f = true;
  if (key == 'g') key_g = true;
  if (key == 'h') key_h = true;
  if (key == 'i') key_i = true;
  if (key == 'j') key_j = true;
  if (key == 'k') key_k = true;
  if (key == 'l') key_l = true;
  if (key == 'm') key_m = true;
  if (key == 'n') {
    println("new, new quoi",frameCount);
    key_n = true;
  }
  if (key == 'o') key_o = true;
  if (key == 'p') key_p = true;
  if (key == 'q') key_q = true;
  if (key == 'r') key_r = true;
  if (key == 's') key_s = true;
  if (key == 't') key_t = true;
  if (key == 'u') key_u = true;
  if (key == 'v') key_v = true;
  if (key == 'w') key_w = true;
  if (key == 'x') key_x = true;
  if (key == 'y') key_y = true;
  if (key == 'z') key_z = true;

  if (key == 'A') key_A = true;
  if (key == 'B') key_B = true;
  if (key == 'C') key_C = true;
  if (key == 'D') key_D = true;
  if (key == 'E') key_E = true;
  if (key == 'F') key_F = true;
  if (key == 'G') key_G = true;
  if (key == 'H') key_H = true;
  if (key == 'I') key_I = true;
  if (key == 'J') key_J = true;
  if (key == 'K') key_K = true;
  if (key == 'L') key_L = true;
  if (key == 'M') key_M = true;
  if (key == 'N') key_N = true;
  if (key == 'O') key_O = true;
  if (key == 'P') key_P = true;
  if (key == 'Q') key_Q = true;
  if (key == 'R') key_R = true;
  if (key == 'S') key_S = true;
  if (key == 'T') key_T = true;
  if (key == 'U') key_U = true;
  if (key == 'V') key_V = true;
  if (key == 'W') key_W = true;
  if (key == 'X') key_X = true;
  if (key == 'Y') key_Y = true;
  if (key == 'Z') key_Z = true;
  
  if (key == '0') key_0 = true;
  if (key == '1') key_1 = true;
  if (key == '2') key_2 = true;
  if (key == '3') key_3 = true;
  if (key == '4') key_4 = true;
  if (key == '5') key_5 = true;
  if (key == '6') key_6 = true;
  if (key == '7') key_7 = true;
  if (key == '8') key_8 = true;
  if (key == '9') key_9 = true;
  
  if (keyCode == SHIFT) key_shift = true ;
  if (keyCode == BACKSPACE) key_backspace = true ;
  if (keyCode == DELETE) key_delete = true ;

  if (keyCode == ALT) key_alt = true ;
  if (keyCode == RETURN) key_return = true ;
  if (keyCode == ENTER) key_enter = true ;
  if (keyCode == CONTROL) key_ctrl = true ;
  if (keyCode == 157) key_cmd = true ;
  
  if (keyCode == LEFT) key_left = true ;
  if (keyCode == RIGHT) key_right = true ;
  if (keyCode == UP) key_up = true ;
  if (keyCode == DOWN) key_down = true ;

  // long
  if (key == ' ') key_space_long = true; 

  if (key == 'c') key_c_long = true; 
  if (key == 'l') key_l_long = true; 
  if (key == 'n') key_n_long = true; 
  if (key == 'v') key_v_long = true; 
 
  if (keyCode == SHIFT) key_shift_long = true;
}

void key_long_false() {
  if (key == ' ') key_space_long = false; 
  if (key == 'c') key_c_long = false;
  if (key == 'l') key_l_long = false;
  if (key == 'n') key_n_long = false;
  if (key == 'v') key_v_long = false;

  if (keyCode == SHIFT) key_shift_long = false;
}


void key_false() {
  /** 
  check for the key and put false here, but it's less reactive that put false just after the use the boolean...here you display false three time !
  */
  // we add modulo to be sure the information about the boolean is transmit to the scene
  if(key_a) key_space = false;

  if(key_a) key_a = false;
  if(key_b) key_b = false;
  if(key_c) key_c = false;
  if(key_d) key_d = false;
  if(key_e) key_e = false;
  if(key_f) key_f = false;
  if(key_g) key_g = false;
  if(key_h) key_h = false;
  if(key_i) key_i = false;
  if(key_j) key_j = false;
  if(key_k) key_k = false;
  if(key_l) key_l = false;
  if(key_m) key_m = false;
  if(key_n) key_n = false;
  if(key_o) key_o = false;
  if(key_p) key_p = false;
  if(key_q) key_q = false;
  if(key_r) key_r = false;
  if(key_s) key_s = false;
  if(key_t) key_t = false;
  if(key_u) key_u = false;
  if(key_v) key_v = false;
  if(key_w) key_w = false;
  if(key_x) key_x = false;
  if(key_y) key_y = false;
  if(key_z) key_z = false;

  if(key_A) key_A = false;
  if(key_B) key_B = false;
  if(key_C) key_C = false;
  if(key_D) key_D = false;
  if(key_E) key_E = false;
  if(key_F) key_F = false;
  if(key_G) key_G = false;
  if(key_H) key_H = false;
  if(key_I) key_I = false;
  if(key_J) key_J = false;
  if(key_K) key_K = false;
  if(key_L) key_L = false;
  if(key_M) key_M = false;
  if(key_N) key_N = false;
  if(key_O) key_O = false;
  if(key_P) key_P = false;
  if(key_Q) key_Q = false;
  if(key_R) key_R = false;
  if(key_S) key_S = false;
  if(key_T) key_T = false;
  if(key_U) key_U = false;
  if(key_V) key_V = false;
  if(key_W) key_W = false;
  if(key_X) key_X = false;
  if(key_Y) key_Y = false;
  if(key_Z) key_Z = false;
  
  if(key_0) key_0 = false;
  if(key_1) key_1 = false;
  if(key_2) key_2 = false;
  if(key_3) key_3 = false;
  if(key_4) key_4 = false;
  if(key_5) key_5 = false;
  if(key_6) key_6 = false;
  if(key_7) key_7 = false;
  if(key_8) key_8 = false;
  if(key_9) key_9 = false;
  
  if (key_backspace) key_backspace = false;
  if (key_delete) key_delete = false; 
  if (key_enter) key_enter = false;
  if (key_return) key_return = false;
  if (key_shift) key_shift = false;
  if (key_alt) key_alt = false; 
  if (key_esc) key_esc = false;
  if (key_ctrl) key_ctrl = false;
  if (key_cmd) key_cmd = false;
  
  if (key_up) key_up = false;
  if (key_down) key_down = false;
  if (key_left) key_left = false;
  if (key_right) key_right = false;
}



