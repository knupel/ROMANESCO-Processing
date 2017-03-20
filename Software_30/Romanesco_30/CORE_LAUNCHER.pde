/**
CORE LAUNCHER 1.0.2
*/

/**
setup
*/
void diplaySetup() {
  background(grisTresFonce);
}

color blanc, gris, grisClair, grisFonce, grisTresFonce, orange, rouge, rougeFonce, vertClair, vertFonce ;
void colorSetup() {
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
  EmigreEight = loadFont ("EmigreEight-14.vlw") ;

  path_controller = (sketchPath("") + "sources/Controleur_"+version+".app");
  // path to OPENING APP
  // window
  if(resize_bug) {
    int id_app = widthSlider-1 ;
    if(id_app == 1) {
      path_prescene_window = (sketchPath("") + "sources/Prescene_"+version+"_window_640.app");
      path_scene_window = (sketchPath("") + "sources/Scene_"+version+"_window_640.app");
    } else if (id_app == 2) {
      path_prescene_window = (sketchPath("") + "sources/Prescene_"+version+"_window_1024.app");
      path_scene_window = (sketchPath("") + "sources/Scene_"+version+"_window_1024.app");
    } else if (id_app == 3) {
      path_prescene_window = (sketchPath("") + "sources/Prescene_"+version+"_window_1280.app");
      path_scene_window = (sketchPath("") + "sources/Scene_"+version+"_window_1280.app");
    } else if (id_app == 4) {
      path_prescene_window = (sketchPath("") + "sources/Prescene_"+version+"_window_1600.app");
      path_scene_window = (sketchPath("") + "sources/Scene_"+version+"_window_1600.app");
    } else if (id_app == 5) {
      path_prescene_window = (sketchPath("") + "sources/Prescene_"+version+"_window_1920.app");
      path_scene_window = (sketchPath("") + "sources/Scene_"+version+"_window_1920.app");
    } else if (id_app == 6) {
      path_prescene_window = (sketchPath("") + "sources/Prescene_"+version+"_window_2560.app");
      path_scene_window = (sketchPath("") + "sources/Scene_"+version+"_window_2560.app");
    } else if (id_app == 7) {
      path_prescene_window = (sketchPath("") + "sources/Prescene_"+version+"_window_3840.app");
      path_scene_window = (sketchPath("") + "sources/Scene_"+version+"_window_3840.app");
    }
  } else {
    path_prescene_window = (sketchPath("") + "sources/Prescene_"+version+"_window.app");
    path_scene_window = (sketchPath("") + "sources/Scene_"+version+"_window.app");
  }
  // fullscreen
  path_prescene_fullscreen  = (sketchPath("") + "sources/Prescene_"+version+"_fullscreen.app");
  path_scene_fullscreen = (sketchPath("") + "sources/Scene_"+version+"_fullscreen.app");

  String[] l = split( ("1"), " ") ;
  saveStrings(sketchPath("")+"sources/preferences/language.txt", l) ;
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
  } else if ((buttonWindow.OnOff && heightSlider > 1 & widthSlider > 1) || (buttonWindow.OnOff && resize_bug & widthSlider > 1)) {
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
SAVE DISPLAY PROPERTY

a lot of datas here ara deprecated, but I'm very lazzy to manage that !
*/
Table sceneProperty;
String pathScenePropertySetting = sketchPath("")+"sources/preferences/sceneProperty.csv" ;

void saveProperty() {
  sceneProperty = new Table();
  String colOne =("fullscreen");
  String colTwo =("whichScreen");
  String colThree =("resizable"); // obsolete
  String colFour =("decorated"); // obsolete
  String colFive =("width");
  String colSix =("height");
  String colSeven =("render"); // obsolete
  String colHeight =("miroir");
  
  sceneProperty.addColumn(colOne);
  sceneProperty.addColumn(colTwo);
  sceneProperty.addColumn(colThree); // obsolete
  sceneProperty.addColumn(colFour); // obsolete
  sceneProperty.addColumn(colFive);
  sceneProperty.addColumn(colSix);
  sceneProperty.addColumn(colSeven); // obsolete
  sceneProperty.addColumn(colHeight);
  
  TableRow newRow = sceneProperty.addRow();
  int whichScreen = 0 ;
  whichScreen = IDscreenSelected() ;
  
  newRow.setString(colOne, screen);
  newRow.setInt(colTwo, whichScreen);
  newRow.setString(colThree, "true"); // obsolete
  newRow.setString(colFour, "true"); // obsolete
  newRow.setInt(colFive, standard_size_width[widthSlider-1]);
  newRow.setInt(colSix, standard_size_height[heightSlider -1]);
  newRow.setString(colSeven, "P3D"); // obsolete
  newRow.setString(colHeight, bool_open_scene);
  //
  saveTable(sceneProperty, pathScenePropertySetting);
}
// END SAVE PROPERTY
////////////////////













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