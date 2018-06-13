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

  build_console_setting();
  // 
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
  dropdown_content = new String[num_dropdown_bar][0];
}





void build_console_background() {
  for (int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_background[i].y *ratio_size_molette), round(size_slider_background[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_background[i].x, round(pos_slider_background[i].y -(slider_height_background *.6)));
    if(info_save_raw_list(info_slider_background,i).a > -1 ) {
      slider_adj_background[i] = new Sladj(temp_pos, size_slider_background[i]);
      slider_adj_background[i].set_molette(ELLIPSE);
      slider_adj_background[i].size_molette(temp_size_mol);
      slider_adj_background[i].set_id(i);
      slider_adj_background[i].set_label(slider_background_name[i],iadd(slider_adj_background[i].get_size(),iVec2(3,0)));
      slider_adj_background[i].set_font(textUsual_1);
      slider_adj_background[i].set_rounded(rounded_slider);
      slider_adj_background[i].set_fill_label(label_in_light,label_out_dark);
      slider_adj_background[i].set_fill(struc_light);
      slider_adj_background[i].set_fill_molette(molette_in_light,molette_out_light);
      slider_adj_background[i].set_fill_adj(adj_in_light,adj_out_light);
    }
  }
  // change color for the next slider after colour slider
  for(int i = 4 ; i < slider_adj_background.length ; i++) {
    slider_adj_background[i].set_fill(struc_dark);
    slider_adj_background[i].set_fill_molette(molette_in_dark,molette_out_dark);
    slider_adj_background[i].set_fill_adj(adj_in_dark,adj_out_dark);
  }

  button_bg = new Button(pos_button_background, size_button_background);
  button_bg.set_is(true);
  button_bg.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_bg.set_font(FuturaExtraBold_10);
  //button_bg.set_label(shader_bg_name[which_bg_shader] + " on/off");
}

void build_console_filter() {
  for (int i = 0 ; i < NUM_SLIDER_FILTER ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_filter[i].y *ratio_size_molette), round(size_slider_filter[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_filter[i].x, round(pos_slider_filter[i].y -(slider_height_filter *.6)));
    if(info_save_raw_list(info_slider_filter,i).a > -1) {
      slider_adj_filter[i] = new Sladj(temp_pos,size_slider_filter[i]);
      slider_adj_filter[i].set_molette(ELLIPSE);
      slider_adj_filter[i].size_molette(temp_size_mol);
      slider_adj_filter[i].set_id(i);
      slider_adj_filter[i].set_label(slider_filter_name[i],iadd(slider_adj_filter[i].get_size(),iVec2(3,0)));
      slider_adj_filter[i].set_font(textUsual_1);
      slider_adj_filter[i].set_rounded(rounded_slider);
      slider_adj_filter[i].set_fill_label(label_in_dark,label_out_dark);
      slider_adj_filter[i].set_fill(struc_dark);
      slider_adj_filter[i].set_fill_molette(molette_in_dark,molette_out_dark);
      slider_adj_filter[i].set_fill_adj(adj_in_dark,adj_out_dark);
    }
  }
}

void build_console_light() {
  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_light[i].y *ratio_size_molette), round(size_slider_light[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_light[i].x, round(pos_slider_light[i].y -(slider_height_light *.6)));
    if(info_save_raw_list(info_slider_light,i).a > -1 ) {
      slider_adj_light[i] = new Sladj(temp_pos, size_slider_light[i]);
      slider_adj_light[i].set_molette(ELLIPSE);
      slider_adj_light[i].size_molette(temp_size_mol);
      slider_adj_light[i].set_id(i);
      slider_adj_light[i].set_label(slider_light_name[i],iadd(slider_adj_light[i].get_size(),iVec2(3,0)));
      slider_adj_light[i].set_font(textUsual_1);
      slider_adj_light[i].set_rounded(rounded_slider);
      slider_adj_light[i].set_fill_label(label_in_dark,label_out_dark);
      slider_adj_light[i].set_fill(struc_dark);
      slider_adj_light[i].set_fill_molette(molette_in_dark,molette_out_dark);
      slider_adj_light[i].set_fill_adj(adj_in_dark,adj_out_dark);
    }
  }

  // LIGHT AMBIENT
  button_light_ambient = new Button(pos_light_ambient_buttonButton, size_light_ambient_buttonButton);
  button_light_ambient.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_ambient.set_font(FuturaExtraBold_10);
  

  button_light_ambient_action = new Button(pos_light_ambient_button_action, size_light_ambient_button_action);
  button_light_ambient_action.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_ambient_action.set_label("action");
  // LIGHT ONE
  button_light_1 = new Button(pos_light_1_button, size_light_1_button);
  button_light_1.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_1.set_font(FuturaExtraBold_10);
  // button_light_1.set_label("Light on/off");

  button_light_1_action = new Button(pos_light_1_button_action, size_light_1_button_action);
  button_light_1_action.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_1_action.set_font(FuturaExtraBold_10);
  button_light_1_action.set_label("action");
  // LIGHT TWO 
  button_light_2 = new Button(pos_light_2_button, size_light_2_button) ;
  button_light_2.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_2.set_font(FuturaExtraBold_10);
  // button_light_2.set_label("Light on/off");

  button_light_2_action = new Button(pos_light_2_button_action, size_light_2_button_action);
  button_light_2_action.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_2_action.set_font(FuturaExtraBold_10);
  button_light_2_action.set_label("action");
}


