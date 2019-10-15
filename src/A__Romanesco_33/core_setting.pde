/**
* setting launcher
* v 0.1.0
* 2019-2019
*/
void display_setup() {
	background(r.GRIS[1]);
}

void set_structure() {
	set_button_location();
	set_button_mode();
	set_button_window();
	//quantityScreen count the number of screen available
	GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
	GraphicsDevice[] devices = ge.getScreenDevices();
	int quantityScreen = devices.length;
	ivec3 pos_which_screen_button = ivec3(150,100,23);
	set_which_screen(quantityScreen, pos_which_screen_button) ;
	set_slider_window();
	set_button_start();
}

void set_slider_window() {
	vec2 size = vec2(180,16);

	slider_width = new Slider(vec2(10,134), size);
	slider_width.set_fill(r.GRIS[3]);
	slider_width.set_fill_molette(r.SAPIN,r.SANG);

	slider_height = new Slider(vec2(200,134), size);
	slider_height.set_fill(r.GRIS[3]);
	slider_height.set_fill_molette(r.SAPIN,r.SANG);
}

void set_button_start() {
	vec2 pos = vec2(10,190);
	vec2 size = vec2(210,20);
	button_start = new Button(pos, size);
	button_start.set_colour_in_on(r.GREEN);
	button_start.set_colour_out_on(r.SAPIN);
	button_start.set_colour_in_off(r.RED);
	button_start.set_colour_out_off(r.BLOOD);
	button_start.set_label("let's go romanesco");
	button_start.set_pos_label(0,button_start.size().y());
}

void set_button_window() {
	vec2 pos_window = vec2(10,70);
	vec2 size_window = vec2(120,20);
	button_window = new Button(pos_window, size_window);
	button_window.set_colour_in_on(r.GREEN);
	button_window.set_colour_out_on(r.SAPIN);
	button_window.set_colour_in_off(r.RED);
	button_window.set_colour_out_off(r.BLOOD);
	button_window.set_label("window");
	button_window.set_pos_label(0,button_window.size().y());

	vec2 pos_fullscreen = vec2(120,70);
	vec2 size_fullscreen = vec2(180,20);	
	button_full_screen = new Button(pos_fullscreen, size_fullscreen);
	button_full_screen.set_colour_in_on(r.GREEN);
	button_full_screen.set_colour_out_on(r.SAPIN);
	button_full_screen.set_colour_in_off(r.RED);
	button_full_screen.set_colour_out_off(r.BLOOD);
	button_full_screen.set_label("full screen");
	button_full_screen.set_pos_label(0,button_full_screen.size().y());
}

void set_button_mode() {
	vec2 pos_home = vec2(100,40);
	vec2 size_home = vec2(85,20);
	button_mode[0] = new Button(pos_home, size_home);
	button_mode[0].set_label("home");

	vec2 pos_live = vec2(180,40);
	vec2 size_live = vec2(85,20);
	button_mode[1] = new Button(pos_live, size_live);
	button_mode[1].set_label("live");

	vec2 pos_mirror = vec2 (240,40);
	vec2 size_mirror = vec2(85,20);
	button_mode[2] = new Button(pos_mirror, size_mirror);
	button_mode[2].set_label("mirror");

	for(int i = 0 ; i < button_mode.length ; i++) {
		button_mode[i].set_colour_in_on(r.GREEN);
		button_mode[i].set_colour_out_on(r.SAPIN);
		button_mode[i].set_colour_in_off(r.RED);
		button_mode[i].set_colour_out_off(r.BLOOD);
		button_mode[i].set_pos_label(0,button_mode[i].size().y());
	}
}

void set_button_location() {
	vec2 pos = vec2(width -150,40);
	vec2 size = vec2(200,40);
	button_reset = new Button(pos, size);
	button_reset.set_colour_in_on(r.GREEN);
	button_reset.set_colour_out_on(r.SAPIN);
	button_reset.set_colour_in_off(r.RED);
	button_reset.set_colour_out_off(r.BLOOD);
	button_reset.set_label("reset location");
	button_reset.set_pos_label(0,button_reset.size().y());
}

void set_which_screen(int n, ivec3 infoPos) {
	screen_num = n ;
	button_which_screen = new Button[screen_num] ;
	int x = infoPos.x();
	int y = infoPos.y();
	int space = infoPos.z();
	
	for ( int i = 0 ; i <  screen_num ; i++) {
		vec2 pos = vec2( x +( i *space), y ) ;
		vec2 size = vec2(20,20) ;
		String title = Integer.toString(i+1) ;
		button_which_screen[i] = new Button(pos, size);
		button_which_screen[i].set_colour_in_on(r.GREEN);
		button_which_screen[i].set_colour_out_on(r.SAPIN);
		button_which_screen[i].set_colour_in_off(r.RED);
		button_which_screen[i].set_colour_out_off(r.BLOOD);
		button_which_screen[i].set_label(title);
		button_which_screen[i].set_pos_label(0,button_which_screen[i].size().y());
	}
}



















String path_controller,path_controller_live;
String path_prescene,path_prescene_live;
String path_scene_live,path_scene_live_fullscreen;
void set_data() {
	FuturaStencil = loadFont ("FuturaStencilICG-20.vlw");
	text_info = loadFont ("Frutiger-Roman-14.vlw");

	String app_path = sketchPath("");

	path_controller = (app_path+"sources/control_"+version+".app");
	path_controller_live = (app_path+"sources/control_"+version+"_live.app");
	// path to OPENING APP
	path_prescene = (app_path + "sources/prescene_"+version+".app");
	path_prescene_live = (app_path + "sources/prescene_"+version+"_live.app");
	// path_scene_window = (app_path+"sources/scene_"+version+"_window.app");

	path_scene_live = (app_path+"sources/scene_"+version+"_live.app");
	path_scene_live_fullscreen = (app_path+"sources/scene_"+version+"_live_fullscreen.app");

	String[] l = split( ("1"), " ");
	saveStrings(app_path+"sources/preferences/language.txt", l);
}














