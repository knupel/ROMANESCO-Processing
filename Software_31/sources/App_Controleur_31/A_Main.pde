/**
Build interface 
v 3.3.1
2014-2018
Romanesco Processing Environment
*/
import java.awt.event.KeyEvent;
import java.awt.image.*;
import java.awt.*;
/**
SETTING
*/
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
SLIDER
v 2.0.0
*/
/**
setting
*/
void build_slider() {
  // background
  for (int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_background[i].y *ratio_size_molette), round(size_slider_background[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_background[i].x, round(pos_slider_background[i].y -(slider_height *.6)));
    if(info_save_raw_list(info_slider_background,i).a > -1 ) {
      slider_adj_background[i] = new Slider_adjustable(temp_pos, size_slider_background[i], temp_size_mol, "ELLIPSE");
      slider_adj_background[i].set_id(i);
    }
  }

  // filter
  for (int i = 0 ; i < NUM_SLIDER_FILTER ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_filter[i].y *ratio_size_molette), round(size_slider_filter[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_filter[i].x, round(pos_slider_filter[i].y -(slider_height *.6)));
    if(info_save_raw_list(info_slider_filter,i).a > -1 ) {
      slider_adj_filter[i] = new Slider_adjustable(temp_pos, size_slider_filter[i], temp_size_mol, "ELLIPSE");
      slider_adj_filter[i].set_id(i);
    }
  }

  // light
  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_light[i].y *ratio_size_molette), round(size_slider_light[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_light[i].x, round(pos_slider_light[i].y -(slider_height *.6)));
    if(info_save_raw_list(info_slider_light,i).a > -1 ) {
      slider_adj_light[i] = new Slider_adjustable(temp_pos, size_slider_light[i], temp_size_mol, "ELLIPSE");
      slider_adj_light[i].set_id(i);
    }
  }

  // sound
  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_sound[i].y *ratio_size_molette), round(size_slider_sound[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_sound[i].x, round(pos_slider_sound[i].y -(slider_height *.6)));
    if(info_save_raw_list(info_slider_sound,i).a > -1 ) {
      slider_adj_sound[i] = new Slider_adjustable(temp_pos, size_slider_sound[i], temp_size_mol, "ELLIPSE");
      slider_adj_sound[i].set_id(i);
    }
  }

  // camera
  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_camera[i].y *ratio_size_molette), round(size_slider_camera[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_camera[i].x, round(pos_slider_camera[i].y -(slider_height *.6)));
    if(info_save_raw_list(info_slider_camera,i).a > -1 ) {
      slider_adj_camera[i] = new Slider_adjustable(temp_pos, size_slider_camera[i], temp_size_mol, "ELLIPSE");
      slider_adj_camera[i].set_id(i);
    }
  }

  // item
  for (int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_item[i].y *ratio_size_molette), round(size_slider_item[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_item[i].x, round(pos_slider_item[i].y -(slider_height *.6)));
    if(info_save_raw_list(info_slider_item,i).a > -1 ) {
      slider_adj_item[i] = new Slider_adjustable(temp_pos, size_slider_item[i], temp_size_mol, "ELLIPSE");
      slider_adj_item[i].set_id(i);
    }
  }  
}


void set_slider() {
  set_slider_background(correction_slider_general_pos_y, iVec2(slider_width, slider_height));
  set_slider_filter(correction_slider_general_pos_y,iVec2(slider_width, slider_height));
  set_slider_light(correction_slider_general_pos_y,iVec2(slider_width, slider_height));
  set_slider_sound(correction_slider_general_pos_y,iVec2(slider_width, slider_height));
  set_slider_camera(correction_slider_general_pos_y,iVec2(slider_width, slider_height));
  set_slider_item_console(height_item_selected +local_pos_y_slider_button,iVec2(slider_width, slider_height));
}



void set_slider_background(int correction_local_y, iVec2 size) {
  for(int i = 0 ; i < NUM_SLIDER_BACKGROUND ;i++) {
    int pos_y = round(offset_background_y +correction_local_y +(i *spacing_slider));
    pos_slider_background[i] = iVec2(offset_background_x, pos_y);
    size_slider_background[i] = iVec2(size);
  }
}

void set_slider_filter(int correction_local_y, iVec2 size) {
  for(int i = 0 ; i < NUM_SLIDER_FILTER ;i++) {
    int pos_y = round(offset_filter_y +correction_local_y +(i *spacing_slider));
    pos_slider_filter[i] = iVec2(offset_filter_x, pos_y);
    size_slider_filter[i] = iVec2(size);
  }
}

