//GLOBAL
//which size SCENE for the MIROIR
PVector posButtonScene = new PVector ( 99, 40 ) ;
PVector sizeButtonScene = new PVector ( 85, 20 ) ;
PVector posButtonMiroir = new PVector ( 210, 40 ) ;
PVector sizeButtonMiroir = new PVector ( 85, 20 ) ;
//which size WINDOW or FULL SCREEN
PVector posButtonWindow = new PVector ( 10, 70 ) ;
PVector sizeButtonWindow = new PVector ( 180, 20 ) ;
PVector posButtonFullscreen = new PVector ( 200, 70 ) ;
PVector sizeButtonFullscreen = new PVector ( 180, 20 ) ;
//which size for window
PVector posSliderWidth = new PVector( 10, 134 ) ;
PVector posMoletteWidth = posSliderWidth ;
PVector posSliderHeight = new PVector( 200, 134 ) ;
PVector posMoletteHeight = posSliderHeight ;
PVector sizeSlider = new PVector ( 180, 16 ) ;
//button start
PVector posButtonStart = new PVector (10, 190) ;
PVector sizeButtonStart = new PVector (210, 20 ) ;
// "X" and  "Y" componant give the button position    "Z" componant = space between the button
PVector posWhichScreenButton = new PVector (150, 100, 23 ) ;

int [] standardSizeWidth = {0,160,240,320,480,640,800,964,1024,1280,1344,1366,1400,1600,1920,2048,2560,3840,4096,5120,6400,7680,8192,16384} ;
int [] standardSizeHeight = {0,120,160,240,320,480,544,600,720,768,800,960,1000,1008,1024,1050,1080,1200,1536,2048,2400,3072,4096,4320,4800,6144,12288} ;
  
// SETUP
////////
void diplaySetup() {
  size(400, 220);
  background(grisTresFonce);
}

color blanc, gris, grisClair, grisFonce, grisTresFonce, orange, rouge, rougeFonce, vertClair, vertFonce ;
void colorSetup() {
  colorMode(HSB,360,100,100) ;
  blanc = color(0,0,95) ;
  grisClair = color (27,10, 70) ; //gris clair
  gris = color (27,20, 50) ; //gris
  grisFonce = color(0,0,40)  ;
  grisTresFonce = color(0,0,15)  ;
  orange = color (35,100,100) ;
  rouge = color(10,100,100) ;
  rougeFonce = color (10, 100, 70) ;
  vertClair = color (88,85,71) ; // vert clair
  vertFonce = color (90,93,46) ; // vert foncé
  c1 = color(orange) ;
  c2 = color(rougeFonce ) ;
  c3 = color(vertClair) ;
  c4 = color(vertFonce) ;
  //common data
  colorIN = color (vertClair ) ;
  colorOUT = color (vertFonce ) ;
}


void structureSetup() {
  String textScene = ("Scène") ;
  String textMiroir = ("Miroir") ;
  String textFullscreen = ("in Fullscreen") ;
  String textWindow = ("in the Window") ;
  String textButtonStart = ("Launch Romanesco") ;
  
  buttonScene = new Button(posButtonScene, sizeButtonScene, c1, c2, c3, c4, textScene) ;
  buttonMiroir = new Button(posButtonMiroir, sizeButtonMiroir, c1, c2, c3, c4, textMiroir) ;
  buttonWindow = new Button(posButtonWindow, sizeButtonWindow, c1, c2, c3, c4, textWindow) ;
  buttonFullscreen = new Button(posButtonFullscreen, sizeButtonFullscreen, c1, c2, c3, c4, textFullscreen) ;
  buttonStart = new Button(posButtonStart, sizeButtonStart, colorIN, colorOUT, colorIN, colorOUT, textButtonStart ) ;

  //quantityScreen count the number of screen available
  int quantityScreen = devices.length ;
  whichScreenSetup(quantityScreen, posWhichScreenButton) ;
  
  color colorBG = color(grisFonce) ;
  color colorBoxIn = color(vertFonce) ;
  color colorBoxOut = color(rougeFonce) ;
  
  sliderWidth = new Slider(posSliderWidth, posMoletteWidth, sizeSlider, colorBG, colorBoxIn, colorBoxOut ) ;
  sliderWidth.sliderSetting() ;
  sliderHeight = new Slider(posSliderHeight, posMoletteHeight, sizeSlider, colorBG, colorBoxIn, colorBoxOut ) ;
  sliderHeight.sliderSetting() ;
}



