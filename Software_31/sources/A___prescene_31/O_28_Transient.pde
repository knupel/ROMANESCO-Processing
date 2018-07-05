/**
Transient
2018
v 0.0.2
Inspirated by Nature of Code of Daniel Shiffman
*/
/*
* @see https://www.youtube.com/watch?v=f0lkz2gSsIk&list=PLRqwX-V7Uu6ZiZxtDDRCi6uhfTH4FilpH&index=15
* @see https://en.wikipedia.org/wiki/Lorenz_system
*/
class Transient extends Romanesco {
	public Transient() {
		item_name = "Transient";
		ID_item = 28 ;
		ID_group = 1 ;
		item_author  = "Stan le Punk";
		item_version = "Version 0.0.1";
		item_pack = "Base 2018";
    item_costume = "";
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
    // size_y_is = true;
    // size_z_is = true;
    // font_size_is = true;
    // canvas_x_is = true;
    // canvas_y_is = true;
    // canvas_z_is = true;

    // reactivity_is = true;
    // speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    // dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    // jit_z_is = true;
    // swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    // num_is = true;
    // variety_is = true;
    // life_is = true;
    // flow_is = true;
    // quality_is = true;
    // area_is = true;
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
    setting_start_position(ID_item, width/2, height/2, 0) ;
  }


  iVec3 [] size ;
	void draw() {
    int shape_num = 4 ;
    if(size == null || size.length != shape_num) {
      size = new iVec3 [shape_num];
      for(int i = 0 ; i < size.length ; i++) size[i] = iVec3(height/5);
    }

    float dist = width /(shape_num+1);
    iVec2 pos = iVec2() ;
    for(int i = 0 ; i < shape_num ;i++) {
      int step = (i+1);
      pos.x = int(dist *step);
      ellipse(pos,size[i]);
    }
  }
}












