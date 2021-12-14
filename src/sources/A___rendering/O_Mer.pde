/**
* Wave
* 2019-2021
* v 0.1.3
*/
class Mer extends Romanesco {
	public Mer() {
		//from the index_objects.csv
		item_name = "Mer" ;
		item_author  = "Stan le Punk";
		item_references = "";
		item_version = "Version 0.1.3";
		item_pack = "Base 2019-2021";
		item_costume = "ellipse/triangle/rect/"; // costume available from get_costume();
		// item_costume = "ellipse/triangle/rect/pentagon/flower/Star 5/Star 7/Super Star 8/Super Star 12/point"; // costume available from get_costume();
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
		diameter_is = true;
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
	int cell_x = 2;
	int cell_y = 2;
	int offset_x = cell_x/2;
	int offset_y = cell_y/2;
	Wave [] ani ;
	boolean build_sea_is;
	PGraphics mer_pg;

	void setup() {
		// give the starting position of your item on the 3D grid
		ani = new Wave[cols*rows];
		set_item_pos(width/2,height/2,0);
	}
	
	//DRAW
	
	void draw() {
		info("info about the item","more","more");
	}
	
	
	void draw_2D() {
		if(birth_is()) {
			build_sea_is = false;
			birth_is(false);
			if(mer_pg == null) {
				mer_pg = createGraphics(width,height,P2D);
			}
		}
		if(!build_sea_is) {
			cols = (int)map(get_canvas_x().value(),get_canvas_x().min(),get_canvas_x().max(),2,width/10);
			rows = (int)map(get_canvas_y().value(),get_canvas_y().min(),get_canvas_y().max(),2,height/10);
			ani = new Wave[cols*rows];
			cell_x = width/cols;
			cell_y = height/rows;
			offset_x = cell_x/2;
			offset_y = cell_y/2;
			float min_size_wave = 5;
			vec2 size_max_wave = vec2(get_size());
			float start_hue_fill = get_fill_hue().value();
			build_sea_grid(min_size_wave,size_max_wave,get_speed_x().value(),start_hue_fill);
			build_sea_is = true;
		}

		// size shape
		float min_size = height * 0.01;
    float max_size = height * 0.2;
		float size = map(get_diameter().value(), get_diameter().min(), get_diameter().max(), min_size, max_size);
    
    // show
    if(mer_pg != null) {
    	beginDraw(mer_pg);
			background(get_background(),mer_pg);
		}
		int count = 0;
		for(int j = 0; j < rows ; j++) {
			for(int i = 0 ; i < cols ; i++) {  
				int x = i * cell_x +offset_x;
				int y = j * cell_y +offset_y;
				if(count < ani.length) {
					ani[count].update();
					// ani[count].set_speed(get_speed_x());
					// ani[count].set_radius(get_size_x(),get_size_y());

					// there is a bug for stroke gestion with the mask because Processing don't manage the overlap on image()
					// ani[count].aspect(get_fill_alp().value(), get_stroke_alp().value(), get_thickness().value());
					ani[count].aspect_wave(get_fill_alp().value(), 0, 0, mer_pg);
					// ani[count].aspect_wave(get_fill_alp().value(), get_stroke(), get_thickness().value(), mer_pg);
					ani[count].render_shape(x,y, size, get_costume(), mer_pg);
					count++; 
				}
			}
		}
		if(mer_pg != null) {
			endDraw(mer_pg);
		}	
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

		void reset_cycle() {
			cycle = 0;
		}

		void set_speed(float speed) {
			this.speed = speed;
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

		void aspect_wave(float fill_alpha, int stroke_alpha, float thickness, PGraphics other) {
			float hue = (cycle*speed+start_hue)%g.colorModeX; // ici c'est égale à 360, définit avec colorMode dans le setup;
			float saturation = g.colorModeY;
			float brightness = g.colorModeZ;
			int colour_fill = color(hue,saturation,brightness,fill_alpha);
			// int colour_stroke = stroke;
			int colour_stroke = color(hue,saturation,brightness,stroke_alpha);
			if(other != null) {
				aspect(colour_fill,colour_stroke,thickness,other);
			} else {
				aspect(colour_fill,colour_stroke,thickness);
			}
		}

		void render_shape(int x, int y, float max_size, R_Costume costume, PGraphics other) {
			vec2 pos = to_cartesian_2D(dir);
			pos.mult(rx,ry);
			float size = abs(sin(frameCount *speed) *max_size);
			if(other != null) {
				push(other);
				translate(x,y,other);
				costume(vec3(pos),vec3(size),costume,other);
				pop(other);
				set_background(other,CENTER);
			} else {
				push();
				translate(x,y);
				costume(vec3(pos),vec3(size),costume);
				pop();
			}
		}
	}
}