void loadSetup() {
  FuturaStencil =loadFont ("FuturaStencilICG-20.vlw") ;
  EmigreEight = loadFont ("EmigreEight-14.vlw") ;
  // path to OPENING APP
  pathScene = (sketchPath("") + "sources/Prescene_"+version+".app");
  pathMiroir = (sketchPath("") + "sources/Scene_"+version+".app");

  String[] l = split( ("1"), " ") ;
  saveStrings(sketchPath("")+"sources/preferences/language.txt", l) ;
}
// END SETUP
////////////



// DRAW
///////
void displayDraw() {
  background(grisTresFonce) ;
  fill(orange) ;
  textFont(FuturaStencil,20);
}

boolean MiroirSetting, SceneSetting ;

void launcherDraw() {
  fill(rougeFonce) ;
  rect(0,0, width, 30) ;
  fill(orange) ;
  rect(0,30,width,2) ;
  fill(blanc) ;
  text(nameVersion, 10.0, 23.0);
  textFont(EmigreEight,14);
  text("Version " +prettyVersion + "."+version, 205.0, 23.0);
  fill(grisClair) ;
  textFont(FuturaStencil,20);
  text("Choice                or ", 10.0, 60.0);
  choiceMiroirOrScene() ;
  //fork choice menu
  if (buttonScene.OnOff || SceneSetting) launchScene() ;
  if (buttonMiroir.OnOff || MiroirSetting) launchMiroir() ;
}
// END DRAW
///////////





//ANNEXE
////////
void choiceMiroirOrScene() {
  buttonScene.displayButton(SceneSetting) ;
  buttonMiroir.displayButton(MiroirSetting) ;
  if(MiroirSetting) whichAppOpeningTheScene =("true") ; else whichAppOpeningTheScene =("false") ;
}
// Scene launcher
void launchScene() {
  MiroirSetting = false ;
  SceneSetting = true ;
  //button to choice between the fullscreen or window display
  buttonWindow.displayButton() ;
  buttonFullscreen.displayButton() ;
  
  if (buttonWindow.OnOff) screen = ("false") ; else if (buttonFullscreen.OnOff) screen = ("true") ;
  // what display  
  if (buttonFullscreen.OnOff) {
    fill(orange) ;
    text("on screen", 10.0, 120.0);
    //on which screen display the window
    whichScreenDraw() ;
  } else if (buttonWindow.OnOff) {
    screen = ("false") ;
    sizeWindow() ;
  }
  //last step
  openScene = true ;
  launchApp() ;
  
}

// LAUNCH MIROIR
void launchMiroir() {
  openScene = false ;
  MiroirSetting = true ;
  SceneSetting = false ;
  screen = ("false") ;
  buttonWindow.OnOff = true ;
  addressLocal(10,88) ;
  sizeWindow() ;
  //last step
  launchApp() ;
}

// LAUNCH APP
void launchApp() {
  if (buttonWhichScreenOnOff > 0 && buttonFullscreen.OnOff) {
    buttonStart.displayButton() ;
  //window mode the user must choice a window size  
  } else if ( buttonWindow.OnOff && heightSlider>1 & widthSlider>1 ) {
    buttonStart.displayButton() ;
  } else {
    fill(orange) ;
    text("Please finish the configuration",10,210) ;
  }
}


// OPEN APP
void openApp(boolean openTheScene) {
  if(openTheScene) open(pathScene); else open(pathMiroir) ;
}




// SAVE DISPLAY PROPERTY
Table sceneProperty;
String pathScenePropertySetting = sketchPath("")+"sources/preferences/sceneProperty.csv" ;

void saveProperty() {
  sceneProperty = new Table();
  String colOne =("fullscreen");
  String colTwo =("whichScreen");
  String colThree =("resizable");
  String colFour =("decorated");
  String colFive =("width");
  String colSix =("height");
  String colSeven =("render");
  String colHeight =("miroir");
  
  sceneProperty.addColumn(colOne);
  sceneProperty.addColumn(colTwo);
  sceneProperty.addColumn(colThree);
  sceneProperty.addColumn(colFour);
  sceneProperty.addColumn(colFive);
  sceneProperty.addColumn(colSix);
  sceneProperty.addColumn(colSeven);
  sceneProperty.addColumn(colHeight);
  
  TableRow newRow = sceneProperty.addRow();
  int whichScreen = 0 ; 
  if(mavericks) whichScreen = IDscreenSelected() -1 ; else whichScreen = IDscreenSelected() ;
  
  newRow.setString(colOne, screen);
  newRow.setInt(colTwo, whichScreen);
  newRow.setString(colThree, "true");
  newRow.setString(colFour, "true");
  newRow.setInt(colFive, standardSizeWidth[widthSlider-1]);
  newRow.setInt(colSix, standardSizeHeight[heightSlider -1]);
  newRow.setString(colSeven, "P3D");
  newRow.setString(colHeight, whichAppOpeningTheScene);
  //
  saveTable(sceneProperty, pathScenePropertySetting);
}
// END SAVE PROPERTY
////////////////////




