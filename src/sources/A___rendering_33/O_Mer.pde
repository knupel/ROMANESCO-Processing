/**
* Wave
v 0.0.2
*/
class Mer extends Romanesco {
  public Mer() {
    //from the index_objects.csv
    item_name = "Mer" ;
    item_author  = "Stan le Punk";
    item_references = "";
    item_version = "Version 0.0.1";
    item_pack = "Base 2019-2019" ;
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
    //size_z_is = true;
    // diameter_is = true;
    canvas_x_is = true;
    canvas_y_is = true;
    // canvas_z_is = true;
    // COL 2
    // frequence_is = true;
    speed_x_is = true;
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

  int cols = 2;
  int rows = 2;
  Wave [] ani = new Wave[cols *rows];
  boolean build_sea_is;

  void setup() {
    // give the starting position of your item on the 3D grid
    setting_start_position(ID_item,width/2,height/2,0);
  }
  
  //DRAW
  
  void draw() {
    info("info about the item","more","more");
  }
  
  
  void draw_2D() {
    // here if you want code in 2D mode
    if(birth_is()) {
      build_sea_is = false;
      birth_is(false);
    }
    if(!build_sea_is) {
      float min_size_wave = 5;
      vec2 size_max_wave = vec2(50,50);
      float max_speed = 1;
      float start_hue_fill = get_fill_hue();
      build_sea_grid(min_size_wave,size_max_wave,max_speed,start_hue_fill);
      build_sea_is = true;
    }

    // show
    int cell_x = width/cols;
    int cell_y = height/rows;
    int offset_x = cell_x/2;
    int offset_y = cell_y/2;
    int count = 0;
    // push();
    // translate(width,0);
    // rotate(PI/2);
    println("direct",get_fill_hue(),get_fill_sat(),get_fill_bright(),get_fill_alpha());
    println("compute",hue(get_fill()),saturation(get_fill()),brightness(get_fill()),alpha(get_fill()));
    for(int i = 0; i < cols ; i++) {
      for(int j = 0 ; j < rows ; j++) {  
        int x = i * cell_x +offset_x;
        int y = j * cell_y +offset_y;
        ani[count].update();
        ani[count].apparence(get_fill_alpha(),get_stroke_alpha(),get_thickness());
        ani[count].render_shape(x,y,get_size_x(),get_costume());
        count++;
      }
    }
    // pop();



    // info("info about the item","more","more");
  }


  void build_sea_grid(float min, vec2 range, float max_speed, float start_hue) {
    for(int i = 0 ; i < ani.length ; i++) {
      ani[i] = new Wave();
      ani[i].set_start_hue(start_hue);
      ani[i].set_speed(random(-max_speed,max_speed)*.1);
      ani[i].set_radius(random(min,range.x),random(min,range.y));
    }
  }


  private class Wave {
    float dir;
    float speed;
    float rx;
    float ry;
    int cycle = 0;
    float start_hue =0;

    Wave() {}

    void set_speed(float speed) {
      this.speed = speed;
      cycle = 0;
    }

    void set_start_hue(float start_hue) {
      this.start_hue = start_hue;
    }


    void set_radius(float rx, float ry) {
      this.rx = rx;
      this.ry = ry;
    }

    void update() {
      dir += speed;
      cycle++;

    }

    void apparence(float fill_alpha, float stroke_alpha, float thickness) {
      float hue = (cycle*speed+start_hue)%g.colorModeX; // ici c'est égale à 360, définit avec colorMode dans le setup;
      float saturation = g.colorModeY;
      float brightness = g.colorModeZ;
      int colour_fill = color(hue,saturation,brightness,fill_alpha);
      int colour_stroke = color(hue,saturation,brightness,stroke_alpha);
      // println(hue,saturation,brightness,fill_alpha);
      // println(colour_fill,colour_stroke,thickness);
      aspect(colour_fill,colour_stroke,thickness);
      // fill(r.WHITE);
    }

    void render_shape(int x, int y, float max_size, Costume costume) {
      vec2 pos = to_cartesian_2D(dir);
      pos.mult(rx,ry);
      float size = abs(sin(frameCount *speed) *max_size);
      push();
      translate(x,y);
      costume(vec3(pos),vec3(size),costume);
      pop();
    }
  }
  //

}















