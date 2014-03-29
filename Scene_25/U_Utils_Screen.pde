  ///////////////////////////////////
 //    GRAPHIC CONFIGURATION  //////
///////////////////////////////////

//SCREEN CHOICE and FULLSCREEN
GraphicsEnvironment g = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] screenDevice = g.getScreenDevices();
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
Table configurationScene;


String pathScenePropertySetting = sketchPath("")+"preferences/sceneProperty.csv" ;
TableRow row ;

//SETUP
void displaySetup(int speed) {
  frameRate(speed) ; noCursor () ;
  colorMode(HSB, HSBmode.x, HSBmode.y, HSBmode.z, 100) ;
  configurationScene = loadTable(pathScenePropertySetting, "header");

  
  loadPropertyScene() ;
  if(mavericks && fullScreen) fullscreenWithMavericks(whichScreen, undecorated) ; else sizeScene() ;
}




//load property from table
void loadPropertyScene() {
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
  if(row.getString("miroir").equals("TRUE") || row.getString("miroir").equals("true")) sendToSyphon = true ; else sendToSyphon = false ;
  

  // type of renderer
  if      (row.getString("render").equals("P2D") ) { displayMode = ("P2D") ; modeP2D = true ; }
  else if (row.getString("render").equals("P3D") ) { displayMode = ("P3D") ; modeP3D = true ; }
  else if (row.getString("render").equals("OPENGL")  || row.getString("render").equals("opengl")) { displayMode = ("OPENGL") ; modeOPENGL = true ; }
  else  { displayMode = ("Classic") ; modeClassic = true ; }
}
// end load property



// MAVERICK
PVector[] screenInfo ;


void fullscreenWithMavericks(int whichOne, boolean decor) {
  initNumberScreen() ;
  infoScreen() ;
  screenMode(decor, screenInfo[whichOne]) ;
}

void sketchPosition(int whichOne) {
  PVector pos = new PVector (0,0) ;
  if (whichOne > screenDevice.length )  whichOne = 0 ;
  GraphicsDevice displayOnThisDevice = screenDevice[whichOne];
  GraphicsConfiguration[] graphicsConfigurationOfThisDevice = displayOnThisDevice.getConfigurations();
  
  
  // loop with a single element the screen selected above
  for ( int i = 0 ; i < graphicsConfigurationOfThisDevice.length ; i++ ) {
    Rectangle gcBounds = graphicsConfigurationOfThisDevice[i].getBounds() ;
    frame.setLocation(gcBounds.x, gcBounds.y) ;
  }
}



void screenMode(boolean varFullscreen, PVector size) {
  if(varFullscreen) {
    removeBorder(true) ;
    instance.setVisible(false, false);
  }
  if       (modeP3D) size((int)size.x,(int)size.y, P3D) ;
  else if  (modeP2D) size((int)size.x,(int)size.y, P2D) ;
  else if  (modeOPENGL) size((int)size.x,(int)size.y, OPENGL) ;
  else size((int)size.x,(int)size.y) ;
}


public void initNumberScreen() {
  screenInfo = new PVector [screenDevice.length] ;
  for ( int i = 0 ; i < screenInfo.length ; i++)  screenInfo [i] = new PVector (0,0,0 ) ;
}

public void infoScreen() {
  for (int i = 0; i < screenInfo.length; i++) {
    String ID = screenDevice[i].getIDstring() ;
    screenInfo [i].x =  screenDevice[i].getDisplayMode().getWidth() ;
    screenInfo [i].y =  screenDevice[i].getDisplayMode().getHeight() ;
  }
}
// END MAVERICK











