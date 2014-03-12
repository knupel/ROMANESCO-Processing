
//LOAD PICTURE VIGNETTE

int numVignette ;
void importPicButtonSetup() {
  //load button vignette GUI general
  for(int j=0 ;  j<bouton.length ; j++ ) bouton[j] = loadImage ("bouton/bouton"+j+".png") ;
  
  //load simple vignette
  numVignette = numGroup[1] +1  ;
  vignette_OFF_in_simple = new PImage[numVignette] ;
  vignette_OFF_out_simple = new PImage[numVignette] ;
  vignette_ON_in_simple = new PImage[numVignette] ;
  vignette_ON_out_simple = new PImage[numVignette] ;

  for(int i=0 ;  i<numVignette ; i++ )  {
    vignette_OFF_in_simple[i] = loadImage ("vignette_simple/vignette_OFF_in_simple_"+i+".png") ;
    vignette_OFF_out_simple[i] = loadImage ("vignette_simple/vignette_OFF_out_simple_"+i+".png") ;
    vignette_ON_in_simple[i] = loadImage ("vignette_simple/vignette_ON_in_simple_"+i+".png") ;
    vignette_ON_out_simple[i] = loadImage ("vignette_simple/vignette_ON_out_simple_"+i+".png") ;
  }
  //load texture vignette
  numVignette = numGroup[2] +1  ;
  vignette_OFF_in_texture = new PImage[numVignette] ;
  vignette_OFF_out_texture = new PImage[numVignette] ;
  vignette_ON_in_texture = new PImage[numVignette] ;
  vignette_ON_out_texture = new PImage[numVignette] ;

  for(int i=0 ;  i<numVignette ; i++ )  {
    vignette_OFF_in_texture[i] = loadImage ("vignette_texture/vignette_OFF_in_texture_"+i+".png") ;
    vignette_OFF_out_texture[i] = loadImage ("vignette_texture/vignette_OFF_out_texture_"+i+".png") ;
    vignette_ON_in_texture[i] = loadImage ("vignette_texture/vignette_ON_in_texture_"+i+".png") ;
    vignette_ON_out_texture[i] = loadImage ("vignette_texture/vignette_ON_out_texture_"+i+".png") ;
  }
  //load typography vignette
  numVignette = numGroup[3] +1  ;
  vignette_OFF_in_typography = new PImage[numVignette] ;
  vignette_OFF_out_typography = new PImage[numVignette] ;
  vignette_ON_in_typography = new PImage[numVignette] ;
  vignette_ON_out_typography = new PImage[numVignette] ;

  for(int i=0 ;  i<numVignette ; i++ )  {
    vignette_OFF_in_typography[i] = loadImage ("vignette_typography/vignette_OFF_in_typography_"+i+".png") ;
    vignette_OFF_out_typography[i] = loadImage ("vignette_typography/vignette_OFF_out_typography_"+i+".png") ;
    vignette_ON_in_typography[i] = loadImage ("vignette_typography/vignette_ON_in_typography_"+i+".png") ;
    vignette_ON_out_typography[i] = loadImage ("vignette_typography/vignette_ON_out_typography_"+i+".png") ;
  }
}
//END GLOBAL

//SETUP
void loadSetup() {
  loadR = loadBytes(sketchPath("")+"preferences/MidiSetting/defaultSetting.dat");
  //load data object
  buildLibrary() ;
  //load text interface 
  // 0 is French
  // 1 is english
  textGUI() ;
}
//END SETUP



//DRAW
void OpenCloseSave() {
  //raccourcit clavier, 
  ////////  proplème : après un CTRL + "touche", il n'y a plus besoin du CTRL pour faire fonctionner le tout....
  clavier[keyCode] = true;
  if(checkClavier(CONTROL ) && checkClavier(KeyEvent.VK_S) ) { 
    selectOutput("Sauvegarde Réglette", "sauvegardeReglette");
    clavier[keyCode] = false ;   // just open one window, when use only the keyboard, if you don't use that open all the windows save and open
  }
  if(checkClavier(CONTROL ) && checkClavier(KeyEvent.VK_O) ) { 
    selectInput("Chargement Réglette", "chargementReglette"); // ("display info in the window" , "name of the void calling" )
    clavier[keyCode] = false;   // 
  }
}


//////
void sauvegardeReglette(File selection) {
  // opens file chooser
  String sauvegardeCheminReglette = selection.getAbsolutePath() ;
  
  if (selection != null) {
    if (!sauvegardeCheminReglette.endsWith(".dat")) sauvegardeCheminReglette += ".dat";
    saveBytes(sauvegardeCheminReglette, saveR);
  } else {
    println("Aucune sauvegarde") ;
  }
}


//////
void chargementReglette(File selection) {
  // opens file chooser
  String chargementCheminReglette = selection.getAbsolutePath();
  
  if (selection != null) {
    loadSliderPos = true ;
    loadR = loadBytes(chargementCheminReglette);
  } else {
    loadSliderPos = false ;
  }
}


// LOAD INFO OBJECT from the PRESCENE
/////////////////////////////////////
Table objectList;
int numGroup [] ;
int [][] objectID ;
int [][] objectGroup ;
String [][] objectName ;
String [][] objectAuthor ;
String [][] objectVersion ;
String [][] objectPack ;
String [][] objectRender ;
String [][] objectLoadName ;
boolean [][] objectClassic ;
boolean [][] objectP2D ;
boolean [][] objectP3D ;


