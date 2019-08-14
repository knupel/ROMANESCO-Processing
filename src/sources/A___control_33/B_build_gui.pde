/**
* Build interface 
* v 3.5.0
* 2014-2019
*
*/

/**
* CONTROL BAR
* v 0.0.2
* 2019-2019
*/
Crope_Bar controler_bar;
void build_bar() {
  controler_bar = new Crope_Bar(this);
  JSONObject menu = loadJSONObject(preference_path+"menu_bar_controller.json");
  controler_bar.set(menu);
  controler_bar.show();
}

void what_happen_in_menu(String what, ActionEvent ae) {
  println("here code your the behavior of", what);
  if(what.equals("midi map")) {
    select_midi_is = select_midi_is ? false:true;
  }

  if(what.equals("syphon")) {
    syphon_is = syphon_is ? false:true;
  }
}













void build_console() {
  build_console_general();
  build_console_media_bar();
  build_console_menu_bar();
  build_console_background();
  build_console_fx_filter();
  build_console_fx_mix();
  build_console_light();
  build_console_sound();
  build_console_setting();
  build_console_item();  
}


void build_console_general() {
  button_curtain = new Button(pos_curtain_button, size_curtain_button);
  button_reset_camera = new Button(pos_reset_camera_button, size_reset_camera_button);
  button_reset_item_on = new Button(pos_reset_item_on_button, size_reset_item_on_button);
  button_reset_fx = new Button(pos_reset_fx_button, size_reset_fx_button);
  button_birth = new Button(pos_birth_button, size_birth_button);
  button_3D = new Button(pos_3D_button, size_3D_button);
}

void build_console_media_bar() {
  dd_media_bar = new Dropdown[num_dd_media_bar];
  dd_media_bar_pos = new vec2[num_dd_media_bar];
  dd_media_bar_size = new vec2[num_dd_media_bar];
  dd_media_bar_content = new String[num_dd_media_bar][0];
}

void build_console_menu_bar() {
  dd_menu_bar = new Dropdown[num_dd_menu_bar];
  dd_menu_bar_pos = new vec2[num_dd_menu_bar];
  dd_menu_bar_size = new vec2[num_dd_menu_bar];
  dd_menu_bar_content = new String[num_dd_menu_bar][0];
}







