import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 
import java.awt.*; 
import java.awt.Font; 
import java.awt.image.BufferedImage; 
import java.awt.FontMetrics; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Romanesco_30 extends PApplet {

/**
Romanesco Unu
2013 \u2013 2017
version 1.2.0 
release 30 
Processing 3.2.4 
*/
/**
2015 730 lines of code the 4th may !!!! 
2016 830 lines may 2016
 */
String version = ("30") ;
String prettyVersion = ("1.2.0") ;
String nameVersion = ("Romanesco Unu") ;

/**
use this trick to export in 64 bits
lighter application only 46M versus 164M
*/



public void settings() {
  size(400, 220);
}


public void setup() {
  colorSetup() ;
  diplaySetup() ;
  
  set_structure() ;
  set_data() ;
}



public void draw() {
  surface.setTitle(nameVersion + " " +prettyVersion+"."+version+ " - Launcher");
  if(resize_bug) {
    set_data() ;
  }
  launcher_background() ;
  launcher_update() ;
  open_controller() ;
}









//MOUSEPRESSED
public void mousePressed() {
  //which type of SCENE display full screen or window
  //to re-init the button
  if (buttonFullscreen.inside || buttonWindow.inside || renderer[0].inside || renderer[1].inside || renderer[2].inside) {
    for(int i = 0 ; i < renderer.length ; i++) {
      renderer[i].OnOff = false ;
    }
    /*
    buttonScene.OnOff = false ;
    buttonMiroir.OnOff = false ;
    */
    buttonFullscreen.OnOff = false ;
    buttonWindow.OnOff = false ;
  }
  // after the re-init we can check what's happen on the button
  for(int i = 0 ; i < renderer.length ; i++) {
    renderer[i].mouseClic() ;
  }
  /*
  buttonScene.mouseClic() ;
  buttonMiroir.mouseClic() ;
  */
  buttonFullscreen.mouseClic() ;
  buttonWindow.mouseClic() ;
  
  //which screen for the fullscreen mode
  if(buttonFullscreen.OnOff) whichScreenPressed() ;
  
  //button start
  buttonStart.mouseClic() ;
  if(buttonStart.OnOff ) {
    saveProperty() ;
    openApp() ;
  }
  buttonStart.OnOff = false ;
}


//MOUSELEASED
public void mouseReleased() {
  if(buttonFullscreen.OnOff) whichScreenReleased() ;
}
/**
BUTTON 2.0.0
*/
class Button
{
  boolean inside, OnOff ;
  Vec2 pos, size ;
  int On_In, On_Out, Off_In, Off_Out ;
  String textOn, textOff ;
  
  //CONSTRUCTOR
  
  //basic Button
  Button(Vec2 pos, Vec2 size) {
    Off_In = color (27,100,100) ; //orange
    Off_Out = color (9,100,70) ; //rouge
    On_In = color (88,85,71) ; // vert clair
    On_Out = color (90,93,46) ; // vert fonc\u00e9
    this.pos = pos ;
    this.size = size ;
  }
  //with specific color
  Button(Vec2 pos, Vec2 size, int Off_In, int Off_Out, int On_In, int On_Out) {
    this.Off_In = Off_In ;
    this.Off_Out = Off_Out ;
    this.On_In = On_In ; 
    this.On_Out = On_Out ;
    this.pos = pos ;
    this.size = size ;
  }
  
  //text Button with two text
  Button(Vec2 pos, Vec2 size, String textOn, String textOff) {
    Off_In = color (27,100,100) ; //orange
    Off_Out = color (9,100,70) ; //rouge
    On_In = color (88,85,71) ; // vert clair
    On_Out = color (90,93,46) ; // vert fonc\u00e9
    this.textOn = textOn ;
    this.textOff = textOff ;
    this.pos = pos ;
    this.size = size ;
  }
  //text button with specific color with two text
  Button(Vec2 pos, Vec2 size, int Off_In, int Off_Out, int On_In, int On_Out, String textOn, String textOff) {
    this.Off_In = Off_In ;
    this.Off_Out = Off_Out ;
    this.On_In = On_In ; 
    this.On_Out = On_Out ;
    this.textOn = textOn ;
    this.textOff = textOff ;
    this.pos = pos ;
    this.size = size ;
  }
    //text button with specific color with one text
  Button(Vec2 pos, Vec2 size, int Off_In, int Off_Out, int On_In, int On_Out, String textOn) {
    this.Off_In = Off_In ;
    this.Off_Out = Off_Out ;
    this.On_In = On_In ; 
    this.On_Out = On_Out ;
    this.textOn = textOn ;
    this.textOff = textOn ;
    this.pos = pos ;
    this.size = size ;
  }
  
  
  public void displayButton() {
    String textResult ;
    if(OnOff) {
      textResult = textOn ;
      if(insideRect()) fill(On_In) ; else fill (On_Out ) ;
    } else {
      textResult = textOff ;
      if(insideRect()) fill(Off_In) ; else fill (Off_Out ) ;
    }
      
    if (textOff != null || textOn != null ) {
      textSize(size.y) ;
      text(textResult, pos.x, pos.y + size.y ) ; 
    } else {
      rect(pos, size) ;
    }
  }
  
  //indicate if this one is on or off
  public void displayButton(boolean off) {
    String textResult ;
    if(OnOff || off) {
      textResult = textOn ;
      if(insideRect()) fill(On_In) ; else fill (On_Out ) ;
    } else {
      textResult = textOff ;
      if(insideRect()) fill(Off_In) ; else fill (Off_Out ) ;
    }
      
    if (textOff != null || textOn != null ) {
      textSize(size.y) ;
      text(textResult, pos.x, pos.y + size.y ) ; 
    } else {
      rect(pos, size) ;
    }
  }
  
  
  
  
  
  //COMMON VOID
  //ANNEXE VOID
  //detection cursor on area
  //rect
  public boolean insideRect() { 
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y  && mouseY < pos.y + size.y ) inside = true ; else inside = false ;
    return inside ;
  }

  //ellipse
  public boolean insideEllipse() {
    float disX = pos.x -mouseX ; 
    float disY = pos.y -mouseY  ; 
    if (sqrt(sq(disX) + sq(disY)) < size.x/2 ) inside = true ; else inside = false ;
    return inside ;
  }
 
  //MOUSEPRESSED
  public void mouseClic() {
    if (insideRect()) if (!OnOff)  OnOff = !OnOff ;
  } 
  
}
class Slider
{
  private PVector pos, size, posText, posMol, sizeMol, newPosMol, posMin, posMax ;
  private int slider, boxIn, boxOut, colorText ;
  private boolean molLocked, inside ;
  private PFont p ;
  
