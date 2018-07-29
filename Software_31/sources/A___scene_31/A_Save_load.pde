/**
SAVE LOAD
v 0.2.0
*/
String path_to_load_scene_setting = ("") ;
void loadScene() {
	if(!path_to_load_scene_setting.equals("") ) {
		loadDataObject(path_to_load_scene_setting) ;
	}
}







// SAVE data OBJ
/**
Here you save all the scene parameter
*/
boolean openSave = true ;
void saveScene() {
	if(( save_New_SCENE_Setting_GLOBAL || save_New_SCENE_Setting_order_from_presecene) && openSave) {
		// println("create a new save") ;
		openSave = false ;
		File tempFileName = new File ("your_scene_setting.json");
		selectOutput("Save Scene", "saveSetting", tempFileName);
		
	} else if((save_Current_SCENE_Setting_GLOBAL || save_Current_SCENE_Setting_order_from_presecene) && openSave) {
		openSave = false ;
		if(!save_path_data_scene.equals("")) {
			save_data_scene(save_path_data_scene) ; 
		} else {
			File tempFileName = new File ("your_scene_setting.json");
			selectOutput("Save Scene", "save_setting_scene", tempFileName);
		}
	}
}


String save_path_data_scene = ("");
void save_setting_scene(File selection) {
	if (selection != null) {
  	save_path_data_scene = selection.getAbsolutePath();
    save_data_scene(save_path_data_scene);
  } 
  openSave = true;
}




