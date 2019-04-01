/**
* Keyboard and Shortcut
* 2015-2019
* v 1.1.0
*/

/**
SHORTCUTS
*/
void shortcuts_controller() {
  keyboard[keyCode] = true;
  if(key_pressed(KEY_CTRL_OS) && key_pressed(KeyEvent.VK_X) ) {
    if(system().equals("Mac OS X")) {
      println("CMD + x: change slider display mode", frameCount);
    } else {
      println("CTRL + x: change slider display mode", frameCount);
    }
    slider_mode_display += 1;
    if(slider_mode_display > 2 ) slider_mode_display = 0;
  }

  // save controller
  key_pressed_save_controller_CURRENT_path();
  key_pressed_save_controller_NEW_path();
  // load
  key_pressed_load_controller();
  // media
  key_pressed_media_input();
  key_pressed_media_folder();
  key_pressed_shift();
}









/**
KEYBOARD CONTROLLER 1.0.1
*/
boolean key_pressed(int c) {
  if (keyboard.length >= c) {
    return keyboard[c];  
  }
  return false;
}
/**
simple touch
*/
boolean shift_key ;
void key_pressed_shift() {
  if(key_pressed(SHIFT)) { 
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

/**
LOAD
*/
void key_pressed_media_input() {
  if(key_pressed(KEY_CTRL_OS) && key_pressed(KeyEvent.VK_I)) {
    if(system().equals("Mac OS X")) {
      println("CMD + i: load media input",frameCount);
    } else {
      println("CTRL + i: load media input",frameCount);
    }
    select_input("media");
    input_is("media",true);
    keyboard[keyCode] = false;
  }
}

void key_pressed_media_folder() {
  if(key_pressed(KEY_CTRL_OS) && key_pressed(KeyEvent.VK_F)) {
    if(system().equals("Mac OS X")) {
      println("CMD + f: load media folder",frameCount);
    } else {
      println("CTRL + f: load media folder",frameCount);
    }
    select_folder();
    folder_is(true);
    keyboard[keyCode] = false;
  }
}



void key_pressed_load_controller() {
  if(key_pressed(KEY_CTRL_OS) && key_pressed(KeyEvent.VK_O)) { 
    if(system().equals("Mac OS X")) {
      println("CMD + o: load controller",frameCount);
    } else {
      println("CTRL + o: load controller",frameCount);
    }
    selectInput("Load setting controller", "load_setting_controller"); // ("display info in the window" , "name of the method callingBack" )
    keyboard[keyCode] = false;   //  
  }
}



/**
SAVE
*/
void key_pressed_save_controller_CURRENT_path() {
  if(key_pressed(KEY_CTRL_OS) && key_pressed(KeyEvent.VK_R)) {
    if(system().equals("Mac OS X")) {
      println("CMD + r: save controller on the last save controller",frameCount);
    } else {
      println("CTRL + r: save controller on the last save controller",frameCount);
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
void key_pressed_save_controller_NEW_path() {
  if(key_pressed(KEY_CTRL_OS) && key_pressed(KeyEvent.VK_E)) {
    if(system().equals("Mac OS X")) {
      println("CMD + e: save new controller save",frameCount);
    } else {
      println("CTRL + e: save new controller save",frameCount);
    }
    show_all_slider_item = true ; 
    File tempFileName = new File ("your_controller_setting.csv");
    selectOutput("Save setting", "save_controller_setting", tempFileName);
    keyboard[keyCode] = false ;  // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
}






