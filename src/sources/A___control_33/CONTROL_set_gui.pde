/**
* Variable controller
* 2014-2019
* v 0.6.0
*/




void set_design() {
  set_design_structure();
  set_design_aspect();
}


/**
set structure
*/
void set_design_structure() {
  num_box_dropdown_item = 15;
  num_box_dropdown_general = 30;

  height_box_dropdown = 15;
  dropdown_pos_text = vec2(3,10);
  ratio_size_molette = 1.3;
  // vertical grid
  marge = 10;

  int width_inside = window_ref.x() -(2*marge);
  grid_col = new int[15];
  col_width = width_inside/grid_col.length;
  grid_col[0] = marge;
  for(int i = 1 ; i < grid_col.length ; i++) {
    grid_col[i] = col_width +grid_col[i-1];
  }

  size_title_button = 10;

  spacing_slider = 11;
  rounded_slider = 4;

  height_header = 23;
  height_button_top = 44 ;
  pos_y_button_top = height_header;

  height_dropdown_top = 32;
  pos_y_dropdown_top = height_header +height_button_top;

  height_menu_general = 193;
  pos_y_menu_general = height_header +height_button_top +height_dropdown_top;
  pos_y_menu_general_content = pos_y_menu_general +5;
  
  set_design_structure_background(1);
  set_design_structure_light(1);
  set_design_structure_fx_filter(1);
  set_design_structure_fx_mix(1);
  set_design_structure_sound(1);
  set_design_structure_setting(4);

  DIST_BETWEEN_ITEM = 40;
  set_design_structure_item_selected();

  set_design_structure_inventory();
}



// general
void set_design_structure_background(int rank) {
  slider_width_background = 100;
  slider_height_background = 8;
  offset_background_x = grid_col[0];
  offset_background_y = pos_y_menu_general_content +(rank *spacing_slider);
}


void set_design_structure_setting(int rank) {
  int px = grid_col[12];
  int py = pos_y_menu_general_content +(rank *spacing_slider);
  dropdown_setting_pos = vec2(px,py);
  int sx = 100;
  int sy = height_box_dropdown ;
  dropdown_setting_size = vec2(sx,sy);
  set_design_structure_camera(rank+3);
  set_design_structure_sound_setting(rank+3);
}


void set_design_structure_camera(int rank) {
  slider_width_camera = 100;
  slider_height_camera = 8;
  offset_camera_x = grid_col[12];
  offset_camera_y = pos_y_menu_general_content +(rank *spacing_slider);
}


void set_design_structure_sound_setting(int rank) {
  slider_width_sound_setting = 100;
  slider_height_sound_setting = 8;
  offset_sound_setting_x = grid_col[12];
  offset_sound_setting_y = pos_y_menu_general_content +(rank *spacing_slider);
}


void set_design_structure_fx_filter(int rank) {
  slider_width_fx_filter = 100;
  slider_height_fx_filter = 8;
  offset_fx_filter_x = grid_col[3];
  offset_fx_filter_y = pos_y_menu_general_content +(rank *spacing_slider);
}

void set_design_structure_fx_mix(int rank) {
  slider_width_fx_mix = 100;
  slider_height_fx_mix = 8;
  offset_fx_mix_x = grid_col[6];
  offset_fx_mix_y = pos_y_menu_general_content +(rank *spacing_slider);
}


void set_design_structure_light(int rank) {
  slider_width_light = 100;
  slider_height_light = 8;
  offset_light_x = grid_col[9];
  offset_light_y = pos_y_menu_general_content +(rank *spacing_slider);
}

void set_design_structure_sound(int rank) {
  slider_width_sound = 100;
  slider_height_sound = 8;
  offset_sound_x = grid_col[12];
  offset_sound_y = pos_y_menu_general_content +(rank *spacing_slider);
}

