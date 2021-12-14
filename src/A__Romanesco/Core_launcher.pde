/**
* CORE LAUNCHER
* 2014-2019
* v 1.2.0
*/

String preference_path;
String load_data_path;
void path_setting() {
	String main_folder = "/sources";
	if(DEV_MODE) {
		load_data_path = sketchPath(1)+main_folder+"/preferences/";
		preference_path = sketchPath(1)+main_folder+"/preferences/";
	} else {
		load_data_path = sketchPath(0)+main_folder+"/preferences/";
		preference_path = sketchPath(0)+main_folder+"/preferences/";
	}
}

String version = "";
String prettyVersion = "";
String nameVersion = "";
void version() {
	String [] s = loadStrings(preference_path+"version.txt");
	String [] v = split(s[0],"/");
	prettyVersion = v[0];
	version = v[1];
	nameVersion = v[2];
}

void structure_background() {
	background(r.GRIS[1]);
	fill(r.ORANGE);
	textFont(FuturaStencil,20);
	fill(r.SANG);
	rect(0,0, width,30);
	fill(r.ORANGE);
	rect(0,30,width,2);
	fill(r.GRIS[14]);
	text(nameVersion, pos_name_version.x, pos_name_version.y);
	textFont(text_info,14);
	text("version " +prettyVersion + "."+version, pos_pretty_version.x, pos_pretty_version.y);
}
















/**
* draw launcher
*/
void reset_window_location() {
	textFont(text_info,14);
	textFont(FuturaStencil,20);
	button_reset.update(mouseX,mouseY);
	button_reset.rollover(true);
	button_reset.show_label();
}

void launcher() {
	choice_rendering();
	for(int i = 0 ; i < num_mode ; i++) {
		 if (button_mode[i].is() || mode_setting[i]) {
			select_renderer_to_launch_app(i);
		}
	}
}


void choice_rendering() {
	// remove 1 to don't update the mirror 
	for(int i = 0 ; i < button_mode.length - 1 ; i++) {
		button_mode[i].update(mouseX,mouseY);
		button_mode[i].rollover(true);
		button_mode[i].show_label();
	}

	if(mode_setting[2]) {
		bool_open_scene =("true") ; 
	} else {
		bool_open_scene =("false") ;
	} 
}

/**
select renderer
*/
void select_renderer_to_launch_app(int which_one) {
	if(which_one == 0) {
		select_renderer_home(which_one);
	} else if(which_one == 1) {
		select_renderer_live(which_one);
	} else if(which_one == 2) {
		select_renderer_live(which_one);
	}
}

void select_renderer_home(int which_one) {
	renderer_is(which_one);
	HOME = true;
	LIVE = false;
	MIRROR = false;
	fullscreen_or_window(true,false) ;
	ready_to_launch(); 
}

void select_renderer_live(int which_one) {
	renderer_is(which_one);
	HOME = false;
	LIVE = true;
	MIRROR = false;
	fullscreen_or_window(true,true) ;
	ready_to_launch(); 
}


void select_renderer_mirror(int which_one) {
	renderer_is(which_one);
	HOME = false;
	LIVE = false;
	MIRROR = true;
	fullscreen_or_window(true,false);
	addressLocal(pos_local_adress.x,pos_local_adress.y);
	ready_to_launch() ;
}

void renderer_is(int which_one) {
	for(int i = 0 ; i < num_mode ; i++) {
		if(i == which_one) {
			mode_setting[i] = true;
		} else {
			mode_setting[i] = false;
		}
	}  
}

void ready_to_launch() {
	if(screen_to_display > -1 && button_full_screen.is()) {
		button_start.update(mouseX,mouseY);
		button_start.rollover(true);
		button_start.show_label();
		// window mode the user must choice a window size  
	} else if(button_window.is() && index_height > 1 && index_width > 1) {
		button_start.update(mouseX,mouseY);
		button_start.rollover(true);
		button_start.show_label();
	} else {
		fill(r.ORANGE);
		text("Please finish the configuration",10,210);
	}
}

