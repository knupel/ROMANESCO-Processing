/**
Ballet
2018
v 0.0.1
*/
class FF extends Romanesco {
	public FF() {
		item_name = "Force Field";
		ID_item = 30;
		ID_group = 1 ;
		item_author  = "Stan le Punk";
		item_version = "Version 0.0.1";
		item_pack = "Romanesco 2018";
    item_costume = "";
    item_mode = "";

	  // hue_fill_is = true;
    // sat_fill_is = true;
    // bright_fill_is = true;
    // alpha_fill_is = true;
    hue_stroke_is = true;
    sat_stroke_is = true;
    bright_stroke_is = true;
    alpha_stroke_is = true;
    thickness_is = true;
    size_x_is = true;
    // size_y_is = true;
    //size_z_is = true;
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

    quantity_is = true;
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
    spectrum_is = true;
  }





  void setup() {
    setting_start_position(ID_item,0,0,height/2);
  }
  


  void draw() {
    int cell_size = (int)map(quantity_item[ID_item],0,1,height/10,2);
    if(get_cell_force_field() != cell_size) {
      set_cell_force_field(cell_size);
      println("cell ref",get_cell_force_field());
      init_force_field();
    }


    update_force_field_is(true);
    int c = stroke_item[ID_item];

    
    float thickness = thickness_item[ID_item];
    float scale = size_x_item[ID_item];
    float range = 0 ;
    if(reverse[ID_item]) {
      range = map(spectrum_item[ID_item],0,360,0,-1);
    } else {
      range = map(spectrum_item[ID_item],0,360,0,1);
    }
    Force_field ff = get_force_field();
    show_field(ff,scale,range,c,thickness);
  }



  /**
  SHOW FIELD
  */
  private void show_field(Force_field ff, float scale, float range_colour, int colour, float thickness) {
    if(ff != null) {
      Vec2 offset = Vec2(ff.get_resolution());
      offset.sub(ff.get_resolution()/2);
      //
      for (int x = 0; x < ff.cols; x++) {
        for (int y = 0; y < ff.rows; y++) {
          Vec2 pos = Vec2(x *ff.get_resolution(), y *ff.get_resolution());
          Vec2 dir = Vec2(ff.field[x][y].x,ff.field[x][y].y);
          if(ff.get_super_type() == r.STATIC) {
            float mag = ff.field[x][y].w;
            pattern_field(dir, mag, pos, ff.resolution *scale,range_colour,colour,thickness);
          } else {
            pos.add(offset);
            float mag = (float)Math.sqrt(dir.x*dir.x + dir.y*dir.y + dir.z*dir.z); ;
            pattern_field(dir, mag, pos, ff.resolution *scale,range_colour,colour,thickness);
          }
        }
      }
    }  
  }

  // Renders a vector object 'v' as an arrow and a position 'x,y'
  private void pattern_field(Vec2 dir, float mag, Vec2 pos, float scale, float range_colour, int c,float thickness) {
    Vec5 colorMode = Vec5(getColorMode());
    colorMode(HSB,1);

    pushMatrix();
    // Translate to position to render vector
    translate(pos);
    // Call vector heading function to get direction (note that pointing to the right is a heading of 0) and rotate
    rotate(dir.angle());
    // Calculate length of vector & scale it to be dir_vector or smaller if dir_vector
    float len = mag *scale;

    float max = range_colour *mag;

    // float value = map(abs(len), 0, scale,max,min);

    float hue = hue(c)+max;
    if(hue >= g.colorModeX) hue -= g.colorModeX;
    if(hue < 0) hue = (g.colorModeX +hue);
    float sat = saturation(c);
    float bright = brightness(c);
    float alpha = alpha(c);
    
    strokeWeight(thickness);
    noFill();
    stroke(hue,sat,bright,alpha);

    if(len > scale) len = scale ;
    line(0,0,len,0);

    popMatrix();

    colorMode(colorMode);
  }
}



















