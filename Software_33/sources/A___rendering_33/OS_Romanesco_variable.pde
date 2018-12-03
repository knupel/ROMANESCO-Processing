/**
Romanesco Manager
Prescene and Scene
2013-2018
v 1.5.0
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
String ROM_COORD_X,ROM_COORD_Y,ROM_COORD_Z = "";


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
  ROM_COORD_X = slider_name[3][5];
  ROM_COORD_Y = slider_name[3][6];
  ROM_COORD_Z = slider_name[3][7];
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














void update_font_item() {
  for(int i = 0 ; i < rpe_manager.size() ; i++) {
    Romanesco item = rpe_manager.get(i);
    item.set_font(current_font);
  }
}




//Update the var of the object
int which_movie_ref, which_bitmap_ref, which_shape_ref, which_text_ref;
void update_var_items(Romanesco item) {
  // Romanesco item = rpe_manager.get(ID);
  int id = item.get_id();
  // info
  item_info_display[id] = displayInfo?true:false;
  
  //initialization
  if(!init_value_mouse[id]) { 
    mouse[id] = mouse[0].copy();
    pen[id] = pen[0].copy();
    init_value_mouse[id] = true;
  }
  if(!init_value_controller[id]) {
    item.set_font(current_font);
    update_slider_value(item) ;
    init_value_controller[id] = true;
    which_bitmap[id] = which_bitmap[0];
    which_text[id] = which_text[0];
    which_shape[id] = which_shape[0];
    which_movie[id] = which_movie[0];
  }

  if(item.parameter_is()) {
    if(which_bitmap_ref != which_bitmap[0]) {
      which_bitmap[id] = which_bitmap[0];
      which_bitmap_ref = which_bitmap[0];
    }

    if(which_text_ref !=  which_text[0]) {
      which_text[id] = which_text[0];
      which_text_ref = which_text[0];
    }

    if(which_movie_ref !=  which_movie[0]) {
      which_movie[id] = which_movie[0];
      which_movie_ref = which_movie[0];
    }

    if(which_shape_ref !=  which_shape[0]) {
      which_shape[id] = which_shape[0];
      which_shape_ref = which_shape[0];
    }

    item.set_font(current_font);
    update_slider_value(item);
  }
  update_var_sound(item);
  
  if(item.action_is()){
    if(key_space_long) {
      pen[id].set(pen[0]);
      mouse[id].set(mouse[0]);
    }
    if (key_n || birth_button_alert_is()) item.switch_birth();
    if (key_x) item.switch_colour();
    if (key_d || dimension_button_alert_is()) item.switch_dimension();
    if (key_h) item.switch_horizon();
    if (key_m) item.switch_motion();
    if (key_o) item.switch_orbit();
    if (key_r) item.switch_reverse();
    if (key_f) item.switch_special();
    if (key_w) item.switch_wire();

    if (key_j)item.switch_fill();
    if (key_k) item.switch_stroke();

    clickLongLeft[id] = ORDER_ONE;
    clickLongRight[id] = ORDER_TWO;
    clickShortLeft[id] = clickShortLeft[0];
    clickShortRight[id] = clickShortRight[0];

    change_bitmap_from_pad(id);
    change_movie_from_pad(id);
    change_text_from_pad(id);
    change_svg_from_pad(id);

    if(item.motion_is()) {
      if(movie[id] != null) movie[id].loop();
    } else {
      if(movie[id] != null) movie[id].pause();
    }
  }
}




















Vec4 fill_raw_ref;
Vec4 stroke_raw_ref;
void change_slider_ref() {
  fill_raw_ref = Vec4(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw);
  stroke_raw_ref = Vec4(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw);
}

void update_slider_value(Romanesco item) {
  //Romanesco item = rpe_manager.get(ID);
  int id = item.get_id();
  boolean init = first_opening_item[id];
  
  // COL 1
  update_slider_value_aspect(init,item);
  if (size_x_raw != size_x_temp || !init) item.set_size_x(size_x_raw); 
  if (size_y_raw != size_y_temp || !init) item.set_size_y(size_y_raw); 
  if (size_z_raw != size_z_temp || !init) item.set_size_z(size_z_raw);
  if (diameter_raw != diameter_temp || !init) item.set_diameter(diameter_raw); 
  if (canvas_x_raw != canvas_x_temp || !init) item.set_canvas_x(canvas_x_raw); 
  if (canvas_y_raw != canvas_y_temp || !init) item.set_canvas_y(canvas_y_raw); 
  if (canvas_z_raw != canvas_z_temp || !init) item.set_canvas_z(canvas_z_raw);

  // COL 2
  if (frequence_raw != frequence_temp || !init) item.set_frequence(frequence_raw); 
  if (speed_x_raw != speed_x_temp || !init) item.set_speed_x(speed_x_raw); 
  if (speed_y_raw != speed_y_temp || !init) item.set_speed_y(speed_y_raw); 
  if (speed_z_raw != speed_z_temp || !init) item.set_speed_z(speed_z_raw);
  if (spurt_x_raw != spurt_x_temp || !init) item.set_spurt_x(spurt_x_raw); 
  if (spurt_y_raw != spurt_y_temp || !init) item.set_spurt_y(spurt_y_raw); 
  if (spurt_z_raw != spurt_z_temp || !init) item.set_spurt_z(spurt_z_raw);
  if (dir_x_raw != dir_x_temp || !init) item.set_dir_x(dir_x_raw); 
  if (dir_y_raw != dir_y_temp || !init) item.set_dir_y(dir_y_raw); 
  if (dir_z_raw != dir_z_temp || !init) item.set_dir_z(dir_z_raw);
  if (jitter_x_raw != jitter_x_temp || !init) item.set_jitter_x(jitter_x_raw); 
  if (jitter_y_raw != jitter_y_temp || !init) item.set_jitter_y(jitter_y_raw); 
  if (jitter_z_raw != jitter_z_temp || !init) item.set_jitter_z(jitter_z_raw);
  if (swing_x_raw != swing_x_temp || !init) item.set_swing_x(swing_x_raw); 
  if (swing_y_raw != swing_y_temp || !init) item.set_swing_y(swing_y_raw); 
  if (swing_z_raw != swing_z_temp || !init) item.set_swing_z(swing_z_raw);

  // COL 3
  if (quantity_raw != quantity_temp || !init) item.set_quantity(quantity_raw);
  if (variety_raw != variety_temp || !init) item.set_variety(variety_raw);
  if (life_raw != life_temp || !init) item.set_life(life_raw);
  if (flow_raw != flow_temp || !init) item.set_flow(flow_raw);
  if (quality_raw != quality_temp || !init) item.set_quality(quality_raw);
  if (area_raw != area_temp || !init) item.set_area(area_raw);
  if (angle_raw != angle_temp || !init) item.set_angle(angle_raw);
  if (scope_raw != scope_temp || !init) item.set_scope(scope_raw);
  if (scan_raw != scan_temp || !init) item.set_scan(scan_raw);
  if (alignment_raw != alignment_temp || !init) item.set_alignment(alignment_raw);
  if (repulsion_raw != repulsion_temp || !init) item.set_repulsion(repulsion_raw);
  if (attraction_raw != attraction_temp || !init) item.set_attraction(attraction_raw);
  if (density_raw != density_temp || !init) item.set_density(density_raw);
  if (influence_raw != influence_temp || !init) item.set_influence(influence_raw);
  if (calm_raw != calm_temp || !init) item.set_calm(calm_raw);
  if (spectrum_raw != spectrum_temp || !init) item.set_spectrum(spectrum_raw);

  // COL 4
  if (grid_raw != grid_temp || !init) item.set_grid(grid_raw);
  if (viscosity_raw != viscosity_temp || !init) item.set_viscosity(viscosity_raw);
  if (diffusion_raw != diffusion_temp || !init) item.set_diffusion(diffusion_raw);
  if (power_raw != power_temp || !init) item.set_power(power_raw);
  if (mass_raw != mass_temp || !init) item.set_mass(mass_raw);
  if (coord_x_raw != coord_x_temp || !init) item.set_coord_x(coord_x_raw); 
  if (coord_y_raw != coord_y_temp || !init) item.set_coord_y(coord_y_raw); 
  if (coord_z_raw != coord_z_temp || !init) item.set_coord_z(coord_z_raw);
  /** 
  make the obj has be never update in the future except by the moving slider 
  */
  first_opening_item[id] = true; 
}