void build_console_background() {
  for (int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    vec2 temp_size_mol = vec2(round(size_slider_background[i].y *ratio_size_molette), round(size_slider_background[i].y *ratio_size_molette));
    vec2 temp_pos = vec2(pos_slider_background[i].x, round(pos_slider_background[i].y -(slider_height_background *.6)));
    if(cropinfo_slider_fx_bg[i].get_id() != -1) {
      slider_adj_background[i] = new Sladj(temp_pos, size_slider_background[i]);
      slider_adj_background[i].set_molette(ELLIPSE);
      slider_adj_background[i].set_size_molette(temp_size_mol);
      slider_adj_background[i].set_id(i);
      slider_adj_background[i].set_label(slider_background_name[i],add(slider_adj_background[i].get_size(),vec2(3,0)));
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
    if((i > 3 && i < 6) || (i > 7 && i < 11)) {
      slider_adj_background[i].set_fill(struc_dark);
      slider_adj_background[i].set_fill_molette(molette_in_dark,molette_out_dark);
      slider_adj_background[i].set_fill_adj(adj_in_dark,adj_out_dark);
    }
  }

  button_bg = new Button(pos_button_background, size_button_background);
  button_bg.set_is(true);
  button_bg.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_bg.set_font(FuturaExtraBold_10);
}

void build_console_fx_filter() {
  for (int i = 0 ; i < NUM_SLIDER_FX_FILTER ; i++) {
    vec2 temp_size_mol = vec2(round(size_slider_fx_filter[i].y *ratio_size_molette), round(size_slider_fx_filter[i].y *ratio_size_molette));
    vec2 temp_pos = vec2(pos_slider_fx_filter[i].x, round(pos_slider_fx_filter[i].y -(slider_height_fx_filter *.6)));
    slider_adj_fx_filter[i] = new Sladj(temp_pos,size_slider_fx_filter[i]);
    slider_adj_fx_filter[i].set_molette(ELLIPSE);
    slider_adj_fx_filter[i].set_size_molette(temp_size_mol);
    slider_adj_fx_filter[i].set_id(i);
    slider_adj_fx_filter[i].set_label(slider_fx_filter_name[i],add(slider_adj_fx_filter[i].get_size(),vec2(3,0)));
    slider_adj_fx_filter[i].set_font(textUsual_1);
    slider_adj_fx_filter[i].set_rounded(rounded_slider);
    slider_adj_fx_filter[i].set_fill_label(label_in_light,label_out_dark);
    slider_adj_fx_filter[i].set_fill(struc_light);
    slider_adj_fx_filter[i].set_fill_molette(molette_in_light,molette_out_light);
    slider_adj_fx_filter[i].set_fill_adj(adj_in_light,adj_out_light);
  }

  // change color for the next slider after colour slider
  for(int i = 3 ; i < slider_adj_fx_filter.length ; i++) {
    if((i > 2 && i < 5) || (i > 6 && i < 9) || (i > 10 && i < 13)) {
      slider_adj_fx_filter[i].set_fill(struc_dark);
      slider_adj_fx_filter[i].set_fill_molette(molette_in_dark,molette_out_dark);
      slider_adj_fx_filter[i].set_fill_adj(adj_in_dark,adj_out_dark);
    }
  }

  for(int i = 0 ; i < NUM_BUTTON_FX_FILTER ; i++) {
    button_fx_filter[i] = new Button(pos_button_fx_filter[i], size_button_fx_filter[i]);
    button_fx_filter[i].set_aspect_on_off(button_on_in,button_on_out,button_off_in,button_off_out);
    button_fx_filter[i].set_font(FuturaExtraBold_10);
    if(i == 0) {
      //
    } else if (i == 1) {
      button_fx_filter[i].set_label("MOVE");
    } else if (i == 2) {
      button_fx_filter[i].set_label("EXTRA");
    }
  }
}



void build_console_fx_mix() {
  for (int i = 0 ; i < NUM_SLIDER_FX_MIX ; i++) {
    vec2 temp_size_mol = vec2(round(size_slider_fx_mix[i].y *ratio_size_molette), round(size_slider_fx_mix[i].y *ratio_size_molette));
    vec2 temp_pos = vec2(pos_slider_fx_mix[i].x, round(pos_slider_fx_mix[i].y -(slider_height_fx_mix *.6)));
    slider_adj_fx_mix[i] = new Sladj(temp_pos,size_slider_fx_mix[i]);
    slider_adj_fx_mix[i].set_molette(ELLIPSE);
    slider_adj_fx_mix[i].set_size_molette(temp_size_mol);
    slider_adj_fx_mix[i].set_id(i);
    slider_adj_fx_mix[i].set_label(slider_fx_mix_name[i],add(slider_adj_fx_mix[i].get_size(),vec2(3,0)));
    slider_adj_fx_mix[i].set_font(textUsual_1);
    slider_adj_fx_mix[i].set_rounded(rounded_slider);
    slider_adj_fx_mix[i].set_fill_label(label_in_light,label_out_dark);
    slider_adj_fx_mix[i].set_fill(struc_light);
    slider_adj_fx_mix[i].set_fill_molette(molette_in_light,molette_out_light);
    slider_adj_fx_mix[i].set_fill_adj(adj_in_light,adj_out_light);
  }

  // change color for the next slider after colour slider
  for(int i = 3 ; i < slider_adj_fx_mix.length ; i++) {
    slider_adj_fx_mix[i].set_fill(struc_dark);
    slider_adj_fx_mix[i].set_fill_molette(molette_in_dark,molette_out_dark);
    slider_adj_fx_mix[i].set_fill_adj(adj_in_dark,adj_out_dark);
  }

  for(int i = 0 ; i < NUM_BUTTON_FX_MIX ; i++) {
    button_fx_mix[i] = new Button(pos_button_fx_mix[i], size_button_fx_mix[i]);
    button_fx_mix[i].set_aspect_on_off(button_on_in,button_on_out,button_off_in,button_off_out);
    button_fx_mix[i].set_font(FuturaExtraBold_10);
  }
}



void build_console_light() {
  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    vec2 temp_size_mol = vec2(round(size_slider_light[i].y *ratio_size_molette), round(size_slider_light[i].y *ratio_size_molette));
    vec2 temp_pos = vec2(pos_slider_light[i].x, round(pos_slider_light[i].y -(slider_height_light *.6)));
    slider_adj_light[i] = new Sladj(temp_pos, size_slider_light[i]);
    slider_adj_light[i].set_molette(ELLIPSE);
    slider_adj_light[i].set_size_molette(temp_size_mol);
    slider_adj_light[i].set_id(i);
    slider_adj_light[i].set_label(slider_light_name[i],add(slider_adj_light[i].get_size(),vec2(3,0)));
    slider_adj_light[i].set_font(textUsual_1);
    slider_adj_light[i].set_rounded(rounded_slider);
    slider_adj_light[i].set_fill_label(label_in_dark,label_out_dark);
    slider_adj_light[i].set_fill(struc_dark);
    slider_adj_light[i].set_fill_molette(molette_in_dark,molette_out_dark);
    slider_adj_light[i].set_fill_adj(adj_in_dark,adj_out_dark);
  }

  // LIGHT AMBIENT
  button_light_ambient = new Button(pos_light_ambient_buttonButton, size_light_ambient_buttonButton);
  button_light_ambient.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_ambient.set_font(FuturaExtraBold_10);
  

  button_light_ambient_action = new Button(pos_light_ambient_button_action, size_light_ambient_button_action);
  button_light_ambient_action.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_ambient_action.set_label("MOVE");
  // LIGHT ONE
  button_light_1 = new Button(pos_light_1_button, size_light_1_button);
  button_light_1.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_1.set_font(FuturaExtraBold_10);

  button_light_1_action = new Button(pos_light_1_button_action, size_light_1_button_action);
  button_light_1_action.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_1_action.set_font(FuturaExtraBold_10);
  button_light_1_action.set_label("MOVE");
  // LIGHT TWO 
  button_light_2 = new Button(pos_light_2_button, size_light_2_button);
  button_light_2.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_2.set_font(FuturaExtraBold_10);

  button_light_2_action = new Button(pos_light_2_button_action, size_light_2_button_action);
  button_light_2_action.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_2_action.set_font(FuturaExtraBold_10);
  button_light_2_action.set_label("MOVE");
}


