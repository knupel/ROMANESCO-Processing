/**
* Template
* the tab is the template that you can duplicate to add the item you want in your Romanesco.
* You must change the class name and this one must be unique.
* v 0.1.1
* 2018-2019
*/
class Template extends Romanesco {
	public Template() {
		//from the index_objects.csv
		item_name = "Template" ;
		item_author  = "Stan le Punk";
		item_references = "";
		item_version = "Version 0.0.7";
		item_pack = "Base 2012-2019" ;
		item_costume = "point/ellipse/triangle/rect/cross/pentagon/Star 5/Star 7/Super Star 8/Super Star 12"; // costume available from get_costume();
		item_mode = "";
		// define slider
		// COL 1
		hue_fill_is = true; // 0 > 360
		sat_fill_is = true; // 0 > 100
		bright_fill_is = true; // 0 > 100
		alpha_fill_is = true; // 0 > 100
		hue_stroke_is = true; // 0 > 360
		sat_stroke_is = true; // 0 > 100
		bright_stroke_is = true; // 0 > 100
		alpha_stroke_is = true; // 0 > 100
		thickness_is = true; // 0 > width * 0.01
		size_x_is = true; // 0 > width
		size_y_is = true; // 0 > width
		size_z_is = true; // 0 > width
		// diameter_is = true; // 0 > width
		// canvas_x_is = true; // 0 > width
		// canvas_y_is = true; // 0 > width
		// canvas_z_is = true; // 0 > width

		// COL 2
		// frequence_is = true; // 0 > 1
		// speed_x_is = true; // 0 > 1
		// speed_y_is = true; // 0 > 1
		// speed_z_is = true; // 0 > 1
		// spurt_x_is = true; // 0 > 1
		// spurt_y_is = true; // 0 > 1
		// spurt_z_is = true; // 0 > 1
		// dir_x_is = true; // 0 > TAU
		// dir_y_is = true; // 0 > TAU
		// dir_z_is = true; // 0 > TAU
		// jit_x_is = true; // 0 > 1
		// jit_y_is = true; // 0 > 1
		// jit_z_is  = true; // 0 > 1
		// swing_x_is = true; // 0 > 1
		// swing_y_is = true; // 0 > 1
		// swing_z_is = true; // 0 > 1

		// COL 3
		// quantity_is = true; // 0 > 1
		// variety_is =true; // 0 > 1
		// life_is = true; // 0 > 1
		// flow_is = true; // 0 > 1
		// quality_is = true; // 0 > 1
		// area_is = true; // 0 > width
		// angle_is = true; // 0 > TAU
		// scope_is = true; // 0 > width
		// scan_is = true; // 0 > TAU
		// align_is = true;  // 0 > 1
		// repulsion_is = true;  // 0 > 1
		// attraction_is = true; // 0 > 1
		// density_is = true; // 0 > 1
		// influence_is = true; // 0 > 1
		// calm_is = true; // 0 > 1
		// spectrum_is = true; // 0 > 360

		// COL 4
		// grid_is = true; // 0 > width
		// viscosity_is = true; // 0 > 1
		// diffusion_is = true; // 0 > 1
		// power_is = true; // 0 > 1
		// mass_is = true; // 0 > 1
		// amplitude_is = true; // 0 > 1
		// coord_x_is = true; // 0 > 1
		// coord_y_is = true; // 0 > 1
		// coord_z_is = true; // 0 > 1
	}

	void setup() {
		// give the starting position of your item on the 3D grid
		set_item_pos(width/2,height/2,0);
		set_item_dir(HALF_PI,PI);
	}
	
	//DRAW
	void draw() {
		// here if you want code in 3D mode
		info("info about the item","more","more");
		aspect_is(fill_is(),stroke_is(),alpha_is());
		aspect(get_fill(),get_stroke(),get_thickness().value());
		set_ratio_costume_size(map(get_area().value(),get_area().min(),get_area().max(),0,1));

		costume(vec3(),get_size(),get_costume());
		println("costume",get_costume().get_name());

		println("mode",get_mode_name(),get_mode_id());

		println("slider vec",get_size());
		println("slider value from min to max",get_size_x().value()); // sometime 0 to 1 or 0 to width or 0 to TAU
		println("slider value min",get_size_x().min());
		println("slider value max",get_size_x().max());

		println("slider raw from 0 to 360",get_size_x().raw());
		println("slider raw min",get_size_x().min_raw());
		println("slider rawmax",get_size_x().max_raw());

		println("slider normal from 0 to 1",get_size_x().normal());

	}

	void draw_2D() {
		// here if you want code in 2D mode
	}
}















