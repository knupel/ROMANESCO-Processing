/**
CORE Rope SCENE and PRESCENE 
v 1.1.3.3
*/
/**
INIT Rope
*/
boolean init_RPE = true ;
void init_RPE() {
  rectMode (CORNER) ;
  textAlign(LEFT) ;
  
  if(init_RPE) {
    SIZE_BG = new PVector(width *100, height *100, height *7.5) ;

    int which_setting = 0 ;
    for(int i = 0 ; i < NUM_ITEM ; i ++) {
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
    init_RPE = false ;
  }
}
























/**

Select Costume Romanesco
v 0.0.2

*/
/*
Max mode is used for what, to give the possibility to have other mode without costume rope ?????
*/
void select_costume(int id_item,  String rpe_name) {

  String mode_list = null ;
  String [] mode_split =new String[1] ;
  for(int i = 0 ; i < rpe_manager.RomanescoList.size() ; i++) {
    Romanesco item = (Romanesco) rpe_manager.RomanescoList.get(i) ;
    if(rpe_name.equals(item.RPE_name)) {
      mode_list = item.RPE_mode ;
      mode_split = split(mode_list, "/") ;
    }
  }

  String costume_romanesco = "unknow" ;
  if(mode_split[0] != null) {
    costume_romanesco = mode_split[mode[id_item]] ;
  } 

  if(costume_romanesco.equals("point") || costume_romanesco.equals("POINT") || costume_romanesco.equals("Point")) {
    if(!dimension[id_item]) {
      costume[id_item] = POINT_ROPE ; 
    } else {
      costume[id_item] = SPHERE_LOW_ROPE ;
    }
  } else if(costume_romanesco.equals("ellipse") || costume_romanesco.equals("ELLIPSE") || costume_romanesco.equals("Ellipse") || costume_romanesco.equals("disc") || costume_romanesco.equals("DISC") || costume_romanesco.equals("Disc")) {
    if(!dimension[id_item]) {
      costume[id_item] = ELLIPSE_ROPE ; 
    } else {
      costume[id_item] = SPHERE_MEDIUM_ROPE ;
    }
  } else if(costume_romanesco.equals("triangle") || costume_romanesco.equals("TRIANGLE") || costume_romanesco.equals("Triangle")) {
    if(!dimension[id_item]) {
      costume[id_item] = TRIANGLE_ROPE ; 
    } else {
      costume[id_item] = TETRAHEDRON_ROPE ;
    }
  } else if(costume_romanesco.equals("rectangle") || costume_romanesco.equals("RECTANGLE") || costume_romanesco.equals("Rectangle") || costume_romanesco.equals("rect") || costume_romanesco.equals("RECT") || costume_romanesco.equals("Rect")) {
    if(!dimension[id_item]) {
      costume[id_item] = RECT_ROPE ; 
    } else {
      costume[id_item] = BOX_ROPE ;
    }
  } else if(costume_romanesco.equals("cross") || costume_romanesco.equals("CROSS") || costume_romanesco.equals("Cross")) {
    if(!dimension[id_item]) {
      costume[id_item] = CROSS_2_ROPE ; 
    } else {
      costume[id_item] = CROSS_3_ROPE ;
    }
  } else if(costume_romanesco.equals("star 4") || costume_romanesco.equals("STAR 4") || costume_romanesco.equals("Star 4")) {
    if(!dimension[id_item]) {
      costume[id_item] = STAR_4_ROPE ; 
    } else {
      costume[id_item] = STAR_4_ROPE ;
    }
  } else if(costume_romanesco.equals("star 5") || costume_romanesco.equals("STAR 5") || costume_romanesco.equals("Star 5")) {
    if(!dimension[id_item]) {
      costume[id_item] = STAR_5_ROPE ; 
    } else {
      costume[id_item] = STAR_5_ROPE ;
    }
  } else if(costume_romanesco.equals("star 6") || costume_romanesco.equals("STAR 6") || costume_romanesco.equals("Star 6")) {
    if(!dimension[id_item]) {
      costume[id_item] = STAR_6_ROPE ; 
    } else {
      costume[id_item] = STAR_6_ROPE ;
    }
  } else if(costume_romanesco.equals("star 7") || costume_romanesco.equals("STAR 7") || costume_romanesco.equals("Star 7")) {
    if(!dimension[id_item]) {
      costume[id_item] = STAR_7_ROPE ; 
    } else {
      costume[id_item] = STAR_7_ROPE ;
    }
  }
  else if(costume_romanesco.equals("star 8") || costume_romanesco.equals("STAR 8") || costume_romanesco.equals("Star 8")) {
    if(!dimension[id_item]) {
      costume[id_item] = STAR_8_ROPE ; 
    } else {
      costume[id_item] = STAR_8_ROPE ;
    }
  } else if(costume_romanesco.equals("super star 8") || costume_romanesco.equals("SUPER STAR 8") || costume_romanesco.equals("Super Star 8")) {
    if(!dimension[id_item]) {
      costume[id_item] = SUPER_STAR_8_ROPE ; 
    } else {
      costume[id_item] = SUPER_STAR_8_ROPE ;
    }
  } else if(costume_romanesco.equals("super star 12") || costume_romanesco.equals("SUPER STAR 12") || costume_romanesco.equals("Super Star 12")) {
    if(!dimension[id_item]) {
      costume[id_item] = SUPER_STAR_12_ROPE ; 
    } else {
      costume[id_item] = SUPER_STAR_12_ROPE ;
    }
  } else if(costume_romanesco.equals("abc") || costume_romanesco.equals("ABC") || costume_romanesco.equals("Abc")) {
    if(!dimension[id_item]) {
      costume[id_item] = TEXT_ROPE ; 
    } else {
      costume[id_item] = TEXT_ROPE ;
    }
  }else {
    if(!dimension[id_item]) {
      costume[id_item] = POINT_ROPE ; 
    } else {
      costume[id_item] = SPHERE_LOW_ROPE ;
    }
  }
}







































/**

CHECK FOLDER
v 0.1.0

*/

/**
bitmap
*/
PImage[] bitmap_import ;
ArrayList bitmap_files = new ArrayList();
boolean folder_bitmap_is_selected = true ;
String [] bitmap_path ;
int count_bitmap_selection ;
int ref_bitmap_num_files ;


void load_bitmap(int ID) {
  check_bitmap_folder_scene() ;
  // which_bitmap is the int return from the dropdown menu
  if(which_bitmap[ID] > bitmap_path.length ) which_bitmap[ID] = 0 ;

  if(bitmap_path != null && bitmap_path.length > 0) {
    String bitmap_current_path = bitmap_path[which_bitmap[ID]] ;
    if(!bitmap_current_path.equals(bitmap_path_ref[ID])) {
      bitmap_import[ID] = loadImage(bitmap_current_path) ;
    }
    bitmap_path_ref[ID] = bitmap_current_path ;
  }
}

void check_bitmap_folder_scene() {
  String path = import_path +"bitmap" ;

  // String path = preference_path +"Images" ;
  ArrayList allFiles = listFilesRecursive(path);
  //check if something happen in the folder
  if(ref_bitmap_num_files != allFiles.size() ) {
    folder_bitmap_is_selected = true ;
    ref_bitmap_num_files = allFiles.size() ;
  }
  // If something happen, algorithm work 
  if(folder_bitmap_is_selected) {
    count_bitmap_selection++ ;
    bitmap_files.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("PNG") || lastThree.equals("png") || lastThree.equals("JPG") || lastThree.equals("jpg") || lastThree.equals("GIF") || lastThree.equals("gif")) {
          bitmap_files.add(f);
        }
      }
    }
    // edit the image path
    bitmap_path = new String[bitmap_files.size()] ;
    for (int i = 0; i < bitmap_files.size(); i++) {
      File f = (File) bitmap_files.get(i);
      bitmap_path[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folder_bitmap_is_selected = false ;
  }
}


