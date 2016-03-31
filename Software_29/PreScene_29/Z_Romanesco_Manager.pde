/**
Romanesco Manager 2.0.1
*/
ObjectRomanescoManager romanescoManager ;
// CLASS ROMANESCO MANAGER
void romanescoSetup() {
  romanescoManager = new ObjectRomanescoManager(this);
  romanescoManager.addObjectRomanesco() ;
  romanescoManager.finishIndex() ;
  romanescoManager.writeInfoUser() ;
}


//Update the var of the object
void updateObject(int ID) {
  //initialization
  if(!initValueMouse[ID]) { 
    mouse[ID] = mouse[0].copy() ;
    pen[ID] = pen[0].copy() ;
    initValueMouse[ID] = true ;
  }
  if(!initValueControleur[ID]) {
    font[ID] = font[0] ;
    update_slider_value(ID) ;
    initValueControleur[ID] = true ;
    which_bitmap[ID] = which_bitmap[0] ;
    which_text[ID] = which_text[0] ;
    which_svg[ID] = which_svg[0] ;
    which_movie[ID] = which_movie[0] ;
  }
  
  // info
  objectInfoDisplay[ID] = displayInfo?true:false ;
  
  
  if(parameter[ID]) {
    which_bitmap[ID] = which_bitmap[0] ;
    which_text[ID] = which_text[0] ;
    which_svg[ID] = which_svg[0] ;
    which_movie[ID] = which_movie[0] ;
    font[ID] = font[0] ;
    update_slider_value(ID) ;
  }
  updateSound(ID) ;
  
  if(action[ID] ){
    if(spaceTouch) {
      pen[ID] = pen[0].copy() ;
      mouse[ID] = mouse[0].copy() ;
    }
    if (mTouch) motion[ID] = !motion[ID] ;
    if (hTouch) horizon[ID] = !horizon[ID] ;
    if (rTouch) reverse[ID] = !reverse[ID] ;
    /*
    clickLongLeft[ID] = clickLongLeft[0] ;
    clickLongRight[ID] = clickLongRight[0] ;
    */
    clickLongLeft[ID] = ORDER_ONE ;
    clickLongRight[ID] = ORDER_TWO ;
    clickShortLeft[ID] = clickShortLeft[0] ;
    clickShortRight[ID] = clickShortRight[0] ;
  }
}