void fullscreen_or_window(boolean window_is, boolean fullscreen_is) {
	if(window_is) {
		button_window.update(mouseX,mouseY);
		button_window.rollover(true);
		button_window.show_label();
	}

	if(screen_num > 1 && fullscreen_is) {
		button_full_screen.update(mouseX,mouseY);
		button_full_screen.rollover(true);
		button_full_screen.show_label();
	}
	
	if(button_window.is()) {
		screen = ("false"); 
	} else if (button_full_screen.is()) {
		screen = ("true");
	}

	if(button_full_screen.is()) {
		FULLSCREEN = true;
		choice_screen_for_fullscreen();
	} else if (button_window.is()) {
		FULLSCREEN = false;
		screen = ("false") ;
		update_button_size_window();
	}
}









/**
* mousePressed
*/
void mousePressed_button() {
	if(button_reset.inside()) {
  	button_reset.switch_is();
  	if(button_reset.is()) {
  		println("reset all windows location");
  		save_window_location_reset();
  		button_reset.is(false);
  	}
  }
	//which type of SCENE display full screen or window
  //to re-init the button
  if (button_full_screen.inside() || button_window.inside() 
  		|| button_mode[0].inside() || button_mode[1].inside() || button_mode[2].inside()) {
    for(int i = 0 ; i < button_mode.length ; i++) {
      button_mode[i].is(false);
    }

    button_full_screen.is(false);
    button_window.is(false);
  }
  // after the re-init we can check what's happen on the button
  for(int i = 0 ; i < button_mode.length ; i++) {
    if(button_mode[i].inside()) {
			button_mode[i].switch_is();
		}
  }

  if(button_full_screen.inside()) {
  	button_full_screen.switch_is();
  }

  if(button_window.inside()) {
  	button_window.switch_is();
  }
  
  //which screen for the fullscreen mode
  if(button_full_screen.is()) {
  	button_which_screen_pressed();
  }
  
  //button start
  if(button_start.inside()) {
  	button_start.switch_is();
  }
  if(button_start.is()) {
    save_app_properties();
    open_app_is(true);
    // open_app();
  }
  button_start.is(false);
}


































/**
ADDRESS IP for Mirror
*/
void addressLocal(float x, float y) {
	fill(r.ORANGE) ;
	try {
		fill(r.GRIS[12]) ;
		text("local address", x,y ) ;
		text(java.net.InetAddress.getLocalHost().getHostAddress(), x+188,y) ;
	}
	catch(Exception e) {
	}
}























/**
* SAVE DISPLAY PROPERTY
* v 0.2.0
*/
void save_app_properties() {
	Table properies = new Table();
	String[] col = new String[13];

	col[0] = "fullscreen";
	col[1] = "whichScreen";
	col[2] = "resizable"; 
	col[3] = "decorated";

	col[4] = "width";
	col[5] = "height";
	col[6] = "preview_width"; 
	col[7] = "preview_height";

	col[8] = "prescene_x"; 
	col[9] = "prescene_y";
	col[10] = "scene_x"; 
	col[11] = "scene_y";
	col[12] = "miroir";
	
	for(int i = 0 ; i < col.length ; i++) {
		properies.addColumn(col[i]);
	}
	
	TableRow newRow = properies.addRow();
	
	int w = standard_size_width[index_width -1];
	int h = standard_size_height[index_height -1];
	int preview_w = 500 ;
	int preview_h = 350;

	int prescene_x = 0;
	int prescene_y = 0;
	int scene_x = 0;
	int scene_y = 0;

	newRow.setString(col[0], screen);
	newRow.setInt(col[1],get_which_screen());
	newRow.setString(col[2],"true"); 
	newRow.setString(col[3],"true"); 
	newRow.setInt(col[4], w);
	newRow.setInt(col[5], h);
	newRow.setInt(col[6], preview_w);
	newRow.setInt(col[7], preview_h);

	newRow.setInt(col[8], prescene_x);
	newRow.setInt(col[9], prescene_y);
	newRow.setInt(col[10], scene_x);
	newRow.setInt(col[11], scene_y);

	newRow.setString(col[12],bool_open_scene);
	String path = preference_path +"sceneProperty.csv";
	println(path);
	saveTable(properies, path);
}

