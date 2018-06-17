/**
Core Romanesco
*
COMMON SKETCH for CONTROLLER, PRESCENE & SCENE
*
2018-2018
v 0.0.10
*/
int NUM_COL_SLIDER = 3 ;
int NUM_SLIDER_ITEM_BY_COL = 16 ;
int NUM_SLIDER_ITEM = NUM_SLIDER_ITEM_BY_COL *NUM_COL_SLIDER;

int KEY_CTRL_OS = 157; // it's macOS CMD // for MAC 

int NUM_SLIDER_BACKGROUND = 9;
int NUM_SLIDER_FILTER = 12;
int NUM_SLIDER_LIGHT = 9;
int NUM_SLIDER_SOUND = 2;
int NUM_SLIDER_SOUND_SETTING = 9; // 9
int NUM_SLIDER_CAMERA = 7;

int NUM_SLIDER_GENERAL 	= NUM_SLIDER_BACKGROUND 
												+ NUM_SLIDER_FILTER 
												+ NUM_SLIDER_LIGHT 
												+ NUM_SLIDER_SOUND 
												+ NUM_SLIDER_SOUND_SETTING 
												+ NUM_SLIDER_CAMERA;

int NUM_GROUP_SLIDER = 2 ; // '0' for general / '1' for the item

int ITEM_GROUP = 1;

String preference_path, import_path, items_path, autosave_path;
void path_setting() {
  preference_path = sketchPath(1)+"/preferences/";
  import_path = sketchPath(1)+"/import/";
  items_path = sketchPath(1)+"/items/";
  autosave_path = sketchPath(1)+"/autosave.csv";
}

String version = "";
String prettyVersion = "";
String nameVersion = "";
void version() {
	String [] s = loadStrings(preference_path+"version.txt");
	String [] v = split(s[0],"/");
	prettyVersion = v[0];
	version = v[1];
	nameVersion = v[2];
}


String system() {
	return System.getProperty("os.name");
}

void set_system_specification() {
	String system = system();
	println("System:",system);
	if(system.equals("Mac OS X")) {
		KEY_CTRL_OS = 157;
	} else {
		KEY_CTRL_OS = CONTROL;
	}
}