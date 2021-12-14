/**
* Photomontage
* v 0.1.1
* 2019-2021
*/
class Photomontage extends Romanesco {
	public Photomontage() {
		//from the index_objects.csv
		item_name = "Photomontage" ;
		item_author  = "Stan le Punk";
		item_references = "";
		item_version = "Version 0.1.0";
		item_pack = "Base 2019-2019" ;
		item_costume = "cloud/tartan"; // costume available from get_costume();
		item_mode = "fx mask gray/fx mask colour/show mask gray/show mask colour";
		// define slider
		// COL 1
		hue_fill_is = true;
		sat_fill_is = true;
		bright_fill_is = true;
		alpha_fill_is = true;
		// hue_stroke_is = true;
		// sat_stroke_is = true;
		// bright_stroke_is = true;
		// alpha_stroke_is = true;
		// thickness_is = true;
		size_x_is = true;
		// size_y_is = true;
		// size_z_is = true;
		// diameter_is = true;
		// canvas_x_is = true;
		// canvas_y_is = true;
		// canvas_z_is = true;

		// COL 2
		//frequence_is = true;
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
		variety_is =true;
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
		density_is = true;
		// influence_is = true;
		// calm_is = true;
		spectrum_is = true;

		// COL 4
		// grid_is = true;
		// viscosity_is = true;
		// diffusion_is = true;
		power_is = true;
		// mass_is = true;
		// amplitude_is = true;
		// coord_x_is = true;
		// coord_y_is = true;
		// coord_z_is = true;
	}

	boolean init = false;
	PImage buffer;
	PGraphics mask;

	void setup() {
		// setup_cloud_mask();
		rand_image_background_id();
		rand_image_buffer_id();
	}
	
	void draw() {

	}

	void draw_2D() {
		// PATTERN
		if(birth_is() || !init) {
			rand_image_background_id();
			rand_image_buffer_id();
			generator(get_costume().get_name());
			birth_is(false);
			init = true;
		}
		update(get_costume().get_name());	

		// RENDER
		int mode_mask = 0; // GRAY VALUE: 0 // WHITE: 1 // BLACK: 2 // COLOUR: 3
		if(get_mode_name().contains("gray")) {
			mode_mask = 0;
		} else {
			mode_mask = 3;
		}
		boolean clear_mask_is = true;
		if(mask == null) {
			mask = createGraphics(width,height,get_renderer());
			beginDraw(mask);
			colorMode(HSB,g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA,mask);
			endDraw(mask);
		}
		render_mask(mask, mode_mask, get_costume().get_name(), clear_mask_is);
    
    // SHOW
		boolean use_bg_like_src = true;
		if(special_is()) use_bg_like_src = false;
		else use_bg_like_src = true;

		if(get_bitmap_collection().size() > 0 && mask != null) {
			// check target
			if(id_img_bg < 0) rand_image_background_id();
			if(id_img_buffer < 0) rand_image_buffer_id();
			// calc buffer
			if(get_mode_name().contains("fx")) {
				boolean on_g = false;
				boolean filter_is = true;
				int step_speparation = 3 +ceil(get_quality().value() *13);
				vec2 threshold = vec2(0,get_density().value());
				float l_red = (get_fill_hue().value() /get_fill_hue().max() ) *6.0;
				float l_gre = (get_fill_sat().value() /get_fill_sat().max() ) *6.0;
				float l_blu = (get_fill_bri().value() /get_fill_bri().max() ) *6.0;
				float l_alp = (get_fill_alp().value() /get_fill_alp().max() ) *6.0;
				vec4 level_layer = vec4(l_red,l_gre,l_blu,l_alp); // 0 to 6
				int fx_mode_mask = get_mode_id();
				buffer = get_bitmap_collection().get(id_img_buffer);
				buffer = fx_mask(buffer,mask,on_g,filter_is,fx_mode_mask,step_speparation,threshold,level_layer);
				show(buffer,SCREEN,use_bg_like_src);
			} else if(get_mode_name().contains("show")) {
				show(mask,SCREEN,use_bg_like_src);
			}            
		}
	}




