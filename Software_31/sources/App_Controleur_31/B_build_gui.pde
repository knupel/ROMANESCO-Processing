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
  button_midi = new Button(pos_midi_button, size_midi_button) ;
  //curtain
  button_curtain = new Button(pos_curtain_button, size_curtain_button) ;
}

void build_console_bar() {
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
      slider_adj_background[i].set_label(slider_background_name[i],iadd(slider_adj_background[i].get_size(),iVec2(3,0)));
      slider_adj_background[i].set_font(textUsual_1);
      slider_adj_background[i].set_rounded(rounded_slider);
      slider_adj_background[i].set_colour_label(r.GRAY_3);
      slider_adj_background[i].set_fill(r.GRAY_4);
      slider_adj_background[i].set_molette_fill(r.GRAY_7,r.GRAY_5);
      slider_adj_background[i].set_adj_fill(r.GRAY_6,r.GRAY_1);
    }
  }

  button_bg = new Button(pos_button_background, size_button_background);
  button_bg.set_is(true);
  button_bg.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out);
  button_bg.set_font(FuturaExtraBold_10);
  button_bg.set_label(shader_bg_name[which_bg_shader] + " on/off");
}

void build_console_filter() {
  for (int i = 0 ; i < NUM_SLIDER_FILTER ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_filter[i].y *ratio_size_molette), round(size_slider_filter[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_filter[i].x, round(pos_slider_filter[i].y -(slider_height_filter *.6)));
    if(info_save_raw_list(info_slider_filter,i).a > -1 ) {
      slider_adj_filter[i] = new Slider_adjustable(temp_pos,size_slider_filter[i],temp_size_mol,"ELLIPSE");
      slider_adj_filter[i].set_id(i);
      slider_adj_filter[i].set_label(slider_filter_name[i],iadd(slider_adj_filter[i].get_size(),iVec2(3,0)));
      slider_adj_filter[i].set_font(textUsual_1);
      slider_adj_filter[i].set_colour_label(r.GRAY_3);
      slider_adj_filter[i].set_fill(r.GRAY_4);
      slider_adj_filter[i].set_molette_fill(r.GRAY_7,r.GRAY_5);
      slider_adj_filter[i].set_adj_fill(r.GRAY_6,r.GRAY_1);
    }
  }
}

void build_console_light() {
  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_light[i].y *ratio_size_molette), round(size_slider_light[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_light[i].x, round(pos_slider_light[i].y -(slider_height_light *.6)));
    if(info_save_raw_list(info_slider_light,i).a > -1 ) {
      slider_adj_light[i] = new Slider_adjustable(temp_pos, size_slider_light[i], temp_size_mol,"ELLIPSE");
      slider_adj_light[i].set_id(i);
      slider_adj_light[i].set_label(slider_light_name[i],iadd(slider_adj_light[i].get_size(),iVec2(3,0)));
      slider_adj_light[i].set_font(textUsual_1);
      slider_adj_light[i].set_colour_label(r.GRAY_3);
      slider_adj_light[i].set_fill(r.GRAY_4);
      slider_adj_light[i].set_molette_fill(r.GRAY_7,r.GRAY_5);
      slider_adj_light[i].set_adj_fill(r.GRAY_6,r.GRAY_1);
    }
  }

  // LIGHT AMBIENT
  button_light_ambient = new Button(pos_light_ambient_buttonButton, size_light_ambient_buttonButton);
  button_light_ambient.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out);
  button_light_ambient.set_font(FuturaExtraBold_10);
  button_light_ambient.set_label("Ambient on/off");

  button_light_ambient_action = new Button(pos_light_ambient_button_action, size_light_ambient_button_action);
  button_light_ambient_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out);
    button_light_ambient_action.set_label("action");
  // LIGHT ONE
  button_light_1 = new Button(pos_light_1_button, size_light_1_button);
  button_light_1.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out);
  button_light_1.set_font(FuturaExtraBold_10);
  button_light_1.set_label("Light on/off");

  button_light_1_action = new Button(pos_light_1_button_action, size_light_1_button_action);
  button_light_1_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out);
  button_light_1_action.set_font(FuturaExtraBold_10);
  button_light_1_action.set_label("action");
  // LIGHT TWO 
  button_light_2 = new Button(pos_light_2_button, size_light_2_button) ;
  button_light_2.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out);
  button_light_2.set_font(FuturaExtraBold_10);
  button_light_2.set_label("Light on/off");

  button_light_2_action = new Button(pos_light_2_button_action, size_light_2_button_action);
  button_light_2_action.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out);
  button_light_2_action.set_font(FuturaExtraBold_10);
  button_light_2_action.set_label("action");
}


