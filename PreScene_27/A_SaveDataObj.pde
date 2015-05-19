/*
JSONArray saveRomanescoDataScene = new JSONArray() ;
int startPosJSONDataWorld = 0 ;
int startPosJSONDataCam = 1 ;
int startPosJSONDataObj ;


void saveDataObject(boolean save) {
	// saveRomanescoDataScene = new JSONArray();
	if (save) {
		// init
		
		// world
		JSONObject dataWorld = new JSONObject();
	

		// background
		dataWorld.setInt("which shader",whichShader) ;
		// dataWorld.setInt("which background", value) ;
		dataWorld.setBoolean("on/off", onOffBackground) ;

		dataWorld.setFloat("h background", colorBackground.r) ;
		dataWorld.setFloat("s background", colorBackground.g) ;
		dataWorld.setFloat("b background", colorBackground.b) ;
		dataWorld.setFloat("refresh background", colorBackground.a) ;
		// color ambient light
		dataWorld.setFloat("h ambient", value) ;
		dataWorld.setFloat("s ambient", value) ;
		dataWorld.setFloat("b ambient", value) ;
		// pos ambient light
		dataWorld.setFloat("pos x ambient", value) ;
		dataWorld.setFloat("pos y ambient", value) ;
		dataWorld.setFloat("pos z ambient", value) ;
		// color light one
		dataWorld.setFloat("h light 1", value) ;
		dataWorld.setFloat("s light 1", value) ;
		dataWorld.setFloat("b light 1", value) ;
		// pos light one
		dataWorld.setFloat("pos x light 1", value) ;
		dataWorld.setFloat("pos y light 1", value) ;
		dataWorld.setFloat("pos z light 1", value) ;
		// color light two
		dataWorld.setFloat("h light 2", value) ;
		dataWorld.setFloat("s light 2", value) ;
		dataWorld.setFloat("b light 2", value) ;
		// pos light two
		dataWorld.setFloat("pos x light 2", value) ;
		dataWorld.setFloat("pos y light 2", value) ;
		dataWorld.setFloat("pos z light 2", value) ;
		// sound
		dataWorld.setFloat("sound left", value) ;
		dataWorld.setFloat("sound right", value) ;
		dataWorld.setBoolean("beat", value) ;
		dataWorld.setBoolean("kick", value) ;
		dataWorld.setBoolean("snare", value) ;
		dataWorld.setBoolean("hat", value) ;
		// add data world in the JSON array
		saveRomanescoDataScene.setJSONObject(startPosJSONDataWorld,dataWorld) ;
		
		// camera
		int numCamera = 1 ;
		for (int i = 0 ; i <numCamera ; i++) {
			JSONObject dataCam = new JSONObject();
			dataCam.setFloat("focal", value[i]) ;
			dataCam.setFloat("deformation", value[i]) ;
			dataCam.setFloat("eye x", value[i]) ;
			dataCam.setFloat("eye y", value[i]) ;
			dataCam.setFloat("eye z", value[i]) ;
			dataCam.setFloat("pos x", value[i]) ;
			dataCam.setFloat("pos y", value[i]) ;
			dataCam.setFloat("pos z", value[i]) ;
			dataCam.setFloat("???", value[i]) ;

			dataCam.setFloat("scene x", value[i]) ;
			dataCam.setFloat("scene y", value[i]) ;
			dataCam.setFloat("scene z", value[i]) ;
			dataCam.setFloat("longitude", value[i]) ;
			dataCam.setFloat("latitude", value[i]) ;
			// save in the JSON Array
			saveRomanescoDataScene.setJSONObject(startPosJSONDataCam +i,dataCam) ;
		}
		// give the static start point in the JSON Array
		startPosJSONDataObj = startPosJSONDataCam + numCamera ;
		

		// obj
		int numObj = 2 ;
		for (int i = 0 ; i <numObj ; i++) {
			JSONObject dataObj = new JSONObject();
			// info obj
			dataObj.setInt("ID obj", value[i]) ;
			dataObj.setString("Name obj", value[i]) ;
			dataObj.setString("Author obj", value[i]) ;
			dataObj.setString("Version obj", value[i]) ;
			// external data obj
			dataObj.setInt("which font", font[i]) ;
			dataObj.setInt("which picture", whichPicture[i]) ;
			dataObj.setInt("which text", whichText[i]) ;
            // display mode
			dataObj.setInt("Mode obj", value[i]) ;
            // slider 
			dataObj.setFloat("hue fill", value[i]) ;
			dataObj.setFloat("saturation fill", value[i]) ;
			dataObj.setFloat("brightness fill", value[i]) ;
			dataObj.setFloat("alpha fill", value[i]) ;
			dataObj.setFloat("hue stroke", value[i]) ;
			dataObj.setFloat("saturation stroke", value[i]) ;
			dataObj.setFloat("brightness stroke", value[i]) ;
			dataObj.setFloat("alpha stroke", value[i]) ;
			dataObj.setFloat("thickness", value[i]) ;

			dataObj.setFloat("width", value[i]) ;
			dataObj.setFloat("height", value[i]) ;
			dataObj.setFloat("depth", value[i]) ;
			dataObj.setFloat("canvas x", value[i]) ;
			dataObj.setFloat("canvas y", value[i]) ;
			dataObj.setFloat("canvas z", value[i]) ;
			dataObj.setFloat("family", value[i]) ;
			dataObj.setFloat("quantity", value[i]) ;
			dataObj.setFloat("life", value[i]) ;

			dataObj.setFloat("speed", value[i]) ;
			dataObj.setFloat("direction", value[i]) ;
			dataObj.setFloat("angle", value[i]) ;
			dataObj.setFloat("amplitude", value[i]) ;
			dataObj.setFloat("attraction", value[i]) ;
			dataObj.setFloat("repulsion", value[i]) ;
			dataObj.setFloat("aligmnent", value[i]) ;
			dataObj.setFloat("influence", value[i]) ;
			dataObj.setFloat("analyze", value[i]) ;
            
            // position & orientation
			dataObj.setFloat("pos x obj", value[i]) ;
			dataObj.setFloat("pos y obj", value[i]) ;
			dataObj.setFloat("pos z obj", value[i]) ;

			dataObj.setFloat("longitude obj", value[i]) ;
			dataObj.setFloat("latitude obj", value[i]) ;
			// save in the JSON Array
			saveRomanescoDataScene.setJSONObject(startPosJSONDataObj +i,dataObj) ;
		}

		saveJSONArray(saveRomanescoDataScene, "data/new.json");
	}
}

void loadDataObject(boolean save) {
	if(save) {

	}
}
*/
