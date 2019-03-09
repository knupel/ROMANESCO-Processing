/**
* VARIABLE
* 2015-2019
* v 1.11.1
*/
boolean scene, prescene;
boolean miroir_on_off = false;

boolean check_size = false;

// In the Miroir and Scene sketch presceneOnly must be true for the final work.
Boolean internet = true;
String bigBrother = ("BIG BROTHER DON'T WATCHING YOU !!");

//init var
//GLOBAL
void scene_variables_setup() {
  for (int i = 0 ; i < data_osc_prescene.length ; i++) {
    data_osc_prescene[i] = ("0");
  }
  
  for (int i = 0 ; i < NUM_ITEM ; i++ ) {
    pen[i] = vec3();
    mouse[i] = vec3();
    wheel[i] = 0;
  }
  println("Rendering variables setup done");
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



//to pass processing in an embeded class, you must call the PApplet too in your class
PApplet papplet = this ;
// use for the border of window (top and right)
java.awt.Insets insets; 


boolean OPEN_APP = false;
// WINDOW VAR
int MIN_WINDOW_WIDTH = 128; 
int MIN_WINDOW_HEIGHT = 128;

int scene_width,scene_height;

// Max value whi is return from the slider controller
int MAX_VALUE_SLIDER = 360;





//spectrum for the color mode and more if you need
vec4 HSBmode = new vec4 (360,100,100,100) ; // give the color mode in HSB
//path to open the controleur
String findPath ; 

// MOUSE DETECTION
// return if the cursor (mouse) is in the sketch or not
boolean MOUSE_IN_OUT = true ;


// BOOLEAN COMMAND
// command from leap motion, mouse or other devices if we code for that :)
boolean ORDER, ORDER_ONE, ORDER_TWO, ORDER_THREE ;
boolean LEAPMOTION_DETECTED ;


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
boolean reset_fx_button_is;
boolean birth_button_is;
boolean dimension_button_is;
boolean background_button_is;
boolean ambient_button_is,ambient_action_is;
boolean light_1_button_is,light_1_action_button_is;
boolean light_2_button_is,light_2_action_button_is;

int which_shader;
int which_fx; 


// media
int [] which_bitmap, which_text, which_shape, which_movie;

String [] bitmap_path_ref, svg_path_ref;

Movie[] movie;

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
//MISC var
//info object
String [] item_info, item_name, item_author, item_version, item_pack;
int [] item_ID;
boolean [] item_info_display;
//for the leap motion ?
int objectLeapID[];
//BUTTON CONTROLER
boolean objectParameter[];

//raw
float fill_hue_raw, fill_sat_raw, fill_bright_raw, fill_alpha_raw;
float stroke_hue_raw, stroke_sat_raw, stroke_bright_raw, stroke_alpha_raw;
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
float power_raw;
float mass_raw;
float coord_x_raw, coord_y_raw, coord_z_raw;


// ref value
float fill_hue_ref, fill_sat_ref, fill_bright_ref, fill_alpha_ref;
float stroke_hue_ref, stroke_sat_ref, stroke_bright_ref, stroke_alpha_ref;
float thickness_ref; 
float size_x_ref, size_y_ref, size_z_ref;
float diameter_ref;
float canvas_x_ref, canvas_y_ref, canvas_z_ref;
// col B
float frequence_ref;
float speed_x_ref, speed_y_ref, speed_z_ref;
float spurt_x_ref, spurt_y_ref, spurt_z_ref;
float dir_x_ref,dir_y_ref,dir_z_ref;
float jitter_x_ref, jitter_y_ref, jitter_z_ref;
float swing_x_ref, swing_y_ref, swing_z_ref;
// col C
float quantity_ref, variety_ref;
float life_ref, flow_ref, quality_ref;
float area_ref, angle_ref, scope_ref, scan_ref;

float alignment_ref, repulsion_ref, attraction_ref, density_ref;
float influence_ref, calm_ref, spectrum_ref;
// col D
float grid_ref;
float viscosity_ref, diffusion_ref;

float power_ref;
float mass_ref;
float coord_x_ref,coord_y_ref,coord_z_ref;


/**
String name
Used for SCENE don't delete
*/
String fill_hue_name = "fill_hue";     
String fill_sat_name = "fill_sat";     
String fill_bright_name= "fill_bright";     
String fill_alpha_name = "fill_alpha";

String stroke_hue_name = "stroke_hue"; 
String stroke_sat_name = "stroke_sat"; 
String stroke_bright_name= "stroke_bright"; 
String stroke_alpha_name = "stroke_alpha";

String thickness_name = "thickness"; 

String size_x_name = "size_x";     
String size_y_name = "size_y";     
String size_z_name = "size_z";

String diameter_name = "diameter";

String canvas_x_name = "canvas_x"; 
String canvas_y_name = "canvas_y"; 
String canvas_z_name = "canvas_z";

String frequence_name = "frequence" ;

String speed_x_name = "speed_x"; 
String speed_y_name = "speed_y"; 
String speed_z_name = "speed_z";

String spurt_x_name = "spurt_x"; 
String spurt_y_name= "spurt_y"; 
String spurt_z_name = "spurt_z";

String dir_x_name = "dir_x"; 
String dir_y_name = "dir_y"; 
String dir_z_name = "dir_z";

String jitter_x_name = "jitter_x"; 
String jitter_y_name = "jitter_y"; 
String jitter_z_name = "jitter_z";

String swing_x_name = "swing_x"; 
String swing_y_name = "swing_y"; 
String swing_z_name = "swing_z";

String quantity_name = "quantity"; 
String variety_name = "variety"; 

String life_name = "life"; 
String flow_name = "flow"; 
String quality_name = "quality";

String area_name = "area"; 
String angle_name = "angle"; 
String scope_name = "scope"; 
String scan_name = "scan";

String alignment_name = "alignment"; 
String repulsion_name = "repulsion"; 
String attraction_name = "attraction"; 
String density_name = "density";

String influence_name = "influence"; 
String calm_name = "calm"; 
String spectrum_name = "spectrum";

String grid_name = "grid"; 
String viscosity_name = "viscosity"; 
String diffusion_name = "diffusion";

String power_name = "power"; 
String mass_name = "mass";

String pos_x_name = "pos_x"; 
String pos_y_name = "pos_y"; 
String pos_z_name = "pos_z";






































// item target final
boolean [] first_opening_item; // used to check if this object is already opening before
vec4 [] fill_item_ref,stroke_item_ref;



//BUTTON
int [] value_button_item;

//position
vec3 [] pos_item_final;
vec3 [] pos_item;
vec3 [] pos_item_ref;


// direction
boolean [] reset_camera_direction_item;
vec3 [] temp_item_canvas_direction;
vec3 [] dir_item;
vec3 [] dir_item_final;
vec3 [] dir_item_ref;

// master and follower
int [] master_ID;
boolean [] follower;
//setting and save
int NUM_SETTING_CAMERA;
int numSettingOrientationObject = 1;
vec3 [][] item_setting_position;
vec3 [][] item_setting_direction;
vec3 [] eyeCameraSetting, sceneCameraSetting;

//position of object and wheel
vec3 [] mouse, pen;
boolean [] clickShortLeft, clickShortRight, clickLongLeft, clickLongRight;
int wheel[];


//font
ROFont current_font;
















//MISC
//var to init the data of the object when is switch ON for the first time
boolean [] init_value_mouse, init_value_controller;
//parameter for the super class
float [] left,right,mix;
// transient
float [][] transient_value;
// spectrum
float band[][];
//tempo
float [] tempo, tempoBeat, tempoKick, tempoSnare, tempoHat;
























/**
CREATE VAR 
v 1.1.0
*/
void create_variable() {
  NUM_ITEM = rom_manager.size();
  NUM_ITEM_PLUS_MASTER = NUM_ITEM +1;

  NUM_SETTING_ITEM = 1;
  NUM_SETTING_CAMERA = 1;

  create_var_misc();
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


  //MISC
  //var to init the data of the object when is switch ON for the first time
  init_value_mouse = new boolean [NUM_ITEM_PLUS_MASTER];
  init_value_controller = new boolean [NUM_ITEM_PLUS_MASTER];
}





// var cursor
void create_var_cursor() {
  //position of object and wheel
   mouse  = new vec3[NUM_ITEM_PLUS_MASTER];
   clickShortLeft = new boolean [NUM_ITEM_PLUS_MASTER];
   clickShortRight = new boolean [NUM_ITEM_PLUS_MASTER];
   clickLongLeft = new boolean [NUM_ITEM_PLUS_MASTER];
   clickLongRight = new boolean [NUM_ITEM_PLUS_MASTER];
   wheel = new int [NUM_ITEM_PLUS_MASTER];
  //pen info
   pen = new vec3[NUM_ITEM_PLUS_MASTER];
}




// P3D
void create_var_P3D(int num_setting_camera) {
   // setting and save
   eyeCameraSetting = new vec3 [num_setting_camera];
   sceneCameraSetting = new vec3 [num_setting_camera];
   
   reset_camera_direction_item = new boolean[NUM_ITEM_PLUS_MASTER];
   pos_item_ref = new vec3[NUM_ITEM_PLUS_MASTER];
   pos_item = new vec3[NUM_ITEM_PLUS_MASTER];
   dir_item = new vec3[NUM_ITEM_PLUS_MASTER];
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



void create_var_item_manipulation(int num_item_setting) {
  pos_item_final = new vec3 [NUM_ITEM_PLUS_MASTER] ;
  item_setting_position = new vec3 [num_item_setting] [NUM_ITEM_PLUS_MASTER];

  dir_item_final = new vec3 [NUM_ITEM_PLUS_MASTER];
  dir_item_ref = new vec3 [NUM_ITEM_PLUS_MASTER];
  temp_item_canvas_direction = new vec3 [NUM_ITEM_PLUS_MASTER];
  item_setting_direction = new vec3 [num_item_setting] [NUM_ITEM_PLUS_MASTER];

  // master and follower
  master_ID = new int[NUM_ITEM_PLUS_MASTER];
  follower = new boolean[NUM_ITEM_PLUS_MASTER];
}  

void create_var_item_slider() {
  first_opening_item = new boolean[NUM_ITEM_PLUS_MASTER] ; // used to check if this object is already opening before
  fill_item_ref = new vec4[NUM_ITEM_PLUS_MASTER];
  stroke_item_ref = new vec4[NUM_ITEM_PLUS_MASTER];
}

















/**
INIT VAR 
*/
void init_variable_item_min_max() {
  float ratio_min_deci = .1;
  float ratio_min_centi = .01;
  float ratio_min_milli = .001;
  float ratio_max = TAU;

  float min_size = .1;
  float max_size = width;
  
  for(Romanesco item : rom_manager.get()) {
    // COL 1
    item.set_fill_hue_min_max(0,MAX_VALUE_SLIDER,0,360);
    item.set_fill_sat_min_max(0,MAX_VALUE_SLIDER,0,HSBmode.sat());
    item.set_fill_bright_min_max(0,MAX_VALUE_SLIDER,0,HSBmode.bri());
    item.set_fill_alpha_min_max(0,MAX_VALUE_SLIDER,0,HSBmode.alp());

    item.set_stroke_hue_min_max(0,MAX_VALUE_SLIDER,0,360);
    item.set_stroke_sat_min_max(0,MAX_VALUE_SLIDER,0,HSBmode.sat());
    item.set_stroke_bright_min_max(0,MAX_VALUE_SLIDER,0,HSBmode.bri());
    item.set_stroke_alpha_min_max(0,MAX_VALUE_SLIDER,0,HSBmode.alp());

    item.set_thickness_min_max(0,MAX_VALUE_SLIDER,min_size,max_size *ratio_min_centi);
    item.set_size_x_min_max(0,MAX_VALUE_SLIDER,max_size *ratio_min_milli,max_size);
    item.set_size_y_min_max(0,MAX_VALUE_SLIDER,max_size *ratio_min_milli,max_size);
    item.set_size_z_min_max(0,MAX_VALUE_SLIDER,max_size *ratio_min_milli,max_size);
    item.set_diameter_min_max(0,MAX_VALUE_SLIDER,max_size *ratio_min_milli,max_size);

    item.set_canvas_x_min_max(0,MAX_VALUE_SLIDER,max_size *ratio_min_deci,max_size *ratio_max);
    item.set_canvas_y_min_max(0,MAX_VALUE_SLIDER,max_size *ratio_min_deci,max_size *ratio_max);
    item.set_canvas_z_min_max(0,MAX_VALUE_SLIDER,max_size *ratio_min_deci,max_size *ratio_max);
    // COL 2
    item.set_frequence_min_max(0,MAX_VALUE_SLIDER,0,1);

    item.set_speed_x_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_speed_y_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_speed_z_min_max(0,MAX_VALUE_SLIDER,0,1);

    item.set_spurt_x_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_spurt_y_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_spurt_z_min_max(0,MAX_VALUE_SLIDER,0,1);

    item.set_dir_x_min_max(0,MAX_VALUE_SLIDER,0,TAU);
    item.set_dir_y_min_max(0,MAX_VALUE_SLIDER,0,TAU);
    item.set_dir_z_min_max(0,MAX_VALUE_SLIDER,0,TAU);

    item.set_jitter_x_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_jitter_y_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_jitter_z_min_max(0,MAX_VALUE_SLIDER,0,1);

    item.set_swing_x_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_swing_y_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_swing_z_min_max(0,MAX_VALUE_SLIDER,0,1);
    // COL 3
    item.set_quantity_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_variety_min_max(0,MAX_VALUE_SLIDER,0,1);

    item.set_life_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_flow_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_quality_min_max(0,MAX_VALUE_SLIDER,0,1);

    item.set_area_min_max(0,MAX_VALUE_SLIDER,max_size *ratio_min_deci, max_size *ratio_max);
    item.set_angle_min_max(0,MAX_VALUE_SLIDER,0,TAU);
    item.set_scope_min_max(0,MAX_VALUE_SLIDER,max_size *ratio_min_deci, max_size *ratio_max);
    item.set_scan_min_max(0,MAX_VALUE_SLIDER,0,TAU);

    item.set_alignment_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_repulsion_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_attraction_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_density_min_max(0,MAX_VALUE_SLIDER,0,1);

    item.set_influence_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_calm_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_spectrum_min_max(0,MAX_VALUE_SLIDER,0,360);
    // COL 4
    item.set_grid_min_max(0,MAX_VALUE_SLIDER,max_size *ratio_min_deci, max_size *ratio_max);
    item.set_viscosity_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_diffusion_min_max(0,MAX_VALUE_SLIDER,0,1);

    item.set_power_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_mass_min_max(0,MAX_VALUE_SLIDER,0,1);

    item.set_coord_x_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_coord_y_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_coord_z_min_max(0,MAX_VALUE_SLIDER,0,1);
  }
}


// init var item
void init_variable_item() {
  for (int i = 0 ; i < NUM_ITEM_PLUS_MASTER ; i++ ) {
    // master follower
    master_ID[i] = 0;
    follower[i] = false;

    reset_camera_direction_item[i] = true;
    temp_item_canvas_direction[i] = vec3();
    pen[i] = vec3();
    // use the 250 value for "z" to keep the position light on the front
    mouse[i] = vec3();
    wheel[i] = 0;
  
    Romanesco item = rom_manager.get(i);
    if(item != null) {
      item.init();
      item.set_size_raw(width *.5);
      item.set_diameter_raw(10);
      item.set_canvas_raw(width);

      item.set_frequence_raw(0);

      item.set_speed_raw(0);
      item.set_spurt_raw(0);
      item.set_dir_raw(0);
      item.set_jitter_raw(0);
      item.set_swing_raw(0);

      item.set_quantity_raw(.1);
      item.set_variety_raw(0);
      item.set_life_raw(.1);
      item.set_flow_raw(0);
      item.set_quality_raw(.1);

      item.set_area_raw(width);
      item.set_angle_raw(0);
      item.set_scope_raw(width);
      item.set_scan_raw(PI/2);

      item.set_alignment_raw(0);
      item.set_repulsion_raw(0);
      item.set_attraction_raw(0);
      item.set_density_raw(0);

      item.set_influence_raw(0);
      item.set_calm_raw(0);
      item.set_spectrum_raw(0);

      item.set_grid_raw(width);
      item.set_viscosity_raw(0);
      item.set_diffusion_raw(0);
      item.set_power_raw(0);
      item.set_mass_raw(0);
      item.set_coord_raw(0);
    }
   
  }
    // init global var for the color obj preview mode display
  COLOR_FILL_ITEM_PREVIEW = color(0,0,100,30); 
  COLOR_STROKE_ITEM_PREVIEW = color(0,0,100,30);
}



boolean items_loaded_is() {
  return rom_manager.init_items();
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
/**
ALERT BUTTON
*this button must became false immetiatly after using
*/
// general button alert
boolean reset_camera_button_alert_is() {
  return reset_camera_button_is;
}

boolean reset_item_on_button_alert_is() {
  return reset_item_on_button_is;
}

boolean reset_fx_button_alert_is() {
  return reset_fx_button_is;
}

// misc
boolean birth_button_alert_is() {
  return birth_button_is;
}

boolean dimension_button_alert_is() {
  return dimension_button_is;
}


// set boolean button alert
// reset
void reset_camera_button_alert_is(boolean is) {
  reset_camera_button_is = is;
}

void reset_item_on_button_alert_is(boolean is) {
  reset_item_on_button_is = is;
}

void reset_fx_button_alert_is(boolean is) {
  reset_fx_button_is = is;
}

// misc
void birth_button_alert_is(boolean is) {
  birth_button_is = is;
}

void dimension_button_alert_is(boolean is) {
  dimension_button_is = is;
}


// set false button alert
boolean button_alert_is = false;
void reset_button_alert() {
  if(reset_camera_button_alert_is() && button_alert_is) {
    reset_camera_button_alert_is(false);
    button_alert_is = false;
  }

  if(reset_item_on_button_alert_is() && button_alert_is) {
    reset_item_on_button_alert_is(false);
    button_alert_is = false;
  }

  if(reset_fx_button_alert_is() && button_alert_is) {
    reset_fx_button_alert_is(false);
    button_alert_is = false;
  }

  if(birth_button_alert_is() && button_alert_is) {
    birth_button_alert_is(false);
    button_alert_is = false;
  }

  if(dimension_button_alert_is()&& button_alert_is) {
    dimension_button_alert_is(false);
    button_alert_is = false;
  }

  if(reset_camera_button_alert_is() 
  || reset_item_on_button_alert_is() 
  || reset_fx_button_alert_is() 
  || birth_button_alert_is() 
  || dimension_button_alert_is()) {
    button_alert_is = true;
  }
}






/**
CLASSIC BUTTON
*/
// general button classic
boolean curtain_button_is() {
  return curtain_button_is;
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
  // COL 1

  int col = NUM_SLIDER_ITEM_BY_COL *0;
  // fill
  fill_hue_raw = map(value_slider_item[col+0],0,MAX_VALUE_SLIDER,0,g.colorModeX);
  fill_sat_raw = map(value_slider_item[col+1],0,MAX_VALUE_SLIDER,0,g.colorModeY);    
  fill_bright_raw = map(value_slider_item[col+2],0,MAX_VALUE_SLIDER,0,g.colorModeZ);  
  fill_alpha_raw = map(value_slider_item[col+3],0,MAX_VALUE_SLIDER,0,g.colorModeA);
  // stroke
  stroke_hue_raw = map(value_slider_item[col+4],0,MAX_VALUE_SLIDER,0,g.colorModeX); 
  stroke_sat_raw = map(value_slider_item[col+5],0,MAX_VALUE_SLIDER,0,g.colorModeY);  
  stroke_bright_raw = map(value_slider_item[col+6],0,MAX_VALUE_SLIDER,0,g.colorModeZ);  
  stroke_alpha_raw = map(value_slider_item[col+7],0,MAX_VALUE_SLIDER,0,g.colorModeA);
  // 
  thickness_raw = value_slider_item[col+8];

  // size
  size_x_raw = value_slider_item[col+9];
  size_y_raw = value_slider_item[col+10];
  size_z_raw = value_slider_item[col+11];
  // size font
  diameter_raw = value_slider_item[col+12];
  // canvas
  canvas_x_raw = value_slider_item[col+13];
  canvas_y_raw = value_slider_item[col+14];
  canvas_z_raw = value_slider_item[col+15];

  col = NUM_SLIDER_ITEM_BY_COL *1;
  // frequence raw
  frequence_raw = value_slider_item[col+0];
  // speed
  speed_x_raw = value_slider_item[col+1];
  speed_y_raw = value_slider_item[col+2];
  speed_z_raw = value_slider_item[col+3];
  // spurt
  spurt_x_raw = value_slider_item[col+4];
  spurt_y_raw = value_slider_item[col+5];
  spurt_z_raw =value_slider_item[col+6];
  // direction
  dir_x_raw = value_slider_item[col+7];
  dir_y_raw = value_slider_item[col+8];
  dir_z_raw = value_slider_item[col+9];
  // jitter
  jitter_x_raw = value_slider_item[col+10];
  jitter_y_raw = value_slider_item[col+11];
  jitter_z_raw = value_slider_item[col+12];
  // spurt
  swing_x_raw = value_slider_item[col+13];
  swing_y_raw = value_slider_item[col+14];
  swing_z_raw = value_slider_item[col+15];

  col = NUM_SLIDER_ITEM_BY_COL *2;
  // misc
  quantity_raw = value_slider_item[col+0];
  variety_raw = value_slider_item[col+1];
  // bio
  life_raw = value_slider_item[col+2];
  flow_raw = value_slider_item[col+3];
  quality_raw = value_slider_item[col+4];
  // radar
  area_raw = value_slider_item[col+5];
  angle_raw = value_slider_item[col+6];
  scope_raw = value_slider_item[col+7];
  scan_raw = value_slider_item[col+8];

  // force or behavior
  alignment_raw = value_slider_item[col+9];
  repulsion_raw = value_slider_item[col+10];
  attraction_raw = value_slider_item[col+11];
  density_raw = value_slider_item[col+12];

  influence_raw = value_slider_item[col+13];
  calm_raw = value_slider_item[col+14];
  spectrum_raw = value_slider_item[col+15];

  col = NUM_SLIDER_ITEM_BY_COL *3;
  grid_raw = value_slider_item[col+0];

  viscosity_raw = value_slider_item[col+1];
  diffusion_raw = value_slider_item[col+2]; 

  power_raw = value_slider_item[col+3];
  mass_raw = value_slider_item[col+4]; 
  coord_x_raw = value_slider_item[col+5];
  coord_y_raw = value_slider_item[col+6];
  coord_z_raw = value_slider_item[col+7];
  

  /*
  value_slider_item[col+8]
  value_slider_item[col+9]
  value_slider_item[col+10]
  value_slider_item[col+11]
  value_slider_item[col+12]
    value_slider_item[col+13]
  value_slider_item[col+14]
  value_slider_item[col+15]
  */

}




/* Those temp value are used to know is the object value must be updated */
// value used to know if the value slider have change or nor 
// col A
void update_slider_ref() {
  // COL 1
  fill_hue_ref = fill_hue_raw;
  fill_sat_ref = fill_sat_raw;    
  fill_bright_ref = fill_bright_raw;   
  fill_alpha_ref = fill_alpha_raw;

  stroke_hue_ref = stroke_hue_raw; 
  stroke_sat_ref = stroke_sat_raw;  
  stroke_bright_ref = stroke_bright_raw; 
  stroke_alpha_ref = stroke_alpha_raw;

  thickness_ref = thickness_raw;

  size_x_ref = size_x_raw;
  size_y_ref = size_y_raw;
  size_z_ref = size_z_raw;

  diameter_ref = diameter_raw;

  canvas_x_ref = canvas_x_raw;
  canvas_y_ref = canvas_y_raw;
  canvas_z_ref = canvas_z_raw;

  // COL 2
  // misc
  frequence_ref = frequence_raw;
  // speed
  speed_x_ref = speed_x_raw;
  speed_y_ref = speed_y_raw;
  speed_z_ref = speed_z_raw;
  // spurt
  spurt_x_ref = spurt_x_raw;
  spurt_y_ref = spurt_y_raw;
  spurt_z_ref = spurt_z_raw;
  // direction
  dir_x_ref = dir_x_raw;
  dir_y_ref = dir_y_raw;
  dir_z_ref = dir_z_raw;
  // jitter
  jitter_x_ref = jitter_x_raw;
  jitter_y_ref = jitter_y_raw;
  jitter_z_ref = jitter_z_raw;
  // direction
  swing_x_ref = swing_x_raw;
  swing_y_ref = swing_y_raw;
  swing_z_ref = swing_z_raw;

  // COL 3
  quantity_ref = quantity_raw;
  variety_ref = variety_raw;

  life_ref = life_raw;
  flow_ref = flow_raw;
  quality_ref = quality_raw;

  area_ref = area_raw;
  angle_ref = angle_raw;
  scope_ref = scope_raw;
  scan_ref = scan_raw;
  // force
  alignment_ref = alignment_raw;
  repulsion_ref = repulsion_raw;
  attraction_ref = attraction_raw;
  density_ref = density_raw;

  influence_ref = influence_raw;
  calm_ref = calm_raw;
  spectrum_ref = spectrum_raw;

  // COL 4
  grid_ref = grid_raw;
  viscosity_ref = viscosity_raw;
  diffusion_ref = diffusion_raw;

  power_ref = power_raw;
  mass_ref = mass_raw;

  coord_x_ref = coord_x_raw;
  coord_y_ref = coord_y_raw;
  coord_z_ref = coord_z_raw;
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

