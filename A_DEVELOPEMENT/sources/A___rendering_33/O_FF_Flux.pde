/**
Flux Force Field
2018-2019
v 0.0.8
*/
class Flux extends Romanesco {

  ArrayList<Vehicle> vehicles;

	public Flux() {
		item_name = "FF Flux";
		item_author  = "Stan le Punk";
		item_version = "Version 0.0.9";
		item_pack = "Force 2018-2019";
    item_costume = "pixel/point/ellipse/triangle/rect/cross/pentagon/Star 5/Star 7/Super Star 8/Super Star 12";
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
    // canvas_x_is = true;
    // canvas_y_is = true;
    // canvas_z_is = true;

    //frequence_is = true;
    speed_x_is = true;
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

    // grid_is = true;
    // viscosity_is = true;
    // diffusion_is = true;
  }





  void setup() {
    setting_start_position(ID_item,0,0,height/2);
    set_vehicle(100);

  }
  


  void draw() {
    if(get_costume().get_type() != PIXEL_ROPE) {
      int mult_particle = 1;
      draw_flux(mult_particle);
    }
  }

  void draw_2D() {
    if(get_costume().get_type() == PIXEL_ROPE) {
      int mult_particle = 10 ;
      draw_flux(mult_particle);
    }
  }




  void draw_flux(int mult_particle) {
    float ratio_num = get_quantity() *get_quantity() *get_quantity();
    int num = (int)map(ratio_num,0,1,10,3000); // > 100_000;
    num *= mult_particle;
    
    set_vehicle(num);
    init_vehicle(num,get_force_field()); 
    
    float speed = .1 + (get_speed_x()*2.);
    update_vehicle(get_force_field(),speed);
    aspect(get_fill(), get_stroke(),get_thickness());
    vec3 size = vec3(get_size_x(),get_size_y(),get_size_z());
    // size.map(get_size_x_min(),get_size_x_max(),1,get_size_x_max());
    show_vehicle(size,get_area(),get_costume());

    //
    item_info[ID_item] = ("vehicles: " +vehicles.size());
  }




  private int get_num() {
    return vehicles.size();
  }

  private boolean vehicle_is = false;
  private void init_vehicle(int num, Force_field ff) {
    if(ff != null && !vehicle_is) {
      build_vehicle(num,ff);
      vehicle_is = true;
    } 
  }
  

  // private int num_ref;
  private void set_vehicle(int num) {
    if(vehicles != null && num != vehicles.size()) {
      vehicles.clear();
      vehicle_is = false;
    } else if(vehicles == null || num != vehicles.size()) {
      vehicle_is = false;
    }
  }


  private void build_vehicle(int num, Force_field ff) {
    if(vehicles == null) vehicles = new ArrayList<Vehicle>();
    int w = ff.get_canvas().x;
    int h = ff.get_canvas().y;
    vec2 range_speed = vec2(1.,2.);
    vec2 range_force = vec2(.2,1.);

    for (int i = 0; i < num; i++) {
      float max_speed = +range_speed.x + random_next_gaussian(range_speed.y,3);
      float max_force = +range_force.x + random_next_gaussian(range_force.y,3);
      vec2 pos = vec2().rand(vec2(0,w),vec2(0,h));
      vehicles.add(new Vehicle(pos,max_speed,max_force));
    }
  }




  private void update_vehicle(Force_field ff, float speed) {
    if(ff != null) {
      for (Vehicle v : vehicles) {
        v.mult_speed(speed);
        v.update(ff);
        v.follow();   
        v.swap();
        v.manage_border(manage_border_is);
      }
    }
  }

  private boolean manage_border_is;
  private void manage_border() {
    manage_border_is = (manage_border_is == true) ? false:true;
  }

  private void show_vehicle(vec size, float ratio, Costume costume) {
    for (Vehicle v : vehicles) {
      float theta = v.get_direction() + radians(90);
      set_ratio_costume_size(map(ratio,width*.1, width*TAU,0,1));
      if(get_costume().get_type() == PIXEL_ROPE) {
        costume(v.get_position().mult(displayDensity()),size,theta,costume);
      } else {
        costume(v.get_position(),size,theta,costume);
      }
      
    }
  }
}



















