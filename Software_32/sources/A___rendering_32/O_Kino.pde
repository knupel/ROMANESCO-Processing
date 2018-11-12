/**
Kino
2018-2018
v 0.0.6
*/
class Kino extends Romanesco {
	public Kino() {
		item_name = "Kino";
		item_author  = "Stan le Punk";
		item_version = "Version 0.0.6";
		item_pack = "Base 2018-2018";
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
    pos_x_is = true;
    // pos_y_is = true;
    // pos_z_is = true;
	}

	void setup() {
		setting_start_position(ID_item,0,0,0);
		load_movie(true,ID_item);
	}



  float pos_ref;
	void draw() {
    param();
    if(get_movie() != null && get_mode() != 0 && get_mode() != 2) {
      get_movie().pause();
    }

		if(get_movie() != null && get_mode() == 2) {
			kino_movie(colour,FIT);
		} else if(get_mode() == 3) {
			kino_bitmap(colour,FIT);
		}

    if(parameter_is() && get_movie() != null) {
      if(pos_ref != get_pos_x()) {
        pos_ref = get_pos_x();
        float pos = get_pos_x() *get_movie().duration();
        get_movie().jump(pos);
      }     
    }
	}

  void draw_2D() {
    param();
    if(get_mode() == 0) {
      kino_movie(colour,SCREEN);

    } else if(get_mode() == 1) {
      kino_bitmap(colour,SCREEN);
    }
  }

  int colour;
  void param() {
    colour = fill_item[ID_item];
  }
  
  // kino movie
  int ref_which_movie;
	private void kino_movie(int c, int what) {
		if(ref_which_movie != which_movie()) {
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
  		if(motion_is()) {
  			get_movie().loop();
  		} else {
  			get_movie().pause();
  		}
      manage_tint(c);
      image(get_movie(),what);
    }
	}


	// kino movie
	private void kino_bitmap(int c, int what) {
		load_bitmap(ID_item);
    manage_tint(c);
		image(get_bitmap(),what);
	}


  private void manage_tint(int c) {
    float h = hue(c);
    /**
    bug or not
    */
    float s = g.colorModeY -saturation(c);
    float b = brightness(c);
    float a = alpha(c);
    tint(h,s,b,a);
  }
}