//
void update_slider_value(int ID) {
    if(fullRendering) {
      /**
      Changer : le fill et le stroke doivent se calculer sur des valeurs séparée, hue, sat, bright and alpha, sinon quand on les change cela change tout d'une seul coup.
      */
      // fill obj
      if      ( !first_opening_item[ID] ) fill_item[ID]               = color ( fill_hue_raw, fill_sat_raw,  fill_bright_raw, fill_alpha_raw) ; 
      else if ( fill_hue_temp != fill_hue_raw) fill_item[ID]       = color ( fill_hue_raw,      saturation(fill_item[ID]),    brightness(fill_item[ID]),  alpha(fill_item[ID])) ;
      else if ( fill_sat_temp != fill_sat_raw) fill_item[ID]       = color ( hue(fill_item[ID]),  fill_sat_raw,               brightness(fill_item[ID]),  alpha(fill_item[ID])) ; 
      else if ( fill_bright_temp != fill_bright_raw) fill_item[ID] = color ( hue(fill_item[ID]),  saturation(fill_item[ID]),    fill_bright_raw,          alpha(fill_item[ID])) ;   
      else if ( fill_alpha_temp != fill_alpha_raw) fill_item[ID]   = color ( hue(fill_item[ID]),  saturation(fill_item[ID]),    brightness(fill_item[ID]),  fill_alpha_raw) ;  
      // stroke obj
      if      ( !first_opening_item[ID] ) stroke_item[ID]                   = color (stroke_hue_raw, stroke_sat_raw, stroke_bright_raw, stroke_alpha_raw) ; 
      else if ( stroke_hue_temp != stroke_hue_raw) stroke_item[ID]       = color ( stroke_hue_raw,      saturation(stroke_item[ID]),  brightness(stroke_item[ID]),  alpha(stroke_item[ID])) ;
      else if ( stroke_sat_temp != stroke_sat_raw) stroke_item[ID]       = color ( hue(stroke_item[ID]),  stroke_sat_raw,             brightness(stroke_item[ID]),  alpha(stroke_item[ID])) ; 
      else if ( stroke_bright_temp != stroke_bright_raw) stroke_item[ID] = color ( hue(stroke_item[ID]),  saturation(stroke_item[ID]),  stroke_bright_raw,          alpha(stroke_item[ID])) ;   
      else if ( stroke_alpha_temp != stroke_alpha_raw) stroke_item[ID]   = color ( hue(stroke_item[ID]),  saturation(stroke_item[ID]),  brightness(stroke_item[ID]),  stroke_alpha_raw) ;  
      // thickness
      if (thickness_raw != thickness_temp|| !first_opening_item[ID]) thickness_item[ID] = thickness_raw ;
    } else {
      // preview display
      fill_item[ID] = COLOR_FILL_OBJ_PREVIEW ;
      stroke_item[ID] =  COLOR_STROKE_OBJ_PREVIEW ;
      thickness_item[ID] = THICKNESS_OBJ_PREVIEW ;
    }
    if (size_x_raw != size_x_temp || !first_opening_item[ID]) size_x_item[ID] = size_x_raw ; 
    if (size_y_raw != size_y_temp || !first_opening_item[ID]) size_y_item[ID] = size_y_raw ; 
    if (size_z_raw != size_z_temp || !first_opening_item[ID]) size_z_item[ID] = size_z_raw ;

    if (font_size_raw != font_size_temp || !first_opening_item[ID]) font_size_item[ID] = font_size_raw ; 

    if (canvas_x_raw != canvas_x_temp || !first_opening_item[ID]) canvas_x_item[ID] = canvas_x_raw ; 
    if (canvas_y_raw != canvas_y_temp || !first_opening_item[ID]) canvas_y_item[ID] = canvas_y_raw ; 
    if (canvas_z_raw != canvas_z_temp || !first_opening_item[ID]) canvas_z_item[ID] = canvas_z_raw ;


    // column 2
    if (speed_x_raw != speed_x_temp || !first_opening_item[ID]) speed_x_item[ID] = speed_x_raw ; 
    if (speed_y_raw != speed_y_temp || !first_opening_item[ID]) speed_y_item[ID] = speed_y_raw ; 
    if (speed_z_raw != speed_z_temp || !first_opening_item[ID]) speed_z_item[ID] = speed_z_raw ;

    if (spurt_x_raw != spurt_x_temp || !first_opening_item[ID]) spurt_x_item[ID] = spurt_x_raw ; 
    if (spurt_y_raw != spurt_y_temp || !first_opening_item[ID]) spurt_y_item[ID] = spurt_y_raw ; 
    if (spurt_z_raw != spurt_z_temp || !first_opening_item[ID]) spurt_z_item[ID] = spurt_z_raw ;

    if (dir_x_raw != dir_x_temp || !first_opening_item[ID]) dir_x_item[ID] = dir_x_raw ; 
    if (dir_y_raw != dir_y_temp || !first_opening_item[ID]) dir_y_item[ID] = dir_y_raw ; 
    if (dir_z_raw != dir_z_temp || !first_opening_item[ID]) dir_z_item[ID] = dir_z_raw ;

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
    if (fertility_raw != fertility_temp || !first_opening_item[ID]) fertility_item[ID] = fertility_raw ;
    if (quality_raw != quality_temp || !first_opening_item[ID]) quality_item[ID] = quality_raw ;

    if (area_raw != area_temp || !first_opening_item[ID]) area_item[ID] = area_raw ;
    if (angle_raw != angle_temp || !first_opening_item[ID]) angle_item[ID] = angle_raw ;
    if (scope_raw != scope_temp || !first_opening_item[ID]) scope_item[ID] = scope_raw ;
    if (scan_raw != scan_temp || !first_opening_item[ID]) scan_item[ID] = scan_raw ;

    if (alignment_raw != alignment_temp || !first_opening_item[ID]) alignment_item[ID] = alignment_raw ;
    if (repulsion_raw != repulsion_temp || !first_opening_item[ID]) repulsion_item[ID] = repulsion_raw ;
    if (attraction_raw != attraction_temp || !first_opening_item[ID]) attraction_item[ID] = attraction_raw ;
    if (charge_raw != charge_temp || !first_opening_item[ID]) charge_item[ID] = charge_raw ;

    if (influence_raw != influence_temp || !first_opening_item[ID]) influence_item[ID] = influence_raw ;
    if (calm_raw != calm_temp || !first_opening_item[ID]) calm_item[ID] = calm_raw ;
    if (need_raw != need_temp || !first_opening_item[ID]) need_item[ID] = need_raw ;



  /** 
  make the obj has be never update in the future except by the moving slider 
  */
  first_opening_item[ID] = true ; 

}





