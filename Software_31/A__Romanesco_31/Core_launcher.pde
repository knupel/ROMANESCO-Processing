/**
CORE LAUNCHER
2014-2018
v 1.1.0
*/



/**
* OPEN ROMANESCO
* v 1.0.0
*/
int time_to_open_prescene = 180;
int time_to_open_controller = 360;
int count_to_open = 0;

boolean open_controller_is;
boolean open_prescene_is;
boolean open_scene_is;

void open_romanesco() {
  if(open_app_is()) {
    count_to_open = 0;
    open_controller_is = true;
    open_prescene_is =true;
    if(LIVE) {
      open_scene_is=true;
    }
    open_app_is(false);
  } else {
    count_to_open++;
    if(count_to_open > 10000) count_to_open = 0;
  }


  if(open_scene_is) {
    open_scene();
    open_scene_is=false;
  }

  if(open_prescene_is && count_to_open > time_to_open_prescene) {
    open_prescene();
    open_prescene_is=false;
  }

  if(open_controller_is && count_to_open > time_to_open_controller) {
    open_controller();
    open_controller_is=false;
  }
}



boolean open_app_is;
void open_app_is(boolean is) {
  open_app_is = is;
}

boolean open_app_is() {
  return open_app_is;
}


void open_prescene() {
  println("Prescene.app is launch, if it's possible");
  println("WARNING:\nin case Romanesco in not compiled,\nthe launcher set the size of windows only it cannot launch the app,\nafter it's necessary to run presecne.pde separately,\nthen run scene.pde if you want use it,\nthen run controller.pde");
  if(LIVE) {
    launch(path_prescene_live);
  } else {
    launch(path_prescene);
  }
}



void open_scene() {
  println("Scene.app is launch, if it's possible");
  println("WARNING:\nin case Romanesco in not compiled,\nthe launcher set the size of windows only it cannot launch the app,after it's necessary to run presecne.pde separately,\nthen run scene.pde if you want use it,\nthen run controller.pde");
  if(LIVE) {
    if(FULLSCREEN) {
      launch(path_scene_live_fullscreen);
    } else {
      launch(path_scene_live);
    }
  }
}


void open_controller() {
  println("Controller.app is launch, if it's possible");
  println("WARNING:\nin case Romanesco in not compiled,\nthe launcher set the size of windows only it cannot launch the app,\nafter it's necessary to run presecne.pde separately,\nthen run scene.pde if you want use it,\nthen run controller.pde");
  if(LIVE) { 
    launch(path_controller_live);
  } else {
    launch(path_controller);
  }
}
































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
  background(grisTresFonce);
}

color blanc, gris, grisClair, grisFonce, grisTresFonce, orange, rouge, rougeFonce, vertClair, vertFonce ;
void color_setup() {
  colorMode(HSB,360,100,100) ;
  blanc = color(0,0,95) ;
  grisClair = color (27,10, 70) ; //gris clair
  gris = color (27,20, 50) ; //gris
  grisFonce = color(0,0,40)  ;
  grisTresFonce = color(0,0,15)  ;
  orange = color (35,100,100) ;
  rouge = color(10,100,100) ;
  rougeFonce = color (10, 100, 70) ;
  vertClair = color (88,85,71) ; // vert clair
  vertFonce = color (90,93,46) ; // vert foncé
  c1 = color(orange) ;
  c2 = color(rougeFonce ) ;
  c3 = color(vertClair) ;
  c4 = color(vertFonce) ;
  //common data
  colorIN = color (vertClair ) ;
  colorOUT = color (vertFonce ) ;
}


void set_structure() {
  // renderer
  Vec2 pos_home = Vec2(100,40);
  Vec2 pos_live = Vec2 (180,40);
  Vec2 pos_mirror = Vec2 (240,40);

  Vec2 size_home = Vec2(85,20);
  Vec2 size_live = Vec2(85,20);
  Vec2 size_mirror = Vec2(85,20);

  renderer[0] = new Button(pos_home, size_home, c1, c2, c3, c4, "Home");
  renderer[1] = new Button(pos_live, size_live, c1, c2, c3, c4, "Live");
  renderer[2] = new Button(pos_mirror, size_mirror, c1, c2, c3, c4, "Mirror");
  
  
  // size and display type
  Vec2 pos_window = Vec2(10,70);
  Vec2 pos_fullscreen = Vec2(120,70);

  Vec2 size_window = Vec2(120,20);
  Vec2 size_fullscreen = Vec2(180,20);

  buttonWindow = new Button(pos_window, size_window, c1, c2, c3, c4, "Window");
  buttonFullscreen = new Button(pos_fullscreen, size_fullscreen, c1, c2, c3, c4, "Full Screen");
  
  // start
  Vec2 pos_start = Vec2(10, 190) ;
  Vec2 size_start = Vec2(210, 20) ;

  buttonStart = new Button(pos_start, size_start, colorIN, colorOUT, colorIN, colorOUT, "Launch Romanesco");

  //quantityScreen count the number of screen available
  GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
  GraphicsDevice[] devices = ge.getScreenDevices();
  int quantityScreen = devices.length;
  set_which_screen(quantityScreen, posWhichScreenButton) ;
  
  color colorBG = color(grisFonce);
  color colorBoxIn = color(vertFonce);
  color colorBoxOut = color(rougeFonce);
  
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
draw launcher
*/
void launcher_background() {
  background(grisTresFonce) ;
  fill(orange);
  textFont(FuturaStencil,20);
  fill(rougeFonce);
  rect(0,0, width,30);
  fill(orange);
  rect(0,30,width,2);
  fill(blanc);
  text(nameVersion, pos_name_version.x, pos_name_version.y);
}


void launcher() {
  textFont(text_info,14);
  text("version " +prettyVersion + "."+version, pos_pretty_version.x, pos_pretty_version.y);
  fill(grisClair) ;
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
  // 
  if(renderer_setting[2]) {
    bool_open_scene =("true") ; 
  } else {
    bool_open_scene =("false") ;
  } 
}







/**
LAUNCH
v 1.0.0
*/
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
    fill(orange) ;
    text("Please finish the configuration",10,210) ;
  }
}






