/**
Core_Prescene
v 1.1.0
2013-2018
*/


/**
GRAPHIC CONFIGURATION 
1.0.0.1
*/
String displayMode = ("") ;
int depth_scene ;

//SETUP
void display_setup(int frame_rate) {
  frameRate(frame_rate);  // Le frameRate doit être le même dans tous les Sketches
  colorMode(HSB, HSBmode.r, HSBmode.g, HSBmode.b, HSBmode.a); 
  set_screen();
  depth_scene = height;
  background_setup();
  background_shader_setup();
}

















/**
Here you find
> variable Prescene
> update command for the mouse, cursor...
> tablet
> open method for the scene and controller
> keyboard command
*/

// VARIABLES PRESCENE
/////////////////////
boolean scene = false ;
boolean prescene = true ;

//to opening app
boolean openScene = true ;
boolean openMiroir = true ;
boolean openControleur = true ;
//send to the other sketches
boolean youCanSendToScene = true ;
// boolean youCanSendToMiroir = true ;

// Web cam activity
// boolean cameraOnOff = false ;

// internet connection
boolean internet = true ;
String bigBrother = ("BIG BROTHER DON'T WATCHING YOU !!") ;



// CURSOR SPEED
int speedWheel = 4 ; // 5 is too quick
float speedLeapmotion = .15 ; // between 0.000001 and 1 : can be good between 0.1 and 0.4

// END VARIABLE
///////////////




// METHOD
/////////


import codeanticode.tablet.*;
Tablet tablet;

void prescene_setup() {
  leap = new com.leapmotion.leap.Controller();
  if(TABLET) tablet = new Tablet(this);
  if(FULL_RENDERING) displayInfo3D = false ; else displayInfo3D = true ;
}










///////////////////////
//CURSOR, MOUSE, TABLET
//GLOBAL
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
update cursor 1.0.1
*/
Vec3 posRef = Vec3() ;
int mouseZ ;

void device_update() {
  update_leap_command() ;
  update_wheel() ;
  
  //mousePressed
  if(ORDER_ONE || ORDER_TWO || ORDER_THREE) {
    ORDER = true ; 
  } else {
    ORDER = false ;
  }
  
  update_tablet() ;

  if(orderOneLeap || orderTwoLeap) {
    update_leapmotion() ;
  } else if (posRef.x != mouseX || posRef.y != mouseY) {
    update_mouse() ;
  }
  



  //re-init the wheel value to be sure this one is stopped
  wheel[0] = 0 ;
  //re-init the mouse button for the short click
  clickShortLeft[0] = false ; 
  clickShortRight[0] = false ;
  
  //why this line is here ????
  if (nextPrevious) nextPreviousInt = 1 ; else nextPreviousInt = 0 ;
}


// ANNEXE VOID
void update_wheel() {
  mouseZ -= wheel[0] ;
}


void update_tablet() {
  if(TABLET) {
    //pen[0] = Vec3 (norm(tablet.getTiltX(),0,1), norm(tablet.getTiltY(),0,1), tablet.getPressure()) ; 
    pen[0] = Vec3 (tablet.getTiltX(), tablet.getTiltY(), tablet.getPressure()) ; 
  } else {
    pen[0] = Vec3(0,0,.02) ;
  }
}


void update_mouse() {
  mouse[0] = Vec3(mouseX,mouseY,0) ;
  posRef.set(mouse[0]) ;
}

void update_leapmotion() {
  mouse[0] = Vec3(averageTranslatePosition(speedLeapmotion).x, -averageTranslatePosition(speedLeapmotion).y,averageTranslatePosition(speedLeapmotion).z)  ;
}
/**
end update cursor
*/










/**
MISC

*/

/**
KEYBOARD & SHORTCUTS
*/
//GLOBAL
import java.awt.event.KeyEvent;
boolean[] keyboard = new boolean[526];

