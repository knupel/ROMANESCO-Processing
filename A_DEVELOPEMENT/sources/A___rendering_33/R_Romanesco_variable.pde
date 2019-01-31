/**
Romanesco Manager
Prescene and Scene
2013-2018
v 1.6.1
*/
Romanesco_manager rpe_manager;

void romanesco_build_item() {
  rpe_manager = new Romanesco_manager(this);
  rpe_manager.add_item();
  rpe_manager.set_item(preference_path+"gui_info_en.csv");
  rpe_manager.finish_index();
  rpe_manager.write_info_user();
  println("Romanesco setup done");
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
    if (key_f) item.switch_follow();
    if (key_r) item.switch_reverse();
    if (key_w) item.switch_wire();
    if (key_s) item.switch_special();


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






















void update_slider_value(Romanesco item) {
  //Romanesco item = rpe_manager.get(ID);
  int id = item.get_id();
  boolean init = first_opening_item[id];
  
  // COL 1
  update_slider_value_aspect(init,item);
  if (size_x_raw != size_x_ref || !init) item.set_size_x(size_x_raw,2,0); 
  if (size_y_raw != size_y_ref || !init) item.set_size_y(size_y_raw,2,0); 
  if (size_z_raw != size_z_ref || !init) item.set_size_z(size_z_raw,2,0);
  if (diameter_raw != diameter_ref || !init) item.set_diameter(diameter_raw,0,0); 
  if (canvas_x_raw != canvas_x_ref || !init) item.set_canvas_x(canvas_x_raw,2,0); 
  if (canvas_y_raw != canvas_y_ref || !init) item.set_canvas_y(canvas_y_raw,2,0); 
  if (canvas_z_raw != canvas_z_ref || !init) item.set_canvas_z(canvas_z_raw,2,0);

  // COL 2
  if (frequence_raw != frequence_ref || !init) item.set_frequence(frequence_raw,0,0); 
  if (speed_x_raw != speed_x_ref || !init) item.set_speed_x(speed_x_raw,2,0); 
  if (speed_y_raw != speed_y_ref || !init) item.set_speed_y(speed_y_raw,2,0); 
  if (speed_z_raw != speed_z_ref || !init) item.set_speed_z(speed_z_raw,2,0);
  if (spurt_x_raw != spurt_x_ref || !init) item.set_spurt_x(spurt_x_raw,2,0); 
  if (spurt_y_raw != spurt_y_ref || !init) item.set_spurt_y(spurt_y_raw,2,0); 
  if (spurt_z_raw != spurt_z_ref || !init) item.set_spurt_z(spurt_z_raw,2,0);
  if (dir_x_raw != dir_x_ref || !init) item.set_dir_x(dir_x_raw,0,0); 
  if (dir_y_raw != dir_y_ref || !init) item.set_dir_y(dir_y_raw,0,0); 
  if (dir_z_raw != dir_z_ref || !init) item.set_dir_z(dir_z_raw,0,0);
  if (jitter_x_raw != jitter_x_ref || !init) item.set_jitter_x(jitter_x_raw,0,0); 
  if (jitter_y_raw != jitter_y_ref || !init) item.set_jitter_y(jitter_y_raw,0,0); 
  if (jitter_z_raw != jitter_z_ref || !init) item.set_jitter_z(jitter_z_raw,0,0);
  if (swing_x_raw != swing_x_ref || !init) item.set_swing_x(swing_x_raw,0,0); 
  if (swing_y_raw != swing_y_ref || !init) item.set_swing_y(swing_y_raw,0,0); 
  if (swing_z_raw != swing_z_ref || !init) item.set_swing_z(swing_z_raw,0,0);

  // COL 3
  if (quantity_raw != quantity_ref || !init) item.set_quantity(quantity_raw,0,0);
  if (variety_raw != variety_ref || !init) item.set_variety(variety_raw,0,0);
  if (life_raw != life_ref || !init) item.set_life(life_raw,0,0);
  if (flow_raw != flow_ref || !init) item.set_flow(flow_raw,0,0);
  if (quality_raw != quality_ref || !init) item.set_quality(quality_raw,0,0);
  if (area_raw != area_ref || !init) item.set_area(area_raw,2,0);
  if (angle_raw != angle_ref || !init) item.set_angle(angle_raw,0,0);
  if (scope_raw != scope_ref || !init) item.set_scope(scope_raw,0,0);
  if (scan_raw != scan_ref || !init) item.set_scan(scan_raw,0,0);
  if (alignment_raw != alignment_ref || !init) item.set_alignment(alignment_raw,0,0);
  if (repulsion_raw != repulsion_ref || !init) item.set_repulsion(repulsion_raw,0,0);
  if (attraction_raw != attraction_ref || !init) item.set_attraction(attraction_raw,0,0);
  if (density_raw != density_ref || !init) item.set_density(density_raw,0,0);
  if (influence_raw != influence_ref || !init) item.set_influence(influence_raw,0,0);
  if (calm_raw != calm_ref || !init) item.set_calm(calm_raw,0,0);
  if (spectrum_raw != spectrum_ref || !init) item.set_spectrum(spectrum_raw,0,0);

  // COL 4
  if (grid_raw != grid_ref || !init) item.set_grid(grid_raw,0,0);
  if (viscosity_raw != viscosity_ref || !init) item.set_viscosity(viscosity_raw,0,0);
  if (diffusion_raw != diffusion_ref || !init) item.set_diffusion(diffusion_raw,0,0);
  if (power_raw != power_ref || !init) item.set_power(power_raw,0,0);
  if (mass_raw != mass_ref || !init) item.set_mass(mass_raw,0,0);
  if (coord_x_raw != coord_x_ref || !init) item.set_coord_x(coord_x_raw,0,0); 
  if (coord_y_raw != coord_y_ref || !init) item.set_coord_y(coord_y_raw,0,0); 
  if (coord_z_raw != coord_z_ref || !init) item.set_coord_z(coord_z_raw,0,0);
  /** 
  make the obj has be never update in the future except by the moving slider 
  */
  first_opening_item[id] = true; 
}

vec4 fill_local_ref;
vec4 stroke_local_ref;
void change_slider_ref() {
  fill_local_ref = vec4(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw);
  stroke_local_ref = vec4(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw);
}


void update_slider_value_aspect(boolean init, Romanesco item) {
  int id = item.get_id();
  if(FULL_RENDERING) {
    if(!init) {
      fill_item_ref[id] = vec4(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw);
      fill_local_ref = vec4(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw);
      item.set_fill(color(fill_hue_raw,fill_sat_raw,fill_bright_raw,fill_alpha_raw));

      stroke_item_ref[id] = vec4(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw);
      stroke_local_ref = vec4(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw);
      item.set_stroke(color(stroke_hue_raw,stroke_sat_raw,stroke_bright_raw,stroke_alpha_raw));  
    }
    
    // FILL part
    bvec4 fill_is = bvec4();
    // check hsba value
    if(fill_local_ref.r != fill_hue_raw) fill_is.x = true;
    if(fill_local_ref.g != fill_sat_raw) fill_is.y = true;
    if(fill_local_ref.b != fill_bright_raw) fill_is.z = true;
    if(fill_local_ref.a != fill_alpha_raw) fill_is.w = true;

    if(fill_is.x) {
      item.set_fill(color(fill_hue_raw,fill_item_ref[id].g,fill_item_ref[id].b,fill_item_ref[id].a));
      fill_item_ref[id] = color_hsba(item.get_fill());
    }

    if(fill_is.y) {
      item.set_fill(color(fill_item_ref[id].r,fill_sat_raw,fill_item_ref[id].b,fill_item_ref[id].a));
      fill_item_ref[id] = color_hsba(item.get_fill());
    }

    if(fill_is.z) {
      item.set_fill(color(fill_item_ref[id].r,fill_item_ref[id].g,fill_bright_raw,fill_item_ref[id].a));
      fill_item_ref[id] = color_hsba(item.get_fill());
    }

    if(fill_is.w) {
      item.set_fill(color(fill_item_ref[id].r,fill_item_ref[id].g,fill_item_ref[id].b,fill_alpha_raw)); 
      fill_item_ref[id] = color_hsba(item.get_fill());
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
    bvec4 stroke_is = bvec4();
    // check hsba value
    if(stroke_local_ref.r != stroke_hue_raw) stroke_is.x = true;
    if(stroke_local_ref.g != stroke_sat_raw) stroke_is.y = true;
    if(stroke_local_ref.b != stroke_bright_raw) stroke_is.z = true;
    if(stroke_local_ref.a != stroke_alpha_raw) stroke_is.w = true;
    

    if(stroke_is.x) {
      item.set_stroke(color(stroke_hue_raw,stroke_item_ref[id].g,stroke_item_ref[id].b,stroke_item_ref[id].a));
      stroke_item_ref[id] = color_hsba(item.get_stroke());
    }

    if(stroke_is.y) {
      item.set_stroke(color(stroke_item_ref[id].r,stroke_sat_raw,stroke_item_ref[id].b,stroke_item_ref[id].a));
      stroke_item_ref[id] = color_hsba(item.get_stroke());
    }

    if(stroke_is.z) {
      item.set_stroke(color(stroke_item_ref[id].r,stroke_item_ref[id].g,stroke_bright_raw,stroke_item_ref[id].a));
      stroke_item_ref[id] = color_hsba(item.get_stroke());
    }

    if(stroke_is.w) {
      item.set_stroke(color(stroke_item_ref[id].r,stroke_item_ref[id].g,stroke_item_ref[id].b,stroke_alpha_raw)); 
      stroke_item_ref[id] = color_hsba(item.get_stroke());
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
    if (thickness_raw != thickness_ref || !init) {
      item.set_thickness(thickness_raw,0,0);
    }
  } else {
    // preview display
    item.set_fill(COLOR_FILL_ITEM_PREVIEW);
    item.set_stroke(COLOR_STROKE_ITEM_PREVIEW);
    item.set_thickness(THICKNESS_ITEM_PREVIEW,0,0);
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
























