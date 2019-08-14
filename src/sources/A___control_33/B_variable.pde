/**
* variable déclaration
* 2019-2019
* 0.2.0
*/



/**
* MISC var
*/
// GUI
int spacing_slider ;
int rounded_slider ;
int height_menu_general;
int pos_y_menu_general;
int pos_y_menu_general_content;
float ratio_size_molette ; 
float ratio_pos_slider_adjustable ; 
float ratio_size_slider_adjustable ;
int size_title_button;
int marge;
int col_width ;
int [] grid_col;
int height_header;

// syphon
boolean syphon_is;













/**
* COLOUR
*/
R_Colour dropdown_colour;
R_Colour dropdown_color_item;
/**
colour structure
*/
int fill_header_struc;
int structure_background_mass_a;
int structure_background_mass_b;
int structure_background_line_a;
int structure_background_line_b;

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
window info
*/
int text_colour_window_info;
int struc_colour_window_info;
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
ivec3 [] info_button_item;
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

ivec2 size_window_ref;

//LOAD PICTURE VIGNETTE
int numVignette ;





// slider mode display
int slider_mode_display;

int height_button_top;
int pos_y_button_top;





/**
DROPDOWN 
*/
int height_box_dropdown;
int num_box_dropdown_item;
int num_box_dropdown_general;
int height_dropdown_header_bar;

Dropdown dropdown_setting;
vec2 dropdown_setting_pos;
vec2 dropdown_setting_size;
vec2 dropdown_pos_text;

int height_dropdown_top;
int pos_y_dropdown_top;



// DROPDOWN media bar
Dropdown [] dd_media_bar;
vec2 [] dd_media_bar_pos;
vec2 [] dd_media_bar_size;
String [] bitmap_dropdown_list;
String [] shape_dropdown_list;
String [] movie_dropdown_list;
String [] file_text_dropdown_list;
int num_dd_media_bar;
int pos_y_dd_media_bar;
int [] pos_x_dd_media_bar;
int [] width_dd_media_bar;
String [] name_dd_media_bar;
String [][] dd_media_bar_content;

// DROPDOWN menu bar
Dropdown [] dd_menu_bar;
vec2 [] dd_menu_bar_pos;
vec2 [] dd_menu_bar_size;
String [] font_dropdown_list;
int num_dd_menu_bar;
int pos_y_dd_menu_bar;
int [] pos_x_dd_menu_bar;
int [] width_dd_menu_bar;
String [] name_dd_menu_bar;
String [][] dd_menu_bar_content;



ivec3 [] info_button_general;

// midi
int sliderMidi, midi_value_romanesco, midi_channel_romanesco ;
int midi_CC_romanesco = -1 ;
boolean select_midi_is = false ;
vec2 pos_midi_info;

// int spacing_midi_info;
// int size_x_window_info_midi;

// Curtain
PImage[] pic_curtain = new PImage[4];
Button button_curtain;
boolean curtainOpenClose ;
int button_curtain_is;
vec2 pos_curtain_button, size_curtain_button;

// reset camera
PImage[] pic_reset_camera = new PImage[4];
Button button_reset_camera;
int button_reset_camera_is;
vec2 pos_reset_camera_button;
vec2 size_reset_camera_button;

// reset coor item selected
PImage[] pic_reset_item_on = new PImage[4];
Button button_reset_item_on;
int button_reset_item_on_is;
vec2 pos_reset_item_on_button;
vec2 size_reset_item_on_button;

// reset fx
PImage[] pic_reset_fx = new PImage[4];
Button button_reset_fx;
int button_reset_fx_is;
vec2 pos_reset_fx_button;
vec2 size_reset_fx_button;

// birth
PImage[] pic_birth = new PImage[4];
Button button_birth;
int button_birth_is;
vec2 pos_birth_button;
vec2 size_birth_button;

// 3D
PImage[] pic_3D = new PImage[4];
Button button_3D;
int button_3D_is;
vec2 pos_3D_button;
vec2 size_3D_button;














// background button
Button button_bg;
int button_background_is;
vec2 pos_button_background, size_button_background;
// background slider
Sladj [] slider_adj_background = new Sladj[NUM_SLIDER_BACKGROUND];
Cropinfo [] cropinfo_slider_fx_bg; 
int slider_width_background;
int slider_height_background;
vec2 [] pos_slider_background = new vec2[NUM_SLIDER_BACKGROUND]; 
vec2 [] size_slider_background = new vec2[NUM_SLIDER_BACKGROUND];
float [] value_slider_background = new float[NUM_SLIDER_BACKGROUND];
String[] slider_background_name = new String[NUM_SLIDER_BACKGROUND];
int offset_background_x;
int offset_background_y;

// FX FILTER button
Button [] button_fx_filter = new Button[NUM_BUTTON_FX_FILTER];
int [] button_fx_filter_is = new int[NUM_BUTTON_FX_FILTER];
vec2 [] pos_button_fx_filter = new vec2[NUM_BUTTON_FX_FILTER];
vec2 [] size_button_fx_filter = new vec2[NUM_BUTTON_FX_FILTER];

