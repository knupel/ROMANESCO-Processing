/**
Rope Manager
2013-2018
v 1.1.2
*/
Romanesco_manager rpe_manager;
String ROM_HUE_FILL, ROM_SAT_FILL,ROM_BRIGHT_FILL, ROM_ALPHA_FILL = "";
String ROM_HUE_STROKE,ROM_SAT_STROKE,ROM_BRIGHT_STROKE,ROM_ALPHA_STROKE = "";
String ROM_THICKNESS = "";
String ROM_SIZE_X,ROM_SIZE_Y,ROM_SIZE_Z = "";
String ROM_FONT_SIZE = "";
String ROM_CANVAS_X,ROM_CANVAS_Y,ROM_CANVAS_Z = "";

String ROM_REACTIVITY = "";
String ROM_SPEED_X,ROM_SPEED_Y,ROM_SPEED_Z = "";
String ROM_SPURT_X,ROM_SPURT_Y,ROM_SPURT_Z = "";
String ROM_DIR_X,ROM_DIR_Y,ROM_DIR_Z = "";
String ROM_JIT_X,ROM_JIT_Y,ROM_JIT_Z = "j";
String ROM_SWIWG_X,ROM_SWIWG_Y,ROM_SWIWG_Z = "";

String ROM_NUM = "";
String ROM_VARIETY = "";
String ROM_LIFE = "";
String ROM_FLOW = "";
String ROM_QUALITY = "";
String ROM_AREA = "";
String ROM_ANGLE = "";
String ROM_SCOPE = "";
String ROM_SCAN = "";
String ROM_ALIGN = "";
String ROM_REPULSION = "";
String ROM_ATTRACTION = "";
String ROM_DENSITY = "";
String ROM_INFLUENCE = "";
String ROM_CALM = "";
String ROM_SPECTRUM = "";

void romanesco_build_item() {
  set_slider_item_name();
  rpe_manager = new Romanesco_manager(this);
  rpe_manager.add_item_romanesco();
  rpe_manager.finishIndex();
  rpe_manager.writeInfoUser();
  println("Romanesco setup done");
}

void set_slider_item_name() {
  Table slider_item_data = loadTable(preference_path+"slider_name_en.csv","header");

  
  String [][] slider_name = new String[3][16];
  for(int i = 0 ; i < slider_item_data.getRowCount() ;i++) {
    TableRow row = slider_item_data.getRow(i);
    for(int line = 0 ; line < 3 ; line++) {
      String name = "";
      if(line == 0) {
        name = "item a";
      } else if(line == 1) {
        name = "item b";
      } else if(line == 2) {
        name = "item c";
      }
      if(row.getString("name").equals(name)) {
        for(int k = 0 ; k < slider_item_data.getColumnCount()-1 ; k++) {
          if(k < slider_name[line].length) {
            slider_name[line][k] = row.getString("col "+Integer.toString(k)) ;
            println("slider",line,k,slider_name[line][k]);
          }
        }
      }
    }
  }
  /*
  for(int i = 0 ; i < 3 ; i++) {
    for(int k = 0 ; k < 16 ; k++) {
      TableRow row = slider_item_data.getRow(i+6);
      //String which_col = Integer.toString(k);
      slider_name[i][k] = row.getString("col "+Integer.toString(k)) ;
      println("slider",i,k,slider_name[i][k]);
    }
  }
  */
  ROM_HUE_FILL = slider_name[0][0];
  ROM_SAT_FILL = slider_name[0][1];
  ROM_BRIGHT_FILL = slider_name[0][2];
  ROM_ALPHA_FILL = slider_name[0][3];
  ROM_HUE_STROKE = slider_name[0][4];
  ROM_SAT_STROKE = slider_name[0][5];
  ROM_BRIGHT_STROKE = slider_name[0][6];
  ROM_ALPHA_STROKE = slider_name[0][7];
  ROM_THICKNESS = slider_name[0][8];
  ROM_SIZE_X = slider_name[0][9];
  ROM_SIZE_Y = slider_name[0][10];
  ROM_SIZE_Z = slider_name[0][11];
  ROM_FONT_SIZE = slider_name[0][12];
  ROM_CANVAS_X = slider_name[0][13];
  ROM_CANVAS_Y = slider_name[0][14];
  ROM_CANVAS_Z = slider_name[0][15];

  ROM_REACTIVITY = slider_name[1][0];
  ROM_SPEED_X = slider_name[1][1];
  ROM_SPEED_Y = slider_name[1][2];
  ROM_SPEED_Z = slider_name[1][3];
  ROM_SPURT_X = slider_name[1][4];
  ROM_SPURT_Y = slider_name[1][5];
  ROM_SPURT_Z = slider_name[1][6];
  ROM_DIR_X = slider_name[1][7];
  ROM_DIR_Y = slider_name[1][8];
  ROM_DIR_Z = slider_name[1][9];
  ROM_JIT_X = slider_name[1][10];
  ROM_JIT_Y = slider_name[1][11];
  ROM_JIT_Z = slider_name[1][12];
  ROM_SWIWG_X = slider_name[1][13];
  ROM_SWIWG_Y = slider_name[1][14];
  ROM_SWIWG_Z = slider_name[1][15];

  ROM_NUM = slider_name[2][0];
  ROM_VARIETY = slider_name[2][1];
  ROM_LIFE = slider_name[2][2];
  ROM_FLOW = slider_name[2][3];
  ROM_QUALITY = slider_name[2][4];
  ROM_AREA = slider_name[2][5];
  ROM_ANGLE = slider_name[2][6];
  ROM_SCOPE = slider_name[2][7];
  ROM_SCAN = slider_name[2][8];
  ROM_ALIGN = slider_name[2][9];
  ROM_REPULSION = slider_name[2][10];
  ROM_ATTRACTION = slider_name[2][11];
  ROM_DENSITY = slider_name[2][12];
  ROM_INFLUENCE = slider_name[2][13];
  ROM_CALM = slider_name[2][14];
  ROM_SPECTRUM = slider_name[2][15];
}

