//COLOR for internal use
color fond ;
color rouge, orange, jaune, vert, bleu, noir, blanc, gris  ;

void colorSetup() {
  rouge = color(10,100,100);
  orange = color(25,100,100);
  jaune = color(50,100,100) ;
  vert = color(150,100,100);
  bleu = color(235,100,100);
  noir = color(10,100,0);
  gris = color(10,50,50);
  blanc = color(0,0,100);
}

//ROLLOVER TEXT ON BACKGROUNG CHANGE
color colorW ;
//
color colorWrite(color colorRef, int threshold, color clear, color deep) {
  if( brightness( colorRef ) < threshold ) {
    colorW = color(clear) ;
  } else {
    colorW = color(deep) ;
  }
  return colorW ;
}
//END COLOR
///////////



//DRAWING
//CROSS
void crossPoint(PVector pos, color colorCross, int e, int size) {
  stroke(colorCross) ;
  strokeWeight(e) ;
  
  line(pos.x, pos.y -size, pos.x, pos.y +size) ;
  line(pos.x +size, pos.y, pos.x -size, pos.y) ;
}
// other cross
void crossPoint(PVector pos, PVector size, color colorCross, float e ) {
  if (e <0.1) e = 0.1 ;
  stroke(colorCross) ;
  strokeWeight(e) ;
  //horizontal
  line(pos.x, pos.y -size.x, pos.x, pos.y +size.x) ;
  //vertical
  line(pos.x +size.y, pos.y, pos.x -size.y, pos.y) ;
}
//



//curtain
void curtain() {
  // we must put a security for the rideau, if not there is bug sometime and the rideau appear we don't know why
  if( eCurtain == 1 ) {
    rectMode(CORNER) ;
   //  float rideau = map(valueSlider[7], 0, 55, 0,100) ; 
    float rideau = 100 ; 
    fill (0, rideau ) ; 
    noStroke() ;
    rect(-1,-1, width+2, height+2);
    fill(75, rideau) ;
    textSize(36) ;
    textFont(ContainerRegular) ;
   // text("ENTRACTE", width /4, height /3) ; 
  }
}
//end curtain

//END DRAWING
////////////



////////////////////////////////////
//CURSOR, MOUSE, TABLET, LEAP MOTION
//GLOBAL
Tablet tablet;

//SETUP
void cursorSetup() {
  //LEAP MOTION
  leap = new com.leapmotion.leap.Controller();
  //TABLET
  tablet = new Tablet(this);
  for (int i = 0 ; i < numObj ; i++ ) {
    pen[i] = new PVector(0,0,0) ;
    mouse[i] = new PVector(0,0) ;
    pmouse[i] = new PVector(0,0) ;
    wheel[i] = 0 ;
  }
}

//DRAW
int speedWheel = 5 ;
void cursorDraw() {
    //mousePressed
  if( clickShortLeft[0] || clickShortRight[0] || clickLongLeft[0] || clickLongRight[0] ) mousepressed[0] = true ; else mousepressed[0] = false ;
  //check the tablet
  pen[0] = new PVector (norm(tablet.getTiltX(),0,1), norm(tablet.getTiltY(),0,1), tablet.getPressure()) ;
  //check the leapmotion
  if (fingerCheck() ) {
    if (fingersNum() < 2 ) mouse[0] = new PVector(averageFingersPosition(true).x, averageFingersPosition(true).y, averageFingersPosition(true).z ) ; else mouse[0] = mouse [0] ;
  } else {
    mouse[0] = new PVector(mouseX, mouseY ) ; 
    pmouse[0] = new PVector(pmouseX, pmouseY ) ;
  }
  //re-init the wheel value to be sure this one is stopped
  wheel[0] = 0 ;
  //re-init the mouse button for the short click
  clickShortLeft[0] = false ; 
  clickShortRight[0] = false ;
  //why this line is here ????
  if (nextPrevious) nextPreviousInt = 1 ; else nextPreviousInt = 0 ;
}


//CURSOR DISPLAY
//GLOBAL
boolean cursorDisplay = false ;
//SHOW CURSOR
void cursorDisplay() {
  //check if we must display the cursor or not
  if (keyPressed == true && !cursorDisplay && key == 'c'   ) cursorDisplay = true ;
  else if ( keyPressed == true && cursorDisplay && key == 'c' ) cursorDisplay = false;
  //display cursor
  if (cursorDisplay) {
    PVector cursorPos = new PVector (mouseX, mouseY) ;
    color colorCursor = color( 0) ;
    int eCursor = 1 ;
    int sizeCursor = 5 ;
    crossPoint(cursorPos, colorCursor, eCursor, sizeCursor) ;
  }
}


