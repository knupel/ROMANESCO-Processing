/**
* CORE RENDERING
* 2015-2019
* v 1.10.0
*/
import java.net.*;
import java.io.*;
import java.util.*;
import java.awt.*;
import java.util.Iterator;
import java.lang.reflect.*; 
import java.awt.image.* ;

import processing.video.*;
import oscP5.*;
import netP5.*;
import processing.net.*;
import processing.pdf.*;

import codeanticode.syphon.*;




/**
* get
*/
boolean camera_global_is() {
  return camera_global_is;
}

boolean camera_item_is() {
  camera_item_is = key_v_long;
  return camera_item_is;
}

boolean space_is() {
  return key_space_long;
}

ivec6 get_render_canvas() {
  return render_canvas;
}



/**
curtain
*/
void curtain() {
  rectMode(CORNER) ;
  fill (0) ; 
  noStroke() ;
  rect(-1,-1, width+2, height+2);
}











/**
MANAGE SAVE
v 0.0.5
*/
void load_autosave() {
  load_save(autosave_path);
}

void load_save(String path) {
  Table save = loadTable(path, "header");
  for (TableRow row : save.rows()) {
    String s = row.getString("Type");
    if(s.equals("Media")){
      String media_path = row.getString("Path");
      File f = new File(media_path);
      if(f.exists()) {
        add_media(media_path);
      } else {
        printErr("method load_save(): no file match with this path",media_path);
      }
    }
  }
}



/**
MANAGE DIALOGUE
v 0.0.5
*/
void load_dial_controller() {
  if(frameCount%240 == 0) {
    Table dial_table = loadTable(preference_path +"dialogue_from_controller.csv","header");
    TableRow row = dial_table.getRow(0);
    float temp_reactivity = row.getFloat("mouse reactivity");
    mouse_reactivity = temp_reactivity *temp_reactivity;
  }
}























/**
Color Romanesco 
v 1.0.1.1
*/
//COLOR for internal use
color fond ;
color rouge, orange, jaune, vert, bleu, noir, blanc, gris  ;
void color_setup() {
  rouge = color(10,100,100);
  orange = color(25,100,100);
  jaune = color(50,100,100) ;
  vert = color(150,100,100);
  bleu = color(235,100,100);
  noir = color(10,100,0);
  gris = color(10,50,50);
  blanc = color(0,0,100);
}









/**
PAD TRACKING
*/
int pad_inc(int target, int pad) {
  if(pad == UP && key_up) {
    target --;
  } else if(pad == DOWN && key_down) {
    target ++;
  } else if(pad == LEFT && key_left) {
    target --;
  } else if(pad == RIGHT && key_right) {
    target ++;
  }
  return target;
}












/**
CAMERA COMPUTER 
v 1.3.0
*/
Capture cam;
String[] cameras ;
String[] cam_name ;
ivec2[] cam_size ;
int[] cam_fps ;
int which_cam = 0;
int ref_cam = -1;
ivec2 CAM_SIZE;
boolean CAMERA_AVAILABLE;
boolean BROADCAST;

boolean new_cam = true;
boolean stop_cam = false;
boolean init_cam = false;

void camera_video_setup() {
  list_cameras() ;
  if(new_cam && which_cam > -1) launch_camera(which_cam) ;
}



void select_camera(int target) {
  which_cam = target ;
}

void video_camera_manager() {
  camera_video_setup();
  if(ref_cam != which_cam || which_cam == -1) {
    new_cam = true ;
    video_camera_stop() ;
    ref_cam = which_cam ;    
  }

  if (new_cam && which_cam > -1 ) {
    BROADCAST = true ;
    launch_camera(which_cam) ;
  }

  if (cam.available() && BROADCAST) {
    cam.read();
  }
}

Capture get_cam() {
  return cam;
}

ivec2 [] get_cam_size() {
  return cam_size ;
}

String [] get_cam_name() {
  return cam_name;
}

int [] get_cam_fps() {
  return cam_fps;
}





// annexe methode camera
void launch_camera(int which_cam) {
  if(CAMERA_AVAILABLE) {
    // if(FULL_RENDERING) which_cam = 0 ; else which_cam = 7 ; // 4 is normal camera around 800x600 or 640x360 with 30 fps
    if(!init_cam) {
      init_camera(which_cam);
      init_cam = true;
    }
    CAM_SIZE = cam_size[which_cam].copy();
    // surface.setSize((int)cam_size[which_cam].x, (int)cam_size[which_cam].y);
    new_cam = false ;
  }
}

void video_camera_stop() {
  cam.stop() ;
  init_cam = false ;
  BROADCAST = false ;
}




void init_camera(int which_camra) {
  cam = new Capture(this, cameras[which_camra]);
  cam.start();     
}


void list_cameras() {
  cameras = Capture.list();
  cam_name = new String[cameras.length] ;
  cam_size = new ivec2[cameras.length] ;
  cam_fps = new int[cameras.length] ;
  
  // about the camera
  if (cameras.length != 0) {
    CAMERA_AVAILABLE = true ;
    for(int i = 0 ; i < cameras.length ; i++) {
      String cam_data [] = split(cameras[i],",") ;
      // camera name
      cam_name[i] = cam_data [0].substring(5,cam_data[0].length()) ;
      // size camera
      String size = cam_data [1].substring(5,cam_data[1].length()) ;
      String [] sizeXY = split(size,"x") ;
      cam_size[i] = ivec2(Integer.parseInt(sizeXY[0]), Integer.parseInt(sizeXY[1])) ;  // Integer.parseInt("1234");
      // fps
      String fps = cam_data [2].substring(4,cam_data[2].length()) ;
      cam_fps[i] = Integer.parseInt(fps) ;
    }
  } else {
    CAMERA_AVAILABLE = false ;
  }
}







































/**
FONT MANAGER 
v 3.0.0
*/
PFont system_font;
void load_system_font() {
  String prefix_default_path_font = import_path +"font/default_font/";
  system_font = loadFont(prefix_default_path_font+"SansSerif-10.vlw");
}

void select_font(int target)  {
  if(target < font.length) {
    current_font = font[target];
  } else {
    current_font = font[0];
  }
  // current_font = font[target];
}

void init_font() {
  current_font = font[0];
  for(int i = 0 ; i < rom_manager.size() ; i++) {
    Romanesco item = rom_manager.get(i);
    item.set_font(current_font);
  }
}









/**
MODE
v 0.0.1
*/
class Mode {
  String [] name;
  int id;

  Mode() {} 

  Mode(int id, String... name) {
    this.name = name;
    this.id = id;
  }

  String get_name(int id) {
    return this.name[id];
  }

  String [] get_name() {
    return this.name;
  }

  int get_id() {
    return this.id;
  }

  // set
  void set_id(int id) {
    this.id = id;
  }

  void set_name(String... name) {
    this.name = name;
  }
}