// item
void set_design_structure_item_selected() {
  slider_width_item = 100;
  slider_height_item = 8;
  // item gui pos
  offset_x_item = grid_col[0];
  item_a_col = grid_col[0];
  item_b_col = grid_col[3];
  item_c_col = grid_col[6];
  item_d_col = grid_col[9];
  // item selected
  local_pos_y_button_item = 20;
  local_pos_y_dropdown_item = local_pos_y_button_item +72;
  local_pos_y_slider_item = local_pos_y_dropdown_item +34;

  height_item_button_console = 85;
  pos_y_item_selected = height_header +height_button_top +height_dropdown_top +height_menu_general;
  height_item_selected = spacing_slider *NUM_SLIDER_ITEM_BY_COL +height_item_button_console;
}

void set_design_structure_inventory() {
  pos_y_inventory = height_header +height_button_top +height_dropdown_top +height_menu_general +height_item_selected;
  // this value depend of the size of the window, indeed we must calculate this one later.
  height_inventory = 100;
}






/**
aspect
*/
void set_design_aspect() {
  set_colour_structure_background_header(r.BLOOD);
  // set_colour_structure_background_mass(r.GRAY_1,r.BLOOD);
  set_colour_structure_background_line(r.ORANGE,r.BLOOD);

  fill_text_title_in = r.YELLOW;
  fill_text_title_out = r.ORANGE;

  fill_info_window_rect = r.CARMIN;
  fill_info_window_text = r.YELLOW;

  fill_midi_no_selection = r.CARMIN;
  fill_midi_selection = r.GRAY[4];

  fill_midi_window_no_selection = r.WHITE;
  fill_midi_window_selection = r.WHITE;

  struc_colour_credit_background = r.GRAY[4];
  struc_colour_credit_text = r.WHITE;
  
  // colour window info
  text_colour_window_info = r.WHITE;
  struc_colour_window_info = r.GRAY[4];



  // colour button
  button_on_in = r.GREEN;
  button_on_out = r.BOUTEILLE;

  button_off_in = r.RED;
  button_off_out = r.CARMIN;

  // dropdown
  color_dd_background = r.BLOOD;
  color_dd_header_in = r.YELLOW;
  color_dd_header_out = r.ORANGE;

  color_dd_header_text_in = r.RED;
  color_dd_header_text_out = r.CARMIN;

  color_dd_item_in = r.RED;
  color_dd_item_out = r.CARMIN;

  color_dd_item_text_in = r.BLOOD;
  color_dd_item_text_out = r.BLOOD;

  color_dd_box_in = r.YELLOW; 
  color_dd_box_out = r.ORANGE;

  color_dd_box_text_in = r.BLOOD;
  color_dd_box_text_out = r.BLOOD;

  selected_dd_text = r.BOUTEILLE;

  // colour slider light
  molette_in_light = r.ORANGE;
  molette_out_light = r.GRAY[6];

  adj_in_light = r.GRAY[14];
  adj_out_light = r.GRAY[6];

  struc_light = r.GRAY[4];

  label_in_light = r.GRAY[14];
  label_out_light = r.GRAY[10];

  // colour slider dark
  molette_in_dark = r.ORANGE;
  molette_out_dark = r.GRAY[6];

  adj_in_dark = r.GRAY[10];
  adj_out_dark = r.GRAY[6];

  struc_dark = r.GRAY[2];

  label_in_dark = r.GRAY[10];
  label_out_dark = r.GRAY[6];

  dropdown_colour = new R_Colour(this,color_dd_background, 
                                    color_dd_header_in, 
                                    color_dd_header_out,
                                    color_dd_header_text_in, 
                                    color_dd_header_text_out,
                                    color_dd_box_in, 
                                    color_dd_box_out, 
                                    color_dd_box_text_in, 
                                    color_dd_box_text_out);

  dropdown_color_item = new R_Colour(this,color_dd_background, 
                                        color_dd_item_in, 
                                        color_dd_item_out,
                                        color_dd_item_text_in,
                                        color_dd_item_text_out,
                                        color_dd_box_in, 
                                        color_dd_box_out,  
                                        color_dd_box_text_in,
                                        color_dd_box_text_out);

}


