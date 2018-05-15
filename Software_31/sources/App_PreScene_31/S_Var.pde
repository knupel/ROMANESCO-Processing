/**
VARIABLE
Prescene, Scene
Romanesco Processing Environment
2015-2018
v 1.2.5
*/

/**
keyboard
*/
//short _key
boolean key_a, key_b, key_c, key_d, key_e, key_f, key_g, key_h, key_i, key_j, key_k, key_l, key_m, key_n, key_o, key_p, key_q, key_r, key_s, key_t, key_u, key_v, key_w, key_x, key_y, key_z;
boolean key_A, key_B, key_C, key_D, key_E, key_F, key_G, key_H, key_I, key_J, key_K, key_L, key_M, key_N, key_O, key_P, key_Q, key_R, key_S, key_T, key_U, key_V, key_W, key_X, key_Y, key_Z;
boolean key_left, key_right, key_up, key_down; 
boolean key_0, key_1, key_2, key_3, key_4, key_5, key_6, key_7, key_8, key_9;
boolean key_space, key_backspace, key_delete, key_enter, key_return, key_shift, key_alt, key_esc, key_ctrl, key_cmd;
//long touch
boolean key_c_long, key_l_long, key_n_long, key_v_long;
boolean key_space_long, key_shift_long; 

String data_osc_prescene[] = new String [135]; 



//CALLING class or library in Other Class, you must call the PApplet too in your class
PApplet callingClass = this ;
// use for the border of window (top and right)
java.awt.Insets insets; 


// WINDOW VAR
//PVector SIZE_BG  ;
int MIN_WINDOW_WIDTH = 128 ; 
int MIN_WINDOW_HEIGHT = 128 ;

int scene_width,scene_height;

// Max value whi is return from the slider controller
int MAX_VALUE_SLIDER = 360 ;


//variable for the tracking
boolean nextPrevious = false ;
int nextPreviousInt = 0 ; // for send to Syphon
int trackerUpdate ; // must be reset after each use
//spectrum for the color mode and more if you need
Vec4 HSBmode = new Vec4 (360,100,100,100) ; // give the color mode in HSB
//path to open the controleur
String findPath ; 

// MOUSE DETECTION
// return if the cursor (mouse) is in the sketch or not
boolean MOUSE_IN_OUT = true ;


// COMMAND BOOLEAN
//BOOLEAN COMMAND
/* command from leap motion, mouse or other devices if we code for that :) */
boolean ORDER, ORDER_ONE, ORDER_TWO, ORDER_THREE ;
boolean LEAPMOTION_DETECTED ;


// SAVE
boolean load_SCENE_Setting_GLOBAL, save_Current_SCENE_Setting_GLOBAL, save_New_SCENE_Setting_GLOBAL ;

//spectrum band
int NUM_BANDS = 16 ;

int NUM_BUTTON_GENERAL = 21 ; 
int button_item_num  ; 
// VAR obj
color COLOR_FILL_OBJ_PREVIEW; 
color COLOR_STROKE_OBJ_PREVIEW;
int THICKNESS_OBJ_PREVIEW = 2;
int NUM_ITEM;
int NUM_ITEM_PLUS_MASTER;
int NUM_SETTING_ITEM;
int BUTTON_ITEM_CONSOLE = 4;


// general var 
// button
boolean beat_is, kick_is, snare_is, hat_is;
boolean curtain_is, background_is;
boolean ambient_is,ambient_action_is;
boolean light_1_is,light_1_action_is;
boolean light_2_is,light_2_action_is;

int which_shader;
int which_filter; 
int [] which_bitmap, which_text, which_shape, which_movie;

boolean [] button_general_is;

//SLIDER
// becareful if the number of MISC SLIDERS is upper than OBJ SLIDER, that can be a problem in the future.
float value_slider_background [] = new float [NUM_SLIDER_BACKGROUND];
float value_slider_filter [] = new float [NUM_SLIDER_FILTER];
float value_slider_light [] = new float [NUM_SLIDER_LIGHT];
float value_slider_sound [] = new float [NUM_SLIDER_SOUND];
float value_slider_camera [] = new float [NUM_SLIDER_CAMERA];
float value_slider_item []  = new float [NUM_SLIDER_ITEM];






/**
Var item
*/
Table indexObjects ;
TableRow [] row_index_item ;
//MISC var
//info object
String [] objectInfo, objectName, objectAuthor, objectVersion, objectPack ;
int [] objectID ;
boolean [] item_info_display ;
//for the leap motion ?
int objectLeapID[] ;
//BUTTON CONTROLER
boolean objectParameter[] ;

//raw
int fill_hue_raw, fill_sat_raw, fill_bright_raw, fill_alpha_raw ;
int stroke_hue_raw, stroke_sat_raw, stroke_bright_raw, stroke_alpha_raw ;
float thickness_raw ; 
float size_x_raw, size_y_raw, size_z_raw ;
float canvas_x_raw, canvas_y_raw, canvas_z_raw ;
float font_size_raw ;

float reactivity_raw ;
float speed_x_raw, speed_y_raw, speed_z_raw ;
float spurt_x_raw, spurt_y_raw, spurt_z_raw ;
float dir_x_raw, dir_y_raw, dir_z_raw ;
float jitter_x_raw, jitter_y_raw, jitter_z_raw ;
float swing_x_raw, swing_y_raw, swing_z_raw ;