//
void updateSound(int ID) {
  if(sound[ID]) {
    left[ID]  = left[0] ;// value(0,1)
    right[ID] = right[0] ;//float value(0,1)
    mix[ID]  = mix[0] ;//   is average volume between the left and the right / float value(0,1)
    
    beat[ID] = beat[0] ;//    is beat : value 1,10 
    kick[ID] = kick[0] ;//   is beat kick : value 1,10 
    snare[ID] = snare [0] ;//   is beat snare : value 1,10 
    hat[ID]  = hat[0] ;//   is beat hat : value 1,10 

    tempo[ID]   = tempo[0] ;     // global speed of track  / float value(0,1)
    tempoBeat[ID] = tempoBeat[0] ;  // speed of track calculate on the beat
    tempoKick[ID] = tempoKick[0] ; // speed of track calculate on the kick
    tempoSnare[ID] = tempoSnare[0] ;// speed of track calculate on the snare
    tempoHat[ID] = tempoHat[0] ;// speed of track calculte on the hat
    
    for (int i = 0 ; i <NUM_BANDS ; i++) {
      band[ID][i] = band[0][i] ;
    }
  } else {
    left[ID]  = 1 ;// value(0,1)
    right[ID] = 1 ;//float value(0,1)
    mix[ID]  = 1 ;//   is average volume between the left and the right / float value(0,1)
    
    beat[ID] = 1 ;//    is beat : value 1,10 
    kick[ID] = 1 ;//   is beat kick : value 1,10 
    snare[ID] = 1 ;//   is beat snare : value 1,10 
    hat[ID]  = 1 ;//   is beat hat : value 1,10 
    
    tempo[ID]   = 1 ;     // global speed of track  / float value(0,1)
    tempoBeat[ID] = 1 ;  // speed of track calculate on the beat
    tempoKick[ID] = 1 ; // speed of track calculate on the kick
    tempoSnare[ID] = 1 ;// speed of track calculate on the snare
    tempoHat[ID] = 1 ;// speed of track calculte on the hat
    
    for (int i = 0 ; i <NUM_BANDS ; i++) {
      band[ID][i] = 1 ;
    }
  }
}


// RESET list and Object
// by action
boolean resetAction(int ID) {
  boolean e = false ;
  //global delete
  if (backspaceTouch) e = true ;
  //SPECIFIC DELETE when the paramer button of contrôleur is ON
  else if (deleteTouch) if ( action[ID]) e = true ;
  return e ;
}
// by parameter
boolean resetParameter(int ID) {
  boolean e = false ;
  //global delete
  if (backspaceTouch) e = true ;
  //SPECIFIC DELETE when the paramer button of contrôleur is ON
  else if (deleteTouch) if (parameter[ID]) e = true ;
  return e ;
}
///////////////////////////////////////




//CLASS
// inspired from Andreas Gysin work from The Abyss Project
class ObjectRomanescoManager {
  private ArrayList<Romanesco>RomanescoList ;
  private ArrayList<Class>objectRomanescoList;
  
  PApplet parent;
  String objectNameRomanesco [] ;
  String classRomanescoName [] ;
  int numClasses ;
  