//LEAP MOTION
void leapFingerSingleInfo() {
  InteractionBox iBox = leap.frame().interactionBox();
  PointableList objectNum = leap.frame().pointables();
  
  for(int p = 0; p < objectNum.count(); p++) {
    //initialization
    Pointable object = objectNum.get(p);
    com.leapmotion.leap.Vector normPos = iBox.normalizePoint(object.stabilizedTipPosition());
    //return the ID
    int objectID = object.id()  ;
    
    //3D position
    float posX = normPos.getX() * width;
    float posY = height - normPos.getY() * height;
    int depth = (width + height) / 4 ;
    float posZ = map(normPos.getZ(), 0,1, -depth, depth) ;
    //put position info in PVector
    PVector pos = new PVector (posX, posY, posZ ) ;
    
    //info 
    float magnitudeObject = normPos.magnitude() ;
    //horizontal orientation
    int rollObject = (int)map(normPos.roll(), 0, PI, 280,-80) ;
    //vertical orientation
    int pitchObject = (int)map(normPos.pitch(), 0, PI, 280,-80) ;
    //assiette
    int yawObject = (int)map(normPos.yaw(), 0, PI, 280,-80) ;
    
    //display info
    pushMatrix() ;
    translate(pos.x, pos.y, pos.z) ;
    rotateX(radians(-pitchObject)) ;
    rotateY(radians(-rollObject)) ;
    rotateZ(radians(yawObject)) ;

    fill(blanc) ;
    text("My name is " + objectID, 0, 0) ;
    fill(rouge) ;
    text("my position is " + (int)pos.x + " / " + (int)pos.y + " / " + (int)pos.z, 0,12) ;
    text("my XXX oriantation " + pitchObject+"°", 0,24) ;
    text("my YYY oriantation " + rollObject+"°", 0,36) ;
    text("my ZZZ oriantation " + yawObject+"°", 0,48) ;
    String mag = String.format("%.5f", magnitudeObject) ;
    text("my magnitude " + mag, 0,60) ;
    popMatrix() ;
  }
}

void leapFingerAverageInfo() {
  //average fingers info position
    
    pushMatrix() ;
    translate(averageFingersPosition(true).x, averageFingersPosition(true).y,averageFingersPosition(true).z ) ;
    fill(blanc) ;
    text("Average position fingers", 0,0 ) ;
    fill(rouge) ;
    text("my position is " + (int)averageFingersPosition(true).x + " / " + (int)averageFingersPosition(true).y + " / " + (int)averageFingersPosition(true).z, 0,12) ;
    
    popMatrix() ;
}



PVector averageFingersPosition(boolean leapMotionConnected) {
  if(leapMotionConnected) {
    InteractionBox iBox = leap.frame().interactionBox();
    PointableList objectNum = leap.frame().pointables();
    
    PVector averagePosOfTheFinger = new PVector (0,0,0) ;
    
    for(int p = 0; p < objectNum.count(); p++)
    {
      //initialization
      Pointable object = objectNum.get(p);
      com.leapmotion.leap.Vector normPos = iBox.normalizePoint(object.stabilizedTipPosition());
      //return the ID
      // int objectID = object.id()  ;
      
      //3D position
      float posX = normPos.getX() * width;
      float posY = height - normPos.getY() * height;
      int depth = (width + height) / 4 ;
      float ratioZoom = 1.0 ;
      float posZ = map(normPos.getZ(), 1,0, -depth *ratioZoom, depth *ratioZoom) ;
      //put position info in PVector
      PVector pos = new PVector (posX, posY, -posZ) ;
      
      //add pos finger by finger
      averagePosOfTheFinger.add(pos) ;
      
    }
    //calculate the average position of all the fingers
    // security, in case all the finger is equal to zero
    if(averagePosOfTheFinger.x <= 0 ) averagePosOfTheFinger.x = 0.0001 ; 
    if(averagePosOfTheFinger.y <= 0 ) averagePosOfTheFinger.y = 0.0001 ; 
    if(averagePosOfTheFinger.x != 0 || averagePosOfTheFinger.x != 0  ) averagePosOfTheFinger.div(objectNum.count()) ;
    
    return averagePosOfTheFinger ;
  } else {
    //leapMotion is not active
    PVector averagePosOfTheFinger = new PVector (mouseX,mouseY,0) ;
    return averagePosOfTheFinger ;
  }
}


//return the num of finger
int fingersNum() {
  int num ;
  // InteractionBox iBox = leap.frame().interactionBox();
  PointableList objectNum = leap.frame().pointables();
  num = objectNum.count() ;
  return num ;
}


//check is there is Finger in the field
boolean fingerCheck() {
  Boolean testFingerLeap ;
  //InteractionBox iBox = leap.frame().interactionBox();
  PointableList objectNum = leap.frame().pointables();
  // PointableList objectNum = leap.frame().isValid();
  if (objectNum.isEmpty()) testFingerLeap  = false ; else testFingerLeap  = true ;
  return testFingerLeap  ;
}
//END LEAP MOTION


