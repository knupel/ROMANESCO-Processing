/**
Romanesco Manager
Prescene and Scene
2013-2018
v 1.3.0
*/
Romanesco_manager rpe_manager;
// col 1
String ROM_HUE_FILL, ROM_SAT_FILL,ROM_BRIGHT_FILL, ROM_ALPHA_FILL = "";
String ROM_HUE_STROKE,ROM_SAT_STROKE,ROM_BRIGHT_STROKE,ROM_ALPHA_STROKE = "";
String ROM_THICKNESS = "";
String ROM_SIZE_X,ROM_SIZE_Y,ROM_SIZE_Z = "";
String ROM_DIAMETER = "";
String ROM_CANVAS_X,ROM_CANVAS_Y,ROM_CANVAS_Z = "";
// col 2
String ROM_FREQUENCE = "";
String ROM_SPEED_X,ROM_SPEED_Y,ROM_SPEED_Z = "";
String ROM_SPURT_X,ROM_SPURT_Y,ROM_SPURT_Z = "";
String ROM_DIR_X,ROM_DIR_Y,ROM_DIR_Z = "";
String ROM_JIT_X,ROM_JIT_Y,ROM_JIT_Z = "j";
String ROM_SWIWG_X,ROM_SWIWG_Y,ROM_SWIWG_Z = "";
// col 3
String ROM_QUANTITY = "";
String ROM_VARIETY = "";
String ROM_LIFE = "";
String ROM_FLOW = "";
String ROM_QUALITY = "";
String ROM_AREA = "";
String ROM_ANGLE = "";
String ROM_SCOPE = "";
String ROM_SCAN = "";
String ROM_ALIGN = "";
String ROM_REPULSION = "";
String ROM_ATTRACTION = "";
String ROM_DENSITY = "";
String ROM_INFLUENCE = "";
String ROM_CALM = "";
String ROM_SPECTRUM = "";
// col 4
String ROM_GRID = "";
String ROM_VISCOSITY = "";
String ROM_DIFFUSION = "";
String ROM_POWER = "";
String ROM_MASS = "";
String ROM_POS_X,ROM_POS_Y,ROM_POS_Z = "";


void romanesco_build_item() {
  set_slider_item_name();
  rpe_manager = new Romanesco_manager(this);
  rpe_manager.add_item_romanesco();
  rpe_manager.finish_index();
  rpe_manager.write_info_user();
  println("Romanesco setup done");
}

