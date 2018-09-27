/**
VARIABLE
Prescene, Scene
Romanesco Processing Environment
2015-2018
v 1.6.2
*/

/** 
SCENE VARIABLE
*/
/**
Variable_Scene
2014_2018
v 0.1.2
*/
boolean scene, prescene;
boolean miroir_on_off = false ;

boolean check_size = false ;


// In the Miroir and Scene sketch presceneOnly must be true for the final work.
Boolean internet = true ;
String bigBrother = ("BIG BROTHER DON'T WATCHING YOU !!") ;

//init var
//GLOBAL
void scene_variables_setup() {
  for (int i = 0 ; i < data_osc_prescene.length ; i++) {
    data_osc_prescene[i] = ("0");
  }
  
  for (int i = 0 ; i < NUM_ITEM ; i++ ) {
    pen[i] = Vec3() ;
    mouse[i] = Vec3() ;
    wheel[i] = 0 ;
  }
  println("Scene variables setup done") ;
}
















/**
GLOBAL VARIABLE
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


boolean OPEN_APP = false;
// WINDOW VAR
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


// BOOLEAN COMMAND
// command from leap motion, mouse or other devices if we code for that :)
boolean ORDER, ORDER_ONE, ORDER_TWO, ORDER_THREE ;
boolean LEAPMOTION_DETECTED ;


// SAVE SCENE
boolean load_Scene_Setting_local, save_Current_Scene_Setting_local, save_New_Scene_Setting_local;
boolean load_SCENE_Setting_order_from_presecene, save_Current_SCENE_Setting_order_from_presecene, save_New_SCENE_Setting_order_from_presecene ;
boolean load_SCENE_Setting_GLOBAL, save_Current_SCENE_Setting_GLOBAL, save_New_SCENE_Setting_GLOBAL;


//spectrum band
int NUM_BANDS = 128;

int button_item_num  ; 
// VAR item
int COLOR_FILL_ITEM_PREVIEW; 
int COLOR_STROKE_ITEM_PREVIEW;
int THICKNESS_ITEM_PREVIEW = 2;
int NUM_ITEM;
int NUM_ITEM_PLUS_MASTER;
int NUM_SETTING_ITEM;
int BUTTON_ITEM_CONSOLE = 4;


// button
boolean [] transient_button_is;
boolean [] fx_button_is = new boolean[NUM_BUTTON_FX];
boolean curtain_button_is;
boolean reset_camera_button_is;
boolean reset_item_on_button_is;
boolean birth_button_is;
boolean dimension_button_is;
boolean background_button_is;
boolean ambient_button_is,ambient_action_is;
boolean light_1_button_is,light_1_action_button_is;
boolean light_2_button_is,light_2_action_button_is;

int which_shader;
int which_filter; 
int [] which_bitmap, which_text, which_shape, which_movie;


//SLIDER
// becareful if the number of MISC SLIDERS is upper than OBJ SLIDER, that can be a problem in the future.
float value_slider_background [] = new float [NUM_MOLETTE_BACKGROUND];
float value_slider_fx [] = new float [NUM_MOLETTE_FX];
float value_slider_light [] = new float [NUM_MOLETTE_LIGHT];
float value_slider_sound [] = new float [NUM_MOLETTE_SOUND];
float value_slider_sound_setting [] = new float [NUM_MOLETTE_SOUND_SETTING];
float value_slider_camera [] = new float [NUM_MOLETTE_CAMERA];
float value_slider_item []  = new float [NUM_MOLETTE_ITEM];






/**
Var item
*/
Table index_item ;
TableRow [] row_index_item ;
//MISC var
//info object
String [] item_info, item_name, item_author, item_version, item_pack ;
int [] item_ID ;
boolean [] item_info_display ;
//for the leap motion ?
int objectLeapID[] ;
//BUTTON CONTROLER
boolean objectParameter[] ;

//raw
int fill_hue_raw, fill_sat_raw, fill_bright_raw, fill_alpha_raw;
int stroke_hue_raw, stroke_sat_raw, stroke_bright_raw, stroke_alpha_raw;
float thickness_raw; 
float size_x_raw, size_y_raw, size_z_raw;
float canvas_x_raw, canvas_y_raw, canvas_z_raw;
float diameter_raw;