/**
svg
*/

ROPE_svg[] svg_import ;
ArrayList svg_files = new ArrayList();
boolean folder_svg_is_selected = true ;
String svg_current_path ;
String [] svg_path ;
int count_svg_selection ;
int ref_svg_num_files ;


void load_svg(int ID) {
  check_svg_folder_scene() ;
  // which_bitmap is the int return from the dropdown menu
  if(which_svg[ID] > svg_path.length ) which_svg[ID] = 0 ;

  if(svg_path != null && svg_path.length > 0) {
    svg_current_path = svg_path[which_svg[ID]] ;
    if(!svg_current_path.equals(svg_path_ref[ID])) {
      svg_import[ID] = new ROPE_svg(this, svg_current_path, "bricks") ;
    }
    svg_path_ref[ID] = svg_current_path ;
  }
}

void check_svg_folder_scene() {
  String path = import_path +"svg" ;
  ArrayList allFiles = listFilesRecursive(path);
  //check if something happen in the folder
  if(ref_bitmap_num_files != allFiles.size() ) {
    folder_svg_is_selected = true ;
    ref_svg_num_files = allFiles.size() ;
  }
  // If something happen, algorithm work 
  if(folder_svg_is_selected) {
    count_svg_selection++ ;
    svg_files.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("SVG") || lastThree.equals("svg")) {
          svg_files.add(f);
        }
      }
    }
    // edit the image path
    svg_path = new String[svg_files.size()] ;
    for (int i = 0; i < svg_files.size(); i++) {
      File f = (File) svg_files.get(i);
      svg_path[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folder_svg_is_selected = false ;
  }
}




/**
text
*/
String[] text_import ;
ArrayList text_files = new ArrayList();
boolean folder_text_is_selected = true ;
String [] text_path ;
int count_text_selection ;
int ref_text_num_files ;

void load_txt(int ID) {
  check_text_folder_scene() ;
  // which_text is the int return from the dropdown menu
  if(text_path != null && text_path.length > 0) {
    if(which_text[ID] > text_path.length ) which_text[ID] = 0 ;
    text_import[ID] = importText(text_path[which_text[ID]]) ;
  } else {
    text_import[ID] = "Big Brother has been burning all books, it's not possible to read anything" ;
  }
    
}




void check_text_folder_scene() {
  String path = import_path +"karaoke" ;
  ArrayList allFiles = listFilesRecursive(path);
  
  //check if something happen in the folder
  if(ref_text_num_files != allFiles.size() ) {
    folder_text_is_selected = true ;
    ref_text_num_files = allFiles.size() ; 
  }
  // If something happen, algorithm work 
  if(folder_text_is_selected) {
    count_text_selection++ ;
    text_files.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("TXT") || lastThree.equals("txt")) {
          text_files.add(f);
        }
      }
    }
    // edit the path file
    text_path = new String[text_files.size()] ;
    for (int i = 0; i < text_files.size(); i++) {
      File f = (File) text_files.get(i); 
      text_path[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folder_text_is_selected = false ;
  }
}


/**
movie
*/
Movie[] movieImport ;
ArrayList movie_files = new ArrayList();
boolean folder_movie_is_selected = true ;
String [] movie_path, movieImportPath ;
int count_movie_selection ;
int ref_movie_num_files ;

void load_movie(int ID) {
  check_movie_folder_scene() ;
  if(movie_path != null && movie_path.length > 0) {
    if(which_movie[ID] > movie_path.length ) which_movie[ID] = 0 ;
    movieImportPath[ID] = movie_path[which_text[ID]] ;
  } else {
    movieImportPath[ID] = "no movie" ;
  }
  setting_movie(ID) ;
}



// Movie Manager
void setting_movie(int ID_item) {
  String lastThree = movieImportPath[ID_item].substring(movieImportPath[ID_item].length()-3, movieImportPath[ID_item].length());
  if (lastThree.equals("MOV") || lastThree.equals("mov")) {
    movieImport[ID_item] = new Movie(this, movieImportPath[ID_item]);
    movieImport[ID_item].loop();
    movieImport[ID_item].read();
  } else {
    println("BIG BROTHER don't find any movie, that's can became a proble, a real problem for you !") ;
    /**
    bug between OSC and the text, but only in Romanesco, not in isolated sketch see folder Processing 3.0.2 bug
    */
    // text("BIG BROTHER disagree your movie and burn it !", width/2, height/2) ;
  }
}





void check_movie_folder_scene() {
  String path = import_path +"movie" ;
  ArrayList allFiles = listFilesRecursive(path);
  
  //check if something happen in the folder
  if(ref_movie_num_files != allFiles.size() ) {
    folder_movie_is_selected = true ;
    ref_movie_num_files = allFiles.size() ; 
  }
  // If something happen, algorithm work 
  if(folder_movie_is_selected) {
    count_movie_selection++ ;
    movie_files.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("MOV") || lastThree.equals("mov")) {
          movie_files.add(f);
        }
      }
    }
    // edit the path file
    movie_path = new String[movie_files.size()] ;
    for (int i = 0; i < movie_files.size(); i++) {
      File f = (File) movie_files.get(i); 
      movie_path[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folder_movie_is_selected = false ;
  }
}



