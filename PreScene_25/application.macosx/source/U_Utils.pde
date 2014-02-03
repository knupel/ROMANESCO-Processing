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
  if( Erideau == 1 ) {
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
  //mouse
  mouse[0] = new PVector(0,0) ;
  pmouse[0] = new PVector(0,0) ;
  wheel[0] = 0 ;

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
  float nx = norm(valueSliderGlobal[3], 0.0 , 100.0) ;
  float ny = pow (nx ,facteur );
  ny = map(ny, 0, 1 , 0.8, 100 ) ;
  
  //meteo change
  if(Emeteo == 1 ) {
    int newPressure = hectoPascal(weather.getPressure()) ;
    color dayColor = color (map(weather.getTemperature(),-40,60,270,0), map(newPressure, 920, 1080, 0,100), 100, ny ) ;
    //color night = color ( 220, map(newPressure, 920, 1080, 0,100), 20, ny ) ;
    
    artificialTime += 1 ;
    if (artificialTime > 1440 ) artificialTime = 0 ;
    int weatherPressure = hectoPascal(weather.getPressure()) ;
    //the articicial time
    bg = color(meteoColor(dayColor, artificialTime, 120, weatherPressure ) );
    //the real one
    // fond = color(meteoColor(dayColor, minClock() ) );
  } else {
    bg = color (map(valueSliderGlobal[0],0,100,0,360), valueSliderGlobal[1], valueSliderGlobal[2], ny ) ; 
  }
  
  
  //choice the background
  if(displayMode.equals("Classic")) backgroundClassic(bg) ;
  else if(displayMode.equals("P3D")) backgroundP3D(bg) ;
}