void set_colour_structure_background_header(int c) {
  fill_header_struc = c;
}

void set_colour_structure_background_mass(int... c) {
  structure_background_mass_a = c[0];
  structure_background_mass_b = c[1];
  // structure_background_mass_c = c_c;
}

void set_colour_structure_background_line(int c_a, int c_b) {
  structure_background_line_a = c_a;
  structure_background_line_b = c_b;
}































/**
* set console
* all button, slider and dropdown is set here
*/
void set_console() {
  set_console_general();

  set_console_slider_background(ivec2(offset_background_x,offset_background_y),ivec2(slider_width_background, slider_height_background));
  set_console_slider_fx_filter(ivec2(offset_fx_filter_x,offset_fx_filter_y),ivec2(slider_width_fx_filter, slider_height_fx_filter));
  set_console_slider_fx_mix(ivec2(offset_fx_mix_x,offset_fx_mix_y),ivec2(slider_width_fx_mix, slider_height_fx_mix));
  set_console_slider_light(ivec2(offset_light_x,offset_light_y),ivec2(slider_width_light, slider_height_light));
  set_console_sound(ivec2(offset_sound_x,offset_sound_y),ivec2(slider_width_sound, slider_height_sound));
  set_console_slider_sound_setting(ivec2(offset_sound_setting_x,offset_sound_setting_y),ivec2(slider_width_sound_setting, slider_height_sound_setting));
  set_console_slider_camera(ivec2(offset_camera_x,offset_camera_y),ivec2(slider_width_camera, slider_height_camera));

  set_console_slider_item(height_item_selected +local_pos_y_slider_item,ivec2(slider_width_item, slider_height_item));

  set_console_window_info();
}


void set_console_window_info() {
  size_window_info = ivec2(250,height/5);
  pos_window_info = ivec2(grid_col[6],height -size_window_info.y -12);
  
}

void set_console_general() {
  // CURTAIN
  pos_curtain_button = vec2(grid_col[0] +0, pos_y_button_top +8);
  size_curtain_button = vec2(30,30);
  // RESET CAMERA
  pos_reset_camera_button = vec2(grid_col[0] +40, pos_y_button_top +9);
  size_reset_camera_button = vec2(26,26);
  // RESET ITEM ON COORD
  pos_reset_item_on_button = vec2(grid_col[0] +70, pos_y_button_top +9);
  size_reset_item_on_button = vec2(26,26);
  // RESET FX LIST
  pos_reset_fx_button = vec2(grid_col[0] +100, pos_y_button_top +9);
  size_reset_fx_button = vec2(26,26);
  // BIRTH
  pos_birth_button = vec2(grid_col[0] +130, pos_y_button_top +9);
  size_birth_button = vec2(26,26);
  // 3D
  pos_3D_button = vec2(grid_col[0] +160, pos_y_button_top +9);
  size_3D_button = vec2(26,26);

  
  // MEDIA DROPDOWN
  int pos_x_last_item = (int)pos_3D_button.x() +35;
  height_dropdown_header_bar = height_box_dropdown;
  set_console_media_bar(pos_x_last_item);
  set_console_menu_bar();
}


void set_console_media_bar(int start_x) {
  num_dd_media_bar = 4;
  pos_y_dd_media_bar = 32;
  int step = width/6;
  // pos x
  pos_x_dd_media_bar = new int[num_dd_media_bar];
  pos_x_dd_media_bar[0] = grid_col[4]; // text
  pos_x_dd_media_bar[1] = grid_col[6];// bitmap
  pos_x_dd_media_bar[2] = grid_col[8];// shape
  pos_x_dd_media_bar[3] = grid_col[10];// movie
  
  // width
 // height_dropdown_header_bar = height_box_dropdown;
  width_dd_media_bar = new int[num_dd_media_bar];
  width_dd_media_bar[0] = 60; // text
  width_dd_media_bar[1] = 60; // bitmap
  width_dd_media_bar[2] = 40; // shape
  width_dd_media_bar[3] = 60; // movie
  
  // name
  name_dd_media_bar = new String[num_dd_media_bar];
  name_dd_media_bar[0] = "text";
  name_dd_media_bar[1] = "bitmap";
  name_dd_media_bar[2] = "shape";
  name_dd_media_bar[3] = "movie";
}


