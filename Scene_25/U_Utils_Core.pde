boolean mavericks = false ;
void OSMavericksCheck() {
  // check OSX version
  String OS = System.getProperty("os.version") ;
  OS  = OS.replace(".","");
  int OSversion = Integer.parseInt(OS);
  if(OSversion >= 1090  ) mavericks = true ; else mavericks = false ;
}


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
//////////

//cross
///////
void crossPoint(PVector pos, color colorCross, int e, int size) {
  stroke(colorCross) ;
  strokeWeight(e) ;
  
  line(pos.x, pos.y -size, pos.x, pos.y +size) ;
  line(pos.x +size, pos.y, pos.x -size, pos.y) ;
}


//just a little cross, for make cursor, point etc
void crossPoint(PVector pos, PVector size, color colorCross, float e ) {
  if (e <0.1) e = 0.1 ;
  stroke(colorCross) ;
  strokeWeight(e) ;
  //horizontal
  line(pos.x, pos.y -size.x, pos.x, pos.y +size.x) ;
  //vertical
  line(pos.x +size.y, pos.y, pos.x -size.y, pos.y) ;
}
//end cross
///////////


//CURTAIN////
/////////////
void curtain() {
  // we must put a security for the rideau, if not there is bug sometime and the rideau appear we don't know why
  if( eCurtain == 1) {
    rectMode(CORNER) ;
    float rideau = 100 ; 
    fill (0, rideau ) ; 
    noStroke() ;
    rect(-1,-1, width+2, height+2);
    fill(75, rideau) ;
    textSize(36) ;
    textFont(ContainerRegular) ;
  }
}
//end curtain
/////////////

//////////////
//END DRAWING


//CURSOR, PEN, LEAP MOTION
//CURSOR, MOUSE, TABLET, LEAP MOTION
//GLOBAL
void cursorSetup() {
  for (int i = 0 ; i < numObj ; i++ ) {
    pen[i] = new PVector(0,0,0) ;
    mouse[i] = new PVector(0,0) ;
    pmouse[i] = new PVector(0,0) ;
    wheel[i] = 0 ;
  }
}


void cursorDraw() {
  //mousePressed
  if( clickShortLeft[0] || clickShortRight[0] || clickLongLeft[0] || clickLongRight[0] ) mousepressed[0] = true ; else mousepressed[0] = false ;
  //next previous
  if (nextPrevious) nextPreviousInt = 1 ; else nextPreviousInt = 0 ;
}
///////////////
//END CURSOR, PEN, 

















//INSIDE
//CIRLCLE
boolean insideCircle (PVector pos, int diam) {
  if (dist(pos.x, pos.y, mouseX, mouseY) < diam) return true  ; else return false ;
}

//RECTANGLE
boolean insideRect(PVector pos, PVector size) { 
    if(mouse[0].x > pos.x && mouse[0].x < pos.x + size.x && mouse[0].y >  pos.y && mouse[0].y < pos.y + size.y) return true ; else return false ;
}

//LOCKED
boolean locked ( boolean inside ) {
  if ( inside  && mousepressed[0] ) return true ; else return false ;
}




















////////
//TIME
int minClock() {
  return hour()*60 + minute() ;
}


//timer
int chrnmtr, chronometer, newChronometer ;

int timer(float tempo) {
  int translateTempo = int(1000 *tempo) ;
  newChronometer = millis()%translateTempo ;
  if ( chronometer > newChronometer ) {
    chrnmtr += 1  ;
  }
  chronometer = newChronometer ;
  return chrnmtr ;
}

//make cycle from speed
float totalCycle ;
float cycle(float add) {
  totalCycle += add ; // choice here the speed of the cycle
  return sin(totalCycle) ;
}


//END TIME
///////////







////////////
//SAVE IMAGE
////////////
int countSave = 0 ;
void saveImg(File selection) {
  
  if (selection == null) {
    println("no picture saved");
  } else {
    
    savePathPNG = savePathPDF  = selection.getAbsolutePath() ;
    countSave += 1 ;
    
    if (!savePathPDF.endsWith(".pdf")) {
      savePathPDF += ".pdf";
    }
    
    if (!savePathPNG.endsWith(".png")) {
      savePathPNG += ".png";
    }
    saveFrame(savePathPNG);
        
  }
}
////////////////
//END SAVE IMAGE
///////////////