float quantity_raw, variety_raw ; 
float life_raw, flow_raw, quality_raw ;

float area_raw, angle_raw, scope_raw, scan_raw ;
float alignment_raw, repulsion_raw, attraction_raw, density_raw ;

float influence_raw, calm_raw, spectrum_raw ;




// MIN MAX MAP SLIDER
Vec2 fill_hue_min_max, fill_sat_min_max , fill_bright_min_max , fill_alpha_min_max ;
Vec2 stroke_hue_min_max, stroke_sat_min_max, stroke_bright_min_max, stroke_alpha_min_max  ;
Vec2 thickness_min_max ; 
Vec2 size_x_min_max, size_y_min_max, size_z_min_max ;
Vec2 font_size_min_max ;
Vec2 canvas_x_min_max, canvas_y_min_max, canvas_z_min_max ;

Vec2 reactivity_min_max ;
Vec2 speed_x_min_max, speed_y_min_max, speed_z_min_max ;
Vec2 spurt_x_min_max, spurt_y_min_max, spurt_z_min_max ;
Vec2 dir_x_min_max, dir_y_min_max, dir_z_min_max  ; 
Vec2 jitter_x_min_max, jitter_y_min_max, jitter_z_min_max ;
Vec2 swing_x_min_max, swing_y_min_max, swing_z_min_max ;

Vec2 quantity_min_max, variety_min_max ; 
Vec2 life_min_max, flow_min_max, quality_min_max ;
Vec2 area_min_max, angle_min_max, scope_min_max, scan_min_max ; 

Vec2 alignment_min_max, repulsion_min_max, attraction_min_max, density_min_max ;
Vec2 influence_min_max, calm_min_max ;
Vec2 spectrum_min_max ;


// temp
/* value used to know if the value slider have change or nor */
int fill_hue_temp, fill_sat_temp, fill_bright_temp, fill_alpha_temp ;
int stroke_hue_temp, stroke_sat_temp, stroke_bright_temp, stroke_alpha_temp ;
float thickness_temp; 
float size_x_temp, size_y_temp, size_z_temp ;
float canvas_x_temp, canvas_y_temp, canvas_z_temp ;
float font_size_temp ;

float reactivity_temp ;
float speed_x_temp, speed_y_temp, speed_z_temp ;
float spurt_x_temp, spurt_y_temp, spurt_z_temp ;
float dir_x_temp, dir_y_temp,dir_z_temp ;
float jitter_x_temp, jitter_y_temp, jitter_z_temp ;
float swing_x_temp, swing_y_temp, swing_z_temp ;

float quantity_temp, variety_temp ;
float life_temp, flow_temp, quality_temp ;
float area_temp, angle_temp, scope_temp, scan_temp ;

float alignment_temp, repulsion_temp, attraction_temp, density_temp ;
float influence_temp, calm_temp, spectrum_temp ;




// item target final
boolean [] first_opening_item ; // used to check if this object is already opening before
int [] fill_item, stroke_item ;
float [] thickness_item ; 
float [] size_x_item, size_y_item, size_z_item ;
float [] font_size_item ;
float [] canvas_x_item, canvas_y_item, canvas_z_item ;

float [] reactivity_item ;
float [] speed_x_item, speed_y_item, speed_z_item ;
float [] spurt_x_item, spurt_y_item, spurt_z_item ;
float [] dir_x_item, dir_y_item, dir_z_item ;
float [] jitter_x_item, jitter_y_item, jitter_z_item ;
float [] swing_x_item, swing_y_item, swing_z_item ;

float [] quantity_item, variety_item ;
float [] life_item, flow_item, quality_item ;

float [] area_item, angle_item, scope_item, scan_item ;
float [] alignment_item, repulsion_item, attraction_item, density_item ;
float [] influence_item, calm_item, spectrum_item ;

/**
String name
Used for SCENE don't delete
*/
String fill_hue_name = "fill_hue" ;     
String fill_sat_name = "fill_sat" ;     
String fill_bright_name= "fill_bright" ;     
String fill_alpha_name = "fill_alpha" ;

String stroke_hue_name = "stroke_hue" ; 
String stroke_sat_name = "stroke_sat" ; 
String stroke_bright_name= "stroke_bright" ; 
String stroke_alpha_name = "stroke_alpha" ;

String thickness_name = "thickness" ; 

String size_x_name = "size_x" ;     
String size_y_name = "size_y" ;     
String size_z_name = "size_z" ;

String font_size_name = "font_size";

String canvas_x_name = "canvas_x" ; 
String canvas_y_name = "canvas_y" ; 
String canvas_z_name = "canvas_z" ;

String reactivity_name = "reactivity" ;

String speed_x_name = "speed_x" ; 
String speed_y_name = "speed_y" ; 
String speed_z_name = "speed_z" ;

String spurt_x_name = "spurt_x" ; 
String spurt_y_name= "spurt_y"; 
String spurt_z_name = "spurt_z" ;

String dir_x_name = "dir_x" ; 
String dir_y_name = "dir_y" ; 
String dir_z_name = "dir_z" ;

String jitter_x_name = "jitter_x" ; 
String jitter_y_name = "jitter_y" ; 
String jitter_z_name = "jitter_z" ;

String swing_x_name = "swing_x" ; 
String swing_y_name = "swing_y" ; 
String swing_z_name = "swing_z";

String quantity_name = "quantity" ; 
String variety_name = "variety"; 

