// LOAD
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
	if(( save_New_SCENE_Setting_from_controller || save_New_SCENE_Setting_order_from_presecene) && openSave) {
		// println("create a new save") ;
		openSave = false ;
		File tempFileName = new File ("your_scene_setting.json");
		selectOutput("Save Scene", "saveSetting", tempFileName);
		
	} else if((save_Current_SCENE_Setting_from_controller || save_Current_SCENE_Setting_order_from_presecene) && openSave) {
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
	dataWorld.setFloat("hue ambient", colourAmbient.r) ;
	dataWorld.setFloat("saturation ambient", colourAmbient.g) ;
	dataWorld.setFloat("brightness ambient", colourAmbient.b) ;
	dataWorld.setFloat("alpha ambient", colourAmbient.a) ;
	// pos ambient light
	/**
	Not use at this time
	dataWorld.setFloat("pos x ambient", value) ;
	dataWorld.setFloat("pos y ambient", value) ;
	dataWorld.setFloat("pos z ambient", value) ;
	*/
	// color light one
	dataWorld.setFloat("hue light 1", colorLightDir_1.r) ;
	dataWorld.setFloat("saturation light 1", colorLightDir_1.g) ;
	dataWorld.setFloat("brightness light 1", colorLightDir_1.b) ;
	dataWorld.setFloat("alpha light 1", colorLightDir_1.a) ;
	// pos light one
	dataWorld.setFloat("pos x light 1", dirLightDir_1.x) ;
	dataWorld.setFloat("pos y light 1", dirLightDir_1.y) ;
	dataWorld.setFloat("pos z light 1", dirLightDir_1.z) ;
	// color light two
	dataWorld.setFloat("hue light 2", colorLightDir_2.r) ;
	dataWorld.setFloat("saturation light 2", colorLightDir_2.g) ;
	dataWorld.setFloat("brightness light 2", colorLightDir_2.b) ;
	dataWorld.setFloat("alpha light 2", colorLightDir_2.a) ;
	// pos light two
	dataWorld.setFloat("pos x light 2", dirLightDir_2.x) ;
	dataWorld.setFloat("pos y light 2", dirLightDir_2.y) ;
	dataWorld.setFloat("pos z light 2", dirLightDir_2.z) ;
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
		dataObj.setInt("which picture", whichImage[i]) ; // problem with var whichPicture[]
		dataObj.setInt("which text", whichText[i]) ; // problem with var whichText[]
        // display mode
		dataObj.setInt("Mode obj", mode[i]) ;
        // slider 
		dataObj.setFloat("hue fill", hue(fillObj[i])) ;
		dataObj.setFloat("saturation fill", saturation(fillObj[i])) ;
		dataObj.setFloat("brightness fill", brightness(fillObj[i])) ;
		dataObj.setFloat("alpha fill", alpha(fillObj[i])) ;
		dataObj.setFloat("hue stroke", hue(strokeObj[i])) ;
		dataObj.setFloat("saturation stroke", saturation(strokeObj[i])) ;
		dataObj.setFloat("brightness stroke", brightness(strokeObj[i])) ;
		dataObj.setFloat("alpha stroke", alpha(strokeObj[i])) ;
		dataObj.setFloat("thickness", thicknessObj[i] /height) ;

		dataObj.setFloat("width", sizeXObj[i] /width) ;
		dataObj.setFloat("height", sizeYObj[i] /width) ;
		dataObj.setFloat("depth", sizeZObj[i] /width) ;
		dataObj.setFloat("canvas x", canvasXObj[i] /width) ;
		dataObj.setFloat("canvas y", canvasYObj[i] /width) ;
		dataObj.setFloat("canvas z", canvasZObj[i] /width) ;
		dataObj.setFloat("family", familyObj[i]) ;
		dataObj.setFloat("quantity", quantityObj[i]) ;
		dataObj.setFloat("life", lifeObj[i]) ;

		dataObj.setFloat("speed", speedObj[i]) ;
		dataObj.setFloat("direction", directionObj[i]) ;
		dataObj.setFloat("angle", angleObj[i]) ;
		dataObj.setFloat("amplitude", amplitudeObj[i]) ;
		dataObj.setFloat("attraction", attractionObj[i]) ;
		dataObj.setFloat("repulsion", repulsionObj[i]) ;
		dataObj.setFloat("aligmnent", alignmentObj[i]) ;
		dataObj.setFloat("influence", influenceObj[i]) ;
		dataObj.setFloat("analyze", analyzeObj[i]) ;
        
        // position & orientation
		dataObj.setFloat("pos x obj", posObjX[i] /width) ;
		dataObj.setFloat("pos y obj", posObjY[i] /width) ;
		dataObj.setFloat("pos z obj", posObjZ[i] /width) ;

		dataObj.setFloat("longitude obj", dirObjX[i]) ;
		dataObj.setFloat("latitude obj", dirObjY[i]) ;
		// save in the JSON Array
		save.setJSONObject(startPosJSONDataObj +i,dataObj) ;
	}
    //
	saveJSONArray(save, path);

}



