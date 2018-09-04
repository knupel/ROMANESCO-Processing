/**
CORE SCENE and PRESCENE 
2015-2018
v 1.5.2
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
INIT Romanesco
*/
boolean init_romanesco = true ;
void init_romanesco() {
  rectMode(CORNER);
  textAlign(LEFT);
  
  if(init_romanesco) {
    int which_setting = 0 ;
    for(int i = 0 ; i < NUM_ITEM_PLUS_MASTER ; i ++) {
      reset_direction_item (which_setting, i) ;
      update_ref_direction(i) ;
      // check for null before start
      if(dir_item_final[i] == null) dir_item_final[i] = Vec3() ;
      if(pos_item_final[i] == null) {
        float x = -(width/2) ;
        float y = -(height/2) ;
        pos_item_final[i] = Vec3(x,y,0) ;
      }
    }
    init_romanesco = false ;
  }
}





String displayMode = ("");
int depth_scene;
void display_setup(int frame_rate) {
  if(IAM.equals("scene")) {
    background(0);
    noCursor();
  }
  frameRate(frame_rate);  // Le frameRate doit être le même dans tous les Sketches
  colorMode(HSB, HSBmode.r, HSBmode.g, HSBmode.b, HSBmode.a); 
  set_screen();
  depth_scene = height;
  background_setup();
  background_shader_setup();
}









void set_screen() {
  Table configurationScene = loadTable(preference_path +"sceneProperty.csv","header");
  TableRow row = configurationScene.getRow(0);
  int w = width;
  int h = height;
  int x = 0;
  int y = 0;

  if(IAM.equals("prescene")) {
    x = row.getInt("prescene_x"); 
    y = row.getInt("prescene_y");
  } else {
    x = row.getInt("scene_x"); 
    y = row.getInt("scene_y");
  }

  if(FULL_RENDERING) {
    w = row.getInt("width"); 
    h = row.getInt("height");
    
    if(!FULL_SCREEN) {
      surface.setLocation(x,y);
      surface.setSize(w,h);
    } else {
      int ox = get_screen_location(sketchDisplay()).x;
      int oy = get_screen_location(sketchDisplay()).y;
      surface.setLocation(ox,oy);
      int sx = get_screen_size(sketchDisplay()).x;
      int sy = get_screen_size(sketchDisplay()).y;
      surface.setSize(sx,sy);
      println("The",IAM,"is on the screen",sketchDisplay());
      println("screen location",get_screen_location(sketchDisplay()));
      w = sx; 
      h = sy;

    }
    
  } else {
    w = row.getInt("preview_width"); 
    h = row.getInt("preview_height");
    surface.setSize(w,h);
    surface.setLocation(x,y);
    println("screen size",get_screen_size(sketchDisplay()));
  }
  scene_width = w;
  scene_height = h;
  println(IAM,"screen size [",w,",",h,"]"); 
}





/**
OPENING
2018-2018
*/
void message_opening() {
  fill(blanc);
  stroke(blanc);
  textSize(48);
  textAlign(CENTER);
  start_matrix();
  translate(width/2, height/2, abs(sin(frameCount * .005)) *(height/2)) ;
  text(nameVersion.toUpperCase(),0,-12);
  textSize(24);
  text(prettyVersion+"." + version,0,16);
  text("rendering " +IAM,0,36);
  stop_matrix() ;
  textAlign(LEFT) ;
}






















/**
GRAPHIC CONFIGURATION 
1.1.0
*/
//int whichScreen;
void resize_scene() {
  if (!FULL_SCREEN && !check_size || (width != scene_width && height != scene_height)) {
    catch_display_position() ;
    check_size = true ;
    int which = 0;
    if(which > screenDevice.length || which < 1) {
      which = 1;
    }
    int pos_x = display_size_x[which -1] - ((display_size_x[which -1]/2) +(scene_width /2)) ;
    int pos_y = display_size_y[which -1] - ((display_size_y[which -1]/2) +(scene_height /2)) ;
    set_display_sketch (pos_x, pos_y, scene_width, scene_height, which, true) ;
  }
}


GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] screenDevice = ge.getScreenDevices();