////////////////////////////////////////
//END CURSOR, MOUSE, TABLET, LEAP MOTION





/////////////
//BACKGROUND
/////////////
int artificialTime ;
//FOND
void backgroundRomanesco() {
  color bg ;
  //to smooth the curve of transparency background
  float facteur = 2.5 ;
  // float homothety = 100.0 ;
  float nx = norm(valueSlider[0][3], 0.0 , 100.0) ;
  float ny = pow (nx ,facteur );
  ny = map(ny, 0, 1 , 0.8, 100 ) ;
  
  bg = color (map(valueSlider[0][0],0,100,0,360), valueSlider[0][1], valueSlider[0][2], ny ) ; 
  //choice the background
  if(displayMode.equals("Classic")) backgroundClassic(bg) ;
  else if(displayMode.equals("P3D")) backgroundP3D(bg) ;
}


void backgroundRomanescoPrescene() {
  color bg ;
  bg = color (map(valueSlider[0][0],0,100,0,360), valueSlider[0][1], valueSlider[0][2], 100 ) ;
    //choice the background
  if(displayMode.equals("Classic")) backgroundClassic(bg) ;
  else if(displayMode.equals("P3D")) backgroundP3D(bg) ;
}


//diffenrent background
void backgroundClassic(color c) {
  //DISPLAY FINAL
  noStroke() ;
  fill(c) ;
  rect (0,0, width, height) ;
}

//P3D
//BACKGROUND
////////////
PVector sizeBG ;
void backgroundP3D(color c) {
  fill(c) ;
  noStroke() ;
  pushMatrix() ;
  sizeBG = new PVector(width *100, height *100, height *7) ;
  translate(-sizeBG.x *.5,-sizeBG.y *.5 , -sizeBG.z) ;
  rect(0,0, sizeBG.x,sizeBG.y) ;
  popMatrix() ;
}
//END BACKGROUND













// DETECTION
/////////////
//CIRLCLE
boolean insideCircle (PVector pos, int diam) {
  if (dist(pos.x, pos.y, mouse[0].x,  mouse[0].y) < diam) return true  ; else return false ;
}

//RECTANGLE
boolean insideRect(PVector pos, PVector size) { 
    if(mouse[0].x > pos.x && mouse[0].x < pos.x + size.x && mouse[0].y >  pos.y && mouse[0].y < pos.y + size.y) return true ; else return false ;
}

//LOCKED
boolean locked ( boolean inside )  {
  if ( inside  && mousepressed[0] ) return true ; else return false ;
}
//END DETECTION
//////////////















//////
//TIME
int minClock() {
  return hour()*60 + minute() ;
}


//timer
int chrnmtr, chronometer, newChronometer ;

int timer(float tempo) {
  int translateTempo = int(1000 *tempo) ;
  newChronometer = millis()%translateTempo ;
  if (  chronometer > newChronometer ) {
    chrnmtr += 1  ;
  }
  chronometer = newChronometer ;
  return chrnmtr ;
}

//cycle
float totalCycle ;
float cycle(float add) {
  totalCycle += add ; // choice here the speed of the cycle

  return sin(totalCycle)  ;
}

//END TIME
//////////





////////////////////////////////////////////////////////////
//MISC // MISC // MISC // MISC //


//file name for save
String nameNumber(String name) {
  String numPict ;
  int year = year() -2000 ;
  String newYear = String.valueOf(year) ;
  String newMonth = String.valueOf(month()) ;
  String newDay = String.valueOf(day()) ;
  
  String newSecond = String.valueOf((hour() *60 *60) + (minute() *60 ) + second()) ;
  numPict = (name + newYear + "_" + newMonth + "_" + newDay + "_" +newSecond) ;
  
  return numPict ;
}



//easing
////////
PVector targetIN = new PVector () ;
//Pen
PVector easingIN = new PVector () ;
//
PVector easing(PVector targetOUT, float effectOUT) {
  targetIN.x = targetOUT.x;
  float dx = targetIN.x - easingIN.x;
  if(abs(dx) > 1) {
    easingIN.x += dx * effectOUT;
  }
  
  targetIN.y = targetOUT.y;
  float dy = targetIN.y - easingIN.y;
  if(abs(dy) > 1) {
    easingIN.y += dy * effectOUT;
  }
  return easingIN ;
}
//
void resetEasing(PVector targetOUT) {
  easingIN.x = targetOUT.x ; easingIN.y = targetOUT.y ;
}
//end easing





//zoom
//with the wheel mouse
private float getCountZoom ;
void zoom() { getCountZoom = wheel[0] ; }
//end zoom



