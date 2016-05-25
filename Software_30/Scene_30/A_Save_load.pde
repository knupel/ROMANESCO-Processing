// Tab: A_Save_load
String path_to_load_scene_setting = ("") ;
// boolean openLoad = true ;


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
		if(!savePathSetting.equals("")) {
			// println("save on the current save", savePathSetting) ;
			saveDataObject(savePathSetting) ; 
		} else {
			File tempFileName = new File ("your_scene_setting.json");
			selectOutput("Save Scene", "saveSetting", tempFileName);
		}
	}
}


String savePathSetting = ("") ;
void saveSetting(File selection) {
	if (selection != null) {
  	savePathSetting = selection.getAbsolutePath() ;
    saveDataObject(savePathSetting) ;
  } 
  openSave = true ;
}




void saveDataObject(String path) {
	JSONArray save = new JSONArray() ;
	// init counter
	int startPosJSONDataWorld = 0 ;
	int startPosJSONDataCam = 1 ;
	int startPosJSONDataObj = 0;


    // FIRST PART
    /////////////
	JSONObject dataWorld = new JSONObject();
	// Romanesco info
	dataWorld.setString("Info",nameVersion + " / " + prettyVersion + "." +version ) ;

	// world
	// background
	dataWorld.setInt("which shader",whichShader) ;
	dataWorld.setBoolean("on/off", onOffBackground) ;


	dataWorld.setFloat("hue background", colorBackground.r) ;
	dataWorld.setFloat("saturation background", colorBackground.g) ;
	dataWorld.setFloat("brightness background", colorBackground.b) ;
	dataWorld.setFloat("refresh background", colorBackground.a) ;

	// color ambient light
	dataWorld.setFloat("hue ambient", color_light[0].r) ;
	dataWorld.setFloat("saturation ambient", color_light[0].g) ;
	dataWorld.setFloat("brightness ambient", color_light[0].b) ;
	dataWorld.setFloat("alpha ambient", color_light[0].a) ;
	// pos ambient light
	/**
	Not use at this time
	dataWorld.setFloat("pos x ambient", value) ;
	dataWorld.setFloat("pos y ambient", value) ;
	dataWorld.setFloat("pos z ambient", value) ;
	*/
	// color light one
	dataWorld.setFloat("hue light 1", color_light[1].r) ;
	dataWorld.setFloat("saturation light 1", color_light[1].g) ;
	dataWorld.setFloat("brightness light 1", color_light[1].b) ;
	dataWorld.setFloat("alpha light 1", color_light[1].a) ;
		// color light two
	dataWorld.setFloat("hue light 2", color_light[2].r) ;
	dataWorld.setFloat("saturation light 2", color_light[2].g) ;
	dataWorld.setFloat("brightness light 2", color_light[2].b) ;
	dataWorld.setFloat("alpha light 2", color_light[2].a) ;
	// pos light one
	dataWorld.setFloat("pos x light 1", pos_light[1].x) ;
	dataWorld.setFloat("pos y light 1", pos_light[1].y) ;
	dataWorld.setFloat("pos z light 1", pos_light[1].z) ;

	// pos light two
	dataWorld.setFloat("pos x light 2", pos_light[2].x) ;
	dataWorld.setFloat("pos y light 2", pos_light[2].y) ;
	dataWorld.setFloat("pos z light 2", pos_light[2].z) ;
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
	save.setJSONObject(startPosJSONDataWorld,dataWorld) ;

	// SECOND PART
	//////////////
	// camera
	// in this time we have only one camera change for the release 28, I hope
	int numCamera = 1 ;
	for (int i = 0 ; i <numCamera ; i++) {
		JSONObject dataCam = new JSONObject();
		dataCam.setFloat("focal", focal) ;
		dataCam.setFloat("deformation", deformation) ;
		/*
		dirCamX, dirCamY, dirCamZ, centerCamX, centerCamY, centerCamZ, upX, upY, upZ
		*/
		dataCam.setFloat("eye x", dirCamX) ;
		dataCam.setFloat("eye y", dirCamY) ;
		dataCam.setFloat("eye z", dirCamZ) ;
		dataCam.setFloat("pos x", centerCamX) ;
		dataCam.setFloat("pos y", centerCamY) ;
		dataCam.setFloat("pos z", centerCamY) ;
		dataCam.setFloat("upX", upX) ;
		/**
		// not use in this time, maybe for the future
		dataCam.setFloat("upY", upY) ;
		dataCam.setFloat("upZ", upZ) ;
		*/
        // curent position
		dataCam.setFloat("scene x", finalSceneCamera.x /width) ;
		dataCam.setFloat("scene y", finalSceneCamera.y /width) ;
		dataCam.setFloat("scene z", finalSceneCamera.z /width) ;
		dataCam.setFloat("longitude", finalEyeCamera.x) ;
		dataCam.setFloat("latitude", finalEyeCamera.y) ;
		// save in the JSON Array
		save.setJSONObject(startPosJSONDataCam +i,dataCam) ;
	}
	// give the static start point in the JSON Array
	startPosJSONDataObj = startPosJSONDataCam + numCamera ;
	
    // THIRD PART
    //////////////
	// obj
	int numObj = NUM_OBJ ;
	for (int i = 0 ; i <= numObj ; i++) {
		JSONObject dataObj = new JSONObject();
		// info obj
		dataObj.setInt   ("ID obj", objectID[i]) ;   // big space to read easily the JSON
		dataObj.setString("Name obj                   ", objectName[i]) ; // big space to read easily the JSON
		dataObj.setString("Author obj                 ", objectAuthor[i]) ; // big space to read easily the JSON
		dataObj.setString("Version obj                ", objectVersion[i]) ; // big space to read easily the JSON
		dataObj.setString("Pack obj                   ", objectPack[i]) ; // big space to read easily the JSON
		// external data obj
		dataObj.setInt("which font", 0) ; // problem with PFont
		dataObj.setInt("which picture", which_bitmap[i]) ; // problem with var whichPicture[]
		dataObj.setInt("which text", which_text[i]) ; // problem with var which_text[]
        // display mode
		dataObj.setInt("Mode obj", mode[i]) ;
        // slider 
		dataObj.setFloat(fill_hue_name, hue(fill_item[i])) ;
		dataObj.setFloat(fill_sat_name, saturation(fill_item[i])) ;
		dataObj.setFloat(fill_bright_name, brightness(fill_item[i])) ;
		dataObj.setFloat(fill_alpha_name, alpha(fill_item[i])) ;

		dataObj.setFloat(stroke_hue_name, hue(stroke_item[i])) ;
		dataObj.setFloat(stroke_sat_name, saturation(stroke_item[i])) ;
		dataObj.setFloat(stroke_bright_name, brightness(stroke_item[i])) ;
		dataObj.setFloat(stroke_alpha_name, alpha(stroke_item[i])) ;

		dataObj.setFloat(thickness_name, thickness_item[i] /height) ;

		dataObj.setFloat(size_x_name, size_x_item[i] /width) ;
		dataObj.setFloat(size_y_name, size_y_item[i] /width) ;
		dataObj.setFloat(size_z_name, size_z_item[i] /width) ;

		dataObj.setFloat(font_size_name, font_size_item[i] /width) ; // check the size

		dataObj.setFloat(canvas_x_name, canvas_x_item[i] /width) ;
		dataObj.setFloat(canvas_y_name, canvas_y_item[i] /width) ;
		dataObj.setFloat(canvas_z_name, canvas_z_item[i] /width) ;

		dataObj.setFloat(reactivity_name, reactivity_item[i]) ;

		dataObj.setFloat(speed_x_name, speed_x_item[i]) ;
		dataObj.setFloat(speed_y_name, speed_y_item[i]) ;
		dataObj.setFloat(speed_z_name, speed_z_item[i]) ;

		dataObj.setFloat(spurt_x_name, spurt_x_item[i]) ;
		dataObj.setFloat(spurt_y_name, spurt_y_item[i]) ;
		dataObj.setFloat(spurt_z_name, spurt_z_item[i]) ;

		dataObj.setFloat(dir_x_name, dir_x_item[i]) ;
		dataObj.setFloat(dir_y_name, dir_y_item[i]) ;
		dataObj.setFloat(dir_z_name, dir_z_item[i]) ;

		dataObj.setFloat(jitter_x_name, jitter_x_item[i]) ;
		dataObj.setFloat(jitter_y_name, jitter_y_item[i]) ;
		dataObj.setFloat(jitter_z_name, jitter_z_item[i]) ;

		dataObj.setFloat(swing_x_name, swing_x_item[i]) ;
		dataObj.setFloat(swing_y_name, swing_y_item[i]) ;
		dataObj.setFloat(swing_z_name, swing_z_item[i]) ;

		dataObj.setFloat(quantity_name, quantity_item[i]) ;
		dataObj.setFloat(variety_name, variety_item[i]) ;

		dataObj.setFloat(life_name, life_item[i]) ;
		dataObj.setFloat(flow_name, flow_item[i]) ;
		dataObj.setFloat(quality_name, quality_item[i]) ;

		dataObj.setFloat(area_name, area_item[i] /width) ;
		dataObj.setFloat(angle_name, angle_item[i]) ;
		dataObj.setFloat(scope_name, scope_item[i] /width) ;
		dataObj.setFloat(scan_name, scan_item[i]) ;

		dataObj.setFloat(alignment_name, alignment_item[i]) ;
		dataObj.setFloat(repulsion_name, repulsion_item[i]) ;
		dataObj.setFloat(attraction_name, attraction_item[i]) ;
		dataObj.setFloat(charge_name, charge_item[i]) ;

		dataObj.setFloat(influence_name, influence_item[i]) ;
		dataObj.setFloat(calm_name, calm_item[i]) ;
		dataObj.setFloat(need_name, need_item[i]) ;
        
        // position & orientation
		dataObj.setFloat("pos x obj", pos_item_old[i].x /width) ;
		dataObj.setFloat("pos y obj", pos_item_old[i].y /width) ;
		dataObj.setFloat("pos z obj", pos_item_old[i].z /width) ;

		dataObj.setFloat("longitude obj", dir_item_old[i].x) ;
		dataObj.setFloat("latitude obj", dir_item_old[i].y) ;
		// save in the JSON Array
		save.setJSONObject(startPosJSONDataObj +i,dataObj) ;
	}
    //
	saveJSONArray(save, path);

}