void save_data_scene(String path) {
	JSONArray save = new JSONArray();
	// init counter
	int startPosJSONDataWorld = 0;
	int startPosJSONDataCam = 1;
	int startPosJSONDataObj = 0;


    // FIRST PART
    /////////////
	JSONObject data_world = new JSONObject();
	// Romanesco info
	data_world.setString("Info",nameVersion + " / " + prettyVersion + "." +version );

	// world
	// background
	data_world.setInt("which shader",which_shader);
	data_world.setBoolean("on/off", background_button_is());


	data_world.setFloat("hue background", colorBackground.r) ;
	data_world.setFloat("saturation background", colorBackground.g);
	data_world.setFloat("brightness background", colorBackground.b);
	data_world.setFloat("refresh background", colorBackground.a);

	// color ambient light
	data_world.setFloat("hue ambient", color_light[0].r);
	data_world.setFloat("saturation ambient", color_light[0].g);
	data_world.setFloat("brightness ambient", color_light[0].b);
	data_world.setFloat("alpha ambient", color_light[0].a);
	// pos ambient light
	/**
	Not use at this time
	dataWorld.setFloat("pos x ambient", value) ;
	dataWorld.setFloat("pos y ambient", value) ;
	dataWorld.setFloat("pos z ambient", value) ;
	*/
	// color light one
	data_world.setFloat("hue light 1", color_light[1].r);
	data_world.setFloat("saturation light 1", color_light[1].g);
	data_world.setFloat("brightness light 1", color_light[1].b);
	data_world.setFloat("alpha light 1", color_light[1].a);
		// color light two
	data_world.setFloat("hue light 2", color_light[2].r);
	data_world.setFloat("saturation light 2", color_light[2].g);
	data_world.setFloat("brightness light 2", color_light[2].b);
	data_world.setFloat("alpha light 2", color_light[2].a);
	// pos light one
	data_world.setFloat("pos x light 1", pos_light[1].x);
	data_world.setFloat("pos y light 1", pos_light[1].y);
	data_world.setFloat("pos z light 1", pos_light[1].z);

	// pos light two
	data_world.setFloat("pos x light 2", pos_light[2].x);
	data_world.setFloat("pos y light 2", pos_light[2].y);
	data_world.setFloat("pos z light 2", pos_light[2].z);
	// sound
	/**
	// I don't know, if it's pertinent to save this data ?
	dataWorld.setFloat("sound left", value) ;
	dataWorld.setFloat("sound right", value) ;
	dataWorld.setBoolean("beat", value) ;
	dataWorld.setBoolean("kick", value) ;
	dataWorld.setBoolean("snare", value) ;
	dataWorld.setBoolean("hat", value) ;
	*/
	// add data world in the JSON array
	save.setJSONObject(startPosJSONDataWorld,data_world);

	// SECOND PART
	//////////////
	// camera
	// in this time we have only one camera change for the release 28, I hope
	int numCamera = 1 ;
	for (int i = 0 ; i <numCamera ; i++) {
		JSONObject data_cam = new JSONObject();
		data_cam.setFloat("focal",focal);
		data_cam.setFloat("deformation",deformation);
		/*
		dirCamX, dirCamY, dirCamZ, centerCamX, centerCamY, centerCamZ, upX, upY, upZ
		*/
		data_cam.setFloat("eye x", dirCamX);
		data_cam.setFloat("eye y", dirCamY);
		data_cam.setFloat("eye z", dirCamZ);
		data_cam.setFloat("pos x", centerCamX);
		data_cam.setFloat("pos y", centerCamY);
		data_cam.setFloat("pos z", centerCamY);
		data_cam.setFloat("upX", upX);
		/**
		// not use in this time, maybe for the future
		dataCam.setFloat("upY", upY) ;
		dataCam.setFloat("upZ", upZ) ;
		*/
    // curent position
		data_cam.setFloat("scene x", finalSceneCamera.x /width);
		data_cam.setFloat("scene y", finalSceneCamera.y /width);
		data_cam.setFloat("scene z", finalSceneCamera.z /width);
		data_cam.setFloat("longitude", finalEyeCamera.x);
		data_cam.setFloat("latitude", finalEyeCamera.y);
		// save in the JSON Array
		save.setJSONObject(startPosJSONDataCam +i,data_cam) ;
	}
	// give the static start point in the JSON Array
	startPosJSONDataObj = startPosJSONDataCam + numCamera ;
	
    // THIRD PART
    //////////////
	for (int i = 0 ; i <= NUM_ITEM ; i++) {
		JSONObject data_item = new JSONObject();
		// info obj
		data_item.setInt   ("ID item", item_ID[i]) ;   // big space to read easily the JSON
		data_item.setString("Name item                   ", item_name[i]); // big space to read easily the JSON
		data_item.setString("Author item                 ", item_author[i]); // big space to read easily the JSON
		data_item.setString("Version item                ", item_version[i]); // big space to read easily the JSON
		data_item.setString("Pack item                   ", item_pack[i]); // big space to read easily the JSON
		// external data obj
		data_item.setInt("which font", 0) ; // problem with PFont
		data_item.setInt("which picture", which_bitmap[i]) ; // problem with var whichPicture[]
		data_item.setInt("which text", which_text[i]); // problem with var which_text[]
        // display mode
		data_item.setInt("Costume item", costume_controller_selection[i]);
		data_item.setInt("Mode item", mode[i]);
        // slider 
		data_item.setFloat(fill_hue_name, hue(fill_item[i]));
		data_item.setFloat(fill_sat_name, saturation(fill_item[i]));
		data_item.setFloat(fill_bright_name, brightness(fill_item[i]));
		data_item.setFloat(fill_alpha_name, alpha(fill_item[i]));

		data_item.setFloat(stroke_hue_name, hue(stroke_item[i]));
		data_item.setFloat(stroke_sat_name, saturation(stroke_item[i]));
		data_item.setFloat(stroke_bright_name, brightness(stroke_item[i]));
		data_item.setFloat(stroke_alpha_name, alpha(stroke_item[i]));

		data_item.setFloat(thickness_name, thickness_item[i] /height);

		data_item.setFloat(size_x_name, size_x_item[i] /width);
		data_item.setFloat(size_y_name, size_y_item[i] /width);
		data_item.setFloat(size_z_name, size_z_item[i] /width);

		data_item.setFloat(diameter_name, diameter_item[i] /width); // check the size

		data_item.setFloat(canvas_x_name, canvas_x_item[i] /width);
		data_item.setFloat(canvas_y_name, canvas_y_item[i] /width);
		data_item.setFloat(canvas_z_name, canvas_z_item[i] /width);

		data_item.setFloat(frequence_name, frequence_item[i]);

		data_item.setFloat(speed_x_name, speed_x_item[i]);
		data_item.setFloat(speed_y_name, speed_y_item[i]);
		data_item.setFloat(speed_z_name, speed_z_item[i]);

		data_item.setFloat(spurt_x_name, spurt_x_item[i]);
		data_item.setFloat(spurt_y_name, spurt_y_item[i]);
		data_item.setFloat(spurt_z_name, spurt_z_item[i]);

		data_item.setFloat(dir_x_name, dir_x_item[i]);
		data_item.setFloat(dir_y_name, dir_y_item[i]);
		data_item.setFloat(dir_z_name, dir_z_item[i]);

		data_item.setFloat(jitter_x_name, jitter_x_item[i]);
		data_item.setFloat(jitter_y_name, jitter_y_item[i]);
		data_item.setFloat(jitter_z_name, jitter_z_item[i]);

		data_item.setFloat(swing_x_name, swing_x_item[i]);
		data_item.setFloat(swing_y_name, swing_y_item[i]);
		data_item.setFloat(swing_z_name, swing_z_item[i]);

		data_item.setFloat(quantity_name, quantity_item[i]);
		data_item.setFloat(variety_name, variety_item[i]);

		data_item.setFloat(life_name, life_item[i]);
		data_item.setFloat(flow_name, flow_item[i]);
		data_item.setFloat(quality_name, quality_item[i]);

		data_item.setFloat(area_name, area_item[i] /width);
		data_item.setFloat(angle_name, angle_item[i]);
		data_item.setFloat(scope_name, scope_item[i] /width);
		data_item.setFloat(scan_name, scan_item[i]);

		data_item.setFloat(alignment_name, alignment_item[i]);
		data_item.setFloat(repulsion_name, repulsion_item[i]);
		data_item.setFloat(attraction_name, attraction_item[i]);
		data_item.setFloat(density_name, density_item[i]);

		data_item.setFloat(influence_name, influence_item[i]);
		data_item.setFloat(calm_name, calm_item[i]);
		data_item.setFloat(spectrum_name, spectrum_item[i]);

		data_item.setFloat(grid_name, grid_item[i]);
		data_item.setFloat(viscosity_name, viscosity_item[i]);
		data_item.setFloat(diffusion_name, diffusion_item[i]);
        
    // position & orientation
		data_item.setFloat("pos x item", pos_item_final[i].x /width);
		data_item.setFloat("pos y item", pos_item_final[i].y /width);
		data_item.setFloat("pos z item", pos_item_final[i].z /width);

		data_item.setFloat("longitude item", dir_item_final[i].x);
		data_item.setFloat("latitude item", dir_item_final[i].y);
		// save in the JSON Array
		save.setJSONObject(startPosJSONDataObj +i,data_item);
	}
    //
	saveJSONArray(save, path);
}