void set_console_menu_bar() {
  num_dd_menu_bar = 4;
  pos_y_dd_menu_bar = 70;
  pos_x_dd_menu_bar = new int[num_dd_menu_bar];
  pos_x_dd_menu_bar[0] = grid_col[0]; // background
  pos_x_dd_menu_bar[1] = grid_col[3]; // fx
  pos_x_dd_menu_bar[2] = grid_col[6]; // mix
  pos_x_dd_menu_bar[3] = grid_col[12]; // font

  
  width_dd_menu_bar = new int[num_dd_menu_bar];
  width_dd_menu_bar[0] = 75; // background
  width_dd_menu_bar[1] = 40; // fx
  width_dd_menu_bar[2] = 40; // mix
  width_dd_menu_bar[3] = 60; // font

  name_dd_menu_bar = new String[num_dd_menu_bar];
  name_dd_menu_bar[0] = "background";
  name_dd_menu_bar[1] = "filter";
  name_dd_menu_bar[2] = "mix";
  name_dd_menu_bar[3] = "font";
}




void set_console_slider_background(ivec2 pos, ivec2 size) {
  // button
  int offset_button_y = -int(size.y *1.5);
  pos_button_background = vec2(pos.x, pos.y +offset_button_y);
  size_button_background = vec2(80,10);
  // slider
  for(int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_background[i] = vec2(pos.x,offset_y);
    size_slider_background[i] = vec2(size);
  }
}



void set_console_slider_fx_filter(ivec2 pos, ivec2 size) {
  int offset_button_y = -int(size.y *1.5);
  int x = pos.x;
  int y = pos.y +offset_button_y;
  // set a default button
  for(int i = 0 ; i < NUM_BUTTON_FX_FILTER ; i++) {
    button_fx_filter_is[i] = 0;
    size_button_fx_filter[i] = vec2(38,10);
  }
  // set position from size
  int offset_x = 0;
  for(int i = 0 ; i < NUM_BUTTON_FX_FILTER ; i++) {  
    x = pos.x + offset_x;
    offset_x += size_button_fx_filter[i].x ;
    pos_button_fx_filter[i] = vec2(x,y);
  }

  for(int i = 0 ; i < NUM_SLIDER_FX_FILTER ; i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_fx_filter[i] = vec2(pos.x, offset_y);
    size_slider_fx_filter[i] = vec2(size);
  }
}

void set_console_slider_fx_mix(ivec2 pos, ivec2 size) {
  int offset_button_y = -int(size.y *1.5);
  int x = pos.x;
  int y = pos.y +offset_button_y;
  // set a default button

  for(int i = 0 ; i < NUM_BUTTON_FX_MIX ; i++) {
    button_fx_mix_is[i] = 0;
    size_button_fx_mix[i] = vec2(47,10);
  }
  // set position from size
  int offset_x = 0;
  for(int i = 0 ; i < NUM_BUTTON_FX_MIX ; i++) {  
    x = pos.x + offset_x;
    offset_x += size_button_fx_mix[i].x;
    pos_button_fx_mix[i] = vec2(x,y);
  }

  for(int i = 0 ; i < NUM_SLIDER_FX_MIX ; i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_fx_mix[i] = vec2(pos.x, offset_y);
    size_slider_fx_mix[i] = vec2(size);
  }
}