void set_slider_item_name() {
  Table slider_item_data = loadTable(preference_path+"gui_info_en.csv","header");
  String [][] slider_name = new String[4][16];
  for(int i = 0 ; i < slider_item_data.getRowCount() ;i++) {
    TableRow row = slider_item_data.getRow(i);
    for(int line = 0 ; line < 4 ; line++) {
      String name = "";
      if(line == 0) {
        name = "slider item a";
      } else if(line == 1) {
        name = "slider item b";
      } else if(line == 2) {
        name = "slider item c";
      } else if(line == 3) {
        name = "slider item d";
      }
      if(row.getString("name").equals(name)) {
        for(int k = 0 ; k < slider_item_data.getColumnCount()-1 ; k++) {
          if(k < slider_name[line].length) {
            slider_name[line][k] = row.getString("col "+Integer.toString(k)) ;
            println("slider",line,k,slider_name[line][k]);
          }
        }
      }
    }
  }
  // COL 1
  ROM_HUE_FILL = slider_name[0][0];
  ROM_SAT_FILL = slider_name[0][1];
  ROM_BRIGHT_FILL = slider_name[0][2];
  ROM_ALPHA_FILL = slider_name[0][3];
  ROM_HUE_STROKE = slider_name[0][4];
  ROM_SAT_STROKE = slider_name[0][5];
  ROM_BRIGHT_STROKE = slider_name[0][6];
  ROM_ALPHA_STROKE = slider_name[0][7];
  ROM_THICKNESS = slider_name[0][8];
  ROM_SIZE_X = slider_name[0][9];
  ROM_SIZE_Y = slider_name[0][10];
  ROM_SIZE_Z = slider_name[0][11];
  ROM_DIAMETER = slider_name[0][12];
  ROM_CANVAS_X = slider_name[0][13];
  ROM_CANVAS_Y = slider_name[0][14];
  ROM_CANVAS_Z = slider_name[0][15];

  // COL 2
  ROM_FREQUENCE = slider_name[1][0];
  ROM_SPEED_X = slider_name[1][1];
  ROM_SPEED_Y = slider_name[1][2];
  ROM_SPEED_Z = slider_name[1][3];
  ROM_SPURT_X = slider_name[1][4];
  ROM_SPURT_Y = slider_name[1][5];
  ROM_SPURT_Z = slider_name[1][6];
  ROM_DIR_X = slider_name[1][7];
  ROM_DIR_Y = slider_name[1][8];
  ROM_DIR_Z = slider_name[1][9];
  ROM_JIT_X = slider_name[1][10];
  ROM_JIT_Y = slider_name[1][11];
  ROM_JIT_Z = slider_name[1][12];
  ROM_SWIWG_X = slider_name[1][13];
  ROM_SWIWG_Y = slider_name[1][14];
  ROM_SWIWG_Z = slider_name[1][15];

  // COL 3
  ROM_QUANTITY = slider_name[2][0];
  ROM_VARIETY = slider_name[2][1];
  ROM_LIFE = slider_name[2][2];
  ROM_FLOW = slider_name[2][3];
  ROM_QUALITY = slider_name[2][4];
  ROM_AREA = slider_name[2][5];
  ROM_ANGLE = slider_name[2][6];
  ROM_SCOPE = slider_name[2][7];
  ROM_SCAN = slider_name[2][8];
  ROM_ALIGN = slider_name[2][9];
  ROM_REPULSION = slider_name[2][10];
  ROM_ATTRACTION = slider_name[2][11];
  ROM_DENSITY = slider_name[2][12];
  ROM_INFLUENCE = slider_name[2][13];
  ROM_CALM = slider_name[2][14];
  ROM_SPECTRUM = slider_name[2][15];

  // COL 4
  ROM_GRID = slider_name[3][0];
  ROM_VISCOSITY = slider_name[3][1];
  ROM_DIFFUSION = slider_name[3][2];
  ROM_POWER = slider_name[3][3];
  ROM_MASS = slider_name[3][4];
  ROM_POS_X = slider_name[3][5];
  ROM_POS_Y = slider_name[3][6];
  ROM_POS_Z = slider_name[3][7];
  /*
  ROM_XXX = slider_name[3][8];
  ROM_XXX = slider_name[3][9];
  ROM_XXX = slider_name[3][10];
  ROM_XXX = slider_name[3][11];
  ROM_XXX = slider_name[3][12];
  ROM_XXX = slider_name[3][13];
  ROM_XXX = slider_name[3][14];
  ROM_XXX = slider_name[3][15];
    */
}



















//Update the var of the object
int which_movie_ref, which_bitmap_ref, which_shape_ref, which_text_ref;
void update_var_items(int ID) {
  // info
  item_info_display[ID] = displayInfo?true:false;

  //initialization
  if(!init_value_mouse[ID]) { 
    mouse[ID] = mouse[0].copy();
    pen[ID] = pen[0].copy();
    init_value_mouse[ID] = true;
  }
  if(!init_value_controller[ID]) {
    font_item[ID] = font_library;
    path_font_item[ID] = path_font_library[0];
    update_slider_value(ID) ;
    init_value_controller[ID] = true;
    which_bitmap[ID] = which_bitmap[0];
    which_text[ID] = which_text[0];
    which_shape[ID] = which_shape[0];
    which_movie[ID] = which_movie[0];
  }


  
  if(parameter[ID]) {
    if(which_bitmap_ref !=  which_bitmap[0]) {
      which_bitmap[ID] = which_bitmap[0];
      which_bitmap_ref = which_bitmap[0];
    }

    if(which_text_ref !=  which_text[0]) {
      which_text[ID] = which_text[0];
      which_text_ref = which_text[0];
    }

    if(which_movie_ref !=  which_movie[0]) {
      which_movie[ID] = which_movie[0];
      which_movie_ref = which_movie[0];
    }

    if(which_shape_ref !=  which_shape[0]) {
      which_shape[ID] = which_shape[0];
      which_shape_ref = which_shape[0];
    }

    font_item[ID] = font_library;
    update_slider_value(ID);
  }
  update_var_sound(ID);
  
  if(action[ID]){
    if(key_space_long) {
      pen[ID].set(pen[0]);
      mouse[ID].set(mouse[0]);
    }
    if (key_n || birth_button_alert_is()) birth[ID] = !birth[ID];
    if (key_x) colour[ID] = !colour[ID];
    if (key_d || dimension_button_alert_is()) dimension[ID] = !dimension[ID];
    if (key_h) horizon[ID] = !horizon[ID];
    if (key_m) motion[ID] = !motion[ID];
    if (key_o) orbit[ID] = !orbit[ID];
    if (key_r) reverse[ID] = !reverse[ID];
    if (key_f) special[ID] = !special[ID];
    if (key_w) wire[ID] = !wire[ID];

    if (key_j) fill_is[ID] = !fill_is[ID];
    if (key_k) stroke_is[ID] = !stroke_is[ID];

    clickLongLeft[ID] = ORDER_ONE;
    clickLongRight[ID] = ORDER_TWO;
    clickShortLeft[ID] = clickShortLeft[0];
    clickShortRight[ID] = clickShortRight[0];

    change_bitmap_from_pad(ID);
    change_movie_from_pad(ID);
    change_text_from_pad(ID);
    change_svg_from_pad(ID);

    if(motion[ID]) {
      if(movie[ID] != null) movie[ID].loop();
    } else {
      if(movie[ID] != null) movie[ID].pause();
    }
  }
}




