void set_slider_light(int correction_local_y, iVec2 size) {
  int count = 0;
  int index = 0;
  for(int i = 0 ; i < NUM_SLIDER_LIGHT ;i++) {
    int pos_y = round(offset_light_y[index] +correction_local_y +(count *spacing_slider));
    pos_slider_light[i] = iVec2(offset_light_x[index], pos_y);
    size_slider_light[i] = iVec2(size);
    count++;
    if(count > 2) {
      index++;
      count = 0;
    }
  }
}

void set_slider_sound(int correction_local_y, iVec2 size) {
  for(int i = 0 ; i < NUM_SLIDER_SOUND ;i++) {
    int pos_y = round(offset_sound_y +correction_local_y +(i *spacing_slider));
    pos_slider_sound[i] = iVec2(offset_sound_x, pos_y);
    size_slider_sound[i] = iVec2(size);
  }
}


void set_slider_camera(int correction_local_y, iVec2 size) {
  for(int i = 0 ; i < NUM_SLIDER_CAMERA ;i++) {
    int pos_y = round(offset_camera_y +correction_local_y +(i *spacing_slider));
    pos_slider_camera[i] = iVec2(offset_camera_x, pos_y);
    size_slider_camera[i] = iVec2(size);
  }
}

void set_slider_item_console(int pos_y, iVec2 size) {
  // where the controller must display the slider
  for( int i = 0 ; i < NUM_SLIDER_ITEM_BY_COL ; i++) {
    for (int j = 0 ; j < NUM_COL_SLIDER ; j++) {
      int whichSlider = i +(j *NUM_SLIDER_ITEM_BY_COL) ;
      int pos_x = 0 ;
      switch(j) {
        case 0 : pos_x = item_a_col; 
        break;
        case 1 : pos_x = item_b_col;
        break;
        case 2 : pos_x = item_c_col;
        break;
      }
      pos_slider_item[whichSlider] = iVec2(pos_x, round(pos_y +i *spacing_slider));
      size_slider_item[whichSlider] = iVec2(size);
    }
  }
}























































/**
BUTTON
v 1.0.0
*/
/**
BUTTON BUILD
*/
Button  button_midi, button_curtain,
        button_bg, 
        button_light_ambient, button_light_ambient_action,
        button_light_1, button_light_1_action,
        button_light_2, button_light_2_action,
        button_beat, button_kick, button_snare, button_hat;


// init button
void init_button_general() {
  numButton = new int[NUM_GROUP_SLIDER] ;
  numButton[0] = 20 ;
  value_button_general = new int[numButton[0]] ;
}


// build button
void build_button_general() {
  //MIDI
  button_midi  = new Button(pos_midi_button, size_midi_button) ;
  //curtain
  button_curtain  = new Button(pos_curtain_button, size_curtain_button) ;
  // General
  button_bg = new Button(pos_bg_button, size_bg_button) ;
  button_bg.set_on_off(true) ;
  button_bg.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  // LIGHT AMBIENT
  button_light_ambient = new Button(posLightAmbientButton, sizeLightAmbientButton) ;
  button_light_ambient.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_light_ambient_action = new Button(posLightAmbientAction, sizeLightAmbientAction) ;
  button_light_ambient_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  // LIGHT ONE
  button_light_1 = new Button(posLightOneButton, sizeLightOneButton) ;
  button_light_1.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_light_1_action = new Button(posLightOneAction, sizeLightOneAction) ;
  button_light_1_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  // LIGHT TWO 
  button_light_2 = new Button(posLightTwoButton, sizeLightTwoButton) ;
  button_light_2.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  button_light_2_action = new Button(posLightTwoAction, sizeLightTwoAction) ;
  button_light_2_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  
  /**
  Sound
  */
  button_beat = new Button(pos_beat_button, size_beat_button) ;
  button_beat.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_kick = new Button(pos_kick_button, size_kick_button) ;
  button_kick.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_snare = new Button(pos_snare_button, size_snare_button) ;
  button_snare.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_hat = new Button(pos_hat_button, size_hat_button) ;
  button_hat.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
}