// filter slider
Sladj [] slider_adj_fx_filter = new Sladj[NUM_SLIDER_FX_FILTER];
Cropinfo [] cropinfo_slider_fx_filter;
int slider_width_fx_filter;
int slider_height_fx_filter;
vec2 [] pos_slider_fx_filter = new vec2[NUM_SLIDER_FX_FILTER]; 
vec2 [] size_slider_fx_filter = new vec2[NUM_SLIDER_FX_FILTER];
float [] value_slider_fx_filter = new float[NUM_SLIDER_FX_FILTER];
String[] slider_fx_filter_name = new String[NUM_SLIDER_FX_FILTER];
int offset_fx_filter_x;
int offset_fx_filter_y;




// FX MIX button
Button [] button_fx_mix = new Button[NUM_BUTTON_FX_MIX];
int [] button_fx_mix_is = new int[NUM_BUTTON_FX_MIX];
vec2 [] pos_button_fx_mix = new vec2[NUM_BUTTON_FX_MIX];
vec2 [] size_button_fx_mix = new vec2[NUM_BUTTON_FX_MIX];

// mix slider
Sladj [] slider_adj_fx_mix = new Sladj[NUM_SLIDER_FX_MIX];
Cropinfo [] cropinfo_slider_fx_mix;
int slider_width_fx_mix;
int slider_height_fx_mix;
vec2 [] pos_slider_fx_mix = new vec2[NUM_SLIDER_FX_MIX]; 
vec2 [] size_slider_fx_mix = new vec2[NUM_SLIDER_FX_MIX];
float [] value_slider_fx_mix = new float[NUM_SLIDER_FX_MIX];
String[] slider_fx_mix_name = new String[NUM_SLIDER_FX_MIX];
int offset_fx_mix_x;
int offset_fx_mix_y;

// light button
Button button_light_ambient, button_light_ambient_action,
        button_light_1, button_light_1_action,
        button_light_2, button_light_2_action;
int light_ambient_button_is, light_ambient_action_button_is;
int light_light_1_button_is, light_light_action_1_button_is; 
int light_light_2_button_is, light_light_action_2_button_is;
vec2 pos_light_ambient_buttonButton, size_light_ambient_buttonButton;
vec2 pos_light_ambient_button_action, size_light_ambient_button_action; 
vec2 pos_light_1_button_action, size_light_1_button_action;
vec2 pos_light_1_button, size_light_1_button;
vec2 pos_light_2_button_action, size_light_2_button_action; 
vec2 pos_light_2_button, size_light_2_button;

// light slider
Sladj [] slider_adj_light = new Sladj[NUM_SLIDER_LIGHT];
Cropinfo [] cropinfo_slider_light;
int slider_width_light;
int slider_height_light;
vec2 [] pos_slider_light = new vec2[NUM_SLIDER_LIGHT]; 
vec2 [] size_slider_light = new vec2[NUM_SLIDER_LIGHT];
float [] value_slider_light = new float[NUM_SLIDER_LIGHT];
String[] slider_light_name = new String[NUM_SLIDER_LIGHT];
int offset_light_x;
int offset_light_y;

// sound button transient
Button [] button_transient = new Button[NUM_BUTTON_TRANSIENT];
int [] button_transient_is = new int[NUM_BUTTON_TRANSIENT];
vec2 [] pos_button_transient = new vec2[NUM_BUTTON_TRANSIENT];
vec2 [] size_button_transient = new vec2[NUM_BUTTON_TRANSIENT];


// sound slider
Sladj [] slider_adj_sound = new Sladj[NUM_SLIDER_SOUND];
Cropinfo [] cropinfo_slider_sound;
int slider_width_sound;
int slider_height_sound;
vec2 [] pos_slider_sound = new vec2[NUM_SLIDER_SOUND]; 
vec2 [] size_slider_sound = new vec2[NUM_SLIDER_SOUND];
float [] value_slider_sound = new float[NUM_SLIDER_SOUND];
String[] slider_sound_name = new String[NUM_SLIDER_SOUND];
int offset_sound_x;
int offset_sound_y;

// sound setting
Slider [] slider_sound_setting = new Slider[NUM_SLIDER_SOUND_SETTING];
Cropinfo [] cropinfo_slider_sound_setting;
int slider_width_sound_setting;
int slider_height_sound_setting;
vec2 [] pos_slider_sound_setting = new vec2[NUM_SLIDER_SOUND_SETTING]; 
vec2 [] size_slider_sound_setting = new vec2[NUM_SLIDER_SOUND_SETTING];
float [] value_slider_sound_setting = new float[NUM_MOLETTE_SOUND_SETTING];
String[] slider_sound_setting_name = new String[NUM_SLIDER_SOUND_SETTING];
int offset_sound_setting_x;
int offset_sound_setting_y;

// camera slider
Sladj [] slider_adj_camera = new Sladj[NUM_SLIDER_CAMERA];
Cropinfo [] cropinfo_slider_camera;
int slider_width_camera;
int slider_height_camera;
vec2 [] pos_slider_camera = new vec2[NUM_SLIDER_CAMERA]; 
vec2 [] size_slider_camera = new vec2[NUM_SLIDER_CAMERA];
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
vec2 [] pos_slider_item = new vec2[NUM_SLIDER_ITEM]; 
vec2 [] size_slider_item = new vec2[NUM_SLIDER_ITEM];
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


// window info
ivec2 pos_window_info ;
ivec2 size_window_info;













