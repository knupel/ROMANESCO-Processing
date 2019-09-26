/**
* Lyric
* the tab is the template that you can duplicate to add the item you want in your Romanesco.
* You must change the class name and this one must be unique.
* v 0.1.0
* 2018-2019
*/
class Lyric extends Romanesco {
	public Lyric() {
		//from the index_objects.csv
		item_name = "Lyric" ;
		item_author  = "Stan le Punk";
		item_references = "";
		item_version = "Version 0.0.1";
		item_pack = "Base 2019-2019" ;
		item_costume = ""; // costume available from get_costume();
		item_mode = "line/window/destroy";
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
		// size_y_is = true;
		// size_z_is = true;
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
		// dir_x_is = true;
		// dir_y_is = true;
		// dir_z_is = true;
		jit_x_is = true;
		jit_y_is = true;
		jit_z_is = true;
		// swing_x_is = true;
		// swing_y_is = true;
		// swing_z_is = true;

		// COL 3
		// quantity_is = true;
		// variety_is =true;
		// life_is = true;
		flow_is = true;
		// quality_is = true;
		// area_is = true;
		angle_is = true;
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
		// amplitude_is = true;
		// coord_x_is = true;
		// coord_y_is = true;
		// coord_z_is = true;
	}

	Poem poem;
	R_Typewriter writer;

	void setup() {
	// give the starting position of your item on the 3D grid
		set_item_pos(width/2,height/2,0);
		set_item_dir(HALF_PI,PI);
		writer = new R_Typewriter(p5,get_font_path(),48);
	}
	
	//DRAW
	boolean text_is = false;
	int index_vers = 0;
	void draw() {
		if(load_text()) {
			text_is = true;
			poem  = new Poem(get_text());
		}

		if(text_is) {
			if(birth_is()) {
				index_vers++;
				birth_is(false);
			}

			if(reverse_is()) {
				index_vers--;
				reverse_is(false);
			}
			if(index_vers >= poem.size()){
				index_vers = 0;
			}

			if(index_vers < 0){
				index_vers = poem.size() -1;
			}

			String blabla = poem.get_vers(index_vers).toString();
			int font_size = 6 + (int)get_size_x().value();
			int w = (int)get_canvas_x().value() * 3 + font_size;
			int h = (int)get_canvas_y().value() * 4 + font_size;
			int max_h = font_size * (blabla.length() / (w/font_size) +2); // can be better algo but that's ok
			if(h > max_h) {
				h = max_h;
			}
			fill(get_fill());

			writer.path(get_font_path(),false);
			writer.size(font_size);
			writer.angle(get_angle().value());
			writer.align(CENTER);
			writer.pos(0,0,0);
			
			if(get_mode_name().toLowerCase().equals("window")) {
				writer.content(blabla);
				writer.show(w,h,CENTER);
			} else if (get_mode_name().toLowerCase().equals("line")) {
				writer.content(blabla);
				writer.show();
			} else if (get_mode_name().toLowerCase().equals("destroy")) {
				stroke(get_stroke());
				strokeWeight(get_thickness().value());
				writer.reset();
				writer.content(blabla);
				vec3 jit  = get_jitter().mult(height).mult(get_flow().value());
				println("jitting",jit);
				beginShape();
				for(vec3 p : writer.get_points()) {
					int show_is = floor(random(2));
					if(show_is != 0) vertex(p.jitter(jit));
				}
				endShape();
			}
		}

	}

	void draw_2D() {
	// here if you want code in 2D mode
	}
}















