// Tab: A_Screen_Scene
  ///////////////////////////////////
 //    GRAPHIC CONFIGURATION  //////
///////////////////////////////////


//SCREEN CHOICE and FULLSCREEN
/*
GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] screenDevice = ge.getScreenDevices();
*/
//FULLSCREEN
boolean undecorated = false ;
boolean fullScreen = false ;
boolean displaySizeByImage ;
String displayMode = ("") ;
//ID of the screen
int whichScreen ;
//size of the Scene
int sceneWidth, sceneHeight ;
//to load the .csv who give the graphic configuration for the Scene
String pathScenePropertySetting = "preferences/sceneProperty.csv" ;
TableRow row ;
Table configurationScene;

//SETUP
void displaySetup(int speed) {
  background(0) ;
  frameRate(speed) ; 
  noCursor () ;
  colorMode(HSB, HSBmode.r, HSBmode.g, HSBmode.b, HSBmode.a) ;
  
  loadPropertyScene() ;
  sizeScene() ;
  
  backgroundSetup() ;
  backgroundShaderSetup(modeP3D) ;
}




//load property from table
void loadPropertyScene() {
  configurationScene = loadTable(sketchPath("") + pathScenePropertySetting, "header");
  row = configurationScene.getRow(0);
  //fullscreen 
  if (row.getString("fullscreen").equals("TRUE") || row.getString("fullscreen").equals("true")) fullScreen = true ; else fullScreen = false ;
  //display on specific screen
  whichScreen = row.getInt("whichScreen") -1 ;
  //decorated the scene
  if (row.getString("decorated").equals("FALSE") || row.getString("decorated").equals("false") || fullScreen ) undecorated = true ; else undecorated = false ;
  //size of the scene when it's not fullscreen
  sceneWidth = row.getInt("width") ;
  sceneHeight =  row.getInt("height")  ;
  //SYPHON
  if(row.getString("miroir").equals("TRUE") || row.getString("miroir").equals("true")) syphon = true ; else syphon = false ;
  
  // type of renderer
  modeP3D = true ; 
}
// end load property



void sizeScene() {
  if (fullScreen) fullScreen(whichScreen) ; else surface.setSize(sceneWidth, sceneHeight);
}
// END size scene












/**
Option to change the size of the scene by the size of imported picture, not used but may be in the future ????
*/
void size_scene_by_picture() {
  //resizable frame by loading external image when Romanesco is not on fullscreen mode
    if (row.getString("resizable").equals("TRUE")) {
      frame.pack();  
      insets = frame.getInsets(); // use for the border of window (top and right)
      displaySizeByImage = true ;
    }
}

//CHANGE SIZE DISPLAY BY IMAGE LOADING
void updateSizeDisplay(PImage imgDisplay) {
  PVector newSizeWindow = new PVector() ;
  if (imgDisplay != null ) {
    PVector newSizeSketch = new PVector (imgDisplay.width, imgDisplay.height ) ;
    setSize((int)newSizeSketch.x, (int)newSizeSketch.y) ;
    newSizeWindow = new PVector ( Math.max( newSizeSketch.x, MIN_WINDOW_WIDTH)  + insets.left + insets.right, 
                                          Math.max( newSizeSketch.y, MIN_WINDOW_HEIGHT) + insets.top  + insets.bottom) ;
    frame.setSize((int)newSizeWindow.x, (int)newSizeWindow.y);
  }
}
/**
End of optional size methode
*/








// MAVERICK
/*
PVector[] screenInfo ;


void fullscreenWithMavericks() {
  initNumberScreen() ;
  infoScreen() ;
  sizeScene() ;
}


void sketchPosition(int whichOne) {
  if (whichOne > screenDevice.length )  whichOne = 0 ;
  GraphicsDevice displayOnThisDevice = screenDevice[whichOne];
  GraphicsConfiguration[] graphicsConfigurationOfThisDevice = displayOnThisDevice.getConfigurations();
  
  
  // loop with a single element the screen selected above
  for ( int i = 0 ; i < graphicsConfigurationOfThisDevice.length ; i++ ) {
    Rectangle gcBounds = graphicsConfigurationOfThisDevice[i].getBounds() ;
    frame.setLocation(gcBounds.x, gcBounds.y) ;
  }
}






public void initNumberScreen() {
  screenInfo = new PVector [screenDevice.length] ;
  for ( int i = 0 ; i < screenInfo.length ; i++)  screenInfo [i] = new PVector () ;
}

public void infoScreen() {
  for (int i = 0; i < screenInfo.length; i++) {
    screenInfo [i].x =  screenDevice[i].getDisplayMode().getWidth() ;
    screenInfo [i].y =  screenDevice[i].getDisplayMode().getHeight() ;
  }
}
// END MAVERICK

*/