/**
method to check folder
*/
// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// Function to get a list ofall files in a directory and all subdirectories
ArrayList listFilesRecursive(String dir) {
  ArrayList fileList = new ArrayList(); 
  recurseDir(fileList, dir);
  return fileList;
}

// Recursive function to traverse subdirectories
void recurseDir(ArrayList a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a, subfiles[i].getAbsolutePath());
    }
  } 
  else {
    a.add(file);
  }
}
/**
END CHECK FOLDER
*/





































/**
TEXT MANAGER


*/
// NEW VOID TEXT
String importRaw [] ;



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
TEXT MANAGER END

*/

























/**
MIROIR
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
  if(yTouch) syphon_on_off = !syphon_on_off ;
  if(syphon_on_off) server.sendScreen();
}
/**
END MIROIR
*/






















/**

LOAD

*/
void loadDataObject(String path) {
  JSONArray load = new JSONArray() ;
  load = loadJSONArray(path);
  // init counter
  int startPosJSONDataWorld = 0 ;
  int startPosJSONDataCam = 1 ;
  int startPosJSONDataObj = 0;
    
    // PART ONE
  JSONObject dataWorld = load.getJSONObject(startPosJSONDataWorld);
  onOffBackground = dataWorld.getBoolean("on/off") ;


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
    JSONObject dataObj = load.getJSONObject(i) ;
    int ID = dataObj.getInt("ID obj") ;
    /**
    int fontRefID = dataObj.getInt("which font") ;
    whichFont[ID] = 
    */
    which_bitmap[ID] = dataObj.getInt("which picture") ;
    which_svg[ID] = dataObj.getInt("which svg") ;
    which_movie[ID] = dataObj.getInt("which movie") ;
    which_text[ID] = dataObj.getInt("which text") ;
        // display mode
    mode[ID] = dataObj.getInt("Mode obj") ;
    
        // slider fill
        float h_fill = dataObj.getFloat("hue fill") ;
        float s_fill = dataObj.getFloat("saturation fill") ;
        float b_fill = dataObj.getFloat("brightness fill") ;
        float a_fill = dataObj.getFloat("alpha fill") ;
    // slider stroke
    float h_stroke = dataObj.getFloat("hue stroke") ;
        float s_stroke = dataObj.getFloat("saturation stroke") ;
        float b_stroke = dataObj.getFloat("brightness stroke") ;
        float a_stroke = dataObj.getFloat("alpha stroke") ;

        if(FULL_RENDERING) {
          fill_item[ID] = color(h_fill, s_fill, b_fill, a_fill) ;
      stroke_item[ID] = color(h_stroke, s_stroke, b_stroke, a_stroke) ;
      thickness_item[ID] = dataObj.getFloat("thickness") *height ;
    } else {
      // preview display
      fill_item[ID] = COLOR_FILL_OBJ_PREVIEW ;
      stroke_item[ID] =  COLOR_STROKE_OBJ_PREVIEW ;
      thickness_item[ID] = THICKNESS_OBJ_PREVIEW ;
      }

    size_x_item[ID] = dataObj.getFloat("width") *width ;
    size_y_item[ID] = dataObj.getFloat("height") *width ;
    size_z_item[ID] = dataObj.getFloat("depth") *width ;
    canvas_x_item[ID] = dataObj.getFloat("canvas x") *width ;
    canvas_y_item[ID] = dataObj.getFloat("canvas y") *width ;
    canvas_z_item[ID] = dataObj.getFloat("canvas z") *width ;
    variety_item[ID] = dataObj.getFloat("family") ;
    quantity_item[ID] = dataObj.getFloat("quantity") ;
    life_item[ID] = dataObj.getFloat("life") ;

    speed_x_item[ID] = dataObj.getFloat("speed") ;
    dir_x_item[ID] = dataObj.getFloat("direction") ;
    angle_item[ID] = dataObj.getFloat("angle") ;
    swing_x_item[ID] = dataObj.getFloat("amplitude") ;
    repulsion_item[ID] = dataObj.getFloat("repulsion") ;
    attraction_item[ID] = dataObj.getFloat("attraction") ;
    alignment_item[ID] = dataObj.getFloat("aligmnent") ;
    influence_item[ID] = dataObj.getFloat("influence") ;

    posObj[ID].x  = dataObj.getFloat("pos x obj") *width ;
    posObj[ID].y  = dataObj.getFloat("pos y obj") *width ;
    posObj[ID].z  = dataObj.getFloat("pos z obj") *width ;

    dirObj[ID].x  = dataObj.getFloat("longitude obj") ;
    dirObj[ID].y  = dataObj.getFloat("latitude obj") ;
  }
}
/**

END LOAD

*/
































/**
DISPLAY INFO
*/
boolean displayInfo, displayInfo3D ;
int posInfo = 2 ;


void info() {
  color color_text = color(0,0,100) ;
  color color_bg = color(0,100,100,50) ;
  if (displayInfo) {
    //perspective() ;
    displayInfoScene(color_bg,color_text) ;
    displayInfoObject(color_bg,color_text) ;
  }
  if (displayInfo3D) displayInfo3D(color_text) ;
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
  if (getTimeTrack() > 1 ) text("the track play until " +getTimeTrack() + "  Tempo " + getTempoRef() , 15,15 *(posInfo)) ; else text("no track detected ", 15, 15 *(posInfo)) ;
  posInfo += 1 ;
  text("right " + right_volume_info, 15, 15 *(posInfo)) ;  
  text("left "  + left_volume_info,  50, 15 *(posInfo)) ;
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
  for(int i = 0 ; i < NUM_ITEM ; i++) {
    
    if(show_object[i]) {
      posInfoObj += 1 ;
      String position = ("x:" +(int)posObj[i].x + " y:" + (int)posObj[i].y+ " z:" + (int)posObj[i].z) ;
      text(objectName[i] + " - Coord " + position + " - " + objectInfo[objectID[i]], 10, height -(15 *(posInfoObj -1))) ;
    }
  }
}



