/** 
Core_scene 
v 1.5.0
2013-2017
*/


/**
OPENING
*/
boolean open_controller = false ;
boolean open_prescene = true ;
int count_to_open_controller = 0 ;
int time_int_second_to_open_controller = 12  ; // the scene run and run slow at the beginning like at 15 frame / second.


void opening() {
// open prescene
  if (open_prescene) {
    if (open_prescene) {
      launch(sketchPath("")+"PreScene_"+version+"_preview.app") ; 
      open_prescene = false ; 
      open_controller = true ;
    } 
  }

  // open controller
  if(open_controller) {
    count_to_open_controller += 1 ;
    int time_factor_to_open = 60 ;
    if (open_controller && count_to_open_controller > (time_int_second_to_open_controller *time_factor_to_open) ) { 
      launch(sketchPath("")+"Controleur_"+version+".app") ; 
      open_controller = false ; 
    }
  }
}

/*
void message_opening() {
  fill(blanc) ;
  stroke(blanc) ;
  textSize(48) ;
  textAlign(CENTER) ;
  start_matrix() ;
  translate(width/2, height/2, abs(sin(frameCount * .005)) *(height/2)) ;
  text("Romanesco Unu release " + prettyVersion+"." + version, 0,0) ;
  stop_matrix() ;
  textAlign(LEFT) ;
}
*/


















/**
GRAPHIC CONFIGURATION 
1.0.0.1
*/



/*
String displayMode = ("") ;
//ID of the screen

//size of the Scene

//to load the .csv who give the graphic configuration for the Scene



//SETUP
void display_setup(int speed) {
  background(0);
  frameRate(speed); 
  noCursor ();
  colorMode(HSB, HSBmode.r, HSBmode.g, HSBmode.b, HSBmode.a) ;

  set_screen();
  
  background_setup() ;
  background_shader_setup() ;
}
*/




/*
int whichScreen;
void resize_scene() {
  if (!FULL_SCREEN && !check_size || (width != scene_width && height != scene_height)) {
    catch_display_position() ;
    check_size = true ;
    int which = whichScreen ;
    if(which > screenDevice.length || which < 1) {
      which = 1;
    }
    int pos_x = display_size_x[which -1] - ((display_size_x[which -1]/2) +(scene_width /2)) ;
    int pos_y = display_size_y[which -1] - ((display_size_y[which -1]/2) +(scene_height /2)) ;
    set_display_sketch (pos_x, pos_y, scene_width, scene_height, which, true) ;
  }
}
// END size scene




// METHOD TO DISPLAY
////////////////////
GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] screenDevice = ge.getScreenDevices();



// window method
void set_display_sketch(int pos_x, int pos_y, int size_x, int size_y, int which_screen, boolean change_setting) {
  if(change_setting) {
    catch_display_position() ; 
    set_display(pos_x, pos_y, size_x, size_y, which_screen) ;
  }
}

// main method to display
void set_display(int pos_x, int pos_y, int size_x, int size_y, int which_screen) {
  int which = which_screen - 1 ;
  if(which < 0 ) which = 0 ;
  if(which < screenDevice.length ) {
    println("Surface set location",pos_x +display_pos_x[which],pos_y +display_pos_y[which]) ;
    surface.setLocation(pos_x +display_pos_x[which],pos_y +display_pos_y[which]) ;
    // surface.setLocation(20,20) ;
    surface.setSize(size_x,size_y) ;
    // surface.setLocation(pos_x +display_pos_x[which],pos_y +display_pos_y[which]) ;

  } else {
    println("You try to use an unvailable display") ;
    surface.setSize(size_x,size_y) ;
    surface.setLocation(20,20) ;
  }
}


// catch info about the different display
int [] display_pos_x, display_pos_y ;
int [] display_size_x, display_size_y ;
int display_num ;
void catch_display_position() {
  display_num = screenDevice.length ;
  display_pos_x = new int [display_num] ;
  display_pos_y = new int [display_num] ;
  display_size_x = new int [display_num] ;
  display_size_y = new int [display_num] ;
  
  for(int i = 0 ; i < display_num ; i++) {
    GraphicsDevice gd = screenDevice[i];
    GraphicsConfiguration[] graphicsConfigurationOfThisDevice = gd.getConfigurations();
    // loop with a single element the screen selected above
    for (int j = 0 ; j < graphicsConfigurationOfThisDevice.length ; j++ ) {
      Rectangle gcBounds = graphicsConfigurationOfThisDevice[j].getBounds() ;
      display_pos_x[i] = gcBounds.x ;
      display_pos_y[i] = gcBounds.y ;
      display_size_x[i] = gd.getDisplayMode().getWidth();
      display_size_y[i] = gd.getDisplayMode().getHeight();
    }
  }
}
*/
/**
END GRAPHIC CONFIGURATION
*/





















/**
We use this void to re-init the temp value of SHORT EVENT from the Préscène, because this one is not refresh at the same framerate than the Scene.
Prescene have a 15 fps and the 60 fps, so the resulte when you press a key on the Prescene, this one is only refresh on the Scène after 4 frames.
*/
void init_value_temp_prescene() {
  // to change the value of the keyboard "a" to "z" to false
  for(int i = 1 ; i < 27 ;i++) {
    if(data_osc_prescene[i].equals("1")) {
    	data_osc_prescene[i] = "0" ;
    }
  }
  // to change the value of the special touch of keyboard like ENTER, BACKSPACE to false
  for(int i = 30 ; i < 38 ;i++) {
    if(data_osc_prescene[i].equals("1")) data_osc_prescene[i] = "0" ;
  }
  // to change the value of the special num touch of keyboard from '0' to '9'
  for(int i = 51 ; i < 61 ;i++) {
    if(data_osc_prescene[i].equals("1")) data_osc_prescene[i] = "0" ;
  }
}