/**
Setting button
*/
void set_button_general() {
  // MIDI
  size_midi_button = Vec2(50,26);
  pos_midi_button = Vec2(grid_col[0] +correctionMidiX, pos_y_button_top +correctionMidiY);
  pos_midi_info =Vec2(pos_midi_button.x +correction_info_midi_x, pos_midi_button.y +correction_info_midi_y);
  // CURTAIN
  size_curtain_button = Vec2(30,30);
  pos_curtain_button = Vec2(grid_col[0] +correctionCurtainX, pos_y_button_top +correctionCurtainY); 
  
  
  // BACKGROUND
  pos_bg_button = Vec2(offset_background_x, offset_background_y +correction_button_txt_y);
  size_bg_button = Vec2(120,10);
  
  // LIGHT
  // ambient button
  posLightAmbientButton = Vec2(offset_light_x[0], offset_light_y[0] +correction_button_txt_y);
  sizeLightAmbientButton = Vec2(80,10);
  posLightAmbientAction = Vec2(offset_light_x[0] +90, posLightAmbientButton.y); // for the y we take the y of the button
  sizeLightAmbientAction = Vec2(45,10);
  // light one button
  posLightOneButton = Vec2(offset_light_x[1], offset_light_y[1] +correction_button_txt_y);
  sizeLightOneButton = Vec2(80,10);
  posLightOneAction = Vec2(offset_light_x[1] +90, posLightOneButton.y); // for the y we take the y of the button
  sizeLightOneAction = Vec2(45,10);
  // light two button
  posLightTwoButton = Vec2(offset_light_x[2], offset_light_y[2] +correction_button_txt_y);
  sizeLightTwoButton = Vec2(80,10);
  posLightTwoAction = Vec2(offset_light_x[2] +90, posLightTwoButton.y); // for the y we take the y of the button
  sizeLightTwoAction = Vec2(45,10);
  
  //SOUND BUTTON
  size_beat_button = Vec2(30,10); 
  size_kick_button = Vec2(30,10); 
  size_snare_button = Vec2(40,10); 
  size_hat_button = Vec2(30,10);
  
  pos_beat_button = Vec2(offset_sound_x, offset_sound_y +correction_button_txt_y); 
  pos_kick_button = Vec2(pos_beat_button.x +size_beat_button.x +5, offset_sound_y +correction_button_txt_y); 
  pos_snare_button = Vec2(pos_kick_button.x +size_kick_button.x +5, offset_sound_y +correction_button_txt_y); 
  pos_hat_button = Vec2(pos_snare_button.x +size_snare_button.x +5, offset_sound_y +correction_button_txt_y);
}






/**
Display Button
*/
/**
MAIN METHOD
*/

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
    button_beat.mousePressedText() ;
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
  if(button_bg.on_off) state_BackgroundButton = 1 ; else state_BackgroundButton = 0 ;
  //LIGHT ONE
  if(button_light_ambient.on_off)  state_LightAmbientButton = 1 ; else  state_LightAmbientButton = 0 ;
  if(button_light_ambient_action.on_off) state_LightAmbientAction = 1 ; else state_LightAmbientAction =  0 ;
  //LIGHT ONE
  if(button_light_1.on_off) state_LightOneButton = 1 ; else state_LightOneButton = 0 ;
  if(button_light_1_action.on_off) state_LightOneAction = 1 ; else state_LightOneAction = 0 ;
  // LIGHT TWO
  if(button_light_2.on_off) state_LightTwoButton = 1 ; else state_LightTwoButton = 0 ;
  if(button_light_2_action.on_off) state_LightTwoAction = 1 ; else state_LightTwoAction = 0 ;
  //SOUND
  if(button_beat.on_off) state_button_beat = 1 ; else state_button_beat = 0 ;
  if(button_kick.on_off) state_button_kick = 1 ; else state_button_kick = 0 ;
  if(button_snare.on_off) state_button_snare = 1 ; else state_button_snare = 0 ;
  if(button_hat.on_off) state_button_hat = 1 ; else state_button_hat = 0 ;
  //Check position of button
  if(button_midi.on_off) state_midi_button = 1 ; else state_midi_button = 0 ;
  if(button_curtain.on_off) state_curtain_button = 1 ; else state_curtain_button = 0 ;
}





























/**
DROPDOWN 
v 1.1.0
*/
// int ref_size_image_bitmap_dropdown, ref_size_image_svg_dropdown, ref_size_movie_dropdown, refSizeFileTextDropdown, refSizeCameraVideoDropdown ;
PVector pos_text_dropdown_image_bitmap, pos_text_dropdown_image_svg, pos_text_dropdown_movie, posTextdropdown_file_text, posTextdropdown_camera_video ; 
color selectedText;
color colorBoxIn, colorBoxOut, colorBoxText;
color colorDropdownBG;
color color_dropdown_header_in, color_dropdown_header_out;
color color_dropdown_item_in, color_dropdown_item_out;