	private void generator(String costume_name) {
		if(costume_name.toLowerCase().equals("cloud")) {
			generator_cloud(get_quantity().value(), get_variety().value(), get_power().value(), get_size_x().value(), get_fill(), get_spectrum().value());
		} else if(costume_name.toLowerCase().equals("tartan")) {
			generator_tartan(birth_is(), get_quantity().value(), get_variety().value(), get_size_x());
			if(get_mode_name().contains("gray")) {
				update_tartan(birth_is(), 0, get_fill_hue().value(), get_fill_sat().value(), get_fill_bri().value(), get_spectrum().value());
			} else {
				update_tartan(birth_is(), 3, get_fill_hue().value(), get_fill_sat().value(), get_fill_bri().value(), get_spectrum().value());
			}
		}
	}

	private void update(String costume_name) {
		if(costume_name.toLowerCase().equals("cloud")) {
			update_cloud_mask(10);
		} else if(costume_name.toLowerCase().equals("tartan")) {
			if(get_mode_name().contains("gray")) {
				update_tartan(false, 0, get_fill_hue().value(), get_fill_sat().value(), get_fill_bri().value(), get_spectrum().value());
			} else {
				update_tartan(false, 3, get_fill_hue().value(), get_fill_sat().value(), get_fill_bri().value(), get_spectrum().value());
			}
			
		}
	}

	private void render_mask(PGraphics pg_buffer, int mode, String costume_name, boolean clear_is) { 
		if(pg_buffer != null) {
			beginDraw(pg_buffer);
			if(pg_buffer != null && clear_is) {
				clear(pg_buffer);
			}

			if(costume_name.toLowerCase().equals("cloud")) {
				render_cloud_mask(pg_buffer, mode);
			} else if(costume_name.toLowerCase().equals("tartan")) {
				render_tartan(pg_buffer, mode);
			}
			endDraw(pg_buffer);
		} 
	}

	private void show(PImage render, int mode, boolean use_bg_like_src) {
		if(use_bg_like_src) {
			image(render,mode);
		} else {
			set_background(render,mode);
		}
	}

	// method
	int id_img_buffer = -1;
	int id_img_bg = -1;
	private void rand_image_background_id() {
		id_img_bg = rand_image_id();
	}

	private void rand_image_buffer_id() {
		id_img_buffer = rand_image_id();
	}

	private int rand_image_id() {
		int id = -1;
		if(get_bitmap_collection().size() > 0) {
			id = floor(random(get_bitmap_collection().size()));
		}
		return id;
	}









	// MACHINE A TARTAN
	int tartan_complexicity = 0;
	int min_line = 0;
	int max_line = 0;
	Tartan tartan;

	private void generator_tartan(boolean birth_is, float quantity, float variety, Varom size) {
		int tartan_complexicity = int(quantity *100 +2);
		if(tartan == null || birth_is || tartan.length() != tartan_complexicity) {
			min_line = (int)map(size.value(),size.min(),size.max(),1,height/10);
			max_line = int(min_line + (height/10 *variety));
			tartan = new Tartan(p5, tartan_complexicity, min_line, max_line);
		}
	}

	float ref_colour = 0;
	private void update_tartan(boolean birth_is, int mode, float hue, float sat, float bright, float spectrum) {
		if(tartan == null) {
			init = false;
		}
		if(tartan != null && (ref_colour != hue +sat +bright +spectrum || birth_is)) {
			ref_colour = hue +sat +bright +spectrum;

			tartan.set_pattern();
			int num = tartan.length();
			if(mode == 0) {
				tartan.set_gray(p5);
			} else if(mode == 1) {
				// to white, like other item cloud mask
			} else if(mode == 2) {
				// to black, like other item cloud mask
			} else if(mode == 3) {
				int num_group = num;
				int hue_key = (int)hue;
				int hue_range = (int)spectrum;
				spectrum = map(spectrum,0,360,0,100);
				vec2 range_sat = vec2(sat -spectrum, sat).constrain(0,100);
				vec2 range_bri = vec2(bright -spectrum, bright).constrain(0,100);
				int [] palette = color_pool(num,num_group, hue_key,hue_range, range_sat,range_bri);	
				tartan.set_palette(palette);
			}

		}
	}

