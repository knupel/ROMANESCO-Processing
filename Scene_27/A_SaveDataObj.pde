


void saveDataObject(boolean authorization) {
	if (authorization) {
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
			dataCam.setFloat("scene x", finalSceneCamera.x) ;
			dataCam.setFloat("scene y", finalSceneCamera.y) ;
			dataCam.setFloat("scene z", finalSceneCamera.z) ;
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
			dataObj.setFloat("thickness", thicknessObj[i]) ;

			dataObj.setFloat("width", sizeXObj[i]) ;
			dataObj.setFloat("height", sizeYObj[i]) ;
			dataObj.setFloat("depth", sizeZObj[i]) ;
			dataObj.setFloat("canvas x", canvasXObj[i]) ;
			dataObj.setFloat("canvas y", canvasYObj[i]) ;
			dataObj.setFloat("canvas z", canvasZObj[i]) ;
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
			dataObj.setFloat("pos x obj", posObjX[i]) ;
			dataObj.setFloat("pos y obj", posObjY[i]) ;
			dataObj.setFloat("pos z obj", posObjZ[i]) ;

			dataObj.setFloat("longitude obj", dirObjX[i]) ;
			dataObj.setFloat("latitude obj", dirObjY[i]) ;
			// save in the JSON Array
			save.setJSONObject(startPosJSONDataObj +i,dataObj) ;
		}
        //
		saveJSONArray(save, "preferences/saveObjData.json");
	}
}

void loadDataObject(boolean authorization) {
	if(authorization) {
		JSONArray load = new JSONArray() ;
		load = loadJSONArray("preferences/saveObjData.json");
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
			finalSceneCamera.x = dataCam.getFloat("scene x") ;
			finalSceneCamera.y = dataCam.getFloat("scene y") ;
			finalSceneCamera.z = dataCam.getFloat("scene z") ;
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

			thicknessObj[ID] = dataObj.getFloat("thickness") ;

			sizeXObj[ID] = dataObj.getFloat("width") ;
			sizeYObj[ID] = dataObj.getFloat("height") ;
			sizeZObj[ID] = dataObj.getFloat("depth") ;
			canvasXObj[ID] = dataObj.getFloat("canvas x") ;
			canvasYObj[ID] = dataObj.getFloat("canvas y") ;
			canvasZObj[ID] = dataObj.getFloat("canvas z") ;
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

			posObjX[ID]	= dataObj.getFloat("pos x obj") ;
			posObjY[ID]	= dataObj.getFloat("pos y obj") ;
			posObjZ[ID]	= dataObj.getFloat("pos z obj") ;

			dirObjX[ID]	= dataObj.getFloat("longitude obj") ;
			dirObjY[ID]	= dataObj.getFloat("latitude obj") ;
		}
	}
}

