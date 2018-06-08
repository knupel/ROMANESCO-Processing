/**
Variable
v 0.1.0
*/
/**
colour
*/


/**
set structure
*/
void set_design_var() {
  // dropdown
  height_box_dropdown = 15;

  ratio_size_molette = 1.3;
  // vertical grid
  marge = 10;

  int width_inside = width -(2*marge);
  //col_width = 160;
  grid_col = new int[12];
  col_width = width_inside/grid_col.length;
  grid_col[0] = marge;
  for(int i = 1 ; i < grid_col.length ; i++) {
    grid_col[i] = col_width +grid_col[i-1];
  }

  sizeTitleButton = 10 ;

  spacing_slider = 11;
  rounded_slider = 4;

  height_header = 23;
  height_button_top = 44 ;
  pos_y_button_top = height_header;
  height_dropdown_top = 32;
  pos_y_dropdown_top = height_header +height_button_top;
  height_menu_general = 193;
  pos_y_menu_general = height_header +height_button_top +height_dropdown_top;

  set_design_var_menu_bar();
  set_design_var_background(pos_y_menu_general +15);
  set_design_var_light(pos_y_menu_general +15);
  set_design_var_filter(pos_y_menu_general +15);
  set_design_var_sound(pos_y_menu_general +15);
  set_design_var_camera(pos_y_menu_general +15);

  DIST_BETWEEN_ITEM = 40;
  set_design_var_item_selected();

  set_design_var_inventory();
}

void set_colour() {
  color_dd_background = rougeTresFonce;
  color_dd_header_in = jaune;
  color_dd_header_out = orange;

  color_dd_header_text_in = orange;
  color_dd_header_text_out = jaune;

  color_dd_item_in = rouge;
  color_dd_item_out = rougeTresFonce;

  color_dd_item_text_in = rougeFonce;
  color_dd_item_text_out = rougeFonce;
/*
  color_dd_header_in = jaune; 
  color_dd_header_out = orange;
  */

  color_dd_box_in = jaune; 
  color_dd_box_out = orange;

  color_dd_box_text_in = rougeFonce;
  color_dd_box_text_out = rougeFonce;

  selected_dd_text = vertFonce;
}









void set_design_var_background(int pos_y) {
  slider_width_background = 100;
  slider_height_background = 8;
  offset_background_x = grid_col[0];
  offset_background_y = pos_y +2;
}

void set_design_var_light(int pos_y) {
  slider_width_light = 100;
  slider_height_light = 8;
  offset_light_x = grid_col[3];
  offset_light_y = pos_y +2;
}


void set_design_var_filter(int pos_y) {
  slider_width_filter = 100;
  slider_height_filter = 8;
  offset_filter_x = grid_col[6];
  offset_filter_y = pos_y +2;
}

void set_design_var_camera(int pos_y) {
  slider_width_camera = 100;
  slider_height_camera = 8;
  offset_camera_x = grid_col[0];
  // offset_camera_y = pos_y -5;
  offset_camera_y = pos_y +65;
}

void set_design_var_sound(int pos_y) {
  slider_width_sound = 100;
  slider_height_sound = 8;
  offset_sound_x = grid_col[9];
  offset_sound_y = pos_y +17;
}

void set_design_var_item_selected() {
  slider_width_item = 100;
  slider_height_item = 8;
  // item gui pos
  offset_y_item = grid_col[0] +15;
  item_a_col = grid_col[0];
  item_b_col = grid_col[3];
  item_c_col = grid_col[6];
  // item selected
  local_pos_y_button_item_selected = 20;
  local_pos_y_dropdown_item_selected = local_pos_y_button_item_selected +73;
  local_pos_y_slider_item_button = local_pos_y_dropdown_item_selected +20;

  height_item_button_console = 85;
  pos_y_item_selected = height_header +height_button_top +height_dropdown_top +height_menu_general;
  height_item_selected = spacing_slider *NUM_SLIDER_ITEM_BY_COL +height_item_button_console;
}

