/**
* Tartan
v 0.0.2
*/
class Tartan extends Romanesco {
  public Tartan() {
    //from the index_objects.csv
    item_name = "Tartan" ;
    item_author  = "Stan le Punk";
    item_references = "";
    item_version = "Version 0.0.2";
    item_pack = "Tartan 2018-2018" ;
    item_costume = ""; // costume available from get_costume();
    item_mode = "Tartan/Strip";
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
    //size_z_is = true;
    // diameter_is = true;
    canvas_x_is = true;
    canvas_y_is = true;
    // canvas_z_is = true;
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
    quantity_is = true;
    // variety_is =true;
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
    // COL 4
    // grid_is = true;
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
    // here if you want code in 3D mode
    if(get_mode_name().equals("Tartan")) {
      tartan();
    } else if(get_mode_name().equals("Strip")) {
      strip();

    }
    info("info about the item","more","more");
  }
   /*
  void draw_2D() {
    // here if you want code in 2D mode
  }   
  */

  void tartan() {
    strip();

  }
  

  // int ref_num_strip;
  void strip() {
    int num_strip = (int)map(get_quantity()*get_quantity(),get_quantity_min(),get_quantity_max(),1,111);
    int w_strip = (int)get_size_x()*5;
    int h_strip = (int)get_size_y()*2;

    int space = (int)map(get_canvas_y(),get_canvas_y_min(),get_canvas_y_max(),h_strip,h_strip*(height*.1));
    int total_height = num_strip *(h_strip+space);
    float start_y = -(total_height*.5);
    // float start_x = -(w_strip*.5);
    float start_x = 0;
    rectMode(CENTER);
    aspect(get_fill(),get_stroke(),get_thickness());
    for(int i = 0 ; i < num_strip ; i++) {
      float x = start_x ;
      float y = start_y +(i*(h_strip+space));
      rect(x,y,w_strip,h_strip);
    }


  }
}