//Update the var of the object
void update_var_items(int ID) {
  //initialization
  if(!init_value_mouse[ID]) { 
    mouse[ID] = mouse[0].copy() ;
    pen[ID] = pen[0].copy() ;
    init_value_mouse[ID] = true ;
  }
  if(!init_value_controller[ID]) {
    font_item[ID] = font_library ;
    path_font_item[ID] = path_font_library[0] ;
    update_slider_value(ID) ;
    init_value_controller[ID] = true ;
    which_bitmap[ID] = which_bitmap[0] ;
    which_text[ID] = which_text[0] ;
    which_svg[ID] = which_svg[0] ;
    which_movie[ID] = which_movie[0] ;
  }
  
  // info
  item_info_display[ID] = displayInfo?true:false ;
  
  
  if(parameter[ID]) {
    which_bitmap[ID] = which_bitmap[0] ;
    which_text[ID] = which_text[0] ;
    which_svg[ID] = which_svg[0] ;
    which_movie[ID] = which_movie[0] ;
    font_item[ID] = font_library ;
    update_slider_value(ID) ;
  }
  update_var_sound(ID) ;
  
  if(action[ID] ){
    if(key_space_long) {
      pen[ID].set(pen[0]) ;
      mouse[ID].set(mouse[0]) ;
    }
    if (key_n) birth[ID] = !birth[ID] ;
    if (key_x) colour[ID] = !colour[ID] ;
    if (key_d) dimension[ID] = !dimension[ID] ;
    if (key_h) horizon[ID] = !horizon[ID] ;
    if (key_m) motion[ID] = !motion[ID] ;
    if (key_o) orbit[ID] = !orbit[ID] ;
    if (key_r) reverse[ID] = !reverse[ID] ;
    if (key_f) special[ID] = !special[ID] ;
    if (key_w) wire[ID] = !wire[ID] ;

    if (key_j) fill_is[ID] = !fill_is[ID] ;
    if (key_k) stroke_is[ID] = !stroke_is[ID] ;

    clickLongLeft[ID] = ORDER_ONE ;
    clickLongRight[ID] = ORDER_TWO ;
    clickShortLeft[ID] = clickShortLeft[0] ;
    clickShortRight[ID] = clickShortRight[0] ;
  }
}