  ObjectRomanescoManager(PApplet parent) {
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
  //END ADD CLASSES
  /////////////////
  
  
  
  //////////////////////////////////////
  // INDEX and INFO OBJECT FROM CLASSES
  String pathObjects = preference_path+"objects/" ;
  
  ////////////////
  // INTERN VOID
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
  

  
  
  
  ////////////////
  /**
  EXTERNAL  VOID
  * romanescoManager.finishIndex() ;
  * use with in romanescoSetup() {}
  */
  //finish index
  void finishIndex() {
      // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      Romanesco objR = (Romanesco) RomanescoList.get(i) ;
      rowIndexObject[i].setString("Name", objR.romanescoName) ;
      rowIndexObject[i].setInt("ID", objR.IDobj) ;
      rowIndexObject[i].setInt("Group", objR.IDgroup) ;
      rowIndexObject[i].setString("Author", objR.romanescoAuthor) ;
      rowIndexObject[i].setString("Version", objR.romanescoVersion) ;
      rowIndexObject[i].setString("Render", objR.romanescoRender) ;
      rowIndexObject[i].setString("Pack", objR.romanescoPack) ;
      rowIndexObject[i].setString("Mode", objR.romanescoMode) ;
      rowIndexObject[i].setString("Slider", objR.romanescoSlider) ;
    }
    saveTable(indexObjects, pathObjects+"index_romanesco_objects.csv") ; 
    NUM_OBJ = RomanescoList.size() ;
  }
  
  /*
  * romanescoManager.writeInfoUser() ;
  * use with in romanescoSetup() {}
  */
  //ADD info for the user
  void writeInfoUser() {
      // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      Romanesco objR = (Romanesco) RomanescoList.get(i) ;
      objectID[objR.IDobj] = objR.IDobj ;
      objectName[objR.IDobj] = objR.romanescoName ;
      objectAuthor[objR.IDobj] = objR.romanescoAuthor ;
      objectVersion[objR.IDobj] = objR.romanescoVersion ;
      objectPack[objR.IDobj] = objR.romanescoPack ;
    }
  }
    
  
  //END of the INDEX
  //////////////////
  
  
  
  
  
  
  
  /////////////////////////////////
  //ADD OBJECT from the sub-classes
  void addObjectRomanesco() {
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
      println(f,i, constructors.length, parent) ;
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
  private void addObject(Romanesco objR) {
    objR.setManagerReference(this);
    RomanescoList.add(objR);
  }
  //END ADD OBJECT
  ////////////////
  
  
  
  ////////
  //SETUP
  // INIT ROMANESCO OBJECT
  void initObj() {
    for (Romanesco objR : RomanescoList) {
      motion[objR.IDobj] = true ;
      initValueMouse[objR.IDobj] = true ;
      objR.setting() ;
      posObjRef[objR.IDobj] = startingPosition[objR.IDobj].copy() ;
    }
  }
  

  // END SETUP
  ////////////
  
  
  
  ////////
  // DRAW
  void displayObject(boolean movePos, boolean moveDir, boolean movePosAndDir) {
    // when you use the third order Romanesco understand the the first and the second are true
    if(movePosAndDir) {
      moveDir = true ;
      movePos = true ;
    }
    
    //the method
    if (show_object != null) {
      for (Romanesco objR : RomanescoList) {
        if (show_object[objR.IDobj]) {
          updateObject(objR.IDobj) ;
          pushMatrix() ;
          addRefObj(objR.IDobj) ;
          if(vLongTouch && action[objR.IDobj] ) objectMove(movePos, moveDir, objR.IDobj) ;
          P3DmoveObj(objR.IDobj) ;
          objR.display() ;
          popMatrix() ;
        }
      }
    }
  }
  // END DRAW
  //////////
}
//END OBJECT ROMANESCO MANAGER












////////////////////////
//SUPER CLASS ROMANESCO
abstract class Romanesco {
  String romanescoName, romanescoAuthor, romanescoVersion, romanescoPack, romanescoRender, romanescoMode, romanescoSlider ;
  int IDobj, IDgroup ;
  //object manager return
  ObjectRomanescoManager orm ;
  
  public Romanesco() {
    romanescoName = "Unknown" ;
    romanescoAuthor = "Anonymous";
    romanescoVersion = "Alpha";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    romanescoSlider = "all" ;
    IDgroup = 0 ;
    IDobj = 0 ;
  }
  
  //manager return
  void setManagerReference(ObjectRomanescoManager orm) {
    this.orm = orm;
  }
  
  //IMPORTANT
  //declared the void use in the sub-classes here
  abstract void setting();
  abstract void display();
}
// END SUPER ROMANESCO
///////////////////////
