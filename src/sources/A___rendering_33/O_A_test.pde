/**
* Template
* the tab is the template that you can duplicate to add the item you want in your Romanesco.
* You must change the class name and this one must be unique.
* v 0.1.1
* 2018-2019
*/
class Test extends Romanesco {
	public Test() {
		//from the index_objects.csv
		item_name = "Test" ;
		item_author  = "Stan le Punk";
		item_references = "";
		item_version = "Version 0.0.1";
		item_pack = "Base 2021-2021" ;
		item_costume = "point/ellipse/triangle/rect/cross/pentagon/Star 5/Star 7/Super Star 8/Super Star 12"; // costume available from get_costume();
		item_mode = "";
		// define slider
		set_true_all_sliders_for_O_A_test(this);
	}

			R_Icosahedron icosahedron;
		
	void setup() {
		// give the starting position of your item on the 3D grid
		set_item_pos(width/2,height/2,0);
		set_item_dir(HALF_PI,PI);
		int radius = width/5;
		icosahedron = new R_Icosahedron(p5, radius);
	}
	
	//DRAW
	void draw() {
		// what_you_need_for_O_A_test(this);

		aspect(get_fill(),get_stroke(),get_thickness().value());
		// float thickness = map(sin(frameCount * 0.003),-1,1,0.1,10);
		float size = get_diameter().value();
		// float size = map(sin(frameCount * 0.005),-1,1,radius -10,radius +10);
		float dist = map(get_amplitude().value(),0,1, 0.1f,1.15f);
		println("get_mass()", get_mass().value());
		println("get_amplitude()", get_amplitude().value());
		println("dist", dist);
		println("size", size);
		icosahedron.size(size);
		icosahedron.update();
		R_Face [] faces = icosahedron.get_faces().toArray(new R_Face[0]);
		vec3 [] normals = icosahedron.get_normals().toArray(new vec3[0]);
		for(int i = 0 ; i < faces.length ; i++) {
			normals[i].mult(dist);
			faces[i].offset(normals[i]);
			faces[i].show();
		}


	}

	void draw_2D() {
		// here if you want code in 2D mode
	}
}



void what_you_need_for_O_A_test(Romanesco ro) {
	ro.info("info about the item","more","more");
	aspect_is(ro.fill_is(),ro.stroke_is(),ro.alpha_is());
	aspect(ro.get_fill(),ro.get_stroke(),ro.get_thickness().value());
	set_ratio_costume_size(map(ro.get_area().value(),ro.get_area().min(),ro.get_area().max(),0,1));

	// costume(vec3(),ro.get_size(),ro.get_costume());
	println("costume",ro.get_costume().get_name());

	println("mode",ro.get_mode_name(),ro.get_mode_id());

	println("slider vec",ro.get_size());
	println("slider value from min to max",ro.get_size_x().value()); // sometime 0 to 1 or 0 to width or 0 to TAU
	println("slider value min",ro.get_size_x().min());
	println("slider value max",ro.get_size_x().max());

	println("slider raw from 0 to 360",ro.get_size_x().raw()); // raw always from 0 to 360
	println("slider raw min",ro.get_size_x().min_raw()); // 0
	println("slider raw max",ro.get_size_x().max_raw()); // 360
	
	println("slider raw from 0 to 360",ro.get_size_x().raw());
	println("slider raw min",ro.get_size_x().min_raw());
	println("slider raw max",ro.get_size_x().max_raw());

	println("slider normal from 0 to 1",ro.get_size_x().normal());
}



void set_true_all_sliders_for_O_A_test(Romanesco ro) {
	// COL 1
	ro.hue_fill_is = true; // 0 > 360 // get_hue();
	ro.sat_fill_is = true; // 0 > 100
	ro.bright_fill_is = true; // 0 > 100
	ro.alpha_fill_is = true; // 0 > 100
	ro.hue_stroke_is = true; // 0 > 360
	ro.sat_stroke_is = true; // 0 > 100
	ro.bright_stroke_is = true; // 0 > 100
	ro.alpha_stroke_is = true; // 0 > 100
	ro.thickness_is = true; // 0 > width * 0.01
	ro.size_x_is = true; // 0 > width
	ro.size_y_is = true; // 0 > width
	ro.size_z_is = true; // 0 > width
	ro.diameter_is = true; // 0 > width
	ro.canvas_x_is = true; // 0 > width
	ro.canvas_y_is = true; // 0 > width
	ro.canvas_z_is = true; // 0 > width

	// COL 2
	ro.frequence_is = true; // 0 > 1
	ro.speed_x_is = true; // 0 > 1
	ro.speed_y_is = true; // 0 > 1
	ro.speed_z_is = true; // 0 > 1
	ro.spurt_x_is = true; // 0 > 1
	ro.spurt_y_is = true; // 0 > 1
	ro.spurt_z_is = true; // 0 > 1
	ro.dir_x_is = true; // 0 > TAU
	ro.dir_y_is = true; // 0 > TAU
	ro.dir_z_is = true; // 0 > TAU
	ro.jit_x_is = true; // 0 > 1
	ro.jit_y_is = true; // 0 > 1
	ro.jit_z_is  = true; // 0 > 1
	ro.swing_x_is = true; // 0 > 1
	ro.swing_y_is = true; // 0 > 1
	ro.swing_z_is = true; // 0 > 1

	// COL 3
	ro.quantity_is = true; // 0 > 1
	ro.variety_is =true; // 0 > 1
	ro.life_is = true; // 0 > 1
	ro.flow_is = true; // 0 > 1
	ro.quality_is = true; // 0 > 1
	ro.area_is = true; // 0 > width
	ro.angle_is = true; // 0 > TAU
	ro.scope_is = true; // 0 > width
	ro.scan_is = true; // 0 > TAU
	ro.align_is = true;  // 0 > 1
	ro.repulsion_is = true;  // 0 > 1
	ro.attraction_is = true; // 0 > 1
	ro.density_is = true; // 0 > 1
	ro.influence_is = true; // 0 > 1
	ro.calm_is = true; // 0 > 1
	ro.spectrum_is = true; // 0 > 360

	// COL 4
	ro.grid_is = true; // 0 > width
	ro.viscosity_is = true; // 0 > 1
	ro.diffusion_is = true; // 0 > 1
	ro.power_is = true; // 0 > 1
	ro.mass_is = true; // 0 > 1
	ro.amplitude_is = true; // 0 > 1
	ro.coord_x_is = true; // 0 > 1
	ro.coord_y_is = true; // 0 > 1
	ro.coord_z_is = true; // 0 > 1
}



