/////////////////
// ADDRESS IP
void addressLocal(int x, int y) {
  fill(orange) ;
  try {
    fill(grisClair) ;
    text("local address", x,y ) ;
    text (java.net.InetAddress.getLocalHost().getHostAddress(), x+188,y) ;
  }
  catch(Exception e) {}
}

////////////////
// SIZE WINDOW
void sizeWindow() {
  //setting the Scene size
  sliderHeight.sliderUpdate() ;
  sliderWidth.sliderUpdate() ;
  
  heightSlider = int(map(sliderHeight.getValue(),0,1,1,standardSizeHeight.length))  ;
  widthSlider = int(map(sliderWidth.getValue(),0,1,1,standardSizeWidth.length))  ;
  String h = Integer.toString(standardSizeHeight[heightSlider -1]) ;
  String w = Integer.toString(standardSizeWidth[widthSlider-1]) ;
  //check the width
  int correctionPosY = -14 ;
  if ( widthSlider <= 1 ) {
    fill(rougeFonce) ;
    text("Width " + w, posSliderWidth.x, posSliderWidth.y +correctionPosY);
  } else {
    fill(vertFonce) ;
    text("Width " + w, posSliderWidth.x, posSliderWidth.y +correctionPosY);
  }
  //check the height
  if ( heightSlider <= 1 ) {
    fill(rougeFonce) ;
    text("Heigth " + h, posSliderHeight.x, posSliderHeight.y +correctionPosY);
  } else {
    fill(vertFonce) ;
    text("Heigth " + h, posSliderHeight.x, posSliderHeight.y +correctionPosY);
  }
}

//////////////
//WHICH SCREEN
int screenNum  ;
//SETUP 
void whichScreenSetup(int n , PVector infoPos) {
  //quantity of button choice
  screenNum = n ;
  whichScreenButton = new Button [screenNum] ;
  //position of the button  
  int x = (int)infoPos.x ;
  int y = (int)infoPos.y ;
  int space = (int)infoPos.z ;
  
  for ( int i = 0 ; i <  screenNum ; i++) {
    PVector pos = new PVector( x +( i *space), y ) ;
    PVector size = new PVector (20,20) ;
    String title = Integer.toString(i+1) ;
    whichScreenButton[i] = new Button(pos, size, c1, c2, c3, c4, title) ;
  }
}

//DRAW
void whichScreenDraw() {
  for(int i =0 ; i <screenNum ; i++) {
    whichScreenButton[i].displayButton() ;
  }
}

//MOUSEPRESSED
void whichScreenPressed() {
  for(int i =0 ; i< screenNum ; i++ ) {
    if (whichScreenButton[i].inside ) {
      for( int j =0 ; j < screenNum ; j++ ) whichScreenButton[j].OnOff = false ;
    }
  }
}

//MOUSERELEASED
int buttonWhichScreenOnOff ;

void whichScreenReleased() {
  buttonWhichScreenOnOff = 0 ;
  for(int i = 0 ; i<screenNum ; i++ ) {
    whichScreenButton[i].mouseClic() ;
    if(whichScreenButton[i].OnOff) buttonWhichScreenOnOff += 1 ;
  }
}

//ID screen
int IDscreen = 0 ;
int IDscreenSelected() {
  
  for (int i = 0 ; i < screenNum ; i++ ) { 
    if (whichScreenButton[i].OnOff == true ) IDscreen = i+1 ;
  }
  return IDscreen ;
}


//check OS
boolean mavericks = false ;
void OSMavericksCheck() {
  // check OSX version
  String OS = System.getProperty("os.version") ;
  OS  = OS.replace(".","");
  int OSversion = Integer.parseInt(OS);
  if(OSversion >= 1090  ) mavericks = true ; else mavericks = false ;
}