void build_console_sound() {
  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_sound[i].y *ratio_size_molette), round(size_slider_sound[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_sound[i].x, round(pos_slider_sound[i].y -(slider_height_sound *.6)));
    if(info_save_raw_list(info_slider_sound,i).a > -1 ) {
      slider_adj_sound[i] = new Sladj(temp_pos, size_slider_sound[i]);
      slider_adj_sound[i].set_molette(ELLIPSE);
      slider_adj_sound[i].size_molette(temp_size_mol);
      slider_adj_sound[i].set_id(i);
      slider_adj_sound[i].set_label(slider_sound_name[i],iadd(slider_adj_sound[i].get_size(),iVec2(3,0)));
      slider_adj_sound[i].set_font(textUsual_1);
      slider_adj_sound[i].set_rounded(rounded_slider);
      slider_adj_sound[i].set_fill_label(label_in_dark,label_out_dark);
      slider_adj_sound[i].set_fill(struc_dark);
      slider_adj_sound[i].set_fill_molette(molette_in_dark,molette_out_dark);
      slider_adj_sound[i].set_fill_adj(adj_in_dark,adj_out_dark);
    }
  }

  button_kick = new Button(pos_kick_button, size_kick_button);
  button_kick.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_kick.set_font(FuturaExtraBold_10);
  button_kick.set_label("KICK");

  button_snare = new Button(pos_snare_button, size_snare_button);
  button_snare.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_snare.set_font(FuturaExtraBold_10);
  button_snare.set_label("SNARE");

  button_hat = new Button(pos_hat_button, size_hat_button);
  button_hat.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_hat.set_font(FuturaExtraBold_10);
  button_hat.set_label("HAT");
}


void build_console_setting() {
  String [] content = {"camera setting","sound setting"};
  dropdown_setting = new Dropdown(dropdown_setting_pos,dropdown_setting_size,"Romanesco setting",content);
  dropdown_setting.set_colour(dropdown_colour);
  dropdown_setting.wheel(true);
  dropdown_setting.set_box_rank(2);
  dropdown_setting.set_header_text_pos(dropdown_pos_text);
  dropdown_setting.set_box_text_pos(dropdown_pos_text);
  dropdown_setting.set_box_height(height_box_dropdown);
  dropdown_setting.set_font(title_medium);
  dropdown_setting.set_box_font(textUsual_1);
  add_dropdown(dropdown_setting);
  build_console_camera();
  build_console_sound_setting();
}

void build_console_sound_setting() {
  for (int i = 0 ; i < NUM_SLIDER_SOUND_SETTING ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_sound_setting[i].y *ratio_size_molette), round(size_slider_sound_setting[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_sound_setting[i].x, round(pos_slider_sound_setting[i].y -(slider_height_sound_setting *.6)));
    if(info_save_raw_list(info_slider_sound_setting,i).a > -1 ) {
      slider_sound_setting[i] = new Slider(temp_pos, size_slider_sound_setting[i]);
      slider_sound_setting[i].set_molette(ELLIPSE);
      slider_sound_setting[i].size_molette(temp_size_mol);
      slider_sound_setting[i].set_id(i);
      slider_sound_setting[i].set_label(slider_sound_setting_name[i],iadd(slider_sound_setting[i].get_size(),iVec2(3,0)));
      slider_sound_setting[i].set_font(textUsual_1);
      slider_sound_setting[i].set_rounded(rounded_slider);
      slider_sound_setting[i].set_fill_label(label_in_dark,label_out_dark);
      slider_sound_setting[i].set_fill(struc_dark);
      slider_sound_setting[i].set_fill_molette(molette_in_dark,molette_out_dark);
    }
  }
}

