/**
Variable
v 0.0.6
*/
void set_structure_data() {
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

  // the position is calculated in ratio of the slider position. Not optimize for the vertical slider
  ratio_pos_slider_adjustable = .5 ; 
  // the height size is calculated in ratio of the slider height size.  Not optimize for the vertical slider
  ratio_size_slider_adjustable =.2 ; 

  sizeTitleButton = 10 ;

  correction_button_txt_y = 1 ;

  slider_width = 100;
  slider_height = 8;
  
  spacing_slider = 11;
  rounded_slider = 4;

  correction_slider_general_pos_y = 12 ;

  height_header = 23;
  height_button_top = 44 ;
  pos_y_button_top = height_header;
  height_dropdown_top = 32;
  pos_y_dropdown_top = height_header +height_button_top;
  height_menu_general = 193;
  pos_y_menu_general = height_header +height_button_top +height_dropdown_top;

  set_structure_menu_bar();
  set_structure_background(pos_y_menu_general +15);
  set_structure_light(pos_y_menu_general +15);
  set_structure_filter(pos_y_menu_general +15);
  set_structure_sound(pos_y_menu_general +140);
  set_structure_camera(pos_y_menu_general +15);

  DIST_BETWEEN_ITEM = 40;
  set_structure_item_selected();

  set_structure_item_inventory();
}







void set_structure_background(int pos_y) {
  offset_background_x = grid_col[0];
  offset_background_y = pos_y +2;
}

void set_structure_light(int pos_y) {
  offset_light_x = new int[3];
  offset_light_x[0] = grid_col[0];
  offset_light_x[1] = grid_col[3];
  offset_light_x[2] = grid_col[3];

  offset_light_y = new int[3];
  offset_light_y[0] = pos_y +73;
  offset_light_y[1] = pos_y +13;
  offset_light_y[2] = pos_y +73;
}


void set_structure_filter(int pos_y) {
  offset_filter_x = grid_col[0];
  offset_filter_y = pos_y +2;
}

void set_structure_sound(int pos_y) {
  offset_sound_x = grid_col[0];
  pos_y_menu_sound = pos_y;
  offset_sound_y = pos_y_menu_sound +17;
}

void set_structure_camera(int pos_y) {
  offset_camera_x = grid_col[6];
  offset_camera_y = pos_y -5;
}

void set_structure_item_selected() {
  // item gui pos
  offset_y_item = grid_col[0] +15;
  item_a_col = grid_col[0];
  item_b_col = grid_col[3];
  item_c_col = grid_col[6];
  // item selected
  local_pos_y_button_item_selected = 20;
  local_pos_y_dropdown_item_selected = local_pos_y_button_item_selected +73;
  local_pos_y_slider_button = local_pos_y_dropdown_item_selected +20;

  height_item_button_console = 85;
  pos_y_item_selected = height_header +height_button_top +height_dropdown_top +height_menu_general;
  height_item_selected = spacing_slider *NUM_SLIDER_ITEM_BY_COL +height_item_button_console;
}

void set_structure_item_inventory() {
  pos_y_inventory_item = height_header +height_button_top +height_dropdown_top +height_menu_general +height_item_selected;
  // this value depend of the size of the window, indeed we must calculate this one later.
  height_inventory_item = 100;
}