void set_design_var_inventory() {
  pos_y_inventory = height_header +height_button_top +height_dropdown_top +height_menu_general +height_item_selected;
  // this value depend of the size of the window, indeed we must calculate this one later.
  height_inventory = 100;
}


void set_design_var_menu_bar() {
  // CURTAIN
  correctionCurtainX = 0 ;
  correctionCurtainY = 8 ;
  // GROUP MIDI
  correctionMidiX = 40 ;
  correctionMidiY = 9 ;
  spacing_midi_info = 13 ;
  correction_info_midi_x = 60 ;
  correction_info_midi_y = 10 ;
  size_x_window_info_midi = 200 ;

  num_dropdown_bar = 7;
  pos_y_dropdown_bar = 73;
  pos_x_dropdown_bar = new int[num_dropdown_bar];
  pos_x_dropdown_bar [0] = 5;
  pos_x_dropdown_bar [1] = 100;
  pos_x_dropdown_bar [2] = 160;
  pos_x_dropdown_bar [3] = 280;
  pos_x_dropdown_bar [4] = 370;
  pos_x_dropdown_bar [5] = 455;
  pos_x_dropdown_bar [6] = 535;

  height_dropdown_header_bar = height_box_dropdown;
  width_dropdown_bar = new int[num_dropdown_bar];
  width_dropdown_bar [0] = 75;
  width_dropdown_bar [1] = 40;
  width_dropdown_bar [2] = 60;
  width_dropdown_bar [3] = 60;
  width_dropdown_bar [4] = 60;
  width_dropdown_bar [5] = 40;
  width_dropdown_bar [6] = 60;

  name_dropdown_bar = new String[num_dropdown_bar];
  name_dropdown_bar[0] = "background";
  name_dropdown_bar[1] = "filter";
  name_dropdown_bar[2] = "font";
  name_dropdown_bar[3] = "text";
  name_dropdown_bar[4] = "bitmap";
  name_dropdown_bar[5] = "shape";
  name_dropdown_bar[6] = "movie";
}























/**
set slider
*/
void set_console() {
  set_console_general();

  set_console_background(iVec2(offset_background_x,offset_background_y),iVec2(slider_width_background, slider_height_background));
  set_console_filter(iVec2(offset_filter_x,offset_filter_y),iVec2(slider_width_filter, slider_height_filter));
  set_console_light(iVec2(offset_light_x,offset_light_y),iVec2(slider_width_light, slider_height_light));
  set_console_sound(iVec2(offset_sound_x,offset_sound_y),iVec2(slider_width_sound, slider_height_sound));
  set_console_camera(iVec2(offset_camera_x,offset_camera_y),iVec2(slider_width_camera, slider_height_camera));

  set_console_item(height_item_selected +local_pos_y_slider_item_button,iVec2(slider_width_item, slider_height_item));
}

void set_console_general() {
  // MIDI
  size_midi_button = iVec2(50,26);
  pos_midi_button = iVec2(grid_col[0] +correctionMidiX, pos_y_button_top +correctionMidiY);
  pos_midi_info = Vec2(pos_midi_button.x +correction_info_midi_x, pos_midi_button.y +correction_info_midi_y);
  // CURTAIN
  size_curtain_button = iVec2(30,30);
  pos_curtain_button = iVec2(grid_col[0] +correctionCurtainX, pos_y_button_top +correctionCurtainY); 
}

void set_console_background(iVec2 pos, iVec2 size) {
  //button
  pos_button_background = iVec2(pos.x, pos.y -size.y);
  size_button_background = iVec2(120,10);
  // slider
  for(int i = 0 ; i < NUM_SLIDER_BACKGROUND ;i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_background[i] = iVec2(pos.x,offset_y);
    size_slider_background[i] = iVec2(size);
  }
}

