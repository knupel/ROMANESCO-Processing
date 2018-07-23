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
    item_mode = "trigos/whisky walk/random";

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
    // font_size_is = true;
    canvas_x_is = true;
    canvas_y_is = true;
    canvas_z_is = true;

    // reactivity_is = true;
    speed_x_is = true;
    speed_y_is = true;
    speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    // dir_x_is = true;
    // dir_y_is = true;
    //dir_z_is = true;
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
  }





  void setup() {
    setting_start_position(ID_item,0,0,height/2);
  }
  


  void draw() {
    random_draw();
    

    // SPOT POSITION
    if(mode[ID_item] == 1) whisky_spot();
    if(mode[ID_item] == 2) random_spot(frameCount%60 == 0);


    // SHOW SPOT
    set_ratio_costume_size(map(area_item[ID_item],width*.1, width*PHI,0,width*.001));
    Vec3 size = Vec3(size_x_item[ID_item],size_y_item[ID_item],size_z_item[ID_item]);

    // define canvas
    iVec2 canvas_ff = get_force_field().get_canvas();
    float max_w = map(canvas_x_item[ID_item],width *.1,(float)width *TAU,canvas_ff.x,5*canvas_ff.x);
    Vec2 limit_w = Vec2(-(max_w-canvas_ff.x),max_w);

    float max_h = map(canvas_y_item[ID_item],width *.1,(float)width *TAU,canvas_ff.y,5*canvas_ff.y);
    Vec2 limit_h = Vec2(-(max_h-canvas_ff.y),max_h);
    
    // here we use the y component of canvas because the `z`don't exist.
    float max_d = map(canvas_z_item[ID_item],width *.1,(float)width *TAU,canvas_ff.y*.1,5*canvas_ff.y);
    Vec2 limit_d = Vec2(-(max_d-canvas_ff.y),max_d);


    

    aspect_is(fill_is[ID_item],stroke_is[ID_item]);
    aspect_rope(fill_item[ID_item], stroke_item[ID_item],thickness_item[ID_item]);
    for(int i =  0 ; i < get_spot_num() ; i++) {

    	Vec3 pos = Vec3(get_spot_pos(i));
    	if(in_vec(limit_w,pos.x) && in_vec(limit_h,pos.y) && in_vec(limit_d,pos.z)) {
    		// nothing happen
    	} else {
    		Vec3 new_pos = new Vec3(r.RANDOM,canvas_ff.x,canvas_ff.y,0);
    		set_spot_pos(new_pos,i);
    	}
      costume_rope(pos,size,get_costume());
    }

    // END DRAW
  }


  boolean in_vec(Vec2 ref, float value) {
  	if(value < ref.x && value < ref.y) {
  		return false;
  	} else if(value > ref.x && value > ref.y) {
  		return false;
  	} else return true;
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




  private void whisky_spot() {
  	float sx = speed_x_item[ID_item];
  	float sy = speed_y_item[ID_item];
  	float sz = speed_z_item[ID_item];
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
  }





  int ref_spot_quantity ;
  private void random_draw() {
  	int max_quantity = 1000 ;
    if(!FULL_RENDERING) max_quantity = 50 ;
    float ratio_quantity = quantity_item[ID_item];
    ratio_quantity = (ratio_quantity*ratio_quantity*ratio_quantity);
    int spot_quantity = (int)map(ratio_quantity,0,1,1,max_quantity);
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
}