void build_console_sound() {
  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_sound[i].y *ratio_size_molette), round(size_slider_sound[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_sound[i].x, round(pos_slider_sound[i].y -(slider_height_sound *.6)));
    if(info_save_raw_list(info_slider_sound,i).a > -1 ) {
      slider_adj_sound[i] = new Slider_adjustable(temp_pos, size_slider_sound[i], temp_size_mol, "ELLIPSE");
      slider_adj_sound[i].set_id(i);
      slider_adj_sound[i].set_label(slider_sound_name[i],iadd(slider_adj_sound[i].get_size(),iVec2(3,0)));
      slider_adj_sound[i].set_font(textUsual_1);
      slider_adj_sound[i].set_rounded(rounded_slider);
      slider_adj_sound[i].set_colour_label(r.GRAY_3);
      slider_adj_sound[i].set_fill(r.GRAY_4);
      slider_adj_sound[i].set_molette_fill(r.GRAY_7,r.GRAY_5);
      slider_adj_sound[i].set_adj_fill(r.GRAY_6,r.GRAY_1);
    }
  }

  button_kick = new Button(pos_kick_button, size_kick_button);
  button_kick.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out);
  button_kick.set_font(FuturaExtraBold_10);
  button_kick.set_label("KICK");

  button_snare = new Button(pos_snare_button, size_snare_button);
  button_snare.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out);
  button_snare.set_font(FuturaExtraBold_10);
  button_snare.set_label("SNARE");

  button_hat = new Button(pos_hat_button, size_hat_button);
  button_hat.set_color_on_off(col_on_in, col_on_out, col_off_in, col_off_out);
  button_hat.set_font(FuturaExtraBold_10);
  button_hat.set_label("HAT");
}




