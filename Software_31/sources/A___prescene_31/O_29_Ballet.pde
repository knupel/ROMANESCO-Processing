/**
Ballet
2018
v 0.0.2
*/
class Ballet extends Romanesco {
	public Ballet() {
		item_name = "Ballet";
		ID_item = 29;
		ID_group = 1 ;
		item_author  = "Stan le Punk";
		item_version = "Version 0.0.2";
		item_pack = "Romanesco 2018";
    item_costume = "none/point/ellipse/triangle/rect/cross/pentagon/Star 5/Star 7/Super Star 8/Super Star 12";
    item_mode = "solo/valse 2D/valse 3D/whisky walk/random";

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
    setting_start_position(ID_item,0,0,0);
  }
  

  Vec3 speed = Vec3();
  void draw() {
    num_spot_management(300);

    iVec2 canvas_ff = get_force_field().get_canvas();
    float max_w = map(canvas_x_item[ID_item],width *.1,(float)width *TAU,canvas_ff.x,5*canvas_ff.x);
    Vec2 limit_w = Vec2(-(max_w-canvas_ff.x),max_w);

    float max_h = map(canvas_y_item[ID_item],width *.1,(float)width *TAU,canvas_ff.y,5*canvas_ff.y);
    Vec2 limit_h = Vec2(-(max_h-canvas_ff.y),max_h);
    
    // here we use the y component of canvas because the `z`don't exist.
    float max_d = map(canvas_z_item[ID_item],width *.1,(float)width *TAU,canvas_ff.y*.1,5*canvas_ff.y);
    Vec2 limit_d = Vec2(-(max_d-canvas_ff.y),max_d);



    
    // motion
    if(motion[ID_item]) {
      // speed rotation
      speed.x = (speed_x_item[ID_item]*speed_x_item[ID_item]*speed_x_item[ID_item]);
      speed.x *= .1;
      //angle growth
      speed.y = speed_y_item[ID_item]*speed_y_item[ID_item]*speed_y_item[ID_item];
      speed.y *= .1;
      //angle growth
      speed.z = speed_z_item[ID_item]*speed_z_item[ID_item]*speed_z_item[ID_item];
      speed.z *= .1;
      if(reverse[ID_item]) {
        speed.mult(-1);
      }
    } 

    // num spiral
    int num_spiral = (int)map(angle_item[ID_item],0,360,1,13);

    // range min_max for the radius
    Vec2 range = Vec2(swing_x_item[ID_item],swing_x_item[ID_item]*5);

    int which_behavior = floor(map(variety_item[ID_item],0,1,0,6));
    if(which_behavior == 6) which_behavior = 5;

    // attractivity / repulsion
    int diameter = (int)map(diameter_item[ID_item],width *.1,(float)width *TAU,2,height/3);
    int attraction = (int)map(attraction_item[ID_item],0,1,0,100);
    int repulsion = (int)map(repulsion_item[ID_item],0,1,0,-100);
    int mass =(int)map(density_item[ID_item],0,1,0,100);

    if(get_type_force_field() == MAGNETIC) {
      set_force_magnetic_tesla(attraction,repulsion);
      set_force_magnetic_diam(50);
    } else if(get_type_force_field() == GRAVITY) {
      set_force_gravity_mass(mass);
    }


    

    // SPOT POSITION
    if(mode[ID_item] == 0) solo_spot();
    else if(mode[ID_item] == 1) valse_2D_spot(canvas_x_item[ID_item],speed,num_spiral,range,which_behavior);
    else if(mode[ID_item] == 2) valse_3D_spot();
    else if(mode[ID_item] == 3) whisky_spot(canvas_ff,speed,limit_w,limit_h,limit_d);
    else if(mode[ID_item] == 4) random_spot(frameCount%60 == 0);


    // SHOW SPOT
    float ratio_size_costume = map(area_item[ID_item],width*.1, width*TAU,0,width*.001);
    Vec3 size = Vec3(size_x_item[ID_item],size_y_item[ID_item],size_z_item[ID_item]);
    aspect_is(fill_is[ID_item],stroke_is[ID_item]);
    aspect_rope(fill_item[ID_item], stroke_item[ID_item],thickness_item[ID_item]);

    for(int i =  0 ; i < get_spot_num() ; i++) {
      Vec3 pos = Vec3(get_spot_pos(i));
      set_ratio_costume_size(ratio_size_costume);
      costume_rope(pos,size,get_costume());
    }

    // END DRAW
  }




  private void solo_spot() {

  }



  Cloud_2D valse_2D;
  int ref_num;
  private void valse_2D_spot(float radius, Vec3 speed, int num_spiral, Vec2 range, int which_behavior) {
    if(valse_2D == null || ref_num != get_spot_num()) {
      valse_2D = new Cloud_2D(get_spot_num(),r.ORDER);
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
    //Vec3 [] temp = cloud_2D.list();
    for(int i = 0 ; i < get_spot_num() &&  i < valse_2D.length(); i++) {
      set_spot_pos(valse_2D.list()[i],i);
      //pos[i] = Vec2(temp[i].x,temp[i].y);
    }


  }



  Cloud_3D cloud_3D;
  private void valse_3D_spot() {

  }






  // END CLASS
  private void random_spot(boolean condition) {
    boolean random_draw = false;
    if(sound[ID_item] && transient_is(0)) {
    	random_draw = true;
    } else if(!sound[ID_item] && condition) {
    	random_draw = true;
    }

    if(random_draw) {
      random_distribution_2D(width,height);
    }
  }


  private void whisky_spot(iVec2 canvas, Vec3 speed, Vec2 limit_w, Vec2 limit_h, Vec2 limit_d) {
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
  		Vec3 vel = new Vec3(RANDOM,sx,sy,sz);
  		Vec3 tempo_pos = get_spot_pos(i);
  		tempo_pos.add(vel);
  		set_spot_pos(tempo_pos,i);
  	}
  	random_spot(false);
    // manage spot when those too drunk and go beyond the galaxy
    for(int i =  0 ; i < get_spot_num() ; i++) {
      Vec3 pos = Vec3(get_spot_pos(i));
      if(in_vec(limit_w,pos.x) && in_vec(limit_h,pos.y) && in_vec(limit_d,pos.z)) {
        // nothing happen
      } else {
        Vec3 new_pos = new Vec3(r.RANDOM,canvas.x,canvas.y,0);
        set_spot_pos(new_pos,i);
      }
    }
  }










  // global method
  int ref_spot_quantity ;
  private void num_spot_management(int max) {

    if(!FULL_RENDERING) {
      max /= 10;
    }
    float ratio_quantity = quantity_item[ID_item];
    ratio_quantity = (ratio_quantity*ratio_quantity*ratio_quantity);
    int spot_quantity = (int)map(ratio_quantity,0,1,1,max);
    if(ref_spot_quantity != spot_quantity || get_spot_num() == 1) {
      ref_spot_quantity = spot_quantity;
      clear_spot();
      add_spot(spot_quantity);
    }
  }


  private void random_distribution_2D(int w, int h) {
  	random_distribution_2D(Vec2(0,w), Vec2(0,h));
  }

  private void random_distribution_2D(Vec2 range_w, Vec2 range_h) {
  	for(int i = 0 ; i < get_spot_num() ; i++) {
  		set_spot_pos(random(range_w.x,range_w.y),random(range_h.x,range_h.y),i);
  	}
  }


  private boolean in_vec(Vec2 ref, float value) {
    if(value < ref.x && value < ref.y) {
      return false;
    } else if(value > ref.x && value > ref.y) {
      return false;
    } else return true;
  }
}