void update_slider_value_aspect(boolean init, Romanesco item) {
  int id = item.get_id();
  if(FULL_RENDERING) {
    if(!init) {
      fill_item_ref[id] = Vec4(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw);
      fill_raw_ref = Vec4(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw);
      item.set_fill(color(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw));

      stroke_item_ref[id] = Vec4(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw);
      stroke_raw_ref = Vec4(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw);
      item.set_stroke(color(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw));  
    }
    
    // FILL part
    bVec4 fill_is = bVec4();
    // check hsba value
    if(fill_raw_ref.r != fill_hue_raw) fill_is.x = true;
    if(fill_raw_ref.g != fill_sat_raw) fill_is.y = true;
    if(fill_raw_ref.b != fill_bright_raw) fill_is.z = true;
    if(fill_raw_ref.a != fill_alpha_raw) fill_is.w = true;

    if(fill_is.x) {
      item.set_fill(color(fill_hue_raw,fill_item_ref[id].g,fill_item_ref[id].b,fill_item_ref[id].a));
      fill_item_ref[id] = color_HSBA(item.get_fill());
    }

    if(fill_is.y) {
      item.set_fill(color(fill_item_ref[id].r,fill_sat_raw,fill_item_ref[id].b,fill_item_ref[id].a));
      fill_item_ref[id] = color_HSBA(item.get_fill());
    }

    if(fill_is.z) {
      item.set_fill(color(fill_item_ref[id].r,fill_item_ref[id].g,fill_bright_raw,fill_item_ref[id].a));
      fill_item_ref[id] = color_HSBA(item.get_fill());
    }

    if(fill_is.w) {
      item.set_fill(color(fill_item_ref[id].r,fill_item_ref[id].g,fill_item_ref[id].b,fill_alpha_raw)); 
      fill_item_ref[id] = color_HSBA(item.get_fill());
    }

    // zero security value
    if(fill_item_ref[id].r == 0) {
      fill_item_ref[id].r = fill_hue_raw;
    }

    if(fill_item_ref[id].g == 0) {
      fill_item_ref[id].g = fill_sat_raw;
    }

    if(fill_item_ref[id].b == 0) {
      fill_item_ref[id].b = fill_bright_raw;
    }
    
    // STROKE part
    bVec4 stroke_is = bVec4();
    // check hsba value
    if(stroke_raw_ref.r != stroke_hue_raw) stroke_is.x = true;
    if(stroke_raw_ref.g != stroke_sat_raw) stroke_is.y = true;
    if(stroke_raw_ref.b != stroke_bright_raw) stroke_is.z = true;
    if(stroke_raw_ref.a != stroke_alpha_raw) stroke_is.w = true;
    

    if(stroke_is.x) {
      item.set_stroke(color(stroke_hue_raw,stroke_item_ref[id].g,stroke_item_ref[id].b,stroke_item_ref[id].a));
      stroke_item_ref[id] = color_HSBA(item.get_stroke());
    }

    if(stroke_is.y) {
      item.set_stroke(color(stroke_item_ref[id].r,stroke_sat_raw,stroke_item_ref[id].b,stroke_item_ref[id].a));
      stroke_item_ref[id] = color_HSBA(item.get_stroke());
    }

    if(stroke_is.z) {
      item.set_stroke(color(stroke_item_ref[id].r,stroke_item_ref[id].g,stroke_bright_raw,stroke_item_ref[id].a));
      stroke_item_ref[id] = color_HSBA(item.get_stroke());
    }

    if(stroke_is.w) {
      item.set_stroke(color(stroke_item_ref[id].r,stroke_item_ref[id].g,stroke_item_ref[id].b,stroke_alpha_raw)); 
      stroke_item_ref[id] = color_HSBA(item.get_stroke());
    }


    // zero security value
    if(stroke_item_ref[id].r == 0) {
      stroke_item_ref[id].r = stroke_hue_raw;
    }

    if(stroke_item_ref[id].g == 0) {
      stroke_item_ref[id].g = stroke_sat_raw;
    }

    if(stroke_item_ref[id].b == 0) {
      stroke_item_ref[id].b = stroke_bright_raw;
    }

    // thickness
    if (thickness_raw != thickness_temp || !init) {
      item.set_thickness(thickness_raw);
    }
  } else {
    // preview display
    item.set_fill(COLOR_FILL_ITEM_PREVIEW);
    item.set_stroke(COLOR_STROKE_ITEM_PREVIEW);
    item.set_thickness(THICKNESS_ITEM_PREVIEW);
  }
}