//
void update_slider_value(int ID) {
  if(FULL_RENDERING) {
    /**
    Changer : le fill et le stroke doivent se calculer sur des valeurs séparée, hue, sat, bright and alpha, sinon quand on les change cela change tout d'une seul coup.
    */
    // fill obj
    if(!first_opening_item[ID] ) fill_item[ID] = color(fill_hue_raw, fill_sat_raw, fill_bright_raw, fill_alpha_raw); 
    else if(fill_hue_temp != fill_hue_raw) fill_item[ID] = color(fill_hue_raw, saturation(fill_item[ID]), brightness(fill_item[ID]), alpha(fill_item[ID]));
    else if(fill_sat_temp != fill_sat_raw) fill_item[ID] = color(hue(fill_item[ID]), fill_sat_raw, brightness(fill_item[ID]), alpha(fill_item[ID])); 
    else if(fill_bright_temp != fill_bright_raw) fill_item[ID] = color(hue(fill_item[ID]),  saturation(fill_item[ID]), fill_bright_raw, alpha(fill_item[ID]));   
    else if(fill_alpha_temp != fill_alpha_raw) fill_item[ID] = color(hue(fill_item[ID]),  saturation(fill_item[ID]), brightness(fill_item[ID]), fill_alpha_raw);  
    // stroke obj
    if (!first_opening_item[ID] ) stroke_item[ID] = color (stroke_hue_raw, stroke_sat_raw, stroke_bright_raw, stroke_alpha_raw); 
    else if(stroke_hue_temp != stroke_hue_raw) stroke_item[ID] = color(stroke_hue_raw, saturation(stroke_item[ID]), brightness(stroke_item[ID]), alpha(stroke_item[ID]));
    else if(stroke_sat_temp != stroke_sat_raw) stroke_item[ID] = color(hue(stroke_item[ID]),stroke_sat_raw,brightness(stroke_item[ID]), alpha(stroke_item[ID])); 
    else if(stroke_bright_temp != stroke_bright_raw) stroke_item[ID] = color(hue(stroke_item[ID]),saturation(stroke_item[ID]), stroke_bright_raw, alpha(stroke_item[ID]));   
    else if(stroke_alpha_temp != stroke_alpha_raw) stroke_item[ID] = color(hue(stroke_item[ID]), saturation(stroke_item[ID]), brightness(stroke_item[ID]), stroke_alpha_raw);  
    // thickness
    if (thickness_raw != thickness_temp|| !first_opening_item[ID]) thickness_item[ID] = thickness_raw;
  } else {
    // preview display
    fill_item[ID] = COLOR_FILL_OBJ_PREVIEW ;
    stroke_item[ID] =  COLOR_STROKE_OBJ_PREVIEW ;
    thickness_item[ID] = THICKNESS_OBJ_PREVIEW ;
  }
  if (size_x_raw != size_x_temp || !first_opening_item[ID]) size_x_item[ID] = size_x_raw; 
  if (size_y_raw != size_y_temp || !first_opening_item[ID]) size_y_item[ID] = size_y_raw; 
  if (size_z_raw != size_z_temp || !first_opening_item[ID]) size_z_item[ID] = size_z_raw;

  if (font_size_raw != font_size_temp || !first_opening_item[ID]) font_size_item[ID] = font_size_raw; 

  if (canvas_x_raw != canvas_x_temp || !first_opening_item[ID]) canvas_x_item[ID] = canvas_x_raw; 
  if (canvas_y_raw != canvas_y_temp || !first_opening_item[ID]) canvas_y_item[ID] = canvas_y_raw; 
  if (canvas_z_raw != canvas_z_temp || !first_opening_item[ID]) canvas_z_item[ID] = canvas_z_raw;


  // column 2
  if (reactivity_raw != reactivity_temp || !first_opening_item[ID]) reactivity_item[ID] = reactivity_raw; 

  if (speed_x_raw != speed_x_temp || !first_opening_item[ID]) speed_x_item[ID] = speed_x_raw; 
  if (speed_y_raw != speed_y_temp || !first_opening_item[ID]) speed_y_item[ID] = speed_y_raw; 
  if (speed_z_raw != speed_z_temp || !first_opening_item[ID]) speed_z_item[ID] = speed_z_raw;

  if (spurt_x_raw != spurt_x_temp || !first_opening_item[ID]) spurt_x_item[ID] = spurt_x_raw; 
  if (spurt_y_raw != spurt_y_temp || !first_opening_item[ID]) spurt_y_item[ID] = spurt_y_raw; 
  if (spurt_z_raw != spurt_z_temp || !first_opening_item[ID]) spurt_z_item[ID] = spurt_z_raw;

  if (dir_x_raw != dir_x_temp || !first_opening_item[ID]) dir_x_item[ID] = dir_x_raw; 
  if (dir_y_raw != dir_y_temp || !first_opening_item[ID]) dir_y_item[ID] = dir_y_raw; 
  if (dir_z_raw != dir_z_temp || !first_opening_item[ID]) dir_z_item[ID] = dir_z_raw;

  if (jitter_x_raw != jitter_x_temp || !first_opening_item[ID]) jitter_x_item[ID] = jitter_x_raw ; 
  if (jitter_y_raw != jitter_y_temp || !first_opening_item[ID]) jitter_y_item[ID] = jitter_y_raw ; 
  if (jitter_z_raw != jitter_z_temp || !first_opening_item[ID]) jitter_z_item[ID] = jitter_z_raw ;

  if (swing_x_raw != swing_x_temp || !first_opening_item[ID]) swing_x_item[ID] = swing_x_raw ; 
  if (swing_y_raw != swing_y_temp || !first_opening_item[ID]) swing_y_item[ID] = swing_y_raw ; 
  if (swing_z_raw != swing_z_temp || !first_opening_item[ID]) swing_z_item[ID] = swing_z_raw ;

  // col 3
  if (quantity_raw != quantity_temp || !first_opening_item[ID]) quantity_item[ID] = quantity_raw ;
  if (variety_raw != variety_temp || !first_opening_item[ID]) variety_item[ID] = variety_raw ;

  if (life_raw != life_temp || !first_opening_item[ID]) life_item[ID] = life_raw ;
  if (flow_raw != flow_temp || !first_opening_item[ID]) flow_item[ID] = flow_raw ;
  if (quality_raw != quality_temp || !first_opening_item[ID]) quality_item[ID] = quality_raw ;

  if (area_raw != area_temp || !first_opening_item[ID]) area_item[ID] = area_raw ;
  if (angle_raw != angle_temp || !first_opening_item[ID]) angle_item[ID] = angle_raw ;
  if (scope_raw != scope_temp || !first_opening_item[ID]) scope_item[ID] = scope_raw ;
  if (scan_raw != scan_temp || !first_opening_item[ID]) scan_item[ID] = scan_raw ;

  if (alignment_raw != alignment_temp || !first_opening_item[ID]) alignment_item[ID] = alignment_raw ;
  if (repulsion_raw != repulsion_temp || !first_opening_item[ID]) repulsion_item[ID] = repulsion_raw ;
  if (attraction_raw != attraction_temp || !first_opening_item[ID]) attraction_item[ID] = attraction_raw ;
  if (density_raw != density_temp || !first_opening_item[ID]) density_item[ID] = density_raw ;

  if (influence_raw != influence_temp || !first_opening_item[ID]) influence_item[ID] = influence_raw ;
  if (calm_raw != calm_temp || !first_opening_item[ID]) calm_item[ID] = calm_raw ;
  if (spectrum_raw != spectrum_temp || !first_opening_item[ID]) spectrum_item[ID] = spectrum_raw ;
  /** 
  make the obj has be never update in the future except by the moving slider 
  */
  first_opening_item[ID] = true ; 

}