//////////////////
//tracking with pad
void nextPreviousKeypressed() {
    //tracking
  nextPrevious = true ;
}
//
int tracking(int t, int n) {
  if (nextPrevious) {
    if (downTouch && t < n-1 ) {
      trackerUpdate = +1 ;
    } else if (upTouch  && t > 0 ) {
      trackerUpdate = -1 ;
    } 
  }
  if (nextPrevious) {
    if ( leftTouch  && t > 0 ) {
      trackerUpdate = -1 ;
    } else if ( rightTouch && t < n-1 ) {
      trackerUpdate = +1 ;
    }
  }
  nextPrevious = false ;
  return trackerUpdate ;
}
//END nextPrevious


//////////////////////////////////////////
//END MISC MISC // MISC // MISC // MISC //
//////////////////////////////////////////














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
  colorMode(HSB, HSBmode.x, HSBmode.y, HSBmode.z, 100) ;

  loadPropertyPrescene() ;
  sizePrescene() ;
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


















///////////////////////////////////////////
//TRANSLATOR INT to String, FLOAT to STRING
//truncate
float truncate( float x ) {
    return round( x * 100.0f ) / 100.0f;
}
//Int to String with array list
String joinIntToString(int []data) {
  String intString ;
  String [] dataString = new String [data.length] ;
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = Integer.toString(data[i]) ;
  intString = join(dataString,"/") ;
  
  return intString ;
}

//float to String with array list
String joinFloatToString(float []data) {
  String floatString ;
  String [] dataString = new String [data.length] ;
  //for ( int i = 0 ; i < data.length ; i++) dataString[i] = Float.toString(data[i]) ;
  //we must use just one decimal after coma, to dodge the outBoundIndex blablabla
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = String.format("%.1f" ,data[i]) ;
  floatString = join(dataString,"/") ;
  
  return floatString ;
}

//Translater to String
String FloatToString(float data) {
  String newData ;
  newData = String.format("%.1f", data ) ;
  return newData ;
}
//
String FloatToStringWithThree(float data) {
  String newData ;
  newData = String.format("%.3f", data ) ;
  return newData ;
}
//
String IntToString(int data) {
  String newData ;
  newData = Integer.toString(data ) ;
  return newData ;
}
//END TRANSLATOR
///////////////




//////////
//KEYBOARD

//short Touch
boolean aTouch, bTouch, cTouch, dTouch, eTouch, fTouch, gTouch, hTouch, iTouch, jTouch, kTouch, lTouch, mTouch, nTouch, oTouch, pTouch, qTouch, rTouch, sTouch, tTouch, uTouch, vTouch, wTouch, xTouch, yTouch, zTouch,
        leftTouch, rightTouch, upTouch, downTouch, 
        touch0, touch1, touch2, touch3, touch4, touch5, touch6, touch7, touch8, touch9, 
        backspaceTouch, deleteTouch, enterTouch, returnTouch, shiftTouch, altTouch, escTouch, ctrlTouch ;
//long touch
boolean spaceTouch,  cLongTouch, nLongTouch, vLongTouch ;        
        
        
void keyboardTrue() {
  if (key == ' ' ) spaceTouch = true ; 
  
  if (key == 'a'  || key == 'A' ) aTouch = true ;
  if (key == 'b'  || key == 'B' ) bTouch = true ;
  if (key == 'c'  || key == 'C' ) { cTouch = true ; cLongTouch = true ; }
  if (key == 'd'  || key == 'D' ) dTouch = true ;
  if (key == 'e'  || key == 'E' ) eTouch = true ;
  if (key == 'f'  || key == 'F' ) fTouch = true ;
  if (key == 'g'  || key == 'G' ) gTouch = true ;
  if (key == 'h'  || key == 'H' ) hTouch = true ;
  if (key == 'i'  || key == 'I' ) iTouch = true ;
  if (key == 'j'  || key == 'J' ) jTouch = true ;
  if (key == 'k'  || key == 'K' ) kTouch = true ;
  if (key == 'l'  || key == 'L' ) lTouch = true ;
  if (key == 'm'  || key == 'M' ) mTouch = true ;
  if (key == 'n'  || key == 'N' ) { nTouch = true ; nLongTouch = true ; }
  if (key == 'o'  || key == 'O' ) oTouch = true ;
  if (key == 'p'  || key == 'P' ) pTouch = true ;
  if (key == 'q'  || key == 'Q' ) qTouch = true ;
  if (key == 'r'  || key == 'R' ) rTouch = true ;
  if (key == 's'  || key == 'S' ) sTouch = true ;
  if (key == 't'  || key == 'T' ) tTouch = true ;
  if (key == 'u'  || key == 'U' ) uTouch = true ;
  if (key == 'v'  || key == 'V' ) { vTouch = true ; vLongTouch = true ; }
  if (key == 'w'  || key == 'W' ) wTouch = true ;
  if (key == 'x'  || key == 'X' ) xTouch = true ;
  if (key == 'y'  || key == 'Y' ) yTouch = true ;
  if (key == 'z'  || key == 'Z' ) zTouch = true ;
  
  if (key == '0' ) touch0 = true ;
  if (key == '1' ) touch1 = true ;
  if (key == '2' ) touch2 = true ;
  if (key == '3' ) touch3 = true ;
  if (key == '4' ) touch4 = true ;
  if (key == '5' ) touch5 = true ;
  if (key == '6' ) touch6 = true ;
  if (key == '7' ) touch7 = true ;
  if (key == '8' ) touch8 = true ;
  if (key == '9' ) touch9 = true ;
  
  if( keyCode == BACKSPACE ) backspaceTouch = true ;
  if (keyCode == DELETE ) deleteTouch = true ;
  if( keyCode == SHIFT ) shiftTouch = true ;
  if( keyCode == ALT ) altTouch = true ;
  if( keyCode == RETURN ) returnTouch = true ;
  if( keyCode == ENTER ) enterTouch = true ;
  if( keyCode == CONTROL ) ctrlTouch = true ;
  
  if( keyCode == LEFT ) leftTouch = true ;
  if( keyCode == RIGHT ) rightTouch = true ;
  if( keyCode == UP ) upTouch = true ;
  if( keyCode == DOWN ) downTouch = true ;
}

