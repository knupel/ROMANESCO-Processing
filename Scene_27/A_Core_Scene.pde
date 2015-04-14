/*
Here you find : 

CURSOR, PEN, LEAP MOTION

GRAPHIC CONFIGURATION

MIRROIR

LIGHT
*/


//CURSOR, PEN, LEAP MOTION

void cursorDraw() {
  //mousePressed
  if(ORDER_ONE || ORDER_TWO || ORDER_THREE) ORDER = true ; else ORDER = false ;  
  
  //next previous
  if (nextPrevious) nextPreviousInt = 1 ; else nextPreviousInt = 0 ;
}
///////////////
//END CURSOR, PEN, 





  ///////////////////////////////////
 //    GRAPHIC CONFIGURATION  //////
///////////////////////////////////
void initDraw() {
  rectMode (CORNER) ; 
  if(mavericks && fullScreen) sketchPosition(whichScreen) ;
}

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
  background(0) ;
  frameRate(speed) ; 
  noCursor () ;
  colorMode(HSB, HSBmode.x, HSBmode.y, HSBmode.z, 100) ;
  configurationScene = loadTable(pathScenePropertySetting, "header");
  
  loadPropertyScene() ;
  if(mavericks && fullScreen) fullscreenWithMavericks(whichScreen, undecorated) ; else sizeScene() ;
  
  backgroundShaderSetup(modeP3D) ;
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
  if(row.getString("miroir").equals("TRUE") || row.getString("miroir").equals("true")) syphon = true ; else syphon = false ;
  
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
  // PVector pos = new PVector (0,0) ;
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
    /*
    instance.setVisible(false, false); 
    // instance.setVisible(false); // Processing 303 and 304
    */
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
    // String ID = screenDevice[i].getIDstring() ;
    screenInfo [i].x =  screenDevice[i].getDisplayMode().getWidth() ;
    screenInfo [i].y =  screenDevice[i].getDisplayMode().getHeight() ;
  }
}
// END MAVERICK











