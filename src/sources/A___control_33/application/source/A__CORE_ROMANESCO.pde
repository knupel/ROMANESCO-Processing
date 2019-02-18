/**
* Core Romanesco
* common code for CONTROLLER and RENDERER
* 2018-2019
* v 0.3.11
*/
int NUM_COL_SLIDER = 4;
int NUM_SLIDER_ITEM_BY_COL = 16;
int NUM_SLIDER_ITEM = NUM_SLIDER_ITEM_BY_COL *NUM_COL_SLIDER;
int NUM_MOLETTE_ITEM = NUM_SLIDER_ITEM;

int KEY_CTRL_OS = 157; // it's macOS CMD // for MAC 


int NUM_DROPDOWN_GENERAL = 7;
// the MIDI BUTTON is not count because is not use in the OSC bridge
int NUM_BUTTON_MISC = 3; // with out MIDI button.
int NUM_BUTTON_RESET = 3;
int NUM_TOP_BUTTON = NUM_BUTTON_MISC + NUM_BUTTON_RESET;

int NUM_BUTTON_BACKGROUND = 1;
int NUM_BUTTON_FX = 3;
int NUM_BUTTON_LIGHT = 6;
int NUM_BUTTON_TRANSIENT = 4;
int NUM_MID_BUTTON = NUM_BUTTON_BACKGROUND 
                      + NUM_BUTTON_FX 
                      + NUM_BUTTON_LIGHT 
                      + NUM_BUTTON_TRANSIENT;

int NUM_BUTTON_GENERAL = NUM_TOP_BUTTON + NUM_MID_BUTTON;

int NUM_SLIDER_BACKGROUND = 14;
int NUM_SLIDER_FX = 14;
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
String font_path;
String items_path;
String autosave_path;
void path_setting() {
  int folder_position = 1;
  if(!DEV_MODE) folder_position = 0;
  preference_path = sketchPath(folder_position)+"/preferences/";
  import_path = sketchPath(folder_position)+"/import/";
  font_path = "/Users/"+System.getProperty("user.name")+"/library/Fonts";
  File file = new File(font_path);
  if(!file.isDirectory()) {
    font_path = import_path+"font/typo_OTF_TTF";
  }
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
MISC
*/
File [] list_files(String path) {
  File file = new File(path);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}











/**
FONT LOADING
0.0.4
*/
ROFont [] font;
void create_font() {
  int size_font = 200;
  String[] path_list = alphabetical_font_path(font_path);

  font = new ROFont[path_list.length]; 
  for(int i = 0 ; i < path_list.length ; i++) {
    if(extension_font(path_list[i])) {
      font[i] = new ROFont(path_list[i],size_font);
    } 
  }
}

String [] alphabetical_font_path(String folder_path) {
  File [] file = list_files(folder_path);
  // check if the file is a font or not
  int num = 0 ;
  for(int i = 0 ; i < file.length ; i++) {
    if(extension_font(file[i].getAbsolutePath())) {
      num++;
    }
  }

  String[] path_list = new String[num];
  int target= 0;
  for(int i = 0 ; i < file.length ; i++) {
    if(extension_font(file[i].getAbsolutePath())) {
      path_list[target] = file[i].getAbsolutePath();
      target++;
    } 
  }
  Arrays.sort(path_list);
  return path_list;
}




boolean extension_font(String path) {
  return extension_is(path,"ttf","TTF","otf","OTF");
}




/**
ROFont
v 0.2.0
2018-2018
*/
class ROFont {
  PFont font;
  String path;
  String type;
  int size;

  ROFont(String path, int size) {
    //if(extension_is(path,"ttf","TTF","otf","OTF")) {
    if(extension_font(path)) {
      this.font = createFont(path,size);
      this.path = path;
      this.size = size;
      this.type = extension(path);
      //println(path,type);
    } else {
      printErr("class ROFont: path don't match with any font type >",path);
    }
  }

  PFont get_font() {
    return font;
  }

  String get_path() {
    return path;
  }

  String get_type() {
    return type;
  }

  int get_size() {
    return size;
  }

  String get_name() {
    return font.getName();
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


















/**
Manage window position
v 0.0.2
*/
ivec2 ref_window_location;
void update_window_location() {
  if(ref_window_location == null) {
    ref_window_location = get_sketch_location().copy();
    write_window_location();
    // println(ref_window_location,frameCount);
  } else {
    if(!ref_window_location.equals(get_sketch_location())) {
      ref_window_location.set(get_sketch_location());
      write_window_location();
    }
  }
}


void write_window_location() {
  String loc [] = new String[2];
  loc[0] = Integer.toString(ref_window_location.x);
  loc[1] = Integer.toString(ref_window_location.y);
  saveStrings("data/location.loc",loc);
}



void load_window_location() {
  load_window_location(ivec2(width,height));
}

void load_window_location(ivec2 window) {
  String[] location = loadStrings("location.loc");
  ivec2 loc = ivec2();
  loc.x = Integer.parseInt(location[0]);
  loc.y = Integer.parseInt(location[1]);
  // check if the save position can be used and don't display the sketch in a innaccessible place
  // First check the num of screen device
  println("location loaded from save file",loc);
  if(get_screen_num() < 2) {
    if(loc.x < 0 || loc.x > get_screen_size().x -window.x || loc.y < 0 || loc.y > get_screen_size().y -window.y) {
      center_sketch(loc);
    }
  } else if (get_screen_num() >= 2) {
    int begin_x = 0;
    int begin_y = 0;
    int end_x = get_screen_size(0).x; // master screen
    int end_y = get_screen_size(0).y; // master screen
    for(int i = 0 ; i < get_screen_num(); i++) {
      // x part
      if(get_screen_location(i).x < begin_x) {
        begin_x = get_screen_location(i).x;
      } 

      if (get_screen_location(i).x > 0) {
        end_x += get_screen_size(i).x;
      }

      // y part
      if(get_screen_location(i).y < begin_y) {
        begin_y = get_screen_location(i).y;
      }

      if (get_screen_location(i).y > 0) {
        end_y += get_screen_size(i).y;
      }
    }
    if(loc.x < begin_x || loc.x > (end_x -window.x) || loc.y < begin_y || loc.y > (end_y - window.y)) {
      center_sketch(loc);
    }
  }
  surface.setLocation(loc.x,loc.y);
}

void center_sketch(ivec2 loc) {
  int term_x_0 = get_screen_size().x /2;
  int term_x_1 = width/2;
  loc.x = term_x_0 - term_x_1;
  int term_y_0 = get_screen_size().y /2;
  int term_y_1 = height/2;
  loc.y = term_y_0 - term_y_1;
}