//
void update_var_sound(int ID) {
  if(sound[ID]) {
    left[ID] = left[0];// value(0,1)
    right[ID] = right[0]; //float value(0,1)
    mix[ID] = mix[0]; //   is average volume between the left and the right / float value(0,1)
    
    beat[ID] = beat[0] ; //    is beat : value 1,10 
    kick[ID] = kick[0] ; //   is beat kick : value 1,10 
    snare[ID] = snare [0]; //   is beat snare : value 1,10 
    hat[ID] = hat[0]; //   is beat hat : value 1,10 

    tempo[ID] = tempo[0]; // global speed of track  / float value(0,1)
    tempoBeat[ID] = tempoBeat[0]; // speed of track calculate on the beat
    tempoKick[ID] = tempoKick[0]; // speed of track calculate on the kick
    tempoSnare[ID] = tempoSnare[0]; // speed of track calculate on the snare
    tempoHat[ID] = tempoHat[0]; // speed of track calculte on the hat
    
    for (int i = 0 ; i <NUM_BANDS ; i++) {
      band[ID][i] = band[0][i] ;
    }
  } else {
    left[ID] = 1;// value(0,1)
    right[ID] = 1; //float value(0,1)
    mix[ID] = 1; //   is average volume between the left and the right / float value(0,1)
    
    beat[ID] = 1 ;//    is beat : value 1,10 
    kick[ID] = 1 ;//   is beat kick : value 1,10 
    snare[ID] = 1 ;//   is beat snare : value 1,10 
    hat[ID] = 1 ;//   is beat hat : value 1,10 
    
    tempo[ID] = 1 ;     // global speed of track  / float value(0,1)
    tempoBeat[ID] = 1 ;  // speed of track calculate on the beat
    tempoKick[ID] = 1 ; // speed of track calculate on the kick
    tempoSnare[ID] = 1 ;// speed of track calculate on the snare
    tempoHat[ID] = 1 ;// speed of track calculte on the hat
    
    for (int i = 0 ; i <NUM_BANDS ; i++) {
      band[ID][i] = 1 ;
    }
  }
}