float frequence_raw;
float speed_x_raw, speed_y_raw, speed_z_raw;
float spurt_x_raw, spurt_y_raw, spurt_z_raw;
float dir_x_raw, dir_y_raw, dir_z_raw;
float jitter_x_raw, jitter_y_raw, jitter_z_raw;
float swing_x_raw, swing_y_raw, swing_z_raw;

float quantity_raw, variety_raw; 
float life_raw, flow_raw, quality_raw;

float area_raw, angle_raw, scope_raw, scan_raw;
float alignment_raw, repulsion_raw, attraction_raw, density_raw;

float influence_raw, calm_raw, spectrum_raw;

float grid_raw;
float viscosity_raw, diffusion_raw;




// MIN MAX MAP SLIDER
// col A
Vec2 fill_hue_min_max, fill_sat_min_max , fill_bright_min_max , fill_alpha_min_max;
Vec2 stroke_hue_min_max, stroke_sat_min_max, stroke_bright_min_max, stroke_alpha_min_max;
Vec2 thickness_min_max; 
Vec2 size_x_min_max, size_y_min_max, size_z_min_max;
Vec2 diameter_min_max;
Vec2 canvas_x_min_max, canvas_y_min_max, canvas_z_min_max;
// col B
Vec2 frequence_min_max;
Vec2 speed_x_min_max, speed_y_min_max, speed_z_min_max;
Vec2 spurt_x_min_max, spurt_y_min_max, spurt_z_min_max;
Vec2 dir_x_min_max, dir_y_min_max, dir_z_min_max; 
Vec2 jitter_x_min_max, jitter_y_min_max, jitter_z_min_max;
Vec2 swing_x_min_max, swing_y_min_max, swing_z_min_max;
// col C
Vec2 quantity_min_max, variety_min_max; 
Vec2 life_min_max, flow_min_max, quality_min_max;
Vec2 area_min_max, angle_min_max, scope_min_max, scan_min_max; 

Vec2 alignment_min_max, repulsion_min_max, attraction_min_max, density_min_max;
Vec2 influence_min_max, calm_min_max;
Vec2 spectrum_min_max;
// col D
Vec2 grid_min_max;
Vec2 viscosity_min_max,diffusion_min_max;




// temp
/* value used to know if the value slider have change or nor */
// col A
int fill_hue_temp, fill_sat_temp, fill_bright_temp, fill_alpha_temp;
int stroke_hue_temp, stroke_sat_temp, stroke_bright_temp, stroke_alpha_temp;
float thickness_temp; 
float size_x_temp, size_y_temp, size_z_temp;
float diameter_temp;
float canvas_x_temp, canvas_y_temp, canvas_z_temp;
// col B
float frequence_temp;
float speed_x_temp, speed_y_temp, speed_z_temp;
float spurt_x_temp, spurt_y_temp, spurt_z_temp;
float dir_x_temp, dir_y_temp,dir_z_temp;
float jitter_x_temp, jitter_y_temp, jitter_z_temp;
float swing_x_temp, swing_y_temp, swing_z_temp;
// col C
float quantity_temp, variety_temp;
float life_temp, flow_temp, quality_temp;
float area_temp, angle_temp, scope_temp, scan_temp;

float alignment_temp, repulsion_temp, attraction_temp, density_temp;
float influence_temp, calm_temp, spectrum_temp;
// col D
float grid_temp;
float viscosity_temp, diffusion_temp;




// item target final
boolean [] first_opening_item; // used to check if this object is already opening before
int [] fill_item, stroke_item;
float [] thickness_item; 
float [] size_x_item, size_y_item, size_z_item;
float [] diameter_item;
float [] canvas_x_item, canvas_y_item, canvas_z_item;

float [] frequence_item;
float [] speed_x_item, speed_y_item, speed_z_item;
float [] spurt_x_item, spurt_y_item, spurt_z_item;
float [] dir_x_item, dir_y_item, dir_z_item;
float [] jitter_x_item, jitter_y_item, jitter_z_item;
float [] swing_x_item, swing_y_item, swing_z_item;

float [] quantity_item, variety_item;
float [] life_item, flow_item, quality_item;

