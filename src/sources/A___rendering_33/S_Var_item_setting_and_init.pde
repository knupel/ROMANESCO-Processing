/**
* INIT VAR 
*/
void init_variable_item_min_max() {
  float min = 0;
  float max = width;
  
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

    item.set_thickness_min_max(0,MAX_VALUE_SLIDER,min,max*.01);
    item.set_size_x_min_max(0,MAX_VALUE_SLIDER,min,max);
    item.set_size_y_min_max(0,MAX_VALUE_SLIDER,min,max);
    item.set_size_z_min_max(0,MAX_VALUE_SLIDER,min,max);
    item.set_diameter_min_max(0,MAX_VALUE_SLIDER,min,max);

    item.set_canvas_x_min_max(0,MAX_VALUE_SLIDER,min,max);
    item.set_canvas_y_min_max(0,MAX_VALUE_SLIDER,min,max);
    item.set_canvas_z_min_max(0,MAX_VALUE_SLIDER,min,max);

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
    
    item.set_area_min_max(0,MAX_VALUE_SLIDER,min,max);
    item.set_angle_min_max(0,MAX_VALUE_SLIDER,0,TAU);
    item.set_scope_min_max(0,MAX_VALUE_SLIDER,min,max);
    item.set_scan_min_max(0,MAX_VALUE_SLIDER,0,TAU);

    item.set_alignment_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_repulsion_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_attraction_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_density_min_max(0,MAX_VALUE_SLIDER,0,1);

    item.set_influence_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_calm_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_spectrum_min_max(0,MAX_VALUE_SLIDER,0,360);
    // COL 4
    item.set_grid_min_max(0,MAX_VALUE_SLIDER,min,max);
    item.set_viscosity_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_diffusion_min_max(0,MAX_VALUE_SLIDER,0,1);

    item.set_power_min_max(0,MAX_VALUE_SLIDER,0,1);
    item.set_mass_min_max(0,MAX_VALUE_SLIDER,0,1);

    item.set_amplitude_min_max(0,MAX_VALUE_SLIDER,0,1);

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
      item.set_canvas_raw(width *.5);

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

      item.set_area_raw(width *.5);
      item.set_angle_raw(0);
      item.set_scope_raw(width *.5);
      item.set_scan_raw(PI/2);

      item.set_alignment_raw(0);
      item.set_repulsion_raw(0);
      item.set_attraction_raw(0);
      item.set_density_raw(0);

      item.set_influence_raw(0);
      item.set_calm_raw(0);
      item.set_spectrum_raw(0);

      item.set_grid_raw(width *.5);
      item.set_viscosity_raw(0);
      item.set_diffusion_raw(0);

      item.set_power_raw(0);
      item.set_mass_raw(0);

      item.set_amplitude_raw(0);

      item.set_coord_raw(0);
    }
   
  }
    // init global var for the color obj preview mode display
  COLOR_FILL_ITEM_PREVIEW = color(0,0,100,30); 
  COLOR_STROKE_ITEM_PREVIEW = color(0,0,100,30);
}