String life_name = "life" ; 
String flow_name = "flow" ; 
String quality_name = "quality";

String area_name = "area" ; 
String angle_name = "angle" ; 
String scope_name = "scope" ; 
String scan_name = "scan" ;

String alignment_name = "alignment" ; 
String repulsion_name = "repulsion" ; 
String attraction_name = "attraction" ; 
String density_name = "density" ;

String influence_name = "influence" ; 
String calm_name = "calm" ; 
String spectrum_name = "spectrum" ;

String [] bitmap_path_ref, svg_path_ref, movie_path_ref;

int [] soundButton, actionButton, parameterButton;
boolean [] show_item, sound, action, parameter;

int mode [];

//BUTTON
int [] value_button_item;

//position
Vec3 [] pos_item_final;
Vec3 [] pos_item;
Vec3 [] pos_item_ref;

// costume
int [] costume;

// direction
boolean [] reset_camera_direction_item;
Vec3 [] temp_item_canvas_direction;
Vec3 [] dir_item;
Vec3 [] dir_item_final;
Vec3 [] dir_item_ref;

// master and follower
int [] master_ID ;
boolean [] follower ;
//setting and save
int NUM_SETTING_CAMERA  ;
int numSettingOrientationObject = 1 ;
Vec3 [][] item_setting_position ;
Vec3 [][] item_setting_direction ;
Vec3 [] eyeCameraSetting, sceneCameraSetting ;

//position of object and wheel
Vec3 [] mouse, pen ;
boolean [] clickShortLeft, clickShortRight, clickLongLeft, clickLongRight;
int wheel[] ;


//boolean object
boolean [] birth, colour, dimension, horizon, motion, orbit, reverse, special, wire;
boolean [] fill_is, stroke_is ;
boolean [] setting, clearList ;

//font
int numFont = 50 ;
String [] path_font_library, path_font_item ;
String path_font_default_ttf ;
PFont font_library ;
PFont [] font_item ;














//MISC
//var to init the data of the object when is switch ON for the first time
boolean [] init_value_mouse, init_value_controller ;
//parameter for the super class
float [] left, right, mix ;
//beat
float [] beat, kick, snare, hat ;
// spectrum
float band[][] ;
//tempo
float [] tempo, tempoBeat, tempoKick, tempoSnare, tempoHat ;
























/**
CREATE VAR 
v 1.1.0
*/
void create_variable() {
  NUM_ITEM = rpe_manager.size();
  NUM_ITEM_PLUS_MASTER = NUM_ITEM +1;

  NUM_SETTING_ITEM = 1;
  NUM_SETTING_CAMERA = 1;

  createMiscVar();
  create_variableButton();
  create_variableSound();

  create_variable_P3D(NUM_SETTING_CAMERA);
  create_variableCursor();
  create_var_item_slider();
  create_var_item_manipulation(NUM_SETTING_ITEM);

  println("variables setup done");
}

// misc var
void createMiscVar() {
  objectLeapID = new int[NUM_ITEM_PLUS_MASTER];
  item_info_display = new boolean[NUM_ITEM_PLUS_MASTER];

  setting = new boolean [NUM_ITEM_PLUS_MASTER];
  // boolean clear
  clearList = new boolean[NUM_ITEM_PLUS_MASTER];
  // boolean action from keyboard
  birth = new boolean[NUM_ITEM_PLUS_MASTER];
  colour = new boolean [NUM_ITEM_PLUS_MASTER];
  dimension = new boolean [NUM_ITEM_PLUS_MASTER];
  horizon = new boolean [NUM_ITEM_PLUS_MASTER];
  motion = new boolean [NUM_ITEM_PLUS_MASTER];
  orbit = new boolean [NUM_ITEM_PLUS_MASTER];
  reverse = new boolean [NUM_ITEM_PLUS_MASTER];
  special = new boolean [NUM_ITEM_PLUS_MASTER];
  wire = new boolean [NUM_ITEM_PLUS_MASTER];

  fill_is = new boolean[NUM_ITEM_PLUS_MASTER];
  stroke_is = new boolean[NUM_ITEM_PLUS_MASTER];

  // costume
  costume = new int[NUM_ITEM_PLUS_MASTER];

  // IMAGE
  bitmap_import = new PImage[NUM_ITEM_PLUS_MASTER];
  which_bitmap = new int[NUM_ITEM_PLUS_MASTER];
  bitmap_path_ref = new String[NUM_ITEM_PLUS_MASTER];
  // SVG
  svg_import = new ROPE_svg[NUM_ITEM_PLUS_MASTER];
  which_shape = new int[NUM_ITEM_PLUS_MASTER];
  svg_path_ref = new String[NUM_ITEM_PLUS_MASTER];

  // Movie
  movieImport = new Movie[NUM_ITEM_PLUS_MASTER];
  movieImportPath = new String[NUM_ITEM_PLUS_MASTER];
  which_movie = new int[NUM_ITEM_PLUS_MASTER];
  movie_path_ref = new String[NUM_ITEM_PLUS_MASTER];
  // TEXT
  text_import = new String [NUM_ITEM_PLUS_MASTER];
  which_text = new int[NUM_ITEM_PLUS_MASTER];
  //main font for each object
  // font = new PFont[NUM_ITEM_PLUS_MASTER] ;
  /*
  path_font_item_TTF = new String[NUM_ITEM_PLUS_MASTER] ;
  path_font_TTF = new String [numFont] ;  
  pathFontVLW = new String [numFont] ;
  */ 

  path_font_library = new String[numFont];
  path_font_item = new String[NUM_ITEM_PLUS_MASTER];

  font_item = new PFont[NUM_ITEM_PLUS_MASTER];

  //MISC
  //var to init the data of the object when is switch ON for the first time
  init_value_mouse = new boolean [NUM_ITEM_PLUS_MASTER];
  init_value_controller = new boolean [NUM_ITEM_PLUS_MASTER];
}