float [] area_item, angle_item, scope_item, scan_item;
float [] alignment_item, repulsion_item, attraction_item, density_item;
float [] influence_item, calm_item, spectrum_item;

float [] grid_item;
float [] viscosity_item,diffusion_item;

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

String diameter_name = "diameter";

String canvas_x_name = "canvas_x" ; 
String canvas_y_name = "canvas_y" ; 
String canvas_z_name = "canvas_z" ;

String frequence_name = "frequence" ;

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

String grid_name = "grid" ; 
String viscosity_name = "viscosity" ; 
String diffusion_name = "diffusion" ;

String [] bitmap_path_ref, svg_path_ref;
// movie_path_ref;

int [] soundButton, actionButton, parameterButton;
boolean [] show_item, sound, action, parameter;

int [] mode;
int [] costume_controller_selection;
int [] costume;


//BUTTON
int [] value_button_item;

//position
Vec3 [] pos_item_final;
Vec3 [] pos_item;
Vec3 [] pos_item_ref;


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
float [] left,right,mix ;
// transient
float [][] transient_value;
// float [] beat, kick, snare, hat ;
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

  create_var_misc();
  create_var_item_button();
  create_var_sound();

  create_var_P3D(NUM_SETTING_CAMERA);
  create_var_cursor();
  create_var_item_slider();
  create_var_item_manipulation(NUM_SETTING_ITEM);

  println("variables setup done");
}

