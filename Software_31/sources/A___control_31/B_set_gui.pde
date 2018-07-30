/**
Variable
v 0.2.0
*/

/**
design
*/
void set_design() {
  set_design_structure();
  set_design_aspect();
}









/**
set structure
*/
void set_design_structure() {
  height_box_dropdown = 15;
  dropdown_pos_text = iVec2(3,10);

  ratio_size_molette = 1.3;
  // vertical grid
  marge = 10;

  int width_inside = width -(2*marge);
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
  pos_y_menu_general_content = pos_y_menu_general +5;

  set_design_structure_menu_bar();
  set_design_structure_background(1);
  set_design_structure_light(1);
  set_design_structure_filter(1);
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
  int px = grid_col[9];
  int py = pos_y_menu_general_content +(rank *spacing_slider);
  dropdown_setting_pos = iVec2(px,py);
  int sx = 100;
  int sy = height_box_dropdown ;
  dropdown_setting_size = iVec2(sx,sy);
  set_design_structure_camera(rank+3);
  set_design_structure_sound_setting(rank+3);
}


void set_design_structure_camera(int rank) {
  slider_width_camera = 100;
  slider_height_camera = 8;
  offset_camera_x = grid_col[9];
  offset_camera_y = pos_y_menu_general_content +(rank *spacing_slider);
}


void set_design_structure_sound_setting(int rank) {
  slider_width_sound_setting = 100;
  slider_height_sound_setting = 8;
  offset_sound_setting_x = grid_col[9];
  offset_sound_setting_y = pos_y_menu_general_content +(rank *spacing_slider);
}




void set_design_structure_filter(int rank) {
  slider_width_filter = 100;
  slider_height_filter = 8;
  offset_filter_x = grid_col[3];
  offset_filter_y = pos_y_menu_general_content +(rank *spacing_slider);
}


void set_design_structure_light(int rank) {
  slider_width_light = 100;
  slider_height_light = 8;
  offset_light_x = grid_col[6];
  offset_light_y = pos_y_menu_general_content +(rank *spacing_slider);
}