// var cursor
void create_variableCursor() {
  //position of object and wheel
   mouse  = new Vec3[NUM_ITEM_PLUS_MASTER];
   clickShortLeft = new boolean [NUM_ITEM_PLUS_MASTER];
   clickShortRight = new boolean [NUM_ITEM_PLUS_MASTER];
   clickLongLeft = new boolean [NUM_ITEM_PLUS_MASTER];
   clickLongRight = new boolean [NUM_ITEM_PLUS_MASTER];
   wheel = new int [NUM_ITEM_PLUS_MASTER];
  //pen info
   pen = new Vec3[NUM_ITEM_PLUS_MASTER];
}




// P3D
void create_variable_P3D(int num_setting_camera) {
   // setting and save
   eyeCameraSetting = new Vec3 [num_setting_camera];
   sceneCameraSetting = new Vec3 [num_setting_camera];
   
   reset_camera_direction_item = new boolean[NUM_ITEM_PLUS_MASTER];
   pos_item_ref = new Vec3[NUM_ITEM_PLUS_MASTER];
   pos_item = new Vec3[NUM_ITEM_PLUS_MASTER];
   dir_item = new Vec3[NUM_ITEM_PLUS_MASTER];
}

void create_variableSound() {
  // volume 
   left = new float [NUM_ITEM_PLUS_MASTER];
   right = new float [NUM_ITEM_PLUS_MASTER];
   mix  = new float [NUM_ITEM_PLUS_MASTER];
   // beat
   beat  = new float [NUM_ITEM_PLUS_MASTER];
   kick  = new float [NUM_ITEM_PLUS_MASTER];
   snare  = new float [NUM_ITEM_PLUS_MASTER];
   hat  = new float [NUM_ITEM_PLUS_MASTER];
   // spectrum
   band = new float [NUM_ITEM_PLUS_MASTER][NUM_BANDS];
   // tempo
   tempo = new float [NUM_ITEM_PLUS_MASTER];
   tempoBeat = new float [NUM_ITEM_PLUS_MASTER];
   tempoKick = new float [NUM_ITEM_PLUS_MASTER];
   tempoSnare = new float [NUM_ITEM_PLUS_MASTER];
   tempoHat = new float [NUM_ITEM_PLUS_MASTER];
}
//

//
void create_variableButton() {
  // objectButton = new int [NUM_ITEM_PLUS_MASTER];
  soundButton = new int [NUM_ITEM_PLUS_MASTER];
  actionButton = new int [NUM_ITEM_PLUS_MASTER];
  parameterButton = new int [NUM_ITEM_PLUS_MASTER];
  
  
  show_item = new boolean [NUM_ITEM_PLUS_MASTER];
  sound = new boolean [NUM_ITEM_PLUS_MASTER];
  action = new boolean [NUM_ITEM_PLUS_MASTER];
  parameter = new boolean [NUM_ITEM_PLUS_MASTER];
  mode = new int [NUM_ITEM_PLUS_MASTER];
  
/*
  show_item = new boolean [NUM_ITEM];
  sound = new boolean [NUM_ITEM];
  action = new boolean [NUM_ITEM];
  parameter = new boolean [NUM_ITEM];
  mode = new int [NUM_ITEM];
  */
  
  // you must init this var, because we launch this part of code before the controller. And if we don't init the value is NaN and return an error.
  // valueButtonGlobal = new int[numButtonGlobal] ;
  button_general_is = new boolean[NUM_BUTTON_GENERAL];
  //value_button_item = new int[button_item_num];

}


void create_var_item_manipulation(int num_item_setting) {
  pos_item_final = new Vec3 [NUM_ITEM_PLUS_MASTER] ;
  item_setting_position = new Vec3 [num_item_setting] [NUM_ITEM_PLUS_MASTER];

  dir_item_final = new Vec3 [NUM_ITEM_PLUS_MASTER];
  dir_item_ref = new Vec3 [NUM_ITEM_PLUS_MASTER];
  temp_item_canvas_direction = new Vec3 [NUM_ITEM_PLUS_MASTER];
  item_setting_direction = new Vec3 [num_item_setting] [NUM_ITEM_PLUS_MASTER];

  // master and follower
  master_ID = new int[NUM_ITEM_PLUS_MASTER];
  follower = new boolean[NUM_ITEM_PLUS_MASTER];
}  

