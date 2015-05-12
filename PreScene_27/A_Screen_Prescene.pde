///////////////////////////////////////////////
//GRAPHIC CONFIGURATION OF THE SCENE DISPLAYING
//SCREEN CHOICE and FULLSCREEN
GraphicsEnvironment g = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] gs = g.getScreenDevices();
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
Table configurationScene;
//factor to divide the size of the Pré-Scène 
int divSizePreScene = 2 ;

String pathScenePropertySetting = sketchPath("")+"preferences/sceneProperty.csv" ;
TableRow row ;

//SETUP
void displaySetup(int speed) {
  frameRate(speed) ;  // Le frameRate doit être le même dans tous les Sketches
  
  //size and different property of scene : size, border, P2D, P3D...
  colorMode(HSB, HSBmode.r, HSBmode.g, HSBmode.b, HSBmode.a) ;
  background(0);

  loadPropertyPrescene() ;
  sizePrescene() ;
  backgroundShaderSetup(modeP3D) ;
}
//END DISPLAY START
//////////////////


//load property from table
void loadPropertyPrescene() {
  configurationScene = loadTable(pathScenePropertySetting, "header");
  row = configurationScene.getRow(0);
  //fullscreen 
  if (row.getString("fullscreen").equals("TRUE") || row.getString("fullscreen").equals("true")) fullScreen = true ; else fullScreen = false ;
  //display on specific screen
  myScreenToDisplayMySketch = row.getInt("whichScreen") -1 ;
  //decorated the scene
  if (row.getString("decorated").equals("FALSE") || row.getString("decorated").equals("false") || fullScreen ) undecorated = true ; else undecorated = false ;

  // type of renderer
  if      ( row.getString("render").equals("P2D") ) { displayMode = ("P2D") ;  modeP3D = false ; }
  else if ( row.getString("render").equals("P3D") ) { displayMode = ("P3D") ; modeP3D = true ; }
  else if (  row.getString("render").equals("OPENGL")  || row.getString("render").equals("opengl") ) { displayMode = ("OPENGL") ; modeP3D = false ; }
  else { displayMode = ("Classic") ; modeP3D = false ; }
}





// SIZE SCENE
void sizePrescene() {
      //size of the scene or prescene
  if(modeP3D) size(600,400,P3D) ; else size(600,400) ;
  depth = height ;
    //resizable frame by loading external image
  // if (row.getString("resizable").equals("TRUE")    || row.getString("fullscreen").equals("true")) {
  if (row.getString("resizable").equals("TRUE")) {
    frame.pack();  
    insets = frame.getInsets(); // use for the border of window (top and right)
    displaySizeByImage = true ;
  }
  
  //resize by cursor
  frame.setResizable(true);
}
// END SIZE SCENE

    
//CHANGE SIZE DISPLAY BY IMAGE LOADING
void updateSizeDisplay(PImage imgDisplay) {
  if (imgDisplay != null ) {
    PVector newSizeSketch = new PVector (imgDisplay.width, imgDisplay.height ) ;
    setSize((int)newSizeSketch.x, (int)newSizeSketch.y) ;
    PVector newSizeWindow = new PVector ( Math.max( newSizeSketch.x, MIN_WINDOW_WIDTH)  + insets.left + insets.right, 
                                          Math.max( newSizeSketch.y, MIN_WINDOW_HEIGHT) + insets.top  + insets.bottom) ;
    frame.setSize((int)newSizeWindow.x, (int)newSizeWindow.y);
  }
}

//catch the size of display device to get the fullscreen on the screen of your choice
PVector fullScreen(int whichScreen) {
  PVector size = new PVector(0,0) ;
  if (whichScreen >= gs.length ) { 
    whichScreen = 0 ;
  }
  size.x =  gs[whichScreen].getDisplayMode().getWidth() ;
  size.y =  gs[whichScreen].getDisplayMode().getHeight() ;
  
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();

  return size ;
}

void sketchPos(int x, int y, int whichScreen) {
  if (whichScreen >= gs.length ) { 
    whichScreen = 0 ;
  } 
  GraphicsDevice gd = gs[whichScreen];
  GraphicsConfiguration[] gc = gd.getConfigurations();
  for (int i=0; i < gc.length; i++) {
    Rectangle gcBounds = gc[i].getBounds();
    int xoffs = gcBounds.x;
    int yoffs = gcBounds.y;
    int posX = (i*50)+xoffs ;
    int posY =  (i*60)+yoffs ;
    frame.setLocation(posX +x, posY +y);
  }
}

// END OF GRAPHIC CONFIGURATION
///////////////////////////////
