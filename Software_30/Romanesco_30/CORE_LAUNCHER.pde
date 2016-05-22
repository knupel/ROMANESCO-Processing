/**
CORE LAUNCHER 1.0.1
*/

void diplaySetup() {
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
  pathPrescene = (sketchPath("") + "sources/Prescene_"+version+".app");
  pathScene_window = (sketchPath("") + "sources/Scene_"+version+"_window.app");
  pathScene_fullscreen = (sketchPath("") + "sources/Scene_"+version+"_fullscreen.app");

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
  text(nameVersion, pos_name_version.x, pos_name_version.y);
  textFont(EmigreEight,14);
  text("Version " +prettyVersion + "."+version, pos_pretty_version.x, pos_pretty_version.y);
  fill(grisClair) ;
  textFont(FuturaStencil,20);

  text("Choice                or ", pos_choice.x, pos_choice.y);
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







// LAUNCH
////////////
boolean openScene ;
// Scene launcher
void launchScene() {
  MiroirSetting = false ;
  SceneSetting = true ;
  fullscreen_or_window() ;
  //last step
  openScene = true ;
  launchApp() ;
  
}


void launchMiroir() {
  MiroirSetting = true ;
  SceneSetting = false ;
  fullscreen_or_window() ;
  addressLocal(pos_local_adress.x,pos_local_adress.y) ;
  //last step
  launchApp() ;
}




// choice your display WINDOW or FULLSCREEN
void fullscreen_or_window() {
  buttonWindow.displayButton() ;
  if(screenNum > 1 ) buttonFullscreen.displayButton() ;
  
  if (buttonWindow.OnOff) {
    pathScene = pathScene_window ;
    screen = ("false") ; 
  } else if (buttonFullscreen.OnOff) {
    pathScene = pathScene_fullscreen ;
    screen = ("true") ;
  }
  if (buttonFullscreen.OnOff) {
    choice_screen_for_full_screen() ;
  } else if (buttonWindow.OnOff) {
    screen = ("false") ;
    sizeWindow() ;
  }
}


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
void openApp() {
  launch(pathScene) ;
}



// END LAUNCH 
/////////////////

















// SAVE DISPLAY PROPERTY
////////////////////////
Table sceneProperty;
String pathScenePropertySetting = sketchPath("")+"sources/preferences/sceneProperty.csv" ;

void saveProperty() {
  sceneProperty = new Table();
  String colOne =("fullscreen");
  String colTwo =("whichScreen");
  String colThree =("resizable"); // obsolete
  String colFour =("decorated"); // obsolete
  String colFive =("width");
  String colSix =("height");
  String colSeven =("render"); // obsolete
  String colHeight =("miroir");
  
  sceneProperty.addColumn(colOne);
  sceneProperty.addColumn(colTwo);
  sceneProperty.addColumn(colThree); // obsolete
  sceneProperty.addColumn(colFour); // obsolete
  sceneProperty.addColumn(colFive);
  sceneProperty.addColumn(colSix);
  sceneProperty.addColumn(colSeven); // obsolete
  sceneProperty.addColumn(colHeight);
  
  TableRow newRow = sceneProperty.addRow();
  int whichScreen = 0 ;
  whichScreen = IDscreenSelected() ;
  
  newRow.setString(colOne, screen);
  newRow.setInt(colTwo, whichScreen);
  newRow.setString(colThree, "true"); // obsolete
  newRow.setString(colFour, "true"); // obsolete
  newRow.setInt(colFive, standardSizeWidth[widthSlider-1]);
  newRow.setInt(colSix, standardSizeHeight[heightSlider -1]);
  newRow.setString(colSeven, "P3D"); // obsolete
  newRow.setString(colHeight, whichAppOpeningTheScene);
  //
  saveTable(sceneProperty, pathScenePropertySetting);
}
// END SAVE PROPERTY
////////////////////













// ADDRESS IP for MIROIR
////////////////////////
void addressLocal(float x, float y) {
  fill(orange) ;
  try {
    fill(grisClair) ;
    text("local address", x,y ) ;
    text (java.net.InetAddress.getLocalHost().getHostAddress(), x+188,y) ;
  }
  catch(Exception e) {}
}
// END ADDRESS IP
//////////////////


















// SIZE WINDOW
////////////////
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

// END SIZE WINDOW
//////////////////
















// WHICH SCREEN
//////////////
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

void choice_screen_for_full_screen() {
/**
    // With Processing 3.0b7 we cannot use this method to choose on which screen display the full screen
    // On which screen display the window
    fill(orange) ;
    text("on screen", 10.0, 120.0);
    whichScreenDraw() ;
    */
    /**
    // Instead to use fullscreen method choice, we say is always true
    */
    buttonWhichScreenOnOff = 1 ;
}


void whichScreenDraw() {
  for(int i = 0 ; i <screenNum ; i++) {
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
    if (whichScreenButton[i].OnOff == true ) IDscreen = i+1 ; else IDscreen = 1 ;
  }
  return IDscreen ;
}

// END CHOICE SCREEN
////////////////////