// Tab: Z_Core
/*
Here you findPath
LIGHT POSITION

CHECK FOLDER
*/



// LIGHT POSITION
/*
This void is necessary to diplay the info, not directly for the light because you don't use Light in the Prescene
*/
PVector lightPos = new PVector() ;
void lightPosition() {
  if(modeP3D && lLongTouch) {
    lightPos.x = mouse[0].x ;
    lightPos.y = mouse[0].y ;
    lightPos.z -= wheel[0] ;
  }
}


//////////////
//CHECK FOLDER
PImage imgDefault ;
PImage[] img ;
ArrayList imageFiles = new ArrayList();

String textRaw ;
String[] textImport ;
ArrayList textFiles = new ArrayList();

String [] imagePath, textPath ;
boolean folderImageIsSelected = true ;
boolean folderFileTextIsSelected = true ;
// use when we open manuelly the folder
int countImageSelection, countFileTextSelection ;
int refImageNumFiles, refTextNumFiles ;



// main void
void loadImg(int ID) {
  checkImageFolder() ;
  // whichImage is the int return from the dropdown menu
  if(whichImage[ID] > imagePath.length ) whichImage[ID] = 0 ;

  if(imagePath != null && imagePath.length > 0) {
    String image_current_path = imagePath[whichImage[ID]] ;
    if(!image_current_path.equals(image_path_ref[ID])) {
      img[ID] = loadImage(image_current_path) ;
    }
    image_path_ref[ID] = image_current_path ;
  }
}

void loadText(int ID) {
  checkFileTextFolder() ;
  // whichText is the int return from the dropdown menu
  if(textPath != null && textPath.length > 0) {
    if(whichText[ID] > textPath.length ) whichText[ID] = 0 ;
    textImport[ID] = importText(textPath[whichText[ID]]) ;
  } else {
    textImport[ID] = "Big Brother has been burning all the books, it's not possible to read anything" ;
  }
    
}



// check what's happen in the selected folder
void checkImageFolder() {
  // String path = sketchPath("") +"/" +preferencesPath +"Images" ;
  String path = preferencesPath +"Images" ;

  // String path = preferencesPath +"Images" ;
  ArrayList allFiles = listFilesRecursive(path);
  //check if something happen in the folder
  if(refImageNumFiles != allFiles.size() ) {
    folderImageIsSelected = true ;
    refImageNumFiles = allFiles.size() ;
  }
  // If something happen, algorithm work 
  if(folderImageIsSelected) {
    countImageSelection++ ;
    imageFiles.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("PNG") || lastThree.equals("png") || lastThree.equals("JPG") || lastThree.equals("jpg") || lastThree.equals("GIF") || lastThree.equals("gif")) {
          imageFiles.add(f);
        }
      }
    }
    // edit the image path
    imagePath = new String[imageFiles.size()] ;
    for (int i = 0; i < imageFiles.size(); i++) {
      File f = (File) imageFiles.get(i);
      imagePath[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folderImageIsSelected = false ;
  }
}

void checkFileTextFolder() {
  // String path = sketchPath("") +"/" +preferencesPath +"Karaoke" ;
  String path = preferencesPath +"Karaoke" ;
  ArrayList allFiles = listFilesRecursive(path);
  
  //check if something happen in the folder
  if(refTextNumFiles != allFiles.size() ) {
    folderFileTextIsSelected = true ;
    refTextNumFiles = allFiles.size() ; 
  }
  // If something happen, algorithm work 
  if(folderFileTextIsSelected) {
    countFileTextSelection++ ;
    textFiles.clear() ;
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
  
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("TXT") || lastThree.equals("txt")) {
          textFiles.add(f);
        }
      }
    }
    // edit the path file
    textPath = new String[textFiles.size()] ;
    for (int i = 0; i < textFiles.size(); i++) {
      File f = (File) textFiles.get(i); 
      textPath[i] = f.getAbsolutePath() ;
    }
    
    // to don't loop with this void
    folderFileTextIsSelected = false ;
  }
}
// end main void




// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// Function to get a list ofall files in a directory and all subdirectories
ArrayList listFilesRecursive(String dir) {
  ArrayList fileList = new ArrayList(); 
  recurseDir(fileList, dir);
  return fileList;
}

// Recursive function to traverse subdirectories
void recurseDir(ArrayList a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a, subfiles[i].getAbsolutePath());
    }
  } 
  else {
    a.add(file);
  }
}
//END CHECK FOLDER
/////////////////










// NEW VOID TEXT
String importRaw [] ;



String importText(String path) {
  importRaw = loadStrings(path) ;
  return join(importRaw, "") ;
}


// info num Chapters
int numChapters(String txt) {
  String chapters [] = split(txt, "*") ;
  return chapters.length ;
}