void buildLibrary() {
  objectList = loadTable(sketchPath("")+"preferences/objects/index_romanesco_objects.csv", "header") ;
  numByGroup() ;
  println("Combien d'objet pas groupe ?",numGroup[1],numGroup[2],numGroup[3]) ; 
  initVarObject() ;
  infoByObject() ;

  
}

void infoByObject() {
  int libraryRank = 0 ;
  int numObjByGroup = 0 ;
  for (int i = 1 ; i < numGroupSlider ; i++) {
    if ( i == 1 ) numObjByGroup = numGroup[i] ;
    if ( i == 2 ) numObjByGroup = numGroup[i] ;
    if ( i == 3 ) numObjByGroup = numGroup[i] ;
    for ( int j = 1 ; j <= numObjByGroup ; j++) {
      libraryRank += 1 ;
      TableRow row = objectList.getRow(libraryRank-1);
      objectID [i][j] = row.getInt("ID") ;
      objectGroup[i][j] = row.getInt("Group");
      objectPack[i][j] = row.getString("Pack");
      objectRender[i][j] = row.getString("Render");
      objectAuthor[i][j] = row.getString("Author");
      objectVersion[i][j] = row.getString("Version");
      objectLoadName[i][j] = row.getString("Class name");
      objectName[i][j] = row.getString("Name");

      println(objectID[i][j], objectLoadName[i][j]) ;

    }
  }
}

void initVarObject() {
  int [] num = new int[numGroupSlider] ;
  for ( int i = 0 ; i<num.length ; i++) {
    num[i] = numGroup[i] ;
  }
  num = sort(num) ;
  int numMaxObj = num[num.length-1] +1 ;
  
  objectID = new int [numGroupSlider][numMaxObj] ;
  objectGroup = new int [numGroupSlider][numMaxObj] ;
  objectName = new String [numGroupSlider][numMaxObj] ;
  objectAuthor = new String [numGroupSlider][numMaxObj] ;
  objectVersion = new String [numGroupSlider][numMaxObj] ;
  objectPack = new String [numGroupSlider][numMaxObj] ;
  objectRender = new String [numGroupSlider][numMaxObj] ;
  objectLoadName = new String [numGroupSlider][numMaxObj] ;
  objectClassic = new boolean [numGroupSlider][numMaxObj] ;
  objectP2D = new boolean [numGroupSlider][numMaxObj] ;
  objectP3D = new boolean [numGroupSlider][numMaxObj] ;
}

void numByGroup() {
  numGroup  = new int[numGroupSlider] ;
  for (TableRow row : objectList.rows()) {
    int objectGroup = row.getInt("Group");
    for (int i = 0 ; i < numSlider ;i++) {
      if (objectGroup == i) numGroup[i] += 1 ;
    }
  }
  //give the value zero at this numGroup by security, because this one are not not use and not init.
  numGroup[0] = 0 ;
}
// END BUILD LIBRARY
////////////////////

//LOAD text Interface
Table textGUI;
int numCol = 15 ;
String[] genTxtGUI = new String[numCol] ;
String[] objTxtGUIone = new String[numCol] ;
String[] objTxtGUItwo = new String[numCol] ;
String[] objTxtGUIthree = new String[numCol] ;
String[] textureTxtGUIone = new String[numCol] ;
String[] textureTxtGUItwo = new String[numCol] ;
String[] textureTxtGUIthree = new String[numCol] ;
String[] typoTxtGUIone = new String[numCol] ;
String[] typoTxtGUItwo = new String[numCol] ;
String[] typoTxtGUIthree = new String[numCol] ;

TableRow [] row = new TableRow[numCol+1] ;

String lang[] ;

void textGUI() {
  if (!test)lang = loadStrings(sketchPath("") +"preferences/language.txt") ; else lang = loadStrings("preferences/language.txt") ;
  String l = join(lang,"") ;
  int language = Integer.parseInt(l);

  
  if( language == 0 ) { 
    textGUI = loadTable(sketchPath("")+"preferences/sliderListFR.csv", "header") ;
  } else if (language == 1 ) {
    textGUI = loadTable(sketchPath("")+"preferences/sliderListEN.csv", "header") ;
  } else {
    textGUI = loadTable(sketchPath("")+"preferences/sliderListEN.csv", "header") ;
  }
    
  for ( int i = 0 ; i < numCol ; i++) {

    row[i] = textGUI.getRow(i) ;
    for ( int j = 1 ; j < numCol ; j++) {
      String numCol = Integer.toString(j) ;
      if ( i == 0 ) genTxtGUI[j] = row[i].getString("Column "+numCol) ;
      if ( i == 1 ) objTxtGUIone[j] = row[i].getString("Column "+numCol) ;
      if ( i == 2 ) objTxtGUItwo[j] = row[i].getString("Column "+numCol) ;
      if ( i == 3 ) objTxtGUIthree[j] = row[i].getString("Column "+numCol) ;
      if ( i == 4 ) textureTxtGUIone[j] = row[i].getString("Column "+numCol) ;
      if ( i == 5 ) textureTxtGUItwo[j] = row[i].getString("Column "+numCol) ;
      if ( i == 6 ) textureTxtGUIthree[j] = row[i].getString("Column "+numCol) ;
      if ( i == 7 ) typoTxtGUIone[j] = row[i].getString("Column "+numCol) ;
      if ( i == 8 ) typoTxtGUItwo[j ] = row[i].getString("Column "+numCol) ;
      if ( i == 9 ) typoTxtGUIthree[j] = row[i].getString("Column "+numCol) ;
    }
  }
}
