/**
Variable
v 0.0.4
*/
/**
ITEM
*/
int NUM_ITEM;
int STEP_ITEM = 40;
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
Vec3 pos_dropdown[];

/**
MISC
*/
Vec2 size_ref ;

int sliderMidi, midi_value_romanesco, midi_channel_romanesco ;
int midi_CC_romanesco = -1 ;
boolean saveMidi ;
boolean selectMidi = false ;
//curtain
boolean curtainOpenClose ;
//GLOBAL
// Save Setting var


// slider mode display
int slider_mode_display = 0 ;

boolean[] keyboard = new boolean[526];
boolean LOAD_SETTING = false ;
















boolean INIT_INTERFACE = true ;

//LOAD PICTURE VIGNETTE
int numVignette ;
PImage[] picCurtain = new PImage[4] ;
PImage[] picMidi = new PImage[4] ;


Vec5 [] info_slider_background; 
Vec2 [] pos_slider_background = new Vec2[NUM_SLIDER_BACKGROUND] ; 
Vec2 [] size_slider_background = new Vec2[NUM_SLIDER_BACKGROUND] ;
Slider_adjustable [] slider_adj_background = new Slider_adjustable[NUM_SLIDER_BACKGROUND] ;
float [] value_slider_background = new float[NUM_SLIDER_BACKGROUND];
String[] slider_background_name = new String[NUM_SLIDER_BACKGROUND];

// slider filter
Vec5 [] info_slider_filter; 
Vec2 [] pos_slider_filter = new Vec2[NUM_SLIDER_FILTER] ; 
Vec2 [] size_slider_filter = new Vec2[NUM_SLIDER_FILTER] ;
Slider_adjustable [] slider_adj_filter = new Slider_adjustable[NUM_SLIDER_FILTER] ;
float [] value_slider_filter = new float[NUM_SLIDER_FILTER];
String[] slider_filter_name = new String[NUM_SLIDER_FILTER];
// slider light
Vec5 [] info_slider_light; 
Vec2 [] pos_slider_light = new Vec2[NUM_SLIDER_LIGHT] ; 
Vec2 [] size_slider_light = new Vec2[NUM_SLIDER_LIGHT] ;
Slider_adjustable [] slider_adj_light = new Slider_adjustable[NUM_SLIDER_LIGHT] ;
float [] value_slider_light = new float[NUM_SLIDER_LIGHT];
String[] slider_light_name = new String[NUM_SLIDER_LIGHT];
// slider sound
Vec5 [] info_slider_sound; 
Vec2 [] pos_slider_sound = new Vec2[NUM_SLIDER_SOUND] ; 
Vec2 [] size_slider_sound = new Vec2[NUM_SLIDER_SOUND] ;
Slider_adjustable [] slider_adj_sound = new Slider_adjustable[NUM_SLIDER_SOUND] ;
float [] value_slider_sound = new float[NUM_SLIDER_SOUND];
String[] slider_sound_name = new String[NUM_SLIDER_SOUND];
// slider camera
Vec5 [] info_slider_camera; 
Vec2 [] pos_slider_camera = new Vec2[NUM_SLIDER_CAMERA] ; 
Vec2 [] size_slider_camera = new Vec2[NUM_SLIDER_CAMERA] ;
Slider_adjustable [] slider_adj_camera = new Slider_adjustable[NUM_SLIDER_CAMERA] ;
float [] value_slider_camera = new float[NUM_SLIDER_CAMERA];
String[] slider_camera_name = new String[NUM_SLIDER_CAMERA];
// slider item
Vec5 [] info_slider_item; 
Vec2 [] pos_slider_item = new Vec2[NUM_SLIDER_ITEM] ; 
Vec2 [] size_slider_item = new Vec2[NUM_SLIDER_ITEM] ;
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




float ratio_size_molette = 1.3; 

int slider_width = 100;
int slider_height = 8;
int col_width = 160;
int spacing_slider = 11;
int rounded_slider = 4;
/*  the position is calculated in ratio of the slider position. Not optimize for the vertical slider */
float ratio_pos_slider_adjustable = .5 ; 
/*the height size is calculated in ratio of the slider height size.  Not optimize for the vertical slider */
float ratio_size_slider_adjustable =.2 ; 

