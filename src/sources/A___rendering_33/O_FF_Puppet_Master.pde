/**
Puppet Master
2018-2019
v 0.2.0
*/
class Puppet_master extends Romanesco {
	public Puppet_master() {
		item_name = "FF Puppet Master";
		item_author  = "Stan le Punk";
		item_version = "Version 0.2.0";
		item_pack = "Force 2018-2019";
    item_costume = "none/pixel/point/ellipse/triangle/rect/cross/pentagon/flower/Star 5/Star 7/Super Star 8/Super Star 12";
    item_mode = "solo/duo/valse 2D/<valse 3D>/whisky walk/random";

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
    diameter_is = true;
    canvas_x_is = true;
    canvas_y_is = true;
    canvas_z_is = true;

    // frequence_is = true;
    speed_x_is = true;
    speed_y_is = true;
    speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    // dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
    // jit_x_is = true;
    // jit_y_is = true;
    // jit_z_is = true;
    swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    quantity_is = true;
    variety_is = true;
    // life_is = true;
    // flow_is = true;
    // quality_is = true;
    area_is = true;
    angle_is = true;
    // scope_is = true;
    // scan_is = true;
    // align_is = true;
    repulsion_is = true;
    attraction_is = true;
    density_is = true;
    // influence_is = true;
    // calm_is = true;
    // spectrum_is = true;

    // grid_is = true;
    // viscosity_is = true;
    // diffusion_is = true;
  }





  void setup() {
    set_item_pos(0,0,(height/2)+1);
  }
  

  vec3 speed = vec3();
  void draw() {
    puppet_master(true);
    // int num, float quantity_slider, boolean use_slider_quantity
    // num_spot_management(300, get_quantity(),true);

    ivec2 canvas_ff = get_force_field().get_canvas();
    float max_w = map(get_canvas_x().value(),get_canvas_x().min(),get_canvas_x().max(),canvas_ff.x,5*canvas_ff.x);
    vec2 limit_w = vec2(-(max_w-canvas_ff.x),max_w);

    float max_h = map(get_canvas_y().value(),get_canvas_y().min(),get_canvas_y().max(),canvas_ff.y,5*canvas_ff.y);
    vec2 limit_h = vec2(-(max_h-canvas_ff.y),max_h);
    
    // here we use the y component of canvas because the `z`don't exist.
    float max_d = map(get_canvas_z().value(),get_canvas_z().min(),get_canvas_z().max(),canvas_ff.y*.1,5*canvas_ff.y);
    vec2 limit_d = vec2(-(max_d-canvas_ff.y),max_d);



    
    // motion
    if(motion_is()) {
      // speed rotation
      speed.x = (get_speed_x().normal() *get_speed_x().normal() *get_speed_x().normal());
      speed.x *= .1;
      //angle growth
      speed.y = get_speed_y().normal() *get_speed_y().normal() *get_speed_y().normal();
      speed.y *= .1;
      //angle growth
      speed.z = get_speed_z().normal() *get_speed_z().normal() *get_speed_z().normal();
      speed.z *= .1;
      if(reverse_is()) {
        speed.mult(-1);
      }
    } 

    // num spiral
    int num_spiral = (int)map(get_angle().value(),get_angle().min(),get_angle().max(),1,13);

    // range min_max for the radius
    vec2 range = vec2(get_swing_x().value(),get_swing_x().value()*5);

    int which_behavior = floor(map(get_variety().value(),get_variety().min(),get_variety().max(),0,6));
    if(which_behavior == 6) which_behavior = 5;

    // attractivity / repulsion
    int diameter = (int)map(get_diameter().value(),get_diameter().min(),get_diameter().max(),2,height/3);
    int attraction = (int)map(get_attraction().value(),get_attraction().min(),get_attraction().max(),0,100);
    int repulsion = (int)map(get_repulsion().value(),get_repulsion().min(),get_repulsion().max(),0,-100);
    int mass =(int)map(get_density().value(),get_density().min(),get_density().max(),0,100);

    if(get_type_force_field() == MAGNETIC) {
      set_force_magnetic_tesla(attraction,repulsion);
      set_force_magnetic_diam(50);
    } else if(get_type_force_field() == GRAVITY) {
      set_force_gravity_mass(mass);
    }


    

    // SPOT POSITION
    if(get_mode_id() == 0) {
      solo_spot();
    } else if(get_mode_id() == 1) {
      duo_spot();
    } else if(get_mode_id() == 2) {
      num_spot_management(300, get_quantity().value(),true);
      valse_2D_spot(get_canvas_x().value(),speed,num_spiral,range,which_behavior);
    } else if(get_mode_id() == 3) {
      num_spot_management(300, get_quantity().value(),true);
      valse_3D_spot();
    } else if(get_mode_id() == 4) {
      num_spot_management(300, get_quantity().value(),true);
      whisky_spot(canvas_ff,speed,limit_w,limit_h,limit_d);
    } else if(get_mode_id() == 5) {
      num_spot_management(300, get_quantity().value(),true);
      random_spot(frameCount%60 == 0);
    }



    // SHOW SPOT
    float ratio_size_costume = map(get_area().value(),get_area().min(), get_area().max(),0,width*.001);
    vec3 size = get_size();
    aspect_is(fill_is(),stroke_is(), alpha_is());
    aspect(get_fill(), get_stroke(),get_thickness().value());
    
    for(int i =  0 ; i < get_spot_num() ; i++) {
      vec3 pos = vec3(get_spot_pos(i));
      set_ratio_costume_size(ratio_size_costume);
      costume(pos,size,get_costume());
    }
  }




