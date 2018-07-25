/**
Load
v 0.0.1
*/
boolean openLoad = true ;
void load_prescene() {
	// we must send the load path to Scene to also open the save setting in the scene with only one opening window input
	if((load_SCENE_Setting_GLOBAL || load_Scene_Setting_local) && openLoad) {
		openLoad = false ;
		selectInput("Load setting Scene", "load_setting_scene") ; // ("display info in the window" , "name of the method callingBack" )
	}
}


String path_to_load_scene_setting = ("") ;
// method callingBack
void load_setting_scene(File selection) {
  if (selection != null) {
  	path_to_load_scene_setting = selection.getAbsolutePath();
  	loadDataObject(path_to_load_scene_setting) ;
  } 
  load_SCENE_Setting_GLOBAL = false ;
  load_Scene_Setting_local = false ;
  openLoad = true ;
}