//INFO 3D
void displayInfo3D(color txt) {
   String posCam = ( int(-1 *sceneCamera.x ) + " / " + int(sceneCamera.y) + " / " +  int(sceneCamera.z -height/2)) ;
   String eyeDirectionCam = ( int(eyeCamera.x) + " / " + int(eyeCamera.y) ) ;
  fill(txt) ; 
  textFont(SansSerif10, 10) ;
  textAlign(RIGHT) ;
  text("Position " +posCam, width/2 -30 , height/2 -30) ;
  text("Direction " +eyeDirectionCam, width/2 -30 , height/2 -15) ;
}



//////
//P3D

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
END DISPLAY INFO
*/

































/**

UTIL CORE

*/



/**
keyboard
*/
//short Touch
boolean aTouch, bTouch, cTouch, dTouch, eTouch, fTouch, gTouch, hTouch, iTouch, jTouch, kTouch, lTouch, mTouch, nTouch, oTouch, pTouch, qTouch, rTouch, sTouch, tTouch, uTouch, vTouch, wTouch, xTouch, yTouch, zTouch,
        leftTouch, rightTouch, upTouch, downTouch, 
        touch0, touch1, touch2, touch3, touch4, touch5, touch6, touch7, touch8, touch9, 
        backspaceTouch, deleteTouch, enterTouch, returnTouch, shiftTouch, altTouch, escTouch, ctrlTouch, cmdTouch ;
//long touch
boolean cLongTouch, lLongTouch, nLongTouch, vLongTouch,
        spaceTouch, shiftLongTouch ;  



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
easing

deprecated
*/
/*
PVector targetIN = new PVector () ;
//Pen
PVector easingIN = new PVector () ;
//
PVector easing(PVector targetOUT, float effectOUT) {
  targetIN.x = targetOUT.x;
  float dx = targetIN.x - easingIN.x;
  if(abs(dx) > 1) {
    easingIN.x += dx * effectOUT;
  }
  
  targetIN.y = targetOUT.y;
  float dy = targetIN.y - easingIN.y;
  if(abs(dy) > 1) {
    easingIN.y += dy * effectOUT;
  }
  return easingIN ;
}
//
void resetEasing(PVector targetOUT) {
  easingIN.x = targetOUT.x ; easingIN.y = targetOUT.y ;
}
*/

/**
NEXT PREVIOUS
*/
void nextPreviousKeypressed() {
    //tracking
  nextPrevious = true ;
}

/**
tracking with pad
*/
int tracking(int t, int n) {
  if (nextPrevious) {
    if (downTouch && t < n-1 ) {
      trackerUpdate = +1 ;
    } else if (upTouch  && t > 0 ) {
      trackerUpdate = -1 ;
    } 
  }
  if (nextPrevious) {
    if ( leftTouch  && t > 0 ) {
      trackerUpdate = -1 ;
    } else if ( rightTouch && t < n-1 ) {
      trackerUpdate = +1 ;
    }
  }
  nextPrevious = false ;
  return trackerUpdate ;
}


/**
curtain
*/
void curtain() {
  if(!onOffCurtain) {
    rectMode(CORNER) ;
    fill (0) ; 
    noStroke() ;
    rect(-1,-1, width+2, height+2);
  }
}

/**
OS mac DETECTION
*/
boolean mavericks = false ;
void OSMavericksCheck() {
  // check OSX version
  String OS = System.getProperty("os.version") ;
  OS  = OS.replace(".","");
  int OSversion = Integer.parseInt(OS);
  if(OSversion >= 1090  ) mavericks = true ; else mavericks = false ;
}


/**

UTIL CORE END


*/

















/**

ROMANESCO BACKGROUND 1.0.1.3

*/
Vec4 colorBackground, colorBackgroundRef, colorBackgroundPrescene;


void background_setup() {
  colorBackgroundRef = Vec4() ;
  colorBackground = Vec4() ;
  colorBackgroundPrescene = Vec4(0,0,20,g.colorModeA) ;
}


void background_romanesco() {
  // in preview mode the background is always on, to remove the trace effect
  if(!FULL_RENDERING) { 
    onOffBackground = false ;
    colorBackground = colorBackgroundPrescene.copy() ;
    background_rope(0,0,g.colorModeZ *.2,g.colorModeA) ;
  } else {
    if(onOffBackground) {
      if(whichShader == 0) {
        // check if the color model is changed after the shader used
        if(g.colorMode != 3 || g.colorModeX != 360 || g.colorModeY != 100 || g.colorModeZ !=100 || g.colorModeA !=100) colorMode(HSB,360,100,100,100) ;
        // choice the rendering color palette for the classic background
        if(FULL_RENDERING) {
          // check if the slider background are move, if it's true update the color background
          if(!equals(colorBackgroundRef,update_background())) {
            colorBackground.set(update_background()) ;
          } else {
            colorBackgroundRef.set(update_background()) ;
          }
          background_rope(colorBackground) ;
        }
        background_rope(colorBackground) ;
      } else {
        background_shader_draw(whichShader) ;
      }
    }
  }
}






// ANNEXE VOID BACKGROUND
Vec4 update_background() {
  //to smooth the curve of transparency background
  // HSB
  float hue_bg =         map(valueSlider[0][0],0,MAX_VALUE_SLIDER,0,HSBmode.r) ;
  float saturation_bg =  map(valueSlider[0][1],0,MAX_VALUE_SLIDER,0,HSBmode.g) ;
  float brigthness_bg =  map(valueSlider[0][2],0,MAX_VALUE_SLIDER,0,HSBmode.b) ;
  // ALPHA
  float factorSmooth = 2.5 ;
  float nx = norm(valueSlider[0][3], 0.0 , MAX_VALUE_SLIDER) ;
  float alpha = pow (nx, factorSmooth);
  alpha = map(alpha, 0, 1, 0.8, HSBmode.a) ;
  return Vec4(hue_bg,saturation_bg,brigthness_bg,alpha) ;
}







// BACKGROUND SHADER
PShader blurOne, blurTwo, cellular, damierEllipse, heart, necklace,  psy, sinLight, snow ;
//PShader bizarre, water, psyTwo, psyThree ;