	private void render_tartan(PGraphics buffer, int mode) {
		if(tartan != null) {
			buffer.loadPixels();
			tartan.show(false, buffer);
			buffer.updatePixels();
		}
	}


	


	







	// CLOUD MASK CHOSE
	
	int [] fill_choses;
	vec2 [] cloud_mask_coord;
	R_Chose [] cloud_mask_chose;

	private void generator_cloud(float quantity, float variety, float power, float size, int fill, float spectrum) {
		int min_shape = 3;
		float norm_q = quantity *quantity *quantity;
		int max_shape = floor(min_shape + (norm_q*3000));
		ivec2 num_range_shape = ivec2(min_shape,max_shape);
		create_cloud_coord(num_range_shape);

		int min_branch = 3;
		int max_branch = floor(min_branch + variety*77);
		ivec2 range_branches = ivec2(min_branch,max_branch);

		int min_rad = width/100;
		int max_rad = floor(min_branch + (size *0.6));
		ivec2 range_radius = ivec2(min_rad,max_rad);

		// ivec2 range_alpha = ivec2(0);
		vec2 range_alpha = vec2(0,power);
		// ivec2 range_alpha = ivec2(0,(int)g.colorModeA);
		//ivec2 range_alpha = ivec2(0,(int)g.colorModeX);
		//ivec2 range_alpha = ivec2(int(g.colorModeX/3),(int)g.colorModeX);
		int master_colour = fill;
		//float spectre = get_spectrum().value();
		create_cloud_mask(cloud_mask_coord.length,range_branches,range_radius,master_colour,spectrum);
	}

	// render cloud mask
	private void mask_cloud_mask_chose(int target, PGraphics pg_buffer) {
		beginShape(pg_buffer);
		cloud_mask_chose[target].calc();
		for(int k = 0 ; k < cloud_mask_chose[target].get_points().length ; k++) {
			vec2 temp_pos = vec2(cloud_mask_chose[target].get_points()[k]).add(cloud_mask_coord[target].xy());
			vertex(temp_pos,pg_buffer);
		} 
		endShape(CLOSE,pg_buffer);
	}

	private void create_cloud_coord(ivec2 num_range_cloud) {
		int num = (int)random(num_range_cloud.min(),num_range_cloud.max());
		cloud_mask_coord = new vec2[num];
		int marge = 50;
		for(int i = 0 ; i < cloud_mask_coord.length ; i++) {
			cloud_mask_coord[i] = vec2().rand(vec2(-marge),vec2(width+marge,height+marge));
		}
	}

	private void create_cloud_mask(int num, ivec2 branch, ivec2 radius, int master_colour, float spectrum) {
		cloud_mask_chose = new R_Chose[num];
		fill_choses = new int[num];
		int num_group = 3;
		int [] colour_paleltte = hue_palette(master_colour, num_group, num, spectrum);
		for(int i = 0 ; i < num ; i++) {
			cloud_mask_chose[i] = new R_Chose(p5,(int)random(branch.min(),branch.max()));

			fill_choses[i] = colour_paleltte[i];
			float [] relief = new float[(int)random(2,cloud_mask_chose[i].get_summits())];
			for(int k = 0 ; k < relief.length ; k++) {
				relief[k] = random(radius.min(),radius.max());
			}
			cloud_mask_chose[i].radius(relief);
			cloud_mask_chose[i].angle_x(random(TAU));
		}
	}