// RESET list and item
boolean reset(int ID) {
  boolean e = false ;
  //global delete
  if (key_backspace) e = true ;
  //SPECIFIC DELETE when the paramer button of contrôleur is ON
  else if (key_delete) if (action[ID] || parameter[ID]) e = true ;
  return e ;
}













/**
Class Romanesco_manager
v 1.1.2
inspired from Andreas Gysin work from The Abyss Project
*/
class Romanesco_manager {
  private ArrayList<Romanesco>RomanescoList ;
  private ArrayList<Class>objectRomanescoList;

  PApplet parent;
  String objectNameRomanesco [] ;
  String classRomanescoName [] ;
  int numClasses ;
  
  Romanesco_manager(PApplet parent) {
    this.parent = parent;
    RomanescoList = new ArrayList<Romanesco>() ;
    //scan the existant classes
    objectRomanescoList = scanClasses(parent, "Romanesco");
  }
  
  //STEP ONE
  //ADD CLASSES
  private ArrayList<Class> scanClasses(PApplet parent, String superClassName) {
    ArrayList<Class> classes = new ArrayList<Class>();

    Class[] c = parent.getClass().getDeclaredClasses();
    
    //create the index table
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && c[i].getSuperclass().getSimpleName().equals(superClassName) ) {
        classes.add(c[i]);
        numClasses = classes.size() ;
      }
    }
    createIndex(numClasses) ;
    
    //init the String info
    objectNameRomanesco = new String[numClasses] ;
    for ( int i =0 ; i <objectNameRomanesco.length ; i++) objectNameRomanesco[i] =("") ;
    
    //add class in Romanesco, plus add info in the String for the index
    int numObjectRomanesco = 0 ;
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && c[i].getSuperclass().getSimpleName().equals(superClassName) ) {
        objectNameRomanesco[numObjectRomanesco] = c[i].getSimpleName() ;
        numObjectRomanesco += 1 ;
      }
    }
    beginIndex() ;
    
    return classes;  
  }
  

  //create the canvas index
  void createIndex(int num) {
    indexObjects = new Table() ;
    indexObjects.addColumn("Library Order") ;
    indexObjects.addColumn("Name") ;
    indexObjects.addColumn("ID") ;
    indexObjects.addColumn("Group") ;
    indexObjects.addColumn("Version") ;
    indexObjects.addColumn("Author") ;
    indexObjects.addColumn("Class name") ;
    indexObjects.addColumn("Pack") ;
    indexObjects.addColumn("Render") ;
    indexObjects.addColumn("Mode") ;
    
    
    // add row
    rowIndexObject = new TableRow [num] ;
    for(int i = 0 ; i < rowIndexObject.length ; i++) {
      rowIndexObject[i] = indexObjects.addRow() ;
    }
    
    // create var for info object, need to be create here
    int numPlusOne = num + 1 ;
    objectID = new int[numPlusOne] ;
    objectName = new String[numPlusOne] ;
    objectAuthor = new String[numPlusOne] ;
    objectVersion = new String[numPlusOne] ;
    objectPack = new String[numPlusOne] ;
    objectInfo = new String[numPlusOne] ;
    // init var
    for ( int i = 0 ; i<numPlusOne ; i++ ) {
      objectName [i] = "My name is Nobody" ;
      objectInfo [i] = "Sorry nobody write about me !" ;
      objectID [i] = 0 ;
    }
    
    
    
  }
  
  // put information in the index
  void beginIndex() {
    for(int i = 0 ; i < rowIndexObject.length ; i++) {
      rowIndexObject[i].setString("Class name", objectNameRomanesco[i]) ;
      rowIndexObject[i].setInt("Library Order", i+1) ;
    }
  }
  

  
  
  
  /**
  EXTERNAL  VOID
  */
  void finishIndex() {
  // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      Romanesco objR = (Romanesco) RomanescoList.get(i) ;
      rowIndexObject[i].setString("Name", objR.item_name) ;
      rowIndexObject[i].setInt("ID", objR.ID_item) ;
      rowIndexObject[i].setInt("Group", objR.ID_group) ;
      rowIndexObject[i].setString("Author", objR.item_author) ;
      rowIndexObject[i].setString("Version", objR.item_version) ;
      rowIndexObject[i].setString("Render", objR.romanescoRender) ;
      rowIndexObject[i].setString("Pack", objR.item_pack) ;
      rowIndexObject[i].setString("Mode", objR.item_mode) ;
      rowIndexObject[i].setString("Slider", objR.item_slider) ;
    }
    saveTable(indexObjects, preference_path+"index_romanesco_items.csv") ; 
    NUM_OBJ = RomanescoList.size() ;
  }
  
  /*
  * rpe_manager.writeInfoUser() ;
  * use with in romanesco_setup() {}
  */
  //ADD info for the user
  void writeInfoUser() {
      // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      Romanesco objR = (Romanesco) RomanescoList.get(i) ;
      objectID[objR.ID_item] = objR.ID_item ;
      objectName[objR.ID_item] = objR.item_name ;
      objectAuthor[objR.ID_item] = objR.item_author ;
      objectVersion[objR.ID_item] = objR.item_version ;
      objectPack[objR.ID_item] = objR.item_pack ;
    }
  }
    
  

  int id_item_from_library(int index) {
    int id = -1 ;
    if(index < RomanescoList.size()) {
      Romanesco item = (Romanesco) RomanescoList.get(index) ;
      id = item.ID_item ;
    }
    
    return id ;
  }
  
  
  
  int size() {
    return floor(objectRomanescoList.size()-1) ;
  }
  
  
  
  //ADD OBJECT from the sub-classes
  void add_item_romanesco() {
    int n = floor(objectRomanescoList.size()-1) ;
    for( int i = 0 ; i <= n ; i++) {
    addObject(i) ;
    }
  }
  //
  public Romanesco addObject(int i) {
    if (i < 0 || i >= objectRomanescoList.size()) return null;
    
    Romanesco f = null;
    try {
      Class c = objectRomanescoList.get(i);
      Constructor[] constructors = c.getConstructors();
      f = (Romanesco) constructors[0].newInstance(parent);
    }
    catch (InvocationTargetException e) {
      System.out.println(e);
    } 
    catch (InstantiationException e) {
      System.out.println(e);
    } 
    catch (IllegalAccessException e) {
      System.out.println(e);
    } 
    //add object 
    if (f != null) {
      addObject(f);
    }
    return f;
  }
  
  // finalization of adding object
  private void addObject(Romanesco item) {
    item.set_item_romanesco(this);
    RomanescoList.add(item);
  }
  
  
  

  // SETUP
  void init_items() {
    int num = 0 ;
    for (Romanesco item : RomanescoList) {
      motion[item.ID_item] = true ;
      init_value_mouse[item.ID_item] = true ;
      num ++ ;
      item.setup() ;
      println("setup of", item.item_name, item.ID_item, "is done") ;
      if(posObjRef[item.ID_item] == null) {
        posObjRef[item.ID_item] = Vec3() ;
      }
      posObjRef[item.ID_item].set(item_setting_position[0][item.ID_item]) ;
    }
  }

  

  // DRAW
  void display_item(boolean movePos, boolean moveDir, boolean movePosAndDir) {
    // when you use the third order Romanesco understand the the first and the second are true
    if(movePosAndDir) {
      moveDir = true ;
      movePos = true ;
    }
    
    //the method
    if (show_object != null) {
      for (Romanesco objR : RomanescoList) {
        if (show_object[objR.ID_item]) {
          update_var_items(objR.ID_item) ;
          pushMatrix() ;
          add_ref_item(objR.ID_item) ;
          item_follower(objR.ID_item) ;
          if(key_v_long && action[objR.ID_item] ) {

            item_move(movePos, moveDir, objR.ID_item) ;
          }

          final_pos_item(objR.ID_item) ;
          objR.draw() ;
          popMatrix() ;
        } else {
          // pause reading movie
          read_movie(false, objR.ID_item) ;
        }
      }
    }
  }
}

