void backgroundRomanescoPrescene() {
  color bg ;
  bg = color (map(valueSliderGlobal[0],0,100,0,360), valueSliderGlobal[1], valueSliderGlobal[2], 100 ) ;
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
//MATH
float perimeterCircle ( float r ) {
  //calcul du perimetre
  float p = r*TWO_PI  ;
  return p ;
}

//radius surface
float radiusSurface(int s) {
  // calcul du rayon par rapport au nombre de point
  float  r = sqrt(s/PI) ;
  return r ;
}
// normal direction 0-360 to -1, 1 PVector
PVector normalDir(int direction) {
  int numPoints = 360;
  float angle = TWO_PI/(float)numPoints;
  direction = 360-direction;
  direction += 180;
  return new PVector(sin(angle*direction), cos(angle*direction));
}
// degre direction from PVector direction
float deg360 (PVector dir) {
  float deg360 ;
  deg360 = 360 -(degrees(atan2(dir.x, dir.y)) +180)   ;
  return deg360 ;
}


//ROTATION
//GLOBAL
PVector resultPositionOfRotation = new PVector() ;
//DRAW

PVector rotation (PVector ref, PVector lattice, float angle) {
  
  float a = angle( lattice, ref ) + angle;
  float d = distance( lattice, ref );
  
  resultPositionOfRotation.x = lattice.x + cos( a ) * d;
  resultPositionOfRotation.y = lattice.y + sin( a ) * d;
  //
  return resultPositionOfRotation;
}

float angle( PVector p0, PVector p1 ) {
  return atan2( p1.y - p0.y, p1.x - p0.x );
}
  
float distance( PVector p0, PVector p1 ) {
  return sqrt( ( p0.x - p1.x ) * ( p0.x - p1.x ) + ( p0.y - p1.y ) * ( p0.y - p1.y ) );
}

//other Rotation
//Rotation Objet
void rotation ( float R, float posX, float posY ) {
  float rotation ;
  float angle  ;
  float vR = map (R, 0, 100, 0, -360 ) ; 
  rotation = vR ;
  angle = rotation ;
  translate(posX, posY ) ;
  rotate (radians(angle) ) ;
}
//END OF ROTATION

//END MATH
//////////






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


// drop event
void dropEvent(DropEvent theDropEvent) {
  // if the dropped object is an image, then load the image into our PImage.
  if(theDropEvent.isImage()) {
      escargotGOanalyze = false ;
      escargotClear() ;

   // println("### loading image ...");
    img = theDropEvent.loadImage();
    analyzeDone = false ;
  }
}
//end drop event


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
// boolean mode
boolean modeP3D ;

void displaySetup() {
  frameRate(30) ;  // Le frameRate doit être le même dans tous les Sketches
  //size and different property of scene : size, border, P2D, P3D...
  colorMode(HSB, HSBmode.x, HSBmode.y, HSBmode.z, 100) ;
  //load graphic configuration
  configurationScene = loadTable("setting/preSceneProperty.csv", "header");
  TableRow row = configurationScene.getRow(0);
  //fullscreen 
  if (row.getString("fullscreen").equals("TRUE") || row.getString("fullscreen").equals("true")) fullScreen = true ; else fullScreen = false ;
  //display on specific screen
  myScreenToDisplayMySketch = row.getInt("whichScreen") -1 ;
  //decorated the scene
  if (row.getString("decorated").equals("FALSE") || row.getString("decorated").equals("false") || fullScreen ) undecorated = true ; else undecorated = false ;

  // type of renderer
  if      ( row.getString("renderer").equals("P2D") ) { displayMode = ("P2D") ;  modeP3D = false ; }
  else if ( row.getString("renderer").equals("P3D") ) { displayMode = ("P3D") ; modeP3D = true ; }
  else if (  row.getString("renderer").equals("OPENGL")  || row.getString("renderer").equals("opengl") ) { displayMode = ("OPENGL") ; modeP3D = false ; }
  else { displayMode = ("Classic") ; modeP3D = false ; }
  
  
  //size of the scene
  if (fullScreen) {
    if(displayMode.equals("P2D") || displayMode.equals("OPENGL") || modeP3D ) { 
      fullSceneWidth  =600 ;  
      fullSceneWidth =400 ; 
    } else { 
      fullSceneWidth = (int)fullScreen(myScreenToDisplayMySketch).x    /divSizePreScene ;
      fullSceneWidth = (int)fullScreen(myScreenToDisplayMySketch).y /divSizePreScene  ;
    }
  } else {
    if(displayMode.equals("P2D") || displayMode.equals("OPENGL") || modeP3D ) { 
      sceneWidth  =600 ;  
      sceneHeight =400 ; 
    } else { 
      sceneWidth = row.getInt("width")    /divSizePreScene ;
      sceneHeight =  row.getInt("height") /divSizePreScene  ;
    }
  }
  
  //create the Scene
  
  if      ( fullScreen && displayMode.equals("Classic"))  size(fullSceneWidth, fullSceneHeight) ;
  else if ( fullScreen && displayMode.equals("P2D")  )    size(fullSceneWidth, fullSceneHeight, P2D) ;
  else if ( fullScreen && modeP3D  )    size(fullSceneWidth, fullSceneHeight, P3D) ;
  else if ( fullScreen && displayMode.equals("OPENGL"))   size(fullSceneWidth, fullSceneHeight, OPENGL) ;
  
  else if ( !fullScreen && displayMode.equals("Classic")) size(sceneWidth, sceneHeight) ;
  else if ( !fullScreen && displayMode.equals("P2D")  )   size(sceneWidth, sceneHeight, P2D) ;
  else if ( !fullScreen && modeP3D  )   size(sceneWidth, sceneHeight, P3D) ;
  else if ( !fullScreen && displayMode.equals("OPENGL"))  size(sceneWidth, sceneHeight, OPENGL) ;
  else size(sceneWidth, sceneHeight) ;
  
  
  //resizable frame by loading external image
  if (row.getString("resizable").equals("TRUE")    || row.getString("fullscreen").equals("true")) {
    frame.pack();  
    insets = frame.getInsets(); // use for the border of window (top and right)
    displaySizeByImage = true ;
  }
  
  //resize by cursor
  frame.setResizable(true);
}
//END DISPLAY START
//////////////////

    
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
      
String pathFontTTF [] = new String [50] ;  
String pathFontVLW [] = new String [50] ;
String prefixTTF = ("typoTTF/") ;
String prefixVLW = ("typoVLW/") ;
      
//SETUP
void fontSetup() {
  //write font path for VLW
  pathFontVLW[1] = (prefixVLW+"AmericanTypewriter-96.vlw");
  pathFontVLW[2] = (prefixVLW+"AmericanTypewriter-Bold-96.vlw");
  pathFontVLW[3] = (prefixVLW+"BancoITCStd-Heavy-96.vlw");
  pathFontVLW[4] = (prefixVLW+"CinquentaMilMeticais-96.vlw");
  pathFontVLW[5] = (prefixVLW+"Container-Regular-96.vlw");
  pathFontVLW[6] = (prefixVLW+"Diesel-96.vlw");
  pathFontVLW[7] = (prefixVLW+"Digital2-96.vlw");
  pathFontVLW[8] = (prefixVLW+"DIN-Regular-96.vlw");
  pathFontVLW[9] = (prefixVLW+"DIN-Bold-96.vlw");
  pathFontVLW[10] = (prefixVLW+"EastBlocICGClosed-96.vlw");
  pathFontVLW[11] = (prefixVLW+"FuturaStencilICG-96.vlw");
  pathFontVLW[12] = (prefixVLW+"FetteFraktur-96.vlw");
  pathFontVLW[13] = (prefixVLW+"GANGBANGCRIME-96.vlw");
  pathFontVLW[14] = (prefixVLW+"JuanitaDecoITCStd-96.vlw");
  pathFontVLW[15] = (prefixVLW+"Komikahuna-96.vlw");
  pathFontVLW[16] = (prefixVLW+"MesquiteStd-96.vlw");
  pathFontVLW[17] = (prefixVLW+"NanumBrush-96.vlw");
  pathFontVLW[18] = (prefixVLW+"RosewoodStd-Regular-96.vlw");
  pathFontVLW[19] = (prefixVLW+"3theHardwayRMX-96.vlw");
  pathFontVLW[20] = (prefixVLW+"Tokyo-One-96.vlw");
  pathFontVLW[21] = (prefixVLW+"MinionPro-Regular-96.vlw");
  pathFontVLW[22] = (prefixVLW+"MinionPro-Bold-96.vlw");
  //special font
  pathFontVLW[49] = (prefixVLW+"DIN-Regular-10.vlw");
  
  //write font path for TTF
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
  SansSerif10 = loadFont(prefixVLW+"SansSerif-10.vlw") ;
}




void whichFont( int whichFont) 
{ 
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

void displayInfoScene()
{
  noStroke() ;
  fill(0,100,0, 50) ;
  rectMode(CORNER) ;
  rect(0,-5,width, 15*posInfoObj) ;
  posInfoObj = 2 ;
  fill(0,0,100) ;
  textFont(SansSerif10, 10) ;
  //INFO SIZE and RENDERER
  String displayModeInfo ;
  if (displayMode.equals("Classic") ) displayModeInfo = ("classique") ; else displayModeInfo = displayMode ;
  if (img != null ) text ("Taille de la scène " + width + "x" + height + " Taille de l'image "+ img.width + "x"+ img.height + "    Mode d'affichage " + displayModeInfo + "    FrameRate " + frameRate, 15,15 ) ; 
  else text("Taille de la scène " + width + "x" + height + "   mode d'affichage " + displayModeInfo + "    FrameRate " + frameRate, 15,15) ;
  //INFO MOUSE and PEN
  text("position X " + mouseX + "  position Y " + mouseY + "  molette " + wheel[0] + "    stylet orientation " + (int)deg360(pen[0]) +"°   stylet pression " + int(pen[0].z *10),15, 15 * (posInfoObj) ) ;  
  posInfoObj += 1 ;
  //INFO SOUND
  if (getTimeTrack() > 1 ) text("Le morceau dure depuis " +getTimeTrack() + "  Tempo " + getTempoRef() , 15,15 *(posInfoObj)) ; else text("Aucun morceau détecté ", 15, 15 *(posInfoObj)) ;
  posInfoObj += 1 ;
  text("droite " +int(input.right.get(1) *100) + "  gauche " + int(input.left.get(1) *100) , 15,15 *(posInfoObj)) ; 

  posInfoObj += 1 ;
  //INFO WEATHER and METEO
  text(weather.getCityName() + " / " + traductionWeather (weather.getWeatherConditionCode()) + "    Température " + weather.getTemperature() + "C°" + "   Pression " + hectoPascal(weather.getPressure()) + " HectoPascal", 15,15 *(posInfoObj)) ; 
  posInfoObj += 1 ;
  text ("Vent " + windFrench() + " de Force " + beaufort() + "     Levé du soleil " + weather.getSunrise() + "     Couché du soleil " + weather.getSunset(), 15,15 *(posInfoObj)) ; 
  posInfoObj += 1 ;
 // if(mainButton[1] == 1 ) { posInfoObj += 1  ; }
 // if(mainButton[2] == 1 ) { posInfoObj += 1  ; }
  //video
  if(mainButton[25] == 1 && videoSignal ) { 
    text( "Caméra active ", 15, 15 * (posInfoObj) ) ;  posInfoObj += 1 ; 
  } else { 
    text("Pas de signal vidéo", 15, 15 *(posInfoObj) ) ;
    posInfoObj += 1 ;
  }
  //
  if(mainButton[27] == 1 ) { 
    text( "Info Escargot " + totalPixCheckedInTheEscargot + " Pixels analysées " +  " sur " + listPixelRaw.size() + "    Escargots " + listEscargot.size() , 15, 15 * (posInfoObj) ) ;  posInfoObj += 1 ; 
  } else { 
    text("Pas d'image traitée", 15, 15 *(posInfoObj) ) ;
    posInfoObj += 1 ;
  }
}
////////////////
//END DISPLAY INFO






////////////
///////
//METEO
//GLOBAL
YahooWeather weather;
int updateIntervallMillis = 30000;

int sunRise, sunSet ;



//SETUP
void meteoSetup()
{
  String [] md = loadStrings (sketchPath("")+"meteo.txt")  ;
  String meteoData  = join(md, "") ;
  String splitMeteoData [] = split(meteoData, '/') ;

  if (splitMeteoData[2].equals("celsius") ) weather = new YahooWeather(this, Integer.parseInt(splitMeteoData[4]), "c", updateIntervallMillis); else weather = new YahooWeather(this, Integer.parseInt(splitMeteoData[4]), "f", updateIntervallMillis) ;



}

//DRAW
void meteoDraw()
{
  weather.update();

  //the sun set and the sunrise is calculate in minutes, one day is 1440 minutes, and the start is midnight
  sunRise = int(clock24(weather.getSunrise(), 1)) ;
  sunSet = int(clock24(weather.getSunset(), 1)) ;
}


//ANNEXE

//CLOCK SUN
String clock24(String t, int mode)
{
  String [] split = new String [2] ;
  String [] splitTime = new String [2] ;
  String clockSunset =  t ;
  //transform clock in 24h mode, then in number (int) ;
  split = split(clockSunset, " ") ;
  splitTime = split(split[0], ":") ;
  
  int hourSunset ;
  if (split[1].equals("pm") == true ) hourSunset = int(splitTime[0]) +12 ; else hourSunset = int(splitTime[0]) ;
  
  String clock24 = (hourSunset +"h"+splitTime[1]) ;
  int m = (int(hourSunset) * 60 + int(splitTime[1])) ;
  String min = (m + "") ;
  
  if (mode == 0 ) return clock24  ; else return min ;
}

//METEO COLOR
//global
float sky_h, sky_s, sky_b, sunValue ;

//DRAW

//Two color
/*
color meteoColor(color day, color night, int whatTimeIsIt, int speedRiseSet)
{
  color colorOfSky ;
  int sunrise,sunset ;
  

  sunrise = int(clock24(weather.getSunrise(), 1)) ;
  sunset = int(clock24(weather.getSunset(), 1)) ;

  //basic 
  //if ( sunrise < whatTimeIsIt && sunset < whatTimeIsIt ) colorOfSky = bleuCiel ; else colorOfSky = bleuNuit ; 
  
  //smooth


  if (  whatTimeIsIt  > sunrise -30 && whatTimeIsIt < sunrise +31 ) {
    sunValue = whatTimeIsIt - sunrise +31  ;
    sky_h = map(sunValue, 0,60, hue(night),       hue(day)) ;
    sky_s = map(sunValue, 0,60, saturation(night),saturation(day)) ;
    sky_b = map(sunValue, 0,60, brightness(night),brightness(day)) ;
  } else if (  whatTimeIsIt  > sunset -30 && whatTimeIsIt < sunset +31 ) {
    sunValue = whatTimeIsIt - sunset +31  ;
    sky_h = map(sunValue, 0,60, hue(day),       hue(night)) ;
    sky_s = map(sunValue, 0,60, saturation(day),saturation(night)) ;
    sky_b = map(sunValue, 0,60, brightness(day),brightness(night)) ;
  } else if ( whatTimeIsIt < sunrise -30 || whatTimeIsIt > sunset +30 ) {
    sky_h = hue(night) ;
    sky_s = saturation(night) ;
    sky_b = brightness(night) ;
  } else {
    sky_h = hue(day) ;
    sky_s = saturation(day) ;
    sky_b = brightness(day) ;
  }
  
  colorOfSky = color (sky_h,sky_s,sky_b) ;
  // colorOfSky = bleuNuit ;
  
  return colorOfSky ;
}

*/



//one color
color meteoColor(color colorOfTheDay, int whatTimeIsIt, int speedRiseSet, int pressure)
{
  color colorOfSky ;
  
  int sunrise,sunset ;
  float wPressure = map(pressure,930, 1060, 0,1) ;
  

  sunrise = int(clock24(weather.getSunrise(), 1)) ;
  sunset = int(clock24(weather.getSunset(), 1)) ;
  
  //basic 
  //if ( sunrise < whatTimeIsIt && sunset < whatTimeIsIt ) colorOfSky = bleuCiel ; else colorOfSky = bleuNuit ; 
  
  //smooth
  int minValueSat = 0 ;
  int minValueBright = 0 ;
  int maxValueSat = int(100 *wPressure) ;
  int maxValueBright = 100 ;
  speedRiseSet /= 2 ;
  

  //sunrise
  if (  whatTimeIsIt  > sunrise -speedRiseSet && whatTimeIsIt < sunrise +speedRiseSet ) {
    sunValue = whatTimeIsIt - sunrise +speedRiseSet  ;
    sky_h = hue(colorOfTheDay) ;
    sky_s = map(sunValue, 0,speedRiseSet, minValueSat, maxValueSat) ;
    sky_b = map(sunValue, 0,speedRiseSet, minValueBright, maxValueBright) ;
  //sunset   
  } else if (  whatTimeIsIt  > sunset -speedRiseSet && whatTimeIsIt < sunset +speedRiseSet ) {
    sunValue = whatTimeIsIt - sunset +speedRiseSet  ;
    sky_h = hue(colorOfTheDay) ;
    sky_s = map(sunValue, 0,speedRiseSet, maxValueSat, minValueSat) ;
    sky_b = map(sunValue, 0,speedRiseSet, maxValueBright, minValueBright) ;
  //the night  
  } else if ( whatTimeIsIt <= sunrise -speedRiseSet || whatTimeIsIt >= sunset +speedRiseSet ) {
    sky_h = hue(colorOfTheDay) ;
    sky_s = minValueSat ;
    sky_b = minValueBright ;
  //the day
  } else if ( whatTimeIsIt >= sunrise +speedRiseSet || whatTimeIsIt <= sunset -speedRiseSet ) {
    sky_h = hue(colorOfTheDay) ;
    sky_s = maxValueSat ;
    sky_b = maxValueBright ;
  }
  
  colorOfSky = color (sky_h,sky_s,sky_b) ;
  // colorOfSky = bleuNuit ;
  
  return colorOfSky ;
}



//PRESSION
int hectoPascal(float pressureToConvert)
{
  int HP ;
  if (pressureToConvert < 800 ) HP = int(pressureToConvert *33.86) ; else HP = (int)pressureToConvert ;
  return HP ;
}
//WIND FORCE
int beaufort()
{
  int forceDuVent = 0 ;
  if (weather.getWindSpeed() < 1 ) forceDuVent = 0 ;
  if (weather.getWindSpeed() > 0 && weather.getWindSpeed() < 6 ) forceDuVent = 1 ;
  if (weather.getWindSpeed() > 5 && weather.getWindSpeed() < 12 ) forceDuVent = 2 ;
  if (weather.getWindSpeed() > 11 && weather.getWindSpeed() < 20 ) forceDuVent = 3 ;
  if (weather.getWindSpeed() > 19 && weather.getWindSpeed() < 29 ) forceDuVent = 4 ;
  if (weather.getWindSpeed() > 28 && weather.getWindSpeed() < 39 ) forceDuVent = 5 ;
  if (weather.getWindSpeed() > 38 && weather.getWindSpeed() < 50 ) forceDuVent = 6 ;
  if (weather.getWindSpeed() > 49 && weather.getWindSpeed() < 62 ) forceDuVent = 7 ;
  if (weather.getWindSpeed() > 61 && weather.getWindSpeed() < 75 ) forceDuVent = 8 ;
  if (weather.getWindSpeed() > 74 && weather.getWindSpeed() < 89 ) forceDuVent = 9 ;
  if (weather.getWindSpeed() > 88 && weather.getWindSpeed() < 103 ) forceDuVent = 10 ;
  if (weather.getWindSpeed() > 102 && weather.getWindSpeed() < 118) forceDuVent = 11 ;
  if (weather.getWindSpeed() > 117 ) forceDuVent = 12 ;
  return forceDuVent ;
}



//WIND DIRECTION
//GLOBAL
String vent ;
//Void
String windFrench()
{
  //wind
  
  if (weather.getWindDirection() > 348 || weather.getWindDirection() <  11 ) vent = "de Nord" ;
  if (weather.getWindDirection() >= 11  && weather.getWindDirection() < 34 )  vent = "de Nord-Nord-Est" ;
  if (weather.getWindDirection() >= 34  && weather.getWindDirection() < 56 )  vent = "de Nord-Est" ;
  if (weather.getWindDirection() >= 56  && weather.getWindDirection() < 79 )  vent = "de Est-Est-Nord" ;
  
  if (weather.getWindDirection() >= 79  && weather.getWindDirection() < 101 ) vent = "d'Est" ;
  if (weather.getWindDirection() >= 101  && weather.getWindDirection() < 124 ) vent = "d'Est-Est-Sud" ;
  if (weather.getWindDirection() >= 124 && weather.getWindDirection() < 146 ) vent = "de Sud-Est" ;
  if (weather.getWindDirection() >= 146 && weather.getWindDirection() < 169 ) vent = "de Sud-Sud-Est" ;
  
  if (weather.getWindDirection() >= 169 && weather.getWindDirection() < 191 ) vent = "de Sud" ;
  if (weather.getWindDirection() >= 191 && weather.getWindDirection() < 214 ) vent = "de Sud-Sud-Ouest" ;
  if (weather.getWindDirection() >= 214 && weather.getWindDirection() < 236 ) vent = "de Sud-Ouest" ;
  if (weather.getWindDirection() >= 236 && weather.getWindDirection() < 259 ) vent = "de Ouest-Ouest-Sud" ;
  
  if (weather.getWindDirection() >= 259 && weather.getWindDirection() < 281 ) vent = "d'Ouest" ;
  if (weather.getWindDirection() >= 281 && weather.getWindDirection() < 304 ) vent = "d'Ouest-Ouest-Nord" ;
  if (weather.getWindDirection() >= 304 && weather.getWindDirection() < 326 ) vent = "de Nord-Ouest" ;
  if (weather.getWindDirection() >= 326 && weather.getWindDirection() < 348 ) vent = "de Nord-Nord-Ouest" ;
  return vent ;
}




//TRADUCTION
String frenchWeatherDescription ;
String traductionWeather(int code) {
  if (code == 0 ) { frenchWeatherDescription =  "tornade" ; }
  if (code == 1 ) { frenchWeatherDescription =  "tempête tropicale" ; }
  if (code == 2 ) { frenchWeatherDescription =  "ouragan" ; }
  if (code == 3 ) { frenchWeatherDescription =  "orage violent" ; }
  if (code == 4 ) { frenchWeatherDescription =  "orage" ; }
  if (code == 5 ) { frenchWeatherDescription =  "pluie et neige mélangées" ; }
  if (code == 6 ) { frenchWeatherDescription =  "pluie et giboulée (grelons?)" ; }
  if (code == 7 ) { frenchWeatherDescription =  "neige et giboulée (grelons?)" ; }
  if (code == 8 ) { frenchWeatherDescription =  "bruine verglassante" ; }
  if (code == 9 ) { frenchWeatherDescription =  "bruine" ; }
  if (code == 10 ) { frenchWeatherDescription =  "pluie verglassante" ; }
  if (code == 11 ) { frenchWeatherDescription =  "averses" ; }
  if (code == 12 ) { frenchWeatherDescription =  "averses" ; }
  if (code == 13 ) { frenchWeatherDescription =  "averses de neige" ; }
  if (code == 14 ) { frenchWeatherDescription =  "averses de neige légère" ; }
  if (code == 15 ) { frenchWeatherDescription =  "rafales de neige" ; }
  if (code == 16 ) { frenchWeatherDescription =  "neige" ; }
  if (code == 17 ) { frenchWeatherDescription =  "grêle" ; }
  if (code == 18 ) { frenchWeatherDescription =  "giboulée" ; }
  if (code == 19 ) { frenchWeatherDescription =  "poussière" ; }
  if (code == 20 ) { frenchWeatherDescription =  "brouillard" ; }
  if (code == 21 ) { frenchWeatherDescription =  "brume" ; }
  if (code == 22 ) { frenchWeatherDescription =  "pollué" ; }
  if (code == 23 ) { frenchWeatherDescription =  "bourrasque" ; }
  if (code == 24 ) { frenchWeatherDescription =  "venteux" ; }
  if (code == 25 ) { frenchWeatherDescription =  "froid" ; }
  if (code == 26 ) { frenchWeatherDescription =  "couvert" ; }
  if (code == 27 ) { frenchWeatherDescription =  "nuit plutôt couverte" ; }
  if (code == 28 ) { frenchWeatherDescription =  "journée plutôt couverte" ; }
  if (code == 29 ) { frenchWeatherDescription =  "nuit partiellement couverte" ; }
  if (code == 30 ) { frenchWeatherDescription =  "journée partiellement couverte" ; }
  if (code == 31 ) { frenchWeatherDescription =  "nuit dégagée" ; }
  if (code == 32 ) { frenchWeatherDescription =  "ensolleillé" ; }
  if (code == 33 ) { frenchWeatherDescription =  "nuit dégagée" ; }
  if (code == 34 ) { frenchWeatherDescription =  "journée dégagée" ; }
  if (code == 35 ) { frenchWeatherDescription =  "pluie et grêle" ; }
  if (code == 36 ) { frenchWeatherDescription =  "chaud" ; }
  if (code == 37 ) { frenchWeatherDescription =  "orages localisés" ; }
  if (code == 38 ) { frenchWeatherDescription =  "orages éparses" ; }
  if (code == 39 ) { frenchWeatherDescription =  "orages éparses" ; }
  if (code == 40 ) { frenchWeatherDescription =  "averses éparses" ; }
  if (code == 41 ) { frenchWeatherDescription =  "grosses chute de neige" ; }
  if (code == 42 ) { frenchWeatherDescription =  "chutes de neige éparses" ; }
  if (code == 43 ) { frenchWeatherDescription =  "grosses chute de neige" ; }
  if (code == 44 ) { frenchWeatherDescription =  "partiellement couvert" ; }
  if (code == 45 ) { frenchWeatherDescription =  "pluies violentes" ; }
  if (code == 46 ) { frenchWeatherDescription =  "averses de neige" ; }
  if (code == 47 ) { frenchWeatherDescription =  "pluies violentes isolées" ; }
  if (code == 3200 ) { frenchWeatherDescription =  "non répertorié" ; } 
  
  return frenchWeatherDescription ;
}
//END METEO
//////////







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
