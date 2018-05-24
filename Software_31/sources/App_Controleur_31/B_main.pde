/**
Main
v 0.0.1
2018-2018
*/
import java.awt.event.KeyEvent;
import java.awt.image.*;
import java.awt.*;

boolean[] keyboard = new boolean[526];
boolean LOAD_SETTING = false ;
boolean INIT_INTERFACE = true ;

void setting() {
  colorSetup() ;  
  frameRate(60) ; 
  noStroke () ; 
  surface.setResizable(true);
  background(gris);
}

void reset() {
  init_slider_dynamic() ;
  INIT_INTERFACE = false ;
}

void info_bg_shader() {
  int n = shaderBackgroundList.getRowCount() ;
  shader_bg_name = new String[n] ;
  shader_bg_author = new String[n] ;
  for (int i = 0 ; i < n ; i++ ) {
     TableRow row = shaderBackgroundList.getRow(i) ;
     shader_bg_name[i] = row.getString("Name") ;
     shader_bg_author[i] = row.getString("Author") ;
  }
}



void check_interface() {
  if(size_window_ref.x != width || size_window_ref.y != height) {
    INIT_INTERFACE = true;
    size_window_ref.set(width,height);
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
  check_button_inventory_item() ;
}

void mousepressed_button_general() {
  if(!dropdownActivity) {
    button_bg.mousePressedText() ;
    //LIGHT ONE
    button_light_ambient.mousePressedText() ;
    button_light_ambient_action.mousePressedText() ;
    //LIGHT ONE
    button_light_1.mousePressedText() ;
    button_light_1_action.mousePressedText() ;
    // LIGHT TWO
    button_light_2.mousePressedText() ;
    button_light_2_action.mousePressedText() ;
    //son
    button_kick.mousePressedText() ;
    button_snare.mousePressedText() ;
    button_hat.mousePressedText() ;
    //midi
    button_midi.mousePressed() ;
    //curtain
    button_curtain.mousePressed() ;
  }
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
// Annexe method
int update_dropdown_bar(Dropdown dd) {
  int content_line = SWITCH_VALUE_FOR_DROPDOWN ;
  dd.update();
  
  if (dropdownOpen) dropdownActivityCount = +1 ;
  marge_around_dropdown = dd.get_size().y  ;
  //give the size of menu recalculate with the size of the word inside
  iVec2 new_size = dd.size_box.copy();
  //compare the standard size of dropdown with the number of element of the list.
  int height_dd_open = 0 ;
  if(dd.get_content().length < dd.get_num_box()) {
    height_dd_open = dd.get_content().length; 
  } else {
    height_dd_open = dd.get_num_box();
  }


  Vec2 temp_size = Vec2(new_size.x +(marge_around_dropdown *1.5), dd.get_size().y *height_dd_open +marge_around_dropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
  //new pos to include the slider
  Vec2 temp_pos = Vec2(dd.get_pos().x -marge_around_dropdown, dd.get_pos().y);
  if(!inside(temp_pos,temp_size,Vec2(mouseX,mouseY),RECT)) dd.locked = false;
  

  // display the selection
  if(!dd.locked && dd.get_content().length > 0) {
    fill(selected_dd_text) ;
    content_line = dd.get_content_line() ;
    textFont(dd.get_font_header());
    text(dd.get_content()[dd.get_content_line()], dd.get_pos().x +3 , dd.get_pos().y +22) ;
  }
  return content_line ;
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
      pointer ++ ;

      dropdown_item_mode[i].change_pos(distance, 0) ;

      String m [] = split(mode_list_RPE[i], "/") ;
      if ( m.length > 1) {
        dropdown_item_mode[i].update();
        if (dropdownOpen) dropdownActivityCount++ ;
        marge_around_dropdown = size_dropdown_item_mode.y  ;

        //give the size of menu recalculate with the size of the word inside
        iVec2 newSizeModeTypo = dropdown_item_mode[i].size_box.copy();
        int heightDropdown = 0 ;

        if(dropdown_item_mode[i].content.length <  dropdown_item_mode[i].get_num_box()) {
          heightDropdown = dropdown_item_mode[i].content.length ; 
        } else {
          heightDropdown = dropdown_item_mode[i].get_num_box();
        }

        Vec2 temp_size = Vec2(newSizeModeTypo.x +(marge_around_dropdown *1.5), size_dropdown_item_mode.y *(heightDropdown +1) +marge_around_dropdown) ; // we must add +1 to the size of the dropdown for the title plus the item list
        
        //new pos to include the slider
        Vec2 temp_pos = Vec2(dropdown_item_mode[i].get_pos().x -marge_around_dropdown, dropdown_item_mode[i].get_pos().y) ;
        if (!inside(temp_pos,temp_size,Vec2(mouseX,mouseY),RECT)) {
          dropdown_item_mode[i].locked = false;
        }
      }
      // display which element is selected
      if (dropdown_item_mode[i].get_content_line() > -1 && m.length > 1) {
        textFont(title_dropdown_medium);      
        text(dropdown_item_mode[i].get_content_line() +1, dropdown_item_mode[i].get_pos().x +12, dropdown_item_mode[i].get_pos().y +8) ;
      }
    }
  }
}


// DROPDOWN MOUSEPRESSED
void mousepressed_dropdown() {
  // dropdown bar
  for(int i = 0 ; i < dropdown_bar.length ; i++) {
    check_dropdown_mousepressed (dropdown_bar[i]);
  }
  // Item menu
  for(int i = 0 ; i < dropdown_item_mode.length ; i++) {
    check_dropdown_mousepressed(dropdown_item_mode[i]);
  } 
}

void check_dropdown_mousepressed(Dropdown dd) {
  if (dd != null) {
    if (inside(dd.get_pos(), dd.get_size(),iVec2(mouseX,mouseY),RECT) && !dd.locked) {
      dd.locked = true;
    } else if (dd.locked) {
      // println("locked",dd.get_name(),frameCount);
      float new_width = dd.size_box.x ;
      int line = dd.selectDropdownLine(new_width);
      if (line > -1 ) {
        dd.whichDropdownLine(line);
        dd.locked = false;        
      } 
    }
  }
}