// misc var
void create_var_misc() {
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
  bitmap = new PImage[NUM_ITEM_PLUS_MASTER];
  which_bitmap = new int[NUM_ITEM_PLUS_MASTER];
  bitmap_path_ref = new String[NUM_ITEM_PLUS_MASTER];
  // SVG
  svg_import = new ROPE_svg[NUM_ITEM_PLUS_MASTER];
  which_shape = new int[NUM_ITEM_PLUS_MASTER];
  svg_path_ref = new String[NUM_ITEM_PLUS_MASTER];

  // Movie
  movie = new Movie[NUM_ITEM_PLUS_MASTER];
  // moviePath = new String[NUM_ITEM_PLUS_MASTER];
  which_movie = new int[NUM_ITEM_PLUS_MASTER];
  //movie_path_ref = new String[NUM_ITEM_PLUS_MASTER];
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
void create_var_cursor() {
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
void create_var_P3D(int num_setting_camera) {
   // setting and save
   eyeCameraSetting = new Vec3 [num_setting_camera];
   sceneCameraSetting = new Vec3 [num_setting_camera];
   
   reset_camera_direction_item = new boolean[NUM_ITEM_PLUS_MASTER];
   pos_item_ref = new Vec3[NUM_ITEM_PLUS_MASTER];
   pos_item = new Vec3[NUM_ITEM_PLUS_MASTER];
   dir_item = new Vec3[NUM_ITEM_PLUS_MASTER];
}

void create_var_sound() {
  // volume 
   left = new float [NUM_ITEM_PLUS_MASTER];
   right = new float [NUM_ITEM_PLUS_MASTER];
   mix  = new float [NUM_ITEM_PLUS_MASTER];
   // transient
   transient_button_is = new boolean[5];
   transient_value = new float[5][NUM_ITEM_PLUS_MASTER]; // beat[ID_item]
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
void create_var_item_button() {
  show_item = new boolean [NUM_ITEM_PLUS_MASTER];
  sound = new boolean [NUM_ITEM_PLUS_MASTER];
  action = new boolean [NUM_ITEM_PLUS_MASTER];
  parameter = new boolean [NUM_ITEM_PLUS_MASTER];
  mode = new int [NUM_ITEM_PLUS_MASTER];
  costume_controller_selection = new int [NUM_ITEM_PLUS_MASTER];
  
  // you must init this var, because we launch this part of code before the controller. And if we don't init the value is NaN and return an error.
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

  diameter_item = new float[NUM_ITEM_PLUS_MASTER];

  canvas_x_item = new float[NUM_ITEM_PLUS_MASTER]; 
  canvas_y_item = new float[NUM_ITEM_PLUS_MASTER]; 
  canvas_z_item = new float[NUM_ITEM_PLUS_MASTER];

   //column 3
  frequence_item = new float[NUM_ITEM_PLUS_MASTER];

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

  grid_item = new float[NUM_ITEM_PLUS_MASTER];
  viscosity_item = new float[NUM_ITEM_PLUS_MASTER];
  diffusion_item = new float[NUM_ITEM_PLUS_MASTER];
}





























/**
INIT VAR 
v 1.1.2
*/
void init_variable_item_min_max() {

  float ratio_min_deci = .1;
  float ratio_min_centi = .01;
  float ratio_min_milli = .001;
  float ratio_max = TAU;

  float min_size = .1;
  float max_size = width;

  fill_hue_min_max = Vec2(0,360) ; // data from controller value 0 - 360
  fill_sat_min_max = Vec2(0,HSBmode.g);     
  fill_bright_min_max = Vec2(0,HSBmode.b);     
  fill_alpha_min_max = Vec2(0,HSBmode.a);

  stroke_hue_min_max = Vec2(0,360) ; // data from controller value 0 - 360
  stroke_sat_min_max = Vec2(0,HSBmode.g); 
  stroke_bright_min_max = Vec2(0,HSBmode.b); 
  stroke_alpha_min_max = Vec2(0,HSBmode.a);

  thickness_min_max = Vec2(min_size, max_size *ratio_min_centi); 

  size_x_min_max = Vec2(max_size *ratio_min_milli,max_size);     
  size_y_min_max = Vec2(max_size *ratio_min_milli,max_size);     
  size_z_min_max = Vec2(max_size *ratio_min_milli,max_size);

  diameter_min_max = Vec2(max_size *ratio_min_milli,max_size);

  canvas_x_min_max = Vec2(max_size *ratio_min_deci,max_size *ratio_max); 
  canvas_y_min_max = Vec2(max_size *ratio_min_deci,max_size *ratio_max); 
  canvas_z_min_max = Vec2(max_size *ratio_min_deci,max_size *ratio_max);

  frequence_min_max = Vec2(0,1);

  speed_x_min_max = Vec2(0,1); 
  speed_y_min_max = Vec2(0,1); 
  speed_z_min_max = Vec2(0,1);

  spurt_x_min_max = Vec2(0,1); 
  spurt_y_min_max = Vec2(0,1); 
  spurt_z_min_max = Vec2(0,1);

  dir_x_min_max = Vec2(0,360); // data from controller value 0 - 360 
  dir_y_min_max = Vec2(0,360); //  data from controller value 0 - 360
  dir_z_min_max = Vec2(0,360); // data from controller value 0 - 360

  jitter_x_min_max = Vec2(0,1); 
  jitter_y_min_max = Vec2(0,1); 
  jitter_z_min_max = Vec2(0,1);

  swing_x_min_max = Vec2(0,1); 
  swing_y_min_max = Vec2(0,1); 
  swing_z_min_max = Vec2(0,1);

  quantity_min_max = Vec2(0,1); 
  variety_min_max = Vec2(0,1); 

  life_min_max = Vec2(0,1); 
  flow_min_max = Vec2(0,1); 
  quality_min_max = Vec2(0,1);

  area_min_max = Vec2(max_size *ratio_min_deci, max_size *ratio_max); 
  angle_min_max = Vec2(0,360);  // data from controller value 0 - 360
  scope_min_max = Vec2(max_size *ratio_min_deci, max_size *ratio_max); 
  scan_min_max = Vec2(0,360); // data from controller value 0 - 360

  alignment_min_max = Vec2(0,1); 
  repulsion_min_max = Vec2(0,1); 
  attraction_min_max = Vec2(0,1); 
  density_min_max = Vec2(0,1);

  influence_min_max = Vec2(0,1); 
  calm_min_max = Vec2(0,1); 
  spectrum_min_max = Vec2(0,360);

  grid_min_max = Vec2(max_size *ratio_min_deci, max_size *ratio_max); 
  viscosity_min_max = Vec2(0,1); 
  diffusion_min_max = Vec2(01);
}


// init var item
void init_variable_item() {
  for (int i = 0 ; i < NUM_ITEM_PLUS_MASTER ; i++ ) {
    // display boolean 
    fill_is[i] = true;
    stroke_is[i] = true;
    wire[i] = true;
    // master follower
    master_ID[i] = 0;
    follower[i] = false;

    reset_camera_direction_item[i] = true;
    temp_item_canvas_direction[i] = Vec3();
    pen[i] = Vec3();
    // use the 250 value for "z" to keep the position light on the front
    mouse[i] = Vec3();
    wheel[i] = 0;

    // costume 
    costume[i] = POINT_ROPE;
    // init slider var item except fill and stroke
    thickness_item [i] =1.; 

    size_x_item [i] = (float)width *.05; 
    size_y_item [i] = (float)width *.05; 
    size_z_item [i] = (float)width *.05;

    size_x_item [i] = 10 ;

    canvas_x_item [i] = width; 
    canvas_y_item [i] = width; 
    canvas_z_item [i] = width;

    // COL B
    frequence_item[i] = 0;

    speed_x_item [i] = 0; 
    speed_y_item [i] = 0; 
    speed_z_item [i] = 0;

    spurt_x_item [i] = 0; 
    spurt_y_item [i] = 0; 
    spurt_z_item [i] = 0; 

    dir_x_item [i] = 0; 
    dir_y_item [i] = 0; 
    dir_z_item [i] = 0; 

    jitter_x_item [i] = 0; 
    jitter_y_item [i] = 0; 
    jitter_z_item [i] = 0; 

    swing_x_item [i] = 0; 
    swing_y_item [i] = 0; 
    swing_z_item [i] = 0; 
    
    // col C
    quantity_item [i] = .1; 
    variety_item [i] = 0; 

    life_item [i] = .1;
    flow_item [i] = 0; 
    quality_item [i] = .1;

    area_item [i] = width; 
    angle_item [i] = 0; 
    scope_item [i] = width;
    scan_item [i] = 90; 

    alignment_item [i] = 0; 
    repulsion_item [i] = 0;  
    attraction_item [i] = 0; 
    density_item [i] = 0; 

    influence_item [i] = 0; 
    calm_item [i] = 0; 
    spectrum_item [i] = 0; 
    // col D
    grid_item [i] = width; 
    viscosity_item [i] = 0; 
    diffusion_item [i] = 0; 
  }
    // init global var for the color obj preview mode display
  COLOR_FILL_ITEM_PREVIEW = color (0,0,100,30); 
  COLOR_STROKE_ITEM_PREVIEW = color (0,0,100,30);
}



boolean items_loaded_is() {
  return rpe_manager.init_items();
}


void init_slider_variable_world() {
  // value from 0 to 360
  // camera setting default before loading data
  value_slider_camera[0] = 100; // lens
  value_slider_camera[1] = 180;
  value_slider_camera[2] = 180;
  value_slider_camera[3] = 180;
  value_slider_camera[4] = 180;
  value_slider_camera[5] = 180;
  value_slider_camera[6] = 180;
  value_slider_camera[7] = 20; // speed rotation
  value_slider_camera[8] = 20; // speed move
  // background
  value_slider_background[0] = g.colorModeX;
  value_slider_background[1] = g.colorModeY;
  value_slider_background[2] = 0;
  value_slider_background[3] = g.colorModeA;

}















/**
button general var setting
*/

// general button
boolean curtain_button_is() {
  return curtain_button_is;
}

boolean reset_camera_button_is() {
  return reset_camera_button_is;
}

boolean reset_item_on_button_is() {
  return reset_item_on_button_is;
}

boolean birth_button_is() {
  return birth_button_is;
}

boolean dimension_button_is() {
  return dimension_button_is;
}

boolean background_button_is() {
  return background_button_is;
}


boolean ambient_button_is() {
  return ambient_button_is;
}

boolean light_1_button_is() {
  return light_1_button_is;
}

boolean light_2_button_is() {
  return light_2_button_is;
}

boolean ambient_action_button_is() {
  return ambient_action_is;
}

boolean light_1_action_button_is() {
  return light_1_action_button_is;
}

boolean light_2_action_button_is() {
  return light_2_action_button_is;
}

boolean transient_button_is(int index) {
  return transient_button_is[index];
}

boolean fx_button_is(int index) {
  return fx_button_is[index];
}


// set boolean


void curtain_button_is(boolean is) {
  curtain_button_is = is;
}

void reset_camera_button_is(boolean is) {
  reset_camera_button_is = is;
}

void reset_item_on_button_is(boolean is) {
  reset_item_on_button_is = is;
}

void birth_button_is(boolean is) {
  birth_button_is = is;
}

void dimension_button_is(boolean is) {
  dimension_button_is = is;
}

void background_button_is(boolean is) {
  background_button_is = is;
}

void ambient_button_is(boolean is) {
  ambient_button_is = is;
}

void light_1_button_is(boolean is) {
  light_1_button_is = is;
}

void light_2_button_is(boolean is) {
  light_2_button_is = is;
}

void ambient_action_button_is(boolean is) {
  ambient_action_is = is;
}

void light_1_action_button_is(boolean is) {
  light_1_action_button_is = is;
}

void light_2_action_button_is(boolean is) {
  light_2_action_button_is = is;
}


void transient_button_is(int index, boolean is) {
  transient_button_is[index] = is;
}

void fx_button_is(int index, boolean is) {
  fx_button_is[index] = is;
}



















/**
UPDATE DATA from CONTROLER and PRESCENE
v 0.0.2
Those value are used to updated the object data value, and updated at the end of the loop the temp value
*/
void update_raw_item_value() {
   int minSource = 0 ;
   int smooth_slider = 2 ;
   // COL A
  // fill
  fill_hue_raw = (int)map(value_slider_item[0], minSource, MAX_VALUE_SLIDER, fill_hue_min_max.x, fill_hue_min_max.y);
  fill_sat_raw = (int)map(value_slider_item[1], minSource, MAX_VALUE_SLIDER, fill_sat_min_max.x, fill_sat_min_max.y);    
  fill_bright_raw = (int)map(value_slider_item[2], minSource, MAX_VALUE_SLIDER, fill_bright_min_max.x, fill_bright_min_max.y);   
  fill_alpha_raw = (int)map(value_slider_item[3], minSource, MAX_VALUE_SLIDER, fill_alpha_min_max.x, fill_alpha_min_max.y);
  // stroke
  stroke_hue_raw = (int)map(value_slider_item[4], minSource, MAX_VALUE_SLIDER, stroke_hue_min_max.x,stroke_hue_min_max.y);   
  stroke_sat_raw = (int)map(value_slider_item[5], minSource, MAX_VALUE_SLIDER, stroke_sat_min_max.x,stroke_sat_min_max.y);  
  stroke_bright_raw = (int)map(value_slider_item[6], minSource, MAX_VALUE_SLIDER, stroke_bright_min_max.x, stroke_bright_min_max.y); 
  stroke_alpha_raw = (int)map(value_slider_item[7], minSource, MAX_VALUE_SLIDER, stroke_alpha_min_max.x, stroke_alpha_min_max.y);
  // 
  thickness_raw = map_smooth_start(value_slider_item[8], minSource, MAX_VALUE_SLIDER, thickness_min_max.x, thickness_min_max.y, smooth_slider);
  // size
  size_x_raw = map_smooth_start(value_slider_item[9], minSource, MAX_VALUE_SLIDER, size_x_min_max.x, size_x_min_max.y, smooth_slider);
  size_y_raw = map_smooth_start(value_slider_item[10], minSource, MAX_VALUE_SLIDER, size_y_min_max.x, size_y_min_max.y, smooth_slider);
  size_z_raw = map_smooth_start(value_slider_item[11], minSource, MAX_VALUE_SLIDER, size_z_min_max.x, size_z_min_max.y, smooth_slider);
  // size font
  diameter_raw = map(value_slider_item[12], minSource, MAX_VALUE_SLIDER, diameter_min_max.x, diameter_min_max.y);
  // canvas
  canvas_x_raw = map_smooth_start(value_slider_item[13], minSource, MAX_VALUE_SLIDER, canvas_x_min_max.x, canvas_x_min_max.y, smooth_slider);
  canvas_y_raw = map_smooth_start(value_slider_item[14], minSource, MAX_VALUE_SLIDER, canvas_y_min_max.x, canvas_y_min_max.y, smooth_slider);
  canvas_z_raw = map_smooth_start(value_slider_item[15], minSource, MAX_VALUE_SLIDER, canvas_z_min_max.x, canvas_z_min_max.y, smooth_slider);
  
  // COL B
  // frequence raw
  frequence_raw = map(value_slider_item[16], minSource, MAX_VALUE_SLIDER, frequence_min_max.x, frequence_min_max.y);
  // speed
  speed_x_raw = map(value_slider_item[17], minSource, MAX_VALUE_SLIDER, speed_x_min_max.x, speed_x_min_max.y);
  speed_y_raw = map(value_slider_item[18], minSource, MAX_VALUE_SLIDER, speed_y_min_max.x, speed_y_min_max.y);
  speed_z_raw = map(value_slider_item[19], minSource, MAX_VALUE_SLIDER, speed_z_min_max.x, speed_z_min_max.y);
  // spurt
  spurt_x_raw = map(value_slider_item[20], minSource, MAX_VALUE_SLIDER, spurt_x_min_max.x, spurt_x_min_max.y);
  spurt_y_raw = map(value_slider_item[21], minSource, MAX_VALUE_SLIDER, spurt_y_min_max.x, spurt_y_min_max.y);
  spurt_z_raw = map(value_slider_item[22], minSource, MAX_VALUE_SLIDER, spurt_z_min_max.x, spurt_z_min_max.y);
  // direction
  dir_x_raw = map(value_slider_item[23], minSource, MAX_VALUE_SLIDER, dir_x_min_max.x, dir_x_min_max.y);
  dir_y_raw = map(value_slider_item[24], minSource, MAX_VALUE_SLIDER, dir_y_min_max.x, dir_y_min_max.y);
  dir_z_raw = map(value_slider_item[25], minSource, MAX_VALUE_SLIDER, dir_z_min_max.x, dir_z_min_max.y);
  // jitter
  jitter_x_raw = map(value_slider_item[26], minSource, MAX_VALUE_SLIDER, jitter_x_min_max.x, jitter_x_min_max.y);
  jitter_y_raw = map(value_slider_item[27], minSource, MAX_VALUE_SLIDER, jitter_y_min_max.x, jitter_y_min_max.y);
  jitter_z_raw = map(value_slider_item[28], minSource, MAX_VALUE_SLIDER, jitter_z_min_max.x, jitter_z_min_max.y);
  // spurt
  swing_x_raw = map(value_slider_item[29], minSource, MAX_VALUE_SLIDER, swing_x_min_max.x, swing_x_min_max.y);
  swing_y_raw = map(value_slider_item[30], minSource, MAX_VALUE_SLIDER, swing_y_min_max.x, swing_y_min_max.y);
  swing_z_raw = map(value_slider_item[31], minSource, MAX_VALUE_SLIDER, swing_z_min_max.x, swing_z_min_max.y);
  
  // COL C
  // misc
  quantity_raw = map(value_slider_item[32], minSource, MAX_VALUE_SLIDER, quantity_min_max.x, quantity_min_max.y);
  variety_raw = map(value_slider_item[33], minSource, MAX_VALUE_SLIDER, variety_min_max.x, variety_min_max.y);
  // bio
  life_raw = map(value_slider_item[34], minSource, MAX_VALUE_SLIDER, life_min_max.x, life_min_max.y);
  flow_raw = map(value_slider_item[35], minSource, MAX_VALUE_SLIDER, flow_min_max.x, flow_min_max.y);
  quality_raw = map(value_slider_item[36], minSource, MAX_VALUE_SLIDER, quality_min_max.x, quality_min_max.y);
  // radar
  area_raw = map_smooth_start(value_slider_item[37], minSource, MAX_VALUE_SLIDER, area_min_max.x, area_min_max.y, smooth_slider);
  angle_raw = map(value_slider_item[38], minSource, MAX_VALUE_SLIDER, angle_min_max.x, angle_min_max.y);
  scope_raw = map(value_slider_item[39], minSource, MAX_VALUE_SLIDER, scope_min_max.x, scope_min_max.y);
  scan_raw = map(value_slider_item[40], minSource, MAX_VALUE_SLIDER, scan_min_max.x, scan_min_max.y);

  // force or behavior
  alignment_raw = map(value_slider_item[41], minSource, MAX_VALUE_SLIDER, alignment_min_max.x, alignment_min_max.y);
  repulsion_raw = map(value_slider_item[42], minSource, MAX_VALUE_SLIDER, repulsion_min_max.x, repulsion_min_max.y);
  attraction_raw = map(value_slider_item[43], minSource, MAX_VALUE_SLIDER, attraction_min_max.x, attraction_min_max.y);
  density_raw = map(value_slider_item[44], minSource, MAX_VALUE_SLIDER, density_min_max.x, density_min_max.y);

  influence_raw = map(value_slider_item[45], minSource, MAX_VALUE_SLIDER, influence_min_max.x, influence_min_max.y);
  calm_raw = map(value_slider_item[46], minSource, MAX_VALUE_SLIDER, calm_min_max.x, calm_min_max.y);
  spectrum_raw = map(value_slider_item[47], minSource, MAX_VALUE_SLIDER, spectrum_min_max.x, spectrum_min_max.y); 

  // COL D
  grid_raw = map(value_slider_item[48], minSource, MAX_VALUE_SLIDER, grid_min_max.x, grid_min_max.y);

  viscosity_raw = map(value_slider_item[49], minSource, MAX_VALUE_SLIDER, viscosity_min_max.x, viscosity_min_max.y);
  diffusion_raw = map(value_slider_item[50], minSource, MAX_VALUE_SLIDER, diffusion_min_max.x, diffusion_min_max.y); 

}


/* Those temp value are used to know is the object value must be updated */
void update_temp_value() {
  // COL A
  fill_hue_temp = fill_hue_raw;
  fill_sat_temp = fill_sat_raw;    
  fill_bright_temp = fill_bright_raw;   
  fill_alpha_temp = fill_alpha_raw;

  stroke_hue_temp = stroke_hue_raw; 
  stroke_sat_temp = stroke_sat_raw;  
  stroke_bright_temp = stroke_bright_raw; 
  stroke_alpha_temp = stroke_alpha_raw;
  //
  thickness_temp= thickness_raw;

  size_x_temp = size_x_raw;
  size_y_temp = size_y_raw;
  size_z_temp = size_z_raw;

  diameter_temp = diameter_raw;

  canvas_x_temp = canvas_x_raw;
  canvas_y_temp = canvas_y_raw;
  canvas_z_temp = canvas_z_raw;
  // COL B
  // misc
  frequence_temp = frequence_raw;
  // speed
  speed_x_temp = speed_x_raw;
  speed_y_temp = speed_y_raw;
  speed_z_temp = speed_z_raw;
  // spurt
  spurt_x_temp = spurt_x_raw;
  spurt_y_temp = spurt_y_raw;
  spurt_z_temp = spurt_z_raw;
  // direction
  dir_x_temp = dir_x_raw;
  dir_y_temp = dir_y_raw;
  dir_z_temp = dir_z_raw;
  // jitter
  jitter_x_temp = jitter_x_raw;
  jitter_y_temp = jitter_y_raw;
  jitter_z_temp = jitter_z_raw;
  // direction
  swing_x_temp = swing_x_raw;
  swing_y_temp = swing_y_raw;
  swing_z_temp = swing_z_raw;
  // COL C
  quantity_temp = quantity_raw;
  variety_temp = variety_raw;

  life_temp = life_raw;
  flow_temp = flow_raw;
  quality_temp = quality_raw;

  area_temp = area_raw;
  angle_temp = angle_raw;
  scope_temp = scope_raw;
  scan_temp = scan_raw;
  // force
  alignment_temp = alignment_raw;
  repulsion_temp = repulsion_raw;
  attraction_temp = attraction_raw;
  density_temp = density_raw;

  influence_temp = influence_raw;
  calm_temp = calm_raw;
  spectrum_temp = spectrum_raw;
  // COL D
  grid_temp = grid_raw;
  viscosity_temp = viscosity_raw;
  diffusion_temp = diffusion_raw;
}


//SHORTCUT VAR
//SOUND
float all_transient(int ID) {
  float val = 0 ;
  for(int i = 1 ; i < transient_value.length ; i++) {
    val += transient_value[i][ID] *.25;
  }
  return val ;
}