//
void update_var_sound(Romanesco item) {
  int id = item.get_id();
  if(item.sound_is()) {
    left[id] = left[0];// value(0,1)
    right[id] = right[0]; //float value(0,1)
    mix[id] = mix[0]; //   is average volume between the left and the right / float value(0,1)
    
    transient_value[0][id] = transient_value[0][0]; // is transient master detection on all spectrum : value 1,10 

    transient_value[1][id] = transient_value[1][0]; // is extra_bass transient detection by default : value 1,10 
    transient_value[2][id] = transient_value[2][0]; // is bass transient detection by default : value 1,10 
    transient_value[3][id] = transient_value[3][0]; // is medium transient detection by default : value 1,10 
    transient_value[4][id] = transient_value[4][0]; // is hight transient detection by default : value 1,10 


    tempo[id] = tempo[0]; // global speed of track  / float value(0,1)
    tempoBeat[id] = tempoBeat[0]; // speed of track calculate on the beat
    tempoKick[id] = tempoKick[0]; // speed of track calculate on the kick
    tempoSnare[id] = tempoSnare[0]; // speed of track calculate on the snare
    tempoHat[id] = tempoHat[0]; // speed of track calculte on the hat
    
    for (int i = 0 ; i <NUM_BANDS ; i++) {
      band[id][i] = band[0][i];
    }
  } else {
    left[id] = 1;// value(0,1)
    right[id] = 1; //float value(0,1)
    mix[id] = 1; //   is average volume between the left and the right / float value(0,1)
    
    transient_value[0][id] = 1; // is transient master detection on all spectrum : value 1,10 

    transient_value[1][id] = 1; // is extra_bass transient detection by default : value 1,10 
    transient_value[2][id] = 1; // is bass transient detection by default : value 1,10 
    transient_value[3][id] = 1; // is medium transient detection by default : value 1,10 
    transient_value[4][id] = 1; // is hight transient detection by default : value 1,10 
    
    tempo[id] = 1; // global speed of track  / float value(0,1)
    tempoBeat[id] = 1; // speed of track calculate on the beat
    tempoKick[id] = 1; // speed of track calculate on the kick
    tempoSnare[id] = 1; // speed of track calculate on the snare
    tempoHat[id] = 1; // speed of track calculte on the hat
    
    for (int i = 0 ; i < NUM_BANDS ; i++) {
      band[id][i] = 1 ;
    }
  }
}












// RESET list and item
boolean reset(Romanesco item) {
  boolean state = false;
  //global delete
  if (key_backspace) state = true;
  //SPECIFIC DELETE when the paramer button of contrôleur is ON
  else if (key_delete) if (item.action_is() || item.parameter_is()) state = true ;
  return state;
}
























