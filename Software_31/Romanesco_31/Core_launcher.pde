/**
CORE LAUNCHER
2014-2018
v 1.0.3
*/
/**
setup
*/
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
  Vec2 pos_home = Vec2(99, 40) ;
  Vec2 pos_live = Vec2 (200, 40) ;
  Vec2 pos_mirror = Vec2 (280, 40) ;

  Vec2 size_home = Vec2(85, 20) ;
  Vec2 size_live = Vec2(85, 20) ;
  Vec2 size_mirror = Vec2(85, 20) ;

  renderer[0] = new Button(pos_home, size_home, c1, c2, c3, c4, "Home") ;
  renderer[1] = new Button(pos_live, size_live, c1, c2, c3, c4, "Live") ;
  renderer[2] = new Button(pos_mirror, size_mirror, c1, c2, c3, c4, "Mirror") ;
  
  
  // size and display type
  Vec2 pos_window = Vec2(10, 70) ;
  Vec2 pos_fullscreen = Vec2(200, 70) ;

  Vec2 size_window = Vec2(180, 20) ;
  Vec2 size_fullscreen = Vec2(180, 20) ;

  buttonWindow = new Button(pos_window, size_window, c1, c2, c3, c4, "in Window") ;
  buttonFullscreen = new Button(pos_fullscreen, size_fullscreen, c1, c2, c3, c4, "in Fullscreen") ;
  
  // start
  Vec2 pos_start = Vec2(10, 190) ;
  Vec2 size_start = Vec2(210, 20) ;

  buttonStart = new Button(pos_start, size_start, colorIN, colorOUT, colorIN, colorOUT, "Launch Romanesco") ;

  //quantityScreen count the number of screen available
  int quantityScreen = devices.length ;
  whichScreenSetup(quantityScreen, posWhichScreenButton) ;
  
  color colorBG = color(grisFonce) ;
  color colorBoxIn = color(vertFonce) ;
  color colorBoxOut = color(rougeFonce) ;
  
  sliderWidth = new Slider(posSliderWidth, posMoletteWidth, sizeSlider, colorBG, colorBoxIn, colorBoxOut ) ;
  sliderWidth.sliderSetting() ;
  sliderHeight = new Slider(posSliderHeight, posMoletteHeight, sizeSlider, colorBG, colorBoxIn, colorBoxOut ) ;
  sliderHeight.sliderSetting() ;
}



void set_data() {
  FuturaStencil =loadFont ("FuturaStencilICG-20.vlw") ;
  EmigreEight = loadFont ("EmigreEight-14.vlw");

  String app_path = sketchPath("") ;

  path_controller = (app_path+"sources/Controleur_"+version+".app");
  // path to OPENING APP
  path_prescene_window = (app_path + "sources/Prescene_"+version+"_window.app");
  path_scene_window = (app_path+"sources/Scene_"+version+"_window.app");

  path_prescene_fullscreen  = (app_path+"sources/Prescene_"+version+"_fullscreen.app");
  path_scene_fullscreen = (app_path+"sources/Scene_"+version+"_fullscreen.app");

  String[] l = split( ("1"), " ") ;
  saveStrings(app_path+"sources/preferences/language.txt", l) ;
}





















/**
draw launcher
*/
void launcher_background() {
  background(grisTresFonce) ;
  fill(orange) ;
  textFont(FuturaStencil,20);
  fill(rougeFonce) ;
  rect(0,0, width, 30) ;
  fill(orange) ;
  rect(0,30,width,2) ;
  fill(blanc) ;
  text(nameVersion, pos_name_version.x, pos_name_version.y);
}


void launcher_update() {
  textFont(EmigreEight,14);
  text("Version " +prettyVersion + "."+version, pos_pretty_version.x, pos_pretty_version.y);
  fill(grisClair) ;
  textFont(FuturaStencil,20);

  text("Choice", pos_choice.x, pos_choice.y);
  choice_rendering() ;
  //fork choice menu
  for(int i = 0 ; i < num_renderer ; i++) {
     if (renderer[i].OnOff || renderer_setting[i]) {
      select_renderer_to_launch_app(i) ;
    }
  }
}




