// Z_LOAD
void loadDataObject(String path) {
	JSONArray load = new JSONArray() ;
	load = loadJSONArray(path);
	// init counter
	int startPosJSONDataWorld = 0 ;
	int startPosJSONDataCam = 1 ;
	int startPosJSONDataObj = 0;
    
    // PART ONE
	JSONObject dataWorld = load.getJSONObject(startPosJSONDataWorld);
	onOffBackground = dataWorld.getBoolean("on/off") ;


	colorBackground.r = dataWorld.getFloat("hue background") ;
	colorBackground.g = dataWorld.getFloat("saturation background");
	colorBackground.b = dataWorld.getFloat("brightness background") ;
	colorBackground.a = dataWorld.getFloat("refresh background") ;
	colorBackgroundRef = colorBackground.copy() ;

	// color ambient light
	color_light[0].r = dataWorld.getFloat("hue ambient") ;
	color_light[0].g = dataWorld.getFloat("saturation ambient") ;
	color_light[0].b = dataWorld.getFloat("brightness ambient") ;
	color_light[0].a = dataWorld.getFloat("alpha ambient") ;
	// pos ambient light
	/**
	Not use at this time
	dataWorld.setFloat("pos x ambient", value) ;
	dataWorld.setFloat("pos y ambient", value) ;
	dataWorld.setFloat("pos z ambient", value) ;
	*/
	// color light one
	color_light[1].r = dataWorld.getFloat("hue light 1") ;
	color_light[1].g = dataWorld.getFloat("saturation light 1") ;
	color_light[1].b = dataWorld.getFloat("brightness light 1") ;
	color_light[1].a = dataWorld.getFloat("alpha light 1") ;
	// pos light one
	dir_light[1].x = dataWorld.getFloat("pos x light 1") ;
	dir_light[1].y = dataWorld.getFloat("pos y light 1") ;
	dir_light[1].z = dataWorld.getFloat("pos z light 1") ;
	// color light two
	color_light[2].r = dataWorld.getFloat("hue light 2") ;
	color_light[2].g = dataWorld.getFloat("saturation light 2") ;
	color_light[2].b = dataWorld.getFloat("brightness light 2") ;
	color_light[2].a = dataWorld.getFloat("alpha light 2") ;
	// dir light two
	dir_light[2].x = dataWorld.getFloat("pos x light 2") ;
	dir_light[2].y = dataWorld.getFloat("pos y light 2") ;
	dir_light[2].z = dataWorld.getFloat("pos z light 2") ;
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





	// PART TWO
	int numCamera = 1 ;
	for (int i = startPosJSONDataCam ; i < startPosJSONDataCam + numCamera ; i++ ) {
		JSONObject dataCam = load.getJSONObject(i);
		// lenz
		focal = dataCam.getFloat("focal") ;
		deformation = dataCam.getFloat("deformation") ;
        // camera orientation
		dirCamX = dataCam.getFloat("eye x") ;
		dirCamY = dataCam.getFloat("eye y") ;
		dirCamZ = dataCam.getFloat("eye z") ;
		centerCamX = dataCam.getFloat("pos x") ;
		centerCamY = dataCam.getFloat("pos y") ;
		centerCamY = dataCam.getFloat("pos z") ;
		upX = dataCam.getFloat("upX");
		/**
		// not use in this time, maybe for the future
		upY = dataCam.getFloat("upY"); ;
		upZ = dataCam.getFloat("upZ"); ;
		*/
        // curent position
		finalSceneCamera.x = dataCam.getFloat("scene x") *width ;
		finalSceneCamera.y = dataCam.getFloat("scene y") *width ;
		finalSceneCamera.z = dataCam.getFloat("scene z") *width ;
		finalEyeCamera.x = dataCam.getFloat("longitude") ;
		finalEyeCamera.y = dataCam.getFloat("latitude") ;
	}
    

    // PART THREE
	for (int i = 2 ; i < load.size() ;i++) {
		JSONObject dataObj = load.getJSONObject(i) ;
		int ID = dataObj.getInt("ID obj") ;
		/**
		int fontRefID = dataObj.getInt("which font") ;
		whichFont[ID] = 
		*/
		which_bitmap[ID] = dataObj.getInt("which picture") ;
		which_text[ID] = dataObj.getInt("which text") ;
        // display mode
		mode[ID] = dataObj.getInt("Mode obj") ;
		
        // slider fill
        float h_fill = dataObj.getFloat(fill_hue_name) ;
        float s_fill = dataObj.getFloat(fill_sat_name) ;
        float b_fill = dataObj.getFloat(fill_bright_name) ;
        float a_fill = dataObj.getFloat(fill_alpha_name) ;
		// slider stroke
		float h_stroke = dataObj.getFloat(stroke_hue_name) ;
        float s_stroke = dataObj.getFloat(stroke_sat_name) ;
        float b_stroke = dataObj.getFloat(stroke_bright_name) ;
        float a_stroke = dataObj.getFloat(stroke_alpha_name) ;

        if(fullRendering) {
        	fill_item[ID] = color(h_fill, s_fill, b_fill, a_fill) ;
			stroke_item[ID] = color(h_stroke, s_stroke, b_stroke, a_stroke) ;
			thickness_item[ID] = dataObj.getFloat(thickness_name) *height ;
		} else {
			// preview display
			fill_item[ID] = COLOR_FILL_OBJ_PREVIEW ;
			stroke_item[ID] =  COLOR_STROKE_OBJ_PREVIEW ;
			thickness_item[ID] = THICKNESS_OBJ_PREVIEW ;
		}

 
		size_x_item[ID] = dataObj.getFloat(size_x_name) *width ;
		size_y_item[ID] = dataObj.getFloat(size_y_name) *width ;
		size_z_item[ID] = dataObj.getFloat(size_z_name) *width ;

		font_size_item[ID] = dataObj.getFloat(font_size_name) *width ;

		canvas_x_item[ID] = dataObj.getFloat(canvas_x_name) *width ;
		canvas_y_item[ID] = dataObj.getFloat(canvas_y_name) *width ;
		canvas_z_item[ID] = dataObj.getFloat(canvas_z_name) *width ;

		reactivity_item[ID] = dataObj.getFloat(reactivity_name) ;

		speed_x_item[ID] = dataObj.getFloat(speed_x_name) ;
		speed_y_item[ID] = dataObj.getFloat(speed_y_name) ;
		speed_z_item[ID] = dataObj.getFloat(speed_z_name) ;

		spurt_x_item[ID] = dataObj.getFloat(spurt_x_name) ;
		spurt_y_item[ID] = dataObj.getFloat(spurt_y_name) ;
		spurt_z_item[ID] = dataObj.getFloat(spurt_z_name) ;

		dir_x_item[ID] = dataObj.getFloat(dir_x_name) ;
		dir_y_item[ID] = dataObj.getFloat(dir_y_name) ;
		dir_z_item[ID] = dataObj.getFloat(dir_z_name) ;

		jitter_x_item[ID] = dataObj.getFloat(jitter_x_name) ;
		jitter_y_item[ID] = dataObj.getFloat(jitter_y_name) ;
		jitter_z_item[ID] = dataObj.getFloat(jitter_z_name) ;

		swing_x_item[ID] = dataObj.getFloat(swing_x_name) ;
		swing_y_item[ID] = dataObj.getFloat(swing_y_name) ;
		swing_z_item[ID] = dataObj.getFloat(swing_z_name) ;

		quantity_item[ID] = dataObj.getFloat(quantity_name) ;
		variety_item[ID] = dataObj.getFloat(variety_name) ;

		life_item[ID] = dataObj.getFloat(life_name) ;
		fertility_item[ID] = dataObj.getFloat(fertility_name) ;
		quality_item[ID] = dataObj.getFloat(quality_name) ;

		area_item[ID] = dataObj.getFloat(area_name) ;
		angle_item[ID] = dataObj.getFloat(angle_name) ;
		scope_item[ID] = dataObj.getFloat(scope_name) ;
		scan_item[ID] = dataObj.getFloat(scan_name) ;

		alignment_item[ID] = dataObj.getFloat(alignment_name) ;
		repulsion_item[ID] = dataObj.getFloat(repulsion_name) ;
		attraction_item[ID] = dataObj.getFloat(attraction_name) ;
		charge_item[ID] = dataObj.getFloat(charge_name) ;

		influence_item[ID] = dataObj.getFloat(influence_name) ;
		calm_item[ID] = dataObj.getFloat(calm_name) ;
		need_item[ID] = dataObj.getFloat(need_name) ;

      // pos and other data item

		posObjX[ID]	= dataObj.getFloat("pos x obj") *width ;
		posObjY[ID]	= dataObj.getFloat("pos y obj") *width ;
		posObjZ[ID]	= dataObj.getFloat("pos z obj") *width ;

		dirObjX[ID]	= dataObj.getFloat("longitude obj") ;
		dirObjY[ID]	= dataObj.getFloat("latitude obj") ;
	}

}