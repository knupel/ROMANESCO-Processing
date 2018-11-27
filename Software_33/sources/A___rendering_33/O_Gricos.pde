/**
* Gricos
* the tab is the template that you can duplicate to add the item you want in your Romanesco.
* You must change the class name and this one must be unique.
v 0.0.1
*/
class Gricos extends Romanesco {
  public Gricos() {
    //from the index_objects.csv
    item_name = "Gricos" ;
    item_author  = "Stan le Punk";
    item_references = "";
    item_version = "Version 0.0.1";
    item_pack = "Base 2018-2018" ;
    item_costume = "point/ellipse/triangle/rect/cross/pentagon/Star 5/Star 7/Super Star 8/Super Star 12"; // costume available from get_costume();
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
    canvas_x_is = true;
    canvas_y_is = true;
    canvas_z_is = true;
    // COL 2
    // frequence_is = true;
    // speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    //dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
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
    grid_is = true;
    // viscosity_is = true;
    // diffusion_is = true;
    // power_is = true;
    // mass_is = true;

  }

  void setup() {
    // give the starting position of your item on the 3D grid
    setting_start_position(ID_item,width/2,height/2,0);
  }
  
  //DRAW
  void draw() {
    iVec3 canvas = round(map(get_canvas(),canvas_x_min_max.x,canvas_x_min_max.y,1,11));
    aspect(get_fill(),get_stroke(),get_thickness());
    // iVec3 [][][] grid = new iVec3[canvas.x][canvas.y][canvas.z];
    int cell = (int)map(get_grid(),grid_min_max.x,grid_min_max.y,5,height/10);
    for(int x = 0 ; x < canvas.x ; x++) {
      for(int y = 0 ; y < canvas.y ; y++) {
        for(int z = 0 ; z < canvas.z ; z++) {
          float pos_x = -((canvas.x*cell)/2)+(cell/2)+(cell*x);
          float pos_y = -((canvas.y*cell)/2)+(cell/2)+(cell*y);
          float pos_z = -((canvas.z*cell)/2)+(cell/2)+(cell*z);
          Vec3 pos = Vec3(pos_x,pos_y,pos_z);
          costume(pos,get_size(),get_costume());
        }
      }
    }

    // here if you want code in 3D mode
    info("info about the item","more","more");
  }  
}