/**
Abstract CLASS ROMANESCO
*/
abstract class Romanesco {
  protected String item_name, item_author, item_version, item_pack, romanescoRender, item_mode, item_slider;
  protected int ID_item, ID_group;
  //object manager return
  Romanesco_manager item_romanesco;

  // slider
  protected boolean hue_fill_is;
  protected boolean sat_fill_is;
  protected boolean bright_fill_is;
  protected boolean alpha_fill_is;
  protected boolean hue_stroke_is;
  protected boolean sat_stroke_is;
  protected boolean bright_stroke_is;
  protected boolean alpha_stroke_is;
  protected boolean thickness_is;
  protected boolean size_x_is;
  protected boolean size_y_is;
  protected boolean size_z_is;
  protected boolean font_size_is;
  protected boolean canvas_x_is;
  protected boolean canvas_y_is;
  protected boolean canvas_z_is;

  protected boolean reactivity_is;
  protected boolean speed_x_is;
  protected boolean speed_y_is;
  protected boolean speed_z_is;
  protected boolean spurt_x_is;
  protected boolean spurt_y_is;
  protected boolean spurt_z_is;
  protected boolean dir_x_is;
  protected boolean dir_y_is;
  protected boolean dir_z_is;
  protected boolean jit_x_is;
  protected boolean jit_y_is;
  protected boolean jit_z_is;
  protected boolean swing_x_is;
  protected boolean swing_y_is;
  protected boolean swing_z_is;