// vertical grid
int col_1 = 10; 
int col_2 = int(col_width +col_1); 
int col_3 = int(col_width +col_2);

// item gui pos
int offset_y_item = col_1 +15;

// this not a position but the height of the rectangle
int height_header = 23;

int height_button_top = 44 ;
int pos_y_button_top = height_header ;

int height_dropdown_top = 32 ;
int pos_y_dropdown_top = height_header +height_button_top;

int height_menu_general = 138 ;
int pos_y_menu_general = height_header +height_button_top +height_dropdown_top;

int height_menu_sound = 55 ;
int pos_y_menu_sound = height_header +height_button_top +height_dropdown_top +height_menu_general;
// item selected setting
int height_item_button_console = 85;
int pos_y_item_selected = height_header +height_button_top +height_dropdown_top +height_menu_general +height_menu_sound;
int height_item_selected = spacing_slider *NUM_SLIDER_ITEM_BY_COL +height_item_button_console;

// inventory item setting
int pos_y_inventory_item = height_header +height_button_top +height_dropdown_top +height_menu_general +height_menu_sound +height_item_selected;
// this value depend of the size of the scene, indeed we must calculate this one later.
int height_inventory_item = 100 ;



// button slider
int sizeTitleButton = 10 ;
int correction_button_txt_y = 1 ;
int correction_slider_txt_y = 1 ;

// CURTAIN
int correctionCurtainX = 0 ;
int correctionCurtainY = 8 ;
// GROUP MIDI
int correctionMidiX = 40 ;
int correctionMidiY = 9 ;
int spacing_midi_info = 13 ;
int correction_info_midi_x = 60 ;
int correction_info_midi_y = 10 ;
int size_x_window_info_midi = 200 ;


// MENU TOP DROPDOWN


//GROUP GENERAL
int correction_slider_general_pos_y = 12 ;
int set_data_item_pos_y = 13 ;

// background
int offset_background_x = col_1 ;
int offset_background_y = pos_y_menu_general +set_data_item_pos_y +2;

// filter
int offset_filter_x = col_1 ;
int offset_filter_y = pos_y_menu_general +set_data_item_pos_y +2;

// light
int [] offset_light_x = {col_1,col_2,col_2};
int [] offset_light_y = {pos_y_menu_general +set_data_item_pos_y +73,
                         pos_y_menu_general +set_data_item_pos_y +13,
                         pos_y_menu_general +set_data_item_pos_y +73 };

// sound
int offset_sound_x = col_1 ;
int offset_sound_y = pos_y_menu_sound +17;

// camera
int offset_camera_x = col_3 ;
int offset_camera_y = pos_y_menu_general +set_data_item_pos_y -5 ;

// item selected
int local_pos_y_button_item_selected = 20 ;
int local_pos_y_dropdown_item_selected = local_pos_y_button_item_selected +73;
int local_pos_y_slider_button = local_pos_y_dropdown_item_selected +20;



/**
DROPDOWN
*/
int SWITCH_VALUE_FOR_DROPDOWN = -2 ;
int height_box_dropdown = 15 ;
/**
item
*/
Vec2 size_dropdown_mode ;
String [] mode_list_RPE ;
// String [] item_mode_dropdown_list;


/**
menu bar
*/
int num_dropdown_bar = 7;
int pos_y_dropdown_bar = 73;
int [] pos_x_dropdown_bar  = {5,50,130,280,370,455,535};
int height_dropdown_header_bar = height_box_dropdown;
int [] width_dropdown_bar  = {75,40,60,60,60,40,60};
String [] name_dropdown_bar = {"background","filter","font","text","bitmap","shape","movie"};
String [][] dropdown_content;

Dropdown dropdown_bar [];
Vec3 [] dropdown_bar_pos;
Vec2 [] dropdown_bar_size;
Vec2 dropdown_bar_pos_text [];

Vec2 posTextDropdown = Vec2(2,8);


String [] filter_dropdown_list, font_dropdown_list, bitmap_dropdown_list, shape_dropdown_list, movie_dropdown_list, file_text_dropdown_list;


float marge_around_dropdown ;