Vec4 fill_raw_ref;
Vec4 stroke_raw_ref;
void change_slider_ref() {
  fill_raw_ref = Vec4(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw);
  stroke_raw_ref = Vec4(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw);
}

void update_slider_value(int ID) {
  boolean init = first_opening_item[ID];
  // COL 1
  if(FULL_RENDERING) {
    if(!init) {
      fill_item_ref[ID] = Vec4(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw);
      fill_raw_ref = Vec4(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw);
      fill_item[ID] = color(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw);

      stroke_item_ref[ID] = Vec4(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw);
      stroke_raw_ref = Vec4(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw);
      stroke_item[ID] = color(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw);  
    }
    
    // FILL part
    boolean change_fill_h = false;
    boolean change_fill_s = false;
    boolean change_fill_b = false;
    boolean change_fill_a = false;
    // check hsba value
    if(fill_raw_ref.r != fill_hue_raw) change_fill_h = true;
    if(fill_raw_ref.g != fill_sat_raw) change_fill_s = true;
    if(fill_raw_ref.b != fill_bright_raw) change_fill_b = true;
    if(fill_raw_ref.a != fill_alpha_raw) change_fill_a = true;
    

    if(change_fill_h) {
      fill_item[ID] = color(fill_hue_raw,fill_item_ref[ID].g,fill_item_ref[ID].b,fill_item_ref[ID].a);
      fill_item_ref[ID] = color_HSBA(fill_item[ID]);
    }

    if(change_fill_s) {
      fill_item[ID] = color(fill_item_ref[ID].r,fill_sat_raw,fill_item_ref[ID].b,fill_item_ref[ID].a);
      fill_item_ref[ID] = color_HSBA(fill_item[ID]);
    }

    if(change_fill_b) {
      fill_item[ID] = color(fill_item_ref[ID].r,fill_item_ref[ID].g,fill_bright_raw,fill_item_ref[ID].a);
      fill_item_ref[ID] = color_HSBA(fill_item[ID]);
    }


    if(change_fill_a) {
      fill_item[ID] = color(fill_item_ref[ID].r,fill_item_ref[ID].g,fill_item_ref[ID].b,fill_alpha_raw); 
      fill_item_ref[ID] = color_HSBA(fill_item[ID]);
    }
    


    // STROKE part
    boolean change_stroke_h = false;
    boolean change_stroke_s = false;
    boolean change_stroke_b = false;
    boolean change_stroke_a = false;
    // check hsba value
    if(stroke_raw_ref.r != stroke_hue_raw) change_stroke_h = true;
    if(stroke_raw_ref.g != stroke_sat_raw) change_stroke_s = true;
    if(stroke_raw_ref.b != stroke_bright_raw) change_stroke_b = true;
    if(stroke_raw_ref.a != stroke_alpha_raw) change_stroke_a = true;
    

    if(change_stroke_h) {
      stroke_item[ID] = color(stroke_hue_raw,stroke_item_ref[ID].g,stroke_item_ref[ID].b,stroke_item_ref[ID].a);
      stroke_item_ref[ID] = color_HSBA(stroke_item[ID]);
    }

    if(change_stroke_s) {
      stroke_item[ID] = color(stroke_item_ref[ID].r,stroke_sat_raw,stroke_item_ref[ID].b,stroke_item_ref[ID].a);
      stroke_item_ref[ID] = color_HSBA(stroke_item[ID]);
    }

    if(change_stroke_b) {
      stroke_item[ID] = color(stroke_item_ref[ID].r,stroke_item_ref[ID].g,stroke_bright_raw,stroke_item_ref[ID].a);
      stroke_item_ref[ID] = color_HSBA(stroke_item[ID]);
    }

    if(change_stroke_a) {
      stroke_item[ID] = color(stroke_item_ref[ID].r,stroke_item_ref[ID].g,stroke_item_ref[ID].b,stroke_alpha_raw); 
      stroke_item_ref[ID] = color_HSBA(stroke_item[ID]);
    }

    // thickness
    if (thickness_raw != thickness_temp || !init) {
      thickness_item[ID] = thickness_raw;
    }
  } else {
    // preview display
    fill_item[ID] = COLOR_FILL_ITEM_PREVIEW ;
    stroke_item[ID] =  COLOR_STROKE_ITEM_PREVIEW ;
    thickness_item[ID] = THICKNESS_ITEM_PREVIEW ;
  }
  if (size_x_raw != size_x_temp || !init) size_x_item[ID] = size_x_raw; 
  if (size_y_raw != size_y_temp || !init) size_y_item[ID] = size_y_raw; 
  if (size_z_raw != size_z_temp || !init) size_z_item[ID] = size_z_raw;
  if (diameter_raw != diameter_temp || !init) diameter_item[ID] = diameter_raw; 
  if (canvas_x_raw != canvas_x_temp || !init) canvas_x_item[ID] = canvas_x_raw; 
  if (canvas_y_raw != canvas_y_temp || !init) canvas_y_item[ID] = canvas_y_raw; 
  if (canvas_z_raw != canvas_z_temp || !init) canvas_z_item[ID] = canvas_z_raw;


  // COL 2
  if (frequence_raw != frequence_temp || !init) frequence_item[ID] = frequence_raw; 
  if (speed_x_raw != speed_x_temp || !init) speed_x_item[ID] = speed_x_raw; 
  if (speed_y_raw != speed_y_temp || !init) speed_y_item[ID] = speed_y_raw; 
  if (speed_z_raw != speed_z_temp || !init) speed_z_item[ID] = speed_z_raw;
  if (spurt_x_raw != spurt_x_temp || !init) spurt_x_item[ID] = spurt_x_raw; 
  if (spurt_y_raw != spurt_y_temp || !init) spurt_y_item[ID] = spurt_y_raw; 
  if (spurt_z_raw != spurt_z_temp || !init) spurt_z_item[ID] = spurt_z_raw;
  if (dir_x_raw != dir_x_temp || !init) dir_x_item[ID] = dir_x_raw; 
  if (dir_y_raw != dir_y_temp || !init) dir_y_item[ID] = dir_y_raw; 
  if (dir_z_raw != dir_z_temp || !init) dir_z_item[ID] = dir_z_raw;
  if (jitter_x_raw != jitter_x_temp || !init) jitter_x_item[ID] = jitter_x_raw; 
  if (jitter_y_raw != jitter_y_temp || !init) jitter_y_item[ID] = jitter_y_raw; 
  if (jitter_z_raw != jitter_z_temp || !init) jitter_z_item[ID] = jitter_z_raw;
  if (swing_x_raw != swing_x_temp || !init) swing_x_item[ID] = swing_x_raw; 
  if (swing_y_raw != swing_y_temp || !init) swing_y_item[ID] = swing_y_raw; 
  if (swing_z_raw != swing_z_temp || !init) swing_z_item[ID] = swing_z_raw;

  // COL 3
  if (quantity_raw != quantity_temp || !init) quantity_item[ID] = quantity_raw;
  if (variety_raw != variety_temp || !init) variety_item[ID] = variety_raw;
  if (life_raw != life_temp || !init) life_item[ID] = life_raw;
  if (flow_raw != flow_temp || !init) flow_item[ID] = flow_raw;
  if (quality_raw != quality_temp || !init) quality_item[ID] = quality_raw;
  if (area_raw != area_temp || !init) area_item[ID] = area_raw;
  if (angle_raw != angle_temp || !init) angle_item[ID] = angle_raw;
  if (scope_raw != scope_temp || !init) scope_item[ID] = scope_raw;
  if (scan_raw != scan_temp || !init) scan_item[ID] = scan_raw;
  if (alignment_raw != alignment_temp || !init) alignment_item[ID] = alignment_raw;
  if (repulsion_raw != repulsion_temp || !init) repulsion_item[ID] = repulsion_raw;
  if (attraction_raw != attraction_temp || !init) attraction_item[ID] = attraction_raw;
  if (density_raw != density_temp || !init) density_item[ID] = density_raw;
  if (influence_raw != influence_temp || !init) influence_item[ID] = influence_raw;
  if (calm_raw != calm_temp || !init) calm_item[ID] = calm_raw;
  if (spectrum_raw != spectrum_temp || !init) spectrum_item[ID] = spectrum_raw;

  // COL 4
  if (grid_raw != grid_temp || !init) grid_item[ID] = grid_raw;
  if (viscosity_raw != viscosity_temp || !init) viscosity_item[ID] = viscosity_raw;
  if (diffusion_raw != diffusion_temp || !init) diffusion_item[ID] = diffusion_raw;
  if (power_raw != power_temp || !init) power_item[ID] = power_raw;
  if (mass_raw != mass_temp || !init) mass_item[ID] = mass_raw;
  if (pos_x_raw != pos_x_temp || !init) pos_x_item[ID] = pos_x_raw; 
  if (pos_y_raw != pos_y_temp || !init) pos_y_item[ID] = pos_y_raw; 
  if (pos_z_raw != pos_z_temp || !init) pos_z_item[ID] = pos_z_raw;
  /** 
  make the obj has be never update in the future except by the moving slider 
  */
  first_opening_item[ID] = true; 
}