/////////////
//BACKGROUND
/////////////
int artificialTime ;
//FOND
void backgroundRomanesco() {
  noStroke() ;
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
////////////////


///////////////////////////////////////////////
// MISC
//////////////////////////////////////////////

//easing
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



//drop event
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
//end dropevent


// zoom
//with the wheel mouse
private float getCountZoom ;
void zoom() { getCountZoom = wheel[0] ; }
//end zoom


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





///////////////////////////////////////////////
// END MISC
//////////////////////////////////////////////











//TRANSLATOR
////////////
//truncate
float truncate( float x ) {
    return round( x * 100.0f ) / 100.0f;
}

//file name for save
String nameNumber(String name) {
  String numPict ;
  int year = year() -2000 ;
  String newYear = String.valueOf(year) ;
  String newMonth = String.valueOf(month()) ;
  String newDay = String.valueOf(day()) ;
  
  String newSecond = String.valueOf((hour() *60 *60) + (minute() *60 ) + second()) ;
  numPict = (name + newYear + "_" + newMonth + "_" + newDay + "_" +newSecond) ;
  return numPict  ;
}
//END TRANSLATOR
////////////////










//////////
//KEYBOARD

//short Touch
boolean aTouch, bTouch, cTouch, dTouch, eTouch, fTouch, gTouch, hTouch, iTouch, jTouch, kTouch, lTouch, mTouch, nTouch, oTouch, pTouch, qTouch, rTouch, sTouch, tTouch, uTouch, vTouch, wTouch, xTouch, yTouch, zTouch,
        leftTouch, rightTouch, upTouch, downTouch, 
        touch0, touch1, touch2, touch3, touch4, touch5, touch6, touch7, touch8, touch9, 
        backspaceTouch, deleteTouch, enterTouch, returnTouch, shiftTouch, altTouch, escTouch, ctrlTouch ;
//long touch
boolean spaceTouch, cLongTouch, nLongTouch, vLongTouch ;  

//END KEYBOARD
//////////////






////////////////////////
// FONT and TEXT MANAGER

//////
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
int posInfoObj = 2 ;

void displayInfoScene() {
  noStroke() ;
  fill(0,100,0, 50) ;
  rect(0,-5,width, 15*posInfoObj) ;
  posInfoObj = 2 ;
  fill(0,0,100) ;
  textFont(SansSerif10, 10) ;
  //INFO SIZE and RENDERER
  String displayModeInfo ;
  if (displayMode.equals("Classic") ) displayModeInfo = ("classique") ; else displayModeInfo = displayMode ;
  if (img != null ) text ("Taille de la scène " + width + "x" + height + " Taille de l'image "+ img.width + "x"+ img.height + "   Mode d'affichage " + displayModeInfo , 15,15 ) ; 
  else text("Taille de la scène " + width + "x" + height + "   mode d'affichage " + displayModeInfo, 15,15) ;
  //INFO MOUSE and PEN
  text("position X " + mouse[0].x + "  position Y " + mouse[0].y + "  molette " + wheel[0] + "    stylet orientation " + (int)deg360(pen[0]) +"°   stylet pression " + int(pen[0].z *10),15, 15 * (posInfoObj) ) ;  
  posInfoObj += 1 ;
  //INFO SOUND
  if (getTimeTrack() > 1 ) text("Le morceau dure depuis " +getTimeTrack() + "  Tempo " + getTempoRef() , 15,15 *(posInfoObj)) ; else text("Aucun morceau détecté ", 15, 15 *(posInfoObj)) ;
  posInfoObj += 1 ;
  //INFO WEATHER and METEO
  text(weather.getCityName() + " / " + traductionWeather (weather.getWeatherConditionCode()) + "    Température " + weather.getTemperature() + "C°" + "   Pression " + hectoPascal(weather.getPressure()) + " HectoPascal", 15,15 *(posInfoObj)) ; 
  posInfoObj += 1 ;
  text ("Vent " + windFrench() + " de Force " + beaufort() + "     Levé du soleil " + weather.getSunrise() + "     Couché du soleil " + weather.getSunset(), 15,15 *(posInfoObj)) ; 
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