void init_dropdown() {
  // dropdown bar
  dropdown_bar = new Dropdown[num_dropdown_bar];
  dropdown_bar_pos = new iVec2[num_dropdown_bar];
  dropdown_bar_size = new iVec2[num_dropdown_bar];
  dropdown_bar_pos_text = new iVec2[num_dropdown_bar];
  dropdown_content = new String[num_dropdown_bar][0];

  // dropdown item
  num_dropdown_item = NUM_ITEM +1; // add one for the dropdownmenu
  lastDropdown = num_dropdown_item -1;
  mode_list_RPE = new String[num_dropdown_item];
  dropdown_item_mode = new Dropdown[num_dropdown_item];
  pos_dropdown = new iVec2[num_dropdown_item];

  for(int i = 0 ; i < num_dropdown_item ; i++) {
    pos_dropdown[i] = iVec2();
  }
}




void set_dropdown_general() {
  colorDropdownBG = rougeTresFonce ;
  color_dropdown_header_in = jaune ;
  color_dropdown_header_out = orange ;
  color_dropdown_item_in = rouge ;
  color_dropdown_item_out = rougeTresFonce ;
  colorBoxIn = jaune ; 
  colorBoxOut = orange ;
  colorBoxText = rougeFonce ;
  selectedText = vertFonce ;

  //load the external list  for each mode and split to read in the interface
  for (int i = 0 ; i<inventory_item_table.getRowCount() ; i++) {
    TableRow row = inventory_item_table.getRow(i);
    mode_list_RPE [row.getInt("ID")] = row.getString("Mode"); 
  }
  //font
  String pList [] = loadStrings(import_path+"font/fontList.txt") ;
  String policeList = join(pList, "") ;
  font_dropdown_list = split(policeList, "/") ;
  
  //image
  update_media() ;
 
  for(int i = 0 ; i < dropdown_bar.length ; i++) {
    dropdown_bar_pos[i] = iVec2(pos_x_dropdown_bar[i],pos_y_dropdown_bar);
    dropdown_bar_size[i] = iVec2(width_dropdown_bar[i],height_dropdown_header_bar);
    int num_box = 7;
    dropdown_bar_pos_text[i] = iVec2(3,10);
    ROPE_color dropdown_color_bar = new ROPE_color(colorDropdownBG, colorBoxIn, colorBoxOut, color_dropdown_header_in, color_dropdown_header_out, colorBoxText);
    dropdown_bar[i] = new Dropdown(name_dropdown_bar[i],dropdown_content[i],dropdown_bar_pos[i],dropdown_bar_size[i],dropdown_bar_pos_text[i], dropdown_color_bar,num_box, height_box_dropdown);
    dropdown_bar[i].set_font_header(title_dropdown_medium);
    dropdown_bar[i].set_font_box(textUsual_1);
  }
}

void set_dropdown_item_selected() {
  //common param
  int num_box = 7;
  size_dropdown_item_mode = iVec2(20,15);
  int x = offset_y_item + -8;
  int y = height_item_selected +local_pos_y_dropdown_item_selected;

  ROPE_color dropdown_color_item = new ROPE_color(colorDropdownBG, colorBoxIn, colorBoxOut, color_dropdown_item_in, color_dropdown_item_out, colorBoxText);
  // group item
  for (int i = 0 ; i <= NUM_ITEM ; i++ ) {
    if(mode_list_RPE[i] != null) {
      //Split the dropdown to display in the dropdown
      String [] item_mode_dropdown_list = split(mode_list_RPE[i], "/" ) ;
      //to change the title of the header dropdown
      pos_dropdown[i].set(x,y); 
      dropdown_item_mode[i] = new Dropdown("M", 
                                  item_mode_dropdown_list, 
                                  pos_dropdown[i], 
                                  size_dropdown_item_mode, 
                                  posTextDropdown, 
                                  dropdown_color_item,
                                  num_box, 
                                  height_box_dropdown) ;
      dropdown_item_mode[i].set_font_header(title_dropdown_medium);
      dropdown_item_mode[i].set_font_box(textUsual_1);

    }
  }
}