void create_var_item_slider() {
  first_opening_item = new boolean[NUM_ITEM_PLUS_MASTER] ; // used to check if this object is already opening before
  fill_item = new color[NUM_ITEM_PLUS_MASTER];
  stroke_item = new color[NUM_ITEM_PLUS_MASTER];
  // column 2
  thickness_item = new float[NUM_ITEM_PLUS_MASTER]; 

  size_x_item = new float[NUM_ITEM_PLUS_MASTER]; 
  size_y_item = new float[NUM_ITEM_PLUS_MASTER]; 
  size_z_item = new float[NUM_ITEM_PLUS_MASTER];

  font_size_item = new float[NUM_ITEM_PLUS_MASTER];

  canvas_x_item = new float[NUM_ITEM_PLUS_MASTER]; 
  canvas_y_item = new float[NUM_ITEM_PLUS_MASTER]; 
  canvas_z_item = new float[NUM_ITEM_PLUS_MASTER];

   //column 3
  reactivity_item = new float[NUM_ITEM_PLUS_MASTER];

  speed_x_item = new float[NUM_ITEM_PLUS_MASTER]; 
  speed_y_item = new float[NUM_ITEM_PLUS_MASTER];
  speed_z_item = new float[NUM_ITEM_PLUS_MASTER];

  spurt_x_item = new float[NUM_ITEM_PLUS_MASTER]; 
  spurt_y_item = new float[NUM_ITEM_PLUS_MASTER];
  spurt_z_item = new float[NUM_ITEM_PLUS_MASTER];

  dir_x_item = new float[NUM_ITEM_PLUS_MASTER]; 
  dir_y_item = new float[NUM_ITEM_PLUS_MASTER];
  dir_z_item = new float[NUM_ITEM_PLUS_MASTER];

  jitter_x_item = new float[NUM_ITEM_PLUS_MASTER]; 
  jitter_y_item = new float[NUM_ITEM_PLUS_MASTER];
  jitter_z_item = new float[NUM_ITEM_PLUS_MASTER];

  swing_x_item = new float[NUM_ITEM_PLUS_MASTER]; 
  swing_y_item = new float[NUM_ITEM_PLUS_MASTER];
  swing_z_item = new float[NUM_ITEM_PLUS_MASTER];

  quantity_item = new float[NUM_ITEM_PLUS_MASTER]; 
  variety_item = new float[NUM_ITEM_PLUS_MASTER]; 

  life_item = new float[NUM_ITEM_PLUS_MASTER];
  flow_item = new float[NUM_ITEM_PLUS_MASTER];
  quality_item = new float[NUM_ITEM_PLUS_MASTER];

  area_item = new float[NUM_ITEM_PLUS_MASTER];
  angle_item = new float[NUM_ITEM_PLUS_MASTER];
  scope_item = new float[NUM_ITEM_PLUS_MASTER];
  scan_item = new float[NUM_ITEM_PLUS_MASTER];

  alignment_item = new float[NUM_ITEM_PLUS_MASTER];
  repulsion_item = new float[NUM_ITEM_PLUS_MASTER];
  attraction_item = new float[NUM_ITEM_PLUS_MASTER];
  density_item = new float[NUM_ITEM_PLUS_MASTER];

  influence_item = new float[NUM_ITEM_PLUS_MASTER];
  calm_item = new float[NUM_ITEM_PLUS_MASTER];
  spectrum_item = new float[NUM_ITEM_PLUS_MASTER];
}





























/**
INIT VAR 
v 1.1.0
*/
void init_variable_item_min_max() {
  float min_size = .1 ;
  float super_min_size = .01 ;
  float factor_area = TAU ;
  float max = width ;

  fill_hue_min_max = Vec2(0,360) ; // data from controller value 0 - 360
  fill_sat_min_max = Vec2(0,HSBmode.g) ;     
  fill_bright_min_max = Vec2(0,HSBmode.b) ;     
  fill_alpha_min_max = Vec2(0,HSBmode.a) ;

  stroke_hue_min_max = Vec2(0,360) ; // data from controller value 0 - 360
  stroke_sat_min_max = Vec2(0,HSBmode.g) ; 
  stroke_bright_min_max = Vec2(0,HSBmode.b); 
  stroke_alpha_min_max = Vec2(0,HSBmode.a) ;

  thickness_min_max = Vec2(min_size, max *super_min_size) ; 

  size_x_min_max = Vec2(max *super_min_size, max) ;     
  size_y_min_max = Vec2(max *super_min_size, max) ;     
  size_z_min_max = Vec2(max *super_min_size, max) ;

  font_size_min_max = Vec2(max *super_min_size, max);

  canvas_x_min_max = Vec2(max *min_size, max *factor_area) ; 
  canvas_y_min_max = Vec2(max *min_size, max *factor_area) ; 
  canvas_z_min_max = Vec2(max *min_size, max *factor_area) ;

  reactivity_min_max = Vec2(0,1) ;

  speed_x_min_max = Vec2(0,1) ; 
  speed_y_min_max = Vec2(0,1) ; 
  speed_z_min_max = Vec2(0,1) ;

  spurt_x_min_max = Vec2(0,1) ; 
  spurt_y_min_max = Vec2(0,1) ; 
  spurt_z_min_max = Vec2(0,1) ;

  dir_x_min_max = Vec2(0,360) ; // data from controller value 0 - 360 
  dir_y_min_max = Vec2(0,360) ; //  data from controller value 0 - 360
  dir_z_min_max = Vec2(0,360) ; // data from controller value 0 - 360

  jitter_x_min_max = Vec2(0,1) ; 
  jitter_y_min_max = Vec2(0,1) ; 
  jitter_z_min_max = Vec2(0,1) ;

  swing_x_min_max = Vec2(0,1) ; 
  swing_y_min_max = Vec2(0,1) ; 
  swing_z_min_max = Vec2(0,1) ;

  quantity_min_max = Vec2(0,1) ; 
  variety_min_max = Vec2(0,1) ; 

  life_min_max = Vec2(0,1) ; 
  flow_min_max = Vec2(0,1) ; 
  quality_min_max = Vec2(0,1) ;

  area_min_max = Vec2(max *min_size, max *factor_area) ; 
  angle_min_max = Vec2(0,360) ;  // data from controller value 0 - 360
  scope_min_max = Vec2(max *min_size, max *factor_area) ; 
  scan_min_max = Vec2(0,360) ; // data from controller value 0 - 360

  alignment_min_max = Vec2(0,1) ; 
  repulsion_min_max = Vec2(0,1) ; 
  attraction_min_max = Vec2(0,1) ; 
  density_min_max = Vec2(0,1) ;

  influence_min_max = Vec2(0,1) ; 
  calm_min_max = Vec2(0,1) ; 
  spectrum_min_max = Vec2(0,360) ;
}


