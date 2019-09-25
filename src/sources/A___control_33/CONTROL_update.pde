/**
* Keyboard and Shortcut
* 2015-2019
* v 1.2.0
*/
/**
MENU BAR
*/
void what_happen_in_menu(String what, ActionEvent ae) {
	println("here code your the behavior of", what);
	if(what.equals("midi map")) {
		select_midi_is = select_midi_is ? false:true;
	}

	if(what.equals("syphon")) {
		syphon_is = syphon_is ? false:true;
	}

	// media
	if(what.equals("media")) {
		select_input("media");
		input_is("media",true);
	}

	if(what.equals("import folder")) {
		select_folder();
	}

	if(what.equals("clear all medias")) {
		clear_all_medias();
		update_media();
		autosave();
	}

	// file
	if(what.equals("load controller")) {
		// ("display info in the window" , "name of the method callingBack" )
		selectInput("Load setting controller", "load_setting_controller"); 
	}


	// save
	if(what.equals("save")) {
		show_all_slider_item = true ;
		if (savePathSetting.equals("")) {
			 save_as_controller_setting();
			// File tempFileName = new File ("your_controller_setting.csv");
			// selectOutput("Save setting", "save_controller_setting", tempFileName);
		} else {
			save_controller_setting(savePathSetting);
		}
	}


	if(what.equals("save as")) {
		show_all_slider_item = true ;
		save_as_controller_setting();
		// File tempFileName = new File ("your_controller_setting.csv");
		// selectOutput("Save setting", "save_controller_setting", tempFileName);
	}
}






















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