void set_console_filter(iVec2 pos, iVec2 size) {
  for(int i = 0 ; i < NUM_SLIDER_FILTER ;i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    //int offset_y = round(pos.y +(i *spacing_slider));
    pos_slider_filter[i] = iVec2(pos.x, offset_y);
    size_slider_filter[i] = iVec2(size);
  }
}

void set_console_light(iVec2 pos, iVec2 size) {
  //button
  
  size_light_ambient_buttonButton = iVec2(80,10);
  size_light_ambient_button_action = iVec2(45,10);
  pos_light_ambient_buttonButton = iVec2(pos.x, pos.y -size.y);
  pos_light_ambient_button_action = iVec2(pos.x +90, pos.y -size.y); // for the y we take the y of the button
  // light one button
  
  size_light_1_button = iVec2(80,10);
  size_light_1_button_action = iVec2(45,10);
  pos_light_1_button = iVec2(pos.x, pos.y +(5*spacing_slider) -size.y);
  pos_light_1_button_action = iVec2(pos.x +90, pos_light_1_button.y); // for the y we take the y of the button
  // light two button
  
  size_light_2_button = iVec2(80,10);
  size_light_2_button_action = iVec2(45,10);
  pos_light_2_button = iVec2(pos.x, pos.y +(10*spacing_slider) -size.y);
  pos_light_2_button_action = iVec2(pos.x +90, pos_light_2_button.y); // for the y we take the y of the button
  
  //slider
  int count = 0;
  for(int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    if(i%3 == 0 && i > 0) count +=3 ; else count++ ;
    int offset_y = offset_y(pos.y, size.y, count-1);
    pos_slider_light[i] = iVec2(pos.x, offset_y);
    size_slider_light[i] = iVec2(size);  
  }
}

void set_console_sound(iVec2 pos, iVec2 size) {
  // button
  size_kick_button = iVec2(30,10); 
  size_snare_button = iVec2(40,10); 
  size_hat_button = iVec2(30,10);
  
  pos_kick_button = iVec2(pos.x,pos.y -size.y); 
  pos_snare_button = iVec2(pos_kick_button.x +size_kick_button.x +5, pos.y -size.y); 
  pos_hat_button = iVec2(pos_snare_button.x +size_snare_button.x +5, pos.y -size.y);

  //slider
  for(int i = 0 ; i < NUM_SLIDER_SOUND ;i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_sound[i] = iVec2(pos.x, offset_y);
    size_slider_sound[i] = iVec2(size);
  }
}

void set_console_camera(iVec2 pos, iVec2 size) {
  for(int i = 0 ; i < NUM_SLIDER_CAMERA ;i++) {
    int offset_y = offset_y(pos.y, 0, i);
    pos_slider_camera[i] = iVec2(pos.x, offset_y);
    size_slider_camera[i] = iVec2(size);
  }
}