  //CONSTRUCTOR with title
  public Slider(PVector pos, PVector posMol , PVector size, PVector posText, int slider, int boxIn, int boxOut, int colorText, PFont p) {
    this.pos = pos ;
    this.posMol = posMol ;
    this.size = size ;
    this.posText = posText ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;
    this.colorText = colorText ;
    this.p = p ;

    newPosMol = new PVector (0, 0) ;
    //which molette for slider horizontal or vertical
    if ( size.x >= size.y ) sizeMol = new PVector (size.y, size.y ) ; else sizeMol = new PVector (size.x, size.x ) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
  
  //CONSTRUCTOR minimum
  public Slider(PVector pos, PVector posMol , PVector size, int slider, int boxIn, int boxOut ) {
    this.pos = pos ;
    this.posMol = posMol ;
    this.size = size ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;

    newPosMol = new PVector (0, 0) ;
    //which molette for slider horizontal or vertical
    if ( size.x >= size.y ) sizeMol = new PVector (size.y, size.y ) ; else sizeMol = new PVector (size.x, size.x ) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
  
  //slider with external molette
  public Slider(PVector pos, PVector posMol , PVector size, PVector sizeMol,  int slider, int boxIn, int boxOut ) {
    this.pos = pos ;
    this.posMol = posMol ;
    this.sizeMol = sizeMol ;
    this.size = size ;
    this.slider = slider ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;

    newPosMol = new PVector (0, 0) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
  
  //SETTING
  
  public void sliderSetting() {
    noStroke() ;
    
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    
    //MOLETTE
    fill(boxOut) ;
    newPosMol = new PVector (posMol.x, posMol.y  ) ;
    rect(posMol.x, posMol.y, sizeMol.x, sizeMol.y ) ;
    
  }
  
  //Slider update with title
  public void sliderUpdate(String s, boolean t) {
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    if (t) {
      fill(colorText) ;
      textFont (p ) ;
      textSize (posText.z) ;
      text(s, posText.x, posText.y ) ;
    }
    //MOLETTE
    if (insideRect()) fill(boxIn); else fill(boxOut ) ;
    moletteUpdate() ;
    rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
  }
  //Slider update simple
  public void sliderUpdate() {
    //SLIDER
    fill(slider) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    /*
    if (t) {
      fill(colorText) ;
      textFont (p ) ;
      textSize (posText.z) ;
      text(s, posText.x, posText.y ) ;
    }
    */
    //MOLETTE
    if (insideRect()) fill(boxIn); else fill(boxOut ) ;
    moletteUpdate() ;
    rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
  }
  
  
  public void moletteUpdate() {
    if (locked ()  ) molLocked = true ;
    if (!mousePressed)  molLocked = false ; 
      
    if ( molLocked ) {  
      if ( size.x >= size.y ) newPosMol.x = constrain(mouseX -(sizeMol.x / 2.0f ), posMin.x, posMax.x)  ; else newPosMol.y = constrain(mouseY -(sizeMol.y / 2.0f ), posMin.y, posMax.y) ;
    }
  }
  
  //RETURN
  public float getValue() {
    float value ;
    if ( size.x >= size.y ) value = map (newPosMol.x, posMin.x, posMax.x, 0,1) ; else value = map (newPosMol.y, posMin.y, posMax.y, 0,1) ;
    return value ;
  }
  
  
  //COMMON VOID
  //ANNEXE VOID
  //rect
  public boolean insideRect() { 
    if ( mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y  && mouseY < pos.y + size.y ) {
      inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }

  //ellipse
  public boolean insideEllipse() {
    float disX = pos.x -mouseX ; 
    float disY = pos.y -mouseY  ; 
    if (sqrt(sq(disX) + sq(disY)) < size.x/2 ) {
     inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }
  
  //locked
  public boolean locked () {
    if ( inside  && mousePressed ) return true ; else return false ;
  }
}



PVector pos_local_adress = new PVector(10,180) ;
PVector pos_name_version = new PVector(10.0f, 23.0f) ;
PVector pos_pretty_version = new PVector(205.0f, 23.0f) ;
PVector pos_choice = new PVector(10.0f, 60.0f) ;


int num_renderer = 3 ;
//Home / Live / Mirror



//which size for window
PVector posSliderWidth = new PVector(10, 134) ;
PVector posMoletteWidth = posSliderWidth ;
PVector posSliderHeight = new PVector(200, 134) ;
PVector posMoletteHeight = posSliderHeight ;
PVector sizeSlider = new PVector (180, 16 ) ;
//button start
/*
PVector posButtonStart = new PVector (10, 190) ;
PVector sizeButtonStart = new PVector (210, 20) ;
*/
// "X" and  "Y" componant give the button position    "Z" componant = space between the button
PVector posWhichScreenButton = new PVector (150, 100, 23) ;

int [] standard_format_for_Processing_bug = {0,800,1024,1600,1920,2560,3840} ;

int [] standard_size_width = {160,240,320,480,640,800,964,1024,1280,1344,1366,1400,1440,1600,1680,1920,2048,2560,2880,3840,4096,5120,6400,7680,8192,16384} ;
int [] standard_size_height = {120,160,240,320,480,544,576,600,640,720,768,800,900,960,1000,1008,1024,1050,1080,1200,1536,1600,1800,2048,2304,2400,2880,3072,4096,4320,4800,6144,12288} ;




boolean test = false ;


PFont FuturaStencil, EmigreEight ;


GraphicsEnvironment g = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] devices = g.getScreenDevices();


int c1, c2, c3, c4 ;
int colorOUT, colorIN ;

// path
String path_controller;
String path_prescene ;
String path_prescene_window, path_prescene_fullscreen ;
String path_scene ;
String path_scene_window, path_scene_fullscreen ;

boolean open ;

//
String screen = ("") ; // for the saved table information
String bool_open_scene = ("") ; // for the saved table information
// Button buttonScene, buttonMiroir  ;

Button [] renderer = new Button [num_renderer] ;
boolean [] renderer_setting = new boolean[num_renderer] ;

Button buttonWindow, buttonFullscreen  ;

//which screen var
Button [] whichScreenButton ;
//slider var
Slider sliderWidth, sliderHeight ;
int heightSlider =1 ;
int widthSlider = 1 ;
//which mode rendering
Button [] whichModeButton ;
//Button start
Button buttonStart ;
/**
CORE LAUNCHER 1.0.1
*/

/**
setup
*/
public void diplaySetup() {
  background(grisTresFonce);
}

int blanc, gris, grisClair, grisFonce, grisTresFonce, orange, rouge, rougeFonce, vertClair, vertFonce ;
public void colorSetup() {
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
  vertFonce = color (90,93,46) ; // vert fonc\u00e9
  c1 = color(orange) ;
  c2 = color(rougeFonce ) ;
  c3 = color(vertClair) ;
  c4 = color(vertFonce) ;
  //common data
  colorIN = color (vertClair ) ;
  colorOUT = color (vertFonce ) ;
}


public void set_structure() {
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

  buttonWindow = new Button(pos_window, size_window, c1, c2, c3, c4, "in the Window") ;
  buttonFullscreen = new Button(pos_fullscreen, size_fullscreen, c1, c2, c3, c4, "in Fullscreen") ;
  
  // start
  Vec2 pos_start = Vec2(10, 190) ;
  Vec2 size_start = Vec2(210, 20) ;

  buttonStart = new Button(pos_start, size_start, colorIN, colorOUT, colorIN, colorOUT, "Launch Romanesco") ;

  //quantityScreen count the number of screen available
  int quantityScreen = devices.length ;
  whichScreenSetup(quantityScreen, posWhichScreenButton) ;
  
  int colorBG = color(grisFonce) ;
  int colorBoxIn = color(vertFonce) ;
  int colorBoxOut = color(rougeFonce) ;
  
  sliderWidth = new Slider(posSliderWidth, posMoletteWidth, sizeSlider, colorBG, colorBoxIn, colorBoxOut ) ;
  sliderWidth.sliderSetting() ;
  sliderHeight = new Slider(posSliderHeight, posMoletteHeight, sizeSlider, colorBG, colorBoxIn, colorBoxOut ) ;
  sliderHeight.sliderSetting() ;
}



public void set_data() {
  FuturaStencil =loadFont ("FuturaStencilICG-20.vlw") ;
  EmigreEight = loadFont ("EmigreEight-14.vlw") ;

  path_controller = (sketchPath("") + "sources/Controleur_"+version+".app");
  // path to OPENING APP
  // window
  if(resize_bug) {
    int id_app = widthSlider-1 ;
    if(id_app == 1) {
      path_prescene_window = (sketchPath("") + "sources/Prescene_"+version+"_window_tiny.app");
      path_scene_window = (sketchPath("") + "sources/Scene_"+version+"_window_tiny.app");
    } else if (id_app == 2) {
      path_prescene_window = (sketchPath("") + "sources/Prescene_"+version+"_window_small.app");
      path_scene_window = (sketchPath("") + "sources/Scene_"+version+"_window_small.app");
    } else if (id_app == 3) {
      path_prescene_window = (sketchPath("") + "sources/Prescene_"+version+"_window_medium.app");
      path_scene_window = (sketchPath("") + "sources/Scene_"+version+"_window_medium.app");
    } else if (id_app == 4) {
      path_prescene_window = (sketchPath("") + "sources/Prescene_"+version+"_window_standard.app");
      path_scene_window = (sketchPath("") + "sources/Scene_"+version+"_window_standard.app");
    } else if (id_app == 5) {
      path_prescene_window = (sketchPath("") + "sources/Prescene_"+version+"_window_big.app");
      path_scene_window = (sketchPath("") + "sources/Scene_"+version+"_window_big.app");
    } else if (id_app == 6) {
      path_prescene_window = (sketchPath("") + "sources/Prescene_"+version+"_window_huge.app");
      path_scene_window = (sketchPath("") + "sources/Scene_"+version+"_window_huge.app");
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
public void launcher_background() {
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


public void launcher_update() {
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




public void choice_rendering() {
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
public void select_renderer_to_launch_app(int which_one) {
  if(which_one == 0) {
    select_renderer_home(which_one) ;
  } else if(which_one == 1) {
    select_renderer_live(which_one) ;
  } else if(which_one == 2) {
    select_renderer_live(which_one) ;
  }
}

public void select_renderer_home(int which_one) {
  renderer_is(which_one) ;
  launch_home = true ;
  fullscreen_or_window() ;
  ready_to_launch() ; 
}

public void select_renderer_live(int which_one) {
  renderer_is(which_one) ;
  launch_home = false ;
  fullscreen_or_window() ;
  ready_to_launch() ; 
}


public void select_renderer_mirror(int which_one) {
  renderer_is(which_one) ;
  launch_home = false ;
  fullscreen_or_window() ;
  addressLocal(pos_local_adress.x,pos_local_adress.y) ;
  ready_to_launch() ;
}

public void renderer_is(int which_one) {
  for(int i = 0 ; i < num_renderer ; i++) {
    if(i == which_one) {
      renderer_setting[i] = true ;
    } else {
      renderer_setting[i] = false ;
    }
  }  
}

public void ready_to_launch() {
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
public void fullscreen_or_window() {
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
public void openApp() {
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

public void open_controller() {
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

public void saveProperty() {
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
public void addressLocal(float x, float y) {
  fill(orange) ;
  try {
    fill(grisClair) ;
    text("local address", x,y ) ;
    text (java.net.InetAddress.getLocalHost().getHostAddress(), x+188,y) ;
  }
  catch(Exception e) {}
}
/**
SIZE WINDOW
actually there is bug with Processing for the resize window in P3D, so we need to
create few apps dedicated and launch... that's growth the size of the zip file...
C'est la vie...
We mut use the boolean to indicate to the launcher, the problem after that it's possible to choice which app must be launch
*/
boolean resize_bug = true ;

public void size_window() {
  int correctionPosY = -14 ;
  size_window_width(standard_format_for_Processing_bug, correctionPosY) ;
  /**
  This lines bellow must use when the bug will be fix !!!!
  */
  // size_window_width(standard_size_width, correctionPosY) ;
  //size_window_height(standard_size_height, correctionPosY) ;
}

public void size_window_width(int [] format_width, int pos_y) {
  sliderWidth.sliderUpdate() ;
  widthSlider = PApplet.parseInt(map(sliderWidth.getValue(),0,1,1,format_width.length))  ;
  String w = Integer.toString(format_width[widthSlider-1]) ;
  if (widthSlider <= 1 ) {
    fill(rougeFonce) ;
    text("Width " + w, posSliderWidth.x, posSliderWidth.y +pos_y);
  } else {
    fill(vertFonce) ;
    text("Width " + w, posSliderWidth.x, posSliderWidth.y +pos_y);
  }
}

public void size_window_height(int[] format_height, int pos_y) {
  sliderHeight.sliderUpdate() ;
  heightSlider = PApplet.parseInt(map(sliderHeight.getValue(),0,1,1,format_height.length))  ;
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
*/
int screenNum  ;
//SETUP 
public void whichScreenSetup(int n , PVector infoPos) {
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



public void choice_screen_for_fullscreen() {
/**
    With Processing 3.0b7 we cannot use this method to choose on which screen display the full screen
    On which screen display the window
    fill(orange) ;
    text("on screen", 10.0, 120.0);
    whichScreenDraw() ;
    */
    /**
    // Instead to use fullscreen method choice, we say is always true
    */
    buttonWhichScreenOnOff = 1 ;
}


public void whichScreenDraw() {
  for(int i = 0 ; i <screenNum ; i++) {
    whichScreenButton[i].displayButton() ;
  }
}

//MOUSEPRESSED
public void whichScreenPressed() {
  for(int i =0 ; i< screenNum ; i++ ) {
    if (whichScreenButton[i].inside ) {
      for( int j =0 ; j < screenNum ; j++ ) whichScreenButton[j].OnOff = false ;
    }
  }
}

//MOUSERELEASED
int buttonWhichScreenOnOff ;

public void whichScreenReleased() {
  buttonWhichScreenOnOff = 0 ;
  for(int i = 0 ; i<screenNum ; i++ ) {
    whichScreenButton[i].mouseClic() ;
    if(whichScreenButton[i].OnOff) buttonWhichScreenOnOff += 1 ;
  }
}

//ID screen
int IDscreen = 0 ;
public int IDscreenSelected() {
  for (int i = 0 ; i < screenNum ; i++ ) { 
    if (whichScreenButton[i].OnOff == true ) IDscreen = i+1 ; else IDscreen = 1 ;
  }
  return IDscreen ;
}
/**
RPE UTILS 1.17.4.0
RPE \u2013 Romanesco Processing Environment \u2013 2015 \u2013 2016
* @author Stan le Punk
* @see https://github.com/StanLepunK/Utils
*/

/**
CONSTANT NUMBER must be here to be generate before all

*/
final float PHI = (1 + sqrt(5))/2; //a number of polys use the golden ratio...
final float ROOT2 = sqrt(2); //...and the square root of two, the famous first irrationnal number by Pythagore
final float EULER = 2.718281828459045235360287471352f; // Constant d'Euler
// about constant https://en.wikipedia.org/wiki/Mathematical_constant
/**
TABLE METHOD
for Table with the first COLLUMN is used for name and the next 6 for the value.
The method is used with the Class Info

*/
// table method for row sort
public void buildTable(Table table, TableRow [] tableRow, String [] col_name, String [] row_name) {
  // add col
  for(int i = 0 ; i < col_name.length ; i++) {
    table.addColumn(col_name[i]);
  }
  // add row
  tableRow = new TableRow[row_name.length] ;
  buildRow(table, row_name) ;
}

public void buildTable(Table table, String [] col_name) {
  // add col
  for(int i = 0 ; i < col_name.length ; i++) {
    table.addColumn(col_name[i]);
  }
}

public void buildRow(Table table, String [] row_name) {
  int num_row = table.getRowCount() ;
  for(int i = 0 ; i < num_row ; i++) {
    TableRow row = table.getRow(i) ;
    row.setString(table.getColumnTitle(0), row_name[i]) ; 
  }
}

public void setTable(Table table, TableRow [] rows, Info_obj... info) {
  for(int i = 0 ; i < rows.length ; i++) {
    if(rows[i] != null) {
      for(int j = 0 ; j < info.length ; j++) {
        if(info[j] != null && info[j].get_name().equals(rows[i].getString(table.getColumnTitle(0)))) {
          if(table.getColumnCount() > 1 && info[j].catch_a() != null)  write_row(rows[i], table.getColumnTitle(1), info[j].catch_a()) ;
          if(table.getColumnCount() > 2 && info[j].catch_b() != null)  write_row(rows[i], table.getColumnTitle(2), info[j].catch_b()) ;
          if(table.getColumnCount() > 3 && info[j].catch_c() != null)  write_row(rows[i], table.getColumnTitle(3), info[j].catch_c()) ;
          if(table.getColumnCount() > 4 && info[j].catch_d() != null)  write_row(rows[i], table.getColumnTitle(4), info[j].catch_d()) ;
          if(table.getColumnCount() > 5 && info[j].catch_e() != null)  write_row(rows[i], table.getColumnTitle(5), info[j].catch_e()) ;
          if(table.getColumnCount() > 6 && info[j].catch_f() != null)  write_row(rows[i], table.getColumnTitle(6), info[j].catch_f()) ;
        }
        
      }
    }
  }
}


public void setRow(Table table, Info_obj info) {
  TableRow result = table.findRow(info.get_name(), table.getColumnTitle(0)) ;
  if(result != null) {
    if(table.getColumnCount() > 1 && info.catch_a() != null)  write_row(result, table.getColumnTitle(1), info.catch_a()) ;
    if(table.getColumnCount() > 2 && info.catch_b() != null)  write_row(result, table.getColumnTitle(2), info.catch_b()) ;
    if(table.getColumnCount() > 3 && info.catch_c() != null)  write_row(result, table.getColumnTitle(3), info.catch_c()) ;
    if(table.getColumnCount() > 4 && info.catch_d() != null)  write_row(result, table.getColumnTitle(4), info.catch_d()) ;
    if(table.getColumnCount() > 5 && info.catch_e() != null)  write_row(result, table.getColumnTitle(5), info.catch_e()) ;
    if(table.getColumnCount() > 6 && info.catch_f() != null)  write_row(result, table.getColumnTitle(6), info.catch_f()) ;
  }
}

public void write_row(TableRow row, String col_name, Object o) {
  if(o instanceof String) {
    String s = (String) o ;
    row.setString(col_name, s);
  } else if(o instanceof Short) {
    short sh = (Short) o ;
    row.setInt(col_name, sh);
  } else if(o instanceof Integer) {
    int in = (Integer) o ;
    row.setInt(col_name, in);
  } else if(o instanceof Float) {
    float f = (Float) o ;
    row.setFloat(col_name, f);
  } else if(o instanceof Character) {
    char c = (Character) o ;
    String s = Character.toString(c) ;
    row.setString(col_name, s);
  } else if(o instanceof Boolean) {
    boolean b = (Boolean) o ;
    String s = Boolean.toString(b) ;
    row.setString(col_name, s);
  } 
}






/**
print tempo

*/
public void printTempo(int tempo, Object... var) {
  if(frameCount%tempo == 0 ) {
    println(var) ;
  }
}







/**
Class info 0.2.2

*/
public class Info_dict {
  ArrayList<Info> list ;
  char type_list = 'o' ;

  Info_dict(char type_list) {
    this.type_list = type_list ;

  }

  Info_dict() {
    list = new ArrayList<Info>() ;
  }

  // add Object
  public void add(String name, Object a) {
    Info_obj info = new Info_obj(name, a) ;
    list.add(info) ;
  }
  public void add(String name, Object a, Object b) {
    Info_obj info = new Info_obj(name, a,b) ;
    list.add(info) ;
  }
  public void add(String name, Object a, Object b, Object c) {
    Info_obj info = new Info_obj(name, a,b,c) ;
    list.add(info) ;
  }
  public void add(String name, Object a, Object b, Object c, Object d) {
    Info_obj info = new Info_obj(name, a,b,c,d) ;
    list.add(info) ;
  }
  public void add(String name, Object a, Object b, Object c, Object d, Object e) {
    Info_obj info = new Info_obj(name, a,b,c,d,e) ;
    list.add(info) ;
  }
  public void add(String name, Object a, Object b, Object c, Object d, Object e, Object f) {
    Info_obj info = new Info_obj(name, a,b,c,d,e,f) ;
    list.add(info) ;
  }
 
  /**
  read
  */  
  public void read() {
    for(Info a : list) {
      println(a, type(type_list)) ;
    }
  }
  /**
  check type
  */ 
  public String type (char type)  {
    String t = ("Unknow") ;
    if(type == 'i') t = "Integer" ;
    else if(type == 's') t = "String" ;
    else if(type == 'f') t = "Float" ;
    else if(type == 'o') t = "Object" ;
    else if(type == 'v') t = "Vec" ;
    else t = ("Unknow") ;
    return t ;
  }
  
  /**
  get
  */
  public Info get(int target) {
    if(target < list.size() && target >= 0) {
      return list.get(target) ;
    } else return null ;
  }
  
  public Info [] get(String which) {
    Info [] info  ;
    int count = 0 ;
    for(Info a : list) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info[count] ;
      count = 0 ;
      for(Info a : list) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_String[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }
  /**
  clear
  */
  public void clear() {
    list.clear() ;
  }
  /**
  remove
  */
  public void remove(String which) {
    for(int i = 0 ; i < list.size() ; i++) {
      Info a = list.get(i) ;
      if(a.get_name().equals(which)) {
        list.remove(i) ;
      }
    }
  }
  
  public void remove(int target) {
   if(target < list.size()) {
      list.remove(target) ;
    }
  }
}

/**
Info_int_dict

*/
public class Info_int_dict extends Info_dict {
  ArrayList<Info_int> list_int ;
  Info_int_dict() {
    super('i') ;
    list_int = new ArrayList<Info_int>() ;
  }


  // add int
  public void add(String name, int a) {
    Info_int info = new Info_int(name, a) ;
    list_int.add(info) ;
  } 
  public void add(String name, int a, int b) {
    Info_int info = new Info_int(name, a,b) ;
    list_int.add(info) ;
  } 

  public void add(String name, int a, int b, int c) {
    Info_int info = new Info_int(name, a,b,c) ;
    list_int.add(info) ;
  } 
  public void add(String name, int a, int b, int c, int d) {
    Info_int info = new Info_int(name, a,b,c,d) ;
    list_int.add(info) ;
  } 
  public void add(String name, int a, int b, int c, int d, int e) {
    Info_int info = new Info_int(name, a,b,c,d,e) ;
    list_int.add(info) ;
  } 
  public void add(String name, int a, int b, int c, int d, int e, int f) {
    Info_int info = new Info_int(name, a,b,c,d,e,f) ;
    list_int.add(info) ;
  }
  /**
  read
  */ 
  public void read() {
    for(Info a : list_int) {
      println(a, type(a.get_type())) ;
    }
  }
  
  /**
  get
  */
  public Info_int get(int target) {
    if(target < list_int.size() && target >= 0) {
      return list_int.get(target) ;
    } else return null ;
  }
  
  public Info_int [] get(String which) {
    Info_int [] info  ;
    int count = 0 ;
    for(Info_int a : list_int) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info_int[count] ;
      count = 0 ;
      for(Info_int a : list_int) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_int[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }
  /**
  clear
  */
  public void clear() {
    list_int.clear() ;
  }
  /**
  remove
  */
  public void remove(String which) {
    for(int i = 0 ; i < list_int.size() ; i++) {
      Info_int a = list_int.get(i) ;
      if(a.get_name().equals(which)) {
        list_int.remove(i) ;
      }
    }
  }
  
  public void remove(int target) {
   if(target < list_int.size()) {
      list_int.remove(target) ;
    }
  }
}


/**
Info_float_dict

*/
public class Info_float_dict extends Info_dict {
  ArrayList<Info_float> list_float ;
  Info_float_dict() {
    super('f') ;
    list_float = new ArrayList<Info_float>() ;
  }

  // add float
  public void add(String name, float a) {
    Info_float info = new Info_float(name, a) ;
    list_float.add(info) ;
  }
  public void add(String name, float a, float b) {
    Info_float info = new Info_float(name, a,b) ;
    list_float.add(info) ;
  }
  public void add(String name, float a, float b, float c) {
    Info_float info = new Info_float(name, a,b,c) ;
    list_float.add(info) ;
  }
  public void add(String name, float a, float b, float c, float d) {
    Info_float info = new Info_float(name, a,b,c,d) ;
    list_float.add(info) ;
  }
  public void add(String name, float a, float b, float c, float d, float e) {
    Info_float info = new Info_float(name, a,b,c,d,e) ;
    list_float.add(info) ;
  }
  public void add(String name, float a, float b, float c, float d, float e, float f) {
    Info_float info = new Info_float(name, a,b,c,d,e,f) ;
    list_float.add(info) ;
  }
  /**
  read
  */
  public void read() {
    for(Info a : list_float) {
      println(a, type(a.get_type())) ;
    }
  }
   
  /**
  get
  */
  public Info_float get(int target) {
    if(target < list_float.size() && target >= 0) {
      return list_float.get(target) ;
    } else return null ;
  }
  
  public Info_float [] get(String which) {
    Info_float [] info  ;
    int count = 0 ;
    for(Info_float a : list_float) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info_float[count] ;
      count = 0 ;
      for(Info_float a : list_float) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_float[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }
  /**
  clear
  */
  public void clear() {
    list_float.clear() ;
  }
  /**
  remove
  */
  public void remove(String which) {
    for(int i = 0 ; i < list_float.size() ; i++) {
      Info a = list_float.get(i) ;
      if(a.get_name().equals(which)) {
        list_float.remove(i) ;
      }
    }
  }
  
  public void remove(int target) {
   if(target < list_float.size()) {
      list_float.remove(target) ;
    }
  }
}



/**
Info_String_dict

*/
public class Info_String_dict extends Info_dict {
  ArrayList<Info_String> list_String ;
  Info_String_dict() {
    super('s') ;
    list_String = new ArrayList<Info_String>() ;
  }

  // add String
  public void add(String name, String a) {
    Info_String info = new Info_String(name, a) ;
    list_String.add(info) ;
  }
  public void add(String name, String a, String b) {
    Info_String info = new Info_String(name, a,b) ;
    list_String.add(info) ;
  }
  public void add(String name, String a, String b, String c) {
    Info_String info = new Info_String(name, a,b,c) ;
    list_String.add(info) ;
  }
  public void add(String name, String a, String b, String c, String d) {
    Info_String info = new Info_String(name, a,b,c,d) ;
    list_String.add(info) ;
  }
  public void add(String name, String a, String b, String c, String d, String e) {
    Info_String info = new Info_String(name, a,b,c,d,e) ;
    list_String.add(info) ;
  }
  public void add(String name, String a, String b, String c, String d, String e, String f) {
    Info_String info = new Info_String(name, a,b,c,d,e,f) ;
    list_String.add(info) ;
  }

  
  public void read() {
    for(Info a : list_String) {
      println(a, type(a.get_type())) ;
    }
  }
  
  /**
  get
  */
  public Info_String get(int target) {
    if(target < list_String.size() && target >= 0) {
      return list_String.get(target) ;
    } else return null ;
  }
  
  public Info_String [] get(String which) {
    Info_String [] info  ;
    int count = 0 ;
    for(Info_String a : list_String) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info_String[count] ;
      count = 0 ;
      for(Info_String a : list_String) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_String[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }
  /**
  clear
  */
  public void clear() {
    list_String.clear() ;
  }
  /**
  remove
  */
  public void remove(String which) {
    for(int i = 0 ; i < list_String.size() ; i++) {
      Info_String a = list_String.get(i) ;
      if(a.get_name().equals(which)) {
        list_String.remove(i) ;
      }
    }
  }
  
  public void remove(int target) {
   if(target < list_String.size()) {
      list_String.remove(target) ;
    }
  }
}


/**
Info_Vec_dict

*/
public class Info_Vec_dict extends Info_dict {
  ArrayList<Info_Vec> list_Vec ;
  Info_Vec_dict() {
    super('v') ;
    list_Vec = new ArrayList<Info_Vec>() ;
  }

  // add Vec
  public void add(String name, Vec a) {
    Info_Vec info = new Info_Vec(name, a) ;
    list_Vec.add(info) ;
  }
  public void add(String name, Vec a, Vec b) {
    Info_Vec info = new Info_Vec(name, a,b) ;
    list_Vec.add(info) ;
  }
  public void add(String name, Vec a, Vec b, Vec c) {
    Info_Vec info = new Info_Vec(name, a,b,c) ;
    list_Vec.add(info) ;
  }
  public void add(String name, Vec a, Vec b, Vec c, Vec d) {
    Info_Vec info = new Info_Vec(name, a,b,c,d) ;
    list_Vec.add(info) ;
  }
  public void add(String name, Vec a, Vec b, Vec c, Vec d, Vec e) {
    Info_Vec info = new Info_Vec(name, a,b,c,d,e) ;
    list_Vec.add(info) ;
  }
  public void add(String name, Vec a, Vec b, Vec c, Vec d, Vec e, Vec f) {
    Info_Vec info = new Info_Vec(name, a,b,c,d,e,f) ;
    list_Vec.add(info) ;
  }

  
  public void read() {
    for(Info a : list_Vec) {
      println(a, type(a.get_type())) ;
    }
  }
  
  /**
  get
  */
  public Info_Vec get(int target) {
    if(target < list_Vec.size() && target >= 0) {
      return list_Vec.get(target) ;
    } else return null ;
  }
  
  public Info_Vec [] get(String which) {
    Info_Vec [] info  ;
    int count = 0 ;
    for(Info_Vec a : list_Vec) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info_Vec[count] ;
      count = 0 ;
      for(Info_Vec a : list_Vec) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_Vec[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }
  /**
  clear
  */
  public void clear() {
    list_Vec.clear() ;
  }
  /**
  remove
  */
  public void remove(String which) {
    for(int i = 0 ; i < list_Vec.size() ; i++) {
      Info_Vec a = list_Vec.get(i) ;
      if(a.get_name().equals(which)) {
        list_Vec.remove(i) ;
      }
    }
  }
  
  public void remove(int target) {
   if(target < list_Vec.size()) {
      list_Vec.remove(target) ;
    }
  }
}



/**

Class Info

*/
interface Info {
  public String get_name() ;
  
  public Object catch_a() ;
  public Object catch_b() ;
  public Object catch_c() ;
  public Object catch_d() ;
  public Object catch_e() ;
  public Object catch_f() ;

  public char get_type() ;
}
 
abstract class Info_method implements Info {
  String name  ;
  Info_method (String name) {
    this.name = name ;
  }


  public String get_name() { 
    return name ;
  }
}


/**
INFO int

*/
class Info_int extends Info_method {
  char type = 'i' ;
  int a, b, c, d, e, f ;
  int num_value ;  
  /**
  int value
  */

  Info_int(String name) {
    super(name) ;
  }

  Info_int(String name, int... var) {
    super(name) ;
    if(var.length > 6 ) num_value = 6 ; else num_value = var.length ;
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
  }

  /**
  get
  */
  public int get_a() { return a ; }
  public int get_b() { return b ; }
  public int get_c() { return c ; }
  public int get_d() { return d ; }
  public int get_e() { return e ; }
  public int get_f() { return f ; }

  public Object catch_a() { return a ; }
  public Object catch_b() { return b ; }
  public Object catch_c() { return c ; }
  public Object catch_d() { return d ; }
  public Object catch_e() { return e ; }
  public Object catch_f() { return f ; }
  
  public char get_type() { return type ; }

  /**
  Print info
  */
  public @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else {
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO String

*/
class Info_String extends Info_method {
  char type = 's' ;
  String a, b, c, d, e, f ;
  int num_value ;  

  Info_String(String name) {
    super(name) ;
  }

  Info_String(String name, String... var) {
    super(name) ;
    if(var.length > 6 ) num_value = 6 ; else num_value = var.length ;
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
  }

  /**
  get
  */
  public String get_a() { return a ; }
  public String get_b() { return b ; }
  public String get_c() { return c ; }
  public String get_d() { return d ; }
  public String get_e() { return e ; }
  public String get_f() { return f ; }

  public Object catch_a() { return a ; }
  public Object catch_b() { return b ; }
  public Object catch_c() { return c ; }
  public Object catch_d() { return d ; }
  public Object catch_e() { return e ; }
  public Object catch_f() { return f ; }

  public char get_type() { return type ; }

  /**
  Print info
  */
  public @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else {
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO float

*/
class Info_float extends Info_method {
  char type = 'f' ;
  float a, b, c, d, e, f ;
  int num_value ; 

  Info_float(String name) {
    super(name) ;
  }

  Info_float(String name, float... var) {
    super(name) ;
    if(var.length > 6 ) num_value = 6 ; else num_value = var.length ;
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
  }


  /**
  get
  */
  public float get_a() { return a ; }
  public float get_b() { return b ; }
  public float get_c() { return c ; }
  public float get_d() { return d ; }
  public float get_e() { return e ; }
  public float get_f() { return f ; }

  public Object catch_a() { return a ; }
  public Object catch_b() { return b ; }
  public Object catch_c() { return c ; }
  public Object catch_d() { return d ; }
  public Object catch_e() { return e ; }
  public Object catch_f() { return f ; }
  
  public char get_type() { return type ; }
  /**
  Print info
  */
  public @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else {
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO Vec
*/
class Info_Vec extends Info_method {
  char type = 'v' ;
  Vec a, b, c, d, e, f ;
  int num_value ;  

  Info_Vec(String name) {
    super(name) ;
  }
  /**
  Vec value
  */
  Info_Vec(String name, Vec... var) {
    super(name) ;
    if(var.length > 6 ) num_value = 6 ; else num_value = var.length ;
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
  }



  /**
  get
  */
  public Vec get_a() { return a ; }
  public Vec get_b() { return b ; }
  public Vec get_c() { return c ; }
  public Vec get_d() { return d ; }
  public Vec get_e() { return e ; }
  public Vec get_f() { return f ; }

  public Object catch_a() { return a ; }
  public Object catch_b() { return b ; }
  public Object catch_c() { return c ; }
  public Object catch_d() { return d ; }
  public Object catch_e() { return e ; }
  public Object catch_f() { return f ; }
  
  public char get_type() { return type ; }
  /**
  Print info
  */
  public @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else {
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}




/**
INFO OBJECT
*/
class Info_obj extends Info_method {
  char type = 'o' ;
  Object a, b, c, d, e, f ;
  int num_value ;

  Info_obj(String name) {
    super(name) ;
  }

  /**
  Object value
  */
  Info_obj(String name, Object... var) {
    super(name) ;
    if(var.length > 6 ) num_value = 6 ; else num_value = var.length ;
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
  }


  /**
  get
  */
  public Object get_a() { return a ; }
  public Object get_b() { return b ; }
  public Object get_c() { return c ; }
  public Object get_d() { return d ; }
  public Object get_e() { return e ; }
  public Object get_f() { return f ; }

  public Object catch_a() { return a ; }
  public Object catch_b() { return b ; }
  public Object catch_c() { return c ; }
  public Object catch_d() { return d ; }
  public Object catch_e() { return e ; }
  public Object catch_f() { return f ; }
  
  public char get_type() { return type ; }

  /**
  Print info
  */
  public @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else {
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}












/**
Random around value
*/

public float random_gaussian(float value) {
  float distrib = random(-1, 1) ;
  return (pow(distrib,5)) *(value*.4f) +value ;
}





/**
MAP
map the value between the min and the max
@ return float
*/
public float map_cycle(float value, float min, float max) {
  max += .000001f ;
  float newValue ;
  if(min < 0 && max >= 0 ) {
    float tempMax = max +abs(min) ;
    value += abs(min) ;
    float tempMin = 0 ;
    newValue =  tempMin +abs(value)%(tempMax - tempMin)  ;
    newValue -= abs(min) ;
    return newValue ;
  } else if ( min < 0 && max < 0) {
    newValue = abs(value)%(abs(max)+min) -max ;
    return newValue ;
  } else {
    newValue = min + abs(value)%(max - min) ;
    return newValue ;
  }
}




/*
map the value between the min and the max, but this value is lock between the min and the max
@ return float
*/
public float map_locked(float value, float sourceMin, float sourceMax, float targetMin, float targetMax) {
  if(sourceMax >= targetMax ) sourceMax = targetMax ;
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  float result = targetMin +deltaTarget *ratio;
  return result; 
}

// to map not linear, start the curve slowly to finish hardly
public float map_smooth_start(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = pow(ratio, level) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}

// to map not linear, start the curve hardly to finish slowly
public float map_smooth_end(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  // ratio = roots(ratio, level) ; // the method roots is use in math util
  ratio = pow(ratio, 1.0f/level) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}

// to map not linear, like a "S"
public float map_smooth(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = map(ratio,0,1, -1, 1 ) ;
  int correction = 1 ;
  if(level % 2 == 1 ) correction = 1 ; else correction = -1 ;
  if (ratio < 0 ) ratio = pow(ratio, level) *correction  ; else ratio = pow(ratio, level)  ;
  ratio = map(ratio, -1,1, 0,1) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}
// END MAP
//////////












/**
CHECK

*/


/**
Check renderer
*/
public boolean renderer_P3D() {
  if(get_renderer_name(getGraphics()).equals("processing.opengl.PGraphics3D")) return true ; else return false ;
}


public String get_renderer_name(final PGraphics graph) {
  try {
    if (Class.forName(JAVA2D).isInstance(graph))  return JAVA2D;
    if (Class.forName(FX2D).isInstance(graph))    return FX2D;
    if (Class.forName(P2D).isInstance(graph))     return P2D;
    if (Class.forName(P3D).isInstance(graph))     return P3D;
    if (Class.forName(PDF).isInstance(graph))     return PDF;
    if (Class.forName(DXF).isInstance(graph))     return DXF;
  }

  catch (ClassNotFoundException ex) {
  }
  return "Unknown";
}


/**
Check Type
*/
public String object_type(Object t) {
  String type = "Type unknow" ;
  if(t instanceof Integer) {
    type = ("Integer") ;
  } else if(t instanceof Float) {
    type = ("Float") ;
  } else if(t instanceof String) {
    type = ("String") ;
  } else if(t instanceof Double) {
    type = ("Double") ;
  } else if(t instanceof Long) {
    type = ("Long") ;
  } else if(t instanceof Short) {
    type = ("Short") ;
  } else if(t instanceof Boolean) {
    type = ("Boolean") ;
  } else if(t instanceof Byte) {
    type = ("Byte") ;
  } else if(t instanceof Character) {
    type = ("Character") ;
  }else {
    type = ("Type unknow") ;
  }
  return type ;
}























/**
TRANSLATOR INT to String, FLOAT to STRING 0.0.3
*/
//truncate
public float truncate( float x ) {
    return round( x * 100.0f ) / 100.0f;
}
//Int to String with array list
/*
@ return String
*/
public String join_int_to_String(int []data) {
  String intString ;
  String [] dataString = new String [data.length] ;
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = Integer.toString(data[i]) ;
  intString = join(dataString,"/") ;
  
  return intString ;
}

//float to String with array list
public String join_float_to_String(float []data) {
  String floatString ;
  String [] dataString = new String [data.length] ;
  //for ( int i = 0 ; i < data.length ; i++) dataString[i] = Float.toString(data[i]) ;
  //we must use just one decimal after coma, to dodge the outBoundIndex blablabla
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = String.format("%.1f" ,data[i]) ;
  floatString = join(dataString,"/") ;
  
  return floatString ;
}

//Translater to String
// float to String
public String float_to_String_1(float data) {
  String float_string_value ;
  float_string_value = String.format("%.1f", data ) ;
  return float_String(float_string_value) ;
}
//
public String float_to_String_2(float data) {
  String float_string_value ;
  float_string_value = String.format("%.2f", data ) ;
  return float_String(float_string_value) ;
}
//
public String float_to_String_3(float data) {
  String float_string_value ;
  float_string_value = String.format("%.3f", data ) ;
  return float_String(float_string_value) ;
}

//
public String float_to_String_4(float data) {
  String float_string_value ;
  float_string_value = String.format("%.4f", data ) ;
  return float_String(float_string_value) ;
}
// local
public String float_String(String value) {
  if(value.contains(".")) {
    return value ;
  } else {
    String [] temp = split(value, ",") ;
    value = temp[0] +"." + temp[1] ;
    return value ;
  }
}


// int to String
public String int_to_String(int data) {
  String float_string_value ;
  float_string_value = Integer.toString(data ) ;
  return float_string_value ;
}

//END TRANSLATOR
///////////////
























/**
STRING UTILS
*/

//STRING SPLIT
public String [] split_text(String textToSplit, String separator) {
  String [] text = textToSplit.split(separator) ;
  return text  ;
}


//STRING COMPARE LIST SORT
//raw compare
public int longest_word( String[] listWordsToSort) {
  int sizeWord = 0 ;
  for ( int i = 0 ; i < listWordsToSort.length ; i++) {
    if (listWordsToSort[i].length() > sizeWord )  sizeWord = listWordsToSort[i].length() ;
  }
  return  sizeWord ;
}
//with starting and end keypoint in the String must be sort
public int longest_word( String[] listWordsToSort, int start, int finish ) {
  int sizeWord = 0 ;

  for ( int i = start ; i < finish ; i++) {
    if (listWordsToSort[i].length() > sizeWord )  sizeWord = listWordsToSort[i].length() ;
  }
  return  sizeWord ;
}



// with the same size_text for each line
public int longest_word_in_pixel(String[] listWordsToSort, int size_font) {
  int sizeWord = 0 ;
  for ( int i = 0 ; i < listWordsToSort.length ; i++) {
    if (length_String_in_pixel(listWordsToSort[i], size_font) > sizeWord )  sizeWord = length_String_in_pixel(listWordsToSort[i],size_font) ;
  }
  return  sizeWord ;
}

// with the same size_text for each line, choice the which line you check
public int longest_word_in_pixel( String[] listWordsToSort, int size_font, int start, int finish ) {
  int sizeWord = 0 ;
  for ( int i = start ; i <= finish ; i++) {
    if (length_String_in_pixel(listWordsToSort[i], size_font) > sizeWord )  sizeWord = length_String_in_pixel(listWordsToSort[i],size_font) ;
  }
  return  sizeWord ;
}

// with list of size_text for each line
public int longest_word_in_pixel( String[] listWordsToSort, int [] size_font) {
  int sizeWord = 0 ;
  for ( int i = 0 ; i < listWordsToSort.length ; i++) {
    if (length_String_in_pixel(listWordsToSort[i], size_font[i]) > sizeWord )  sizeWord = length_String_in_pixel(listWordsToSort[i],size_font[i]) ;
  }
  return  sizeWord ;
}

// with list of size_text for each line, choice the which line you check
public int longest_word_in_pixel( String[] listWordsToSort, int [] size_font, int start, int finish ) {
  int sizeWord = 0 ;
  for ( int i = start ; i <= finish ; i++) {
    if (length_String_in_pixel(listWordsToSort[i], size_font[i]) > sizeWord )  sizeWord = length_String_in_pixel(listWordsToSort[i],size_font[i]) ;
  }
  return  sizeWord ;
}




 



public int length_String_in_pixel(String target, int ratio) {
  Font font = new Font("defaultFont", Font.BOLD, ratio) ;
  BufferedImage img = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
  FontMetrics fm = img.getGraphics().getFontMetrics(font);
  return fm.stringWidth(target);
}




// Research a specific word in String
public boolean research_in_String(String research, String target) {
  boolean result = false ;
  for(int i = 0 ; i < target.length() - research.length() +1; i++) {
    result = target.regionMatches(i,research,0,research.length()) ;
    if (result) break ;
  }
  return result ;
}





// remove the path of your file
public String file_name(String s) {
  String file_name = "" ;
  String [] split_path = s.split("/") ;
  file_name = split_path[split_path.length -1] ;
  return file_name ;
}
/**
CLASS ROPE VEC 1.8.4.0
Rope \u2013 Romanesco Processing Environment: 2015 \u2013 2017
* @author Stan le Punk
* @see https://github.com/StanLepunK/Vec
* inspireted by GLSL code and PVector from Daniel Shiffman
* ROPE is not add before Vec, because is too long, and little too much to have something like
* that RopeVec(), ROVec(), RPEVec() or RVec(), plus there is no confusion with PVector, so stay simple !
*/
/**
Vec Master

*/
abstract class Vec {
  /**
  may be remove ref in the future
  */
  float ref_x, ref_y, ref_z, ref_w = Float.NaN  ;
  float x,y,z,w = Float.NaN ;
  float a,b,c,d,e,f = Float.NaN  ;
  float r,g = Float.NaN ;
  float s,t,p,q = Float.NaN ;
  float u,v = Float.NaN;

  Vec() {}
}

/**
VEC 2

*/
class Vec2 extends Vec {

  Vec2(float x, float y) {
    super() ;
    this.ref_x = this.x = this.s = this.u = x ;
    this.ref_y = this.y = this.t = this.v = y ;
  }
  /**
  Random constructor
  */
  Vec2(String key_random, int r1) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.s = this.u = random(-r1,r1) ;
      this.ref_y = this.y = this.t = this.v = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.s = this.u = random(0,r1) ;
      this.ref_y = this.y = this.t = this.v = random(0,r1) ;
    } else {
      this.ref_x = this.ref_y = this.x = this.y = this.s = this.t = this.u = this.v = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec2(String key_random, int r1, int r2) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.s = this.u = random(-r1,r1) ;
      this.ref_y = this.y = this.t = this.v = random(-r2,r2) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.s = this.u = random(0,r1) ;
      this.ref_y = this.y = this.t = this.v = random(0,r2) ;
    } else if(key_random.equals("RANDOM RANGE")) {
      this.ref_x = this.x = this.s = this.u = random(r1,r2) ;
      this.ref_y = this.y = this.t = this.v = random(r1,r2) ;
    } else {
      this.ref_x = this.ref_y = this.x = this.y = this.s = this.t = this.u = this.v = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' or 'RANDOM RANGE' ") ;
    }
  }

  Vec2(String key_random, int a1, int a2, int b1, int b2) {
    super() ;
    if(key_random.equals("RANDOM RANGE")) {
      this.ref_x = this.x = this.s = this.u = random(a1,a2) ;
      this.ref_y = this.y = this.t = this.v = random(b1,b2) ;
    } else {
      this.ref_x = this.ref_y = this.x = this.y = this.s = this.t = this.u = this.v = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }
  /**
  Set
  */
   /**
   * Sets components of the vector using two or three separate
   * variables, the data from a Vec, or the values from a float array.
   */
  public Vec2 set(float v) {
    this.x = this.s = this.u = v;
    this.y = this.t = this.v = v ;
    return this;
  }
  public Vec2 set(float x, float y) {
    this.x = this.s = this.u = x ;
    this.y = this.t = this.v = y ;
    return this;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec2 set(Vec2 v) {
    if(v == null) {
      this.x = this.s = this.u = 0 ;
      this.y = this.t = this.v = 0 ;
      return this;
    } else {
      this.x = this.s = this.u = v.x ;
      this.y = this.t = this.v = v.y ;
      return this;
    }
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec2 set(float[] source) {
    this.x = this.s = this.u = source[0];
    this.y = this.t = this.v = source[1];
    return this;
  }

  
  
  
  
  
  
  
  
  /**
  multiplication
  */
  /* multiply Vector by a same float value */
  public Vec2 mult(float mult) {
    x *= mult ; 
    y *= mult ;

    set(x,y) ;
    return this ;
  }
  
  /* multiply Vector by different float value */
  public Vec2 mult(float mult_x, float mult_y) {
    x *= mult_x ; 
    y *= mult_y ;

    set(x,y) ;
    return this;
  }
  
  // mult by vector
  public Vec2 mult(Vec2 v) {
    if(v != null) {
      x *= v.x ; 
      y *= v.y ; 
    }
    set(x,y) ;
    return this;
  }
  
  /**
  division
  */
  /*
  divide Vector by a float value */
  public Vec2 div(float div) {
    x /= div ; 
    y /= div ; 
    
    set(x,y) ;
    return this;
    
  }
  
  // divide by vector
  public Vec2 div(Vec2 v) {
    if(v != null) {
      x /= v.x ; 
      y /= v.y ;
    }  
    set(x,y) ;
    return this;
  }
  
  
  /** 
  Addition
  */
  /* add float value */
  public Vec2 add(float value) {
    x += value ;
    y += value ;
    
    set(x,y) ;
    return this ;
  }

  public Vec2 add(float value_a, float value_b) {
    x += value_a ;
    y += value_b ;
    
    set(x,y) ;
    return this ;
  }
  /* add Vector */
  public Vec2 add(Vec v) {
    if(v != null) {
      x += v.x ;
      y += v.y ;
    }
    set(x,y) ;
    return this ;
  }
  /* add two Vector together */
  public Vec2 add(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x + v_b.x ;
      y = v_a.y + v_b.y ;
    }
    set(x,y) ;
    return this ;
  }


  /**
  Substraction
  */
    /* add float value */
  public Vec2 sub(float value) {
    x -= value ;
    y -= value ;
    
    set(x,y) ;
    return this ;
  }
  public Vec2 sub(float value_a,float value_b) {
    x -= value_a ;
    y -= value_b ;
    
    set(x,y) ;
    return this ;
  }
  /* add one Vector */
  public Vec2 sub(Vec v) {
    if(v != null) {
      x -= v.x ;
      y -= v.y ;
    }
    set(x,y) ;
    return this ;
  }
  
  /* add two Vector together */
  public Vec2 sub(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x - v_b.x ;
      y = v_a.y - v_b.y ;
    }
    set(x,y) ;
    return this ;
  }

  /**
  Average
  */
  public float average() {
    return (this.x + this.y) *.5f ;
  }


    /**
  Dot
  */
  public float dot(Vec2 v) {
    if(v != null) {
      return x*v.x + y*v.y ;
    } else {
      println("Your Vec arg is", null) ;
      return x *0 + y *0  ;
    }
  }
  public float dot(float x, float y) {
    return this.x*x + this.y*y ;
  }

  
  
  /**
  Direction
  */
  //return mapping vector
  // @return Vec2
  public Vec2 dir() {
    return dir(Vec2(0)) ;
  }
  public Vec2 dir(float a_x, float a_y) {
    return dir(Vec2(a_x,a_y)) ;
  }
  public Vec2 dir(Vec2 origin) {
    if(origin != null) {
      float dist = dist(origin) ;
      sub(origin) ;
      div(dist) ;
    }
    set(x,y) ;
    return this ;
  }


  /**
  Tangent
  */
  public Vec2 tan() {
    return tan(Vec2(x,y)) ;
  }
  public Vec2 tan(float a_x, float a_y) {
    return tan(Vec2(a_x,a_y)) ;
  }

  public Vec2 tan(Vec2 target) {
    if(target != null) {
      float mag = mag() ;
      target.div(mag) ;
      x = -target.y ;
      y = target.x ;
    }
    set(x,y) ;
    return this ;
  }
  

  /**
  Min Max
  */
    // find the min and the max value in the vector list
  // @ float
  public float max_vec() {
    float [] list = { x, y} ;
    return max(list) ;
  }
  public float min_vec() {
    float [] list = { x, y} ;
    return min(list) ;
  }

  /**
  Normalize
  */
  /*
  return mapping vector
  @return Vec2
  */
  /*
  Vec2 normalize(Vec2 min, Vec2 max) {
    if(min != null && max != null) {
      x = map(x, min.x, max.x, 0, 1) ;
      y = map(y, min.y, max.y, 0, 1) ;
    }
    set(x,y) ;
    return this ;
  }
  */
  
  
  public Vec2 normalize(Vec2 target) {
    if (target == null) {
      target = Vec2();
    }
    float m = mag();
    if (m > 0) {
      target.set(x/m, y/m);
    } else {
      target.set(x, y);
    }
    return target;
  }

  public Vec2 normalize() {
    float m = mag();
    if (m != 0 && m != 1) {
      div(m);
    }
    return this ;
  }

  /**
 Map
  */
  /*
  return mapping vector
  @return Vec2
  */
  public Vec2 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x,minIn, maxIn, minOut, maxOut) ;
    y = map(y,minIn, maxIn, minOut, maxOut) ;
    
    set(x,y) ;
    return this ;
  }
  
   /**
  Mag
  */
  /* magnitude or length of Vec2
  @ return float
  */
  public float mag() {
    return sqrt(x*x + y*y) ;
  }

  public float mag(Vec v_target) {
    if(v_target != null) {
      float new_x = (v_target.x -x) *(v_target.x -x) ;
      float new_y = (v_target.y -y) *(v_target.y -y) ;
      return sqrt(new_x +new_y) ;
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
  }
  
  
  /**
  Distance
  */
  /*
  @ return float
  distance between himself and an other vector
  */
  public float dist(Vec v_target) {
    if(v_target != null) {
      float dx = x - v_target.x;
      float dy = y - v_target.y;
      return (float) Math.sqrt(dx*dx + dy*dy);
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
 
  }
  
  
  /**
  Jitter
  */
  /* create jitter effect around the vector position */
  /* with global range */
  public Vec2 jitter(int range) {
    return jitter(range,range) ;
  }
  public Vec2 jitter(Vec2 range) {
    if(range != null) {
      return jitter((int)range.x,(int)range.y) ;
    } else {
      return jitter(0,0) ;
    }
    
  }
  /* with specific range */
  public Vec2 jitter(int range_x,int range_y) {
    println("jitter 1", x, y) ;
    /*
    x = ref_x ;
    y = ref_y ;
    */
    x += random(-range_x, range_x) ;
    y += random(-range_y, range_y) ;
    set(x,y) ;
    return this ;
  }
  
  
  /**
  Revolution
  */
  /* create a circular motion effect */
  public Vec2 revolution(int radius, float speed) {
    float new_speed = speed *.01f ;
    /*
    x = ref_x ;
    y = ref_y ;
    */
    float m_x = sin(frameCount *new_speed) ;
    float m_y = cos(frameCount *new_speed) ;
    m_x *=radius ;
    m_y *=radius ;
    
    return this ;
  }


  public Vec2 revolution(int r_x, int r_y, float speed) {
    float new_speed = speed *.01f ;
    /*
    x = ref_x ;
    y = ref_y ;
    */
    float m_x = sin(frameCount *new_speed) ;
    float m_y = cos(frameCount *new_speed) ;
    m_x *=r_x ;
    m_y *=r_y ;
    
    return this ;
  }

  public Vec2 revolution(Vec2 radius, float speed) {
    float new_speed = speed *.01f ;
    /*
    x = ref_x ;
    y = ref_y ;
    */
    float m_x = sin(frameCount *new_speed) ;
    float m_y = cos(frameCount *new_speed) ;

    m_x *=radius.x ;
    m_y *=radius.y ;
    
    return this ;
  }

  /**
  Equals
  */
  public boolean equals(Vec2 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y)) {
        return true ; 
      } else return false ;
    } else return false ;
  }

  public boolean equals(float target) {
    if((x == target) && (y == target)) 
    return true ; 
    else return false ;
  }
  
  public boolean equals(float t_x,float t_y) {
    if((x == t_x) && (y == t_y)) 
    return true ; 
    else return false ;
  }



  
  /**
  Compare deprecated
  */
  public boolean compare(Vec2 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y)) {
        return true ; 
      } else return false ;
    } else return false ;
  }

  public boolean compare(float target) {
    if((x == target) && (y == target)) 
    return true ; 
    else return false ;
  }
  
  public boolean compare(float t_x,float t_y) {
    if((x == t_x) && (y == t_y)) 
    return true ; 
    else return false ;
  }
  
  
  
  /**
  Copy
  */
  /*
  return all the component of Vec
  @return Vec2
  */
  public Vec2 copy() {
    return new Vec2(x,y) ;
  }
  /*
  return all the component of Vec in type PVector
  @return PVector
  */
  public PVector copy_PVector() {
    return new PVector(x,y) ;
  }


  /**
  Print info
  */
  public @Override String toString() {
    return "[ " + x + ", " + y + " ]";
  }
}
// END VEC 2
////////////






/**

VEC 3

*/
class Vec3 extends Vec {
 
  /**
  Constructor
  */
  Vec3(float x, float y, float z) {
    super() ;
    this.ref_x = this.x = this.r = this.s = x ;
    this.ref_y = this.y = this.g = this.t = y ;
    this.ref_z = this.z = this.b = this.p = z ;
  }
  
   /**
  Random constructor
  */ 
  // random generator for the Vec
  Vec3(String key_random, int r1) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.r = this.s = random(-r1,r1) ;
      this.ref_y = this.y = this.g = this.t = random(-r1,r1) ;
      this.ref_z = this.z = this.b = this.p = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.r = this.s = random(0,r1) ;
      this.ref_y = this.y = this.g = this.t = random(0,r1) ;
      this.ref_z = this.z = this.b = this.p = random(0,r1) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec3(String key_random, int r1, int r2, int r3) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.r = this.s = random(-r1,r1) ;
      this.ref_y = this.y = this.g = this.t = random(-r2,r2) ;
      this.ref_z = this.z = this.b = this.p = random(-r3,r3) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.r = this.s = random(0,r1) ;
      this.ref_y = this.y = this.g = this.t = random(0,r2) ;
      this.ref_z = this.z = this.b = this.p = random(0,r3) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec3(String key_random, int a1, int a2, int b1, int b2, int c1, int c2) {
    super() ;
    if(key_random.equals("RANDOM RANGE")) {
      this.ref_x = this.x = this.r = this.s = random(a1,a2) ;
      this.ref_y = this.y = this.g = this.t = random(b1,b2) ;
      this.ref_z = this.z = this.b = this.p = random(c1,c2) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }



  /**
  Set
  */
   /**
   * Sets components of the vector using two or three separate
   * variables, the data from a Vec, or the values from a float array.
   */
   
   public Vec3 set(float v) {
    this.x = this.r = this.s = v ;
    this.y = this.g = this.t = v ;
    this.z = this.b = this.p = v ;
    return this ;
  }
  public Vec3 set(float x, float y, float z) {
    this.x = this.r = this.s = x ;
    this.y = this.g = this.t = y ;
    this.z = this.b = this.p = z ;
    return this ;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec3 set(Vec3 v) {
    if(v == null) {
      this.x = this.r = this.s = 0 ;
      this.y = this.g = this.t = 0 ;
      this.z = this.b = this.p = 0 ;
      return this ;
    } else {
      this.x = v.x ;
      this.r = v.x ;
      this.s = v.x ;

      this.y = v.y ;
      this.g = v.y ;
      this.t = v.y ;

      this.z = v.z ;
      this.b = v.z ;
      this.p = v.z ;
      return this ;
    }
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec3 set(float[] source) {
    this.x = source[0] ;
    this.r = source[0] ;
    this.s = source[0] ;

    this.y = source[1] ;
    this.g = source[1] ;
    this.t = source[1] ;

    this.z = source[2] ;
    this.b = source[2] ;
    this.p = source[2] ;
    return this ;
  }
  
  
  
  
  
  
  
  
  
  
  
  /**
  METHOD
  */
  /**
  Mult
  */
  /* multiply Vector by a same float value */
  public Vec3 mult(float mult) {
    x *= mult ; y *= mult ; z *= mult ;
    
    set(x,y,z) ;
    return this ;
  }
  
  /* multiply Vector by a different float value */
  public Vec3 mult(float mult_x, float mult_y, float mult_z) {
    x *= mult_x ; y *= mult_y ; z *= mult_z ;
    
    set(x,y,z) ;
    return this ;
  }
  
  // mult by vector
  public Vec3 mult(Vec3 v) {
    if(v != null) {
      x *= v.x ; 
      y *= v.y ; 
      z *= v.z ; 
    }
    set(x,y,z) ;
    return this ;
  }
  
  
  
  /**
  Division
  */
  /*
  @ return Vec
  divide Vector by a float value */
  public Vec3 div(float div) {
    x /= div ; 
    y /= div ; 
    z /= div ;
    
    set(x,y,z) ;
    return this ;
  }
  
  // divide by vector
  public Vec3 div(Vec3 v) {
    if(v != null) {
      x /= v.x ; 
      y /= v.y ; 
      z /= v.z ; 
    }
    set(x,y,z) ;
    return this ;
  }
  
  
  
  /**
  Addition
  */
    /* add float value */
  public Vec3 add(float value) {
    x += value ;
    y += value ;
    z += value ;
    
    set(x,y,z) ;
    return this ;
  }
  public Vec3 add(float value_a,float value_b,float value_c) {
    x += value_a ;
    y += value_b ;
    z += value_c ;
    
    set(x,y,z) ;
    return this ;
  }
  /* add one Vector */
  public Vec3 add(Vec v) {
    if(v != null) {
      x += v.x ;
      y += v.y ;
      z += v.z ;
    }
    set(x,y,z) ;
    return this ;
  }
  
  /* add two Vector together */
  public Vec3 add(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x + v_b.x ;
      y = v_a.y + v_b.y ;
      z = v_a.z + v_b.z ;
    }
    set(x,y,z) ;
    return this ;
  }



  /**
  Substraction
  */
    /* add float value */
  public Vec3 sub(float value) {
    x -= value ;
    y -= value ;
    z -= value ;
    
    set(x,y,z) ;
    return this ;
  }
  public Vec3 sub(float value_a,float value_b,float value_c) {
    x -= value_a ;
    y -= value_b ;
    z -= value_c ;

    set(x,y,z) ;
    return this ;
  }
  /* add one Vector */
  public Vec3 sub(Vec v) {
    if(v != null) {
      x -= v.x ;
      y -= v.y ;
      z -= v.z ;
    }
    set(x,y,z) ;
    return this ;
  }
  
  /* add two Vector together */
  public Vec3 sub(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x - v_b.x ;
      y = v_a.y - v_b.y ;
      z = v_a.z - v_b.z ;
    }
    set(x,y,z) ;
    return this ;
  }


  /**
  Average
  */
  public float average() {
    return (this.x + this.y +this.z) *.333f ;
  }


  /**
  Dot
  */
  public float dot(Vec3 v) {
    if(v != null) {
      return x*v.x + y*v.y + z*v.z;
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
    
  }
  public float dot(float x, float y, float z) {
    return this.x*x + this.y*y + this.z*z;
  }

  /**
  Cross
  */
  public Vec3 cross(Vec3 v) {
    if(v != null) {
      return cross(v, null);
    } else return null ;
    
  }
  public Vec3 cross(float x, float y, float z) {
    Vec3 v = Vec3(x,y,z) ;
    return cross(v, null);
  }

  public Vec3 cross(Vec3 v, Vec3 target) {
    if(v != null && target != null) {
      float crossX = y*v.z - v.y*z;
      float crossY = z*v.x - v.z*x;
      float crossZ = x*v.y - v.x*y;
      if (target == null) {
        target = Vec3(crossX, crossY, crossZ);
      } else {
        target.set(crossX, crossY, crossZ);
      }
      return target;
    } else return null ;

  }
  

  /**
  Direction cartesian
  */
  public Vec3 dir() {
    return dir(Vec3(0)) ;
  }
  public Vec3 dir(float a_x, float a_y, float a_z) {
    return dir(Vec3(a_x,a_y,a_z)) ;
  }
  public Vec3 dir(Vec3 origin) {
    if(origin != null) {
      float dist = dist(origin) ;
      sub(origin) ;
      div(dist) ;
    }
    set(x,y,z) ;
    return this ;
  }
  
  

  /**
  Tangent
  */
  // to find the tangent you need to associate an other vector of your dir vector to create a reference plane.
  public Vec3 tan(float float_to_make_plane_ref_x, float float_to_make_plane_ref_y, float float_to_make_plane_ref_z) {
    return tan(Vec3(float_to_make_plane_ref_x, float_to_make_plane_ref_y, float_to_make_plane_ref_z)) ;
  }

  public Vec3 tan(Vec3 vector_to_make_plane_ref) {
    if(vector_to_make_plane_ref != null) {
      Vec3 tangent = cross(vector_to_make_plane_ref) ;
      return tangent ;
    } else return null ;
  }
  

  /**
  Map
  */
  // find the min and the max value in the vector list
  // @ float
  public float max_vec() {
    float [] list = { x, y, z } ;
    return max(list) ;
  }
  public float min_vec() {
    float [] list = { x, y, z } ;
    return min(list) ;
  }





  /**
  Normalize
  */
  /*
  return normalize vector with length of 1
  @return Vec3
  */
  /*
  Vec3 normalize(Vec min, Vec max) {
    if(min != null && max != null) {
      x = map(x, min.x, max.x, 0, 1) ;
      y = map(y, min.y, max.y, 0, 1) ;
      z = map(z, min.z, max.z, 0, 1) ;
    }
    set(x,y,z) ;
    return new Vec3(x,y,z) ;
  }
  */
  
  public Vec3 normalize(Vec3 target) {
    if (target == null) {
      target = Vec3();
    }
    float m = mag();
    if (m > 0) {
      target.set(x/m, y/m, z/m);
    } else {
      target.set(x, y, z);
    }
    return target;
  }

  public Vec3 normalize() {
    float m = mag();
    if (m != 0 && m != 1) {
      div(m);
    }
    return this ;
  }

  /**
  Map
  */
  /*
  return mapping vector
  @return Vec3
  */
  public Vec3 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x, minIn, maxIn, minOut, maxOut) ;
    y = map(y, minIn, maxIn, minOut, maxOut) ;
    z = map(z, minIn, maxIn, minOut, maxOut) ;

    set(x,y,z) ;
    return this ;
  }
  
  
  
  /**
  Magnitude
  */
  /* Magnitude or length of Vec3
  @ return float
  */
  /////////////////////
  public float mag() {
    return sqrt(x*x + y*y + z*z) ;
  }


  public float mag(Vec3 v_target) {
    if(v_target != null) {
      float new_x = (v_target.x -x) *(v_target.x -x) ;
      float new_y = (v_target.y -y) *(v_target.y -y) ;
      float new_z = (v_target.z -z) *(v_target.z -z) ;
      return sqrt(new_x +new_y +new_z) ;
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
  }
  
  /**
  Distance
  */
  /*
  @ return float
  distance himself and an other vector
  */
  public float dist(Vec v_target) {
    if(v_target != null) {
      float dx = x - v_target.x;
      float dy = y - v_target.y;
      float dz = z - v_target.z;
      return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
  }
  
  /**
  Jitter
  */
  /* create jitter effect around the vector position */
  /* with global range */
  public Vec3 jitter(int range) {
    return jitter(range,range,range) ;
  }
  public Vec3 jitter(Vec3 range) {
    if(range != null) {
      return jitter((int)range.x,(int)range.y,(int)range.z) ;
    } else return jitter(0, 0, 0) ;
    
  }
  /* with specific range */
  public Vec3 jitter(int range_x,int range_y,int range_z) {
    /*
    x = ref_x ;
    y = ref_y ;
    z = ref_z ;
    */
    x += random(-range_x, range_x) ;
    y += random(-range_y, range_y) ;
    z += random(-range_z, range_z) ;

    set(x,y,z) ;
    return this ;
  }
  
  
  
  /**
  Revolution
  */
  /* create a circular motion effect */
  public Vec3 revolutionX(int rx, int ry, float speed) {
    return revolutionX(Vec2(rx,ry), speed) ;
  }
  public Vec3 revolutionX(int r, float speed) {
    return revolutionX(Vec2(r,r), speed) ;
  }
  public Vec3 revolutionX(Vec2 radius, float speed) {
    if(radius != null) {
      float new_speed = speed *.01f ; 
      /*
      x = ref_x ;
      y = ref_y ;
      */
      float m_x = sin(frameCount *new_speed) ;
      float m_y = cos(frameCount *new_speed) ;
      m_x *=radius.x ;
      m_y *=radius.y ;
      return new Vec3(x +m_x, y +m_y, z) ;
    } else return null ;

  }
  //
  public Vec3 revolutionY(int rx, int ry, float speed) {
    return revolutionY(Vec2(rx,ry), speed) ;
  }
  public Vec3 revolutionY(int r, float speed) {
    return revolutionY(Vec2(r,r), speed) ;
  }
  public Vec3 revolutionY(Vec2 radius, float speed) {
    if(radius != null) {
      float new_speed = speed *.01f ; 
      /*
      x = ref_x ;
      z = ref_z ;
      */
      float m_x = sin(frameCount *new_speed) ;
      float m_z = cos(frameCount *new_speed) ;
      m_x *=radius.x ;
      m_z *=radius.y ;
      return new Vec3(x +m_x, y, z +m_z) ;
    } else return null ;
  }
  //
  public Vec3 revolutionZ(int rx, int ry, float speed) {
    return revolutionZ(Vec2(rx,ry), speed) ;
  }

  public Vec3 revolutionZ(int r, float speed) {
    return revolutionZ(Vec2(r,r), speed) ;
  }
  public Vec3 revolutionZ(Vec2 radius, float speed) {
    if(radius != null) {
      float new_speed = speed *.01f ; 
      /*
      y = ref_y ;
      z = ref_z ;
      */
      float m_y = sin(frameCount *new_speed) ;
      float m_z = cos(frameCount *new_speed) ;
      m_y *=radius.x ;
      m_z *=radius.y ;
      return new Vec3(x, y +m_y, z +m_z) ;
    } else return null ;
  }


  /**
  Equals
  */
  public boolean equals(Vec3 target) {
    if(target != null) {
      if((x == target.x) && (y == target.y) && (z == target.z)) {
        return true ; 
      } else return false ;
    } else return false ;
  }
  
  public boolean equals(float target) {
    if((x == target) && (y == target) && (z == target)) 
    return true ; 
    else return false ;
  }
  
  public boolean equals(float t_x,float t_y,float t_z) {
    if((x == t_x) && (y == t_y) && (z == t_z)) 
    return true ; 
    else return false ;
  }
  
  
  /**
  Compare deprecated
  */
  public boolean compare(Vec3 target) {
    if(target != null) {
      if((x == target.x) && (y == target.y) && (z == target.z)) {
        return true ; 
      } else return false ;
    } else return false ;
  }
  
  public boolean compare(float target) {
    if((x == target) && (y == target) && (z == target)) 
    return true ; 
    else return false ;
  }
  
  public boolean compare(float t_x,float t_y,float t_z) {
    if((x == t_x) && (y == t_y) && (z == t_z)) 
    return true ; 
    else return false ;
  }
  


  
  
  /**
  Copy
  */
  /*
  return all the component of Vec
  @return Vec3
  */
  public Vec3 copy() {
    return new Vec3(x,y,z) ;
  }
  /*
  return all the component of Vec in type PVector
  @return PVector
  */
  public PVector copy_PVector() {
    return new PVector(x,y,z) ;
  }

  /**
  Print info
  */
  public @Override String toString() {
    return "[ " + x + ", " + y + ", " + z + " ]";
  }
  
  
}
// END VEC 3
////////////





/**
VEC 4

*/
class Vec4 extends Vec {
  /**
  Constructor
  */
  
  Vec4(float x, float y, float z, float w) {
    super() ;
    this.ref_x = this.x = this.r = this.s = x ;
    this.ref_y = this.y = this.g = this.t = y ;
    this.ref_z = this.z = this.b = this.p = z ;
    this.ref_w = this.w = this.a = this.q = w ;
  }



  /**
  Random constructor
  */ 
  // random generator for the Vec
  Vec4(String key_random, int r1) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.r =this.s = random(-r1,r1) ;
      this.ref_y = this.y = this.g =this.t = random(-r1,r1) ;
      this.ref_z = this.z = this.b = this.p = random(-r1,r1) ;
      this.ref_w = this.w = this.a = this.q = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.r =this.s = random(0,r1) ;
      this.ref_y = this.y = this.g =this.t = random(0,r1) ;
      this.ref_z = this.z = this.b = this.p = random(0,r1) ;
      this.ref_w = this.w = this.a = this.q = random(0,r1) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.ref_w = this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec4(String key_random, int r1, int r2, int r3, int r4) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.ref_x = this.x = this.r =this.s = random(-r1,r1) ;
      this.ref_y = this.y = this.g =this.t = random(-r2,r2) ;
      this.ref_z = this.z = this.b = this.p = random(-r3,r3) ;
      this.ref_w = this.w = this.a = this.q = random(-r4,r4) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.ref_x = this.x = this.r =this.s = random(0,r1) ;
      this.ref_y = this.y = this.g =this.t = random(0,r2) ;
      this.ref_z = this.z = this.b = this.p = random(0,r3) ;
      this.ref_w = this.w = this.a = this.q = random(0,r4) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.ref_w = this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec4(String key_random, int a1, int a2, int b1, int b2, int c1, int c2, int d1, int d2) {
    super() ;
    if(key_random.equals("RANDOM RANGE")) {
      this.ref_x = this.x = this.r = this.s = random(a1,a2) ;
      this.ref_y = this.y = this.g = this.t = random(b1,b2) ;
      this.ref_z = this.z = this.b = this.p = random(c1,c2) ;
      this.ref_w = this.w = this.a = this.q = random(d1,d2) ;
    } else {
      this.ref_x = this.ref_y = this.ref_z = this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }
  
  /**
  Set
  */
   /**
   * Sets components of the vector using two or three separate
   * variables, the data from a Vec, or the values from a float array.
   */
  public Vec4 set(float v) {
    this.x = this.r = this.s = v ;
    this.y = this.g = this.t = v ;
    this.z = this.b = this.p = v ;
    this.w = this.a = this.q = v ;
    return this ;
  }
  
  
  public Vec4 set(float x, float y, float z, float w) {
    this.x = this.r = this.s = x ;
    this.y = this.g = this.t = y ;
    this.z = this.b = this.p = z ;
    this.w = this.a = this.q = w ;
    return this ;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec4 set(Vec4 v) {
    if ( v == null) {
      this.x = this.r = this.s = 0 ;
      this.y = this.g = this.t = 0 ;
      this.z = this.b = this.p = 0 ;
      this.w = this.a =  this.q = 0 ;
      return this ;
    } else {
      this.x = this.r = this.s = v.x ;
      this.y = this.g = this.t = v.y ;
      this.z = this.b = this.p = v.z ;
      this.w = this.a = this.q = v.w ;
      return this ;
    }
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec4 set(float[] source) {
    this.x = this.r = this.s = source[0] ;
    this.y = this.g = this.t = source[1] ;
    this.z = this.b = this.p = source[2] ;
    this.w = this.a = this.q = source[3] ;
    return this ;
  }



  /** 
  METHOD
  */
  /**
  Multiplication
  */
  // mult by a same float
  public Vec4 mult(float mult) {
    x *= mult ; y *= mult ; z *= mult ; w *= mult ;

    set(x,y,z,w) ;
    return this ;
  }
  
    // mult by a different float
  public Vec4 mult(float mult_x, float mult_y, float mult_z, float mult_w) {
    x *= mult_x ; y *= mult_y ; z *= mult_z ; w *= mult_w ;

    set(x,y,z,w) ;
    return this ;
  }
  
  // mult by vector
  public Vec4 mult(Vec4 v) {
    if(v != null) {
      x *= v.x ; 
      y *= v.y ; 
      z *= v.z ; 
      w *= v.w ;
    }
    set(x,y,z,w) ;
    return this ;
  }
  
  
  /**
  Division
  */
  /*
  @ return Vec
  divide Vector by a float value */
  public Vec4 div(float div) {
    x /= div ; y /= div ; z /= div ; w /= div ;
    set(x,y,z,w) ;
    return this ;
  }
  
  // divide by vector
  public Vec4 div(Vec4 v) {
    if(v != null) {
      x /= v.x ; 
      y /= v.y ; 
      z /= v.z ; 
      w /= v.w ;
    }
    set(x,y,z,w) ;
    return this ;
  }
  
  
  /**
  Addition
  */
    /* add float value */
  public Vec4 add(float value) {
    x += value ;
    y += value ;
    z += value ;
    w += value ;
    
    set(x,y,z,w) ;
    return this ;
  }
  public Vec4 add(float value_a,float value_b,float value_c,float value_d) {
    x += value_a ;
    y += value_b ;
    z += value_c ;
    w += value_d ;
    
    set(x,y,z,w) ;
    return this ;
  }
  /* add vec */
  public Vec4 add(Vec v) {
    if(v != null) {
      x += v.x ;
      y += v.y ;
      z += v.z ;
      w += v.w ;
    }
    set(x,y,z,w) ;
    return this  ;
  }
  /* add two Vector together */
  public Vec4 add(Vec v_a, Vec v_b) {
    if(v_a != null && v_b != null) {
      x = v_a.x + v_b.x ;
      y = v_a.y + v_b.y ;
      z = v_a.z + v_b.z ;
      w = v_a.w + v_b.w ;
    }
    set(x,y,z,w) ;
    return this ;
  }

  /**
  Substraction
  */
    /* add float value */
  public Vec4 sub(float value) {
    x -= value ;
    y -= value ;
    z -= value ;
    w -= value ;
    
    set(x,y,z,w) ;
    return this ;
  }
  public Vec4 sub(float value_a,float value_b,float value_c, float value_d) {
    x -= value_a ;
    y -= value_b ;
    z -= value_c ;
    w -= value_d ;
    
    set(x,y,z,w) ;
    return this ;
  }
  /* add one Vector */
  public Vec4 sub(Vec v) {
    if(v != null) {
      x -= v.x ;
      y -= v.y ;
      z -= v.z ;
      w -= v.w ;
    }
    set(x,y,z,w) ;
    return this ;
  }
  
  /* add two Vector together */
  public Vec4 sub(Vec v_a, Vec v_b) {
    if(v_a != null &&  v_b != null) {
      x = v_a.x - v_b.x ;
      y = v_a.y - v_b.y ;
      z = v_a.z - v_b.z ;
      w = v_a.w - v_b.w ;
    }
    set(x,y,z,w) ;
    return this ;
  }


  /**
  Average
  */
  public float average() {
    return (this.x + this.y +this.z +this.w) *.25f ;
  }

  /**
  Dot
  */
  public float dot(Vec4 v) {
    if(v != null) {
      return x*v.x + y*v.y + z*v.z + w*this.w;
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
    
  }
  public float dot(float x, float y, float z, float w) {
    return this.x*x + this.y*y + this.z*z + this.w*w;
  }



  /**
  Direction cartesian
  */
  public Vec4 dir() {
    return dir(Vec4(0)) ;
  }
  public Vec4 dir(float a_x, float a_y, float a_z, float a_w) {
    return dir(Vec4(a_x,a_y,a_z,a_w)) ;
  }
  public Vec4 dir(Vec4 origin) {
    if(origin != null) {
      float dist = dist(origin) ;
      sub(origin) ;
      div(dist) ;
    }
    set(x,y,z,w) ;
    return this ;
  }
  
  /**
  Min Max
  */
    // find the min and the max value in the vector list
  // @ float
  public float max_vec() {
    float [] list = { x, y, z, w } ;
    return max(list) ;
  }
  public float min_vec() {
    float [] list = { x, y, z,w } ;
    return min(list) ;
  }





    /**
  Normalize
  */
  /*
  return normalize vector with length of 1
  @return Vec4
  */
  /*
  Vec4 normalize(Vec min, Vec max) {
    if(min != null && max != null) {
      x = map(x, min.x, max.x, 0, 1) ;
      y = map(y, min.y, max.y, 0, 1) ;
      z = map(z, min.z, max.z, 0, 1) ;
      w = map(w, min.w, max.w, 0, 1) ;
    }
    set(x,y,z,w) ;
    return new Vec4(x,y,z,w) ;
  }
  */
  

  public Vec4 normalize(Vec4 target) {
    if (target == null) {
      target = Vec4();
    }
    float m = mag();
    if (m > 0) {
      target.set(x/m, y/m, z/m, w/m);
    } else {
      target.set(x, y, z, w);
    }
    return target;
  }

  public Vec4 normalize() {
    float m = mag();
    if (m != 0 && m != 1) {
      div(m);
    }
    return this ;
  }

  /**
  Map
  */
  /* mapping
  return mapping vector
  @return Vec4
  */
  public Vec4 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x, minIn, maxIn, minOut, maxOut) ;
    y = map(y, minIn, maxIn, minOut, maxOut) ;
    z = map(z, minIn, maxIn, minOut, maxOut) ;
    w = map(w, minIn, maxIn, minOut, maxOut) ;
    
    set(x,y,z,w) ;
    return this ;
  }
  
  /**
  Magnitude or length
 */
  public float mag() {
    return sqrt(x*x + y*y + z*z + w*w) ;
  }

  public float mag(Vec4 v_target) {
    if(v_target != null) {
      float new_x = (v_target.x -x) *(v_target.x -x) ;
      float new_y = (v_target.y -y) *(v_target.y -y) ;
      float new_z = (v_target.z -z) *(v_target.z -z) ;
      float new_w = (v_target.w -w) *(v_target.w -w) ;
      return sqrt(new_x +new_y +new_z +new_w) ;
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
  }
  
  /**
  Distance
  */
  // distance himself and an other vector
  public float dist(Vec4 v_target) {
    if(v_target != null) {
      float dx = x - v_target.x;
      float dy = y - v_target.y;
      float dz = z - v_target.z;
      float dw = w - v_target.w;
      return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
    } else {
      println("Your Vec arg is", null) ;
      return 0 ;
    }
  }
  
  
  /**
  Jitter
  */
  /* create jitter effect around the vector position */
  /* with global range */
  public Vec4 jitter(int range) {
    return jitter(range,range,range,range) ;
  }
  public Vec4 jitter(Vec4 range) {
    if(range != null) {
      return jitter((int)range.x,(int)range.y,(int)range.z,(int)range.w) ;
    } else return jitter(0) ;
  }
  /* with specific range */
  public Vec4 jitter(int range_x,int range_y,int range_z,int range_w) {
    /*
    x = ref_x ;
    y = ref_y ;
    z = ref_z ;
    w = ref_w ;
    */
    x += random(-range_x, range_x) ;
    y += random(-range_y, range_y) ;
    z += random(-range_z, range_z) ;
    w += random(-range_z, range_z) ;
    
    set(x,y,z,w) ;
    return this ;
  }


    /**
  Equals
  */
  public boolean equals(Vec4 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y) && (z == target.z) && (w == target.w)) {
        return true ; 
      } else return false ;
    } else return false ;
  }
  public boolean equals(float target) {
    if((x == target) && (y == target) && (z == target) && (w == target)) 
    return true ; 
    else return false ;
  }
  
  public boolean equals(float t_x,float t_y,float t_z,float t_w) {
    if((x == t_x) && (y == t_y) && (z == t_z)&& (w == t_w)) 
    return true ; 
    else return false ;
  }


  
   
  /**
  Compare deprecated
  */
  public boolean compare(Vec4 target) {
    if(target != null ) {
      if((x == target.x) && (y == target.y) && (z == target.z) && (w == target.w)) {
        return true ; 
      } else return false ;
    } else return false ;
  }
  public boolean compare(float target) {
    if((x == target) && (y == target) && (z == target) && (w == target)) 
    return true ; 
    else return false ;
  }
  
  public boolean compare(float t_x,float t_y,float t_z,float t_w) {
    if((x == t_x) && (y == t_y) && (z == t_z)&& (w == t_w)) 
    return true ; 
    else return false ;
  }
  
  /**
  Copy
  */
  public Vec4 copy() {
    return new Vec4(x,y,z,w) ;
  }

  /**
  Print info
  */
  public @Override String toString() {
    return "[ " + x + ", " + y + ", " + z + ", " + w + " ]";
  }
}
// END VEC 4
////////////


/**
CLASS Vec5

*/
class Vec5 extends Vec{

  /**
  Constructor
  */
  Vec5(float a, float b, float c, float d, float e) {
    super() ;
    this.a = a ;
    this.b = b ;
    this.c = c ;
    this.d = d ;
    this.e = e ;
  }

  /**
  Random Constructor
  */
  // random generator for the Vec
  Vec5(String key_random, int r1) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.a = random(-r1,r1) ;
      this.b = random(-r1,r1) ;
      this.c = random(-r1,r1) ;
      this.d = random(-r1,r1) ;
      this.e = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.a = random(0,r1) ;
      this.b = random(0,r1) ;
      this.c = random(0,r1) ;
      this.d = random(0,r1) ;
      this.e = random(0,r1) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec5(String key_random, int r1, int r2, int r3, int r4, int r5) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.a = random(-r1,r1) ;
      this.b = random(-r2,r2) ;
      this.c = random(-r3,r3) ;
      this.d = random(-r4,r4) ;
      this.e = random(-r5,r5) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.a = random(0,r1) ;
      this.b = random(0,r2) ;
      this.c = random(0,r3) ;
      this.d = random(0,r4) ;
      this.e = random(0,r5) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec5(String key_random, int a1, int a2, int b1, int b2, int c1, int c2, int d1, int d2, int e1, int e2) {
    super() ;
    if(key_random.equals("RANDOM RANGE")) {
      this.a = random(a1,a2) ;
      this.b = random(b1,b2) ;
      this.c = random(c1,c2) ;
      this.d = random(d1,d2) ;
      this.e = random(e1,e2) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }


  /**
  Set
  */
  /**
  * Sets components of the vector using two or three separate
  * variables, the data from a Vec, or the values from a float array.
  */
  public Vec5 set(float value) {
    this.a = this.b = this.c = this.d = this.e = value;
    return this ;
  }
  
  public Vec5 set(float a, float b, float c, float d, float e) {
    this.a = a ;
    this.b = b;
    this.c = c;
    this.d = d;
    this.e = e;
    return this ;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec5 set(Vec5 v) {
    if( v == null) {
      a = b = c = d = e = 0 ;
      return this ;
    } else {
      a = v.a ;
      b = v.b ;
      c = v.c ;
      d = v.d ;
      e = v.e ;
      return this ;
    }
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec5 set(float[] source) {
    a = source[0] ;
    b = source[1] ;
    c = source[2] ;
    d = source[3] ;
    e = source[4] ;
    return this ;
  }

  /**
  Min Max
  */
    // find the min and the max value in the vector list
  // @ float
  public float max_vec() {
    float [] list = { a,b,c,d,e} ;
    return max(list) ;
  }
  public float min_vec() {
    float [] list = {a,b,c,d,e} ;
    return min(list) ;
  }
  
  /**
  Copy
  */
  public Vec5 copy() {
    return new Vec5(a,b,c,d,e) ;
  }
  
  /**
  Print info
  */
  public @Override String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
  }
}

// END VEC 5
////////////


/**
CLASS Vec6

*/
class Vec6 extends Vec {

  /**
  Constructor
  */
  Vec6(float a, float b, float c, float d, float e, float f) {
    super() ;
    this.a = a ;
    this.b = b ;
    this.c = c ;
    this.d = d ;
    this.e = e ;
    this.f = f ;
  }

  
  /**
  Random Constructor
  */
  Vec6(String key_random, int r1) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.a = random(-r1,r1) ;
      this.b = random(-r1,r1) ;
      this.c = random(-r1,r1) ;
      this.d = random(-r1,r1) ;
      this.e = random(-r1,r1) ;
    } else if(key_random.equals("RANDOM ZERO")) {
      this.a = random(0,r1) ;
      this.b = random(0,r1) ;
      this.c = random(0,r1) ;
      this.d = random(0,r1) ;
      this.e = random(0,r1) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }
  
  Vec6(String key_random, int r1, int r2, int r3, int r4, int r5, int r6) {
    super() ;
    if(key_random.equals("RANDOM")) {
      this.a = random(-r1,r1) ;
      this.b = random(-r2,r2) ;
      this.c = random(-r3,r3) ;
      this.d = random(-r4,r4) ;
      this.e = random(-r5,r5) ;
      this.f = random(-r6,r6) ;
    } else if(key_random.equals("RANDOM")) {
      this.a = random(0,r1) ;
      this.b = random(0,r2) ;
      this.c = random(0,r3) ;
      this.d = random(0,r4) ;
      this.e = random(0,r5) ;
      this.f = random(0,r6) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      println("the key word for the random is not available use the String 'RANDOM' or 'RANDOM ZERO' ") ;
    }
  }

  Vec6(String key_random, int a1, int a2, int b1, int b2, int c1, int c2, int d1, int d2, int e1, int e2, int f1, int f2) {
    super() ;
    if(key_random.equals("RANDOM RANGE")) {
      this.a = random(a1,a2) ;
      this.b = random(b1,b2) ;
      this.c = random(c1,c2) ;
      this.d = random(d1,d2) ;
      this.e = random(e1,e2) ;
      this.f = random(f1,f2) ;
    } else {
      this.a = this.b = this.c = this.d = this.e = this.f = 0 ;
      println("the key word for the random is not available use the String 'RANDOM RANGE' ") ;
    }
  }

  /**
  Set
  */
  /**
  * Sets components of the vector using two or three separate
  * variables, the data from a Vec, or the values from a float array.
  */
  public Vec6 set(float v) {
    this.a = this.b = this.c = this.d = this.e = this.f = v;
    return this;
  }

  public Vec6 set(float a, float b, float c, float d, float e, float f) {
    this.a = a ;
    this.b = b ;
    this.c = c ;
    this.d = d ;
    this.e = e ;
    this.f = f ;
    return this;
  }


  /**
   * @param v any variable of type Vec
   */
  public Vec6 set(Vec6 v) {
    if ( v == null) {    
      a = b = c = d = e = f = 0 ;
      return this ;
    } else {
      a = v.a ;
      b = v.b ;
      c = v.c ;
      d = v.d ;
      e = v.e ;
      f = v.f ;
      return this ;
    }
  }


  /**
   * Set the x, y (and maybe z) coordinates using a float[] array as the source.
   * @param source array to copy from
   */
  public Vec6 set(float[] source) {
    a = source[0] ;
    b = source[1] ;
    c = source[2] ;
    d = source[3] ;
    e = source[4] ;
    f = source[5] ;
    return this ;
  }


  /**
  Min Max
  */
      // find the min and the max value in the vector list
  // @ float
  public float max_vec() {
    float [] list = {a,b,c,d,e,f} ;
    return max(list) ;
  }
  public float min_vec() {
    float [] list = {a,b,c,d,e,f} ;
    return min(list) ;
  }

  /**
  Copy
  */
  public Vec6 copy() {
    return new Vec6(a,b,c,d,e,f) ;
  }

  /**
  Print info
  */
  public @Override String toString() {
    return "[ " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]" ;
  }
}

// END VEC 6
////////////
















/**
External Methods VEC

*/
/**
Addition
*/
// return the resultat of vector addition
public Vec2 add(Vec2 v_a, Vec2 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    return new Vec2(x,y) ;
  }

}

public Vec3 add(Vec3 v_a, Vec3 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    float z = v_a.z + v_b.z ;
    return new Vec3(x,y,z)  ;
  }
}

public Vec4 add(Vec4 v_a, Vec4 v_b) {  
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    float z = v_a.z + v_b.z ;
    float w = v_a.w + v_b.w ;
    return new Vec4(x,y,z, w)  ;
  }
}

public Vec2 add(Vec2 v_a, float v) {  
  if(v_a == null ) {
    return null ;
  } else {
    float x = v_a.x +v ;
    float y = v_a.y +v ;
    return new Vec2(x,y) ;
  }
}

public Vec3 add(Vec3 v_a, float v) {
  if(v_a == null ) {
    return null ;
  } else {
    float x = v_a.x +v ;
    float y = v_a.y +v ;
    float z = v_a.z +v ;
    return new Vec3(x,y,z)  ;
  }
}

public Vec4 add(Vec4 v_a, float v) {
  if(v_a == null ) {
    return null ;
  } else {
    float x = v_a.x +v ;
    float y = v_a.y +v ;
    float z = v_a.z +v ;
    float w = v_a.w +v ;
    return new Vec4(x,y,z, w)  ;
  }
}


/**
Multiplication
*/
// return the resultat of vector multiplication
public Vec2 mult(Vec2 v_a, Vec2 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    return new Vec2(x,y) ;
  }
}

public Vec3 mult(Vec3 v_a, Vec3 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    float z = v_a.z * v_b.z ;
    return new Vec3(x,y,z)  ;
  }
}

public Vec4 mult(Vec4 v_a, Vec4 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    float z = v_a.z * v_b.z ;
    float w = v_a.w * v_b.w ;
    return new Vec4(x,y,z, w)  ;
  }
}

public Vec2 mult(Vec2 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x *v ;
    float y = v_a.y *v ;
    return new Vec2(x,y) ;
  }
}

public Vec3 mult(Vec3 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x *v ;
    float y = v_a.y *v ;
    float z = v_a.z *v ;
    return new Vec3(x,y,z)  ;
  }
}

public Vec4 mult(Vec4 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x *v ;
    float y = v_a.y *v ;
    float z = v_a.z *v ;
    float w = v_a.w *v ;
    return new Vec4(x,y,z, w)  ;
  }
}


/**
Division
*/
// return the resultat of vector addition
public Vec2 div(Vec2 v_a, Vec2 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x / v_b.x ;
    float y = v_a.y / v_b.y ;
    return new Vec2(x,y) ;
  }
}

public Vec3 div(Vec3 v_a, Vec3 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x / v_b.x ;
    float y = v_a.y / v_b.y ;
    float z = v_a.z / v_b.z ;
    return new Vec3(x,y,z)  ;
  }
}

public Vec4 div(Vec4 v_a, Vec4 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x / v_b.x ;
    float y = v_a.y / v_b.y ;
    float z = v_a.z / v_b.z ;
    float w = v_a.w / v_b.w ;
    return new Vec4(x,y,z, w)  ;
  }
}


public Vec2 div(Vec2 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x /v ;
    float y = v_a.y /v ;
    return new Vec2(x,y) ;
  }
}

public Vec3 div(Vec3 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x /v ;
    float y = v_a.y /v ;
    float z = v_a.z /v ;
    return new Vec3(x,y,z)  ;
  }
}

public Vec4 div(Vec4 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x /v ;
    float y = v_a.y /v ;
    float z = v_a.z /v ;
    float w = v_a.w /v;
    return new Vec4(x,y,z, w)  ;
  }
}


/**
Substraction
*/
// return the resultat of vector substraction
public Vec2 sub(Vec2 v_a, Vec2 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x - v_b.x ;
    float y = v_a.y - v_b.y ;
    return new Vec2(x,y) ;
  }
}

public Vec3 sub(Vec3 v_a, Vec3 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x - v_b.x ;
    float y = v_a.y - v_b.y ;
    float z = v_a.z - v_b.z ;
    return new Vec3(x,y,z)  ;
  }
}

public Vec4 sub(Vec4 v_a, Vec4 v_b) {
  if(v_a == null || v_b == null) {
    return null ;
  } else {
    float x = v_a.x - v_b.x ;
    float y = v_a.y - v_b.y ;
    float z = v_a.z - v_b.z ;
    float w = v_a.w - v_b.w ;
    return new Vec4(x,y,z, w)  ;
  }
}

public Vec2 sub(Vec2 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x -v ;
    float y = v_a.y -v ;
    return new Vec2(x,y) ;
  }
}

public Vec3 sub(Vec3 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x -v ;
    float y = v_a.y -v ;
    float z = v_a.z -v ;
    return new Vec3(x,y,z)  ;
  }
}

public Vec4 sub(Vec4 v_a, float v) {
  if(v_a == null) {
    return null ;
  } else {
    float x = v_a.x -v ;
    float y = v_a.y -v ;
    float z = v_a.z -v ;
    float w = v_a.w -v ;
    return new Vec4(x,y,z, w)  ;
  }
}


/**
Cross
*/
public Vec3 cross(Vec3 v1, Vec3 v2, Vec3 target) {
  if(v1 == null ||  v2 == null || target == null) {
    return null ;
  } else {
    float crossX = v1.y * v2.z - v2.y * v1.z;
    float crossY = v1.z * v2.x - v2.z * v1.x;
    float crossZ = v1.x * v2.y - v2.x * v1.y;

    if (target == null) {
      target = Vec3(crossX, crossY, crossZ);
    } else {
      target.set(crossX, crossY, crossZ);
    }
    return target ;
  }  
}


/**
Equals
*/
/*
Compare Vector with or without area
compare two vectors Vec without area

@ return boolean
*/
// Vec2 compare
public boolean equals(Vec2 v_a, Vec2 v_b) {
  return compare(Vec4(v_a.x,v_a.y,0,0),Vec4(v_b.x,v_b.y,0,0)) ;
}

// Vec3 compare
public boolean equals(Vec3 v_a, Vec3 v_b) {
  return compare(Vec4(v_a.x, v_a.y, v_a.z, 0),Vec4(v_b.x, v_b.y, v_b.z, 0)) ;
}
// Vec4 compare
public boolean equals(Vec4 v_a, Vec4 v_b) {
  if( v_a != null && v_b != null ) {
    if((v_a.x == v_b.x) && (v_a.y == v_b.y) && (v_a.z == v_b.z) && (v_a.w == v_b.w)) {
            return true ; 
    } else return false ;
  } else return false ;
}


/* 
compare if the first vector is in the area of the second vector, 
the area of the second vector is define by a Vec area, 
that give the possibility of different size for each component
*/
/*
@ return boolean
*/
// Vec method
// Vec2 compare with area
public boolean equals(Vec2 v_a, Vec2 v_b, Vec2 area) {
  return compare(Vec4(v_a.x, v_a.y, 0, 0),Vec4(v_b.x, v_b.y, 0, 0),Vec4(area.x, area.y, 0, 0)) ;
}
// Vec3 compare with area
public boolean equals(Vec3 v_a, Vec3 v_b, Vec3 area) {
  return compare(Vec4(v_a.x, v_a.y, v_a.z, 0),Vec4(v_b.x, v_b.y, v_b.z, 0),Vec4(area.x, area.y, area.z, 0)) ;
}
// Vec4 compare with area
public boolean equals(Vec4 v_a, Vec4 v_b, Vec4 area) {
  if( v_a != null && v_b != null && area != null ) {
    if(    (v_a.x >= v_b.x -area.x && v_a.x <= v_b.x +area.x) 
        && (v_a.y >= v_b.y -area.y && v_a.y <= v_b.y +area.y) 
        && (v_a.z >= v_b.z -area.z && v_a.z <= v_b.z +area.z) 
        && (v_a.w >= v_b.w -area.w && v_a.w <= v_b.w +area.w)) {
            return true ; 
    } else return false ;
  } else return false ;
}





/**
Compare deprecated
*/
/*
Compare Vector with or without area
compare two vectors Vec without area

@ return boolean
*/
// Vec2 compare
public boolean compare(Vec2 v_a, Vec2 v_b) {
  return compare(Vec4(v_a.x,v_a.y,0,0),Vec4(v_b.x,v_b.y,0,0)) ;
}

// Vec3 compare
public boolean compare(Vec3 v_a, Vec3 v_b) {
  return compare(Vec4(v_a.x, v_a.y, v_a.z, 0),Vec4(v_b.x, v_b.y, v_b.z, 0)) ;
}
// Vec4 compare
public boolean compare(Vec4 v_a, Vec4 v_b) {
  if( v_a != null && v_b != null ) {
    if((v_a.x == v_b.x) && (v_a.y == v_b.y) && (v_a.z == v_b.z) && (v_a.w == v_b.w)) {
            return true ; 
    } else return false ;
  } else return false ;
}


/* 
compare if the first vector is in the area of the second vector, 
the area of the second vector is define by a Vec area, 
that give the possibility of different size for each component
*/
/*
@ return boolean
*/
// Vec method
// Vec2 compare with area
public boolean compare(Vec2 v_a, Vec2 v_b, Vec2 area) {
  return compare(Vec4(v_a.x, v_a.y, 0, 0),Vec4(v_b.x, v_b.y, 0, 0),Vec4(area.x, area.y, 0, 0)) ;
}
// Vec3 compare with area
public boolean compare(Vec3 v_a, Vec3 v_b, Vec3 area) {
  return compare(Vec4(v_a.x, v_a.y, v_a.z, 0),Vec4(v_b.x, v_b.y, v_b.z, 0),Vec4(area.x, area.y, area.z, 0)) ;
}
// Vec4 compare with area
public boolean compare(Vec4 v_a, Vec4 v_b, Vec4 area) {
  if( v_a != null && v_b != null && area != null ) {
    if(    (v_a.x >= v_b.x -area.x && v_a.x <= v_b.x +area.x) 
        && (v_a.y >= v_b.y -area.y && v_a.y <= v_b.y +area.y) 
        && (v_a.z >= v_b.z -area.z && v_a.z <= v_b.z +area.z) 
        && (v_a.w >= v_b.w -area.w && v_a.w <= v_b.w +area.w)) {
            return true ; 
    } else return false ;
  } else return false ;
}



/**
Map
*/
/*
return mapping vector
@return Vec2, Vec3 or Vec4
*/
public Vec2 mapVec(Vec2 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    return new Vec2(x,y) ;
  } else return null ;
}
public Vec3 mapVec(Vec3 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
    return new Vec3(x,y,z) ;
  } else return null ;
}
public Vec4 mapVec(Vec4 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
    float w = map(v.w, minIn, maxIn, minOut, maxOut) ;
    return new Vec4(x,y,z,w) ;
  } else return null ;
}

/**
Magnitude or length
*/
/*
@return float
*/
// mag Vec2
public float mag(Vec2 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  return sqrt(x+y) ;
}

public float mag(Vec2 v_a, Vec2 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  return sqrt(x+y) ;
}
// mag Vec3
public float mag(Vec3 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  float z = v_a.z *v_a.z ;
  return sqrt(x+y+z) ;
}

public float mag(Vec3 v_a, Vec3 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  float z = (v_b.z -v_a.z)*(v_b.z -v_a.z) ;
  return sqrt(x+y+z) ;
}
// mag Vec4
public float mag(Vec4 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  float z = v_a.z *v_a.z ;
  float w = v_a.w *v_a.w ;
  return sqrt(x+y+z+w) ;
}

public float mag(Vec4 v_a, Vec4 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  float z = (v_b.z -v_a.z)*(v_b.z -v_a.z) ;
  float w = (v_b.w -v_a.w)*(v_b.w -v_a.w) ;
  return sqrt(x+y+z+w) ;
}



/**
Distance
*/
/*
return float
return the distance beatwen two vectors
*/
public float dist(Vec2 v_a, Vec2 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    return (float) Math.sqrt(dx*dx + dy*dy);
}
public float dist(Vec3 v_a, Vec3 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    float dz = v_a.z - v_b.z;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
}
public float dist(Vec4 v_a, Vec4 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    float dz = v_a.z - v_b.z;
    float dw = v_a.w - v_b.w;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
}


/**
Deprecated Middle
*/
/*
@ return Vec2, Vec3 or Vec4
return the middle between two Vector
*/
public Vec2 middle(Vec2 p1, Vec2 p2)  {
  Vec2 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

public Vec2 middle(Vec2 [] list)  {
  Vec2 middle = Vec2() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

public Vec3 middle(Vec3 p1, Vec3 p2) {
  Vec3 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}

public Vec3 middle(Vec3 [] list)  {
  Vec3 middle = Vec3() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

public Vec4 middle(Vec4 p1, Vec4 p2)  {
  Vec4 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

public Vec4 middle(Vec4 [] list)  {
  Vec4 middle = Vec4() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}


/**
barycenter
*/
public Vec2 barycenter(Vec2... v) {
  int div_num = v.length ;
  Vec2 sum = Vec2() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}

 
public Vec3 barycenter(Vec3... v) {
  int div_num = v.length ;
  Vec3 sum = Vec3() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}

public Vec4 barycenter(Vec4... v) {
  int div_num = v.length ;
  Vec4 sum = Vec4() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}










/**
Jitter
*/
// Vec2
public Vec2 jitter_2D(int range) {
  return jitter_2D(range, range) ;
}
public Vec2 jitter_2D(Vec2 range) {
  return jitter_2D((int)range.x, (int)range.y) ;
}
public Vec2 jitter_2D(int range_x, int range_y) {
  Vec2 jitter = Vec2() ;
  jitter.x = random(-range_x, range_x) ;
  jitter.y = random(-range_y, range_y) ;
  return jitter ;
}
// Vec3
public Vec3 jitter_3D(int range) {
  return jitter_3D(range, range, range) ;
}
public Vec3 jitter_3D(Vec3 range) {
  return jitter_3D((int)range.x, (int)range.y, (int)range.z) ;
}
public Vec3 jitter_3D(int range_x, int range_y, int range_z) {
  Vec3 jitter = Vec3() ;
  jitter.x = random(-range_x, range_x) ;
  jitter.y = random(-range_y, range_y) ;
  jitter.z = random(-range_z, range_z) ;
  return jitter ;
}
// Vec4
public Vec4 jitter_4D(int range) {
  return jitter_4D(range, range, range, range) ;
}
public Vec4 jitter_4D(Vec4 range) {
  return jitter_4D((int)range.x, (int)range.y, (int)range.z, (int)range.w) ;
}
public Vec4 jitter_4D(int range_x, int range_y, int range_z, int range_w) {
  Vec4 jitter = Vec4() ;
  jitter.x = random(-range_x, range_x) ;
  jitter.y = random(-range_y, range_y) ;
  jitter.z = random(-range_z, range_z) ;
  jitter.w = random(-range_w, range_w) ;
  return jitter ;
}
// END JITTER
/////////////


/**
Normalize
*/
// VEC 2 from angle
///////////////////
public Vec2 norm_rad(float angle) {
  float x = (float)Math.cos(angle) ;
  float y = (float)Math.sin(angle) ;
  return Vec2(x,y) ;
}

public Vec2 norm_deg(float angle) {
  angle = radians(angle) ;
  float x = (float)Math.cos(angle) ;
  float y = (float)Math.sin(angle) ;
  return Vec2(x,y) ;
}


// normalize direction

public Vec2 norm_dir(String type, float direction) {
  float x, y = 0 ;
  if(type.equals("DEG")) {
    float angle = TWO_PI/360.f;
    direction = 360-direction;
    direction += 180;
    x = sin(angle *direction) ;
    y = cos(angle *direction);
  } else if (type.equals("RAD")) {
    x = sin(direction) ;
    y = cos(direction);
  } else {
    println("the type must be 'RAD' for radians or 'DEG' for degrees") ;
    x = 0 ;
    y = 0 ;
  }
  return new Vec2(x,y) ;
}
// END VEC FROM ANGLE
/////////////////////



/**
translate int color to Vec4 color
*/
public Vec4 color_HSB_a(int c) {
  return Vec4(hue(c), saturation(c), brightness(c), alpha(c)) ;
}

public Vec4 color_RGB_a(int c) {
  return Vec4(red(c), green(c), blue(c), alpha(c)) ;
}

public Vec3 color_HSB(int c) {
  return Vec3(hue(c), saturation(c), brightness(c)) ;
}

public Vec3 color_RGB(int c) {
  return Vec3(red(c), green(c), blue(c)) ;
}





/**
Return a new Vec
*/
/**
Vec 2
*/
public Vec2 Vec2() {
  return new Vec2(0,0) ;
}

public Vec2 Vec2(float x, float y) { 
  return new Vec2(x,y) ;
}

public Vec2 Vec2(float v) {
  return new Vec2(v,v) ;
}

public Vec2 Vec2(PVector p) {
  if(p == null) {
    println("PVector null, instead '0' is used to build Vec2") ;
    return new Vec2(0,0) ;
  } else {
    return new Vec2(p.x, p.y) ;
  }
}

public Vec2 Vec2(Vec2 p) {
  if(p == null) {
    println("Vec2 null, instead '0' is used to build Vec2") ;
    return new Vec2(0,0) ;
  } else {
    return new Vec2(p.x, p.y) ;
  }
}


public Vec2 Vec2(String s, int x, int y) { 
  return new Vec2(s,x,y) ;
}

public Vec2 Vec2(String s, int a, int b, int c, int d) { 
  return new Vec2(s,a,b,c,d) ;
}

public Vec2 Vec2(String s, int v) {
  return new Vec2(s,v) ;
}
/**
Vec 3
*/
public Vec3 Vec3() {
  return new Vec3(0,0,0) ;
}

public Vec3 Vec3(float x, float y, float z) {
  return new Vec3(x,y,z) ;
}

public Vec3 Vec3(float v) {
  return new Vec3(v,v,v) ;
}

public Vec3 Vec3(PVector p) {
  if(p == null) {
    println("PVector null, instead '0' is used to build Vec3") ;
    return new Vec3(0,0,0) ;
  } else {
    return new Vec3(p.x, p.y, p.z) ;
  }
}

public Vec3 Vec3(Vec3 p) {
  if(p == null) {
    println("Vec3 null, instead '0' is used to build Vec3") ;
    return new Vec3(0,0,0) ;
  } else {
    return new Vec3(p.x, p.y, p.z) ;
  }
}

public Vec3 Vec3(Vec2 p) {
  if(p == null) {
    println("Vec2 null, instead '0' is used to build Vec3") ;
    return new Vec3(0,0,0) ;
  } else {
    return new Vec3(p.x, p.y, 0) ;
  }
}

public Vec3 Vec3(String s, int x, int y, int z) { 
  return new Vec3(s,x,y,z) ;
}

public Vec3 Vec3(String s, int a, int b, int c, int d, int e, int f) { 
  return new Vec3(s,a,b,c,d,e,f) ;
}

public Vec3 Vec3(String s, int v) {
  return new Vec3(s,v) ;
}
/**
Vec 4
*/
public Vec4 Vec4() {
  return new Vec4(0,0,0,0) ;
}

public Vec4 Vec4(float x, float y, float z, float w) {
  return new Vec4(x,y,z,w) ;
}

public Vec4 Vec4(float v) {
  return new Vec4(v,v,v,v) ;
}

// build with Vec
public Vec4 Vec4(Vec4 p) {
  if(p == null) {
    println("Vec4 null, instead '0' is used to build Vec4") ;
    return new Vec4(0,0,0,0) ;
  } else {
    return new Vec4(p.x, p.y, p.z, p.w) ;
  }
}
public Vec4 Vec4(Vec3 p) {
  if(p == null) {
    println("Vec3 null, instead '0' is used to build Vec4") ;
    return new Vec4(0,0,0,0) ;
  } else {
    return new Vec4(p.x, p.y, p.z, 0) ;
  }
}
public Vec4 Vec4(Vec2 p) {
  if(p == null) {
    println("Vec2 null, instead '0' is used to build Vec4") ;
    return new Vec4(0,0,0,0) ;
  } else {
    return new Vec4(p.x, p.y, 0, 0) ;
  }
}

public Vec4 Vec4(Vec2 p1,Vec2 p2) {
  if(p1 == null) {
    println("first Vec2 null, instead '0' is used to build Vec4") ;
    return new Vec4(0,0, p2.x, p2.y) ;
  } else if (p2 == null) {
    println("second Vec2 null, instead '0' is used to build Vec4") ;
    return new Vec4(p1.x, p1.y, 0, 0) ;
  }  else if (p1 == null && p2 == null) {
    println("all Vec2 null, instead '0' is used to build Vec4") ;
    return new Vec4(0,0,0,0) ;
  } else {
    return new Vec4(p1.x, p1.y, p2.x, p2.y) ;
  }
}


public Vec4 Vec4(String s, int x, int y, int z, int w) { 
  return new Vec4(s,x,y,z,w) ;
}

public Vec4 Vec4(String s, int a, int b, int c, int d, int e, int f, int g, int h) { 
  return new Vec4(s,a,b,c,d,e,f,g,h) ;
}

public Vec4 Vec4(String s, int v) {
  return new Vec4(s,v) ;
}
/**
Vec 5
*/
public Vec5 Vec5() {
  return new Vec5(0,0,0,0,0) ;
}

public Vec5 Vec5(float a, float b, float c, float d, float e) {
  return new Vec5(a,b,c,d,e) ;
}

public Vec5 Vec5(float v) {
  return new Vec5(v,v,v,v,v) ;
}

// build with Vec
public Vec5 Vec5(Vec5 p) {
  if(p == null) {
    println("Vec5 null, instead '0' is used to build Vec5") ;
    return new Vec5(0,0,0,0,0) ;
  } else {
    return new Vec5(p.a,p.b,p.c,p.d,p.e) ;
  }
}

public Vec5 Vec5(Vec4 p) {
  if(p == null) {
    println("Vec4 null, instead '0' is used to build Vec5") ;
    return new Vec5(0,0,0,0,0) ;
  } else {
    return new Vec5(p.x,p.y,p.z,p.w,0) ;
  }
}
public Vec5 Vec5(Vec3 p) {
  if(p == null) {
    println("Vec3 null, instead '0' is used to build Vec5") ;
    return new Vec5(0,0,0,0,0) ;
  } else {
    return new Vec5(p.x,p.y,p.z,0,0) ;
  }
}
public Vec5 Vec5(Vec2 p) {
  if(p == null) {
    println("Vec2 null, instead '0' is used to build Vec5") ;
    return new Vec5(0,0,0,0,0) ;
  } else {
    return new Vec5(p.x,p.y,0,0,0) ;
  }
}

public Vec5 Vec5(Vec2 p1,Vec2 p2) {
  if(p1 == null) {
    println("first Vec2 null, instead '0' is used to build Vec5") ;
    return new Vec5(0,0, p2.x, p2.y, 0) ;
  } else if (p2 == null) {
    println("second Vec2 null, instead '0' is used to build Vec5") ;
    return new Vec5(p1.x, p1.y, 0, 0, 0) ;
  }  else if (p1 == null && p2 == null) {
    println("all Vec2 null, instead '0' is used to build Vec4") ;
    return new Vec5(0,0,0,0,0) ;
  } else {
    return new Vec5(p1.x,p1.y,p2.x,p2.y,0) ;
  }
}
public Vec5 Vec5(Vec2 p1,Vec3 p2) {
  if(p1 == null) {
    println("first Vec2 null, instead '0' is used to build Vec5") ;
    return new Vec5(0, 0, p2.x, p2.y, p2.z) ;
  } else if (p2 == null) {
    println("second Vec3 null, instead '0' is used to build Vec5") ;
    return new Vec5(p1.x, p1.y, 0, 0, 0) ;
  }  else if (p1 == null && p2 == null) {
    println("Vec2 and Vec3 null, instead '0' is used to build Vec4") ;
    return new Vec5(0,0,0,0,0) ;
  } else {
    return new Vec5(p1.x,p1.y,p2.x,p2.y,p2.z) ;
  }
}

public Vec5 Vec5(Vec3 p1,Vec2 p2) {
  if(p1 == null) {
    println("first Vec3 null, instead '0' is used to build Vec5") ;
    return new Vec5(0, 0, 0, p2.x, p2.y) ;
  } else if (p2 == null) {
    println("second Vec2 null, instead '0' is used to build Vec5") ;
    return new Vec5(p1.x, p1.y, p1.z, 0, 0) ;
  }  else if (p1 == null && p2 == null) {
    println("Vec3 and Vec2 null, instead '0' is used to build Vec4") ;
    return new Vec5(0,0,0,0,0) ;
  } else {
    return new Vec5(p1.x,p1.y,p1.z,p2.x,p2.y) ;
  }
}



public Vec5 Vec5(String s, int a, int b, int c, int d, int e) { 
  return new Vec5(s,a,b,c,d,e) ;
}

public Vec5 Vec5(String s, int a, int b, int c, int d, int e, int f, int g, int h, int i, int j) { 
  return new Vec5(s,a,b,c,d,e,f,g,h,i,j) ;
}

public Vec5 Vec5(String s, int v) {
  return new Vec5(s,v) ;
}
/**
Vec 6
*/
public Vec6 Vec6() {
  return new Vec6(0,0,0,0,0,0) ;
}

public Vec6 Vec6(float a, float b, float c, float d, float e, float f) {
  return new Vec6(a,b,c,d,e,f) ;
}

public Vec6 Vec6(float v) {
  return new Vec6(v,v,v,v,v,v) ;
}

// build with vec
public Vec6 Vec6(Vec6 p) {
  if(p == null) {
    println("Vec6 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p.a,p.b,p.c,p.d,p.e,p.f) ;
  }
}
public Vec6 Vec6(Vec5 p) {
  if(p == null) {
    println("Vec5 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p.a,p.b,p.c,p.d,p.e,0) ;
  }
}
public Vec6 Vec6(Vec4 p) {
  if(p == null) {
    println("Vec4 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p.x,p.y,p.z,p.w,0,0) ;
  }
}
public Vec6 Vec6(Vec3 p) {
  if(p == null) {
    println("Vec3 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p.x,p.y,p.z,0,0,0) ;
  }
}
public Vec6 Vec6(Vec2 p) {
  if(p == null) {
    println("Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p.x,p.y,0,0,0,0) ;
  }
}
public Vec6 Vec6(Vec2 p1,Vec2 p2) {
  if(p1 == null) {
    println("first Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0, p2.x, p2.y, 0,0) ;
  } else if (p2 == null) {
    println("second Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, 0, 0, 0,0) ;
  }  else if (p1 == null && p2 == null) {
    println("all Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p1.x,p1.y,p2.x,p2.y,0,0) ;
  }
}
public Vec6 Vec6(Vec2 p1,Vec3 p2) {
  if(p1 == null) {
    println("first Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0, 0, p2.x, p2.y, p2.z,0) ;
  } else if (p2 == null) {
    println("second Vec3 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, 0, 0, 0,0) ;
  }  else if (p1 == null && p2 == null) {
    println("Vec2 and Vec3 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p1.x,p1.y,p2.x,p2.y,p2.z, 0) ;
  }
}
public Vec6 Vec6(Vec3 p1,Vec2 p2) {
  if(p1 == null) {
    println("first Vec3 null, instead '0' is used to build Vec6") ;
    return new Vec6(0, 0, 0, p2.x, p2.y,0) ;
  } else if (p2 == null) {
    println("second Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, p1.z, 0, 0, 0) ;
  }  else if (p1 == null && p2 == null) {
    println("Vec3 and Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p1.x,p1.y,p1.z,p2.x,p2.y,0) ;
  }
}
public Vec6 Vec6(Vec2 p1,Vec4 p2) {
  if(p1 == null) {
    println("first Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0, 0, p2.x, p2.y, p2.z, p2.w) ;
  } else if (p2 == null) {
    println("second Vec4 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, 0, 0, 0, 0) ;
  }  else if (p1 == null && p2 == null) {
    println("Vec2 and Vec4 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p1.x,p1.y,p2.x,p2.y,p2.z, p2.w) ;
  }
}

public Vec6 Vec6(Vec4 p1,Vec2 p2) {
  if(p1 == null) {
    println("first Vec4 null, instead '0' is used to build Vec6") ;
    return new Vec6(0, 0, 0, 0, p2.x, p2.y) ;
  } else if (p2 == null) {
    println("second Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, p1.z, p1.w, 0, 0) ;
  }  else if (p1 == null && p2 == null) {
    println("Vec4 and Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p1.x,p1.y,p1.z,p1.w, p2.x,p2.y) ;
  }
}

public Vec6 Vec6(Vec2 p1,Vec2 p2, Vec2 p3) {
  if(p1 == null && p2!= null && p3 != null) {
    println("first Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0, p2.x, p2.y,p3.x,p3.y) ;
  } else if (p1 != null && p2 == null && p3 != null) {
    println("second Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, 0, 0, p3.x,p3.y) ;
  } else if (p1 != null && p2 != null && p3 == null) {
    println("third Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, p2.x, p2.y ,0,0) ;
  } else if (p1 == null && p2 == null && p3 != null) {
    println("first and second Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0, 0, 0, 0,p3.x,p3.y) ;
  } else if (p1 == null && p2 != null && p3 == null) {
    println("first and third Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0, 0, p2.x, p2.y, 0, 0) ;
  } else if (p1 != null && p2 == null && p3 == null) {
    println("second and third Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, 0,0, 0, 0) ;
  } else if (p1 == null && p2 == null && p3 == null) {
    println("all Vec2 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y) ;
  }
}

public Vec6 Vec6(Vec3 p1,Vec3 p2) {
  if(p1 == null) {
    println("first Vec3 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0, 0, p2.x, p2.y, p2.z) ;
  } else if (p2 == null) {
    println("second Vec3 null, instead '0' is used to build Vec6") ;
    return new Vec6(p1.x, p1.y, p1.z, 0, 0,0) ;
  }  else if (p1 == null && p2 == null) {
    println("all Vec3 null, instead '0' is used to build Vec6") ;
    return new Vec6(0,0,0,0,0,0) ;
  } else {
    return new Vec6(p1.x,p1.y,p2.x,p2.y,0,0) ;
  }
}



public Vec6 Vec6(String s, int a, int b, int c, int d, int e, int f) { 
  return new Vec6(s,a,b,c,d,e,f) ;
}

public Vec6 Vec6(String s, int a, int b, int c, int d, int e, int f, int g, int h, int i, int j, int k, int l) { 
  return new Vec6(s,a,b,c,d,e,f,g,h,i,j,k,l) ;
}

public Vec6 Vec6(String s, int v) {
  return new Vec6(s,v) ;
}










/**
PROCESSING VEC METHOD 1.0.1

*/
/**
random
*/
public float random (Vec2 v) {
  return random(v.x, v.y) ;
}
/**
background
*/
public void background(Vec4 c) {
  background(c.r,c.g,c.b,c.a) ;
}

public void background(Vec3 c) {
  background(c.r,c.g,c.b) ;
}

public void background(Vec2 c) {
  background(c.x,c.y) ;
}

/**
Ellipse
*/
public void ellipse(Vec2 p, Vec2 s) {
  ellipse(p.x, p.y, s.x, s.y) ;
}
public void ellipse(Vec3 p, Vec2 s) {
  if(renderer_P3D()) {
    start_matrix() ;
    translate(p.x, p.y, p.z) ;
    ellipse(0,0, s.x, s.y) ;
    stop_matrix() ;
  } else ellipse(p.x, p.y, s.x, s.y) ;
}



/**
Rect
*/
public void rect(Vec2 p, Vec2 s) {
  rect(p.x, p.y, s.x, s.y) ;
}
public void rect(Vec3 p, Vec2 s) {
  if(renderer_P3D()) {
    start_matrix() ;
    translate(p.x, p.y,p.z ) ;
    rect(0,0, s.x, s.y) ;
    stop_matrix() ;
  } else rect(p.x, p.y, s.x, s.y) ;
}

/**
Box
*/
public void box(Vec3 p) {
  box(p.x, p.y, p.z) ;
}

/**
Point
*/
public void point(Vec2 p) {
  point(p.x, p.y) ;
}
public void point(Vec3 p) {
  if(renderer_P3D()) point(p.x, p.y, p.z) ; else  point(p.x, p.y) ;
}
/**
Line
*/
public void line(Vec2 a, Vec2 b){
  line(a.x, a.y, b.x,b.y) ;
}
public void line(Vec3 a, Vec3 b){
  if(renderer_P3D()) line(a.x, a.y, a.z, b.x,b.y, b.z) ; else line(a.x, a.y, b.x,b.y) ;
}
/**
Vertex
*/
public void vertex(Vec2 a){
  vertex(a.x, a.y) ;
}
public void vertex(Vec3 a){
  if(renderer_P3D()) vertex(a.x, a.y, a.z) ; else vertex(a.x, a.y) ;
}

/**
Bezier Vertex
*/
public void bezierVertex(Vec2 a, Vec2 b, Vec2 c) {
  bezierVertex(a.x, a.y, b.x, b.y, c.x, c.y) ;
}

public void bezierVertex(Vec3 a, Vec3 b, Vec3 c) {
  if(renderer_P3D()) bezierVertex(a.x, a.y, a.z, b.x, b.y, b.z, c.x, c.y, c.z) ; else bezierVertex(a.x, a.y, b.x, b.y, c.x, c.y) ;
}

/**
Quadratic Vertex
*/
public void quadraticVertex(Vec2 a, Vec2 b) {
  quadraticVertex(a.x, a.y, b.x, b.y) ;
}

public void quadraticVertex(Vec3 a, Vec3 b) {
  if(renderer_P3D()) quadraticVertex(a.x, a.y, a.z, b.x, b.y, b.z) ; else quadraticVertex(a.x, a.y, b.x, b.y) ;
}

/**
Curve Vertex
*/
public void curveVertex(Vec2 a){
  curveVertex(a.x, a.y) ;
}
public void curveVertex(Vec3 a){
  if(renderer_P3D()) curveVertex(a.x, a.y, a.z) ; else curveVertex(a.x, a.y) ;
}


/**
Fill
*/
public void fill(Vec2 c) {
  if( c.y > 0) fill(c.x, c.y) ; else noFill() ;
}
public void fill(Vec3 c) {
  fill(c.r,c.g,c.b) ;
}

public void fill(Vec3 c, float a) {
  if( a > 0)  fill(c.r,c.g,c.b, a) ; else noFill() ;
}

public void fill(Vec4 c) {
  if( c.a > 0) fill(c.r,c.g,c.b,c.a) ; else noFill() ;
}
/**
Stroke
*/
public void stroke(Vec2 c) {
  if(c.y > 0) stroke(c.x, c.y) ; else noStroke() ;
}
public void stroke(Vec3 c) {
  stroke(c.r,c.g,c.b) ;
}

public void stroke(Vec3 c, float a) {
  if( a > 0)  stroke(c.r,c.g,c.b, a) ; else noStroke() ;
}

public void stroke(Vec4 c) {
  if(c.a > 0) stroke(c.r,c.g,c.b,c.a) ; else noStroke() ;
}



/**
text
*/
public void text(String s, Vec pos) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    text(s, p.x, p.y) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    text(s, p.x, p.x, p.z) ;
  }
}

public void text(char c, Vec pos) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    text(c, p.x, p.y) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    text(c, p.x, p.x, p.z) ;
  }
}

public void text(int num, Vec pos) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    text(num, p.x, p.y) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    text(num, p.x, p.x, p.z) ;
  }
}

public void text(float num, Vec pos) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    text(num, p.x, p.y) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    text(num, p.x, p.x, p.z) ;
  }
}

/**
image
*/
public void image(PImage img, Vec pos) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    image(img, p.x, p.y) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    start_matrix() ;
    translate(p) ;
    image(img, 0,0) ;
    stop_matrix() ;
  }
}

public void image(PImage img, Vec pos, Vec2 size) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    image(img, p.x, p.y, size.x, size.y) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    start_matrix() ;
    translate(p) ;
    image(img, 0,0, size.x, size.y) ;
    stop_matrix() ;
  }
}





/**
Translate
*/
public void translate(Vec3 t){
  if(renderer_P3D()) translate(t.x, t.y, t.z) ; else translate(t.x, t.y) ;
}

public void translate(Vec2 t){
  translate(t.x, t.y) ;
}

public void translateX(float t){
  translate(t, 0) ;
}

public void translateY(float t){
  translate(0, t) ;
}

public void translateZ(float t){
  translate(0, 0, t) ;
}


/**
Rotate
*/
public void rotateXY(Vec2 rot) {
  rotateX(rot.x) ;
  rotateY(rot.y) ;
}

public void rotateXZ(Vec2 rot) {
  rotateX(rot.x) ;
  rotateZ(rot.y) ;
}

public void rotateYZ(Vec2 rot) {
  rotateY(rot.x) ;
  rotateZ(rot.y) ;
}
public void rotateXYZ(Vec3 rot) {
  rotateX(rot.x) ;
  rotateY(rot.y) ;
  rotateZ(rot.z) ;
}

/**
Matrix

*/

public void start_matrix_3D(Vec pos, Vec3 dir_cart) {
  Vec3 dir = dir_cart.copy() ;
  pushMatrix() ;
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    translate(p) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    translate(p) ;
  } else {
    System.err.println("error in start_matrix_3D(), Vec pos is not an instance of Vec2 or Vec3, the matrix don't translate your object") ;
    exit() ;
  }
  float radius = sqrt(dir.x * dir.x + dir.y * dir.y + dir.z * dir.z);
  float longitude = acos(dir.x / sqrt(dir.x * dir.x + dir.y * dir.y)) * (dir.y < 0 ? -1 : 1);
  float latitude = acos(dir.z / radius) * (dir.z < 0 ? -1 : 1);
  // check NaN result
  if (Float.isNaN(longitude)) longitude = 0 ;
  if (Float.isNaN(latitude)) latitude = 0 ;
  if (Float.isNaN(radius)) radius = 0 ;
  rotateX(latitude) ;
  rotateY(longitude) ;
}

public void start_matrix_3D(Vec pos, Vec2 dir_polar) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    pushMatrix() ;
    translate(p) ;
    rotateXY(dir_polar) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    pushMatrix() ;
    translate(p) ;
    rotateXY(dir_polar) ;
  } else {
    System.err.println("error in start_matrix_3D(), Vec pos is not an instance of Vec2 or Vec3, the matrix cannot be init") ;
    exit() ;
  }
}

public void start_matrix_2D(Vec pos, float orientation) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    pushMatrix() ;
    translate(p) ;
    rotate(orientation) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    pushMatrix() ;
    translate(p.x, p.y) ;
    rotate(orientation) ;
  } else {
    System.err.println("Vec pos is not an instance of Vec2 or Vec3, the matrix cannot be init") ;
    exit() ;
  }
}

public void stop_matrix() {
  popMatrix() ;
}

public void start_matrix() {
  pushMatrix() ;
}


/**
Matrix 
deprecated
*/
public void matrix_3D_start(Vec3 pos, Vec3 dir_cart) {
  Vec3 dir = dir_cart.copy() ;
  pushMatrix() ;
  translate(pos) ;
  float radius = sqrt(dir.x * dir.x + dir.y * dir.y + dir.z * dir.z);
  float longitude = acos(dir.x / sqrt(dir.x * dir.x + dir.y * dir.y)) * (dir.y < 0 ? -1 : 1);
  float latitude = acos(dir.z / radius) * (dir.z < 0 ? -1 : 1);
  // check NaN result
  if (Float.isNaN(longitude)) longitude = 0 ;
  if (Float.isNaN(latitude)) latitude = 0 ;
  if (Float.isNaN(radius)) radius = 0 ;
  rotateX(latitude) ;
  rotateY(longitude) ;
  System.err.println("Deprecated method matrix_3D_start(Vec3 arg, Vec3 cartesian_dir) is deprecated instead use start_matrix_3D(Vec3 arg, Vec3 cartesian_dir)") ;
}

public void matrix_3D_start(Vec3 pos, Vec2 dir_polar) {
  pushMatrix() ;
  translate(pos) ;
  rotateXY(dir_polar) ;
  System.err.println("Deprecated method matrix_3D_start(Vec3 arg, Vec3 polar_dir) is deprecated instead use start_matrix_3D(Vec3 arg, Vec2 polar_dir)") ;
}

public void matrix_2D_start(Vec2 pos, float orientation) {
  pushMatrix() ;
  translate(pos) ;
  rotate(orientation) ;
  System.err.println("Deprecated method matrix_2D_start(Vec2 pos, float orientation) is deprecated instead use start_matrix_2D(Vec2 pos, float orientation)") ;
}

public void matrix_end() {
  popMatrix() ;
  System.err.println("Deprecated method matrix_end() is deprecated instead use stop_matrix()") ;
}

public void matrix_start() {
  pushMatrix() ;
  System.err.println("Deprecated method matrix_start() is deprecated instead use start_matrix()") ;
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Romanesco_30" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
