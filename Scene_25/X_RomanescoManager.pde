// CLASS ROMANESCO MANAGER
void romanescoSetup() {
  romanescoManager = new ObjectRomanescoManager(this);
  romanescoManager.addObjectRomanesco() ;
  romanescoManager.finishTheIndex() ;
}


//Update the var of the object
void updateObject(int ID, int group) {
  //if (font[ID] == null ) font[ID] = font[0] ;
  //initialization
  if(!initValueMouse[ID]) { 
    mouse[ID] = mouse[0].get() ;
    initValueMouse[ID] = true ;
  }
  if(!initValueSlider[ID]) {
    font[ID] = font[0] ;
    updateParameter(ID,group ) ;
    initValueSlider[ID] = true ;
  }
  
  if(parameter[ID] ) {
    font[ID] = font[0] ;
    updateParameter(ID,group ) ;
  }
  updateSound(ID) ;
  
  if(action[ID] ){
    if(spaceTouch) mouse[ID] = mouse[0].get() ;  // else mouse[ID] = mouseSuperRomanesco ;
    if( mTouch ) motion[ID] = !motion[ID] ;
    if (hTouch) horizon[ID] = !horizon[ID] ;
    clickLongLeft[ID] = clickLongLeft[0] ;
    clickLongRight[ID] = clickLongRight[0] ;
    clickShortLeft[ID] = clickShortLeft[0] ;
    clickShortRight[ID] = clickShortRight[0] ;
  }
}




//
void updateParameter(int ID, int group) {
  for ( int i = 0 ; i <= numGroup ; i++) if( group == i ) {
    int whichOne = i-1 ;
    fillObj[ID] = fillRaw[whichOne] ;
    strokeObj[ID] = strokeRaw[whichOne] ;
    thicknessObj[ID] = thicknessRaw[whichOne] ;
    sizeXObj[ID] = sizeXRaw[whichOne] ; 
    sizeYObj[ID] = sizeYRaw[whichOne] ; 
    sizeZObj[ID] = sizeZRaw[whichOne] ;
    canvasXObj[ID] = canvasXRaw[whichOne] ; 
    canvasYObj[ID] = canvasYRaw[whichOne] ; 
    canvasZObj[ID] = canvasZRaw[whichOne] ;
    quantityObj[ID] = quantityRaw[whichOne] ;
    //column 3
    speedObj[ID] = speedRaw[whichOne] ;
    directionObj[ID] = directionRaw[whichOne] ;
    angleObj[ID] = angleRaw[whichOne] ;
    amplitudeObj[ID] = amplitudeRaw[whichOne] ;
    analyzeObj[ID] = analyzeRaw[whichOne] ; 
    familyObj[ID] = familyRaw[whichOne] ;
    lifeObj[ID] = lifeRaw[whichOne] ;
    forceObj[ID] = forceRaw[whichOne] ;
  }
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
    
    for (int i = 0 ; i <numBand ; i++) {
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
    
    for (int i = 0 ; i <numBand ; i++) {
      band[ID][i] = 1 ;
    }
  }
}


//Clear the list
boolean emptyList(int ID) {
  boolean e = false ;
  //global delete
  if (backspaceTouch) e = true ;
  //SPECIFIC DELETE when the paramer button of contrôleur is ON
  else if (deleteTouch) if ( action[ID]) e = true ;
  return e ;
}
///////////////////////////////////////




//CLASS
// inspired from Andreas Gysin work from The Abyss Project
class ObjectRomanescoManager {
  private ArrayList<SuperRomanesco>RomanescoList ;
  private ArrayList<Class>objectRomanescoList;
  
  PApplet parent;
  String objectNameRomanesco [] ;
  String classRomanescoName [] ;
  int numClasses ;
  
  ObjectRomanescoManager(PApplet parent) {
    this.parent = parent;
    RomanescoList = new ArrayList<SuperRomanesco>() ;
    //scan the existant classes
    objectRomanescoList = scanClasses(parent, "SuperRomanesco");
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
    writeIndex() ;
    
    return classes;  
  }
  //END ADD CLASSES
  /////////////////
  
  
  
  /////////////////////////////////////////////
  //CREATE an index.csv for the objects classes
  String pathObjects = sketchPath("")+"preferences/objects/" ;
  
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
    
    // numObj = num +1 ;
    objectName = new String[num +1] ;
    objectID = new int[num +1] ;
    
    // add row
    rowIndexObject = new TableRow [num] ;
    for(int i = 0 ; i < rowIndexObject.length ; i++) {
      rowIndexObject[i] = indexObjects.addRow() ;
    }
  }
  
  // put information in the index
  void writeIndex() {
    for(int i = 0 ; i < rowIndexObject.length ; i++) {
      rowIndexObject[i].setString("Class name", objectNameRomanesco[i]) ;
      rowIndexObject[i].setInt("Library Order", i+1) ;
    }
  }
  
  //external void
  void finishTheIndex() {
      // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      SuperRomanesco objR = (SuperRomanesco) RomanescoList.get(i) ;
      rowIndexObject[i].setString("Name", objR.romanescoName) ;
      rowIndexObject[i].setInt("ID", objR.IDobj) ;
      rowIndexObject[i].setInt("Group", objR.IDgroup) ;
      rowIndexObject[i].setString("Author", objR.romanescoAuthor) ;
      rowIndexObject[i].setString("Version", objR.romanescoVersion) ;
      rowIndexObject[i].setString("Render", objR.romanescoRender) ;
      rowIndexObject[i].setString("Pack", objR.romanescoPack) ;
      rowIndexObject[i].setString("Mode", objR.romanescoMode) ;
    }
    saveTable(indexObjects, pathObjects+"index_romanesco_objects.csv") ; 
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
  public SuperRomanesco addObject(int i) {
    if (i < 0 || i >= objectRomanescoList.size()) return null;
    
    SuperRomanesco f = null;
    try {
      Class c = objectRomanescoList.get(i);
      Constructor[] constructors = c.getConstructors();
      f = (SuperRomanesco) constructors[0].newInstance(parent);
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
  private void addObject(SuperRomanesco objR) {
    objR.setManagerReference(this);
    RomanescoList.add(objR);
  }
  //END ADD OBJECT
  ////////////////
  
  
  
  ////////
  //SETUP
  // INIT ROMANESCO OBJECT
  void initObj() {
    for (SuperRomanesco objR : RomanescoList) {
      motion[objR.IDobj] = true ;
      initValueMouse [objR.IDobj] = true ;
      objR.setting() ;
    }
  }
  // END SETUP
  ////////////
  
  
  
  ////////
  // DRAW
  void displayObject() {
    for (SuperRomanesco objR : RomanescoList) {
      if (object[objR.IDobj]) {
        updateObject(objR.IDobj, objR.IDgroup) ;
        pushMatrix() ;
        //addRefObj(objR.IDobj) ;
        if(vLongTouch && action[objR.IDobj] ) P3Dmanipulation(objR.IDobj) ;
        P3DmoveObj(objR.IDobj) ;
        objR.display() ;
        popMatrix() ;
      }
    }
  }
  // END DRAW
  //////////
}
//END OBJECT ROMANESCO MANAGER