void build_console_sound() {
  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {
    vec2 temp_size_mol = vec2(round(size_slider_sound[i].y *ratio_size_molette), round(size_slider_sound[i].y *ratio_size_molette));
    vec2 temp_pos = vec2(pos_slider_sound[i].x, round(pos_slider_sound[i].y -(slider_height_sound *.6)));
    slider_adj_sound[i] = new Sladj(temp_pos, size_slider_sound[i]);
    slider_adj_sound[i].set_molette(ELLIPSE);
    slider_adj_sound[i].set_size_molette(temp_size_mol);
    slider_adj_sound[i].set_id(i);
    slider_adj_sound[i].set_label(slider_sound_name[i],add(slider_adj_sound[i].get_size(),vec2(3,0)));
    slider_adj_sound[i].set_font(textUsual_1);
    slider_adj_sound[i].set_rounded(rounded_slider);
    slider_adj_sound[i].set_fill_label(label_in_dark,label_out_dark);
    slider_adj_sound[i].set_fill(struc_dark);
    slider_adj_sound[i].set_fill_molette(molette_in_dark,molette_out_dark);
    slider_adj_sound[i].set_fill_adj(adj_in_dark,adj_out_dark);
  }

  for(int i = 0 ; i < NUM_BUTTON_TRANSIENT ; i++) {
    button_transient[i] = new Button(pos_button_transient[i], size_button_transient[i]);
    button_transient[i].set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
    button_transient[i].set_font(FuturaExtraBold_10);
    button_transient[i].set_label("BEAT "+i);
  }
}