// info num Sentences
int numMaxSentencesByChapter(String txt) {
  String chapters [] = split(txt, "*") ;
  // find the quantity of chapter and sentences by chapter to create the final double array String
  int numChapter = chapters.length ;
  int maxSentencesByChapter = 0 ;  
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(chapters[i], "/") ;
    if ( sentences.length > maxSentencesByChapter ) maxSentencesByChapter = sentences.length ; 
  }
  
  return maxSentencesByChapter ;
}



String whichSentence(String txt, int whichChapter, int whichSentence) {
  String chapters [] = split(txt, "*") ;
  String  [][] repartition ;
  
  // find the quantity of chapter and sentences by chapter to create the final double array String
  int numChapter = chapters.length ;
  int maxSentencesByChapter = 0 ;  
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(chapters[i], "/") ;
    if ( sentences.length > maxSentencesByChapter ) maxSentencesByChapter = sentences.length ; 
  }
  //create the final double array string
  repartition = new String [numChapter][maxSentencesByChapter] ;
  //put the sentences in the double String by chapter
  for ( int i = 0 ; i < numChapter ; i++) {
    String sentences [] = split(chapters[i], "/") ;
    for ( int j = 0 ; j <  sentences.length ; j++) {
      repartition [i][j] = sentences[j] ;
    }
  }
  //security
  if(whichChapter > chapters.length ) whichChapter = 0 ;
  if(whichSentence > maxSentencesByChapter ) whichSentence = 0 ;
  
  return repartition[whichChapter][whichSentence] ;
}

// END TEXT
//////////








// MIROIR
/////////

boolean syphon  ;

SyphonServer server;
void miroirSetup() {
  server = new SyphonServer(this, nameVersion + " " + prettyVersion +"."+version);
}
void miroirDraw() {
  if(yTouch) syphon = !syphon ;
  if (syphon) server.sendScreen();
}

// Old Syphon
/**
Miroir miroir;
void miroirSetup() {
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
    for(int x = 0; x < that.width; x++) {
     for(int y = 0; y < that.height; y++) {
         canvas.pixels[((that.height-y-1)*that.width+x)] = that.pixels[y*that.width+x];
     }
   }
    canvas.updatePixels();
    server.sendImage(canvas);
  }
}
*/
//END MIROIR










//////////////
//DISPLAY INFO
boolean displayInfo, displayInfo3D ;
int posInfo = 2 ;


void info() {
  if (displayInfo) {
    //perspective() ;
    displayInfoScene() ;
    displayInfoObject() ;
  }
  if (modeP3D && displayInfo3D) displayInfo3D() ;
}

void displayInfoScene() {
  noStroke() ;
  fill(0,100,0, 50) ;
  rectMode(CORNER) ;
  textAlign(LEFT) ;
  rect(0,-5,width, 15*posInfo) ;
  posInfo = 2 ;
  fill(0,0,100) ;
  textFont(SansSerif10, 10) ;
  //INFO SIZE and RENDERER
  String displayModeInfo ;
  if (displayMode.equals("Classic") ) displayModeInfo = ("classic") ; else displayModeInfo = displayMode ;
  String infoRendering =("");
  if(fullRendering) infoRendering = ("Full rendering") ; else infoRendering = ("Preview rendering") ;
  text("Size " + width + "x" + height + " / "  + infoRendering + " / Render mode " + displayModeInfo + " / FrameRate " + (int)frameRate, 15,15) ;
  // INFO SYPHON
  text("Syphon " +syphon + " / press “y“ to on/off the Syphon",15, 15 *posInfo ) ;
  posInfo += 1 ;
  //INFO MOUSE and PEN
  text("Mouse " + mouseX + " / " + mouseY + " molette " + wheel[0] + " pen orientation " + (int)deg360(pen[0]) +"°   stylet pressur " + int(pen[0].z *10),15, 15 *posInfo ) ;  
  posInfo += 1 ;
  // LIGHT INFO
  text("Light Position " + lightPos.x + " / " + lightPos.y + " / "+ lightPos.z,15, 15 *posInfo  ) ;
  posInfo += 1 ;
  //INFO SOUND
  if (getTimeTrack() > 1 ) text("the track play until " +getTimeTrack() + "  Tempo " + getTempoRef() , 15,15 *(posInfo)) ; else text("no track detected ", 15, 15 *(posInfo)) ;
  posInfo += 1 ;
  text("right " + right_volume_info, 15, 15 *(posInfo)) ;  
  text("left "  + left_volume_info,  50, 15 *(posInfo)) ;
  posInfo += 1 ;
}


int posInfoObj = 1 ;