void keyboardLongFalse() {
  if (key == ' ' ) spaceTouch = false ; 
  if (key == 'c'  || key == 'C' ) cLongTouch = false ;
  if (key == 'n'  || key == 'N' ) nLongTouch = false ;
  if (key == 'v'  || key == 'V' ) vLongTouch = false ;
}


void keyboardFalse() {
  // check for the key and put false here, but it's less reactive that put false just after the use the boolean...here you display false three time !
  if(aTouch) aTouch = false ; 
  if(bTouch) bTouch = false ;
  if(cTouch) cTouch = false ;
  if(dTouch) dTouch = false ;
  if(eTouch) eTouch = false ;
  if(fTouch) fTouch = false ;
  if(gTouch) gTouch = false ;
  if(hTouch) hTouch = false ;
  if(iTouch) iTouch = false ;
  if(jTouch) jTouch = false ;
  if(kTouch) kTouch = false ;
  if(lTouch) lTouch = false ;
  if(mTouch) mTouch = false ;
  if(nTouch) nTouch = false ;
  if(oTouch) oTouch = false ;
  if(pTouch) pTouch = false ;
  if(qTouch) qTouch = false ;
  if(rTouch) rTouch = false ;
  if(sTouch) sTouch = false ;
  if(tTouch) tTouch = false ;
  if(uTouch) uTouch = false ;
  if(vTouch) vTouch = false ;
  if(wTouch) wTouch = false ;
  if(xTouch) xTouch = false ;
  if(yTouch) yTouch = false ;
  if(zTouch) zTouch = false ;
  
  if(touch0) touch0 = false ;
  if(touch1) touch1 = false ;
  if(touch2) touch2 = false ;
  if(touch3) touch3 = false ;
  if(touch4) touch4 = false ;
  if(touch5) touch5 = false ;
  if(touch6) touch6 = false ;
  if(touch7) touch7 = false ;
  if(touch8) touch8 = false ;
  if(touch9) touch9 = false ;
  
  if (backspaceTouch) backspaceTouch = false ;
  if (deleteTouch) deleteTouch = false ; 
  if (enterTouch) enterTouch = false ;
  if (returnTouch) returnTouch = false ;
  if (shiftTouch) shiftTouch = false ;
  if (altTouch) altTouch = false ; 
  if (escTouch) escTouch = false ;
  if (ctrlTouch) ctrlTouch = false ;
  
  if(upTouch ) upTouch = false ;
  if(downTouch) downTouch = false ;
  if (leftTouch) leftTouch = false ;
  if (rightTouch ) rightTouch = false ;

}
//END KEYBOARD
//////////////





////////////////////////
// FONT and TEXT MANAGER

//FONT
PFont SansSerif10,

      AmericanTypewriter, AmericanTypewriterBold,
      Banco, 
      ContainerRegular, Cinquenta,
      Diesel,
      Digital, 
      DinRegular10 ,DinRegular, DinBold,
      EastBloc,
      FetteFraktur, FuturaStencil,
      GangBangCrime,
      Juanita, JuanitaOutline,
      Komikahuna,
      Mesquite,
      Minion, MinionBold,
      NanumBrush, 
      Rosewood,
      TheHardwayRMX,
      TokyoOne, TokyoOneSolid ;
      


      
