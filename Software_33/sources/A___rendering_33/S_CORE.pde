/**
CORE SCENE and PRESCENE 
2015-2018
v 1.6.4
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
//FLUX RSS or TWITTER ????
import com.sun.syndication.feed.synd.*;
import com.sun.syndication.io.*;
//GEOMERATIVE
import geomerative.*;
//TOXIC
import toxi.geom.*;
import toxi.geom.mesh2d.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.processing.*;

// SYPHON
import codeanticode.syphon.*;





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
iVec2[] cam_size ;
int[] cam_fps ;
int which_cam = 0;
int ref_cam = -1;
iVec2 CAM_SIZE;
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

iVec2 [] get_cam_size() {
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
  cam_size = new iVec2[cameras.length] ;
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
      cam_size[i] = iVec2(Integer.parseInt(sizeXY[0]), Integer.parseInt(sizeXY[1])) ;  // Integer.parseInt("1234");
      // fps
      String fps = cam_data [2].substring(4,cam_data[2].length()) ;
      cam_fps[i] = Integer.parseInt(fps) ;
    }
  } else {
    CAMERA_AVAILABLE = false ;
  }
}























/**
LOAD
v 0.2.0
*/
void load_data_item(String path) {
  JSONArray load = new JSONArray() ;
  load = loadJSONArray(path);
  // init counter
  int startPosJSONDataWorld = 0 ;
  int startPosJSONDataCam = 1 ;
  int startPosJSONDataObj = 0;
    
  // PART ONE
  JSONObject dataWorld = load.getJSONObject(startPosJSONDataWorld);
  background_button_is(dataWorld.getBoolean("on/off"));


  colorBackground.r = dataWorld.getFloat("hue background") ;
  colorBackground.g = dataWorld.getFloat("saturation background");
  colorBackground.b = dataWorld.getFloat("brightness background") ;
  colorBackground.a = dataWorld.getFloat("refresh background") ;
  colorBackgroundRef = colorBackground.copy() ;

  // color ambient light
  color_light[0].r = dataWorld.getFloat("hue ambient") ;
  color_light[0].g = dataWorld.getFloat("saturation ambient") ;
  color_light[0].b = dataWorld.getFloat("brightness ambient") ;
  color_light[0].a = dataWorld.getFloat("alpha ambient") ;
  // pos ambient light
  /**
  Not use at this time
  dataWorld.setFloat("pos x ambient", value) ;
  dataWorld.setFloat("pos y ambient", value) ;
  dataWorld.setFloat("pos z ambient", value) ;
  */
  // color light one
  color_light[1].r = dataWorld.getFloat("hue light 1") ;
  color_light[1].g = dataWorld.getFloat("saturation light 1") ;
  color_light[1].b = dataWorld.getFloat("brightness light 1") ;
  color_light[1].a = dataWorld.getFloat("alpha light 1") ;
  // pos light one
  dir_light[1].x = dataWorld.getFloat("pos x light 1") ;
  dir_light[1].y = dataWorld.getFloat("pos y light 1") ;
  dir_light[1].z = dataWorld.getFloat("pos z light 1") ;
  // color light two
  color_light[2].r = dataWorld.getFloat("hue light 2") ;
  color_light[2].g = dataWorld.getFloat("saturation light 2") ;
  color_light[2].b = dataWorld.getFloat("brightness light 2") ;
  color_light[2].a = dataWorld.getFloat("alpha light 2") ;
  // dir light two
  dir_light[2].x = dataWorld.getFloat("pos x light 2") ;
  dir_light[2].y = dataWorld.getFloat("pos y light 2") ;
  dir_light[2].z = dataWorld.getFloat("pos z light 2") ;
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
    finalSceneCamera.x = dataCam.getFloat("scene x") *width ;
    finalSceneCamera.y = dataCam.getFloat("scene y") *width ;
    finalSceneCamera.z = dataCam.getFloat("scene z") *width ;
    finalEyeCamera.x = dataCam.getFloat("longitude") ;
    finalEyeCamera.y = dataCam.getFloat("latitude") ;
  }
    

    // PART THREE
  for (int i = 2 ; i < load.size() ;i++) {
    JSONObject data_item = load.getJSONObject(i);
    int ID = data_item.getInt("ID obj");

    which_bitmap[ID] = data_item.getInt("which picture");
    which_shape[ID] = data_item.getInt("which svg");
    which_movie[ID] = data_item.getInt("which movie");
    which_text[ID] = data_item.getInt("which text");
    // display mode
    mode[ID] = data_item.getInt("Mode obj");
    costume_controller_selection[ID] = data_item.getInt("Costume selection item");

    // slider fill
    float h_fill = data_item.getFloat("hue fill");
    float s_fill = data_item.getFloat("saturation fill");
    float b_fill = data_item.getFloat("brightness fill");
    float a_fill = data_item.getFloat("alpha fill");
    // slider stroke
    float h_stroke = data_item.getFloat("hue stroke");
    float s_stroke = data_item.getFloat("saturation stroke");
    float b_stroke = data_item.getFloat("brightness stroke");
    float a_stroke = data_item.getFloat("alpha stroke");
    if(FULL_RENDERING) {
      fill_item[ID] = color(h_fill, s_fill, b_fill, a_fill) ;
      stroke_item[ID] = color(h_stroke, s_stroke, b_stroke, a_stroke) ;
      thickness_item[ID] = data_item.getFloat("thickness") *height ;
    } else {
      // preview display
      fill_item[ID] = COLOR_FILL_ITEM_PREVIEW ;
      stroke_item[ID] =  COLOR_STROKE_ITEM_PREVIEW ;
      thickness_item[ID] = THICKNESS_ITEM_PREVIEW ;
      }

    size_x_item[ID] = data_item.getFloat("width") *width ;
    size_y_item[ID] = data_item.getFloat("height") *width ;
    size_z_item[ID] = data_item.getFloat("depth") *width ;
    canvas_x_item[ID] = data_item.getFloat("canvas x") *width ;
    canvas_y_item[ID] = data_item.getFloat("canvas y") *width ;
    canvas_z_item[ID] = data_item.getFloat("canvas z") *width ;

    variety_item[ID] = data_item.getFloat("family") ;
    quantity_item[ID] = data_item.getFloat("quantity") ;
    life_item[ID] = data_item.getFloat("life") ;

    speed_x_item[ID] = data_item.getFloat("speed") ;
    dir_x_item[ID] = data_item.getFloat("direction") ;
    angle_item[ID] = data_item.getFloat("angle") ;
    swing_x_item[ID] = data_item.getFloat("amplitude") ;
    repulsion_item[ID] = data_item.getFloat("repulsion") ;
    attraction_item[ID] = data_item.getFloat("attraction") ;
    alignment_item[ID] = data_item.getFloat("aligmnent") ;
    influence_item[ID] = data_item.getFloat("influence") ;

    pos_item[ID].x  = data_item.getFloat("pos x obj") *width ;
    pos_item[ID].y  = data_item.getFloat("pos y obj") *width ;
    pos_item[ID].z  = data_item.getFloat("pos z obj") *width ;

    dir_item[ID].x  = data_item.getFloat("longitude obj") ;
    dir_item[ID].y  = data_item.getFloat("latitude obj") ;
  }
}































