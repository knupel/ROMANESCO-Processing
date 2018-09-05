/**
Force Field
2018
v 0.0.1
*/
class Flux extends Romanesco {

  ArrayList<Vehicle> vehicles;

	public Flux() {
		item_name = "Flux";
		ID_item = 31;
		ID_group = 1 ;
		item_author  = "Stan le Punk";
		item_version = "Version 0.0.1";
		item_pack = "Force 2018";
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

    // grid_is = true;
    // viscosity_is = true;
    // diffusion_is = true;
  }





  void setup() {
    setting_start_position(ID_item,0,0,height/2);
    set_vehicle(100);

  }
  


  void draw() {
    float ratio_num = quantity_item[ID_item] *quantity_item[ID_item] *quantity_item[ID_item];
    int num = (int)map(ratio_num,0,1,100,100000); // > 100_000;
    set_vehicle(num);
    init_vehicle(num,get_force_field()); 
    
    float speed = .1 + (speed_x_item[ID_item]*2.);
    update_vehicle(get_force_field(),speed);
    aspect_rope(fill_item[ID_item], stroke_item[ID_item],thickness_item[ID_item]);
    Vec3 size = Vec3(size_x_item[ID_item],size_y_item[ID_item],size_z_item[ID_item]);
    show_vehicle(size,get_costume());

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
    Vec2 range_speed = Vec2(1.,2.);
    Vec2 range_force = Vec2(.2,1.);

    for (int i = 0; i < num; i++) {
      float max_speed = +range_speed.x + random_next_gaussian(range_speed.y,3);
      float max_force = +range_force.x + random_next_gaussian(range_force.y,3);
      Vec2 pos = Vec2(RANDOM_ZERO,w,h);
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

  private void show_vehicle(Vec size, int costume) {
    for (Vehicle v : vehicles) {
      float theta = v.get_direction() + radians(90);
      costume_rope(v.get_position(),size,theta,costume);
    }
  }
}



















