/**
Build interface 
v 3.3.1
2014-2018
Romanesco Processing Environment
*/
void build_console() {
  build_console_general();
  build_console_bar();
  build_console_background();
  build_console_filter();
  build_console_light();
  build_console_sound();
  build_console_camera();
  build_console_item();  
}


void build_console_general() {
  //MIDI
  button_midi  = new Button(pos_midi_button, size_midi_button) ;
  //curtain
  button_curtain  = new Button(pos_curtain_button, size_curtain_button) ;
}

void build_console_bar() {
  // dropdown bar
  dropdown_bar = new Dropdown[num_dropdown_bar];
  dropdown_bar_pos = new iVec2[num_dropdown_bar];
  dropdown_bar_size = new iVec2[num_dropdown_bar];
  dropdown_bar_pos_text = new iVec2[num_dropdown_bar];
  dropdown_content = new String[num_dropdown_bar][0];
}





void build_console_background() {
  for (int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_background[i].y *ratio_size_molette), round(size_slider_background[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_background[i].x, round(pos_slider_background[i].y -(slider_height_background *.6)));
    if(info_save_raw_list(info_slider_background,i).a > -1 ) {
      slider_adj_background[i] = new Slider_adjustable(temp_pos, size_slider_background[i], temp_size_mol, "ELLIPSE");
      slider_adj_background[i].set_id(i);
    }
  }

  button_bg = new Button(pos_button_background, size_button_background) ;
  button_bg.set_on_off(true) ;
  button_bg.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
}

void build_console_filter() {
  for (int i = 0 ; i < NUM_SLIDER_FILTER ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_filter[i].y *ratio_size_molette), round(size_slider_filter[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_filter[i].x, round(pos_slider_filter[i].y -(slider_height_filter *.6)));
    if(info_save_raw_list(info_slider_filter,i).a > -1 ) {
      slider_adj_filter[i] = new Slider_adjustable(temp_pos, size_slider_filter[i], temp_size_mol, "ELLIPSE");
      slider_adj_filter[i].set_id(i);
    }
  }
}

void build_console_light() {
  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_light[i].y *ratio_size_molette), round(size_slider_light[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_light[i].x, round(pos_slider_light[i].y -(slider_height_light *.6)));
    if(info_save_raw_list(info_slider_light,i).a > -1 ) {
      slider_adj_light[i] = new Slider_adjustable(temp_pos, size_slider_light[i], temp_size_mol, "ELLIPSE");
      slider_adj_light[i].set_id(i);
    }
  }

  // LIGHT AMBIENT
  button_light_ambient = new Button(pos_light_ambient_buttonButton, size_light_ambient_buttonButton) ;
  button_light_ambient.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  button_light_ambient_action = new Button(pos_light_ambient_button_action, size_light_ambient_button_action) ;
  button_light_ambient_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  // LIGHT ONE
  button_light_1 = new Button(pos_light_1_button, size_light_1_button) ;
  button_light_1.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  button_light_1_action = new Button(pos_light_1_button_action, size_light_1_button_action) ;
  button_light_1_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  // LIGHT TWO 
  button_light_2 = new Button(pos_light_2_button, size_light_2_button) ;
  button_light_2.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
  button_light_2_action = new Button(pos_light_2_button_action, size_light_2_button_action) ;
  button_light_2_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
}

void build_console_sound() {
  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_sound[i].y *ratio_size_molette), round(size_slider_sound[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_sound[i].x, round(pos_slider_sound[i].y -(slider_height_sound *.6)));
    if(info_save_raw_list(info_slider_sound,i).a > -1 ) {
      slider_adj_sound[i] = new Slider_adjustable(temp_pos, size_slider_sound[i], temp_size_mol, "ELLIPSE");
      slider_adj_sound[i].set_id(i);
    }
  }

  button_beat = new Button(pos_beat_button, size_beat_button) ;
  button_beat.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_kick = new Button(pos_kick_button, size_kick_button) ;
  button_kick.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_snare = new Button(pos_snare_button, size_snare_button) ;
  button_snare.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;

  button_hat = new Button(pos_hat_button, size_hat_button) ;
  button_hat.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out) ;
}

void build_console_camera() {
  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_camera[i].y *ratio_size_molette), round(size_slider_camera[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_camera[i].x, round(pos_slider_camera[i].y -(slider_height_camera *.6)));
    if(info_save_raw_list(info_slider_camera,i).a > -1 ) {
      slider_adj_camera[i] = new Slider_adjustable(temp_pos, size_slider_camera[i], temp_size_mol, "ELLIPSE");
      slider_adj_camera[i].set_id(i);
    }
  }
}

void build_console_item() {
  // dropdown
  num_dropdown_item = NUM_ITEM +1; // add one for the dropdownmenu
  lastDropdown = num_dropdown_item -1;
  mode_list_RPE = new String[num_dropdown_item];
  dropdown_item_mode = new Dropdown[num_dropdown_item];
  pos_dropdown = new iVec2[num_dropdown_item];

  for(int i = 0 ; i < num_dropdown_item ; i++) {
    pos_dropdown[i] = iVec2();
  }
  // slider
  for (int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_item[i].y *ratio_size_molette), round(size_slider_item[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_item[i].x, round(pos_slider_item[i].y -(slider_height_item *.6)));
    if(info_save_raw_list(info_slider_item,i).a > -1 ) {
      slider_adj_item[i] = new Slider_adjustable(temp_pos, size_slider_item[i], temp_size_mol, "ELLIPSE");
      slider_adj_item[i].set_id(i);
    }
  }
}

















































/**
Build DROPDOWN 
v 1.1.0
*/
void build_dropdown_bar() {
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
    ROPE_color dropdown_color_bar = new ROPE_color(color_dd_background, color_dd_box_in, color_dd_box_out, color_dd_header_in, color_dd_header_out, color_dd_box_text);
    dropdown_bar[i] = new Dropdown(name_dropdown_bar[i],dropdown_content[i],dropdown_bar_pos[i],dropdown_bar_size[i],dropdown_bar_pos_text[i], dropdown_color_bar,num_box, height_box_dropdown);
    dropdown_bar[i].set_font_header(title_dropdown_medium);
    dropdown_bar[i].set_font_box(textUsual_1);
  }
}

void build_dropdown_item_selected() {
  //common param
  int num_box = 7;
  size_dropdown_item_mode = iVec2(20,15);
  int x = offset_y_item + -8;
  int y = height_item_selected +local_pos_y_dropdown_item_selected;

  ROPE_color dropdown_color_item = new ROPE_color(color_dd_background, color_dd_box_in, color_dd_box_out, color_dd_item_in, color_dd_item_out, color_dd_box_text);
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