void background_shader_setup() {
  String pathShaderBG = preference_path +"shader/shader_bg/" ;

  blurOne = loadShader(pathShaderBG+"blurOneFrag.glsl") ;
  blurTwo = loadShader(pathShaderBG+"blurTwoFrag.glsl") ;
  cellular = loadShader(pathShaderBG+"cellularFrag.glsl") ;
  damierEllipse = loadShader(pathShaderBG+"damierEllipseFrag.glsl") ;
  heart = loadShader(pathShaderBG+"heartFrag.glsl") ;
  necklace = loadShader(pathShaderBG+"necklaceFrag.glsl") ;
  psy = loadShader(pathShaderBG+"psyFrag.glsl") ;
  sinLight = loadShader(pathShaderBG+"sinLightFrag.glsl") ;
  snow = loadShader(pathShaderBG+"snowFrag.glsl") ;

  /*
  bizarre = loadShader(pathShaderBG+"bizarreFrag.glsl") ; // work bad
  water = loadShader(pathShaderBG+"waterFrag.glsl") ; // problem
  psyTwo = loadShader(pathShaderBG+"psyTwoFrag.glsl") ; // problem
  psyThree = loadShader(pathShaderBG+"psyThreeFrag.glsl") ; // problem
  */

}



void background_shader_draw(int whichOne) {
  if(TEST_ROMANESCO || FULL_RENDERING) {
    PVector posBGshader = new PVector(0,0) ;
    PVector sizeBGshader = new PVector(width,height, height) ; 
    fill(0) ; noStroke() ;

    if     (whichOne ==1) rectangle(posBGshader, sizeBGshader, blurOne ) ;
    else if(whichOne ==2) rectangle(posBGshader, sizeBGshader, blurTwo ) ;
    else if(whichOne ==3) rectangle(posBGshader, sizeBGshader, cellular) ;
    else if(whichOne ==4) rectangle(posBGshader, sizeBGshader, damierEllipse) ;
    else if(whichOne ==5) rectangle(posBGshader, sizeBGshader, heart) ;
    else if(whichOne ==6) rectangle(posBGshader, sizeBGshader, necklace) ;
    else if(whichOne ==7) rectangle(posBGshader, sizeBGshader, psy) ;
    else if(whichOne ==8) rectangle(posBGshader, sizeBGshader, snow ) ;
    else if(whichOne ==9) rectangle(posBGshader, sizeBGshader, sinLight ) ;
    
    
    //rectangle(posBGshader, sizeBGshader, bizarre) ;  // work bad
    //rectangle(posBGshader, sizeBGshader, water) ; // problem
    //rectangle(posBGshader, sizeBGshader, psyTwo) ; // problem
    //rectangle(posBGshader, sizeBGshader, psyThree) ; // problem
  }  else if (whichOne != 0  ) {
    background_norm(1) ;
    int sizeText = 14 ;
    textSize(sizeText) ;
    fill(orange) ; noStroke() ;
    text("Shader is ON", sizeText, height/3) ;
  } 

}

float shaderMouseX, shaderMouseY ;
void rectangle(PVector pos, PVector size, PShader s) {
  int factorSize = 10 ;
  size.mult(factorSize) ;
  pushMatrix() ;
  translate(-size.x *.5,-size.y *.5 , -size.z*.5) ;
  shader(s) ;

  Vec4 RGBbackground = HSB_to_RGB( map(valueSlider[0][0],0,MAX_VALUE_SLIDER,0,g.colorModeX), 
                                map(valueSlider[0][1],0,MAX_VALUE_SLIDER,0,g.colorModeY), 
                                map(valueSlider[0][2],0,MAX_VALUE_SLIDER,0,g.colorModeZ),
                                map(valueSlider[0][3],0,MAX_VALUE_SLIDER,0,g.colorModeA)  ) ;
  float redNorm = map(RGBbackground.x,0,255,0,1) ;
  float greenNorm = map(RGBbackground.y,0,255,0,1) ;
  float blueNorm = map(RGBbackground.z,0,255,0,1) ;
  float alphaNorm = map(RGBbackground.w,0,255,0,1) ;
  float varTime = (float)millis() *.001 ;
  if(spaceTouch) {
    shaderMouseX = map(mouse[0].x,0,width,0,1) ;
    shaderMouseY = map(mouse[0].y,0,height,0,1) ;
  }
  
  s.set("colorBG",redNorm, greenNorm, blueNorm, alphaNorm) ; 
  s.set("mixSound", mix[0]) ;
  s.set("timeTrack", getTimeTrack()) ;
  s.set("tempo", tempo[0]) ;
  s.set("beat", allBeats(0)) ;
  s.set("mouse",shaderMouseX, shaderMouseY) ;
  s.set("resolution",size.x/factorSize, size.y/factorSize) ;
  s.set("time", varTime);
  
  beginShape(QUADS) ;
  vertex(pos.x,pos.y) ;
  vertex(pos.x +size.x,pos.y) ;
  vertex(pos.x +size.x,pos.y +size.y) ;
  vertex(pos.x,pos.y +size.y) ;
  endShape() ;
  resetShader() ;
  popMatrix() ;
}

/**

END BACKGROUND

*/






































/**

SOUND rope 1.0.1

*/
//GLOBAL PARAMETER Minim
Minim minim;
AudioInput input; // music from outside
// spectrum
FFT fft; 

//beat
BeatDetect beatEnergy, beatFrequency;
BeatListener bl;


float beatData, kickData, snareData, hatData ;
float minBeat = 1.0 ;
float maxBeat = 10.0  ;

//volume
int right_volume_info = 0 ;
int left_volume_info = 0 ;


// boolean
boolean SOUND_PLAY ;

//////////////
// SOUND SETUP
void sound_setup() {
  //Sound
  minim = new Minim(this);
  //sound from outside
  minim.debugOn();
  input = minim.getLineIn(Minim.STEREO, 512);
  
  spectrumSetup(NUM_BANDS) ;
  beatSetup() ;
}
// END SOUND SETUP
//////////////////




/////////////
// SOUND DRAW
void soundDraw() {
  spectrum(input.mix, NUM_BANDS) ;
  beatEnergy.detect(input.mix);
  initTempo() ;
  soundRomanesco() ;
  right_volume_info = int(input.right.get(1)  *100) ; 
  left_volume_info = int(input.left.get(1)  *100) ;
  time_track() ;
}
// END SOUND DRAW
/////////////////