void displayInfoObject() {
  noStroke() ;
  fill(0,100,0, 50) ;
  rectMode(CORNER) ;
  textAlign(LEFT) ;
  float heightBox = 15*posInfoObj ;
  rect(0, height -heightBox,width, heightBox) ;
  fill(0,0,100) ;
  textFont(SansSerif10, 10) ;
  
  posInfoObj = 1 ;
  // for (Romanesco objR : RomanescoList)
  for(int i = 0 ; i < numObj ; i++) {
    
    if(show_object[i]) {
      posInfoObj += 1 ;
      String position = ("x:" +(int)posObjX[i] + " y:" + (int)posObjY[i]+ " z:" + (int)posObjZ[i]) ;
      text(objectName[i] + " - Coord " + position + " - " + objectInfo[objectID[i]], 10, height -(15 *(posInfoObj -1))) ;
    }
  }
}



//INFO 3D
void displayInfo3D() {
   String posCam = ( int(-1 *sceneCamera.x ) + " / " + int(sceneCamera.y) + " / " +  int(sceneCamera.z -height/2)) ;
   String eyeDirectionCam = ( int(eyeCamera.x) + " / " + int(eyeCamera.y) ) ;
  fill(0,0,100) ; 
  textFont(SansSerif10, 10) ;
  textAlign(RIGHT) ;
  text("Position " +posCam, width/2 -30 , height/2 -30) ;
  text("Direction " +eyeDirectionCam, width/2 -30 , height/2 -15) ;
}



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



//END P3D
/////////
////////////////
//END DISPLAY INFO





//DRAWING
//CROSS
void crossPoint2D(PVector pos, color colorCross, int e, int size) {
  stroke(colorCross) ;
  strokeWeight(e) ;
  
  line(pos.x, pos.y -size, pos.x, pos.y +size) ;
  line(pos.x +size, pos.y, pos.x -size, pos.y) ;
}


// other cross
void crossPoint2D(PVector pos, PVector size, color colorCross, float e ) {
  if (e <0.1) e = 0.1 ;
  stroke(colorCross) ;
  strokeWeight(e) ;
  //horizontal
  line(pos.x, pos.y -size.x, pos.x, pos.y +size.x) ;
  //vertical
  line(pos.x +size.y, pos.y, pos.x -size.y, pos.y) ;
}
void crossPoint3D(PVector pos, PVector size, color colorCross, float e ) {
  if (e <0.1) e = 0.1 ;
  stroke(colorCross) ;
  strokeWeight(e) ;
  //horizontal
  line(pos.x, pos.y -size.x,0, pos.x, pos.y +size.x,0) ;
  //vertical
  line(pos.x +size.y, pos.y,0, pos.x -size.y, pos.y,0) ;
  //depth
  line(pos.x, pos.y,size.z, pos.x, pos.y,-size.z) ;
}
//


//END DRAWING
////////////
















// MISC
///////


//curtain
void curtain() {
  if(!onOffCurtain) {
    rectMode(CORNER) ;
    fill (0) ; 
    noStroke() ;
    rect(-1,-1, width+2, height+2);
  }
}
//end curtain



// OS mac DETECTION
boolean mavericks = false ;
void OSMavericksCheck() {
  // check OSX version
  String OS = System.getProperty("os.version") ;
  OS  = OS.replace(".","");
  int OSversion = Integer.parseInt(OS);
  if(OSversion >= 1090  ) mavericks = true ; else mavericks = false ;
}


// END MISC
///////////








//////////
//KEYBOARD

//short Touch
boolean aTouch, bTouch, cTouch, dTouch, eTouch, fTouch, gTouch, hTouch, iTouch, jTouch, kTouch, lTouch, mTouch, nTouch, oTouch, pTouch, qTouch, rTouch, sTouch, tTouch, uTouch, vTouch, wTouch, xTouch, yTouch, zTouch,
        leftTouch, rightTouch, upTouch, downTouch, 
        touch0, touch1, touch2, touch3, touch4, touch5, touch6, touch7, touch8, touch9, 
        backspaceTouch, deleteTouch, enterTouch, returnTouch, shiftTouch, altTouch, escTouch, ctrlTouch, cmdTouch ;
//long touch
boolean spaceTouch, cLongTouch, lLongTouch, nLongTouch, vLongTouch ;  

//END KEYBOARD
//////////////






//DETECTION
//CIRLCLE
boolean insideCircle (PVector pos, int diam) {
  if (dist(pos.x, pos.y, mouseX, mouseY) < diam) return true  ; else return false ;
}

//RECTANGLE
boolean insideRect(PVector pos, PVector size) { 
    if(mouse[0].x > pos.x && mouse[0].x < pos.x + size.x && mouse[0].y >  pos.y && mouse[0].y < pos.y + size.y) return true ; else return false ;
}
//DETECTION





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



// EASING
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








/*
///////////////////////////////////////////
//TRANSLATOR INT to String, FLOAT to STRING
//truncate
float truncate( float x ) {
    return round( x * 100.0f ) / 100.0f;
}
//Int to String with array list

// @ return String

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
*/
//END TRANSLATOR
///////////////