//SETUP
void fontSetup() {
  String fontPathVLW = sketchPath("")+"preferences/Font/typoVLW/" ;

  //write font path
  pathFontVLW[1] = (fontPathVLW+"AmericanTypewriter-96.vlw");
  pathFontVLW[2] = (fontPathVLW+"AmericanTypewriter-Bold-96.vlw");
  pathFontVLW[3] = (fontPathVLW+"BancoITCStd-Heavy-96.vlw");
  pathFontVLW[4] = (fontPathVLW+"CinquentaMilMeticais-96.vlw");
  pathFontVLW[5] = (fontPathVLW+"Container-Regular-96.vlw");
  pathFontVLW[6] = (fontPathVLW+"Diesel-96.vlw");
  pathFontVLW[7] = (fontPathVLW+"Digital2-96.vlw");
  pathFontVLW[8] = (fontPathVLW+"DIN-Regular-96.vlw");
  pathFontVLW[9] = (fontPathVLW+"DIN-Bold-96.vlw");
  pathFontVLW[10] = (fontPathVLW+"EastBlocICGClosed-96.vlw");
  pathFontVLW[11] = (fontPathVLW+"FuturaStencilICG-96.vlw");
  pathFontVLW[12] = (fontPathVLW+"FetteFraktur-96.vlw");
  pathFontVLW[13] = (fontPathVLW+"GANGBANGCRIME-96.vlw");
  pathFontVLW[14] = (fontPathVLW+"JuanitaDecoITCStd-96.vlw");
  pathFontVLW[15] = (fontPathVLW+"Komikahuna-96.vlw");
  pathFontVLW[16] = (fontPathVLW+"MesquiteStd-96.vlw");
  pathFontVLW[17] = (fontPathVLW+"NanumBrush-96.vlw");
  pathFontVLW[18] = (fontPathVLW+"RosewoodStd-Regular-96.vlw");
  pathFontVLW[19] = (fontPathVLW+"3theHardwayRMX-96.vlw");
  pathFontVLW[20] = (fontPathVLW+"Tokyo-One-96.vlw");
  pathFontVLW[21] = (fontPathVLW+"MinionPro-Regular-96.vlw");
  pathFontVLW[22] = (fontPathVLW+"MinionPro-Bold-96.vlw");
  //special font
  pathFontVLW[49] = (fontPathVLW+"DIN-Regular-10.vlw");
  SansSerif10 = loadFont(fontPathVLW+"SansSerif-10.vlw") ;
  
  //write font path for TTF
  String prefixTTF = (sketchPath("")+"preferences/Font/typoTTF/") ;
  //by default
  pathFontTTF[0] = (prefixTTF+"FuturaStencil.ttf");
  //type
  pathFontTTF[1] = (prefixTTF+"AmericanTypewriter.ttf");
  pathFontTTF[2] = (prefixTTF+"AmericanTypewriter.ttf");
  pathFontTTF[3] = (prefixTTF+"Banco.ttf");
  pathFontTTF[4] = (prefixTTF+"Cinquenta.ttf");
  pathFontTTF[5] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[6] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[7] = (prefixTTF+"Digital2.ttf");
  pathFontTTF[8] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[9] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[10] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[11] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[12] = (prefixTTF+"FetteFraktur.ttf");
  pathFontTTF[13] = (prefixTTF+"GangBangCrime.ttf");
  pathFontTTF[14] = (prefixTTF+"JuanitaITC.ttf");
  pathFontTTF[15] = (prefixTTF+"Komikahuna.ttf");
  pathFontTTF[16] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[17] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[18] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[19] = (prefixTTF+"3Hardway.ttf");
  pathFontTTF[20] = (prefixTTF+"FuturaStencil.ttf");
  pathFontTTF[21] = (prefixTTF+"MinionWebPro.ttf");
  pathFontTTF[22] = (prefixTTF+"MinionWebPro.ttf");
  //special font
  pathFontTTF[49] = (prefixTTF+"FuturaStencil.ttf");

  //load
  AmericanTypewriter=loadFont      (pathFontVLW[1]);
  AmericanTypewriterBold=loadFont  (pathFontVLW[2]);
  Banco=loadFont                   (pathFontVLW[3]);
  Cinquenta=loadFont               (pathFontVLW[4]);
  ContainerRegular=loadFont        (pathFontVLW[5]);
  Diesel=loadFont                  (pathFontVLW[6]);
  Digital=loadFont                 (pathFontVLW[7]);
  DinRegular=loadFont              (pathFontVLW[8]);
  DinBold=loadFont                 (pathFontVLW[9]);
  EastBloc=loadFont                (pathFontVLW[10]);
  FuturaStencil=loadFont           (pathFontVLW[11]);
  FetteFraktur=loadFont            (pathFontVLW[12]);
  GangBangCrime=loadFont           (pathFontVLW[13]);
  JuanitaOutline=loadFont          (pathFontVLW[14]);
  Komikahuna=loadFont              (pathFontVLW[15]);
  Mesquite=loadFont                (pathFontVLW[16]);
  NanumBrush=loadFont              (pathFontVLW[17]);
  Rosewood=loadFont                (pathFontVLW[18]);
  TheHardwayRMX=loadFont           (pathFontVLW[19]);
  TokyoOne=loadFont                (pathFontVLW[20]);
  Minion=loadFont                  (pathFontVLW[21]);
  MinionBold=loadFont              (pathFontVLW[22]);

  //default and special font
  DinRegular10=loadFont            (pathFontVLW[49]);

  font[0] = FuturaStencil ;
  pathFontObjTTF[0] = pathFontTTF[0] ;
}