void set_design_structure_sound(int rank) {
  slider_width_sound = 100;
  slider_height_sound = 8;
  offset_sound_x = grid_col[9];
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


void set_design_structure_menu_bar() {
  // CURTAIN
  correctionCurtainX = 0;
  correctionCurtainY = 8;
  // GROUP MIDI
  correctionMidiX = 40;
  correctionMidiY = 9;
  spacing_midi_info = 13;
  correction_info_midi_x = 60;
  correction_info_midi_y = 10;
  size_x_window_info_midi = 200;

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
aspect
*/
void set_design_aspect() {
  fill_header_struc = r.BLOOD;
  structure_background_gray_a = r.GRAY_1;
  structure_background_gray_b = r.GRAY_3;
  structure_background_colour_a = r.ORANGE;
  structure_background_colour_b = r.BLOOD;

  fill_text_title_in = r.YELLOW;
  fill_text_title_out = r.ORANGE;

  fill_info_window_rect = r.CARMIN;
  fill_info_window_text = r.YELLOW;

  fill_midi_no_selection = r.CARMIN;
  fill_midi_selection = r.GRAY_2;

  fill_midi_window_no_selection = r.WHITE;
  fill_midi_window_selection = r.WHITE;

  struc_colour_credit_background = r.GRAY_2;
  struc_colour_credit_text = r.WHITE;

  /**
  colour button
  */
  button_on_in = r.GREEN;
  button_on_out = r.BOTTLE;

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

  selected_dd_text = r.BOTTLE;

  /**
  colour slider light
  */
  molette_in_light = r.GRAY_7;
  molette_out_light = r.GRAY_5;

  adj_in_light = r.GRAY_7;
  adj_out_light = r.GRAY_5;

  struc_light = r.GRAY_3;

  label_in_light = r.GRAY_7;
  label_out_light = r.GRAY_5;

  /**
  colour slider dark
  */
  molette_in_dark = r.GRAY_5;
  molette_out_dark = r.GRAY_3;

  adj_in_dark = r.GRAY_5;
  adj_out_dark = r.GRAY_3;

  struc_dark = r.GRAY_2;

  label_in_dark = r.GRAY_5;
  label_out_dark = r.GRAY_3;

  dropdown_colour = new ROPE_colour(color_dd_background, 
                                    color_dd_header_in, 
                                    color_dd_header_out,
                                    color_dd_header_text_in, 
                                    color_dd_header_text_out,
                                    color_dd_box_in, 
                                    color_dd_box_out, 
                                    color_dd_box_text_in, 
                                    color_dd_box_text_out);

  dropdown_color_item = new ROPE_colour(color_dd_background, 
                                        color_dd_item_in, 
                                        color_dd_item_out,
                                        color_dd_item_text_in,
                                        color_dd_item_text_out,
                                        color_dd_box_in, 
                                        color_dd_box_out,  
                                        color_dd_box_text_in,
                                        color_dd_box_text_out);

}































/**
set console
*/
void set_console() {
  set_console_general();

  set_console_slider_background(iVec2(offset_background_x,offset_background_y),iVec2(slider_width_background, slider_height_background));
  set_console_slider_fx(iVec2(offset_filter_x,offset_filter_y),iVec2(slider_width_filter, slider_height_filter));
  set_console_slider_light(iVec2(offset_light_x,offset_light_y),iVec2(slider_width_light, slider_height_light));
  set_console_sound(iVec2(offset_sound_x,offset_sound_y),iVec2(slider_width_sound, slider_height_sound));
  set_console_slider_sound_setting(iVec2(offset_sound_setting_x,offset_sound_setting_y),iVec2(slider_width_sound_setting, slider_height_sound_setting));
  set_console_slider_camera(iVec2(offset_camera_x,offset_camera_y),iVec2(slider_width_camera, slider_height_camera));

  set_console_slider_item(height_item_selected +local_pos_y_slider_item,iVec2(slider_width_item, slider_height_item));
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

void set_console_slider_background(iVec2 pos, iVec2 size) {
  //button
  int offset_button_y = -int(size.y *1.5);
  pos_button_background = iVec2(pos.x, pos.y +offset_button_y);
  size_button_background = iVec2(120,10);
  // slider
  for(int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_background[i] = iVec2(pos.x,offset_y);
    size_slider_background[i] = iVec2(size);
  }
}



void set_console_slider_fx(iVec2 pos, iVec2 size) {
  int offset_button_y = -int(size.y *1.5);
  int x = pos.x;
  int y = pos.y +offset_button_y;
  for(int i = 0 ; i < NUM_BUTTON_FX ; i++) {
    button_fx_is[i] = 0;
    size_button_fx[i] = iVec2(40,10);
    int s = size_button_fx[i].x ;
    x = ((s*i) +pos.x);
    pos_button_fx[i] = iVec2(x,y);
  }

  for(int i = 0 ; i < NUM_SLIDER_FX ; i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_fx[i] = iVec2(pos.x, offset_y);
    size_slider_fx[i] = iVec2(size);
  }
}



void set_console_slider_light(iVec2 pos, iVec2 size) {
  int offset_button_y = -int(size.y *1.5);

  size_light_ambient_buttonButton = iVec2(80,10);
  size_light_ambient_button_action = iVec2(45,10);
  pos_light_ambient_buttonButton = iVec2(pos.x, pos.y +offset_button_y);
  pos_light_ambient_button_action = iVec2(pos.x +90, pos_light_ambient_buttonButton.y); // for the y we take the y of the button
  
  // light one button
  size_light_1_button = iVec2(80,10);
  size_light_1_button_action = iVec2(45,10);
  pos_light_1_button = iVec2(pos.x, pos.y +(5*spacing_slider) +offset_button_y);
  pos_light_1_button_action = iVec2(pos.x +90, pos_light_1_button.y); // for the y we take the y of the button
  // light two button
  
  size_light_2_button = iVec2(80,10);
  size_light_2_button_action = iVec2(45,10);
  pos_light_2_button = iVec2(pos.x, pos.y +(10*spacing_slider) +offset_button_y);
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
  int offset_button_y = -int(size.y *1.5);
  
  // button
  int x = pos.x;
  int y =  pos.y +offset_button_y;
  for(int i = 0 ; i < NUM_BUTTON_TRANSIENT ; i++) {
    button_transient_is[i] = 0;
    size_button_transient[i] = iVec2(40,10);
    int s = size_button_transient[i].x ;
    x = ((s*i) +pos.x);
    pos_button_transient[i] = iVec2(x,y);
  }

  //slider
  for(int i = 0 ; i < NUM_SLIDER_SOUND ;i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_sound[i] = iVec2(pos.x, offset_y);
    size_slider_sound[i] = iVec2(size);
  }
}

void set_console_slider_sound_setting(iVec2 pos, iVec2 size) {
  for(int i = 0 ; i < NUM_SLIDER_SOUND_SETTING ;i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_sound_setting[i] = iVec2(pos.x, offset_y);
    size_slider_sound_setting[i] = iVec2(size);
  }
}

void set_console_slider_camera(iVec2 pos, iVec2 size) {
  for(int i = 0 ; i < NUM_SLIDER_CAMERA ;i++) {
    int offset_y = offset_y(pos.y, 0, i);
    pos_slider_camera[i] = iVec2(pos.x, offset_y);
    size_slider_camera[i] = iVec2(size);
  }
}






void set_console_slider_item(int pos_y, iVec2 size) {
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
int pos_y_menu_general_content;


/**
COLOUR
*/
ROPE_colour dropdown_colour;
ROPE_colour dropdown_color_item;
/**
colour structure
*/
int fill_header_struc;
int structure_background_gray_a;
int structure_background_gray_b;
int structure_background_colour_a;
int structure_background_colour_b;

int fill_text_title_in;
int fill_text_title_out;

int fill_info_window_rect;
int fill_info_window_text;

int fill_midi_no_selection;
int fill_midi_selection;
int fill_midi_window_no_selection;
int fill_midi_window_selection;

int struc_colour_credit_background;
int struc_colour_credit_text;
/**
colour dropdown
*/
int selected_dd_text;

int color_dd_background;

int color_dd_header_in;
int color_dd_header_out;
int color_dd_header_text_in;
int color_dd_header_text_out;

int color_dd_item_in;
int color_dd_item_out;
int color_dd_item_text_in;
int color_dd_item_text_out;

int color_dd_box_in;
int color_dd_box_out;
int color_dd_box_text_in;
int color_dd_box_text_out;
/**
colour slider light
*/
int molette_in_light;
int molette_out_light;

int adj_in_light;
int adj_out_light;

int struc_light;

int label_in_light;
int label_out_light;

/**
colour slider dark
*/
int molette_in_dark;
int molette_out_dark;

int adj_in_dark;
int adj_out_dark;

int struc_dark;

int label_in_dark;
int label_out_dark;

/**
colour slider dark
*/
int button_off_in;
int button_off_out;

int button_on_in;
int button_on_out;









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

Dropdown dd_item_costume[];
Dropdown dd_item_mode[];

iVec2 size_window_ref;

//LOAD PICTURE VIGNETTE
int numVignette ;
PImage[] picCurtain = new PImage[4] ;
PImage[] picMidi = new PImage[4] ;

// slider mode display
int slider_mode_display = 0 ;



/**
DROPDOWN 
*/
Dropdown dropdown_setting;
iVec2 dropdown_setting_pos;
iVec2 dropdown_setting_size;
iVec2 dropdown_pos_text;







// top
int height_button_top;
int pos_y_button_top;
int height_dropdown_top;
int pos_y_dropdown_top;

// DROPDOWN bar
int which_bg_shader, which_filter, which_font, which_text, which_bitmap, which_shape, which_movie;
Dropdown [] dropdown_bar;
iVec2 [] dropdown_bar_pos, dropdown_bar_size;
String [] filter_dropdown_list, font_dropdown_list, bitmap_dropdown_list, shape_dropdown_list, movie_dropdown_list, file_text_dropdown_list;
int num_dropdown_bar ;
int pos_y_dropdown_bar ;
int [] pos_x_dropdown_bar ;
int height_dropdown_header_bar ;
int [] width_dropdown_bar  ;
String [] name_dropdown_bar ;
String [][] dropdown_content;



iVec3 [] info_button_general;


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


// background button
Button button_bg;
int button_background_is;
iVec2 pos_button_background, size_button_background;
// background slider
Sladj [] slider_adj_background = new Sladj[NUM_SLIDER_BACKGROUND];
Cropinfo [] cropinfo_slider_background; 
int slider_width_background;
int slider_height_background;
iVec2 [] pos_slider_background = new iVec2[NUM_SLIDER_BACKGROUND]; 
iVec2 [] size_slider_background = new iVec2[NUM_SLIDER_BACKGROUND];
float [] value_slider_background = new float[NUM_SLIDER_BACKGROUND];
String[] slider_background_name = new String[NUM_SLIDER_BACKGROUND];
int offset_background_x;
int offset_background_y;

// filter button
Button [] button_fx = new Button[NUM_BUTTON_FX];
int [] button_fx_is = new int[NUM_BUTTON_FX];
iVec2 [] pos_button_fx = new iVec2[NUM_BUTTON_FX];
iVec2 [] size_button_fx = new iVec2[NUM_BUTTON_FX];
// String [] name_button_fx = new String[NUM_BUTTON_FILTER];
// filter slider
Sladj [] slider_adj_fx = new Sladj[NUM_SLIDER_FX];
Cropinfo [] cropinfo_slider_fx;
int slider_width_filter;
int slider_height_filter;
iVec2 [] pos_slider_fx = new iVec2[NUM_SLIDER_FX]; 
iVec2 [] size_slider_fx = new iVec2[NUM_SLIDER_FX];
float [] value_slider_filter = new float[NUM_SLIDER_FX];
String[] slider_filter_name = new String[NUM_SLIDER_FX];
int offset_filter_x;
int offset_filter_y;

// light button
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

// light slider
Sladj [] slider_adj_light = new Sladj[NUM_SLIDER_LIGHT];
Cropinfo [] cropinfo_slider_light;
int slider_width_light;
int slider_height_light;
iVec2 [] pos_slider_light = new iVec2[NUM_SLIDER_LIGHT]; 
iVec2 [] size_slider_light = new iVec2[NUM_SLIDER_LIGHT];
float [] value_slider_light = new float[NUM_SLIDER_LIGHT];
String[] slider_light_name = new String[NUM_SLIDER_LIGHT];
int offset_light_x;
int offset_light_y;

// sound button transient
Button [] button_transient = new Button[NUM_BUTTON_TRANSIENT];
int [] button_transient_is = new int[NUM_BUTTON_TRANSIENT];
iVec2 [] pos_button_transient = new iVec2[NUM_BUTTON_TRANSIENT];
iVec2 [] size_button_transient = new iVec2[NUM_BUTTON_TRANSIENT];


// sound slider
Sladj [] slider_adj_sound = new Sladj[NUM_SLIDER_SOUND];
Cropinfo [] cropinfo_slider_sound;
int slider_width_sound;
int slider_height_sound;
iVec2 [] pos_slider_sound = new iVec2[NUM_SLIDER_SOUND]; 
iVec2 [] size_slider_sound = new iVec2[NUM_SLIDER_SOUND];
float [] value_slider_sound = new float[NUM_SLIDER_SOUND];
String[] slider_sound_name = new String[NUM_SLIDER_SOUND];
int offset_sound_x;
int offset_sound_y;

// sound setting
Slider [] slider_sound_setting = new Slider[NUM_SLIDER_SOUND_SETTING];
Cropinfo [] cropinfo_slider_sound_setting;
int slider_width_sound_setting;
int slider_height_sound_setting;
iVec2 [] pos_slider_sound_setting = new iVec2[NUM_SLIDER_SOUND_SETTING]; 
iVec2 [] size_slider_sound_setting = new iVec2[NUM_SLIDER_SOUND_SETTING];
float [] value_slider_sound_setting = new float[NUM_MOLETTE_SOUND_SETTING];
String[] slider_sound_setting_name = new String[NUM_SLIDER_SOUND_SETTING];
int offset_sound_setting_x;
int offset_sound_setting_y;

// camera slider
Sladj [] slider_adj_camera = new Sladj[NUM_SLIDER_CAMERA];
Cropinfo [] cropinfo_slider_camera;
int slider_width_camera;
int slider_height_camera;
iVec2 [] pos_slider_camera = new iVec2[NUM_SLIDER_CAMERA]; 
iVec2 [] size_slider_camera = new iVec2[NUM_SLIDER_CAMERA];
float [] value_slider_camera = new float[NUM_SLIDER_CAMERA];
String[] slider_camera_name = new String[NUM_SLIDER_CAMERA];
int offset_camera_x;
int offset_camera_y;

// item button
int local_pos_y_button_item;
int height_item_button_console;
// item dropdown 
int local_pos_y_dropdown_item;
String [] list_item_mode;
String [] list_item_costume;
// item slider
Sladj [] slider_adj_item = new Sladj[NUM_SLIDER_ITEM];
Cropinfo [] cropinfo_slider_item;
int slider_width_item;
int slider_height_item;
iVec2 [] pos_slider_item = new iVec2[NUM_SLIDER_ITEM]; 
iVec2 [] size_slider_item = new iVec2[NUM_SLIDER_ITEM];
float [] value_slider_item = new float[NUM_SLIDER_ITEM];
String [] slider_item_name = new String[NUM_SLIDER_ITEM];
int local_pos_y_slider_item;
int pos_y_item_selected;
int height_item_selected;
int offset_x_item;
int item_a_col;
int item_b_col;
int item_c_col;
int item_d_col;

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
int height_box_dropdown;








