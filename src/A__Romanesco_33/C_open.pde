/**
* OPEN ROMANESCO
* v 1.0.0
*/
int time_to_open_prescene = 180;
int time_to_open_controller = 360;
int count_to_open = 0;

boolean open_controller_is;
boolean open_prescene_is;
boolean open_scene_is;

void open_romanesco() {
	if(open_app_is()) {
		count_to_open = 0;
		open_controller_is = true;
		open_prescene_is = true;
		if(LIVE) {
			open_scene_is = true;
		}
		open_app_is(false);
	} else {
		count_to_open++;
		if(count_to_open > 10000) count_to_open = 0;
	}


	if(open_scene_is) {
		open_scene();
		open_scene_is=false;
	}

	if(open_prescene_is && count_to_open > time_to_open_prescene) {
		open_prescene();
		open_prescene_is=false;
	}

	if(open_controller_is && count_to_open > time_to_open_controller) {
		open_controller();
		open_controller_is=false;
	}
}



boolean open_app_is;
void open_app_is(boolean is) {
	open_app_is = is;
}

boolean open_app_is() {
	return open_app_is;
}

String warning_launch = ("WARNING: \nin case Romanesco is not compiled,\nthe launcher set the size of windows only it cannot launch the app,\nafter it's necessary to run presecne.pde separately,\nthen run scene.pde if you want use it,\nthen run controller.pde");
void open_prescene() {
	println("Prescene.app is launch, if it's possible");
	println(warning_launch);
	if(LIVE) {
		launch(path_prescene_live);
	} else {
		launch(path_prescene);
	}
}



void open_scene() {
	println("Scene.app is launch, if it's possible");
	println(warning_launch);
	if(LIVE) {
		if(FULLSCREEN) {
			launch(path_scene_live_fullscreen);
		} else {
			launch(path_scene_live);
		}
	}
}


void open_controller() {
	println("Controller.app is launch, if it's possible");
	println(warning_launch);
	if(LIVE) { 
		launch(path_controller_live);
	} else {
		launch(path_controller);
	}
}