//
void update_var_sound(int ID) {
  if(sound[ID]) {
    left[ID] = left[0];// value(0,1)
    right[ID] = right[0]; //float value(0,1)
    mix[ID] = mix[0]; //   is average volume between the left and the right / float value(0,1)
    
    transient_value[0][ID] = transient_value[0][0]; // is transient master detection on all spectrum : value 1,10 

    transient_value[1][ID] = transient_value[1][0]; // is extra_bass transient detection by default : value 1,10 
    transient_value[2][ID] = transient_value[2][0]; // is bass transient detection by default : value 1,10 
    transient_value[3][ID] = transient_value[3][0]; // is medium transient detection by default : value 1,10 
    transient_value[4][ID] = transient_value[4][0]; // is hight transient detection by default : value 1,10 


    tempo[ID] = tempo[0]; // global speed of track  / float value(0,1)
    tempoBeat[ID] = tempoBeat[0]; // speed of track calculate on the beat
    tempoKick[ID] = tempoKick[0]; // speed of track calculate on the kick
    tempoSnare[ID] = tempoSnare[0]; // speed of track calculate on the snare
    tempoHat[ID] = tempoHat[0]; // speed of track calculte on the hat
    
    for (int i = 0 ; i <NUM_BANDS ; i++) {
      band[ID][i] = band[0][i];
    }
  } else {
    left[ID] = 1;// value(0,1)
    right[ID] = 1; //float value(0,1)
    mix[ID] = 1; //   is average volume between the left and the right / float value(0,1)
    
    transient_value[0][ID] = 1; // is transient master detection on all spectrum : value 1,10 

    transient_value[1][ID] = 1; // is extra_bass transient detection by default : value 1,10 
    transient_value[2][ID] = 1; // is bass transient detection by default : value 1,10 
    transient_value[3][ID] = 1; // is medium transient detection by default : value 1,10 
    transient_value[4][ID] = 1; // is hight transient detection by default : value 1,10 
    
    tempo[ID] = 1; // global speed of track  / float value(0,1)
    tempoBeat[ID] = 1; // speed of track calculate on the beat
    tempoKick[ID] = 1; // speed of track calculate on the kick
    tempoSnare[ID] = 1; // speed of track calculate on the snare
    tempoHat[ID] = 1; // speed of track calculte on the hat
    
    for (int i = 0 ; i < NUM_BANDS ; i++) {
      band[ID][i] = 1 ;
    }
  }
}