  private void solo_spot() {
    num_spot_management(1, get_quantity().value(),false);
    set_spot_pos(mouse[ID_item],0);
  }

  private void duo_spot() {
    num_spot_management(2, get_quantity().value(),false);
    set_spot_pos(mouse[ID_item],0);
    set_spot_pos(width -mouse[ID_item].x,height -mouse[ID_item].y,1);
  }



  Cloud_2D valse_2D;
  int ref_num;
  private void valse_2D_spot(float radius, vec3 speed, int num_spiral, vec2 range, int which_behavior) {
    if(valse_2D == null || ref_num != get_spot_num()) {
      valse_2D = new Cloud_2D(p5,get_spot_num(),r.ORDER);
      ref_num = get_spot_num();
    }
    // cloud_2D.pos(ref_pos);
    valse_2D.set_radius(radius);
    valse_2D.spiral(num_spiral);
    valse_2D.rotation(speed.x,false);
    valse_2D.set_growth(speed.y);
    valse_2D.range(range);
    if(which_behavior == 0) {
      valse_2D.set_behavior("SIN");
    } else if(which_behavior == 1) {
      valse_2D.set_behavior("SIN_TAN");
    } else if(which_behavior == 2) {
      valse_2D.set_behavior("SIN_TAN_COS");
    } else if(which_behavior == 3) {
      valse_2D.set_behavior("SIN_POW_SIN");
    } else if(which_behavior == 4) {
      valse_2D.set_behavior("POW_SIN_PI");
    } else if(which_behavior == 5) {
      valse_2D.set_behavior("SIN_TAN_POW_SIN");
    }
    valse_2D.update();
    // update spot position from cloud
    //vec3 [] temp = cloud_2D.list();
    for(int i = 0 ; i < get_spot_num() &&  i < valse_2D.length(); i++) {
      set_spot_pos(valse_2D.list()[i],i);
      //pos[i] = vec2(temp[i].x,temp[i].y);
    }


  }



  Cloud_3D cloud_3D;
  private void valse_3D_spot() {

  }






  // END CLASS
  private void random_spot(boolean condition) {
    boolean random_draw = false;
    if(sound_is() && transient_is(0)) {
    	random_draw = true;
    } else if(!sound_is() && condition) {
    	random_draw = true;
    }

    if(random_draw) {
      random_distribution_2D(width,height);
    }
  }


  private void whisky_spot(ivec2 canvas, vec3 speed, vec2 limit_w, vec2 limit_h, vec2 limit_d) {
  	float sx = speed.x;
  	float sy = speed.y;
  	float sz = speed.z;
  	sx *= sx;
  	sx *= (width/50);
  	sy *= sy;
  	sy *= (width/50);	
  	sz *= sz;
  	sz *= (width/50);	
  	for(int i = 0 ; i < get_spot_num() ; i++) {
  		vec3 vel = vec3().rand(vec3(-sx,-sy,-sz),vec3(sx,sy,sz));
  		vec3 tempo_pos = get_spot_pos(i);
  		tempo_pos.add(vel);
  		set_spot_pos(tempo_pos,i);
  	}
  	random_spot(false);
    // manage spot when those too drunk and go beyond the galaxy
    for(int i =  0 ; i < get_spot_num() ; i++) {
      vec3 pos = vec3(get_spot_pos(i));
      if(in_vec(limit_w,pos.x) && in_vec(limit_h,pos.y) && in_vec(limit_d,pos.z)) {
        // nothing happen
      } else {
        vec2 new_pos = vec2().rand(vec2(-canvas.x(),-canvas.y()),vec2(canvas.x(),canvas.y()));
        set_spot_pos(vec3(new_pos),i);
      }
    }
  }










  // global method
  int ref_spot_quantity ;
  private void num_spot_management(int num, float quantity_slider, boolean use_slider_quantity) {
    int spot_quantity = num;
    if(!FULL_RENDERING) num /= 10;
    
    if(use_slider_quantity) {
      float ratio_quantity = quantity_slider;
      ratio_quantity = (ratio_quantity*ratio_quantity*ratio_quantity);
      spot_quantity = ceil(map(ratio_quantity,0,1,1,num));
    }
    
    if(ref_spot_quantity != spot_quantity || ref_spot_quantity != get_spot_num()) {
      ref_spot_quantity = spot_quantity;
      clear_spot();
      add_spot(spot_quantity);
    }
  }


  private void random_distribution_2D(int w, int h) {
  	random_distribution_2D(vec2(0,w), vec2(0,h));
  }

  private void random_distribution_2D(vec2 range_w, vec2 range_h) {
  	for(int i = 0 ; i < get_spot_num() ; i++) {
  		set_spot_pos(random(range_w.x,range_w.y),random(range_h.x,range_h.y),i);
  	}
  }


  private boolean in_vec(vec2 ref, float value) {
    if(value < ref.x && value < ref.y) {
      return false;
    } else if(value > ref.x && value > ref.y) {
      return false;
    } else return true;
  }
}












