/**
Core Romanesco
2018-2018
v 0.0.3
*/
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