//specific stuff from romanesco
//////////////////////////////
void soundRomanesco() {
  int sound = 1 ;
    
  float volumeControleurG = map(valueSlider[0][4], 0,MAX_VALUE_SLIDER, 0, 1.3 ) ;
  left[0] = map(input.left.get(sound),  -0.07,0.1,  0, volumeControleurG);
  
  float volumeControleurD = map(valueSlider[0][5], 0,MAX_VALUE_SLIDER, 0, 1.3 ) ;
  right[0] = map(input.right.get(sound),  -0.07,0.1,  0, volumeControleurD);
  
  float volumeControleurM = map(( (valueSlider[0][4] + valueSlider[0][5]) *.5), 0,MAX_VALUE_SLIDER, 0, 1.3 ) ;
  mix[0] = map(input.mix.get(sound),  -0.07,0.1,  0, volumeControleurM);
  
  //volume
  if(left[0] < 0 ) left[0] = 0 ;
  if(left[0] > 1 ) left[0] = 1.0 ; 
  if(right[0] < 0 ) right[0] = 0 ;
  if(right[0] > 1 ) right[0] = 1.0 ; 
  if(mix[0] < 0 ) mix[0] = 0 ;
  if(mix[0] > 1 ) mix[0] = 1.0 ;
  
  //Beat
  beat[0] = getBeat(onOffBeat) ;
  kick[0] = getKick(onOffKick) ;
  snare[0] = getSnare(onOffSnare) ;
  hat[0] = getHat(onOffHat) ;
  
  
  //spectrum
  for ( int i = 0 ; i < NUM_BANDS ; i++ ) {
    band[0][i] = bandSprectrum[i] ;
  }
  
  //tempo
  tempo[0] = getTempoRef() ;
  tempoKick[0] = getTempoKickRef() ;
  tempoSnare[0] = getTempoSnareRef() ;
  tempoHat[0] = getTempoHatRef() ;
}
  



//////
//BEAT
//GLOBAL
int beatNum, kickNum, snareNum, hatNum ;
//setup
void beatSetup() {
  //Beat Frequency
  beatFrequency = new BeatDetect(input.bufferSize(), input.sampleRate());
  beatFrequency.setSensitivity(300);
  kickData = snareData = hatData = minBeat; 
  bl = new BeatListener(beatFrequency, input); 
  
  //Beat energy
  beatEnergy = new BeatDetect();
  beatData = 1.0 ;
}
//RETURN
//BEAT QUANTITY
int getBeatNum() {
  if ( beatEnergy.isOnset() ) beatNum += 1 ; else if (  getTotalSpectrum(NUM_BANDS) < 0.03 ) beatNum = 0 ;
  return beatNum ;
}
int getKickNum() {
  if ( beatFrequency.isKick()  ) kickNum += 1 ; else if (  getTotalSpectrum(NUM_BANDS) < 0.03 ) kickNum = 0 ;
  return kickNum ;
}
int getSnareNum() {
  if ( beatFrequency.isSnare()  ) snareNum += 1 ; else if (  getTotalSpectrum(NUM_BANDS) < 0.03 ) snareNum = 0 ;
  return snareNum ;
}
int getHatNum() {
  if ( beatFrequency.isHat()  ) hatNum += 1 ; else if (  getTotalSpectrum(NUM_BANDS) < 0.03 ) hatNum = 0 ;
  return hatNum ;
}

//RESULT
float getBeat(boolean beat) {
  if (beat) {
    if ( beatEnergy.isOnset() ) beatData = maxBeat;
    beatData *= 0.95;
    if ( beatData < minBeat ) beatData = minBeat;
  } else beatData = 1.0 ;
  
  return beatData ;
}

float getKick(boolean kick) {
  if (kick) {
    if ( beatFrequency.isKick() )  kickData = maxBeat;
    kickData = constrain(kickData * 0.95, minBeat, maxBeat);
  } else kickData = 1.0 ;
  //
  return kickData ;
}

float getSnare(boolean snare) {
  if (snare) {
    if ( beatFrequency.isSnare() )  snareData = maxBeat;
    snareData = constrain(snareData * 0.95, minBeat, maxBeat);
  } else snareData = 1.0 ;
  //
  return snareData ;
}

float getHat(boolean hat) {
  if (hat) {
    if ( beatFrequency.isHat() )  hatData = maxBeat;
    hatData = constrain(hatData * 0.95, minBeat, maxBeat);
  } else hatData = 1.0 ;
  //
  return hatData ;
}
//END BEAT
/////////







///////
//TEMPO
float tempoMin = 0.01 ;
float tempoMax = 1.0 ;
int maxSpecific = 1 ;

// float tempoBeat = 0.005 ;
float mesure ; 
boolean refresh = false ;

//Direct Specific Analyze
//GLOBAL

float tempoBeatRef = 1 ;
float tempoKickRef = 1 ; 
float tempoSnareRef = 1 ; 
float tempoHatRef = 1 ; // for Beat, Kick, Snare, Hat
float tempoB, tempoK,  tempoS,  tempoH  ;
float tempoBeatAdd  = 0.005 ;
float tempoKickAdd  = 0.005 ;
float tempoSnareAdd = 0.005 ;
float tempoHatAdd   = 0.005 ;
//RETURN



//INITIALIZATION

void initTempo() {
  // this weird float who's not used must be here, we must work around !
  float init = getTempoBeat() + getTempoKick()  + getTempoHat() + getTempoSnare() ;
}


//return global tempo
float getTempoRef() {
  // I remove the snare because is very bad information and slow down the the speed
  float tempoRef = 1 - (getTempoBeatRef() + getTempoKickRef()  + getTempoHatRef() ) *.33 ;
  return tempoRef ;
}
//get tempo
float getTempo() {
  // I remove the snare because is very bad information and slow down the the speed
  float tempo = (getTempoBeat() + getTempoKick()  + getTempoHat() ) *.33 ;
  return tempo ;
}
// return direct BEAT
float getTempoBeat() {
  if ( beatEnergy.isOnset()  ) {
    if( tempoB != 0 ) tempoBeatRef = tempoB ;
    tempoB = 0 ; 
  } else {
    tempoB += tempoBeatAdd  ;
  }
  return tempoB ;
}
float getTempoBeatRef() {
  if (tempoBeatRef > maxSpecific || getTotalSpectrum(NUM_BANDS) < 0.03  ) tempoBeatRef = maxSpecific  ; 
  return  tempoBeatRef ;
}