// init var item
void init_variable_item() {
  for (int i = 0 ; i < NUM_ITEM_PLUS_MASTER ; i++ ) {
    // display boolean 
    fill_is[i] = true ;
    stroke_is[i] = true ;
    wire[i] = true ;
    // master follower
    master_ID[i] = 0 ;
    follower[i] = false ;

    reset_camera_direction_item[i] = true ;
    temp_item_canvas_direction[i] = Vec3() ;
    pen[i] = Vec3() ;
    // use the 250 value for "z" to keep the position light on the front
    mouse[i] = Vec3() ;
    wheel[i] = 0 ;

    // costume 
    costume[i] = POINT_ROPE ;
    // init slider var item except fill and stroke
    thickness_item [i] =1. ; 

    size_x_item [i] = (float)width *.05 ; 
    size_y_item [i] = (float)width *.05 ; 
    size_z_item [i] = (float)width *.05 ;

    font_size_item [i] = 10 ;

    canvas_x_item [i] = width ; 
    canvas_y_item [i] = width ; 
    canvas_z_item [i] = width ;

    reactivity_item[i] = 0 ;

    speed_x_item [i] = 0 ; 
    speed_y_item [i] = 0 ; 
    speed_z_item [i] = 0 ;

    spurt_x_item [i] = 0 ; 
    spurt_y_item [i] = 0 ; 
    spurt_z_item [i] = 0 ; 

    dir_x_item [i] = 0 ; 
    dir_y_item [i] = 0 ; 
    dir_z_item [i] = 0 ; 

    jitter_x_item [i] = 0 ; 
    jitter_y_item [i] = 0 ; 
    jitter_z_item [i] = 0 ; 

    swing_x_item [i] = 0 ; 
    swing_y_item [i] = 0 ; 
    swing_z_item [i] = 0 ; 

    quantity_item [i] = .1 ; 

    variety_item [i] = 0 ; 

    life_item [i] = .1 ;
    flow_item [i] = 0 ; 
    quality_item [i] = .1 ;

    area_item [i] = width ; 
    angle_item [i] = 0 ; 
    scope_item [i] = width ;
    scan_item [i] = 90 ; 

    alignment_item [i] = 0 ; 
    repulsion_item [i] = 0 ;  
    attraction_item [i] = 0 ; 
    density_item [i] = 0 ; 

    influence_item [i] = 0 ; 
    calm_item [i] = 0 ; 
    spectrum_item [i] = 0 ; 
  }
    // init global var for the color obj preview mode display
  COLOR_FILL_OBJ_PREVIEW = color (0,0,100,30) ; 
  COLOR_STROKE_OBJ_PREVIEW = color (0,0,100,30) ;
}



void init_items() {
  rpe_manager.init_items() ;
}















/**
button general var setting
*/
boolean beat_is() {
  return beat_is;
}

boolean kick_is() {
  return kick_is;
}

boolean snare_is() {
  return snare_is;
}

boolean hat_is() {
  return hat_is;
}

boolean curtain_is() {
  return curtain_is;
}

boolean background_is() {
  return background_is;
}

boolean light_ambient_is() {
  return ambient_is;
}

boolean light_1_is() {
  return light_1_is;
}

boolean light_2_is() {
  return light_2_is;
}

boolean light_ambient_action_is() {
  return ambient_action_is;
}

boolean light_1_action_is() {
  return light_1_action_is;
}

boolean light_2_action_is() {
  return light_2_action_is;
}

void beat_is(boolean is) {
  beat_is = is;
}

void kick_is(boolean is) {
  kick_is = is;
}

void snare_is(boolean is) {
  snare_is = is;
}

void hat_is(boolean is) {
  hat_is = is;
}

void curtain_is(boolean is) {
  curtain_is = is;
}

void background_is(boolean is) {
  background_is = is;
}

void light_ambient_is(boolean is) {
  ambient_is = is;
}

void light_1_is(boolean is) {
  light_1_is = is;
}

void light_2_is(boolean is) {
  light_2_is = is;
}

void light_ambient_action_is(boolean is) {
  ambient_action_is = is;
}

void light_1_action_is(boolean is) {
  light_1_action_is = is;
}

void light_2_action_is(boolean is) {
  light_2_action_is = is;
}



















