/**
Core Romanesco
COMMON SKETCH for CONTROLLER, PRESCENE & SCENE
2018-2018
v 0.1.8
*/
int NUM_COL_SLIDER = 4;
int NUM_SLIDER_ITEM_BY_COL = 16;
int NUM_SLIDER_ITEM = NUM_SLIDER_ITEM_BY_COL *NUM_COL_SLIDER;
int NUM_MOLETTE_ITEM = NUM_SLIDER_ITEM;

int KEY_CTRL_OS = 157; // it's macOS CMD // for MAC 

int NUM_BUTTON_CURTAIN = 1;
int NUM_BUTTON_RESET = 2;
int NUM_BUTTON_BACKGROUND = 1;
int NUM_BUTTON_FX = 2;
int NUM_BUTTON_LIGHT = 6;
int NUM_BUTTON_TRANSIENT = 4;
int NUM_BUTTON_GENERAL = NUM_BUTTON_CURTAIN 
                        + NUM_BUTTON_RESET
                        + NUM_BUTTON_BACKGROUND 
                        + NUM_BUTTON_FX 
                        + NUM_BUTTON_LIGHT 
                        + NUM_BUTTON_TRANSIENT;

int NUM_SLIDER_BACKGROUND = 14;
int NUM_SLIDER_FX = 12;
int NUM_SLIDER_LIGHT = 9;
int NUM_SLIDER_SOUND = 2;
int NUM_SLIDER_SOUND_SETTING = 5; // 5
int NUM_SLIDER_CAMERA = 10;

int NUM_SLIDER_GENERAL  = NUM_SLIDER_BACKGROUND 
                        + NUM_SLIDER_FX 
                        + NUM_SLIDER_LIGHT 
                        + NUM_SLIDER_SOUND 
                        + NUM_SLIDER_SOUND_SETTING 
                        + NUM_SLIDER_CAMERA;

// for the case where the slider is a multislider, important for the sending and receiving OSC data
int NUM_MOLETTE_BACKGROUND = NUM_SLIDER_BACKGROUND;
int NUM_MOLETTE_FX = NUM_SLIDER_FX;
int NUM_MOLETTE_LIGHT = NUM_SLIDER_LIGHT;
int NUM_MOLETTE_SOUND = NUM_SLIDER_SOUND;
int NUM_MOLETTE_SOUND_SETTING = 11; // here the value is different because it's slider with few molette
int NUM_MOLETTE_CAMERA = NUM_SLIDER_CAMERA;

int NUM_MOLETTE_GENERAL = NUM_MOLETTE_BACKGROUND 
                        + NUM_MOLETTE_FX 
                        + NUM_MOLETTE_LIGHT 
                        + NUM_MOLETTE_SOUND 
                        + NUM_MOLETTE_SOUND_SETTING 
                        + NUM_MOLETTE_CAMERA;

int NUM_GROUP_SLIDER = 2; // '0' for general / '1' for the item

int ITEM_GROUP = 1;

String preference_path;
String import_path;
String items_path;
String autosave_path;
void path_setting() {
  int folder_position = 1;
  if(!DEV_MODE) folder_position = 0;
  preference_path = sketchPath(folder_position)+"/preferences/";
  import_path = sketchPath(folder_position)+"/import/";
  items_path = sketchPath(folder_position)+"/items/";
  autosave_path = sketchPath(folder_position)+"/autosave.csv";
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














/**
MEDIA
2014-2018
v 0.1.4
*/
ArrayList<File> text_files = new ArrayList<File>();
ArrayList<File> bitmap_files = new ArrayList<File>();
ArrayList<File> svg_files = new ArrayList<File>();
ArrayList<File> movie_files = new ArrayList<File>();
ArrayList<File> media_files = new ArrayList<File>();




String ref_path;
void add_media(String path) {
  if(path != null && !path.equals(ref_path)) {
    ref_path = path;
    // movie case
    if(ext(path,"mov") || ext(path,"MOV") || ext(path,"avi") || ext(path,"AVI") || ext(path,"mp4") || ext(path,"MP4") || ext(path,"mkv") || ext(path,"MKV")) {
      add_input(movie_files,path);
    } else if(ext(path,"jpeg") || ext(path,"JPEG") || ext(path,"jpg") || ext(path,"jpeg") || ext(path,"tif") || ext(path,"TIF") || ext(path,"tiff") || ext(path,"TIFF") || ext(path,"tga") || ext(path,"TGA") || ext(path,"gif") || ext(path,"GIF")) {
      add_input(bitmap_files,path);
    } else if(ext(path,"txt") || ext(path,"TXT")) {
      add_input(text_files,path);
    } else if(ext(path,"svg") || ext(path,"SVG")) {
      add_input(svg_files,path);
    }
  }
}


boolean ext(String path, String extension) {
  return extension(path).equals(extension);
}


/**
add movie path
*/
void add_input(ArrayList<File> media_file_by_type, String path) {
  File file = new File(path);
  if(!check_already_existing_path(path)) {
    media_file_by_type.add(file);
    media_files.add(file);
  }
}

boolean check_already_existing_path(String path) {
  boolean existing = false;
  for(File f : media_files) {
    String existing_path = f.getAbsolutePath();
    if(existing_path.equals(path)) {
      existing = true;
      break;
    }
  }
  return existing;
}