// return direct KICK
float getTempoKick() {
  if ( beatFrequency.isKick()  ) {
    if( tempoK != 0 ) tempoKickRef = tempoK ;
    tempoK = 0 ; 
  } else {
    tempoK += tempoKickAdd  ;
  }
  return tempoK ;
}
float getTempoKickRef() {
  if (tempoKickRef > maxSpecific || getTotalSpectrum(NUM_BANDS) < 0.03  ) tempoKickRef = maxSpecific  ; 
  return  tempoKickRef ;
}

// return direct SNARE
float getTempoSnare() {
  if ( beatFrequency.isSnare()  ) {
    if( tempoS != 0 ) tempoSnareRef = tempoS ;
    tempoS = 0 ; 
  } else {
    tempoS += tempoSnareAdd  ;
  }
  return tempoS ;
}
float getTempoSnareRef() {
  if (tempoSnareRef > maxSpecific || getTotalSpectrum(NUM_BANDS) < 0.03  ) tempoSnareRef = maxSpecific  ; 
  return  tempoSnareRef ;
}

// return direct Hat
float getTempoHat() {
  if ( beatFrequency.isHat()  ) {
    if( tempoH != 0 ) tempoHatRef = tempoH ;
    tempoH = 0 ; 
  } else {
    tempoH += tempoHatAdd  ;
  }
  return tempoH ;
}
float getTempoHatRef() {
  if (tempoHatRef > maxSpecific || getTotalSpectrum(NUM_BANDS) < 0.03  ) tempoHatRef = maxSpecific  ; 
  return  tempoHatRef ;
}




//Average Analyze
//GLOBAL
float tempoAverage, tempoAverageRef  ;
float tempoBeatAverage = 0.05 ;
//RETURN
float tempoAverageRef() {
  //regulation du tempo
  if ( mesure == 0 && !refresh ) {
    tempoAverageRef = tempoAverage()  ;
    tempoAverage = 0.01 ;
    refresh = true ;
  }
  if ( mesure != 0 ) refresh = false ;
  
  return tempoAverageRef ;
}


float tempoAverage() {
  mesure = second()%2 ;
  
  if ( beatEnergy.isOnset() || beatFrequency.isKick() || beatFrequency.isSnare() || beatFrequency.isHat()  )  tempoAverage += tempoBeatAverage  ;
  if ( tempoAverage > 1.0 ) tempoAverage = 1.0 ;
  
  //regulation du tempo
  if ( mesure == 0 && !refresh ) {
    tempoAverageRef = tempoAverage  ;
    tempoAverage = 0.01 ;
    refresh = true ;
  }
  
  if ( mesure != 0 ) refresh = false ;
  
  return tempoAverage ;
}

//END TEMPO
//////////


//TIME TRACK
////////////
//GLOBAL
int time_track_elapse  ;
void time_track() {
  if(getTimeTrack() > .2 ) SOUND_PLAY = true ; else SOUND_PLAY = false ;
}
//RETURN
float getTimeTrack() {
  float t ; 
  time_track_elapse += millis() % 10 ;
  t = time_track_elapse *.01 ;
  if ( getTotalSpectrum(NUM_BANDS) < 0.1 ) time_track_elapse = 0 ;
  return round( t * 10.0f ) / 10.0f; 
}
////////////////
//END TIME TRACK


//SPECTRUM
//////////
//SPECTRUM
//info text band
float [] bandSprectrum  ;
//SETUP
void spectrumSetup(int n) {
  //spectrum
  bandSprectrum = new float [n] ;
  fft = new FFT(input.bufferSize(), input.sampleRate());
  fft.linAverages(n);
}

//DRAW
//just create spectrum
void spectrum(AudioBuffer fftData, int n) {
  fft.forward(fftData) ;
  for(int i = 0; i < n ; i++)
  {
    fft.scaleBand(i, 0.5 ) ;
    bandSprectrum[i] = fft.getBand(i) ;
  }
}

//ANNEXE VOID
float getTotalSpectrum(int NUM_BANDS) {
  float t = 0 ;
  if (bandSprectrum != null ) {
   for ( int i = 0 ; i < NUM_BANDS ; i++ ) {
     //  if(bandSprectrum[i] != null ) t += bandSprectrum[i] ;
      t += bandSprectrum[i] ;
    }
  }
  return t ;
}
//END SPECTRUM
//////////////





//CLASS to use the beat analyze
class BeatListener implements AudioListener {
  private BeatDetect beatFrequency;
  private AudioInput source;
  
  BeatListener(BeatDetect beatFrequency, AudioInput source) {
    this.source = source;
    this.source.addListener(this);
    this.beatFrequency = beatFrequency;
  }
  
  void samples(float[] samps) {
    beatFrequency.detect(source.mix);
  }
  
  void samples(float[] sampsL, float[] sampsR) {
    beatFrequency.detect(source.mix);
  }
}



//END MINIM
void stop() {
  input.close() ;
  minim.stop() ;
  super.stop() ;
}

/**

SOUND END
*/









































/**

CAMERA COMPUTER 1.1.0

*/
Capture cam;
String[] cameras ;
String[] cam_name ;
PVector[] cam_size ;
int[] cam_fps ;
int which_cam = 0;
int ref_cam = -1 ;
PVector CAM_SIZE ;
boolean CAMERA_AVAILABLE ;
boolean BROADCAST ;

boolean new_cam = true ;
boolean stop_cam = false ;
boolean init_cam = false ;



// Main method camera
void camera_video_setup() {
  list_cameras() ;
  if(new_cam && which_cam > -1) launch_camera(which_cam) ;
}

void video_camera_manager() {
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





// annexe methode camera
void launch_camera(int which_cam) {
  if(CAMERA_AVAILABLE) {
    // if(FULL_RENDERING) which_cam = 0 ; else which_cam = 7 ; // 4 is normal camera around 800x600 or 640x360 with 30 fps
    if(!init_cam) {
      init_camera(which_cam) ;
      init_cam = true ;
    }
    CAM_SIZE = cam_size[which_cam].copy() ;
    // surface.setSize((int)cam_size[which_cam].x, (int)cam_size[which_cam].y) ;
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
  // cam.read(); 

}


void list_cameras() {
  cameras = Capture.list();
  cam_name = new String[cameras.length] ;
  cam_size = new PVector[cameras.length] ;
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
      cam_size[i] = new PVector(Integer.parseInt(sizeXY[0]), Integer.parseInt(sizeXY[1])) ;  // Integer.parseInt("1234");
      // fps
      String fps = cam_data [2].substring(4,cam_data[2].length()) ;
      cam_fps[i] = Integer.parseInt(fps) ;
    }
  } else {
    CAMERA_AVAILABLE = false ;
  }
}
/**
END COMPUTER CAMERA
*/


