/**
UPDATE DATA from CONTROLER and PRESCENE
Those value are used to updated the object data value, and updated at the end of the loop the temp value
*/
void update_raw_value() {
   int minSource = 0 ;
   int smooth_slider = 2 ;
  // fill
  fill_hue_raw = (int)map(value_slider_item[0], minSource, MAX_VALUE_SLIDER, fill_hue_min_max.x, fill_hue_min_max.y);
  fill_sat_raw = (int)map(value_slider_item[1], minSource, MAX_VALUE_SLIDER, fill_sat_min_max.x, fill_sat_min_max.y);    
  fill_bright_raw = (int)map(value_slider_item[2], minSource, MAX_VALUE_SLIDER, fill_bright_min_max.x, fill_bright_min_max.y) ;   
  fill_alpha_raw = (int)map(value_slider_item[3], minSource, MAX_VALUE_SLIDER, fill_alpha_min_max.x, fill_alpha_min_max.y);
  // stroke
  stroke_hue_raw = (int)map(value_slider_item[4], minSource, MAX_VALUE_SLIDER, stroke_hue_min_max.x,stroke_hue_min_max.y);   
  stroke_sat_raw = (int)map(value_slider_item[5], minSource, MAX_VALUE_SLIDER, stroke_sat_min_max.x,stroke_sat_min_max.y);  
  stroke_bright_raw = (int)map(value_slider_item[6], minSource, MAX_VALUE_SLIDER, stroke_bright_min_max.x, stroke_bright_min_max.y) ; 
  stroke_alpha_raw = (int)map(value_slider_item[7], minSource, MAX_VALUE_SLIDER, stroke_alpha_min_max.x, stroke_alpha_min_max.y);
  // 
  thickness_raw = map_smooth_start(value_slider_item[8], minSource, MAX_VALUE_SLIDER, thickness_min_max.x, thickness_min_max.y, smooth_slider) ;
  // size
  size_x_raw = map_smooth_start(value_slider_item[9], minSource, MAX_VALUE_SLIDER, size_x_min_max.x, size_x_min_max.y, smooth_slider) ;
  size_y_raw = map_smooth_start(value_slider_item[10], minSource, MAX_VALUE_SLIDER, size_y_min_max.x, size_y_min_max.y, smooth_slider) ;
  size_z_raw = map_smooth_start(value_slider_item[11], minSource, MAX_VALUE_SLIDER, size_z_min_max.x, size_z_min_max.y, smooth_slider) ;
  // size font
  font_size_raw = map(value_slider_item[12], minSource, MAX_VALUE_SLIDER, font_size_min_max.x, font_size_min_max.y) ;
  // canvas
  canvas_x_raw = map_smooth_start(value_slider_item[13], minSource, MAX_VALUE_SLIDER, canvas_x_min_max.x, canvas_x_min_max.y, smooth_slider) ;
  canvas_y_raw = map_smooth_start(value_slider_item[14], minSource, MAX_VALUE_SLIDER, canvas_y_min_max.x, canvas_y_min_max.y, smooth_slider) ;
  canvas_z_raw = map_smooth_start(value_slider_item[15], minSource, MAX_VALUE_SLIDER, canvas_z_min_max.x, canvas_z_min_max.y, smooth_slider) ;

  // size font
  reactivity_raw = map(value_slider_item[16], minSource, MAX_VALUE_SLIDER, reactivity_min_max.x, reactivity_min_max.y) ;
  // speed
  speed_x_raw = map(value_slider_item[17], minSource, MAX_VALUE_SLIDER, speed_x_min_max.x, speed_x_min_max.y) ;
  speed_y_raw = map(value_slider_item[18], minSource, MAX_VALUE_SLIDER, speed_y_min_max.x, speed_y_min_max.y) ;
  speed_z_raw = map(value_slider_item[19], minSource, MAX_VALUE_SLIDER, speed_z_min_max.x, speed_z_min_max.y) ;
  // spurt
  spurt_x_raw = map(value_slider_item[20], minSource, MAX_VALUE_SLIDER, spurt_x_min_max.x, spurt_x_min_max.y) ;
  spurt_y_raw = map(value_slider_item[21], minSource, MAX_VALUE_SLIDER, spurt_y_min_max.x, spurt_y_min_max.y) ;
  spurt_z_raw = map(value_slider_item[22], minSource, MAX_VALUE_SLIDER, spurt_z_min_max.x, spurt_z_min_max.y) ;
  // direction
  dir_x_raw = map(value_slider_item[23], minSource, MAX_VALUE_SLIDER, dir_x_min_max.x, dir_x_min_max.y) ;
  dir_y_raw = map(value_slider_item[24], minSource, MAX_VALUE_SLIDER, dir_y_min_max.x, dir_y_min_max.y) ;
  dir_z_raw = map(value_slider_item[25], minSource, MAX_VALUE_SLIDER, dir_z_min_max.x, dir_z_min_max.y) ;
  // jitter
  jitter_x_raw = map(value_slider_item[26], minSource, MAX_VALUE_SLIDER, jitter_x_min_max.x, jitter_x_min_max.y) ;
  jitter_y_raw = map(value_slider_item[27], minSource, MAX_VALUE_SLIDER, jitter_y_min_max.x, jitter_y_min_max.y) ;
  jitter_z_raw = map(value_slider_item[28], minSource, MAX_VALUE_SLIDER, jitter_z_min_max.x, jitter_z_min_max.y) ;
  // spurt
  swing_x_raw = map(value_slider_item[29], minSource, MAX_VALUE_SLIDER, swing_x_min_max.x, swing_x_min_max.y) ;
  swing_y_raw = map(value_slider_item[30], minSource, MAX_VALUE_SLIDER, swing_y_min_max.x, swing_y_min_max.y) ;
  swing_z_raw = map(value_slider_item[31], minSource, MAX_VALUE_SLIDER, swing_z_min_max.x, swing_z_min_max.y) ;

  // misc
  quantity_raw = map(value_slider_item[32], minSource, MAX_VALUE_SLIDER, quantity_min_max.x, quantity_min_max.y) ;
  variety_raw = map(value_slider_item[33], minSource, MAX_VALUE_SLIDER, variety_min_max.x, variety_min_max.y) ;
  // bio
  life_raw = map(value_slider_item[34], minSource, MAX_VALUE_SLIDER, life_min_max.x, life_min_max.y) ;
  flow_raw = map(value_slider_item[35], minSource, MAX_VALUE_SLIDER, flow_min_max.x, flow_min_max.y) ;
  quality_raw = map(value_slider_item[36], minSource, MAX_VALUE_SLIDER, quality_min_max.x, quality_min_max.y) ;
  // radar
  area_raw = map_smooth_start(value_slider_item[37], minSource, MAX_VALUE_SLIDER, area_min_max.x, area_min_max.y, smooth_slider) ;
  angle_raw = map(value_slider_item[38], minSource, MAX_VALUE_SLIDER, angle_min_max.x, angle_min_max.y) ;
  scope_raw = map(value_slider_item[39], minSource, MAX_VALUE_SLIDER, scope_min_max.x, scope_min_max.y) ;
  scan_raw = map(value_slider_item[40], minSource, MAX_VALUE_SLIDER, scan_min_max.x, scan_min_max.y) ;

  // force or behavior
  alignment_raw = map(value_slider_item[41], minSource, MAX_VALUE_SLIDER, alignment_min_max.x, alignment_min_max.y) ;
  repulsion_raw = map(value_slider_item[42], minSource, MAX_VALUE_SLIDER, repulsion_min_max.x, repulsion_min_max.y) ;
  attraction_raw = map(value_slider_item[43], minSource, MAX_VALUE_SLIDER, attraction_min_max.x, attraction_min_max.y) ;
  density_raw = map(value_slider_item[44], minSource, MAX_VALUE_SLIDER, density_min_max.x, density_min_max.y) ;


  influence_raw = map(value_slider_item[45], minSource, MAX_VALUE_SLIDER, influence_min_max.x, influence_min_max.y) ;
  calm_raw = map(value_slider_item[46], minSource, MAX_VALUE_SLIDER, calm_min_max.x, calm_min_max.y) ;
  spectrum_raw = map(value_slider_item[47], minSource, MAX_VALUE_SLIDER, spectrum_min_max.x, spectrum_min_max.y) ; 

}