void build_console_camera() {
  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_camera[i].y *ratio_size_molette), round(size_slider_camera[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_camera[i].x, round(pos_slider_camera[i].y -(slider_height_camera *.6)));
    if(info_save_raw_list(info_slider_camera,i).a > -1 ) {
      slider_adj_camera[i] = new Slider_adjustable(temp_pos, size_slider_camera[i], temp_size_mol, "ELLIPSE");
      slider_adj_camera[i].set_id(i);
      slider_adj_camera[i].set_label(slider_camera_name[i],iadd(slider_adj_camera[i].get_size(),iVec2(3,0)));
      slider_adj_camera[i].set_font(textUsual_1);
      slider_adj_camera[i].set_rounded(rounded_slider);
      slider_adj_camera[i].set_colour_label(r.GRAY_3);
      slider_adj_camera[i].set_fill(r.GRAY_4);
      slider_adj_camera[i].set_molette_fill(r.GRAY_7,r.GRAY_5);
      slider_adj_camera[i].set_adj_fill(r.GRAY_6,r.GRAY_1);
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

      String label_name = slider_item_name[i];
      if(label_name.equals("f_hue")) label_name = "FILL";
      else if(label_name.equals("f_saturation")) label_name = "saturation";
      else if(label_name.equals("f_brightness")) label_name = "brightness";
      else if(label_name.equals("f_alpha")) label_name = "alpha";
      else if(label_name.equals("s_hue")) label_name = "STROKE";
      else if(label_name.equals("s_saturation")) label_name = "saturation";
      else if(label_name.equals("s_brightness")) label_name = "brightness";
      else if(label_name.equals("s_alpha")) label_name = "alpha";
      else if(label_name.equals("thickness")) label_name = "THICKNESS";
      slider_adj_item[i].set_label(label_name,iadd(slider_adj_item[i].get_size(),iVec2(3,0)));
      slider_adj_item[i].set_font(textUsual_1);
      slider_adj_item[i].set_rounded(rounded_slider);
      slider_adj_item[i].set_colour_label(r.GRAY_3);
      slider_adj_item[i].set_molette_fill(r.GRAY_7,r.GRAY_5);
      slider_adj_item[i].set_adj_fill(r.GRAY_6,r.GRAY_1);
    }
  }
  // fill alpha
  slider_adj_item[hue_fill_rank].set_fill(r.GRAY_4);
  slider_adj_item[sat_fill_rank].set_fill(r.GRAY_4);
  slider_adj_item[bright_fill_rank].set_fill(r.GRAY_4);
  slider_adj_item[alpha_fill_rank].set_fill(r.GRAY_4);
  // stroke alpha
  slider_adj_item[hue_stroke_rank].set_fill(r.GRAY_2);
  slider_adj_item[sat_stroke_rank].set_fill(r.GRAY_2);
  slider_adj_item[bright_stroke_rank].set_fill(r.GRAY_2);
  slider_adj_item[alpha_stroke_rank].set_fill(r.GRAY_2);
  //  thickness
  slider_adj_item[thickness_rank].set_fill(r.GRAY_4);
  // size
  slider_adj_item[size_x_rank].set_fill(r.GRAY_2);
  slider_adj_item[size_y_rank].set_fill(r.GRAY_2);
  slider_adj_item[size_z_rank].set_fill(r.GRAY_2);
  // Font size
  slider_adj_item[font_size_rank].set_fill(r.GRAY_4);
  // canvas
  slider_adj_item[canvas_x_rank].set_fill(r.GRAY_2);
  slider_adj_item[canvas_y_rank].set_fill(r.GRAY_2);
  slider_adj_item[canvas_z_rank].set_fill(r.GRAY_2);

  // COL 2
  // reactivity
  slider_adj_item[reactivity_rank].set_fill(r.GRAY_4);
  // speed
  slider_adj_item[speed_x_rank].set_fill(r.GRAY_2);
  slider_adj_item[speed_y_rank].set_fill(r.GRAY_2);
  slider_adj_item[speed_z_rank].set_fill(r.GRAY_2);
  // spurt
  slider_adj_item[spurt_x_rank].set_fill(r.GRAY_4);
  slider_adj_item[spurt_y_rank].set_fill(r.GRAY_4);
  slider_adj_item[spurt_z_rank].set_fill(r.GRAY_4);
  // direction
  slider_adj_item[dir_x_rank].set_fill(r.GRAY_2);
  slider_adj_item[dir_y_rank].set_fill(r.GRAY_2);
  slider_adj_item[dir_z_rank].set_fill(r.GRAY_2);
  // jitter
  slider_adj_item[jitter_x_rank].set_fill(r.GRAY_4);
  slider_adj_item[jitter_y_rank].set_fill(r.GRAY_4);
  slider_adj_item[jitter_z_rank].set_fill(r.GRAY_4);
  // swing
  slider_adj_item[swing_x_rank].set_fill(r.GRAY_2);
  slider_adj_item[swing_y_rank].set_fill(r.GRAY_2);
  slider_adj_item[swing_z_rank].set_fill(r.GRAY_2);

  // COL 3
  // quantity
  slider_adj_item[quantity_rank].set_fill(r.GRAY_4);
  // variety
  slider_adj_item[variety_rank].set_fill(r.GRAY_4); 
  // life
  slider_adj_item[life_rank].set_fill(r.GRAY_4);
  // fertility
  slider_adj_item[flow_rank].set_fill(r.GRAY_4);
  // quality
  slider_adj_item[quality_rank].set_fill(r.GRAY_4);
  
  // area
  slider_adj_item[area_rank].set_fill(r.GRAY_2);
  // angle
  slider_adj_item[angle_rank].set_fill(r.GRAY_2);
  // scope
  slider_adj_item[scope_rank].set_fill(r.GRAY_2);
  // scan
  slider_adj_item[scan_rank].set_fill(r.GRAY_2); 
  // alignment
  slider_adj_item[alignment_rank].set_fill(r.GRAY_4);
  // repulsion
  slider_adj_item[repulsion_rank].set_fill(r.GRAY_4);
  // attraction
  slider_adj_item[attraction_rank].set_fill(r.GRAY_4);
  // density
  slider_adj_item[density_rank].set_fill(r.GRAY_4);
  
  // influence
  slider_adj_item[influence_rank].set_fill(r.GRAY_2);
  // calm
  slider_adj_item[calm_rank].set_fill(r.GRAY_2);
  // spectrum
  slider_adj_item[spectrum_rank].set_fill(r.GRAY_2);
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
    dropdown_bar[i].set_font_header(title_medium);
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
      dropdown_item_mode[i].set_font_header(title_medium);
      dropdown_item_mode[i].set_font_box(textUsual_1);
    }
  }
}