// window method
void set_display_sketch(int pos_x, int pos_y, int size_x, int size_y, int which_screen, boolean change_setting) {
  if(change_setting) {
    catch_display_position() ; 
    set_display(pos_x, pos_y, size_x, size_y, which_screen) ;
  }
}

// main method to display
void set_display(int pos_x, int pos_y, int size_x, int size_y, int which_screen) {
  int which = which_screen - 1 ;
  if(which < 0 ) which = 0 ;
  if(which < screenDevice.length ) {
    println("Surface set location",pos_x +display_pos_x[which],pos_y +display_pos_y[which]) ;
    surface.setLocation(pos_x +display_pos_x[which],pos_y +display_pos_y[which]) ;
    // surface.setLocation(20,20) ;
    surface.setSize(size_x,size_y) ;
    // surface.setLocation(pos_x +display_pos_x[which],pos_y +display_pos_y[which]) ;

  } else {
    println("You try to use an unvailable display") ;
    surface.setSize(size_x,size_y) ;
    surface.setLocation(20,20) ;
  }
}


// catch info about the different display
int [] display_pos_x, display_pos_y ;
int [] display_size_x, display_size_y ;
int display_num ;
void catch_display_position() {
  display_num = screenDevice.length ;
  display_pos_x = new int [display_num] ;
  display_pos_y = new int [display_num] ;
  display_size_x = new int [display_num] ;
  display_size_y = new int [display_num] ;
  
  for(int i = 0 ; i < display_num ; i++) {
    GraphicsDevice gd = screenDevice[i];
    GraphicsConfiguration[] graphicsConfigurationOfThisDevice = gd.getConfigurations();
    // loop with a single element the screen selected above
    for (int j = 0 ; j < graphicsConfigurationOfThisDevice.length ; j++ ) {
      Rectangle gcBounds = graphicsConfigurationOfThisDevice[j].getBounds() ;
      display_pos_x[i] = gcBounds.x ;
      display_pos_y[i] = gcBounds.y ;
      display_size_x[i] = gd.getDisplayMode().getWidth();
      display_size_y[i] = gd.getDisplayMode().getHeight();
    }
  }
}




































/**
MANAGE SAVE
v 0.0.3
*/
void media_update() {
  if(frameCount%120 == 0) thread("load_autosave");
}

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
svg
*/
ROPE_svg[] svg_import ;
String svg_current_path ;
String [] svg_path ;
void load_svg(int ID) {
  update_svg_path();
  // which_bitmap is the int return from the dropdown menu
  if(which_shape[ID] > svg_path.length ) which_shape[ID] = 0;

  if(svg_path != null && svg_path.length > 0 && svg_path[which_shape[ID]] != null) {
    // println("length",svg_path.length, "ID",ID, svg_path[which_shape[ID]]);
    svg_current_path = svg_path[which_shape[ID]];
    if(!svg_current_path.equals(svg_path_ref[ID])) {
      svg_import[ID] = new ROPE_svg(this, svg_current_path, "bricks");
    }
    svg_path_ref[ID] = svg_current_path;
  }
}

void update_svg_path() {
  svg_path = new String[svg_files.size()];
  for (int i = 0; i < svg_files.size(); i++) {
    File f = (File) svg_files.get(i);
    if(f.exists()) {
      svg_path[i] = f.getAbsolutePath();
    }   
  }
}





/**
text
*/
String[] text_import ;
String [] text_path;
void load_txt(int ID) {
  update_text_path();
  // which_text is the int return from the dropdown menu
  if(text_path != null && text_path.length > 0 && text_path[which_text[ID]] != null) {
    if(which_text[ID] > text_path.length ) which_text[ID] = 0;
    text_import[ID] = importText(text_path[which_text[ID]]);
  } else {
    text_import[ID] = "Big Brother has been burning all books, it's not possible to read anything";
  }    
}


void update_text_path() {
  text_path = new String[text_files.size()] ;
  for (int i = 0; i < text_files.size(); i++) {
    File f = (File) text_files.get(i);
    if(f.exists()) {
      text_path[i] = f.getAbsolutePath();
    }   
  }
}