	private void update_cloud_mask(float swing) {
		if(cloud_mask_chose != null) {
			for(R_Chose chose : cloud_mask_chose) {
				float [] relief = chose.get_radius();
				for(int i = 0 ; i < relief.length ; i++) {
					relief[i] = chose.get_radius(i) + random(-swing,swing);
				}
				chose.radius(relief);
				chose.reset_is(true);
			}
		}
	}

	private void render_cloud_mask(PGraphics pg_buffer, int mode) {
		if(cloud_mask_coord != null) {
			for (int i = 0 ; i < cloud_mask_coord.length ; i++) {
				if (mode == 0) {
					// here we use hue value, because this one is a only one with different value in the array
					// because when we create colour with hue_palette the variation is only on hue, not on saturation and brightness.
					float gray = map(hue(fill_choses[i]),0,g.colorModeX,0,g.colorModeZ);
					fill(0,0,gray,pg_buffer);
				} else if(mode == 1) {
					// fill(r.WHITE,pg_buffer); // like other item tartan
				} else if(mode == 2) {
					// fill(r.BLACK,pg_buffer); // like other item tartan
				} else if(mode == 3) {
					fill(fill_choses[i],pg_buffer);
				}
				noStroke(pg_buffer);
				mask_cloud_mask_chose(i,pg_buffer); 
			}
		}	
	}
}

































/**
* Tartan v 0.0.5
*/
public class Tartan {
	int [] tartan_pattern;
	R_Colour palette;
	float alpha = 0.5;
	private int complexity = 2;
	private int min = 1;
	private int max = 2;

	public Tartan(PApplet pa, int complexity, int min, int max) {
		if(complexity < 2) complexity = 2;
		if(min < 1) min = 1;
		if(max <= min) max = min +1;
		this.complexity = complexity;
		this.min = min;
		this.max = max;
		set_pattern();
		set_gray(pa);
	}

	public void set_pattern() {
		// contain entry value;
		int range = max - min;
		tartan_pattern = new int[complexity];
		for(int i = 0 ; i < tartan_pattern.length ; i++) {
			tartan_pattern[i] = ceil(random(range));
		}
	}

	private void set_gray(PApplet pa) {
		palette = new R_Colour(pa);
		for(int i = 0 ; i < complexity ; i++) {
			palette.add(color(random(g.colorModeX))); 
		}
	}

	public int length() {
		return complexity;
	}

	public void set_colour(int index, int colour) {
		if(index >= 0 && index < palette.size()) {
			palette.set(index,colour);
		} else {
			printErr("class Tartan method set_colour(int index, int colour): index ", index, " is out of the array colour");
		}
	}


	public void set_palette(int... colour) {
		for(int i = 0 ; i < colour.length && i < palette.size(0) ; i++) {
			palette.set(i,colour[i]);
		}
	}

	public int [] get_palette() {
		return palette.get(0);
	}

	private void show(boolean single) {
		show(single, g);
	}

	private void show(boolean single, PGraphics pg) {
		// set final pattern desing and colour
		int [] pattern = tartan_pattern;
		int [] colour = palette.get();
		if(!single) {
			colour = new int[palette.size() *2];
			pattern = new int[tartan_pattern.length *2];
			int index = 0;
			for(int i = 0 ; i < pattern.length ; i++) {
				pattern[i] = tartan_pattern[index];
				colour[i] = palette.get()[index];
				if(i < tartan_pattern.length -1) {
					index++;
				} else if(i > tartan_pattern.length -1) {
					index--;
				}
			}
		}

		noStroke(pg);
		// col
		int col = 0;
		while(col <  pg.width) {
			for(int index = 0 ; index < pattern.length ; index++) {
				fill(colour[index], pg.colorModeA * alpha, pg);
				rect(col,0,pattern[index], pg.height, pg);
				col += pattern[index];
			}
		}
		// row
		int row = 0;
		while(row <  pg.height) {
			for(int index = 0 ; index < pattern.length ; index++) {
				fill(colour[index], pg.colorModeA * alpha, pg);
				rect(0,row, pg.width,pattern[index], pg);
				row += pattern[index];
			}
		}
	}
}
