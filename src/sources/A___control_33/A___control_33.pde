/**
* Romanesco dui
* 2012–2019
* version 33
* Processing 3.5.3
* Rope library 0.8.5.30
*/
/**
* Controller 
* V 1.2.1
* 2015 may 4_100 lines of code
* 2016 september 8_700 lines of code
* 2017 March 11_100 lines of code
* 2018 June 5_000 lines of code without CROPE and ROPE
*/
String IAM = "controller";

// DEV SETTING 
boolean DEBUG_MODE = true;
boolean DEV_MODE = true;
boolean LIVE = false;
boolean MIROIR = false;
boolean KEEP_BUTTON_ITEM_STATE = true;

// DEV SETTING LIVE
// boolean DEBUG_MODE = true;
// boolean DEV_MODE = true; 
// boolean LIVE = true;
// boolean MIROIR = false;
// boolean KEEP_BUTTON_ITEM_STATE = true;










// EXPORT SETTING
// DIRECT
// APP: control_##
// boolean LIVE = false;
// boolean MIROIR = false;
// boolean KEEP_BUTTON_ITEM_STATE = true;
// boolean DEV_MODE = false;
// boolean DEBUG_MODE = false;

// LIVE
// APP: control_##_live
// boolean LIVE = true;
// boolean MIROIR = false;
// boolean KEEP_BUTTON_ITEM_STATE = true;
// boolean DEV_MODE = false;
// boolean DEBUG_MODE = false;









void settings() {
	size(810,725);
	size_window_ref = ivec2(width,height);
	set_design();
}

void setup() {
	colorMode(HSB,360,100,100);
	load_window_location();
	path_setting();
	version();
	setting_misc();
	init_button_general();
	init_midi();
	init_info_shader();
	create_and_initialize_item(); 
	load_setup();
	
	set_system_specification();
	set_font();
	set_display_slider();
	set_import_pic_button();
	set_console();
	set_button_item_console();

	build_bar();
	build_console();
	build_dropdown_bar();
	build_dropdown_item_selected();
	build_button_item_console();
	build_inventory();
	set_OSC();
	set_data();
	reset();
}

void draw() {
	// print_debug_tempo(240,"void draw(): sketch controller is",focused);
	check_size_window();
	update_window_location();
	check_slider_item();
	
	add_media();
	check_button();

	manage_autosave();
	load_dial_scene();
	update_media();

	surface.setTitle(nameVersion + ": " +prettyVersion+"."+version+ " - Controller");

	set_data();

	display_structure();

	show_misc_text();
	show_slider_controller();

	update_button();
	show_button();

	show_dropdown();
	
	midi_manager(false);
	update_midi();
	update_OSC();
	update_dial();

	show_window_info();

	reset();
	credit();
}


void mouseWheel(MouseEvent e) {
	scroll(e);
}

void mousePressed () {
	if(!dropdown_is()) {
		mousePressed_button_general();
		mousepressed_button_item_console();
		mousepressed_button_inventory();
	} 
}

boolean send_data_is;
void keyPressed() {
	keypressed_midi();
	shortcuts_controller();
}


void keyReleased() { 
	key_false();
	keyboard[keyCode] = false;
}
