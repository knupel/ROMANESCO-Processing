/**
Core controller
v 0.1.0
2018-2018
*/
import java.awt.event.KeyEvent;
import java.awt.image.*;
import java.awt.*;

boolean[] keyboard = new boolean[526];
boolean LOAD_SETTING = false ;
boolean INIT_INTERFACE = true ;

void setting_misc() {
  frameRate(60) ; 
  noStroke () ; 
  surface.setResizable(true);
}

void reset() {
  LOAD_SETTING = false;
  INIT_INTERFACE = false;
  reset_midi_selection = false;
}

void info_bg_shader() {
  int n = shaderBackgroundList.getRowCount();
  shader_bg_name = new String[n];
  shader_bg_author = new String[n];
  for (int i = 0 ; i < n ; i++) {
    TableRow row = shaderBackgroundList.getRow(i);
    shader_bg_name[i] = row.getString("Name");
    shader_bg_author[i] = row.getString("Author");
  }
}







/**
size window
*/
boolean change_size_window_is = false ;
void check_size_window() {
  if(size_window_ref.x != width || size_window_ref.y != height) {
    change_size_window(true);
    INIT_INTERFACE = true;
    size_window_ref.set(width,height);
  }
}

void change_size_window(boolean is) {
  change_size_window_is = is ;
}

boolean change_size_window_is() {
  return change_size_window_is;
}


/**
manage autosave
*/
void manage_autosave() {
  boolean state = false ;
  state = change_size_window_is();
  
  if(state) {
    autosave();
    load_autosave();
  }     
}






















/**
FONT
*/
PFont textUsual_1, textUsual_2, textUsual_3; 
PFont title_medium, title_big;  
PFont FuturaExtraBold_9, FuturaExtraBold_10;
PFont FuturaCondLight_10, FuturaCondLight_11,FuturaCondLight_12,FuturaStencil_20;
      
//SETUP
void set_font() {
  String path_font_gui = import_path+"font/default_font/" ;
  FuturaStencil_20 = loadFont(path_font_gui +"FuturaStencilICG-20.vlw");
  FuturaExtraBold_9 = loadFont(path_font_gui +"Futura-ExtraBold-9.vlw");
  FuturaExtraBold_10 = loadFont(path_font_gui +"Futura-ExtraBold-10.vlw");
  FuturaCondLight_10 = loadFont(path_font_gui +"Futura-CondensedLight-10.vlw");
  FuturaCondLight_11 = loadFont(path_font_gui +"Futura-CondensedLight-11.vlw");
  FuturaCondLight_12 = loadFont(path_font_gui +"Futura-CondensedLight-12.vlw");
  
  textUsual_1 = FuturaCondLight_10 ;
  textUsual_2 = FuturaCondLight_11 ;
  textUsual_3 = FuturaCondLight_12 ;

  title_medium = FuturaExtraBold_10 ;
  title_big = FuturaStencil_20 ;
}







/**
DETECTION CURSOR
*/
boolean locked (boolean inside) {
  if (inside && mousePressed) return true ; else return false ;
}





/**
CREDIT
*/
boolean insideNameversion ;
void credit() {
  if(mouseX > 2 && mouseX < 160 && mouseY > 3 && mouseY < 26 ) insideNameversion = true ; else insideNameversion = false ;
  if(insideNameversion && mousePressed) {
    String credit[] = loadStrings("credit.txt");
    
    fill(struc_colour_credit_background,225); 
    int startBloc = 24;
    rect(0, startBloc, width, height - startBloc -9 ) ; // //GROUP ZERO
    for (int i = 0 ; i < credit.length; i++) {
      textFont(textUsual_3);
      fill(struc_colour_credit_text) ;
      text(credit[i], 10,startBloc + 12 + ((i+1)*14));
    }
  }
}




