void build_console_setting() {
  String [] content = {"SOUND","CAMERA"};
  dropdown_setting = new Dropdown(dropdown_setting_pos,dropdown_setting_size,"Romanesco setting",content);
  dropdown_setting.set_colour(dropdown_colour);
  dropdown_setting.wheel(true);
  dropdown_setting.set_box_rank(2);
  dropdown_setting.set_header_text_pos(dropdown_pos_text);
  dropdown_setting.set_box_text_pos(dropdown_pos_text);
  dropdown_setting.set_box_height(height_box_dropdown);
  dropdown_setting.set_font(title_medium);
  dropdown_setting.set_box_font(textUsual_1);
  build_console_camera();
  build_console_sound_setting();
}

void build_console_sound_setting() {
  // slider range transient
  vec2 size_mol = vec2(round(size_slider_sound_setting[0].y *ratio_size_molette), round(size_slider_sound_setting[0].y *ratio_size_molette));
  vec2 pos_slider = vec2(pos_slider_sound_setting[0].x, round(pos_slider_sound_setting[0].y -(slider_height_sound_setting *.6)));
  slider_sound_setting[0] = new Slider(pos_slider, size_slider_sound_setting[0]);
  slider_sound_setting[0].set_id(0);
  slider_sound_setting[0].set_molette_num(3);
  slider_sound_setting[0].set_size_molette(size_mol.x/2,size_mol.y);
  slider_sound_setting[0].set_label(slider_sound_setting_name[0],add(slider_sound_setting[0].get_size(),vec2(3,0)));
  slider_sound_setting[0].set_font(textUsual_1);
  slider_sound_setting[0].set_rounded(rounded_slider);
  slider_sound_setting[0].set_fill_label(label_in_light,label_out_light);
  slider_sound_setting[0].set_fill(struc_light);
  slider_sound_setting[0].set_fill_molette(molette_in_dark,molette_out_light);
  // slider transient threshold
  int in_slider_double = 1;
  int out_slider_double = 5;
  for (int i = in_slider_double ; i < out_slider_double ; i++) {
    vec2 temp_size_mol = vec2(round(size_slider_sound_setting[i].y *ratio_size_molette), round(size_slider_sound_setting[i].y *ratio_size_molette));
    vec2 temp_pos = vec2(pos_slider_sound_setting[i].x, round(pos_slider_sound_setting[i].y -(slider_height_sound_setting *.6)));
    if(cropinfo_slider_sound_setting[i].get_id() > -1) {
      slider_sound_setting[i] = new Slider(temp_pos, size_slider_sound_setting[i]);
      slider_sound_setting[i].set_id(i);
      slider_sound_setting[i].set_molette_num(2);
      slider_sound_setting[i].set_size_molette(size_mol.x/2,size_mol.y);
      slider_sound_setting[i].set_label(slider_sound_setting_name[i],add(slider_sound_setting[i].get_size(),vec2(3,0)));
      slider_sound_setting[i].set_font(textUsual_1);
      slider_sound_setting[i].set_rounded(rounded_slider);
      slider_sound_setting[i].set_fill_label(label_in_dark,label_out_dark);
      slider_sound_setting[i].set_fill(struc_dark);
      slider_sound_setting[i].set_fill_molette(molette_in_dark,molette_out_dark);
    }
  }
  
  int in_slider_single = out_slider_double;
  int out_slider_single = NUM_SLIDER_SOUND_SETTING;
  for (int i =  in_slider_single ; i < out_slider_single ; i++) {
    vec2 temp_size_mol = vec2(round(size_slider_sound_setting[i].y *ratio_size_molette), round(size_slider_sound_setting[i].y *ratio_size_molette));
    vec2 temp_pos = vec2(pos_slider_sound_setting[i].x, round(pos_slider_sound_setting[i].y -(slider_height_sound_setting *.6)));
    slider_sound_setting[i] = new Slider(temp_pos, size_slider_sound_setting[i]);
    slider_sound_setting[i].set_molette(ELLIPSE);
    slider_sound_setting[i].set_size_molette(temp_size_mol);
    slider_sound_setting[i].set_id(i);
    slider_sound_setting[i].set_label(slider_sound_setting_name[i],add(slider_sound_setting[i].get_size(),vec2(3,0)));
    slider_sound_setting[i].set_font(textUsual_1);
    slider_sound_setting[i].set_rounded(rounded_slider);
    slider_sound_setting[i].set_fill_label(label_in_dark,label_out_dark);
    slider_sound_setting[i].set_fill(struc_dark);
    slider_sound_setting[i].set_fill_molette(molette_in_dark,molette_out_dark);
  }
}