// WITHOUT MAVERICKS
///////////////////////////////////
void sizeScene() {
  if(fullScreen) instance = new JAppleMenuBar();
    //create the Scene on fullscreen mode
  if (fullScreen && modeClassic) {
    size(screenWidth(whichScreen),screenHeight(whichScreen)) ;
    sketchPosWithoutMavericks(0, 0, whichScreen) ;
  } else if (fullScreen && modeP2D) {
    if ( !isGL() ) removeBorder(undecorated) ;
    size(screenWidth(whichScreen),screenHeight(whichScreen), P2D) ;
    sketchPosWithoutMavericks(0, 0, whichScreen) ;
  } else if (fullScreen && modeP3D) {
    if ( !isGL() ) removeBorder(undecorated) ;
    size(screenWidth(whichScreen),screenHeight(whichScreen), P3D) ;
    sketchPosWithoutMavericks(0, 0, whichScreen) ;
  } else if (fullScreen && modeOPENGL) {
    if ( !isGL() ) removeBorder(undecorated) ;
    size(screenWidth(whichScreen),screenHeight(whichScreen), OPENGL) ;
    sketchPosWithoutMavericks(0, 0, whichScreen) ;
  }
  //create the Scene on window mode
  else if ( !fullScreen && modeClassic) size(sceneWidth, sceneHeight) ;
  else if ( !fullScreen && modeP2D    ) size(sceneWidth, sceneHeight, P2D) ;
  else if ( !fullScreen && modeP3D    ) size(sceneWidth, sceneHeight, P3D) ;
  else if ( !fullScreen && modeOPENGL ) size(sceneWidth, sceneHeight, OPENGL) ;
  else size(sceneWidth, sceneHeight) ;
  
  //resizable frame by loading external image when Romanesco is not on fullscreen mode
  if (row.getString("resizable").equals("TRUE")  && !fullScreen && modeClassic ) {
    frame.pack();  
    insets = frame.getInsets(); // use for the border of window (top and right)
    displaySizeByImage = true ;
  }
}
// END size scene



void sketchPosWithoutMavericks(int x, int y, int whichOne) {
  // remove the apple menu bar
  instance.setVisible(false, false);
  
  if (whichOne >= screenDevice.length ||  whichOne < 0 ) { 
    whichOne = 0 ;
    println( "screen choice not available") ;
  } 
  GraphicsDevice gd = screenDevice[whichOne];
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


//SCREN SIZE
//catch the size of display device to get the fullscreen on the screen of your choice
PVector fullScreen(int whichOne) {
  PVector size = new PVector(0,0) ;
  if (whichOne >= screenDevice.length ) { 
    whichOne = 0 ;
    println( "screen choice not available") ;
  }
  size.x =  screenDevice[whichOne].getDisplayMode().getWidth() ;
  size.y =  screenDevice[whichOne].getDisplayMode().getHeight() ;

  return size ;
}
// width
int screenWidth(int whichOne) {
  int x = 0 ;
  if (whichOne >= screenDevice.length ||  whichOne < 0 ) { 
    whichOne = 0 ;
    println( "screen choice not available") ;
  }
  println(whichOne) ;
  x = screenDevice[whichOne].getDisplayMode().getWidth() ;
  return x ;
}
//heigth
int screenHeight(int whichOne) {
  int y = 0 ;
  if (whichOne >= screenDevice.length || whichOne < 0 ) { 
    whichOne = 0 ;
    println( "screen choice not available") ;
  }
  y = screenDevice[whichOne].getDisplayMode().getHeight() ;
  return y ;
}
// END SCREEN SIZE
//END WITHOUT MAVERICK






// ANNEXE
//REMOVE decoration windows
void removeBorder(boolean decor) {
  frame.removeNotify();
  frame.setUndecorated(decor);
  frame.addNotify();
}

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
// END ANNEXE






// MIROIR
/////////
Miroir miroir;
boolean sendToSyphon  ;

void miroirSetup() {
  if (sendToSyphon) miroir = new Miroir(this);
}

void miroirDraw() {
  if (sendToSyphon) miroir.update();
}




class Miroir {
  public PGraphics canvas;
  public SyphonServer server;
  PApplet that;
  Miroir(PApplet that) {
    this.that = that;
    canvas = createGraphics(that.width, that.height, P3D);
    // Create syhpon server to send frames out.
    //server = new SyphonServer(that, "Processing Syphon");
    server = new SyphonServer(that, "Romanesco");
  }
  void update() {
    that.loadPixels();
    canvas.loadPixels();
    //mirror effect
    /*
    for(int i=0;i<that.pixels.length;i++){
      canvas.pixels[i] = that.pixels[i];
    }
    */
    for(int x = 0; x < that.width; x++) {
     for(int y = 0; y < that.height; y++) {
         canvas.pixels[((that.height-y-1)*that.width+x)] = that.pixels[y*that.width+x];
     }
   }
    canvas.updatePixels();
    server.sendImage(canvas);
  }
}
//END MIROIR


  //////////////////////////////////////
 ///  END OF GRAPHIC CONFIGURATION ////
//////////////////////////////////////
