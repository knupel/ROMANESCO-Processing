/**
Kino
2018-2019
v 0.2.0
*/
class Kino extends Romanesco {
	public Kino() {
		item_name = "Kino";
		item_author  = "Stan le Punk";
		item_version = "Version 0.2.0";
		item_pack = "Base 2018-2019";
		item_costume = ""; // separate the differentes mode by "/"
		item_mode = "Movie/Diaporama/Movie 3D/Diaporama 3D"; // separate the differentes mode by "/"

		hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    // hue_stroke_is = true;
    // sat_stroke_is = true;
    // bright_stroke_is = true;
    // alpha_stroke_is = true;
    // thickness_is = true;
    // size_x_is = true;
    // size_y_is = true;
    // size_z_is = true;
    // diameter_is = true;
    // canvas_x_is = true;
    // canvas_y_is = true;
    // canvas_z_is = true;

    // frequence_is = true;
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

    // quantity_is = true;
    // variety_is = true;
    // life_is = true;
    // flow_is = true;
    quality_is = true;
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

    // grid_is = true;
    // viscosity_is = true;
    // diffusion_is = true;
    coord_x_is = true;
    // coord_y_is = true;
    // coord_z_is = true;
	}

	void setup() {
		setting_start_position(ID_item,0,0,0);
		load_movie(true,ID_item);
	}

  float coord_ref;
	void draw() {
    param();
    

    
    if(get_movie() != null && get_mode_id() != 0 && get_mode_id() != 2) {
      get_movie().pause();
    }

    boolean background_is = false;
		if(get_movie() != null && get_mode_id() == 2) {
			kino_movie(colour,FIT,background_is,to_white);
		} else if(get_mode_id() == 3) {
			kino_bitmap(colour,FIT,background_is,to_white);
		}

    if(parameter_is() && get_movie() != null) {
      if(coord_ref != get_coord_x()) {
        coord_ref = get_coord_x();
        float pos = get_coord_x() *get_movie().duration();
        get_movie().jump(pos);
      }     
    }
	}

  void draw_2D() {
    param();
    boolean background_is = true;
    if(get_mode_id() == 0) {
      kino_movie(colour,CENTER,background_is,to_white);
    } else if(get_mode_id() == 1) {
      kino_bitmap(colour,CENTER,background_is,to_white);
    }
  }

  vec4 colour;
  int to_white = 0;
  float speed_movie = 1;
  // float ref_speed_slider;
  void param() {
    float h = get_fill_hue();
    float s = get_fill_sat();
    float b = get_fill_bright();
    float a = get_fill_alpha();
    if(colour == null) {
      colour = vec4(h,s,b,a);
    } else {
      colour.set(h,s,b,a);
    }
    // normalize colour
    colour.div(vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA));
    colour.a(colour.x *colour.a *colour.a);

    // to make the colour to white or black
    if(reverse_is()) {
      to_white = 1;
    }

    // change the video speed
    
    // if(ref_speed_x() != ref_speed_x) {
      // ref_speed_slider = get_speed_x();
      float temp_speed = map(get_speed_x(),0,1,-1,1);
      temp_speed = temp_speed *temp_speed *temp_speed;
      temp_speed = map(temp_speed,-1,1,-12,12);
      float range = .3;
      if(temp_speed < 1. + range && temp_speed > 1. -range) temp_speed = 1.;
      speed_movie = temp_speed;
  //  }

  }
  
  // kino movie
  int ref_which_movie;
  boolean security_load_is = false;
	private void kino_movie(vec4 c, int what, boolean background_is, int mode_to_black_or_white) {
		if(ref_which_movie != which_movie() && ref_which_movie < movie_time.length) {
      movie_time[ref_which_movie] = get_movie().time();
			load_movie(true,ID_item);
      if(movie_time[which_movie()] < get_movie().duration()) {
        get_movie().jump(movie_time[which_movie()]);
      }
			ref_which_movie = which_movie();
		} else {
			// need to write in case the movie path file change or new movie is imported
			load_movie(false,ID_item);
		}
    if(get_movie() != null) {
      // get_movie().speed(speed_movie);
  		if(motion_is()) {
        if(sound_is()) {
          get_movie().volume(1); 
        } else {
          get_movie().volume(0);
        }
  			get_movie().loop();
  		} else {
  			get_movie().pause();
  		}

      if(background_is) {
        if(!security_load_is && get_movie().width > 0 && get_movie().height > 0) {
          // println("every thing is ok you can fly Rypley");
          // println(get_movie().width, get_movie().height, get_movie().pixels, frameCount);
          // get_movie().loadPixels();
          security_load_is = true;
        }

        if(get_movie().width == 0 && get_movie().height == 0) {
          // println("WARNING Rypley");
          // println(get_movie().width, get_movie().height, get_movie().pixels, frameCount);
          security_load_is = false;
        }

        if(security_load_is) {
          // println("Every thing is OK you can fly with the NOSTROMO");
          // println(get_movie().width, get_movie().height, get_movie().pixels, get_movie().pixels.length, frameCount);
        }
        // println("pixels movie", get_movie().pixels);
        // image(fx_level(get_movie(),false,mode_to_black_or_white,c.array()),CENTER);
        /*
        surface.setSize(get_movie().width,get_movie().height);
        if(get_movie().width == width && get_movie().height == height) {
          println("width",width); 
          println("height",height);
          println("width movie",get_movie().width); 
          println("height movie",get_movie().height);
          int target = floor(random(get_movie().pixels.length));
          println("target pixel",target,get_movie().pixels[target]); // all pixel are at zero ?????
          println("length",get_movie().pixels.length);
          println("length window",width*height);
          get_movie().loadPixels();
          background(get_movie());

        }
        */
        set_background(get_movie(),what);
        //set_background(fx_level(get_movie(),false,mode_to_black_or_white,c.array()),what);
      } else {
        image(fx_level(get_movie(),false,mode_to_black_or_white,c.array()),what);
      }
    }
	}


	// kino movie
	private void kino_bitmap(vec4 c, int what, boolean background_is, int mode_to_black_or_white) {
		load_bitmap(ID_item);
    if(get_bitmap() != null) {
      if(background_is) {
        set_background(fx_level(get_bitmap(),false,mode_to_black_or_white,c.array()),what);
      } else {
        image(fx_level(get_bitmap(),false,mode_to_black_or_white,c.array()),what);
      }
    }
	}
}