/**

Color Romanesco 1.0.1.1

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

//ROLLOVER TEXT ON BACKGROUNG CHANGE

//









  

  
















































































  
/**
OSC CORE Version 1.1.1
*/
/////////////////////////
// RECEIVE INFO from CONTROLLER
////////////////////////////////
int numOfPartSendByController = 5 ; 
String fromController [] = new String [numOfPartSendByController] ;
//EVENT to check what else is receive by the receiver





// ANNEXE VOID of OSC RECEIVE

// catch raw osc data
void catchDataFromController(OscMessage receive) {
  for ( int i = 0 ; i < fromController.length ; i++ ) {
    fromController [i] = receive.get(i).stringValue() ;
  }
}

// split data button
void splitDataButton() {
  //Split data from the String Data
  valueButtonGlobal = int(split(fromController [0], '/')) ;
  // stick the Int(String) chain from the group object "one" and "two" is single chain integer(String).
  String fullChainValueButtonObj =("") ;
  for ( int i = 1 ; i <= NUM_GROUP ; i++ ) {
    fullChainValueButtonObj += fromController [i]+"/" ;
  }
  valueButtonObj = int(split(fullChainValueButtonObj, '/')) ;
}

// split data slider
void splitDataSlider() {
    //SLIDER
  //split String value from controller
  int numTotalGroup = NUM_GROUP +1 ;
  for ( int i = 0 ; i < numTotalGroup ; i++ ) {
    valueSliderTemp [i] = split(fromController [i +numTotalGroup], '/') ;
  }
  // translate the String value to the float var to use
  for ( int i = 0 ; i < NUM_GROUP +1 ; i++ ) {
    // security because there not same quantity of slider in the group MISC "zero" and OBJECT group "one and two".
    int n = 0 ;
    if ( i < 1 ) n = NUM_SLIDER_MISC ; else n = NUM_SLIDER_OBJ ;
    for (int j = 0 ; j < n ; j++) {
      valueSlider[i][j] = Float.valueOf(valueSliderTemp[i][j]) ;
    }
  }
}


// split data boolean to give load or save order
void splitDataLoadSaveController() {
    // LOAD SAVE

  /*
  +1 for the global group
  *2 because there is one group for the button and an other one for the slider
  */
  int whichOne = (NUM_GROUP +1) *2 ;
  String [] booleanSave  ;

  booleanSave = split(fromController[whichOne], '/') ;
  // convert string to boolean
  load_SCENE_Setting_GLOBAL = Boolean.valueOf(booleanSave[0]).booleanValue();
  save_Current_SCENE_Setting_GLOBAL = Boolean.valueOf(booleanSave[1]).booleanValue();
  save_New_SCENE_Setting_GLOBAL = Boolean.valueOf(booleanSave[2]).booleanValue();
}



// TRANSFORM info from controler to use in the PRESCENE
void translateDataFromController_buttonGlobal() {
  // sound option on/off
  if(valueButtonGlobal[1] == 1 ) onOffBeat = true ; else onOffBeat = false ;
  if(valueButtonGlobal[2] == 1 ) onOffKick = true ; else onOffKick = false ;
  if(valueButtonGlobal[3] == 1 ) onOffSnare = true ; else onOffSnare = false ;
  if(valueButtonGlobal[4] == 1 ) onOffHat = true ; else onOffHat = false ;
  // backgound option on/off
  if(valueButtonGlobal[6] == 1 ) onOffCurtain = true ; else onOffCurtain = false ;
  if(valueButtonGlobal[7] == 1 ) onOffBackground = true ; else onOffBackground = false ;
  // light on/off
  if(valueButtonGlobal[8] == 1 ) onOffDirLightOne = true ; else onOffDirLightOne = false ;
  if(valueButtonGlobal[9] == 1 ) onOffDirLightTwo = true ; else onOffDirLightTwo = false ;
  if(valueButtonGlobal[10] == 1 ) onOffLightAmbient = true ; else onOffLightAmbient = false ;
  // light move light on/off
  if(valueButtonGlobal[11] == 1 ) onOffDirLightOneAction = true ; else onOffDirLightOneAction = false ;
  if(valueButtonGlobal[12] == 1 ) onOffDirLightTwoAction = true ; else onOffDirLightTwoAction = false ;
  if(valueButtonGlobal[13] == 1 ) onOffLightAmbientAction = true ; else onOffLightAmbientAction = false ;
  
  // list choice
  whichShader = valueButtonGlobal[14] ;

  select_font(valueButtonGlobal[5]) ;

  which_bitmap[0] = valueButtonGlobal[15] ;
  which_svg[0] = valueButtonGlobal[16] ;
  which_text[0] = valueButtonGlobal[17] ;
  which_movie[0] = valueButtonGlobal[18] ;
  which_cam = valueButtonGlobal[19] ;
}
void translateDataFromController_buttonItem() {
  for (int i = 0 ; i < NUM_ITEM -1 ; i++) {
    int iPlusOne = i+1 ;
    objectButton   [iPlusOne] = valueButtonObj[i *10 +1] ;
    parameterButton[iPlusOne] = valueButtonObj[i *10 +2] ;
    soundButton    [iPlusOne] = valueButtonObj[i *10 +3] ;
    actionButton   [iPlusOne] = valueButtonObj[i *10 +4] ;
    mode     [iPlusOne] = valueButtonObj[i *10 +9] ;
    if (objectButton[iPlusOne] == 1 ) show_object[iPlusOne] = true ; else show_object[iPlusOne] = false ;
    if (parameterButton[iPlusOne] == 1 ) parameter[iPlusOne] = true ; else parameter[iPlusOne] = false ;
    if (soundButton[iPlusOne] == 1 ) sound[iPlusOne] = true ; else sound[iPlusOne] = false ;
    if (actionButton[iPlusOne] == 1 ) action[iPlusOne] = true ; else action[iPlusOne] = false ;
  }
}


/**
OSC CORE END

*/























/**

FONT MANAGER 
v 2.0.1.0

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



      
//SETUP
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