/**
bitmap
*/
PImage[] bitmap ;
String [] bitmap_path ;
void load_bitmap(int ID) {
  update_bitmap_path();
  if(which_bitmap[ID] > bitmap_path.length) which_bitmap[ID] = 0;

  if(bitmap_path != null && bitmap_path.length > 0 && bitmap_path[which_bitmap[ID]] != null) {
    String bitmap_current_path = bitmap_path[which_bitmap[ID]];
    println(bitmap_current_path);
    println("length",bitmap_path.length);
    println(bitmap_path_ref[ID],which_bitmap[ID], ID);
    if(!bitmap_current_path.equals(bitmap_path_ref[ID])) {
      bitmap[ID] = loadImage(bitmap_current_path);
    }
    bitmap_path_ref[ID] = bitmap_current_path;
  }
}

void update_bitmap_path() {
  bitmap_path = new String[bitmap_files.size()] ;
  for (int i = 0; i < bitmap_files.size(); i++) {
    File f = (File) bitmap_files.get(i);
    if(f.exists()) {
      bitmap_path[i] = f.getAbsolutePath();
    }   
  }
}






/**
movie 
*/
Movie[] movie ;
String [] movie_path;
String [] movie_path_ref;
void load_movie(boolean change_movie_is, int id) {
  update_movie_path();
  boolean new_movie_is = check_for_new_movie();  
  if(movie_path.length > 0 && (new_movie_is || change_movie_is)) {
    setting_movie(id,movie_path[which_movie[id]]);
  }  
}






boolean check_for_new_movie() {
  boolean new_movie_is = false;
  if(movie_path_ref == null || movie_path_ref.length != movie_path.length) {
    new_movie_is = true;
    movie_path_ref = new String[movie_path.length];
  }
  
  // in case there a same quantity of ref we must check if the path ref is the same
  if(!new_movie_is)
  for(int i = 0 ; i < movie_files.size() ; i++) {
    new_movie_is = !movie_path_ref[i].equals(movie_path[i]);
    if(new_movie_is) {
      break;
    }
  }

  // in case there is a new movie make a new ref path
  if(new_movie_is) {
    for(int i = 0 ; i < movie_files.size() ; i++) {
      movie_path_ref[i] = movie_path[i];
    }
  }
  return new_movie_is;
}


void update_movie_path() {
  if(movie_path == null || movie_path.length != movie_files.size()) {
    movie_path = new String[movie_files.size()] ;
  }
  for (int i = 0; i < movie_files.size(); i++) {
    File f = (File) movie_files.get(i);
    if(f.exists()) {
      movie_path[i] = f.getAbsolutePath();
    }   
  }
}


// Movie Manager
void setting_movie(int id, String path) {
  if(movie[id] != null) {
    movie[id].stop();
  }
  if(ext(path,"mov") || ext(path,"MOV") || ext(path,"avi") || ext(path,"AVI") || ext(path,"mp4") || ext(path,"MP4") || ext(path,"mkv") || ext(path,"MKV")) {
    movie[id] = new Movie(this,path);
    movie[id].loop();
    movie[id].pause();
  } else {
    printErrTempo(120,"ROMANESCO don't find the movie:",id,path);
  }
}

void movieEvent(Movie m) {
  m.read(); 
}

/*
void classic_movie(int id, int place, boolean full_width, boolean full_height) {
  int pos_x = 0;
  int pos_y = 0;
  int size_x = movie[id].width;
  int size_y = movie[id].height;

  // Size in the Scene
  if(full_width && full_height) {
    size_x = width;
    size_y = height;
  } else if(!full_width && !full_height) {
    size_x = movie[id].width;
    size_y = movie[id].height;
  } else if(full_width && !full_height) {
    size_x = width;
    float ratio = (float)width / (float)movie[id].width ;
    size_y = int(movie[id].height *ratio);
  } else if(!full_width && full_height) {
    size_y = height ;
    float ratio = (float)height / (float)movie[id].height ;
    size_x = int(movie[id].width *ratio) ;
  }
  
  // position in the Scene
  if(place == CENTER) {
    pos_x = width/2 - (size_x/2) ;
    pos_y = height/2  - (size_y/2);
  }

  // show movie
  image(movie[id], pos_x, pos_y, size_x, size_y) ;
}
*/















































