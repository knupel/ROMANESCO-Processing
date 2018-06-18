/**
Main
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
button
*/
void init_button_general() {
  button_general_num = 20 ;
  value_button_general = new int[button_general_num];
}


void check_button() {
  check_button_general() ;
  check_button_item_console() ;
  check_button_inventory() ;
}

void mousepressed_button_general() {
    boolean dropdownActivity = dropdown_is();

    button_bg.update(mouseX,mouseY,dropdownActivity);
    //LIGHT ONE
    button_light_ambient.update(mouseX,mouseY,dropdownActivity);
    button_light_ambient_action.update(mouseX,mouseY,dropdownActivity);
    //LIGHT ONE
    button_light_1.update(mouseX,mouseY,dropdownActivity);
    button_light_1_action.update(mouseX,mouseY,dropdownActivity);
    // LIGHT TWO
    button_light_2.update(mouseX,mouseY,dropdownActivity);
    button_light_2_action.update(mouseX,mouseY,dropdownActivity);
    //son
    button_kick.update(mouseX,mouseY,dropdownActivity);
    button_snare.update(mouseX,mouseY,dropdownActivity);
    button_hat.update(mouseX,mouseY,dropdownActivity);
    //midi
    button_midi.update(mouseX,mouseY,dropdownActivity);
    //curtain
    button_curtain.update(mouseX,mouseY,dropdownActivity);
 // }
}






void check_button_general() {
  /* Check to send by OSC to Scene and Prescene */
  if(button_bg.is()) button_background_is = 1 ; else button_background_is = 0 ;
  //LIGHT ONE
  if(button_light_ambient.is())  light_ambient_button_is = 1 ; else  light_ambient_button_is = 0 ;
  if(button_light_ambient_action.is()) light_ambient_action_button_is = 1 ; else light_ambient_action_button_is =  0 ;
  //LIGHT ONE
  if(button_light_1.is()) light_light_1_button_is = 1 ; else light_light_1_button_is = 0 ;
  if(button_light_1_action.is()) light_light_action_1_button_is = 1 ; else light_light_action_1_button_is = 0 ;
  // LIGHT TWO
  if(button_light_2.is()) light_light_2_button_is = 1 ; else light_light_2_button_is = 0 ;
  if(button_light_2_action.is()) light_light_action_2_button_is = 1 ; else light_light_action_2_button_is = 0 ;
  //SOUND
  if(button_kick.is()) button_kick_is = 1 ; else button_kick_is = 0 ;
  if(button_snare.is()) button_snare_is = 1 ; else button_snare_is = 0 ;
  if(button_hat.is()) button_hat_is = 1 ; else button_hat_is = 0 ;
  //Check position of button
  if(button_midi.is()) button_midi_is = 1 ; else button_midi_is = 0 ;
  if(button_curtain.is()) button_curtain_is = 1 ; else button_curtain_is = 0 ;
}









/**
dropdown
*/

void update_dropdown(Dropdown... dd) {
  for(int i = 0 ; i < dd.length ; i++) {
    dd[i].update(mouseX,mouseY);
    dd[i].show_header_text();
    dd[i].show_box();
    dd[i].show_selection(dd[i].get_pos().x +3 , dd[i].get_pos().y +22);
  }
}

void update_dropdown_bar_content() {
  dropdown_content [0] = shader_bg_name;
  dropdown_content [1] = filter_dropdown_list;
  dropdown_content [2] = font_dropdown_list;
  dropdown_content [3] = file_text_dropdown_list;
  
  dropdown_content [4] = bitmap_dropdown_list;
  dropdown_content [5] = shape_dropdown_list;
  dropdown_content [6] = movie_dropdown_list;
}


void update_dropdown_item() {
  int pointer = 0 ;
  for (int i = 1 ; i <= NUM_ITEM ; i++) {
    if(mode_list_RPE[i] != null && inventory[i].is()) {
      int distance = pointer *DIST_BETWEEN_ITEM ;
      pointer++ ;

      dropdown_item_mode[i].offset(distance, 0) ;

      String m [] = split(mode_list_RPE[i], "/") ;
      if ( m.length > 1) {
        dropdown_item_mode[i].update(mouseX,mouseY);
        dropdown_item_mode[i].show_header_text();
        dropdown_item_mode[i].show_box();
      }
      // display which element is selected
      if (dropdown_item_mode[i].get_selection() > -1 && m.length > 1) {
        int x = dropdown_item_mode[i].get_pos().x +12;
        int y = dropdown_item_mode[i].get_pos().y +8;
        /*
        dropdown_item_mode[i].show_selection(x,y);
        */    
        textFont(dropdown_item_mode[i].get_font());      
        text(dropdown_item_mode[i].get_selection() +1,x,y);   
      }
    }
  }
}



























/**
FONT
*/
public PFont 
      ///controller Font
      textUsual_1, textUsual_2, textUsual_3,
      title_medium, title_big,  
      FuturaExtraBold_9, FuturaExtraBold_10,
      FuturaCondLight_10, FuturaCondLight_11,FuturaCondLight_12,
      FuturaStencil_20;
      
//SETUP
void set_font() {
  //controller Font
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




