void build_console_camera() {
  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {
    iVec2 temp_size_mol = iVec2(round(size_slider_camera[i].y *ratio_size_molette), round(size_slider_camera[i].y *ratio_size_molette));
    iVec2 temp_pos = iVec2(pos_slider_camera[i].x, round(pos_slider_camera[i].y -(slider_height_camera *.6)));
    if(info_save_raw_list(info_slider_camera,i).a > -1 ) {
      slider_adj_camera[i] = new Sladj(temp_pos, size_slider_camera[i]);
      slider_adj_camera[i].set_molette(ELLIPSE);
      slider_adj_camera[i].size_molette(temp_size_mol);
      slider_adj_camera[i].set_id(i);
      slider_adj_camera[i].set_label(slider_camera_name[i],iadd(slider_adj_camera[i].get_size(),iVec2(3,0)));
      slider_adj_camera[i].set_font(textUsual_1);
      slider_adj_camera[i].set_rounded(rounded_slider);
      slider_adj_camera[i].set_fill_label(label_in_dark,label_out_dark);
      slider_adj_camera[i].set_fill(struc_dark);
      slider_adj_camera[i].set_fill_molette(molette_in_dark,molette_out_dark);
      slider_adj_camera[i].set_fill_adj(adj_in_dark,adj_out_dark);
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
      slider_adj_item[i] = new Sladj(temp_pos, size_slider_item[i]);
      slider_adj_item[i].set_molette(ELLIPSE);
      slider_adj_item[i].size_molette(temp_size_mol);
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
      slider_adj_item[i].set_fill_label(label_in_dark,label_out_dark);
      slider_adj_item[i].set_fill_molette(molette_in_dark,molette_out_dark);
      slider_adj_item[i].set_fill_adj(adj_in_dark,adj_out_dark);
    }
  }
  // fill alpha
  slider_adj_item[hue_fill_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[sat_fill_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[bright_fill_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[alpha_fill_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // stroke alpha
  slider_adj_item[hue_stroke_rank].set_fill_adj(adj_in_dark,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[sat_stroke_rank].set_fill_adj(adj_in_dark,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[bright_stroke_rank].set_fill_adj(adj_in_dark,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[alpha_stroke_rank].set_fill_adj(adj_in_dark,adj_out_dark).set_fill(struc_dark);
  //  thickness
  slider_adj_item[thickness_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // size
  slider_adj_item[size_x_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[size_y_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[size_z_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  // Font size
  slider_adj_item[font_size_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // canvas
  slider_adj_item[canvas_x_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[canvas_y_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[canvas_z_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);

  // COL 2
  // reactivity
  slider_adj_item[reactivity_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // speed
  slider_adj_item[speed_x_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[speed_y_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[speed_z_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  // spurt
  slider_adj_item[spurt_x_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[spurt_y_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[spurt_z_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // direction
  slider_adj_item[dir_x_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[dir_y_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[dir_z_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  // jitter
  slider_adj_item[jitter_x_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[jitter_y_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[jitter_z_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // swing
  slider_adj_item[swing_x_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[swing_y_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[swing_z_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);

  // COL 3
  // quantity
  slider_adj_item[quantity_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // variety
  slider_adj_item[variety_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light); 
  // life
  slider_adj_item[life_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // fertility
  slider_adj_item[flow_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // quality
  slider_adj_item[quality_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  
  // area
  slider_adj_item[area_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  // angle
  slider_adj_item[angle_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  // scope
  slider_adj_item[scope_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  // scan
  slider_adj_item[scan_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark); 
  // alignment
  slider_adj_item[alignment_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // repulsion
  slider_adj_item[repulsion_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // attraction
  slider_adj_item[attraction_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // density
  slider_adj_item[density_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  
  // influence
  slider_adj_item[influence_rank].set_fill(struc_dark);
  // calm
  slider_adj_item[calm_rank].set_fill(struc_dark);
  // spectrum
  slider_adj_item[spectrum_rank].set_fill(struc_dark);
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

    dropdown_bar[i] = new Dropdown(dropdown_bar_pos[i],dropdown_bar_size[i],name_dropdown_bar[i],dropdown_content[i]);
    dropdown_bar[i].set_colour(dropdown_colour);
    dropdown_bar[i].set_header_text_pos(dropdown_pos_text);
    dropdown_bar[i].wheel(true);
    dropdown_bar[i].set_box_text_pos(dropdown_pos_text);
    dropdown_bar[i].set_box(num_box,2);
    dropdown_bar[i].set_box_height(height_box_dropdown);
    dropdown_bar[i].set_font(title_medium);
    dropdown_bar[i].set_box_font(textUsual_1);
  }
  add_dropdown(dropdown_bar);
}

void build_dropdown_item_selected() {
  //common param
  size_dropdown_item_mode = iVec2(20,15);
  int x = offset_y_item + -8;
  int y = height_item_selected +local_pos_y_dropdown_item_selected;
  // group item
  for (int i = 0 ; i <= NUM_ITEM ; i++ ) {
    if(mode_list_RPE[i] != null) {
      //Split the dropdown to display in the dropdown
      String [] item_mode_dropdown_list = split(mode_list_RPE[i], "/" ) ;
      //to change the title of the header dropdown
      pos_dropdown[i].set(x,y); 
      dropdown_item_mode[i] = new Dropdown(pos_dropdown[i], size_dropdown_item_mode,"M",item_mode_dropdown_list);
      dropdown_item_mode[i].set_colour(dropdown_color_item);
      dropdown_item_mode[i].set_header_text_pos(posTextDropdown);
      dropdown_item_mode[i].wheel(true);
      dropdown_item_mode[i].set_box_text_pos(posTextDropdown);
      dropdown_item_mode[i].set_box(7);
      dropdown_item_mode[i].set_box_height(height_box_dropdown);
      dropdown_item_mode[i].set_font(title_medium);
      dropdown_item_mode[i].set_box_font(textUsual_1);
    }
  }
  add_dropdown(dropdown_item_mode);
}