void set_console_slider_light(ivec2 pos, ivec2 size) {
  int offset_button_y = -int(size.y *1.5);

  size_light_ambient_buttonButton = vec2(75,10);
  size_light_ambient_button_action = vec2(45,10);
  pos_light_ambient_buttonButton = vec2(pos.x, pos.y +offset_button_y);
  pos_light_ambient_button_action = vec2(pos.x +size_light_ambient_buttonButton.x, pos_light_ambient_buttonButton.y); // for the y we take the y of the button
  
  // light one button
  size_light_1_button = vec2(80,10);
  size_light_1_button_action = vec2(45,10);
  pos_light_1_button = vec2(pos.x, pos.y +(5*spacing_slider) +offset_button_y);
  pos_light_1_button_action = vec2(pos.x +size_light_1_button.x, pos_light_1_button.y); // for the y we take the y of the button
  // light two button
  
  size_light_2_button = vec2(82,10);
  size_light_2_button_action = vec2(45,10);
  pos_light_2_button = vec2(pos.x, pos.y +(10*spacing_slider) +offset_button_y);
  pos_light_2_button_action = vec2(pos.x +size_light_2_button.x, pos_light_2_button.y); // for the y we take the y of the button
  
  //slider
  int count = 0;
  for(int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    if(i%3 == 0 && i > 0) count +=3 ; else count++ ;
    int offset_y = offset_y(pos.y, size.y, count-1);
    pos_slider_light[i] = vec2(pos.x, offset_y);
    size_slider_light[i] = vec2(size);  
  }
}




void set_console_sound(ivec2 pos, ivec2 size) {
  int offset_button_y = -int(size.y *1.5);
  
  // button
  int x = pos.x;
  int y =  pos.y +offset_button_y;
  for(int i = 0 ; i < NUM_BUTTON_TRANSIENT ; i++) {
    button_transient_is[i] = 0;
    size_button_transient[i] = vec2(40,10);
    int s = (int)size_button_transient[i].x ;
    x = ((s*i) +pos.x);
    pos_button_transient[i] = vec2(x,y);
  }

  //slider
  for(int i = 0 ; i < NUM_SLIDER_SOUND ;i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_sound[i] = vec2(pos.x, offset_y);
    size_slider_sound[i] = vec2(size);
  }
}

void set_console_slider_sound_setting(ivec2 pos, ivec2 size) {
  for(int i = 0 ; i < NUM_SLIDER_SOUND_SETTING ;i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_sound_setting[i] = vec2(pos.x, offset_y);
    size_slider_sound_setting[i] = vec2(size);
  }
}

void set_console_slider_camera(ivec2 pos, ivec2 size) {
  for(int i = 0 ; i < NUM_SLIDER_CAMERA ;i++) {
    int offset_y = offset_y(pos.y, 0, i);
    pos_slider_camera[i] = vec2(pos.x, offset_y);
    size_slider_camera[i] = vec2(size);
  }
}






void set_console_slider_item(int pos_y, ivec2 size) {
  // where the controller must display the slider
  for( int i = 0 ; i < NUM_SLIDER_ITEM_BY_COL ; i++) {
    for ( int j = 0 ; j < NUM_COL_SLIDER ; j++) {
      int whichSlider = i +(j *NUM_SLIDER_ITEM_BY_COL) ;
      int pos_x = 0 ;
      switch(j) {
        case 0 : pos_x = item_a_col; 
        break;
        case 1 : pos_x = item_b_col;
        break;
        case 2 : pos_x = item_c_col;
        break;
        case 3 : pos_x = item_d_col;
        break;
      }
      pos_slider_item[whichSlider] = vec2(pos_x, round(pos_y +i *spacing_slider));
      size_slider_item[whichSlider] = vec2(size);
    }
  }
}


/**
local offset for slider
*/
int offset_y(int pos_y, int offset_title, int rank) {
  return round((pos_y+offset_title) +(rank *spacing_slider));
}








