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
	colourAmbient.r = dataWorld.getFloat("hue ambient") ;
	colourAmbient.g = dataWorld.getFloat("saturation ambient") ;
	colourAmbient.b = dataWorld.getFloat("brightness ambient") ;
	colourAmbient.a = dataWorld.getFloat("alpha ambient") ;
	// pos ambient light
	/**
	Not use at this time
	dataWorld.setFloat("pos x ambient", value) ;
	dataWorld.setFloat("pos y ambient", value) ;
	dataWorld.setFloat("pos z ambient", value) ;
	*/
	// color light one
	colorLightDir_1.r = dataWorld.getFloat("hue light 1") ;
	colorLightDir_1.g = dataWorld.getFloat("saturation light 1") ;
	colorLightDir_1.b = dataWorld.getFloat("brightness light 1") ;
	colorLightDir_1.a = dataWorld.getFloat("alpha light 1") ;
	// pos light one
	dirLightDir_1.x = dataWorld.getFloat("pos x light 1") ;
	dirLightDir_1.y = dataWorld.getFloat("pos y light 1") ;
	dirLightDir_1.z = dataWorld.getFloat("pos z light 1") ;
	// color light two
	colorLightDir_2.r = dataWorld.getFloat("hue light 2") ;
	colorLightDir_2.g = dataWorld.getFloat("saturation light 2") ;
	colorLightDir_2.b = dataWorld.getFloat("brightness light 2") ;
	colorLightDir_2.a = dataWorld.getFloat("alpha light 2") ;
	// pos light two
	dirLightDir_2.x = dataWorld.getFloat("pos x light 2") ;
	dirLightDir_2.y = dataWorld.getFloat("pos y light 2") ;
	dirLightDir_2.z = dataWorld.getFloat("pos z light 2") ;
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
		whichImage[ID] = dataObj.getInt("which picture") ;
		whichText[ID] = dataObj.getInt("which text") ;
        // display mode
		mode[ID] = dataObj.getInt("Mode obj") ;
		
        // slider 
        float h_fill = dataObj.getFloat("hue fill") ;
        float s_fill = dataObj.getFloat("saturation fill") ;
        float b_fill = dataObj.getFloat("brightness fill") ;
        float a_fill = dataObj.getFloat("alpha fill") ;
		fillObj[ID] = color(h_fill, s_fill, b_fill, a_fill) ;
		float h_stroke = dataObj.getFloat("hue stroke") ;
        float s_stroke = dataObj.getFloat("saturation stroke") ;
        float b_stroke = dataObj.getFloat("brightness stroke") ;
        float a_stroke = dataObj.getFloat("alpha stroke") ;
		strokeObj[ID] = color(h_stroke, s_stroke, b_stroke, a_stroke) ;

		thicknessObj[ID] = dataObj.getFloat("thickness") *height ;

		sizeXObj[ID] = dataObj.getFloat("width") *width ;
		sizeYObj[ID] = dataObj.getFloat("height") *width ;
		sizeZObj[ID] = dataObj.getFloat("depth") *width ;
		canvasXObj[ID] = dataObj.getFloat("canvas x") *width ;
		canvasYObj[ID] = dataObj.getFloat("canvas y") *width ;
		canvasZObj[ID] = dataObj.getFloat("canvas z") *width ;
		familyObj[ID] = dataObj.getFloat("family") ;
		quantityObj[ID] = dataObj.getFloat("quantity") ;
		lifeObj[ID] = dataObj.getFloat("life") ;

		speedObj[ID] = dataObj.getFloat("speed") ;
		directionObj[ID] = dataObj.getFloat("direction") ;
		angleObj[ID] = dataObj.getFloat("angle") ;
		amplitudeObj[ID] = dataObj.getFloat("amplitude") ;
		attractionObj[ID] = dataObj.getFloat("attraction") ;
		repulsionObj[ID] = dataObj.getFloat("repulsion") ;
		alignmentObj[ID] = dataObj.getFloat("aligmnent") ;
		influenceObj[ID] = dataObj.getFloat("influence") ;
		analyzeObj[ID] = dataObj.getFloat("analyze") ;

		posObjX[ID]	= dataObj.getFloat("pos x obj") *width ;
		posObjY[ID]	= dataObj.getFloat("pos y obj") *width ;
		posObjZ[ID]	= dataObj.getFloat("pos z obj") *width ;

		dirObjX[ID]	= dataObj.getFloat("longitude obj") ;
		dirObjY[ID]	= dataObj.getFloat("latitude obj") ;
	}

}