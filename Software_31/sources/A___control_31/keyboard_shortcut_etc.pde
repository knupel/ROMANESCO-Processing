/**
Keyboard and Shortcut
v 1.0.1
*/

/**
SHORTCUTS
*/
void shortcuts_controller() {
  keyboard[keyCode] = true;
  if(checkKeyboard(KEY_CTRL_OS) && checkKeyboard(KeyEvent.VK_X) ) {
    if(system().equals("Mac OS X")) {
      println("CMD + x: change slider display mode", frameCount);
    } else {
      println("CTRL + x: change slider display mode", frameCount);
    }
    slider_mode_display += 1;
    if(slider_mode_display > 2 ) slider_mode_display = 0;
  }

  // save Scene
  check_Keyboard_save_scene_CURRENT_path();
  check_Keyboard_save_scene_NEW_path();
  // save controller
  check_Keyboard_save_controller_CURRENT_path();
  check_Keyboard_save_controller_NEW_path();
  // load
  check_Keyboard_load_scene();
  check_Keyboard_load_controller();

  check_keyboard_shift();
}









/**
KEYBOARD CONTROLLER 1.0.1
*/
boolean checkKeyboard(int c) {
  if (keyboard.length >= c) {
    return keyboard[c];  
  }
  return false;
}
/**
simple touch
*/
boolean shift_key ;
void check_keyboard_shift() {
  if(checkKeyboard(SHIFT)) { 
    shift_key = true;
    keyboard[keyCode] = false; 
  }
}

void key_false() {
  shift_key = false;
}

/**
LOAD SAVE
*/
boolean load_scene_setting, save_current_scene_setting, save_new_scene_setting ;
/**
LOAD
*/
void check_Keyboard_load_scene() {
  if(checkKeyboard(KEY_CTRL_OS) && checkKeyboard(KeyEvent.VK_L) ) {
    if(system().equals("Mac OS X")) {
      println("CMD + l: load scene", frameCount);
    } else {
      println("CTRL + l: load scene", frameCount);
    }
    load_scene_setting = true;
    keyboard[keyCode] = false;   //
    
  }
}

void check_Keyboard_load_controller() {
  if(checkKeyboard(KEY_CTRL_OS) && checkKeyboard(KeyEvent.VK_O) ) { 
    if(system().equals("Mac OS X")) {
      println("CMD + o: load controller", frameCount);
    } else {
      println("CTRL + o: load controller", frameCount);
    }
    selectInput("Load setting controller", "load_setting_controller"); // ("display info in the window" , "name of the method callingBack" )
    keyboard[keyCode] = false;   //  
  }
}



/**
SAVE
*/
void check_Keyboard_save_scene_CURRENT_path() {
  if(checkKeyboard(KEY_CTRL_OS) && checkKeyboard(KeyEvent.VK_D) ) {
    if(system().equals("Mac OS X")) {
      println("CMD + d: save current scene on the last save", frameCount);
    } else {
      println("CTRL + d: save current scene on the last save", frameCount);
    }
    save_current_scene_setting = true ;
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
   }
}
// Scene new save
void check_Keyboard_save_scene_NEW_path() {
  if(checkKeyboard(KEY_CTRL_OS) && checkKeyboard(KeyEvent.VK_S) ) {
    if(system().equals("Mac OS X")) {
      println("CMD + s: save a new save", frameCount);
    } else {
      println("CTRL + s: save a new save", frameCount);
    }
    save_new_scene_setting = true ;
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
}


void check_Keyboard_save_controller_CURRENT_path() {
  if(checkKeyboard(KEY_CTRL_OS) && checkKeyboard(KeyEvent.VK_R) ) {
    if(system().equals("Mac OS X")) {
      println("CMD + r: save controller on the last save controller", frameCount);
    } else {
      println("CTRL + r: save controller on the last save controller", frameCount);
    }
    show_all_slider_item = true ;
    if (savePathSetting.equals("")) {
      File tempFileName = new File ("your_controller_setting.csv");
      selectOutput("Save setting", "save_controller_setting", tempFileName);
    } else save_controller_setting(savePathSetting) ;
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
}
// Controller new save
// CTRL + SHIFT + E
void check_Keyboard_save_controller_NEW_path() {
  if(checkKeyboard(KEY_CTRL_OS) && checkKeyboard(KeyEvent.VK_E) ) {
    if(system().equals("Mac OS X")) {
      println("CMD + e: save new controller save", frameCount);
    } else {
      println("CTRL + e: save new controller save", frameCount);
    }
    show_all_slider_item = true ; 
    File tempFileName = new File ("your_controller_setting.csv");
    selectOutput("Save setting", "save_controller_setting", tempFileName);
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
}