/**
selected display rendering
*/
// choice your display WINDOW or FULLSCREEN
void fullscreen_or_window(boolean window_is, boolean fullscreen_is) {
  if(window_is) buttonWindow.displayButton();

  if(screenNum > 1 && fullscreen_is) {
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
ADDRESS IP for Mirror
*/
void addressLocal(float x, float y) {
  fill(orange) ;
  try {
    fill(grisClair) ;
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

  col[0] ="fullscreen";
  col[1] ="whichScreen";
  col[2] ="resizable"; 
  col[3] ="decorated";

  col[4] ="width";
  col[5] ="height";
  col[6] ="preview_width"; 
  col[7] ="preview_height";

  col[8] ="prescene_x"; 
  col[9] ="prescene_y";
  col[10] ="scene_x"; 
  col[11] ="scene_y";
  col[12] ="miroir";
  
  for(int i = 0 ; i < col.length ; i++) {
    properies.addColumn(col[i]);
  }
  
  TableRow newRow = properies.addRow();

  int which_screen = get_which_screen();

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
  newRow.setInt(col[1], which_screen);
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
    fill(rougeFonce) ;
    text("Width " + w, posSliderWidth.x, posSliderWidth.y +pos_y);
  } else {
    fill(vertFonce) ;
    text("Width " + w, posSliderWidth.x, posSliderWidth.y +pos_y);
  }
}

void size_window_height(int[] format_height, int pos_y) {
  sliderHeight.sliderUpdate() ;
  heightSlider = int(map(sliderHeight.getValue(),0,1,1,format_height.length))  ;
  String h = Integer.toString(format_height[heightSlider -1]) ;
  if (heightSlider <= 1 ) {
    fill(rougeFonce) ;
    text("Heigth " + h, posSliderHeight.x, posSliderHeight.y +pos_y);
  } else {
    fill(vertFonce) ;
    text("Heigth " + h, posSliderHeight.x, posSliderHeight.y +pos_y);
  }
}










/**
SCREEN
v 1.0.0
*/
int screenNum  ;
//SETUP 
void set_which_screen(int n , PVector infoPos) {
  //quantity of button choice
  screenNum = n ;
  whichScreenButton = new Button [screenNum] ;
  //position of the button  
  int x = (int)infoPos.x ;
  int y = (int)infoPos.y ;
  int space = (int)infoPos.z ;
  
  for ( int i = 0 ; i <  screenNum ; i++) {
    Vec2 pos = Vec2( x +( i *space), y ) ;
    Vec2 size = Vec2(20,20) ;
    String title = Integer.toString(i+1) ;
    whichScreenButton[i] = new Button(pos, size, c1, c2, c3, c4, title) ;
  }
}



void choice_screen_for_fullscreen() {
  fill(orange);
  text("on screen",10.,120.);
  which_screen();
}


void which_screen() {
  for(int i = 0 ; i < screenNum ; i++) {
    whichScreenButton[i].displayButton() ;
  }
}

//MOUSEPRESSED
void which_screen_pressed() {
  for(int i =0 ; i< screenNum ; i++ ) {
    if (whichScreenButton[i].inside ) {
      for( int j =0 ; j < screenNum ; j++ ) whichScreenButton[j].OnOff = false ;
    }
  }
}

//MOUSERELEASED
int screen_to_display;
void which_screen_released() {
 // screen_to_display = -1;
  for(int i = 0 ; i < screenNum ; i++ ) {
    whichScreenButton[i].mouseClic() ;
    if(whichScreenButton[i].OnOff) {
      screen_to_display = i;
    }
  }
}

//ID screen
int IDscreen = 0 ;
int get_which_screen() {
  for(int i = 0 ; i < screenNum ; i++ ) { 
    if(whichScreenButton[i].OnOff == true ) {
      IDscreen = i+1 ; 
    } else {
      IDscreen = 1 ;
    }
  }
  return IDscreen ;
}