/* Those temp value are used to know is the object value must be updated */
void update_temp_value() {
  // fill
  fill_hue_temp = fill_hue_raw ;
  fill_sat_temp = fill_sat_raw ;    
  fill_bright_temp = fill_bright_raw ;   
  fill_alpha_temp = fill_alpha_raw ;
  // stroke
  stroke_hue_temp = stroke_hue_raw ; 
  stroke_sat_temp = stroke_sat_raw ;  
  stroke_bright_temp = stroke_bright_raw ; 
  stroke_alpha_temp = stroke_alpha_raw ;
  //
  thickness_temp= thickness_raw ;
  //size
  size_x_temp = size_x_raw ;
  size_y_temp = size_y_raw ;
  size_z_temp = size_z_raw ;
  // font size
  font_size_temp = font_size_raw ;
  // canvas
  canvas_x_temp = canvas_x_raw ;
  canvas_y_temp = canvas_y_raw ;
  canvas_z_temp = canvas_z_raw ;
  // misc
  reactivity_temp = reactivity_raw ;
  // speed
  speed_x_temp = speed_x_raw ;
  speed_y_temp = speed_y_raw ;
  speed_z_temp = speed_z_raw ;
  // spurt
  spurt_x_temp = spurt_x_raw ;
  spurt_y_temp = spurt_y_raw ;
  spurt_z_temp = spurt_z_raw ;
  // direction
  dir_x_temp = dir_x_raw ;
  dir_y_temp = dir_y_raw ;
  dir_z_temp = dir_z_raw ;
  // jitter
  jitter_x_temp = jitter_x_raw ;
  jitter_y_temp = jitter_y_raw ;
  jitter_z_temp = jitter_z_raw ;
  // direction
  swing_x_temp = swing_x_raw ;
  swing_y_temp = swing_y_raw ;
  swing_z_temp = swing_z_raw ;

  quantity_temp = quantity_raw ;
  variety_temp = variety_raw ;

  life_temp = life_raw ;
  flow_temp = flow_raw ;
  quality_temp = quality_raw ;

  area_temp = area_raw ;
  angle_temp = angle_raw ;
  scope_temp = scope_raw ;
  scan_temp = scan_raw ;
  // force
  alignment_temp = alignment_raw ;
  repulsion_temp = repulsion_raw ;
  attraction_temp = attraction_raw ;
  density_temp = density_raw ;

  influence_temp = influence_raw ;
  calm_temp = calm_raw ;
  spectrum_temp = spectrum_raw ;
}


//SHORTCUT VAR
//SOUND
float allBeats(int ID) {
  return (beat[ID]*.25) +(kick[ID]*.25) +(hat[ID]*.25) +(snare[ID]*.25) ;
}