void shortCutsPrescene() {
  keyboard[keyCode] = true ;
  // save Scene
  check_Keyboard_save_scene_CURRENT_path() ;
  check_Keyboard_save_scene_NEW_path() ;
  // load
  check_Keyboard_load_scene() ;

  // save
  // if (key == 's') selectOutput("Enregistrez le PDF et le PNG ", "saveImg") ;
  // info common command with Scene
  if (key == 'i') displayInfo = !displayInfo ;
  if (key == 'g') displayInfo3D = !displayInfo3D ;

}



// SCENE
///////////////////
boolean load_Scene_Setting_local, 
        save_Current_Scene_Setting_local,
        save_New_Scene_Setting_local ;
// Scene load
// CTRL + O
void check_Keyboard_load_scene() {
  if(checkKeyboard(CONTROL) && !checkKeyboard(SHIFT) && checkKeyboard(KeyEvent.VK_O) ) { 
    load_Scene_Setting_local = true ;
    keyboard[keyCode] = false;   //
    
  }
}

// Scene current save
// CTRL + S
void check_Keyboard_save_scene_CURRENT_path() {
  if(checkKeyboard(CONTROL) && !checkKeyboard(SHIFT) && checkKeyboard(KeyEvent.VK_S) ) {
    save_Current_Scene_Setting_local = true ;
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
   }
}
// Scene new save
// CTRL + SHIFT + S
void check_Keyboard_save_scene_NEW_path() {
  if(checkKeyboard(CONTROL) && checkKeyboard(SHIFT) && checkKeyboard(KeyEvent.VK_S) ) {
    save_New_Scene_Setting_local = true ;
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
}



boolean checkKeyboard(int c) {
  if (keyboard.length >= c) {
    return keyboard[c];  
  }
  return false;
}



      
 // KEYBOARD COMMAND       
        
void keyboardTrue() {
  if (key == ' ' ) key_space_long = true ; 
  
  if (key == 'a'  || key == 'A' ) key_a = true ;
  if (key == 'b'  || key == 'B' ) key_b = true ;
  if (key == 'c'  || key == 'C' ) { 
    key_c = true ; 
    key_c_long = true ; 
  }
  if (key == 'd'  || key == 'D' ) key_d = true ;
  if (key == 'e'  || key == 'E' ) key_e = true ;
  if (key == 'f'  || key == 'F' ) key_f = true ;
  if (key == 'g'  || key == 'G' ) key_g = true ;
  if (key == 'h'  || key == 'H' ) key_h = true ;
  if (key == 'i'  || key == 'I' ) key_i = true ;
  if (key == 'j'  || key == 'J' ) key_j = true ;
  if (key == 'k'  || key == 'K' ) key_k = true ;
  if (key == 'l'  || key == 'L' ) { 
    key_l = true ; 
    key_l_long = true ; 
  }
  if (key == 'm'  || key == 'M' ) key_m = true ;
  if (key == 'n'  || key == 'N' ) { 
    key_n = true ; 
    key_n_long = true ; 
  }
  if (key == 'o'  || key == 'O' ) key_o = true ;
  if (key == 'p'  || key == 'P' ) key_p = true ;
  if (key == 'q'  || key == 'Q' ) key_q = true ;
  if (key == 'r'  || key == 'R' ) key_r = true ;
  if (key == 's'  || key == 'S' ) key_s = true ;
  if (key == 't'  || key == 'T' ) key_t = true ;
  if (key == 'u'  || key == 'U' ) key_u = true ;
  if (key == 'v'  || key == 'V' ) { 
    key_v = true ; 
    key_v_long = true ; 
  }
  if (key == 'w'  || key == 'W' ) key_w = true ;
  if (key == 'x'  || key == 'X' ) key_x = true ;
  if (key == 'y'  || key == 'Y' ) key_y = true ;
  if (key == 'z'  || key == 'Z' ) key_z = true ;
  
  if (key == '0' ) key_0 = true ;
  if (key == '1' ) key_1 = true ;
  if (key == '2' ) key_2 = true ;
  if (key == '3' ) key_3 = true ;
  if (key == '4' ) key_4 = true ;
  if (key == '5' ) key_5 = true ;
  if (key == '6' ) key_6 = true ;
  if (key == '7' ) key_7 = true ;
  if (key == '8' ) key_8 = true ;
  if (key == '9' ) key_9 = true ;
  
  if (keyCode == BACKSPACE ) key_backspace = true ;
  if (keyCode == DELETE ) key_delete = true ;
  if (keyCode == SHIFT ) {
    key_shift = true ;
    key_shift_long = true ;
  }
  if (keyCode == ALT ) key_alt = true ;
  if (keyCode == RETURN ) key_return = true ;
  if (keyCode == ENTER ) key_enter = true ;
  if (keyCode == CONTROL ) key_ctrl = true ;
  if (keyCode == 157 ) key_cmd = true ;
  
  if (keyCode == LEFT ) key_left = true ;
  if (keyCode == RIGHT ) key_right = true ;
  if (keyCode == UP ) key_up = true ;
  if (keyCode == DOWN ) key_down = true ;
}

void keyboardLongFalse() {
  if (key == ' ' ) key_space_long = false ; 
  if (key == 'c'  || key == 'C' ) key_c_long = false ;
  if (key == 'l'  || key == 'L' ) key_l_long = false ;
  if (key == 'n'  || key == 'N' ) key_n_long = false ;
  if (key == 'v'  || key == 'V' ) key_v_long = false ;

  if (keyCode == SHIFT ) key_shift_long = false ;
}


void keyboardFalse() {
  /** 
  check for the key and put false here, but it's less reactive that put false just after the use the boolean...here you display false three time !
  */
  // we add modulo to be sure the information about the boolean is transmit to the scene
  if(key_a) key_a = false ; 
  if(key_b) key_b = false ;
  if(key_c) key_c = false ;
  if(key_d) key_d = false ;
  if(key_e) key_e = false ;
  if(key_f) key_f = false ;
  if(key_g) key_g = false ;
  if(key_h) key_h = false ;
  if(key_i) key_i = false ;
  if(key_j) key_j = false ;
  if(key_k) key_k = false ;
  if(key_l) key_l = false ;
  if(key_m) key_m = false ;
  if(key_n) key_n = false ;
  if(key_o) key_o = false ;
  if(key_p) key_p = false ;
  if(key_q) key_q = false ;
  if(key_r) key_r = false ;
  if(key_s) key_s = false ;
  if(key_t) key_t = false ;
  if(key_u) key_u = false ;
  if(key_v) key_v = false ;
  if(key_w) key_w = false ;
  if(key_x) key_x = false ;
  if(key_y) key_y = false ;
  if(key_z) key_z = false ;
  
  if(key_0) key_0 = false ;
  if(key_1) key_1 = false ;
  if(key_2) key_2 = false ;
  if(key_3) key_3 = false ;
  if(key_4) key_4 = false ;
  if(key_5) key_5 = false ;
  if(key_6) key_6 = false ;
  if(key_7) key_7 = false ;
  if(key_8) key_8 = false ;
  if(key_9) key_9 = false ;
  
  if (key_backspace) key_backspace = false ;
  if (key_delete) key_delete = false ; 
  if (key_enter) key_enter = false ;
  if (key_return) key_return = false ;
  if (key_shift) key_shift = false ;
  if (key_alt) key_alt = false ; 
  if (key_esc) key_esc = false ;
  if (key_ctrl) key_ctrl = false ;
  if (key_cmd) key_cmd = false ;
  
  if (key_up) key_up = false ;
  if (key_down) key_down = false ;
  if (key_left) key_left = false ;
  if (key_right) key_right = false ;
}
//END KEYBOARD
//////////////