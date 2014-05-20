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
  if(imagePath != null) img[ID] = loadImage(imagePath[whichImage[ID]]) ;
}

void loadText(int ID) {
  checkFileTextFolder() ;
  // whichText is the int return from the dropdown menu
  if(whichText[ID] > textPath.length ) whichText[ID] = 0 ;
  textImport[ID] = importText(textPath[whichText[ID]]) ;
}



// check what's happen in the selected folder
void checkImageFolder() {
  String path = sketchPath +"/" +preferencesPath +"Images" ;
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
      //println("Name: " + filename);
      //println("Full path: " + f.getAbsolutePath());
      //println("Is directory: " + f.isDirectory());
  
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
  String path = sketchPath +"/" +preferencesPath +"Karaoke" ;
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
      //println("Name: " + filename);
      //println("Full path: " + f.getAbsolutePath());
      //println("Is directory: " + f.isDirectory());
  
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





// OLD VOID TEXT
/*
String [][] sentencesByChapter ;

void importTxt(String path) {
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
*/
// END TEXT
//////////















//////////////
//DISPLAY INFO
boolean displayInfo, displayInfo3D ;
int posInfo = 2 ;


void info () {
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
  rect(0,-5,width, 15*posInfo) ;
  posInfo = 2 ;
  fill(0,0,100) ;
  textFont(SansSerif10, 10) ;
  //INFO SIZE and RENDERER
  String displayModeInfo ;
  if (displayMode.equals("Classic") ) displayModeInfo = ("classic") ; else displayModeInfo = displayMode ;
  text("Scène width " + width + "height" + height + "   render mode " + displayModeInfo + "    FrameRate " + (int)frameRate, 15,15) ;
  //INFO MOUSE and PEN
  text("Mouse " + mouseX + " / " + mouseY + " molette " + wheel[0] + " pen orientation " + (int)deg360(pen[0]) +"°   stylet pressur " + int(pen[0].z *10),15, 15 *posInfo ) ;  
  posInfo += 1 ;
  // LIGHT INFO
  text("Light Position " + lightPos.x + " / " + lightPos.y + " / "+ lightPos.z,15, 15 *posInfo  ) ;
  posInfo += 1 ;
  //INFO SOUND
  if (getTimeTrack() > 1 ) text("the track play until " +getTimeTrack() + "  Tempo " + getTempoRef() , 15,15 *(posInfo)) ; else text("no track detected ", 15, 15 *(posInfo)) ;
  posInfo += 1 ;
  text("right " +int(input.right.get(1) *100),15, 15 *(posInfo)) ;  text("left " + int(input.left.get(1) *100), 50, 15 *(posInfo)) ;
  posInfo += 1 ;
}


int posInfoObj = 1 ;

void displayInfoObject() {
  noStroke() ;
  fill(0,100,0, 50) ;
  rectMode(CORNER) ;
  float heightBox = 15*posInfoObj ;
  rect(0, height -heightBox,width, heightBox) ;
  fill(0,0,100) ;
  textFont(SansSerif10, 10) ;
  
  posInfoObj = 1 ;
  // for (SuperRomanesco objR : RomanescoList)
  for(int i = 0 ; i < numObj ; i++) {
    
    if(object[i]) {
      posInfoObj += 1 ;
      String position = ((int)P3DpositionX[i] + " " + (int)P3DpositionY[i]+ " " + (int)P3DpositionZ[i]) ;
      text(objectName[i] + " / " + position + " / " + objectInfo[objectID[i]], 10, height -(15 *(posInfoObj -1))) ;
    }
  }
}



//INFO 3D
void displayInfo3D() {
   String posCam = ( int(sceneCamera.x +width/2) + " / " + int(sceneCamera.y +height/2) + " / " +  int(sceneCamera.z -height/2)) ;
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

//repere camera
void repereCamera(PVector size) {
  if(modeP3D && displayInfo3D)  {
    PVector newSize =  PVector.mult(size,.1) ;
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
    line(-newSize.x,0,0,newSize.x,0,0) ;

    // Y LINE
    fill(yColor) ;
    pushMatrix() ;
    rotateZ(radians(-90)) ;
    text("Y LINE YYY", posTxt,-posTxt) ;
    popMatrix() ;
    stroke(yColor) ; noFill() ;
    line(0,-newSize.y,0,0,newSize.y,0) ;
    
    // Z LINE
    fill(zColor) ;
    pushMatrix() ;
    rotateY(radians(90)) ;
    text("Z LINE ZZZ", posTxt,-posTxt) ;
    popMatrix() ;
    stroke(zColor) ; noFill() ;
    line(0,0,-newSize.z,0,0,newSize.z) ;
  }
}


void grid(PVector s) {
  strokeWeight(.2) ;
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
////////////////
//END DISPLAY INFO







// INFO SYSTEM
//////////////
// OS mac DETECTION
boolean mavericks = false ;
void OSMavericksCheck() {
  // check OSX version
  String OS = System.getProperty("os.version") ;
  OS  = OS.replace(".","");
  int OSversion = Integer.parseInt(OS);
  if(OSversion >= 1090  ) mavericks = true ; else mavericks = false ;
}
// END INFO SYSTEM
//////////////////
