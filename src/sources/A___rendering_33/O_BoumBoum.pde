/**
Boum Boum / Transient detection
2018-2018
v 0.0.6
*/
class BoumBoum extends Romanesco {
	public BoumBoum() {
		item_name = "BoumBoum";
		item_author  = "Stan le Punk";
		item_version = "Version 0.0.6";
		item_pack = "Base 2018-2018";
    item_costume = "ellipse/triangle/rect/cross/pentagon/Star 5/Star 7/Super Star 8/Super Star 12";
    item_mode = "";

	  hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = true;
    size_y_is = true;
    size_z_is = true;
    // diameter_is = true;
    canvas_x_is = true;
    // canvas_y_is = true;
    // canvas_z_is = true;

    // frequence_is = true;
    speed_x_is = true;
    speed_y_is = true;
    speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    dir_x_is = true;
    dir_y_is = true;
    dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    // jit_z_is = true;
    // swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    // quantity_is = true;
    // variety_is = true;
    // life_is = true;
    // flow_is = true;
    // quality_is = true;
    area_is = true;
    // angle_is = true;
    // scope_is = true;
    // scan_is = true;
    // align_is = true;
    // repulsion_is = true;
    // attraction_is = true;
    // density_is = true;
    // influence_is = true;
    // calm_is = true;
    // spectrum_is = true;
  }





  void setup() {
    setting_start_position(ID_item,0,0,0);
  }


  vec3 [] size ;
  vec3 speed ;
	void draw() {
    int shape_num = 4 ;
    // size shape
    if(size == null || size.length != shape_num) {
      size = new vec3 [shape_num];
      for(int i = 0 ; i < size.length ; i++) {
        size[i] = vec3(get_size_x(),get_size_y(),get_size_z());
        size[i].mult(.3);
      }
    } else {
      for(int i = 0 ; i < size.length ; i++) {
        size[i].set(get_size_x(),get_size_y(),get_size_z());
      }
    }

    
    float dist_between_shape = get_canvas_x() /(shape_num+1);
    // give position for the shapes centered 
    float offset_x = (get_canvas_x() /2) -(width/2);
    vec3 pos = vec3(-offset_x,height/2,0);
    vec3 dir = vec3(get_dir());

    
    // speed
    if(motion_is()) {
      vec3 inc_speed = vec3(get_speed_x(),get_speed_y(),get_speed_z());
      inc_speed.mult(inc_speed);
      if(speed == null) {
        speed = vec3(inc_speed);
      } else {
        speed.add(inc_speed);
      }   
    }
    dir.add(speed);


    for(int i = 0 ; i < shape_num ;i++) {
      int step = (i+1);
      vec3 temp_pos = pos.copy();
      temp_pos.x += int(dist_between_shape *step);
      vec3 temp_size = size[i].copy();
      temp_size.mult(transient_value[i+1][ID_item]);
      fill(get_fill());
      stroke(get_stroke());
      strokeWeight(get_thickness());
      set_ratio_costume_size(map(get_area(),width*.1, width*TAU,0,1));
      costume(temp_pos, temp_size, dir,get_costume());
    }
  }
}












