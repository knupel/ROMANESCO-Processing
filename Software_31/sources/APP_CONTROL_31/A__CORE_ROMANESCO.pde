/**
Core Romanesco
*
COMMON SKETCH for CONTROLLER, PRESCENE & SCENE
*
2018-2018
v 0.0.7
*/
int NUM_COL_SLIDER = 3 ;
int NUM_SLIDER_ITEM_BY_COL = 16 ;
int NUM_SLIDER_ITEM = NUM_SLIDER_ITEM_BY_COL *NUM_COL_SLIDER;

int NUM_SLIDER_BACKGROUND = 8;
int NUM_SLIDER_FILTER = 12;
int NUM_SLIDER_LIGHT = 9;
int NUM_SLIDER_SOUND = 2;
int NUM_SLIDER_CAMERA = 7;
int NUM_SLIDER_GENERAL = NUM_SLIDER_BACKGROUND +NUM_SLIDER_FILTER +NUM_SLIDER_LIGHT +NUM_SLIDER_SOUND +NUM_SLIDER_CAMERA;

int NUM_GROUP_SLIDER = 2 ; // '0' for general / '1' for the item

int ITEM_GROUP = 1;

String preference_path, import_path, items_path;
void path_setting(String path) {
  preference_path = path+"/preferences/";
  import_path = path+"/import/";
  items_path = path+"/items/";
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