// RESET list and item
boolean reset(int ID) {
  boolean e = false;
  //global delete
  if (key_backspace) e = true;
  //SPECIFIC DELETE when the paramer button of contrôleur is ON
  else if (key_delete) if (action[ID] || parameter[ID]) e = true ;
  return e;
}













/**
Class Romanesco_manager
v 1.2.1
inspired by Andreas Gysin work for The Abyss Project
@see https://github.com/ertdfgcvb/TheAbyss
*/
class Romanesco_manager {
  private ArrayList<Romanesco>RomanescoList;
  private ArrayList<Class>item_list;

  PApplet parent;
  String item_class_name [];
  int num_classes;
  Romanesco_manager(PApplet parent) {
    this.parent = parent;
    RomanescoList = new ArrayList<Romanesco>() ;
    //scan the existant classes
    item_list = scan_classes(parent,"Romanesco");
  }

  //ADD CLASSES
  private ArrayList<Class> scan_classes(PApplet parent, String super_Class_name) {
    ArrayList<Class> classes = new ArrayList<Class>();

    Class[] c = parent.getClass().getDeclaredClasses();
    
    //create the index table
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && c[i].getSuperclass().getSimpleName().equals(super_Class_name)) {
        classes.add(c[i]);
        num_classes = classes.size() ;
      }
    }
    create_index(num_classes) ;
    
    //init the String info
    item_class_name = new String[num_classes] ;
    for (int i = 0 ; i <item_class_name.length ; i++) item_class_name[i] =("");
    
    //add class in Romanesco, plus add info in the String for the index
    int numObjectRomanesco = 0 ;
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && c[i].getSuperclass().getSimpleName().equals(super_Class_name)) {
        item_class_name[numObjectRomanesco] = c[i].getSimpleName() ;
        numObjectRomanesco += 1 ;
      }
    }
    begin_index() ;
    return classes;  
  }

  //create the canvas index
  void create_index(int num) {
    index_item = new Table() ;
    index_item.addColumn("Library Order");
    index_item.addColumn("Name");
    index_item.addColumn("ID");
    index_item.addColumn("Group");
    index_item.addColumn("Version");
    index_item.addColumn("Author");
    index_item.addColumn("Class name");
    index_item.addColumn("Pack");
    index_item.addColumn("Render");
    index_item.addColumn("Costume");
    index_item.addColumn("Mode");
    
    
    // add row
    row_index_item = new TableRow [num] ;
    for(int i = 0 ; i < row_index_item.length ; i++) {
      row_index_item[i] = index_item.addRow();
    }
    
    // create var for info object, need to be create here
    int num_plus_one = num+1;
    item_ID = new int[num_plus_one];
    item_name = new String[num_plus_one];
    item_author = new String[num_plus_one];
    item_version = new String[num_plus_one];
    item_pack = new String[num_plus_one];
    item_info = new String[num_plus_one];
    // init var
    for ( int i = 0 ; i< num_plus_one ; i++ ) {
      item_name [i] = "My name is Nobody";
      item_info [i] = "Sorry nobody write about me!";
      item_ID [i] = 0;
    }
  }

  // put information in the index
  void begin_index() {
    for(int i = 0 ; i < row_index_item.length ; i++) {
      row_index_item[i].setString("Class name",item_class_name[i]);
      row_index_item[i].setInt("Library Order",i+1);
    }
  }

  /**
  EXTERNAL  VOID
  */
  void finish_index() {
  // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      Romanesco item = (Romanesco) RomanescoList.get(i);
      row_index_item[i].setString("Name",item.item_name);
      row_index_item[i].setInt("ID",item.ID_item);
      row_index_item[i].setInt("Group",item.ID_group);
      row_index_item[i].setString("Author",item.item_author);
      row_index_item[i].setString("Version",item.item_version);
      row_index_item[i].setString("Renderer",item.romanesco_renderer);
      row_index_item[i].setString("Pack",item.item_pack);
      row_index_item[i].setString("Costume",item.item_costume);
      row_index_item[i].setString("Mode",item.item_mode);
      row_index_item[i].setString("Slider",item.item_slider);
    }
    saveTable(index_item, preference_path+"index_romanesco_items.csv"); 
  }
  // ADD info for the user
  void write_info_user() {
    // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++) {
      Romanesco item = (Romanesco) RomanescoList.get(i);
      item_ID[item.ID_item] = item.ID_item;
      item_name[item.ID_item] = item.item_name;
      item_author[item.ID_item] = item.item_author;
      item_version[item.ID_item] = item.item_version;
      item_pack[item.ID_item] = item.item_pack;
    }
  }

  int id_item_from_library(int index) {
    int id = -1 ;
    if(index < RomanescoList.size()) {
      Romanesco item = (Romanesco) RomanescoList.get(index);
      id = item.ID_item;
    }  
    return id;
  }

  public Romanesco get(int index) {
    if(index < RomanescoList.size()) {
      return RomanescoList.get(index);
    } else {
      return null;
    }  
  }
  
  
  public int size() {
    return item_list.size();
  }
  
  
  //ADD OBJECT from the sub-classes
  public void add_item_romanesco() {
    int n = item_list.size();
    for( int i = 0 ; i < n ; i++) {
      add_item(i);
    }
  }

  //
  public Romanesco add_item(int i) {
    if (i < 0 || i >= item_list.size()) {
      return null;
    }
    
    Romanesco class_romanesco_item = null;
    try {
      Class c = item_list.get(i);
      Constructor[] constructors = c.getConstructors();
      class_romanesco_item = (Romanesco)constructors[0].newInstance(parent);
      class_romanesco_item.set_id(i+1);
      class_romanesco_item.set_group(1);
    }
    catch (InvocationTargetException e) {
      System.out.println(e);
    } 
    catch (InstantiationException e) {
      System.out.println(e);
    } 
    catch (IllegalAccessException e) {
      System.out.println(e);
    } 
    //add object 
    if (class_romanesco_item != null) {
      add_romaneco_item(class_romanesco_item);
    }
    return class_romanesco_item;
  }
  
  // finalization of adding object
  private void add_romaneco_item(Romanesco item) {
    item.set_item_romanesco(this);
    RomanescoList.add(item);
  }
  
  
  

  // SETUP
  public boolean init_items() {
    int num = 0 ;
    for (Romanesco item : RomanescoList) {
      motion[item.get_id()] = true;
      init_value_mouse[item.get_id()] = true;
      num++;
      item.setup();
      println("setup of", item.item_name, item.get_id(), "is done");
      if(pos_item_ref[item.get_id()] == null) {
        pos_item_ref[item.get_id()] = Vec3();
      }
      pos_item_ref[item.get_id()].set(item_setting_position[0][item.get_id()]);
    }

    if(num == RomanescoList.size()) {
      return true ;
    } else {
      return false;
    }
  }

  

  // DRAW
  public void show_item_3D(boolean movePos, boolean moveDir, boolean movePosAndDir) {
    // when you use the third order Romanesco understand the the first and the second are true
    if(movePosAndDir) {
      moveDir = true;
      movePos = true;
    }
    
    //the method
    if (show_item != null) {
      for (Romanesco item : RomanescoList) {
        if (show_item[item.get_id()]) {
          update_var_items(item.get_id());
          pushMatrix();
          add_ref_item(item.get_id());
          item_follower(item.get_id());
          if((key_v_long || reset_item_on_button_alert_is()) && action[item.get_id()]) {
            item_move(movePos, moveDir, item.get_id());
          }
          final_pos_item(item.get_id());
          item.draw();
          popMatrix();
        } else {
          if(movie[item.get_id()] != null) movie[item.get_id()].pause();
        }
      }
    }
  }


  public void show_item_2D() {
    for (Romanesco item : RomanescoList) {
      if (show_item[item.get_id()]) {
        item.draw_2D();
      } else {
        if(movie[item.get_id()] != null) movie[item.get_id()].pause();
      }
    }
  }
}

