void set_console_item(int pos_y, iVec2 size) {
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
local offset for slider
*/
int offset_y(int pos_y, int offset_title, int rank) {
  return round((pos_y+offset_title) +(rank *spacing_slider));
}



















/**
MUST BE REMOVE
*/
int height_menu_general;
int pos_y_menu_general;

/**
colour
*/
int selected_dd_text;

int color_dd_background;

int color_dd_header_in, color_dd_header_out;
int color_dd_header_text_in,color_dd_header_text_out;

int color_dd_item_in, color_dd_item_out;
int color_dd_item_text_in,color_dd_item_text_out;

int color_dd_box_in, color_dd_box_out;
int color_dd_box_text_in,color_dd_box_text_out;






/**
general
*/
iVec3 [] info_button_general;


/**
ITEM
*/
int NUM_ITEM;
int DIST_BETWEEN_ITEM;
int BUTTON_ITEM_CONSOLE = 4;
iVec3 [] info_button_item;
int [] info_list_item_ID; 

PImage[] OFF_in_thumbnail;
PImage[] OFF_out_thumbnail;
PImage[] ON_in_thumbnail;
PImage[] ON_out_thumbnail;

PImage[] picSetting = new PImage[4];
PImage[] picSound = new PImage[4];
PImage[] picAction = new PImage[4];

Dropdown dropdown_item_mode[];
iVec2 pos_dropdown[];

iVec2 size_window_ref;

//LOAD PICTURE VIGNETTE
int numVignette ;
PImage[] picCurtain = new PImage[4] ;
PImage[] picMidi = new PImage[4] ;

// slider mode display
int slider_mode_display = 0 ;





// top
int height_button_top;
int pos_y_button_top;
int height_dropdown_top;
int pos_y_dropdown_top;


// DROPDOWN button font and shader background
int which_bg_shader, which_filter, which_font, which_text, which_bitmap, which_shape, which_movie;
Dropdown [] dropdown_bar;
iVec2 [] dropdown_bar_pos, dropdown_bar_size, dropdown_bar_pos_text;
String [] filter_dropdown_list, font_dropdown_list, bitmap_dropdown_list, shape_dropdown_list, movie_dropdown_list, file_text_dropdown_list;
int num_dropdown_bar ;
int pos_y_dropdown_bar ;
int [] pos_x_dropdown_bar ;
int height_dropdown_header_bar ;
int [] width_dropdown_bar  ;
String [] name_dropdown_bar ;
String [][] dropdown_content;


// midi
Button button_midi;
int sliderMidi, midi_value_romanesco, midi_channel_romanesco ;
int midi_CC_romanesco = -1 ;
boolean saveMidi ;
boolean selectMidi = false ;
int button_midi_is;
iVec2 pos_midi_button, size_midi_button;
Vec2 pos_midi_info;
int correctionMidiX;
int correctionMidiY;
int spacing_midi_info;
int correction_info_midi_x;
int correction_info_midi_y;
int size_x_window_info_midi;

// Curtain
Button button_curtain;
boolean curtainOpenClose ;
int button_curtain_is;
iVec2 pos_curtain_button, size_curtain_button;
int correctionCurtainX;
int correctionCurtainY;


// background
Button button_bg;
int button_background_is;
iVec2 pos_button_background, size_button_background;
int slider_width_background;
int slider_height_background;
Vec5 [] info_slider_background; 
iVec2 [] pos_slider_background = new iVec2[NUM_SLIDER_BACKGROUND] ; 
iVec2 [] size_slider_background = new iVec2[NUM_SLIDER_BACKGROUND] ;
Sladj [] slider_adj_background = new Sladj[NUM_SLIDER_BACKGROUND] ;
float [] value_slider_background = new float[NUM_SLIDER_BACKGROUND];
String[] slider_background_name = new String[NUM_SLIDER_BACKGROUND];
int offset_background_x;
int offset_background_y;

// filter
int slider_width_filter;
int slider_height_filter;
Vec5 [] info_slider_filter; 
iVec2 [] pos_slider_filter = new iVec2[NUM_SLIDER_FILTER] ; 
iVec2 [] size_slider_filter = new iVec2[NUM_SLIDER_FILTER] ;
Sladj [] slider_adj_filter = new Sladj[NUM_SLIDER_FILTER] ;
float [] value_slider_filter = new float[NUM_SLIDER_FILTER];
String[] slider_filter_name = new String[NUM_SLIDER_FILTER];
int offset_filter_x;
int offset_filter_y;

// light
Button button_light_ambient, button_light_ambient_action,
        button_light_1, button_light_1_action,
        button_light_2, button_light_2_action;
int light_ambient_button_is, light_ambient_action_button_is;
int light_light_1_button_is, light_light_action_1_button_is; 
int light_light_2_button_is, light_light_action_2_button_is;
iVec2 pos_light_ambient_buttonButton, size_light_ambient_buttonButton;
iVec2 pos_light_ambient_button_action, size_light_ambient_button_action; 
iVec2 pos_light_1_button_action, size_light_1_button_action;
iVec2 pos_light_1_button, size_light_1_button;
iVec2 pos_light_2_button_action, size_light_2_button_action; 
iVec2 pos_light_2_button, size_light_2_button;
int slider_width_light;
int slider_height_light;
Vec5 [] info_slider_light; 
iVec2 [] pos_slider_light = new iVec2[NUM_SLIDER_LIGHT] ; 
iVec2 [] size_slider_light = new iVec2[NUM_SLIDER_LIGHT] ;
Sladj [] slider_adj_light = new Sladj[NUM_SLIDER_LIGHT] ;
float [] value_slider_light = new float[NUM_SLIDER_LIGHT];
String[] slider_light_name = new String[NUM_SLIDER_LIGHT];
int offset_light_x;
int offset_light_y;

// sound
Button button_kick, button_snare, button_hat;
int button_kick_is, button_snare_is, button_hat_is;
iVec2 pos_kick_button, size_kick_button;
iVec2 pos_snare_button, size_snare_button;
iVec2 pos_hat_button, size_hat_button;

int slider_width_sound;
int slider_height_sound;
Vec5 [] info_slider_sound; 
iVec2 [] pos_slider_sound = new iVec2[NUM_SLIDER_SOUND] ; 
iVec2 [] size_slider_sound = new iVec2[NUM_SLIDER_SOUND] ;
Sladj [] slider_adj_sound = new Sladj[NUM_SLIDER_SOUND] ;
float [] value_slider_sound = new float[NUM_SLIDER_SOUND];
String[] slider_sound_name = new String[NUM_SLIDER_SOUND];
int offset_sound_x;
int offset_sound_y;

// camera
int slider_width_camera;
int slider_height_camera;
Vec5 [] info_slider_camera; 
iVec2 [] pos_slider_camera = new iVec2[NUM_SLIDER_CAMERA]; 
iVec2 [] size_slider_camera = new iVec2[NUM_SLIDER_CAMERA];
Sladj [] slider_adj_camera = new Sladj[NUM_SLIDER_CAMERA];
float [] value_slider_camera = new float[NUM_SLIDER_CAMERA];
String[] slider_camera_name = new String[NUM_SLIDER_CAMERA];
int offset_camera_x;
int offset_camera_y;

// item
int slider_width_item;
int slider_height_item;
Vec5 [] info_slider_item; 
iVec2 [] pos_slider_item = new iVec2[NUM_SLIDER_ITEM]; 
iVec2 [] size_slider_item = new iVec2[NUM_SLIDER_ITEM];
Sladj [] slider_adj_item = new Sladj[NUM_SLIDER_ITEM];
float [] value_slider_item = new float[NUM_SLIDER_ITEM];
String [] slider_item_name = new String[NUM_SLIDER_ITEM];
int local_pos_y_button_item_selected;
int local_pos_y_dropdown_item_selected;
int local_pos_y_slider_item_button;
int height_item_button_console;
int pos_y_item_selected;
int height_item_selected;
iVec2 size_dropdown_item_mode;
String [] mode_list_RPE;
int offset_y_item;
int item_a_col,item_b_col,item_c_col;

// inventory
int pos_y_inventory;
int height_inventory;






/**
MISC var
*/
float ratio_size_molette ; 

int col_width ;
int spacing_slider ;
int rounded_slider ;
// the position is calculated in ratio of the slider position. Not optimize for the vertical slider
float ratio_pos_slider_adjustable ; 
// the height size is calculated in ratio of the slider height size.  Not optimize for the vertical slider
float ratio_size_slider_adjustable ; 

// vertical grid
int marge;
int [] grid_col;

// this not a position but the height of the rectangle
int height_header;





// button slider
int sizeTitleButton;

/**
DROPDOWN
*/
// int SWITCH_VALUE_FOR_DROPDOWN = -2;
int height_box_dropdown;
iVec2 posTextDropdown = iVec2(2,8);
// float marge_around_dropdown;