void whichFont( int whichFont)  { 
  if (whichFont == 1 )     { pathFontObjTTF[0] = pathFontTTF[1] ; font[0] = AmericanTypewriter ;  }
  else if (whichFont ==2 ) { pathFontObjTTF[0] = pathFontTTF[2] ; font[0] = AmericanTypewriterBold ; }
  else if (whichFont == 3) { pathFontObjTTF[0] = pathFontTTF[3] ; font[0] = Banco ; }
  else if (whichFont ==4)  { pathFontObjTTF[0] = pathFontTTF[4] ; font[0] = Cinquenta ; }
  else if (whichFont ==5)  { pathFontObjTTF[0] = pathFontTTF[5] ; font[0] = ContainerRegular ; }
  else if (whichFont ==6)  { pathFontObjTTF[0] = pathFontTTF[6] ; font[0] = Diesel ; }
  else if (whichFont ==7)  { pathFontObjTTF[0] = pathFontTTF[7] ; font[0] = Digital ; }
  else if (whichFont ==8)  { pathFontObjTTF[0] = pathFontTTF[8] ; font[0] = DinRegular ; }
  else if (whichFont ==9)  { pathFontObjTTF[0] = pathFontTTF[9] ; font[0] = DinBold ; }
  else if (whichFont ==10) { pathFontObjTTF[0] = pathFontTTF[10] ; font[0] = EastBloc ; }
  else if (whichFont ==11) { pathFontObjTTF[0] = pathFontTTF[11] ; font[0] = FetteFraktur ; }
  else if (whichFont ==12) { pathFontObjTTF[0] = pathFontTTF[12] ; font[0] = FuturaStencil ; }
  else if (whichFont ==13) { pathFontObjTTF[0] = pathFontTTF[13] ; font[0] = GangBangCrime ; }
  else if (whichFont ==14) { pathFontObjTTF[0] = pathFontTTF[14] ; font[0] = JuanitaOutline ; }   
  else if (whichFont ==15) { pathFontObjTTF[0] = pathFontTTF[15] ; font[0] = Komikahuna ; }
  else if (whichFont ==16) { pathFontObjTTF[0] = pathFontTTF[16] ; font[0] = Mesquite ; }
  else if (whichFont ==17) { pathFontObjTTF[0] = pathFontTTF[17] ; font[0] = Minion ; }
  else if (whichFont ==18) { pathFontObjTTF[0] = pathFontTTF[18] ; font[0] = MinionBold ; }
  else if (whichFont ==19) { pathFontObjTTF[0] = pathFontTTF[19] ; font[0] = NanumBrush ; }
  else if (whichFont ==20) { pathFontObjTTF[0] = pathFontTTF[20] ; font[0] = Rosewood ; }
  else if (whichFont ==21) { pathFontObjTTF[0] = pathFontTTF[21] ; font[0] = TheHardwayRMX ; }
  else if (whichFont ==22) { pathFontObjTTF[0] = pathFontTTF[22] ; font[0] = TokyoOne ; } 
  else                     { pathFontObjTTF[0] = pathFontTTF[49]  ; font[0] = AmericanTypewriter ; }
}
//END FONT


//TEXT
String importRaw [] ;
String  textRaw ;
String [][] sentencesByChapter ;

void importText(String path) {
  importRaw = loadStrings(path) ;
  textRaw = join(importRaw, "") ;
}

void splitText() {
  String karaokeChapters [] = split(textRaw, "*") ;
  
  // find the quantity of chapter and sentences by chapter to create the final double array String
  int numChapter = karaokeChapters.length ;
  int maxSentencesByChapter = 0 ;  
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(karaokeChapters[i], "/") ;
    if ( sentences.length > maxSentencesByChapter ) maxSentencesByChapter = sentences.length ; 
  }
  //create the final double array string
  sentencesByChapter = new String [numChapter][maxSentencesByChapter] ;
  //put the sentences in the double String by chapter
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(karaokeChapters[i], "/") ;
    for ( int j = 0 ; j <  sentences.length ; j++) {
      sentencesByChapter [i][j] = sentences[j] ;
    }
  }
}
// END TEXT
//////////