void save_window_location_reset() {
	if(!DEV_MODE) {
		String loc [] = new String[2];
		loc[0] = Integer.toString(10);
		loc[1] = Integer.toString(10);
		saveStrings(preference_path+"window/controller_location.loc",loc);
		saveStrings(preference_path+"window/prescene_location.loc",loc);
		saveStrings(preference_path+"window/scene_location.loc",loc);
	}
}














/**
* SIZE WINDOW
*/
void update_button_size_window() {
	int correctionPosY = -14 ;
	update_button_size_window_width(standard_size_width, correctionPosY) ;
	update_button_size_window_height(standard_size_height, correctionPosY) ;
}

void update_button_size_window_width(int [] format_width, int pos_y) {
	slider_width.update(mouseX,mouseY);
	slider_width.show_structure();
  slider_width.show_molette();
  slider_width.show_label(); 
	index_width = int(map(slider_width.get(0),0,1,1,format_width.length));
	String w = Integer.toString(format_width[index_width -1]) ;
	if (index_width <= 1) {
		fill(r.SANG);
		text("width " + w, slider_width.pos().x(), slider_width.pos().y() + pos_y);
	} else {
		fill(r.SAPIN);
		text("width " + w, slider_width.pos().x(), slider_width.pos().y() + pos_y);
	}
}

void update_button_size_window_height(int[] format_height, int pos_y) {
	slider_height.update(mouseX,mouseY);
	slider_height.show_structure();
  slider_height.show_molette();
  slider_height.show_label(); 
	index_height = int(map(slider_height.get(0),0,1,1,format_height.length));
	String h = Integer.toString(format_height[index_height -1]) ;
	if (index_height <= 1) {
		fill(r.SANG);
		text("heigth " + h, slider_height.pos().x(), slider_height.pos().y() +pos_y);
	} else {
		fill(r.SAPIN);
		text("heigth " + h, slider_height.pos().x(), slider_height.pos().y() +pos_y);
	}
}










/**
* SCREEN
* v 1.2.0
*/
void choice_screen_for_fullscreen() {
	fill(r.ORANGE);
	text("on screen",10.0,120.0);
	which_screen();
}

int screen_num;
void which_screen() {
	for(int i = 0 ; i < screen_num ; i++) {
		button_which_screen[i].update(mouseX,mouseY);
		button_which_screen[i].rollover(true);
		button_which_screen[i].show_label();
	}
}

// MOUSE PRESSED
void button_which_screen_pressed() {
	for(int i = 0 ; i < screen_num ; i++) {
		if(button_which_screen[i].inside()) {
			
			for(int j = 0 ; j < screen_num ; j++) {
				button_which_screen[j].is(false);
			}
			button_which_screen[i].switch_is();
		}
	}
}

// MOUSE RELEASED
int screen_to_display;
void which_screen_released() {
	for(int i = 0 ; i < screen_num ; i++ ) {
		button_which_screen[i].inside();
		if(button_which_screen[i].is()) {
			screen_to_display = i;
		}
	}
}

int get_which_screen() {
	int id_screen = 0;
	// check if all screen exist
	boolean [] screen_is = new boolean[screen_num];
	for(int i = 0 ; i < screen_num ; i++) {
		if(get_screen(i) != null) {
			println("size display", i, get_screen(i).getWidth(),get_screen(i).getHeight());
			screen_is[i] = true;
		}
	}
	for(int i = 0 ; i < screen_num ; i++ ) { 
		if(button_which_screen[i].is()) {
			if(screen_is[i]) {
				id_screen = i; 
				break;
			} else {
				for(int k = 0 ; k < screen_is.length ; k++) {
					 if(screen_is[k]) {
						id_screen = k;
						break;
					}
				}
			}
		}
	}
	return id_screen;
}