void choice_rendering() {
  for(int i = 0 ; i < num_renderer ; i++) {
    renderer[i].displayButton(renderer_setting[i]) ;
  }
  // 
  if(renderer_setting[2]) {
    bool_open_scene =("true") ; 
  } else {
    bool_open_scene =("false") ;
  } 
}







/**
LAUNCH
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
  launch_home = true ;
  fullscreen_or_window() ;
  ready_to_launch() ; 
}

void select_renderer_live(int which_one) {
  renderer_is(which_one) ;
  launch_home = false ;
  fullscreen_or_window() ;
  ready_to_launch() ; 
}


void select_renderer_mirror(int which_one) {
  renderer_is(which_one) ;
  launch_home = false ;
  fullscreen_or_window() ;
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
  if (buttonWhichScreenOnOff > 0 && buttonFullscreen.OnOff) {
    buttonStart.displayButton() ;
    // window mode the user must choice a window size  
  } else if ((buttonWindow.OnOff && heightSlider > 1 & widthSlider > 1) || (buttonWindow.OnOff && widthSlider > 1)) {
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
void fullscreen_or_window() {
  buttonWindow.displayButton() ;
  if(screenNum > 1 ) {
    buttonFullscreen.displayButton() ;
  }
  
  if (buttonWindow.OnOff) {
    path_scene = path_scene_window ;
    path_prescene = path_prescene_window ;

    // I think we used this method long time ago, when Processing is more cool with the fullscreen and size() management :)
    screen = ("false") ; 
  } else if (buttonFullscreen.OnOff) {
    path_scene = path_scene_fullscreen ;
    path_prescene = path_prescene_fullscreen ;

    // I think we used this method long time ago, when Processing is more cool with the fullscreen and size() management :)
    screen = ("true") ;
  }

  // I think we used this method long time ago, when Processing is more cool with the fullscreen and size() management :)
  if (buttonFullscreen.OnOff) {
    choice_screen_for_fullscreen() ;
  } else if (buttonWindow.OnOff) {
    screen = ("false") ;
    size_window() ;
  }
}


// OPEN APP
boolean launch_home ;
void openApp() {
  if(launch_home) {
    println("Prescene is launch") ;
    launch(path_prescene) ;
    launch_controller = true ;
  } else {
    println("Scene is launch") ;
    launch(path_scene) ;
  }
}

boolean launch_controller ;
int time_to_open_controller = 180 ;
int count_to_open_controller = 0 ;
void open_controller() {
  if(launch_controller) {
    count_to_open_controller++ ;
    if(count_to_open_controller > time_to_open_controller) {
      launch_controller = false ;
      count_to_open_controller = 0 ;
      println("Controller is launch") ;
      launch(path_controller) ;
    }
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
    text (java.net.InetAddress.getLocalHost().getHostAddress(), x+188,y) ;
  }
  catch(Exception e) {}
}























/**
SAVE DISPLAY PROPERTY
v 0.2.0
*/
// Table sceneProperty;
void save_app_properties() {
  Table properies = new Table();
  String[] col = new String[9];

  col[0] ="fullscreen";
  col[1] ="whichScreen";
  col[2] ="resizable"; 
  col[3] ="decorated"; 
  col[4] ="width";
  col[5] ="height";
  col[6] ="preview_width"; 
  col[7] ="preview_height";
  col[8] ="miroir";
  
  for(int i = 0 ; i < col.length ; i++) {
    properies.addColumn(col[i]);
  }
  
  TableRow newRow = properies.addRow();
  int whichScreen = 0 ;
  whichScreen = IDscreenSelected() ;
  
  newRow.setString(col[0], screen);
  newRow.setInt(col[1], whichScreen);
  newRow.setString(col[2], "true"); 
  newRow.setString(col[3], "true"); 
  newRow.setInt(col[4], standard_size_width[widthSlider-1]);
  newRow.setInt(col[5], standard_size_height[heightSlider -1]);
  newRow.setInt(col[6], 500);
  newRow.setInt(col[7], 350);
  newRow.setString(col[8],bool_open_scene);

  String path = sketchPath(1)+"/sources/preferences/sceneProperty.csv";
  println(path);
  println(standard_size_width[widthSlider-1],standard_size_height[heightSlider -1]);
  saveTable(properies, path);
}






















