/**
Romanesco Manager
Prescene and Scene
2013-2018
v 1.3.0
*/
Romanesco_manager rpe_manager;
// col 0
String ROM_HUE_FILL, ROM_SAT_FILL,ROM_BRIGHT_FILL, ROM_ALPHA_FILL = "";
String ROM_HUE_STROKE,ROM_SAT_STROKE,ROM_BRIGHT_STROKE,ROM_ALPHA_STROKE = "";
String ROM_THICKNESS = "";
String ROM_SIZE_X,ROM_SIZE_Y,ROM_SIZE_Z = "";
String ROM_DIAMETER = "";
String ROM_CANVAS_X,ROM_CANVAS_Y,ROM_CANVAS_Z = "";
// col 1
String ROM_FREQUENCE = "";
String ROM_SPEED_X,ROM_SPEED_Y,ROM_SPEED_Z = "";
String ROM_SPURT_X,ROM_SPURT_Y,ROM_SPURT_Z = "";
String ROM_DIR_X,ROM_DIR_Y,ROM_DIR_Z = "";
String ROM_JIT_X,ROM_JIT_Y,ROM_JIT_Z = "j";
String ROM_SWIWG_X,ROM_SWIWG_Y,ROM_SWIWG_Z = "";
// col 2
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
// col 3
String ROM_GRID = "";
String ROM_VISCOSITY = "";
String ROM_DIFFUSION = "";
/*
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
*/

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
  // col A
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
  // col B
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
  // col C
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
  // col D
  ROM_GRID = slider_name[3][0];
  ROM_VISCOSITY = slider_name[3][1];
  ROM_DIFFUSION = slider_name[3][2];
}

//Update the var of the object
void update_var_items(int ID) {
  //initialization
  if(!init_value_mouse[ID]) { 
    mouse[ID] = mouse[0].copy() ;
    pen[ID] = pen[0].copy() ;
    init_value_mouse[ID] = true ;
  }
  if(!init_value_controller[ID]) {
    font_item[ID] = font_library ;
    path_font_item[ID] = path_font_library[0] ;
    update_slider_value(ID) ;
    init_value_controller[ID] = true ;
    which_bitmap[ID] = which_bitmap[0] ;
    which_text[ID] = which_text[0] ;
    which_shape[ID] = which_shape[0] ;
    which_movie[ID] = which_movie[0] ;
  }
  
  // info
  item_info_display[ID] = displayInfo?true:false ;
  
  if(parameter[ID]) {
    which_bitmap[ID] = which_bitmap[0] ;
    which_text[ID] = which_text[0] ;
    which_shape[ID] = which_shape[0] ;
    which_movie[ID] = which_movie[0] ;
    font_item[ID] = font_library ;
    update_slider_value(ID) ;
  }
  update_var_sound(ID) ;
  
  if(action[ID] ){
    if(key_space_long) {
      pen[ID].set(pen[0]) ;
      mouse[ID].set(mouse[0]) ;
    }
    if (key_n) birth[ID] = !birth[ID] ;
    if (key_x) colour[ID] = !colour[ID] ;
    if (key_d) dimension[ID] = !dimension[ID] ;
    if (key_h) horizon[ID] = !horizon[ID] ;
    if (key_m) motion[ID] = !motion[ID] ;
    if (key_o) orbit[ID] = !orbit[ID] ;
    if (key_r) reverse[ID] = !reverse[ID] ;
    if (key_f) special[ID] = !special[ID] ;
    if (key_w) wire[ID] = !wire[ID] ;

    if (key_j) fill_is[ID] = !fill_is[ID] ;
    if (key_k) stroke_is[ID] = !stroke_is[ID] ;

    clickLongLeft[ID] = ORDER_ONE ;
    clickLongRight[ID] = ORDER_TWO ;
    clickShortLeft[ID] = clickShortLeft[0] ;
    clickShortRight[ID] = clickShortRight[0] ;
  }
}