// WITHOUT MAVERICKS
///////////////////////////////////
void sizeScene() {
  /*
  if(fullScreen) instance = new JAppleMenuBar();
  */
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
  /*
  // remove the apple menu bar
  instance.setVisible(false, false); 
  // instance.setVisible(false); // Processing 303 and 304
  */
  
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


//SCREEN SIZE
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
boolean syphon  ;

void miroirSetup() {
  //if (syphon) miroir = new Miroir(this);
  miroir = new Miroir(this);
}

void miroirDraw() {
  if(yTouch) syphon = !syphon ;
  if (syphon) miroir.update();
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

















//LIGHT
///////
PVector colorLightOne = new PVector(0,0,0);
PVector colorLightTwo = new PVector(0,0,0);
PVector dirLightOne = new PVector(0,0,1);
PVector dirLightTwo = new PVector(0,0,1);
boolean lightOneMove, lightTwoMove ;

PVector speedColorLight = new PVector(0,0,0) ;
//SETUP
void lightSetup() {
  if(modeP3D) {
    shaderSetup() ;
    float min =.001 ;
    float max = 0.3 ;
    speedColorLight = new PVector(random(min,max),random(min,max),random(min,max)) ;
  }
}



//DRAW
void lightDraw() {
  if(modeP3D) {
    //change color of light
    colorLightOne = new PVector (map(valueSlider[0][6], 0, MAX_VALUE_SLIDER, 0, HSBmode.x), map(valueSlider[0][7],0, MAX_VALUE_SLIDER, 0, HSBmode.y), map(valueSlider[0][8], 0, MAX_VALUE_SLIDER, 0, HSBmode.z)) ;
    colorLightTwo = new PVector (map(valueSlider[0][9], 0, MAX_VALUE_SLIDER, 0, HSBmode.x), map(valueSlider[0][10], 0, MAX_VALUE_SLIDER, 0, HSBmode.y), map(valueSlider[0][11], 0, MAX_VALUE_SLIDER, 0, HSBmode.z)) ;
    
    // change the direction of the light
    if(eLightOneAction == 1 ) lightOneMove = true ; else lightOneMove = false ;
    if(eLightTwoAction == 1 ) lightTwoMove = true ; else lightTwoMove = false ;
    
    if(lightOneMove) {
      dirLightOne.x = map(lightPos.x,0,width, -1,1) ;
      dirLightOne.y = map(lightPos.y,0,height, -1,1) ;
      dirLightOne.z = map(lightPos.z,-750,750, -1,1) ;
    }
    if(lightTwoMove) {
      dirLightTwo.x = map(lightPos.x,0,width, 1,-1) ;
      dirLightTwo.y = map(lightPos.y,0,height, 1,-1) ;
      dirLightTwo.z = map(lightPos.z,-750,750, 1,-1) ;
    }
    //result
    romanescoLight(colorLightOne, colorLightTwo, dirLightOne, dirLightTwo) ;
  }
}

//ANNEXE LIGHT VOID
void romanescoLight(PVector colorOne, PVector colorTwo, PVector dirOne, PVector dirTwo) {
  shader(pixShader);
  // ambiant light
  Vec4 colourAmbient = new Vec4(map(valueSlider[0][0],0,MAX_VALUE_SLIDER,0,HSBmode.x), map(valueSlider[0][1],0,MAX_VALUE_SLIDER,0,HSBmode.y), map(valueSlider[0][2],0,MAX_VALUE_SLIDER,0,HSBmode.z), 100) ;
  
  ambientLightPix(colourAmbient) ;
  
  // directional
  int numOflight = 2 ;
  Vec4 [] colorLight = new Vec4[numOflight] ;
  Vec3 [] dirLight = new Vec3[numOflight] ;
  // change by the future Vec4 HSBmode.a
  float a = 100 ;
  colorLight[0] = new Vec4(colorOne.x, colorOne.y, colorOne.z, a) ;
  colorLight[1] = new Vec4(colorTwo.x, colorTwo.y,  colorTwo.z, a) ;
  dirLight[0] = new Vec3(dirOne.x, dirOne.y, dirOne.z) ;
  dirLight[1] = new Vec3(dirTwo.x, dirTwo.y, dirTwo.z) ;
  
  directionalLightPixList(colorLight,dirLight, 1) ; // 2 lights
  /*
  if(eLightOne == 1 ) directionalLight(colorOne.x, colorOne.y, colorOne.z, dirOne.x, dirOne.y, dirOne.z);
  if(eLightTwo == 1 ) directionalLight(colorTwo.x, colorTwo.y, colorTwo.z, dirTwo.x, dirTwo.y, dirTwo.z);
  */
  // don't use the ambiant light if you need the object color
}



// SHADER PIX LIGHT
///////////////////
PShader pixShader;

void shaderSetup() {
  String path = (preferencesPath +"shader/") ;
  pixShader = loadShader(path+"pixFrag.glsl", path+"pixVert.glsl");
}


// LIGHT
///////

// Annexe light void
//////////////////////

/// AMBIENT LIGHT
/////////////////
void ambientLightPix(Vec4 colourPlusAlpha) {
  /*
  int alphaFromColorMode = 100 ; // Romanesco are in HSB(360,100,100,100) ;
  float alpha = map(colourPlusAlpha.a,0,alphaFromColorMode,0,1) ;
  */
  ambientLight(colourPlusAlpha.r, colourPlusAlpha.g, colourPlusAlpha.b);
  // we can use the pos of light in case we use the function falloff
  /*
  float x = width/2 ;
 float y = height/2 ;
  float z = 0 ;
  ambientLight(colourPlusAlpha.r, colourPlusAlpha.g, colourPlusAlpha.b, x, y, z);
  */
  
}






// POINT LIGTH
//////////////
void pointLightList() {
  float r = 255 *abs(cos(frameCount *.01)) ;
  float g = 255 *abs(cos(frameCount *.002)) ;
  float b = 255 *abs(cos(frameCount *.003)) ;
  float a = 255 ;
  Vec4 colorLightOne = new Vec4(r, g, b, a) ;
  Vec4 colorLightTwo = new Vec4(g, b,  r, a) ;
    float x = mouseX ;
  float y = mouseY ;
  float z = 200 ;
  Vec3 posLightOne = new Vec3(x, y, z) ;
  x = width -mouseX ;
  y = height -mouseY ;
  Vec3 posLightTwo = new Vec3(x, y, z) ;
  pointLightPix(colorLightOne, posLightOne);
  pointLightPix(colorLightTwo, posLightTwo);
}


void pointLightPix(Vec4 colourPlusAlpha, Vec3 pos) {
   float alpha = map(colourPlusAlpha.a,0,255,0,1) ;
   pointLight(colourPlusAlpha.r *alpha, colourPlusAlpha.g *alpha, colourPlusAlpha.b *alpha, pos.x, pos.y, pos.z) ;
}




//DIRECTIONAL LIGHT
///////////////////
/**
open a list of lights with a max of height lights
@param Vec4 [] colour RGBa float component value 0-255
@param Vec4 [] dir xyz float component value -1 to 1
*/
void directionalLightPixList(Vec4 [] colour, Vec3 [] dir, int num) {
   // security for the outbound index
  if (colour.length != num || dir.length != num ) { 
    num = 1 ;
    println("Problem with the number of light, by security we use just one light now !") ;
  }
  for (int i = 0 ; i < 1 ; i++) {
    directionalLightPix(colour[i], dir[i]) ;
  }
}
// specific void
///////////////
void directionalLightPix(Vec4 rgba, Vec3 dir) {
  int alphaFromColorMode = 100 ; // Romanesco are in HSB(360,100,100,100) ;
  float alpha = map(rgba.a,0,alphaFromColorMode,0,1) ;
  directionalLight(rgba.r *alpha, rgba.g *alpha, rgba.b *alpha, dir.x, dir.y, dir.z);
  
}



//SPOT LIGHT
/////////////
void spotLightPixList() {
  float r = 255 *abs(cos(frameCount *.002)) ;
  float g = 255 *abs(cos(frameCount *.01)) ;
  float b = 255 *abs(cos(frameCount *.004)) ;
  float a = 255 ;
  Vec4 colorLightOne = new Vec4(r, g, b, a) ;
  Vec4 colorLightTwo = new Vec4(g, b,  r, a) ;
  Vec4 colorLightThree = new Vec4(b, r,  g, a) ;
  
  float x = mouseX ;
  float y = mouseY ;
  float z = 200 ;
  Vec3 posLightOne = new Vec3(x, y, z) ;
  x = width -mouseX ;
  y = height -mouseY ;
  Vec3 posLightTwo = new Vec3(x, y, z) ;
  x = width *sin(frameCount *.002) ;
  y = height *sin(frameCount *.01) ;
  Vec3 posLightThree = new Vec3(x, y, z) ;
  
  float dirX = 0 ;
  float dirY = 0 ;
  float dirZ = -1 ;
  Vec3 dirLight = new Vec3(dirX, dirY, dirZ) ;
  
  /*
  float ratio = 1.2 +(5 *abs(sin(frameCount *.003))) ;
  float angle = TAU/ratio ; // good from PI/2 to
  float concentration = 1+ 100 *abs(sin(frameCount *.004)); // try 1 > 1000
  */
   float angle = TAU /2 ;
  float concentration = 100 ;

  
  spotLightPix(colorLightOne, posLightOne, dirLight, angle, concentration) ;
  spotLightPix(colorLightTwo, posLightTwo, dirLight, angle, concentration) ;
  spotLightPix(colorLightThree, posLightThree, dirLight, angle, concentration) ;
}

void spotLightPix(Vec4 rgba, Vec3 pos, Vec3 dir, float angle, float concentration) {
   float alpha = map(rgba.a,0,255,0,1) ;
   spotLight(rgba.r *alpha, rgba.g *alpha, rgba.b *alpha, pos.x, pos.y, pos.z, dir.x, dir.y, dir.z, angle, concentration) ;
}
// END SHADER PIX LIGTH
//////////////////////

// END LIGHT
////////////







// GLOBAL SHADER
////////////////
void  shaderDraw() {
  // Color value fro the global vertex
  ////////////////////////////////////
  Vec4 RGBa = new Vec4(1, 1, 1, .5) ; // it's OPENGL data between 0 to 1 
    // the range is between -1 to 1, you can go beyond but take care at your life !
  PVector RGB = new PVector(RGBa.r, RGBa.g, RGBa.b);

  pixShader.set("colorVertex", RGB);
  pixShader.set("alphaVertex", RGBa.a);
  // pixlightShader.set("contrast", 1.);
  
  
  // vertex position
  //////////////////
  // float canvasZ = cos(frameCount *.01) ;
  PVector canvasXYZ = new PVector (1,1,1) ;
  
  pixShader.set("canvas", canvasXYZ);
  pixShader.set("zoom", 1.);
}

// GLOBAL SHADER
////////////////