/**
TEXT MANAGER
*/
String importRaw [];
String importText(String path) {
  importRaw = loadStrings(path) ;
  return join(importRaw, "") ;
}

// info num Chapters
int numChapters(String txt) {
  String chapters [] = split(txt, "*") ;
  return chapters.length ;
}

// info num Sentences
int numMaxSentencesByChapter(String txt) {
  String chapters [] = split(txt, "*") ;
  // find the quantity of chapter and sentences by chapter to create the final double array String
  int numChapter = chapters.length ;
  int maxSentencesByChapter = 0 ;  
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(chapters[i], "/") ;
    if ( sentences.length > maxSentencesByChapter ) maxSentencesByChapter = sentences.length ; 
  }
  return maxSentencesByChapter ;
}



String whichSentence(String txt, int whichChapter, int whichSentence) {
  String chapters [] = split(txt, "*") ;
  String  [][] repartition ;
  
  // find the quantity of chapter and sentences by chapter to create the final double array String
  int numChapter = chapters.length ;
  int maxSentencesByChapter = 0 ;  
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(chapters[i], "/") ;
    if ( sentences.length > maxSentencesByChapter ) maxSentencesByChapter = sentences.length ; 
  }
  //create the final double array string
  repartition = new String [numChapter][maxSentencesByChapter] ;
  //put the sentences in the double String by chapter
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(chapters[i], "/") ;
    for ( int j = 0 ; j <  sentences.length ; j++) {
      repartition [i][j] = sentences[j] ;
    }
  }
  //security
  if(whichChapter > chapters.length ) whichChapter = 0 ;
  if(whichSentence > maxSentencesByChapter ) whichSentence = 0 ;
  
  return repartition[whichChapter][whichSentence] ;
}






























/**
MIROIR
v 0.1.0
*/
boolean syphon_on_off  ;
SyphonServer server ;
void syphon_settings() {
  PJOGL.profile=1;
}

void syphon_setup() {
  String name_syphon = (nameVersion + " " + prettyVersion +"."+version) ;
  server = new SyphonServer(this, name_syphon);
  println("Syphon setup done") ;
}