// END FONT and TEXT MANAGER
////////////////////////////





//////////////
//DISPLAY INFO
boolean displayInfo, displayInfo3D ;
int posInfoObj = 2 ;

void info () {
    //check the keyboard
  if (iTouch) displayInfo = !displayInfo ;
  if (gTouch) displayInfo3D = !displayInfo3D ;
  //display info
  if (displayInfo) displayInfoScene() ;
  if ( modeP3D && displayInfo3D) displayInfo3D() ;
}

void displayInfoScene() {
  noStroke() ;
  fill(0,100,0, 50) ;
  rectMode(CORNER) ;
  rect(0,-5,width, 15*posInfoObj) ;
  posInfoObj = 2 ;
  fill(0,0,100) ;
  textFont(SansSerif10, 10) ;
  //INFO SIZE and RENDERER
  String displayModeInfo ;
  if (displayMode.equals("Classic") ) displayModeInfo = ("classic") ; else displayModeInfo = displayMode ;
  if (img != null ) text ("Scène width " + width + " height" + height + " image width "+ img.width + "height"+ img.height + "    render mode" + displayModeInfo + "    FrameRate " + frameRate, 15,15 ) ; 
  else text("Scène width " + width + "height" + height + "   render mode " + displayModeInfo + "    FrameRate " + frameRate, 15,15) ;
  //INFO MOUSE and PEN
  text("position X " + mouseX + "  position Y " + mouseY + "  molette " + wheel[0] + "    pen orientation " + (int)deg360(pen[0]) +"°   stylet pressur " + int(pen[0].z *10),15, 15 * (posInfoObj) ) ;  
  posInfoObj += 1 ;
  //INFO SOUND
  if (getTimeTrack() > 1 ) text("the track play until " +getTimeTrack() + "  Tempo " + getTempoRef() , 15,15 *(posInfoObj)) ; else text("no track detected ", 15, 15 *(posInfoObj)) ;
  posInfoObj += 1 ;
  text("right" +int(input.right.get(1) *100) + "  left " + int(input.left.get(1) *100) , 15,15 *(posInfoObj)) ; 

  posInfoObj += 1 ;
}
////////////////
//END DISPLAY INFO














//////
//P3D

//REPERE 3D
void repere(int size, PVector pos, String name) {
  pushMatrix() ;
  translate(pos.x +20 , pos.y -20, pos.z) ;
  fill(blanc) ;
  text(name, 0,0) ;
  popMatrix() ;
  line(-size +pos.x,pos.y, pos.z,size +pos.x, pos.y, pos.z) ;
  line(pos.x,-size +pos.y, pos.z, pos.x,size +pos.y, pos.z) ;
  line(pos.x, pos.y,-size +pos.z, pos.x, pos.y,size +pos.z) ;
}
//repere cross
void repere(int size) {
  line(-size,0,0,size,0,0) ;
  line(0,-size,0,0,size,0) ;
  line(0,0,-size,0,0,size) ;
}

//repere camera
void repereCamera(PVector size) {
  if(modeP3D && displayInfo3D )  {
    size.x = size.x *.1 ;
    size.y = size.y *.1 ;
    
    color xColor = rouge ;
    color yColor = vert ;
    color zColor = jaune ;
    int posTxt = 10 ;
    textFont(SansSerif10, 10) ;
    
    
    //GRID
    grid(size) ;
    //AXES
    strokeWeight(.2) ;
    // X LINE
    fill(xColor) ;
    text("X LINE XXX", posTxt,-posTxt) ;
    stroke(xColor) ; noFill() ;
    line(-size.x,0,0,size.x,0,0) ;
    
    // Y LINE
    fill(yColor) ;
    pushMatrix() ;
    rotateZ(radians(-90)) ;
    text("Y LINE YYY", posTxt,-posTxt) ;
    popMatrix() ;
    stroke(yColor) ; noFill() ;
    line(0,-size.y,0,0,size.y,0) ;
    
    // Z LINE
    fill(zColor) ;
    pushMatrix() ;
    rotateY(radians(90)) ;
    text("Z LINE ZZZ", posTxt,-posTxt) ;
    popMatrix() ;
    stroke(zColor) ; noFill() ;
    line(0,0,-size.z,0,0,size.z) ;
  }
}


void grid(PVector s) {
  strokeWeight(.1) ;
  noFill() ;
  stroke(bleu) ;
  int sizeX = (int)s.z ;
  //horizontal grid
  for ( int i = -sizeX ; i<= sizeX ; i = i+10 ) {
    if(i != 0 ) line(i,0,-sizeX,i,0,sizeX) ;
  }
}
//END REPERE 3D


//END P3D
/////////
