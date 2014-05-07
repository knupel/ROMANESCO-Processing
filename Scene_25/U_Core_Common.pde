//////////////
//CHECK FOLDER
PImage img ;
ArrayList imageFiles = new ArrayList();
ArrayList textFiles = new ArrayList();
String [] imagePath, textPath ;
boolean folderImageIsSelected = true ;
boolean folderFileTextIsSelected = true ;
// use when we open manuelly the folder
int countImageSelection, countFileTextSelection ;
int refImageNumFiles, refTextNumFiles ;



// main void
void loadLiveData() {
  // image
  checkImageFolder() ;
  if(whichImage > imagePath.length ) whichImage = 0 ;
  if(imagePath != null) img = loadImage(imagePath[whichImage]) ;
  // text
  checkFileTextFolder() ;
  if(whichText > textPath.length ) whichText = 0 ;
  importText(textPath[whichText]) ;
  splitText() ;
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