void syphon_draw() {
  if(key_y) syphon_on_off = !syphon_on_off ;
  if(syphon_on_off) server.sendScreen();
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
DISPLAY INFO
v 0.2.1
*/
boolean displayInfo, displayInfo3D ;
int posInfo = 2 ;
void info() {
  sounda.info(displayInfo);
  color color_text = color(0,0,100);
  color color_bg = color(0,100,100,50);

  if (displayInfo) {
    //perspective() ;
    displayInfoScene(color_bg,color_text) ;
    displayInfoObject(color_bg,color_text) ;
  }
  if (displayInfo3D) {
    displayInfo3D(color_text);
  }
}

void displayInfoScene(color bg_txt, color txt) {
  noStroke() ;
  fill(bg_txt) ;
  rectMode(CORNER) ;
  textAlign(LEFT) ;
  rect(0,-5,width, 15*posInfo) ;
  posInfo = 2 ;
  fill(txt) ;
  textFont(SansSerif10, 10) ;
  //INFO SIZE and RENDERER
  String displayModeInfo ;
  if (displayMode.equals("Classic") ) displayModeInfo = ("classic") ; else displayModeInfo = displayMode ;
  String infoRendering =("");
  if(FULL_RENDERING) infoRendering = ("Full rendering") ; else infoRendering = ("Preview rendering") ;
  text("Size " + width + "x" + height + " / "  + infoRendering + " / Render mode " + displayModeInfo + " / FrameRate " + (int)frameRate, 15,15) ;
  // INFO SYPHON
  text("Syphon " +syphon_on_off + " / press “y“ to on/off the Syphon",15, 15 *posInfo ) ;
  posInfo += 1 ;
  //INFO MOUSE and PEN
  text("Mouse " + mouseX + " / " + mouseY + " molette " + wheel[0] + " pen orientation " + (int)deg360(Vec2(pen[0].x,pen[0].y)) +"°   stylet pressur " + int(pen[0].z *10),15, 15 *posInfo ) ;  
  posInfo += 1 ;
  // LIGHT INFO
  text("Directional light ONE || pos " + int(pos_light[1].x)+ " / " + int(pos_light[1].y) + " / "+ int(pos_light[1].z) + " || dir " + decimale(dir_light[1].x,2) + " / " + decimale(dir_light[1].y,2) + " / "+ decimale(dir_light[1].z,2),15, 15 *posInfo  ) ;
  posInfo += 1 ;
  text("Directional light TWO || pos " + int(pos_light[2].x)+ " / " + int(pos_light[2].y) + " / "+ int(pos_light[2].z) + " || dir " + decimale(dir_light[2].x,2) + " / " + decimale(dir_light[2].y,2) + " / "+ decimale(dir_light[2].z,2),15, 15 *posInfo  ) ;
  posInfo += 1 ;
  //INFO SOUND
  if (get_time_track() > 1 ) text("the track play until " +get_time_track() + " – tempo " + get_tempo_name() + " " + get_tempo() , 15,15 *(posInfo)) ; else text("no track detected ", 15, 15 *(posInfo)) ;
  posInfo += 1 ;
  text("right " + get_right(100), 15, 15 *(posInfo)) ;  
  text("left "  + get_left(100),  50, 15 *(posInfo)) ;
  posInfo += 1 ;
}


int posInfoObj = 1 ;
void displayInfoObject(color bg_txt, color txt) {
  noStroke() ;
  fill(bg_txt) ;
  rectMode(CORNER) ;
  textAlign(LEFT) ;
  float heightBox = 15*posInfoObj ;
  rect(0, height -heightBox,width, heightBox) ;
  fill(txt) ;
  textFont(SansSerif10, 10) ;
  
  posInfoObj = 1 ;
  // for (Romanesco objR : RomanescoList)
  for(int i = 0 ; i < NUM_ITEM_PLUS_MASTER ; i++) {
    if(show_item[i]) {
      posInfoObj += 1 ;
      String position = ("x:" +(int)pos_item[i].x + " y:" + (int)pos_item[i].y+ " z:" + (int)pos_item[i].z) ;
      text(item_name[i] + " - Coord " + position + " - " + item_info[item_ID[i]], 10, height -(15 *(posInfoObj -1))) ;
    }
  }
}



//INFO 3D
void displayInfo3D(color txt) {
  String posCam = ( int(-1 *sceneCamera.x ) + " / " + int(sceneCamera.y) + " / " +  int(sceneCamera.z -height/2));
  String eyeDirectionCam = (int(eyeCamera.x) + " / " + int(eyeCamera.y));
  fill(txt); 
  textFont(SansSerif10, 10);
  textAlign(RIGHT);
  text("Position " +posCam, width/2 -30 , height/2 -30);
  text("Direction " +eyeDirectionCam, width/2 -30 , height/2 -15);
}


//REPERE 3D
void repere(int size, PVector pos, String name) {
  pushMatrix() ;
  translate(pos.x +20 , pos.y -20, pos.z) ;
  fill(blanc) ;
  text(name, 0,0) ;
  popMatrix() ;
  line(-size +pos.x,pos.y, pos.z,size +pos.x, pos.y, pos.z) ;
  line(pos.x,-size +pos.y, pos.z, pos.x,size +pos.y, pos.z) ;
  line(pos.x, pos.y,-size +pos.z, pos.x, pos.y,size +pos.z) ;
}

//repere cross
void repere(int size) {
  line(-size,0,0,size,0,0) ;
  line(0,-size,0,0,size,0) ;
  line(0,0,-size,0,0,size) ;
}









































/**
UTIL 
v 0.2.1
*/
/**
detection
*/
//CIRLCLE
boolean insideCircle (PVector pos, int diam) {
  if (dist(pos.x, pos.y, mouseX, mouseY) < diam) return true  ; else return false ;
}

//RECTANGLE
boolean insideRect(PVector pos, PVector size) { 
    if(mouse[0].x > pos.x && mouse[0].x < pos.x + size.x && mouse[0].y >  pos.y && mouse[0].y < pos.y + size.y) return true ; else return false ;
}


/**
time
*/
int minClock() {
  return hour()*60 + minute() ;
}

//timer
int chrnmtr, chronometer, newChronometer ;

int timer(float tempo) {
  int translateTempo = int(1000 *tempo) ;
  newChronometer = millis()%translateTempo ;
  if ( chronometer > newChronometer ) {
    chrnmtr += 1  ;
  }
  chronometer = newChronometer ;
  return chrnmtr ;
}

//make cycle from speed
float totalCycle ;
float cycle(float add) {
  totalCycle += add ; // choice here the speed of the cycle
  return sin(totalCycle) ;
}


/**
NEXT PREVIOUS
*/
void nextPreviousKeypressed() {
  nextPrevious = true ;
}

/**
tracking with pad
*/
int tracking(int t, int n) {
  if (nextPrevious) {
    if (key_down && t < n-1 ) {
      trackerUpdate = +1 ;
    } else if (key_up  && t > 0 ) {
      trackerUpdate = -1 ;
    } 
  }
  if (nextPrevious) {
    if ( key_left  && t > 0 ) {
      trackerUpdate = -1 ;
    } else if ( key_right && t < n-1 ) {
      trackerUpdate = +1 ;
    }
  }
  nextPrevious = false ;
  return trackerUpdate ;
}





























































/**
SOUND
v 1.4.0
*/
Sounda sounda;
int [] transient_section_id;

void sound_setup() {
  int length_analyze = 512 ;
  sounda = new Sounda(length_analyze);

  float scale_spectrum_sound = .11 ;
  sounda.set_spectrum(NUM_BANDS, scale_spectrum_sound);

  int len = sounda.buffer_size();
  int section_1 = len/8 ;
  int section_2 = len/3 ;
  int section_3 = len - (len/6);
  set_section_analyze(section_1,section_2,section_3);
  set_transient();
  sounda.set_tempo();
}

void sound_draw() {
  // setting
  sounda.audio_buffer(r.MIX);
  update_volume_setting();
  update_section_setting();
  update_transient_setting();
  // update
  sounda.update_spectrum(true);
  transient_romanesco();
  spectrum_romaneco();
  tempo_romanesco();
  
  /*
  println("in out 0",sounda.get_section_in(0),sounda.get_section_out(0));
  println("in out 1",sounda.get_section_in(1),sounda.get_section_out(1));
  println("in out 2",sounda.get_section_in(2),sounda.get_section_out(2));
  println("in out 3",sounda.get_section_in(3),sounda.get_section_out(3));
  */
  
}

















/**
ROMANESCO SOUND DRAW
*/
void tempo_romanesco() {
  tempo[0] = sounda.get_tempo();
  tempoKick[0] = sounda.get_tempo();
  tempoSnare[0] = sounda.get_tempo();
  tempoHat[0] = sounda.get_tempo();
}

void spectrum_romaneco() {
  for (int i = 0 ; i < sounda.spectrum_size() ; i++ ) {
    band[0][i] = sounda.get_spectrum(i);
  }
}

void transient_romanesco() {
  int max_transient_value = 10 ;
  float back_factor = .95;
  // transient global
  boolean transient_global_is = false; 
  for(int i = 1 ; i < transient_button_is.length ; i++) {
    if(transient_button_is(i)) {
      transient_global_is = true;
      break;
    }
  }
  if(transient_global_is && sounda.transient_is()) {    
    transient_value[0][0] = max_transient_value;
  } else {
    transient_value[0][0] *= back_factor;
  }

  // give catch value `0` from the lib because here we use `0` for the master transient
  for(int i = 1 ; i < transient_button_is.length ; i++) {
    if(transient_button_is(i) && sounda.transient_is(i-1)) {
      transient_value[i][0] = max_transient_value;   
    } else {
      transient_value[i][0] *= back_factor;
    }
  }
}


boolean transient_is(int index) {
  boolean is = false ;
  if(index > 0 && index < sounda.section_size()) {
    is = sounda.transient_is(index);
  } else if(index == 0) {
    for(int i = 0 ; i < sounda.section_size() ;i++) {
      if(sounda.transient_is(i)) {
        is = sounda.transient_is(i);
        break;
      }
    }
  }
  if(index >= sounda.section_size()) {
    printErr("method transient_is():",index,"is out of sounda.section_size()");
  }
  return is;
}

















/**
UPDATE SETTING SOUND
*/
void update_section_setting() {
  int cut_section_1 = (int)map(value_slider_sound_setting[0],0,360,0,sounda.buffer_size());
  int cut_section_2 = (int)map(value_slider_sound_setting[1],0,360,0,sounda.buffer_size());
  int cut_section_3 = (int)map(value_slider_sound_setting[2],0,360,0,sounda.buffer_size());
  set_section_analyze(cut_section_1,cut_section_2,cut_section_3);
}

void update_transient_setting() {
  Vec2 [] transient_threshold = new Vec2[4];
  for(int i = 0 ; i < transient_threshold.length ; i++) {
    int index = i*2;
    float threshold_low = map(value_slider_sound_setting[index+3],0,360,4,0);
    float threshold_high = map(value_slider_sound_setting[index+4],0,360,4,0);
    transient_threshold[i] = Vec2(threshold_low,threshold_high);
    sounda.set_transient(i,transient_threshold[i]);
  }
}

void update_volume_setting() {
  float vol_left_controller = map(value_slider_sound[0],0,MAX_VALUE_SLIDER,0,1.3);
  left[0] = map(sounda.get_left(),-.07,.1,0,vol_left_controller);
  
  float col_right_controller = map(value_slider_sound[1],0,MAX_VALUE_SLIDER,0,1.3);
  right[0] = map(sounda.get_right(),-.07,.1,0,col_right_controller);
  
  float vol_mix = map(((value_slider_sound[0] +value_slider_sound[1]) *.5),0,MAX_VALUE_SLIDER,0,1.3);
  mix[0] = map(sounda.get_mix(),  -.07,.1,0,vol_mix);
  
  //volume
  if(left[0] < 0 ) left[0] = 0;
  if(left[0] > 1 ) left[0] = 1.; 
  if(right[0] < 0 ) right[0] = 0;
  if(right[0] > 1 ) right[0] = 1.; 
  if(mix[0] < 0 ) mix[0] = 0;
  if(mix[0] > 1 ) mix[0] = 1.;
}













/**
SET
*/
void set_section_analyze(int... section_entry) {
  int len = sounda.buffer_size();
  int num_part = section_entry.length +1;
  iVec2 [] in_out = new iVec2[num_part];
  int part = len/(num_part*2);
  in_out[0] = iVec2(0,section_entry[0]); 
  in_out[1] = iVec2(section_entry[0],section_entry[1]);
  in_out[2] = iVec2(section_entry[1],section_entry[2]);
  in_out[3] = iVec2(section_entry[2],len);
  sounda.set_section(in_out);
}

void set_transient() {
  Vec2 [] transient_part_threshold = new Vec2[sounda.section_size()];
  transient_part_threshold[0] = Vec2(.1, 2.5);
  transient_part_threshold[1] = Vec2(.1, 2.5);
  transient_part_threshold[2] = Vec2(.1, 2.5);
  transient_part_threshold[3] = Vec2(.1, 2.5);

  sounda.init_transient(transient_part_threshold);
  sounda.set_transient_low_pass(20);     
  sounda.set_transient_smooth_slow(3.);
  sounda.set_transient_smooth_fast(21.);
  sounda.set_transient_ratio_log(100,50,40,30); 
  sounda.set_transient_threshold_low(.05,.08,.12,.16);
  sounda.set_transient_threshold_high(.8,.3,.25,.20);


}
















/**
GET
*/
int band_length() {
  return band[0].length;
}

float get_time_track() {
  if(sounda != null) {
    return sounda.get_time_track();
  } else {
    float f = Float.NaN ;
    return f;
  }
}

boolean sound_is() {
  return sounda.sound_is();
}

float get_right(int target_sample) {
  return sounda.get_right(target_sample);
}

float get_left(int target_sample) {
  return sounda.get_left(target_sample);
}

float get_mix(int target_sample) {
  return sounda.get_mix(target_sample);
}


String get_tempo_name() {
  return sounda.get_tempo_name();
} 

int get_tempo() {
  return sounda.get_tempo();
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




