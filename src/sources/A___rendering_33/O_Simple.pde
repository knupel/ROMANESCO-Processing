/**
* Simple
* v 0.0.6
* 2018-2019
*/
class Simple extends Romanesco {
  public Simple() {
    //from the index_objects.csv
    item_name = "Simple" ;
    item_author  = "Stan le Punk";
    item_references = "";
    item_version = "Version 0.0.6";
    item_pack = "Simple 2018-2019" ;
    item_costume = "ellipse/triangle/rect/cross/pentagon/flower 5/flower 7/flower 12/flower 24/Star 5/Star 7/Super Star 8/Super Star 12"; // costume available from get_costume();
    item_mode = "";
    // define slider
    // COL 1
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
    // canvas_x_is = true;
    // canvas_y_is = true;
    // canvas_z_is = true;
    // COL 2
    // frequence_is = true;
    // speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    dir_x_is = true;
    dir_y_is = true;
    dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    // jit_z_is  = true;
    // swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;
    // COL 3
    // quantity_is = true;
    // variety_is =true;
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
    // COL 4
    // grid_is = true;
    // viscosity_is = true;
    // diffusion_is = true;
    // power_is = true;
    // mass_is = true;
    // amplitude_is = true;
  }

  void setup() {
    // give the starting position of your item on the 3D grid
    set_item_pos(width/2,height/2,0);
  }
  
  //DRAW
  void draw() {
    // here if you want code in 3D mode
    info("info about the item","more","more");
    aspect_is(fill_is(),stroke_is(),alpha_is());
    aspect(get_fill(),get_stroke(),get_thickness());
    set_ratio_costume_size(map(get_area(),get_area_min(),get_area_max(),0,1));
    costume(vec3(),get_size().mult(3),get_costume());
  }
/*
  void draw_2D() {
    // here if you want code in 2D mode
  } 
  */  
}