// DRAW DROPDOWN
boolean dropdownActivity ;
int dropdownActivityCount ;
void display_dropdown() {
  update_dropdown_bar_content() ;
  
  // update_dropdown_background() ;
  for(int i = 0 ; i < dropdown_bar.length ; i++) {
    dropdown_bar[i].set_content(dropdown_content[i]);
    update_dropdown_bar(dropdown_bar[i]);
  }

  // item
  update_dropdown_item() ;
  
  which_bg_shader = dropdown_bar[0].get_content_line();
  which_filter = dropdown_bar[1].get_content_line();
  which_font = dropdown_bar[2].get_content_line();
  which_text = dropdown_bar[3].get_content_line();
  which_bitmap = dropdown_bar[4].get_content_line();
  which_shape = dropdown_bar[5].get_content_line();
  which_movie = dropdown_bar[6].get_content_line();

  // check the activity o the dropdown
  if(dropdownActivityCount > 0 ) {
    dropdownActivity = true; 
  } else {
    dropdownActivity = false;
  }
  dropdownActivityCount = 0;
}










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
    fill(selectedText) ;
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
    if(mode_list_RPE[i] != null && on_off_inventory_item[i].on_off) {
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

























/**
OTHER METHOD 
*/
//show info
void text_info_object(PVector pos, PVector size, int IDorder, int IDfamily) {
  if (mouseX > pos.x && mouseX < (size.x + pos.x ) && mouseY > pos.y - 10 && mouseY <  (size.y + pos.y) -20 ) {
    PVector fontPos = new PVector(-10, -20 ) ;
    
    if (NUM_ITEM > 0 ) {
      display_info_object(IDorder, fontPos) ;
    }
  }
}





void display_info_object(int IDorder, PVector pos) {
  int whichLine = 0 ;
  int num = inventory_item_table.getRowCount() ;
  for ( int j = 0 ; j < num ; j++) {
    TableRow lookFor = inventory_item_table.getRow(j);
    int ID = lookFor.getInt("ID") ;
    if ( ID == IDorder ) {
      whichLine = j ;
    }
  }
  TableRow displayInfo = inventory_item_table.getRow(whichLine) ;
  int num_line = 4 ;
  String [] text = new String[num_line] ;
  int [] size_text = new int[num_line] ;
  text[0] = displayInfo.getString("Name") ;
  text[1] = displayInfo.getString("Author") ;
  text[2] = displayInfo.getString("Version") ;
  text[3] = displayInfo.getString("Pack") ;
  size_text [0] = 20 ;
  size_text [1] = 15 ;
  size_text [2] = 10 ;
  size_text [3] = 10 ;

  // background window
  int pos_correction_y = -30 ;
  Vec2 pos_window = Vec2(pos.x +mouseX , pos.y + mouseY +pos_correction_y) ;
  Vec2 ratio_size = Vec2( 1.4, 1.3) ;
  int speed = 7 ;
  int size_angle = 2 ;
  fill(rougeFonce, 150) ;
  Vec2 range_check = Vec2(0,1) ;
  background_text_list(Vec2(pos_window.x +2, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check,FuturaStencil_20) ;


  // text
  fill(jaune) ;  
  textSize(size_text [0] ) ;
  textFont(FuturaStencil_20) ;
  text(text[0], pos_window.x, pos_window.y +5) ;
  textSize(size_text [1] ) ;
  text(text[1], pos_window.x, pos_window.y +20) ;
  textSize(size_text [2] ) ;
  text(text[2], pos_window.x, pos_window.y +30) ;
  text(text[3], pos_window.x, pos_window.y +40) ;
}







void background_text_list(Vec2 pos, String [] list, int [] size_text, int size_angle, int speed_rotation, Vec2 ratio_size, Vec2 start_end, PFont font) {
  // create the starting point of the shape
  pos = Vec2(pos.x -(size_text[0] *.5), pos.y -size_text[0]) ;

  // spacing
  float spacing = 0 ;
  for(int i = 0 ; i < size_text.length ; i++) {
    spacing += size_text[i] ;
  }
  spacing /= size_text.length ;
  spacing *= ratio_size.y;

  //define the size of the background
  int start_point_list = int(start_end.x) ;
  int end_point_list = int(start_end.y) ;
  
  int size_word = int(longest_String_pixel(font,list, size_text, start_point_list, end_point_list)) ;
  float width_rect =  size_word *ratio_size.x ;
  int height_rect = list.length *(int)spacing ;
  
  // create the point to build the background
  int diam = size_angle ;
  int speed = speed_rotation ;
  Vec2 a = Vec2(pos.x + 0,pos.y + 0).revolution(diam *3, speed/2) ;
  Vec2 b = Vec2(pos.x + width_rect, pos.y + 0).revolution(int(diam *1.5), speed) ;
  Vec2 c = Vec2(pos.x + width_rect, pos.y + height_rect).revolution(diam *2, int(speed *1.2)) ;
  Vec2 d = Vec2(pos.x + 0, pos.y + height_rect).revolution(diam, int(speed *.7)) ;
  
  // display background
  beginShape() ;
  vertex(a.x, a.y) ;
  vertex(b.x, b.y) ;
  vertex(c.x, c.y) ;
  vertex(d.x, d.y) ;
  endShape(CLOSE) ;
}







