import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.awt.event.KeyEvent; 
import java.awt.image.*; 
import java.awt.*; 
import oscP5.*; 
import netP5.*; 
import java.util.Arrays; 
import java.nio.ByteBuffer; 
import java.nio.ByteOrder; 
import processing.pdf.*; 
import rope.core.*; 
import rope.vector.*; 
import java.util.Arrays; 
import java.util.Iterator; 
import java.util.Random; 
import java.awt.image.BufferedImage; 
import java.awt.Color; 
import java.awt.Font; 
import java.awt.image.BufferedImage; 
import java.awt.FontMetrics; 
import java.io.FileNotFoundException; 
import java.io.FileOutputStream; 
import javax.imageio.ImageIO; 
import javax.imageio.IIOImage; 
import javax.imageio.ImageWriter; 
import javax.imageio.ImageWriteParam; 
import javax.imageio.metadata.IIOMetadata; 
import java.lang.reflect.Field; 
import java.awt.Graphics; 
import java.awt.GraphicsEnvironment; 
import java.awt.GraphicsDevice; 
import java.awt.Rectangle; 
import themidibus.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class A___control_33 extends PApplet {

/**
Romanesco dui
2012–2019
version 32
Processing 3.5.3
*/
/**
Controller 
V 1.2.0
2015 may 4_100 lines of code
2016 september 8_700 lines of code
2017 March 11_100 lines of code
2018 June 5_000 lines of code without CROPE and ROPE internal library who have around 18_000 lines
*/
String IAM = "controller";
/**
LIVE must change from the launcher, the info must be write in the external loading preference app
*/

// DEV SETTING
// boolean DEV_MODE = true; // inter alia, path preferences folder, curtain
// boolean LIVE = false;
// boolean MIROIR = false;
// boolean KEEP_BUTTON_ITEM_STATE = true;










// EXPORT SETTING

// DIRECT
// boolean LIVE = false;
// boolean MIROIR = false;
// boolean KEEP_BUTTON_ITEM_STATE = true;
// boolean DEV_MODE = false;  // inter alia, path preferences folder, curtain

// LIVE
boolean LIVE = true;
boolean MIROIR = false;
boolean KEEP_BUTTON_ITEM_STATE = true;
boolean DEV_MODE = false; // inter alia, path preferences folder, curtain









public void settings() {
  size(670,725);
  size_window_ref = ivec2(width,height);
  set_design();
}

public void setup() {
  colorMode(HSB,360,100,100);
  // surface.setLocation(0,20);
  load_window_location();
  path_setting();
  version();
  setting_misc();
  init_button_general();
  init_midi();
  create_and_initialize_data(); 
  load_setup();
  // load_filter();
  
  set_system_specification();
  set_font();
  set_display_slider();
  set_import_pic_button();
  set_console();
  set_button_item_console();  
  build_console();
  build_dropdown_bar();
  build_dropdown_item_selected();
  build_button_item_console();
  build_inventory();
  set_OSC();
  set_data();
  reset();
}

public void draw() {
  check_size_window();
  update_window_location();
  check_slider_item();
  
  add_media();
  check_button();

  manage_autosave();
  
  update_media();
  
  surface.setTitle(nameVersion + ": " +prettyVersion+"."+version+ " - Controller");

  set_data();

  display_structure();

  show_misc_text();
  show_slider_controller();

  update_button();
  show_button();

  show_dropdown();
  
  midi_manager(false);
  update_midi();
  update_OSC();
  update_dial();

  reset();
  credit();
}


public void mouseWheel(MouseEvent e) {
  scroll(e);
}

public void mousePressed () {
  if(!dropdown_is()) {
    mousePressed_button_general();
    mousepressed_button_item_console();
    mousepressed_button_inventory();
  } 
}

public void keyPressed() {
  keypressed_midi();
  shortcuts_controller();
}


public void keyReleased() { 
  key_false();
  keyboard[keyCode] = false;
}
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
public void path_setting() {
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
public void version() {
  String [] s = loadStrings(preference_path+"version.txt");
  String [] v = split(s[0],"/");
  prettyVersion = v[0];
  version = v[1];
  nameVersion = v[2];
}


public String system() {
  return System.getProperty("os.name");
}

public void set_system_specification() {
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
public File [] list_files(String path) {
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
public void create_font() {
  int size_font = 200;
  String[] path_list = alphabetical_font_path(font_path);

  font = new ROFont[path_list.length]; 
  for(int i = 0 ; i < path_list.length ; i++) {
    if(extension_font(path_list[i])) {
      font[i] = new ROFont(path_list[i],size_font);
    } 
  }
}

public String [] alphabetical_font_path(String folder_path) {
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




public boolean extension_font(String path) {
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

  public PFont get_font() {
    return font;
  }

  public String get_path() {
    return path;
  }

  public String get_type() {
    return type;
  }

  public int get_size() {
    return size;
  }

  public String get_name() {
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
public void add_media(String path) {
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


public boolean ext(String path, String extension) {
  return extension(path).equals(extension);
}


/**
add movie path
*/
public void add_input(ArrayList<File> media_file_by_type, String path) {
  File file = new File(path);
  if(!check_already_existing_path(path)) {
    media_file_by_type.add(file);
    media_files.add(file);
  }
}

public boolean check_already_existing_path(String path) {
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
public void update_window_location() {
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


public void write_window_location() {
  String loc [] = new String[2];
  loc[0] = Integer.toString(ref_window_location.x);
  loc[1] = Integer.toString(ref_window_location.y);
  saveStrings("data/location.loc",loc);
}



public void load_window_location() {
  load_window_location(ivec2(width,height));
}

public void load_window_location(ivec2 window) {
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

public void center_sketch(ivec2 loc) {
  int term_x_0 = get_screen_size().x /2;
  int term_x_1 = width/2;
  loc.x = term_x_0 - term_x_1;
  int term_y_0 = get_screen_size().y /2;
  int term_y_1 = height/2;
  loc.y = term_y_0 - term_y_1;
}











/**
Core controller
v 0.1.0
2018-2018
*/




boolean[] keyboard = new boolean[526];
boolean LOAD_SETTING = false ;
boolean INIT_INTERFACE = true ;


public void setting_misc() {
  frameRate(60) ; 
  noStroke () ; 
  surface.setResizable(true);
}





public void reset() {
  LOAD_SETTING = false;
  INIT_INTERFACE = false;
  reset_midi_control_parametter();
  reset_button_flash();
  if(!mousePressed) {
    slider_already_used(false);
    set_dna_gui_processing(0);
  }
  // slider_already_used(false);
}

public void reset_button_flash() {
  button_reset_camera.set_is(false);
  button_reset_item_on.set_is(false);
  button_reset_fx.set_is(false);
  button_birth.set_is(false);
  button_3D.set_is(false);
}






public void info_shader_background() {
  int n = shader_background_table.getRowCount();
  shader_bg_name = new String[n];
  shader_bg_author = new String[n];
  for (int i = 0 ; i < n ; i++) {
    TableRow row = shader_background_table.getRow(i);
    shader_bg_name[i] = row.getString("Name");
    shader_bg_author[i] = row.getString("Author");
  }
}

public void info_shader_fx() {
  int n = shader_fx_table.getRowCount();
  shader_fx_name = new String[n];
  shader_fx_author = new String[n];
  for (int i = 0 ; i < n ; i++) {
    TableRow row = shader_fx_table.getRow(i);
    shader_fx_name[i] = row.getString("Name");
    shader_fx_author[i] = row.getString("Author");
  }
}






/**
size window
*/
boolean change_size_window_is = false ;
public void check_size_window() {
  if(size_window_ref.x != width || size_window_ref.y != height) {
    change_size_window(true);
    INIT_INTERFACE = true;
    size_window_ref.set(width,height);
  }
}

public void change_size_window(boolean is) {
  change_size_window_is = is ;
}

public boolean change_size_window_is() {
  return change_size_window_is;
}


/**
manage autosave
*/
public void manage_autosave() {
  boolean state = false ;
  state = change_size_window_is();
  
  if(state) {
    autosave();
    load_autosave();
  }     
}





/**
dialogue between controller prescen and scene
this part can be use to save no instant data, to keep ligh the OSC system
*/
float mouse_reactivity = .5f;
float mouse_reactivity_ref = .5f;
public void update_dial() {
  mouse_reactivity = map(value_slider_camera[6],0,360,0.001f,1);
  if(mouse_reactivity_ref != mouse_reactivity) {
    save_dial_data(preference_path);
    mouse_reactivity_ref = mouse_reactivity;

  }
}






















/**
FONT
*/
PFont textUsual_1, textUsual_2, textUsual_3; 
PFont title_medium, title_big;  
PFont FuturaExtraBold_9, FuturaExtraBold_10;
PFont FuturaCondLight_10, FuturaCondLight_11,FuturaCondLight_12,FuturaStencil_20;
      
//SETUP
public void set_font() {
  String path_font_gui = import_path+"font/default_font/" ;
  FuturaStencil_20 = loadFont(path_font_gui +"FuturaStencilICG-20.vlw");
  FuturaExtraBold_9 = loadFont(path_font_gui +"Futura-ExtraBold-9.vlw");
  FuturaExtraBold_10 = loadFont(path_font_gui +"Futura-ExtraBold-10.vlw");
  FuturaCondLight_10 = loadFont(path_font_gui +"Futura-CondensedLight-10.vlw");
  FuturaCondLight_11 = loadFont(path_font_gui +"Futura-CondensedLight-11.vlw");
  FuturaCondLight_12 = loadFont(path_font_gui +"Futura-CondensedLight-12.vlw");
  
  textUsual_1 = FuturaCondLight_10 ;
  textUsual_2 = FuturaCondLight_11 ;
  textUsual_3 = FuturaCondLight_12 ;

  title_medium = FuturaExtraBold_10 ;
  title_big = FuturaStencil_20 ;
}







/**
DETECTION CURSOR
*/
public boolean locked (boolean inside) {
  if (inside && mousePressed) return true ; else return false ;
}





/**
CREDIT
*/
boolean insideNameversion ;
public void credit() {
  if(mouseX > 2 && mouseX < 160 && mouseY > 3 && mouseY < 26 ) {
    insideNameversion = true; 
  } else {
    insideNameversion = false;
  }

  if(insideNameversion && mousePressed) {
    String credit[] = loadStrings("credit.txt");
    
    fill(struc_colour_credit_background,225); 
    int startBloc = 24;
    rect(0, startBloc, width, height - startBloc -9 ) ; // //GROUP ZERO
    for (int i = 0 ; i < credit.length; i++) {
      textFont(textUsual_3);
      fill(struc_colour_credit_text) ;
      text(credit[i], 10,startBloc + 12 + ((i+1)*14));
    }
  }
}




















/**
Build interface 
v 3.3.1
2014-2018
Romanesco Processing Environment
*/
public void build_console() {
  build_console_general();
  build_console_bar();
  build_console_background();
  build_console_filter();
  build_console_light();
  build_console_sound();
  build_console_setting();
  build_console_item();  
}


public void build_console_general() {
  button_midi = new Button(pos_midi_button, size_midi_button);
  button_curtain = new Button(pos_curtain_button, size_curtain_button);
  button_reset_camera = new Button(pos_reset_camera_button, size_reset_camera_button);
  button_reset_item_on = new Button(pos_reset_item_on_button, size_reset_item_on_button);
  button_reset_fx = new Button(pos_reset_fx_button, size_reset_fx_button);
  button_birth = new Button(pos_birth_button, size_birth_button);
  button_3D = new Button(pos_3D_button, size_3D_button);
}

public void build_console_bar() {
  dropdown_bar = new Dropdown[num_dropdown_bar];
  dropdown_bar_pos = new ivec2[num_dropdown_bar];
  dropdown_bar_size = new ivec2[num_dropdown_bar];
  dropdown_content = new String[num_dropdown_bar][0];
}





public void build_console_background() {
  for (int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    ivec2 temp_size_mol = ivec2(round(size_slider_background[i].y *ratio_size_molette), round(size_slider_background[i].y *ratio_size_molette));
    ivec2 temp_pos = ivec2(pos_slider_background[i].x, round(pos_slider_background[i].y -(slider_height_background *.6f)));
    if(cropinfo_slider_background[i].get_id() != -1) {
      slider_adj_background[i] = new Sladj(temp_pos, size_slider_background[i]);
      slider_adj_background[i].set_molette(ELLIPSE);
      slider_adj_background[i].size_molette(temp_size_mol);
      slider_adj_background[i].set_id(i);
      slider_adj_background[i].set_label(slider_background_name[i],iadd(slider_adj_background[i].get_size(),ivec2(3,0)));
      slider_adj_background[i].set_font(textUsual_1);
      slider_adj_background[i].set_rounded(rounded_slider);
      slider_adj_background[i].set_fill_label(label_in_light,label_out_dark);
      slider_adj_background[i].set_fill(struc_light);
      slider_adj_background[i].set_fill_molette(molette_in_light,molette_out_light);
      slider_adj_background[i].set_fill_adj(adj_in_light,adj_out_light);
    }
  }

  // change color for the next slider after colour slider
  for(int i = 4 ; i < slider_adj_background.length ; i++) {
    if((i > 3 && i < 6) || (i > 7 && i < 11)) {
      slider_adj_background[i].set_fill(struc_dark);
      slider_adj_background[i].set_fill_molette(molette_in_dark,molette_out_dark);
      slider_adj_background[i].set_fill_adj(adj_in_dark,adj_out_dark);
    }
  }

  button_bg = new Button(pos_button_background, size_button_background);
  button_bg.set_is(true);
  button_bg.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_bg.set_font(FuturaExtraBold_10);
}

public void build_console_filter() {
  for (int i = 0 ; i < NUM_SLIDER_FX ; i++) {
    ivec2 temp_size_mol = ivec2(round(size_slider_fx[i].y *ratio_size_molette), round(size_slider_fx[i].y *ratio_size_molette));
    ivec2 temp_pos = ivec2(pos_slider_fx[i].x, round(pos_slider_fx[i].y -(slider_height_filter *.6f)));
    slider_adj_fx[i] = new Sladj(temp_pos,size_slider_fx[i]);
    slider_adj_fx[i].set_molette(ELLIPSE);
    slider_adj_fx[i].size_molette(temp_size_mol);
    slider_adj_fx[i].set_id(i);
    slider_adj_fx[i].set_label(slider_filter_name[i],iadd(slider_adj_fx[i].get_size(),ivec2(3,0)));
    slider_adj_fx[i].set_font(textUsual_1);
    slider_adj_fx[i].set_rounded(rounded_slider);
    slider_adj_fx[i].set_fill_label(label_in_light,label_out_dark);
    slider_adj_fx[i].set_fill(struc_light);
    slider_adj_fx[i].set_fill_molette(molette_in_light,molette_out_light);
    slider_adj_fx[i].set_fill_adj(adj_in_light,adj_out_light);
  }

  // change color for the next slider after colour slider
  for(int i = 3 ; i < slider_adj_fx.length ; i++) {
    if((i > 2 && i < 5) || (i > 6 && i < 9) || (i > 10 && i < 13)) {
      slider_adj_fx[i].set_fill(struc_dark);
      slider_adj_fx[i].set_fill_molette(molette_in_dark,molette_out_dark);
      slider_adj_fx[i].set_fill_adj(adj_in_dark,adj_out_dark);
    }
  }

  for(int i = 0 ; i < NUM_BUTTON_FX ; i++) {
    button_fx[i] = new Button(pos_button_fx[i], size_button_fx[i]);
    button_fx[i].set_aspect_on_off(button_on_in,button_on_out,button_off_in,button_off_out);
    button_fx[i].set_font(FuturaExtraBold_10);
    if(i == 0) {
      //button_fx[i].set_label("FX ON/OFF");
    } else if (i == 1) {
      button_fx[i].set_label("MOVE");
    } else if (i == 2) {
      button_fx[i].set_label("EXTRA");
    }
  }
}

public void build_console_light() {
  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    ivec2 temp_size_mol = ivec2(round(size_slider_light[i].y *ratio_size_molette), round(size_slider_light[i].y *ratio_size_molette));
    ivec2 temp_pos = ivec2(pos_slider_light[i].x, round(pos_slider_light[i].y -(slider_height_light *.6f)));
    slider_adj_light[i] = new Sladj(temp_pos, size_slider_light[i]);
    slider_adj_light[i].set_molette(ELLIPSE);
    slider_adj_light[i].size_molette(temp_size_mol);
    slider_adj_light[i].set_id(i);
    slider_adj_light[i].set_label(slider_light_name[i],iadd(slider_adj_light[i].get_size(),ivec2(3,0)));
    slider_adj_light[i].set_font(textUsual_1);
    slider_adj_light[i].set_rounded(rounded_slider);
    slider_adj_light[i].set_fill_label(label_in_dark,label_out_dark);
    slider_adj_light[i].set_fill(struc_dark);
    slider_adj_light[i].set_fill_molette(molette_in_dark,molette_out_dark);
    slider_adj_light[i].set_fill_adj(adj_in_dark,adj_out_dark);
  }

  // LIGHT AMBIENT
  button_light_ambient = new Button(pos_light_ambient_buttonButton, size_light_ambient_buttonButton);
  button_light_ambient.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_ambient.set_font(FuturaExtraBold_10);
  

  button_light_ambient_action = new Button(pos_light_ambient_button_action, size_light_ambient_button_action);
  button_light_ambient_action.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_ambient_action.set_label("MOVE");
  // LIGHT ONE
  button_light_1 = new Button(pos_light_1_button, size_light_1_button);
  button_light_1.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_1.set_font(FuturaExtraBold_10);

  button_light_1_action = new Button(pos_light_1_button_action, size_light_1_button_action);
  button_light_1_action.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_1_action.set_font(FuturaExtraBold_10);
  button_light_1_action.set_label("MOVE");
  // LIGHT TWO 
  button_light_2 = new Button(pos_light_2_button, size_light_2_button);
  button_light_2.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_2.set_font(FuturaExtraBold_10);

  button_light_2_action = new Button(pos_light_2_button_action, size_light_2_button_action);
  button_light_2_action.set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
  button_light_2_action.set_font(FuturaExtraBold_10);
  button_light_2_action.set_label("MOVE");
}


public void build_console_sound() {
  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {
    ivec2 temp_size_mol = ivec2(round(size_slider_sound[i].y *ratio_size_molette), round(size_slider_sound[i].y *ratio_size_molette));
    ivec2 temp_pos = ivec2(pos_slider_sound[i].x, round(pos_slider_sound[i].y -(slider_height_sound *.6f)));
    slider_adj_sound[i] = new Sladj(temp_pos, size_slider_sound[i]);
    slider_adj_sound[i].set_molette(ELLIPSE);
    slider_adj_sound[i].size_molette(temp_size_mol);
    slider_adj_sound[i].set_id(i);
    slider_adj_sound[i].set_label(slider_sound_name[i],iadd(slider_adj_sound[i].get_size(),ivec2(3,0)));
    slider_adj_sound[i].set_font(textUsual_1);
    slider_adj_sound[i].set_rounded(rounded_slider);
    slider_adj_sound[i].set_fill_label(label_in_dark,label_out_dark);
    slider_adj_sound[i].set_fill(struc_dark);
    slider_adj_sound[i].set_fill_molette(molette_in_dark,molette_out_dark);
    slider_adj_sound[i].set_fill_adj(adj_in_dark,adj_out_dark);
  }

  for(int i = 0 ; i < NUM_BUTTON_TRANSIENT ; i++) {
    button_transient[i] = new Button(pos_button_transient[i], size_button_transient[i]);
    button_transient[i].set_aspect_on_off(button_on_in, button_on_out, button_off_in, button_off_out);
    button_transient[i].set_font(FuturaExtraBold_10);
    button_transient[i].set_label("BEAT "+i);
  }
}


public void build_console_setting() {
  String [] content = {"SOUND","CAMERA"};
  dropdown_setting = new Dropdown(dropdown_setting_pos,dropdown_setting_size,"Romanesco setting",content);
  dropdown_setting.set_colour(dropdown_colour);
  dropdown_setting.wheel(true);
  dropdown_setting.set_box_rank(2);
  dropdown_setting.set_header_text_pos(dropdown_pos_text);
  dropdown_setting.set_box_text_pos(dropdown_pos_text);
  dropdown_setting.set_box_height(height_box_dropdown);
  dropdown_setting.set_font(title_medium);
  dropdown_setting.set_box_font(textUsual_1);
  build_console_camera();
  build_console_sound_setting();
}

public void build_console_sound_setting() {
  // slider range transient
  ivec2 size_mol = ivec2(round(size_slider_sound_setting[0].y *ratio_size_molette), round(size_slider_sound_setting[0].y *ratio_size_molette));
  ivec2 pos_slider = ivec2(pos_slider_sound_setting[0].x, round(pos_slider_sound_setting[0].y -(slider_height_sound_setting *.6f)));
  slider_sound_setting[0] = new Slider(pos_slider, size_slider_sound_setting[0]);
  slider_sound_setting[0].set_id(0);
  slider_sound_setting[0].set_molette_num(3);
  slider_sound_setting[0].size_molette(size_mol.x/2,size_mol.y);
  slider_sound_setting[0].set_label(slider_sound_setting_name[0],iadd(slider_sound_setting[0].get_size(),ivec2(3,0)));
  slider_sound_setting[0].set_font(textUsual_1);
  slider_sound_setting[0].set_rounded(rounded_slider);
  slider_sound_setting[0].set_fill_label(label_in_light,label_out_light);
  slider_sound_setting[0].set_fill(struc_light);
  slider_sound_setting[0].set_fill_molette(molette_in_dark,molette_out_light);
  // slider transient threshold
  int in_slider_double = 1;
  int out_slider_double = 5;
  for (int i = in_slider_double ; i < out_slider_double ; i++) {
    ivec2 temp_size_mol = ivec2(round(size_slider_sound_setting[i].y *ratio_size_molette), round(size_slider_sound_setting[i].y *ratio_size_molette));
    ivec2 temp_pos = ivec2(pos_slider_sound_setting[i].x, round(pos_slider_sound_setting[i].y -(slider_height_sound_setting *.6f)));
    if(cropinfo_slider_sound_setting[i].get_id() > -1) {
      slider_sound_setting[i] = new Slider(temp_pos, size_slider_sound_setting[i]);
      slider_sound_setting[i].set_id(i);
      slider_sound_setting[i].set_molette_num(2);
      slider_sound_setting[i].size_molette(size_mol.x/2,size_mol.y);
      slider_sound_setting[i].set_label(slider_sound_setting_name[i],iadd(slider_sound_setting[i].get_size(),ivec2(3,0)));
      slider_sound_setting[i].set_font(textUsual_1);
      slider_sound_setting[i].set_rounded(rounded_slider);
      slider_sound_setting[i].set_fill_label(label_in_dark,label_out_dark);
      slider_sound_setting[i].set_fill(struc_dark);
      slider_sound_setting[i].set_fill_molette(molette_in_dark,molette_out_dark);
    }
  }
  
  int in_slider_single = out_slider_double;
  int out_slider_single = NUM_SLIDER_SOUND_SETTING;
  for (int i =  in_slider_single ; i < out_slider_single ; i++) {
    ivec2 temp_size_mol = ivec2(round(size_slider_sound_setting[i].y *ratio_size_molette), round(size_slider_sound_setting[i].y *ratio_size_molette));
    ivec2 temp_pos = ivec2(pos_slider_sound_setting[i].x, round(pos_slider_sound_setting[i].y -(slider_height_sound_setting *.6f)));
    slider_sound_setting[i] = new Slider(temp_pos, size_slider_sound_setting[i]);
    slider_sound_setting[i].set_molette(ELLIPSE);
    slider_sound_setting[i].size_molette(temp_size_mol);
    slider_sound_setting[i].set_id(i);
    slider_sound_setting[i].set_label(slider_sound_setting_name[i],iadd(slider_sound_setting[i].get_size(),ivec2(3,0)));
    slider_sound_setting[i].set_font(textUsual_1);
    slider_sound_setting[i].set_rounded(rounded_slider);
    slider_sound_setting[i].set_fill_label(label_in_dark,label_out_dark);
    slider_sound_setting[i].set_fill(struc_dark);
    slider_sound_setting[i].set_fill_molette(molette_in_dark,molette_out_dark);
  }
}

public void build_console_camera() {
  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {
    ivec2 temp_size_mol = ivec2(round(size_slider_camera[i].y *ratio_size_molette), round(size_slider_camera[i].y *ratio_size_molette));
    ivec2 temp_pos = ivec2(pos_slider_camera[i].x, round(pos_slider_camera[i].y -(slider_height_camera *.6f)));
    slider_adj_camera[i] = new Sladj(temp_pos, size_slider_camera[i]);
    slider_adj_camera[i].set_molette(ELLIPSE);
    slider_adj_camera[i].size_molette(temp_size_mol);
    slider_adj_camera[i].set_id(i);
    slider_adj_camera[i].set_label(slider_camera_name[i],iadd(slider_adj_camera[i].get_size(),ivec2(3,0)));
    slider_adj_camera[i].set_font(textUsual_1);
    slider_adj_camera[i].set_rounded(rounded_slider);
    slider_adj_camera[i].set_fill_label(label_in_dark,label_out_dark);
    slider_adj_camera[i].set_fill(struc_dark);
    slider_adj_camera[i].set_fill_molette(molette_in_dark,molette_out_dark);
    slider_adj_camera[i].set_fill_adj(adj_in_dark,adj_out_dark);
  }
}

public void build_console_item() {
  // dropdown
  num_dd_item = NUM_ITEM +1; // add one for the dropdownmenu, because the item `0` is not used
  list_item_costume = new String[num_dd_item];
  dd_item_costume = new Dropdown[num_dd_item];

  list_item_mode = new String[num_dd_item];
  dd_item_mode = new Dropdown[num_dd_item];

  // slider
  for (int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    ivec2 temp_size_mol = ivec2(round(size_slider_item[i].y *ratio_size_molette), round(size_slider_item[i].y *ratio_size_molette));
    ivec2 temp_pos = ivec2(pos_slider_item[i].x, round(pos_slider_item[i].y -(slider_height_item *.6f)));
    println("method build_console_item(): cropinfo length",cropinfo_slider_item.length,i);
    if(cropinfo_slider_item[i].get_id() > -1) {
      slider_adj_item[i] = new Sladj(temp_pos, size_slider_item[i]);
      slider_adj_item[i].set_molette(ELLIPSE);
      slider_adj_item[i].size_molette(temp_size_mol);
      slider_adj_item[i].set_id(i);

      String label_name = slider_item_name[i];
      if(label_name.equals("f_hue")) label_name = "FILL";
      else if(label_name.equals("f_saturation")) label_name = "saturation";
      else if(label_name.equals("f_brightness")) label_name = "brightness";
      else if(label_name.equals("f_alpha")) label_name = "alpha";
      else if(label_name.equals("s_hue")) label_name = "STROKE";
      else if(label_name.equals("s_saturation")) label_name = "saturation";
      else if(label_name.equals("s_brightness")) label_name = "brightness";
      else if(label_name.equals("s_alpha")) label_name = "alpha";
      else if(label_name.equals("thickness")) label_name = "THICKNESS";
      slider_adj_item[i].set_label(label_name,iadd(slider_adj_item[i].get_size(),ivec2(3,0)));
      slider_adj_item[i].set_font(textUsual_1);
      slider_adj_item[i].set_rounded(rounded_slider);
      slider_adj_item[i].set_fill_label(label_in_dark,label_out_dark);
      slider_adj_item[i].set_fill_molette(molette_in_dark,molette_out_dark);
      slider_adj_item[i].set_fill_adj(adj_in_dark,adj_out_dark);
    }
  }
  // COL A
  // fill alpha
  slider_adj_item[hue_fill_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[sat_fill_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[bright_fill_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[alpha_fill_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // stroke alpha
  slider_adj_item[hue_stroke_rank].set_fill_adj(adj_in_dark,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[sat_stroke_rank].set_fill_adj(adj_in_dark,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[bright_stroke_rank].set_fill_adj(adj_in_dark,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[alpha_stroke_rank].set_fill_adj(adj_in_dark,adj_out_dark).set_fill(struc_dark);
  //  thickness
  slider_adj_item[thickness_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // size
  slider_adj_item[size_x_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[size_y_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[size_z_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  // diam
  slider_adj_item[diameter_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // canvas
  slider_adj_item[canvas_x_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[canvas_y_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[canvas_z_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);

  // COL B
  // reactivity
  slider_adj_item[frequence_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // speed
  slider_adj_item[speed_x_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[speed_y_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[speed_z_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  // spurt
  slider_adj_item[spurt_x_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[spurt_y_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[spurt_z_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // direction
  slider_adj_item[dir_x_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[dir_y_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[dir_z_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  // jitter
  slider_adj_item[jitter_x_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[jitter_y_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[jitter_z_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  // swing
  slider_adj_item[swing_x_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[swing_y_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[swing_z_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);

  // COL C
  slider_adj_item[quantity_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);

  slider_adj_item[variety_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light); 
  slider_adj_item[life_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[flow_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[quality_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  
  slider_adj_item[area_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[angle_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[scope_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
  slider_adj_item[scan_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark); 
  slider_adj_item[alignment_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);

  slider_adj_item[repulsion_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[attraction_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  slider_adj_item[density_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);
  
  slider_adj_item[influence_rank].set_fill(struc_dark);
  slider_adj_item[calm_rank].set_fill(struc_dark);
  slider_adj_item[spectrum_rank].set_fill(struc_dark);

  // COL D
  slider_adj_item[grid_rank].set_fill_adj(adj_in_light,adj_out_light).set_fill(struc_light);

  slider_adj_item[viscosity_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark); 
  slider_adj_item[diffusion_rank].set_fill_adj(adj_in_light,adj_out_dark).set_fill(struc_dark);
}

















































/**
Build DROPDOWN 
v 1.2.0
*/
public void build_dropdown_bar() {
  String[] path_list = alphabetical_font_path(font_path);
  font_dropdown_list = new String[path_list.length];;
  int target = 0;
  for(int i = 0 ; i < path_list.length ; i++) {
    if(extension_font(path_list[i])) {
      ROFont font = new ROFont(path_list[i],10);
      font_dropdown_list[target] = font.get_name();
      target++;
    } 
  }

  
  //image
  update_media() ;
 
  for(int i = 0 ; i < dropdown_bar.length ; i++) {
    dropdown_bar_pos[i] = ivec2(pos_x_dropdown_bar[i],pos_y_dropdown_bar);
    dropdown_bar_size[i] = ivec2(width_dropdown_bar[i],height_dropdown_header_bar);
    int num_box = 7;

    dropdown_bar[i] = new Dropdown(dropdown_bar_pos[i],dropdown_bar_size[i],name_dropdown_bar[i],dropdown_content[i]);
    dropdown_bar[i].set_colour(dropdown_colour);
    dropdown_bar[i].set_header_text_pos(dropdown_pos_text);
    dropdown_bar[i].wheel(true);
    dropdown_bar[i].set_box_text_pos(dropdown_pos_text);
    dropdown_bar[i].set_box(num_box,2);
    dropdown_bar[i].set_box_height(height_box_dropdown);
    dropdown_bar[i].set_font(title_medium);
    dropdown_bar[i].set_box_font(textUsual_1);
  }
}

public void build_dropdown_item_selected() {
  build_local_dd_item(dd_item_costume,inventory_item_table, list_item_costume, "C","Costume", 0);
  build_local_dd_item(dd_item_mode,inventory_item_table, list_item_mode, "M","Mode", 15);
}

public void build_local_dd_item(Dropdown [] dd, Table inventory_table, String [] list_global, String title, String type, int offset_y) {
  //load the external list  for each mode and costume and split to read in the interface
  for (int i = 0 ; i<inventory_table.getRowCount() ; i++) {
    TableRow row = inventory_table.getRow(i);
    list_global[row.getInt("ID")] = row.getString(type); 
  }
  //common param
  ivec2 size_header = ivec2(30,15);
  ivec2 pos_text = ivec2(8,8);
  int x = offset_x_item;
  int y = height_item_selected +local_pos_y_dropdown_item + offset_y;
  // group item
  for (int i = 0 ; i <= NUM_ITEM ; i++ ) {
    if(list_global[i] != null) {
      //Split the dropdown to display in the dropdown
      String [] list_detail = split(list_global[i],"/");
      //to change the title of the header dropdown
      dd[i] = new Dropdown(ivec2(x,y), size_header,title,list_detail);
      dd[i].set_colour(dropdown_color_item);
      dd[i].set_header_text_pos(pos_text);
      dd[i].wheel(true);
      dd[i].set_box_text_pos(pos_text);
      dd[i].set_box(7);
      dd[i].set_box_height(height_box_dropdown);
      dd[i].set_font(title_medium);
      dd[i].set_box_font(textUsual_1);
    }
  }
}





/**
Variable
v 0.3.0
*/
/**
design
*/
public void set_design() {
  set_design_structure();
  set_design_aspect();
}






/**
set structure
*/
public void set_design_structure() {
  height_box_dropdown = 15;
  dropdown_pos_text = ivec2(3,10);

  ratio_size_molette = 1.3f;
  // vertical grid
  marge = 10;

  int width_inside = width -(2*marge);
  grid_col = new int[12];
  col_width = width_inside/grid_col.length;
  grid_col[0] = marge;
  for(int i = 1 ; i < grid_col.length ; i++) {
    grid_col[i] = col_width +grid_col[i-1];
  }

  sizeTitleButton = 10 ;

  spacing_slider = 11;
  rounded_slider = 4;

  height_header = 23;
  height_button_top = 44 ;
  pos_y_button_top = height_header;
  height_dropdown_top = 32;
  pos_y_dropdown_top = height_header +height_button_top;
  height_menu_general = 193;
  pos_y_menu_general = height_header +height_button_top +height_dropdown_top;
  pos_y_menu_general_content = pos_y_menu_general +5;

  set_design_structure_menu_bar();
  set_design_structure_background(1);
  set_design_structure_light(1);
  set_design_structure_filter(1);
  set_design_structure_sound(1);
  set_design_structure_setting(4);

  DIST_BETWEEN_ITEM = 40;
  set_design_structure_item_selected();

  set_design_structure_inventory();
}



// general
public void set_design_structure_background(int rank) {
  slider_width_background = 100;
  slider_height_background = 8;
  offset_background_x = grid_col[0];
  offset_background_y = pos_y_menu_general_content +(rank *spacing_slider);
}


public void set_design_structure_setting(int rank) {
  int px = grid_col[9];
  int py = pos_y_menu_general_content +(rank *spacing_slider);
  dropdown_setting_pos = ivec2(px,py);
  int sx = 100;
  int sy = height_box_dropdown ;
  dropdown_setting_size = ivec2(sx,sy);
  set_design_structure_camera(rank+3);
  set_design_structure_sound_setting(rank+3);
}


public void set_design_structure_camera(int rank) {
  slider_width_camera = 100;
  slider_height_camera = 8;
  offset_camera_x = grid_col[9];
  offset_camera_y = pos_y_menu_general_content +(rank *spacing_slider);
}


public void set_design_structure_sound_setting(int rank) {
  slider_width_sound_setting = 100;
  slider_height_sound_setting = 8;
  offset_sound_setting_x = grid_col[9];
  offset_sound_setting_y = pos_y_menu_general_content +(rank *spacing_slider);
}


public void set_design_structure_filter(int rank) {
  slider_width_filter = 100;
  slider_height_filter = 8;
  offset_filter_x = grid_col[3];
  offset_filter_y = pos_y_menu_general_content +(rank *spacing_slider);
}


public void set_design_structure_light(int rank) {
  slider_width_light = 100;
  slider_height_light = 8;
  offset_light_x = grid_col[6];
  offset_light_y = pos_y_menu_general_content +(rank *spacing_slider);
}

public void set_design_structure_sound(int rank) {
  slider_width_sound = 100;
  slider_height_sound = 8;
  offset_sound_x = grid_col[9];
  offset_sound_y = pos_y_menu_general_content +(rank *spacing_slider);
}

// item
public void set_design_structure_item_selected() {
  slider_width_item = 100;
  slider_height_item = 8;
  // item gui pos
  offset_x_item = grid_col[0];
  item_a_col = grid_col[0];
  item_b_col = grid_col[3];
  item_c_col = grid_col[6];
  item_d_col = grid_col[9];
  // item selected
  local_pos_y_button_item = 20;
  local_pos_y_dropdown_item = local_pos_y_button_item +72;
  local_pos_y_slider_item = local_pos_y_dropdown_item +34;

  height_item_button_console = 85;
  pos_y_item_selected = height_header +height_button_top +height_dropdown_top +height_menu_general;
  height_item_selected = spacing_slider *NUM_SLIDER_ITEM_BY_COL +height_item_button_console;
}

public void set_design_structure_inventory() {
  pos_y_inventory = height_header +height_button_top +height_dropdown_top +height_menu_general +height_item_selected;
  // this value depend of the size of the window, indeed we must calculate this one later.
  height_inventory = 100;
}


public void set_design_structure_menu_bar() {
  spacing_midi_info = 13;
  size_x_window_info_midi = 200;

  num_dropdown_bar = 7;
  pos_y_dropdown_bar = 73;
  pos_x_dropdown_bar = new int[num_dropdown_bar];
  pos_x_dropdown_bar [0] = 5;
  pos_x_dropdown_bar [1] = 100;
  pos_x_dropdown_bar [2] = 160;
  pos_x_dropdown_bar [3] = 280;
  pos_x_dropdown_bar [4] = 370;
  pos_x_dropdown_bar [5] = 455;
  pos_x_dropdown_bar [6] = 535;

  height_dropdown_header_bar = height_box_dropdown;
  width_dropdown_bar = new int[num_dropdown_bar];
  width_dropdown_bar [0] = 75;
  width_dropdown_bar [1] = 40;
  width_dropdown_bar [2] = 60;
  width_dropdown_bar [3] = 60;
  width_dropdown_bar [4] = 60;
  width_dropdown_bar [5] = 40;
  width_dropdown_bar [6] = 60;

  name_dropdown_bar = new String[num_dropdown_bar];
  name_dropdown_bar[0] = "background";
  name_dropdown_bar[1] = "filter";
  name_dropdown_bar[2] = "font";
  name_dropdown_bar[3] = "text";
  name_dropdown_bar[4] = "bitmap";
  name_dropdown_bar[5] = "shape";
  name_dropdown_bar[6] = "movie";
}























/**
aspect
*/
public void set_design_aspect() {
  set_colour_structure_background_header(r.BLOOD);
  set_colour_structure_background_mass(r.GRAY_1,r.GRAY_3);
  set_colour_structure_background_line(r.ORANGE,r.BLOOD);

  fill_text_title_in = r.YELLOW;
  fill_text_title_out = r.ORANGE;

  fill_info_window_rect = r.CARMIN;
  fill_info_window_text = r.YELLOW;

  fill_midi_no_selection = r.CARMIN;
  fill_midi_selection = r.GRAY_2;

  fill_midi_window_no_selection = r.WHITE;
  fill_midi_window_selection = r.WHITE;

  struc_colour_credit_background = r.GRAY_2;
  struc_colour_credit_text = r.WHITE;

  // colour button
  button_on_in = r.GREEN;
  button_on_out = r.BOTTLE;

  button_off_in = r.RED;
  button_off_out = r.CARMIN;

  // dropdown
  color_dd_background = r.BLOOD;
  color_dd_header_in = r.YELLOW;
  color_dd_header_out = r.ORANGE;

  color_dd_header_text_in = r.RED;
  color_dd_header_text_out = r.CARMIN;

  color_dd_item_in = r.RED;
  color_dd_item_out = r.CARMIN;

  color_dd_item_text_in = r.BLOOD;
  color_dd_item_text_out = r.BLOOD;

  color_dd_box_in = r.YELLOW; 
  color_dd_box_out = r.ORANGE;

  color_dd_box_text_in = r.BLOOD;
  color_dd_box_text_out = r.BLOOD;

  selected_dd_text = r.BOTTLE;

  // colour slider light
  molette_in_light = r.GRAY_7;
  molette_out_light = r.GRAY_5;

  adj_in_light = r.GRAY_7;
  adj_out_light = r.GRAY_5;

  struc_light = r.GRAY_3;

  label_in_light = r.GRAY_7;
  label_out_light = r.GRAY_5;


  // colour slider dark
  molette_in_dark = r.GRAY_5;
  molette_out_dark = r.GRAY_3;

  adj_in_dark = r.GRAY_5;
  adj_out_dark = r.GRAY_3;

  struc_dark = r.GRAY_2;

  label_in_dark = r.GRAY_5;
  label_out_dark = r.GRAY_3;

  dropdown_colour = new ROPE_colour(color_dd_background, 
                                    color_dd_header_in, 
                                    color_dd_header_out,
                                    color_dd_header_text_in, 
                                    color_dd_header_text_out,
                                    color_dd_box_in, 
                                    color_dd_box_out, 
                                    color_dd_box_text_in, 
                                    color_dd_box_text_out);

  dropdown_color_item = new ROPE_colour(color_dd_background, 
                                        color_dd_item_in, 
                                        color_dd_item_out,
                                        color_dd_item_text_in,
                                        color_dd_item_text_out,
                                        color_dd_box_in, 
                                        color_dd_box_out,  
                                        color_dd_box_text_in,
                                        color_dd_box_text_out);

}




public void set_colour_structure_background_header(int c) {
  fill_header_struc = c;
}

public void set_colour_structure_background_mass(int c_a, int c_b) {
  structure_background_mass_a = c_a;
  structure_background_mass_b = c_b;

}

public void set_colour_structure_background_line(int c_a, int c_b) {
  structure_background_line_a = c_a;
  structure_background_line_b = c_b;

}































/**
set console
*/
public void set_console() {
  set_console_general();

  set_console_slider_background(ivec2(offset_background_x,offset_background_y),ivec2(slider_width_background, slider_height_background));
  set_console_slider_fx(ivec2(offset_filter_x,offset_filter_y),ivec2(slider_width_filter, slider_height_filter));
  set_console_slider_light(ivec2(offset_light_x,offset_light_y),ivec2(slider_width_light, slider_height_light));
  set_console_sound(ivec2(offset_sound_x,offset_sound_y),ivec2(slider_width_sound, slider_height_sound));
  set_console_slider_sound_setting(ivec2(offset_sound_setting_x,offset_sound_setting_y),ivec2(slider_width_sound_setting, slider_height_sound_setting));
  set_console_slider_camera(ivec2(offset_camera_x,offset_camera_y),ivec2(slider_width_camera, slider_height_camera));

  set_console_slider_item(height_item_selected +local_pos_y_slider_item,ivec2(slider_width_item, slider_height_item));
}

public void set_console_general() {
  // CURTAIN
  pos_curtain_button = ivec2(grid_col[0] +0, pos_y_button_top +8);
  size_curtain_button = ivec2(30,30);
  // RESET CAMERA
  pos_reset_camera_button = ivec2(grid_col[0] +40, pos_y_button_top +9);
  size_reset_camera_button = ivec2(26,26);
  // RESET ITEM ON COORD
  pos_reset_item_on_button = ivec2(grid_col[0] +70, pos_y_button_top +9);
  size_reset_item_on_button = ivec2(26,26);
  // RESET FX LIST
  pos_reset_fx_button = ivec2(grid_col[0] +100, pos_y_button_top +9);
  size_reset_fx_button = ivec2(26,26);
  // BIRTH
  pos_birth_button = ivec2(grid_col[0] +130, pos_y_button_top +9);
  size_birth_button = ivec2(26,26);
  // 3D
  pos_3D_button = ivec2(grid_col[0] +160, pos_y_button_top +9);
  size_3D_button = ivec2(26,26);

  // MIDI
  pos_midi_button = ivec2(grid_col[11] +5, pos_y_button_top +9);
  size_midi_button = ivec2(50,26);
  pos_midi_info = vec2(pos_midi_button.x -size_x_window_info_midi, pos_midi_button.y +10); 
}

public void set_console_slider_background(ivec2 pos, ivec2 size) {
  // button
  int offset_button_y = -PApplet.parseInt(size.y *1.5f);
  pos_button_background = ivec2(pos.x, pos.y +offset_button_y);
  size_button_background = ivec2(80,10);
  // slider
  for(int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_background[i] = ivec2(pos.x,offset_y);
    size_slider_background[i] = ivec2(size);
  }
}



public void set_console_slider_fx(ivec2 pos, ivec2 size) {
  int offset_button_y = -PApplet.parseInt(size.y *1.5f);
  int x = pos.x;
  int y = pos.y +offset_button_y;
  // set a default button
  for(int i = 0 ; i < NUM_BUTTON_FX ; i++) {
    button_fx_is[i] = 0;
    size_button_fx[i] = ivec2(38,10);
  }
  // set position from size
  int offset_x = 0;
  for(int i = 0 ; i < NUM_BUTTON_FX ; i++) {
    
    x = pos.x + offset_x;
    offset_x += size_button_fx[i].x ;
    pos_button_fx[i] = ivec2(x,y);
  }

  for(int i = 0 ; i < NUM_SLIDER_FX ; i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_fx[i] = ivec2(pos.x, offset_y);
    size_slider_fx[i] = ivec2(size);
  }
}



public void set_console_slider_light(ivec2 pos, ivec2 size) {
  int offset_button_y = -PApplet.parseInt(size.y *1.5f);

  size_light_ambient_buttonButton = ivec2(75,10);
  size_light_ambient_button_action = ivec2(45,10);
  pos_light_ambient_buttonButton = ivec2(pos.x, pos.y +offset_button_y);
  pos_light_ambient_button_action = ivec2(pos.x +size_light_ambient_buttonButton.x, pos_light_ambient_buttonButton.y); // for the y we take the y of the button
  
  // light one button
  size_light_1_button = ivec2(80,10);
  size_light_1_button_action = ivec2(45,10);
  pos_light_1_button = ivec2(pos.x, pos.y +(5*spacing_slider) +offset_button_y);
  pos_light_1_button_action = ivec2(pos.x +size_light_1_button.x, pos_light_1_button.y); // for the y we take the y of the button
  // light two button
  
  size_light_2_button = ivec2(82,10);
  size_light_2_button_action = ivec2(45,10);
  pos_light_2_button = ivec2(pos.x, pos.y +(10*spacing_slider) +offset_button_y);
  pos_light_2_button_action = ivec2(pos.x +size_light_2_button.x, pos_light_2_button.y); // for the y we take the y of the button
  
  //slider
  int count = 0;
  for(int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    if(i%3 == 0 && i > 0) count +=3 ; else count++ ;
    int offset_y = offset_y(pos.y, size.y, count-1);
    pos_slider_light[i] = ivec2(pos.x, offset_y);
    size_slider_light[i] = ivec2(size);  
  }
}




public void set_console_sound(ivec2 pos, ivec2 size) {
  int offset_button_y = -PApplet.parseInt(size.y *1.5f);
  
  // button
  int x = pos.x;
  int y =  pos.y +offset_button_y;
  for(int i = 0 ; i < NUM_BUTTON_TRANSIENT ; i++) {
    button_transient_is[i] = 0;
    size_button_transient[i] = ivec2(40,10);
    int s = size_button_transient[i].x ;
    x = ((s*i) +pos.x);
    pos_button_transient[i] = ivec2(x,y);
  }

  //slider
  for(int i = 0 ; i < NUM_SLIDER_SOUND ;i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_sound[i] = ivec2(pos.x, offset_y);
    size_slider_sound[i] = ivec2(size);
  }
}

public void set_console_slider_sound_setting(ivec2 pos, ivec2 size) {
  for(int i = 0 ; i < NUM_SLIDER_SOUND_SETTING ;i++) {
    int offset_y = offset_y(pos.y, size.y, i);
    pos_slider_sound_setting[i] = ivec2(pos.x, offset_y);
    size_slider_sound_setting[i] = ivec2(size);
  }
}

public void set_console_slider_camera(ivec2 pos, ivec2 size) {
  for(int i = 0 ; i < NUM_SLIDER_CAMERA ;i++) {
    int offset_y = offset_y(pos.y, 0, i);
    pos_slider_camera[i] = ivec2(pos.x, offset_y);
    size_slider_camera[i] = ivec2(size);
  }
}






public void set_console_slider_item(int pos_y, ivec2 size) {
  // where the controller must display the slider
  for( int i = 0 ; i < NUM_SLIDER_ITEM_BY_COL ; i++) {
    for ( int j = 0 ; j < NUM_COL_SLIDER ; j++) {
      int whichSlider = i +(j *NUM_SLIDER_ITEM_BY_COL) ;
      int pos_x = 0 ;
      switch(j) {
        case 0 : pos_x = item_a_col; 
        break;
        case 1 : pos_x = item_b_col;
        break;
        case 2 : pos_x = item_c_col;
        break;
        case 3 : pos_x = item_d_col;
        break;
      }
      pos_slider_item[whichSlider] = ivec2(pos_x, round(pos_y +i *spacing_slider));
      size_slider_item[whichSlider] = ivec2(size);
    }
  }
}


/**
local offset for slider
*/
public int offset_y(int pos_y, int offset_title, int rank) {
  return round((pos_y+offset_title) +(rank *spacing_slider));
}



















/**
MUST BE REMOVE
*/
int height_menu_general;
int pos_y_menu_general;
int pos_y_menu_general_content;


/**
COLOUR
*/
ROPE_colour dropdown_colour;
ROPE_colour dropdown_color_item;
/**
colour structure
*/
int fill_header_struc;
int structure_background_mass_a;
int structure_background_mass_b;
int structure_background_line_a;
int structure_background_line_b;

int fill_text_title_in;
int fill_text_title_out;

int fill_info_window_rect;
int fill_info_window_text;

int fill_midi_no_selection;
int fill_midi_selection;
int fill_midi_window_no_selection;
int fill_midi_window_selection;

int struc_colour_credit_background;
int struc_colour_credit_text;
/**
colour dropdown
*/
int selected_dd_text;

int color_dd_background;

int color_dd_header_in;
int color_dd_header_out;
int color_dd_header_text_in;
int color_dd_header_text_out;

int color_dd_item_in;
int color_dd_item_out;
int color_dd_item_text_in;
int color_dd_item_text_out;

int color_dd_box_in;
int color_dd_box_out;
int color_dd_box_text_in;
int color_dd_box_text_out;
/**
colour slider light
*/
int molette_in_light;
int molette_out_light;

int adj_in_light;
int adj_out_light;

int struc_light;

int label_in_light;
int label_out_light;

/**
colour slider dark
*/
int molette_in_dark;
int molette_out_dark;

int adj_in_dark;
int adj_out_dark;

int struc_dark;

int label_in_dark;
int label_out_dark;

/**
colour slider dark
*/
int button_off_in;
int button_off_out;

int button_on_in;
int button_on_out;









/**
ITEM
*/
int NUM_ITEM;
int DIST_BETWEEN_ITEM;
int BUTTON_ITEM_CONSOLE = 4;
ivec3 [] info_button_item;
int [] info_list_item_ID; 

PImage[] OFF_in_thumbnail;
PImage[] OFF_out_thumbnail;
PImage[] ON_in_thumbnail;
PImage[] ON_out_thumbnail;

PImage[] picSetting = new PImage[4];
PImage[] picSound = new PImage[4];
PImage[] picAction = new PImage[4];

Dropdown dd_item_costume[];
Dropdown dd_item_mode[];

ivec2 size_window_ref;

//LOAD PICTURE VIGNETTE
int numVignette ;





// slider mode display
int slider_mode_display = 0 ;



/**
DROPDOWN 
*/
Dropdown dropdown_setting;
ivec2 dropdown_setting_pos;
ivec2 dropdown_setting_size;
ivec2 dropdown_pos_text;







// top
int height_button_top;
int pos_y_button_top;
int height_dropdown_top;
int pos_y_dropdown_top;

// DROPDOWN bar
int which_bg_shader, which_filter, which_font, which_text, which_bitmap, which_shape, which_movie;
Dropdown [] dropdown_bar;
ivec2 [] dropdown_bar_pos, dropdown_bar_size;
String [] font_dropdown_list, bitmap_dropdown_list, shape_dropdown_list, movie_dropdown_list, file_text_dropdown_list;
int num_dropdown_bar ;
int pos_y_dropdown_bar ;
int [] pos_x_dropdown_bar ;
int height_dropdown_header_bar ;
int [] width_dropdown_bar  ;
String [] name_dropdown_bar ;
String [][] dropdown_content;

ivec3 [] info_button_general;

// midi
PImage[] pic_midi = new PImage[4];
Button button_midi;
int sliderMidi, midi_value_romanesco, midi_channel_romanesco ;
int midi_CC_romanesco = -1 ;
boolean saveMidi ;
boolean selectMidi = false ;
int button_midi_is;
ivec2 pos_midi_button, size_midi_button;
vec2 pos_midi_info;

int spacing_midi_info;
int size_x_window_info_midi;

// Curtain
PImage[] pic_curtain = new PImage[4];
Button button_curtain;
boolean curtainOpenClose ;
int button_curtain_is;
ivec2 pos_curtain_button, size_curtain_button;

// reset camera
PImage[] pic_reset_camera = new PImage[4];
Button button_reset_camera;
int button_reset_camera_is;
ivec2 pos_reset_camera_button;
ivec2 size_reset_camera_button;

// reset coor item selected
PImage[] pic_reset_item_on = new PImage[4];
Button button_reset_item_on;
int button_reset_item_on_is;
ivec2 pos_reset_item_on_button;
ivec2 size_reset_item_on_button;

// reset fx
PImage[] pic_reset_fx = new PImage[4];
Button button_reset_fx;
int button_reset_fx_is;
ivec2 pos_reset_fx_button;
ivec2 size_reset_fx_button;

// birth
PImage[] pic_birth = new PImage[4];
Button button_birth;
int button_birth_is;
ivec2 pos_birth_button;
ivec2 size_birth_button;

// 3D
PImage[] pic_3D = new PImage[4];
Button button_3D;
int button_3D_is;
ivec2 pos_3D_button;
ivec2 size_3D_button;














// background button
Button button_bg;
int button_background_is;
ivec2 pos_button_background, size_button_background;
// background slider
Sladj [] slider_adj_background = new Sladj[NUM_SLIDER_BACKGROUND];
Cropinfo [] cropinfo_slider_background; 
int slider_width_background;
int slider_height_background;
ivec2 [] pos_slider_background = new ivec2[NUM_SLIDER_BACKGROUND]; 
ivec2 [] size_slider_background = new ivec2[NUM_SLIDER_BACKGROUND];
float [] value_slider_background = new float[NUM_SLIDER_BACKGROUND];
String[] slider_background_name = new String[NUM_SLIDER_BACKGROUND];
int offset_background_x;
int offset_background_y;

// filter button
Button [] button_fx = new Button[NUM_BUTTON_FX];
int [] button_fx_is = new int[NUM_BUTTON_FX];
ivec2 [] pos_button_fx = new ivec2[NUM_BUTTON_FX];
ivec2 [] size_button_fx = new ivec2[NUM_BUTTON_FX];
// String [] name_button_fx = new String[NUM_BUTTON_FILTER];
// filter slider
Sladj [] slider_adj_fx = new Sladj[NUM_SLIDER_FX];
Cropinfo [] cropinfo_slider_fx;
int slider_width_filter;
int slider_height_filter;
ivec2 [] pos_slider_fx = new ivec2[NUM_SLIDER_FX]; 
ivec2 [] size_slider_fx = new ivec2[NUM_SLIDER_FX];
float [] value_slider_filter = new float[NUM_SLIDER_FX];
String[] slider_filter_name = new String[NUM_SLIDER_FX];
int offset_filter_x;
int offset_filter_y;

// light button
Button button_light_ambient, button_light_ambient_action,
        button_light_1, button_light_1_action,
        button_light_2, button_light_2_action;
int light_ambient_button_is, light_ambient_action_button_is;
int light_light_1_button_is, light_light_action_1_button_is; 
int light_light_2_button_is, light_light_action_2_button_is;
ivec2 pos_light_ambient_buttonButton, size_light_ambient_buttonButton;
ivec2 pos_light_ambient_button_action, size_light_ambient_button_action; 
ivec2 pos_light_1_button_action, size_light_1_button_action;
ivec2 pos_light_1_button, size_light_1_button;
ivec2 pos_light_2_button_action, size_light_2_button_action; 
ivec2 pos_light_2_button, size_light_2_button;

// light slider
Sladj [] slider_adj_light = new Sladj[NUM_SLIDER_LIGHT];
Cropinfo [] cropinfo_slider_light;
int slider_width_light;
int slider_height_light;
ivec2 [] pos_slider_light = new ivec2[NUM_SLIDER_LIGHT]; 
ivec2 [] size_slider_light = new ivec2[NUM_SLIDER_LIGHT];
float [] value_slider_light = new float[NUM_SLIDER_LIGHT];
String[] slider_light_name = new String[NUM_SLIDER_LIGHT];
int offset_light_x;
int offset_light_y;

// sound button transient
Button [] button_transient = new Button[NUM_BUTTON_TRANSIENT];
int [] button_transient_is = new int[NUM_BUTTON_TRANSIENT];
ivec2 [] pos_button_transient = new ivec2[NUM_BUTTON_TRANSIENT];
ivec2 [] size_button_transient = new ivec2[NUM_BUTTON_TRANSIENT];


// sound slider
Sladj [] slider_adj_sound = new Sladj[NUM_SLIDER_SOUND];
Cropinfo [] cropinfo_slider_sound;
int slider_width_sound;
int slider_height_sound;
ivec2 [] pos_slider_sound = new ivec2[NUM_SLIDER_SOUND]; 
ivec2 [] size_slider_sound = new ivec2[NUM_SLIDER_SOUND];
float [] value_slider_sound = new float[NUM_SLIDER_SOUND];
String[] slider_sound_name = new String[NUM_SLIDER_SOUND];
int offset_sound_x;
int offset_sound_y;

// sound setting
Slider [] slider_sound_setting = new Slider[NUM_SLIDER_SOUND_SETTING];
Cropinfo [] cropinfo_slider_sound_setting;
int slider_width_sound_setting;
int slider_height_sound_setting;
ivec2 [] pos_slider_sound_setting = new ivec2[NUM_SLIDER_SOUND_SETTING]; 
ivec2 [] size_slider_sound_setting = new ivec2[NUM_SLIDER_SOUND_SETTING];
float [] value_slider_sound_setting = new float[NUM_MOLETTE_SOUND_SETTING];
String[] slider_sound_setting_name = new String[NUM_SLIDER_SOUND_SETTING];
int offset_sound_setting_x;
int offset_sound_setting_y;

// camera slider
Sladj [] slider_adj_camera = new Sladj[NUM_SLIDER_CAMERA];
Cropinfo [] cropinfo_slider_camera;
int slider_width_camera;
int slider_height_camera;
ivec2 [] pos_slider_camera = new ivec2[NUM_SLIDER_CAMERA]; 
ivec2 [] size_slider_camera = new ivec2[NUM_SLIDER_CAMERA];
float [] value_slider_camera = new float[NUM_SLIDER_CAMERA];
String[] slider_camera_name = new String[NUM_SLIDER_CAMERA];
int offset_camera_x;
int offset_camera_y;

// item button
int local_pos_y_button_item;
int height_item_button_console;
// item dropdown 
int local_pos_y_dropdown_item;
String [] list_item_mode;
String [] list_item_costume;
// item slider
Sladj [] slider_adj_item = new Sladj[NUM_SLIDER_ITEM];
Cropinfo [] cropinfo_slider_item;
int slider_width_item;
int slider_height_item;
ivec2 [] pos_slider_item = new ivec2[NUM_SLIDER_ITEM]; 
ivec2 [] size_slider_item = new ivec2[NUM_SLIDER_ITEM];
float [] value_slider_item = new float[NUM_SLIDER_ITEM];
String [] slider_item_name = new String[NUM_SLIDER_ITEM];
int local_pos_y_slider_item;
int pos_y_item_selected;
int height_item_selected;
int offset_x_item;
int item_a_col;
int item_b_col;
int item_c_col;
int item_d_col;

// inventory
int pos_y_inventory;
int height_inventory;






/**
MISC var
*/
float ratio_size_molette ; 

int col_width ;
int spacing_slider ;
int rounded_slider ;
// the position is calculated in ratio of the slider position. Not optimize for the vertical slider
float ratio_pos_slider_adjustable ; 
// the height size is calculated in ratio of the slider height size.  Not optimize for the vertical slider
float ratio_size_slider_adjustable ; 

// vertical grid
int marge;
int [] grid_col;

// this not a position but the height of the rectangle
int height_header;





// button slider
int sizeTitleButton;

/**
DROPDOWN
*/
int height_box_dropdown;








/**
update, display and design
v 0.0.6
2018-2018
*/

/**
STRUCTURE DISPLAY
*/
int thickness_line_deco = 2 ;
public void display_structure() {
  // check event for structure
  if(button_curtain_is == 1) {
    set_colour_structure_background_mass(r.GRENAT_PROFOND,r.BLOOD);
  } else {
    set_colour_structure_background_mass(r.GRAY_1,r.GRAY_3);
  }



  // display
  noStroke();
  ivec2 pos = ivec2(0,0);
  ivec2 size = ivec2(width, height_header);
  display_structure_header(pos,size, fill_header_struc);

  pos.set(0,pos_y_button_top);
  size.set(width,height_button_top);
  display_structure_top_button(pos,size,structure_background_mass_a,structure_background_line_a);

  pos.set(0,pos_y_dropdown_top);
  size.set(width, height_dropdown_top);
  display_structure_dropdown_menu_general(pos,size,structure_background_mass_a,structure_background_line_a);

  pos.set(0,pos_y_menu_general);
  size.set(width,height_menu_general);
  display_structure_general(pos,size,structure_background_mass_a,structure_background_mass_b);
  
  pos.set(0,pos_y_item_selected);
  size.set(width, height_item_selected);
  display_structure_item_selected(pos,size,structure_background_mass_a,structure_background_line_a);

  pos.set(0,pos_y_inventory);
  size.set(width, height);
  display_structure_inventory_item(pos,size,structure_background_mass_a,structure_background_mass_b);

  display_structure_bottom(structure_background_line_a,structure_background_line_b);
}




public void display_structure_header(ivec2 pos, ivec2 size, int colour_bg) {
  fill(colour_bg); 
  rect(pos,size);
}

public void display_structure_top_button(ivec2 pos, ivec2 size, int colour_bg, int colour_line) {
  fill(colour_bg); 
  rect(pos,size); 

  fill(colour_line) ;
  rect(pos.x,pos.y,size.x,thickness_line_deco) ;
}

public void display_structure_dropdown_menu_general(ivec2 pos, ivec2 size, int colour_bg, int colour_line) {
  fill(colour_bg); 
  rect(pos,size);
  // decoration 
  fill (colour_line) ;
  rect(pos.x,pos.y,size.x,thickness_line_deco) ;
}

public void display_structure_general(ivec2 pos, ivec2 size, int colour_bg, int colour_line) {
  fill(colour_bg); 
  rect(pos,size);
}

public void display_structure_menu_sound(ivec2 pos, ivec2 size, int colour_bg, int colour_line) {
  fill(colour_bg) ;
  rect(pos,size); 
  // decoration
  fill(colour_line);
  rect(pos.x,pos.y,size.x,thickness_line_deco); 
}

public void display_structure_item_selected(ivec2 pos, ivec2 size, int colour_bg, int colour_line) {
  fill(colour_bg);
  rect(pos,size); 
  // decoration
  fill(colour_line);
  rect(pos.x,pos.y,size.x,thickness_line_deco); 
}

public void display_structure_inventory_item(ivec2 pos, ivec2 size, int colour_bg, int colour_line) {
  fill(colour_bg);
  rect(pos,size); 
}


public void display_structure_bottom(int colour_a, int colour_b) {
  fill(colour_a);
  rect(0,height-9,width,2);
  fill(colour_b);
  rect(0,height-7,width,7);
}


public void show_misc_text() {
  if(insideNameversion) fill (fill_text_title_in) ; else fill(fill_text_title_out) ;
  int posTextY = 18 ;
  textFont(FuturaStencil_20,16); 
  text(nameVersion,5,posTextY);
  //CLOCK
  fill(fill_text_title_out); 
  textFont(FuturaStencil_20,16); 
  textAlign(RIGHT);
  text(nf(hour(),2)   + ":" +nf(minute(),2) , width -10, posTextY);
}





















/**
DROPDOWN UPDATE and DISPLAY
*/
/**
display
*/
public void show_dropdown() {
  update_dropdown_bar_content() ;
  
  for(int i = 0 ; i < dropdown_bar.length ; i++) {
    if(i == 1) {
      //
    }
    dropdown_bar[i].set_content(dropdown_content[i]);
  }

  update_dropdown(dropdown_setting);
  update_dropdown(dropdown_bar);

  // item
  update_dropdown_item() ;
  
  which_bg_shader = dropdown_bar[0].get_selection();
  which_filter = dropdown_bar[1].get_selection();
  which_font = dropdown_bar[2].get_selection();
  which_text = dropdown_bar[3].get_selection();
  which_bitmap = dropdown_bar[4].get_selection();
  which_shape = dropdown_bar[5].get_selection();
  which_movie = dropdown_bar[6].get_selection();  
}

/**
update
*/
public void update_dropdown(Dropdown... dd) {
  for(int i = 0 ; i < dd.length ; i++) {
    dd[i].update(mouseX,mouseY);
    dd[i].show_header_text();
    dd[i].show_box();
    dd[i].show_selection(dd[i].get_pos().x +3 , dd[i].get_pos().y +22);
  }
}

public void update_dropdown_bar_content() {
  dropdown_content [0] = shader_bg_name;
  dropdown_content [1] = shader_fx_name;
  dropdown_content [2] = font_dropdown_list;
  dropdown_content [3] = file_text_dropdown_list;
  
  dropdown_content [4] = bitmap_dropdown_list;
  dropdown_content [5] = shape_dropdown_list;
  dropdown_content [6] = movie_dropdown_list;
}


public void update_dropdown_item() {
  int pointer = 0 ;
  ivec2 offset_selection = ivec2(18,8);
  for (int i = 1 ; i <= NUM_ITEM ; i++) {
    update_dropdown_item(dd_item_costume, list_item_costume, inventory, i,offset_selection, pointer);
    update_dropdown_item(dd_item_mode, list_item_mode, inventory, i,offset_selection,pointer);
    show_dropdown_box_item(dd_item_costume, list_item_costume, inventory, i,offset_selection, pointer);
    show_dropdown_box_item(dd_item_mode, list_item_mode, inventory, i,offset_selection,pointer);
    if(inventory[i].is()) pointer++;
  }
}

public void update_dropdown_item(Dropdown [] dd, String [] list, Inventory [] inventory, int index, ivec2 offset, int pointer) {
  if(inventory[index].is()) {
    int distance = pointer *DIST_BETWEEN_ITEM;
    dd[index].offset(distance, 0);
    String boxes[] = split(list[index],"/");
    if (boxes.length > 1) {
      if(dropdown_is() && dd[index].locked_is()) {
        dd[index].update(mouseX,mouseY); 
      } else if(!dropdown_is()) {
        dd[index].update(mouseX,mouseY); 
      }
    }
    // display which element is selected
    if (dd[index].get_selection() > -1 && boxes.length > 1) {
      int selection = dd[index].get_selection() +1;
      String name = dd[index].get_name() + " " + selection;
      dd[index].show_header_text(name);  
    } else {
      fill(r.GRAY_3);
      ivec2 pos = dd[index].get_pos().add(dd[index].get_header_text_pos());
      PFont font = dd[index].get_font();
      textFont(font);
      text(dd[index].get_name(),pos);
    }     
  }
}


public void show_dropdown_box_item(Dropdown [] dd, String [] list, Inventory [] inventory, int index, ivec2 offset, int pointer) {
  if(inventory[index].is()) {
    int distance = pointer *DIST_BETWEEN_ITEM;
    dd[index].offset(distance, 0);
    String boxes[] = split(list[index],"/");
    if (boxes.length > 1) {
      // dd[index].update(mouseX,mouseY); 
      dd[index].show_box();
    } 
  }
}





















/**
SLIDER UPDATE and DISPLAY
*/
public void show_slider_controller() {
  show_slider_background();
  show_slider_filter();
  show_slider_light();
  show_slider_sound();
  if(dropdown_setting.get_selection() == 0) {
    show_slider_sound_setting();
  } else if (dropdown_setting.get_selection() == 1) {
    show_slider_camera();
  }

  pass_slider_general_to_osc();

  show_slider_item();
}









/**
manageslider part
*/
boolean slider_already_used;
public void slider_already_used(boolean state) {
  slider_already_used = state;
}

public boolean slider_already_used_is() {
  return slider_already_used;
}

int dna_gui_processing;
public void set_dna_gui_processing(int dna) {
  dna_gui_processing = dna;
}

public int get_dna_gui_processing() {
  return dna_gui_processing;
}














public void update_slider(Slider slider, Cropinfo [] info_slider) {
  update_midi_slider(slider,info_slider);

  //check
  if(slider instanceof Sladj) {
    Sladj sladj = (Sladj)slider;
    boolean state = false ;
    for(int i = 0 ; i < sladj.molette.length ; i++) {
      if(sladj.molette[i].used_is || sladj.molette[i].inside_is) {
        state = true;
        break;
      }
    }

    if(!state) {
      // min molette
      if(!sladj.inside_max() && !sladj.locked_max_is()) {
        sladj.inside_min();
        sladj.select_min(shift_key);
        sladj.update_min();
      }
      // max molette
      if(!sladj.inside_min() && !sladj.locked_min_is()) {
        sladj.inside_max();
        sladj.select_max(shift_key);
        sladj.update_max();
      }
    }
    // update 
    sladj.update_min_max();
  } else {
    slider.inside_molette_ellipse();
  }
  
  // multislider case
  boolean add_slider_to_selection = false;
  if(keyPressed && key == CODED && keyCode == SHIFT) {
    slider_already_used(false);
    add_slider_to_selection = true;
  }
  
  // single slider case
  if(slider.molette_inside_is() && !add_slider_to_selection && !slider_already_used_is()) {
    set_dna_gui_processing(slider.get_dna()); // dna id to securise for the only gui using
    slider_already_used(true);
  }
  

  // update the active slider
  if(add_slider_to_selection || slider.get_dna() == get_dna_gui_processing() || !slider_already_used_is()) {
    slider.update(mouseX,mouseY);
  }

  if(add_slider_to_selection) {
    slider.keep_selection(true);
    slider.select(true);
  } else if(slider_already_used_is()) {
    if(slider.get_dna() == get_dna_gui_processing()) {
      slider.keep_selection(true);
    } else {
      slider.keep_selection(false);
    }
    slider.select(true);
  } else {
    slider.keep_selection(false);
    slider.select(false);
  }
}




// SLIDER DRAW
public void show_slider_background() {
  boolean show_is = false;
  if(!dropdown_is()) {
    show_is = show_slider_structure_colour(pos_slider_background, size_slider_background, value_slider_background);
  }
  for (int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_adj_background[i],cropinfo_slider_background);
    }
    if(!show_is || i >= 3 ) slider_adj_background[i].show_structure();
    slider_adj_background[i].show_adj();
    slider_adj_background[i].show_molette();
    slider_adj_background[i].show_label();
  }
}

public void show_slider_filter() {
  for (int i = 0 ; i < NUM_SLIDER_FX ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_adj_fx[i],cropinfo_slider_fx);
    }    
    slider_adj_fx[i].show_structure();
    slider_adj_fx[i].show_adj();
    slider_adj_fx[i].show_molette();
    slider_adj_fx[i].show_label();
  }
}

public void show_slider_light() {
  boolean [] is = new boolean[3];
  if(!dropdown_is()) {
    is[0] = slider_light_0_show_structure_colour();
    is[1] = slider_light_1_show_structure_colour();
    is[2] = slider_light_2_show_structure_colour();
  }


  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_adj_light[i],cropinfo_slider_light);
    }   
    boolean show_is = false;
    for(int k = 0 ; k < is.length ; k++) {
      if(!is[k]) {
        int num_special_slider = 3;
        for(int m = 0 ; m < num_special_slider ; m++) {
          if(i == k*num_special_slider+m) {
            show_is = true;
            break;
          }
        }
      }
    }  
    if(show_is) slider_adj_light[i].show_structure();
    slider_adj_light[i].show_adj();
    slider_adj_light[i].show_molette();
    slider_adj_light[i].show_label();
  }
}

public void show_slider_sound() {
  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_adj_sound[i],cropinfo_slider_sound);
    }   
    slider_adj_sound[i].show_structure();
    slider_adj_sound[i].show_adj();
    slider_adj_sound[i].show_molette();
    slider_adj_sound[i].show_label();
  }
}

public void show_slider_sound_setting() {
  int rank = 0;
  for (int i = 0 ; i < NUM_SLIDER_SOUND_SETTING ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_sound_setting[i],cropinfo_slider_sound_setting);
    }
    rank += slider_sound_setting[i].get().length;

    slider_sound_setting[i].show_structure();
    slider_sound_setting[i].show_molette();
    slider_sound_setting[i].show_label();
  }
}

public void show_slider_camera() {
  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {
    if(!dropdown_is()) {
      update_slider(slider_adj_camera[i],cropinfo_slider_camera);
    }    
    slider_adj_camera[i].show_structure();
    slider_adj_camera[i].show_adj();
    slider_adj_camera[i].show_molette();
    slider_adj_camera[i].show_label();  
  }
}

public void pass_slider_general_to_osc() {
  for (int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    pass_slider_to_osc_arg(slider_adj_background[i], value_slider_background);
  }

  for (int i = 0 ; i < NUM_SLIDER_FX ; i++) {    
    pass_slider_to_osc_arg(slider_adj_fx[i], value_slider_filter);
  }

  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) { 
    pass_slider_to_osc_arg(slider_adj_light[i],value_slider_light);
  }

  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {   
    pass_slider_to_osc_arg(slider_adj_sound[i],value_slider_sound);
  }
  
  int rank = 0;
  for (int i = 0 ; i < NUM_SLIDER_SOUND_SETTING ; i++) {
    pass_multi_slider_to_osc_arg(slider_sound_setting[i],value_slider_sound_setting,rank);
    rank += slider_sound_setting[i].get().length;
  }

  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {   
    pass_slider_to_osc_arg(slider_adj_camera[i],value_slider_camera);  
  }
}







// Slider display for the global slider background, camera, light, sound....
/*
When you add a new sliders, you must change the starting value from 'NAN' to a value between 0 and 1 in the file 'defaultSetting.csv' in the 'preferences/setting' folder.
And you must add the name of this one in the 'preferences/'  folder slider_name_en.csv' and in the 'slider_name_fr' file
*/
public boolean slider_light_0_show_structure_colour() {
  int start = 0;
  int length = 3 ;
  ivec2 [] pos = new ivec2[length];
  ivec2 [] size = new ivec2[length];
  float [] value = new float[length];
  System.arraycopy(pos_slider_light,start,pos,0,length);
  System.arraycopy(size_slider_light,start,size,0,length);
  System.arraycopy(value_slider_light,start,value,0,length);
  return show_slider_structure_colour(pos, size, value);
}

public boolean slider_light_1_show_structure_colour() {
  int start = 3 ;
  int length = 3 ;
  ivec2 [] pos = new ivec2[length];
  ivec2 [] size = new ivec2[length];
  float [] value = new float[length];
  System.arraycopy(pos_slider_light,start,pos,0,length);
  System.arraycopy(size_slider_light,start,size,0,length);
  System.arraycopy(value_slider_light,start,value,0,length);
  return show_slider_structure_colour(pos, size, value);
}

public boolean slider_light_2_show_structure_colour() {
  int start = 6 ;
  int length = 3 ;
  ivec2 [] pos = new ivec2[length];
  ivec2 [] size = new ivec2[length];
  float [] value = new float[length];
  System.arraycopy(pos_slider_light,start,pos,0,length);
  System.arraycopy(size_slider_light,start,size,0,length);
  System.arraycopy(value_slider_light,start,value,0,length);
  return show_slider_structure_colour(pos, size, value);
}




// supra local void
public boolean show_slider_structure_colour(ivec2 [] pos, ivec2 [] size, float [] value) {
  if (mouseX > (pos[0].x ) && mouseX < ( pos[0].x +size[0].x) 
      && mouseY > ( pos[0].y - 5) && mouseY < pos[0].y +40) {
    show_slider_hue_structure(pos[0], size[0]) ;
    show_slider_saturation_structure(pos[1],size[1],value[0],value[1],value[2]);
    show_slider_brightness_structure(pos[2],size[2],value[0],value[1],value[2]);
    return true;
  } else {
    return false;
  }
}


/**
Item
*/
/*
When you add a new sliders, you must change the starting value from 'NAN' to a value between 0 and 1 in the file 'defaultSetting.csv' in the 'preferences/setting' folder.
And you must add the name of this one in the 'preferences/'  folder slider_name_en.csv' and in the 'slider_name_fr' file
*/
public void show_slider_item() {
  boolean [] is = new boolean[2];
  if(!show_all_slider_item) {
    if(!dropdown_is()) {
      is[0] = show_slider_item_colour(hue_fill_rank, sat_fill_rank, bright_fill_rank); // fill
      is[1] = show_slider_item_colour(hue_stroke_rank, sat_stroke_rank, bright_stroke_rank); // stroke
    }
    for (int i = 1 ; i <= NUM_ITEM ; i++) {
      if (item_active[i]) {
        if (item_group[i] == 1) { 
          for(int k = 0 ; k < NUM_SLIDER_ITEM ; k++) {
            if (display_slider[k]) {
              show_slider(k,is);
            }
          }
        }
      }
    }
  } else {
    if(!dropdown_is()) {
      is[0] = show_slider_item_colour(hue_fill_rank, sat_fill_rank, bright_fill_rank); // fill
      is[1] = show_slider_item_colour(hue_stroke_rank, sat_stroke_rank, bright_stroke_rank); // stroke
    }
    for(int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
      show_slider(i,is);
    }
  } 
}


public void show_slider(int index, boolean [] is) {
  if(!dropdown_is()) {
    update_slider(slider_adj_item[index],cropinfo_slider_item);
  }
  pass_slider_to_osc_arg(slider_adj_item[index],value_slider_item);
  boolean show_is = false ;
  for(int k = 0 ; k < is.length ;k++) {
    if(!is[k]) {
      int num_special_slider = 3;
      int step = 4 ;
      for(int m = 0 ; m < num_special_slider ; m++) {    
        if(index == k* step +m || index == 3 || index > 6) {
          show_is = true;
          break;
        } 
      }
    }
  }
  if(show_is) {
    slider_adj_item[index].show_structure();
  }
  slider_adj_item[index].show_adj();
  slider_adj_item[index].show_molette();
  slider_adj_item[index].show_label();
}





// local void to display the HSB slider and display the specific color of this one
public boolean show_slider_item_colour(int hueRank, int satRank, int brightRank) {
  boolean is = (mouseX > (pos_slider_item[hueRank].x ) 
                        && mouseX < (pos_slider_item[hueRank].x +size_slider_item[hueRank].x) 
                        && mouseY > (pos_slider_item[hueRank].y - 5) 
                        && mouseY < pos_slider_item[hueRank].y +30);

  if (is) {
    if (display_slider[hueRank]) show_slider_hue_structure(pos_slider_item[hueRank], size_slider_item[hueRank]) ; 
    if (display_slider[satRank]) show_slider_saturation_structure(pos_slider_item[satRank], size_slider_item[satRank], value_slider_item[hueRank], value_slider_item[satRank], value_slider_item[brightRank]) ;
    if (display_slider[brightRank]) show_slider_brightness_structure(pos_slider_item[brightRank], size_slider_item[brightRank], value_slider_item[hueRank], value_slider_item[satRank], value_slider_item[brightRank]) ;
    
  } 
  return is;
}





/**
display item info
*/
public void item_thumbnail_info(ivec2 pos, ivec2 size, int IDorder, int IDfamily) {
  if (mouseX > pos.x && mouseX < (size.x + pos.x ) && mouseY > pos.y - 10 && mouseY <  (size.y + pos.y) -20 ) {
    ivec2 fontPos = ivec2(-10, -20 ) ; 
    if (NUM_ITEM > 0 ) {
      display_info_item(IDorder, fontPos) ;
    }
  }
}

public void display_info_item(int IDorder, ivec2 pos) {
  int whichLine = 0 ;
  int num = inventory_item_table.getRowCount() ;
  for ( int j = 0 ; j < num ; j++) {
    TableRow lookFor = inventory_item_table.getRow(j);
    int ID = lookFor.getInt("ID") ;
    if ( ID == IDorder ) {
      whichLine = j ;
    }
  }
  TableRow displayInfo = inventory_item_table.getRow(whichLine) ;
  int num_line = 4 ;
  String [] text = new String[num_line] ;
  int [] size_text = new int[num_line] ;
  text[0] = displayInfo.getString("Name") ;
  text[1] = displayInfo.getString("Author") ;
  text[2] = displayInfo.getString("Version") ;
  text[3] = displayInfo.getString("Pack") ;
  size_text [0] = 20 ;
  size_text [1] = 15 ;
  size_text [2] = 10 ;
  size_text [3] = 10 ;

  // background window
  int pos_correction_y = -30 ;
  vec2 pos_window = vec2(pos.x +mouseX , pos.y + mouseY +pos_correction_y) ;
  vec2 ratio_size = vec2( 1.4f, 1.3f) ;
  int speed = 7 ;
  int size_angle = 2 ;
  fill(fill_info_window_rect,150);
  vec2 range_check = vec2(0,1) ;
  background_text_list(vec2(pos_window.x +2, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check,FuturaStencil_20) ;


  // text
  fill(fill_info_window_text);  
  textSize(size_text[0]);
  textFont(FuturaStencil_20);
  text(text[0], pos_window.x, pos_window.y +5);
  textSize(size_text[1]);
  text(text[1], pos_window.x, pos_window.y +20);
  textSize(size_text[2]);
  text(text[2], pos_window.x, pos_window.y +30);
  text(text[3], pos_window.x, pos_window.y +40);
}

public void background_text_list(vec2 pos, String [] list, int [] size_text, int size_angle, int speed_rotation, vec2 ratio_size, vec2 start_end, PFont font) {
  // create the starting point of the shape
  pos = vec2(pos.x -(size_text[0] *.5f), pos.y -size_text[0]) ;

  // spacing
  float spacing = 0;
  for(int i = 0 ; i < size_text.length ; i++) {
    spacing += size_text[i];
  }
  spacing /= size_text.length;
  spacing *= ratio_size.y;

  //define the size of the background
  int start_point_list = PApplet.parseInt(start_end.x);
  int end_point_list = PApplet.parseInt(start_end.y);
  
  int size_word = PApplet.parseInt(longest_String_pixel(font,list, size_text, start_point_list, end_point_list));
  float width_rect =  size_word *ratio_size.x;
  int height_rect = list.length *(int)spacing;
  
  // create the point to build the background

  vec2 a = vec2(pos.x + 0,pos.y + 0);
  vec2 b = vec2(pos.x + width_rect, pos.y + 0);
  vec2 c = vec2(pos.x + width_rect, pos.y + height_rect);
  vec2 d = vec2(pos.x + 0, pos.y + height_rect);
  
  // display background
  beginShape();
  vertex(a);
  vertex(b);
  vertex(c);
  vertex(d);
  endShape(CLOSE);
}




















/**
slider method
*/

// hue
public void show_slider_hue_structure(ivec2 pos, ivec2 size) {
  pushMatrix();
  translate (pos.x , pos.y -(size.y *.5f));
  for (int i = 0 ; i < size.x ; i++) {
    for (int j = 0 ; j <= size.y ; j++) {
      float cr = map(i,0,size.x,0,360);
      fill(cr,100,100);
      rect(i,j,1,1);
    }
  }
  popMatrix();
}

// saturation
public void show_slider_saturation_structure(ivec2 pos, ivec2 size, float colour, float s, float d) {
  pushMatrix ();
  translate (pos.x, pos.y-(size.y *.5f));
  for ( int i = 0 ; i < size.x ; i++) {
    for ( int j = 0 ; j <=size.y ; j++) {
      float cr = map(i,0,size.x,0,100);
      float dens = map(d,0,size.x,0,100);
      fill (colour,cr,dens);
      rect (i,j,1,1);
    }
  }
  popMatrix();
}

// brightness
public void show_slider_brightness_structure(ivec2 pos, ivec2 size, float colour, float s, float d) {
  pushMatrix ();
  translate (pos.x, pos.y-(size.y *.5f));
  for (int i = 0 ; i < size.x ; i++) {
    for (int j = 0 ; j <= size.y ; j++) {
      float cr = map(i,0,size.x,0,100);
      float sat = map(s,0,size.x,0,100);
      fill (colour, sat, cr) ;
      rect (i,j,1,1) ;
    }
  }
  popMatrix() ;
}





/**
pass info for OSC
*/
public void pass_slider_to_osc_arg(Slider slider, float [] value_slider) {
  int valueMax = 360;
  float val_single_slider = slider.get(0);
  value_slider[slider.get_id()] = constrain(map(val_single_slider,0,1,0,valueMax),0,valueMax);
}



public void pass_multi_slider_to_osc_arg(Slider slider, float [] value_slider, int rank) {
  int valueMax = 360;
  for(int i = 0 ; i < slider.get().length ; i++) {
    float value = slider.get(i);
    value_slider[rank] = constrain(map(value,0,1,0,valueMax),0,valueMax);
    rank++;
  } 
}



































/**
BUTTON
*/
/**
init
*/
public void init_button_general() {
  button_general_num = 20;
  value_button_general = new int[button_general_num];
}
/**
check button
*/
public void check_button() {
  check_button_general() ;
  check_button_item_console() ;
  check_button_inventory() ;
}

public void check_button_general() {
  /* Check to send by OSC to Scene and Prescene */
  if(button_bg.is()) button_background_is = 1 ; else button_background_is = 0 ;
  // FX
  for(int i = 0 ; i < NUM_BUTTON_FX ; i++) {
    if(button_fx[i].is()) button_fx_is[i] = 1 ; else button_fx_is[i] = 0 ;
  }
  //LIGHT ONE
  if(button_light_ambient.is()) light_ambient_button_is = 1; 
  else  light_ambient_button_is = 0;
  if(button_light_ambient_action.is()) light_ambient_action_button_is = 1; 
  else light_ambient_action_button_is =  0;
  //LIGHT ONE
  if(button_light_1.is()) light_light_1_button_is = 1; 
  else light_light_1_button_is = 0;

  if(button_light_1_action.is()) light_light_action_1_button_is = 1;
   else light_light_action_1_button_is = 0;
  // LIGHT TWO
  if(button_light_2.is()) light_light_2_button_is = 1; 
  else light_light_2_button_is = 0;
  if(button_light_2_action.is()) light_light_action_2_button_is = 1; 
  else light_light_action_2_button_is = 0;
  //SOUND
  for(int i = 0 ; i < NUM_BUTTON_TRANSIENT ; i++) {
    if(button_transient[i].is()) button_transient_is[i] = 1; 
    else button_transient_is[i] = 0;
  }
  //Check position of button
  if(button_curtain.is()) button_curtain_is = 1; 
  else button_curtain_is = 0;

  if(button_midi.is()) button_midi_is = 1; 
  else button_midi_is = 0;
  // reset button
  if(button_reset_camera.is()) button_reset_camera_is = 1; 
  else button_reset_camera_is = 0;

  // misc item button
  if(button_reset_item_on.is()) button_reset_item_on_is = 1; 
  else button_reset_item_on_is = 0;

  if(button_reset_fx.is()) button_reset_fx_is = 1; 
  else button_reset_fx_is = 0;

  if(button_birth.is()) button_birth_is = 1; 
  else button_birth_is = 0;

  if(button_3D.is()) button_3D_is = 1; 
  else button_3D_is = 0;

}


/**
mouse pressed
*/
public void mousePressed_button_general() {
  if(button_bg.inside()) button_bg.switch_is();

  for(int i = 0 ; i < NUM_BUTTON_FX ; i++) {
    if(button_fx[i].inside()) button_fx[i].switch_is();
  }

  if(button_light_ambient.inside()) button_light_ambient.switch_is();
  if(button_light_ambient_action.inside()) button_light_ambient_action.switch_is();

  if(button_light_1.inside()) button_light_1.switch_is();
  if(button_light_1_action.inside()) button_light_1_action.switch_is();

  if(button_light_2.inside()) button_light_2.switch_is();
  if(button_light_2_action.inside()) button_light_2_action.switch_is();
  
  for(int i = 0 ; i < NUM_BUTTON_TRANSIENT ; i++) {
    if(button_transient[i].inside()) button_transient[i].switch_is();
  }
  if(button_midi.inside()) button_midi.switch_is();
  if(button_curtain.inside()) button_curtain.switch_is();
  // reset button
  if(button_reset_camera.inside()) button_reset_camera.switch_is();
  // item action
  if(button_reset_item_on.inside()) button_reset_item_on.switch_is();
  if(button_reset_fx.inside()) button_reset_fx.switch_is();
  if(button_birth.inside()) button_birth.switch_is();
  if(button_3D.inside())button_3D.switch_is();
}




/**
display
*/
public void show_button() {
  display_button_general();
  if(change_size_window_is()) {
    display_button_item_console(true);
    change_size_window(false);
  } else {
    display_button_item_console(false);
  }
  display_button_inventory();
  display_button_header();
}


public void display_button_header() {
  // background window
  vec2 pos_window = vec2(mouseX , mouseY -20);
  vec2 ratio_size = vec2(1.6f, 1.3f);
  int speed = 7;
  int size_angle = 2;
  vec2 range_check = vec2(0,0);
  String [] text = new String[1];
  int [] size_text = new int[1];
  size_text [0] = 20 ;
  textFont(FuturaStencil_20);

  noStroke();
  int alpha_bg_rollover = PApplet.parseInt(g.colorModeA *.8f);

  if(button_curtain.inside()) {
    text[0] = ("CUT") ;
    noStroke() ;
    fill(fill_info_window_rect, alpha_bg_rollover) ;
    background_text_list(vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size,range_check,FuturaStencil_20);
    fill(fill_info_window_text);
    text(text [0], pos_window.x, pos_window.y);
  }

  if(button_midi.inside()) {
    text[0] = ("MIDI");
    fill(fill_info_window_rect, alpha_bg_rollover);
    background_text_list(vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check, FuturaStencil_20);
    fill(fill_info_window_text);
    text(text[0],pos_window.x, pos_window.y);
  }


  if(button_reset_camera.inside()) {
    text[0] = ("RESET CAMERA");
    fill(fill_info_window_rect, alpha_bg_rollover);
    background_text_list(vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check, FuturaStencil_20);
    fill(fill_info_window_text);
    text(text[0],pos_window.x, pos_window.y);
  }

  if(button_reset_item_on.inside()) {
    text[0] = ("RESET COORD ITEM ON");
    fill(fill_info_window_rect, alpha_bg_rollover);
    background_text_list(vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check, FuturaStencil_20);
    fill(fill_info_window_text);
    text(text[0],pos_window.x, pos_window.y);
  }

  if(button_reset_fx.inside()) {
    text[0] = ("RESET FX LIST");
    fill(fill_info_window_rect, alpha_bg_rollover);
    background_text_list(vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check, FuturaStencil_20);
    fill(fill_info_window_text);
    text(text[0],pos_window.x, pos_window.y);
  }

  if(button_birth.inside()) {
    text[0] = ("BIRTH");
    fill(fill_info_window_rect, alpha_bg_rollover);
    background_text_list(vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check, FuturaStencil_20);
    fill(fill_info_window_text);
    text(text[0],pos_window.x, pos_window.y);
  }

  if(button_3D.inside()) {
    text[0] = ("3 DIMENSIONS");
    fill(fill_info_window_rect, alpha_bg_rollover);
    background_text_list(vec2(pos_window.x, pos_window.y), text, size_text, size_angle, speed, ratio_size, range_check, FuturaStencil_20);
    fill(fill_info_window_text);
    text(text[0],pos_window.x, pos_window.y);
  }
}



public void display_button_general() {
    if(button_bg.is()) {
    button_bg.set_label("BACKGROUND ON");
    // button_bg.set_label(shader_bg_name[which_bg_shader] + " on");
  } else {
    button_bg.set_label("BACKGROUND OFF");
    // button_bg.set_label(shader_bg_name[which_bg_shader] + " off");
  }
  button_bg.show_label();

  // FX
  if(button_fx[0].is()) {
    button_fx[0].set_label("FX ON");
  } else {
    button_fx[0].set_label("FX OFF");
  }
  for(int i = 0 ; i < NUM_BUTTON_FX ; i++) {
    button_fx[i].show_label();
  }

  // Light ambient
  if(button_light_ambient.is()) {
    button_light_ambient.set_label("AMBIENT ON");
  } else {
    button_light_ambient.set_label("AMBIENT OFF");
  }
  button_light_ambient.show_label();
  button_light_ambient_action.show_label();
  //LIGHT ONE
  if(button_light_1.is()) {
    button_light_1.set_label("LIGHT ONE ON");
  } else {
    button_light_1.set_label("LIGHT ONE OFF");
  }
  button_light_1.show_label();
  button_light_1_action.show_label();
  // LIGHT TWO
  if(button_light_2.is()) {
    button_light_2.set_label("LIGHT TWO ON");
  } else {
    button_light_2.set_label("LIGHT TWO OFF");
  }
  button_light_2.show_label();
  button_light_2_action.show_label();
  
  // SOUND
  for(int i = 0 ; i < NUM_BUTTON_TRANSIENT ; i++) {
    button_transient[i].show_label();
  }
  //MIDI / CURTAIN
  button_curtain.show_picto(pic_curtain);
  // RESET
  button_reset_camera.show_picto(pic_reset_camera);
  button_reset_item_on.show_picto(pic_reset_item_on);
  button_reset_fx.show_picto(pic_reset_fx);
  // MISC
  button_birth.show_picto(pic_birth);
  button_3D.show_picto(pic_3D);
  // 
  button_midi.show_picto(pic_midi);

}


/**
update
*/
public void update_button() {
  update_button_general();
  update_button_inventory();
}

public void update_button_general() {
  // button on the top
  update_button_local(button_curtain,button_reset_camera,button_reset_item_on,button_reset_fx,button_birth,button_3D);
  update_button_local(button_midi);
  // button on the middle
  update_button_local(button_bg,
                      button_light_ambient,button_light_ambient_action,
                      button_light_1,button_light_1_action,
                      button_light_2,button_light_2_action);
  update_button_local(button_fx);
  update_button_local(button_transient);
}

public void update_button_local(Button... b) {
  for(int i = 0 ; i < b.length ; i++) {
    b[i].update(mouseX,mouseY,dropdown_is());
  }
}
/**
LOAD 
v 2.9.0
2013-2019
*/
public void load_setup() {
  load_save(preference_path+"setting/defaultSetting.csv");
}


public void load_autosave() {
  load_save(autosave_path);
}


public void load_save(String path) {
  set_data_save_setting() ;
  load_data_GUI(path) ;
  load_saved_file_controller(path) ;
  apply_text_gui() ;

}






// LOAD INFO OBJECT from the PRESCENE

Table inventory_item_table;
Table shader_background_table;
Table shader_fx_table;
int numGroup []; 
int [] item_rank, item_ID, item_group, item_camera_video_on_off, item_GUI_on_off;
String [] item_info, item_info_raw;
String [] item_name, item_author, item_version, item_pack, item_load_name, item_slider; 

String [] shader_bg_name, shader_bg_author;
String [] shader_fx_name, shader_fx_author;

//BUTTON

int button_general_num;

int [] value_button_general; 


//Variable must be send to Scene
// statement on_off for the item group
int button_item_num;
boolean [] item_button_state;
int num_dd_item;
int [] value_button_item;
int [] pos_button_width_item, pos_button_height_item, width_button_item, height_button_item ;




Inventory [] inventory ;

class Inventory {
  String name = "" ;
  boolean is = false ;
  Inventory(String name, boolean is) {
    this.name = name ;
    this.is = is;
  }

  public boolean is() {
    return is;
  }

  public void set_is(boolean is) {
    this.is = is;
  }

  public String get_name() {
    return name;
  }
}



















/**
SETTING INFO BUTTON AND SLIDER
*/
public void load_data_GUI(String path) {
  Table table = loadTable(path, "header");
  // create the var info for the slider we need
  int count_slider_background = 0;
  int count_slider_fx = 0;
  int count_slider_light = 0;
  int count_slider_sound = 0;
  int count_slider_sound_setting = 0;
  int count_slider_camera = 0;
  int count_slider_item = 0;

  for (TableRow row : table.rows()) {
    String s = row.getString("Type") ; 
    if(s.equals("Slider item a")) count_slider_item++ ;
    else if(s.equals("Slider item b")) count_slider_item++;
    else if(s.equals("Slider item c")) count_slider_item++;
    else if(s.equals("Slider item d")) count_slider_item++;
    else if(s.equals("Slider background")) count_slider_background++;
    else if(s.equals("Slider fx")) count_slider_fx++; 
    else if(s.equals("Slider light")) count_slider_light++; 
    else if(s.equals("Slider sound")) count_slider_sound++;
    else if(s.equals("Slider sound setting")) count_slider_sound_setting++;  
    else if(s.equals("Slider camera")) count_slider_camera++; 
  }
  println("sliders background",count_slider_background);
  println("sliders fx",count_slider_fx);
  println("sliders light",count_slider_light);
  println("sliders sound",count_slider_sound);
  println("sliders sound setting",count_slider_sound_setting);
  println("sliders camera",count_slider_camera);
  println("sliders item",count_slider_item);

  // info_slider_general = new Vec5 [count_slider_general];
  info_button_general = new ivec3 [NUM_BUTTON_GENERAL];
  for(int i = 0 ; i < info_button_general.length ; i++) {
    info_button_general[i] = ivec3();
  }
  
  if(count_slider_background != NUM_SLIDER_BACKGROUND) {
    count_slider_background = NUM_SLIDER_BACKGROUND;
    printErr("info save SLIDER BACKGROUND is not the same than constant NUM_SLIDER_BACKGROUND, the constast has used instead, to prevent error");
  }
  cropinfo_slider_background = new Cropinfo[count_slider_background];
  for(int i = 0 ; i < count_slider_background ; i++) {
    cropinfo_slider_background[i] = new Cropinfo();
  }
  
  if(count_slider_fx != NUM_SLIDER_FX) {
    count_slider_fx = NUM_SLIDER_FX;
    printErr("info save SLIDER FX is not the same than constant NUM_SLIDER_FX, the constast has used instead, to prevent error");
  }
  cropinfo_slider_fx = new Cropinfo[count_slider_fx];
  for(int i = 0 ; i < count_slider_fx ; i++) {
    cropinfo_slider_fx[i] = new Cropinfo();
  }
  

  if(count_slider_light != NUM_SLIDER_LIGHT) {
    count_slider_light = NUM_SLIDER_LIGHT;
    printErr("info save SLIDER LIGHT is not the same than constant NUM_SLIDER_LIGHT, the constast has used instead, to prevent error");
  }
  cropinfo_slider_light = new Cropinfo[count_slider_light];
  for(int i = 0 ; i < count_slider_light ; i++) {
    cropinfo_slider_light[i] = new Cropinfo();
  }

  if(count_slider_sound != NUM_SLIDER_SOUND) {
    count_slider_sound = NUM_SLIDER_SOUND;
    printErr("info save SLIDER SOUND is not the same than constant NUM_SLIDER_SOUND, the constast has used instead, to prevent error");
  }
  cropinfo_slider_sound = new Cropinfo[count_slider_sound];
  for(int i = 0 ; i < count_slider_sound ; i++) {
    cropinfo_slider_sound[i] = new Cropinfo();
  }

  if(count_slider_sound_setting != NUM_SLIDER_SOUND_SETTING) {
    count_slider_sound_setting = NUM_SLIDER_SOUND_SETTING;
    printErr("info save SLIDER SOUND SETTING is not the same than constant NUM_SLIDER_SOUND_SETTING, the constast has used instead, to prevent error");
  }
  cropinfo_slider_sound_setting = new Cropinfo[count_slider_sound_setting];
  for(int i = 0 ; i < count_slider_sound_setting ; i++) {
    cropinfo_slider_sound_setting[i] = new Cropinfo();
  }

  if(count_slider_camera != NUM_SLIDER_CAMERA) {
    count_slider_camera = NUM_SLIDER_CAMERA;
    printErr("info save SLIDER CAMERA is not the same than constant NUM_SLIDER_CAMERA, the constast has used instead, to prevent error");
  }
  cropinfo_slider_camera = new Cropinfo[count_slider_camera];
  for(int i = 0 ; i < count_slider_camera ; i++) {
    cropinfo_slider_camera[i] = new Cropinfo();
  }


  cropinfo_slider_item = new Cropinfo[count_slider_item];
  for(int i = 0 ; i < count_slider_item ; i++) {
    cropinfo_slider_item[i] = new Cropinfo();
  }

  // create the var info for the item we need
  info_list_item_ID = new int [NUM_ITEM] ;
  
  // we don't count from the save in case we add object and this one has never use before and he don't exist in the data base
  info_button_item = new ivec3 [NUM_ITEM *BUTTON_ITEM_CONSOLE +BUTTON_ITEM_CONSOLE] ; 
  for(int i = 0 ; i < info_button_item.length ; i++) {
    info_button_item[i] = ivec3();
  }
}








































/**
LOAD file
v 2.1.0
2014-2018
*/
public void load_setting_controller(File selection) {
  if (selection != null) {
    String loadPathControllerSetting = selection.getAbsolutePath();
    load_saved_file_controller(loadPathControllerSetting);
    INIT_INTERFACE = true;
    LOAD_SETTING = true;
  } 
}



// loadSave(path) read info from save file
public void load_saved_file_controller(String path) {
  Table settingTable = loadTable(path, "header");
  // re-init the counter for the new loop
  int count_button_item = 0;
  int count_button_general = 0;
  int count_slider_general = 0;
  int count_slider_background = 0;
  int count_slider_fx = 0;
  int count_slider_light = 0;
  int count_slider_sound = 0;
  int count_slider_sound_setting = 0;
  int count_slider_camera = 0;
  int count_slider_item = 0;
  int count_item = 0;


  for (TableRow row : settingTable.rows()) {
    String s = row.getString("Type");
    // media
    if(s.equals("Media")){
      String media_path = row.getString("Path");
      add_media(media_path);
    }
    // button general
    if(s.equals("Button background")){ 
      int IDbutton = row.getInt("ID button");
      int IDmidi = row.getInt("ID midi");
      int onOff = row.getInt("On Off");
      if(count_button_general < info_button_general.length) {
        info_button_general[count_button_general].set(IDbutton,IDmidi,onOff);
      }
      count_button_general++;
    }
    if(s.equals("Button curtain")){ 
      int IDbutton = row.getInt("ID button");
      int IDmidi = row.getInt("ID midi");
      int onOff = row.getInt("On Off");
      if(count_button_general < info_button_general.length) {
        info_button_general[count_button_general].set(IDbutton,IDmidi,onOff);
      }
      count_button_general++;
    }

    if(s.equals("Button fx")){ 
      int IDbutton = row.getInt("ID button");
      int IDmidi = row.getInt("ID midi");
      int onOff = row.getInt("On Off");
      if(count_button_general < info_button_general.length) {
        info_button_general[count_button_general].set(IDbutton,IDmidi,onOff);
      }
      count_button_general++;
    }


    if(s.equals("Button light ambient")){ 
      int IDbutton = row.getInt("ID button");
      int IDmidi = row.getInt("ID midi");
      int onOff = row.getInt("On Off");
      if(count_button_general < info_button_general.length) {
        info_button_general[count_button_general].set(IDbutton,IDmidi,onOff);
      }
      count_button_general++;
    }
    if(s.equals("Button light 1")){ 
      int IDbutton = row.getInt("ID button");
      int IDmidi = row.getInt("ID midi");
      int onOff = row.getInt("On Off");
      if(count_button_general < info_button_general.length) {
        info_button_general[count_button_general].set(IDbutton,IDmidi,onOff);
      }
      count_button_general++;
    }

    if(s.equals("Button light 2")){ 
      int IDbutton = row.getInt("ID button");
      int IDmidi = row.getInt("ID midi");
      int onOff = row.getInt("On Off");
      if(count_button_general < info_button_general.length) {
        info_button_general[count_button_general].set(IDbutton,IDmidi,onOff);
      }
      count_button_general++;
    }

    if(s.equals("Button transient")){ 
      int IDbutton = row.getInt("ID button");
      int IDmidi = row.getInt("ID midi");
      int onOff = row.getInt("On Off");
      if(count_button_general < info_button_general.length) {
        info_button_general[count_button_general].set(IDbutton,IDmidi,onOff);
      }
      count_button_general++;
    }

    // button item
    if(s.equals("Button item")){ 
      int IDbutton = row.getInt("ID button");
      int IDmidi = row.getInt("ID midi");
      int onOff = row.getInt("On Off");
      if(count_button_item < info_button_item.length) {
        info_button_item[count_button_item].set(IDbutton,IDmidi,onOff);
      } 
      count_button_item++; 
    }

    // slider background
    if(s.equals("Slider background")) {
      set_info_slider(row, "Slider background", cropinfo_slider_background[count_slider_background]);
      count_slider_background++;
    }

    // slider FX
    if(s.equals("Slider fx")) {
      set_info_slider(row, "Slider fx", cropinfo_slider_fx[count_slider_fx]);
      count_slider_fx++;
    }    
    // slider light
    if(s.equals("Slider light")) {
      set_info_slider(row, "Slider light", cropinfo_slider_light[count_slider_light]);
      count_slider_light++;
    }

    // slider sound
    if(s.equals("Slider sound")) {
      set_info_slider(row, "Slider sound", cropinfo_slider_sound[count_slider_sound]);
      count_slider_sound++;
    }

    // slider sound setting
    if(s.equals("Slider sound setting")) {
      set_info_slider(row, "Slider sound setting", cropinfo_slider_sound_setting[count_slider_sound_setting]);
      count_slider_sound_setting++;
    }
    
    // slider camera
    if(s.equals("Slider camera")) {
      set_info_slider(row, "Slider camera", cropinfo_slider_camera[count_slider_camera]);
      count_slider_camera++;
    }

    // slider item
    if(s.equals("Slider item a")) {
      set_info_slider(row, "Slider item a", cropinfo_slider_item[count_slider_item]);
      count_slider_item++;
    }

    if(s.equals("Slider item b")) {
      set_info_slider(row, "Slider item b", cropinfo_slider_item[count_slider_item]);
      count_slider_item++;
    }

    if(s.equals("Slider item c")) {
      set_info_slider(row, "Slider item c", cropinfo_slider_item[count_slider_item]);
      count_slider_item++;
    }

    if(s.equals("Slider item d")) {
      set_info_slider(row, "Slider item d", cropinfo_slider_item[count_slider_item]);
      count_slider_item++;
    }

    
    // item list
    if(s.equals("Item")) {
      // security in case the developper remove item.
      // because if that's happen there is an Out Bound Exception
      if(count_item <  info_list_item_ID.length) {
        info_list_item_ID[count_item] = row.getInt("Item ID");
        String [] temp_item_info_split = split(item_info_raw[count_item +1], "/") ;
        int ID =  Integer.parseInt(temp_item_info_split[2]) ;
        boolean on_off = false ;
        if(row.getInt("Item On Off") == 1) {
          on_off = true; 
        } else {
          on_off = false;
        }

        inventory[ID].name = item_name[count_item +1]; 
        inventory[ID].set_is(on_off); 
        count_item++ ;
      }      
    }
  }
}


public void set_info_slider(TableRow row, String name, Cropinfo info) {
  int id = row.getInt("ID slider");
  int id_midi = row.getInt("ID midi");
  
  int length_value = row.getInt("Value length");
  float [] value = new float[length_value];
  for(int i = 0 ; i < length_value ; i++) {
    value[i] = row.getFloat("Value slider "+i);

  }
 
  float min = row.getFloat("Min slider");
  float max = row.getFloat("Max slider");
  info.set_id(id).set_id_midi(id_midi).set_value(value).set_min(min).set_max(max);
  
}





















/**
SETTING SAVE
*/
boolean first_load;
public void set_data() {
  if(INIT_INTERFACE) {
    set_button_inventory();
    if(!first_load) {
      set_inventory_item(false);
      first_load = true ;
    } else {
      set_inventory_item(true);
    }
    set_button_from_saved_file();
    set_slider_data_group();
    INIT_INTERFACE = false ;
  }
}



// Setting SLIDER from save
public void set_slider_data_group() {
  for (int i = 0 ; i < NUM_SLIDER_BACKGROUND ; i++) {
    setting_data_slider(slider_adj_background[i],cropinfo_slider_background[i]);
    update_slider(slider_adj_background[i],cropinfo_slider_background);
  }

  for (int i = 0 ; i < NUM_SLIDER_FX ; i++) {
    setting_data_slider(slider_adj_fx[i],cropinfo_slider_fx[i]);
    update_slider(slider_adj_fx[i],cropinfo_slider_fx);
  }

  for (int i = 0 ; i < NUM_SLIDER_LIGHT ; i++) {
    setting_data_slider(slider_adj_light[i],cropinfo_slider_light[i]);
    update_slider(slider_adj_light[i],cropinfo_slider_light);
  }

  for (int i = 0 ; i < NUM_SLIDER_SOUND ; i++) {
    setting_data_slider(slider_adj_sound[i],cropinfo_slider_sound[i]);
    update_slider(slider_adj_sound[i],cropinfo_slider_sound);
  }

  for (int i = 0 ; i < NUM_SLIDER_SOUND_SETTING ; i++) {
    setting_data_slider(slider_sound_setting[i],cropinfo_slider_sound_setting[i]);
    update_slider(slider_sound_setting[i],cropinfo_slider_sound_setting);
  }

  for (int i = 0 ; i < NUM_SLIDER_CAMERA ; i++) {
    setting_data_slider(slider_adj_camera[i],cropinfo_slider_camera[i]);
    update_slider(slider_adj_camera[i],cropinfo_slider_camera);
  }

  for(int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    setting_data_slider(slider_adj_item[i],cropinfo_slider_item[i]);
    update_slider(slider_adj_item[i],cropinfo_slider_item);
  }
}


// local method of set_slider_save()
public void setting_data_slider(Slider slider, Cropinfo info) {
  slider.set_id_midi(info.get_id_midi());
  if(info.get_value() != null && slider.molette.length > info.get_value().length){
    float [] value;
    float step = 1.f / (slider.molette.length +1);
    value = new float[slider.molette.length];
    for(int i = 0 ; i < value.length ;i++) {
      value[i] = (i+1)*step;
    }
    slider.set_molette_pos_norm(value);
  } else if(info.get_value() != null) {
    slider.set_molette_pos_norm(info.get_value());
  }

  if(slider instanceof Sladj) {
    Sladj sladj = (Sladj)slider;
    sladj.set_min_max(info.get_min(),info.get_max());
  }
}





//setting BUTTON from save
public void set_button_from_saved_file() {
  // close loop to save the button statement, 
  // see void midiButtonManager(boolean saveButton)
  int rank = 0;
  // background
  if(info_button_general[rank].z == 1.0f) button_bg.set_is(true) ; else button_bg.set_is(false);
  button_bg.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  // curtain
  if(info_button_general[rank].z == 1.0f) button_curtain.set_is(true); else button_curtain.set_is(false);
  button_curtain.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  // fx
  for(int i = 0 ; i < NUM_BUTTON_FX; i++) {
    if(info_button_general[rank].z == 1.0f) button_fx[i].set_is(true); else button_fx[i].set_is(false);
    button_fx[i].set_id_midi((int)info_button_general[rank].y); 
    rank++ ;
  }
  // light ambient
  if(info_button_general[rank].z == 1.0f) button_light_ambient.set_is(true); else button_light_ambient.set_is(false);
  button_light_ambient.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  if(info_button_general[rank].z == 1.0f) button_light_ambient_action.set_is(true); else button_light_ambient_action.set_is(false);
  button_light_ambient_action.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  //LIGHT ONE
  if(info_button_general[rank].z == 1.0f) button_light_1.set_is(true); else button_light_1.set_is(false);
  button_light_1.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  if(info_button_general[rank].z == 1.0f) button_light_1_action.set_is(true); else button_light_1_action.set_is(false);
  button_light_1_action.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  // LIGHT TWO
  if(info_button_general[rank].z == 1.0f) button_light_2.set_is(true); else button_light_2.set_is(false);
  button_light_2.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  if(info_button_general[rank].z == 1.0f) button_light_2_action.set_is(true); else button_light_2_action.set_is(false);
  button_light_2_action.set_id_midi((int)info_button_general[rank].y); 
  rank++ ;
  //SOUND
  for(int i = 0 ; i < NUM_BUTTON_TRANSIENT; i++) {
    if(info_button_general[rank].z == 1.0f) button_transient[i].set_is(true); else button_transient[i].set_is(false);
    button_transient[i].set_id_midi((int)info_button_general[rank].y); 
    rank++ ;
  }
  

  /**
  can be simplify not sure it's necessary to use buttonRank
  */
  rank = 4; // start a 4 because we don't use the fourth for historic and bad reason
  int button_rank;
  for(int i = 1 ; i <= NUM_ITEM ; i++) {
    for (int j = 0 ; j < BUTTON_ITEM_CONSOLE ; j++) {
      button_rank = info_button_item[rank].x;
      // check if button rank is upper to zero, 
      // that's happen when a new item is add from Scene before save the setting
      if(button_rank > 0) {
        if(info_button_item[rank].z == 1.0f && button_rank == (i*BUTTON_ITEM_CONSOLE)+j) {
          button_item[button_rank].set_is(true);
        } else {
          button_item[button_rank].set_is(false); 
        }
        button_item[button_rank].set_id_midi((int)info_button_item[rank].y);
      }   
      rank++ ;
    }
  }
}




// info_save_raw_list read info to translate and give a good position
/*
Vec5 info_save_raw_list(Vec5[] list, int index) {
  if(list != null) {
    Vec5 info = Vec5() ;
    float value_slider = 0 ;
    float value_slider_min = 0 ;
    float value_slider_max = 1 ;
    float IDmidi = 0 ;
    for(int i = 0 ; i < list.length ;i++) {
      if(list[i] != null ) if((int)list[i].a == index) {
        value_slider = list[i].c ;
        value_slider_min = list[i].d ;
        value_slider_max = list[i].e ;
        IDmidi = list[i].b ;
        info = Vec5(index, IDmidi,value_slider,value_slider_min,value_slider_max) ;
        break;
      } else {
        info = Vec5(-1) ;
      }
    }
    return info ;
  } else return null; 
}
*/













//LOAD text Interface
public void apply_text_gui() {
  String lang[] ;
  lang = loadStrings(preference_path+"language.txt");

  String l = join(lang,"") ;
  int language = Integer.parseInt(l);
  Table gui_table;
  if(language == 0) {
    gui_table = loadTable(preference_path+"gui_info_fr.csv","header");
  } else if (language == 1) {
    gui_table = loadTable(preference_path+"gui_info_en.csv","header");
  } else {
    gui_table = loadTable(preference_path+"gui_info_en.csv","header");
  }


  int num_row = gui_table.getRowCount();
  for (int i = 0 ; i < num_row ; i++) {
    TableRow row = gui_table.getRow(i);
    String name = row.getString("name");
    int num = NUM_SLIDER_ITEM_BY_COL ;

    if(name.equals("general")) {
      // 
    } else if(name.equals("slider background")) {
      for(int k = 0 ; k < NUM_SLIDER_BACKGROUND ; k++) {
        slider_background_name[k] = row.getString("col "+k);
      } 
    } else if(name.equals("slider filter")) {
      for(int k = 0 ; k < NUM_SLIDER_FX ; k++) {
        slider_filter_name[k] = row.getString("col "+k);
      }
    } else if(name.equals("slider light")) {
      for(int k = 0 ; k < NUM_SLIDER_LIGHT ; k++) {
        slider_light_name[k] = row.getString("col "+k);
      }
    } else if(name.equals("slider sound")) {
      for(int k = 0 ; k < NUM_SLIDER_SOUND ; k++) {
        slider_sound_name[k] = row.getString("col "+k);
      }
    } else if(name.equals("slider sound setting")) {
      for(int k = 0 ; k < NUM_SLIDER_SOUND_SETTING ; k++) {
        slider_sound_setting_name[k] = row.getString("col "+k);
      }
    } else if(name.equals("slider camera")) {
      for(int k = 0 ; k < NUM_SLIDER_CAMERA ; k++) {
        slider_camera_name[k] = row.getString("col "+k);
      } 
    } 
    
    if(name.equals("slider item a")) {
      for(int k = 0 ; k < num ; k++) {
        slider_item_name[k] = row.getString("col "+k);
      }
    } else if(name.equals("slider item b")) {
      for(int k = 0 ; k < num ; k++) {
        slider_item_name[k +num] = row.getString("col "+k);
      }
    } else if(name.equals("slider item c")) {
      for(int k = 0 ; k < num ; k++) {
        slider_item_name[k +(num*2)] = row.getString("col "+k);
      }
    } else if(name.equals("slider item d")) {
      for(int k = 0 ; k < num ; k++) {
        slider_item_name[k +(num*3)] = row.getString("col "+k);
      }
    } 
  }
}





//IMPORT VIGNETTE
public void set_import_pic_button() {
  //picto setting
  for(int i = 0 ; i < 4 ; i++) {
    pic_curtain[i] = loadImage("picto/picto_curtain_"+i+".png");
    pic_midi[i] = loadImage("picto/picto_midi_"+i+".png");
    // reset
    pic_reset_camera[i] = loadImage("picto/picto_camera_"+i+".png");
    pic_reset_item_on[i] = loadImage("picto/picto_item_selected_"+i+".png");
    pic_reset_fx[i] = loadImage("picto/picto_fx_"+i+".png");
    // misc
    pic_birth[i] = loadImage("picto/picto_birth_"+i+".png");
    pic_3D[i] = loadImage("picto/picto_3D_"+i+".png");
    //item
    picSetting[i] = loadImage("picto/picto_setting_"+i+".png") ;
    picSound[i] = loadImage("picto/picto_sound_"+i+".png") ;
    picAction[i] = loadImage("picto/picto_action_"+i+".png") ;
  }
  // load thumbnail
  int num = NUM_ITEM +1 ;
  OFF_in_thumbnail = new PImage[num] ;
  OFF_out_thumbnail = new PImage[num] ;
  ON_in_thumbnail = new PImage[num] ;
  ON_out_thumbnail = new PImage[num] ;
  for(int i=0 ;  i<num ; i++ ) {
    String className = ("0") ;
    if (item_load_name[i] != null) className = item_load_name[i] ;
    OFF_in_thumbnail[i] = loadImage("thumbnail/OFF_in/OFF_in_"+className+".png") ;
    if(OFF_in_thumbnail[i] == null) OFF_in_thumbnail[i] = loadImage("thumbnail/OFF_in/OFF_in_0.png") ;
    //
    OFF_out_thumbnail[i] = loadImage("thumbnail/OFF_out/OFF_out_"+className+".png") ;
    if(OFF_out_thumbnail[i] == null) OFF_out_thumbnail[i] = loadImage("thumbnail/OFF_out/OFF_out_0.png") ;
    // 
    ON_in_thumbnail[i] = loadImage("thumbnail/ON_in/ON_in_"+className+".png") ;
    if(ON_in_thumbnail[i] == null) ON_in_thumbnail[i] = loadImage("thumbnail/ON_in/ON_in_0.png") ;
    //
    ON_out_thumbnail[i] = loadImage("thumbnail/ON_out/ON_out_"+className+".png") ;
    if(ON_out_thumbnail[i] == null) ON_out_thumbnail[i] = loadImage("thumbnail/ON_out/ON_out_0.png") ;
  }
}
/**
SAVE
v 2.1.0
*/
String savePathSetting = ("") ;
public void save_controller_setting(File selection) {
  savePathSetting = selection.getAbsolutePath() ;
  if (selection != null) {
    save_controller_setting(savePathSetting);
  }
}


public void autosave() {
  println("Autosave in progress");
  save_controller_setting(autosave_path);
}











/**
* dialogue data is a save can be read not often by the scene like setting mouse...
*/
public void save_dial_data(String path) {
  Table save_dial = new Table();
  save_dial.addColumn("mouse reactivity");
  TableRow table_row = save_dial.addRow() ;
  table_row.setFloat("mouse reactivity",mouse_reactivity);
  saveTable(save_dial,path+"/dialogue.csv");
}


























public void save_controller_setting(String path) {
  println("Save controller in progress:",path);
  save_info_slider();
  save_info_item();
  save_info_media();
  // for the fake item 0 with all the buttom console
  for(int i = 0 ; i < BUTTON_ITEM_CONSOLE ;i++) {
    set_data_button(i, 0,false,"Button item");
  }  
  midi_manager(true);
  saveTable(saveSetting, path);
  saveSetting.clearRows() ;
}



// SAVE MEDIA PATH
public void save_info_media() {
  for(File file : media_files) {
    String path = file.getAbsolutePath();
    set_data_media("Media",path);
  }
}




// SAVE SLIDERS
// save the position and the ID of the slider molette
public void save_info_slider() {
  int start = 0;
  // background
  for (int i = start ; i < NUM_SLIDER_BACKGROUND ; i++) {
    cropinfo_slider_background[i].set_value(slider_adj_background[i].get(0));
    cropinfo_slider_background[i].set_min(slider_adj_background[i].get_min_norm());
    cropinfo_slider_background[i].set_max(slider_adj_background[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_background[i],"Slider background");
  }

  // FX
  for (int i = start ; i < NUM_SLIDER_FX ; i++) {
    cropinfo_slider_fx[i].set_value(slider_adj_fx[i].get(0));
    cropinfo_slider_fx[i].set_min(slider_adj_fx[i].get_min_norm());
    cropinfo_slider_fx[i].set_max(slider_adj_fx[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_fx[i],"Slider fx");
  }

  // light
  for (int i = start ; i < NUM_SLIDER_LIGHT ; i++) {
    cropinfo_slider_light[i].set_value(slider_adj_light[i].get(0));
    cropinfo_slider_light[i].set_min(slider_adj_light[i].get_min_norm());
    cropinfo_slider_light[i].set_max(slider_adj_light[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_light[i],"Slider light");
  }

  // sound
  for (int i = start ; i < NUM_SLIDER_SOUND ; i++) {
    cropinfo_slider_sound[i].set_value(slider_adj_sound[i].get(0));
    cropinfo_slider_sound[i].set_min(slider_adj_sound[i].get_min_norm());
    cropinfo_slider_sound[i].set_max(slider_adj_sound[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_sound[i],"Slider sound");
  }

  // sound setting
  for (int i = start ; i < NUM_SLIDER_SOUND_SETTING ; i++) {
    cropinfo_slider_sound_setting[i].set_value(slider_sound_setting[i].get());
    set_data_slider(i,cropinfo_slider_sound_setting[i],"Slider sound setting");
  }

  // camera
  for (int i = start ; i < NUM_SLIDER_CAMERA ; i++) {
    // int temp = i-1 ;
    cropinfo_slider_camera[i].set_value(slider_adj_camera[i].get(0));
    cropinfo_slider_camera[i].set_min(slider_adj_camera[i].get_min_norm());
    cropinfo_slider_camera[i].set_max(slider_adj_camera[i].get_max_norm());
    set_data_slider(i,cropinfo_slider_camera[i],"Slider camera");
  }
 
  // item
  String [] slider_name = new String[NUM_COL_SLIDER];
  slider_name [0] = "Slider item a";
  slider_name [1] = "Slider item b";
  slider_name [2] = "Slider item c";
  slider_name [3] = "Slider item d";
  int index = 0;
  for(int i = 0; i < NUM_SLIDER_ITEM ; i++) {
    int slider_ID = i;
    for(int k = 0 ; k < cropinfo_slider_item.length ;k++) {
      if(cropinfo_slider_item[k].get_id() == slider_ID) {
        cropinfo_slider_item[k].set_value(slider_adj_item[slider_ID].get(0));
        cropinfo_slider_item[k].set_min(slider_adj_item[slider_ID].get_min_norm());
        cropinfo_slider_item[k].set_max(slider_adj_item[slider_ID].get_max_norm());
        int min = NUM_SLIDER_ITEM_BY_COL *index;
        int max = NUM_SLIDER_ITEM_BY_COL *(index+1);
        if(i >= min && i <= max) {
          set_data_slider(slider_ID,cropinfo_slider_item[k],slider_name[index]);
          if(i == max) index++;
        } 
      }
    }
  }
  show_all_slider_item = false ;
}

public void save_info_item() {
  for(int i = 0 ; i < NUM_ITEM ; i++) {
    set_data_item(item_ID[i] +1) ;
  }
}





Table saveSetting;
public void set_data_save_setting() {
  saveSetting = new Table();
  saveSetting.addColumn("Type") ;
  saveSetting.addColumn("ID slider");
  saveSetting.addColumn("Min slider");
  saveSetting.addColumn("Max slider");
  saveSetting.addColumn("Value length");
  saveSetting.addColumn("Value slider 0");
  saveSetting.addColumn("Value slider 1");
  saveSetting.addColumn("Value slider 2");
  saveSetting.addColumn("Value slider 3");
  saveSetting.addColumn("ID button");
  saveSetting.addColumn("On Off");
  saveSetting.addColumn("ID midi");
  saveSetting.addColumn("Item ID");
  saveSetting.addColumn("Item On Off");
  saveSetting.addColumn("Item Name");
  saveSetting.addColumn("Item Class Name");
  saveSetting.addColumn("Path");
}

//write the value in the table
public void set_data_button(int IDbutton, int IDmidi, boolean is_on_off, String type) {
  TableRow buttonSetting = saveSetting.addRow() ;
  buttonSetting.setString("Type", type) ;
  buttonSetting.setInt("ID button", IDbutton) ;
  buttonSetting.setInt("ID midi", IDmidi) ;
  if(is_on_off) {
    buttonSetting.setInt("On Off",1); 
  } else {
    buttonSetting.setInt("On Off",0);
  }
}

//
public void set_data_slider(int id_slider, Cropinfo info, String name){
  TableRow sliderSetting = saveSetting.addRow();
  sliderSetting.setString("Type",name);
  sliderSetting.setInt("ID slider",id_slider);
  sliderSetting.setInt("ID midi",info.get_id_midi());
  for(int i = 0 ; i < info.get_value().length; i++) {
    sliderSetting.setFloat("Value slider "+i, info.get_value(i));
  }
  sliderSetting.setInt("Value length",info.get_value().length);    
  sliderSetting.setFloat("Min slider",info.get_min()); 
  sliderSetting.setFloat("Max slider",info.get_max()); 
}

// void set_data_item(int ID_item, boolean display_item_on_off) {
public void set_data_item(int ID_item) {
  TableRow item_setting = saveSetting.addRow() ;
  item_setting.setString("Type", "Item") ;
  item_setting.setInt("Item ID", ID_item) ;

  // if(on_off_inventory_item[ID_item]) item_setting.setInt("Item On Off", 1) ; 
  if(inventory[ID_item].is()) item_setting.setInt("Item On Off", 1); 
  else item_setting.setInt("Item On Off", 0);
  item_setting.setString("Item Name", item_name[ID_item]) ;
  item_setting.setString("Item Class Name", item_load_name[ID_item]);
}


public void set_data_media(String type, String path) {
  TableRow media = saveSetting.addRow() ;
  media.setString("Type",type);
  media.setString("Path",path);
}



/**
OSC Controller
2014 - 2018
v 1.2.0
*/


String ID_address_local = ("127.0.0.1") ;

String IP_address_prescene = ID_address_local ;
String [] ID_address_scene ;

OscP5 osc_prescene_general;
OscP5 osc_prescene_item;
OscP5 osc_scene_general;
OscP5 osc_scene_item;

int port_prescene_general = 10_000;
int port_prescene_item = 10_001;
int port_scene_general = 9_500;
int port_scene_item = 9_501;

NetAddress prescene_net_address_general;
NetAddress prescene_net_address_item;

NetAddress [] scene_net_addresses_general;
NetAddress [] scene_net_addresses_item;

public void set_OSC() {
  int num_address = 1 ;
  String [] address = loadStrings(preference_path+"network/IP_address_mirror.txt") ;
  String [] temp = split(address[0],"/");
  

  int num_valid_address = 0 ;
  for(int i = 0 ; i < temp.length ; i++) {
    if(temp[i].equals("IP_address") || temp[i].equals("")) {
      // nothing happen
    } else {
      num_valid_address ++;
    }   
  }  

  ID_address_scene = new String[num_valid_address];
  scene_net_addresses_general = new NetAddress[num_valid_address];
  scene_net_addresses_item = new NetAddress[num_valid_address] ;

  for(int i = 0 ; i < num_valid_address ; i++) {
    ID_address_scene[i] = temp[i+1] ;
  }  

  osc_prescene_general = new OscP5(this,port_prescene_general);
  osc_prescene_item = new OscP5(this,port_prescene_item);
  osc_scene_general = new OscP5(this,port_scene_general);
  osc_scene_item = new OscP5(this,port_scene_item);

  set_ip_address() ;
}

public void set_ip_address() {
  // general
  prescene_net_address_general = new NetAddress(IP_address_prescene,port_prescene_general);
  for(int i = 0 ; i < scene_net_addresses_general.length ; i++) {
     scene_net_addresses_general[i] = new NetAddress(ID_address_scene[i], port_scene_general) ;
  }
  // item
  prescene_net_address_item = new NetAddress(IP_address_prescene,port_prescene_item);
  for(int i = 0 ; i < scene_net_addresses_item.length ; i++) {
     scene_net_addresses_item[i] = new NetAddress(ID_address_scene[i], port_scene_item) ;
  }
}






public void update_OSC() {
  total_data_osc_general = 0;
  OscMessage mess_general = new OscMessage("Controller general");
  message_general_osc(mess_general);
  if(send_general_is()) {
    send_OSC(osc_prescene_general,osc_scene_general,prescene_net_address_general,scene_net_addresses_general,mess_general);
  }

  total_data_osc_item = 0;
  OscMessage mess_item = new OscMessage("Controller item");
  message_item_osc(mess_item);

  if(send_item_is()) {
    send_OSC(osc_prescene_item,osc_scene_item,prescene_net_address_item,scene_net_addresses_item,mess_item);
  }
}


public void message_general_osc(OscMessage m) {
  // add menu bar
  add_data_general(m,button_curtain.is());
  add_data_general(m,button_reset_camera.is());
  add_data_general(m,button_reset_item_on.is());
  add_data_general(m,button_reset_fx.is());
  add_data_general(m,button_birth.is());
  add_data_general(m,button_3D.is());
 
  // dropdown general
  add_data_general(m,dropdown_bar[0].get_selection()); // shader
  add_data_general(m,dropdown_bar[1].get_selection()); // filter
  add_data_general(m,dropdown_bar[2].get_selection()); // font 
  add_data_general(m,dropdown_bar[3].get_selection()); // text
  add_data_general(m,dropdown_bar[4].get_selection()); // bitmap
  add_data_general(m,dropdown_bar[5].get_selection()); // shape
  add_data_general(m,dropdown_bar[6].get_selection()); // movie

  // button general background
  add_data_general(m,button_bg.is());
  // button fx
  for(int i = 0 ; i < NUM_BUTTON_FX ; i++) {
    add_data_general(m,button_fx[i].is());
  }
  // button general light
  add_data_general(m,button_light_ambient.is());
  add_data_general(m,button_light_ambient_action.is());
  add_data_general(m,button_light_1.is());
  add_data_general(m,button_light_1_action.is());
  add_data_general(m,button_light_2.is());
  add_data_general(m,button_light_2_action.is());
  // button transient sound
  for(int i = 0 ; i < NUM_BUTTON_TRANSIENT ; i++) {
    add_data_general(m,button_transient[i].is());
  }
  // add slider general
  for(int i = 0 ; i < value_slider_background.length ; i++) {
    add_data_general(m,value_slider_background[i]);
  }
  for(int i = 0 ; i < value_slider_filter.length ; i++) {
    add_data_general(m,value_slider_filter[i]);
  }
  for(int i = 0 ; i < value_slider_light.length ; i++) {
    add_data_general(m,value_slider_light[i]);
  }
  for(int i = 0 ; i < value_slider_sound.length ; i++) {
    add_data_general(m,value_slider_sound[i]);
  }
  for(int i = 0 ; i < value_slider_sound_setting.length ; i++) {
    add_data_general(m,value_slider_sound_setting[i]);
  }
  for(int i = 0 ; i < value_slider_camera.length ; i++) {
    // for information the value "6" is no more use, because it is save on the dial table void save_dial_data(String path)
    add_data_general(m,value_slider_camera[i]);
  }
}

public void message_item_osc(OscMessage m) {
  // add item slider
  for ( int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    add_data_item(m,value_slider_item[i]); 
  }
  // add button item
  for (int i = 0 ; i < item_button_state.length ; i++) {
    add_data_item(m,item_button_state[i]); 
  }
  // add dropdown mode item
  for(int i = 0 ; i < NUM_ITEM ; i++) {
    int index = i +1;
    add_data_item(m,dd_item_costume[index].get_selection());
  }
  for(int i = 0 ; i < NUM_ITEM ; i++) {
    int index = i +1;
    add_data_item(m,dd_item_mode[index].get_selection());
  }
}

public void send_OSC(OscP5 osc_prescene, OscP5 osc_scene, NetAddress ad_prescene, NetAddress [] ad_scene, OscMessage m) {
  if(LIVE) {
    if(MIROIR) {
      for(int i = 0 ; i < ad_scene.length ; i++) {
        osc_scene.send(m, ad_scene[i]); 
      }
    } else if(!MIROIR) {
      println("void send OSC(): scene",ad_scene[0],frameCount);
      osc_scene.send(m, ad_scene[0]);
    }
    println("void send OSC(): prescene",ad_prescene,frameCount);  
    osc_prescene.send(m,ad_prescene);
  } else if(!LIVE) {
    osc_prescene.send(m,ad_prescene);
  }
}













boolean send_message_item_is;
float ref_total_data_osc_item;
float total_data_osc_item;
public boolean send_item_is() {
  if(total_data_osc_item != ref_total_data_osc_item) {
    send_message_item_is = true;
    ref_total_data_osc_item = total_data_osc_item;
  } else {
    send_message_item_is = false;
  }
  return send_message_item_is; 
}



boolean send_message_general_is;
float ref_total_data_osc_general;
float total_data_osc_general;
public boolean send_general_is() {
  if(total_data_osc_general != ref_total_data_osc_general) {
    send_message_general_is = true;
    ref_total_data_osc_general = total_data_osc_general;
  } else {
    send_message_general_is = false;
  }
  return send_message_general_is; 
}


public void add_data_general(OscMessage m, Object obj) {
  boolean cast_float_like_int = true;
  // byte case
  if(obj instanceof Byte) {
    byte by = (byte)obj ;
    m.add(by);
    total_data_osc_general += by;
  } // int short
  else if(obj instanceof Short) {
    short s = (short)obj ;
    m.add(s);
    total_data_osc_general += s;
    // int case
  } else if(obj instanceof Integer) {
    int i = (int)obj ;
    m.add(i);
    total_data_osc_general += i;
  // float case  
  } else if(obj instanceof Float) {
    float f = (float)obj;
    if(cast_float_like_int) {
      int i = round(f);
      m.add(i);
      total_data_osc_general += i;
    } else {
      m.add(f); 
      total_data_osc_general += f; 
    }
  // String case
  } else if(obj instanceof String) {
    String s = (String)obj;
    m.add(s);
    total_data_osc_general += s.length(); 
  // boolean case
  } else if(obj instanceof Boolean) {
    boolean b = (boolean)obj;
    m.add(to_int(b));
    if(b) {
      total_data_osc_general++;
    } 
  }  
}



public void add_data_item(OscMessage m, Object obj) {
  boolean cast_float_like_int = true;
  // byte case
  if(obj instanceof Byte) {
    byte by = (byte)obj ;
    m.add(by);
    total_data_osc_item += by;
  } // int short
  else if(obj instanceof Short) {
    short s = (short)obj ;
    m.add(s);
    total_data_osc_item += s;
    // int case
  } else if(obj instanceof Integer) {
    int i = (int)obj ;
    m.add(i);
    total_data_osc_item += i;
  // float case  
  } else if(obj instanceof Float) {
    float f = (float)obj;
    if(cast_float_like_int) {
      int i = round(f);
      m.add(i);
      total_data_osc_item += i;
    } else {
      m.add(f); 
      total_data_osc_item += f; 
    }
  // String case
  } else if(obj instanceof String) {
    String s = (String)obj;
    m.add(s);
    total_data_osc_item += s.length(); 
  // boolean case
  } else if(obj instanceof Boolean) {
    boolean b = (boolean)obj;
    m.add(to_int(b));
    if(b) {
      total_data_osc_item++;
    } 
  }  
}


public int to_int(boolean b) {
  if(b) return 1 ; else return 0;
}



  
  





  
/**
* CROPE
* Control ROmanesco Processing Environment
* v 0.9.15
* Copyleft (c) 2018-2019
* Processing 3.5.3
* @author Stan le Punk
* @see https://github.com/StanLepunK/Crope
* @see http://stanlepunk.xyz/
*/


/**
Crope Manager
v 0.0.1
2018-2018
*/
int birth_crope = 0;
ArrayList<Crope> object_crope ;

public ArrayList<Crope> get_crope() {
  return object_crope;
}







/**
Crope info > Cropinfo
v 0.1.2
2018-2019
*/
public class Cropinfo {
  private int rank = -1;
  private int id = -1;
  private int dna = Integer.MIN_VALUE;
  private int id_midi = -1;
  private String name = null;
  private String type = null;
  private boolean is; // button
  private float[] value; // slider
  private float min = 0; // slider
  private float max = 1; // slider
  private int line = -1; // dropdown
  
  public Cropinfo() {
    //
  }
  
  // set
  public Cropinfo set_rank(int rank){
    this.rank = rank;
    return this;
  }

  public Cropinfo set_id(int id){
    this.id = id;
    return this;
  }

  public Cropinfo set_dna(int dna){
    this.dna = dna;
    return this;
  }

  public Cropinfo set_id_midi(int id_midi){
    this.id_midi = id_midi;
    return this;
  }

  public Cropinfo set_name(String name){
    this.name = name;
    return this;
  }

  public Cropinfo set_type(String type){
    this.type = type;
    return this;
  }
  
  // set button info
  public Cropinfo set_is(boolean is){
    this.is = is;
    return this;
  }

  // set slider info
  public Cropinfo set_value(float... value){
    this.value = new float[value.length];
    for(int i = 0 ; i < this.value.length ; i++) {
      this.value[i] = value[i];
    }
    return this;
  }

  public Cropinfo set_min(float min){
    this.min = min;
    return this;
  }
  
  public Cropinfo set_max(float max){
    this.max = max;
    return this;
  }
  
  // set dropdown 
  public Cropinfo set_line(int line){
    this.line = line;
    return this;
  }

  // get crope info
  public int get_rank(){
    return this.rank;
  }

  public int get_id(){
    return this.id;
  }

  public int get_dna(){
    return this.dna;
  }

  public int get_id_midi(){
    return this.id_midi;
  }

  public String get_name(){
    return this.name;
  }

  public String get_type(){
    return this.type;
  }
  
  // get button info
  public boolean get_is(){
    return this.is;
  }
  
  // get slider info
  public float [] get_value(){
    if(this.value == null) {
      return null;
    }
    return this.value;
  }

  public float get_value(int index){
    if(this.value != null && index < this.value.length && index >= 0) {
      return this.value[index];
    } else if(this.value == null) {
      printErr("class Cropinfo method get_value(): value is null, may be you need to init it");
      return 0;    
    } else {
      printErr("class Cropinfo method get_value(",index,") is out of the range first value is return");
      return this.value[0];  
    }    
  }

  public float get_min(){
    return this.min;
  }
  
  public float get_max(){
    return this.max;
  }
  
  // get dropdown info
  public int get_line(){
    return this.line;
  }

  public @Override String toString() {
    String info = "";
    info += "type: "+type + ", ";
    info += "rank: "+rank + ", ";
    info += "name: "+name + ", ";
    info += "id: "+id + ", ";
    info += "midi: "+id_midi + ", ";
    info += "is: "+is + ", ";
    if(value == null) {
      value = new float[1];
      value[0] = 0;
    }
    for(int i = 0 ; i < value.length ;i++) {
      info += "value "+i+": "+value[i] + ", ";
    }
    info += "min: "+min+ ", ";
    info += "max: "+max+ ", ";
    info += "dropdown line: "+line+ ", ";
    return info;
  }
}











/**
class Crope
v 0.9.3
2018-2019
*/
public class Crope {
  protected ivec2 pos, size;
  protected ivec2 pos_ref;

  protected ivec2 cursor;

  protected int fill_in = color(g.colorModeX -(g.colorModeX *.1f));
  protected int fill_out = color(g.colorModeX /2);
  protected int stroke_in = fill_in;
  protected int stroke_out = fill_out;
  protected float thickness = 0;
  protected int color_label_in = fill_in;
  protected int color_label_out = fill_out;

  protected float rounded = 0;
  // label
  protected int align = LEFT;
  protected String name = null;
  protected ivec2 pos_label;

  protected PFont font;
  protected int font_size = 0;

  protected int new_midi_value;
  protected int id_midi = -2 ;

  protected int id = -1;
  protected int dna = Integer.MIN_VALUE;

  private int rank;
  private int birth;

  private String type = "Crope";

  protected boolean crope_build_is = false;

  public Crope(String type) {
    this.birth = birth_crope++;
    this.type = type;
    add_crope(this);
    dna = floor(random(Integer.MIN_VALUE,Integer.MAX_VALUE));
    if(dna == 0) dna = 1;
  }







  /**
  set structure
  */
  public Crope pos(int x, int y) {
    pos(ivec2(x,y));
    return this;
  }

  public Crope pos(ivec2 pos) {
    if(this.pos == null || !this.pos.equals(pos)) {
      if(this.pos == null) {
        this.pos = pos.copy();
        this.pos_ref = pos.copy();
      } else {
        this.pos.set(pos);
        this.pos_ref.set(pos);
      }
    }
    return this;
  }
  
  public Crope size(int x, int y) {
    size(ivec2(x,y));
    return this;
  }

  public Crope size(ivec2 size) {
    if(this.size == null || !this.size.equals(size)) {
      if(this.size == null) {
        this.size = size.copy();
      } else {
        this.size.set(size);
      }
    }
    return this;
  }


  /**
  private
  */
  protected void cursor(ivec2 cursor) {
    cursor(cursor.x,cursor.y);
  }

  protected void cursor(int x, int y) {
    if(cursor == null) {
      cursor = ivec2(x,y);
    } else {
      cursor.set(x,y);
    }
  }

  
  /**
  set colour
  */
  public Crope set_fill(int c) {
    set_fill(c,c);
    return this;
  }

  public Crope set_fill(int c_in, int c_out) {
    this.fill_in = c_in;
    this.fill_out = c_out;
    return this;
  }
  
  public Crope set_stroke(int c) {
    set_stroke(c,c);
    return this;
  }

  public Crope set_stroke(int c_in, int c_out) {
    this.stroke_in = c_in;
    this.stroke_out = c_out;
    return this;
  }

  public Crope set_thickness(float thickness) {
    this.thickness = thickness;
    return this;
  }


  public Crope set_aspect(int f_c, int s_c, float thickness) {
    set_fill(f_c,f_c);
    set_stroke(s_c,s_c);
    set_thickness(thickness);
    return this;
  }

  public Crope set_aspect(int f_c_in, int f_c_out, int s_c_in,  int s_c_out, float thickness) {
    set_fill(f_c_in,f_c_out);
    set_stroke(s_c_in,s_c_out);
    set_thickness(thickness);
    return this;
  }







  public Crope set_rounded(float rounded) {
    this.rounded = rounded;
    return this;
  }

  // set label
  public Crope set_name(String name) {
    this.name = name;
    return this;
  }

  public Crope set_label(String name) {
    this.name = name;
    return this;
  }

  public Crope set_label(String name, int x, int y) {
    this.name = name;
    if(this.pos_label == null) {
      this.pos_label = ivec2(x,y);
    } else {
      this.pos_label.set(x,y);
    }
    return this;
  }

  public Crope set_label(String name, ivec2 pos_label) {
    set_label(name, pos_label.x, pos_label.y);
    return this;
  }

  public Crope set_pos_label(ivec2 pos) {
    set_pos_label(pos.x,pos.y);
    return this;
  }

  public Crope set_pos_label(int x, int y) {
    if(this.pos_label == null) {
      this.pos_label = ivec2(x,y);
    } else {
       this.pos_label.set(x,y);
    }
    return this;
  }

  public Crope set_fill_label(int c) {
    set_fill_label(c,c);
    return this;
  }

  public Crope set_fill_label(int c_in, int c_out) {
    this.color_label_in = c_in;
    this.color_label_out = c_out;
    return this;
  }

  public Crope set_align_label(int align) {
    this.align = align;
    return this;
  }

  /**
  font
  */
  public Crope set_font(PFont font) {
    this.font = font;
    return this;
  }

  public Crope set_font(String font_name, int size) {
    this.font = createFont(font_name,size);
    return this;
  }

  public Crope set_font_size(int font_size) {
    this.font_size = font_size;
    return this; 
  }
  





  // set midi
  public Crope set_id_midi(int id_midi) {
    this.id_midi = id_midi;
    return this;
  }

  public Crope set_id(int id) {
    this.id = id;
    return this;
  }

  public Crope set_rank(int rank) {
    this.rank = rank;
    return this;
  }



  /**
  get
  */
  public int get_dna() {
    return dna;
  }

  public ivec2 get_pos() {
    return pos;
  }

  public ivec2 get_size() {
    return size;
  }

  public String get_name() {
    return name;
  }

  public String get_label() {
    return get_name();
  }

  //give the IDmidi 
  public int get_id_midi() { 
    return this.id_midi ; 
  }

  public int get_id() {
    return this.id;
  }


  public PFont get_font() {
    return font;
  }

  public int get_rank() {
    return rank;
  }

  public int get_birth() {
    return birth;
  }

  public String get_type() {
    return type;
  }




  public void add_crope(Crope crope) {
    if(object_crope == null) {
      object_crope = new ArrayList<Crope>();
    }
    object_crope.add(crope);
  }
}




























/**
CLASS BUTTON 
v 1.2.3
2013-2018
*/
public class Button extends Crope {
  int color_bg;

  int color_on_off;
  int color_in_ON, color_out_ON, color_in_OFF, color_out_OFF; 

  PImage [] pic;

  boolean inside;
  boolean authorization;
  boolean is = false;  

  protected Button() {
    super("Button");
  }

  //complexe
  /*
  public Button(int pos_x, int pos_y, int size_x, int size_y) {
    this.pos(pos_x, pos_y);
    this.size(size_x,size_y);
    super("Button");
  }
  */

  public Button(ivec2 pos, ivec2 size) {
    super("Button");
    this.pos(pos);
    this.size(size);
  }


  private Button(String type) {
    super(type);
  }

  //complexe
  /*
  private Button(String type, int pos_x, int pos_y, int size_x, int size_y) {
    this.pos(pos_x, pos_y);
    this.size(size_x,size_y);
    super(type);
  }
  */

  private Button(String type, ivec2 pos, ivec2 size) {
    super(type);
    this.pos(pos);
    this.size(size); 
  }

  /**
  Setting
  */
  public void set_is(boolean is) {
    this.is = is ;
  }

  public boolean is() {
    return is;
  }

  public void switch_is() {
    this.is = !this.is;
  }
  
  /**
  set
  */
  public Crope set_aspect_on_off(int color_in_ON, int color_out_ON, int color_in_OFF, int color_out_OFF) {
    this.color_in_ON = color_in_ON ; 
    this.color_out_ON = color_out_ON ; 
    this.color_in_OFF = color_in_OFF ; 
    this.color_out_OFF = color_out_OFF ;
    return this;
  }




  


  /**
  MISC
  */
  public void update(ivec2 cursor) {
    update(cursor.x, cursor.y);
  }

  public void update(int x, int y) {
    cursor(x,y);
    update(x,y,true);
  }

  public void update(int x, int y, boolean authorization) {
    cursor(x,y);
    this.authorization = authorization;
  }
  
  //ROLLOVER
  /**
  this method inside() must be refactoring, 
  it's not acceptable to have a def value inside
  */
  public boolean inside() {
    if(cursor == null) cursor = ivec2();
    float newSize = 1  ;
    if (size.y < 10 ) newSize = size.y *1.8f ; 
    else if (size.y >= 10 && size.y < 20  ) newSize = size.y *1.2f ;  
    else if (size.y >= 20 ) newSize = size.y ;
    
    if (cursor.x > pos.x && cursor.x < pos.x + size.x && cursor.y > pos.y  && cursor.y < pos.y +newSize) { 
      inside = true ;
      return true ; 
    } else {
      inside = false ;
      return false ; 
    }
  }
 






  /**
  SHOW BUTTON
  */
  /**
  PICTO
  */
  public void show_picto(PImage [] pic) {
    int correctionX = -1 ;
    if(pic[0] != null && pic[1] != null && pic[2] != null && pic[3] != null ) {
      if (is) {
        if (inside() && !authorization) {
          // inside
          image(pic[0],pos.x +correctionX, pos.y); 
        } else {
          // outside
          image(pic[1],pos.x +correctionX, pos.y);
        }
      } else {
        if (inside() && !authorization) {
          // inside
          image(pic[2],pos.x +correctionX, pos.y); 
        } else {
          // outside
          image(pic[3],pos.x +correctionX, pos.y);
        }
      }
    }
  }



  /**
  LABEL
  */
  public void show_label() {
    if(this.name != null) {
      if (is) {
        if (inside() && !authorization) {
          color_on_off = color_in_ON; 
        } else {
          color_on_off = color_out_ON;
        }
      } else {
        if (inside() && !authorization) {
          color_on_off = color_in_OFF; 
        } else {
          color_on_off = color_out_OFF;
        }
      }
      
      if(pos_label == null) {
        pos_label = ivec2();
      }
      // display text
      if(font != null) textFont(font);
      if(font_size > 0) textSize(font_size);
      textAlign(align);
      fill(color_on_off);
      ivec2 pos_def = iadd(pos,pos_label);
      pos_def.y += size.y ;
      text(this.name,pos_def);
    }  
  }


  /**
  CLASSIC RECT BUTTON
  */
  public void button_rect(boolean on_off_is) {
    noStroke();
    if(on_off_is) {
      if (is) {
        if (inside() && !authorization) {
          color_on_off = color_in_ON; 
        } else {
          color_on_off = color_out_ON;
        }
      } else {
        if (inside() && !authorization) {
          color_on_off = color_in_OFF; 
        } else {
          color_on_off = color_out_OFF;
        }
      }
      fill(color_on_off);
    } else {
      fill(color_bg);
    }  
    rect(pos, size);
  }
}






/**
BUTTON DYNAMIC
*/
public class Button_dynamic extends Button {
  public ivec2 change_pos = ivec2() ;
  public Button_dynamic() {
    super("Button dynamic") ;
  }

  public Button_dynamic(ivec2 pos, ivec2 size) {
    super("Button dynamic",pos, size);
  }
  
  public void change_pos(int x, int y) {
    this.change_pos.set(x,y) ;
  }

  public void update_pos(boolean display_button) {
    if(!display_button) {
      pos.set(-100) ; 
    } else {
      pos.set(pos_ref) ;
      pos.add(change_pos) ;
    }
  }
}
























































/**
SLIDER
v 1.5.6
2013-2019
*/
boolean molette_already_selected ;
public class Slider extends Crope {
  protected boolean selected_type;
  
  protected Molette [] molette;

  private boolean init_molette_is = false ;

  protected ivec2 pos_min, pos_max;

  protected int fill_molette_in = color(g.colorModeX *.4f);
  protected int fill_molette_out = color(g.colorModeX *.2f);
  protected int stroke_molette_in = fill_molette_in;
  protected int stroke_molette_out = fill_molette_out;
  protected float thickness_molette = 0;

  protected float min_norm = 0 ;
  protected float max_norm = 1 ;

  protected int molette_type = RECT;

  boolean notch_is;
  int notches_num;
  int notch;

  public Slider() {
    super("Slider");
    this.pos(ivec2(-1));
    this.size(ivec2(-1));
  }
  
  public Slider(ivec2 pos, ivec2 size) {
    super("Slider");
    this.pos(pos);
    this.size(size);
  }

  public Slider(String type, ivec2 pos, ivec2 size) {
    super(type);
    this.pos(pos);
    this.size(size);
  }





  /**
  MAIN METHOD
  */
  public void update(ivec2 cursor) {
    update(cursor.x,cursor.y);
  }

  public void update(int x, int y) {
    if(!crope_build_is) {
      molette_builder(1);
    }

    cursor(x,y);
    molette_update();
    
  }
  
  private boolean wheel_is;
  public void wheel(boolean wheel_is) {
    if(molette.length == 1) {
      this.wheel_is = wheel_is; 
    } else {
      printErrTempo(60, "method wheel(boolean wheel_is): Work only on mode single slider");
      this.wheel_is = false;
    } 
  }

  public boolean wheel_is() {
    return wheel_is;
  }

  




  /**
  MOLETTE
  */
  protected void molette_update() {
    inside_slider();
    if(molette == null) {
      init_molette(1);
    }
    for(int i = 0 ; i < molette.length ; i++) {
      if(!molette[i].select_is) {
        selected_type = mousePressed;
        molette[i].used_is = select(i,molette_used_is(i),molette[i].used_is,true);
        if(molette[i].used_is) {
          mol_update_pos(i,temp_min(i),temp_max(i));
          mol_update_used(i,temp_min(i),temp_max(i));
          break;
        }   
      }
    }

    if(wheel_is()) {
      if(get_scroll() == null) {
        printErrTempo(60, "class Slider method molette_update(): the wheelEvent is innacessible \nmay be you must use method scroll(MouseEvent e) in void mouseWheel(MouseEvent e)");
      } else {
        if (size.x >= size.y) { 
          molette[0].pos.x -= get_scroll().x;
        } else { 
          molette[0].pos.y -= get_scroll().y;
        }
        mol_update_pos(0,temp_min(0),temp_max(0));
      }   
    }
  }
  

  private void mol_update_used(int index, ivec2 min, ivec2 max) {
    if (molette[index].used_is) {
      if (size.x >= size.y) { 
        molette[index].pos.x = round(constrain(cursor.x -(molette[index].size.x *.5f), min.x, max.x));
      } else { 
        molette[index].pos.y = round(constrain(cursor.y -(molette[index].size.y *.5f), min.y, max.y));
      }
    }
  }


  private void mol_update_pos(int index, ivec2 min, ivec2 max) {
    if(size.x >= size.y) {
      // for the horizontal slider
      if (molette[index].pos.x < min.x) {
        molette[index].pos.x = min.x;
      }
      if (molette[index].pos.x > max.x) {
        molette[index].pos.x = max.x;
      }
    } else {
      // for the vertical slider
      if (molette[index].pos.y < min.y) {
        molette[index].pos.y = min.y;
      }
      if (molette[index].pos.y > max.y) {
        molette[index].pos.y = max.y;
      }
    }
  }

  private ivec2 temp_min(int index) {
    ivec2 min = pos_min.copy();
    // def min
    if(molette.length > 1 && index > 0) {
      min.set(molette[index-1].pos);
      if(molette_type == ELLIPSE) {
       if(size.x >= size.y) {
          min.x += (size.y /2);
        } else {
          min.y += (size.x/2);
        }
      } else {
        if(size.x >= size.y) {
          min.x += size.y;
        } else {
          min.y += size.x;
        }  
      }
    }
    return min;
  }

  private ivec2 temp_max(int index) {
    ivec2 max = pos_max.copy();
     if(molette.length > 1 && index < molette.length -1) {
      max.set(molette[index+1].pos) ;
      if(molette_type == ELLIPSE) {
       if(size.x >= size.y) {
          max.x -= size.y;
        } else {
          max.y -= size.x;
        }
      } else {
        if(size.x >= size.y) {
          max.x -= size.y;
        } else {
          max.y -= size.x;
        }  
      }
    }
    return max;
  }
 





  





  // state information
  public boolean molette_used_is() {
    boolean state = false;
    for(int i = 0 ; i < molette.length; i++) {
      if(molette_used_is(i)){
        state = true;
        break;
      }
    }
    return state;
  }

  public boolean molette_used_is(int index) {
    boolean inside = false ;
    if(molette_type == ELLIPSE) {
      inside = inside_molette_ellipse(index);
    } else {
      inside = inside_molette_rect(index);
    }
    if (inside && selected_type) {
      return true ; 
    } else {
      return false ;
    }
  }


  public boolean molette_inside_is() {
    boolean is = false; 
    for(int i = 0 ; i < molette.length ; i++) {
      if(molette[i].inside_is()) {
        is = true ;
        break;
      }
    }
    return is;
  }


  public boolean molette_inside_is(int index) {
    boolean is = false; 
    if(index >= 0 && index < molette.length) {
      is = molette[index].inside_is();
    }
    return is;
  }




  public boolean select_is() {
    boolean is = false; 
    for(int i = 0 ; i < molette.length ; i++) {
      if(molette[i].select_is()) {
        is = true ;
        break;
      }
    }
    return is;
  }


  public boolean select_is(int index) {
    boolean is = false; 
    if(index >= 0 && index < molette.length) {
      is = molette[index].select_is();
    }
    return is;
  }

  public boolean used_is() {
    boolean is = false; 
    for(int i = 0 ; i < molette.length ; i++) {
      if(molette[i].used_is()) {
        is = true ;
        break;
      }
    }
    return is;
  }


  public boolean used_is(int index) {
    boolean is = false; 
    if(index >= 0 && index < molette.length) {
      is = molette[index].used_is();
    }
    return is;
  }






  boolean keep_selection = true;
  public void keep_selection(boolean state) {

    if(state) {
      this.keep_selection = false;
     } else {
      this.keep_selection = true;
    }
  }

  // select
  public void select(boolean authorization) {
    for(int i = 0 ; i < molette.length ; i++) {
      select(i,authorization);
    }
  }

  private void select(int index, boolean authorization) {
    molette[index].select(keep_selection);
    selected_type = mousePressed;
    molette[index].used_is = select(index, molette_used_is(index),molette[index].used_is,authorization);
  }
  
  //
  public  void select(boolean authorization_1, boolean authorization_2) {
    for(int i = 0 ; i < molette.length ; i++) {
      select(i,authorization_1,authorization_2);
    }
  }

  private void select(int index, boolean authorization_1, boolean authorization_2) {
    molette[index].select(keep_selection);
    selected_type = authorization_1;
    molette[index].used_is = select(index,molette_used_is(index),molette[index].used_is,authorization_2);
  }
  

  // this method is used to switch false all select_is molette
  protected boolean select(boolean locked_method, boolean result, boolean authorization) {
    return select(-1, locked_method,result,authorization);
  }


  // privat method
  protected boolean select(int index, boolean locked_method, boolean result, boolean authorization) {
    if(authorization) {
      if(!molette_already_selected) {
        if (locked_method) {
          molette_already_selected = true;
          result = true;
        }
      } else if(locked_method) {
        if(index == -1) {
          for(int i = 0 ; i < molette.length ;i++) {
            molette[i].select(false);
          }
        } else if(index >= 0 && index < molette.length) {
          molette[index].select(false);
        }
        
        result = true ;
      }

      if (!selected_type) { 
        result = false ; 
        molette_already_selected = false;
      }
      return result;
    } else return false;   
  }









  /**
  MOLETTE SETTING and BUILDING
  */
  private void init_molette(int len) {
    if(molette == null || len != molette.length) {
      molette_builder(len);
    }
  }


  private void molette_builder(int num) {
    molette = new Molette[num]; // create list of molette
    for(int i = 0 ; i < num ; i++) {
      molette[i] = new Molette();
      this.set_pos_molette(i);
      size_molette(i);
      molette[i].id = 0;
      molette[i].used_is = false;
      molette[i].inside_is = false;
      init_molette_is = true;
    }
    set_molette_min_max_pos();
    crope_build_is = true;
  } 

  private Slider set_molette_min_max_pos() {
    for(int i = 0 ; i < molette.length ; i++) {
      if(size.x > size.y) {
        pos_min = pos.copy();
        pos_max = ivec2(pos.x +size.x -molette[i].size.x, pos.y) ;
      } else {
        pos_min = pos.copy();
        pos_max = ivec2(pos.x, pos.y +size.y -molette[i].size.y) ;
      }
    }  
    return this;
  }

  public Slider set_molette(int type) {
    this.molette_type = type;
    return this;
  }


  // set size
  private void size_molette(int index) {
    if (size.x >= size.y) {
      molette[index].size = ivec2(size.y); 
    } else {
      molette[index].size = ivec2(size.x);
    }
  }

  public Slider size_molette(ivec2 size) {
    size_molette(size.x, size.y);
    return this;
  }

  public Slider size_molette(int x, int y) {
    if(molette == null) {
      init_molette(1);
    }
    for(int i = 0 ; i < molette.length ; i++) {
      molette[i].size.set(x,y);
    }
    set_molette_min_max_pos();
    return this;
  }

  // set pos
  public Slider set_pos_molette() {
    for(int i = 0 ; i < molette.length ; i++) {
      set_pos_molette(i);
    }   
    return this;
  }

  public Slider set_pos_molette(int index) {
    this.molette[index].pos.set(pos);
    return this;
  }

  public Slider set_pos_molette(ivec2... pos_mol) {
    init_molette(pos_mol.length);
    for(int i = 0 ; i < molette.length ; i++) {
      if(i < pos_mol.length) {
        set_pos_molette(i,pos_mol[i].x, pos_mol[i].y);
      } else {
        set_pos_molette(i,pos.x,pos.y);
      }
    }
    return this;
  }

  public Slider set_pos_molette(int index, int x, int y) {
    if(index < molette.length) {
      if(molette[index].pos == null) {
        molette[index].pos = ivec2(x,y);
      } else {
        molette[index].pos.set(x,y);
      }
    } 
    return this;
  }

  
  // set_molette
  public Slider set_molette_num(int num) {
    init_molette(num);
    float [] pos_norm = new float[num];
    float step = 1.f / (num+1) ;
    for(int i = 0 ; i < num ; i++) {
      pos_norm[i] = (i+1)*step;
    }
    set_molette_pos_norm(pos_norm);
    return this;
  }

  // Give a normal position between 0 and 1
  public Slider set_molette_pos_norm(float... pos_norm) {
    Arrays.sort(pos_norm);
    init_molette(pos_norm.length);
    for(int i = 0 ; i < molette.length ; i++) {
      molette[i].pos = ivec2();
      molette[i].id = i;
      // security to constrain the value in normalizing range.
      if(pos_norm[i] > 1.f) pos_norm[i] = 1.f;
      if(pos_norm[i] < 0.f) pos_norm[i] = 0.f;
      // check if it's horizontal or vertical slider
      
      if(size.x >= size.y) {;
        int x = round(size.x *pos_norm[i] +pos_min.x -(molette[i].size.y *pos_norm[i])); 
        int y = pos.y;
        molette[i].pos.set(x,y);
      } else {
        int x = pos.x;
        int y = round(size.y *pos_norm[i] +pos_min.y -(molette[i].size.x *pos_norm[i]));
        molette[i].pos.set(x,y);
      }
    }
    return this;
  }
  

  // aspect
  public Slider set_fill_molette(int c) {
    set_fill_molette(c,c);
    return this;
  }

  public Slider set_fill_molette(int c_in, int c_out) {
    this.fill_molette_in = c_in;
    this.fill_molette_out = c_out;
    return this;
  }
  
  public Slider set_stroke_molette(int c) {
    set_stroke_molette(c,c);
    return this;
  }

  public Slider set_stroke_molette(int c_in, int c_out) {
    this.stroke_molette_in = c_in;
    this.stroke_molette_out = c_out;
    return this;
  }

  public Slider set_thickness_molette(float thickness) {
    this.thickness_molette = thickness;
    return this;
  }


  public Slider set_aspect_molette(int f_c, int s_c, float thickness) {
    set_fill_molette(f_c,f_c);
    set_stroke_molette(s_c,s_c);
    set_thickness_molette(thickness);
    return this;
  }

  public Slider set_aspect_molette(int f_c_in, int f_c_out, int s_c_in,  int s_c_out, float thickness) {
    set_fill_molette(f_c_in,f_c_out);
    set_stroke_molette(s_c_in,s_c_out);
    set_thickness_molette(thickness);
    return this;
  }







  // display slider
  public void show_structure() {
    if(thickness > 0 && alpha(stroke_in) > 0 && alpha(stroke_out) > 0) {
      strokeWeight(thickness);
      if(inside_slider()) {
        fill(fill_in);
        stroke(stroke_in);
      } else {
        fill(fill_out);
        stroke(stroke_out);
      }    
    } else {
      noStroke();
      if(inside_slider()) {
        fill(fill_in);
      } else {
        fill(fill_out);
      }
    }

    if(rounded > 0) {
      rect(pos.x,pos.y,size.x,size.y,rounded);
    } else {
      rect(pos,size);
    }
  }


  public void show_molette() {
    for(int i = 0 ; i < molette.length ; i++) {
      if(molette[i].inside_is()) {
        aspect(fill_molette_in,stroke_molette_in,thickness_molette);
        molette_shape(i);
      } else {
        aspect(fill_molette_out,stroke_molette_out,thickness_molette);
        molette_shape(i);
      }   
    }
  }
  
  public void show_label() {
    if(this.name != null) {
      textAlign(align);
      if(font != null) textFont(font);
      if(font_size > 0) textSize(font_size);
      if(inside_slider()) {
        fill(color_label_in);
      } else {
        fill(color_label_out);
      }   
      text(name,add(pos,pos_label));
    }  
  }

  public void show_value() {
    if(this.name != null) {
       textAlign(align);
       if(font != null) textFont(font);
       if(font_size > 0) textSize(font_size);
       if(inside_slider()) {
        fill(color_label_in);
      } else {
        fill(color_label_out);
      }


      String value = "[ ";
      for(int i = 0 ; i < get().length ; i++) {
        float f = truncate(get()[i],2);
        value += f;
        if(i < get().length -1) value += ",";
      }
      value += " ]";
      vec2 final_pos = add(pos,pos_label);
      final_pos.y += font_size;
      text(value,final_pos);
    }
  }

  public void show_value(float... external_value) {
    if(this.name != null) {
       textAlign(align);
       if(font != null) textFont(font);
       if(font_size > 0) textSize(font_size);
       if(inside_slider()) {
        fill(color_label_in);
      } else {
        fill(color_label_out);
      }


      String value = "[ ";
      for(int i = 0 ; i < external_value.length ; i++) {
        float f = truncate(external_value[i],2);
        value += f;
        if(i < external_value.length -1) value += ",";
      }
      value += " ]";
      vec2 final_pos = add(pos,pos_label);
      final_pos.y += font_size;
      text(value,final_pos);
    }
  }


  
  private void molette_shape(int index) {
    if(molette_type == ELLIPSE) {
      ivec2 temp = ivec2(round(mult(molette[index].size,.5f)));
      ivec2 pos = iadd(molette[index].pos,temp);
      ellipse(pos,molette[index].size);
    } else if(molette_type == RECT) {
      molette_rect(index);
    } else {
      molette_rect(index);
    }
  }
  

  private void molette_rect(int index) {
    if(size.x > size.y) {
      ivec2 pos = molette[index].pos.copy();
      pos.y = pos.y -((molette[index].size.y -size.y)/2);
      rect(pos,molette[index].size);
    } else {
      ivec2 pos = molette[index].pos;
      pos.x = pos.x -((molette[index].size.x -size.x)/2);
      rect(pos,molette[index].size);
    }
  }
  





  
  // inside slider
  public boolean inside_slider() {
    if(inside(pos,size,cursor,RECT)) {
      return true ; 
    } else {
      return false ;
    }
  }
  
  // inside molette
  public boolean inside_molette_rect() {
    boolean state = false;
    for(int i = 0 ; i < molette.length; i++) {
      if(inside_molette_rect(i)) {
        state = true;
        break;
      }
    }
    return state;
  }

  public boolean inside_molette_rect(int index) {
    if(inside(molette[index].pos,molette[index].size,cursor,RECT)) {
      molette[index].inside_is = true ; 
    } else {
      molette[index].inside_is = false ;
    }
    return molette[index].inside_is;
  }
  
  public boolean inside_molette_ellipse() {
    boolean state = false;
    for(int i = 0 ; i < molette.length; i++) {
      if(inside_molette_ellipse(i));
      state = true;
      break;
    }
    return state;
  }

  public boolean inside_molette_ellipse(int index) {
    if(cursor == null) cursor = ivec2();
    float radius = molette[index].size.x ;
    int posX = PApplet.parseInt(radius *.5f +molette[index].pos.x ); 
    int posY = PApplet.parseInt(size.y *.5f +molette[index].pos.y);
    if(pow((posX -cursor.x),2) + pow((posY -cursor.y),2) < pow(radius,sqrt(3))) {
      molette[index].inside_is = true ; 
    } else {
      molette[index].inside_is = false ;
    }
    return molette[index].inside_is;
  }





  // update position from midi controller
  //update the Midi position only if the Midi Button move
  public void update_midi(int... val) {
    if(val.length > molette.length) {
      printErr("method_midi(): there is too much midi value for the quantity of molette available.\nmethod apply only when is possible");
    }
    for(int i = 0 ; i < molette.length ; i++) {
      if(i < val.length) {
        update_midi(i, val[i]);
      } 
    }
  }

  public void update_midi(int index, int val) {
    //update the Midi position only if the Midi Button move
    if (new_midi_value != val) { 
      molette[index].new_midi_value = val ; 
      if(size.x >= size.y) {
        molette[index].pos.x = round(map(val, 1, 127, pos_min.x, pos_max.x));
      } else {
        molette[index].pos.y = round(map(val, 1, 127, pos_min.y, pos_max.y));
      }
    }
  }







  /**
  GET
  */
  public float [] get() {
    int num = 1;
    if(molette != null) {
      num = molette.length;
    }
    float [] value = new float[num];
    for(int i = 0 ; i < value.length ; i++) {
      value[i] = get(i);
    }
    return value;
  }

  public float get(int index) {
    float value = 0;
    if(molette != null && index < molette.length 
      && pos_min.x > 0 && pos_min.y > 0 && pos_max.x > 0 && pos_max.y > 0) {
      if (size.x >= size.y) {
        value = map(molette[index].pos.x,pos_min.x,pos_max.x,min_norm,max_norm); 
      } else {
        value = map(molette[index].pos.y,pos_min.y,pos_max.y,min_norm,max_norm);
      }
    }
    return value ;
  }
  
  public float get_min_norm() {
    return min_norm ;
  }

  public float get_max_norm() {
    return max_norm ;
  }
  
  public ivec2 get_min_pos() {
    return pos_min;
  }

  public ivec2 get_max_pos() {
    return pos_max;
  }

  

  public ivec2 [] get_molette_pos() {
    ivec2 [] pos = new ivec2[molette.length] ;
    for(int i = 0 ; i < molette.length ;i++) {
      pos[i] = molette[i].pos.copy();
    }
    return pos;
  }

  public ivec2 get_molette_pos(int index) {
    if(index < molette.length && index >= 0) {
      return molette[index].pos;
    } else {
      printErr("method get_molette_pos(",index,") is out of the range");
      return null;
    }
  }

  public ivec2 get_molette_size(int index) {
    return molette[index].size;
  }


  public boolean inside_molette_is(int index) {
    return molette[index].inside_is;
  }
  

  // class Molette
  private class Molette {
    protected ivec2 size = ivec2();
    protected ivec2 pos = ivec2();
    protected int id =0;


    protected int new_midi_value;
    protected int id_midi = -2 ;

    protected boolean select_is;
    protected boolean used_is;
    protected boolean inside_is;

    Molette() { }


    private boolean select_is() {
      return select_is;
    }

    private boolean used_is() {
      return used_is;
    }

    private boolean inside_is() {
      return inside_is;
    }



    private void select(boolean state) {
      select_is = state;
    }

    private void used(boolean state) {
      used_is = state;
    }

    private void inside(boolean state) {
      inside_is = state;
    }
  }
}






















/**
SLOTCH > notch's slider
v 0.1.0
2018-2018
*/
public class Slotch extends Slider {
  float [] notches_pos ;
  int colour_notch = PApplet.parseInt(g.colorModeX);
  float thickness_notch = 1.f;
  Slotch(ivec2 pos, ivec2 size) {
    super("Slotch",pos, size);   
  }




  public void update(int x, int y) {
    cursor(x,y);
    molette_update();
    if (size.x >= size.y) { 
      if(notch_is) {
        for(int i = 0 ; i < molette.length ; i++) {
          molette[i].pos.x = (int)pos_notch(size.x, molette[i].pos.x);
        }
        
      }
    } else { 
      if(notch_is) {
        for(int i = 0 ; i < molette.length ; i++) {
          molette[i].pos.y = (int)pos_notch(size.y, molette[i].pos.y);
        }
      }
    }
  }



  public Slotch set_notch(int num) {
    notch_is = true ;
    this.notches_num = num;
    notches_position();
    return this;
  }

  public Slotch set_aspect_notch(int c, float thickness) {
    this.colour_notch = c ;
    this.thickness_notch = thickness;
    return this;
  }

  public Slotch set_aspect_notch(int c) {
    this.colour_notch = c ;
    return this;
  }

  private float pos_notch(int size, int pos_molette) {
    /**
    something must be improve when there is 3 notches
    */
    float pos = pos_molette;
    float step = size / get_notches_num();
    for(int i = 0 ; i < notches_pos.length ; i++) {
      float min = notches_pos[i] - (step *.5f);
      float max = notches_pos[i] + (step *.5f);
      if(pos > min && pos < max) {
        pos = notches_pos[i];
        break;
      }
    }
    return pos;
  }




  public float [] notches_position() {
    notches_pos = new float[get_notches_num()];
    float step = size.x / get_notches_num();
    for(int i = 0 ; i < get_notches_num(); i++) {
      notches_pos[i] = (i+1) *step -(step*.5f);
    }
    return notches_pos;
  }
  
  public void show_notch() {
    show_notch(0,0);
  }

  public void show_notch(int start, int stop) {
    stroke(colour_notch);
    noFill();
    strokeWeight(thickness_notch);
    if (size.x >= size.y) {
      start += pos.y ;
      stop += size.y;
      for(int i = 0 ; i < notches_pos.length ; i++) {
        float abs_pos = notches_pos[i];
        line(pos.x +abs_pos,start,pos.x +abs_pos,start +stop);
      }
    } else {
      start += pos.x ;
      stop += size.x;
      for(int i = 0 ; i < notches_pos.length ; i++) {
        float abs_pos = notches_pos[i];
        line(start,pos.y +abs_pos,start+stop,pos.y +abs_pos);
      }
    } 
  }



  public int get_notch() {
    return notch;
  }

  public int get_notches_num() {
    return notches_num;
  }
} 
























/**
SLADJ > SLIDER ADJUSTABLE
v 1.3.0
2016-2018
*/
public class Sladj extends Slider {
  // size
  protected ivec2 size_min_max;
  protected ivec2 size_molette_min_max;
  // pos  
  protected ivec2 new_pos_min;
  protected ivec2 new_pos_max;


  private vec2 pos_norm_adj = vec2(1,.5f);
  private vec2 size_norm_adj = vec2(1.f,.2f);

  protected int fill_adj_in = color(g.colorModeX/2);
  protected int fill_adj_out = color(g.colorModeX /4);
  protected int stroke_adj_in = color(g.colorModeX/2);
  protected int stroke_adj_out = color(g.colorModeX /4);
  protected float thickness_adj = 0;

  private boolean locked_min, locked_max;
    
  Sladj(ivec2 pos, ivec2 size) {
    super("Sladj",pos, size);
    this.new_pos_max = ivec2();
    this.new_pos_min = pos.copy();
    this.size_min_max = size.copy();

    if (size.x >= size.y) {
      this.size_molette_min_max = ivec2(size.y); 
    } else {
      this.size_molette_min_max = ivec2(size.x) ;
    }
  }
  /*
  //slider with external molette
  public Sladj(ivec2 pos, ivec2 size, ivec2 size_molette, int moletteShapeType) {
    super(pos,size);
    size_molette(size_molette);
    set_molette(moletteShapeType);
    this.new_pos_max = ivec2();
    this.new_pos_min = ivec2();
    this.size_min_max = size.copy();
    this.size_molette_min_max = ivec2(size_molette);
  }
  */



  public Sladj set_fill_adj(int c) {
    set_fill_adj(c,c);
    return this;
  }

  public Sladj set_fill_adj(int c_in, int c_out) {
    this.fill_adj_in = c_in;
    this.fill_adj_out = c_out;
    return this;
  }
  
  public Sladj set_stroke_adj(int c) {
    set_stroke_adj(c,c);
    return this;
  }

  public Sladj set_stroke_adj(int c_in, int c_out) {
    this.stroke_adj_in = c_in;
    this.stroke_adj_out = c_out;
    return this;
  }

  public Sladj set_thickness_adj(float thickness) {
    this.thickness_adj = thickness;
    return this;
  }


  
  
  
  /**
  METHOD
  */
  public void update_min_max() {
    float newNormSize = max_norm -min_norm ;
    
    if (size.x >= size.y) size_min_max = ivec2(round(size.x *newNormSize), size.y) ; else size_min_max = ivec2(round(size.y *newNormSize), size.x) ;
    
    pos_min = ivec2(round(pos.x +(size.x *min_norm)), pos.y) ;
    // in this case the detection is translate on to and left of the size of molette
    // we use the molette[0] to set the max. there is at least one molette by slider :)
    pos_max = ivec2(round(pos.x -molette[0].size.x +(size.x *max_norm)), pos.y); 
  }
  


  public boolean locked_min_is() {
    return locked_min;
  }

  public boolean locked_max_is() {
    return locked_max;
  }
  
  // update min
  public void select_min(boolean authorization) {
    locked_min = select(locked_min(), locked_min, authorization) ;
  }
  public void update_min() {
    // we use the molette[0] to set the max. there is at least one molette by slider :)
    float arbitrary_value = 1.5f;
    float range = molette[0].size.x * arbitrary_value;
    
    if (locked_min) {
      if (size.x >= size.y) {
        // security
        if (new_pos_min.x < pos_min.x ) new_pos_min.x = pos_min.x ;
        else if (new_pos_min.x > pos_max.x -range) new_pos_min.x = round(pos_max.x -range);
        
        new_pos_min.x = round(constrain(cursor.x, pos.x, pos.x+size.x -range)); 
        // norm the value to return to method minMaxSliderUpdate
        min_norm = map(new_pos_min.x, pos_min.x, pos_max.x, min_norm,max_norm) ;
      } else new_pos_min.y = round(constrain(cursor.y -size_min_max.y, pos_min.y, pos_max.y)); // this line is not reworking for the vertical slider
    }
  }
  
  // update max
  public void select_max(boolean authorization) {
    locked_max = select(-1,locked_max(), locked_max, authorization) ;
  }
  // update maxvalue
  public void update_max() {
    float arbitrary_value = 1.5f;
    float range = molette[0].size.x * arbitrary_value;
    
    if (locked_max) {  // this line is not reworking for the vertical slider
      if (size.x >= size.y) {
        // security
        if (new_pos_max.x < pos_min.x +range)  {
          new_pos_max.x = round(pos_min.x +range);
        } else if (new_pos_max.x > pos_max.x ) {
          new_pos_max.x = pos_max.x;
        }
        new_pos_max.x = round(constrain(cursor.x -(size.y *.5f) , pos.x +range, pos.x +size.x -(size.y *.5f))); 
         // norm the value to return to method minMaxSliderUpdate
        pos_max = ivec2(round(pos.x -molette[0].size.x +(size.x *max_norm)), pos.y) ;
        // we use a temporary position for a good display of the max slider 
        vec2 tempPosMax = vec2(pos.x -(size.y *.5f) +(size.x *max_norm), pos_max.y) ;
        max_norm = map(new_pos_max.x, pos_min.x, tempPosMax.x, min_norm, max_norm) ;
      } else {
        new_pos_max.y = round(constrain(cursor.y -size_min_max.y, pos_min.y, pos_max.y)); // this line is not reworking for the vertical slider
      }
    }
    
  }
  
  // set min and max position
  public Sladj set_min_max(float min_norm, float max_norm) {
    min_norm = min_norm;
    max_norm = max_norm;
    return this;
  }

  public Sladj set_min(float min_norm) {
    min_norm = min_norm;
    return this;
  }

  public Sladj set_max(float max_norm) {
    max_norm = max_norm;
    return this;
  }
  
  
  
  
  
  
  
  
  
  // Display classic
  public void show_adj() {
    strokeWeight(thickness_adj) ;
    if(locked_min || locked_max || inside_max() || inside_min()) {
      aspect(fill_adj_in,stroke_adj_in,thickness_adj);
    } else {
      aspect(fill_adj_out,stroke_adj_out,thickness_adj);
    }

    vec2 pos = vec2(pos_min.x, pos_min.y +size_min_max.y *pos_norm_adj.y);
    vec2 size = vec2(size_min_max.x, size_min_max.y *size_norm_adj.y);
    rect(pos,size);
  }
  
  

  // INSIDE
  private boolean inside_min() {
    int x = round(pos_min.x);
    int y = round(pos_min.y +size_min_max.y *pos_norm_adj.y) ;
    ivec2 temp_pos_min = ivec2(x,y);
    if(inside(temp_pos_min,size_molette_min_max,cursor,RECT)) return true ; else return false ;
  }
  
  private boolean inside_max() {
    int x = round(pos_max.x);
    int y = round(pos_max.y +size_min_max.y *pos_norm_adj.y) ;
    ivec2 temp_pos_max =  ivec2(x,y);
    if(inside(temp_pos_max, size_molette_min_max,cursor,RECT)) return true ; else return false ;
  }
  
  //LOCKED
  private boolean locked_min() {
    if (inside_min() && mousePressed) {
      return true; 
    } else {
      return false;
    }
  }
  
  private boolean locked_max() {
    if (inside_max() && mousePressed) {
      return true; 
    } else {
      return false;
    }
  }
}






















/**
* CROPE DROPDOWN 
* v 0.2.1
* 2018-2019
* method to know is dropdown is active or not
* Add dropdown must use when the dropdown is build.
*/

public boolean dropdown_is() {
  boolean locked = false ;
  for(Crope crope : get_crope()) {
    if(crope != null) {
      if(crope instanceof Dropdown) {
        Dropdown dd = (Dropdown) crope;
        if(dd.locked_is()) {
          locked = true;
          break;
        }
      }
    }   
  } 
  return locked;
}


/**
* DROPDOWN class
* v 2.6.0
* 2014-2018
*/
public class Dropdown extends Crope {
  protected boolean selected_type;
  //Slider dropdown
  private Slider slider_dd;
  private ivec2 size_box;
  // font
  private PFont font_box;
  //dropdown
  private int line = 0;
  private String content[];

  private boolean locked;
  private boolean slider;
  // private boolean inside_box;
  // color
  private int colour_structure = r.GRAY_2;

  private int colour_box_in = r.GRAY_6;
  private int colour_box_out = r.GRAY_9;

  private int colour_header_in = r.GRAY_6;
  private int colour_header_out = r.GRAY_9; 

  private int colour_header_text_in = r.GRAY_2;
  private int colour_header_text_out = r.GRAY_4;

  private int colour_box_text_in = r.GRAY_2;
  private int colour_box_text_out = r.GRAY_4;


  private ivec2 pos_header_text;
  private ivec2 pos_box_text;

  private int pos_ref_x, pos_ref_y ;
  private ivec2 change_pos;
  // private float factorPos; // use to calculate the margin between the box
  // box
  private int height_box;
  private int num_box;



  private int start = 0 ;
  private int end = 1 ;
  private int offset_slider = 0 ; //for the slider update
  private float missing ;

  private int box_starting_rank_position = 1;

  private boolean wheel_is = false;

  /**
  CONSTRUCTOR
  */
  public Dropdown(ivec2 pos, ivec2 size, String name, String [] content) {
    super("Dropdown");
    int size_header_text = PApplet.parseInt(size.y *.6f);
    this.font = createFont("defaultFont",size_header_text);
    int size_content_text = PApplet.parseInt(size.y *.6f);
    this.font_box = createFont("defaultFont",size_content_text);
    this.name = name; 
    this.pos = pos.copy();
    pos_ref_x = pos.x;
    pos_ref_y = pos.y;
    this.size = size.copy(); // header size

    set_box(content.length);
    set_content(content);
    set_box_height(size.y);
    
    int offset_text_x = 2 ;
    int offset_text_header_y = (size.y - size_header_text)/2;
    set_header_text_pos(offset_text_x,size.y -offset_text_header_y);
    int offset_text_content_y = (size_box.y - size_content_text)/2;
    set_box_text_pos(offset_text_x,size_box.y - offset_text_content_y); 
    selected_type = mousePressed;
  }


  public Dropdown set_header_text_pos(ivec2 pos) {
    set_header_text_pos(pos.x, pos.y);
    return this;
  }

  public Dropdown set_header_text_pos(int x, int y) {
    if(pos_header_text == null) {
      this.pos_header_text = ivec2(x,y);
    } else {
      this.pos_header_text.set(x,y);
    }
    return this;
  }


  public Dropdown set_box_text_pos(ivec2 pos) {
    set_box_text_pos(pos.x, pos.y);
    return this;
  }

  public Dropdown set_box_text_pos(int x, int y) {
    if(pos_box_text == null) {
      this.pos_box_text = ivec2(x,y);
    } else {
      this.pos_box_text.set(x,y);
    }
    return this;
  }



  public Dropdown set_colour(ROPE_colour rc) {
    this.colour_structure = rc.get_colour()[0];

    this.colour_header_in = rc.get_colour()[1];
    this.colour_header_out = rc.get_colour()[2];

    this.colour_header_text_in = rc.get_colour()[3];
    this.colour_header_text_out = rc.get_colour()[4];

    this.colour_box_in = rc.get_colour()[5];
    this.colour_box_out = rc.get_colour()[6]; 

    this.colour_box_text_in = rc.get_colour()[7];
    this.colour_box_text_out = rc.get_colour()[8];
    return this;
  }




  /**
  method
  */
  public void wheel(boolean wheel_is) {
    this.wheel_is = wheel_is;
  }

  public Dropdown set_box(int num_box) {
    set_box(num_box, this.box_starting_rank_position);
    return this;
  }

  public Dropdown set_box(int num_box, int rank) {
    this.num_box = num_box;
    this.box_starting_rank_position = rank;
    if(content != null && num_box != content.length) {
      set_num_box_rendering(true);
    }
    return this;
  }

  public Dropdown set_box_rank(int rank) {
    this.box_starting_rank_position = rank;
    return this;
  }

  public Dropdown set_box_height(int h) {
    this.height_box = h;
    if(size_box == null) {
      size_box = ivec2(longest_String_pixel(font_box,this.content), this.height_box);
    } else {
      size_box.set(ivec2(longest_String_pixel(font_box,this.content), this.height_box));
    }
    return this;
  }

  public Dropdown set_box_width(int w) {
    size_box.set(w,size_box.y);
    return this;
  }



  public Dropdown set_box_font(String font_name, int size) {
    this.font_box = createFont(font_name,size);
    return this;
  }
  
  public Dropdown set_box_font(PFont font) {
    this.font_box = font;
    return this;
  }

  // content
  public Dropdown set_content(String [] content) {
    boolean new_slider = false ;
    if(this.content == null || this.content.length != content.length) {
      new_slider = true ;
    }
   
    this.content = content;
    set_num_box_rendering(new_slider);
    return this;
  }


  public Dropdown set_name(String name) {
    this.name = name;
    return this;
  }


  private Dropdown set_num_box_rendering(boolean new_slider_is) {
    end = num_box;
    if (content != null) {
      if (end > content.length) {
        end = content.length;
      }
      missing = content.length -end;
      if (content.length > end) {
        slider = true; 
      } else {
        slider = false;
      }
    }

    if (slider && (slider_dd == null || new_slider_is)) {
      update_slider();
    }
    return this;
  }


  private void update_slider() {
    ivec2 size_slider = ivec2(round(height_box *.5f), round((end *height_box) -pos.z));
    int x = pos.x -size_slider.x;
    int y = pos.y +(height_box *box_starting_rank_position);
    ivec2 pos_slider = ivec2(x,y);
  
    float ratio = PApplet.parseFloat(content.length) / PApplet.parseFloat(end -1);
    
    ivec2 size_molette =  ivec2(size_slider.x, round(size_slider.y /ratio));
    
    boolean keep_pos_mol_is = false;
    int index = 0 ; // so catch the first molette of the index ;
    int pos_mol_y = 0;
    if(slider_dd != null) {
      pos_mol_y = slider_dd.get_molette_pos(index).y;
      keep_pos_mol_is = true ;
    }

    if(slider_dd == null) {
      slider_dd = new Slider("Slider Dropdown",pos_slider, size_slider);
    } else {
      slider_dd.pos(pos_slider);
      slider_dd.size(size_slider);
      slider_dd.set_pos_molette();
    }
    slider_dd.size_molette(size_molette);
    if(keep_pos_mol_is) {
      int pos_mol_x = slider_dd.get_molette_pos(index).x;
      slider_dd.set_pos_molette(index,pos_mol_x,pos_mol_y);
    }
    slider_dd.set_molette(RECT);
    slider_dd.set_fill(colour_structure);
    slider_dd.set_fill_molette(colour_box_in,colour_box_out);
    slider_dd.wheel(wheel_is);
  }

  public void offset(int x, int y) {
    pos.set(pos_ref_x, pos_ref_y);
    ivec2 temp = ivec2(x,y);
    pos.add(temp);
    update_slider();
  }

  public void offset(ivec2 offset) {
    offset(offset.x, offset.y);
  }

  public void update(int x,int y) {
    cursor(x,y);
    selected_type = mousePressed;
    open_dropdown(); 
  }



  private void open_dropdown() {
    boolean inside = inside(get_pos(), get_size(),cursor,RECT);
    if (inside) {
      if(selected_type) {
        locked = true;
      }
    } else if(!inside && selected_type && slider_dd == null) {
      locked = false;
    } else if(!inside && selected_type && slider_dd != null && !slider_dd.inside_slider()) {
      locked = false;
    }
    if(locked) {
      int result_line = get_select_line();
      if (result_line > -1) {
        line = result_line; 
      }
    }
  }


  private int get_select_line() {
    int content_size_y = ((content.length+1) *size.y) +pos.y;
    // very quick bug fix, for the case there is only two item in thelist
    if(content.length == 2) {
      content_size_y = ((content.length+2) *size.y) +pos.y;
    }
    if(cursor.x >= pos.x 
      && cursor.x <= pos.x +size_box.x 
      && cursor.y >= pos.y && cursor.y <= content_size_y) {
      //choice the line
      int line = floor((cursor.y - (pos.y +size.y)) / size.y ) +offset_slider;
      line -= (box_starting_rank_position -1);
      return line;
    } else {
      return -1; 
    }
  }




  /**
  SHOW
  */
  public void show() {
    show_header();
    show_header_text();
    show_box();
  }

  private void show_selection(int x,int y) {
    if (inside(pos,size,cursor,RECT)) {
      fill(colour_header_text_in); 
    } else {
      fill(colour_header_text_out);
    }
    textFont(font);
    if(get_content().length > 0 && get_content()[get_selection()] != null) {
      text(get_content()[get_selection()], x, y);
    } else {
      text("empty",x,y);
    }
  }
  
  public void show_header() {
    noStroke();
    if (inside(pos,size,cursor,RECT)) {
      fill(colour_header_in); 
    } else {
      fill(colour_header_out);
    }
    rect(get_pos(),get_size());
  }

  public void show_header_text(String name) {
    if(name != null) {
      if (inside(pos,size,cursor,RECT)) {
        fill(colour_header_text_in); 
      } else {
        fill(colour_header_text_out);
      }
      textFont(font);
      text(name, pos.x +pos_header_text.x, pos.y +pos_header_text.y);
    }
  }

  public void show_header_text() {
    show_header_text(this.name);
  }


  public void show_box() {
    if(locked) {
      int step = box_starting_rank_position;
      int index = 0; // first pos molette from the array pos molette
      //give the position in list of Item with the position from the slider's molette
      if (slider) {
        offset_slider = round(map(slider_dd.get(index),0,1,0,missing));
      }
      set_box_width(longest_String_pixel(font_box,this.content));
      for (int i = start +offset_slider ; i < end +offset_slider ; i++) {
        
        if(i < 0) {
          i = 0 ;
        }

        if(i >= content.length) {
          i = content.length -1;
        }
        
        float pos_temp_y = pos.y + (size_box.y *step);
        ivec2 temp_pos = ivec2(pos.x, (int)pos_temp_y);
        boolean inside = inside(temp_pos,size_box,cursor,RECT);
        render_box(temp_pos,content[i],step,inside);
        step++;


        if (slider) {
          int x = pos.x -slider_dd.get_size().x;
          int y = pos.y +(height_box *box_starting_rank_position);
          slider_dd.pos(x,y);
          //slider_dd.select(false);
          slider_dd.update(cursor);
          slider_dd.show_structure();
          slider_dd.show_molette();
        }
      }
    }
  }

  private void render_box(ivec2 pos, String content, int step, boolean inside) {
    if(content != null) {
    // box part
      noStroke() ;  
      if (inside) {
        fill(colour_box_in); 
      } else {
        fill(colour_box_out);
      }
      int min = 60 ;
      int max = 300 ;
      if (size_box.x < min ) {
        size_box.x = min; 
      } else if(size_box.x > max ) {
        size_box.x = max;
      }
      rect(pos,size_box); 
      // text part
      if (inside(pos,size_box,cursor,RECT)) {
        fill(colour_box_text_in); 
      } else {
        fill(colour_box_text_out);
      }
      textFont(font_box);
      int x = pos.x +pos_box_text.x;
      int y = pos.y +height_box -(ceil(height_box*.2f));
      text(content,x,y);
    }
  }





  
  
  /**
  GET
  */
  //return which line of dropdown is selected
  int current_line ;
  public int get_selection() {
    float size_temp_y = size_box.y *num_box;
    ivec2 temp_size = ivec2(size_box.x, (int)size_temp_y);
    ivec2 temp_pos = pos.copy();
    temp_pos.y += (box_starting_rank_position *height_box);
    boolean inside_open_box = inside(temp_pos,temp_size,cursor,RECT);
    if(!inside_open_box) {
      line = current_line;
    }
    if(!locked && inside_open_box) {
      if(line >= 0 && line < content.length) {
        current_line = line ;     
      } else {
        printErr("class Dropdown - method get_selected()\nthe line", line, "don't match with any content, the method keep the last content");
      }
    } 
    return current_line;
  }


  //return which line of dropdown is highlighted
  public int get_highlight() {
    return line ;
  }

  public String get_name() {
    return this.name;
  }


  public String [] get_content() {
    return content;
  }

  public int get_num_box() {
    return num_box;
  }

  public PFont get_font_box() {
    return font_box;
  }

  public ivec2 get_header_text_pos() {
    return pos_header_text;
  }

  public ivec2 get_content_text_pos() {
    return pos_box_text;
  }

  public boolean locked_is() {
    return locked;
  }
}

/**
* ROPE IMAGE
v 0.3.1
* Copyleft (c) 2014-2019
* Stan le Punk > http://stanlepunk.xyz/
Rope – Romanesco Processing Environment – 
Processing 3.4
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/









/**
PATTERN GENERATOR
v 0.0.2
2018-2018
*/
public PGraphics pattern_noise(int w, int h, float... inc) {
  PGraphics pg ;
  noiseSeed((int)random(MAX_INT));
  if(w > 0 && h > 0 && inc.length > 0 && inc.length < 5) {
    pg = createGraphics(w,h);
    float offset_x [] = new float[inc.length];
    float offset_y [] = new float[inc.length];
    float component [] = new float[inc.length];
    float max [] = new float[inc.length];
    if(inc.length == 1) {
      max[0] = g.colorModeZ;
    } else if (inc.length == 2) {
      max[0] = g.colorModeZ;
      max[1] = g.colorModeA;
    } else if (inc.length == 3) {
      max[0] = g.colorModeX;
      max[1] = g.colorModeY;
      max[2] = g.colorModeZ;
    } else if (inc.length == 4) {
      max[0] = g.colorModeX;
      max[1] = g.colorModeY;
      max[2] = g.colorModeZ;
      max[3] = g.colorModeA;
    }

    
    pg.beginDraw();
    for(int i = 0 ; i < inc.length ; i++) {
      offset_y[i] = 0;
    }
    
    for(int x = 0 ; x < w ; x++) {
      for(int i = 0 ; i < inc.length ; i++) {
        offset_x[i] = 0;
      }
      for(int y = 0 ; y < h ; y++) {
        for(int i = 0 ; i < inc.length ; i++) {
          component[i] = map(noise(offset_x[i],offset_y[i]),0,1,0,max[i]);
        }
        int c = 0;
        if(inc.length == 1) c = color(component[0]);
        else if (inc.length == 2) c = color(component[0],component[1]);
        else if (inc.length == 3) c = color(component[0],component[1],component[2]);
        else if (inc.length == 4) c = color(component[0],component[1],component[2],component[3]);

        pg.set(x,y,c);
        for(int i = 0 ; i < inc.length ; i++) {
          offset_x[i] += inc[i];
        }
      }
      for(int i = 0 ; i < inc.length ; i++) {
        offset_y[i] += inc[i];
      }
    }
    pg.endDraw();
    return pg;
  } else {
    printErr("method pattern_noise(): may be problem with size:",w,h,"\nor with component color num >>>",inc.length,"<<< must be between 1 and 4");
    return null;
  }
}











/**
LAYER
v 0.1.0
2018-2018
*/
PGraphics [] rope_layer;
boolean warning_rope_layer;
int which_rope_layer = 0;

// init
public void init_layer() {
  init_layer(width,height,get_renderer(),1);
}

public void init_layer(int num) {
  init_layer(width,height,get_renderer(),num);
}

public void init_layer(int x, int y) {
  init_layer(x,y, get_renderer(),1);
}

public void init_layer(int x, int y, int num) {
  init_layer(x,y, get_renderer(),num);
}

public void init_layer(int x, int y, String type, int num) {
  rope_layer = new PGraphics[num];
  for(int i = 0 ; i < num ; i++) {
    rope_layer[i] = createGraphics(x,y,type);
  }
  
  if(!warning_rope_layer) {
    warning_rope_layer = true;
  }
  String warning = ("WARNING LAYER METHOD\nAll classical method used on the main rendering,\nwill return the PGraphics selected PGraphics layer :\nimage(), set(), get(), fill(), stroke(), rect(), ellipse(), pushMatrix(), popMatrix(), box()...\nto use those methods on the main PGraphics write g.image() for example");
  printErr(warning);
}

// begin and end draw
public void begin_layer() {
  if(get_layer() != null) {
    get_layer().beginDraw();
  }
}

public void end_layer() {
  if(get_layer() != null) {
    get_layer().endDraw();
  }
}



// num
public int get_layer_num() {
  if(rope_layer != null) {
    return  rope_layer.length ;
  } else return -1;  
}


// clear layer
public void clear_layer() {
  if(rope_layer != null && rope_layer.length > 0) {
    for(int i = 0 ; i < rope_layer.length ; i++) {
      String type = get_renderer(rope_layer[i]);
      int w = rope_layer[i].width;
      int h = rope_layer[i].height;
      rope_layer[i] = createGraphics(w,h,type);
    }
  } else {
    String warning = ("void clear_layer(): there is no layer can be clear maybe you forget to create one :)");
    printErr(warning);
  }
  
}

public void clear_layer(int target) {
  if(target > -1 && target < rope_layer.length) {
    String type = get_renderer(rope_layer[target]);
    int w = rope_layer[target].width;
    int h = rope_layer[target].height;
    rope_layer[target] = createGraphics(w,h,type);
  } else {
    String warning = ("void clear_layer(): target "+target+" is out the range of the layers available,\n no layer can be clear");
    printErr(warning);
  }
}




/**
GET LAYER
* May be the method can be improve by using a PGraphics template for buffering instead usin a calling method ????
*/
// get layer
public PGraphics get_layer() {
  return get_layer(which_rope_layer);
}


public PGraphics get_layer(int target) {
  if(rope_layer == null) {
//    printErrTempo(180,"void get_layer(): Your layer system has not been init use method init_layer() in first",frameCount);
    return g;
  } else if(target > -1 && target < rope_layer.length) {
    return rope_layer[target];
  } else {
    String warning = ("PGraphics get_layer(int target): target "+target+" is out the range of the layers available,\n instead target 0 is used");
    printErr(warning);
    return rope_layer[0];
  }
}

// select layer
public void select_layer(int target) {
  if(rope_layer != null) {
    if(target > -1 && target < rope_layer.length) {
      which_rope_layer = target;
    } else {
      which_rope_layer = 0;
      String warning = ("void select_layer(int target): target "+target+" is out the range of the layers available,\n instead target 0 is used");
      printErr(warning);
    }
  } else {
    printErrTempo(180,"void select_layer(): Your layer system has not been init use method init_layer() in first",frameCount);
  } 
}





















/**
PImage manager library
v 0.4.2
*/
class ROPImage_Manager {
  ArrayList<ROPImage> library ;
  int which_img;

  private void build() {
    if(library == null) {
      library = new ArrayList<ROPImage>();
    }
  }

  public void load(String... path_img) {
    build();
    for(int i = 0 ; i <path_img.length ; i++) {
      //Image img = loadImage(img_src[i]);
      ROPImage rop_img = new ROPImage(path_img[i]);
      //println(img.width, img_src[i]);
      library.add(rop_img);
    }  
  }

  public void add(PImage img_src) {
    build();
    ROPImage rop_img = new ROPImage(img_src);
    library.add(rop_img);
  }

  public void add(PImage img_src, String name) {
    build();
    ROPImage rop_img = new ROPImage(img_src, name);
    library.add(rop_img);
  }

  public void clear() {
    if(library != null) {
      library.clear();
    }
  }

  public ArrayList<ROPImage> list() {
    return library;
  }

  public void select(int which_one) {
    which_img = which_one ;
  }

  public void select(String target_name) {
    if(library.size() > 0) {
      for(int i = 0 ; i < library.size() ; i++) {
        if(target_name.equals(library.get(i).name)) {
          which_img = i ;
          break ;
        }
      }
    } else {
      printErr("the String target name don't match with any name of image library") ;
    }
  }


  public int size() {
    if(library != null) {
      return library.size() ;
    } else return -1 ;  
  }

  public void set(PImage src_img, int target) {
    build();
    if(target < library.size()) {
      if(src_img.width == get(target).width && src_img.height == get(target).height){
        get(target).pixels = src_img.pixels ;
        get(target).updatePixels();
      } else {
        get(target).resize(src_img.width, src_img.height);
        get(target).pixels = src_img.pixels ;
        get(target).updatePixels();
      }
    } else {
      printErr("Neither target image match with your request");
    }
  }

  public void set(PImage src_img, String target_name) {
    build();
    if(library.size() > 0) {
      if(src_img.width == get(target_name).width && src_img.height == get(target_name).height){
        get(target_name).pixels = src_img.pixels ;
        get(target_name).updatePixels();
      } else {
        get(target_name).resize(src_img.width, src_img.height);
        get(target_name).pixels = src_img.pixels ;
        get(target_name).updatePixels();
      }
    } else {
      printErr("Neither target image match with your request");
    }
  }

  public String get_name() {
    return get_name(which_img);
  }

  public String get_name(int target) {
    if(library != null && library.size() > 0) {
      if(target < library.size()) {
        return library.get(target).get_name() ;
      } else return null ;
    } else return null ;
  }



  public int get_rank(String target_name) {
    if(library != null && library.size() > 0) {
      int rank = 0 ;
      for(int i = 0 ; i < library.size() ; i++) {
        String final_name = target_name.split("/")[target_name.split("/").length -1].split("\\.")[0] ;
        if(final_name.equals(library.get(i).name) ) {
          rank = i ;
          break;
        } 
      }
      return rank;
    } else return -1;
  }


  public PImage get() {
    if(library != null && library.size() > 0 ) {
      if(which_img < library.size()) return library.get(which_img).img; 
      else return library.get(0).img; 
    } else return null ;
  }

  public PImage get(int target){
    if(library != null && target < library.size()) {
      return library.get(target).img;
    } else return null;
  }

  public PImage get(String target_name){
    if(library.size() > 0) {
      int target = 0 ;
      for(int i = 0 ; i < library.size() ; i++) {
        String final_name = target_name.split("/")[target_name.split("/").length -1].split("\\.")[0] ;
        if(final_name.equals(library.get(i).name) ) {
          target = i ;
          break;
        } 
      }
      return get(target);
    } else return null;
  }


  // private class
  private class ROPImage {
    private PImage img ;
    private String name = "no name" ;

    private ROPImage(String path) {
      this.name = path.split("/")[path.split("/").length -1].split("\\.")[0] ;
      this.img = loadImage(path);
    }

    private ROPImage(PImage img) {
      this.img = img;
    }

    private ROPImage(PImage img, String name) {
      this.img = img;
      this.name = name;
    }

    public String get_name() {
      return name ;
    }

    public PImage get_image() {
      return img ;
    }
  }
}

/**
resize image
v 0.0.2
*/
/**
* resize your picture proportionaly to the window sketch of the a specificic PGraphics
*/
public void image_resize(PImage src) {
  image_resize(src,g,true);
}

public void image_resize(PImage src, boolean fullfit) {
  image_resize(src,g,fullfit);
}

public void image_resize(PImage src, PGraphics pg, boolean fullfit) {
  float ratio_w = pg.width / (float)src.width;
  float ratio_h = pg.height / (float)src.height;
  if(!fullfit) {
    if(ratio_w > ratio_h) {
      src.resize(ceil(src.width *ratio_w), ceil(src.height *ratio_w));
    } else {
      src.resize(ceil(src.width *ratio_h), ceil(src.height *ratio_h));  
    }
  } else {
    if(ratio_w > ratio_h) {
      src.resize(ceil(src.width *ratio_h), ceil(src.height *ratio_h));
    } else {
      src.resize(ceil(src.width *ratio_w), ceil(src.height *ratio_w));  
    }
  }
}

/**
copy window
v 0.0.1
*/
public PImage image_copy_window(PImage src, int where) {
  return image_copy_window(src, g, where);
}

public PImage image_copy_window(PImage src, PGraphics pg, int where) {
  int x = 0 ;
  int y = 0 ;
  if(where == CENTER) {
    x = (src.width -pg.width) /2 ;
    y = (src.height -pg.height) /2 ;   
  } else if(where == LEFT) {
    y = (src.height -pg.height) /2 ; 
  } else if(where == RIGHT) { 
    x = src.width -pg.width ;
    y = (src.height -pg.height) /2 ;   
  } else if(where == TOP) {
    x = (src.width -pg.width) /2 ;   
  } else if(where == BOTTOM) { 
    x = (src.width -pg.width) /2 ;
    y = src.height -pg.height;   
  }  
  return src.get(x, y, pg.width, pg.height); 
}

















/**
IMAGE
v 0.2.2
2016-2018
*/
/**
* additionnal method for image
* @see other method in vec mini library
*/
public void image(PImage img) {
  if(img != null) image(img, 0, 0);
  else printErr("Object PImage pass to method image() is null");
}

public void image(PImage img, int what) {
  if(img != null) {
    float x = 0 ;
    float y = 0 ;
    int w = img.width;
    int h = img.height;
    int where = CENTER;
    if(what == r.FIT || what == LANDSCAPE || what == PORTRAIT || what == SCREEN) {
      float ratio = 1.f;
      int diff_w = width-w;
      int diff_h = height-h;


      if(what == r.FIT) {
        if(diff_w > diff_h) {
          ratio = (float)height / (float)h;
        } else {
          ratio = (float)width / (float)w;
        }
      } else if(what == SCREEN) {
        float ratio_w = (float)width / (float)w;
        float ratio_h = (float)height / (float)h;
        if(ratio_w > ratio_h) {
          ratio = ratio_w;
        } else {
          ratio = ratio_h;
        }
        /*
        if(diff_w > diff_h) {
          ratio = (float)width / (float)w;
        } else {
          ratio = (float)height/ (float)h;
        }
        */
      } else if(what == PORTRAIT) {
        ratio = (float)height / (float)h;
      } else if(what == LANDSCAPE) {
        ratio = (float)width / (float)w;
      }
      w *= ratio;
      h *= ratio;
    } else {
      where = what;
    }

    if(where == CENTER) {
      x = (width /2.f) -(w /2.f);
      y = (height /2.f) -(h /2.f);   
    } else if(where == LEFT) {
      x = 0;
      y = (height /2.f) -(h /2.f);
    } else if(where == RIGHT) {
      x = width -w;
      y = (height /2.f) -(h /2.f);
    } else if(where == TOP) {
      x = (width /2.f) -(w /2.f);
      y = 0;
    } else if(where == BOTTOM) {
      x = (width /2.f) -(w /2.f);
      y = height -h; 
    }
    image(img,x,y,w,h);
  } else {
    printErrTempo(60,"image(); no PImage has pass to the method, img is null");
  } 
}

public void image(PImage img, float coor) {
  if(img != null) image(img, coor, coor);
  else printErr("Object PImage pass to method image() is null");
}

public void image(PImage img, ivec pos) {
  if(pos instanceof ivec2) {
    image(img, vec2(pos.x, pos.y));
  } else if(pos instanceof ivec3) {
    image(img, vec3(pos.x, pos.y, pos.z));
  }
}

public void image(PImage img, ivec pos, ivec2 size) {
  if(pos instanceof ivec2) {
    image(img, vec2(pos.x, pos.y), vec2(size.x, size.y));
  } else if(pos instanceof ivec3) {
    image(img, vec3(pos.x, pos.y, pos.z), vec2(size.x, size.y));
  } 
}

public void image(PImage img, vec pos) {
  if(pos instanceof vec2) {
    vec2 p = (vec2) pos ;
    image(img, p.x, p.y) ;
  } else if(pos instanceof vec3) {
    vec3 p = (vec3) pos ;
    start_matrix() ;
    translate(p) ;
    image(img, 0,0) ;
    stop_matrix() ;
  }
}

public void image(PImage img, vec pos, vec2 size) {
  if(pos instanceof vec2) {
    vec2 p = (vec2) pos ;
    image(img, p.x, p.y, size.x, size.y) ;
  } else if(pos instanceof vec3) {
    vec3 p = (vec3) pos ;
    start_matrix() ;
    translate(p) ;
    image(img, 0,0, size.x, size.y) ;
    stop_matrix() ;
  }
}









/**
* For the future need to use shader to do that...but in the future !
*/
public PImage reverse(PImage img) {
  PImage final_img;
  final_img = createImage(img.width, img.height, RGB) ;
  for(int i = 0 ; i < img.pixels.length ; i++) {
    final_img.pixels[i] = img.pixels[img.pixels.length -i -1];
  }
  return final_img ;
}

/**
* For the future need to use shader to do that...but in the future !
*/
public PImage mirror(PImage img) {
  PImage final_img ;
  final_img = createImage(img.width, img.height, RGB) ;

  int read_head = 0 ;
  for(int i = 0 ; i < img.pixels.length ; i++) {
    if(read_head >= img.width) {
      read_head = 0 ;
    }
    int reverse_line = img.width -(read_head*2) -1 ;
    int target = i +reverse_line  ;

    if(target < 0 || target >img.pixels.length) println(i, read_head, target) ;
    final_img.pixels[i] = img.pixels[target] ;

    read_head++ ;
  }
  return final_img ;
}

public PImage paste(PImage img, int entry, int [] array_pix, boolean vertical_is) {
  if(!vertical_is) {
    return paste_vertical(img, entry, array_pix);
  } else {
    return paste_horizontal(img, entry, array_pix);
  }
}

public PImage paste_horizontal(PImage img, int entry, int [] array_pix) { 
  // println("horinzontal", frameCount, entry);
  PImage final_img ;
  final_img = img.copy() ;
  // reduce the array_pix in this one is bigger than img.pixels.length
  if(array_pix.length > final_img.pixels.length) {
     array_pix = Arrays.copyOf(array_pix,final_img.pixels.length) ;
  }

  int count = 0 ;
  int target = 0 ;
  for(int i = entry ; i < entry+array_pix.length ; i++) {
    if(i < final_img.pixels.length) {
      final_img.pixels[i] = array_pix[count];
    } else {
      target = i -final_img.pixels.length ;
      // security length outbound index
      // change the size can happen ArrayIndexOutBound,
      if(target >= final_img.pixels.length) {
        target = final_img.pixels.length -1;
      }
      if(count >= array_pix.length) {
        println("count", count, "array pix length", array_pix.length);
      }
      final_img.pixels[target] = array_pix[count];
    }
    count++ ;
  }
  return final_img ;
}


public PImage paste_vertical(PImage img, int entry, int [] array_pix) { 
  PImage final_img;
  final_img = img.copy();
  // reduce the array_pix in this one is bigger than img.pixels.length
  if(array_pix.length > final_img.pixels.length) {
     array_pix = Arrays.copyOf(array_pix,final_img.pixels.length) ;
  }

  int count = 0;
  int target = 0;
  int w = final_img.width;
  int line = 0;

  for(int i = entry ; i < entry+array_pix.length ; i++) {
    int mod = i%w ;
    // the master piece algorithm to change the direction :)
    int where =  entry +(w *(w -(w -mod))) +line;
    if(mod >= w -1) {
      line++;
    }
    if(where < final_img.pixels.length) {
      final_img.pixels[where] = array_pix[count];
    } else {
      target = where -final_img.pixels.length ;
      // security length outbound index
      // change the size can happen ArrayIndexOutBound,
      if(target >= final_img.pixels.length) {
        target = final_img.pixels.length -1;
      }
      if(count >= array_pix.length) {
        println("count", count, "array pix length", array_pix.length);
      }
      final_img.pixels[target] = array_pix[count];
    }
    count++ ;
  }
  return final_img ;
}





















/**
CANVAS
v 0.2.0
*/
PImage [] rope_canvas;
int current_canvas_rope;

// build canvas
public void new_canvas(int num) {
  rope_canvas = new PImage[num];
}

public void create_canvas(int w, int h, int type) {
  rope_canvas = new PImage[1];
  rope_canvas[0] = createImage(w, h, type);
}

public void create_canvas(int w, int h, int type, int which_one) {
  rope_canvas[which_one] = createImage(w, h, type);
}

// clean
public void clean_canvas(int which_canvas) {
  int c = color(0,0) ;
  clean_canvas(which_canvas, c) ;
}

public void clean_canvas(int which_canvas, int c) {
  if(which_canvas < rope_canvas.length) {
    select_canvas(which_canvas) ;
    for(int i = 0 ; i < get_canvas().pixels.length ; i++) {
      get_canvas().pixels[i] = c ;
    }
  } else {
    String message = ("The target: " + which_canvas + " don't match with an existing canvas");
    printErr(message);
  }
}



// misc
public int canvas_size() {
  return rope_canvas.length;
}

// select the canvas must be used for your next work
public void select_canvas(int which_one) {
  if(which_one < rope_canvas.length && which_one >= 0) {
    current_canvas_rope = which_one;
  } else {
    String message = ("void select_canvas(): Your selection " + which_one + " is not available, canvas '0' be use");
    printErr(message);
    current_canvas_rope = 0;
  }
}

// get
public PImage get_canvas(int which) {
  if(which < rope_canvas.length) {
    return rope_canvas[which];
  } else return null; 
}

public PImage get_canvas() {
  return rope_canvas[current_canvas_rope];
}

public int get_canvas_id() {
  return current_canvas_rope;
}

// update
public void update_canvas(PImage img) {
  update_canvas(img,current_canvas_rope);
}

public void update_canvas(PImage img, int which_one) {
  if(which_one < rope_canvas.length && which_one >= 0) {
    rope_canvas[which_one] = img;
  } else {
    println("void update_canvas() : Your selection" ,which_one, "is not available, canvas '0' be use");
    rope_canvas[0] = img;
  }  
}


/**
canvas event
v 0.0.1
*/
public void alpha_canvas(int target, float change) { 
  for(int i = 0 ; i < get_canvas(target).pixels.length ; i++) {
    int c = get_canvas(target).pixels[i];
    float rr = red(c);
    float gg = green(c);
    float bb = blue(c);
    float aa = alpha(c);
    aa += change ;
    if(i== 0 && target == 1 && aa < 5) {
      // println(aa, change);
    } 
    if(aa < 0 ) {
      aa = 0 ;
    }
    get_canvas(target).pixels[i] = color(rr,gg,bb,aa) ;
  }
  get_canvas(target).updatePixels() ;
}




/**
show canvas
v 0.0.4
*/
boolean fullscreen_canvas_is = false ;
ivec2 show_pos ;
/**
Add to set the center of the canvas in relation with the window
*/
int offset_canvas_x = 0 ;
int offset_canvas_y = 0 ;
public void set_show() {
  if(!fullscreen_canvas_is) {
    surface.setSize(get_canvas().width, get_canvas().height);
  } else {
    offset_canvas_x = width/2 - (get_canvas().width/2);
    offset_canvas_y = height/2 - (get_canvas().height/2);
    show_pos = ivec2(offset_canvas_x,offset_canvas_y) ;
  }
}

public ivec2 get_offset_canvas() {
  return ivec2(offset_canvas_x, offset_canvas_y);
}

public int get_offset_canvas_x() {
  return offset_canvas_x;
}

public int get_offset_canvas_y() {
  return offset_canvas_y;
}

public void show_canvas(int num) {
  if(fullscreen_canvas_is) {
    image(get_canvas(num), show_pos);
  } else {
    image(get_canvas(num));
  }  
}

























/**
BACKGROUND_2D_3D 
v 0.1.0
*/
float MAX_RATIO_DEPTH = 6.9f ;

/**
Background classic processing
*/
// vec
public void background(vec4 c) {
  background(c.r,c.g,c.b,c.a) ;
}

public void background(vec3 c) {
  background(c.r,c.g,c.b) ;
}

public void background(vec2 c) {
  background(c.x,c.y) ;
}
// ivec
public void background(ivec4 c) {
  background(c.x,c.y,c.z,c.w) ;
}

public void background(ivec3 c) {
  background(c.x,c.y,c.z) ;
}

public void background(ivec2 c) {
  background(c.x,c.y) ;
}




/**
Normalize background
*/

public void background_norm(vec4 bg) {
  background_norm(bg.x, bg.y, bg.z, bg.a) ;
}

public void background_norm(vec3 bg) {
  background_norm(bg.x, bg.y, bg.z, 1) ;
}

public void background_norm(vec2 bg) {
  background_norm(bg.x, bg.x, bg.x, bg.y) ;
}

public void background_norm(float c, float a) {
  background_norm(c, c, c, a) ;
}

public void background_norm(float c) {
  background_norm(c, c, c, 1) ;
}

public void background_norm(float r,float g, float b) {
  background_norm(r, g, b, 1) ;
}

// Main method
public void background_norm(float r_c, float g_c, float b_c, float a_c) {
  rectMode(CORNER) ;
  float x = map(r_c,0,1, 0, g.colorModeX) ;
  float y = map(g_c,0,1, 0, g.colorModeY) ;
  float z = map(b_c,0,1, 0, g.colorModeZ) ;
  float a = map(a_c,0,1, 0, g.colorModeA) ;
  noStroke() ;
  fill(x, y, z, a) ;
  int canvas_x = width ;
  int canvas_y = height ;
  if(renderer_P3D()) {
    canvas_x = width *100 ;
    canvas_y = height *100 ;
    int pos_x = - canvas_x /2 ;
    int pos_y = - canvas_y /2 ;
    // this problem of depth is not clarify, is must refactoring
    int pos_z = PApplet.parseInt( -height *MAX_RATIO_DEPTH) ;
    pushMatrix() ;
    translate(0,0,pos_z) ;
    rect(pos_x,pos_y,canvas_x, canvas_y) ;
    popMatrix() ;
  } else {
    rect(0,0,canvas_x, canvas_y) ;
  }
  // HSB mode
  if(g.colorMode == 3) {
    fill(0, 0, g.colorModeZ) ;
    stroke(0) ;
  // RGB MODE
  } else if (g.colorMode == 1) {
    fill(g.colorModeX, g.colorModeY, g.colorModeZ) ;
    stroke(0) ;

  }
  strokeWeight(1) ; 
}



/**
background rope
*/
public void background_rope(int c) {
  if(g.colorMode == 3) {
    background_rope(hue(c),saturation(c),brightness(c));
  } else {
    background_rope(red(c),green(c),blue(c));
  }
}

public void background_rope(int c, float w) {
  if(g.colorMode == 3) {
    background_rope(hue(c),saturation(c),brightness(c),w);
  } else {
    background_rope(red(c),green(c),blue(c),w );
  }
}

public void background_rope(float c) {
  background_rope(c,c,c);
}

public void background_rope(float c, float w) {
  background_rope(c,c,c,w);
}

public void background_rope(vec4 c) {
  background_rope(c.x,c.y,c.z,c.w);
}

public void background_rope(vec3 c) {
  background_rope(c.x,c.y,c.z);
}

public void background_rope(vec2 c) {
  background_rope(c.x,c.x,c.x,c.y);
}

// master method
public void background_rope(float x, float y, float z, float w) {
  background_norm(x/g.colorModeX, y/g.colorModeY, z/g.colorModeZ, w /g.colorModeA) ;
}

public void background_rope(float x, float y, float z) {
  background_norm(x/g.colorModeX, y/g.colorModeY, z/g.colorModeZ) ;
}























/**
GRAPHICS METHOD
v 0.3.3
*/
/**
SCREEN
*/
public void set_window(int px, int py, int sx, int sy) {
  set_window(ivec2(px,py), ivec2(sx,sy), get_screen_location(0));
}

public void set_window(int px, int py, int sx, int sy, int target) {
  set_window(ivec2(px,py), ivec2(sx,sy), get_screen_location(target));
}

public void set_window(ivec2 pos, ivec2 size) {
  set_window(pos, size, get_screen_location(0));
}

public void set_window(ivec2 pos, ivec2 size, int target) {
  set_window(pos, size, get_screen_location(target));
}

public void set_window(ivec2 pos, ivec2 size, ivec2 pos_screen) { 
  int offset_x = pos.x;
  int offset_y = pos.y;
  int dx = pos_screen.x;
  int dy = pos_screen.y;
  surface.setSize(size.x,size.y);
  surface.setLocation(offset_x +dx, offset_y +dy);
}

/**
check screen
*/
/**
screen size
*/
public ivec2 get_screen_size() {
  return get_display_size(sketchDisplay() -1);
}

public ivec2 get_screen_size(int target) {
  if(target >= get_display_num()) {
    target = 0;
    printErr("method get_screen_size(int target): target screen",target,"don't match with any screen device instead target '0' is used");
  }
  return get_display_size(target);
}

public @Deprecated
ivec2 get_display_size() {
  return get_display_size(sketchDisplay() -1);
}


public ivec2 get_display_size(int target) {
  if(target >= get_display_num()) {
    target = 0;
    printErr("method get_screen_size(int target): target screen",target,"don't match with any screen device instead target '0' is used");
  }  
  Rectangle display = get_screen(target);
  return ivec2((int)display.getWidth(), (int)display.getHeight()); 
}

/**
screen location
*/

public ivec2 get_screen_location(int target) {
  Rectangle display = get_screen(target);
  return ivec2((int)display.getX(), (int)display.getY());
}

/**
screen num
*/
public int get_screen_num() {
  return get_display_num();
}

public int get_display_num() {
  GraphicsEnvironment environment = GraphicsEnvironment.getLocalGraphicsEnvironment();
  return environment.getScreenDevices().length;
}


/**
screen
*/
public Rectangle get_screen(int target_screen) {
  GraphicsEnvironment environment = GraphicsEnvironment.getLocalGraphicsEnvironment();
  GraphicsDevice[] awtDevices = environment.getScreenDevices();
  int target = 0 ;
  if(target_screen < awtDevices.length) {
    target = target_screen ; 
  } else {
    printErr("No screen match with your request, instead we use the current screen");
    target = sketchDisplay() -1;
    if(target >= awtDevices.length) target = awtDevices.length -1;
  }
  GraphicsDevice awtDisplayDevice = awtDevices[target];
  Rectangle display = awtDisplayDevice.getDefaultConfiguration().getBounds();
  return display;
}



/**
sketch location 
0.0.2
*/
public ivec2 get_sketch_location() {
  return ivec2(get_sketch_location_x(),get_sketch_location_y());
}

public int get_sketch_location_x() {
  if(get_renderer() != P3D && get_renderer() != P2D) {
    return getJFrame(surface).getX();
  } else {
    return get_rectangle(surface).getX();

  }
  
}

public int get_sketch_location_y() {
  if(get_renderer() != P3D && get_renderer() != P2D) {
    return getJFrame(surface).getY();
  } else {
    return get_rectangle(surface).getY();
  }
}


public com.jogamp.nativewindow.util.Rectangle get_rectangle(PSurface surface) {
  com.jogamp.newt.opengl.GLWindow window = (com.jogamp.newt.opengl.GLWindow) surface.getNative();
  com.jogamp.nativewindow.util.Rectangle rectangle = window.getBounds();
  return rectangle;
}


public static final javax.swing.JFrame getJFrame(final PSurface surface) {
  return (javax.swing.JFrame)
  (
    (processing.awt.PSurfaceAWT.SmoothCanvas) surface.getNative()
  ).getFrame();
}








/**
Check renderer
*/
public boolean renderer_P3D() {
  if(get_renderer(getGraphics()).equals("processing.opengl.PGraphics3D")) return true ; else return false ;
}


public String get_renderer() {
  return get_renderer(g);
}

public String get_renderer(final PGraphics graph) {
  try {
    if (Class.forName(JAVA2D).isInstance(graph))  return JAVA2D;
    if (Class.forName(FX2D).isInstance(graph))    return FX2D;
    if (Class.forName(P2D).isInstance(graph))     return P2D;
    if (Class.forName(P3D).isInstance(graph))     return P3D;
    if (Class.forName(PDF).isInstance(graph))     return PDF;
    if (Class.forName(DXF).isInstance(graph))     return DXF;
  }

  catch (ClassNotFoundException ex) {
  }
  return "Unknown";
}






public String graphics_is(Object obj) {
  if(obj instanceof PGraphics) {
    return "PGraphics";
  } else if(obj instanceof PGraphics2D) {
    return "PGraphics";
  } else if(obj instanceof PGraphics3D) {
    return "PGraphics";
  } else if(obj instanceof processing.javafx.PGraphicsFX2D) {
    return "PGraphics";
  } else if(obj instanceof PImage) {
    return "PImage";
  } else return null;
}
/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2017 
* Stan le Punk > http://stanlepunk.xyz/
Rope Motion  2015 – 2018
v 1.3.0
Rope – Romanesco Processing Environment – 
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/




/**
Method motion
v 0.2.0
*/
public vec2 follow(vec2 target, float speed) {
  vec3 f = follow(target.x,target.y,0,speed);
  return vec2(f.x,f.y);
}



public vec3 follow(vec3 target, float speed) {
  return follow(target.x,target.y,target.z,speed);
}

public vec2 follow(float tx, float ty, float speed) {
  vec3 f = follow(tx,ty,0,speed);
  return vec2(f.x,f.y);
}

/**
* master method
*Compute position vector Traveller, give the target pos and the speed to go.
*/
vec3 dest_3D_follow_rope;
public vec3 follow(float tx, float ty, float tz, float speed) {
  if(speed <= 0 || speed > 1) {
    printErrTempo(120,"vec3 follow(): float speed parameter must be a normal value between 0 and 1\n instead value 1 is attribute to speed");
    speed = 1.f;
  }
  if(dest_3D_follow_rope == null) dest_3D_follow_rope = vec3();
  // calcul X pos
  float dx = tx - dest_3D_follow_rope.x;
  if(abs(dx) != 0) {
    dest_3D_follow_rope.x += dx * speed;
  }
  // calcul Y pos
  float dy = ty - dest_3D_follow_rope.y;
  if(abs(dy) != 0) {
    dest_3D_follow_rope.y += dy * speed;
  }
  // calcul Z pos
  float dz = tz - dest_3D_follow_rope.z;
  if(abs(dz) != 0) {
    dest_3D_follow_rope.z += dz * speed;
  }
  return dest_3D_follow_rope;
}






/**
Class Motion 
v 1.1.0
2016-2018
* @author Stan le Punk
* @see https://github.com/StanLepunK/Motion
*/

class Motion {
  float vel_ref = 1.f ;
  float vel = 1.f ;
  float max_vel = 1 ;

  float acc = .01f ;
  float dec = .01f ;
  boolean  acc_is = false ;
  boolean  dec_is = true ;

  vec3 dir  ;
  int tempo = 0 ;
  private boolean tempo_is = false ;
  
  // constructor
  Motion() {
  }

  Motion(float max_vel) {
    this.max_vel = max_vel ;
  }



  // get
  public float get_velocity() {
    return vel ;
  }

  public vec3 get_direction() {
    return dir ;
  }

  public float get_acceleration() {
    return acc;
  }

  public float get_deceleration() {
    return dec;
  }

  public boolean acceleration_is() {
    return acc_is ;
  }

  public boolean deceleration_is() {
    return dec_is ;
  }

  public boolean velocity_is() {
    if(vel == 0) return false ; else return true ;
  }




  // set
  public void set_deceleration(float dec) {
    this.dec = abs(dec) ;
  }

  public void set_acceleration(float acc) {
    this.acc = abs(acc) ;
  }

  public void set_velocity(float vel) {
    this.vel = vel ;
  }

  public void set_max_velocity(float max_vel) {
    this.max_vel = max_vel ;
  }

  public void set_tempo(int tempo) {
    tempo_is = true ;
    this.tempo = tempo ;
  }

  public void reset() {
    this.vel = 0 ;
    this.vel_ref = 0 ;
    if(dir == null) {
      this.dir = vec3(0) ;
    } else {
      this.dir.set(0) ;
    }
  }




  // event
  public void stop() {
    this.vel_ref = this.vel ;
    set_velocity(0) ;
  }

  public void start() {
    set_velocity(vel_ref) ;
  }

  public void acceleration_is(boolean state) {
    acc_is = state ;
  }

  public void deceleration_is(boolean state) {
    dec_is = state ;
  }


  // motion
  // deceleration
  public void deceleration() {
    if(vel > 0) {
      vel -= dec ;
      // to stop object
      if(vel < 0) vel = 0 ;
    } else if(vel < 0 ) {
      vel += dec ;
      if(vel > 0) vel = 0 ;
    }
  }
  
  // acceleration
  public void acceleration() {
    if(vel > 0) {
      vel += acc ;
      // limit the velocity to the maximum velocity
      if(vel > max_vel) vel = max_vel ;
    } else if(vel < 0 ) {
      vel -= acc ;
      // limit the velocity to the maximum velocity
      if(abs(vel) > max_vel) vel = -max_vel ;
    }
  }







  /**
  leading 
  v 0.0.3
  */
  public vec2 leading(vec2 leading_pos, vec2 exec_pos) {
    vec3 current_pos_3D = vec3(leading_pos) ;
    vec3 my_pos_3D = vec3(exec_pos) ;
    vec3 lead = leading(current_pos_3D, my_pos_3D) ;
    return vec2(lead.x, lead.y) ;
  }


  vec3 for_vel ;
  vec3 for_dir ;

  vec3 leading_pos ;
  vec3 leading_ref ;
  boolean apply_acc = false ;

  public vec3 leading(vec3 leading_pos, vec3 exec_pos) {
    if(leading_ref == null) {
      leading_ref = vec3(exec_pos) ;
    }
    vec3 new_pos = vec3(exec_pos) ;

    vec3 velocity_xyz = apply_leading(leading_pos) ;
    if(velocity_xyz.equals(vec3(0))) {
      // follow the lead when this one move
      apply_acc = true ;
      new_pos.sub(sub(leading_ref, leading_pos)) ;
    } else {
      new_pos.add(velocity_xyz) ;
    }
    leading_ref.set(leading_pos) ;
    return new_pos ;
  }


  private vec3 apply_leading(vec3 leading_pos) {
    // init var if var is null
    if (dir == null) {
      dir = vec3() ;
    }
    if (for_vel == null) {
      for_vel = vec3() ;
    }
    if (for_dir == null) {
      for_dir = vec3() ;
    }
    if (leading_pos == null) {
      leading_pos = vec3() ;
    }


    vec3 vel_vec3 = vec3() ;
    leading_pos.set(leading_pos) ;

    if(for_vel.equals(leading_pos)) {
      // limit speed
      if (abs(vel) > max_vel) {
        if(vel < 0) {
          vel = -max_vel ;
        } else {
          vel = max_vel ;
        }
      }
      

      if(abs(vel) >= max_vel || !acc_is) {
        apply_acc = false ;
      }

      if(apply_acc && acc_is) {
        acceleration() ;
      }

      if(!apply_acc && dec_is) {
        deceleration() ;
      }

      // update position
      vel_vec3 = mult(dir, vel) ;
    } else {
      vel = dist(leading_pos, for_vel) ;
      dir = sub(leading_pos, for_dir) ;
      dir.normalize() ;
    }
    for_vel.set(leading_pos) ;

    // calcul direction
    if(!tempo_is) tempo = PApplet.parseInt(frameRate *.25f) ;
    if(tempo != 0) {
      if(frameCount%tempo == 0) {
        for_dir.set(leading_pos) ;
      } 
    }
    
    //
    return vel_vec3 ;
  }
  /**
  end leading
  */

  
}







/**
PATH
*/
class Path extends Motion {
  // list of the keypoint, use super_class Path
  ArrayList<vec3> path ;
  // distance between the keypoint and the position of the translation shape
  float dist_from_start = 0 ;
  float dist_a_b = 0 ;

  // a & b are points to calculate the direction and position of the translation to give at the shape
  // vec3 origin, target ;
  // speed ratio to adjust the speed xy according to position target
  vec3 ratio  ;
  //keypoint 
  vec3 pos ;
  

  // find a good keypoint in the ArrayList
  int n = 0 ;
  int m = 1 ;

  Path() {
    super() ;
    path = new ArrayList<vec3>() ;
    pos = vec3(MAX_INT) ;
  }
   // set
   public void set_velocity(float velocity) {
    if(vel < 0) {
      System.err.println("negative value, class Path use the abslolute value of") ;
      System.err.println(vel) ;
    }
    this.vel = abs(vel) ;
   }

  

  // next
  public void previous() {
    vec3 origin, target ;
    if (path.size() > 1 ) {
      vec3 key_a = vec3() ;
      vec3 key_b = vec3() ;
      int origin_rank = path.size() - n -1 ;
      int target_rank = path.size() - m -1 ;
      key_a = (vec3) path.get(origin_rank) ;
      key_b = (vec3) path.get(target_rank) ;

      origin = vec3(key_a) ;
      target = vec3(key_b) ;
      go(origin, target) ;

    } else if (path.size() == 1) {
      vec3 key_a = (vec3) path.get(0) ;
      origin = vec3(key_a) ;
      pos.set(origin) ;
    } else {
      pos.set(-100) ;
    }
  }






  // next
  public void next() {
    vec3 origin, target ;
    if (path.size() > 1 ) {
      vec3 key_a = vec3() ;
      vec3 key_b = vec3() ;
      key_a = (vec3) path.get(n) ;
      key_b = (vec3) path.get(m) ;

      origin = vec3(key_a) ;
      target = vec3(key_b) ;
      go(origin, target) ;

    } else if (path.size() == 1) {
      vec3 key_a = (vec3) path.get(n) ;
      origin = vec3(key_a) ;
      pos.set(origin) ;
    } else {
      pos.set(-100) ;
    }
  }




  // private method of class
  private void go(vec3 origin, vec3 target) {
    if(pos.equals(vec3(MAX_INT))) {
      pos.set(origin) ;
    }
    // distance between the keypoint a & b and the position of the translation shape
    dist_a_b = origin.dist(target) ;
    dist_from_start = pos.dist(origin) ;
    //update the position
    if (dist_from_start < dist_a_b) {
      // calcul speed ratio
      vec3 speed_ratio = sub(origin,target) ;

      // final calcul ratio
      if(ratio == null) {
        ratio = vec3() ;
      }
      ratio.x = speed_ratio.x / speed_ratio.y ;
      ratio.y = speed_ratio.y / speed_ratio.x ;
      if(abs(ratio.x) > abs(ratio.y) ) { 
        ratio.x = 1.0f ; ratio.y = abs(ratio.y) ; 
      } else { 
        ratio.x = abs(ratio.x) ; ratio.y = 1.0f ; 
      }
      
      // Give the good direction to the translation
      if (speed_ratio.x == 0) {
        pos.x += 0 ;
        if (origin.y - target.y < 0 )  {
          pos.y += vel ; 
        } else {
          pos.y -= vel ;
        }
      } 
      if (speed_ratio.y == 0) {
        pos.y += 0 ;
        if (origin.x - target.x < 0 ) {
          pos.x += vel ; 
        } else {
          pos.x -= vel ;
        }     
      }

      if (speed_ratio.x != 0 && speed_ratio.y != 0  )  {
        if (origin.x - target.x < 0 ) {
          pos.x += (vel *ratio.x) ; 
        } else {
          pos.x -= (vel *ratio.x) ;
        }
        if (origin.y - target.y < 0 ) {
          pos.y += (vel *ratio.y) ; 
        } else {
          pos.y -= (vel *ratio.y) ;
        }
      }
    } else {
      n++ ; 
      m++ ;
    }
    //change to the next keypoint 
    if (target.equals(pos)) {  
      m++ ; 
      n++ ; 
    }
    
    if (n != path.size() && m == 1) { 
      m = 1 ; 
      n = 0 ; 
    }
    
    if (m == path.size()) { 
      m = 0 ; 
    }
    
    if (n == path.size()) { 
      n = 0 ; 
    } 
  }









  // get
  public vec3 get_pos() {
    return pos ;
  }

  public int path_size() {
    return path.size() ;
  }

  public vec3 [] path() {
    vec3 [] list = new vec3[path.size()] ;
    for(int i = 0 ; i < path.size() ; i++) {
      list[i] = path.get(i).copy() ;
    }
    return list ;
  }

  public ArrayList<vec3> path_ArrayList() {
    return path ;
  }
  

  // add point to the list to make the path
  public void add(vec coord) {
    path.add(vec3(coord.x,coord.y,coord.z)) ;
  }
  public void add(int x, int y, int z) {
    path.add(vec3(x,y,z)) ;
  }

  public void add(int x, int y) {
    path.add(vec3(x,y,0)) ;
  }
}
/**
ROPE PROCESSING METHOD
v 2.3.0
* Copyleft (c) 2014-2019
* Stan le Punk > http://stanlepunk.xyz/
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope_method
* Processing 3.5.3
*/


/**
ADVANCED GHOST METHOD
v 1.0.0
All advanced ghost push Processing method further.
Processing and vec, ivec and bvec method
the idea here is create method directly insprating from Processing to simplify the coder life
*/

/**
* colorMode(vec5 color_component)
* @param component give in order : mode, x, y, z and alpha
*/
public void colorMode(vec5 component) {
  int mode = (int)component.a;
  if(mode == HSB) {
    colorMode(HSB,component.b,component.c,component.d,component.e);
  } else if(mode == RGB) {
    colorMode(RGB,component.b,component.c,component.d,component.e);
  } else {
    printErr("The first component of your vec is", mode, "and don't match with any Processing colorMode, instead the current colorMode will be used");
  }
}
/**
* colorMode(int mode, vec4 color_component)
* @param mode give environment HSB or RGB
* @param color_component give in order : x, y, z and alpha
*/
public void colorMode(int mode, vec4 component) {
  if(mode == HSB) {
    colorMode(HSB,component.x,component.y,component.z,component.w);
  } else if(mode == RGB) {
    colorMode(RGB,component.x,component.y,component.z,component.w);
  } else {
    printErr("int mode", mode, "don't match with any Processing colorMode, instead the current colorMode will be used");
  }
}
/**
* colorMode(int mode, vec3 color_component)
* @param mode give environment HSB or RGB
* @param color_component give in order : x, y, z
*/
public void colorMode(int mode, vec3 component) {
  colorMode(mode, vec4(component.x,component.y,component.z,g.colorModeA));
}
/**
* colorMode(int mode, vec2 color_component)
* @param mode give environment HSB or RGB
* @param color_component give in order the x give x,y,z and y give the alpha
*/
public void colorMode(int mode, vec2 component) {
   colorMode(mode, vec4(component.x,component.x,component.x,component.y));
}







/**
floor
*/
public vec2 floor(vec2 arg) {
  return vec2(floor(arg.x),floor(arg.y));
}

public vec3 floor(vec3 arg) {
  return vec3(floor(arg.x),floor(arg.y),floor(arg.z));
}

public vec4 floor(vec4 arg) {
  return vec4(floor(arg.x),floor(arg.y),floor(arg.z),floor(arg.w));
}






/**
round
*/
public vec2 round(vec2 arg) {
  return vec2(round(arg.x),round(arg.y));
}

public vec3 round(vec3 arg) {
  return vec3(round(arg.x),round(arg.y),round(arg.z));
}

public vec4 round(vec4 arg) {
  return vec4(round(arg.x),round(arg.y),round(arg.z),round(arg.w));
}





/**
ceil
*/
public vec2 ceil(vec2 arg) {
  return vec2(ceil(arg.x),ceil(arg.y));
}

public vec3 ceil(vec3 arg) {
  return vec3(ceil(arg.x),ceil(arg.y),ceil(arg.z));
}

public vec4 ceil(vec4 arg) {
  return vec4(ceil(arg.x),ceil(arg.y),ceil(arg.z),ceil(arg.w));
}


/**
abs
*/
public vec2 abs(vec2 arg) {
  return vec2(abs(arg.x),abs(arg.y));
}

public vec3 abs(vec3 arg) {
  return vec3(abs(arg.x),abs(arg.y),abs(arg.z));
}

public vec4 abs(vec4 arg) {
  return vec4(abs(arg.x),abs(arg.y),abs(arg.z),abs(arg.w));
}

public ivec2 abs(ivec2 arg) {
  return ivec2(abs(arg.x),abs(arg.y));
}

public ivec3 abs(ivec3 arg) {
  return ivec3(abs(arg.x),abs(arg.y),abs(arg.z));
}

public ivec4 abs(ivec4 arg) {
  return ivec4(abs(arg.x),abs(arg.y),abs(arg.z),abs(arg.w));
}



/**
max
*/
public vec2 max(vec2 a, vec2 b) {
  return vec2(max(a.x,b.x),max(a.y,b.y));
}

public vec3 max(vec3 a, vec3 b) {
  return vec3(max(a.x,b.x),max(a.y,b.y),max(a.z,b.z));
}

public vec4 max(vec4 a, vec4 b) {
  return vec4(max(a.x,b.x),max(a.y,b.y),max(a.z,b.z),max(a.w,b.w));
}

public ivec2 max(ivec2 a, ivec2 b) {
  return ivec2(max(a.x,b.x),max(a.y,b.y));
}

public ivec3 max(ivec3 a, ivec3 b) {
  return ivec3(max(a.x,b.x),max(a.y,b.y),max(a.z,b.z));
}

public ivec4 max(ivec4 a, ivec4 b) {
  return ivec4(max(a.x,b.x),max(a.y,b.y),max(a.z,b.z),max(a.w,b.w));
}



/**
min
*/
public vec2 min(vec2 a, vec2 b) {
  return vec2(min(a.x,b.x),min(a.y,b.y));
}

public vec3 min(vec3 a, vec3 b) {
  return vec3(min(a.x,b.x),min(a.y,b.y),min(a.z,b.z));
}

public vec4 min(vec4 a, vec4 b) {
  return vec4(min(a.x,b.x),min(a.y,b.y),min(a.z,b.z),min(a.w,b.w));
}

public ivec2 min(ivec2 a, ivec2 b) {
  return ivec2(min(a.x,b.x),min(a.y,b.y));
}

public ivec3 min(ivec3 a, ivec3 b) {
  return ivec3(min(a.x,b.x),min(a.y,b.y),min(a.z,b.z));
}

public ivec4 min(ivec4 a, ivec4 b) {
  return ivec4(min(a.x,b.x),min(a.y,b.y),min(a.z,b.z),min(a.w,b.w));
}





/**
set
*/
public void set(ivec2 pos, int c) {
  set(pos.x, pos.y, c);
}

public void set(vec2 pos, int c) {
  set((int)pos.x, (int)pos.y, c);
}



/**
random
*/
public float random (vec2 v) {
  return random(v.x, v.y);
}

public float random (ivec2 v) {
  return random(v.x, v.y);
}




/**
Ellipse
v 0.1.1
*/
// with vec2 or ivec2
public void ellipse(vec2 p, vec s) {
  ellipse(p.x,p.y, s.x,s.y);
}

public void ellipse(vec2 p, float x, float y) {
  ellipse(p.x,p.y,x,y);
}

public void ellipse(vec2 p, float x) {
  ellipse(p.x,p.y,x,x);
}


// ivec
public void ellipse(ivec2 p, ivec s) {
  ellipse(p.x,p.y,s.x,s.y) ;
}

public void ellipse(ivec2 p, int x, int y) {
  ellipse(p.x,p.y, x,y);
}

public void ellipse(ivec2 p, int x) {
  ellipse(p.x,p.y,x,x);
}

// with vec3 or ivec3
public void ellipse(ivec3 p, int x, int y) {
  ellipse(p,ivec2(x,y));
}

public void ellipse(ivec3 p, int x) {
  ellipse(p,ivec2(x));
}

public void ellipse(ivec3 p, ivec s) {
  vec3 temp_pos = vec3((int)p.x, (int)p.y, (int)p.z);
  vec2 temp_size = vec2((int)s.x,(int)s.y);
  ellipse(temp_pos, temp_size);
}


public void ellipse(vec3 p, float x, float y) {
  ellipse(p,vec2(x,y));
}

public void ellipse(vec3 p, float x) {
  ellipse(p,vec2(x));
}

/**
main method
*/
public void ellipse(vec3 p, vec s) {
  if(renderer_P3D()) {
    start_matrix() ;
    translate(p.x, p.y, p.z);
    ellipse(0,0, s.x, s.y);
    stop_matrix() ;
  } else {
    ellipse(p.x,p.y,s.x,s.y);
  }
}







/**
Rect
*/
public void rect(vec2 p, vec2 s) {
  rect(p.x,p.y,s.x,s.y);
}
public void rect(vec3 p, vec2 s) {
  if(renderer_P3D()) {
    start_matrix();
    translate(p.x,p.y,p.z);
    rect(0,0,s.x,s.y);
    stop_matrix();
  } else rect(p.x,p.y,s.x,s.y);
}

public void rect(ivec2 p, ivec2 s) {
  rect(p.x,p.y,s.x,s.y) ;
}

public void rect(ivec3 p, ivec2 s) {
  vec3 temp_pos = vec3((int)p.x,(int)p.y,(int)p.z);
  vec2 temp_size = vec2((int)s.x,(int)s.y);
  rect(temp_pos,temp_size);
}


/**
Triangle
*/
public void triangle(ivec a, ivec b, ivec2 c) {
  triangle(vec3(a.x,a.y,a.z),vec3(b.x,b.y,b.z),vec3(c.x,c.y,c.z));
}

public void triangle(vec a, vec b, vec c) {
  if(a.z == 0 && b.z == 0 && c.z == 0) {
    triangle(a.x,a.y,b.x,b.y,c.x,c.y);
  } else {
    if(renderer_P3D()) {
      beginShape();
      vertex(a.x,a.y,a.z);
      vertex(b.x,b.y,b.z);
      vertex(c.x,c.y,c.z);
      endShape(CLOSE);
    } else {

      triangle(a.x,a.y,b.x,b.y,c.x,c.y);
    }
  }
}




/**
Box
*/
public void box(vec3 p) {
  box(p.x,p.y,p.z);
}

public void box(ivec3 p) {
  box(p.x,p.y,p.z);
}




/**
Point
*/
public void point(vec2 p) {
  point(p.x,p.y);
}
public void point(vec3 p) {
  if(renderer_P3D()) point(p.x,p.y,p.z); 
  else point(p.x,p.y) ;
}

public void point(ivec2 p) {
  point(p.x,p.y);
}
public void point(ivec3 p) {
  if(renderer_P3D()) point(p.x,p.y,p.z); 
  else point(p.x,p.y);
}




/**
Line
*/
public void line(vec2 a, vec2 b){
  line(a.x,a.y,b.x,b.y);
}
public void line(vec3 a, vec3 b){
  if(renderer_P3D()) line(a.x,a.y,a.z,b.x,b.y,b.z); 
  else line(a.x,a.y,b.x,b.y);
}

public void line(ivec2 a, ivec2 b) {
  line(a.x,a.y,b.x,b.y);
}

public void line(ivec3 a, ivec3 b) {
  if(renderer_P3D()) line(a.x,a.y,a.z,b.x,b.y,b.z); 
  else line(a.x,a.y,b.x,b.y);
}



/**
Vertex
v 0.0.2
*/
public void vertex(vec2 xy) {
  vertex(xy.x,xy.y);
}

public void vertex(vec3 xyz) {
  if(renderer_P3D()) vertex(xyz.x,xyz.y,xyz.z); 
  else vertex(xyz.x,xyz.y);
}
//
public void vertex(ivec2 xy) {
  vertex(xy.x,xy.y);
}

public void vertex(ivec3 xyz){
  if(renderer_P3D()) vertex(xyz.x,xyz.y,xyz.z); 
  else vertex(xyz.x,xyz.y);
}
//
public void vertex(vec2 xy, vec2 uv) {
  vertex(xy.x,xy.y,uv.u,uv.v);
}

public void vertex(ivec2 xy, vec2 uv) {
  vertex(xy.x,xy.y,uv.u,uv.v);
}
//
public void vertex(vec3 xyz, vec2 uv) {
  if(renderer_P3D()) vertex(xyz.x,xyz.y,xyz.z,uv.u,uv.v); 
  else vertex(xyz.x,xyz.y,uv.u,uv.v);
}

public void vertex(ivec3 xyz, vec2 uv) {
  if(renderer_P3D()) vertex(xyz.x,xyz.y,xyz.z,uv.u,uv.v); 
  else vertex(xyz.x,xyz.y,uv.u,uv.v);
}



/**
Bezier Vertex
*/
public void bezierVertex(vec2 a, vec2 b, vec2 c) {
  bezierVertex(a.x, a.y,b.x,b.y,c.x,c.y);
}

public void bezierVertex(vec3 a, vec3 b, vec3 c) {
  if(renderer_P3D()) bezierVertex(a.x,a.y,a.z,b.x,b.y,b.z,c.x,c.y,c.z); 
  else bezierVertex(a.x,a.y,b.x,b.y,c.x,c.y);
}

public void bezierVertex(ivec2 a, ivec2 b, ivec2 c) {
  bezierVertex(a.x,a.y,b.x,b.y,c.x,c.y);
}

public void bezierVertex(ivec3 a, ivec3 b, ivec3 c) {
  if(renderer_P3D()) bezierVertex(a.x,a.y,a.z,b.x,b.y,b.z,c.x,c.y,c.z); 
  else bezierVertex(a.x,a.y,b.x,b.y,c.x,c.y);
}





/**
Quadratic Vertex
*/
public void quadraticVertex(vec2 a, vec2 b) {
  quadraticVertex(a.x, a.y, b.x, b.y);
}

public void quadraticVertex(vec3 a, vec3 b) {
  if(renderer_P3D()) quadraticVertex(a.x, a.y, a.z, b.x, b.y, b.z); 
  else quadraticVertex(a.x, a.y, b.x, b.y) ;
}

public void quadraticVertex(ivec2 a, ivec2 b) {
  quadraticVertex(a.x, a.y, b.x, b.y);
}

public void quadraticVertex(ivec3 a, ivec3 b) {
  if(renderer_P3D()) quadraticVertex(a.x, a.y, a.z, b.x, b.y, b.z); 
  else quadraticVertex(a.x, a.y, b.x, b.y);
}




/**
Curve Vertex
*/
public void curveVertex(vec2 a) {
  curveVertex(a.x, a.y);
}
public void curveVertex(vec3 a){
  if(renderer_P3D()) curveVertex(a.x, a.y, a.z) ; 
  else curveVertex(a.x, a.y);
}

public void curveVertex(ivec2 a) {
  curveVertex(a.x, a.y);
}
public void curveVertex(ivec3 a){
  if(renderer_P3D()) curveVertex(a.x, a.y, a.z) ; 
  else curveVertex(a.x, a.y);
}





/**
Fill
*/
// vec
public void fill(vec2 c) {
  if( c.y > 0) fill(c.x, c.y); 
  else noFill();
}
public void fill(vec3 c) {
  fill(c.r,c.g,c.b) ;
}

public void fill(vec3 c, float a) {
  if(a > 0) fill(c.r,c.g,c.b,a); 
  else noFill();
}

public void fill(vec4 c) {
  if(c.w > 0) fill(c.x,c.y,c.z,c.w); 
  else noFill();
}

// ivec
public void fill(ivec2 c) {
  if(c.y > 0) fill(c.x,c.y); 
  else noFill();
}
public void fill(ivec3 c) {
  fill(c.x,c.y,c.z);
}

public void fill(ivec3 c, float a) {
  if(a > 0) fill(c.x,c.y,c.z,a);
  else noFill();
}

public void fill(ivec4 c) {
  if(c.w > 0) fill(c.x,c.y,c.z,c.w); 
  else noFill();
}




/**
Stroke
*/
// vec
public void stroke(vec2 c) {
  if(c.y > 0) stroke(c.x,c.y); 
  else noStroke();
}
public void stroke(vec3 c) {
  stroke(c.r,c.g,c.b);
}

public void stroke(vec3 c, float a) {
  if(a > 0) stroke(c.r,c.g,c.b, a); 
  else noStroke();
}

public void stroke(vec4 c) {
  if(c.a > 0) stroke(c.r,c.g,c.b,c.a); 
  else noStroke();
}
// ivec
public void stroke(ivec2 c) {
  if(c.y > 0) stroke(c.x,c.y); 
  else noStroke();
}
public void stroke(ivec3 c) {
  stroke(c.x, c.y, c.z);
}

public void stroke(ivec3 c, float a) {
  if(a > 0) stroke(c.x,c.y,c.z,a); 
  else noStroke();
}

public void stroke(ivec4 c) {
  if(c.w > 0) stroke(c.x,c.y,c.z,c.w); 
  else noStroke();
}



/**
text
v 0.2.0
*/
public void text(String s, vec pos) {
  if(pos instanceof vec2 && s != null) {
    vec2 p = (vec2)pos;
    text(s,p.x,p.y);
  } else if(pos instanceof vec3 && s != null) {
    vec3 p = (vec3)pos;
    text(s,p.x,p.y,p.z);
  } else {
    printErrTempo(60,"method text(): String message is null or vec is not an instance of vec3 or vec2");
  }
}

public void text(char c, vec pos) {
  if(pos instanceof vec2) {
    vec2 p = (vec2)pos;
    text(c, p.x, p.y);
  } else if(pos instanceof vec3) {
    vec3 p = (vec3)pos;
    text(c,p.x,p.y,p.z);
  }
}

public void text(int num, vec pos) {
  if(pos instanceof vec2) {
    vec2 p = (vec2)pos;
    text(num, p.x, p.y);
  } else if(pos instanceof vec3) {
    vec3 p = (vec3)pos;
    text(num,p.x,p.y,p.z);
  } 
}

public void text(float num, vec pos) {
  if(pos instanceof vec2) {
    vec2 p = (vec2) pos;
    text(num, p.x, p.y);
  } else if(pos instanceof vec3) {
    vec3 p = (vec3) pos;
    text(num,p.x,p.y,p.z);
  } 
}

// ivec
public void text(String s, ivec pos) {
  if(pos instanceof ivec2 && s != null) {
    vec2 temp_pos = vec2(pos.x,pos.y);
    text(s, temp_pos);
  } else if(pos instanceof ivec2) {
    vec3 temp_pos = vec3(pos.x,pos.y,pos.z);
    text(s, temp_pos);
  } else {
    printErrTempo(60,"method text(): String message is null or ivec is not an instance of ivec3 or ivec2");
  }  
}

public void text(char c, ivec pos) {
  if(pos instanceof ivec2) {
    vec2 temp_pos = vec2(pos.x,pos.y);
    text(c, temp_pos);
  } else if(pos instanceof ivec2) {
    vec3 temp_pos = vec3(pos.x,pos.y,pos.z);
    text(c, temp_pos);
  } 
}

public void text(int num, ivec pos) {
  if(pos instanceof ivec2) {
    vec2 temp_pos = vec2(pos.x,pos.y);
    text(num, temp_pos);
  } else if(pos instanceof ivec2) {
    vec3 temp_pos = vec3(pos.x,pos.y,pos.z);
    text(num, temp_pos);
  }
}

public void text(float num, ivec pos) {
  if(pos instanceof ivec2) {
    vec2 temp_pos = vec2(pos.x,pos.y);
    text(num, temp_pos);
  } else if(pos instanceof ivec2) {
    vec3 temp_pos = vec3(pos.x,pos.y,pos.z);
    text(num, temp_pos);
  } 
}








/**
Translate
*/
// vec
public void translate(vec3 t) {
  if(renderer_P3D()) {
    translate(t.x,t.y,t.z); 
  } else {
    translate(t.x,t.y);
  }
}

public void translate(vec2 t){
  translate(round(t.x),round(t.y));
}

// ivec
public void translate(ivec3 t){
  if(renderer_P3D()) {
    translate(t.x,t.y,t.z); 
  } else {
    translate(t.x,t.y);
  }
}

public void translate(ivec2 t){
  translate(t.x,t.y);
}

public void translateX(float t){
  translate(t,0);
}

public void translateY(float t){
  translate(0,t);
}

public void translateZ(float t){
  translate(0,0,t);
}


/**
Rotate
*/
// vec
public void rotateXY(vec2 rot) {
  rotateX(rot.x);
  rotateY(rot.y);
}

public void rotateXZ(vec2 rot) {
  rotateX(rot.x);
  rotateZ(rot.y);
}

public void rotateYZ(vec2 rot) {
  rotateY(rot.x);
  rotateZ(rot.y);
}
public void rotateXYZ(vec3 rot) {
  rotateX(rot.x);
  rotateY(rot.y);
  rotateZ(rot.z);
}

// ivec
public void rotateXY(ivec2 rot) {
  rotateX(rot.x);
  rotateY(rot.y);
}

public void rotateXZ(ivec2 rot) {
  rotateX(rot.x);
  rotateZ(rot.y);
}

public void rotateYZ(ivec2 rot) {
  rotateY(rot.x);
  rotateZ(rot.y);
}
public void rotateXYZ(ivec3 rot) {
  rotateX(rot.x);
  rotateY(rot.y);
  rotateZ(rot.z);
}







/**
Matrix
v 0.1.0
*/
// vec
public void start_matrix_3D(vec pos, vec3 dir_cart) {
  vec3 dir = dir_cart.copy() ;
  pushMatrix() ;
  if(pos instanceof vec2) {
    vec2 p = (vec2) pos ;
    translate(p) ;
  } else if(pos instanceof vec3) {
    vec3 p = (vec3) pos ;
    translate(p) ;
  } else {
    printErr("Error in void start_matrix_3D(), vec pos is not an instance of vec2 or vec3, the matrix don't translate your object") ;
    exit() ;
  }
  float radius = sqrt(dir.x * dir.x + dir.y * dir.y + dir.z * dir.z);
  float longitude = acos(dir.x / sqrt(dir.x * dir.x + dir.y * dir.y)) * (dir.y < 0 ? -1 : 1);
  float latitude = acos(dir.z / radius) * (dir.z < 0 ? -1 : 1);
  // check NaN result
  if (Float.isNaN(longitude)) longitude = 0;
  if (Float.isNaN(latitude)) latitude = 0;
  if (Float.isNaN(radius)) radius = 0;
  rotateX(latitude);
  rotateY(longitude);
}

public void start_matrix_3D(vec pos, vec2 dir_polar) {
  if(pos instanceof vec2) {
    vec2 p = (vec2) pos;
    pushMatrix();
    translate(p);
    rotateXY(dir_polar);
  } else if(pos instanceof vec3) {
    vec3 p = (vec3) pos;
    pushMatrix();
    translate(p);
    rotateXY(dir_polar);
  } else {
    printErr("Error in void start_matrix_3D(), vec pos is not an instance of vec2 or vec3, the matrix cannot be init") ;
    exit() ;
  }
}

public void start_matrix_2D(vec pos, float orientation) {
  if(pos instanceof vec2) {
    vec2 p = (vec2)pos;
    pushMatrix();
    translate(p);
    rotate(orientation);
  } else if(pos instanceof vec3) {
    vec3 p = (vec3)pos;
    pushMatrix();
    translate(p.x, p.y);
    rotate(orientation);
  } else {
    printErr("Error in void start_matrix_3D(), vec pos is not an instance of vec2 or vec3, the matrix cannot be init") ;
    exit();
  }
}

// ivec
public void start_matrix_3D(ivec pos, ivec3 dir_cart) {
  vec3 temp_dir_cart = vec3(dir_cart.x, dir_cart.y, dir_cart.z);
  if(pos instanceof ivec2) {
    vec2 temp_pos = vec2(pos.x, pos.y);
    start_matrix_3D(temp_pos, temp_dir_cart);
  } else if(pos instanceof ivec3) {
    vec3 temp_pos = vec3(pos.x, pos.y, pos.z);
    start_matrix_3D(temp_pos, temp_dir_cart);
  } 
}

public void start_matrix_3D(ivec pos, ivec2 dir_polar) {
  vec2 temp_dir_polar = vec2(dir_polar.x, dir_polar.y);
  if(pos instanceof ivec2) {
    vec2 temp_pos = vec2(pos.x, pos.y);
    start_matrix_3D(temp_pos, temp_dir_polar);
  } else if(pos instanceof ivec3) {
    vec3 temp_pos = vec3(pos.x, pos.y, pos.z);
    start_matrix_3D(temp_pos, temp_dir_polar);
  }
}

public void start_matrix_2D(ivec pos, float orientation) {
  if(pos instanceof ivec2) {
    vec2 temp_pos = vec2(pos.x, pos.y);
    start_matrix_2D(temp_pos, orientation);
  } else if(pos instanceof ivec3) {
    vec3 temp_pos = vec3(pos.x, pos.y, pos.z);
    start_matrix_2D(temp_pos, orientation);
  }
}



// stop ans Start Matrix
public void start_matrix() {
  pushMatrix() ;
}


public void stop_matrix() {
  popMatrix() ;
}




/**
Matrix deprecated
*/
public @Deprecated
void matrix_3D_start(vec3 pos, vec3 dir_cart) {
  vec3 dir = dir_cart.copy() ;
  pushMatrix() ;
  translate(pos) ;
  float radius = sqrt(dir.x * dir.x + dir.y * dir.y + dir.z * dir.z);
  float longitude = acos(dir.x / sqrt(dir.x * dir.x + dir.y * dir.y)) * (dir.y < 0 ? -1 : 1);
  float latitude = acos(dir.z / radius) * (dir.z < 0 ? -1 : 1);
  // check NaN result
  if (Float.isNaN(longitude)) longitude = 0 ;
  if (Float.isNaN(latitude)) latitude = 0 ;
  if (Float.isNaN(radius)) radius = 0 ;
  rotateX(latitude) ;
  rotateY(longitude) ;
  printErr("void matrix_3D_start() is deprecated instead use start_matrix_3D()") ;
}

public @Deprecated
void matrix_3D_start(vec3 pos, vec2 dir_polar) {
  pushMatrix() ;
  translate(pos) ;
  rotateXY(dir_polar) ;
  printErr("void matrix_3D_start() is deprecated instead use start_matrix_3D()") ;
}

public @Deprecated
void matrix_2D_start(vec2 pos, float orientation) {
  pushMatrix() ;
  translate(pos) ;
  rotate(orientation) ;
  printErr("void matrix_2D_start() is deprecated instead use start_matrix_2D()") ;
}

public @Deprecated
void matrix_end() {
  popMatrix() ;
  printErr("void matrix_end() is deprecated instead use stop_matrix()") ;
}

public @Deprecated
void matrix_start() {
  pushMatrix() ;
  printErr("void matrix_start() is deprecated instead use start_matrix()") ;
}





















































/**
GHOST METHODS for PROCESSING
2018-2018
v 0.2.0
*/
// colorMode
public void colorMode(int mode) {
  if(get_layer() != null) {
    get_layer().colorMode(mode);
  } else {
    g.colorMode(mode);
  }
}

public void colorMode(int mode, float max) {
  if(get_layer() != null) {
    get_layer().colorMode(mode,max);
  } else {
    g.colorMode(mode,max);
  } 
}


public void colorMode(int mode, float max1, float max2, float max3) {
  if(get_layer() != null) {
    get_layer().colorMode(mode,max1,max2,max3);
  } else {
    g.colorMode(mode,max1,max2,max3);
  }
}
public void colorMode(int mode, float max1, float max2, float max3, float maxA) {
  if(get_layer() != null) {
    get_layer().colorMode(mode,max1,max2,max3,maxA);
  } else {
    g.colorMode(mode,max1,max2,max3,maxA);
  }
}




// Processing ghost method

// position
public void translate(float x, float y) {
  if(get_layer() != null) {
    get_layer().translate(x,y);
  } else {
    g.translate(x,y);
  }
}

public void translate(float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().translate(x,y,z);
  } else {
    g.translate(x,y,z);
  }
}


// rotate
public void rotate(float arg) {
  if(get_layer() != null) {
    get_layer().rotate(arg);
  } else {
    g.rotate(arg);
  }
}


public void rotateX(float arg) {
  if(get_layer() != null) {
    get_layer().rotateX(arg);
  } else {
    g.rotateX(arg);
  }
}

public void rotateY(float arg) {
  if(get_layer() != null) {
    get_layer().rotateY(arg);
  } else {
    g.rotateY(arg);
  }
}


public void rotateZ(float arg) {
  if(get_layer() != null) {
    get_layer().rotateZ(arg);
  } else {
    g.rotateZ(arg);
  }
}

// scale
public void scale(float s) {
  if(get_layer() != null) {
    get_layer().scale(s);
  } else {
    g.scale(s);
  }
}

public void scale(float x, float y) {
  if(get_layer() != null) {
    get_layer().scale(x,y);
  } else {
    g.scale(x,y);
  }
}

public void scale(float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().scale(x,y,z);
  } else {
    g.scale(x,y,z);
  }
}

// shear
public void shearX(float angle) {
  if(get_layer() != null) {
    get_layer().shearX(angle);
  } else {
    g.shearX(angle);
  }
}

public void shearY(float angle) {
  if(get_layer() != null) {
    get_layer().shearY(angle);
  } else {
    g.shearY(angle);
  }
}













/**
aspect
*/
// fill
public void noFill() {
  if(get_layer() != null) {
    get_layer().noFill();
  } else {
    g.noFill();
  }
} 

public void fill(int rgb) {
  if(get_layer() != null) {
    get_layer().fill(rgb);
  } else {
    g.fill(rgb);
  }
}


public void fill(int rgb, float alpha) {
  if(get_layer() != null) {
    get_layer().fill(rgb,alpha);
  } else {
    g.fill(rgb,alpha);
  }
}

public void fill(float gray) {
  if(get_layer() != null) {
    get_layer().fill(gray);
  } else {
    g.fill(gray);
  }
}


public void fill(float gray, float alpha) {
  if(get_layer() != null) {
    get_layer().fill(gray,alpha);
  } else {
    g.fill(gray,alpha);
  }
}

public void fill(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().fill(v1,v2,v3);
  } else {
    g.fill(v1,v2,v3);
  }
}

public void fill(float v1, float v2, float v3, float alpha) {
  if(get_layer() != null) {
    get_layer().fill(v1,v2,v3,alpha);
  } else {
    g.fill(v1,v2,v3,alpha);
  }
}

// stroke
public void noStroke() {
  if(get_layer() != null) {
    get_layer().noStroke();
  } else {
    g.noStroke();
  }
} 

public void stroke(int rgb) {
  if(get_layer() != null) {
    get_layer().stroke(rgb);
  } else {
    g.stroke(rgb);
  }
}


public void stroke(int rgb, float alpha) {
  if(get_layer() != null) {
    get_layer().stroke(rgb,alpha);
  } else {
    g.stroke(rgb,alpha);
  }
}

public void stroke(float gray) {
  if(get_layer() != null) {
    get_layer().stroke(gray);
  } else {
    g.stroke(gray);
  }
}


public void stroke(float gray, float alpha) {
  if(get_layer() != null) {
    get_layer().stroke(gray,alpha);
  } else {
    g.stroke(gray,alpha);
  }
}

public void stroke(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().stroke(v1,v2,v3);
  } else {
    g.stroke(v1,v2,v3);
  }
}

public void stroke(float v1, float v2, float v3, float alpha) {
  if(get_layer() != null) {
    get_layer().stroke(v1,v2,v3,alpha);
  } else {
    g.stroke(v1,v2,v3,alpha);
  }
}


// strokeWeight
public void strokeWeight(float thickness) {
  if(get_layer() != null) {
    get_layer().strokeWeight(thickness);
  } else {
    g.strokeWeight(thickness);
  }
}

// strokeJoin
public void strokeJoin(int join) {
  if(get_layer() != null) {
    get_layer().strokeJoin(join);
  } else {
    g.strokeJoin(join);
  }
}

// strokeJoin
public void strokeCapstrokeCap(int cap) {
  if(get_layer() != null) {
    get_layer().strokeCap(cap);
  } else {
    g.strokeCap(cap);
  }
}












/**
shape
*/

public void rectMode(int mode) {
  if(get_layer() != null) {
    get_layer().rectMode(mode);
  } else {
    g.rectMode(mode);
  }
}

public void ellipseMode(int mode) {
  if(get_layer() != null) {
    get_layer().ellipseMode(mode);
  } else {
    g.ellipseMode(mode);
  }
}

// rect
public void rect(float px, float py, float sx, float sy) {
  if(get_layer() != null) {
    get_layer().rect(px,py,sx,sy);
  } else {
    g.rect(px,py,sx,sy);
  }
}


public void rect(float  px, float py, float sx, float sy, float r) {
  if(get_layer() != null) {
    get_layer().rect(px,py,sx,sy,r);
  } else {
    g.rect(px,py,sx,sy,r);
  }
}

public void rect(float px, float py, float sx, float sy, float tl, float tr, float br, float bl) {
  if(get_layer() != null) {
    get_layer().rect(px,py,sx,sy,tl,tr,br,bl);
  } else {
    g.rect(px,py,sx,sy,tl,tr,br,bl);
  }
}


//arc
public void arc(float a, float b, float c, float d, float start, float stop) {
  if(get_layer() != null) {
    get_layer().arc(a,b,c,d,start,stop);
  } else {
    g.arc(a,b,c,d,start,stop);
  }
}

public void arc(float a, float b, float c, float d, float start, float stop, int mode) {
  if(get_layer() != null) {
    get_layer().arc(a,b,c,d,start,stop,mode);
  } else {
    g.arc(a,b,c,d,start,stop,mode);
  }
}

// ellipse
public void ellipse(int px, int py, int sx, int sy) {
  if(get_layer() != null) {
    get_layer().ellipse(px,py,sx,sy);
  } else {
    g.ellipse(px,py,sx,sy);
  }
}




// box
public void box(float s) {
  if(get_layer() != null) {
    get_layer().box(s,s,s);
  } else {
    g.box(s,s,s);
  }
}

public void box(float w, float h, float d) {
  if(get_layer() != null) {
    get_layer().box(w,h,d);
  } else {
    g.box(w,h,d);
  }
}


// sphere
public void sphere(float r) {
  if(get_layer() != null) {
    get_layer().sphere(r);
  } else {
    g.sphere(r);
    // p.sphere(r);
  }
}


// sphere detail
public void sphereDetail(int res) {
  if(get_layer() != null) {
    get_layer().sphereDetail(res);
  } else {
    g.sphereDetail(res);
  }
}

public void sphereDetail(int ures, int vres) {
  if(get_layer() != null) {
    get_layer().sphereDetail(ures,vres);
  } else {
    g.sphereDetail(ures,vres);
  }
}




//line
public void line(float x1, float y1, float x2, float y2) {
  if(get_layer() != null) {
    get_layer().line(x1,y1,x2,y2);
  } else {
    g.line(x1,y1,x2,y2);
  }
}

public void line(float x1, float y1, float z1, float x2, float y2, float z2) {
  if(get_layer() != null) {
    get_layer().line(x1,y1,z1,x2,y2,z2);
  } else {
    g.line(x1,y1,z1,x2,y2,z2);
  }
}






// point
public void point(float x, float y) {
  if(get_layer() != null) {
    get_layer().point(x,y);
  } else {
    g.point(x,y);
  }
}

public void point(float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().point(x,y,z);
  } else {
    g.point(x,y,z);
  }
}

// quad
public void quad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer() != null) {
    get_layer().quad(x1,y1,x2,y2,x3,y3,x4,y4);
  } else {
    g.quad(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}

// triangle
/*
method already use somewhere else
void triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
  if(get_layer() != null) {
    get_layer().triangle(x1,y1,x2,y2,x3,y3);
  } else {
    g.triangle(x1,y1,x2,y2,x3,y3);
  }
}
*/


/**
vertex
*/
// begin
public void beginShape() {
  if(get_layer() != null) {
    get_layer().beginShape();
  } else {
    g.beginShape();
  }
}

public void beginShape(int kind) {
  if(get_layer() != null) {
    get_layer().beginShape(kind);
  } else {
    g.beginShape(kind);
  }
}


public void endShape() {
  if(get_layer() != null) {
    get_layer().endShape();
  } else {
    g.endShape();
  }
}

public void endShape(int mode) {
  if(get_layer() != null) {
    get_layer().endShape(mode);
  } else {
    g.endShape(mode);
  }
}

// shape
public void shape(PShape shape) {
  if(get_layer() != null) {
    get_layer().shape(shape);
  } else {
    g.shape(shape);
  }
}

public void shape(PShape shape, float x, float y) {
  if(get_layer() != null) {
    get_layer().shape(shape,x,y);
  } else {
    g.shape(shape,x,y);
  }
}

public void shape(PShape shape, float a, float b, float c, float d) {
  if(get_layer() != null) {
    get_layer().shape(shape,a,b,c,d);
  } else {
    g.shape(shape,a,b,c,d);
  }
}




//vertex
public void vertex(float x, float y) {
  if(get_layer() != null) {
    get_layer().vertex(x,y);
  } else {
    g.vertex(x,y);
  }
}

public void vertex(float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().vertex(x,y,z);
  } else {
    g.vertex(x,y,z);
  }
}

public void vertex(float [] v) {
  if(get_layer() != null) {
    get_layer().vertex(v);
  } else {
    g.vertex(v);
  }
}

public void vertex(float x, float y, float u, float v) {
  if(get_layer() != null) {
    get_layer().vertex(x,y,u,v);
  } else {
    g.vertex(x,y,u,v);
  }
} 


public void vertex(float x, float y, float z, float u, float v) {
  if(get_layer() != null) {
    get_layer().vertex(x,y,z,u,v);
  } else {
    g.vertex(x,y,z,u,v);
  }
}  


// quadratic vertex
public void quadraticVertex(float cx, float cy, float x3, float y3) {
  if(get_layer() != null) {
    get_layer().quadraticVertex(cx,cy,x3,y3);
  } else {
    g.quadraticVertex(cx,cy,x3,y3);
  }
}

public void quadraticVertex(float cx, float cy, float cz, float x3, float y3, float z3) {
  if(get_layer() != null) {
    get_layer().quadraticVertex(cx,cy,cz,x3,y3,z3);
  } else {
    g.quadraticVertex(cx,cy,cz,x3,y3,z3);
  }
}

// curve vertex
public void curveVertex(float x, float y) {
  if(get_layer() != null) {
    get_layer().curveVertex(x,y);
  } else {
    g.curveVertex(x,y);
  }
}

public void curveVertex(float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().curveVertex(x,y,z);
  } else {
    g.curveVertex(x,y,z);
  }
}


//bezier vertex
public void bezierVertex(float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer() != null) {
    get_layer().bezierVertex(x2,y2,x3,y3,x4,y4);
  } else {
    g.bezierVertex(x2,y2,x3,y3,x4,y4);
  }
}


public void bezierVertex(float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(get_layer() != null) {
    get_layer().bezierVertex(x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.bezierVertex(x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// bezier
public void bezier(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer() != null) {
    get_layer().bezier(x1,y1,x2,y2,x3,y3,x4,y4);
  } else {
    g.bezier(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}

public void bezier(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(get_layer() != null) {
    get_layer().bezier(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.bezier(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// bezier detail
public void bezierDetail(int detail) {
  if(get_layer() != null) {
    get_layer().bezierDetail(detail);
  } else {
    g.bezierDetail(detail);
  }
}

// curve
public void curve(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if(get_layer() != null) {
    get_layer().curve(x1,y1,x2,y2,x3,y3,x4,y4);
  } else {
    g.curve(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}


public void curve(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  if(get_layer() != null) {
    get_layer().curve(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  } else {
    g.curve(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4);
  }
}

// curve detail
public void curveDetail(int detail) {
  if(get_layer() != null) {
    get_layer().curveDetail(detail);
  } else {
    g.curveDetail(detail);
  }
}




















// light
public void lights() {
  if(get_layer() != null) {
    get_layer().lights();
  } else {
    g.lights();
  }
}

public void noLights() {
  if(get_layer() != null) {
    get_layer().noLights();
  } else {
    g.noLights();
  }
}

// ambient light
public void ambientLight(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().ambientLight(v1,v2,v3);
  } else {
    g.ambientLight(v1,v2,v3);
  }
}


public void ambientLight(float v1, float v2, float v3, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().ambientLight(v1,v2,v3,x,y,z);
  } else {
    g.ambientLight(v1,v2,v3,x,y,z);
  }
}


//directionalLight(v1, v2, v3, nx, ny, nz)
public void directionalLight(float v1, float v2, float v3, float nx, float ny, float nz) {
  if(get_layer() != null) {
    get_layer().directionalLight(v1,v2,v3,nx,ny,nz);
  } else {
    g.directionalLight(v1,v2,v3,nx,ny,nz);
  }
}



// lightFalloff(constant, linear, quadratic)
public void lightFalloff(float constant, float linear, float quadratic) {
  if(get_layer() != null) {
    get_layer().lightFalloff(constant,linear,quadratic);
  } else {
    g.lightFalloff(constant,linear,quadratic);
  }
}


// lightSpecular(v1, v2, v3) 

public void lightSpecular(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().lightSpecular(v1,v2,v3);
  } else {
    g.lightSpecular(v1,v2,v3);
  }
}

// normal(nx, ny, nz)
public void normal(float nx, float ny, float nz) {
  if(get_layer() != null) {
    get_layer().normal(nx,ny,nz);
  } else {
    g.normal(nx,ny,nz);
  }
}


// pointLight(v1, v2, v3, x, y, z)
public void pointLight(float v1, float v2, float v3, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().pointLight(v1,v2,v3,x,y,z);
  } else {
    g.pointLight(v1,v2,v3,x,y,z);
  }
}

// spotLight(v1, v2, v3, x, y, z, nx, ny, nz, angle, concentration)
public void spotLight(float v1, float v2, float v3, float x, float y, float z, float nx, float ny, float nz, float angle, float concentration) {
  if(get_layer() != null) {
    get_layer().spotLight(v1,v2,v3,x,y,z,nx,ny,nz,angle,concentration);
  } else {
    g.spotLight(v1,v2,v3,x,y,z,nx,ny,nz,angle,concentration);
  }
}


/**
Material properties
*/
public void ambient(int rgb) {
  if(get_layer() != null) {
    get_layer().ambient(rgb);
  } else {
    g.ambient(rgb);
  }
}

public void ambient(float gray) {
  if(get_layer() != null) {
    get_layer().ambient(gray);
  } else {
    g.ambient(gray);
  }
}


public void ambient(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().ambient(v1,v2,v3);
  } else {
    g.ambient(v1,v2,v3);
  }
}


// emissive
public void emissive(int rgb) {
  if(get_layer() != null) {
    get_layer().emissive(rgb);
  } else {
    g.emissive(rgb);
  }
}

public void emissive(float gray) {
  if(get_layer() != null) {
    get_layer().emissive(gray);
  } else {
    g.emissive(gray);
  }
}


public void emissive(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().emissive(v1,v2,v3);
  } else {
    g.emissive(v1,v2,v3);
  }
}


// specular
public void specular(int rgb) {
  if(get_layer() != null) {
    get_layer().specular(rgb);
  } else {
    g.specular(rgb);
  }
}

public void specular(float gray) {
  if(get_layer() != null) {
    get_layer().specular(gray);
  } else {
    g.specular(gray);
  }
}


public void specular(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().specular(v1,v2,v3);
  } else {
    g.specular(v1,v2,v3);
  }
}


// shininess(shine)
public void shininess(float shine) {
  if(get_layer() != null) {
    get_layer().shininess(shine);
  } else {
    g.shininess(shine);
  }
}























/**
camera ghost
*/
// camera
public void camera() {
  if(get_layer() != null) {
    get_layer().camera();
  } else {
    g.camera();
  }
}

public void camera(float eyeX, float eyeY, float eyeZ, float centerX, float centerY, float centerZ, float upX, float upY, float upZ) {
  if(get_layer() != null) {
    get_layer().camera(eyeX,eyeY,eyeZ,centerX,centerY,centerZ,upX,upY,upZ);
  } else {
    g.camera(eyeX,eyeY,eyeZ,centerX,centerY,centerZ,upX,upY,upZ);
  }
}


public void beginCamera() {
  if(get_layer() != null) {
    get_layer().beginCamera();
  } else {
    g.beginCamera();
  }
}

public void endCamera() {
  if(get_layer() != null) {
    get_layer().endCamera();
  } else {
    g.endCamera();
  }
}


// frustum(left, right, bottom, top, near, far)
public void frustum(float left, float right, float bottom, float top, float near, float far) {
  if(get_layer() != null) {
    get_layer().frustum(left,right,bottom,top,near,far);
  } else {
    g.frustum(left,right,bottom,top,near,far);
  }
}


// ortho
public void ortho() {
  if(get_layer() != null) {
    get_layer().ortho();
  } else {
    g.ortho();
  }
}

public void ortho(float left, float right, float bottom, float top) {
  if(get_layer() != null) {
    get_layer().ortho(left,right,bottom,top);
  } else {
    g.ortho(left,right,bottom,top);
  }
}


public void ortho(float left, float right, float bottom, float top, float near, float far) {
  if(get_layer() != null) {
    get_layer().ortho(left,right,bottom,top,near,far);
  } else {
    g.ortho(left,right,bottom,top,near,far);
  }
}


  
// perspective
public void perspective() {
  if(get_layer() != null) {
    get_layer().perspective();
  } else {
    g.perspective();
  }
}


public void perspective(float fovy, float aspect, float zNear, float zFar) {
  if(get_layer() != null) {
    get_layer().perspective(fovy,aspect,zNear,zFar);
  } else {
    g.perspective(fovy,aspect,zNear,zFar);
  }
}


















/**
matrix
*/
public void pushMatrix() {
  if(get_layer() != null) {
    get_layer().pushMatrix();
  } else {
    g.pushMatrix();
  }
}


public void popMatrix() {
  if(get_layer() != null) {
    get_layer().popMatrix();
  } else {
    g.popMatrix();
  }
}


// apply matrix
public void applyMatrix(PMatrix source) {
  if(get_layer() != null) {
    get_layer().applyMatrix(source);
  } else {
    g.applyMatrix(source);
  }
}

public void applyMatrix(float n00, float n01, float n02, float n10, float n11, float n12) {
  if(get_layer() != null) {
    get_layer().applyMatrix(n00,n01,n02,n10,n11,n12);
  } else {
    g.applyMatrix(n00,n01,n02,n10,n11,n12);
  }
}

public void applyMatrix(float n00, float n01, float n02, float n03, float n10, float n11, float n12, float n13, float n20, float n21, float n22, float n23, float n30, float n31, float n32, float n33) {
  if(get_layer() != null) {
    get_layer().applyMatrix(n00,n01,n02,n03,n10,n11,n12,n13,n20,n21,n22,n23,n30,n31,n32,n33);
  } else {
    g.applyMatrix(n00,n01,n02,n03,n10,n11,n12,n13,n20,n21,n22,n23,n30,n31,n32,n33);
  }
}



public void resetMatrix() {
  if(get_layer() != null) {
    get_layer().resetMatrix();
  } else {
    g.resetMatrix();
  }
}


  












/**
image
*/
public void image(PImage img, float x, float y) {
  if(get_layer() != null) {
    get_layer().image(img,x,y);
  } else {
    g.image(img,x,y);
  }
}

public void image(PImage img, float a, float b, float c, float d) {
  if(get_layer() != null) {
    get_layer().image(img,a,b,c,d);
  } else {
    g.image(img,a,b,c,d);
  }
}














/**
get
*/
public int get(int x, int y) {
  if(get_layer() != null) {
    return get_layer().get(x,y);
  } else {
    return g.get(x,y);
  }
} 


public PImage get(int x, int y, int w, int h) {
  if(get_layer() != null) {
    return get_layer().get(x,y,w,h);
  } else {
    return g.get(x,y,w,h);
  }
}


public PImage get() {
  if(get_layer() != null) {
    return get_layer().get();
  } else {
    return g.get();
  }
}









/**
loadPixels()
*/
public void loadPixels() {
  if(get_layer() != null) {
    get_layer().loadPixels();
  } else {
    g.loadPixels();
  }
}


/**
updatePixels()
*/
public void updatePixels() {
  if(get_layer() != null) {
    get_layer().updatePixels();
  } else {
    g.updatePixels();
  }
}








/**
tint
*/
public void tint(int rgb) {
  if(get_layer() != null) {
    get_layer().tint(rgb);
  } else {
    g.tint(rgb);
  }
}

public void tint(int rgb, float alpha) {
  if(get_layer() != null) {
    get_layer().tint(rgb,alpha);
  } else {
    g.tint(rgb,alpha);
  }
}

public void tint(float gray) {
  if(get_layer() != null) {
    get_layer().tint(gray);
  } else {
    g.tint(gray);
  }
}

public void tint(float gray, float alpha) {
  if(get_layer() != null) {
    get_layer().tint(gray,alpha);
  } else {
    g.tint(gray,alpha);
  }
}

public void tint(float v1, float v2, float v3) {
  if(get_layer() != null) {
    get_layer().tint(v1,v2,v3);
  } else {
    g.tint(v1,v2,v3);
  }
}

public void tint(float v1, float v2, float v3, float alpha) {
  if(get_layer() != null) {
    get_layer().tint(v1,v2,v3,alpha);
  } else {
    g.tint(v1,v2,v3,alpha);
  }
}















/**
blend
*/
public void blend(int sx, int sy, int sw, int sh, int dx, int dy, int dw, int dh, int mode) {
  if(get_layer() != null) {
    get_layer().blend(sx,sy,sw,sh,dx,dy,dw,dh,mode);
  } else {
    g.blend(sx,sy,sw,sh,dx,dy,dw,dh,mode);
  }
}


public void blend(PImage src, int sx, int sy, int sw, int sh, int dx, int dy, int dw, int dh, int mode) {
  if(get_layer() != null) {
    get_layer().blend(src,sx,sy,sw,sh,dx,dy,dw,dh,mode);
  } else {
    g.blend(src,sx,sy,sw,sh,dx,dy,dw,dh,mode);
  }
}













/**
filter
*/
public void filter(PShader shader) {
  if(get_layer() != null) {
    get_layer().filter(shader);
  } else {
    g.filter(shader);
  }
}

public void filter(int kind) {
  if(get_layer() != null) {
    get_layer().filter(kind);
  } else {
    g.filter(kind);
  }
}

public void filter(int kind, float param) {
  if(get_layer() != null) {
    get_layer().filter(kind,param);
  } else {
    g.filter(kind,param);
  }
}













/**
set
*/
public void set(int x, int y, int c) {
  if(get_layer() != null) {
    get_layer().set(x,y,c);
  } else {
    /*
    x *= displayDensity();
    y *= displayDensity();
    */
    g.set(x,y,c);
  }
}

public void set(int x, int y, PImage img) {
  if(get_layer() != null) {
    get_layer().set(x,y,img);
  } else {
    /*
    x *= displayDensity();
    y *= displayDensity();
    */
    g.set(x,y,img);
  }
}














/**
text
2017-2019
v 0.1.1
*/
public void text(char c, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(c,x,y);
  } else {
    g.text(c,x,y);
  }
}


public void text(char c, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(c,x,y,z);
  } else {
    g.text(c,x,y,z);
  }
}

public void text(char [] chars, int start, int stop, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(chars,start,stop,x,y);
  } else {
    g.text(chars,start,stop,x,y);
  }
}


public void text(char [] chars, int start, int stop, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(chars,start,stop,x,y,z);
  } else {
    g.text(chars,start,stop,x,y,z);
  }
}



public void text(String str, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(str,x,y);
  } else {
    g.text(str,x,y);
  }
}


public void text(String str, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(str,x,y,z);
  } else {
    g.text(str,x,y,z);
  }
}


public void text(String str, float x1, float y1, float x2, float y2) {
  if(get_layer() != null) {
    get_layer().text(str,x1,y1,x2,y2);
  } else {
    g.text(str,x1,y1,x2,y2);
  }
}

public void text(float num, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(num,x,y);
  } else {
    g.text(num,x,y);
  }
}


public void text(float num, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(num,x,y,z);
  } else {
    g.text(num,x,y,z);
  }
}


public void text(int num, float x, float y) {
  if(get_layer() != null) {
    get_layer().text(num,x,y);
  } else {
    g.text(num,x,y);
  }
}


public void text(int num, float x, float y, float z) {
  if(get_layer() != null) {
    get_layer().text(num,x,y,z);
  } else {
    g.text(num,x,y,z);
  }
}


// text Align
public void textAlign(int alignX) {
  if(get_layer() != null) {
    get_layer().textAlign(alignX);
  } else {
    g.textAlign(alignX);
  }
}


public void textAlign(int alignX, int alignY) {
  if(get_layer() != null) {
    get_layer().textAlign(alignX,alignY);
  } else {
    g.textAlign(alignX,alignY);
  }
}

// textLeading(leading)
public void textLeading(float leading) {
if(get_layer() != null) {
    get_layer().textLeading(leading);
  } else {
    g.textLeading(leading);
  }
}


// textMode(mode)
public void textMode(int mode) {
  if(get_layer() != null) {
    get_layer().textMode(mode);
  } else {
    g.textMode(mode);
  }
}

// text Size
public void textSize(float size) {
  if(get_layer() != null) {
    get_layer().textSize(size);
  } else {
    g.textSize(size);
  }
}


// textFont
public void textFont(PFont font) {
  if(font != null) {
    if(get_layer() != null) {
      get_layer().textFont(font);
    } else {
      g.textFont(font);
    }
  }
}

public void textFont(PFont font, float size) {
  if(font != null) {
    if(get_layer() != null) {
      get_layer().textFont(font,size);
    } else {
      g.textFont(font,size);
    }
  }
}






  




/**
ROPE SCIENCE
v 0.7.0
* Copyleft (c) 2014-2019 
* Stan le Punk > http://stanlepunk.xyz/
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope_method
*
the sketch method tab is not included on this repository if you need
* @see https://github.com/StanLepunK/Old_code/tree/master/Science_rope_2017_12_8
* Processing 3.5.3
*/

/**
Gaussian randomize
v 0.0.2
*/
public @Deprecated
float random_gaussian(float value) {
  return random_gaussian(value, .4f) ;
}

public @Deprecated
float random_gaussian(float value, float range) {
  /*
  * It's cannot possible to indicate a value result here, this part need from the coder ?
  */
  printErrTempo(240,"float random_gaussian(); method must be improved or totaly deprecated");
  range = abs(range) ;
  float distrib = random(-1, 1) ;
  float result = 0 ;
  if(value == 0) {
    value = 1 ;
    result = (pow(distrib,5)) *(value *range) +value ;
    result-- ;
  } else {
    result = (pow(distrib,5)) *(value *range) +value ;
  }
  return result;
}



/**
Next Gaussian randomize
v 0.0.2
*/
/**
* return value from -1 to 1
* @return float
*/
Random random = new Random();
public float random_next_gaussian() {
  return random_next_gaussian(1,1);
}

public float random_next_gaussian(int n) {
  return random_next_gaussian(1,n);
}

public float random_next_gaussian(float range) {
  return random_next_gaussian(range,1);
}

public float random_next_gaussian(float range, int n) {
  float roots = (float)random.nextGaussian();
  float var = map(roots,-2.5f,2.5f,-1,1);  
  if(n > 1) {
    if(n%2 ==0 && var < 0) {
       var = -1 *pow(var,n);
     } else {
       var = pow(var,n);
     }
     return var *range ;
  } else {
    return var *range ;
  }
}


















/**
Physic Rope
v 0.0.2
*/
public double g_force(double dist, double m_1, double m_2) {
  return RConstants.G *(dist*dist)/(m_1 *m_2);
}



/**
Math rope 
v 1.8.17
* @author Stan le Punk
* @see https://github.com/StanLepunK/Math_rope
*/
/**
Algebra utils
*/
//roots dimensions n
public float roots(float valueToRoots, int n) {
  return pow(valueToRoots, 1.0f/n) ;
}

// Decimal
// @return a specific quantity of decimal after comma
public float decimale(float var, int n) {
  float div = pow(10, abs(n)) ;
  return Math.round(var *div) / div;
}


/**
geometry util
v. 0.0.7
*/
public float perimeter_disc(int r) {
  return 2 *r *PI ;
}

public float radius_from_circle_surface(int surface) {
  return sqrt(surface/PI) ;
}


public boolean inside(ivec pos, ivec size, ivec2 target_pos) {
  return inside(vec2(pos.x,pos.y), vec2(size.x,size.y), vec2(target_pos), ELLIPSE);
}

public boolean inside(ivec pos, ivec size, ivec2 target_pos, int type) {
  return inside(vec2(pos.x,pos.y), vec2(size.x,size.y), vec2(target_pos), type);
}

public boolean inside(vec pos, vec size, vec2 target_pos) {
  return inside(pos, size, target_pos, ELLIPSE);
}

public boolean inside(vec pos, vec size, vec2 target_pos, int type) {
  if(type == ELLIPSE) {
    // this part can be improve to check the 'x' and the 'y'
    if (dist(vec2(pos.x,pos.y), target_pos) < size.x *.5f) return true ; 
    else return false ;
  } else {
    if(target_pos.x > pos.x && target_pos.x < pos.x +size.x && 
       target_pos.y > pos.y && target_pos.y < pos.y +size.y) return true ; 
      else return false ;
  } 
}






/**
GEOMETRY POLAR and CARTESIAN
*/
/**
Info
http://mathinsight.org/vectors_cartesian_coordinates_2d_3d
http://zone.ni.com/reference/en-XX/help/371361H-01/gmath/3d_cartesian_coordinate_rotation_euler/
http://www.mathsisfun.com/polar-cartesian-coordinates.html
https://en.wikipedia.org/wiki/Spherical_coordinate_system
http://stackoverflow.com/questions/20769011/converting-3d-polar-coordinates-to-cartesian-coordinates
http://www.vias.org/comp_geometry/math_coord_convert_3d.htm
http://mathworld.wolfram.com/Sphere.html
*/
/*
@return float
*/
public float longitude(float x, float range) {
  return map(x, 0,range, 0, TAU) ;
}

public float latitude(float y, float range) {
  return map(y, 0,range, 0, TAU) ;
}

/**
angle
v 0.0.2
* @return float
*/
public float angle_radians(float y, float range) {
  return map(y, 0,range, 0, TAU) ;
}

public float angle_degrees(float y, float range) {
  return map(y, 0,range, 0, 360) ;
}

public float angle(vec2 a, vec2 b) {
  return atan2(b.y -a.y, b.x -a.x);
}

public float angle(vec2 v) {
  return atan2(v.y, v.x);
}



  

/* 
return a vector info : radius,longitude, latitude
@return vec3
*/
public vec3 to_polar(vec3 cart) {
  float radius = sqrt(cart.x * cart.x + cart.y * cart.y + cart.z * cart.z);
  float phi = acos(cart.x / sqrt(cart.x * cart.x + cart.y * cart.y)) * (cart.y < 0 ? -1 : 1);
  float theta = acos(cart.z / radius) * (cart.z < 0 ? -1 : 1);
  // check NaN result
  if (Float.isNaN(phi)) phi = 0 ;
  if (Float.isNaN(theta)) theta = 0 ;
  if (Float.isNaN(radius)) radius = 0 ;
  // result
  //return new vec3(radius, longitude, latitude) ;
  return new vec3(phi, theta, radius) ;
}


///////////////
// Cartesian 3D
/*
@ return vec3
return the position of point on Sphere, with longitude and latitude
*/
//If you want just the final pos
public vec3 to_cartesian_3D(vec2 pos, vec2 range, float sizeField)  {
  // vertical plan position
  float verticalY = to_cartesian_2D(pos.y, vec2(0,range.y), vec2(0,TAU), sizeField).x ;
  float verticalZ = to_cartesian_2D(pos.y, vec2(0,range.y), vec2(0,TAU), sizeField).y ; 
  vec3 posVertical = new vec3(0, verticalY, verticalZ) ;
  // horizontal plan position
  float horizontalX = to_cartesian_2D(pos.x, vec2(0,range.x), vec2(0,TAU), sizeField).x ; 
  float horizontalZ = to_cartesian_2D(pos.x, vec2(0,range.x), vec2(0,TAU), sizeField).y  ;
  vec3 posHorizontal = new vec3(horizontalX, 0, horizontalZ) ;
  
  return projection(middle(posVertical, posHorizontal), sizeField) ;
}

public vec3 to_cartesian_3D(float latitude, float longitude) {
  float radius_normal = 1 ;
  return to_cartesian_3D(latitude, longitude, radius_normal);
}

// main method
public vec3 to_cartesian_3D(float latitude, float longitude,  float radius) {
  // https://en.wikipedia.org/wiki/List_of_common_coordinate_transformations
  

  /*
  //  Must be improve is not really good in the border versus direct polar rotation with the matrix
  */ 
  float theta = longitude%TAU ;
  float phi = latitude%PI ;

  float x = radius *sin(theta) *cos(phi);
  float y = radius *sin(theta) *sin(phi);
  float z = radius *cos(theta);
  return new vec3(x, y, z);
}
/*
vec3 to_cartesian_3D(float longitude, float latitude, float radius) {
  // https://en.wikipedia.org/wiki/List_of_common_coordinate_transformations
  float x = radius *sin(latitude) *cos(longitude);
  float y = radius *sin(latitude) *sin(longitude);
  float z = radius *cos(latitude);
  return new vec3(x, y, z);
}
*/



//Step 1 : translate the mouse position x and y  on the sphere, we must do that separately
/*
@ return vec2 
return linear value on the circle perimeter
*/
public vec2 to_cartesian_2D (float posMouse, vec2 range, vec2 targetRadian, float distance) {
  float rotationPlan = map(posMouse, range.x, range.y, targetRadian.x, targetRadian.y)  ;
  return to_cartesian_2D (rotationPlan, distance) ;
}

public vec2 to_cartesian_2D (float angle) {
  float radius_normal = 1 ;
  return to_cartesian_2D (angle, radius_normal) ;
}

// main method
public vec2 to_cartesian_2D (float angle, float radius) {
  float x = cos(angle) *radius;
  float y = sin(angle) *radius ;
  return vec2(x,y) ;
}







/**
Projection
*/
// Cartesian projection 2D
public vec2 projection(vec2 direction) {
  return projection(direction, vec2(), 1.f) ;
}

public vec2 projection(vec2 direction, float radius) {
  return projection(direction, vec2(), radius) ;
}
public vec2 projection(vec2 direction, vec2 origin, float radius) {
  // vec3 p = point_to_project.normalize(origin) ;
  vec2 ref = direction.copy() ;
  vec2 p = ref.dir(origin) ;
  p.mult(radius) ;
  p.add(origin) ;
  return p ;
}
// polar projection 2D
public vec2 projection(float angle) {
  return projection(angle, 1) ;
}
public vec2 projection(float angle, float radius) {
  return vec2(cos(angle) *radius, sin(angle) *radius) ;
}
// cartesian projection 3D
public vec3 projection(vec3 direction) {
  return projection(direction, vec3(), 1.f) ;
}

public vec3 projection(vec3 direction, float radius) {
  return projection(direction, vec3(), radius) ;
}

public vec3 projection(vec3 direction, vec3 origin, float radius) {
  vec3 ref = direction.copy() ;
  vec3 p = ref.dir(origin) ;
  p.mult(radius) ;
  p.add(origin) ;
  return p ;
}


/**
look at 
before target direction
v 0.0.2
*/
// Target direction return the normal direction of the target from the origin
public @Deprecated
vec2 target_direction(vec2 target, vec2 my_position) {
  printErrTempo(240, "vec2 target_direction() deprecated instead use look_at(vec target, vec origin) method, becareful the result is mult by -1");
  return projection(target, my_position, 1).sub(my_position);
}

public @Deprecated
vec3 target_direction(vec3 target, vec3 my_position) {
   printErrTempo(240, "vec2 target_direction() deprecated instead use look_at(vec target, vec origin) method, becareful the result is mult by -1");
  return projection(target, my_position, 1).sub(my_position) ;
}


public vec2 look_at(vec2 target, vec2 origin) {
  return projection(target, origin, 1).sub(origin).mult(-1,1);
}

public vec3 look_at(vec3 target, vec3 origin) {
  return projection(target, origin, 1).sub(origin);
}





/**
SPHERE PROJECTION
*/
/**
FIBONACCI SPHERE PROJECTION CARTESIAN
*/
public vec3 [] list_cartesian_fibonacci_sphere (int num, float step, float root) {
  float root_sphere = root *num ;
  vec3 [] list_points = new vec3[num] ;
  for (int i = 0; i < list_points.length ; i++) list_points[i] = distribution_cartesian_fibonacci_sphere(i, num, step, root_sphere) ;
  return list_points ;
}
/*
float root_cartesian_fibonnaci(int num) {
  return random(1) *num ;
}
*/

public vec3 distribution_cartesian_fibonacci_sphere(int n, int num, float step, float root) {
  if(n<num) {
    float offset = 2.f / num ;
    float y  = (n *offset) -1 + (offset / 2.f) ;
    float r = sqrt(1 - pow(y,2)) ;
    float phi = ((n +root)%num) * step ;
    
    float x = cos(phi) *r ;
    float z = sin(phi) *r ;
    
    return vec3(x,y,z) ;
  } else return vec3() ;
}

/**
POLAR PROJECTION FIBONACCI SPHERE
*/
public vec2 [] list_polar_fibonacci_sphere(int num, float step) {
  vec2 [] list_points = new vec2[num] ;
  for (int i = 0; i < list_points.length ; i++) list_points[i] = distribution_polar_fibonacci_sphere(i, num, step) ;
  return list_points ;
}
public vec2 distribution_polar_fibonacci_sphere(int n, int num, float step) {
  if(n<num) {
    float longitude = r.PHI *TAU *n;
    longitude /= step ;
    // like a normalization of the result ?
    longitude -= floor(longitude); 
    longitude *= TAU;
    if (longitude > PI)  longitude -= TAU;
    // Convert dome height (which is proportional to surface area) to latitude
    float latitude = asin(-1 + 2*n/(float)num);
    return vec2(longitude, latitude) ;
  } else return vec2() ;

}




// normal direction 0-360 to -1, 1 PVector
public PVector normal_direction(int direction) {
  int numPoints = 360;
  float angle = TWO_PI/(float)numPoints;
  direction = 360-direction;
  direction += 180;
  return new PVector(sin(angle*direction), cos(angle*direction));
}

// degre direction from PVector direction
public float deg360 (PVector dir) {
  float deg360 ;
  deg360 = 360 -(degrees(atan2(dir.x, dir.y)) +180)   ;
  return deg360 ;
}

public float deg360 (vec2 dir) {
  float deg360 ;
  deg360 = 360 -(degrees(atan2(dir.x, dir.y)) +180)   ;
  return deg360 ;
}

/**
ROTATION
*/
//Rotation Objet
public void rotation (float angle, float posX, float posY) {
  translate(posX, posY ) ;
  rotate (radians(angle) ) ;
}
public void rotation (float angle, vec2 pos) {
  translate(pos.x, pos.y) ;
  rotate (radians(angle) ) ;
}

public vec2 rotation (vec2 ref, vec2 lattice, float angle) {
  float a = angle(lattice, ref) + angle;
  float d = lattice.dist(ref);
  float x = lattice.x + cos( a ) * d;
  float y = lattice.y + sin( a ) * d;
  return vec2(x,y);
}

/**
May be must push to deprecated
*/
public vec2 rotation_lattice(vec2 ref, vec2 lattice, float angle) {
  float a = angle( lattice, ref ) + angle;
  float d = dist( lattice, ref );
  float x = lattice.x + cos( a ) * d;
  float y = lattice.y + sin( a ) * d;
  return vec2(x,y);
}









/**
PRIMITIVE 2D
*/
/**
DISC
*/
public void disc(PVector pos, int diam, int c ) {
  for ( int i = 1 ; i < diam +1 ; i++) {
    circle(c, pos, i) ;
  }
}

public void chromatic_disc( PVector pos, int diam ) {
  for ( int i = 1 ; i < diam +1 ; i++) {
    chromatic_circle(pos, i) ;
  }
}

/**
CIRCLE
*/
public void chromatic_circle(PVector pos, int d) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radius_from_circle_surface(surface)) ;
  int numPoints = ceil(perimeter_disc( radius)) ;
  for(int i=0; i < numPoints; i++) {
      //circle
      float stepAngle = map(i, 0, numPoints, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      //color
      int c = color (i, 100,100) ;
      //display
      set(PApplet.parseInt(projection(angle, radius).x + pos.x) , PApplet.parseInt(projection(angle, radius).y + pos.y), c);
  }
}


//full cirlce
public void circle(int c, PVector pos, int d) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radius_from_circle_surface(surface)) ;
  int numPoints = ceil(perimeter_disc(radius)) ;
  for(int i=0; i < numPoints; i++) {
      float stepAngle = map(i, 0, numPoints, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      set(PApplet.parseInt(projection(angle, radius).x + pos.x) , PApplet.parseInt(projection(angle, radius).y + pos.y), c);
  }
}

//circle with a specific quantity points
public void circle(int c, PVector pos, int d, int num) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?

  int radius = ceil(radius_from_circle_surface(surface)) ;
  for(int i=0; i < num; i++) {
      float stepAngle = map(i, 0, num, 0, 2*PI) ; 
      float angle =  2*PI - stepAngle;
      set(PApplet.parseInt(projection(angle, radius).x + pos.x) , PApplet.parseInt(projection(angle, radius).y + pos.y), c);
  }
}
//circle with a specific quantity points and specific shape for each point
public void circle(PVector pos, int d, int num, PVector size, String shape) {
  int surface = d*d ; // surface is equale of square surface where is the cirlcke...make sens ?
  int whichShape = 0 ;
  if (shape.equals("point") )  whichShape = 0;
  else if (shape.equals("ellipse") )  whichShape = 1 ;
  else if (shape.equals("rect") )  whichShape = 2 ;
  else if (shape.equals("box") )  whichShape = 3 ;
  else if (shape.equals("sphere") )  whichShape = 4 ;
  else whichShape = 0 ;

  int radius = ceil(radius_from_circle_surface(surface)) ;
  for(int i=0; i < num; i++) {
    float stepAngle = map(i, 0, num, 0, 2*PI) ; 
    float angle =  2*PI - stepAngle;
    PVector newPos = new PVector(projection(angle, radius).x + pos.x, projection(angle, radius).y + pos.y) ;
    if(whichShape == 0 ) point(newPos.x, newPos.y) ;
    if(whichShape == 1 ) ellipse(newPos.x, newPos.y, size.x, size.y) ;
    if(whichShape == 2 ) rect(newPos.x, newPos.y, size.x, size.y) ;
    if(whichShape == 3 ) {
      pushMatrix() ;
      translate(newPos.x, newPos.y,0) ;
      box(size.x, size.y, size.z) ;
      popMatrix() ;
    }
    if(whichShape == 4 ) {
      pushMatrix() ;
      translate(newPos.x, newPos.y,0) ;
      int detail = (int)size.x /4 ;
      if (detail > 10 ) detail = 10 ;
      sphereDetail(detail) ;
      sphere(size.x) ;
      popMatrix() ;
    }
  }
}
// summits around the circle
public PVector [] circle (PVector pos, int d, int num) {
  PVector [] p = new PVector [num] ;
  int surface = d*d ; 
  int radius = ceil(radius_from_circle_surface(surface)) ;
  
  // choice your starting point
  float startingAnglePos = PI*.5f;
  if(num == 4) startingAnglePos = PI*.25f;
  
  for( int i=0 ; i < num ; i++) {
    float stepAngle = map(i, 0, num, 0, TAU) ; 
    float angle =  TAU - stepAngle -startingAnglePos;
    p[i] = new PVector(projection(angle, radius).x +pos.x,projection(angle, radius).y + pos.y) ;
  }
  return p ;
}

public PVector [] circle (PVector pos, int d, int num, float jitter) {
  PVector [] p = new PVector [num] ;
  int surface = d*d ; 
  int radius = ceil(radius_from_circle_surface(surface)) ;
  
  // choice your starting point
  float startingAnglePos = PI*.5f;
  if(num == 4) startingAnglePos = PI*.25f;
  
  float angleCorrection ; // this correction is cosmetic, when we'he a pair beam this one is stable for your eyes :)
  for( int i=0 ; i < num ; i++) {
    int beam = num /2 ;
    if ( beam%2 == 0 ) angleCorrection = PI / num ; else angleCorrection = 0.0f ;
    if ( num%2 == 0 ) jitter *= -1 ; else jitter *= 1 ; // the beam have two points at the top and each one must go to the opposate...
    
    float stepAngle = map(i, 0, num, 0, TAU) ;
    float jitterAngle = map(jitter, -1, 1, -PI/num, PI/num) ;
    float angle =  TAU -stepAngle +jitterAngle +angleCorrection -startingAnglePos;
    
    p[i] = new PVector(projection(angle, radius).x +pos.x, projection(angle, radius).y +pos.y) ;
  }
  return p ;
}
/**
END DISC and CIRCLE
*/



































/**
PRIMITIVE 3D
*/

/**
POLYDRON
v 0.2.0
*/
  //create Polyhedron
  /*
  "TETRAHEDRON","CUBE", "OCTOHEDRON", "DODECAHEDRON","ICOSAHEDRON","CUBOCTAHEDRON","ICOSI DODECAHEDRON",
  "TRUNCATED CUBE","TRUNCATED OCTAHEDRON","TRUNCATED DODECAHEDRON","TRUNCATED ICOSAHEDRON","TRUNCATED CUBOCTAHEDRON","RHOMBIC CUBOCTAHEDRON",
  "RHOMBIC DODECAHEDRON","RHOMBIC TRIACONTAHEDRON","RHOMBIC COSI DODECAHEDRON SMALL","RHOMBIC COSI DODECAHEDRON GREAT"
  All Polyhedrons can use "POINT" and "LINE" display mode.
  except the "TETRAHEDRON" who can also use "VERTEX" display mode.
  */
  
// MAIN VOID to create polyhedron
public void polyhedron(String type, String style, int size) {
  //This is where the actual defining of the polyhedrons takes place

  if(vec_polyhedron_list != null) {
    //clear out whatever verts are currently defined
    vec_polyhedron_list.clear();
  } else {
    vec_polyhedron_list = new ArrayList();
  }
  
  if(type.equals("TETRAHEDRON")) tetrahedron_poly(size) ;
  if(type.equals("CUBE")) cube(size) ;
  if(type.equals("OCTOHEDRON")) octohedron(size) ;
  if(type.equals("DODECAHEDRON"))dodecahedron(size) ;
  if(type.equals("ICOSAHEDRON"))icosahedron(size) ;
  if(type.equals("CUBOCTAHEDRON"))cuboctahedron(size) ;
  if(type.equals("ICOSI DODECAHEDRON"))icosi_dodecahedron(size) ;

  if(type.equals("TRUNCATED CUBE"))truncated_cube(size) ;
  if(type.equals("TRUNCATED OCTAHEDRON"))truncated_octahedron(size) ;
  if(type.equals("TRUNCATED DODECAHEDRON"))truncated_dodecahedron(size) ;
  if(type.equals("TRUNCATED ICOSAHEDRON"))truncated_icosahedron(size) ;
  if(type.equals("TRUNCATED CUBOCTAHEDRON"))truncated_cuboctahedron(size) ;
  
  if(type.equals("RHOMBIC CUBOCTAHEDRON"))rhombic_cuboctahedron(size) ;
  if(type.equals("RHOMBIC DODECAHEDRON"))rhombic_dodecahedron(size) ;
  if(type.equals("RHOMBIC TRIACONTAHEDRON"))rhombic_triacontahedron(size) ;
  if(type.equals("RHOMBIC COSI DODECAHEDRON SMALL"))rhombic_cosi_dodecahedron_small(size) ;
  if(type.equals("RHOMBIC COSI DODECAHEDRON GREAT"))rhombic_cosi_dodecahedron_great(size) ;
  
  // which method to draw
  if(style.equals("LINE")) polyhedron_draw_line(type) ;
  if(style.equals("POINT")) polyhedron_draw_point(type) ;
  if(style.equals("VERTEX")) polyhedron_draw_vertex(type) ;

}




// POLYHEDRON DETAIL 
//set up initial polyhedron
float factor_size_polyhedron ;
//some variables to hold the current polyhedron...
ArrayList<vec3>vec_polyhedron_list;
float edge_polyhedron_length;
String strName, strNotes;

// FEW POLYHEDRON
// BASIC
public void tetrahedron_poly(int size) {
  if(vec_polyhedron_list == null) vec_polyhedron_list = new ArrayList();
  vec_polyhedron_list.add(vec3(1,1,1));
  vec_polyhedron_list.add(vec3(-1,-1,1));
  vec_polyhedron_list.add(vec3(-1,1,-1));
  vec_polyhedron_list.add(vec3(1,-1,-1));
  edge_polyhedron_length = 0 ;
  factor_size_polyhedron = size /2;
}

public void cube(int size) {
  addVerts(1, 1, 1);
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size /2;
}

public void octohedron(int size) {
  addPermutations(1, 0, 0);
  edge_polyhedron_length = r.ROOT2;
  factor_size_polyhedron = size *.8f;
}

public void dodecahedron(int size) {
  addVerts(1, 1, 1);
  addPermutations(0, 1/r.PHI, r.PHI);
  edge_polyhedron_length = 2/r.PHI;
  factor_size_polyhedron = size /2.5f;
}


// SPECIAL
public void icosahedron(int size) {
  addPermutations(0,1,r.PHI);
  edge_polyhedron_length = 2.0f;
  factor_size_polyhedron = size /2.7f;
}

public void icosi_dodecahedron(int size) {
  addPermutations(0,0,2*r.PHI);
  addPermutations(1,r.PHI,sq(r.PHI));
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/5;
}

public void cuboctahedron(int size) {
  addPermutations(1,0,1);
  edge_polyhedron_length = r.ROOT2;
  factor_size_polyhedron = size /1.9f;
}


// TRUNCATED
public void truncated_cube(int size) {
  addPermutations(r.ROOT2-1,1,1);
  edge_polyhedron_length = 2*(r.ROOT2-1);     
  factor_size_polyhedron = size /2.1f;
}

public void truncated_octahedron(int size) {
  addPermutations(0,1,2);
  addPermutations(2,1,0);
  edge_polyhedron_length = r.ROOT2;
  factor_size_polyhedron = size/3.4f;
}

public void truncated_cuboctahedron(int size) {
  addPermutations(r.ROOT2+1,2*r.ROOT2 + 1, 1);
  addPermutations(r.ROOT2+1,1,2*r.ROOT2 + 1);
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/6.9f;
}

public void truncated_dodecahedron(int size) {
  addPermutations(0,1/r.PHI,r.PHI+2);
  addPermutations(1/r.PHI,r.PHI,2*r.PHI);
  addPermutations(r.PHI,2,sq(r.PHI));
  edge_polyhedron_length = 2*(r.PHI - 1);
  factor_size_polyhedron = size/6;
}

public void truncated_icosahedron(int size) {
  addPermutations(0,1,3*r.PHI);
  addPermutations(2,2*r.PHI+1,r.PHI);
  addPermutations(1,r.PHI+2,2*r.PHI);
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/8;
}

// RHOMBIC
public void rhombic_dodecahedron(int size) {
  addVerts(1,1,1);
  addPermutations(0,0,2);
  edge_polyhedron_length = sqrt(3);
  factor_size_polyhedron = size /2.8f;
}

public void rhombic_triacontahedron(int size) {
  addVerts(sq(r.PHI), sq(r.PHI), sq(r.PHI));
  addPermutations(sq(r.PHI), 0, pow(r.PHI, 3));
  addPermutations(0,r.PHI, pow(r.PHI,3));
  edge_polyhedron_length = r.PHI*sqrt(r.PHI+2);
  factor_size_polyhedron = size /7.2f;
}

public void rhombic_cuboctahedron(int size) {
  addPermutations(r.ROOT2 + 1, 1, 1);
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/4.2f;
}

public void rhombic_cosi_dodecahedron_small(int size) {
  addPermutations(1, 1, pow(r.PHI,3));
  addPermutations(sq(r.PHI),r.PHI,2*r.PHI);
  addPermutations(r.PHI+2,0,sq(r.PHI));
  edge_polyhedron_length = 2;
  factor_size_polyhedron = size/7.4f;
}

public void rhombic_cosi_dodecahedron_great(int size) {
  addPermutations(1/r.PHI,1/r.PHI,r.PHI+3);
  addPermutations(2/r.PHI,r.PHI,2*r.PHI+1);
  addPermutations(1/r.PHI, sq(r.PHI),3*r.PHI-1);
  addPermutations(2*r.PHI-1,2,r.PHI+2);
  addPermutations(r.PHI,3,2*r.PHI);
  edge_polyhedron_length = 2*r.PHI-2;
  factor_size_polyhedron = size/7.8f;
}



//Built Tetrahedron
// EASY METHOD, for direct and single drawing
// classic and easy method
public void polyhedron_draw_point(String name) {
  for (int i = 0 ; i < vec_polyhedron_list.size() ; i++) {
    vec3 point = vec_polyhedron_list.get(i);
    if(name.equals("TETRAHEDRON")) {
      pushMatrix() ;
      rotateX(TAU -1) ;
      rotateY(PI/4) ;
    }
    point(point.x *factor_size_polyhedron, point.y *factor_size_polyhedron, point.z *factor_size_polyhedron);
    if(name.equals("TETRAHEDRON")) popMatrix() ;
  }
}

public void polyhedron_draw_line(String name) {
  for (int i=0; i <vec_polyhedron_list.size(); i++) {
    for (int j=i +1; j < vec_polyhedron_list.size(); j++) {
      if (isEdge(i, j, vec_polyhedron_list) || edge_polyhedron_length == 0 ) {
        vec3 v1 = vec_polyhedron_list.get(i).copy();
        vec3 v2 = vec_polyhedron_list.get(j).copy();
        if(name.equals("TETRAHEDRON")) {
          pushMatrix() ;
          rotateX(TAU -1) ;
          rotateY(PI/4) ;
        }
        line(v1.x *factor_size_polyhedron, v1.y *factor_size_polyhedron, v1.z *factor_size_polyhedron, v2.x *factor_size_polyhedron, v2.y *factor_size_polyhedron, v2.z *factor_size_polyhedron);
        if(name.equals("TETRAHEDRON")) popMatrix() ;
      }
    }
  }
}

public void polyhedron_draw_vertex(String name) {
  // TETRAHEDRON
  if(name.equals("TETRAHEDRON")) {
    pushMatrix() ;
    rotateX(TAU -1) ;
    rotateY(PI/4) ;
    int n = 4 ; // quantity of face of Tetrahedron
    for(int i = 0 ; i < n ; i++) {
      // println("je suis là face",i);
      // choice of each point
      int a = i ;
      int b = i+1 ;
      int c = i+2 ;
      if(i == n-2 ) c = 0 ;
      if(i == n-1 ) {
        b = 0 ;
        c = 1 ;
      }
      vec3 v1 = vec_polyhedron_list.get(a).copy();
      vec3 v2 = vec_polyhedron_list.get(b).copy();
      vec3 v3 = vec_polyhedron_list.get(c).copy();
      // scale the position of the points
      v1.mult(factor_size_polyhedron);
      v2.mult(factor_size_polyhedron);
      v3.mult(factor_size_polyhedron);
      
      // drawing
      beginShape() ;
      vertex(v1) ;
      vertex(v2) ;
      vertex(v3) ;
      endShape(CLOSE) ;
    }
    popMatrix() ;
  // OTHER POLYHEDRON
  } else {
    beginShape() ;
    for (int i= 0; i <vec_polyhedron_list.size(); i++) {
      for (int j= i +1; j <vec_polyhedron_list.size(); j++) {
        if (isEdge(i, j, vec_polyhedron_list) || edge_polyhedron_length == 0 ) {
          // vLine((PVector)vec_polyhedron_list.get(i), (PVector)vec_polyhedron_list.get(j));
          vec3 v1 = vec_polyhedron_list.get(i).copy();
          vec3 v2 = vec_polyhedron_list.get(j).copy();
          v1.mult(factor_size_polyhedron);
          v2.mult(factor_size_polyhedron);;
          vertex(v1);
          vertex(v2);
        }
      }
    }
    endShape(CLOSE) ;
  }
}
// END of EASY METHOD and DIRECT METHOD

 



/**
annexe draw polyhedron
*/
public boolean isEdge(int vID1, int vID2, ArrayList<vec3>listPoint) {
  //had some rounding errors that were messing things up, so I had to make it a bit more forgiving...
  int pres = 1000;
  vec3 v1 = listPoint.get(vID1).copy();
  vec3 v2 = listPoint.get(vID2).copy();
  float d = sqrt(sq(v1.x - v2.x) + sq(v1.y - v2.y) + sq(v1.z - v2.z)) + .00001f;
  return (PApplet.parseInt(d *pres)==PApplet.parseInt(edge_polyhedron_length *pres));
}






// ADD POINTS for built POLYHEDRON
/////////////////////////////////
public void addPermutations(float x, float y, float z) {
  //adds vertices for all three permutations of x, y, and z
  addVerts(x, y, z);
  addVerts(z, x, y);
  addVerts(y, z, x);
}


 
public void addVerts(float x, float y, float z) {
  //adds the requested vert and all "mirrored" verts
  vec_polyhedron_list.add (vec3(x,y,z));
  // z
  if (z != 0.0f) vec_polyhedron_list.add (vec3(x,y,-z)); 
  // y
  if (y != 0.0f) {
    vec_polyhedron_list.add (vec3(x, -y, z));
    if (z != 0.0f) vec_polyhedron_list.add(vec3(x,-y,-z));
  } 
  // x
  if (x != 0.0f) {
    vec_polyhedron_list.add (vec3(-x, y, z));
    if (z != 0.0f) vec_polyhedron_list.add(vec3(-x,y,-z));
    if (y != 0.0f) {
      vec_polyhedron_list.add(vec3(-x, -y, z));
      if (z != 0.0f) vec_polyhedron_list.add(vec3(-x,-y,-z));
    }
  }
}
/**
SHADER filter
v 0.6.0
few method manipulate image with the shader to don't slower Processing
part
*/
PShader rope_shader_level, rope_shader_mix, rope_shader_blend, rope_shader_overlay, rope_shader_multiply;
PShader rope_shader_gaussian_blur ;
PShader rope_shader_resize ;

String shader_folder_path = null;
public void shader_folder_filter(String path) {
  shader_folder_path = path;
}

/**
Gaussian blur
pass x2 vertical and horizontal

*/
public void blur(PImage tex, float intensity) {
  blur(tex, intensity);
}

public void blur(PGraphics p, PImage tex, float intensity) {
  set_blur(intensity) ;
  // temp
  if(temp_gaussian_blur == null) {
    temp_gaussian_blur = createImage(tex.width, tex.height, ARGB);
    tex.loadPixels() ;
    temp_gaussian_blur.pixels = tex.pixels;
    temp_gaussian_blur.updatePixels();
  }
  if(temp_gaussian_blur.width != tex.width || temp_gaussian_blur.height != tex.height) {
    temp_gaussian_blur.resize(tex.width, tex.height);
    tex.loadPixels() ;
    temp_gaussian_blur.pixels = tex.pixels;
    temp_gaussian_blur.updatePixels();
  }

  reset_blur(tex);

  if(rope_shader_gaussian_blur == null) {
    if(shader_folder_path != null) {
      rope_shader_gaussian_blur = loadShader(shader_folder_path+"rope_filter_gaussian_blur.glsl");
    } else {
      rope_shader_gaussian_blur = loadShader("shader/filter/rope_filter_gaussian_blur.glsl");
    }  
  }
  
  if(pass_rope_1 == null) {
    if(p == null) pass_rope_1 = createGraphics(tex.width,tex.height,P2D);
    else pass_rope_1 = createGraphics(p.width,p.height,P2D);
  }
  if(pass_rope_2 == null) {
    if(p == null) pass_rope_2 = createGraphics(tex.width,tex.height,P2D);
    else pass_rope_2 = createGraphics(p.width,p.height,P2D);
  }


  if(p != null) {
    rope_shader_gaussian_blur.set("PGraphics_renderer_is",true);
    float ratio_x = (float)p.width / (float)tex.width ;
    float ratio_y = (float)p.height / (float)tex.height ;
    rope_shader_gaussian_blur.set("wh_renderer_ratio",ratio_x, ratio_y);
  }

  rope_shader_gaussian_blur.set("blurSize", size_gaussian_blur_rope);
  rope_shader_gaussian_blur.set("sigma", sigma_gaussian_blur_rope);


  
  // Applying the blur shader along the vertical direction   
  rope_shader_gaussian_blur.set("horizontalPass", true);
  pass_rope_1.beginDraw();            
  pass_rope_1.shader(rope_shader_gaussian_blur);
  pass_rope_1.image(tex, 0, 0); 
  pass_rope_1.endDraw();

  // Applying the blur shader along the horizontal direction        
  rope_shader_gaussian_blur.set("horizontalPass", false);
   pass_rope_2.beginDraw();            
   pass_rope_2.shader(rope_shader_gaussian_blur);  
   pass_rope_2.image(pass_rope_1, 0, 0);
   pass_rope_2.endDraw(); 

  if(p == null) {
     pass_rope_2.loadPixels() ;
    tex.pixels =  pass_rope_2.pixels ;
    tex.updatePixels() ;
  } else {
     pass_rope_2.loadPixels();
    p.pixels =  pass_rope_2.pixels;
    p.updatePixels();

  }
}

/*
util blur
*/
PGraphics pass_rope_1, pass_rope_2;
PImage temp_gaussian_blur ;
public void reset_blur(PImage tex) {
  if(temp_gaussian_blur != null) {
    temp_gaussian_blur.loadPixels() ;
    tex.pixels = temp_gaussian_blur.pixels;
    tex.updatePixels();
  }
}

int size_gaussian_blur_rope = 7 ;
float sigma_gaussian_blur_rope = 3f ;

public void set_blur(float intensity) {
  size_gaussian_blur_rope = floor(intensity) ;
  sigma_gaussian_blur_rope = intensity *.5f ;
}







  
/**
multiply

*/
/**
* size
*/
/**
void multiply_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_multiply == null) rope_shader_multiply = loadShader("shader/filter/rope_filter_multiply.glsl");
  rope_shader_multiply.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}

void multiply_size(int w, int h) {
  if(rope_shader_multiply == null) rope_shader_multiply = loadShader("shader/filter/rope_filter_multiply.glsl");
  rope_shader_multiply.set("wh_renderer_ratio",1f/w, 1f/h);
}
*/

public void set_multiply_shader() {
  if(rope_shader_multiply == null) {
    if(shader_folder_path != null) {
      rope_shader_multiply = loadShader(shader_folder_path+"rope_filter_multiply.glsl");
    } else {
      rope_shader_multiply = loadShader("shader/filter/rope_filter_multiply.glsl");
    }  
  }
}
/**
* flip 
*/
public void multiply_flip_tex(boolean bx_tex, boolean by_tex) {
  multiply_flip(bx_tex,by_tex,false,false);
}

public void multiply_flip_inc(boolean bx_inc, boolean by_inc) {
  multiply_flip(false,false,bx_inc,by_inc);
}

public void multiply_flip(boolean bx, boolean by) {
  multiply_flip(bx,by,bx,by);
}

public void multiply_flip(boolean bx_tex, boolean by_tex, boolean bx_inc, boolean by_inc) {
  set_multiply_shader();
  rope_shader_multiply.set("flip_tex",bx_tex,by_tex);
  rope_shader_multiply.set("flip_inc",bx_inc,by_inc);
}

/**
* follower method
*/
public void multiply(PImage tex, PImage inc) {
  multiply(tex, inc, 1);
}

public void multiply(PImage tex, PImage inc, vec2 ratio) {
  multiply(tex, inc, ratio.x, ratio.y);
}

public void multiply(PImage tex, PImage inc, vec3 ratio) {
  multiply(tex, inc, ratio.x, ratio.y, ratio.z);
}

public void multiply(PImage tex, PImage inc, vec4 ratio) {
  multiply(tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}

public void multiply(PImage tex, PImage inc, float... ratio) {
  if(ratio.length == 1) {
    multiply(null, tex, inc, ratio[0]);
  } else if(ratio.length == 2) {
    multiply(null, tex, inc, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    multiply(null, tex, inc, ratio[0], ratio[1], ratio[2]);
  } else {
    multiply(null, tex, inc, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}


/**
* with PGraphics work
*/
public void multiply(PGraphics p, PImage tex, PImage inc) {
  multiply(p, tex, inc, 1);
}

public void multiply(PGraphics p, PImage tex, PImage inc, vec2 ratio) {
  multiply(p, tex, inc, ratio.x, ratio.y);
}

public void multiply(PGraphics p, PImage tex, PImage inc, vec3 ratio) {
  multiply(p, tex, inc, ratio.x, ratio.y, ratio.z);
}

public void multiply(PGraphics p, PImage tex, PImage inc, vec4 ratio) {
  multiply(p, tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}
/**
* Master method multiply
* this method have a purpose to blend the four channel color.
* @param Pimage tex, is the image must be back
* @param Pimage inc, is the image must be incrusted on the background picture
* @param float [], vec2, vec3 or vec4 is the normal ratio overlaying
*/
public void multiply(PGraphics p, PImage tex, PImage inc, float... ratio) {
  set_multiply_shader();
  
  vec4 r = array_to_vec4_rgba(ratio);

  rope_shader_multiply.set("incrustation",inc);
  rope_shader_multiply.set("ratio",r.x,r.z,r.w,r.z);

  if(p == null) {
    rope_shader_multiply.set("texture",tex);
    shader(rope_shader_multiply);
    //g.filter(rope_shader_multiply);
  } else {
    rope_shader_multiply.set("texture_PGraphics",tex);
    rope_shader_multiply.set("PGraphics_renderer_is",true);
    p.filter(rope_shader_multiply);
  }
}
/**
overlay

*/
/**
* size
*/
/**
void overlay_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_overlay == null) rope_shader_overlay = loadShader("shader/filter/rope_filter_overlay.glsl");
  rope_shader_overlay.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}
*/
public void set_overlay_shader() {
  if(rope_shader_overlay == null) {
    if(shader_folder_path != null) {
      rope_shader_overlay = loadShader(shader_folder_path+"rope_filter_overlay.glsl");
    } else {
      rope_shader_overlay = loadShader("shader/filter/rope_filter_overlay.glsl");
    }  
  }
}
/**
* flip 
*/
public void overlay_flip_tex(boolean bx_tex, boolean by_tex) {
  overlay_flip(bx_tex,by_tex,false,false);
}

public void overlay_flip_inc(boolean bx_inc, boolean by_inc) {
  overlay_flip(false,false,bx_inc,by_inc);
}

public void overlay_flip(boolean bx, boolean by) {
  overlay_flip(bx,by,bx,by);
}

public void overlay_flip(boolean bx_tex, boolean by_tex, boolean bx_inc, boolean by_inc) {
  set_overlay_shader();
  rope_shader_overlay.set("flip_tex",bx_tex,by_tex);
  rope_shader_overlay.set("flip_inc",bx_inc,by_inc);
}
/**
* follower method
*/
public void overlay(PImage tex, PImage inc) {
  overlay(tex, inc, 1);
}

public void overlay(PImage tex, PImage inc, vec2 ratio) {
  overlay(tex, inc, ratio.x, ratio.y);
}

public void overlay(PImage tex, PImage inc, vec3 ratio) {
  overlay(tex, inc, ratio.x, ratio.y, ratio.z);
}

public void overlay(PImage tex, PImage inc, vec4 ratio) {
  overlay(tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}

public void overlay(PImage tex, PImage inc, float... ratio) {
  if(ratio.length == 1) {
    overlay(null, tex, inc, ratio[0]);
  } else if(ratio.length == 2) {
    overlay(null, tex, inc, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    overlay(null, tex, inc, ratio[0], ratio[1], ratio[2]);
  } else {
    overlay(null, tex, inc, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}


/**
* with PGraphics work
*/
public void overlay(PGraphics p, PImage tex, PImage inc) {
  overlay(p, tex, inc, 1);
}

public void overlay(PGraphics p, PImage tex, PImage inc, vec2 ratio) {
  overlay(p, tex, inc, ratio.x, ratio.y);
}

public void overlay(PGraphics p, PImage tex, PImage inc, vec3 ratio) {
  overlay(p, tex, inc, ratio.x, ratio.y, ratio.z);
}

public void overlay(PGraphics p, PImage tex, PImage inc, vec4 ratio) {
  overlay(p, tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}
/**
* Master method overlay
* this method have a purpose to blend the four channel color.
* @param Pimage tex, is the image must be back
* @param Pimage inc, is the image must be incrusted on the background picture
* @param float [], vec2, vec3 or vec4 is the normal ratio overlaying
*/
public void overlay(PGraphics p, PImage tex, PImage inc, float... ratio) { 
  set_overlay_shader();

  vec4 r = array_to_vec4_rgba(ratio);
  
  rope_shader_overlay.set("incrustation",inc);
  rope_shader_overlay.set("ratio",r.x,r.z,r.w,r.z);
  
  if(p == null) {
    rope_shader_overlay.set("texture",tex);
    shader(rope_shader_overlay);
  } else {
    rope_shader_overlay.set("texture_PGraphics",tex);
    rope_shader_overlay.set("PGraphics_renderer_is",true);
    p.filter(rope_shader_overlay);
  }
}






/**
blend

*/
/**
* size
*/
/**
void blend_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_blend == null) rope_shader_blend = loadShader("shader/filter/rope_filter_blend.glsl");
  rope_shader_blend.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}
*/
public void set_blend_shader() {
  if(rope_shader_blend == null) {
    if(shader_folder_path != null) {
      rope_shader_blend = loadShader(shader_folder_path+"rope_filter_blend.glsl");
    } else {
      rope_shader_blend = loadShader("shader/filter/rope_filter_blend.glsl");
    }  
  }
}
/**
* flip 
*/
public void blend_flip_tex(boolean bx_tex, boolean by_tex) {
  blend_flip(bx_tex,by_tex,false,false);
}

public void blend_flip_inc(boolean bx_inc, boolean by_inc) {
  blend_flip(false,false,bx_inc,by_inc);
}

public void blend_flip(boolean bx, boolean by) {
  blend_flip(bx,by,bx,by);
}

public void blend_flip(boolean bx_tex, boolean by_tex, boolean bx_inc, boolean by_inc) {
  set_blend_shader();
  rope_shader_overlay.set("flip_tex",bx_tex,by_tex);
  rope_shader_overlay.set("flip_inc",bx_inc,by_inc);
}
/**
* follower method
*/
public void blend(PImage tex, PImage inc, float blend, vec2 ratio) {
  blend(null, tex, inc, blend, ratio.x, ratio.y);
}

public void blend(PImage tex, PImage inc, float blend, vec3 ratio) {
  blend(null, tex, inc, blend, ratio.x, ratio.y, ratio.z);
}

public void blend(PImage tex, PImage inc, float blend, vec4 ratio) {
  blend(null, tex, inc, blend, ratio.x, ratio.y, ratio.z, ratio.w);
}

public void blend(PImage tex, PImage inc, float blend, float... ratio) {
  if(ratio.length == 1) {
    blend(null, tex, inc, blend, ratio[0]);
  } else if(ratio.length == 2) {
    blend(null, tex, inc, blend, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    blend(null, tex, inc, blend, ratio[0], ratio[1], ratio[2]);
  } else {
    blend(null, tex, inc, blend, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}


/**
* with PGraphics work
*/
public void blend(PGraphics p, PImage tex, float blend, PImage inc) {
  blend(p, tex, inc, blend, 1);
}

public void blend(PGraphics p, PImage tex, PImage inc, float blend, vec2 ratio) {
  blend(p, tex, inc, blend, ratio.x, ratio.y);
}

public void blend(PGraphics p, PImage tex, PImage inc, float blend, vec3 ratio) {
  blend(p, tex, inc, blend, ratio.x, ratio.y, ratio.z);
}

public void blend(PGraphics p, PImage tex, PImage inc, float blend, vec4 ratio) {
  blend(p, tex, inc, blend, ratio.x, ratio.y, ratio.z, ratio.w);
}




/**
* Master method blend
* this method have a purpose to blend the four channel color.
* @param Pimage tex, is the image must be back
* @param Pimage inc, is the image must be incrusted on the background picture
* @param float [], vec2, vec3 or vec4 is the normal ratio overlaying
*/
public void blend(PGraphics p, PImage tex, PImage inc, float blend, float... ratio) { 
  set_blend_shader();

  vec4 r = array_to_vec4_rgba(ratio);
  
  rope_shader_blend.set("incrustation",inc);
  rope_shader_blend.set("blend", blend);
  rope_shader_blend.set("ratio",r.x,r.z,r.w,r.z);
  
  if(p == null) {
    rope_shader_blend.set("texture",tex);
    shader(rope_shader_blend);
  } else {
    rope_shader_blend.set("texture_PGraphics",tex);
    rope_shader_blend.set("PGraphics_renderer_is",true);
    p.filter(rope_shader_blend);
  }
}

/**
mix

*/
/**
* size
*/
/**
void mix_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_mix == null) rope_shader_mix = loadShader("shader/filter/rope_filter_mix.glsl");
  rope_shader_mix.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}
*/
public void set_mix_shader() {
  if(rope_shader_mix == null) {
    if(shader_folder_path != null) {
      rope_shader_mix = loadShader(shader_folder_path+"rope_filter_mix.glsl");
    } else {
      rope_shader_mix = loadShader("shader/filter/rope_filter_mix.glsl");
    }  
  }
}
/**
* flip 
*/
public void mix_flip_tex(boolean bx_tex, boolean by_tex) {
  mix_flip(bx_tex,by_tex,false,false);
}

public void mix_flip_inc(boolean bx_inc, boolean by_inc) {
  mix_flip(false,false,bx_inc,by_inc);
}

public void mix_flip(boolean bx, boolean by) {
  mix_flip(bx,by,bx,by);
}

public void mix_flip(boolean bx_tex, boolean by_tex, boolean bx_inc, boolean by_inc) {
  set_mix_shader();
  rope_shader_mix.set("flip_tex",bx_tex,by_tex);
  rope_shader_mix.set("flip_inc",bx_inc,by_inc);
}

/**
* without PGraphics work
*/
public void mix(PImage tex, PImage inc) {
  mix(null, tex, inc, 1);
}

public void mix(PImage tex, PImage inc, vec2 ratio) {
  mix(null, tex, inc, ratio.x, ratio.y);
}

public void mix(PImage tex, PImage inc, vec3 ratio) {
  mix(null, tex, inc, ratio.x, ratio.y, ratio.z);
}

public void mix(PImage tex, PImage inc, vec4 ratio) {
  mix(null, tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}

public void mix(PImage tex, PImage inc, float... ratio) {
  if(ratio.length == 1) {
    mix(null, tex, inc, ratio[0]);
  } else if(ratio.length == 2) {
    mix(null, tex, inc, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    mix(null, tex, inc, ratio[0], ratio[1], ratio[2]);
  } else {
    mix(null, tex, inc, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}

/**
* with PGraphics work
*/
public void mix(PGraphics p, PImage tex, PImage inc) {
  mix(p, tex, inc, 1);
}

public void mix(PGraphics p, PImage tex, PImage inc, vec2 ratio) {
  mix(p, tex, inc, ratio.x, ratio.y);
}

public void mix(PGraphics p, PImage tex, PImage inc, vec3 ratio) {
  mix(p, tex, inc, ratio.x, ratio.y, ratio.z);
}

public void mix(PGraphics p, PImage tex, PImage inc, vec4 ratio) {
  mix(p, tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}

/**
* Master method mix
* this method have a purpose to mix the four channel color.
*/
public void mix(PGraphics p, PImage tex, PImage inc, float... ratio) {
  set_mix_shader();

  vec4 r = array_to_vec4_rgba(ratio); 
  
  rope_shader_mix.set("incrustation",inc);
  rope_shader_mix.set("ratio",r.r,r.g,r.b,r.a);

  if(p == null) {
    rope_shader_mix.set("texture",tex);
    shader(rope_shader_mix);
  } else {
    rope_shader_mix.set("texture_PGraphics",tex);
    rope_shader_mix.set("PGraphics_renderer_is",true);
    // Problem with MacBook Pro 2018 Grapichs 560X OSX Mojave
    p.filter(rope_shader_mix);
    /*
    try {
      p.filter(rope_shader_mix);
    } catch(java.lang.RuntimeException ArrayIndexOutBoundsException) { 
      printErrTempo(60,"void mix(PGraphics p, PImage tex, PImage inc, float... ratio): ArrayIndexOutBoundsException",frameCount);
    }
    */
  }
}

/**
level colour

*/
/**
* size
*/
/**
void level_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_level == null) rope_shader_level = loadShader("shader/filter/rope_filter_level.glsl");
  rope_shader_level.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}
*/
/**
* flip 
 */
public void level_flip(boolean bx, boolean by) {
  if(rope_shader_level == null) {
    if(shader_folder_path != null) {
      rope_shader_level = loadShader(shader_folder_path+"rope_filter_level.glsl");
    } else {
      rope_shader_level = loadShader("shader/filter/rope_filter_level.glsl");
    }  
  }  
  rope_shader_level.set("flip",bx,by);
}
/**
* follower method
*/
public void level(PImage tex, vec2 level) {
  level(tex,level.x,level.y);
}

public void level(PImage tex, vec3 level) {
  level(tex,level.x,level.y,level.z);
}

public void level(PImage tex, vec4 level) {
  level(tex,level.r,level.g,level.b,level.a);
}

public void level(PImage tex, float... ratio) {
  if(ratio.length == 1) {
    level(null, tex, ratio[0]);
  } else if(ratio.length == 2) {
    level(null, tex, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    level(null, tex, ratio[0], ratio[1], ratio[2]);
  } else {
    level(null, tex, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}

/**
* with PGraphics work
*/
public void level(PGraphics p, PImage tex, PImage inc) {
  level(p, tex, 1);
}

public void level(PGraphics p, PImage tex, vec2 ratio) {
  level(p, tex, ratio.x, ratio.y);
}

public void level(PGraphics p, PImage tex, vec3 ratio) {
  level(p, tex, ratio.x, ratio.y, ratio.z);
}

public void level(PGraphics p, PImage tex, vec4 ratio) {
  level(p, tex, ratio.x, ratio.y, ratio.z, ratio.w);
}
/**
* Master method level
* this method have a purpose to mix the four channel color.
*/
public void level(PGraphics p, PImage tex, float... ratio) {
  if(rope_shader_level == null) {
    if(shader_folder_path != null) {
      rope_shader_level = loadShader(shader_folder_path+"rope_filter_level.glsl");
    } else {
      rope_shader_level = loadShader("shader/filter/rope_filter_level.glsl");
    }  
  } 

  vec4 r = array_to_vec4_rgba(ratio);
 
  rope_shader_level.set("level",r.r,r.g,r.b,r.a);

  if( p == null ) {
    rope_shader_level.set("texture",tex);
    shader(rope_shader_level);
  } else {
    rope_shader_level.set("texture_PGraphics",tex);
    rope_shader_level.set("PGraphics_renderer_is",true);
    p.filter(rope_shader_level);
  }
}
/**
Rope UTILS 
v 1.56.2
* Copyleft (c) 2014-2019
* Stan le Punk > http://stanlepunk.xyz/
Rope – Romanesco Processing Environment – 
Processing 3.5.3
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/


/**
CHECK SIZE WINDOW
return true if the window size has changed
*/
ivec2 rope_window_size;
public boolean window_change_is() {
  if(rope_window_size == null || !all(equal(ivec2(width,height),rope_window_size))) {
    check_window_size();
    return true;
  } else {
    return false;
  }
}

public void check_window_size() {
  if(rope_window_size == null) {
    rope_window_size = ivec2(width,height);
  } else {
    rope_window_size.set(width,height);
  }
}







/**
print Constants
v 0.0.3
*/
Constant_list processing_constants_list = new Constant_list(PConstants.class);
Constant_list rope_constants_list = new Constant_list(rope.core.RConstants.class);
public void print_constants_rope() {
  if(rope_constants_list == null) {
    rope_constants_list = new Constant_list(rope.core.RConstants.class);
  }
  println("ROPE CONSTANTS");
  for(String s: rope_constants_list.list()){
    println(s);
  }
}

public void print_constants_processing() {
  if(processing_constants_list == null) {
    processing_constants_list = new Constant_list(PConstants.class);
  }
  println("PROCESSING CONSTANTS");
  for(String s: processing_constants_list.list()) {
    println(s);
  }
} 

public void print_constants() {
  if(processing_constants_list == null) {
    processing_constants_list = new Constant_list(PConstants.class);
  }

  if(rope_constants_list == null) {
    rope_constants_list = new Constant_list(rope.core.RConstants.class);
  }

  println("ROPE CONSTANTS");
  for(String s: rope_constants_list.list()){
    println(s);
  }
  println();
  println("PROCESSING CONSTANTS");
  for(String s: processing_constants_list.list()){
    println(s);
  }
} 

/*
* class to list the interface stuff
*/
class Constant_list {
  Field[] classFields; 
  Constant_list(Class c){
    classFields = c.getFields();
  }
  public ArrayList<String> list() {
    ArrayList<String> slist = new ArrayList();
    // for each constant
    for (Field f : classFields) {
      String s = "";
      // object type
      s = s + "(" + f.getType() + ")";
      // field name
      s = s + " " + f.getName();
      // value
      try {
        s = s + ": " + f.get(null);
      } 
      catch (IllegalAccessException e) {
      }
      // Optional special handling for field types:
      if (f.getType().equals(int.class)) {
        // ...
      }
      if (f.getType().equals(float.class)) {
        // ...
      }
      slist.add(s);
    }
    return(slist);
  }
}



















/**
FOLDER & FILE MANAGER
v 0.3.0
*/
/*
INOUT PART
*/
String selected_path_input = null;
boolean input_selected_is;

public void select_input() {
  select_input("");
}

public void select_input(String message) {
  // folder_selected_is = true ;
  selectInput(message, "input_selected");
}

public void input_selected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Input path is:" +selection.getAbsolutePath());
    selected_path_input = selection.getAbsolutePath();
    input_selected_is = true;
  }
}

public boolean input_selected_is() {
  return input_selected_is;
}

public void reset_input_selection() {
  input_selected_is = false;
}

public String input() {
  return selected_path_input;
}


/*
FOLDER PART
*/
String selected_path_folder = null;
boolean folder_selected_is;

public void select_folder() {
  select_folder("");
}

public void select_folder(String message) {
  selectFolder(message, "folder_selected");
}


/**
* this method is called by method select_folder(), and the method name must be the same as named
*/
public void folder_selected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Folder path is:" +selection.getAbsolutePath());
    selected_path_folder = selection.getAbsolutePath();
    folder_selected_is = true;
  }
}


public boolean folder_selected_is() {
  return folder_selected_is;
}

public void reset_folder_selection() {
  folder_selected_is = false;
}

public String folder() {
  return selected_path_folder;
}


// check what's happen in the selected folder
ArrayList <File> files;
int count_selection;

public void set_media_list() {
  if(files == null) files = new ArrayList<File>(); else files.clear();
}



public ArrayList<File> get_files() {
  return files ;
}


public String [] get_files_sort() {
  if(files != null) {
    String [] list = new String [files.size()];
    for(int i = 0 ; i < get_files().size() ; i++) {
      File f = get_files().get(i);
      list[i] = f.getAbsolutePath();
    }
    Arrays.sort(list);
    return list;

  } else return null ;

}

public void explore_folder(String path_folder, String... extension) {
  explore_folder(path_folder, false, extension);

}

public void explore_folder(String path, boolean check_sub_folder, String... extension) {
  if((folder_selected_is || input_selected_is) && path != ("")) {
    count_selection++ ;
    set_media_list();
 
    ArrayList allFiles = list_files(path, check_sub_folder);
  
    String fileName = "";
    int count_pertinent_file = 0 ;
  
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        for(int k = 0 ; k < extension.length ; k++) {
          if (extension(fileName).equals(extension[k])) {
            count_pertinent_file += 1 ;
            println(count_pertinent_file, "/", i, f.getName());
            files.add(f);
          }
        }
      }
    }
    // to don't loop with this void
    folder_selected_is = false ;
    input_selected_is = false ;
  }
}




// Method to get a list of all files in a directory and all subdirectories
public ArrayList list_files(String dir, boolean check_sub_folder) {
  ArrayList fileList = new ArrayList(); 
  if(check_sub_folder) { 
    explore_directory(fileList, dir);
  } else {
    if(folder_selected_is) {
      File file = new File(dir);
      File[] subfiles = file.listFiles();
      for(int i = 0 ; i < subfiles.length ; i++) {
        fileList.add(subfiles[i]);
      }
    } else if(input_selected_is) {
      File file = new File(dir);
      fileList.add(file);
    }
  }
  return fileList;
}

// Recursive function to traverse subdirectories
public void explore_directory(ArrayList list_file, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    list_file.add(file);  // include directories in the list

    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      explore_directory(list_file, subfiles[i].getAbsolutePath());
    }
  } else {
    list_file.add(file);
  }
}





























/**
SAVE LOAD  FRAME Rope
v 0.3.1
*/
/**
Save Frame
V 0.1.2
*/
public void saveFrame(String where, String filename, PImage img) {
  float compression = 1.f ;
  saveFrame(where, filename, compression, img) ;
}

public void saveFrame(String where, String filename) {
  float compression = 1.f ;
  PImage img = null;
  saveFrame(where, filename, compression, img) ;
}

public void saveFrame(String where, String filename, float compression) {
  PImage img = null;
  saveFrame(where, filename, compression, img);
}

public void saveFrame(String where, String filename, float compression, PImage img) {
  // check if the directory or folder exist, if it's not create the path
  File dir = new File(where)  ;
  dir.mkdir() ;
  // final path with file name adding
  String path = where+"/"+filename ;
  try {
    OutputStream os = new FileOutputStream(new File(path));
    loadPixels(); 
    BufferedImage buff_img;
    if(img == null) {
      printErr("method saveFrame(): the PImage is null, no save can be done");
    } else {
      buff_img = new BufferedImage(img.width, img.height, BufferedImage.TYPE_INT_RGB);
      buff_img.setRGB(0, 0, img.width, img.height, img.pixels, 0, img.width);
      if(path.contains(".bmp") || path.contains(".BMP")) {
        saveBMP(os, buff_img);
      } else if(path.contains(".jpeg") || path.contains(".jpg") || path.contains(".JPG") || path.contains(".JPEG")) {
        saveJPG(os, compression, buff_img);
      }
    } 
  }  catch (FileNotFoundException e) {
    //
  }
}

/**
SAVE JPG
v 0.0.1
*/
// classic one
public boolean saveJPG(OutputStream output, float compression,  BufferedImage buff_img) {
  compression = truncate(compression, 1);
  if(compression < 0) compression = 0.0f;
  else if(compression > 1) compression = 1.0f;

  try {
    ImageWriter writer = null;
    ImageWriteParam param = null;
    IIOMetadata metadata = null;

    if ((writer = imageioWriter("jpeg")) != null) {
      param = writer.getDefaultWriteParam();
      param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
      param.setCompressionQuality(compression);

      writer.setOutput(ImageIO.createImageOutputStream(output));
      writer.write(metadata, new IIOImage(buff_img, null, metadata), param);
      writer.dispose();
      output.flush();
      javax.imageio.ImageIO.write(buff_img, "jpg", output);
    }
    return true ;
  }
  catch(IOException e) {
    e.printStackTrace();
  }
  return false ;
}

public ImageWriter imageioWriter(String extension) {
  // code from Processing PImage.java
  Iterator<ImageWriter> iter = ImageIO.getImageWritersByFormatName(extension);
  if (iter.hasNext()) {
    return iter.next();
  }
  return null;
}


/**
SAVE BMP
v 0.3.0.1
*/
// SAVE
public boolean saveBMP(OutputStream output, BufferedImage buff_img) {
  try {
    Graphics g = buff_img.getGraphics();
    g.dispose();
    output.flush();
    
    ImageIO.write(buff_img, "bmp", output);
    return true ;
  }
  catch(IOException e) {
    e.printStackTrace();
  }
  return false ;
}

// LOAD
public PImage loadImageBMP(String fileName) {
  PImage img = null;

  try {
    InputStream is = createInput(fileName);
    BufferedImage buff_img = ImageIO.read(is);
    int[] pix = buff_img.getRGB(0, 0, buff_img.getWidth(), buff_img.getHeight(), null, 0, buff_img.getWidth());
    img = createImage(buff_img.getWidth(),buff_img.getHeight(), RGB);
    // println("Componenent", buff_img.getColorModel().getNumComponents()) ;
    img.pixels = pix;   

    // in case the picture is in grey value...to set the grey because this one is very very bad
    // I don't find any solution to solve it...
    // any idea ?
    if(buff_img.getColorModel().getNumComponents() == 1) {
      float ratio_brightness = .95f;
      for(int i = 0 ; i < img.pixels.length ; i++) {     
        colorMode(HSB);
        float b = brightness(img.pixels[i]) *ratio_brightness ;
        img.pixels[i] = color(0,0,b);
        colorMode(RGB);
      }
    }
  }
  catch(IOException e) {
  }

  if(img != null) {
    return img;
  } else {
    return null ;
  }
}































/**
TRANSLATOR 
v 0.2.0
*/
/**
primitive to byte, byte to primitive
v 0.1.0
*/



public int int_from_byte(Byte b) {
  int result = b.intValue();
  return result;
}

public Boolean boolean_from_bytes(byte... array_byte) {
  if(array_byte.length == 1) {
    if(array_byte[0] == 0) return false ; return true;
  } else {
    Boolean null_data = null;
    return null_data;
  }
}

public Character char_from_bytes(byte [] array_byte) {
  if(array_byte.length == 2) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte);
    char result = buffer.getChar();
    return result;
  } else {
    Character null_data = null;
    return null_data;
  }
}

public Short short_from_bytes(byte [] array_byte) {
  if(array_byte.length == 2) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte);
    short result = buffer.getShort();
    return result;
  } else {
    Short null_data = null;
    return null_data;
  }
}

public Integer int_from_bytes(byte [] array_byte) {
  if(array_byte.length == 4) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte) ;
    int result = buffer.getInt();
    return result;
  } else {
    Integer null_data = null;
    return null_data;
  }
}

public Long long_from_bytes(byte [] array_byte) {
  if(array_byte.length == 8) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte) ;
    long result = buffer.getLong();
    return result;
  } else {
    Long null_data = null;
    return null_data;
  }
}

public Float float_from_bytes(byte [] array_byte) {
  if(array_byte.length == 4) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte) ;
    float result = buffer.getFloat();
    return result;
  } else {
    Float null_data = null;
    return null_data;
  }
}

public Double double_from_bytes(byte [] array_byte) {
  if(array_byte.length == 8) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte) ;
    double result = buffer.getDouble();
    return result;
  } else {
    Double null_data = null;
    return null_data;
  }
}



// @Deprecated // this method return a short because it's reordering by LITTLE_ENDIAN to used by getShort()
public Integer int_from_4_bytes(byte [] array_byte, boolean little_endian) {
  if(array_byte.length == 4) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte);
    if(little_endian)buffer.order(ByteOrder.LITTLE_ENDIAN);
    int result = buffer.getShort();
    return result;
  } else {
    Integer null_data = null;
    return null_data;
  }
}



// return byte
public byte[] to_byte(Object obj) {
  if(obj instanceof Boolean) {
    boolean value = (boolean)obj;
    byte [] array = new byte[1];
    array[0] = (byte)(value?1:0);
    return array;
  } else if(obj instanceof Character) {
    char value = (char)obj;
    return ByteBuffer.allocate(2).putChar(value).array();
  } else if(obj instanceof Short) {
    short value = (short)obj;
    return ByteBuffer.allocate(2).putShort(value).array();
  } else if(obj instanceof Integer) {
    int value = (int)obj;
    return ByteBuffer.allocate(4).putInt(value).array();
  } else if(obj instanceof Long) {
    long value = (long)obj;
    return ByteBuffer.allocate(8).putLong(value).array();
  } else if(obj instanceof Float) {
    float value = (float)obj;
    return ByteBuffer.allocate(4).putFloat(value).array();
  } else if(obj instanceof Double) {
    double value = (double)obj;
    return ByteBuffer.allocate(8).putDouble(value).array();
  } else return null;
}



/**
* from ivec, vec to PVector
*/
public PVector to_PVector(Object obj) {
  if(obj instanceof vec || obj instanceof ivec) {
    if(obj instanceof vec) {
      vec v = (vec)obj;
      return new PVector(v.x,v.y,v.z);
    } else {
      ivec iv = (ivec)obj;
      return new PVector(iv.x,iv.y,iv.z);
    }
  } else {
    printErr("method to_Pvectro(): wait for Object of type vec or ivec");
    return null;
  }
}


/**
truncate a float argument
v 0.0.2
*/
public float truncate(float x) {
    return round(x *100.0f) /100.0f;
}

public float truncate(float x, int num) {
  float result = 0.0f ;
  switch(num) {
    case 0:
      result = round(x *1.0f) /1.0f;
      break;
    case 1:
      result = round(x *10.0f) /10.0f;
      break;
    case 2:
      result = round(x *100.0f) /100.0f;
      break;
    case 3:
      result = round(x *1000.0f) /1000.0f;
      break;
    case 4:
      result = round(x *10000.0f) /10000.0f;
      break;
    case 5:
      result = round(x *100000.0f) /100000.0f;
      break;
    default:
      result = x;
      break;
  }
  return result;
}

/**
Int to String
Float to String
v 0.0.3
*/
/*
@ return String
*/
public String join_int_to_String(int []data) {
  String intString ;
  String [] dataString = new String [data.length] ;
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = Integer.toString(data[i]) ;
  intString = join(dataString,"/") ;
  
  return intString ;
}

//float to String with array list
public String join_float_to_String(float []data) {
  String floatString ;
  String [] dataString = new String [data.length] ;
  //for ( int i = 0 ; i < data.length ; i++) dataString[i] = Float.toString(data[i]) ;
  //we must use just one decimal after coma, to dodge the outBoundIndex blablabla
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = String.format("%.1f" ,data[i]) ;
  floatString = join(dataString,"/") ;
  
  return floatString ;
}

//Translater to String
// float to String
public String float_to_String_1(float data) {
  String float_string_value ;
  float_string_value = String.format("%.1f", data ) ;
  return float_String(float_string_value) ;
}
//
public String float_to_String_2(float data) {
  String float_string_value ;
  float_string_value = String.format("%.2f", data ) ;
  return float_String(float_string_value) ;
}
//
public String float_to_String_3(float data) {
  String float_string_value ;
  float_string_value = String.format("%.3f", data ) ;
  return float_String(float_string_value) ;
}

//
public String float_to_String_4(float data) {
  String float_string_value ;
  float_string_value = String.format("%.4f", data ) ;
  return float_String(float_string_value) ;
}
// local
public String float_String(String value) {
  if(value.contains(".")) {
    return value ;
  } else {
    String [] temp = split(value, ",") ;
    value = temp[0] +"." + temp[1] ;
    return value ;
  }
}


// int to String
public String int_to_String(int data) {
  String float_string_value ;
  float_string_value = Integer.toString(data ) ;
  return float_string_value ;
}



/**
array float to vec
*/
public vec4 array_to_vec4_rgba(float... f) {
  vec4 v = vec4(1);
  if(f.length == 1) {
    v.set(f[0],f[0],f[0],1.f);
  } else if(f.length == 2) {
    v.set(f[0],f[0],f[0],f[1]);
  } else if(f.length == 3) {
    v.set(f[0],f[1],f[2],1);
  } else if(f.length > 3) {
    v.set(f[0],f[1],f[2],f[3]);
  }
  return v;
}


































/**
EXPORT FILE PDF_PNG 0.1.1
*/
String ranking_shot = "_######" ;
// PDF

boolean record_PDF;
public void start_PDF() {
  start_PDF(null,null) ;
}

public void start_PDF(String name_file) {
  start_PDF(null, name_file) ;
}
public void start_PDF(String path_folder, String name_file) {
  if(path_folder == null) path_folder = "pdf_folder";
  if(name_file == null) name_file = "pdf_file_"+ranking_shot;

  if (record_PDF && !record_PNG) {
    if(renderer_P3D()) {
      beginRaw(PDF, path_folder+"/"+name_file+".pdf"); 
    } else {
      beginRecord(PDF, path_folder+"/"+name_file+".pdf");
    }
  }
}

public void save_PDF() {
  if (record_PDF && !record_PNG) {
    if(renderer_P3D()) {
      endRaw(); 
    } else {
      endRecord() ;
    }
    println("PDF");
    record_PDF = false;
  }
}

public void event_PDF() {
  record_PDF = true;
}




// PNG
boolean record_PNG ;
boolean naming_PNG ;
String path_folder_png, name_file_png  ;
public void start_PNG(String path_folder, String name_file) {
  path_folder_png = path_folder ;
  name_file_png = name_file ;
  naming_PNG = true ;
}

public void save_PNG() {
  if(record_PNG) {
    if(!naming_PNG) {
      saveFrame("png_folder/shot_" + ranking_shot + ".png");
    } else {
      saveFrame(path_folder_png + "/" + name_file_png + ".png");
    }
    record_PNG = false ;
  }
}

public void event_PNG() {
  record_PNG = true;
}


























































/**
print
v 0.2.0
*/
// print Err
public void printErr(Object... obj) {
  System.err.println(write_message(obj));
}

// print tempo
public void printErrTempo(int tempo, Object... obj) {
  if(frameCount%tempo == 0 || frameCount <= 1) {
    String message = write_message(obj);
    System.err.println(message);
  }
}

public void printTempo(int tempo, Object... obj) {
  if(frameCount%tempo == 0 || frameCount <= 1) {
    String message = write_message(obj);
    println(message);
  }
}




public void printArrayTempo(int tempo, Object[] obj) {
  if(frameCount%tempo == 0 || frameCount <= 1) {
    printArray(obj);
  }
}

public void printArrayTempo(int tempo, float[] var) {
  if(frameCount%tempo == 0 || frameCount <= 10) {
    printArray(var);
  }
}

public void printArrayTempo(int tempo, int[] var) {
  if(frameCount%tempo == 0 || frameCount <= 10) {
    printArray(var);
  }
}

public void printArrayTempo(int tempo, String[] var) {
  if(frameCount%tempo == 0 || frameCount <= 10) {
    printArray(var);
  }
}











/**
MAP
map the value between the min and the max
@ return float
*/
public float map_cycle(float value, float min, float max) {
  max += .000001f ;
  float newValue ;
  if(min < 0 && max >= 0 ) {
    float tempMax = max +abs(min) ;
    value += abs(min) ;
    float tempMin = 0 ;
    newValue =  tempMin +abs(value)%(tempMax - tempMin)  ;
    newValue -= abs(min) ;
    return newValue ;
  } else if ( min < 0 && max < 0) {
    newValue = abs(value)%(abs(max)+min) -max ;
    return newValue ;
  } else {
    newValue = min + abs(value)%(max - min) ;
    return newValue ;
  }
}




/*
map the value between the min and the max, but this value is lock between the min and the max
@ return float
*/
public float map_locked(float value, float sourceMin, float sourceMax, float targetMin, float targetMax) {
  if(sourceMax >= targetMax ) sourceMax = targetMax ;
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  float result = targetMin +deltaTarget *ratio;
  return result; 
}


// to map not linear, start the curve hardly to start slowly
public float map_begin(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = pow(ratio, level) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}

// to map not linear, start the curve hardly to finish slowly
public float map_end(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = pow(ratio, 1.0f/level) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}

public float map(float value, float start_1, float stop_1, float start_2, float stop_2, int begin, int end) {
  begin = abs(begin);
  end = abs(end);
  if(begin != 0 && end != 0) {
    if (value < start_1 ) value = start_1;
    if (value > stop_2 ) value = stop_2;

    float new_max = stop_2 - start_1;
    float delta = stop_2 - start_2;
    float ratio = (value - start_1) / new_max;

    ratio = map(ratio,0,1,-1,1);
    if (ratio < 0) {
      if(begin < 2) ratio = pow(ratio,begin) ;
      else ratio = pow(ratio,begin) *(-1);
      if(ratio > 0) ratio *= -1;
    } else {
      ratio = pow(ratio,end);
    }
    
    ratio = map(ratio,-1,1,0,1);
    float result = start_2 +delta *ratio;
    return result;
  } else if(begin == 0 && end != 0) {
    return map_end(value,start_1,stop_1,start_2,stop_2,end);
  } else if(end == 0 && begin != 0) {
    return map_begin(value,start_1,stop_1,start_2,stop_2,begin);
  } else {
    return map(value,start_1,stop_1,start_2,stop_2,1,1);
  }

}











/**
MISC
v 0.0.6
*/
/**
stop trhead draw by using loop and noLoop()
*/
boolean freeze_is ;
public void freeze() {
  freeze_is = (freeze_is)? false:true ;
  if (freeze_is)  {
    noLoop();
  } else {
    loop();
  }
}








/**
PIXEL UTILS
v 0.0.3
*/
public int [][] loadPixels_array_2D() {
  int [][] array_pix;
  loadPixels();
  array_pix = new int[height][width] ;
  int which_pix = 0;
  if(pixels != null) {
    for(int y = 0 ; y < height ; y++) {
      for(int x = 0 ; x < width ; x++) {
        which_pix = y *width +x ;
        array_pix[y][x] = pixels[which_pix] ;
      }
    }
  }
  if(array_pix != null) {
    return array_pix ;
  } else {
    return null ;
  }
}

































/**
CHECK
v 0.2.4
*/
/**
Check Type
v 0.0.4
*/
public String get_type(Object obj) {
  if(obj instanceof Integer) {
    return "Integer";
  } else if(obj instanceof Float) {
    return "Float";
  } else if(obj instanceof String) {
    return "String";
  } else if(obj instanceof Double) {
    return "Double";
  } else if(obj instanceof Long) {
    return "Long";
  } else if(obj instanceof Short) {
    return "Short";
  } else if(obj instanceof Boolean) {
    return "Boolean";
  } else if(obj instanceof Byte) {
    return "Byte";
  } else if(obj instanceof Character) {
    return "Character";
  } else if(obj instanceof PVector) {
    return "PVector";
  } else if(obj instanceof vec) {
    return "vec";
  } else if(obj instanceof ivec) {
    return "ivec";
  } else if(obj instanceof bvec) {
    return "bvec";
  } else if(obj == null) {
    return "null";
  } else return "Unknow" ;
}




























/**
check value in range
*/
public boolean in_range(float min, float max, float value) {
  if(value <= max && value >= min) {
    return true ; 
  } else {
    return false ;
  }
}

public boolean in_range_wheel(float min, float max, float roof_max, float value) {
  if(value <= max && value >= min) {
    return true ;
  } else {
    // wheel value
    if(max > roof_max ) {
      // test hight value
      if(value <= (max - roof_max)) {
        return true ;
      } 
    } 
    if (min < 0) {
      // here it's + min 
      if(value >= (roof_max + min)) {
        return true ;
      } 
    } 
    return false ;
  }
}














































/**
STRING UTILS
v 0.3.3
*/
public String write_message(Object... obj) {
  String mark = " ";
  return write_message_sep(mark,obj);
}
public String write_message_sep(String mark, Object... obj) {
  String m = "";
  for(int i = 0 ; i < obj.length ; i++) {
    m += write_message(obj[i], obj.length,i,mark);
  }
  return m;
}

// local method
public String write_message(Object obj, int length, int i, String mark) {
  String message = "";
  String add = "";
  if(i == length -1) { 
    if(obj == null) {
      add = "null";
    } else {
      add = obj.toString();
    }
    return message += add;
  } else {
    if(obj == null) {
      add = "null";
    } else {
      add = obj.toString();
    }
    return message += add + mark;
  }
}



//STRING SPLIT
public String [] split_text(String str, String separator) {
  String [] text = str.split(separator) ;
  return text  ;
}


//STRING COMPARE LIST SORT
//raw compare
public int longest_String(String[] string_list) {
  int finish = 0;
  if(string_list != null) finish = string_list.length;
  return longest_String(string_list, 0, finish);
}

//with starting and end keypoint in the String must be sort
public int longest_String(String[] string_list, int start, int finish) {
  int length = 0;
  if(string_list != null) {
    for ( int i = start ; i < finish ; i++) {
      if (string_list[i].length() > length ) length = string_list[i].length() ;
    }
  }
  return length;
}

/**
Longuest String with PFont
*/
public int longest_String_pixel(PFont font, String[] string_list) {
  int [] size_font = new int[1];
  size_font[0] = font.getSize();
  int finish = 0;
  if(string_list != null) finish = string_list.length;
  return longest_String_pixel(font.getName(), string_list, size_font, 0, finish);
}

public int longest_String_pixel(PFont font, String[] string_list, int... size_font) {
  int finish = 0;
  if(string_list != null) finish = string_list.length;
  return longest_String_pixel(font.getName(), string_list, size_font, 0, finish);
}

public int longest_String_pixel(PFont font, String[] string_list, int [] size_font, int start, int finish) {
  return longest_String_pixel(font.getName(), string_list, size_font, start, finish);
}

/**
Longuest String with String name Font
*/
public int longest_String_pixel(String font_name, String[] string_list, int... size_font) {
  int finish = 0;
  if(string_list != null) finish = string_list.length;
  return longest_String_pixel(font_name, string_list, size_font, 0, finish);
}

// diferrent size by line
public int longest_String_pixel(String font_name, String[] string_list, int size_font, int start, int finish) {
  int [] s_font = new int[1];
  s_font[0] = size_font;
  return longest_String_pixel(font_name, string_list, s_font, start, finish);
}

public int longest_String_pixel(String font_name, String[] string_list, int [] size_font, int start, int finish) {
  int width_pix = 0 ;
  if(string_list != null) {
    int target_size_font = 0;
    for (int i = start ; i < finish && i < string_list.length; i++) {
      if(i >= size_font.length) target_size_font = 0 ;
      if (width_String(font_name, string_list[i], size_font[target_size_font]) > width_pix) {
        width_pix = width_String(string_list[i],size_font[target_size_font]);
      }
      target_size_font++;
    }
  }
  return width_pix;
}




/**
width String
*/
public int width_String(String target, int size) {
  return width_String("defaultFont", target, size) ;
}

public int width_String(PFont pfont, String target, int size) {
  return width_String(pfont.getName(), target, size);
}

public int width_String(String font_name, String target, int size) {
  Font font = new Font(font_name, Font.BOLD, size) ;
  BufferedImage img = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
  FontMetrics fm = img.getGraphics().getFontMetrics(font);
  if(target == null) {
    target = "";
  }
  return fm.stringWidth(target);
}




public int width_char(char target, int size) {
  return width_char("defaultFont", target, size) ;
}

public int width_char(PFont pfont, char target, int size) {
  return width_char(pfont.getName(), target, size);
}
public int width_char(String font_name, char target, int size) {
  Font font = new Font(font_name, Font.BOLD, size) ;
  BufferedImage img = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
  FontMetrics fm = img.getGraphics().getFontMetrics(font);
  return fm.charWidth(target);
}




// Research a specific word in String
public boolean research_in_String(String research, String target) {
  boolean result = false ;
  for(int i = 0 ; i < target.length() - research.length() +1; i++) {
    result = target.regionMatches(i,research,0,research.length()) ;
    if (result) break ;
  }
  return result ;
}





/**
String file utils
2014-2018
v 0.2.0
*/
/**
* remove element of the sketch path
*/
public String sketchPath(int minus) {
  minus = abs(minus);
  String [] element = split(sketchPath(),"/");
  String new_path ="" ;
  if(minus < element.length ) {
    for(int i = 0 ; i < element.length -minus ; i++) {
      new_path +="/";
      new_path +=element[i];
    }
    return new_path; 
  } else {
    printErr("The number of path elements is lower that elements must be remove, instead a data folder is used");
    return sketchPath()+"/data";
  }  
}



// remove the path of your file
public String file_name(String s) {
  String file_name = "" ;
  String [] split_path = s.split("/") ;
  file_name = split_path[split_path.length -1] ;
  return file_name ;
}

/**
* work around extension
*/
public String extension(String filename) {
  if(filename != null) {
    if(filename.contains(".")) {
      return filename.substring(filename.lastIndexOf(".") + 1, filename.length());
    } else {
      return null;
    } 
  } else {
    return null;
  }
}

public boolean extension_is(String... data) {
  boolean is = false;
  if(data.length >= 2) {
    String extension_to_compare = extension(data[0]);
    if(extension_to_compare != null) {
      for(int i = 1 ; i < data.length ; i++) {
        if(extension_to_compare.equals(data[i])) {
          is = true;
          break;
        } else {
          is = false;
        }
      }
    } else {
      printErr("method extension_is(): [",data[0],"] this path don't have any extension");
    }
  } else {
    printErr("method extension_is() need almost two components, the first is the path and the next is extension");
  }
  return is;
}














































/**
TABLE METHOD 
v 0.0.3.1
for Table with the first COLLUMN is used for name and the next 6 for the value.
The method is used with the Class Info

*/
// table method for row sort
public void buildTable(Table table, TableRow [] tableRow, String [] col_name, String [] row_name) {
  // add col
  for(int i = 0 ; i < col_name.length ; i++) {
    table.addColumn(col_name[i]);
  }
  // add row
  tableRow = new TableRow[row_name.length] ;
  buildRow(table, row_name) ;
}

public void buildTable(Table table, String [] col_name) {
  // add col
  for(int i = 0 ; i < col_name.length ; i++) {
    table.addColumn(col_name[i]);
  }
}

public void buildRow(Table table, String [] row_name) {
  int num_row = table.getRowCount() ;
  for(int i = 0 ; i < num_row ; i++) {
    TableRow row = table.getRow(i) ;
    row.setString(table.getColumnTitle(0), row_name[i]) ; 
  }
}

public void setTable(Table table, TableRow [] rows, Info_Object... info) {
  for(int i = 0 ; i < rows.length ; i++) {
    if(rows[i] != null) {
      for(int j = 0 ; j < info.length ; j++) {
        if(info[j] != null && info[j].get_name().equals(rows[i].getString(table.getColumnTitle(0)))) {
          for(int k = 1 ; k < 7 ; k++) {
            if(table.getColumnCount() > k && info[j].catch_obj(k-1) != null)  write_row(rows[i], table.getColumnTitle(k), info[j].catch_obj(k-1)) ;
          }
        }
        
      }
    }
  }
}


public void setRow(Table table, Info_Object info) {
  TableRow result = table.findRow(info.get_name(), table.getColumnTitle(0)) ;
  if(result != null) {
    for(int k = 1 ; k < 7 ; k++) {
      if(table.getColumnCount() > k && info.catch_obj(k-1) != null)  write_row(result, table.getColumnTitle(k), info.catch_obj(k-1)) ;
    }
  }
}

public void write_row(TableRow row, String col_name, Object o) {
  if(o instanceof String) {
    String s = (String) o ;
    row.setString(col_name, s);
  } else if(o instanceof Short) {
    short sh = (Short) o ;
    row.setInt(col_name, sh);
  } else if(o instanceof Integer) {
    int in = (Integer) o ;
    row.setInt(col_name, in);
  } else if(o instanceof Float) {
    float f = (Float) o ;
    row.setFloat(col_name, f);
  } else if(o instanceof Character) {
    char c = (Character) o ;
    String s = Character.toString(c) ;
    row.setString(col_name, s);
  } else if(o instanceof Boolean) {
    boolean b = (Boolean) o ;
    String s = Boolean.toString(b) ;
    row.setString(col_name, s);
  } 
}
/**
Info_dict 
v 0.3.0.1
*/
public class Info_dict {
  ArrayList<Info> list;
  char type_list = 'o';

  Info_dict(char type_list) {
    this.type_list = type_list;
  }

  Info_dict() {
    list = new ArrayList<Info>();
  }

  // add Object
  public void add(String name, Object a) {
    Info_Object info = new Info_Object(name,a);
    list.add(info);
  }
  public void add(String name, Object a, Object b) {
    Info_Object info = new Info_Object(name,a,b);
    list.add(info);
  }
  public void add(String name, Object a, Object b, Object c) {
    Info_Object info = new Info_Object(name,a,b,c);
    list.add(info);
  }
  public void add(String name, Object a, Object b, Object c, Object d) {
    Info_Object info = new Info_Object(name,a,b,c,d);
    list.add(info);
  }
  public void add(String name, Object a, Object b, Object c, Object d, Object e) {
    Info_Object info = new Info_Object(name,a,b,c,d,e);
    list.add(info);
  }
  public void add(String name, Object a, Object b, Object c, Object d, Object e, Object f) {
    Info_Object info = new Info_Object(name,a,b,c,d,e,f);
    list.add(info);
  }
  public void add(String name, Object a, Object b, Object c, Object d, Object e, Object f, Object g) {
    Info_Object info = new Info_Object(name,a,b,c,d,e,f,g);
    list.add(info);
  }

   // size
   public int size() {
    return list.size();
   }

  // read
  public void read() {
    println("Object list");
    for(Info a : list) {
      if(a instanceof Info_Object) {
        Info_Object obj = (Info_Object)a ;
        if(obj.a != null && obj.b == null && obj.c == null && obj.d == null && obj.e == null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a));   
        }
        if(obj.a != null && obj.b != null && obj.c == null && obj.d == null && obj.e == null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d == null && obj.e == null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d != null && obj.e == null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c),get_type(obj.d));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d != null && obj.e != null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c),get_type(obj.d),get_type(obj.e));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d != null && obj.e != null && obj.f != null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c),get_type(obj.d),get_type(obj.e),get_type(obj.f));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d != null && obj.e != null && obj.f != null && obj.g != null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c),get_type(obj.d),get_type(obj.e),get_type(obj.f),get_type(obj.g));   
        }      
      }
    }
  }

  // get
  public Info get(int target) {
    if(target < list.size() && target >= 0) {
      return list.get(target);
    } else return null;
  }
  
  public Info [] get(String which) {
    Info [] info;
    int count = 0;
    for(Info a : list) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info[count] ;
      count = 0;
      for(Info a : list) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++;
        }
      }
    } else {
      info = new Info_String[1];
      info[0] = null;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info;
  }

  // clear
  public void clear() {
    list.clear();
  }

  // remove
  public void remove(String which) {
    for(int i = 0 ; i < list.size() ; i++) {
      Info a = list.get(i);
      if(a.get_name().equals(which)) {
        list.remove(i);
      }
    }
  }
  
  public void remove(int target) {
   if(target < list.size()) {
      list.remove(target);
    }
  }
}

/**
Info_int_dict
v 0.0.2
*/

public class Info_int_dict extends Info_dict {
  ArrayList<Info_int> list_int;
  Info_int_dict() {
    super('i');
    list_int = new ArrayList<Info_int>();
  }


  // add int
  public void add(String name, int a) {
    Info_int info = new Info_int(name,a);
    list_int.add(info);
  } 
  public void add(String name, int a, int b) {
    Info_int info = new Info_int(name,a,b);
    list_int.add(info);
  } 

  public void add(String name, int a, int b, int c) {
    Info_int info = new Info_int(name,a,b,c);
    list_int.add(info);
  } 
  public void add(String name, int a, int b, int c, int d) {
    Info_int info = new Info_int(name, a,b,c,d);
    list_int.add(info);
  } 
  public void add(String name, int a, int b, int c, int d, int e) {
    Info_int info = new Info_int(name,a,b,c,d,e);
    list_int.add(info);
  } 
  public void add(String name, int a, int b, int c, int d, int e, int f) {
    Info_int info = new Info_int(name,a,b,c,d,e,f);
    list_int.add(info);
  }
  public void add(String name, int a, int b, int c, int d, int e, int f, int g) {
    Info_int info = new Info_int(name,a,b,c,d,e,f,g);
    list_int.add(info);
  }


  // size
  public int size() {
    return list_int.size() ;
  }

  // read
  public void read() {
    println("Integer list");
    for(Info a : list_int) {
      println(a,"Integer");
    }
  }
  

  // get
  public Info_int get(int target) {
    if(target < list_int.size() && target >= 0) {
      return list_int.get(target);
    } else return null;
  }
  
  public Info_int [] get(String which) {
    Info_int [] info  ;
    int count = 0;
    for(Info_int a : list_int) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info_int[count] ;
      count = 0 ;
      for(Info_int a : list_int) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++;
        }
      }
    } else {
      info = new Info_int[1] ;
      info[0] = null;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }

  // clear
  public void clear() {
    list_int.clear();
  }

  // remove
  public void remove(String which) {
    for(int i = 0 ; i < list_int.size() ; i++) {
      Info_int a = list_int.get(i) ;
      if(a.get_name().equals(which)) {
        list_int.remove(i);
      }
    }
  }
  
  public void remove(int target) {
   if(target < list_int.size()) {
      list_int.remove(target);
    }
  }
}

/**
Info_float_dict
v 0.0.2
*/
public class Info_float_dict extends Info_dict {
  ArrayList<Info_float> list_float ;
  Info_float_dict() {
    super('f');
    list_float = new ArrayList<Info_float>();
  }

  // add float
  public void add(String name, float a) {
    Info_float info = new Info_float(name,a);
    list_float.add(info);
  }
  public void add(String name, float a, float b) {
    Info_float info = new Info_float(name,a,b);
    list_float.add(info);
  }
  public void add(String name, float a, float b, float c) {
    Info_float info = new Info_float(name,a,b,c);
    list_float.add(info);
  }
  public void add(String name, float a, float b, float c, float d) {
    Info_float info = new Info_float(name,a,b,c,d);
    list_float.add(info);
  }
  public void add(String name, float a, float b, float c, float d, float e) {
    Info_float info = new Info_float(name,a,b,c,d,e);
    list_float.add(info);
  }
  public void add(String name, float a, float b, float c, float d, float e, float f) {
    Info_float info = new Info_float(name,a,b,c,d,e,f);
    list_float.add(info);
  }
  public void add(String name, float a, float b, float c, float d, float e, float f, float g) {
    Info_float info = new Info_float(name,a,b,c,d,e,f,g);
    list_float.add(info);
  }

  // size
  public int size() {
    return list_float.size() ;
  }

  //read
  public void read() {
    println("Float list");
    for(Info a : list_float) {
      println(a,"Float");
    }
  }
   

  // get
  public Info_float get(int target) {
    if(target < list_float.size() && target >= 0) {
      return list_float.get(target);
    } else return null;
  }
  
  public Info_float [] get(String which) {
    Info_float [] info;
    int count = 0;
    for(Info_float a : list_float) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info_float[count] ;
      count = 0 ;
      for(Info_float a : list_float) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++;
        }
      }
    } else {
      info = new Info_float[1] ;
      info[0] = null;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }

  // clear
  public void clear() {
    list_float.clear();
  }

  // remove
  public void remove(String which) {
    for(int i = 0 ; i < list_float.size() ; i++) {
      Info a = list_float.get(i) ;
      if(a.get_name().equals(which)) {
        list_float.remove(i);
      }
    }
  }
  
  public void remove(int target) {
   if(target < list_float.size()) {
      list_float.remove(target);
    }
  }
}



/**
Info_String_dict

*/
public class Info_String_dict extends Info_dict {
  ArrayList<Info_String> list_String ;
  Info_String_dict() {
    super('s');
    list_String = new ArrayList<Info_String>();
  }

  // add String
  public void add(String name, String a) {
    Info_String info = new Info_String(name,a);
    list_String.add(info);
  }
  public void add(String name, String a, String b) {
    Info_String info = new Info_String(name,a,b); 
    list_String.add(info);
  }
  public void add(String name, String a, String b, String c) {
    Info_String info = new Info_String(name,a,b,c);
    list_String.add(info);
  }
  public void add(String name, String a, String b, String c, String d) {
    Info_String info = new Info_String(name,a,b,c,d);
    list_String.add(info);
  }
  public void add(String name, String a, String b, String c, String d, String e) {
    Info_String info = new Info_String(name,a,b,c,d,e);
    list_String.add(info);
  }
  public void add(String name, String a, String b, String c, String d, String e, String f) {
    Info_String info = new Info_String(name,a,b,c,d,e,f);
    list_String.add(info);
  }
  public void add(String name, String a, String b, String c, String d, String e, String f,String g) {
    Info_String info = new Info_String(name,a,b,c,d,e,f,g);
    list_String.add(info);
  }

  // size
  public int size() {
    return list_String.size() ;
  }

  //read
  public void read() {
    println("String list");
    for(Info a : list_String) {
      println(a,"String");
    }
  }
  

  // get
  public Info_String get(int target) {
    if(target < list_String.size() && target >= 0) {
      return list_String.get(target);
    } else return null;
  }
  
  public Info_String [] get(String which) {
    Info_String [] info  ;
    int count = 0 ;
    for(Info_String a : list_String) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info_String[count] ;
      count = 0;
      for(Info_String a : list_String) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++;
        }
      }
    } else {
      info = new Info_String[1];
      info[0] = null;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info;
  }

  // clear
  public void clear() {
    list_String.clear();
  }

  // remove
  public void remove(String which) {
    for(int i = 0 ; i < list_String.size() ; i++) {
      Info_String a = list_String.get(i);
      if(a.get_name().equals(which)) {
        list_String.remove(i);
      }
    }
  }
  
  public void remove(int target) {
   if(target < list_String.size()) {
      list_String.remove(target);
    }
  }
}


/**
Info_vec_dict
*/
public class Info_vec_dict extends Info_dict {
  ArrayList<Info_vec> list_vec ;
  Info_vec_dict() {
    super('v') ;
    list_vec = new ArrayList<Info_vec>() ;
  }

  // add vec
  public void add(String name, vec a) {
    Info_vec info = new Info_vec(name,a);
    list_vec.add(info);
  }
  public void add(String name, vec a, vec b) {
    Info_vec info = new Info_vec(name,a,b);
    list_vec.add(info);
  }
  public void add(String name, vec a, vec b, vec c) {
    Info_vec info = new Info_vec(name,a,b,c);
    list_vec.add(info);
  }
  public void add(String name, vec a, vec b, vec c, vec d) {
    Info_vec info = new Info_vec(name,a,b,c,d);
    list_vec.add(info);
  }
  public void add(String name, vec a, vec b, vec c, vec d, vec e) {
    Info_vec info = new Info_vec(name,a,b,c,d,e);
    list_vec.add(info);
  }
  public void add(String name, vec a, vec b, vec c, vec d, vec e, vec f) {
    Info_vec info = new Info_vec(name,a,b,c,d,e,f);
    list_vec.add(info);
  }
  public void add(String name, vec a, vec b, vec c, vec d, vec e, vec f, vec g) {
    Info_vec info = new Info_vec(name,a,b,c,d,e,f,g);
    list_vec.add(info);
  }

  // size
  public int size() {
    return list_vec.size();
  }

  //read
  public void read() {
    println("vec list");
    for(Info a : list_vec) {
      println(a,"vec");
    }
  }
  

  // get
  public Info_vec get(int target) {
    if(target < list_vec.size() && target >= 0) {
      return list_vec.get(target);
    } else return null;
  }
  
  public Info_vec [] get(String which) {
    Info_vec [] info;
    int count = 0 ;
    for(Info_vec a : list_vec) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info_vec[count];
      count = 0 ;
      for(Info_vec a : list_vec) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++ ;
        }
      }
    } else {
      info = new Info_vec[1];
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info;
  }

  // clear
  public void clear() {
    list_vec.clear();
  }

  // remove
  public void remove(String which) {
    for(int i = 0 ; i < list_vec.size() ; i++) {
      Info_vec a = list_vec.get(i) ;
      if(a.get_name().equals(which)) {
        list_vec.remove(i);
      }
    }
  }
  
  public void remove(int target) {
   if(target < list_vec.size()) {
      list_vec.remove(target);
    }
  }
}



/**
Info 0.1.0.2

*/
interface Info {
  public String get_name();

  public Object [] catch_all() ;
  public Object catch_obj(int arg);

  public char get_type();
}
 
abstract class Info_method implements Info {
  String name  ;
  // error message
  String error_target = "Your target is beyond of my knowledge !" ;
  String error_value_message = "This value is beyond of my power mate !" ;
  Info_method (String name) {
    this.name = name ;
  }


  public String get_name() { 
    return name ;
  }
}


/**
INFO int

*/
class Info_int extends Info_method {
  char type = 'i' ;
  int a, b, c, d, e, f, g ;
  int num_value ;  


  Info_int(String name) {
    super(name) ;
  }

  Info_int(String name, int... var) {
    super(name) ;
    if(var.length > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = var.length ;
    }
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
    if(var.length > 6) this.g = var[6] ;
  }


  // get
  public int [] get() {
    int [] list = new int[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  public int get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return 0 ;
    } 
  }
  
  public Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  public Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return null ;
    } 
  }
  
  public char get_type() { return type ; }

  // Print info
  public @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g +" ]";
    } else {
      System.err.println(num_value) ;
      System.err.println(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO String
*/
class Info_String extends Info_method {
  char type = 's' ;
  String a, b, c, d, e, f, g ;
  int num_value ;  

  Info_String(String name) {
    super(name) ;
  }

  Info_String(String name, String... var) {
    super(name) ;
    if(var.length > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = var.length ;
    }
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
    if(var.length > 6) this.g = var[6] ;
  }


  // get
  public String [] get() {
    String [] list = new String[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  public String get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    }else {
      System.err.println(error_target) ;
      return null ;
    }
  }
  
  public Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  public Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    }else {
      System.err.println(error_target) ;
      return null ;
    }
  }

  public char get_type() { return type ; }


  // Print info
  public @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g + " ]";
    } else {
      System.err.println(num_value) ;
      System.err.println(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO float
*/
class Info_float extends Info_method {
  char type = 'f' ;
  float a, b, c, d, e, f, g ;
  int num_value ; 

  Info_float(String name) {
    super(name) ;
  }

  Info_float(String name, float... var) {
    super(name) ;
    if(var.length > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = var.length ;
    }
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
    if(var.length > 6) this.g = var[6] ;
  }

  // get
  public float [] get() {
    float [] list = new float[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  public float get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return 0.0f ;
    }
  }
  
  public Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  public Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return null ;
    }
  }

  public char get_type() { return type ; }
  
  // Print info
  public @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g + " ]";
    } else {
      System.err.println(num_value) ;
      System.err.println(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO vec
v 0.0.2
*/
class Info_vec extends Info_method {
  char type = 'v' ;
  vec a, b, c, d, e, f, g ;
  int num_value ;  

  Info_vec(String name) {
    super(name) ;
  }

  // vec value
  Info_vec(String name, vec... var) {
    super(name) ;
    if(var.length > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = var.length ;
    }
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
    if(var.length > 6) this.g = var[6] ;
  }




  // get
  public vec [] get() {
    vec [] list = new vec[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  public vec get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    }else {
      System.err.println(error_target) ;
      return null;
    }
  }
  
  public Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  public Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return null ;
    }
  }

  public char get_type() { return type; }

  // Print info
  public @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g + " ]";
    } else {
      System.err.println(num_value) ;
      System.err.println(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}




/**
INFO OBJECT
v 0.0.2
*/
class Info_Object extends Info_method {
  char type = 'o' ;
  Object a, b, c, d, e, f, g ;
  int num_value ;

  Info_Object(String name) {
    super(name) ;
  }


  // Object value
  Info_Object(String name, Object... var) {
    super(name) ;
    if(var.length > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = var.length ;
    }
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
    if(var.length > 6) this.g = var[6] ;
  }


  // get
  public Object [] get() {
    Object [] list = new Object []{a,b,c,d,e,f,g} ;
    return list ;
  }

  public Object get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    } else {
      printErr(error_target) ;
      return null ;
    }
  }
  
  public Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  public Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    } else {
      printErr(error_target) ;
      return null ;
    }
  }
  
  public char get_type() { return type ; }


  // Print info
  public @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g + " ]";
    } else {
      printErr(num_value) ;
      printErr(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}
/**
END INFO LIST
*/


/**
Vec, iVec and bVec rope method
v 0.3.0
* Copyleft (c) 2018-2019
* Stan le Punk > http://stanlepunk.xyz/
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/




/**
Addition
v 0.0.4
*/
/**
* return the resultat of vector addition
*/
public ivec2 iadd(ivec2 a, ivec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x + b.x ;
    int y = a.y + b.y ;
    return new ivec2(x,y) ;
  }
}

public ivec3 iadd(ivec3 a, ivec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x + b.x ;
    int y = a.y + b.y ;
    int z = a.z + b.z ;
    return new ivec3(x,y,z)  ;
  }
}

public ivec4 iadd(ivec4 a, ivec4 b) {  
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x + b.x ;
    int y = a.y + b.y ;
    int z = a.z + b.z ;
    int w = a.w + b.w ;
    return new ivec4(x,y,z,w)  ;
  }
}

public ivec2 iadd(ivec2 a, int arg) {
  return iadd(a,ivec2(arg,arg));
}

public ivec3 iadd(ivec3 a, int arg) {
  return iadd(a,ivec3(arg,arg,arg));
}

public ivec4 iadd(ivec4 a, int arg) {  
  return iadd(a,ivec4(arg,arg,arg,arg));
}




/**
Multiplication
v 0.0.1
*/
/**
* return the resultat of vector multiplication
*/
public ivec2 imult(ivec2 a, ivec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x * b.x;
    int y = a.y * b.y;
    return new ivec2(x,y);
  }
}

public ivec3 imult(ivec3 a, ivec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x * b.x;
    int y = a.y * b.y;
    int z = a.z * b.z;
    return new ivec3(x,y,z);
  }
}

public ivec4 imult(ivec4 a, ivec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x * b.x;
    int y = a.y * b.y;
    int z = a.z * b.z;
    int w = a.w * b.w;
    return new ivec4(x,y,z,w);
  }
}

public ivec2 imult(ivec2 a, int arg) {
  return imult(a,ivec2(arg,arg));
}

public ivec3 imult(ivec3 a, int arg) {
  return imult(a,ivec3(arg,arg,arg));
}

public ivec4 imult(ivec4 a, int arg) {  
  return imult(a,ivec4(arg,arg,arg,arg));
}


/**
Division
v 0.0.3
*/
/**
* return the resultat of vector division
*/
public ivec2 idiv(ivec2 a, ivec2 b) {
  if(a == null || b == null) {
    return null;
  } else {
    int x = a.x / b.x;
    int y = a.y / b.y;
    return new ivec2(x,y);
  }
}

public ivec3 idiv(ivec3 a, ivec3 b) {
  if(a == null || b == null) {
    return null;
  } else {
    int x = a.x / b.x;
    int y = a.y / b.y;
    int z = a.z / b.z;
    return new ivec3(x,y,z);
  }
}

public ivec4 idiv(ivec4 a, ivec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x / b.x;
    int y = a.y / b.y;
    int z = a.z / b.z;
    int w = a.w / b.w;
    return new ivec4(x,y,z,w);
  }
}

public ivec2 idiv(ivec2 a, int arg) {
  return idiv(a,ivec2(arg,arg));
}

public ivec3 idiv(ivec3 a, int arg) {
  return idiv(a,ivec3(arg,arg,arg));
}

public ivec4 idiv(ivec4 a, int arg) {  
  return idiv(a,ivec4(arg,arg,arg,arg));
}



/**
Substraction
v 0.0.1
*/
/**
* return the resultat of vector substraction
*/
public ivec2 isub(ivec2 a, ivec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x - b.x;
    int y = a.y - b.y;
    return new ivec2(x,y);
  }
}

public ivec3 isub(ivec3 a, ivec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x - b.x;
    int y = a.y - b.y;
    int z = a.z - b.z;
    return new ivec3(x,y,z);
  }
}

public ivec4 isub(ivec4 a, ivec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    int x = a.x - b.x;
    int y = a.y - b.y;
    int z = a.z - b.z;
    int w = a.w - b.w;
    return new ivec4(x,y,z,w);
  }
}

public ivec2 isub(ivec2 a, int arg) {
  return isub(a,ivec2(arg,arg));
}

public ivec3 isub(ivec3 a, int arg) {
  return isub(a,ivec3(arg,arg,arg));
}

public ivec4 isub(ivec4 a, int arg) {  
  return isub(a,ivec4(arg,arg,arg,arg));
}




































/**
METHOD
Vec
v 1.0.0
*/
/**
Addition
v 0.0.4
*/
/**
* return the resultat of vector addition
*/
public vec2 add(vec2 a, vec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x + b.x ;
    float y = a.y + b.y ;
    return new vec2(x,y) ;
  }
}

public vec3 add(vec3 a, vec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x + b.x ;
    float y = a.y + b.y ;
    float z = a.z + b.z ;
    return new vec3(x,y,z)  ;
  }
}

public vec4 add(vec4 a, vec4 b) {  
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x + b.x ;
    float y = a.y + b.y ;
    float z = a.z + b.z ;
    float w = a.w + b.w ;
    return new vec4(x,y,z,w)  ;
  }
}
/**
* iVec arg
*/
public vec2 add(ivec2 a, ivec2 b) {
  return add(vec2(a),vec2(b));
}

public vec3 add(ivec3 a, ivec3 b) {
  return add(vec3(a),vec3(b));
}

public vec4 add(ivec4 a, ivec4 b) {  
  return add(vec4(a),vec4(b));
}
/**
* float arg
*/
public vec2 add(vec2 a, float arg) {
  return add(a,vec2(arg,arg));
}

public vec3 add(vec3 a, float arg) {
  return add(a,vec3(arg,arg,arg));
}

public vec4 add(vec4 a, float arg) {  
  return add(a,vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/

public vec2 add(ivec2 a, float arg) {
  return add(vec2(a),vec2(arg,arg));
}

public vec3 add(ivec3 a, float arg) {
  return add(vec3(a),vec3(arg,arg,arg));
}

public vec4 add(ivec4 a, float arg) {  
  return add(vec4(a),vec4(arg,arg,arg,arg));
}




/**
Multiplication
v 0.0.4
*/
/**
* return the resultat of vector multiplication
*/
public vec2 mult(vec2 a, vec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x * b.x;
    float y = a.y * b.y;
    return new vec2(x,y);
  }
}

public vec3 mult(vec3 a, vec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x * b.x;
    float y = a.y * b.y;
    float z = a.z * b.z;
    return new vec3(x,y,z);
  }
}

public vec4 mult(vec4 a, vec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x * b.x;
    float y = a.y * b.y;
    float z = a.z * b.z;
    float w = a.w * b.w;
    return new vec4(x,y,z,w);
  }
}
/**
* iVec arg
*/
public vec2 mult(ivec2 a, ivec2 b) {
  return mult(vec2(a),vec2(b));
}

public vec3 mult(ivec3 a, ivec3 b) {
  return mult(vec3(a),vec3(b));
}

public vec4 mult(ivec4 a, ivec4 b) {  
  return mult(vec4(a),vec4(b));
}

/**
* float arg
*/
public vec2 mult(vec2 a, float arg) {
  return mult(a,vec2(arg,arg));
}

public vec3 mult(vec3 a, float arg) {
  return mult(a,vec3(arg,arg,arg));
}

public vec4 mult(vec4 a, float arg) {  
  return mult(a,vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/
public vec2 mult(ivec2 a, float arg) {
  return mult(vec2(a),vec2(arg,arg));
}

public vec3 mult(ivec3 a, float arg) {
  return mult(vec3(a),vec3(arg,arg,arg));
}

public vec4 mult(ivec4 a, float arg) {  
  return mult(vec4(a),vec4(arg,arg,arg,arg));
}




/**
Division
v 0.0.4
*/
/**
* return the resultat of vector division
*/
public vec2 div(vec2 a, vec2 b) {
  if(a == null || b == null) {
    return null;
  } else {
    float x = a.x /b.x;
    float y = a.y /b.y;
    return new vec2(x,y);
  }
}

public vec3 div(vec3 a, vec3 b) {
  if(a == null || b == null) {
    return null;
  } else {
    float x = a.x /b.x;
    float y = a.y /b.y;
    float z = a.z /b.z;
    return new vec3(x,y,z);
  }
}

public vec4 div(vec4 a, vec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x /b.x;
    float y = a.y /b.y;
    float z = a.z /b.z;
    float w = a.w /b.w;
    return new vec4(x,y,z,w);
  }
}
/**
* iVec arg
*/
public vec2 div(ivec2 a, ivec2 b) {
  return div(vec2(a),vec2(b));
}

public vec3 div(ivec3 a, ivec3 b) {
  return div(vec3(a),vec3(b));
}

public vec4 div(ivec4 a, ivec4 b) {  
  return div(vec4(a),vec4(b));
}
/**
* float arg
*/
public vec2 div(vec2 a, float arg) {
  return div(a,vec2(arg,arg));
}

public vec3 div(vec3 a, float arg) {
  return div(a,vec3(arg,arg,arg));
}

public vec4 div(vec4 a, float arg) {  
  return div(a,vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/
public vec2 div(ivec2 a, float arg) {
  return div(vec2(a),vec2(arg,arg));
}

public vec3 div(ivec3 a, float arg) {
  return div(vec3(a),vec3(arg,arg,arg));
}

public vec4 div(ivec4 a, float arg) {  
  return div(vec4(a),vec4(arg,arg,arg,arg));
}


/**
Substraction
v 0.0.5
*/
/**
* return the resultat of vector substraction
*/
public vec2 sub(vec2 a, vec2 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x - b.x;
    float y = a.y - b.y;
    return new vec2(x,y);
  }
}

public vec3 sub(vec3 a, vec3 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x - b.x;
    float y = a.y - b.y;
    float z = a.z - b.z;
    return new vec3(x,y,z);
  }
}

public vec4 sub(vec4 a, vec4 b) {
  if(a == null || b == null) {
    return null ;
  } else {
    float x = a.x - b.x;
    float y = a.y - b.y;
    float z = a.z - b.z;
    float w = a.w - b.w;
    return new vec4(x,y,z,w);
  }
}
/**
* iVec arg
*/
public vec2 sub(ivec2 a, ivec2 b) {
  return sub(vec2(a),vec2(b));
}

public vec3 sub(ivec3 a, ivec3 b) {
  return sub(vec3(a),vec3(b));
}

public vec4 sub(ivec4 a, ivec4 b) {  
  return sub(vec4(a),vec4(b));
}
/**
* float arg
*/
public vec2 sub(vec2 a, float arg) {
  return sub(a,vec2(arg,arg));
}

public vec3 sub(vec3 a, float arg) {
  return sub(a,vec3(arg,arg,arg));
}

public vec4 sub(vec4 a, float arg) {  
  return sub(a,vec4(arg,arg,arg,arg));
}
/**
* iVec + float
*/
public vec2 sub(ivec2 a, float arg) {
  return sub(vec2(a),vec2(arg,arg));
}

public vec3 sub(ivec3 a, float arg) {
  return sub(vec3(a),vec3(arg,arg,arg));
}

public vec4 sub(ivec4 a, float arg) {  
  return sub(vec4(a),vec4(arg,arg,arg,arg));
}



/**
Cross
v 0.0.2
*/
public vec3 cross(vec3 v1, vec3 v2) {
  if(v1 == null ||  v2 == null) {
    return null;
  } else {
    float crossX = v1.y * v2.z - v2.y * v1.z;
    float crossY = v1.z * v2.x - v2.z * v1.x;
    float crossZ = v1.x * v2.y - v2.x * v1.y;
    return vec3(crossX, crossY, crossZ);
  }
}
/**
* @deprecated "cross(vec3 v1, vec3 v2, vec3 target), can be deprecated in the future, need to be test"
*/
public @Deprecated
vec3 cross(vec3 v1, vec3 v2, vec3 target) {
  println("cross(vec3 v1, vec3 v2, vec3 target), can be deprecated in the future, need to be test");
  if(v1 == null ||  v2 == null || target == null) {
    return null ;
  } else {
    float crossX = v1.y * v2.z - v2.y * v1.z;
    float crossY = v1.z * v2.x - v2.z * v1.x;
    float crossZ = v1.x * v2.y - v2.x * v1.y;

    if (target == null) {
      target = vec3(crossX, crossY, crossZ);
    } else {
      target.set(crossX, crossY, crossZ);
    }
    return target ;
  }  
}



/**
Equals
v 0.0.2
*/
/*
@Deprecated // use compare()
boolean equals(vec2 v_a, vec2 v_b) {
  return compare(v_a,v_b);
}

@Deprecated // use compare()
boolean equals(vec3 v_a, vec3 v_b) {
  return compare(v_a,v_b);
}

@Deprecated // use compare()
boolean equals(vec4 v_a, vec4 v_b) {
  return compare(v_a,v_b);
}

@Deprecated // use compare()
boolean equals(vec2 v_a, vec2 v_b, vec2 area) {
  return compare(v_a,v_b, area);
}

@Deprecated // use compare()
boolean equals(vec3 v_a, vec3 v_b, vec3 area) {
   return compare(v_a,v_b, area);
}

@Deprecated // use compare()
boolean equals(vec4 v_a, vec4 v_b, vec4 area) {
  return compare(v_a,v_b, area);
}
*/



/** 
* compare if the first vector is in the area of the second vector, 
* the area of the second vector is define by a Vec area, 
* that give the possibility of different size for each component
* @return boolean
* v 0.2.0
*/

public boolean compare(ivec2 a, ivec2 b) {
  return compare(vec2(a),vec2(b));
}

public boolean compare(ivec3 a, ivec3 b) {
  return compare(vec3(a),vec3(b));
}

public boolean compare(ivec4 a, ivec4 b) {
  return compare(vec4(a),vec4(b));
}


public boolean compare(vec2 a, vec2 b) {
  if(a == null || b == null) {
    println("Is not possible to compare", a, "to", b) ;
    return false ;
  } else {
    return compare(vec4(a.x,a.y,0,0),vec4(b.x,b.y,0,0)) ;
  }
}

// vec3 compare
public boolean compare(vec3 a, vec3 b) {
    if(a == null || b == null) {
    println("Is not possible to compare", a, "to", b) ;
    return false ;
  } else {
    return compare(vec4(a.x,a.y,a.z, 0),vec4(b.x,b.y,b.z, 0)) ;
  }
}
// vec4 compare
public boolean compare(vec4 a, vec4 b) {
  if(a != null && b != null ) {
    if((a.x == b.x) && (a.y == b.y) && (a.z == b.z) && (a.w == b.w)) {
      return true ; 
    } else {
      return false ;
    }
  } else {
    return false ;
  } 
}


/**
* compare with area
*/
public boolean compare(ivec2 a, ivec2 b, ivec2 area) {
  return compare(vec2(a),vec2(b),vec2(area));
}

public boolean compare(ivec3 a, ivec3 b, ivec3 area) {
  return compare(vec3(a),vec3(b),vec3(area));
}

public boolean compare(ivec4 a, ivec4 b, ivec4 area) {
  return compare(vec4(a),vec4(b),vec4(area));
}

public boolean compare(vec2 a, vec2 b, vec2 area) {
  if(a == null || b == null || area == null) {
    println("Is not possible to compare", a, "with", b, "with", area) ;
    return false ;
  } else {
    return compare(vec4(a.x,a.y, 0, 0),vec4(b.x,b.y, 0, 0),vec4(area.x, area.y, 0, 0)) ;
  }
}

public boolean compare(vec3 a, vec3 b, vec3 area) {
    if(a == null || b == null || area == null) {
    println("Is not possible to compare", a, "with", b, "with", area) ;
    return false ;
  } else {
    return compare(vec4(a.x,a.y,a.z, 0),vec4(b.x,b.y,b.z, 0),vec4(area.x, area.y, area.z, 0)) ;
  }
}

public boolean compare(vec4 a, vec4 b, vec4 area) {
  if(a != null && b != null && area != null ) {
    if(    (a.x >= b.x -area.x && a.x <= b.x +area.x) 
        && (a.y >= b.y -area.y && a.y <= b.y +area.y) 
        && (a.z >= b.z -area.z && a.z <= b.z +area.z) 
        && (a.w >= b.w -area.w && a.w <= b.w +area.w)) {
            return true ; 
    } else {
      return false ;
    }
  } else {
    return false ;
  }
}









/**
Map
*/
/**
* return mapping vector
* @return Vec
*/
public vec2 map(vec2 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    return new vec2(x,y) ;
  } else return null ;
}


public vec3 map(vec3 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
    return new vec3(x,y,z) ;
  } else return null ;
}


public vec4 map(vec4 v,float minIn, float maxIn, float minOut, float maxOut) {
  if(v != null) {
    float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
    float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
    float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
    float w = map(v.w, minIn, maxIn, minOut, maxOut) ;
    return new vec4(x,y,z,w) ;
  } else return null ;
}


/**
Magnitude or length
*/
/**
* @return float
*/
// mag vec2
public float mag(vec2 a) {
  float x = a.x*a.x ;
  float y = a.y *a.y ;
  return sqrt(x+y) ;
}

public float mag(vec2 a, vec2 b) {
  // same result than dist
  float x = (b.x -a.x)*(b.x -a.x) ;
  float y = (b.y -a.y)*(b.y -a.y) ;
  return sqrt(x+y) ;
}
// mag vec3
public float mag(vec3 a) {
  float x = a.x*a.x ;
  float y = a.y *a.y ;
  float z = a.z *a.z ;
  return sqrt(x+y+z) ;
}

public float mag(vec3 a, vec3 b) {
  // same result than dist
  float x = (b.x -a.x)*(b.x -a.x) ;
  float y = (b.y -a.y)*(b.y -a.y) ;
  float z = (b.z -a.z)*(b.z -a.z) ;
  return sqrt(x+y+z) ;
}
// mag vec4
public float mag(vec4 a) {
  float x = a.x*a.x ;
  float y = a.y*a.y ;
  float z = a.z*a.z ;
  float w = a.w*a.w ;
  return sqrt(x+y+z+w) ;
}

public float mag(vec4 a, vec4 b) {
  // same result than dist
  float x = (b.x -a.x)*(b.x -a.x) ;
  float y = (b.y -a.y)*(b.y -a.y) ;
  float z = (b.z -a.z)*(b.z -a.z) ;
  float w = (b.w -a.w)*(b.w -a.w) ;
  return sqrt(x+y+z+w) ;
}



/**
Distance
v 0.0.2
*/
/**
* return the distance beatwen two vectors
* @return float
*/
public float dist(vec2 a, vec2 b) {
  if(a != null && b != null) {
    float dx = a.x - b.x;
    float dy = a.y - b.y;
    return (float) Math.sqrt(dx*dx + dy*dy);
  } else return Float.NaN ;
    
}
public float dist(vec3 a, vec3 b) {
  if(a != null && b != null) {
    float dx = a.x - b.x;
    float dy = a.y - b.y;
    float dz = a.z - b.z;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
  } else return Float.NaN ;
}

public float dist(vec4 a, vec4 b) {
  if(a != null && b != null) {
    float dx = a.x - b.x;
    float dy = a.y - b.y;
    float dz = a.z - b.z;
    float dw = a.w - b.w;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
  } else return Float.NaN ;
}


/**
Deprecated Middle
*/
/**
* return the middle between two Vector
* @return Vec
*/
public vec2 middle(vec2 a, vec2 b)  {
  vec2 middle ;
  middle = add(a,b);
  middle.div(2) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

public vec2 middle(vec2 [] list)  {
  vec2 middle = vec2() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

public vec3 middle(vec3 a, vec3 b) {
  vec3 middle ;
  middle = add(a,b);
  middle.div(2) ;
  return middle ;
}

public vec3 middle(vec3 [] list)  {
  vec3 middle = vec3() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

public vec4 middle(vec4 a, vec4 b)  {
  vec4 middle ;
  middle = add(a,b);
  middle.div(2) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}

public vec4 middle(vec4 [] list)  {
  vec4 middle = vec4() ;
  for (int i = 0 ; i < list.length ; i++) {
    middle.add(list[i]);
  }
  middle.div(list.length) ;
  println("The method middle is deprecated instead use barycenter(Vec... arg)") ;
  return middle ;
}


/**
barycenter
*/
public vec2 barycenter(vec2... v) {
  int div_num = v.length ;
  vec2 sum = vec2() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}

 
public vec3 barycenter(vec3... v) {
  int div_num = v.length ;
  vec3 sum = vec3() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}

public vec4 barycenter(vec4... v) {
  int div_num = v.length ;
  vec4 sum = vec4() ;
  for(int i = 0 ; i < div_num ; i++) {
    sum.add(v[i]) ;
  }
  return sum.div(div_num) ;
}





/**
Jitter
v 0.0.2
*/
// vec2
public vec2 jitter_2D(int range) {
  return jitter_2D(range, range) ;
}
public vec2 jitter_2D(vec2 range) {
  return jitter_2D((int)range.x, (int)range.y) ;
}
public vec2 jitter_2D(int range_x, int range_y) {
  vec2 jitter = vec2() ;
  jitter.x = random_next_gaussian(range_x, 2);
  jitter.y = random_next_gaussian(range_y, 2);
  return jitter ;
}
// vec3
public vec3 jitter_3D(int range) {
  return jitter_3D(range, range, range) ;
}
public vec3 jitter_3D(vec3 range) {
  return jitter_3D((int)range.x, (int)range.y, (int)range.z) ;
}
public vec3 jitter_3D(int range_x, int range_y, int range_z) {
  vec3 jitter = vec3() ;
  jitter.x = random_next_gaussian(range_x, 2);
  jitter.y = random_next_gaussian(range_y, 2);
  jitter.z = random_next_gaussian(range_z, 2);
  return jitter ;
}
// vec4
public vec4 jitter_4D(int range) {
  return jitter_4D(range, range, range, range) ;
}
public vec4 jitter_4D(vec4 range) {
  return jitter_4D((int)range.x, (int)range.y, (int)range.z, (int)range.w) ;
}
public vec4 jitter_4D(int range_x, int range_y, int range_z, int range_w) {
  vec4 jitter = vec4() ;
  jitter.x = random_next_gaussian(range_x, 2);
  jitter.y = random_next_gaussian(range_y, 2);
  jitter.z = random_next_gaussian(range_z, 2);
  jitter.w = random_next_gaussian(range_w, 2);
  return jitter ;
}
// END JITTER
/////////////


/**
Normalize
*/
// VEC 2 from angle
///////////////////
public vec2 norm_rad(float angle) {
  float x = (float)Math.cos(angle) ;
  float y = (float)Math.sin(angle) ;
  return vec2(x,y) ;
}

public vec2 norm_deg(float angle) {
  angle = radians(angle) ;
  float x = (float)Math.cos(angle) ;
  float y = (float)Math.sin(angle) ;
  return vec2(x,y) ;
}


// normalize direction
public vec2 norm_dir(String type, float direction) {
  float x, y = 0 ;
  if(type.equals("DEG")) {
    float angle = TWO_PI/360.f;
    direction = 360-direction;
    direction += 180;
    x = sin(angle *direction) ;
    y = cos(angle *direction);
  } else if (type.equals("RAD")) {
    x = sin(direction) ;
    y = cos(direction);
  } else {
    println("the type must be 'RAD' for radians or 'DEG' for degrees") ;
    x = 0 ;
    y = 0 ;
  }
  return new vec2(x,y) ;
}




/**
translate int color to vec4 color
*/
public vec4 color_hsba(int c) {
  return vec4(hue(c), saturation(c), brightness(c), alpha(c)) ;
}

public vec4 color_rgba(int c) {
  return vec4(red(c), green(c), blue(c), alpha(c)) ;
}

public vec3 color_hsb(int c) {
  return vec3(hue(c), saturation(c), brightness(c)) ;
}

public vec3 color_rgb(int c) {
  return vec3(red(c), green(c), blue(c)) ;
}
































/**
New Vec, iVec and bVec
v 0.0.2
*/

/**
Return a new bVec
*/
/**
* @return bVec
*/
/**
bvec2
*/
public bvec2 bvec2() {
  return new bvec2(false,false) ;
}

public bvec2 bvec2(boolean b) {
  return new bvec2(b,b);
}

public bvec2 bvec2(boolean x, boolean y) { 
  return new bvec2(x,y) ;
}

public bvec2 bvec2(boolean [] array) {
  if(array.length == 1) {
    return new bvec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new bvec2(array[0],array[1]);
  } else {
    return null;
  }
}

public bvec2 bvec2(bvec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bvec2(false,false) ;
  } else if(b instanceof bvec5 || b instanceof bvec6) {
    return new bvec2(b.a,b.b) ;
  } else {
    return new bvec2(b.x,b.y) ;
  }
}

/**
ivec3
*/
public bvec3 bvec3() {
  return new bvec3(false,false,false) ;
}

public bvec3 bvec3(boolean b) {
  return new bvec3(b,b,b);
}

public bvec3 bvec3(boolean x, boolean y, boolean z) { 
  return new bvec3(x,y,z) ;
}

public bvec3 bvec3(boolean [] array) {
  if(array.length == 1) {
    return new bvec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bvec3(array[0],array[1],false);
  } else if (array.length > 2) {
    return new bvec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

public bvec3 bvec3(bvec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bvec3(false,false,false) ;
  } else if(b instanceof bvec5 || b instanceof bvec6) {
    return new bvec3(b.a,b.b,b.c) ;
  } else {
    return new bvec3(b.x,b.y,b.z) ;
  }
}

/**
ivec4
*/
public bvec4 bvec4() {
  return new bvec4(false,false,false,false) ;
}

public bvec4 bvec4(boolean b) {
  return new bvec4(b,b,b,b);
}

public bvec4 bvec4(boolean x, boolean y, boolean z, boolean w) { 
  return new bvec4(x,y,z,w) ;
}

public bvec4 bvec4(boolean [] array) {
  if(array.length == 1) {
    return new bvec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bvec4(array[0],array[1],false,false);
  } else if (array.length == 3) {
    return new bvec4(array[0],array[1],array[2],false);
  } else if (array.length > 3) {
    return new bvec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

public bvec4 bvec4(bvec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bvec4(false,false,false,false) ;
  } else if(b instanceof bvec5 || b instanceof bvec6) {
    return new bvec4(b.a,b.b,b.c,b.d) ;
  } else {
    return new bvec4(b.x,b.y,b.z,b.w) ;
  }
}

/**
ivec5
*/
public bvec5 bvec5() {
  return new bvec5(false,false,false,false,false) ;
}

public bvec5 bvec5(boolean b) {
  return new bvec5(b,b,b,b,b);
}

public bvec5 bvec5(boolean a, boolean b, boolean c, boolean d, boolean e) { 
  return new bvec5(a,b,c,d,e) ;
}

public bvec5 bvec5(boolean [] array) {
  if(array.length == 1) {
    return new bvec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bvec5(array[0],array[1],false,false,false);
  } else if (array.length == 3) {
    return new bvec5(array[0],array[1],array[2],false,false);
  } else if (array.length == 4) {
    return new bvec5(array[0],array[1],array[2],array[3],false);
  } else if (array.length >4) {
    return new bvec5(array[0],array[1],array[2],array[3],array[4]);
  } else {
    return null;
  }
}

public bvec5 bvec5(bvec b) {
  if(b == null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bvec5(false,false,false,false,false) ;
  } else if(b instanceof bvec5 || b instanceof bvec6) {
    return new bvec5(b.a,b.b,b.c,b.d,b.e) ;
  } else {
    return new bvec5(b.x,b.y,b.z,b.w,false) ;
  }
}

/**
bvec6
*/
public bvec6 bvec6() {
  return new bvec6(false,false,false,false,false,false) ;
}

public bvec6 bvec6(boolean b) {
  return new bvec6(b,b,b,b,b,b);
}

public bvec6 bvec6(boolean a, boolean b, boolean c, boolean d, boolean e, boolean f) { 
  return new bvec6(a,b,c,d,e,f) ;
}

public bvec6 bvec6(boolean [] array) {
  if(array.length == 1) {
    return new bvec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new bvec6(array[0],array[1],false,false,false,false);
  } else if (array.length == 3) {
    return new bvec6(array[0],array[1],array[2],false,false,false);
  } else if (array.length == 4) {
    return new bvec6(array[0],array[1],array[2],array[3],false,false);
  } else if (array.length == 5) {
    return new bvec6(array[0],array[1],array[2],array[3],array[4],false);
  }  else if (array.length > 5) {
    return new bvec6(array[0],array[1],array[2],array[3],array[4],array[5]);
  } else {
    return null;
  }
}

public bvec6 bvec6(bvec b) {
  if(b== null) {
    println("bVec null, instead 'false' is used to build bVec") ;
    return new bvec6(false,false,false,false,false,false) ;
  } else if(b instanceof bvec5 || b instanceof bvec6) {
    return new bvec6(b.a,b.b,b.c,b.d,b.e,b.f) ;
  } else {
    return new bvec6(b.x,b.y,b.z,b.w,false,false) ;
  }
}

























/**
Return a new iVec
*/
/**
ivec2
*/
public ivec2 ivec2() {
  return ivec2(0) ;
}

public ivec2 ivec2(int v) {
  return new ivec2(v,v);
}

public ivec2 ivec2(int x, int y) { 
  return new ivec2(x,y) ;
}


public ivec2 ivec2(int [] array) {
  if(array.length == 1) {
    return new ivec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new ivec2(array[0],array[1]);
  } else {
    return null;
  }
}

public ivec2 ivec2(ivec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new ivec2(0,0) ;
  } else if(p instanceof ivec5 || p instanceof ivec6) {
    return new ivec2(p.a,p.b) ;
  } else {
    return new ivec2(p.x,p.y) ;
  }
}

public ivec2 ivec2(float v) {
  return new ivec2(PApplet.parseInt(v),PApplet.parseInt(v));
}

public ivec2 ivec2(float x, float y) { 
  return new ivec2(PApplet.parseInt(x),PApplet.parseInt(y));
}

public ivec2 ivec2(float [] array) {
  if(array.length == 1) {
    return new ivec2(PApplet.parseInt(array[0]),PApplet.parseInt(array[0]));
  } else if (array.length > 1) {
    return new ivec2(PApplet.parseInt(array[0]),PApplet.parseInt(array[1]));
  } else {
    return null;
  }
}

public ivec2 ivec2(vec p) {
  if(p == null) {
    println("Vec null, instead '0' is used to build iVec") ;
    return new ivec2(0,0) ;
  } else if(p instanceof vec5 || p instanceof vec6) {
    return new ivec2(PApplet.parseInt(p.a),PApplet.parseInt(p.b));
  } else {
    return new ivec2(PApplet.parseInt(p.x),PApplet.parseInt(p.y));
  }
}


public ivec2 ivec2(PGraphics media) {
  if(media != null) {
    return new ivec2(media.width,media.height);
  } else {
    return null;
  }
}

public ivec2 ivec2(PImage media) {
  if(media != null) {
    return new ivec2(media.width,media.height);
  } else {
    return null;
  }
}

/**
ivec3
*/
public ivec3 ivec3() {
  return ivec3(0) ;
}

public ivec3 ivec3(int v) {
  return new ivec3(v,v,v);
}

public ivec3 ivec3(int x, int y, int z) { 
  return new ivec3(x,y,z) ;
}

public ivec3 ivec3(int [] array) {
  if(array.length == 1) {
    return new ivec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new ivec3(array[0],array[1],0);
  } else if (array.length > 2) {
    return new ivec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

public ivec3 ivec3(ivec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new ivec3(0,0,0) ;
  } else if(p instanceof ivec5 || p instanceof ivec6) {
    return new ivec3(p.a,p.b,p.c) ;
  } else {
    return new ivec3(p.x,p.y,p.z) ;
  }
}

public ivec3 ivec3(float v) {
  return new ivec3(PApplet.parseInt(v),PApplet.parseInt(v),PApplet.parseInt(v));
}

public ivec3 ivec3(float x, float y,float z) { 
  return new ivec3(PApplet.parseInt(x),PApplet.parseInt(y),PApplet.parseInt(z));
}

public ivec3 ivec3(float [] array) {
  if(array.length == 1) {
    return new ivec3(PApplet.parseInt(array[0]),PApplet.parseInt(array[0]),PApplet.parseInt(array[0]));
  } else if (array.length == 2) {
    return new ivec3(PApplet.parseInt(array[0]),PApplet.parseInt(array[1]),0);
  } else if (array.length > 2) {
    return new ivec3(PApplet.parseInt(array[0]),PApplet.parseInt(array[1]),PApplet.parseInt(array[2]));
  } else {
    return null;
  }
}

public ivec3 ivec3(vec p) {
  if(p == null) {
    println("Vec null, instead '0' is used to build iVec") ;
    return new ivec3(0,0,0) ;
  } else if(p instanceof vec5 || p instanceof vec6) {
    return new ivec3(PApplet.parseInt(p.a),PApplet.parseInt(p.b),PApplet.parseInt(p.c));
  } else {
    return new ivec3(PApplet.parseInt(p.x),PApplet.parseInt(p.y),PApplet.parseInt(p.z));
  }
}

/**
ivec4
*/
public ivec4 ivec4() {
  return ivec4(0) ;
}

public ivec4 ivec4(int v) {
  return new ivec4(v,v,v,v);
}

public ivec4 ivec4(int x, int y, int z, int w) { 
  return new ivec4(x,y,z,w) ;
}

public ivec4 ivec4(int [] array) {
  if(array.length == 1) {
    return new ivec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new ivec4(array[0],array[1],0,0);
  } else if (array.length == 3) {
    return new ivec4(array[0],array[1],array[2],0);
  } else if (array.length > 3) {
    return new ivec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

public ivec4 ivec4(ivec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new ivec4(0,0,0,0) ;
  } else if(p instanceof ivec5 || p instanceof ivec6) {
    return new ivec4(p.a,p.b,p.c,p.d) ;
  } else {
    return new ivec4(p.x,p.y,p.z,p.w) ;
  }
}

public ivec4 ivec4(float v) {
  return new ivec4(PApplet.parseInt(v),PApplet.parseInt(v),PApplet.parseInt(v),PApplet.parseInt(v));
}

public ivec4 ivec4(float x, float y, float z, float w) { 
  return new ivec4(PApplet.parseInt(x),PApplet.parseInt(y),PApplet.parseInt(z),PApplet.parseInt(w));
}

public ivec4 ivec4(float [] array) {
  if(array.length == 1) {
    return new ivec4(PApplet.parseInt(array[0]),PApplet.parseInt(array[0]),PApplet.parseInt(array[0]),PApplet.parseInt(array[0]));
  } else if (array.length == 2) {
    return new ivec4(PApplet.parseInt(array[0]),PApplet.parseInt(array[1]),0,0);
  } else if (array.length == 3) {
    return new ivec4(PApplet.parseInt(array[0]),PApplet.parseInt(array[1]),PApplet.parseInt(array[2]),0);
  } else if (array.length > 3) {
    return new ivec4(PApplet.parseInt(array[0]),PApplet.parseInt(array[1]),PApplet.parseInt(array[2]),PApplet.parseInt(array[3]));
  } else {
    return null;
  }
}


public ivec4 ivec4(vec p) {
  if(p == null) {
    println("Vec null, instead '0' is used to build iVec") ;
    return new ivec4(0,0,0,0) ;
  } else if(p instanceof vec5 || p instanceof vec6) {
    return new ivec4(PApplet.parseInt(p.a),PApplet.parseInt(p.b),PApplet.parseInt(p.c),PApplet.parseInt(p.d));
  } else {
    return new ivec4(PApplet.parseInt(p.x),PApplet.parseInt(p.y),PApplet.parseInt(p.z),PApplet.parseInt(p.w));
  }
}

/**
ivec5
*/
public ivec5 ivec5() {
  return ivec5(0) ;
}

public ivec5 ivec5(int v) {
  return new ivec5(v,v,v,v,v);
}

public ivec5 ivec5(int a, int b, int c, int d, int e) { 
  return new ivec5(a,b,c,d,e) ;
}

public ivec5 ivec5(int [] array) {
  if(array.length == 1) {
    return new ivec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new ivec5(array[0],array[1],0,0,0);
  } else if (array.length == 3) {
    return new ivec5(array[0],array[1],array[2],0,0);
  } else if (array.length == 4) {
    return new ivec5(array[0],array[1],array[2],array[3],0);
  } else if (array.length > 4) {
    return new ivec5(array[0],array[1],array[2],array[3],array[4]);
  } else {
    return null;
  }
}

public ivec5 ivec5(ivec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new ivec5(0,0,0,0,0) ;
  } else if(p instanceof ivec5 || p instanceof ivec6) {
    return new ivec5(p.a,p.b,p.c,p.d,p.e) ;
  } else {
    return new ivec5(p.x,p.y,p.z,p.w,0) ;
  }
}

public ivec5 ivec5(vec p) {
  if(p == null) {
    println("Vec null, instead '0' is used to build iVec") ;
    return new ivec5(0,0,0,0,0) ;
  } else if(p instanceof vec5 || p instanceof vec6) {
    return new ivec5(PApplet.parseInt(p.a),PApplet.parseInt(p.b),PApplet.parseInt(p.c),PApplet.parseInt(p.d),PApplet.parseInt(p.e));
  } else {
    return new ivec5(PApplet.parseInt(p.x),PApplet.parseInt(p.y),PApplet.parseInt(p.z),PApplet.parseInt(p.w),0);
  }
}

/**
ivec6
*/
public ivec6 ivec6() {
  return ivec6(0) ;
}

public ivec6 ivec6(int v) {
  return new ivec6(v,v,v,v,v,v);
}

public ivec6 ivec6(int a, int b, int c, int d, int e, int f) { 
  return new ivec6(a,b,c,d,e,f) ;
}

public ivec6 ivec6(int [] array) {
  if(array.length == 1) {
    return new ivec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new ivec6(array[0],array[1],0,0,0,0);
  } else if (array.length == 3) {
    return new ivec6(array[0],array[1],array[2],0,0,0);
  } else if (array.length == 4) {
    return new ivec6(array[0],array[1],array[2],array[3],0,0);
  } else if (array.length == 5) {
    return new ivec6(array[0],array[1],array[2],array[3],array[4],0);
  }  else if (array.length > 5) {
    return new ivec6(array[0],array[1],array[2],array[3],array[4],array[5]);
  } else {
    return null;
  }
}

public ivec6 ivec6(ivec p) {
  if(p == null) {
    println("iVec null, instead '0' is used to build iVec") ;
    return new ivec6(0,0,0,0,0,0) ;
  } else if(p instanceof ivec5 || p instanceof ivec6) {
    return new ivec6(p.a,p.b,p.c,p.d,p.e,p.f) ;
  } else {
    return new ivec6(p.x,p.y,p.z,p.w,0,0) ;
  }
}

public ivec6 ivec6(vec p) {
  if(p == null) {
    println("Vec null, instead '0' is used to build iVec") ;
    return new ivec6(0,0,0,0,0,0) ;
  } else if(p instanceof vec5 || p instanceof vec6) {
    return new ivec6(PApplet.parseInt(p.a),PApplet.parseInt(p.b),PApplet.parseInt(p.c),PApplet.parseInt(p.d),PApplet.parseInt(p.e),PApplet.parseInt(p.f));
  } else {
    return new ivec6(PApplet.parseInt(p.x),PApplet.parseInt(p.y),PApplet.parseInt(p.z),PApplet.parseInt(p.w),0,0);
  }
}
























/**
Return a new Vec
*/
/**
Vec 2
*/
public vec2 vec2() {
  return new vec2(0,0) ;
}

public vec2 vec2(float x, float y) { 
  return new vec2(x,y) ;
}

public vec2 vec2(float [] array) {
  if(array.length == 1) {
    return new vec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new vec2(array[0],array[1]);
  } else {
    return null;
  }
}

public vec2 vec2(int [] array) {
  if(array.length == 1) {
    return new vec2(array[0],array[0]);
  } else if (array.length > 1) {
    return new vec2(array[0],array[1]);
  } else {
    return null;
  }
}

public vec2 vec2(float v) {
  return new vec2(v,v) ;
}

public vec2 vec2(PVector p) {
  if(p == null) {
    return new vec2(0,0);
  } else {
    return new vec2(p.x, p.y);
  }
}

public vec2 vec2(vec p) {
  if(p == null) {
    return new vec2(0,0);
  } else if(p instanceof vec5 || p instanceof vec6) {
    return new vec2(p.a,p.b);
  } else {
    return new vec2(p.x,p.y);
  }
}


public vec2 vec2(ivec p) {
  if(p == null) {
    return new vec2(0,0);
  } else if(p instanceof ivec5 || p instanceof ivec6) {
    return new vec2(p.a,p.b);
  } else {
    return new vec2(p.x,p.y);
  }
}




public vec2 vec2(PGraphics media) {
  if(media != null) {
    return new vec2(media.width,media.height);
  } else {
    return null;
  }
}

public vec2 vec2(PImage media) {
  if(media != null) {
    return new vec2(media.width,media.height);
  } else {
    return null;
  }
}
/**
Vec 3
*/
public vec3 vec3() {
  return new vec3(0,0,0) ;
}

public vec3 vec3(float x, float y, float z) {
  return new vec3(x,y,z);
}

public vec3 vec3(float [] array) {
  if(array.length == 1) {
    return new vec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new vec3(array[0],array[1],0);
  } else if (array.length > 2) {
    return new vec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

public vec3 vec3(int [] array) {
  if(array.length == 1) {
    return new vec3(array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new vec3(array[0],array[1],0);
  } else if (array.length > 2) {
    return new vec3(array[0],array[1],array[2]);
  } else {
    return null;
  }
}

public vec3 vec3(float v) {
  return new vec3(v,v,v);
}

public vec3 vec3(PVector p) {
  if(p == null) {
    return new vec3(0,0,0);
  } else {
    return new vec3(p.x, p.y, p.z);
  }
}

public vec3 vec3(vec p) {
  if(p == null) {
    return new vec3(0,0,0);
  } else if(p instanceof vec5 || p instanceof vec6) {
    return new vec3(p.a,p.b,p.c);
  } else {
    return new vec3(p.x,p.y,p.z);
  }
}

public vec3 vec3(ivec p) {
  if(p == null) {
    return new vec3(0,0,0);
  } else if(p instanceof ivec5 || p instanceof ivec6) {
    return new vec3(p.a,p.b,p.c);
  } else {
    return new vec3(p.x,p.y,p.z);
  }
}



/**
Vec 4
*/
public vec4 vec4() {
  return new vec4(0,0,0,0);
}

public vec4 vec4(float x, float y, float z, float w) {
  return new vec4(x,y,z,w);
}

public vec4 vec4(float [] array) {
  if(array.length == 1) {
    return new vec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new vec4(array[0],array[1],0,0);
  } else if (array.length == 3) {
    return new vec4(array[0],array[1],array[2],0);
  } else if (array.length > 3) {
    return new vec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

public vec4 vec4(int [] array) {
  if(array.length == 1) {
    return new vec4(array[0],array[0],array[0],array[0]);
  } else if (array.length == 2) {
    return new vec4(array[0],array[1],0,0);
  } else if (array.length == 3) {
    return new vec4(array[0],array[1],array[2],0);
  } else if (array.length > 3) {
    return new vec4(array[0],array[1],array[2],array[3]);
  } else {
    return null;
  }
}

public vec4 vec4(float v) {
  return new vec4(v,v,v,v);
}

public vec4 vec4(PVector p) {
  if(p == null) {
    return new vec4(0,0,0,0);
  } else {
    return new vec4(p.x, p.y, p.z, 0);
  }
}
// build with Vec
public vec4 vec4(vec p) {
  if(p == null) {
    return new vec4(0,0,0,0);
  } else if(p instanceof vec5 || p instanceof vec6) {
    return new vec4(p.a,p.b,p.c,p.d);
  } else {
    return new vec4(p.x,p.y,p.z,p.w);
  }
}

public vec4 vec4(ivec p) {
  if(p == null) {
    return new vec4(0,0,0,0);
  } else if(p instanceof ivec5 || p instanceof ivec6) {
    return new vec4(p.a,p.b,p.c,p.d);
  } else {
    return new vec4(p.x,p.y,p.z,p.w);
  }
}



/**
Vec 5
*/
public vec5 vec5() {
  return new vec5(0,0,0,0,0);
}

public vec5 vec5(float a, float b, float c, float d, float e) {
  return new vec5(a,b,c,d,e);
}

public vec5 vec5(float [] array) {
  if(array.length == 1) {
    return new vec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new vec5(array[0],array[1],0,0,0) ;
  } else if (array.length == 3){
    return new vec5(array[0],array[1],array[2],0,0) ;
  } else if (array.length == 4){
    return new vec5(array[0],array[1],array[2],array[3],0) ;
  }  else if (array.length > 4){
    return new vec5(array[0],array[1],array[2],array[3],array[4]) ;
  } else {
    return null;
  }
}

public vec5 vec5(int [] array) {
  if(array.length == 1) {
    return new vec5(array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new vec5(array[0],array[1],0,0,0) ;
  } else if (array.length == 3){
    return new vec5(array[0],array[1],array[2],0,0) ;
  } else if (array.length == 4){
    return new vec5(array[0],array[1],array[2],array[3],0) ;
  }  else if (array.length > 4){
    return new vec5(array[0],array[1],array[2],array[3],array[4]) ;
  } else {
    return null;
  }
}

public vec5 vec5(float v) {
  return new vec5(v,v,v,v,v);
}

public vec5 vec5(PVector p) {
  if(p == null) {
    return new vec5(0,0,0,0,0);
  } else {
    return new vec5(p.x, p.y, p.z, 0,0);
  }
}
// build with Vec
public vec5 vec5(vec p) {
  if(p == null) {
    return new vec5(0,0,0,0,0);
  } else if(p instanceof vec5 || p instanceof vec6) {
    return new vec5(p.a,p.b,p.c,p.d,p.e);
  } else {
    return new vec5(p.x,p.y,p.z,p.w,p.e);
  }
}

public vec5 vec5(ivec p) {
  if(p == null) {
    return new vec5(0,0,0,0,0);
  }  else if(p instanceof ivec5 || p instanceof ivec6) {
    return new vec5(p.a,p.b,p.c,p.d,p.e);
  } else {
    return new vec5(p.x,p.y,p.z,p.w,p.e);
  }
}


/**
Vec 6
*/
public vec6 vec6() {
  return new vec6(0,0,0,0,0,0) ;
}

public vec6 vec6(float a, float b, float c, float d, float e, float f) {
  return new vec6(a,b,c,d,e,f);
}

public vec6 vec6(float [] array) {
  if(array.length == 1) {
    return new vec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new vec6(array[0],array[1],0,0,0,0) ;
  } else if (array.length == 3){
    return new vec6(array[0],array[1],array[2],0,0,0) ;
  } else if (array.length == 4){
    return new vec6(array[0],array[1],array[2],array[3],0,0) ;
  } else if (array.length == 5){
    return new vec6(array[0],array[1],array[2],array[3],array[4],0) ;
  }  else if (array.length > 5){
    return new vec6(array[0],array[1],array[2],array[3],array[4],array[5]) ;
  } else {
    return null;
  }
}

public vec6 vec6(int [] array) {
  if(array.length == 1) {
    return new vec6(array[0],array[0],array[0],array[0],array[0],array[0]);
  } else if (array.length == 2){
    return new vec6(array[0],array[1],0,0,0,0) ;
  } else if (array.length == 3){
    return new vec6(array[0],array[1],array[2],0,0,0) ;
  } else if (array.length == 4){
    return new vec6(array[0],array[1],array[2],array[3],0,0) ;
  } else if (array.length == 5){
    return new vec6(array[0],array[1],array[2],array[3],array[4],0) ;
  }  else if (array.length > 5){
    return new vec6(array[0],array[1],array[2],array[3],array[4],array[5]) ;
  } else {
    return null;
  }
}

public vec6 vec6(float v) {
  return new vec6(v,v,v,v,v,v);
}
public vec6 vec6(PVector p) {
  if(p == null) {
    return new vec6(0,0,0,0,0,0);
  } else {
    return new vec6(p.x, p.y, p.z, 0,0,0);
  }
}

// build with vec
public vec6 vec6(vec p) {
  if(p == null) {
    return new vec6(0,0,0,0,0,0);
  } else if(p instanceof vec5 || p instanceof vec6) {
    return new vec6(p.a,p.b,p.c,p.d,p.e,p.f);
  } else {
    return new vec6(p.x,p.y,p.z,p.w,p.e,p.f);
  }
}

public vec6 vec6(ivec p) {
  if(p == null) {
    return new vec6(0,0,0,0,0,0) ;
  } else if(p instanceof ivec5 || p instanceof ivec6) {
    return new vec6(p.a,p.b,p.c,p.d,p.e,p.f);
  } else {
    return new vec6(p.x,p.y,p.z,p.w,p.e,p.f);
  }
}












/**
Rope COLOUR
v 0.6.4
* Copyleft (c) 2016-2018 
* Stan le Punk > http://stanlepunk.xyz/
Rope – Romanesco Processing Environment – 
Processing 3.4
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*
* Pack of method to use colour, palette and method conversion
*
*/







/**
COLOUR LIST class
v 0.0.2
*/
/**
* Idea for the future add a list name for colour

* get the colour by index or name
*/
public class ROPE_colour implements rope.core.RConstants {
	int [] c;
	public ROPE_colour(int... c) {
		this.c = new int[c.length];
		for(int i = 0; i < c.length ; i++) {
			this.c[i] = c[i];
		}
	}

	public int[] get_colour() {
		return c;
	}

	public float[] get_hue() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = hue(c[i]);
		}
		return component;
	}

	public float[] get_saturation() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = saturation(c[i]);
		}
		return component;
	}

	public float[] get_brightness() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = brightness(c[i]);
		}
		return component;
	}

	public float[] get_red() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = red(c[i]);
		}
		return component;
	}

	public float[] get_green() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = green(c[i]);
		}
		return component;
	}

	public float[] get_blue() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = blue(c[i]);
		}
		return component;
	}

	public float[] get_alpha() {
		float[] component = new float[c.length];
		for(int i = 0 ; i < c.length ; i++) {
			component[i] = blue(c[i]);
		}
		return component;
	}
}




/**
GET COLORMODE
v 0.0.2
*/
/**
* getColorMode()
* @return float array of your color environment.
* @param boolean print_info_is retrun a print about the color environment
*/
public float [] getColorMode(boolean print_info_is) {
  float colorMode = g.colorMode ;
  float x = g.colorModeX;
  float y = g.colorModeY;
  float z = g.colorModeZ;
  float a = g.colorModeA;
  float array[] = {colorMode,x,y,z,a};
  if (print_info_is && g.colorMode == HSB) {
    println("HSB",x,y,z,a);
  } else if(print_info_is && g.colorMode == RGB) {
    println("RGB",x,y,z,a);
  }
  return array;
}

public float [] getColorMode() {
  return getColorMode(false);
}

/**
camaieu 
v 0.1.1
*/
// return hue or other date in range of specific data float
public float camaieu(float max, float color_ref, float range) {
  float camaieu = 0 ;
  float which_color = random(-range, range) ;
  camaieu = color_ref +which_color ;
  if(camaieu < 0 ) camaieu = max +camaieu ;
  if(camaieu > max) camaieu = camaieu -max ;
  return camaieu ;
}







/**
color pool 
v 0.2.0
*/
// color pool vec4 RGB
public vec4 [] color_pool_RGB(int num) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float range = g.colorModeX *.5f ;
  int num_group = 1 ;
  float key_hue = -1 ;
  return color_pool_RGB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

public vec4 [] color_pool_RGB(int num, float key_hue) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float range = g.colorModeX *.5f ;
  int num_group = 1 ;
  return color_pool_RGB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}


public vec4 [] color_pool_RGB(int num, int num_group, float hue_range) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float key_hue = -1 ;
  return color_pool_RGB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


public vec4 [] color_pool_RGB(int num, int num_group, float key_hue, float hue_range) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  return color_pool_RGB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

public vec4 [] color_pool_RGB(int num, int num_group, float hue_range, vec2 sat_range, vec2 bright_range, vec2 alpha_range) {
  float key_hue = -1 ;
  return color_pool_RGB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


public vec4 [] color_pool_RGB(int num, int num_group, float key_hue, float hue_range, vec2 sat_range, vec2 bright_range, vec2 alpha_range) {
  vec4 [] list = new vec4[num]  ;
  int [] c = color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
  for(int i = 0 ; i <list.length ; i++) {
    list[i] = new vec4(red(c[i]),green(c[i]),blue(c[i]),alpha(c[i])) ;
  }
  return list ;
}

// color pool vec4 HSB
public vec4 [] color_pool_HSB(int num) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float range = g.colorModeX *.5f ;
  int num_group = 1 ;
  float key_hue = -1 ;
  return color_pool_HSB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

public vec4 [] color_pool_HSB(int num, float key_hue) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float range = g.colorModeX *.5f ;
  int num_group = 1 ;
  return color_pool_HSB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}


public vec4 [] color_pool_HSB(int num, int num_group, float hue_range) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float key_hue = -1 ;
  return color_pool_HSB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


public vec4 [] color_pool_HSB(int num, int num_group, float key_hue, float hue_range) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  return color_pool_HSB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

public vec4 [] color_pool_HSB(int num, int num_group, float hue_range, vec2 sat_range, vec2 bright_range, vec2 alpha_range) {
  float key_hue = -1 ;
  return color_pool_HSB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


public vec4 [] color_pool_HSB(int num, int num_group, float key_hue, float hue_range, vec2 sat_range, vec2 bright_range, vec2 alpha_range) {
  vec4 [] list = new vec4[num]  ;
  int [] c = color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
  for(int i = 0 ; i <list.length ; i++) {
    list[i] = new vec4(hue(c[i]),saturation(c[i]),brightness(c[i]),alpha(c[i])) ;
  }
  return list ;
}

// color pool int
public int [] color_pool(int num) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float range = g.colorModeX *.5f ;
  int num_group = 1 ;
  float key_hue = -1 ;
  return color_pool(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

public int [] color_pool(int num, float key_hue) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float range = g.colorModeX *.5f ;
  int num_group = 1 ;
  return color_pool(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

public int [] color_pool(int num, int num_group, float hue_range) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  float key_hue = -1 ;
  return color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

public int [] color_pool(int num, int num_group, float key_hue, float hue_range) {
  vec2 sat_range = vec2(g.colorModeY) ;
  vec2 bright_range = vec2(g.colorModeZ) ;
  vec2 alpha_range = vec2(g.colorModeA) ;
  return color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

public int [] color_pool(int num, int num_group, float hue_range, vec2 sat_range, vec2 bright_range, vec2 alpha_range) {
  float key_hue = -1 ;
  return color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;

}

// color pool by group
public int [] color_pool(int num, int num_group, float key_hue, float hue_range, vec2 sat_range, vec2 bright_range, vec2 alpha_range) {
  int ref = g.colorMode ;
  float x = g.colorModeX ;
  float y = g.colorModeY ;
  float z = g.colorModeZ ;
  float a = g.colorModeA ;
  colorMode(HSB,360,100,100,100) ;

  float [] color_ref = new float[num_group] ;
  if(key_hue >= 0 ) {
    color_ref[0] = key_hue ;
  } else {
    color_ref[0] = random(g.colorModeX) ;
  }
  if(num_group > 1) {
    float step = g.colorModeX / num_group ;
    for(int i = 1 ; i < num_group ; i++) {
      color_ref[i] = color_ref[i -1] + step ;
      if(color_ref[i] > g.colorModeX) {
        color_ref[i] = color_ref[i] - g.colorModeX ;
      }      
    }
  }

  int [] list = new int[num] ;
  int count = 0 ;
  int step = num / num_group ;
  int next_stop = step ; ;
  for(int i = 0 ; i < list.length ; i++) {
    if(i > next_stop) {
      next_stop += step ;
    }
    float saturation = random(sat_range) ;
    float brightness = random(bright_range) ;
    float alpha = random(alpha_range) ;
    float hue = camaieu(g.colorModeX, color_ref[count], hue_range) ;
    list[i] = color(hue, saturation,brightness, alpha) ;
    count++ ;
    if(count >= color_ref.length) count = 0 ;

  }
  colorMode(ref,x,y,z,a) ;
  return list ;
}





/**
component range
*/
public boolean alpha_range(float min, float max, int colour) {
  float alpha = alpha(colour) ;
  return in_range(min, max, alpha) ;
}

public boolean red_range(float min, float max, int colour) {
  float  r = red(colour) ;
  return in_range(min, max, r) ;
}

public boolean green_range(float min, float max, int colour) {
  float  g = green(colour) ;
  return in_range(min, max, g) ;
}

public boolean blue_range(float min, float max, int colour) {
  float  b = blue(colour) ;
  return in_range(min, max, b) ;
}

public boolean saturation_range(float min, float max, int colour) {
  float  s = saturation(colour) ;
  return in_range(min, max, s) ;
}

public boolean brightness_range(float min, float max, int colour) {
  float  b = brightness(colour) ;
  return in_range(min, max, b) ;
}


public boolean hue_range(float min, float max, int colour) {
  int c_m = g.colorMode ;
  float c_x = g.colorModeX ;
  float c_y = g.colorModeY ;
  float c_z = g.colorModeZ ;
  float c_a = g.colorModeA ;
  colorMode(HSB, c_x, c_y, c_z, c_a) ;
  float  h = hue(colour) ;

  boolean result = false ;
  // test for the wheel value, hue is one of them ;
  result = in_range_wheel(min, max, c_x, h) ;
  // return to the current colorMode
  colorMode(c_m, c_x, c_y, c_z, c_a) ;
  return result ;
}












/**
convert color 0.1.2
*/
//convert color HSB to RVB
public vec3 hsb_to_rgb(float hue, float saturation, float brightness) {
  vec4 ref = vec4(g.colorModeX, g.colorModeY, g.colorModeY, g.colorModeA);
  int c = color(hue,saturation,brightness);

  colorMode(RGB,255) ;
  vec3 rgb = vec3(red(c),green(c),blue(c)) ;
  // return to the previous colorMode
  colorMode(HSB,ref.r, ref.g, ref.b, ref.a) ;
  return rgb;
}

public vec4 to_cmyk(int c) {
  return rgb_to_cmyk(red(c),green(c),blue(c));
}


public vec4 rgb_to_cmyk(float r, float g, float b) {
  // convert to 0 > 1 value
  r = r/this.g.colorModeX;
  g = g/this.g.colorModeY;
  b = b/this.g.colorModeZ;
  // RGB to CMY
  float c = 1.f-r;
  float m = 1.f-g;
  float y = 1.f-b;
  // CMY to CMYK
  float var_k = 1;
  if (c < var_k) var_k = c;
  if (m < var_k) var_k = m;
  if (y < var_k) var_k = y;
  // black only
  if (var_k == 1) { 
    c = 0;
    m = 0;
    y = 0;
  } else {
    c = (c-var_k)/(1-var_k);
    m = (m-var_k)/(1-var_k);
    y = (y-var_k)/(1-var_k);
  }
  float k = var_k; 
  return vec4(c,m,y,k);
}

// same result
/*
vec4 rgb_to_cmyk_2(float r, float g, float b) {
  // convert to 0 > 1 value
  r = r/this.g.colorModeX;
  g = g/this.g.colorModeY;
  b = b/this.g.colorModeZ;
  // RGB to CMY
  float c = 1.-r;
  float m = 1.-g;
  float y = 1.-b;
  // CMY to CMYK
  float min_cmy = min(c,m,y);
  c = (c - min_cmy) / (1 - min_cmy);
  m = (m - min_cmy) / (1 - min_cmy);
  y = (y - min_cmy) / (1 - min_cmy);
  float k = min_cmy;
  return vec4(c,m,y,k);
}
*/









public vec3 cmyk_to_rgb(float c, float m, float y, float k) {
  vec3 rgb = null;
   // cmyk value must be from 0 to 1
  if(colour_normal_range_is(c) && colour_normal_range_is(m) && colour_normal_range_is(y) && colour_normal_range_is(k)) {
    // CMYK > CMY
    c = (c *(1.f-k)+k);
    m = (m *(1.f-k)+k);
    y = (y *(1.f-k)+k);
    //CMY > RGB
    float red = (1.f- c) * g.colorModeX;
    float green = (1.f- m) * g.colorModeY;
    float blue = (1.f- y) * g.colorModeZ;
    rgb = vec3(red,green,blue);

  } else {
    printErr("method cmyk_to_rgb(): the values c,m,y,k must have value from 0 to 1.\n","yours values is cyan",c,"magenta",m,"yellow",y,"black",k);
  }
  return rgb;
  
}

public boolean colour_normal_range_is(float v) {
  if(v >= 0.f && v <= 1.f) return true; else return false;
}










// color context
/*
* good when the text is on different background
*/
public int color_context(int color_ref, int threshold, int clear, int dark) {
  int new_color ;
  if(brightness(color_ref) < threshold ) {
    new_color = clear;
  } else {
    new_color = dark ;
  }
  return new_color ;
}












/**
ROPE - Romanesco processing environment – 
* Copyleft (c) 2014-2018
* Stan le Punk > http://stanlepunk.xyz/
ROPE core
v 0.1.1
2017-2018
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/










 


























/**
Something weird, now it's not necessary to use the method init_rope()
to use the interface Rope_constants...
that's cool but that's very weird !!!!!
*/
Rope r ;
public void init_rope() {
  r = new Rope();
  println("Init ROPE: Romanesco Processing Environment - 2015-2018");
}














/**
event
v 0.0.2
*/
vec2 scroll_event;
public void scroll(MouseEvent e) {
	float scroll_x = e.getCount();
	float scroll_y = e.getCount();
	if(scroll_event == null) {
		scroll_event = vec2(scroll_x,scroll_y);
	} else {
		scroll_event.set(scroll_x,scroll_y);
	}
}


public vec2 get_scroll() {
	if(scroll_event == null) {
		scroll_event = vec2();
		return scroll_event;
	} else {
		return scroll_event;
	}
}

/**
add for the future
import java.awt.event.MouseWheelEvent;
void mouseWheelMoved(MouseWheelEvent e) {
  println(e.getWheelRotation());
  println(e.getScrollType());
  println(MouseWheelEvent.WHEEL_UNIT_SCROLL);
  println(e.getScrollAmount());
  println(e.getUnitsToScroll());
}
*/


/**
COSTUME class
* Copyleft (c) 2019-2019
* v 0.6.1
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope_method
* Here you finf the class Costume and all the class shape used.
* Processing 3.5.3
*/


/**
PRIMITIVE
2019-2019
v 0.1.0
*/
public class Primitive implements RConstants {
	private vec3 pos;
	private float diam = 0;
	private vec2 dir;
  private vec3 [] pts;
  private int summits = 0;
  private float angle = 0;

	public Primitive () {}
  

  public vec3 [] get_normal() {
  	return pts;
  }

  public vec3 [] get() {
  	vec3 [] temp = new vec3[pts.length];
  	float radius = diam *.5f;
  	for(int i = 0 ; i < temp.length ; i++) {
  		temp[i] = pts[i].copy();
  		if(temp.length == 2) {
  			temp[i].mult(diam).add(pos);
  		} else {
  			temp[i].mult(radius).add(pos);
  		}
  	}
  	return temp;
  }


  public vec3 get_pos() {
  	return pos;
  }

  public vec2 get_dir() {
  	return dir;
  }

  public float get_diam() {
  	return diam;
  }

  public float get_radius() {
  	return diam*.5f;
  }

  public int get_summits() {
  	return summits;
  }

  public float get_angle() {
  	return angle;
  }


  /**
  * draw
  * calcule and show result in same methode
  */
	public void draw(float diam, int summits) {
	  draw(vec3(),diam,summits,0,vec2());
	}

	public void draw(vec pos, float diam, int summits) {
	  draw(pos,diam,summits,0,vec2());
	}

	public void draw(vec pos, float diam, int summits, vec2 dir_P3D) {
	  draw(pos,diam,summits,0,dir_P3D);
	}

	public void draw(vec pos, float diam, int summits, float angle) {
	  draw(pos,diam,summits,angle,vec2());
	}

	public void draw(vec pos, float diam, int summits, float angle, vec2 dir_P3D) {
    calc(pos,diam,summits,angle,dir_P3D);
		show();
	}
  

  /**
  * calcule all points for shape
  */
  public void calc(float diam, int summits) {
	  calc(vec3(),diam,summits,0,vec2());
	}

	// Primitive with vec method
	public void calc(vec pos, float diam, int summits) {
	  calc(pos,diam,summits,0,vec2());
	}

	public void calc(vec pos, float diam, int summits, vec2 dir_P3D) {
	  calc(pos,diam,summits,0,dir_P3D);
	}

	public void calc(vec pos, float diam, int summits, float angle) {
	  calc(pos,diam,summits,angle,vec2());
	}
	// Primitive with vec method and angle to display
	public void calc(vec pos, float diam, int summits, float angle, vec2 dir_P3D) {
		this.diam = diam;

		if(this.pos == null) {
			this.pos = vec3(pos.x,pos.y,pos.z);
		} else {
			this.pos.set(pos.x,pos.y,pos.z);
		}

		if(this.dir == null) {
			this.dir = vec2(dir_P3D.x,dir_P3D.y);
		} else {
			this.dir.set(dir_P3D.x,dir_P3D.y);
		}
    // println("this",this.summits,this.angle);
    // println("new",summits,angle);
    if(this.summits != summits || this.angle != angle) {
    	this.summits = summits;
    	this.angle = angle;
    	build();
    }

	  /**
	  * IN FUTURE MUST BE COMPUTE with POLYGON 3D may be in 2028 ??????

	  if (dir_P3D != null && renderer_P3D()) {
	    // polygon_3D()
	    // method must be used in the future when this one is not shitty instead polygon2D() with matrix();
	    // classic version with polygon_2D method
	    for (int i = 0 ; i < summits ; i++) {
	      printTempo(60,"param",i,summits,angle);
	      points[i] = polygon_2D(summits, angle)[i].copy();
	      printTempo(60,"point",points[i]);
	    }
	  } else {
	    for (int i = 0 ; i < summits ; i++) {
	      points[i] = polygon_2D(summits, angle)[i].copy();
	    }
	  }

	  // draw the shape
	  // this rotate part must be integrate with a cartesian method in the circle method
	  draw_primitive(pos,dir_P3D,radius,points);

	  
	  With advance shitty version of Polygon_3D
	  if(dir == null ) {
	    draw_primitive(pos, radius, points); 
	  } else if (dir != null && renderer_P3D()) {
	    draw_primitive( points);
	  }
	  */
	}








  /**
  * build all the point if necessary, that increase the speed rendering
  */
	private void build() {
    // security for the sinple, null or negative point quantity
	  if(this.summits < 2) {
	    this.summits = 2;
	  }

	  pts = new vec3[this.summits];
	  // create coord of the shape
	  if(this.summits == 2 && this.angle == 0) {
	    pts[0] = vec3(-.5f,0,0);
	    pts[1] = vec3(.5f,0,0);
	  } else {
	    for (int i = 0 ; i < this.summits ; i++) {
	      pts[i] = polygon_2D(this.summits,this.angle)[i].copy();
	    }
	  }
	}





	/**
	* main SHOW primitive
	* the line rendering is awful, very very low when there is a lot of shape,
	* may be the compute on polygon_2D() is guilty
	*/
	private void show() {
		float radius = diam *.5f;
	  boolean check_line = false;

	  vec3 [] temp_pos = new vec3[pts.length];
	  for(int i = 0 ; i < temp_pos.length ; i++) {
	  	temp_pos[i] = pts[i].copy();
	  }

	  if(temp_pos.length == 2) {
	  	for(int i = 0 ; i < temp_pos.length ; i++) {
	  		temp_pos[i].mult(diam).add(pos);
	  	}
	  	line(temp_pos[0],temp_pos[1]);
	  } else if(temp_pos.length == 3) {
	  	// faster method to display a lot of triangle
	  	for(int i = 0 ; i < temp_pos.length ; i++) {
	  		temp_pos[i].mult(radius).add(pos);
	  	}
	  	triangle(temp_pos[0],temp_pos[1],temp_pos[2]);
	  } else if (temp_pos.length == 4) {
	  	// faster method to display a lot of rect
	  	rectMode(CENTER);
	  	float side = diam*.5f *ROOT2;
	  	square(pos.x,pos.y,side);
	  } else {
	    beginShape();
	    for (int i = 0 ; i < temp_pos.length ; i++) {
	      if (temp_pos[i] != null ) {
	        vertex(temp_pos[i].mult(radius).add(pos));
	      }
	    }
	    endShape(CLOSE) ;
	  }
	}



	/**
	POLYGON 2D
	v 0.1.0
	*/
	public vec3 [] polygon_2D (int num) {
	  float new_orientation = 0;
	  return polygon_2D (num,new_orientation);
	}


	// main method
	public vec3 [] polygon_2D (int num, float new_orientation) {
	  vec3 [] p = new vec3[num];
	  // choice your starting point
	  float start_angle = PI*.5f +new_orientation;
	  if(num == 4) {
	    start_angle = PI*.25f +new_orientation;
	  }
	  // calcul the position of each summit, step by step
	  for(int i = 0 ; i < num ; i++) {
	    p[i] = compute_coord_polygon_2D(i,num,start_angle).copy();
	  }
	  return p;
	}

	public vec3 compute_coord_polygon_2D(int target, int num, float start_angle) {
	  float step_angle = map(target,0,num,0,TAU); 
	  float orientation = TAU -step_angle -start_angle;
	  vec2 temp_orientation_xy = to_cartesian_2D(orientation);
	  float x = temp_orientation_xy.x;
	  float y = temp_orientation_xy.y;
	  float z = 0 ;
	  return vec3(x,y,z);
	}


	/**
	POLYGON 3D
	but must be refactoring because the metod is a little shitty !!!!!
	*/
	// polygon with 3D direction in cartesian world
	public vec3 [] polygon_3D(int num, float new_orientation, vec3 dir) {
	  vec3 pos = vec3();
	  int radius = 1 ;
	  return polygon_3D (pos,radius,num,new_orientation,dir);
	}


	/**
	Inspirated by : Creating a polygon perpendicular to a line segment Written by Paul Bourke February 1997
	@see http://paulbourke.net/geometry/circlesphere/
	*/
	public vec3 [] polygon_3D(vec3 pos, float radius, int num, float new_orientation, vec3 dir) {

	  vec3 p1 = dir.copy();
	  vec3 p2 = to_cartesian_3D(PI,PI);
	  vec3 support = to_cartesian_3D(PI,PI);
	  /*
	  vec3 p2 = vec3(0,0,1) ;
	  vec3 support = vec3 (1,0,0) ;
	  */
	  // prepare the vector direction
	  vec3 r = vec3();
	  vec3 s = vec3();
	  vec3 p2_sub_p1 = sub(p1,p2);

	  r = cross(p2_sub_p1,support,r);
	  s = cross(p2_sub_p1,r,s);
	  r.dir();
	  s.dir();

	  // prepare polygone in 3D world
	  vec3 plane = vec3();
	  int num_temp = num +1 ;
	  vec3 [] p ;
	  p = new vec3 [num_temp] ;

	  // init vec3 p
	  for(int i = 0 ; i < num_temp ; i++) p[i] = vec3() ;
	  
	  // create normal direction for the point
	  float theta, delta;
	  delta = TAU / num;
	  int step = 0 ;
	  for (theta = 0 ; theta < TAU ; theta += delta) {
	    plane.x = p1.x + r.x * cos(theta +delta) + s.x * sin(theta +delta);
	    plane.y = p1.y + r.y * cos(theta +delta) + s.y * sin(theta +delta);
	    plane.z = p1.z + r.z * cos(theta +delta) + s.z * sin(theta +delta);
	    /**
	    plane is not a normal value, it's big problem :(((((((
	    */
	    plane.mult(radius);
	    plane.add(pos);
	    // write summits
	    p[step] = plane.copy();

	    step++ ;
	  }
	  return p ;
	}
}






































/**
Class House
2019-2019
v 0.0.6
*/
public class House {
	private int fill_roof = r.BLOOD;
	private int fill_wall = r.GRAY_3;
	private int fill_ground = r.BLACK;
	private int stroke_roof = r.BLACK;
	private int stroke_wall = r.BLACK;
	private int stroke_ground = r.BLACK;
	private float thickness = 1;
	private boolean aspect_is;

	private int level;
	private vec3 pos;
	private vec3 size;
	private boolean roof_ar, roof_cr; // to draw or not the small roof side
	private vec3 offset = vec3(-.5f,0,.5f); // to center the house; 

  private vec3 [] pa;
	private vec3 [] pc;

	private int type = CENTER;
	public House() {
		build();
	}
  
  public House(float size) {
  	this.size = vec3(size);
		build();
	}

	public House(float sx, float sy, float sz) {
		this.size = vec3(sx,sy,sz);
		build();
	}

	public void mode(int type) {
		this.type = type;
	}

	public void set_pos(vec3 pos) {
		if(this.pos == null) {
			this.pos = pos.copy();
		} else {
			this.pos.set(pos);
		}
	}

	public void set_size(vec3 size) {
		if(this.size == null) {
			this.size = size.copy();
		} else {
			this.size.set(size);
		}
	}

	private void set_peak(float ra, float rc) {
		// check if this peak configuration is permitted
		if(ra + rc > 1.f) {
			if(ra>rc) {
				ra = 1.f-rc; 
			} else {
				rc = 1.f-ra;
			}
		}

		if(ra > 0.f) {
			roof_ar = true;
			if(pa != null && pa[0] != null) {
				pa[0].x = 1.f-ra+offset.x;
			}
		}

		if(rc > 0.f) {
			roof_cr = true;
			if(pc != null && pc[0] != null) {
				pc[0].x = rc+offset.x;
			}
		}
	}
  // aspect
  // fill
  public void set_fill(int c) {
  	aspect_is = true;
  	fill_roof = fill_wall = fill_ground = c;
  }

  public void set_fill_roof(int c) {
		aspect_is = true;
		fill_roof = c;
	}

	public void set_fill_wall(int c) {
		aspect_is = true;
		fill_wall = c;
	}

	public void set_fill_ground(int c) {
		aspect_is = true;
		fill_ground = c;
	}

	public void set_fill(float x, float y, float z, float a) {
		set_fill(color(x,y,z,a));
	}

	public void set_fill_roof(float x, float y, float z, float a) {
		set_fill_roof(color(x,y,z,a));
	}

	public void set_fill_wall(float x, float y, float z, float a) {
		set_fill_wall(color(x,y,z,a));
	}

	public void set_fill_ground(float x, float y, float z, float a) {
		set_fill_ground(color(x,y,z,a));
	}

  // stroke
	public void set_stroke(int c) {
  	aspect_is = true;
  	stroke_roof = stroke_wall = stroke_ground = c;
  }

  public void set_stroke_roof(int c) {
		aspect_is = true;
		stroke_roof = c;
	}

	public void set_stroke_wall(int c) {
		aspect_is = true;
		stroke_wall = c;
	}

	public void set_stroke_ground(int c) {
		aspect_is = true;
		stroke_ground = c;
	}

	public void set_stroke(float x, float y, float z, float a) {
		set_stroke(color(x,y,z,a));
	}

	public void set_stroke_roof(float x, float y, float z, float a) {
		set_stroke_roof(color(x,y,z,a));
	}

	public void set_stroke_wall(float x, float y, float z, float a) {
		set_stroke_wall(color(x,y,z,a));
	}

	public void set_stroke_ground(float x, float y, float z, float a) {
		set_stroke_ground(color(x,y,z,a));
	}

	public void set_thickness(float thickness) {
		aspect_is = true;
		this.thickness = thickness;
	}

	public void aspect_is(boolean is) {
		this.aspect_is = is;
	}

  
  // build
	private void build() {
		pa = new vec3[5];
		pc = new vec3[5];
		
		pa[0] = vec3(1,-1,-0.5f); // roof peak
		pa[1] = vec3(1,0,-1);
		pa[2] = vec3(1,1,-1);
		pa[3] = vec3(1,1,0);
		pa[4] = vec3(1,0,0);

		pc[0] = vec3(0,-1,-0.5f); // roof peak
		pc[1] = vec3(0,0,-1);
		pc[2] = vec3(0,1,-1);
		pc[3] = vec3(0,1,0);
		pc[4] = vec3(0,0,0);

		for(int i = 0 ; i < pa.length ; i++) {
			pa[i].add(offset);
			pc[i].add(offset);
		}
	}
  

	public void show() {
		float smallest_size = 0;
		for(int i = 0 ; i < 3 ; i++) {
			if(smallest_size == 0 || smallest_size > size.array()[i]) {
				smallest_size = size.array()[i];
			}
		}

    // DEFINE FINAL OFFSET
    vec3 def_pos = null;
	  if(this.type == TOP) {
	  	if(pos == null) {
	  		def_pos = vec3();
	  		def_pos.add(vec3(0,size.y*.5f,0));
	  	} else {
	  		def_pos = pos.copy();
	  		def_pos.add(vec3(0,size.y*.5f,0));		
	  	}
	  } else if(this.type == BOTTOM) {
	  	if(pos == null) {
	  		def_pos = vec3();
	  		def_pos.add(vec3(0,-size.y,0));
	  	} else {
	  		def_pos = pos.copy();
	  		def_pos.add(vec3(0,-size.y,0));		
	  	}
	  }



	  // WALL
	  if(aspect_is) {
	  	aspect(fill_wall,stroke_wall,thickness);
	  }
		// draw A : WALL > small and special side
		beginShape();
		if(def_pos == null) {
			if(!roof_ar) {
				vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			}
			for(int i = 1 ; i < pa.length ; i++) {
				vertex(pa[i].copy().mult(size));
			}
		} else {
			if(!roof_ar) {
				vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
			}
			for(int i = 1 ; i < pa.length ; i++) {
				vertex(pa[i].copy().mult(size).add(def_pos));
			}
		}
		endShape(CLOSE);


	  // draw B : WALL > main wall
	  beginShape();
		if(def_pos == null) {
			vertex(pa[2].copy().mult(size));
			vertex(pa[1].copy().mult(size));
			vertex(pc[1].copy().mult(size));
			vertex(pc[2].copy().mult(size));
		} else {
			vertex(pa[2].copy().mult(size).add(def_pos));
			vertex(pa[1].copy().mult(size).add(def_pos));
			vertex(pc[1].copy().mult(size).add(def_pos));
			vertex(pc[2].copy().mult(size).add(def_pos));
		}
		endShape(CLOSE);

	  // draw C : WALL > small and special side
		beginShape();
		if(def_pos == null) {
			if(!roof_cr) {
				vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			}
			for(int i = 1 ; i < pc.length ; i++) {
				vertex(pc[i].copy().mult(size));
			}
		} else {
			if(!roof_cr) {
				vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
			}
			for(int i = 1 ; i < pc.length ; i++) {
				vertex(pc[i].copy().mult(size).add(def_pos));
			}	
		}
		endShape(CLOSE);

		// draw D : WALL > main wall
		beginShape();
		if(def_pos == null) {
			vertex(pa[3].copy().mult(size));
			vertex(pa[4].copy().mult(size));
			vertex(pc[4].copy().mult(size));
			vertex(pc[3].copy().mult(size));
		} else {
			vertex(pa[3].copy().mult(size).add(def_pos));
			vertex(pa[4].copy().mult(size).add(def_pos));
			vertex(pc[4].copy().mult(size).add(def_pos));
			vertex(pc[3].copy().mult(size).add(def_pos));
		}
		endShape(CLOSE);





    // GROUND
    if(aspect_is) {
	  	aspect(fill_ground,stroke_ground,thickness);
	  }
		// draw G : GROUND
		beginShape();
		if(def_pos == null) {
			vertex(pa[2].copy().mult(size));
			vertex(pc[2].copy().mult(size));
			vertex(pc[3].copy().mult(size));
			vertex(pa[3].copy().mult(size));
		} else {
			vertex(pa[2].copy().mult(size).add(def_pos));
			vertex(pc[2].copy().mult(size).add(def_pos));
			vertex(pc[3].copy().mult(size).add(def_pos));
			vertex(pa[3].copy().mult(size).add(def_pos));
		}
		endShape(CLOSE);



    // ROOF
    if(aspect_is) {
	  	aspect(fill_roof,stroke_roof,thickness);
	  }
    // draw E : ROOF > main roof
		beginShape();
		if(def_pos == null) {
			vertex(pa[4].copy().mult(size));
			vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			vertex(pc[4].copy().mult(size));			
		} else {
			vertex(pa[4].copy().mult(size).add(def_pos));
			vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
			vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
			vertex(pc[4].copy().mult(size).add(def_pos));
		}
		endShape(CLOSE);

		// draw F : ROOF > main roof
		beginShape();
		if(def_pos == null) {
			vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
			vertex(pa[1].copy().mult(size));
			vertex(pc[1].copy().mult(size));
			vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
		} else {
			vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
			vertex(pa[1].copy().mult(size).add(def_pos));
			vertex(pc[1].copy().mult(size).add(def_pos));
			vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
		}
		endShape(CLOSE);

		// DRAW AR  > small side roof
		if(roof_ar) {
			beginShape();
			if(def_pos == null) {
				vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
				vertex(pa[1].copy().mult(size));
				vertex(pa[4].copy().mult(size));
			} else {
				vertex(pa[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
				vertex(pa[1].copy().mult(size).add(def_pos));
				vertex(pa[4].copy().mult(size).add(def_pos));
			}
			endShape(CLOSE);
		}

		// DRAW CR > small side roof
		if(roof_cr) {
			beginShape();
			if(def_pos == null) {
				vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z))); // special point for the roof peak
				vertex(pc[1].copy().mult(size));
				vertex(pc[4].copy().mult(size));
			} else {
				vertex(pc[0].copy().mult(vec3(size.x,smallest_size,size.z)).add(def_pos)); // special point for the roof peak
				vertex(pc[1].copy().mult(size).add(def_pos));
				vertex(pc[4].copy().mult(size).add(def_pos));
			}
			endShape(CLOSE);
		}
	}
}






























/**
STAR
2016-2018
v 0.1.0
*/
public class Star {
	boolean is_3D = false;
	vec3 pos;
	vec3 size;
	int summits;
	float angle;
	float [] ratio;

	public Star() {
		pos = vec3();
		size = vec3(1);
		summits = 5;
		ratio = new float[1]; 
		ratio[0] = .38f;
		angle = 0;
	}

	public void is_3D(boolean is_3D) {
		this.is_3D = is_3D;
	}

	public void set_summits(int summits) {
		if(summits > 3) this.summits = summits;
	}

	public void set_angle(float angle) {
		this.angle = angle;
	}

	public void set_ratio(float... ratio) {
		this.ratio = ratio;
	}

	public void show(vec position, vec size_raw) {
		if(position instanceof vec2) {
			vec2 p = (vec2) position;
			pos.set(p.x,p.y,0);
		} else if(position instanceof vec3) {
			vec3 p = (vec3)position;
			pos.set(p);
		}

		if(size_raw instanceof vec2) {
			vec2 s = (vec2)size_raw;
			size.set(s.x,s.y,1);
		} else if(size_raw instanceof vec3) {
			vec3 s = (vec3)size_raw;
			size.set(s.x,s.y,s.z);
		}

		if(pos.z != 0) {
			start_matrix();
			translate(0,0,pos.z);
		}

		vec3 [] p = new Primitive().polygon_2D(summits*2,angle);
    
    if(is_3D) {
    	star_3D(pos,size,p,ratio);
    } else {
    	star_2D(pos,size,p,ratio);
    }
		


		if(pos.z != 0) {
			stop_matrix();
		}
	}

	private void star_3D(vec3 pos, vec3 size, vec3 [] p, float[] ratio) {
		int count_ratio = 0;
		for(int i = 0 ; i < p.length ; i++) {
			// make a star, change the interior radius
			if(ratio.length <= 1 ) {
				if(i%2 != 0) p[i].mult(ratio[0]);
			} else {
				if(i%(ratio.length) == 0) {
					count_ratio = 0;

				}
				p[i].mult(ratio[count_ratio]) ;
				count_ratio++;
			}
			p[i].mult(size);
			p[i].add(pos);
		}
	  
	  float top = size.z;
	  float bottom = -size.z;
	  vec3 center = barycenter(p);
	  vec3 center_top = vec3(center.x,center.y,top);
	  vec3 center_bottom = vec3(center.x,center.y,bottom);

		for(int i = 0 ; i < p.length ; i++) {
			// face top
			beginShape() ;
			vertex(p[i]);
	    vertex(center_top);
			if(i+1 < p.length)  {
				vertex(p[i+1]);
			} else {
				vertex(p[0]);
			}
			endShape(CLOSE);
			// face bottom
			beginShape() ;
			vertex(p[i]);
	    vertex(center_bottom);
			if(i+1 < p.length)  {
				vertex(p[i+1]);
			} else {
				vertex(p[0]);
			}
			endShape(CLOSE);
		}
	}



	private void star_2D(vec3 pos, vec3 size, vec3 [] p, float[] ratio) {
		int count_ratio = 0;
		for(int i = 0 ; i < p.length ; i++) {
			// make a star, change the interior radius
			if(ratio.length <= 1 ) {
				if(i%2 != 0) p[i].mult(ratio[0]);
			} else {
				if(i%(ratio.length) == 0) {
					count_ratio = 0;

				}
				p[i].mult(ratio[count_ratio]) ;
				count_ratio++;
			}
			p[i].mult(size);
			p[i].add(pos);
		}
		// draww star
		beginShape() ;
		for(int i = 0 ; i < p.length ; i++) {
			vertex(p[i]);
		}
		endShape(CLOSE);
	}
}




























/**
CLASS VIRUS
2015-2018
v 0.2.0
*/
public class Virus {
	vec3 [][] branch;
	vec3 size;
	vec3 pos ;
	int node = 4;
	int num = 4;
	int mutation = 4;

	float angle = 0 ;
	public Virus() {
		size = vec3(1);
		pos = vec3(0);
		set_branch();
	}

  // set
	private void set_branch() {
		branch = new vec3 [node][num] ;
		for(int i = 0 ; i < node ; i++) {
			for(int k = 0 ; k < num ; k++) {
				vec3 dir = vec3().rand(-1,1);
				branch[i][k] = projection(dir) ;
			}
		}
	}


	public void set_node(int node) {
		this.node = node;
		set_branch();
	}

	public void set_num(int num) {
		this.num = num;
		set_branch();
	}

	public void set_mutation(int mutation) {
		this.mutation = mutation;
	}
  

  // get
	public int get_mutation() {
		return this.mutation;
	}

	public int get_node() {
		return this.node;
	}

	public int get_num() {
		return this.num;
	}



  

  // method
	public void reset() {
		for(int i = 0 ; i < node ; i++) {
			for(int k = 0 ; k < num ; k++) {
				vec3 dir = vec3().rand(-1,1);
				branch[i][k].set(projection(dir)) ;
			}
		}
	}
  
  // set
  public void set_size(vec s) {
  	vec3 final_size = vec3(1) ;
		if(s instanceof vec2) {
			vec2 size_temp = (vec2) s ;
			final_size.set(size_temp.x, size_temp.y, 1) ;
		} else if (s instanceof vec3) {
			vec3 size_temp = (vec3) s ;
			final_size.set(size_temp) ;
		}
		size.set(final_size) ;
	}

	public void set_pos(vec p) {
  	vec3 final_pos = vec3() ;
		if(p instanceof vec2) {
			vec2 pos_temp = (vec2) p ;
			final_pos.set(pos_temp.x, pos_temp.y, 1) ;
		} else if (p instanceof vec3) {
			vec3 pos_temp = (vec3) p ;
			final_pos.set(pos_temp) ;
		}
		pos.set(final_pos) ;
	}
  

  public void rotation(float angle) {
  	this.angle = angle ;
  	// System.err.println("Virus rotation() don't work must be coded for the future") ;
  }

	public vec2 angle(float angle) {
		return to_cartesian_2D(angle) ;
	}
  

  // show
  public void show() {
  	show(-1) ;
  }
	


	public void show(int close) {
		if(angle != 0) {
			start_matrix() ;
			translate(pos) ;
			rotate(angle) ;
		}
		for(int k = 0 ; k < num ; k++) {
			if(node == 2) {
				vec3 final_pos_a = branch[0][k].copy() ;
				final_pos_a.add(angle(angle)) ;
				final_pos_a.mult(size) ;
				if(angle == 0) final_pos_a.add(pos) ;

				vec3 final_pos_b = branch[1][k].copy() ;
				final_pos_b.mult(size) ;
				if(angle == 0) final_pos_b.add(pos) ;
				line(final_pos_a, final_pos_b) ;
			} else if( node > 2) {
				beginShape() ;
				for(int m = 0 ; m < node ; m++) {
					vec3 final_pos = branch[m][k].copy() ;
					final_pos.mult(size) ;
					if(angle == 0) final_pos.add(pos) ;
					vertex(final_pos) ;
				}
				if(close == CLOSE) endShape(CLOSE) ; else endShape() ;
			} else {
				vec3 final_pos = branch[0][k].copy() ;
				//final_pos.add(angle(angle)) ;
				final_pos.mult(size) ;
				if(angle == 0) final_pos.add(pos) ;
				point(final_pos) ;
			}
		}
		if(angle != 0) stop_matrix() ;
	}
  
  // get
	public vec3 [][] get() {
		return branch ;
	}
}






















































/**
COSTUME CLASS
*/
public class Costume_pic {
	PImage img ;
	ROPE_svg svg ;
	int type = -1 ; 

	String name ;
	int ID ;
	public Costume_pic(PApplet p5, String path, int ID) {
		// add png
		if(path.endsWith("png") || path.endsWith("PNG")) {
			img = loadImage(path) ;
			type = 1 ;
		}

		// add svg
		if(path.endsWith("svg") || path.endsWith("SVG")) {
			svg = new ROPE_svg(p5, path) ;
						svg.mode(CENTER) ;
			svg.build() ;
			type = 2 ;
		}
		
		String [] split = path.split("/") ;
		name = split[split.length -1] ;
		name = name.substring(0, name.lastIndexOf(".")) ;
		this.ID = ID ;
	}
}















/**
class Costume 
2018-2019
v 0.2.0
*/
public class Costume {
	boolean fill_is;
	boolean stroke_is;
	int fill;
	int stroke;
	float thickness = 1.f;

	int type;
	int node;
	int summits;
	int num;
	int mutation;
  float angle;
	float [] ratio;
	boolean is_3D = false;
	boolean is_vertex = true;
	Primitive prim;

	public Costume() {}

	public Costume(int type) {
		this.type = type;
	}
  
  // set
  public void set_type(int type) {
		this.type = type;
	}

	public void set_node(int node) {
		this.node = node;
	}

	public void set_mutation(int mutation) {
		this.mutation = mutation;
	}

	public void set_summit(int summits) {
		this.summits = summits;
	}

	public void set_num(int num) {
		this.num = num;
	}

	public void set_angle(float angle) {
		this.angle = angle;
	}

	public void set_ratio(float... ratio) {
		this.ratio = ratio;
	}

	public void is_3D(boolean is_3D) {
		this.is_3D = is_3D;
	}

	public void is_vertex(boolean is_vertex) {
		this.is_vertex = is_vertex;
	}



	// get
	public int get_fill() {
		return fill;
	}

	public int get_stroke() {
		return stroke;
	}

	public float get_thickness() {
		return thickness;
	}


	public int get_type() {
		return type;
	}

	public int get_node() {
		return node;
	}

	public int get_mutation() {
		return mutation;
	}

	public int get_summit() {
		return summits;
	}

	public int get_num() {
		return num;
	}

	public float get_angle() {
		return angle;
	}

	public float[] get_ratio() {
		return ratio;
	}

	public boolean is_3D() {
		return is_3D;
	}

	public boolean is_vertex() {
		return is_vertex;
	}

	public boolean fill_is() {
		return this.fill_is;
	}

	public boolean stroke_is() {
		return this.stroke_is;
	}






	// ASPECT
	public void aspect_is(boolean fill_is, boolean stroke_is) {
		this.fill_is = fill_is;
		this.stroke_is = stroke_is;
	}

	public void init_bool_aspect() {
		this.fill_is = true ;
	  this.stroke_is = true ;
	}

	public void aspect(int fill, int stroke, float thickness) {
	  //checkfill color
	  if(alpha(fill) <= 0 || !this.fill_is)  {
	    noFill(); 
	  } else {
	  	manage_fill(fill);
	  } 
	  //check stroke color
	  if(alpha(stroke) <=0 || thickness <= 0 || !this.stroke_is) {
	    noStroke();
	  } else {
	  	manage_stroke(stroke);
	    manage_thickness(thickness);
	  }
	  //
	  init_bool_aspect();
	}

	public void aspect(int fill, int stroke, float thickness, Costume costume) {
		aspect(fill,stroke,thickness,costume.get_type());
	}

	public void aspect(int fill, int stroke, float thickness, int costume) {
		if(costume == r.NULL) {
	    // 
		} else if(costume != r.NULL || costume != POINT_ROPE || costume != POINT) {
	    if(alpha(fill) <= 0 || !fill_rope_is) {
	    	noFill(); 
	    } else {
	    	manage_fill(fill);
	    }

	    if(alpha(stroke) <= 0  || thickness <= 0 || !stroke_rope_is) {
	    	noStroke(); 
	    } else {
	    	manage_stroke(stroke);
	      manage_thickness(thickness);
	    }   
	  } else {
	    if(alpha(fill) == 0) {
	    	noStroke(); 
	    } else {
	    	// case where the fill is use like a stroke, for point, pixel...
	    	manage_stroke(fill);
	    	manage_thickness(thickness);
	    }
	    noFill();   
	  }
	  //
	  init_bool_aspect();
	}



	public void aspect(vec fill, vec stroke, float thickness) {
	  //checkfill color
	  if(fill.w <=0 || !this.fill_is)  {
	    noFill() ; 
	  } else {
	    manage_fill(fill);
	  } 
	  //check stroke color
	  if(stroke.w <=0 || thickness <= 0 || !this.stroke_is) {
	    noStroke();
	  } else {
	    manage_stroke(stroke);
	    manage_thickness(thickness);
	  }
	  //
	  init_bool_aspect();
	}

	public void aspect(vec fill, vec stroke, float thickness, Costume costume) {
		aspect(fill,stroke,thickness,costume.get_type());
	}


	public void aspect(vec fill, vec stroke, float thickness, int costume) {
	  if(costume == r.NULL) {
	    // 
		} else if(costume != r.NULL || costume != POINT_ROPE || costume != POINT) {
	    if(fill.w <= 0 || !this.fill_is) {
	    	noFill() ; 
	    } else {
	    	manage_fill(fill);
	    } 
	    if(stroke.w <= 0  || thickness <= 0 || !this.stroke_is) {
	    	noStroke(); 
	    } else {
	    	manage_stroke(stroke);
	    	manage_thickness(thickness);
	    }   
	  } else {
	    if(fill.w <= 0 || !this.fill_is) {
	    	noStroke(); 
	    } else {
	    	// case where the fill is use like a stroke, for point, pixel...
	    	manage_stroke(fill); 
	    	manage_thickness(thickness);
	    }
	    noFill();   
	  }
	  //
	  init_bool_aspect();
	}


	private void manage_fill(Object arg) {
		if(arg instanceof vec2) {
			vec2 c = (vec2)arg;
			this.fill = color(c.x,c.x,c.x,c.y);
			fill(c) ;
		} else if(arg instanceof vec3) {
			vec3 c = (vec3)arg;
			this.fill = color(c.x,c.y,c.z,g.colorModeA);
			fill(c) ;
		} else if(arg instanceof vec4) {
			vec4 c = (vec4)arg;
			this.fill = color(c.x,c.y,c.z,c.w);
			fill(c);
		} else if(arg instanceof Integer) {
			int c = (int)arg;
			this.fill = c;
			fill(c);
		}
	}

	private void manage_stroke(Object arg) {
		if(arg instanceof vec2) {
			vec2 c = (vec2)arg;
			this.stroke = color(c.x,c.x,c.x,c.y);
			stroke(c);
		} else if(arg instanceof vec3) {
			vec3 c = (vec3)arg;
			this.stroke = color(c.x,c.y,c.z,g.colorModeA);
			stroke(c);
		} else if(arg instanceof vec4) {
			vec4 c = (vec4)arg;
			this.stroke = color(c.x,c.y,c.z,c.w);
			stroke(c);
		} else if(arg instanceof Integer) {
			int c = (int)arg;
			this.stroke = c;
			stroke(c);
		}
	}


	private void manage_thickness(float thickness) {
		this.thickness = thickness;
		strokeWeight(this.thickness);
	}






	public void draw(vec3 pos, vec3 size, vec rot) {
		if(rot.x != 0) costume_rotate_x();
		if(rot.y != 0) costume_rotate_y();
		if(rot.z != 0) costume_rotate_z();

		if (this.get_type() == PIXEL_ROPE) {
			set((int)pos.x,(int)pos.y,(int)get_fill_rope());
		} else if (this.get_type() == POINT_ROPE) {
	    strokeWeight(size.x);
			point(pos);
		} else if (this.get_type() == ELLIPSE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			ellipse(vec2(),size);
			stop_matrix();

		} else if (this.get_type() == RECT_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			rect(vec2(-size.x,-size.y).div(2),vec2(size.x,size.y));
			stop_matrix();

		} else if (this.get_type() == LINE_ROPE) {
			if(prim == null) prim = new Primitive();
			prim.draw(pos,size.x,2,rot.x);
		}

		else if (this.get_type() == TRIANGLE_ROPE) {
			if(prim == null) prim = new Primitive();
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			prim.draw(vec3(0),size.x,3);
			stop_matrix();
		}  else if (this.get_type() == SQUARE_ROPE) {
			if(prim == null) prim = new Primitive();
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			prim.draw(vec3(0),size.x,4);
			stop_matrix();
		} else if (this.get_type() == PENTAGON_ROPE) {
			if(prim == null) prim = new Primitive();
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			prim.draw(vec3(0),size.x,5);
			stop_matrix();
		} else if (this.get_type() == HEXAGON_ROPE) {
			if(prim == null) prim = new Primitive();
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			prim.draw(vec3(0),size.x,6);
			stop_matrix() ;
		} else if (this.get_type() == HEPTAGON_ROPE) {
			if(prim == null) prim = new Primitive();
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			prim.draw(vec3(0),size.x,7);
			stop_matrix();
		} else if (this.get_type() == OCTOGON_ROPE) {
			if(prim == null) prim = new Primitive();
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			prim.draw(vec3(0),size.x,8);
			stop_matrix();
		} else if (this.get_type() == NONAGON_ROPE) {
			if(prim == null) prim = new Primitive();
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			prim.draw(vec3(0),size.x,9);
			stop_matrix();
		} else if (this.get_type() == DECAGON_ROPE) {
			if(prim == null) prim = new Primitive();
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			prim.draw(vec3(0),size.x,10);
			stop_matrix();
		} else if (this.get_type() == HENDECAGON_ROPE) {
			if(prim == null) prim = new Primitive();
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			prim.draw(vec3(0),size.x,11);
			stop_matrix();
		} else if (this.get_type() == DODECAGON_ROPE) {
			if(prim == null) prim = new Primitive();
			start_matrix();
			translate(pos);
			rotate_behavior(rot) ;
			prim.draw(vec3(0),size.x,12);
			stop_matrix();
		}

		else if (this.get_type() == CROSS_RECT_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			cross_rect(ivec2(0),(int)size.y,(int)size.x);
			stop_matrix() ;
		} else if (this.get_type() == CROSS_BOX_2_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			//cross_box_2(vec2(size.x, size.y),ratio_size);
			cross_box_2(vec2(size.x, size.y));
			stop_matrix() ;
		} else if (this.get_type() == CROSS_BOX_3_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			//cross_box_3(size,ratio_size);
			cross_box_3(size);
			stop_matrix();
		}



	  else if(this.get_type() == TEXT_ROPE) {
	  	start_matrix();
	  	translate(pos);
	  	rotate_behavior(rot);
	  	textSize(size.x);
	  	if(costume_text_rope != null) {
	  		text(costume_text_rope,0,0);
	  	} else {
	  		costume_text_rope = "ROPE";
	  		text(costume_text_rope,0,0);
	  	}
	  	stop_matrix();
	  }

		else if (this.get_type() == SPHERE_LOW_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			sphereDetail(5);
			sphere(size.x);
			stop_matrix();
		} else if (this.get_type() == SPHERE_MEDIUM_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			sphereDetail(12);
			sphere(size.x);
			stop_matrix();
		} else if (this.get_type() == SPHERE_HIGH_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			sphere(size.x);
			stop_matrix();
		} else if (this.get_type() == TETRAHEDRON_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			polyhedron("TETRAHEDRON","VERTEX",(int)size.x);
			stop_matrix();
		} else if (this.get_type() == BOX_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			box(size);
			stop_matrix();
		}


		else if (this.get_type() == STAR_ROPE) {
			float [] ratio = {.38f};
			start_matrix();
			translate(pos);
			rotate_behavior(rot);

			star_3D_is(false);
			star(vec3(),size);
			stop_matrix();
		} else if (this.get_type() == STAR_3D_ROPE) {
			float [] ratio = {.38f};
			start_matrix();
			translate(pos);
			rotate_behavior(rot);

			star_3D_is(true);
			star(vec3(),size);
			stop_matrix();
		} 


		else if (this.get_type() == TETRAHEDRON_LINE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			polyhedron("TETRAHEDRON","LINE",(int)size.x);
			stop_matrix();
		} else if (this.get_type() == CUBE_LINE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			polyhedron("CUBE","LINE",(int)size.x);
			stop_matrix();
		} else if (this.get_type() == OCTOHEDRON_LINE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			polyhedron("OCTOHEDRON","LINE",(int)size.x);
			stop_matrix();
		} else if (this.get_type() == RHOMBIC_COSI_DODECAHEDRON_SMALL_LINE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			polyhedron("RHOMBIC COSI DODECAHEDRON SMALL","LINE",(int)size.x);
			stop_matrix();
		} else if (this.get_type() == ICOSI_DODECAHEDRON_LINE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			polyhedron("ICOSI DODECAHEDRON","LINE",(int)size.x);
			stop_matrix();
		}

		else if(this.get_type() == HOUSE_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			house(size);
			stop_matrix();
		}


	  else if(this.get_type() == VIRUS_ROPE) {
			start_matrix();
			translate(pos);
			rotate_behavior(rot);
			virus(vec3(),size,0,-1);
			stop_matrix();
		}



		else if(this.get_type() < 0) {
			start_matrix() ;
			translate(pos) ;
			rotate_behavior(rot) ;
			for(int i = 0 ; i < costume_pic_list.size() ; i++) {
				Costume_pic p = costume_pic_list.get(i);
				if(p.ID == this.get_type()) {
					if(p.type == 1) {
						PImage img_temp = p.img.copy();
						if(size.x == size.y ) {
							img_temp.resize((int)size.x, 0);
						} else if (size.x != size.y) {
							img_temp.resize((int)size.x, (int)size.y);
						}
						image(img_temp,0,0);
						break ;
					} else if(p.type == 2) {
						vec2 scale = vec2(1) ;
						if(size.x == size.y) {
	            scale = vec2(size.x / p.svg.width(), size.x / p.svg.width());
						} else {
							scale = vec2(size.x / p.svg.width(), size.y / p.svg.height());
						}
						
						p.svg.scaling(scale) ;
						p.svg.draw() ;
						break ;
					}		
				}
			}
			stop_matrix() ;
		}

	  // reset variable can be change the other costume, if the effect is don't use.
		ratio_costume_size = 1;
	}
}
































/**
Costume method
* Copyleft (c) 2014-2019
v 1.7.2
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope_method
*/
final int POINT_ROPE = 1;
final int ELLIPSE_ROPE = 2;
final int RECT_ROPE = 3;
final int LINE_ROPE = 4;

final int TRIANGLE_ROPE = 13;
final int SQUARE_ROPE = 14;
final int PENTAGON_ROPE = 15;
final int HEXAGON_ROPE = 16;
final int HEPTAGON_ROPE = 17;
final int OCTOGON_ROPE = 18;
final int NONAGON_ROPE = 19;
final int DECAGON_ROPE = 20;
final int HENDECAGON_ROPE = 21;
final int DODECAGON_ROPE = 22;

final int TEXT_ROPE = 26;

final int CROSS_RECT_ROPE = 52;
final int CROSS_BOX_2_ROPE = 53;
final int CROSS_BOX_3_ROPE = 54;

final int SPHERE_LOW_ROPE = 100;
final int SPHERE_MEDIUM_ROPE = 101;
final int SPHERE_HIGH_ROPE = 102;
final int TETRAHEDRON_ROPE = 103;
final int BOX_ROPE = 104;

final int PIXEL_ROPE = 800;

final int STAR_ROPE = 805;
final int STAR_3D_ROPE = 806;

final int TETRAHEDRON_LINE_ROPE = 1001;
final int CUBE_LINE_ROPE = 1002;
final int OCTOHEDRON_LINE_ROPE = 1003;
final int RHOMBIC_COSI_DODECAHEDRON_SMALL_LINE_ROPE = 1004;
final int ICOSI_DODECAHEDRON_LINE_ROPE = 1005;

final int HOUSE_ROPE = 2000;

final int VIRUS_ROPE = 88_888_888;



/**
SHOW
*/
/**
Costume selection in shape catalogue
*/
public void costume(float x, float y, float sx, float sy, Object data) {
	costume(vec2(x,y),vec2(sx,sy),data);
}

public void costume(float x, float y, float z, float sx, float sy, Object data) {
	costume(vec3(x,y,z),vec2(sx,sy),data);
}

public void costume(float x, float y, float z, float sx, float sy, float sz, Object data) {
	costume(vec3(x,y,z),vec3(sx,sy,sz),data);
}


public void costume(vec pos, int size_int, Object data) {
	int which_costume = 0;
	String sentence = null;
	if(data instanceof Costume) {
		which_costume = ((Costume)data).get_type();
	} else if(data instanceof Integer) {
		which_costume = (int)data;
	} else if(data instanceof String) {
		sentence = (String)data;
		which_costume = MAX_INT;
	}

	// int which_costume = cast_data(costume_obj);
	vec3 rotation = vec3();
	vec3 size = vec3(size_int);
	if(sentence == null) {
		costume(pos,size,rotation,which_costume,null);
	} else {
		costume(pos,size,rotation,which_costume,sentence);
	}
}

public void costume(vec pos, vec size, Object data) {
	int which_costume = 0;
	String sentence = null;
	if(data instanceof Costume) {
		which_costume = ((Costume)data).get_type();
	} else if(data instanceof Integer) {
		which_costume = (int)data;
	} else if(data instanceof String) {
		sentence = (String)data;
		which_costume = MAX_INT;
	}

	vec3 rotation = vec3() ;
	if(sentence == null) {
		costume(pos,size,rotation,which_costume,null);
	} else {
		costume(pos,size,rotation,which_costume,sentence);
	}
}

public void costume(vec pos, vec size, float rotation, Object data) {
	int which_costume = 0;
	String sentence = null;
	if(data instanceof Costume) {
		which_costume = ((Costume)data).get_type();
	} else if(data instanceof Integer) {
		which_costume = (int)data;
	} else if(data instanceof String) {
		sentence = (String)data;
		which_costume = MAX_INT;
	}

	if(sentence == null) {
		costume(pos, size, vec3(0,0,rotation),which_costume,null);
	} else {
		costume(pos,size,vec3(0,0,rotation),which_costume,sentence);
	}
}

public void costume(vec pos, vec size, vec rotation, Object data) {
	int which_costume = 0;
	String sentence = null;
	if(data instanceof Costume) {
		which_costume = ((Costume)data).get_type();
	} else if(data instanceof Integer) {
		which_costume = (int)data;
	} else if(data instanceof String) {
		sentence = (String)data;
		which_costume = MAX_INT;
	}

	if(sentence == null) {
		costume(pos,size,rotation,which_costume);
	} else {
		costume(pos,size,rotation,which_costume,sentence);
	}
}


/**
managing costume rope method
*/
public void costume(vec pos, vec size, vec rotation, int which_costume, String sentence) {
  vec3 pos_final = vec3(0) ;
  vec3 size_final = vec3(1) ;
	if((pos instanceof vec2 || pos instanceof vec3) 
			&& (size instanceof vec2 || size instanceof vec3)
			&& (rotation instanceof vec2 || rotation instanceof vec3)) {
		// pos
		if(pos instanceof vec2) {
			vec2 temp_pos = (vec2)pos;
			pos_final.set(temp_pos.x, temp_pos.y, 0);
		} else if(pos instanceof vec3) {
			vec3 temp_pos = (vec3)pos;
			pos_final.set(temp_pos);
		}
		//size
		if(size instanceof vec2) {
			vec2 temp_size = (vec2)size;
			size_final.set(temp_size.x, temp_size.y, 1);
		} else if(size instanceof vec3) {
			vec3 temp_size = (vec3)size;
			size_final.set(temp_size);
		}
		//send
		if(sentence == null ) {
			costume(pos_final,size_final,rotation,which_costume);
		} else {
			costume(pos_final,size_final,rotation,sentence);
		}		
	} else {
		printErrTempo(180,"vec pos or vec size if not an instanceof vec2 or vec3, it's not possible to process costume_rope()");
	}
}

/**
MAIN METHOD 
String COSTUME
v 0.1.1
Change the method for method with 
case and which_costume
and 
break
*/
public void costume(vec3 pos, vec3 size, vec rot, String sentence) {
	if(rot.x != 0) costume_rotate_x();
	if(rot.y != 0) costume_rotate_y();
	if(rot.z != 0) costume_rotate_z();

	start_matrix();
	translate(pos);
	rotate_behavior(rot);
  text(sentence,0,0);
	stop_matrix();
}

/**
method to pass costume to class costume
*/
Costume costume_rope_buffer;
public void costume(vec3 pos, vec3 size, vec rot, int which_costume) {
	if(costume_rope_buffer == null) {
		costume_rope_buffer = new Costume(which_costume);
	}
	// Costume costume = new Costume(which_costume);
	costume_rope_buffer.draw(pos,size,rot);
}

public void costume(vec3 pos, vec3 size, vec rot, Costume costume) {
	costume.draw(pos,size,rot);
}





















































/**
ASPECT ROPE 2016-2018
v 0.1.3
*/
public void aspect_is(boolean fill_is, boolean stroke_is) {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_rope.aspect_is(fill_is,stroke_is);
	fill_rope_is = aspect_rope.fill_is();
	stroke_rope_is = aspect_rope.stroke_is();
}

public void init_bool_aspect() {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_rope.aspect_is(true,true);
}

public void aspect(int fill, int stroke, float thickness) {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is());
	aspect_rope.aspect(fill,stroke,thickness);
}

public void aspect(int fill, int stroke, float thickness, Costume costume) {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is());
	aspect_rope.aspect(fill,stroke,thickness,costume.get_type());
}

public void aspect(int fill, int stroke, float thickness, int costume) {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is());
	aspect_rope.aspect(fill,stroke,thickness,costume);
}

public void aspect(vec fill, vec stroke, float thickness) {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is());
	aspect_rope.aspect(fill,stroke,thickness);
}

public void aspect(vec fill, vec stroke, float thickness, Costume costume) {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is());
	aspect_rope.aspect(fill,stroke,thickness,costume.get_type());
}


public void aspect(vec fill, vec stroke, float thickness, int costume) {
	if(aspect_rope == null) aspect_rope = new Costume();
	aspect_is(aspect_rope.fill_is(),aspect_rope.stroke_is());
	aspect_rope.aspect(fill,stroke,thickness,costume);
}







public int get_fill_rope() {
	if(aspect_rope != null) {
		return aspect_rope.get_fill();
	} else {
		return color(g.colorModeX);
	}
}

public int get_stroke_rope() {
	if(aspect_rope != null) {
		return aspect_rope.get_stroke();
	} else {
		return color(0);
	}
}

public float get_thickness_rope() {
	if(aspect_rope != null) {
		return aspect_rope.get_thickness();
	} else {
		return 1.f;
	}
}













































/**
COSTUME
v 0.0.1
*/
/**
simple text 
v 0.0.1
*/
public void costume_text(String s) {
	costume_text_rope = s ;
}


/**
rotate behavior
v 0.1.0
*/
boolean costume_rot_x;
boolean costume_rot_y;
boolean costume_rot_z;

public void costume_rotate_x() {
	costume_rot_x = true;
}

public void costume_rotate_y() {
	costume_rot_y = true;
}

public void costume_rotate_z() {
	costume_rot_z = true;
}

public void rotate_behavior(vec rotate) {
	if(costume_rot_x && rotate.x != 0) {
		rotateX(rotate.x);
		costume_rot_x = false;
	}
	if(costume_rot_y && rotate.y != 0) {
		rotateY(rotate.y);
		costume_rot_y = false;
	}
	if(costume_rot_z && rotate.z != 0) {
		rotateZ(rotate.z);
		costume_rot_z = false;
	}
}


/**
ratio size costume
*/
float ratio_costume_size = 1;
public void set_ratio_costume_size(float ratio) {
	ratio_costume_size = ratio;
}




























/**
add pic 
v 0.0.1
*/
ArrayList <Costume_pic> costume_pic_list = new ArrayList<Costume_pic>() ;

public void load_costume_pic(String path) {
	if(path.endsWith("png") || path.endsWith("PNG") || path.endsWith("svg") || path.endsWith("SVG")) {
		int new_ID = costume_pic_list.size() * (-1) ;
		new_ID -= 1 ;
		Costume_pic c = new Costume_pic(this, path, new_ID) ;
		costume_pic_list.add(c) ; ;
		println("ID pic:", new_ID) ;
	}
}














































/**
house method
*/
House house_costume_rope;
public void house(vec3 size) {
	if(house_costume_rope != null) {
		house_costume_rope.set_size(size);
		house_costume_rope.show();
	} else {
		house_costume_rope = new House();
	}
}









































/**
ANNEXE COSTUME
SHAPE CATALOGUE
*/
/**
STAR
*/
Star star_costume_rope;
public void star_3D_is(boolean is_3D) {
	if(star_costume_rope != null) {
		star_costume_rope.is_3D(is_3D);
	} else {
		star_costume_rope = new Star();
	}
}


public void star_summits(int summits) {
	if(star_costume_rope != null) {
		star_costume_rope.set_summits(summits);
	} else {
		star_costume_rope = new Star();
	}
}

public void star_angle(float angle) {
	if(star_costume_rope != null) {
		star_costume_rope.set_angle(angle);
	} else {
		star_costume_rope = new Star();
	}
}

public void star_ratio(float... ratio) {
	if(star_costume_rope != null) {
		star_costume_rope.set_ratio(ratio);
	} else {
		star_costume_rope = new Star();
	}
}


public void star(vec position, vec size) {
	if(star_costume_rope != null) {
		star_costume_rope.show(position,size);
	} else {
		star_costume_rope = new Star();
	}
}






 






















/**
CROSS
*/
public void cross_rect(ivec2 pos, int thickness, int radius) {
	float h = radius;
	float w = thickness/3;

  // verticale one
	vec2 size = vec2(w,h);
	vec2 pos_temp = vec2(pos.x, pos.y -floor(size.y/2) +(w/2));
	pos_temp.sub(w/2);
	rect(pos_temp,size);
	
	// horizontal one
	size.set(h,w);
	pos_temp.set(pos.x-floor(size.x/2) +(w/2),pos.y);
	pos_temp.sub(w/2);
	rect(pos_temp,size);
}

public void cross_box_2(vec2 size) {
	float scale_cross = size.sum() *.5f;
	float small_part = scale_cross *ratio_costume_size *.3f;

	box(size.x,small_part,small_part);
	box(small_part,size.y,small_part);
}

public void cross_box_3(vec3 size) {
	float scale_cross = size.sum() *.3f;
	float small_part = scale_cross *ratio_costume_size *.3f;
   
	box(size.x,small_part,small_part);
	box(small_part,size.y,small_part);
	box(small_part,small_part,size.z);
}
















/**
VIRUS
2015-2018
v 0.2.0
*/
public void virus(vec pos, vec size) {
	int close = -1 ;
	float angle = 0 ;
	virus(pos,size,angle,close) ;
}

public void virus(vec pos, vec size, float angle) {
	int close = -1;
	virus(pos,size,angle,close);
}


// main method
Virus virus_costume_rope;
boolean make_virus = true ;
public void virus(vec pos, vec size, float angle, int close) {
	if(make_virus) {
		virus_costume_rope = new Virus() ;
		make_virus = false ;
	}

	if(virus_costume_rope.get_mutation() > 0 && frameCount%virus_costume_rope.get_mutation() == 0) {
		virus_costume_rope.reset() ;
	}
  virus_costume_rope.rotation(angle) ;
	virus_costume_rope.set_pos(pos) ;
	virus_costume_rope.set_size(size) ;
	virus_costume_rope.show(close) ;	
}

public void virus_mutation(int mutation) {
	if(virus_costume_rope != null && mutation != 0 && mutation != virus_costume_rope.get_mutation()) {
		virus_costume_rope.set_mutation(abs(mutation));
	}
}

public void virus_num(int num) {
	if(virus_costume_rope != null && num != 0 && num != virus_costume_rope.get_num()) {
		virus_costume_rope.set_num(abs(num));
	}
}

public void virus_node(int node) {
	if(virus_costume_rope != null && node != 0 && node != virus_costume_rope.get_node()) {
		virus_costume_rope.set_node(abs(node));
	}
}




























/**
COSTUME INFO
*/
// get costume
public int get_costume(int target) {
	costume_list() ;
	if(target >= 0 && target < costume_dict.size()) {
		return costume_dict.get(target).get(0) ;
	} else {
		System.err.println("Your target is out from the list") ;
		return 0 ;
	}
}

// return size of the arrayList costume
public int costumes_size() {
	costume_list() ;
	return costume_dict.size() ;
}




Info_int_dict costume_dict = new Info_int_dict();
boolean list_costume_is_built = false ;
int ref_size_pic = -1 ;
Costume aspect_rope;
String costume_text_rope = null;
boolean fill_rope_is = true;
boolean stroke_rope_is = true;
public void costume_list() {
	if(!list_costume_is_built) {
		/* 
		* add(name, code, renderer, type)
		* code: int constante to access directly
		* render: 2 = 2D ; 3 = 3D ;
		* type : 0 = shape ; 1 = bitmap ; 2 = svg  ; 3 = shape with just stroke component ; 4 = text
		*/
		costume_dict.add("NULL",r.NULL,0,0);

		costume_dict.add("PIXEL_ROPE",PIXEL_ROPE,2,1);

		costume_dict.add("POINT_ROPE",POINT_ROPE,2,0);
		costume_dict.add("ELLIPSE_ROPE",ELLIPSE_ROPE,2,0);
		costume_dict.add("RECT_ROPE",RECT_ROPE,2,0);
		costume_dict.add("LINE_ROPE",LINE_ROPE,2,0);

		costume_dict.add("TRIANGLE_ROPE",TRIANGLE_ROPE,2,0);
		costume_dict.add("SQUARE_ROPE",SQUARE_ROPE,2,0);
		costume_dict.add("PENTAGON_ROPE",PENTAGON_ROPE,2,0);
		costume_dict.add("HEXAGON_ROPE",HEXAGON_ROPE,2,0);
		costume_dict.add("HEPTAGON_ROPE",HEPTAGON_ROPE,2,0);
		costume_dict.add("OCTOGON_ROPE",OCTOGON_ROPE,2,0);
		costume_dict.add("NONAGON_ROPE",NONAGON_ROPE,2,0);
		costume_dict.add("DECAGON_ROPE",DECAGON_ROPE,2,0);
		costume_dict.add("HENDECAGON_ROPE",HENDECAGON_ROPE,2,0);
		costume_dict.add("DODECAGON_ROPE",DODECAGON_ROPE,2,0);

		costume_dict.add("TEXT_ROPE",TEXT_ROPE,2,4);
    
    costume_dict.add("CROSS_RECT_ROPE",CROSS_RECT_ROPE,2,0);
		costume_dict.add("CROSS_BOX_2_ROPE",CROSS_BOX_2_ROPE,3,0);
		costume_dict.add("CROSS_BOX_3_ROPE",CROSS_BOX_3_ROPE,3,0);

		costume_dict.add("SPHERE_LOW_ROPE",SPHERE_LOW_ROPE,3,0);
		costume_dict.add("SPHERE_MEDIUM_ROPE",SPHERE_MEDIUM_ROPE,3,0);
		costume_dict.add("SPHERE_HIGH_ROPE",SPHERE_HIGH_ROPE,3,0);
		costume_dict.add("TETRAHEDRON_ROPE",TETRAHEDRON_ROPE,3,0);
		costume_dict.add("BOX_ROPE",BOX_ROPE,3,0);

		costume_dict.add("SPHERE_LOW_ROPE",SPHERE_LOW_ROPE,3,0);
		costume_dict.add("SPHERE_MEDIUM_ROPE",SPHERE_MEDIUM_ROPE,3,0);
		costume_dict.add("SPHERE_HIGH_ROPE",SPHERE_HIGH_ROPE,3,0);
		costume_dict.add("TETRAHEDRON_ROPE",TETRAHEDRON_ROPE,3,0);
		costume_dict.add("BOX_ROPE",BOX_ROPE,3,0);

		costume_dict.add("STAR_ROPE",STAR_ROPE,2,3);
		costume_dict.add("STAR_3D_ROPE",STAR_3D_ROPE,2,3);

		costume_dict.add("HOUSE_ROPE",HOUSE_ROPE,3,0);

		costume_dict.add("VIRUS_ROPE",VIRUS_ROPE,3,0);

		list_costume_is_built = true ;
	}

  // add costume from your SVG or PNG
	if(ref_size_pic != costume_pic_list.size()) {
		for(Costume_pic c : costume_pic_list) {
			costume_dict.add(c.name, c.ID, 3, c.type) ;
		}
		ref_size_pic = costume_pic_list.size() ;
	}
}


// print list costume
public void print_list_costume() {
	if(!list_costume_is_built) {
		costume_list() ;
	}
  println("Costume have " + costume_dict.size() + " costumes.") ;
	if(list_costume_is_built) {
		for(int i = 0 ; i < costume_dict.size() ; i++) {
			String type = "" ;
			if(costume_dict.get(i).get(2) == 0 ) type = "shape" ;
			else if(costume_dict.get(i).get(2) == 1 ) type = "bitmap" ;
			else if(costume_dict.get(i).get(2) == 2 ) type = "scalable vector graphics" ;
			else if(costume_dict.get(i).get(2) == 3 ) type = "shape with no fill component" ;
			println("[ Rank:", i, "][ ID:",costume_dict.get(i).get(0), "][ Name:", costume_dict.get(i).get_name(), "][ Renderer:", costume_dict.get(i).get(1)+"D ][ Picture:", type, "]") ;
		}
	}
}
























/**
ROPE GLSL METHOD
v 0.0.6
* Copyleft (c) 2019-2019
* Stan le Punk > http://stanlepunk.xyz/
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope_method
*/

/**
transcription of few common glsl method

/**
mix
*/
public float mix(float x, float y, float a) {
  return x*(1-a)+y*a;
}

public vec2 mix(vec2 x, vec2 y, vec2 a) {
  return vec2(mix(x.x,y.x,a.x),mix(x.y,y.y,a.y));
}

public vec3 mix(vec3 x, vec3 y, vec3 a) {
  return vec3(mix(x.x,y.x,a.x),mix(x.y,y.y,a.y),mix(x.z,y.z,a.z));
}

public vec4 mix(vec4 x, vec4 y, vec4 a) {
  return vec4(mix(x.x,y.x,a.x),mix(x.y,y.y,a.y),mix(x.z,y.z,a.z),mix(x.w,y.w,a.w));
}

/**
fract
*/
public float fract(float x) {
  return x - floor(x);
}

public vec2 fract(vec2 v) {
  return vec2(fract(v.x),fract(v.y));
}

public vec3 fract(vec3 v) {
  return vec3(fract(v.x),fract(v.y),fract(v.z));
}

public vec4 fract(vec4 v) {
  return vec4(fract(v.x),fract(v.y),fract(v.z),fract(v.w));
}

/**
sign
*/
public float sign(float x) {
  if(x < 0 ) {
    return -1.f;
  } else if(x > 0) {
    return 1.f ;
  } else return 0.0f;
}

public vec2 sign(vec2 x) {
  return vec2(sign(x.x),sign(x.y));
}

public vec3 sign(vec3 x) {
  return vec3(sign(x.x),sign(x.y),sign(x.z));
}

public vec4 sign(vec4 x) {
  return vec4(sign(x.x),sign(x.y),sign(x.z),sign(x.w));
}


public int sign(int x) {
  return PApplet.parseInt(sign(PApplet.parseFloat(x)));
}

public ivec2 sign(ivec2 x) {
  return ivec2(sign(x.x),sign(x.y));
}

public ivec3 sign(ivec3 x) {
  return ivec3(sign(x.x),sign(x.y),sign(x.z));
}

public ivec4 sign(ivec4 x) {
  return ivec4(sign(x.x),sign(x.y),sign(x.z),sign(x.w));
}


/**
step
*/
public float step(float edge, float x) {
  if(x < edge) return 0; else return 1;
}

public vec2 step(vec2 edge, vec2 x) {
  return vec2(step(edge.x,x.x),step(edge.y,x.y));
}

public vec3 step(vec3 edge, vec3 x) {
  return vec3(step(edge.x,x.x),step(edge.y,x.y),step(edge.z,x.z));
}

public vec4 step(vec4 edge, vec4 x) {
  return vec4(step(edge.x,x.x),step(edge.y,x.y),step(edge.z,x.z),step(edge.w,x.w));
}


/**
smoothstep
*/
public float smoothstep(float edge0, float edge1, float x) {
  if(x <= edge0) {
    return 0; 
  } else if(x >= edge1) {
    return 1;
  } else {
    float t = clamp((x-edge0)/(edge1-edge0),0.f,1.f);
    return t*t*(3.f-2.f*t);
  }
}

public vec2 smoothstep(vec2 edge0, vec2 edge1, vec2 x) {
  return vec2(smoothstep(edge0.x,edge1.x,x.x),smoothstep(edge0.y,edge1.y,x.y));
}

public vec3 smoothstep(vec3 edge0, vec3 edge1, vec3 x) {
  return vec3(smoothstep(edge0.x,edge1.x,x.x),smoothstep(edge0.y,edge1.y,x.y),smoothstep(edge0.z,edge1.z,x.z));
}

public vec4 smoothstep(vec4 edge0, vec4 edge1, vec4 x) {
  return vec4(smoothstep(edge0.x,edge1.x,x.x),smoothstep(edge0.y,edge1.y,x.y),smoothstep(edge0.z,edge1.z,x.z),smoothstep(edge0.w,edge1.w,x.w));
}



/*
mod
*/
public float mod(float x, float y) {
  return x-y*floor(x/y);
}

public vec2 mod(vec2 x, vec2 y) {
  return vec2(mod(x.x,y.x),mod(x.y,y.y));
}

public vec3 mod(vec3 x, vec3 y) {
  return vec3(mod(x.x,y.x),mod(x.y,y.y),mod(x.z,y.z));
}

public vec4 mod(vec4 x, vec4 y) {
  return vec4(mod(x.x,y.x),mod(x.y,y.y),mod(x.z,y.z),mod(x.w,y.w));
}

public ivec2 mod(ivec2 x, ivec2 y) {
  return ivec2(mod(x.x,y.x),mod(x.y,y.y));
}

public ivec3 mod(ivec3 x, ivec3 y) {
  return ivec3(mod(x.x,y.x),mod(x.y,y.y),mod(x.z,y.z));
}

public ivec4 mod(ivec4 x, ivec4 y) {
  return ivec4(mod(x.x,y.x),mod(x.y,y.y),mod(x.z,y.z),mod(x.w,y.w));
}

/**
clamp
*/
public float clamp(float x, float min, float max) {
  return min(max(x,min),max);
}

public vec2 clamp(vec2 x, vec2 min, vec2 max) {
  return min(max(x,min),max);
}

public vec3 clamp(vec3 x, vec3 min, vec3 max) {
  return min(max(x,min),max);
}

public vec4 clamp(vec4 x, vec4 min, vec4 max) {
  return min(max(x,min),max);
}




/**
equal
*/
public boolean equal(float x, float y) {
  return x==y?true:false;
}

public boolean equal(int x, int y) {
  return equal((float)x,(float)y);
}

// with vec
public bvec2 equal(vec2 x, vec2 y) {
  if(x != null && y != null) {
    return bvec2(equal(x.x,y.x),equal(x.y,y.y));
  } else return null;
}

public bvec3 equal(vec3 x, vec3 y) {
  if(x != null && y != null) {
    return bvec3(equal(x.x,y.x),equal(x.y,y.y),equal(x.z,y.z));
  } else return null;
}

public bvec4 equal(vec4 x, vec4 y) {
  if(x != null && y != null) {
    return bvec4(equal(x.x,y.x),equal(x.y,y.y),equal(x.z,y.z),equal(x.w,y.w));
  } else return null;
}

// width ivec
public bvec2 equal(ivec2 x, ivec2 y) {
  if(x != null && y != null) {
    return bvec2(equal(x.x,y.x),equal(x.y,y.y));
  } else return null;
}

public bvec3 equal(ivec3 x, ivec3 y) {
  if(x != null && y != null) {
    return bvec3(equal(x.x,y.x),equal(x.y,y.y),equal(x.z,y.z));
  } else return null;
}

public bvec4 equal(ivec4 x, ivec4 y) {
  if(x != null && y != null) {
    return bvec4(equal(x.x,y.x),equal(x.y,y.y),equal(x.z,y.z),equal(x.w,y.w));
  } else return null;
}




/**
lessThan
*/
public boolean lessThan(float x, float y) {
  return x<y?true:false;
}

public boolean lessThan(int x, int y) {
  return lessThan((float)x,(float)y);
}

// with vec
public bvec2 lessThan(vec2 x, vec2 y) {
  if(x != null && y != null) {
    return bvec2(lessThan(x.x,y.x),lessThan(x.y,y.y));
  } else return null;
}

public bvec3 lessThan(vec3 x, vec3 y) {
  if(x != null && y != null) {
    return bvec3(lessThan(x.x,y.x),lessThan(x.y,y.y),lessThan(x.z,y.z));
  } else return null;
}

public bvec4 lessThan(vec4 x, vec4 y) {
  if(x != null && y != null) {
    return bvec4(lessThan(x.x,y.x),lessThan(x.y,y.y),lessThan(x.z,y.z),lessThan(x.w,y.w));
  } else return null;
}

// width ivec
public bvec2 lessThan(ivec2 x, ivec2 y) {
  if(x != null && y != null) {
    return bvec2(lessThan(x.x,y.x),lessThan(x.y,y.y));
  } else return null;
}

public bvec3 lessThan(ivec3 x, ivec3 y) {
  if(x != null && y != null) {
    return bvec3(lessThan(x.x,y.x),lessThan(x.y,y.y),lessThan(x.z,y.z));
  } else return null;
}

public bvec4 lessThan(ivec4 x, ivec4 y) {
  if(x != null && y != null) {
    return bvec4(lessThan(x.x,y.x),lessThan(x.y,y.y),lessThan(x.z,y.z),lessThan(x.w,y.w));
  } else return null;
}





/**
greaterThan
*/
public boolean greaterThan(float x, float y) {
  return x>y?true:false;
}

public boolean greaterThan(int x, int y) {
  return greaterThan((float)x,(float)y);
}

// with vec
public bvec2 greaterThan(vec2 x, vec2 y) {
  if(x != null && y != null) {
    return bvec2(greaterThan(x.x,y.x),greaterThan(x.y,y.y));
  } else return null; 
}

public bvec3 greaterThan(vec3 x, vec3 y) {
  if(x != null && y != null) {
    return bvec3(greaterThan(x.x,y.x),greaterThan(x.y,y.y),greaterThan(x.z,y.z));
  } else return null; 
}

public bvec4 greaterThan(vec4 x, vec4 y) {
  if(x != null && y != null) {
    return bvec4(greaterThan(x.x,y.x),greaterThan(x.y,y.y),greaterThan(x.z,y.z),greaterThan(x.w,y.w));
  } else return null; 
}

// width ivec
public bvec2 greaterThan(ivec2 x, ivec2 y) {
  if(x != null && y != null) {
    return bvec2(greaterThan(x.x,y.x),greaterThan(x.y,y.y));
  } else return null; 
}

public bvec3 greaterThan(ivec3 x, ivec3 y) {
  if(x != null && y != null) {
    return bvec3(greaterThan(x.x,y.x),greaterThan(x.y,y.y),greaterThan(x.z,y.z));
  } else return null; 
}

public bvec4 greaterThan(ivec4 x, ivec4 y) {
  if(x != null && y != null) {
    return bvec4(greaterThan(x.x,y.x),greaterThan(x.y,y.y),greaterThan(x.z,y.z),greaterThan(x.w,y.w));
  } else return null; 
}






/**
greaterThanEqual
*/
public boolean greaterThanEqual(float x, float y) {
  return x>=y?true:false;
}

public boolean greaterThanEqual(int x, int y) {
  return greaterThanEqual((float)x,(float)y);
}

// with vec
public bvec2 greaterThanEqual(vec2 x, vec2 y) {
  if(x != null && y != null) {
    return bvec2(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y));
  } else return null; 
}

public bvec3 greaterThanEqual(vec3 x, vec3 y) {
  if(x != null && y != null) {
    return bvec3(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y),greaterThanEqual(x.z,y.z));
  } else return null; 
}

public bvec4 greaterThanEqual(vec4 x, vec4 y) {
  if(x != null && y != null) {
    return bvec4(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y),greaterThanEqual(x.z,y.z),greaterThanEqual(x.w,y.w));
  } else return null; 
}

// width ivec
public bvec2 greaterThanEqual(ivec2 x, ivec2 y) {
  if(x != null && y != null) {
    return bvec2(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y));
  } else return null; 
}

public bvec3 greaterThanEqual(ivec3 x, ivec3 y) {
  if(x != null && y != null) {
    return bvec3(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y),greaterThanEqual(x.z,y.z));
  } else return null; 
}

public bvec4 greaterThanEqual(ivec4 x, ivec4 y) {
  if(x != null && y != null) {
    return bvec4(greaterThanEqual(x.x,y.x),greaterThanEqual(x.y,y.y),greaterThanEqual(x.z,y.z),greaterThanEqual(x.w,y.w));
  } else return null; 
}






/**
lessThanEqual
*/
public boolean lessThanEqual(float x, float y) {
  return x<=y?true:false;
}

public boolean lessThanEqual(int x, int y) {
  return lessThanEqual((float)x,(float)y);
}

// with vec
public bvec2 lessThanEqual(vec2 x, vec2 y) {
  if(x != null && y != null) {
    return bvec2(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y));
  } else return null; 
}

public bvec3 lessThanEqual(vec3 x, vec3 y) {
  if(x != null && y != null) {
    return bvec3(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y),lessThanEqual(x.z,y.z));
  } else return null; 
}

public bvec4 lessThanEqual(vec4 x, vec4 y) {
  if(x != null && y != null) {
    return bvec4(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y),lessThanEqual(x.z,y.z),lessThanEqual(x.w,y.w));
  } else return null; 
}

// width ivec
public bvec2 lessThanEqual(ivec2 x, ivec2 y) {
  if(x != null && y != null) {
    return bvec2(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y));
  } else return null; 
}

public bvec3 lessThanEqual(ivec3 x, ivec3 y) {
  if(x != null && y != null) {
    return bvec3(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y),lessThanEqual(x.z,y.z));
  } else return null; 
}

public bvec4 lessThanEqual(ivec4 x, ivec4 y) {
  if(x != null && y != null) {
    return bvec4(lessThanEqual(x.x,y.x),lessThanEqual(x.y,y.y),lessThanEqual(x.z,y.z),lessThanEqual(x.w,y.w));
  } else return null; 
}







/**
all
v 0.0.2
*/
public boolean all(bvec2 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = true;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == false) {
        result = false;
        break;
      }
    }
    return result;
  } else {
    printErr("method all(bvec2 b) return false because argument is",b);
    return false;
  }
}

public boolean all(bvec3 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = true;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == false) {
        result = false;
        break;
      }
    }
    return result;
  } else {
    printErr("method all(bvec3 b) return false because argument is",b);
    return false;
  }
}

public boolean all(bvec4 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = true;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == false) {
        result = false;
        break;
      }
    }
    return result;
  } else {
    printErr("method all(bvec4 b) return false because argument is",b);
    return false;
  }
}

public boolean all(bvec5 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = true;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == false) {
        result = false;
        break;
      }
    }
    return result;
  } else {
    printErr("method all(bvec5 b) return false because argument is",b);
    return false;
  }
}

public boolean all(bvec6 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = true;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == false) {
        result = false;
        break;
      }
    }
    return result;
  } else {
    printErr("method all(bvec6 b) return false because argument is",b);
    return false;
  }
}




/**
any
*/
public boolean any(bvec2 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = false;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == true) {
        result = true;
        break;
      }
    }
    return result;
  } else {
    printErr("method any() return false because argument is",b);
    return false;
  }
}

public boolean any(bvec3 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = false;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == true) {
        result = true;
        break;
      }
    }
    return result;
  } else {
    printErr("method any() return false because argument is",b);
    return false;
  }
}

public boolean any(bvec4 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = false;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == true) {
        result = true;
        break;
      }
    }
    return result;
  } else {
    printErr("method any() return false because argument is",b);
    return false;
  }
}

public boolean any(bvec5 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = false;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == true) {
        result = true;
        break;
      }
    }
    return result;
  } else {
    printErr("method any() return false because argument is",b);
    return false;
  }
}

public boolean any(bvec6 b) {
  if(b != null) {
    boolean [] list = b.array();
    boolean result = false;
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i] == true) {
        result = true;
        break;
      }
    }
    return result;
  } else {
    printErr("method any() return false because argument is",b);
    return false;
  }
}


/**
ROPE SVG
v 1.4.0
* Copyleft (c) 2014-2018
Rope – Romanesco Processing Environment – 
* @author Stan le Punk
* @see https://github.com/StanLepunK/SVG_Vertex-Processing
  2016-2018
*/

class ROPE_svg {
  PApplet p5  ;
  //
  PShape shape_SVG ;
  String path = "" ;
  String folder_brick_name = "brick" ;
  ArrayList<Brick_SVG> list_brick_SVG = new ArrayList<Brick_SVG>() ;
  String name = "" ;
  String header_svg = "" ;
  int ID_brick ;
  private String saved_path_bricks_svg = "" ;

  private boolean position_center = false ;
  
  private boolean bool_scale_translation ; 
  private boolean bool_pos, bool_jitter_svg, bool_scale_svg ;
  private boolean keep_change ;

  private boolean display_fill_original = true ;
  private boolean display_stroke_original = true ;
  private boolean display_thickness_original = true ;

  private boolean display_fill_custom = false ;
  private boolean display_stroke_custom = false ;
  private boolean display_thickness_custom = false ;

  private vec3 pos = vec3() ;
  private vec3 jitter_svg = vec3() ;
  private vec3 scale_svg = vec3() ;

  // Aspect default
  private String [] st ;
  private vec4 fill_custom = vec4(0,0,0,g.colorModeA) ;
  private vec4 stroke_custom = vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA) ;
  private float thickness_custom = 1 ;

  private vec4 fill_factor = vec4(1) ;
  private vec4 stroke_factor = vec4(1) ;






  /**  
  CONSTRUCTOR

  */
  ROPE_svg (PApplet p5, String path, String folder_brick_name) {
    this.p5 = p5 ;
    this.name = file_name(path) ;
    this.folder_brick_name = folder_brick_name ;
    this.path = path ;
    saved_path_bricks_svg = "RPE_SVG/" + folder_brick_name + "/" ;
  }

  ROPE_svg (PApplet p5, String path) {
    this.p5 = p5 ;
    this.name = file_name(path) ;
    this.path = path ;
    saved_path_bricks_svg = "RPE_SVG/" + folder_brick_name + "/" ;
  }



  

  
  








  /**
  PUBLIC METHOD

  */
  public void build(String path_import, String path_brick) {
    list_brick_SVG.clear() ;
    list_ellipse_SVG.clear() ;
    list_rectangle_SVG.clear() ;
    list_vertice_SVG.clear() ;

    shape_SVG = loadShape(path_import) ;

    XML svg_info = loadXML(path_import) ;
    analyze_SVG(svg_info) ;
    save_brick_SVG() ;
    build_SVG(list_brick_SVG, path_brick) ;

  }

  public void build() {
    build(path, saved_path_bricks_svg) ;
  } 






  
  /**
  METHOD to draw all the SVG
  */
  public void draw() {
    reset() ;
    draw_SVG (pos, scale_svg, jitter_svg) ;
    change_boolean_to_false() ;
  }
  
  public void draw(int ID) {
    reset() ;
    draw_SVG (pos, scale_svg, jitter_svg, ID) ;
    change_boolean_to_false() ;
  }


  public void draw(String layer_or_group_name) {
    reset() ;
    vec3 new_pos = pos.copy() ;
    if(bool_scale_translation) {
      start_matrix() ;
      vec3 translation = vec3() ;
      translation = scale_translation(scale_svg, layer_or_group_name); 
      translate(translation) ;
    }
    draw_SVG (pos, scale_svg, jitter_svg, layer_or_group_name) ;

    if(bool_scale_translation) stop_matrix() ;

    change_boolean_to_false() ;
  }


  private vec3 scale_translation(vec3 scale_svg, String layer_name) {
    vec3 translation = vec3() ;

    int num = 0 ;
    vec3 correction = vec3() ;
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      if( b.family_name.contains(layer_name)) {
        // catch position before the scaling
        for(int k = 0 ; k < list_svg_vec(b.ID).length ; k++) {
          num++ ;
          // special translate for the shape kind rect, because this one move from the corner
          if(b.kind == "rect") {
             float width_rect = b.xml_brick.getChild(0).getFloat("width") ;
             float height_rect = b.xml_brick.getChild(0).getFloat("height") ;
             correction.set(width_rect *.5f, height_rect *.5f, 0) ;
           }
        }
      }
    }

    vec3 [] list_raw = new vec3[num] ;
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      if( b.family_name.contains(layer_name)) {
        // catch position before the scaling
        for(int k = 0 ; k < list_svg_vec(b.ID).length ; k++) {
          list_raw[k] = list_svg_vec(b.ID)[k].copy()  ;
        }
      }
    }

    // result
    vec3 barycenter = barycenter(list_raw) ;
    if(position_center) {
      vec3 center_pos = vec3(canvas().x,canvas().y, 0) ;
      center_pos.mult(.5f) ;
      barycenter.sub(center_pos) ;
    }
    if(!correction.equals(0)) barycenter.add(correction);
    vec3 barycenter_translated = mult(barycenter, scale_svg) ;
    translation = sub(barycenter, barycenter_translated) ;

    return translation ;
  }


  
  /**
  TEMPORARY CHANGE
  This change don't modify the original coord of point
  */

 /**
 POS
 */
  public void pos(float x) {
    bool_pos = true ;
    pos.set(x) ;
  }

  public void pos(float x, float y) {
    bool_pos = true ;
    pos.set(x,y,0) ;
  }

  public void pos(float x, float y, float z) {
    bool_pos = true ;
    pos.set(x,y,z) ;
  }

  public void pos(vec pos_raw) {
    bool_pos = true ;
    if(pos_raw instanceof vec2) {
      vec2 pos_2D = (vec2) pos_raw ;
      pos.set(pos_2D.x, pos_2D.y, 0) ;
    } else if (pos_raw instanceof vec3) {
      vec3 pos_3D = (vec3) pos_raw ;
      pos.set(pos_3D) ;
    }
  }

  /**
  SCALE
  */
  // scale_translation
  private void scaling(float x) {
    scaling(false, vec3(x,x,0)) ;
  }

  private void scaling(float x, float y) {
    scaling(false, vec3(x,y,0)) ;
  }

  private void scaling(float x, float y, float z) {
    scaling(false, vec3(x,y,z)) ;
  }

  private void scaling(vec scale_raw) {
    scaling(false, scale_raw) ;
  }

  private void scaling(boolean translation, float x) {
    scaling(translation, vec3(x,x,0)) ;
  }

  private void scaling(boolean translation, float x, float y) {
    scaling(translation, vec3(x,y,0)) ;
  }

  private void scaling(boolean translation, float x, float y, float z) {
    scaling(translation, vec3(x,y,z)) ;
  }

  private void scaling(boolean translation, vec scale_raw) {
    bool_scale_translation = translation ;
    bool_scale_svg = true ;
    if(scale_raw instanceof vec2) {
      vec2 scale = (vec2) scale_raw ;
      scale_svg.set(scale.x, scale.y, 1) ;
    } else if (scale_raw instanceof vec3) {
      vec3 scale = (vec3) scale_raw ;
      scale_svg.set(scale) ;
    }
  }



  /**
  JITEER 
  */
  public void jitter(float x) {
    bool_jitter_svg = true ;
    jitter_svg.set(x) ;
  }

  public void jitter(int x, int y) {
    bool_jitter_svg = true ;
    jitter_svg.set(x,y,0) ;
  }

  public void jitter(int x, int y, int z) {
    bool_jitter_svg = true ;
    jitter_svg.set(x,y,z) ;
  }

  public void jitter(vec jitter_raw) {
    bool_jitter_svg = true ;
    if(jitter_raw instanceof vec2) {
      vec2 jitter = (vec2) jitter_raw ;
      jitter_svg.set(jitter.x, jitter.y, 0) ;
    } else if (jitter_raw instanceof vec3) {
      vec3 jitter = (vec3) jitter_raw ;
      jitter_svg.set(jitter) ;
    }
  }

  
  
  
  /* 
  method start() & end() use in correlation with reset for the change like jitter, pos, scale...
  when the svg is using in split mode with name or ID param
  */
  public void start() {
    keep_change = true ;
  }
  public void stop() {
    keep_change = false ;
    reset() ;
  }


  /**
  ASPECT
  v 0.2.0
  */
  /**
  opacity
  */
  public void opacity(float a_fill, float a_stroke) {
    display_stroke_original = true ;
    display_stroke_custom = false ;
    display_fill_original = true ;
    display_fill_custom = false ;
    float normalize_alpha_fill = (a_fill / g.colorModeA) ;
    float normalize_alpha_stroke = (a_stroke / g.colorModeA) ;
    this.fill_factor(1, 1, 1, normalize_alpha_fill) ;
    this.stroke_factor(1, 1, 1, normalize_alpha_stroke) ;

  }

  public void opacityStroke(float a) {
    display_stroke_original = true ;
    display_stroke_custom = false ;
    float normalize_alpha = (a / g.colorModeA) ;
    this.stroke_factor(1, 1, 1, normalize_alpha) ;
  }
    public void opacityFill(float a) {
    display_fill_original = true ;
    display_fill_custom = false ;
    float normalize_alpha = (a / g.colorModeA) ;
    this.fill_factor(1, 1, 1, normalize_alpha) ;
  }
  
  /**
  fill
  */

  public void noFill() {
    display_fill_original = false ;
    display_fill_custom = true ;
    fill_custom.set(0) ;
  }
  
  public void fill(int c) {
    display_fill_original = false ;
    display_fill_custom = true;
    if(g.colorMode == 1 ) fill_custom.set(red(c),green(c),blue(c),alpha(c));
    else if(g.colorMode == 3) fill_custom.set(hue(c),saturation(c),brightness(c),alpha(c));
  }

  public void fill(float value) {
    display_fill_original = false ;
    display_fill_custom = true ;
    fill_custom.set(value,value,value, g.colorModeA) ;
  }

  public void fill(float value, float alpha) {
    display_fill_original = false ;
    display_fill_custom = true ;
    fill_custom.set(value,value,value, alpha) ;
  }

  public void fill(float x, float y, float z) {
    display_fill_original = false ;
    display_fill_custom = true ;
    fill_custom.set(x, y, z, g.colorModeA) ;
  }
  
  public void fill(float x, float y, float z, float a) {
    display_fill_original = false ;
    display_fill_custom = true ;
    fill_custom.set(x,y,z,a) ;
  }

  public void fill(vec v) {
    display_fill_original = false ;
    display_fill_custom = true ;
    if(v instanceof vec2) {
      vec2 v2 = (vec2) v ;
      fill_custom.set(v2.x, v2.x, v2.x, v2.y) ;
    } else if(v instanceof vec3) {
      vec3 v3 = (vec3) v ;
      fill_custom.set(v3.x,v3.y,v3.z, g.colorModeA) ;
    } else if(v instanceof vec3 ) {
      vec4 v4 = (vec4) v ;
      fill_custom.set(v4.x, v4.y, v4.z, v4.w) ;
    }
  }
  /**
  stroke
  */
  public void noStroke() {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    thickness_custom = 0 ;
    stroke_custom.set(0) ;
  }
  
  public void stroke(int c) {
    display_stroke_original = false ;
    display_stroke_custom = true;
    if(g.colorMode == 1 ) stroke_custom.set(red(c),green(c),blue(c),alpha(c));
    else if(g.colorMode == 3) stroke_custom.set(hue(c),saturation(c),brightness(c),alpha(c));
  }

  public void stroke(float value) {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    stroke_custom.set(value, value, value, g.colorModeA) ;
  }

  public void stroke(float value, float a) {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    stroke_custom.set(value, value, value, a) ;
  }

  public void stroke(float x, float y, float z) {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    stroke_custom.set(x, y, z, g.colorModeA) ;
  }

  public void stroke(float x, float y, float z, float a) {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    stroke_custom.set(x,y,z,a) ;
  }


  public void stroke(vec v) {
    display_stroke_original = false ;
    display_stroke_custom = true ;
    if(v instanceof vec2) {
      vec2 v2 = (vec2) v ;
      stroke_custom.set(v2.x, v2.x, v2.x, v2.y) ;
    } else if(v instanceof vec3) {
      vec3 v3 = (vec3) v ;
      stroke_custom.set(v3.x,v3.y,v3.z, g.colorModeA) ;
    } else if(v instanceof vec3 ) {
      vec4 v4 = (vec4) v ;
      stroke_custom.set(v4.x, v4.y, v4.z, v4.w) ;
    }
  }
  /**
  strokeWeight
  */
  public void strokeWeight(float x) {
    display_thickness_original = false ;
    display_thickness_custom = true ;
    thickness_custom = x ;
  }


  /**
  original style
  */
  public void original_style(boolean fill, boolean stroke) {
    display_fill_original = fill ;
    display_stroke_original = stroke ;
    display_thickness_original = stroke ;
  }

  public void original_fill(boolean fill) {
    display_fill_original = fill ;
  }

  public void original_stroke(boolean stroke) {
    display_stroke_original = stroke ;
    display_thickness_original = stroke ;
  }
  

  /**
  fill factor
  use value from '0' to '1' is better !
  */
  public void fill_factor(float x, float y, float z, float a) {
    fill_factor.set(x,y,z,a) ;
  }

  public void stroke_factor(float x, float y, float z, float a) {
    stroke_factor.set(x,y,z,a) ;
  }

  public void fill_factor(vec4 f) {
    fill_factor.set(f.x,f.y,f.z,f.a) ;
  }

  public void stroke_factor(vec4 f) {
    stroke_factor.set(f.x,f.y,f.z,f.a) ;
  }

  /**
  PERMANENTE CHANGE
  This change modify the original points
  */
  public void add_def(int target, vec3... value) {
    if(list_brick_SVG.size() > 0) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      if(b.kind == "polygon" || b.kind == "path" || b.kind == "polyline") {
        for(Vertices v : list_vertice_SVG) {
          if(v.ID == b.get_id()) v.add_value(value) ;
        }
      } else if(b.kind == "line") {
        for(Line l : list_line_SVG) {
          if(l.ID == b.get_id()) l.add_value(value) ;
        }
      } else if(b.kind == "circle" || b.kind == "ellipse") {
        for(Ellipse e : list_ellipse_SVG) {
          if(e.ID == b.get_id()) e.add_value(value) ;
        }
      } else if(b.kind == "rect") {
        for(Rectangle r : list_rectangle_SVG) {
          if(r.ID == b.get_id()) r.add_value(value) ;
        }
      } else if(b.kind == "text") {
        for(ROPEText t : list_text_SVG) {
          if(t.get_id() == b.get_id()) t.add_value(value) ;
        }
      } 
    } 
  }
  

  /**
  SVG info
  */

  
  /**
   return quantity of brick 
  */
  public int num_brick() {
    return list_brick_SVG.size() ;
  }
  

  /**
  list
  */
  public vec3 [] list_svg_vec(int target) {
    vec3 [] p = new vec3[1] ;
    p[0] = vec3(2147483647,2147483647,2147483647) ; // it's maximum value of int in 8 bit :)

    if(list_brick_SVG.size() > 0) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      if(b.kind == "polygon" || b.kind == "path" || b.kind == "polyline") {
        for(Vertices v : list_vertice_SVG) {
          if(v.ID == b.ID) return v.vertices() ;
        }
      } else if(b.kind == "line") {
        for(Line l : list_line_SVG) {
          if(l.ID == b.ID) {
            p[0] = l.pos_a ;
            p[1] = l.pos_b ;
            return p ;
          }
        }
      } else if(b.kind == "circle" || b.kind == "ellipse") {
        for(Ellipse e : list_ellipse_SVG) {
          if(e.ID == b.ID) {
            p[0] = e.pos ;
            return p ;
          }
        }
      } else if(b.kind == "rect") {
        for(Rectangle r : list_rectangle_SVG) {
          if(r.ID == b.ID) { 
            p[0] = r.pos ;
            return p ;
          }
        }
      } 
    } else return p ;
    return p ;
  }


  public PVector [] list_svg_PVector(int target) {
    PVector [] p  ;
    vec3 [] temp_list ;
    temp_list = list_svg_vec(target).clone() ;
    int num = temp_list.length ;
    p = new PVector[num] ;
    for(int i = 0 ; i < num ; i++) {
      p[i] = new PVector(temp_list[i].x, temp_list[i].y, temp_list[i].z) ;
    }
    if (p != null) return p ; else return null ;
  }





  /**
  method to return different definition about the brick
  */

  public String folder_brick_name() {
    return folder_brick_name ;
  }


  public String [] brick_name_list() {
    return name_brick_SVG(list_brick_SVG) ;
  }

  public String brick_name(int target) {
    if(list_brick_SVG.size() > 0 && target < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      return b.brick_name ;

    } else return "No idea for this ID !" ;
  }

  public String [] family_brick() {
    return family_brick_SVG(list_brick_SVG) ;
  }

  public String family_brick(int target) {
    if(list_brick_SVG.size() > 0 && target < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      return b.family_name ;

    } else return "No idea for this ID !" ;
  }

  public String [] kind_brick() {
    return kind_brick_SVG(list_brick_SVG) ;
  }
  public String kind_brick(int target) {
    if(list_brick_SVG.size() > 0 && target < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(target) ;
      return b.kind ;

    } else return "No idea for this ID !" ;
  }





  
  




  /**
  Canvas SVG
  */
  public float width() {
    if(shape_SVG != null) {
      return shape_SVG.width ; 
    } else {
      return 0 ;
    }
  }
  public float height() {
    if(shape_SVG != null) { 
      return shape_SVG.height ; 
    } else {
      return 0 ;
    }
  }
  
  public vec2 canvas() {
    if(shape_SVG != null) {
      return vec2(shape_SVG.width, shape_SVG.height) ; 
    } else { 
      return vec2() ;
    }
  }
  
  
  
  
  
  /**
  Canvas brick SVG
  */
  public float width_brick(int target) {
    if(list_brick_SVG.size() > 0 && target <list_brick_SVG.size()) {
      Brick_SVG b_svg = list_brick_SVG.get(target) ;
      return b_svg.width ; 
    } else return 0 ;
  }

  public float height_brick(int target) {
    if(list_brick_SVG.size() > 0 && target <list_brick_SVG.size()) {
      Brick_SVG b_svg = list_brick_SVG.get(target) ;
      return b_svg.height ; 
    } else return 0 ;
  }
  
  public vec2 canvas_brick(int target) {
    if(list_brick_SVG.size() > 0 && target <list_brick_SVG.size()) {
      Brick_SVG b_svg = list_brick_SVG.get(target) ;
      return vec2(b_svg.width, b_svg.height) ;
    } else return vec2() ;
  }










 /**
  SETTING
  */
  public void mode(int mode) {
    // for info CORNER = 0 / CENTER = 3 > Global variable from Processing
    if(mode == 0 ) position_center = false ;
    else if(mode == 3 ) position_center = true ;
    else position_center = false ;
  }
  /**
  // END PUBLIC METHOD


  */
  







  
  
  
  
  
  






  
  
  
  
  
  
  
  
  /**
  PRIVATE METHOD


  */

  /**
  DRAW

  */
  // reset all change to something flat and borring !
  public void reset() {
    if(!keep_change) {
      if(!bool_pos) {
        pos.set(0) ;
      }
      if(!bool_jitter_svg) {
        jitter_svg.set(0) ;
      }
      if(!bool_scale_svg) {
        scale_svg.set(1) ;
      }
    } else {
      original_style(true, true) ;
      fill_factor(1,1,1,1) ;
      stroke_factor(1,1,1,1) ;
    }
  }
  


  private void change_boolean_to_false() {
    bool_pos = false ;
    bool_scale_svg = false ;
    bool_jitter_svg = false ;
    bool_scale_translation = false ;
  }
  /**
  Draw all shape
  */
  // INTERN METHOD 2D
  private void draw_SVG(vec pos_, vec scale_, vec jitter_) {
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      draw_final(pos_, scale_, jitter_, b) ;
    }
  }
 
  
  /**
  Draw shape by ID
  */
  // 2D
  private void draw_SVG (vec pos_, vec scale_, vec jitter_, int ID) {
    if(ID < list_brick_SVG.size()) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(ID) ;
      draw_final(pos_, scale_, jitter_, b) ;
    }
  }
   
  
  /**
  Draw shape by name
  */
  // draw all file from shape or group of layer
  // must be factoring is very ligth method :)
  private void draw_SVG (vec pos_, vec scale_, vec jitter_, String layer_name) {
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG b = (Brick_SVG) list_brick_SVG.get(i) ;
      if( b.family_name.contains(layer_name)) {
        draw_final(pos_, scale_, jitter_, b) ;
      }
    }
  }

  private void draw_final(vec pos_, vec scale_, vec jitter_, Brick_SVG b) {
    if(b.font != null) textFont(b.font) ;
    if(b.size_font != MAX_INT) textSize(b.size_font) ;

    float average_scale = (scale_.x + scale_.y) *.5f ;
    aspect(b, average_scale) ;
    display_shape(b, pos_, scale_, jitter_) ;

  }
  /**
  END DRAW METHOD

  */






  /**
  ASPECT
  */
  private void aspect(Brick_SVG b, float scale_thickness) {
    aspect_original(b, scale_thickness) ;
    aspect_custom() ;
  }

  // super local
  private  void aspect_original(Brick_SVG b, float scale_thickness) {
    if(display_fill_original) {
      b.aspect_fill(fill_factor) ; 
    } else {
      p5.noFill() ;
    }
    if(display_stroke_original && display_thickness_original) {
      b.aspect_stroke(scale_thickness,stroke_factor) ; 
    } else { 
      p5.noStroke() ;
    }
  }

  private  void aspect_custom() {
    if(fill_custom.a > 0 && display_fill_custom && !display_fill_original) {
      p5.fill(fill_custom.r *fill_factor.x, fill_custom.g *fill_factor.y, fill_custom.b *fill_factor.y, fill_custom.a *fill_factor.w) ; 
    }
    if(display_stroke_custom && !display_stroke_original) {
      if(stroke_custom.a > 0 || thickness_custom > 0 ) {
        p5.stroke(stroke_custom.r *stroke_factor.x, stroke_custom.g *stroke_factor.y, stroke_custom.b *stroke_factor.z, stroke_custom.a *stroke_factor.w) ;
        p5.strokeWeight(thickness_custom) ;
      }
    }
    
    if(!display_fill_original && !display_fill_custom) {
      p5.noFill() ;
    }
    if(!display_stroke_original && !display_stroke_custom) {
      p5.noStroke() ;
    }
  }



  
  


































  /**
  BUILD

  */
  /**
  Main display method

  */
  private void display_shape(Brick_SVG b, vec pos_raw, vec scale_raw, vec jitter_raw) {
    if(pos_raw instanceof vec2 && scale_raw instanceof vec2 && jitter_raw instanceof vec2) {
      vec2 pos_temp = (vec2) pos_raw ;
      vec2 scale_temp = (vec2) scale_raw ;
      vec2 jitter_temp = (vec2) jitter_raw ;

      vec3 pos = vec3(pos_temp) ;
      vec3 scale = vec3(scale_temp) ;
      vec3 jitter = vec3(jitter_temp) ;
      display_shape_3D(b, pos, scale, jitter) ;
    } else if (pos_raw instanceof vec3 && scale_raw instanceof vec3 && jitter_raw instanceof vec3) {
      vec3 pos = (vec3) pos_raw ;
      vec3 scale = (vec3) scale_raw ;
      vec3 jitter = (vec3) jitter_raw ;
      display_shape_3D(b, pos, scale, jitter) ;
    }
  }

  private void display_shape_3D(Brick_SVG b, vec3 pos, vec3 scale, vec3 jitter) {
    if(b.kind == "path" || b.kind == "polygon" || b.kind == "polyline") {
      for(Vertices v : list_vertice_SVG) {
        if(v.ID == b.ID) build_path(pos, scale, jitter, v) ;
      }
    } else if(b.kind == "line") {
      for(Line l : list_line_SVG) {
        if(l.ID == b.ID) {
          build_line(pos, scale, jitter, l) ;
        }
      }
    } else if(b.kind == "ellipse" || b.kind == "circle") {
      for(Ellipse e : list_ellipse_SVG) {
        if(e.ID == b.ID) {
          build_ellipse(pos, scale, jitter, e) ;
        }
      }
    } else if(b.kind == "rect") {
      for(Rectangle r : list_rectangle_SVG) {
        if(r.ID == b.ID) {
          build_rectangle(pos, scale, jitter, r) ;
        }
      }
    } else if(b.kind == "text") {
      for(ROPEText t : list_text_SVG) {
        if(t.ID == b.ID) {
          build_text(pos, scale, jitter, t) ;
        }
      }
    }
  }



  /**

  Build SVG brick


  */
  private void build_SVG(ArrayList<Brick_SVG> list, String path_brick) {
    PShape [] children = new PShape[list.size()] ;
    for(int i = 0 ; i < list.size() ; i++) {
      PShape mother = loadShape(path_brick + folder_brick_name + "_" + i + ".svg") ;
      children = mother.getChildren() ;
      /**
      Problem here with P3D and P2D mode
      return null pointer exception with type 'text'
      println(children) ;
      */
      
      Brick_SVG b = (Brick_SVG) list.get(i) ;
      if(b.kind == "polygon" || b.kind == "path" || b.kind == "polyline")  vertex_count(children[0], mother.getName(), b.ID) ;
      if(b.kind == "line")  line_count(b.xml_brick, mother.getName(), b.ID) ;
      else if(b.kind == "circle" || b.kind == "ellipse") ellipse_count(b.xml_brick, b.ID) ;
      else if(b.kind == "rect") rectangle_count(b.xml_brick, b.ID) ;
      else if(b.kind == "text") text_count(b.xml_brick,  b.ID) ;
    }
  }
  
  /**
  TEXT
  */
  // list of group SVG
  ArrayList<ROPEText> list_text_SVG = new ArrayList<ROPEText>() ;
      
  //
  private void text_count(XML xml_shape, int ID) {
    vec6 matrix = matrix_vec(xml_shape) ;
    String sentence = xml_shape.getChild("text").getContent() ;

    ROPEText t = new ROPEText(matrix, sentence, ID) ;
    list_text_SVG.add(t) ;
  }



  

  /**
  Main method to draw text
  */
  public void build_text(vec3 pos, vec3 scale, vec3 jitter, ROPEText t) {
    vec3 temp_pos = vec3(t.pos.x, t.pos.y,0)   ;
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) {
      vec3 center_pos = vec3(canvas().x,canvas().y, 0) ;
      center_pos.mult(.5f) ; 
      temp_pos.sub(center_pos) ;
    }
    if(!scale.equals(vec3(1))) {
      temp_pos.mult(scale) ; 
    }
    if(!pos.equals(vec3())) {
      temp_pos.add(pos) ;
    }

    
    if(check_matrix(t.matrix)) {
      start_matrix() ;
      matrix(t.matrix, temp_pos) ;
      text(t.sentence, 0,0) ;
      stop_matrix() ;
    } else {
      // if there is no matrix effect
      text(t.sentence, temp_pos) ;
    }
  }
  /**
  END CIRCLE & ELLIPSE
  */













  /**
  Line
  */
  // list of group SVG
  ArrayList<Line> list_line_SVG = new ArrayList<Line>() ;

  private void line_count(XML xml_shape, String geom_name, int ID) {
    float x_a = xml_shape.getChild(0).getFloat("x1") ;
    float y_a = xml_shape.getChild(0).getFloat("y1") ;
    float x_b = xml_shape.getChild(0).getFloat("x2") ;
    float y_b = xml_shape.getChild(0).getFloat("y2") ;
  
    Line l = new Line(x_a, y_a, x_b, y_b, ID) ;
    list_line_SVG.add(l) ;
  }
  

  /**
  Main method to draw ellipse
  */
  public void build_line(vec3 pos, vec3 scale, vec3 jitter, Line l) {
    vec3 temp_pos_a = vec3(l.pos_a.x, l.pos_a.y,0)  ;
    vec3 temp_pos_b = vec3(l.pos_b.x, l.pos_b.y,0)  ;

  
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) {
      vec3 center_pos = vec3(canvas().x,canvas().y, 0) ;
      center_pos.mult(.5f) ; 
      temp_pos_a.sub(center_pos) ;
      temp_pos_b.sub(center_pos) ;
    }
    if(!scale.equals(vec3(1))) {
      temp_pos_a.mult(scale) ; 
      temp_pos_b.mult(scale) ; 
    }
    if(!pos.equals(vec3())) {
      temp_pos_a.add(pos) ;
      temp_pos_b.add(pos) ;
    }
  
    line(temp_pos_a.mult(scale), temp_pos_b.mult(scale)) ;
  }
  /**
  END CIRCLE & ELLIPSE
  */







  /**
  ELLIPSE & CIRCLE
  */
  // list of group SVG
  ArrayList<Ellipse> list_ellipse_SVG = new ArrayList<Ellipse>() ;

  private void ellipse_count(XML xml_shape, int ID) {
    vec6 matrix = matrix_vec(xml_shape) ;
    float r = xml_shape.getChild(0).getFloat("r") ;
    float rx = (float)xml_shape.getChild(0).getFloat("rx") ;
    float ry = (float)xml_shape.getChild(0).getFloat("ry") ;
    float cx = xml_shape.getChild(0).getFloat("cx") ;
    float cy = xml_shape.getChild(0).getFloat("cy") ;
    if(r > 0 ) rx = ry = r ;
  
    Ellipse e = new Ellipse(matrix, cx, cy, rx, ry, ID) ;
    list_ellipse_SVG.add(e) ;
  }
  

  /**
  Main method to draw ellipse
  */
  public void build_ellipse(vec3 pos, vec3 scale, vec3 jitter, Ellipse e) {
    vec3 temp_pos = vec3(e.pos.x, e.pos.y,0)  ;

  
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) {
      vec3 center_pos = vec3(canvas().x,canvas().y, 0) ;
      center_pos.mult(.5f) ; 
      temp_pos.sub(center_pos) ;
    }
    if(!scale.equals(vec3(1))) temp_pos.mult(scale) ; 
    if(!pos.equals(vec3())) temp_pos.add(pos) ;
  
    vec2 temp_size = e.size.copy() ;

    if(check_matrix(e.matrix)) {
      start_matrix() ;
      matrix(e.matrix, temp_pos) ;
      ellipse(vec2(0), temp_size.mult(scale.x, scale.y)) ;
      stop_matrix() ;
    } else {
      // if there is no matrix effect
      ellipse(temp_pos, temp_size.mult(scale.x, scale.y)) ;
    }

    
  }
  /**
  END CIRCLE & ELLIPSE
  */
  



  /**
  RECTANGLE
  */
  // list of group SVG
  private ArrayList<Rectangle> list_rectangle_SVG = new ArrayList<Rectangle>() ;
  
  private void rectangle_count(XML xml_shape, int ID) {
    vec6 matrix = matrix_vec(xml_shape) ;
    float x = xml_shape.getChild(0).getFloat("x") ;
    float y = xml_shape.getChild(0).getFloat("y") ;
    float width_rect = xml_shape.getChild(0).getFloat("width") ;
    float height_rect = xml_shape.getChild(0).getFloat("height") ;
  
    Rectangle r = new Rectangle(matrix, x, y, width_rect, height_rect, ID) ;
    list_rectangle_SVG.add(r) ;
  }
  
  /**
  Main method to draw ellipse
  */
  
  private void build_rectangle(vec3 pos, vec3 scale, vec3 jitter, Rectangle r) {
    vec3 temp_pos = vec3(r.pos.x, r.pos.y,0)  ;
  
    // the order of operation is very weird, because is not a same for the build_vertex()
    if(position_center) {
      vec3 center_pos = vec3(canvas().x,canvas().y, 0) ;
      center_pos.mult(.5f) ; 
      temp_pos.sub(center_pos) ;
    }
    if(!scale.equals(vec3(1))) temp_pos.mult(scale) ; 
    if(!pos.equals(vec3())) temp_pos.add(pos) ;
  
    vec2 temp_size = r.size.copy() ;

    if(check_matrix(r.matrix)) {
      start_matrix() ;
      matrix(r.matrix, temp_pos) ;
      vec2 pos_def = vec2() ;
      // pos_def.x += (temp_size.x *.5) ;
      // pos_def.y += (temp_size.y *.5) ;
      // pos_def.x += mouseX ;
      // pos_def.y += mouseY ;
      printTempo(60, pos_def) ;
      printTempo(60, "void build_rectangle()") ;
      rect(pos_def, temp_size) ;
      stop_matrix() ;
    } else {
      // if there is no matrix effect
      rect(temp_pos, temp_size.mult(scale.x, scale.y)) ;
    }
  }
  /**
  END RECTANGLE
  */
  

  











  /**
  VERTEX


  */
  /**
  Build
  */
  // list of group SVG
  private ArrayList<Vertices> list_vertice_SVG = new ArrayList<Vertices>() ;
  // here we must build few object for each group, but how ?
  private vec3 [] vert ;
  private int [] vertex_code ;
  private int code_vertex_count ;
  
  private void vertex_count(PShape geom_shape, String geom_name, int ID) {
    int num = geom_shape.getVertexCount() ;
    vertex_code = new int[num] ;
    vert = new vec3[num] ;
    vertex_code = geom_shape.getVertexCodes() ;
    code_vertex_count = geom_shape.getVertexCodeCount() ;
    
    Vertices v = new Vertices(code_vertex_count, num, geom_shape, geom_name, ID) ;
    v.build_vertices_3D(geom_shape) ;
    list_vertice_SVG.add(v) ;
  }
  /**
  END VERTEX
  */
 
  




  /**
  Draw Vertice
  adapted from Processing PShape drawPath for the vertex
  https://github.com/processing/processing/blob/master/core/src/processing/core/PShape.java
  line 1700 and the dust !
  */


  private void build_path(vec3 pos, vec3 scale, vec3 jitter, Vertices v) {
    vec3 center_pos = vec3(canvas().x,canvas().y,0) ;
    center_pos.mult(.5f) ; 
    if(!scale.equals(vec3(1))) center_pos.mult(scale) ; 
  
    if (v.vert == null) return;
  
    boolean insideContour = false;
    beginShape();
    // for the simple vertex
    if (v.code_vertex_count == 0) {  
      for (int i = 0; i <  v.vert.length; i++) {
        vec3 temp_pos_a = v.vert[i].copy() ;
        //
        if(!scale.equals(vec3(1))) temp_pos_a.mult(scale) ;
        //
        if(!jitter.equals(vec3())) {
          vec3 jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
          temp_pos_a.add(jitter_pos) ;
        }
        //
        if(position_center) temp_pos_a.sub(center_pos) ;
        //
        if(!pos.equals(vec3())) temp_pos_a.add(pos) ;
        //
        vertex(temp_pos_a);
      }
    // for the complex draw vertex, with bezier, curve...
    } else {  
      int index = 0;
      for (int j = 0; j < v.code_vertex_count; j++) {
        vec3 temp_pos_a , temp_pos_b, temp_pos_c ;
  
        switch (v.vertex_code[j]) {
          //----------
          case VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          //
          if(!scale.equals(vec3(1))) temp_pos_a.mult(scale) ;
          //
          if(!jitter.equals(vec3())) {
            vec3 jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
          }
          //
          if(position_center) temp_pos_a.sub(center_pos) ;
          //
          if(!pos.equals(vec3())) temp_pos_a.add(pos) ;
          //
          vertex(temp_pos_a);
          index++;
          break;
        // QUADRATIC_VERTEX
          case QUADRATIC_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          temp_pos_b = v.vert[index +1].copy() ;
          //
          if(!scale.equals(vec3(1))) {
            temp_pos_a.mult(scale) ;
            temp_pos_b.mult(scale) ;
          }
          //
          if(!jitter.equals(vec3())) {
            vec3 jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
            jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_b.add(jitter_pos) ;
          }
          //
          if(position_center) {
            temp_pos_a.sub(center_pos) ;
            temp_pos_b.sub(center_pos) ;
          }
          //
          if(!pos.equals(vec3())) {
            temp_pos_a.add(pos) ;
            temp_pos_b.add(pos) ;
          }
          //
          quadraticVertex(temp_pos_a, temp_pos_b);
          index += 2;
          break;
          // BEZIER_VERTEX
          case BEZIER_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          temp_pos_b = v.vert[index +1].copy() ;
          temp_pos_c = v.vert[index +2].copy() ;
          //
          if(!scale.equals(vec3(1))) {
            temp_pos_a.mult(scale) ;
            temp_pos_b.mult(scale) ;
            temp_pos_c.mult(scale) ;
          }
          //
          if(!jitter.equals(vec3())) {
            vec3 jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
            jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_b.add(jitter_pos) ;
            jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_c.add(jitter_pos) ;
          }
          //
          if(position_center) {
            temp_pos_a.sub(center_pos) ;
            temp_pos_b.sub(center_pos) ;
            temp_pos_c.sub(center_pos) ;
          }
          //
          if(!pos.equals(vec3())) {
            temp_pos_a.add(pos) ;
            temp_pos_b.add(pos) ;
            temp_pos_c.add(pos) ;
          }
          //
          bezierVertex(temp_pos_a, temp_pos_b, temp_pos_c);
          index += 3;
          break;
          // CURVE_VERTEX
          case CURVE_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          //
          if(!scale.equals(vec3(1))) temp_pos_a.mult(scale) ;
          //
          if(!jitter.equals(vec3())) {
            vec3 jitter_pos = vec3().jitter((int)jitter.x,(int)jitter.y,(int)jitter.z) ;
            temp_pos_a.add(jitter_pos) ;
          }
          //
          if(position_center) temp_pos_a.sub(center_pos) ;
          //
          if(!pos.equals(vec3())) temp_pos_a.add(pos) ;
          //
          curveVertex(temp_pos_a);
          index++;
          break;
          // BREAK
          case BREAK:
          if (insideContour) {
            endContour();
          }
          beginContour();
          insideContour = true;
        }
      }
    }
    if (insideContour) {
      endContour();
    }
    // endShape(CLOSE);
    endShape();
  }
  /**
  END BUILD

  */
























  /** 
  MATRIX 
  transformation

  */

  private vec6 matrix_vec(XML xml_shape) {
    if(xml_shape.getChild(0).getString("transform") != null) {
      String matrix = xml_shape.getChild(0).getString("transform") ;
      if(matrix.startsWith("matrix(")) {
        matrix = matrix.substring(6) ;
      }
      if(matrix.endsWith(")")) {
        matrix = matrix.substring(1, matrix.length() -1) ;
      }
      String [] transform = split(matrix," ") ;
      /**
      more about matrix 3x3 > 6
      https://www.w3.org/TR/SVG/coords.html#TransformMatrixDefined
      */

      float a = Float.parseFloat(transform[0] );
      float b = Float.parseFloat(transform[1] );
      float c = Float.parseFloat(transform[2] );
      float d = Float.parseFloat(transform[3] );

      float e = Float.parseFloat(transform[4] );
      float f = Float.parseFloat(transform[5] );
      vec6 m = vec6(a,b,c,d,e,f) ;
      return m ;
    } else return null ;
  }




  private boolean check_matrix(vec6 matrix) {
    if(matrix != null) {
      float a = matrix.a ;
      float b = matrix.b ;
      float c = matrix.c ;
      float d = matrix.d ;
      if(a == 1 && b == 0 && c == 0 && d == 1) {
        return false ; 
      } else return true ;
    } else return false ;
  }



  private void matrix(vec6 matrix, vec3 pos) {
    float a = matrix.a ;
    float b = matrix.b ;
    float c = matrix.c ;
    float d = matrix.d ;
    // about matrix 
    // http://stackoverflow.com/questions/4361242/extract-rotation-scale-values-from-2d-transformation-matrix
    boolean matrix_bool = false ;
    boolean rotate_bool = false ;
    boolean scale_bool = false ;
    boolean skew_bool = false ;


    if(a == 1 && b == 0 && c == 0 && d == 1) {
      matrix_bool = false ;
      rotate_bool = false ;
      scale_bool = false ;
      skew_bool = false ;
    } else {
      // run matrix
      matrix_bool = true ;

      boolean rotate_case = false ;
      boolean scale_case = false ;
      boolean skew_case = false ;
      if(abs(a) == abs(d) && abs(c) == abs(b)) rotate_case = true ;
      if(a != 1 && b == 0 && c == 0 &&  abs(a) != abs(d)) scale_case = true ;
      if(a < 1 && b > -1 && c < 1 && d < 1) skew_case = true ;

      // rotate case
      if(rotate_case) {
        rotate_bool = true ;
        scale_bool = false ;
        skew_bool = false ;
      // scale case
      } else if(scale_case) {
        rotate_bool = false ;
        scale_bool = true ;
        skew_bool = false ;
      } else if ((a < -1 || a > 1) && (b < -1 || b > 1)) {
        scale_bool = true ;
        rotate_bool = true ;
        skew_bool = false ;
      }
      // skew case
      if(skew_case && !rotate_case && (a != 1 && b != 0 && c != 0 && d != 1) ) {
        skew_bool = true ;
      }
    }

    /**
    matrix case
    */
    if(matrix_bool) {
      float angle = atan(-matrix.b / matrix.a) ; 

      // rotate
      if(rotate_bool && !scale_bool && !skew_bool) {
        translate(pos) ;
        if(d <= 0 ) {
          angle = angle + PI ;
        }
        rotate(-angle) ;
      }

      // scale
      if(scale_bool && !rotate_bool && !skew_bool) {
        float sx = sqrt((a * a) + (c * c)) ;
        if(a < 0 || c < 0) {
          sx *= -1 ;
        }
        float sy = sqrt((b * b) + (d * d)) ;
        if(b < 0 || d < 0) {
          sy *= -1 ;
        }

        translate(pos.x, pos.y) ;
        scale(sx, sy) ;
      }

      // scale and rotate
      if(scale_bool && rotate_bool && !skew_bool) {
        // rotation
        if(d <= 0 ) {
          angle += PI ;
        }
        // scale
        float sx_1 = a / cos(angle) ;
        float sx_2 = -c / sin(angle) ;
        float sy_1 = b / sin(angle) ;
        float sy_2 = d / cos(angle) ;
        
        translate(pos) ;
        rotate(-angle) ;
        scale(sx_1, sy_2) ;
      }
      
      // SKEW
      // skew / shear is rotate/scale and skew in same time 
      // skew take the lead on every thing, I believe but not sure
      
      // this alpgorithm is not really good, very approximative :(
      
      if(skew_bool && !rotate_bool && !scale_bool) {
        // calcule the angle for skew-scaling
        // scale
        float sx_1 = a / cos(angle) ;
        float sx_2 = -c / sin(angle) ;
        float sy_1 = b / sin(angle) ;
        float sy_2 = d / cos(angle) ;

        translate(pos) ;

        shearX(c) ;
        shearY(b) ;
        scale(sx_1, sy_2) ;
        
      }
    }
  }

  /**

  END MATRIX

  */
























  /**
  EXTRACT POINT
  
  */
  
  private void extract(Vertices v) {
    if (v.vert == null) return;
    if (v.code_vertex_count == 0) {  
      for (int i = 0; i <  v.vert.length; i++) {
        vec3 temp_pos_a = v.vert[i].copy() ;
        vertex(temp_pos_a);
      }
    // for the complex draw vertex, with bezier, curve...
    } else {  
      int index = 0;
      for (int j = 0; j < v.code_vertex_count; j++) {
        vec3 temp_pos_a , temp_pos_b, temp_pos_c ;
        switch (v.vertex_code[j]) {
          case VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          vertex(temp_pos_a);
          index++;
          break;
          // QUADRATIC_VERTEX
          case QUADRATIC_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          temp_pos_b = v.vert[index +1].copy() ;
          //
          quadraticVertex(temp_pos_a, temp_pos_b);
          index += 2;
          break;
          // BEZIER_VERTEX
          case BEZIER_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          temp_pos_b = v.vert[index +1].copy() ;
          temp_pos_c = v.vert[index +2].copy() ;
          //
          bezierVertex(temp_pos_a, temp_pos_b, temp_pos_c);
          index += 3;
          break;
          // CURVE_VERTEX
          case CURVE_VERTEX:
          temp_pos_a = v.vert[index].copy() ;
          curveVertex(temp_pos_a);
          index++;
          break;
          // BREAK
          case BREAK:
        }
      }
    }
  }






  /**
  INFO

  */
  public String [] name_brick_SVG (ArrayList<Brick_SVG> list_brick) {
    String [] list ;
    if(list_brick.size() > 0 ) {
      list = new String[list_brick.size()] ;
      for (int i = 0 ; i < list.length ; i++) {
        Brick_SVG b_svg = list_brick.get(i) ;
        list[i] = b_svg.brick_name ;
      }
      return list ;
    } else {
      list = new String[1] ;
      list[0] = "no item in the list" ;
      return list ;
    }
  }
  
  public String [] kind_brick_SVG (ArrayList<Brick_SVG> list_brick) {
    String [] list ;
    if(list_brick.size() > 0 ) {
      list = new String[list_brick.size()] ;
      for (int i = 0 ; i < list.length ; i++) {
        Brick_SVG b_svg = list_brick.get(i) ;
        list[i] = b_svg.kind ;
      }
      return list ;
    } else {
      list = new String[1] ;
      list[0] = "no item in the list" ;
      return list ;
    }
  }
  
  public String [] family_brick_SVG (ArrayList<Brick_SVG> list_brick) {
    String [] list ;
    if(list_brick.size() > 0 ) {
      list = new String[list_brick.size()] ;
      for (int i = 0 ; i < list.length ; i++) {
        Brick_SVG b_svg = list_brick.get(i) ;
        list[i] = b_svg.family_name ;
      }
      return list ;
    } else {
      list = new String[1] ;
      list[0] = "no item in the list" ;
      return list ;
    }
  }
  /**
  END INFO

  */
  

  


















  
  
  /**
  ANALYZE

  */
  private void analyze_SVG(XML target) {
    // catch the header to rebuild a SVG as small as possible to use Processing build PShapeSVG of Processing engine
    header_svg = catch_header_SVG(target) ;


    ID_brick = 0 ;
    String primal_name =("") ;
    String primal_opacity = ("none") ;

    /**
    work in progress for ordering shape




    */
    
    /**



    */
    // style for SVG version 2
    XML [] svg_style = target.getChildren("style") ;

    if(svg_style.length > 0) {
      // new SVG 1.1 version 2
      build_array_style(svg_style[0]) ;
      deep_analyze_SVG(header_svg, true, target, primal_name, primal_opacity) ;

    } else {
      // old SVG
      XML no_style = new XML ("no_style") ;
      deep_analyze_SVG(header_svg, false, target, primal_name, primal_opacity) ;
    }
  }




  private void build_array_style(XML style) {
    String string_style = style.toString() ;
    String [] st_temp = split(string_style,".st") ;
    // remove the first element of the array and the first occurence of each element
    st = new String[st_temp.length -1] ;
    for(int i = 0 ; i < st.length ;i++) {
      st[i] = "st"+ st_temp[i+1] ;
      if(st[i].contains("st"+i)) {
        st[i] = st[i].replaceAll("st"+i, "") ;
      }
    }
    // remove the word style from the last array String
    if(st[st.length -1].contains("</style>")) {
      st[st.length -1] = st[st.length -1].replaceAll("</style>","") ;
    }
  }
  
  private void save_brick_SVG() {
    /* here in the future :
    Save name of SVG, width, height and other global properties
    */
    for(int i = 0 ; i < list_brick_SVG.size() ; i++) {
      Brick_SVG shape = (Brick_SVG) list_brick_SVG.get(i) ;
      saveXML(shape.xml_brick,  saved_path_bricks_svg + folder_brick_name + "_" + i + ".svg") ;
    }
  }

  
  
  
  // Local method
  int rank_analyze = 0 ;
  private void deep_analyze_SVG(String header, boolean style, XML target, String ancestral_name, String opacity_group) {
    rank_analyze ++ ;
    String ID_xml =("") ;
    ID_xml = get_kind_SVG(target) ;

    String [] children_str = target.listChildren() ;
    XML [] children_xml = target.getChildren() ;
    // split XML children



    // build brick XML
    for(int i = 0 ; i < children_xml.length ; i++) {
      if( children_str[i].equals("rect") 
          || children_str[i].equals("line") 
          || children_str[i].equals("polyline") 
          || children_str[i].equals("circle") 
          || children_str[i].equals("ellipse") 
          || children_str[i].equals("polygon") 
          || children_str[i].equals("path")
          || children_str[i].equals("text")
          ) {
        if(check_kind_SVG(children_xml[i])) {
          add_brick_SVG(header_svg, style, children_xml[i], ancestral_name, opacity_group) ;
        }
      } else if(children_str[i].equals("g") ) {
        String new_name = ancestral_name + children_xml[i].getString("id") ;
        if(!style) if(opacity_group == null || opacity_group == "none")  opacity_group = children_xml[i].getString("opacity") ;
        deep_analyze_SVG(header, style, children_xml[i], new_name, opacity_group) ;
      } 
    }
  }
  
  
  
  private void add_brick_SVG(String header, boolean style, XML target_brick, String ancestral_name, String opacity_group) {
    String name = target_brick.getName() ;
    if( name != null && ( name.equals("rect")
                         || name.equals("line")
                         || name.equals("polyline")
                         || name.equals("circle")
                         || name.equals("ellipse")
                         || name.equals("polygon")
                         || name.equals("path"))
                         || name.equals("text")
      ) {
      catch_brick_shape(header, style, target_brick, ancestral_name, opacity_group) ;
    }
  }
    




  /**
  CATCH INFO 
  */
  private String catch_header_SVG(XML target) {
    String s = "" ;
    String string_to_split = target.toString() ;
    String [] part = string_to_split.split("<") ;
    s = "<"+part[1] ;
    return s ;
  }
  
  
  private void catch_brick_shape(String header, boolean style, XML target, String ancestral_name, String opacity_group) {
    Brick_SVG new_brick = new Brick_SVG(header, style, target, ID_brick, ancestral_name, opacity_group) ;
    list_brick_SVG.add(new_brick) ;
    ID_brick++ ;
  }
  /**
  CHECK INFO
  */  
  private boolean check_kind_SVG(XML target_brick) {
    String kind_name = target_brick.getName() ;
    if(kind_name.equals("path")
       || kind_name.equals("rect") 
       || kind_name.equals("line") 
       || kind_name.equals("polyline") 
       || kind_name.equals("polygon")
       || kind_name.equals("circle")
       || kind_name.equals("ellipse")
       || kind_name.equals("text")
       ) {
      return true ;
    } else {
      return false ;
    }
  }

  private boolean check_g_shape(XML target) {
    boolean result = false ;
    if(target.getChild("g")!= null ) result = true ;
    else result = false ;
    return result ;

  }
  /**
  GET
  */
  private String get_kind_SVG(XML target) {
    String kind = "" ;
    if(target.getChild("path") != null ) kind = "path" ;
    else if(target.getChild("line")!= null ) kind = "line" ;
    else if(target.getChild("polyline")!= null ) kind = "polyline" ;
    else if(target.getChild("polygon")!= null ) kind = "polygon" ;
    else if(target.getChild("circle")!= null )kind = "circle" ;
    else if(target.getChild("ellipse")!= null ) kind = "ellipse" ;
    else if(target.getChild("rect")!= null ) kind = "rect" ;
    else if(target.getChild("text")!= null ) kind = "text" ;
    else if(target.getChild("g")!= null ) kind = "g" ;
    else kind = "no kind detected" ;
    return kind ;
  }
  /**
  END ANALYZE

  */
  
  






























  
  /**
  PRIVATE CLASS
  
  */
  /**
  class brick
  */
  private class Brick_SVG {
    private String file_name ;
    private String brick_name = "no name" ;
    private String family_name = "no name" ;
    private String kind = "" ;
    private int ID ;


    // attribut font
    /**
    may be not here but in the class Text with the build method ???
    */
    private PFont font = null  ;
    private float size_font = MAX_INT;
    private int alignment = MAX_INT ;
    // private String sentence = null ;

    private String font_str = null ;
    private String font_size_str = null ;
    private String alignment_str = null ;
    private String font_unit_str = null ;
    /**
    may be not here but in the class Text with the build method ???
    */



    // attribut colour
    private int fill, stroke ;
    private float strokeMitterlimit ;
    private float strokeWeight ;
    private float opacity, opacity_group ;
    private boolean noStroke, noFill ;

    // str
    private String fill_str = null;        
    private String stroke_str = null ;
    private String stroke_mitterlimit_str = null ;
    private String strokeWeight_str = null ;
    private String opacity_str = null ;


    private String clip_rule_str = null ;
    private String fill_rule_str = null ;



    private int width, height ;
    private XML xml_brick ;
    private boolean style ;
    private String built_svg_file = "" ;
   
    Brick_SVG(String header, boolean style, XML brick, int ID, String ancestral_name, String str_opacity_group) {
      this.style = style ;
      this.ID = ID ;
      built_svg_file = header + brick.toString() + "</svg>" ;
      xml_brick = parseXML(built_svg_file) ;
  
      brick_name = get_name(brick) ;
      family_name = ancestral_name + "_" + get_name(xml_brick) ;
      this.kind = get_kind_SVG(xml_brick) ;
      if(str_opacity_group != "none" && str_opacity_group != null) opacity_group = Float.valueOf(str_opacity_group.trim()).floatValue(); else opacity_group = 1.f ;
      set_aspect(brick) ;
    }
  
    public String get_name(XML target) {
      String name = "no name" ;
      if(target.getString("id") != null) name = target.getString("id") ;
      return name ;
    }

    public int get_id() {
      return ID;
    }

    /**
    aspect original
    */
    private void set_aspect(XML target) {
      // catch attribut
      if(style) {
        // style tag from last Illustrator CC
        catch_attribut_by_style(target) ;
      } else {
        // old data from illustrator CS
        catch_attribut(target) ;
      }
      


      // give attribut
      // font size
      if(font_size_str != null) {
        size_font = Float.parseFloat(font_size_str) ;
      }
      // font
      if(font_str != null) {
        String [] fontList = PFont.list() ;
        for(int i = 0 ; i < fontList.length ; i++) {
          if(font_str.equals(fontList[i])) {
            int size = 60 ;
            if(size_font != MAX_INT && size_font > size ) size = (int)size_font ;
            font = createFont(fontList[i], size) ;
          }
        }
      }

      // fill
      if(fill_str == null) {
        fill = 0xff000000 ; 
      } else if(fill_str.contains("none")) {
        noFill = true ;
      } else {
        String fill_temp = "" ;
        fill_temp = fill_str.substring(1) ;
        fill = unhex(fill_temp) ;
      }
      // stroke
      if(stroke_str == null) {
        stroke = MAX_INT ; 
      } else if(stroke_str.contains("none")) {
        noStroke = true ;
      } else {
        String stroke_temp = "" ;
        stroke_temp = stroke_str.substring(1) ;
        stroke = unhex(stroke_temp) ;
      }
      // strokeWeight
      if(strokeWeight_str == null  || strokeWeight_str.contains("none")) strokeWeight = 1.f ; 
      else strokeWeight = Float.valueOf(strokeWeight_str.trim()).floatValue();
      // stroke mitter
      if(stroke_mitterlimit_str == null  || stroke_mitterlimit_str.contains("none")) strokeMitterlimit = 10 ; 
      else strokeMitterlimit = Float.valueOf(stroke_mitterlimit_str.trim()).floatValue();
      // opacity
      if(opacity_str == null || opacity_str.contains("none")) opacity = 1.f ; 
      else opacity = Float.valueOf(opacity_str.trim()).floatValue();
      if(opacity == 1.f && opacity_group != 1.f) opacity = opacity_group ;
    }



    // super local method
    //
    // catch attribut classic SVG version 1
    private void catch_attribut(XML target) {
      fill_str =  target.getString("fill") ;        
      stroke_str =  target.getString("stroke") ;
      stroke_mitterlimit_str =  target.getString("stroke-mitterimit") ;
      strokeWeight_str =  target.getString("stroke-width") ;
      opacity_str =  target.getString("opacity") ;

      font_str = target.getString("font-family") ;
      font_size_str = target.getString("font-size") ;

      clip_rule_str = target.getString("clip-rule") ;
      fill_rule_str = target.getString("fill-rule") ;
    }

    // catch attribut style SVG version 2
    private void catch_attribut_by_style(XML target) {
      String style_id = target.getString("class") ;
      // catch the style in the style list
      String [] id = split(style_id, "st") ;
      // clean white space in the String array, because for the class text there is few style, and there is white space between each one.
      if(id.length > 1) {
        for(int i = 0 ; i < id.length ;i++) {
          if(id[i].contains(" ")) id[i] = id[i].replaceAll(" ", "") ;
          if(i != 0) { 
            int which_style = Integer.parseInt(id[i]) ;
            String my_style = st[which_style] ;
            if(my_style.contains("}") ) {
              my_style = my_style.replaceAll("}","") ;
            }
            if(my_style.contains("{")) {
              my_style = my_style.substring(1) ;
            }

            String [] attribut = split(my_style,";") ;
            // loop to check all component of style
            for(int k = 0 ; k < attribut.length ; k++) {
              if(attribut[k].contains("fill:")) {
                String [] final_data = attribut[k].split(":") ;
                fill_str = final_data[1] ;
              }
              if(attribut[k].contains("stroke:")) {
                String [] final_data = attribut[k].split(":") ;
                stroke_str = final_data[1] ;
              }
              if(attribut[k].contains("stroke-mitterlimit:")) {
                String [] final_data = attribut[k].split(":") ;
                stroke_mitterlimit_str = final_data[1] ;
              }
              if(attribut[k].contains("stroke-width:")) {
                String [] final_data = attribut[k].split(":") ;
                strokeWeight_str = final_data[1] ;
              }
              if(attribut[k].contains("opacity:")) {
                String [] final_data = attribut[k].split(":") ;
                opacity_str = final_data[1] ;
              }
              if(attribut[k].contains("font-family:")) {
                String [] final_data = attribut[k].split(":") ;
                font_str = final_data[1] ;
              }
              if(attribut[k].contains("font-size:")) {
                String [] final_data = attribut[k].split(":") ;
                font_size_str = final_data[1] ;
              }
              if(attribut[k].contains("clip-rule:")) {
                String [] final_data = attribut[k].split(":") ;
                clip_rule_str = final_data[1] ;
              }
              if(attribut[k].contains("fill-rule:")) {
                String [] final_data = attribut[k].split(":") ;
                fill_rule_str = final_data[1] ;
              }
            }
          }
        }
      }
      // clear
      if(font_str != null) {
        if(font_str.contains("'")) {
          font_str = font_str.replaceAll("'","") ;
        }
      } 
      
      // split size and unit type for font
      if(font_size_str != null) {
        if(font_size_str.endsWith("pt")) {
          font_unit_str = "pt" ;
          font_size_str = font_size_str.replaceAll("pt","") ; // * 1.25f;
        } else if (font_size_str.endsWith("pc")) {
          font_unit_str = "pc" ;
          font_size_str = font_size_str.replaceAll("pc","") ; // * 15;
        } else if (font_size_str.endsWith("mm")) {
          font_unit_str = "mm" ;
          font_size_str = font_size_str.replaceAll("mm","") ; // * 3.543307f;
        } else if (font_size_str.endsWith("cm")) {
          font_unit_str = "cm" ;
          font_size_str = font_size_str.replaceAll("cm","") ; // * 35.43307f;
        } else if (font_size_str.endsWith("in")) {
          font_unit_str = "in" ;
          font_size_str = font_size_str.replaceAll("in","") ; // * 90;
        } else if (font_size_str.endsWith("px")) {
          font_unit_str = "px" ;
          font_size_str = font_size_str.replaceAll("px","") ;
        } else if (font_size_str.endsWith("%")) {
          font_unit_str = "%" ;
          font_size_str = font_size_str.replaceAll("%","") ;
        }
      }
    }

    
    
    
    private void aspect_fill(vec4 factor) {
      // HSB mmode
      if(noFill) {
        p5.noFill() ;
      } else {
        if(g.colorMode == 3) {
          p5.fill(hue(fill) *factor.x, saturation(fill) *factor.y, brightness(fill) *factor.z, opacity *g.colorModeA *factor.w) ;
        // RGB mmode
        } else if( g.colorMode == 1 ) {
          float red_col = red(fill) *factor.x ;
          float alpha_col = opacity *g.colorModeA *factor.w ;
          alpha_col = opacity *g.colorModeA *factor.w  ;
          p5.fill(red_col, green(fill) *factor.y, blue(fill) *factor.z, alpha_col) ;
        }
      }
    }

    private void aspect_stroke(float scale, vec4 factor) {
      if(noStroke) {
        p5.noStroke() ;
      } else {
        float thickness = strokeWeight ;
        if(scale != 1 ) thickness *= scale ;
        // HSB mmode
        if(g.colorMode == 3) {
          if(strokeWeight <= 0 || stroke == MAX_INT )  {
            p5.noStroke() ;
          } else {
            p5.strokeWeight(thickness) ;
            p5.stroke(hue(stroke) *factor.x, saturation(stroke) *factor.y, brightness(stroke) *factor.z, opacity *g.colorModeA *factor.w) ; 
          }
        // RGB mmode
        } else if( g.colorMode == 1 ) {
          if(strokeWeight <= 0 || stroke == MAX_INT)  {
            p5.noStroke() ;
          } else {
            p5.strokeWeight(thickness) ;
            p5.stroke(red(stroke) *factor.x, green(stroke) *factor.y, blue(stroke) *factor.z, opacity *g.colorModeA *factor.w) ; 
          }
        }
      }
    }
  }
  

















  /**
  Class Text
  */

  private class ROPEText {
    String shape_name ;
    vec3 pos ;
    vec6 matrix ;
    int ID ;
    String sentence = null ;
  
    ROPEText (vec6 matrix, String sentence, int ID) {
      this.ID = ID ;
      this.pos = vec3(matrix.e, matrix.f,0) ;
      this.matrix = matrix ;

      this.sentence = sentence ;
    }
    
    public void add_value(vec3... value) {
      pos.add(value[0]) ;
    }

    public int get_id() {
      return ID;
    }
  }

  /**
  Class Line
  */
  private class Line {
    String shape_name ;
    vec3 pos_a, pos_b ;
    int ID ;
  
    Line(float x_a, float y_a,  float x_b, float y_b, int ID) {
      this.ID = ID ;
      this.pos_a = vec3(x_a, y_a,0) ;
      this.pos_b = vec3(x_b, y_b,0) ;
    }
    
    public void add_value(vec3... value) {
      pos_a.add(value[0]) ;
      pos_b.add(value[0]) ;
    }
  }



    
  
  /**
  class to build all specific group
  */
  private class Vertices {
    String shape_name = "my name is noboby" ;
    vec2 size ;
    vec3 [] vert ;
    int [] vertex_code ;
    int code_vertex_count ;
    int num ;
    int ID ;
    
    Vertices(int code_vertex_count, int num, PShape p, String mother_name, int ID) {
      this.ID = ID ;
      this.num = num ;
      // not sur we need this shape_name !
      this.shape_name = mother_name + "<>" +p.getName() ;
  
      this.code_vertex_count = code_vertex_count ;
      
      vert = new vec3[num] ;
      vertex_code = new int[num] ;
      vertex_code = p.getVertexCodes() ;
      size = vec2(p.width, p.height);
    }
    
    public void build_vertices_3D(PShape path) {
      for(int i = 0 ; i < num ; i++) {
        vert[i] = vec3(path.getVertex(i)) ;
      }
    }
    
    public vec3 [] vertices() {
      return vert ;
    }

    public void add_value(vec3... value) {
      if(value.length <= vert.length) {
        for(int i = 0 ; i < value.length ; i++) {
          vert[i].add(value[i]) ;
        }
      } else {
        for(int i = 0 ; i < vert.length ; i++) {
          vert[i].add(value[i]) ;
        }
      }
    }
  }


  /**
  Class Ellipse
  */

  private class Ellipse {
    String shape_name ;
    vec3 pos ;
    vec2 size ;
    vec6 matrix ;
    int ID ;
  
    Ellipse(vec6 matrix, float cx, float cy,  float rx, float ry, int ID) {
      this.matrix = matrix ;
      this.ID = ID ;
      this.pos = vec3(cx, cy,0) ;
      this.size = vec2(rx, ry).mult(2) ;
    }
    
    public void add_value(vec3... value) {
      pos.add(value[0]) ;
    }
  }

  /**
  Class Rectangle
  */
  private class Rectangle {
    String shape_name ;
    vec3 pos ;
    vec2 size ;
    vec6 matrix ;
    int ID ;
  
    Rectangle(vec6 matrix, float x, float y,  float width_rect, float height_rect, int ID) {
      this.matrix = matrix ;
      this.ID = ID ;
      this.pos = vec3(x, y,0) ;
      this.size = vec2(width_rect, height_rect) ;
    }
    
    public void add_value(vec3... value) {
      pos.add(value[0]) ;
    }
  }
  /**
  END OF PRIVATE CLASS

  */
}
/**
END OF MAIN CLASS

*/
/**
ITEM 1.2.0
*/
public void item_inventory() {
  int num_group = 1;
  for (TableRow row : inventory_item_table.rows()) {
    int item_group = row.getInt("Group");
    for (int i = 1 ; i <= num_group ; i++) {
      if (item_group == i) NUM_ITEM++;
    }
  }
  println("Items:", NUM_ITEM);
}

public void info_item() {
  item_info_raw[0] = item_info[0] = ("") ;
  // the list start from '1' so we must init the '0'
  for(int i = 0 ; i < NUM_ITEM ; i++) {
    TableRow lookFor = inventory_item_table.getRow(i);
    int ID = lookFor.getInt("ID");
    for(int j = 0 ; j <= NUM_ITEM ; j++) {
      if(ID == j) { 
        /* 
        item_info_raw is used to call the save in the order of the item labrary ID, not alphabetic
        item_info is used to display in the alphabetic order, but when is calling the order alphabetic doesn't exist,
        and it's necessary to order it, but after that is not possible back to original order, it's a reason
        to create a raw list for the next loading item list :( very messy :( 
        */
        item_info_raw[j] = lookFor.getString("Name") + "/" +lookFor.getInt("ID") + "/" +lookFor.getInt("Library Order") ;
        item_info[j] = item_info_raw[j];
        item_name[j] = lookFor.getString("Name");
        item_ID [j] = lookFor.getInt("ID");

        item_group[j] = lookFor.getInt("Group");
        item_pack[j] = lookFor.getString("Pack");

        item_author[j] = lookFor.getString("Author");
        item_version[j] = lookFor.getString("Version");
        item_load_name[j] = lookFor.getString("Class name");
        item_slider[j] = lookFor.getString("Slider");
      }
    }
  }
}



public void create_and_initialize_data() {
  inventory_item_table = loadTable(preference_path+"index_romanesco_items.csv","header");
  shader_fx_table = loadTable(preference_path+"index_fx.csv","header");
  shader_background_table = loadTable(preference_path+"index_fx_background.csv","header");
  item_inventory();
  init_var_item();

  init_inventory();
  init_button_inventory();

  init_button_item_console();

  info_item();
  info_shader_background();
  info_shader_fx();
}

public void init_var_item() {
  item_group = new int [NUM_ITEM +1];
  item_GUI_on_off = new int [NUM_ITEM +1];

  item_info_raw = new String [NUM_ITEM +1];
  item_info = new String [NUM_ITEM +1];
  item_ID = new int [NUM_ITEM +1];

  item_author = new String [NUM_ITEM +1];
  item_name = new String [NUM_ITEM +1];
  item_version = new String [NUM_ITEM +1];
  item_pack = new String [NUM_ITEM +1];
  item_load_name = new String [NUM_ITEM +1];
  item_slider = new String [NUM_ITEM +1];
}




/**
Item console
*/
Button_dynamic[] button_item ;

public void init_button_item_console() {
  int num = BUTTON_ITEM_CONSOLE;
  button_item_num = NUM_ITEM *num;
  value_button_item = new int[button_item_num] ;
  // button item
  button_item = new Button_dynamic[button_item_num +num];
  println("init_button_item_console()",frameCount);
  pos_button_width_item = new int[button_item_num +num];
  pos_button_height_item = new int[button_item_num +num];
  width_button_item = new int[button_item_num +num];
  height_button_item = new int[button_item_num +num];

  item_button_state = new boolean[button_item_num]; 
}

public void init_inventory() {
  inventory = new Inventory[NUM_ITEM +1] ;
  for(int i = 0 ; i < inventory.length ; i++ ) {
    inventory[i] = new Inventory("", true);
  }
}


public void build_button_item_console() {
  for ( int i = BUTTON_ITEM_CONSOLE ; i < button_item_num +BUTTON_ITEM_CONSOLE; i++) {
    if(NUM_ITEM > 0) {
      ivec2 pos = ivec2(pos_button_width_item[i], pos_button_height_item[i]);
      ivec2 size = ivec2(width_button_item[i], height_button_item[i]); 
      button_item[i] = new Button_dynamic(pos, size);
      button_item[i].set_aspect_on_off(button_on_in,button_on_out,button_off_in,button_off_out);
      // here we give information for the item button, we need later to manage the dynamic GUI
      int ID_temp = i / BUTTON_ITEM_CONSOLE ; // because there is few button by item
      String [] temp = split(item_info[ID_temp], "/") ;
      button_item[i].set_label(temp[0]) ;
      button_item[i].set_id(Integer.parseInt(temp[1]));
      button_item[i].set_rank(Integer.parseInt(temp[2]));
    } 
  }
}







// LOCAL METHOD SETUP
public void set_button_item_console() {
  ivec2 pos_main_button = ivec2(7, -10) ;
  ivec2 pos_param_button = ivec2(7,14) ;
  ivec2 pos_sound_button = ivec2(7,25) ;
  ivec2 pos_action_button = ivec2(19,25) ;

  int pos_y = pos_y_item_selected +local_pos_y_button_item;
  //position and area for the rollover
  int num = BUTTON_ITEM_CONSOLE;
  for (int i = 1 ; i <= NUM_ITEM ; i++) {
    //main
    pos_button_width_item[i*num+0] = offset_x_item +pos_main_button.x; 
    pos_button_height_item[i*num+0] = pos_y +pos_main_button.y; 
    width_button_item[i*num+0] = 20 ; 
    height_button_item[i*num+0] = 20 ;  
    //setting
    pos_button_width_item[i*num+1] = offset_x_item +pos_param_button.x; 
    pos_button_height_item[i*num+1] = pos_y +pos_param_button.y; 
    width_button_item[i*num+1] = 19 ; 
    height_button_item[i*num+1] = 6 ; 
    //sound
    pos_button_width_item[i*num+2] = offset_x_item +pos_sound_button.x; 
    pos_button_height_item[i*num+2] = pos_y +pos_sound_button.y; 
    width_button_item[i*num+2] = 10 ; 
    height_button_item[i*num+2] = 6 ; 
    //action
    pos_button_width_item[i*num+3] = offset_x_item +pos_action_button.x; 
    pos_button_height_item[i*num+3] = pos_y +pos_action_button.y; 
    width_button_item[i*num+3] = 10 ; 
    height_button_item[i*num+3] = 6 ; 
  }
}

public void display_button_item_console(boolean keep_setting) {
  int pointer = 0 ;
  for(int i = 1 ; i <= NUM_ITEM ; i++) {
    if(inventory[i].is()) {
      int distance = pointer *DIST_BETWEEN_ITEM;
      for(int j = 0 ; j < BUTTON_ITEM_CONSOLE ; j++) {
        int rank = i*BUTTON_ITEM_CONSOLE+j;
        button_item[rank].change_pos(distance, 0);
        button_item[rank].update_pos(inventory[i].is());
        button_item[rank].update(mouseX,mouseY,dropdown_is());

        if(j == 0) {
          PImage [] pic = {ON_in_thumbnail[i], ON_out_thumbnail[i],OFF_in_thumbnail[i], OFF_out_thumbnail[i]};
          button_item[rank].show_picto(pic);
        }
        if(j == 1) button_item[rank].show_picto(picSetting);
        if(j == 2) button_item[rank].show_picto(picSound); 
        if(j == 3) button_item[rank].show_picto(picAction);

      }
      int px = pos_button_width_item[i*BUTTON_ITEM_CONSOLE +2] +distance;
      int py = pos_button_height_item[i*BUTTON_ITEM_CONSOLE +1] -15;
      ivec2 pos = ivec2(px,py);
      ivec2 size = ivec2(20,100);
      item_thumbnail_info(pos,size,i,1);
      pointer ++ ;
    } else if(!keep_setting) {
      for(int jj = 0 ; jj < BUTTON_ITEM_CONSOLE ; jj++) {
        int rank = i*BUTTON_ITEM_CONSOLE+jj;
        if(jj == 0) button_item[rank].set_is(false); // show item
        if(jj == 1) button_item[rank].set_is(false); // setting item
        if(jj == 2) button_item[rank].set_is(false); // setting sound
        if(jj == 3) button_item[rank].set_is(false); // setting action
      }
    } 
  }
}


public void check_button_item_console() {
  if(NUM_ITEM > 0){
    // item available
    int num = button_item_num +BUTTON_ITEM_CONSOLE;
    for(int i = BUTTON_ITEM_CONSOLE ; i < num ; i++) {
      if(button_item[i].is()) {
        item_button_state[i-BUTTON_ITEM_CONSOLE] = true; 
      } else {
        item_button_state[i-BUTTON_ITEM_CONSOLE] = false;
      }
    }
  }
}

public void mousepressed_button_item_console() {
  if(!dropdown_is() && NUM_ITEM > 0) {
    for(int i = BUTTON_ITEM_CONSOLE ; i < NUM_ITEM *BUTTON_ITEM_CONSOLE +BUTTON_ITEM_CONSOLE ; i++) {
      button_item[i].update_pos(inventory[i/BUTTON_ITEM_CONSOLE].is());
      if(button_item[i].inside()) button_item[i].switch_is();
    }
  }
}












/**
ITEM INVENTORY
*/
Button[] button_inventory ;
boolean [] on_off_inventory_save ;

public void init_button_inventory() {
  button_inventory = new Button[NUM_ITEM +1] ;
  on_off_inventory_save = new boolean[NUM_ITEM +1] ;
}

public void build_inventory() {
  for(int i = 0 ; i < button_inventory.length ; i++) {
    if(button_inventory[i] == null) {
      button_inventory[i] = new Button();
    }
  }
}

public void set_button_inventory() {
  ivec2 pos = ivec2();
  ivec2 size = ivec2();
  height_inventory = height -pos_y_inventory ;

  int h = 12 ;
  int spacing = h + (h /4 ) ;
  int num_item_by_col = PApplet.parseInt(PApplet.parseFloat(height_inventory) /(spacing *1.2f)) ;

  int max_size_col = num_item_by_col *spacing;
  int col_size_list_item = 80 ;
  int left_flag = grid_col[0] +10 ;
  int top_text = pos_y_inventory -(h/2);
  int ratio_rollover_x = 9 ;

  item_info = sort(item_info) ;
  // build button
  for(int i = 0 ; i < button_inventory.length ; i++) {
    int step = i *spacing;
    String [] temp_item_info_split = split(item_info[i], "/");
    int w = width_String(temp_item_info_split[0], ratio_rollover_x);
    if(temp_item_info_split[0] != "" ) {
      // Must be optimized, it's very very very too long, too much, too bad, too too...
      if(i <= num_item_by_col) {
        pos = ivec2(left_flag, top_text +step);
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col && i <= num_item_by_col *2) {
        
        pos = ivec2(left_flag +col_size_list_item, top_text +step -max_size_col);
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *2 && i <= num_item_by_col *3) {
        
        pos = ivec2(left_flag +(col_size_list_item *2), top_text +step -(max_size_col *2));
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *3 && i <= num_item_by_col *4) {
        pos = ivec2(left_flag +(col_size_list_item *3), top_text +step -(max_size_col *3));
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *4 && i <= num_item_by_col *5) {
        pos = ivec2(left_flag +(col_size_list_item *4), top_text +step -(max_size_col *4));
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *5 && i <= num_item_by_col *6) {
        pos = ivec2(left_flag +(col_size_list_item *5), top_text +step -(max_size_col *5));
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size) ;
      } else if (i > num_item_by_col *6 && i <= num_item_by_col *7) {
        pos = ivec2(left_flag +(col_size_list_item *6), top_text +step -(max_size_col *6));
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *7 && i <= num_item_by_col *8) {
        pos = ivec2(left_flag +(col_size_list_item *7), top_text +step -(max_size_col *7));
        size = ivec2(w,h);
        button_inventory[i].pos(pos) ;
        button_inventory[i].size(size) ;
      } else if (i > num_item_by_col *8 && i <= num_item_by_col *9) {
        pos = ivec2(left_flag +(col_size_list_item *8), top_text +step -(max_size_col *8));
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      } else if (i > num_item_by_col *9 && i <= num_item_by_col *10) {
        pos = ivec2(left_flag +(col_size_list_item *9), top_text +step -(max_size_col *9));
        size = ivec2(w,h);
        button_inventory[i].pos(pos);
        button_inventory[i].size(size);
      }
    }
  }
}

public void set_inventory_item(boolean keep_state) {
  boolean local_state = keep_state ;
  //color col_off_out_menu_item = rougeTresTresFonce ;
  // give the the good statement
  for( int i = 0 ; i < button_inventory.length ; i++) {
    if(item_info[i] != "" ) {
      button_inventory[i].set_aspect_on_off(button_on_in,button_on_out,button_off_in,button_off_out) ;

      String [] temp_item_info_split = split(item_info[i], "/") ;
      button_inventory[i].set_label(temp_item_info_split[0]);
      button_inventory[i].set_font_size(12);
      button_inventory[i].set_font(textUsual_3);
      button_inventory[i].set_id(Integer.parseInt(temp_item_info_split[1])) ;
      button_inventory[i].set_rank(Integer.parseInt(temp_item_info_split[2])) ;
      // start a second loop to check again if the saved name is ok with the alphabetical sort of the item.
      for(int j = 0 ; j < inventory.length ; j++) {
        if(inventory[j].name.equals(button_inventory[i].name) && !keep_state) {
          if(INIT_INTERFACE) {
            button_inventory[i].set_is(inventory[j].is()) ;
          } else {
            button_inventory[i].set_is(on_off_inventory_save[i]) ;
            inventory[j].set_is(on_off_inventory_save[i]) ;
          }
        }
      }
    }
  }
}

public void display_button_inventory() {
  if(item_info.length > 0) {
    for(int i = 0 ; i < item_info.length ; i++) {
      if(item_info[i] != "" && button_inventory[i].pos != null) {
       button_inventory[i].show_label();
      }
    }
  }
}

public void update_button_inventory() {
  if(item_info.length > 0) {
    for(int i = 0 ; i < item_info.length ; i++) {
      if(item_info[i] != "" && button_inventory[i].pos != null) {
       button_inventory[i].update(mouseX,mouseY,dropdown_is());
      }
    }
  }
}


public void check_button_inventory() {
  // Check to display or not the item in the controller
  if( NUM_ITEM > 0 && !INIT_INTERFACE ) {
    for(int i = 1 ; i < button_inventory.length ; i++) {
      // here it's boolean not an int because we don't need to send it via OSC.
      int ID = button_inventory[i].get_id() ;
      if(button_inventory[i].is()) {
        inventory[ID].set_is(true); // use ID item
      } else { 
        inventory[ID].set_is(false);
      }
    }
  }
}

public void mousepressed_button_inventory() {
  if( NUM_ITEM > 0 ) {
    for(int i = 1 ; i < button_inventory.length ; i++ ) {
      if(button_inventory[i].inside()) button_inventory[i].switch_is();
    }
    for(int i = 1 ; i < on_off_inventory_save.length ; i++ ) {
      on_off_inventory_save[i] = button_inventory[i].is() ;
    }
  }
}



/**
* Keyboard and Shortcut
* 2015-2019
* v 1.1.0
*/

/**
SHORTCUTS
*/
public void shortcuts_controller() {
  keyboard[keyCode] = true;
  if(key_pressed(KEY_CTRL_OS) && key_pressed(KeyEvent.VK_X) ) {
    if(system().equals("Mac OS X")) {
      println("CMD + x: change slider display mode", frameCount);
    } else {
      println("CTRL + x: change slider display mode", frameCount);
    }
    slider_mode_display += 1;
    if(slider_mode_display > 2 ) slider_mode_display = 0;
  }

  // save controller
  key_pressed_save_controller_CURRENT_path();
  key_pressed_save_controller_NEW_path();
  // load
  key_pressed_load_controller();
  // media
  key_pressed_media_input();
  key_pressed_media_folder();
  key_pressed_shift();
}









/**
KEYBOARD CONTROLLER 1.0.1
*/
public boolean key_pressed(int c) {
  if (keyboard.length >= c) {
    return keyboard[c];  
  }
  return false;
}
/**
simple touch
*/
boolean shift_key ;
public void key_pressed_shift() {
  if(key_pressed(SHIFT)) { 
    shift_key = true;
    keyboard[keyCode] = false; 
  }
}

public void key_false() {
  shift_key = false;
}

/**
LOAD SAVE
*/
boolean load_media_input;
boolean load_media_folder;
/**
LOAD
*/

public void key_pressed_media_input() {
  if(key_pressed(KEY_CTRL_OS) && key_pressed(KeyEvent.VK_I)) {
    if(system().equals("Mac OS X")) {
      println("CMD + i: load media input",frameCount);
    } else {
      println("CTRL + i: load media input",frameCount);
    }
    select_input();
    load_media_input = true;
    keyboard[keyCode] = false;
  }
}

public void key_pressed_media_folder() {
  if(key_pressed(KEY_CTRL_OS) && key_pressed(KeyEvent.VK_F)) {
    if(system().equals("Mac OS X")) {
      println("CMD + f: load media folder",frameCount);
    } else {
      println("CTRL + f: load media folder",frameCount);
    }
    select_folder();
    load_media_folder = true;
    keyboard[keyCode] = false;
  }
}



public void key_pressed_load_controller() {
  if(key_pressed(KEY_CTRL_OS) && key_pressed(KeyEvent.VK_O)) { 
    if(system().equals("Mac OS X")) {
      println("CMD + o: load controller",frameCount);
    } else {
      println("CTRL + o: load controller",frameCount);
    }
    selectInput("Load setting controller", "load_setting_controller"); // ("display info in the window" , "name of the method callingBack" )
    keyboard[keyCode] = false;   //  
  }
}



/**
SAVE
*/
public void key_pressed_save_controller_CURRENT_path() {
  if(key_pressed(KEY_CTRL_OS) && key_pressed(KeyEvent.VK_R)) {
    if(system().equals("Mac OS X")) {
      println("CMD + r: save controller on the last save controller",frameCount);
    } else {
      println("CTRL + r: save controller on the last save controller",frameCount);
    }
    show_all_slider_item = true ;
    if (savePathSetting.equals("")) {
      File tempFileName = new File ("your_controller_setting.csv");
      selectOutput("Save setting", "save_controller_setting", tempFileName);
    } else save_controller_setting(savePathSetting) ;
    keyboard[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
}
// Controller new save
// CTRL + SHIFT + E
public void key_pressed_save_controller_NEW_path() {
  if(key_pressed(KEY_CTRL_OS) && key_pressed(KeyEvent.VK_E)) {
    if(system().equals("Mac OS X")) {
      println("CMD + e: save new controller save",frameCount);
    } else {
      println("CTRL + e: save new controller save",frameCount);
    }
    show_all_slider_item = true ; 
    File tempFileName = new File ("your_controller_setting.csv");
    selectOutput("Save setting", "save_controller_setting", tempFileName);
    keyboard[keyCode] = false ;  // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
}






/**
ADD MEDIA
v 0.1.1
*/
String input_ref;
public void add_media() {
  if(load_media_input && input() != null && !input().equals(input_ref)) {
    input_ref = input();
    add_media(input());
    load_media_input = false;
    autosave();  
  }

  if(load_media_folder) { 
    boolean explore_sub_folder = false;
    explore_folder(folder(),explore_sub_folder,
                            "mov","MOV","AVI","AVI","mkv","MKV","mp4","MP4",
                            "jpeg","JPEG","jpg","jpeg","tif","TIF","tiff","TIFF","tga","TGA","gif","GIF",
                            "txt","TXT",
                            "svg","SVG");
    if(get_files() != null && get_files().size() > 0) {
      for(File f : get_files()) {
        println(f.getAbsolutePath());
        add_media(f.getAbsolutePath());
      }
      load_media_folder = false;
      get_files().clear();
    }
    autosave();  
  }
}





public void update_media() {
  //text
  file_text_dropdown_list = new String[text_files.size()] ;
  for(int i = 0 ; i< file_text_dropdown_list.length ; i++) {
    File f = (File) text_files.get(i);
    file_text_dropdown_list[i] = naming_media_file(f);
  }

  // bitmap
  bitmap_dropdown_list = new String[bitmap_files.size()] ;
  for(int i = 0 ; i< bitmap_dropdown_list.length ; i++) {
    File f = (File) bitmap_files.get(i);
    bitmap_dropdown_list[i] = naming_media_file(f);
  }

  // shape
  shape_dropdown_list = new String[svg_files.size()] ;
  for(int i = 0 ; i< shape_dropdown_list.length ; i++) {
    File f = (File) svg_files.get(i);
    shape_dropdown_list[i] = naming_media_file(f);
  }

  // Movie
  movie_dropdown_list = new String[movie_files.size()] ;
  for(int i = 0 ; i < movie_dropdown_list.length ; i++) {
    File f = (File) movie_files.get(i);
    movie_dropdown_list[i] = naming_media_file(f);
  }
}


public String naming_media_file(File f) {
  String name = f.getName();
  String ext = extension(name);
  String remove = "."+ext;
  name = name.replace(remove,"");
  if(name.length() > 13) {
    String begin = name.substring(0,6);
    String end = name.substring(name.length() -4);
    name = begin+"..."+end;
    // check for dead link
  }
  if(!f.exists()) {
    name = "<"+name+ ">";
  }
  return name;
}




/**
MIDI CONTROL
v 2.1.1
2014-2018
*/
boolean reset_midi_selection;

public void init_midi() {
  check_midi_input();
  open_midi_bus();
  select_first_midi_input();
}

public void update_midi() {
  midi_select(which_midi_input, num_midi_input);
  use_specific_midi_input(which_midi_input);
}

public void reset_midi_control_parametter() {
  reset_midi_selection = false;
}













/**
MAIN METHOD
*/
 
MidiBus [] myBus; 
int  num_midi_input;
int which_midi_input = -1;
boolean choice_midi_device, choice_midi_default_device;
String [] name_midi_input;
String [] ID_midi_input;
public void check_midi_input() {
  name_midi_input = MidiBus.availableInputs();
  num_midi_input = name_midi_input.length;
  ID_midi_input = new String[num_midi_input];
}


public void open_midi_bus() {
  myBus = new MidiBus[num_midi_input] ;
  for(int i = 0 ; i < num_midi_input ; i++) {
    myBus [i] = new MidiBus(this, i, "Java Sound Synthesizer");
    ID_midi_input [i] = myBus [i].getBusName() ;
  }
}

public void select_first_midi_input() {
  if (num_midi_input > 0 && !choice_midi_device && !choice_midi_default_device) which_midi_input = 0 ;
}

public void close_midi_input_bus() {
  for(int i = 0 ; i < num_midi_input ; i++) {
      myBus [i].close() ;
  }
}



// info from controller midi device
int midi_channel, midi_CC, midi_value ; 
long long_timestamp ;
String midi_bus_name ;
// this void is an upper method like draw, setup, setting...
public void controllerChange(int channel, int CC, int value, long timestamp, String bus_name) {
  midi_channel = channel ;
  midi_CC = CC ;
  midi_value = value ;
  midi_bus_name = bus_name ;
  long_timestamp = timestamp ;
}







































// give the midi info to the romanesco variable
public void use_specific_midi_input(int ID) {
  if(ID_midi_input != null && ID >= 0 && ID < ID_midi_input.length) {
    if(ID_midi_input[ID].equals(midi_bus_name)) {
      midi_channel_romanesco = midi_channel ;
      midi_CC_romanesco = midi_CC ;
      midi_value_romanesco = midi_value ;
    }
  }
  if(ID >= ID_midi_input.length) {
    printErr("No MIDI devices match with your request");
  }
}


// Give new midi device to Romanesco
public void open_input_midi(int which_one, int num) {
  if ((!choice_midi_device || !choice_midi_default_device) &&  which_one != -1 && which_one < num) {
    use_specific_midi_input(which_one) ;
    choice_midi_default_device = true ;
    choice_midi_device = true ;
  }
}

// reset 
public void reset_input_midi_device() {
  if (which_midi_input >= 0 ) {
    which_midi_input = -1 ;
    choice_midi_device = false ;
  }
}









// DISPLAY INFO MIDI INPUT
public void display_midi_device_available(vec2 pos, int spacing) {
  int num_line = 0 ;
  if (!choice_midi_device || !choice_midi_default_device) {
    text("Press the ID number to select an input Midi", pos.x, pos.y) ;

    text(num_midi_input + " device(s) available(s)", pos.x, pos.y +spacing) ;
    for (int i = 0; i < num_midi_input; i++) {
      num_line = i +2 ;
      // to make something clean for the reading
      String ID_input = "" +i ;
      if (i > 9 ) ID_input = nf(i, 2) ;
      //
      text("input device "+ID_input+": "+name_midi_input [i], pos.x, pos.y +(num_line *spacing));
    }
  }
}



public void display_select_midi_device(vec2 pos, int spacing) {
  if(which_midi_input < num_midi_input ) {
    if (which_midi_input >= 0 && (choice_midi_device || choice_midi_default_device)) {
      text("Current midi device is " + name_midi_input [which_midi_input], pos.x, pos.y) ;
      text("If you want choice an other input press “N“ ", pos.x, pos.y + spacing) ;
    }
  } else {
    choice_midi_device = false ;
  }
}



public void window_midi_info(vec2 pos, int size_x, int spacing) {
  int pos_x = (int)pos.x -(spacing/2) ;
  int pos_y = (int)pos.y -spacing ;
  int size_y = 0 ;
  if (!choice_midi_device || !choice_midi_default_device) {
    size_y = PApplet.parseInt(spacing *2.5f +(spacing *(num_midi_input *1.2f))) ;
  } else {
    size_y = PApplet.parseInt(spacing *2.5f) ;
  }
  rect(pos_x, pos_y, size_x, size_y) ;
}











// ANNEXE don't need MIDI LIBRARIE CODE
boolean init_midi ;
public void midi_select(int which_one, int num) {
  if(selectMidi || !init_midi) {
    open_input_midi(which_one, num) ;
    init_midi = true ;
  }

  if(selectMidi) {  
    if(num < 1 ) {
      fill(fill_midi_no_selection); 
    } else {
      fill(fill_midi_selection);
    }
    noStroke();
    window_midi_info(pos_midi_info, size_x_window_info_midi, spacing_midi_info) ;

    textFont(textUsual_1);  
    textAlign(LEFT);
    if(num < 1 ) {
      fill(fill_midi_window_no_selection); 
    } else {
      fill(fill_midi_window_selection);
    }

    display_select_midi_device(pos_midi_info, spacing_midi_info) ;
    display_midi_device_available(pos_midi_info, spacing_midi_info) ;
  }



  if (button_midi_is == 1) {
    selectMidi = true; 
  } else {
    selectMidi = false;
  }
}


public void select_input_midi_device() {
  if (key == '0') which_midi_input = 0 ;
  if (key == '1') which_midi_input = 1 ;
  if (key == '2') which_midi_input = 2 ;
  if (key == '3') which_midi_input = 3 ;
  if (key == '4') which_midi_input = 4 ;
  if (key == '5') which_midi_input = 5 ;
  if (key == '6') which_midi_input = 6 ;
  if (key == '7') which_midi_input = 7 ;
  if (key == '8') which_midi_input = 8 ;
  if (key == '9') which_midi_input = 9 ;
}

public void keypressed_midi() {
  if (!choice_midi_device) {
    select_input_midi_device();
  }
  if (key =='n' && choice_midi_device) {
    reset_input_midi_device();
  }
  if(keyCode == BACKSPACE || keyCode == DELETE) {
    if(selectMidi) {
      reset_midi_selection = true;
    }   
  } 
}









/**
MIDI MANAGER
*/
public void midi_manager(boolean saveButton) {
  int rank = 0 ;
  midi_button(button_bg,rank,saveButton,"Button background");
  rank++;
  midi_button(button_curtain,rank,saveButton,"Button curtain");
  rank++;
  midi_button(button_reset_camera,rank,saveButton,"Button reset camera");
  rank++;
  midi_button(button_reset_item_on,rank,saveButton,"Button reset ative item position");
  rank++;
  midi_button(button_birth,rank,saveButton,"Button birth");
  rank++;
  midi_button(button_3D,rank,saveButton,"Button 3D");
  rank++;

  for(int i = 0 ; i < NUM_BUTTON_FX ; i++) {
    midi_button(button_fx[i],rank,saveButton,"Button fx");
    rank++;
  }
  midi_button(button_light_ambient,rank,saveButton,"Button light ambient");
  rank++;
  midi_button(button_light_ambient_action,rank,saveButton,"Button light ambient");
  rank++;
  midi_button(button_light_1,rank,saveButton,"Button light 1");
  rank++;
  midi_button(button_light_1_action,rank,saveButton,"Button light 1");
  rank++;
  midi_button(button_light_2,rank,saveButton,"Button light 2");
  rank++;
  midi_button(button_light_2_action,rank,saveButton,"Button light 2");
  rank++; 
  for(int i = 0 ; i < NUM_BUTTON_TRANSIENT ; i++) {
    midi_button(button_transient[i],rank,saveButton,"Button transient");
    rank++;
  }

  
  for(int i = 0 ; i <= NUM_ITEM ; i++) {
    if(i == 0) {
      // the first fourth button is unused for the this time
    } else {
      rank = 0 ;
      midi_button(button_item[posRankButton(i,rank)], posRankButton(i,rank), saveButton,"Button item"); 
      rank++ ;
      midi_button(button_item[posRankButton(i,rank)], posRankButton(i,rank), saveButton,"Button item"); 
      rank++ ;
      midi_button(button_item[posRankButton(i,rank)], posRankButton(i,rank), saveButton,"Button item"); 
      rank++ ;
      midi_button(button_item[posRankButton(i,rank)], posRankButton(i,rank), saveButton,"Button item");
    }
  }
}


public int posRankButton(int pos, int rank) {
  return pos* BUTTON_ITEM_CONSOLE +rank ;
}



/**
Here it's real midi stuff
*/
public void midi_button(Button b, int id, boolean saveButton, String type) {
  setting_midi_button(b);
  update_midi_button(b);
  if(saveButton) {
    set_data_button(id, b.get_id_midi(),b.is(),type);
  }
}

public void setting_midi_button(Button b) {
  if(selectMidi) {
    if(reset_midi_selection) {
      b.set_id_midi(-2);
    } else if (b.inside && mousePressed) {
      b.set_id_midi(midi_CC_romanesco);  
    }  
  }
}


boolean midi_update_button = true;
public void update_midi_button(Button b) {
  if(midi_value_romanesco == 127 && midi_CC_romanesco == b.get_id_midi() && midi_update_button) {
    // println("je suis là",midi_CC_romanesco,b.get_id_midi(),frameCount);
    b.switch_is();
    midi_update_button = false;
  }

  if(midi_value_romanesco == 0) {
    midi_update_button = true;
  } 
}














//give which button is active and check is this button have a same ID midi that Item
public void update_midi_slider(Slider slider, Cropinfo[] cropinfo) {
  // update info from midi controller
  if (midi_CC_romanesco == slider.get_id_midi()) {
    slider.update_midi(midi_value_romanesco);
  }

  if(selectMidi) {
    if(reset_midi_selection) {
      for(int i = 0 ; i < cropinfo.length ; i++) {
        if(slider.get_id() == cropinfo[slider.get_id()].get_id()) {
          cropinfo[i].set_id_midi(-2);
        }
      }
      slider.set_id_midi(-2);
    } else if(slider.molette_used_is()) {
      cropinfo[slider.get_id()].set_id_midi(midi_CC_romanesco);
      slider.set_id_midi(midi_CC_romanesco);
    }
  }
  
  //ID midi from controller midi button setting
  // if (selectMidi && slider.molette_used_is()) slider.set_id_midi(midi_CC_romanesco);
  
  //ID midi from save
  if(LOAD_SETTING) {
    int index = slider.get_id();
    slider.set_id_midi(cropinfo[index].get_id_midi());
  }
}



/**
Slider_dynamic
v 2.0.2.1
*/
StringList slider_item_controller = new StringList();

StringList [] sliders_by_item;
String [] sliders_by_item_raw;

String [][] slider_inventory_item_raw;
boolean [] item_active;
boolean [] display_slider;

boolean reset_slider_item = true;
boolean show_all_slider_item_active = false;
boolean show_all_slider_item = false;

//these sliders name are not used for the interface but for the display analyze slider
// col A
int hue_fill_rank = 0;
int sat_fill_rank = 1;
int bright_fill_rank = 2;
int alpha_fill_rank = 3;

int hue_stroke_rank = 4;
int sat_stroke_rank = 5;
int bright_stroke_rank = 6;
int alpha_stroke_rank = 7;
int thickness_rank = 8;

int size_x_rank = 9;
int size_y_rank = 10;
int size_z_rank = 11;

int diameter_rank = 12;

int canvas_x_rank = 13;
int canvas_y_rank = 14;
int canvas_z_rank = 15;

// col B
int frequence_rank = 16;

int speed_x_rank = 17;
int speed_y_rank = 18;
int speed_z_rank = 19;

int spurt_x_rank = 20;
int spurt_y_rank = 21;
int spurt_z_rank = 22;

int dir_x_rank = 23;
int dir_y_rank = 24;
int dir_z_rank = 25;

int jitter_x_rank = 26;
int jitter_y_rank = 27;
int jitter_z_rank = 28;

int swing_x_rank = 29;
int swing_y_rank = 30;
int swing_z_rank = 31;

// col C
int quantity_rank = 32;
int variety_rank = 33;

int life_rank = 34;
int flow_rank = 35;
int quality_rank = 36;

int area_rank = 37;
int angle_rank = 38;
int scope_rank = 39;
int scan_rank = 40;

int alignment_rank = 41;
int repulsion_rank = 42;
int attraction_rank = 43;
int density_rank = 44;

int influence_rank = 45;
int calm_rank = 46;
int spectrum_rank = 47;

// col C
int grid_rank = 48;

int viscosity_rank = 49;
int diffusion_rank = 50;







public void set_display_slider() {
  set_dynamic_slider() ;
  list_item_slider_gui() ;
  recover_active_slider_from_item() ;
  list_slider_item() ;
}

public void set_dynamic_slider() {
  sliders_by_item = new StringList [NUM_ITEM +1];
  sliders_by_item_raw = new String [NUM_ITEM +1];

  slider_inventory_item_raw = new String [NUM_ITEM +1][NUM_SLIDER_ITEM +1] ;
  item_active = new boolean [NUM_ITEM +1] ;
  display_slider = new boolean [NUM_SLIDER_ITEM +1] ;
}


public void recover_active_slider_from_item() {
  sliders_by_item_raw[0] = ("not used") ;
  for(int i = 1 ; i <= NUM_ITEM ; i++) {
    sliders_by_item_raw[i] = item_slider[item_ID[i]] ;
  }
}






public void list_slider_item() {
  //create the String list for each item
  for ( int i = 0 ; i < sliders_by_item.length ; i++) {
    sliders_by_item[i] = new StringList() ;
  }

  // setting the list to don't have a null value
  for (int i = 0 ; i < sliders_by_item.length ; i++) {
    for( int j = 0 ; j <= NUM_SLIDER_ITEM ; j++ ) {
      sliders_by_item[i].append("") ;
    }
  }
  // add value to item slider list
  for (int i = 1 ; i <= NUM_ITEM ; i++) {
    String [] temp = split_text(sliders_by_item_raw[i], (",")) ;
    for(int j = 0 ; j < NUM_SLIDER_ITEM ; j++) {
      for (int k = 0 ; k < temp.length ; k++) {
        if(temp[k].equals(slider_item_controller.get(j))) {
          sliders_by_item[i].set(j,temp[k]);
        } else if(temp[k].equals("all") ) {
          sliders_by_item[i].set(j,"all") ;
        }
      }
    }
  }
}




public void list_item_slider_gui() {
  for(int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
    slider_item_controller.append(slider_item_name[i]) ;
  }
}



// DRAW
public void check_slider_item() {
  check_item_parameter_on_off() ;
  which_slider_display() ;
  //check if the slider must be display
  if (reset_slider_item) {
    // use this boolean to have a boolean slider true, if this boolean is don't use no slider can be true and active
    boolean firstCheck = true ; 
    //reset slider for new check
    for(int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
      display_slider[i] = false;
    }
    //active slider item
    if (show_all_slider_item) {
      for (int i = 0 ; i < NUM_SLIDER_ITEM ; i++) {
        display_slider[i] = true;
      }
    } else {
      for (int i = 1 ; i <= NUM_ITEM ; i++) {
        if (item_active[i]) {
          for(int k = 0 ; k < NUM_SLIDER_ITEM ; k++) {
            if (firstCheck) {
              if((slider_item_controller.get(k).equals(sliders_by_item[i].get(k)) || sliders_by_item[i].get(k).equals("all"))) {
                display_slider[k] = true; 
              } else {
                display_slider[k] = false;
              }
            } else {
              if (!show_all_slider_item_active) {
                if((slider_item_controller.get(k).equals(sliders_by_item[i].get(k)) || sliders_by_item[i].get(k).equals("all")) && display_slider[k]) {
                  display_slider[k] = true; 
                } else {
                  display_slider[k] = false;
                }
              } else if (show_all_slider_item_active) {
                if (!display_slider[k]) {
                  if (slider_item_controller.get(k).equals(sliders_by_item[i].get(k)) || sliders_by_item[i].get(k).equals("all")) {
                    display_slider[k] = true;
                  } 
                } 
              }
            }
          }
          firstCheck = false ;
        }
      }
    }
    reset_slider_item = false ;  
  }
}



// CHOICE which slider must be display after checking the keyboard
public void which_slider_display() {
  switch(slider_mode_display) {
    case 0 : 
    reset_slider_item = true ;
    show_all_slider_item = true ;
    break ;
    case 1 : 
    reset_slider_item = true;
    show_all_slider_item = false;
    show_all_slider_item_active = true;
    break ;
    case 2 : 
    reset_slider_item = true ;
    show_all_slider_item = false ;
    show_all_slider_item_active = false ;
    break ;
  }
}


public void check_item_parameter_on_off() {
  boolean button_is = false;
  boolean witness_activity_is = false;
  boolean parameter_activity_is = false;
  for(int i = 0 ; i < NUM_ITEM ; i++ ) {
    int whichOne = i*BUTTON_ITEM_CONSOLE +1;
    witness_activity_is = button_is;
    if (item_button_state[whichOne]) {
      item_active[i+1] = true;
      if(mousePressed) {
        button_is = !button_is;
      }
    } else { 
      item_active[i+1] = false;
      if(mousePressed) {
        button_is = !button_is;
      }     
    }
    //check ctivity
    if(witness_activity_is != button_is) {
      parameter_activity_is = true;
    }
  }
  if(parameter_activity_is) {
    reset_slider_item = true;
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "A___control_33" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
