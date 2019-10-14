/**
* CORE LAUNCHER
* 2014-2019
* v 1.2.0
*/

String preference_path;
String load_data_path;
/*
String import_path;
String items_path;
String autosave_path;
*/
void path_setting() {
	//int folder_position = 1;
	String main_folder = "/sources";
	if(DEV) {
		load_data_path = sketchPath(1)+main_folder+"/preferences/";
		preference_path = sketchPath(1)+main_folder+"/preferences/";
		/*
		import_path = sketchPath(1)+main_folder+"/import/";
		items_path = sketchPath(1)+main_folder+"/items/";
		autosave_path = sketchPath(1)+main_folder+"/autosave.csv";
		*/
	} else {
		load_data_path = sketchPath(0)+main_folder+"/preferences/";
		preference_path = sketchPath(0)+main_folder+"/preferences/";
		/*
		import_path = sketchPath(0)+main_folder+"/import/";
		items_path = sketchPath(0)+main_folder+"/items/";
		autosave_path = sketchPath(0)+main_folder+"/autosave.csv";
		*/
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




































void display_setup() {
	background(r.GRIS[1]);
}

void color_setup() {
	colorMode(HSB,360,100,100);
	c1 = color(r.ORANGE);
	c2 = color(r.SANG);
	c3 = color(r.VERT);
	c4 = color(r.SAPIN);
	//common data
	colorIN = color (r.VERT);
	colorOUT = color (r.SAPIN);
}


void set_structure() {
	vec2 pos_reset = vec2(width -150,40);
	vec2 size_reset = vec2(240,40);

	reset_location = new Button(pos_reset, size_reset, c1, c2, c3, c4, "reset location");


	vec2 pos_home = vec2(100,40);
	vec2 pos_live = vec2(180,40);
	vec2 pos_mirror = vec2 (240,40);
	vec2 size_home = vec2(85,20);
	vec2 size_live = vec2(85,20);
	vec2 size_mirror = vec2(85,20);
	renderer[0] = new Button(pos_home, size_home, c1, c2, c3, c4, "Home");
	renderer[1] = new Button(pos_live, size_live, c1, c2, c3, c4, "Live");
	renderer[2] = new Button(pos_mirror, size_mirror, c1, c2, c3, c4, "Mirror");
	
	// size and display type
	vec2 pos_window = vec2(10,70);
	vec2 pos_fullscreen = vec2(120,70);

	vec2 size_window = vec2(120,20);
	vec2 size_fullscreen = vec2(180,20);

	buttonWindow = new Button(pos_window, size_window, c1, c2, c3, c4, "Window");
	buttonFullscreen = new Button(pos_fullscreen, size_fullscreen, c1, c2, c3, c4, "Full Screen");
	
	// start
	vec2 pos_start = vec2(10, 190);
	vec2 size_start = vec2(210, 20);

	buttonStart = new Button(pos_start, size_start, colorIN, colorOUT, colorIN, colorOUT, "Launch Romanesco");

	//quantityScreen count the number of screen available
	GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
	GraphicsDevice[] devices = ge.getScreenDevices();
	int quantityScreen = devices.length;
	set_which_screen(quantityScreen, posWhichScreenButton) ;
	
	color colorBG = color(r.GRIS[3]);
	color colorBoxIn = color(r.SAPIN);
	color colorBoxOut = color(r.SANG);
	
	sliderWidth = new Slider(posSliderWidth, posMoletteWidth, sizeSlider, colorBG, colorBoxIn, colorBoxOut);
	sliderWidth.sliderSetting();
	sliderHeight = new Slider(posSliderHeight, posMoletteHeight, sizeSlider, colorBG, colorBoxIn, colorBoxOut);
	sliderHeight.sliderSetting();
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





















/**
* draw launcher
*/
void reset_window_location() {
	textFont(text_info,14);
	fill(r.NOIR);
	textFont(FuturaStencil,20);
	reset_location.displayButton();
}

void launcher_background() {
	background(r.GRIS[1]) ;
	fill(r.ORANGE);
	textFont(FuturaStencil,20);
	fill(r.SANG);
	rect(0,0, width,30);
	fill(r.ORANGE);
	rect(0,30,width,2);
	fill(r.GRIS[14]);
	text(nameVersion, pos_name_version.x, pos_name_version.y);
}

void launcher() {
	textFont(text_info,14);
	text("version " +prettyVersion + "."+version, pos_pretty_version.x, pos_pretty_version.y);
	fill(r.GRIS[14]);
	textFont(FuturaStencil,20);

	text("Choice", pos_choice.x, pos_choice.y);

	choice_rendering();
	//fork choice menu
	for(int i = 0 ; i < num_renderer ; i++) {
		 if (renderer[i].OnOff || renderer_setting[i]) {
			select_renderer_to_launch_app(i) ;
		}
	}
}

void choice_rendering() {
	renderer[0].displayButton(renderer_setting[0]) ; // HOME
	renderer[1].displayButton(renderer_setting[1]) ; // LIVE
	// renderer[2].displayButton(renderer_setting[2]) ; // MIRROR
	if(renderer_setting[2]) {
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
		select_renderer_home(which_one) ;
	} else if(which_one == 1) {
		select_renderer_live(which_one) ;
	} else if(which_one == 2) {
		select_renderer_live(which_one) ;
	}
}

void select_renderer_home(int which_one) {
	renderer_is(which_one) ;
	HOME = true ;
	LIVE = false;
	MIRROR = false;
	fullscreen_or_window(true,false) ;
	ready_to_launch() ; 
}

void select_renderer_live(int which_one) {
	renderer_is(which_one) ;
	HOME = false ;
	LIVE = true;
	MIRROR = false;
	fullscreen_or_window(true,true) ;
	ready_to_launch() ; 
}


void select_renderer_mirror(int which_one) {
	renderer_is(which_one) ;
	HOME = false;
	LIVE = false;
	MIRROR = true;
	fullscreen_or_window(true,false);
	addressLocal(pos_local_adress.x,pos_local_adress.y) ;
	ready_to_launch() ;
}

void renderer_is(int which_one) {
	for(int i = 0 ; i < num_renderer ; i++) {
		if(i == which_one) {
			renderer_setting[i] = true ;
		} else {
			renderer_setting[i] = false ;
		}
	}  
}

void ready_to_launch() {
	if (screen_to_display > -1 && buttonFullscreen.OnOff) {
		buttonStart.displayButton() ;
		// window mode the user must choice a window size  
	} else if (buttonWindow.OnOff && heightSlider > 1 && widthSlider > 1) {
		buttonStart.displayButton() ;
	} else {
		fill(r.ORANGE) ;
		text("Please finish the configuration",10,210) ;
	}
}

void fullscreen_or_window(boolean window_is, boolean fullscreen_is) {
	if(window_is) buttonWindow.displayButton();

	if(screen_num > 1 && fullscreen_is) {
		buttonFullscreen.displayButton();
	}
	
	if (buttonWindow.OnOff) {
		screen = ("false") ; 
	} else if (buttonFullscreen.OnOff) {
		screen = ("true") ;
	}

	if (buttonFullscreen.OnOff) {
		FULLSCREEN = true;
		choice_screen_for_fullscreen() ;
	} else if (buttonWindow.OnOff) {
		 FULLSCREEN = false;
		screen = ("false") ;
		size_window() ;
	}
}









/**
* mousePressed
*/
void mousePressed_button() {
	reset_location.mouseClic();
	//which type of SCENE display full screen or window
  //to re-init the button
  if (buttonFullscreen.inside || buttonWindow.inside || renderer[0].inside || renderer[1].inside || renderer[2].inside) {
    for(int i = 0 ; i < renderer.length ; i++) {
      renderer[i].OnOff = false ;
    }

    buttonFullscreen.OnOff = false ;
    buttonWindow.OnOff = false ;
  }
  // after the re-init we can check what's happen on the button
  for(int i = 0 ; i < renderer.length ; i++) {
    renderer[i].mouseClic() ;
  }
  buttonFullscreen.mouseClic() ;
  buttonWindow.mouseClic() ;
  
  //which screen for the fullscreen mode
  if(buttonFullscreen.OnOff) {
  	which_screen_pressed();
  }
  
  //button start
  buttonStart.mouseClic() ;
  if(buttonStart.OnOff) {
    save_app_properties();
    open_app_is(true);
    // open_app();
  }
  buttonStart.OnOff = false;
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
SAVE DISPLAY PROPERTY
v 0.2.0
*/
// Table sceneProperty;
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



	println("display 0",0,get_display_size(0));
	println("display 1",1,get_display_size(1));
	// println("display 2",2,get_display_size(2));
	
	int w = standard_size_width[widthSlider-1];
	int h = standard_size_height[heightSlider -1];
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


















/**
SIZE WINDOW
actually there is bug with Processing for the resize window in P3D, so we need to
create few apps dedicated and launch... that's growth the size of the zip file...
C'est la vie...
We mut use the boolean to indicate to the launcher, the problem after that it's possible to choice which app must be launch
*/
// boolean resize_bug = true ;

void size_window() {
	int correctionPosY = -14 ;
	// size_window_width(standard_format_for_Processing_bug, correctionPosY) ;
	/**
	This lines bellow must use when the bug will be fix !!!!
	*/
	size_window_width(standard_size_width, correctionPosY) ;
	size_window_height(standard_size_height, correctionPosY) ;
}

void size_window_width(int [] format_width, int pos_y) {
	sliderWidth.sliderUpdate() ;
	widthSlider = int(map(sliderWidth.getValue(),0,1,1,format_width.length))  ;
	String w = Integer.toString(format_width[widthSlider-1]) ;
	if (widthSlider <= 1 ) {
		fill(r.SANG) ;
		text("Width " + w, posSliderWidth.x, posSliderWidth.y +pos_y);
	} else {
		fill(r.SAPIN) ;
		text("Width " + w, posSliderWidth.x, posSliderWidth.y +pos_y);
	}
}

void size_window_height(int[] format_height, int pos_y) {
	sliderHeight.sliderUpdate() ;
	heightSlider = int(map(sliderHeight.getValue(),0,1,1,format_height.length))  ;
	String h = Integer.toString(format_height[heightSlider -1]) ;
	if (heightSlider <= 1 ) {
		fill(r.SANG) ;
		text("Heigth " + h, posSliderHeight.x, posSliderHeight.y +pos_y);
	} else {
		fill(r.SAPIN) ;
		text("Heigth " + h, posSliderHeight.x, posSliderHeight.y +pos_y);
	}
}










/**
SCREEN
v 1.1.0
*/
int screen_num  ;
//SETUP 
void set_which_screen(int n , PVector infoPos) {
	//quantity of button choice
	screen_num = n ;
	whichScreenButton = new Button [screen_num] ;
	//position of the button  
	int x = (int)infoPos.x ;
	int y = (int)infoPos.y ;
	int space = (int)infoPos.z ;
	
	for ( int i = 0 ; i <  screen_num ; i++) {
		vec2 pos = vec2( x +( i *space), y ) ;
		vec2 size = vec2(20,20) ;
		String title = Integer.toString(i+1) ;
		whichScreenButton[i] = new Button(pos, size, c1, c2, c3, c4, title) ;
	}
}

void choice_screen_for_fullscreen() {
	fill(r.ORANGE);
	text("on screen",10.,120.);
	which_screen();
}


void which_screen() {
	for(int i = 0 ; i < screen_num ; i++) {
		whichScreenButton[i].displayButton() ;
	}
}

//MOUSEPRESSED
void which_screen_pressed() {
	for(int i =0 ; i< screen_num ; i++ ) {
		if (whichScreenButton[i].inside ) {
			for( int j =0 ; j < screen_num ; j++ ) {
				whichScreenButton[j].OnOff = false;
			}
		}
	}
}

//MOUSERELEASED
int screen_to_display;
void which_screen_released() {
	for(int i = 0 ; i < screen_num ; i++ ) {
		whichScreenButton[i].mouseClic() ;
		if(whichScreenButton[i].OnOff) {
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
			println("size display",i,get_screen(i).getWidth(),get_screen(i).getHeight());
			screen_is[i] = true;
		}
	}
	for(int i = 0 ; i < screen_num ; i++ ) { 
		if(whichScreenButton[i].OnOff == true ) {
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