void set_structure_menu_bar() {
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
MISC
*/
// keyboard
boolean[] keyboard = new boolean[526];
boolean LOAD_SETTING = false ;
boolean INIT_INTERFACE = true ;
/**
ITEM
*/
int NUM_ITEM;
int DIST_BETWEEN_ITEM;
int BUTTON_ITEM_CONSOLE = 4;
PVector [] infoButton;
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

/**
MISC
*/
iVec2 size_window_ref ;

int sliderMidi, midi_value_romanesco, midi_channel_romanesco ;
int midi_CC_romanesco = -1 ;
boolean saveMidi ;
boolean selectMidi = false ;
//curtain
boolean curtainOpenClose ;
// slider mode display
int slider_mode_display = 0 ;


//LOAD PICTURE VIGNETTE
int numVignette ;
PImage[] picCurtain = new PImage[4] ;
PImage[] picMidi = new PImage[4] ;
// slider background
Vec5 [] info_slider_background; 
iVec2 [] pos_slider_background = new iVec2[NUM_SLIDER_BACKGROUND] ; 
iVec2 [] size_slider_background = new iVec2[NUM_SLIDER_BACKGROUND] ;
Slider_adjustable [] slider_adj_background = new Slider_adjustable[NUM_SLIDER_BACKGROUND] ;
float [] value_slider_background = new float[NUM_SLIDER_BACKGROUND];
String[] slider_background_name = new String[NUM_SLIDER_BACKGROUND];
// slider filter
Vec5 [] info_slider_filter; 
iVec2 [] pos_slider_filter = new iVec2[NUM_SLIDER_FILTER] ; 
iVec2 [] size_slider_filter = new iVec2[NUM_SLIDER_FILTER] ;
Slider_adjustable [] slider_adj_filter = new Slider_adjustable[NUM_SLIDER_FILTER] ;
float [] value_slider_filter = new float[NUM_SLIDER_FILTER];
String[] slider_filter_name = new String[NUM_SLIDER_FILTER];
// slider light
Vec5 [] info_slider_light; 
iVec2 [] pos_slider_light = new iVec2[NUM_SLIDER_LIGHT] ; 
iVec2 [] size_slider_light = new iVec2[NUM_SLIDER_LIGHT] ;
Slider_adjustable [] slider_adj_light = new Slider_adjustable[NUM_SLIDER_LIGHT] ;
float [] value_slider_light = new float[NUM_SLIDER_LIGHT];
String[] slider_light_name = new String[NUM_SLIDER_LIGHT];
// slider sound
Vec5 [] info_slider_sound; 
iVec2 [] pos_slider_sound = new iVec2[NUM_SLIDER_SOUND] ; 
iVec2 [] size_slider_sound = new iVec2[NUM_SLIDER_SOUND] ;
Slider_adjustable [] slider_adj_sound = new Slider_adjustable[NUM_SLIDER_SOUND] ;
float [] value_slider_sound = new float[NUM_SLIDER_SOUND];
String[] slider_sound_name = new String[NUM_SLIDER_SOUND];
// slider camera
Vec5 [] info_slider_camera; 
iVec2 [] pos_slider_camera = new iVec2[NUM_SLIDER_CAMERA] ; 
iVec2 [] size_slider_camera = new iVec2[NUM_SLIDER_CAMERA] ;
Slider_adjustable [] slider_adj_camera = new Slider_adjustable[NUM_SLIDER_CAMERA] ;
float [] value_slider_camera = new float[NUM_SLIDER_CAMERA];
String[] slider_camera_name = new String[NUM_SLIDER_CAMERA];
// slider item
Vec5 [] info_slider_item; 
iVec2 [] pos_slider_item = new iVec2[NUM_SLIDER_ITEM] ; 
iVec2 [] size_slider_item = new iVec2[NUM_SLIDER_ITEM] ;
Slider_adjustable [] slider_adj_item = new Slider_adjustable[NUM_SLIDER_ITEM] ;
float [] value_slider_item = new float[NUM_SLIDER_ITEM];
String [] slider_item_name = new String[NUM_SLIDER_ITEM] ;

//Background / light one / light two
int state_BackgroundButton,
    state_LightAmbientButton, state_LightAmbientAction,
    state_LightOneButton, state_LightOneAction, 
    state_LightTwoButton, state_LightTwoAction ;
Vec2 pos_bg_button, size_bg_button,
     posLightAmbientAction, sizeLightAmbientAction, posLightAmbientButton, sizeLightAmbientButton,
     posLightOneAction, sizeLightOneAction, posLightOneButton, sizeLightOneButton,
     posLightTwoAction, sizeLightTwoAction, posLightTwoButton, sizeLightTwoButton ;

// DROPDOWN button font and shader background
int which_bg_shader, which_filter, which_font, which_text, which_bitmap, which_shape, which_movie;

// MIDI, CURTAIN
int state_midi_button, state_curtain_button, state_button_beat, state_button_kick, state_button_snare, state_button_hat;
Vec2  pos_midi_button, size_midi_button, pos_midi_info,
      pos_curtain_button, size_curtain_button,
      pos_beat_button, size_beat_button,
      pos_kick_button, size_kick_button,
      pos_snare_button, size_snare_button,
      pos_hat_button, size_hat_button ;

float ratio_size_molette ; 

int slider_width ;
int slider_height ;
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
int item_a_col,item_b_col,item_c_col;

// item gui pos
int offset_y_item;

// this not a position but the height of the rectangle
int height_header;

int height_button_top;
int pos_y_button_top;

int height_dropdown_top;
int pos_y_dropdown_top;

int height_menu_general;
int pos_y_menu_general;

// int height_menu_sound;
int pos_y_menu_sound;
// item selected setting
int height_item_button_console;
int pos_y_item_selected;
int height_item_selected;

// inventory item setting
int pos_y_inventory_item;
// this value depend of the size of the scene, indeed we must calculate this one later.
int height_inventory_item;

// button slider
int sizeTitleButton;
int correction_button_txt_y;

// CURTAIN
int correctionCurtainX;
int correctionCurtainY;
// GROUP MIDI
int correctionMidiX;
int correctionMidiY;
int spacing_midi_info;
int correction_info_midi_x;
int correction_info_midi_y;
int size_x_window_info_midi;

//GROUP GENERAL
int correction_slider_general_pos_y;

// background
int offset_background_x;
int offset_background_y;

// filter
int offset_filter_x;
int offset_filter_y;

// light
int [] offset_light_x;
int [] offset_light_y;

// sound
int offset_sound_x;
int offset_sound_y;

// camera
int offset_camera_x;
int offset_camera_y;

// item selected
int local_pos_y_button_item_selected;
int local_pos_y_dropdown_item_selected;
int local_pos_y_slider_button;

/**
DROPDOWN
*/
int SWITCH_VALUE_FOR_DROPDOWN = -2 ;
int height_box_dropdown;
/**
item
*/
iVec2 size_dropdown_item_mode ;
String [] mode_list_RPE ;
/**
menu bar
*/
int num_dropdown_bar ;
int pos_y_dropdown_bar ;
int [] pos_x_dropdown_bar ;
int height_dropdown_header_bar ;
int [] width_dropdown_bar  ;
String [] name_dropdown_bar ;
String [][] dropdown_content;

Dropdown [] dropdown_bar;
iVec2 [] dropdown_bar_pos, dropdown_bar_size, dropdown_bar_pos_text;

iVec2 posTextDropdown = iVec2(2,8);

String [] filter_dropdown_list, font_dropdown_list, bitmap_dropdown_list, shape_dropdown_list, movie_dropdown_list, file_text_dropdown_list;

float marge_around_dropdown ;