  protected boolean num_is;
  protected boolean variety_is;
  protected boolean life_is;
  protected boolean flow_is;
  protected boolean quality_is;
  protected boolean area_is;
  protected boolean angle_is;
  protected boolean scope_is;
  protected boolean scan_is;
  protected boolean align_is;
  protected boolean repulsion_is;
  protected boolean attraction_is;
  protected boolean density_is;
  protected boolean influence_is;
  protected boolean calm_is;
  protected boolean spectrum_is;
  
  public Romanesco() {
    item_name = "Unknown" ;
    item_author = "Anonymous";
    item_version = "Alpha";
    item_pack = "Base" ;
    romanescoRender = "classic" ;
    item_mode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    item_slider = "" ;
    ID_group = 0 ;
    ID_item = 0 ;

    hue_fill_is = false;
    sat_fill_is = false;
  }
  
  //manager return
  void set_item_romanesco(Romanesco_manager item_romanesco) {
    this.item_romanesco = item_romanesco;
    if(!hue_fill_is) item_slider +="," ; else item_slider += (ROM_HUE_FILL +",");
    if(!sat_fill_is) item_slider +="," ;else item_slider +=(ROM_SAT_FILL+",");
    if(!bright_fill_is) item_slider +="," ;else item_slider +=(ROM_BRIGHT_FILL+",");
    if(!alpha_fill_is) item_slider +="," ;else item_slider +=(ROM_ALPHA_FILL+",");
    if(!hue_stroke_is) item_slider +="," ; else item_slider += (ROM_HUE_STROKE +",");
    if(!sat_stroke_is) item_slider +="," ;else item_slider +=(ROM_SAT_STROKE+",");
    if(!bright_stroke_is) item_slider +="," ;else item_slider +=(ROM_BRIGHT_STROKE+",");
    if(!alpha_stroke_is) item_slider +="," ;else item_slider +=(ROM_ALPHA_STROKE+",");
    if(!thickness_is) item_slider +="," ; else item_slider += (ROM_THICKNESS+",");
    if(!size_x_is) item_slider +="," ; else item_slider += (ROM_SIZE_X+",");
    if(!size_x_is) item_slider +="," ; else item_slider += (ROM_SIZE_Y+",");
    if(!size_z_is) item_slider +="," ; else item_slider += (ROM_SIZE_Z+",");
    if(!font_size_is) item_slider +="," ; else item_slider += (ROM_FONT_SIZE+",");
    if(!canvas_x_is) item_slider +="," ; else item_slider += (ROM_CANVAS_X+",");
    if(!canvas_y_is) item_slider +="," ; else item_slider += (ROM_CANVAS_Y+",");
    if(!canvas_z_is) item_slider +="," ; else item_slider += (ROM_CANVAS_Z+",");

    if(!reactivity_is) item_slider +="," ; else item_slider += (ROM_REACTIVITY+",");
    if(!speed_x_is) item_slider +="," ; else item_slider += (ROM_SPEED_X+",");
    if(!speed_y_is) item_slider +="," ; else item_slider += (ROM_SPEED_Y+",");
    if(!speed_z_is) item_slider +="," ; else item_slider += (ROM_SPEED_Z+",");
    if(!spurt_x_is) item_slider +="," ; else item_slider += (ROM_SPURT_X+",");
    if(!spurt_y_is) item_slider +="," ; else item_slider += (ROM_SPURT_Y+",");
    if(!spurt_z_is) item_slider +="," ; else item_slider += (ROM_SPURT_Z+",");
    if(!dir_x_is) item_slider +="," ; else item_slider += (ROM_DIR_X+",");
    if(!dir_y_is) item_slider +="," ; else item_slider += (ROM_DIR_Y+",");
    if(!dir_z_is) item_slider +="," ; else item_slider += (ROM_DIR_Z+",");
    if(!jit_x_is) item_slider +="," ; else item_slider += (ROM_JIT_X+",");
    if(!jit_y_is) item_slider +="," ; else item_slider += (ROM_JIT_Y+",");
    if(!jit_z_is) item_slider +="," ; else item_slider += (ROM_JIT_Z+",");
    if(!swing_x_is) item_slider +="," ; else item_slider += (ROM_SWIWG_X+",");
    if(!swing_y_is) item_slider +="," ; else item_slider += (ROM_SWIWG_Y+",");
    if(!swing_z_is) item_slider +="," ; else item_slider += (ROM_SWIWG_Z+",");

    if(!num_is) item_slider +="," ; else item_slider += (ROM_NUM+",");
    if(!variety_is) item_slider +="," ; else item_slider += (ROM_VARIETY+",");
    if(!life_is) item_slider +="," ; else item_slider += (ROM_LIFE+",");
    if(!flow_is) item_slider +="," ; else item_slider += (ROM_FLOW+",");
    if(!quality_is) item_slider +="," ; else item_slider += (ROM_QUALITY+",");
    if(!area_is) item_slider +="," ; else item_slider += (ROM_AREA+",");
    if(!angle_is) item_slider +="," ; else item_slider += (ROM_ANGLE+",");
    if(!scope_is) item_slider +="," ; else item_slider += (ROM_SCOPE+",");
    if(!scan_is) item_slider +="," ; else item_slider += (ROM_SCAN+",");
    if(!align_is) item_slider +="," ; else item_slider += (ROM_ALIGN+",");
    if(!repulsion_is) item_slider +="," ; else item_slider += (ROM_REPULSION+",");
    if(!attraction_is) item_slider +="," ; else item_slider += (ROM_ATTRACTION+",");
    if(!density_is) item_slider +="," ; else item_slider += (ROM_DENSITY+",");
    if(!influence_is) item_slider +="," ; else item_slider += (ROM_INFLUENCE+",");
    if(!calm_is) item_slider +="," ; else item_slider += (ROM_CALM+",");
    if(!spectrum_is) item_slider +="," ; else item_slider += (ROM_SPECTRUM+",");
  }
  

  //must must be declared in the sub-classes
  abstract void setup();
  abstract void draw();
}