void build_console_camera() {
  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {
    vec2 temp_size_mol = vec2(round(size_slider_camera[i].y *ratio_size_molette), round(size_slider_camera[i].y *ratio_size_molette));
    vec2 temp_pos = vec2(pos_slider_camera[i].x, round(pos_slider_camera[i].y -(slider_height_camera *.6)));
    slider_adj_camera[i] = new Sladj(temp_pos, size_slider_camera[i]);
    slider_adj_camera[i].set_molette(ELLIPSE);
    slider_adj_camera[i].set_size_molette(temp_size_mol);
    slider_adj_camera[i].set_id(i);
    slider_adj_camera[i].set_label(slider_camera_name[i],add(slider_adj_camera[i].get_size(),vec2(3,0)));
    slider_adj_camera[i].set_font(textUsual_1);
    slider_adj_camera[i].set_rounded(rounded_slider);
    slider_adj_camera[i].set_fill_label(label_in_dark,label_out_dark);
    slider_adj_camera[i].set_fill(struc_dark);
    slider_adj_camera[i].set_fill_molette(molette_in_dark,molette_out_dark);
    slider_adj_camera[i].set_fill_adj(adj_in_dark,adj_out_dark);
  }
}

void build_console_item() {
  // dropdown
  num_dd_item = NUM_ITEM +1; // add one for the dropdownmenu, because the item `0` is not used
  list_item_costume = new String[num_dd_item];
  dd_item_costume = new Dropdown[num_dd_item];

  list_item_mode = new String[num_dd_item];
  dd_item_mode = new Dropdown[num_dd_item];

  // slider
  for (int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    vec2 temp_size_mol = vec2(round(size_slider_item[i].y *ratio_size_molette), round(size_slider_item[i].y *ratio_size_molette));
    vec2 temp_pos = vec2(pos_slider_item[i].x, round(pos_slider_item[i].y -(slider_height_item *.6)));
    println("method build_console_item(): cropinfo length",cropinfo_slider_item.length,i);
    if(cropinfo_slider_item[i].get_id() > -1) {
      slider_adj_item[i] = new Sladj(temp_pos, size_slider_item[i]);
      slider_adj_item[i].set_molette(ELLIPSE);
      slider_adj_item[i].set_size_molette(temp_size_mol);
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
      slider_adj_item[i].set_label(label_name,add(slider_adj_item[i].get_size(),vec2(3,0)));
      slider_adj_item[i].set_font(textUsual_1);
      slider_adj_item[i].set_rounded(rounded_slider);
      slider_adj_item[i].set_fill_label(label_in_dark,label_out_dark);
      slider_adj_item[i].set_fill_molette(molette_in_dark,molette_out_dark);
      slider_adj_item[i].set_fill_adj(adj_in_dark,adj_out_dark);
    }
  }
  // COL A
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
  // diam
  slider_adj_item[diameter_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // canvas
  slider_adj_item[canvas_x_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[canvas_y_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[canvas_z_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);

  // COL B
  // reactivity
  slider_adj_item[frequence_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
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

  // COL C
  slider_adj_item[quantity_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);

  slider_adj_item[variety_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light); 
  slider_adj_item[life_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[flow_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[quality_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  
  slider_adj_item[area_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[angle_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[scope_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[scan_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark); 
  slider_adj_item[alignment_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);

  slider_adj_item[repulsion_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[attraction_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[density_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  
  slider_adj_item[influence_rank].set_fill(struc_dark);
  slider_adj_item[calm_rank].set_fill(struc_dark);
  slider_adj_item[spectrum_rank].set_fill(struc_dark);

  // COL D
  slider_adj_item[grid_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);

  slider_adj_item[viscosity_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark); 
  slider_adj_item[diffusion_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
}

















































/**
* Build DROPDOWN 
* v 1.3.1
* 2016-2019
*/
void build_dropdown_bar() {
  String[] path_list = alphabetical_font_path(font_path);
  font_dropdown_list = new String[path_list.length];;
  int target = 0;
  for(int i = 0 ; i < path_list.length ; i++) {
    if(extension_font(path_list[i])) {
      ROFont font = new ROFont(path_list[i],10);
      font_dropdown_list[target] = font.get_name();
      target++;
    } 
  }

  build_dd_menu_bar();
 
  update_media();
  build_dd_media_bar();
}


void build_dd_menu_bar() {
  for(int i = 0 ; i < dd_menu_bar.length ; i++) {
    dd_menu_bar_pos[i] = vec2(pos_x_dd_menu_bar[i],pos_y_dd_menu_bar);
    dd_menu_bar_size[i] = vec2(width_dd_menu_bar[i],height_dropdown_header_bar);

    dd_menu_bar[i] = new Dropdown(dd_menu_bar_pos[i],dd_menu_bar_size[i],name_dd_menu_bar[i],dd_menu_bar_content[i]);
    dd_menu_bar[i].set_colour(dropdown_colour);
    dd_menu_bar[i].set_header_text_pos(dropdown_pos_text);
    dd_menu_bar[i].wheel(true);
    dd_menu_bar[i].set_box_text_pos(dropdown_pos_text);
    dd_menu_bar[i].set_box(num_box_dropdown_general,2);
    dd_menu_bar[i].set_box_height(height_box_dropdown);
    dd_menu_bar[i].set_font(title_medium);
    dd_menu_bar[i].set_box_font(textUsual_1);
  }
}

void build_dd_media_bar() {
  for(int i = 0 ; i < dd_media_bar.length ; i++) {
    dd_media_bar_pos[i] = vec2(pos_x_dd_media_bar[i],pos_y_dd_media_bar);
    dd_media_bar_size[i] = vec2(width_dd_media_bar[i],height_dropdown_header_bar);

    dd_media_bar[i] = new Dropdown(dd_media_bar_pos[i],dd_media_bar_size[i],name_dd_media_bar[i],dd_media_bar_content[i]);
    dd_media_bar[i].set_colour(dropdown_colour);
    dd_media_bar[i].set_header_text_pos(dropdown_pos_text);
    dd_media_bar[i].wheel(true);
    dd_media_bar[i].set_box_text_pos(dropdown_pos_text);
    dd_media_bar[i].set_box(num_box_dropdown_general,2);
    dd_media_bar[i].set_box_height(height_box_dropdown);
    dd_media_bar[i].set_font(title_medium);
    dd_media_bar[i].set_box_font(textUsual_1);
  }
}

void build_dropdown_item_selected() {
  build_local_dd_item(dd_item_costume,inventory_item_table, list_item_costume, "C","Costume", 0);
  build_local_dd_item(dd_item_mode,inventory_item_table, list_item_mode, "M","Mode", 15);
}

void build_local_dd_item(Dropdown [] dd, Table inventory_table, String [] list_global, String title, String type, int offset_y) {
  //load the external list  for each mode and costume and split to read in the interface
  for (int i = 0 ; i<inventory_table.getRowCount() ; i++) {
    TableRow row = inventory_table.getRow(i);
    list_global[row.getInt("ID")] = row.getString(type); 
  }
  //common param
  vec2 size_header = vec2(30,15);
  vec2 pos_text = vec2(8,8);
  int x = offset_x_item;
  int y = height_item_selected +local_pos_y_dropdown_item + offset_y;
  // group item
  for (int i = 0 ; i <= NUM_ITEM ; i++ ) {
    if(list_global[i] != null) {
      //Split the dropdown to display in the dropdown
      String [] list_detail = split(list_global[i],"/");
      //to change the title of the header dropdown
      dd[i] = new Dropdown(vec2(x,y), size_header,title,list_detail);
      dd[i].set_colour(dropdown_color_item);
      dd[i].set_header_text_pos(pos_text);
      dd[i].wheel(true);
      dd[i].set_box_text_pos(pos_text);
      dd[i].set_box(num_box_dropdown_item);
      dd[i].set_box_height(height_box_dropdown);
      dd[i].set_font(title_medium);
      dd[i].set_box_font(textUsual_1);
    }
  }
}