/**
FONT MANAGER 
v 2.0.1.1
*/
PFont SansSerif10 ;

PFont 
American_Typewriter,
Banco,
Cinquenta,
Container_Regular,
Diesel,
Digital,
DIN_Black, DIN_Bold, DIN_Light, DIN_Medium, DIN_Regular,
DosEquis,
EastBloc_Closed, EastBloc_ClosedAlt, EastBloc_Open, EastBloc_OpenAlt,
FetteFraktur,
FuturaStencil,
GangBangCrime,
Juanita, JuanitaDeco,
Komikahuna,
Mesquite,
Minion_Black, Minion_Bold, Minion_BoldItalic, Minion_Italic, Minion_Regular,
Rosewood,
Tokyo_One, Tokyo_OneSolid, Tokyo_Two, Tokyo_TwoSolid,
Three_Hardway ;


void create_font() {
  int size_font = 200 ;
  String prefix_path_font = import_path +"font/typo_OTF_TTF/" ;

  // path_font_item
  path_font_library[1] = prefix_path_font + "AmericanTypewriter.ttf" ;
  American_Typewriter = createFont(path_font_library[1], size_font) ;

  path_font_library[2] = prefix_path_font + "Banco.ttf" ;
  Banco = createFont(path_font_library[2], size_font) ;

  path_font_library[3] = prefix_path_font + "Cinquenta.ttf" ;
  Cinquenta = createFont(path_font_library[3], size_font) ;

  path_font_library[4] = prefix_path_font + "Container-Regular.otf" ;
  Container_Regular = createFont(path_font_library[4], size_font) ;

  path_font_library[5] = prefix_path_font + "Diesel.otf" ;
  Diesel = createFont(path_font_library[5], size_font) ;

  path_font_library[6] = prefix_path_font + "Digital.ttf" ;
  Digital = createFont(path_font_library[6], size_font) ;
  
  path_font_library[7] = prefix_path_font + "DIN-Black.otf" ;
  DIN_Black = createFont(path_font_library[7], size_font) ;
  path_font_library[8] = prefix_path_font + "DIN-Bold.otf" ;
  DIN_Bold = createFont(path_font_library[8], size_font) ; 
  path_font_library[9] = prefix_path_font + "DIN-Light.otf" ;
  DIN_Light = createFont(path_font_library[9], size_font) ;  
  path_font_library[10] = prefix_path_font + "DIN-Medium.otf" ;
  DIN_Medium = createFont(path_font_library[10], size_font) ; 
  path_font_library[11] = prefix_path_font + "DIN-Regular.otf" ;
  DIN_Regular = createFont(path_font_library[11], size_font) ;

  path_font_library[12] = prefix_path_font + "DosEquis.ttf" ;
  DosEquis = createFont(path_font_library[12], size_font) ;
  
  path_font_library[13] = prefix_path_font + "EastBloc-Closed.otf" ;
  EastBloc_Closed = createFont(path_font_library[13], size_font) ; 
  path_font_library[14] = prefix_path_font + "EastBloc-ClosedAlt.otf" ;
  EastBloc_ClosedAlt = createFont( path_font_library[14], size_font) ;
  path_font_library[15] = prefix_path_font + "EastBloc-Open.otf" ;
  EastBloc_Open = createFont(path_font_library[15], size_font) ;
  path_font_library[16] = prefix_path_font + "EastBloc-OpenAlt.otf" ;
  EastBloc_OpenAlt = createFont(path_font_library[16], size_font) ;
  
  path_font_library[17] = prefix_path_font + "FetteFraktur.ttf" ;
  FetteFraktur = createFont(path_font_library[17], size_font) ;

  path_font_library[18] = prefix_path_font + "FuturaStencil.ttf" ;
  FuturaStencil = createFont(path_font_library[18], size_font) ;

  path_font_library[19] = prefix_path_font + "GangBangCrime.ttf" ;
  GangBangCrime = createFont(path_font_library[19], size_font) ;
  
  path_font_library[20] = prefix_path_font + "Juanita.ttf" ;
  Juanita = createFont(path_font_library[20], size_font) ; 
  path_font_library[21] = prefix_path_font + "JuanitaDeco.ttf" ;
  JuanitaDeco = createFont(path_font_library[21], size_font) ; 
  
  path_font_library[22] = prefix_path_font + "Komikahuna.ttf" ;
  Komikahuna = createFont(path_font_library[22], size_font) ; 

  path_font_library[23] = prefix_path_font + "Mesquite.otf" ;
  Mesquite = createFont(path_font_library[23], size_font) ; 
  
  path_font_library[24] = prefix_path_font + "Minion-Black.otf" ;
  Minion_Black = createFont(path_font_library[24], size_font) ;
  path_font_library[25] = prefix_path_font + "Minion-Bold.otf" ;
  Minion_Bold = createFont(path_font_library[25], size_font) ; 
  path_font_library[26] = prefix_path_font + "Minion-BoldItalic.otf" ;
  Minion_BoldItalic = createFont(path_font_library[26], size_font) ; 
  path_font_library[27] = prefix_path_font + "Minion-Italic.otf" ;
  Minion_Italic = createFont( path_font_library[27], size_font) ;
  path_font_library[28] = prefix_path_font + "Minion-Regular.otf" ;
  Minion_Regular = createFont(path_font_library[28], size_font) ;
  
  path_font_library[29] = prefix_path_font + "Rosewood.otf" ;
  Rosewood = createFont(path_font_library[29], size_font) ;

  path_font_library[30] = prefix_path_font + "Tokyo-One.otf" ;
  Tokyo_One = createFont(path_font_library[30], size_font) ; 
  path_font_library[31] = prefix_path_font + "Tokyo-OneSolid.otf" ;
  Tokyo_OneSolid = createFont(path_font_library[31], size_font) ; 
  path_font_library[32] = prefix_path_font + "Tokyo-Two.otf" ;
  Tokyo_Two = createFont(path_font_library[32], size_font) ; 
  path_font_library[33] = prefix_path_font + "Tokyo-TwoSolid.otf" ;
  Tokyo_TwoSolid = createFont(path_font_library[33], size_font) ;
  
  path_font_library[34] = prefix_path_font + "3Hardway.ttf" ;
  Three_Hardway = createFont(path_font_library[34], size_font) ;

  // default and special font
  String prefix_default_path_font = import_path +"font/default_font/" ;

  

  SansSerif10 = loadFont(prefix_default_path_font+"SansSerif-10.vlw");
  
  // default font
  path_font_default_ttf = prefix_path_font + "DINEngschrift-Regular.ttf" ;
  font_library = DIN_Bold ;
  // 
  println("font build setup done") ;
}