void update_slider_value(int ID) {
  boolean init = first_opening_item[ID];
  // col A
  if(FULL_RENDERING) {
    // fill obj
    if(!init ) fill_item[ID] = color(fill_hue_raw, fill_sat_raw, fill_bright_raw, fill_alpha_raw); 
    else if(fill_hue_temp != fill_hue_raw) fill_item[ID] = color(fill_hue_raw, saturation(fill_item[ID]), brightness(fill_item[ID]), alpha(fill_item[ID]));
    else if(fill_sat_temp != fill_sat_raw) fill_item[ID] = color(hue(fill_item[ID]), fill_sat_raw, brightness(fill_item[ID]), alpha(fill_item[ID])); 
    else if(fill_bright_temp != fill_bright_raw) fill_item[ID] = color(hue(fill_item[ID]),  saturation(fill_item[ID]), fill_bright_raw, alpha(fill_item[ID]));   
    else if(fill_alpha_temp != fill_alpha_raw) fill_item[ID] = color(hue(fill_item[ID]),  saturation(fill_item[ID]), brightness(fill_item[ID]), fill_alpha_raw);  
    // stroke obj
    if (!init) stroke_item[ID] = color (stroke_hue_raw, stroke_sat_raw, stroke_bright_raw, stroke_alpha_raw); 
    else if(stroke_hue_temp != stroke_hue_raw) stroke_item[ID] = color(stroke_hue_raw, saturation(stroke_item[ID]), brightness(stroke_item[ID]), alpha(stroke_item[ID]));
    else if(stroke_sat_temp != stroke_sat_raw) stroke_item[ID] = color(hue(stroke_item[ID]),stroke_sat_raw,brightness(stroke_item[ID]), alpha(stroke_item[ID])); 
    else if(stroke_bright_temp != stroke_bright_raw) stroke_item[ID] = color(hue(stroke_item[ID]),saturation(stroke_item[ID]), stroke_bright_raw, alpha(stroke_item[ID]));   
    else if(stroke_alpha_temp != stroke_alpha_raw) stroke_item[ID] = color(hue(stroke_item[ID]), saturation(stroke_item[ID]), brightness(stroke_item[ID]), stroke_alpha_raw);  
    // thickness
    if (thickness_raw != thickness_temp|| !init) thickness_item[ID] = thickness_raw;
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


  // col B
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

  // col C
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

  // col C
  if (grid_raw != grid_temp || !init) {
    grid_item[ID] = grid_raw;
  }

  if (viscosity_raw != viscosity_temp || !init) viscosity_item[ID] = viscosity_raw;
  if (diffusion_raw != diffusion_temp || !init) diffusion_item[ID] = diffusion_raw;
  /** 
  make the obj has be never update in the future except by the moving slider 
  */
  first_opening_item[ID] = true ; 

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
      band[ID][i] = band[0][i] ;
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
  private ArrayList<Romanesco>RomanescoList ;
  private ArrayList<Class>item_list;

  PApplet parent;
  String item_class_name [] ;
  int num_classes ;
  
  Romanesco_manager(PApplet parent) {
    this.parent = parent;
    RomanescoList = new ArrayList<Romanesco>() ;
    //scan the existant classes
    item_list = scan_classes(parent,"Romanesco");
  }
  
  //STEP ONE
  //ADD CLASSES
  private ArrayList<Class> scan_classes(PApplet parent, String super_Class_name) {
    ArrayList<Class> classes = new ArrayList<Class>();

    Class[] c = parent.getClass().getDeclaredClasses();
    
    //create the index table
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && c[i].getSuperclass().getSimpleName().equals(super_Class_name) ) {
        classes.add(c[i]);
        num_classes = classes.size() ;
      }
    }
    create_index(num_classes) ;
    
    //init the String info
    item_class_name = new String[num_classes] ;
    for ( int i = 0 ; i <item_class_name.length ; i++) item_class_name[i] =("") ;
    
    //add class in Romanesco, plus add info in the String for the index
    int numObjectRomanesco = 0 ;
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && c[i].getSuperclass().getSimpleName().equals(super_Class_name) ) {
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
      row_index_item[i] = index_item.addRow() ;
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
      item_name [i] = "My name is Nobody" ;
      item_info [i] = "Sorry nobody write about me!" ;
      item_ID [i] = 0 ;
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
  
  /*
  * rpe_manager.writeInfoUser() ;
  * use with in romanesco_setup() {}
  */
  //ADD info for the user
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
    if (i < 0 || i >= item_list.size()) return null;
    
    Romanesco f = null;
    try {
      Class c = item_list.get(i);
      Constructor[] constructors = c.getConstructors();
      f = (Romanesco) constructors[0].newInstance(parent);
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
    if (f != null) {
      add_romaneco_item(f);
    }
    return f;
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
          if(key_v_long && action[item.get_id()] ) {
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

























/**
Abstract CLASS ROMANESCO
v 0.0.5
2013-2018
*/
abstract class Romanesco implements Rope_Constants {
  protected String item_name, item_author, item_version, item_pack, romanesco_renderer, item_costume, item_mode, item_slider;
  protected int ID_item, ID_group;
  //object manager return
  Romanesco_manager item_romanesco;

  // slider
  // col 0
  protected boolean hue_fill_is;
  protected boolean sat_fill_is;
  protected boolean bright_fill_is;
  protected boolean alpha_fill_is;
  protected boolean hue_stroke_is;
  protected boolean sat_stroke_is;
  protected boolean bright_stroke_is;
  protected boolean alpha_stroke_is;
  protected boolean thickness_is;
  protected boolean size_x_is;
  protected boolean size_y_is;
  protected boolean size_z_is;
  protected boolean diameter_is;
  protected boolean canvas_x_is;
  protected boolean canvas_y_is;
  protected boolean canvas_z_is;
  // col 1
  protected boolean frequence_is;
  protected boolean speed_x_is;
  protected boolean speed_y_is;
  protected boolean speed_z_is;
  protected boolean spurt_x_is;
  protected boolean spurt_y_is;
  protected boolean spurt_z_is;
  protected boolean dir_x_is;
  protected boolean dir_y_is;
  protected boolean dir_z_is;
  protected boolean jit_x_is;
  protected boolean jit_y_is;
  protected boolean jit_z_is;
  protected boolean swing_x_is;
  protected boolean swing_y_is;
  protected boolean swing_z_is;
  // col 2
  protected boolean quantity_is;
  protected boolean variety_is;
  protected boolean life_is;
  protected boolean flow_is;
  protected boolean quality_is;
  protected boolean area_is;
  protected boolean angle_is;
  protected boolean scope_is;
  protected boolean scan_is;
  protected boolean align_is;
  protected boolean repulsion_is;
  protected boolean attraction_is;
  protected boolean density_is;
  protected boolean influence_is;
  protected boolean calm_is;
  protected boolean spectrum_is;
  // col 3
  protected boolean grid_is;
  protected boolean viscosity_is;
  protected boolean diffusion_is;

  
  public Romanesco() {
    item_name = "Unknown" ;
    item_author = "Anonymous";
    item_version = "Alpha";
    item_pack = "Base" ;
    romanesco_renderer = "classic" ;
    item_costume = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    item_mode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    item_slider = "" ;
    ID_group = 0 ;
    ID_item = 0 ;

    hue_fill_is = false;
    sat_fill_is = false;
  }
  
  //manager return
  void set_item_romanesco(Romanesco_manager item_romanesco) {
    this.item_romanesco = item_romanesco;
    if(!hue_fill_is) item_slider +="," ; else item_slider += (ROM_HUE_FILL +",");
    if(!sat_fill_is) item_slider +="," ; else item_slider +=(ROM_SAT_FILL+",");
    if(!bright_fill_is) item_slider +="," ; else item_slider +=(ROM_BRIGHT_FILL+",");
    if(!alpha_fill_is) item_slider +="," ; else item_slider +=(ROM_ALPHA_FILL+",");
    if(!hue_stroke_is) item_slider +="," ; else item_slider += (ROM_HUE_STROKE +",");
    if(!sat_stroke_is) item_slider +="," ; else item_slider +=(ROM_SAT_STROKE+",");
    if(!bright_stroke_is) item_slider +="," ; else item_slider +=(ROM_BRIGHT_STROKE+",");
    if(!alpha_stroke_is) item_slider +="," ; else item_slider +=(ROM_ALPHA_STROKE+",");
    if(!thickness_is) item_slider +="," ; else item_slider += (ROM_THICKNESS+",");
    if(!size_x_is) item_slider +="," ; else item_slider += (ROM_SIZE_X+",");
    if(!size_y_is) item_slider +="," ; else item_slider += (ROM_SIZE_Y+",");
    if(!size_z_is) item_slider +="," ; else item_slider += (ROM_SIZE_Z+",");
    if(!diameter_is) item_slider +="," ; else item_slider += (ROM_DIAMETER+",");
    if(!canvas_x_is) item_slider +="," ; else item_slider += (ROM_CANVAS_X+",");
    if(!canvas_y_is) item_slider +="," ; else item_slider += (ROM_CANVAS_Y+",");
    if(!canvas_z_is) item_slider +="," ; else item_slider += (ROM_CANVAS_Z+",");

    if(!frequence_is) item_slider +="," ; else item_slider += (ROM_FREQUENCE+",");
    if(!speed_x_is) item_slider +="," ; else item_slider += (ROM_SPEED_X+",");
    if(!speed_y_is) item_slider +="," ; else item_slider += (ROM_SPEED_Y+",");
    if(!speed_z_is) item_slider +="," ; else item_slider += (ROM_SPEED_Z+",");
    if(!spurt_x_is) item_slider +="," ; else item_slider += (ROM_SPURT_X+",");
    if(!spurt_y_is) item_slider +="," ; else item_slider += (ROM_SPURT_Y+",");
    if(!spurt_z_is) item_slider +="," ; else item_slider += (ROM_SPURT_Z+",");
    if(!dir_x_is) item_slider +="," ; else item_slider += (ROM_DIR_X+",");
    if(!dir_y_is) item_slider +="," ; else item_slider += (ROM_DIR_Y+",");
    if(!dir_z_is) item_slider +="," ; else item_slider += (ROM_DIR_Z+",");
    if(!jit_x_is) item_slider +="," ; else item_slider += (ROM_JIT_X+",");
    if(!jit_y_is) item_slider +="," ; else item_slider += (ROM_JIT_Y+",");
    if(!jit_z_is) item_slider +="," ; else item_slider += (ROM_JIT_Z+",");
    if(!swing_x_is) item_slider +="," ; else item_slider += (ROM_SWIWG_X+",");
    if(!swing_y_is) item_slider +="," ; else item_slider += (ROM_SWIWG_Y+",");
    if(!swing_z_is) item_slider +="," ; else item_slider += (ROM_SWIWG_Z+",");

    if(!quantity_is) item_slider +="," ; else item_slider += (ROM_QUANTITY+",");
    if(!variety_is) item_slider +="," ; else item_slider += (ROM_VARIETY+",");
    if(!life_is) item_slider +="," ; else item_slider += (ROM_LIFE+",");
    if(!flow_is) item_slider +="," ; else item_slider += (ROM_FLOW+",");
    if(!quality_is) item_slider +="," ; else item_slider += (ROM_QUALITY+",");
    if(!area_is) item_slider +="," ; else item_slider += (ROM_AREA+",");
    if(!angle_is) item_slider +="," ; else item_slider += (ROM_ANGLE+",");
    if(!scope_is) item_slider +="," ; else item_slider += (ROM_SCOPE+",");
    if(!scan_is) item_slider +="," ; else item_slider += (ROM_SCAN+",");
    if(!align_is) item_slider +="," ; else item_slider += (ROM_ALIGN+",");
    if(!repulsion_is) item_slider +="," ; else item_slider += (ROM_REPULSION+",");
    if(!attraction_is) item_slider +="," ; else item_slider += (ROM_ATTRACTION+",");
    if(!density_is) item_slider +="," ; else item_slider += (ROM_DENSITY+",");
    if(!influence_is) item_slider +="," ; else item_slider += (ROM_INFLUENCE+",");
    if(!calm_is) item_slider +="," ; else item_slider += (ROM_CALM+",");
    if(!spectrum_is) item_slider +="," ; else item_slider += (ROM_SPECTRUM+",");

    if(!grid_is) item_slider +="," ; else item_slider += (ROM_GRID+",");
    if(!viscosity_is) item_slider +="," ; else item_slider += (ROM_VISCOSITY+",");
    if(!diffusion_is) item_slider +="," ; else item_slider += (ROM_DIFFUSION+",");
  }
  

  //must must be declared in the sub-classes
  abstract void setup();
  abstract void draw();

  public void draw_2D() {

  }

  public int get_id() {
    return ID_item;
  }

  public int get_id_group() {
    return ID_group;
  }

  public String get_name() {
    return item_name;
  }

  public int get_costume() {
    String [] costume_split = new String[1];
    costume_split = split(item_costume,"/");

    String costume_romanesco = "unknow" ;
    if(costume_split[0] != null) {
      // printErr("int get_costume(): vient voir si costume[] existe ou si il se passe quelque chose ????");
      int target = costume_controller_selection[get_id()];
      costume_romanesco = costume_split[target];
    } 

    if(costume_romanesco.equals("point") || costume_romanesco.equals("POINT") || costume_romanesco.equals("Point")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = POINT_ROPE; 
      } else {
        costume[get_id()] = SPHERE_LOW_ROPE;
      }
    } else if(costume_romanesco.equals("line") || costume_romanesco.equals("LINE") || costume_romanesco.equals("Line")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = LINE_ROPE; 
      } else {
        costume[get_id()] = LINE_ROPE;
      }
    } else if(costume_romanesco.equals("ellipse") || costume_romanesco.equals("ELLIPSE") || costume_romanesco.equals("Ellipse") || costume_romanesco.equals("disc") || costume_romanesco.equals("DISC") || costume_romanesco.equals("Disc")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = ELLIPSE_ROPE; 
      } else {
        costume[get_id()] = SPHERE_MEDIUM_ROPE;
      }
    } else if(costume_romanesco.equals("triangle") || costume_romanesco.equals("TRIANGLE") || costume_romanesco.equals("Triangle")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = TRIANGLE_ROPE; 
      } else {
        costume[get_id()] = TETRAHEDRON_ROPE;
      }
    } else if(costume_romanesco.equals("rectangle") || costume_romanesco.equals("RECTANGLE") || costume_romanesco.equals("Rectangle") || costume_romanesco.equals("rect") || costume_romanesco.equals("RECT") || costume_romanesco.equals("Rect")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = RECT_ROPE; 
      } else {
        costume[get_id()] = BOX_ROPE;
      }
    } else if(costume_romanesco.equals("pentagon") || costume_romanesco.equals("PENTAGON") || costume_romanesco.equals("Pentagon")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = PENTAGON_ROPE; 
      } else {
        printErrTempo(60,"method select_costume(): No shape match in P3D with Pentagon");
        costume[get_id()] = PENTAGON_ROPE;
      }
    } else if(costume_romanesco.equals("cross") || costume_romanesco.equals("CROSS") || costume_romanesco.equals("Cross")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = CROSS_BOX_2_ROPE; 
      } else {
        costume[get_id()] = CROSS_BOX_3_ROPE;
      }
    } else if(costume_romanesco.equals("star 4") || costume_romanesco.equals("STAR 4") || costume_romanesco.equals("Star 4")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = STAR_4_ROPE; 
      } else {
        costume[get_id()] = STAR_4_ROPE;
      }
    } else if(costume_romanesco.equals("star 5") || costume_romanesco.equals("STAR 5") || costume_romanesco.equals("Star 5")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = STAR_5_ROPE; 
      } else {
        costume[get_id()] = STAR_5_ROPE;
      }
    } else if(costume_romanesco.equals("star 6") || costume_romanesco.equals("STAR 6") || costume_romanesco.equals("Star 6")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = STAR_6_ROPE; 
      } else {
        costume[get_id()] = STAR_6_ROPE;
      }
    } else if(costume_romanesco.equals("star 7") || costume_romanesco.equals("STAR 7") || costume_romanesco.equals("Star 7")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = STAR_7_ROPE; 
      } else {
        costume[get_id()] = STAR_7_ROPE;
      }
    }
    else if(costume_romanesco.equals("star 8") || costume_romanesco.equals("STAR 8") || costume_romanesco.equals("Star 8")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = STAR_8_ROPE; 
      } else {
        costume[get_id()] = STAR_8_ROPE;
      }
    } else if(costume_romanesco.equals("super star 8") || costume_romanesco.equals("SUPER STAR 8") || costume_romanesco.equals("Super Star 8")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = SUPER_STAR_8_ROPE; 
      } else {
        costume[get_id()] = SUPER_STAR_8_ROPE;
      }
    } else if(costume_romanesco.equals("super star 12") || costume_romanesco.equals("SUPER STAR 12") || costume_romanesco.equals("Super Star 12")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = SUPER_STAR_12_ROPE; 
      } else {
        costume[get_id()] = SUPER_STAR_12_ROPE;
      }
    } else if(costume_romanesco.equals("abc") || costume_romanesco.equals("ABC") || costume_romanesco.equals("Abc")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = TEXT_ROPE; 
      } else {
        costume[get_id()] = TEXT_ROPE;
      }
    } else if(costume_romanesco.equals("none") || costume_romanesco.equals("NONE") || costume_romanesco.equals("None") ||
              costume_romanesco.equals("nothing") || costume_romanesco.equals("NOTHING") || costume_romanesco.equals("Nothing") || 
              costume_romanesco.equals("null") || costume_romanesco.equals("NULL") || costume_romanesco.equals("Null")) {
      if(!dimension[get_id()]) {
        costume[get_id()] = NULL; 
      } else {
        costume[get_id()] = NULL;
      }
    } else {
      costume[get_id()] = NULL;
    }

    return costume[get_id()];
  }
}









