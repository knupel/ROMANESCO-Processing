/**
A_Screen_Prescene
//GRAPHIC CONFIGURATION OF THE SCENE DISPLAYING
//SCREEN CHOICE and FULLSCREEN
*/

/**
MUST BE CLEAR

*/
/*
GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] gs = ge.getScreenDevices();
*/
//FULLSCREEN
boolean undecorated = false ;
boolean fullScreen = false ;
boolean displaySizeByImage ;
String displayMode = ("") ;
//ID of the screen
int myScreenToDisplayMySketch ;
//size of the Scene
int fullSceneWidth, fullSceneHeight, sceneWidth, sceneHeight ;
int depth ;
//to load the .csv who give the graphic configuration for the Scene
String pathScenePropertySetting = "preferences/sceneProperty.csv" ;
TableRow row ;
Table configurationScene;

//factor to divide the size of the Pré-Scène 
int divSizePreScene = 2 ;



//SETUP
void display_setup(int speed) {
  frameRate(speed) ;  // Le frameRate doit être le même dans tous les Sketches
  colorMode(HSB, HSBmode.r, HSBmode.g, HSBmode.b, HSBmode.a) ;
  // loadPropertyPrescene() ;
  
    depth = height ;
  //resizable frame by loading external image
  
  //resize by cursor
  surface.setResizable(true);
  
  background_setup() ;
  background_shader_setup() ;
}
//END DISPLAY START
//////////////////


//load property from table

// deprecated
/*
void loadPropertyPrescene() {
  configurationScene = loadTable(sketchPath("") + pathScenePropertySetting, "header");
  row = configurationScene.getRow(0);
  //fullscreen 
  if (row.getString("fullscreen").equals("TRUE") || row.getString("fullscreen").equals("true")) fullScreen = true ; else fullScreen = false ;
  //display on specific screen
  myScreenToDisplayMySketch = row.getInt("whichScreen") -1 ;
  //decorated the scene
  if (row.getString("decorated").equals("FALSE") || row.getString("decorated").equals("false") || fullScreen ) undecorated = true ; else undecorated = false ;
}
*/