void select_font(int whichOne)  {
  // path font
  if (whichOne > 0 && whichOne < numFont ) {
    path_font_library[0] = path_font_library[whichOne] ;
  }
  
  // PFont selection
  if (whichOne == 1) { 
    font_library = American_Typewriter ; 
  } else if (whichOne == 2) { 
    font_library = Banco ; 
  } else if (whichOne == 3)  { 
    font_library = Cinquenta ; 
  } else if (whichOne == 4) { 
    font_library = Container_Regular ; 
  } else if (whichOne == 5)  { 
    font_library = Diesel ; 
  } else if (whichOne == 6) { 
    font_library = Digital ; 

  } else if (whichOne == 7) { 
    font_library = DIN_Black ; 
  } else if (whichOne == 8) { 
    font_library = DIN_Bold ; 
  } else if (whichOne == 9) { 
    font_library = DIN_Light ; 
  } else if (whichOne == 10) { 
    font_library = DIN_Medium ; 
  } else if (whichOne == 11) { 
    font_library = DIN_Regular ; 

  } else if (whichOne == 12) { 
    font_library = DosEquis ; 

  } else if (whichOne == 13) { 
    font_library = EastBloc_Closed ; 
  } else if (whichOne == 14) { 
    font_library = EastBloc_ClosedAlt ; 
  } else if (whichOne == 15) { 
    font_library = EastBloc_Open ; 
  } else if (whichOne == 16) { 
    font_library = EastBloc_OpenAlt ; 

  } else if (whichOne == 17) { 
    font_library = FetteFraktur ; 
  } else if (whichOne == 18) { 
    font_library = FuturaStencil ; 
  } else if (whichOne == 19) { 
    font_library = GangBangCrime ; 

  } else if (whichOne == 20) { 
    font_library = Juanita ; 
  } else if (whichOne == 21) { 
    font_library = JuanitaDeco ; 

  } else if (whichOne == 22) { 
    font_library = Komikahuna ; 
  } else if (whichOne == 23) { 
    font_library = Mesquite ; 

  } else if (whichOne == 24) { 
    font_library = Minion_Black ; 
  } else if (whichOne == 25) { 
    font_library = Minion_Bold ; 
  } else if (whichOne == 26) { 
    font_library = Minion_BoldItalic ; 
  } else if (whichOne == 27) { 
    font_library = Minion_Italic ; 
  } else if (whichOne == 28) { 
    font_library = Minion_Regular ; 

  } else if (whichOne == 29) { 
    font_library = Rosewood ; 

  } else if (whichOne == 30) { 
    font_library = Tokyo_One ; 
  } else if (whichOne == 31) { 
    font_library = Tokyo_OneSolid ; 
  } else if (whichOne == 32) { 
    font_library = Tokyo_Two ; 
  } else if (whichOne == 33) { 
    font_library = Tokyo_TwoSolid ; 

  } else if (whichOne == 34) { 
    font_library = Three_Hardway ; 

  } else { 
    font_library = DIN_Bold ; 
  }
}