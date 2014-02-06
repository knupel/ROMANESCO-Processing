
//LOAD PICTURE VIGNETTE

int numVignette ;
void importPicButtonSetup() {
  //load button vignette GUI general
  for(int j=0 ;  j<bouton.length ; j++ ) bouton[j] = loadImage ("bouton/bouton"+j+".png") ;
  
  //load simple vignette
  numVignette = numObjectSimple +1  ;
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
  numVignette = numObjectTexture +1  ;
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
  numVignette = numObjectTypography +1  ;
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




//SAVE SLIDER SETTING
//GLOBALE
byte saveR [] = new byte [2*numSlider]; // byte sur cette -128 à 127 soit 256 bytes
byte loadR []  = new byte [2*numSlider] ;
//END GLOBAL

//SETUP
void loadSetup() {
  //////////// ATTENTION ////////////////
  // put the folder "Sauvegarde" in the folder "data", if you don't do that, it is not export when you make your application.
  // loadR = loadBytes("Sauvegarde"+java.io.File.separator+"Reglage.dat");
  loadR = loadBytes("setting/BasicSetting.dat");
  
  //load data object
  objectTableSetup() ;
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
    chargement = true ;
    loadR = loadBytes(chargementCheminReglette);
  } else {
    chargement = false ;
  }
}


//LOAD INFO OBJECT
Table objectList;
int numObjectSimple, numObjectTexture, numObjectTypography ;
int [] objectSimpleID, objectTextureID, objectTypographyID ;
String [] objectSimpleName, objectTextureName, objectTypographyName ;
String [] objectSimpleAuthor, objectTextureAuthor, objectTypographyAuthor ;
boolean [] objectSimpleWeather, objectTextureWeather, objectTypographyWeather ;
boolean [] objectSimpleClassic, objectTextureClassic, objectTypographyClassic ;
boolean [] objectSimpleP2D, objectTextureP2D, objectTypographyP2D ;
boolean [] objectSimpleP3D, objectTextureP3D, objectTypographyP3D ;


void objectTableSetup() {
  objectList = loadTable("objectList.csv", "header") ;
  
  //find the quantity of object in each family
  for (TableRow row : objectList.rows()) {
  //  int objectID = row.getInt("ID");
    String objectFamily = row.getString("family");
  //  String objectName = row.getString("name");
 //   String objectAuthor = row.getString("author");
  //  String objectWeather = row.getString("weather") ;
    if (objectFamily.equals("simple")) numObjectSimple += 1 ;
    if (objectFamily.equals("texture")) numObjectTexture += 1 ;
    if (objectFamily.equals("typography")) numObjectTypography += 1 ;
    //  println(objectID + ": " + objectName + " by " + objectAuthor ) ;
  }
  
  //generate the array var for each component 
  //Simple object
  objectSimpleID  = new int[numObjectSimple] ;
  objectSimpleName = new String[numObjectSimple] ;
  objectSimpleAuthor = new String[numObjectSimple] ;
  //meteo button
  objectSimpleWeather = new boolean[numObjectSimple] ;
  //render
  objectSimpleClassic = new boolean[numObjectSimple] ;
  objectSimpleP2D = new boolean[numObjectSimple] ;
  objectSimpleP3D = new boolean[numObjectSimple] ;
  
  //Texture object
  objectTextureID = new int[numObjectTexture] ;
  objectTextureName = new String[numObjectTexture] ;
  objectTextureAuthor = new String[numObjectTexture] ;
  //meteo button
  objectTextureWeather = new boolean[numObjectSimple] ;
  //render
  objectTextureClassic = new boolean[numObjectSimple] ;
  objectTextureP2D = new boolean[numObjectSimple] ;
  objectTextureP3D = new boolean[numObjectSimple] ;
  
  //Typography object
  objectTypographyID = new int[numObjectTypography] ;
  objectTypographyName = new String[numObjectTypography] ;
  objectTypographyAuthor = new String[numObjectTypography] ;
  //meteo button
  objectTypographyWeather = new boolean[numObjectSimple] ;
  //render
  objectTypographyClassic = new boolean[numObjectSimple] ;
  objectTypographyP2D = new boolean[numObjectSimple] ;
  objectTypographyP3D = new boolean[numObjectSimple] ;
  
  //reInit the counter
  numObjectSimple = numObjectTexture = numObjectTypography = 0 ; 
  //write the name object
  for (TableRow row : objectList.rows()) {
    int objectID = row.getInt("ID");
    String objectFamily = row.getString("family");
    String objectName = row.getString("name");
    String objectAuthor = row.getString("author");
    //weather (meteo) button
    String objectWeather = row.getString("weather") ;
    
    //check by familly
    if (objectFamily.equals("simple")) {
      objectSimpleID[numObjectSimple] = objectID ;
      objectSimpleName[numObjectSimple] = objectName ;
      objectSimpleAuthor[numObjectSimple] = objectAuthor ;
      if (objectWeather.equals("true") ) objectSimpleWeather[numObjectSimple] = true ; else objectSimpleWeather[numObjectSimple] = false ;
      numObjectSimple += 1 ;
    }
    if (objectFamily.equals("texture")) 
    {
      objectTextureID[numObjectTexture] = objectID ;
      objectTextureName[numObjectTexture] = objectName ;
      objectTextureAuthor[numObjectTexture] = objectAuthor ;
      if (objectWeather.equals("true") ) objectTextureWeather[numObjectTexture] = true ; else objectTextureWeather[numObjectTexture] = false ;
      numObjectTexture += 1 ;
    }
    if (objectFamily.equals("typography")) 
    {
      objectTypographyID[numObjectTypography] = objectID ;
      objectTypographyName[numObjectTypography] = objectName ;
      objectTypographyAuthor[numObjectTypography] = objectAuthor ;
      if (objectWeather.equals("true") ) objectTypographyWeather[numObjectTypography] = true ; else objectTypographyWeather[numObjectTypography] = false ;
      numObjectTypography += 1 ;
    }
  }
}


//LOAD text Interface
Table textGUI;
int numCol = 9 ;
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

TableRow [] row = new TableRow[10] ;

String lang[] ;

void textGUI() {
  if (!test)lang = loadStrings(sketchPath("") +"preference/language.txt") ; else lang = loadStrings("preference/language.txt") ;
  String l = join(lang,"") ;
  int language = Integer.parseInt(l);

  
  if( language == 0 ) { 
    textGUI = loadTable("sliderListFR.csv", "header") ;
  } else if (language == 1 ) {
    textGUI = loadTable("sliderListEN.csv", "header") ;
  } else {
    textGUI = loadTable("sliderListEN.csv", "header") ;
  }
    
  for ( int i = 0 ; i < 10 ; i++) {

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
