
// Tab: X_Misc

//COLOR
//GLOBAL
color rouge, rougeFonce, rougeTresFonce,   
      orange, jauneOrange, jaune, 
      vert, vertClair, vertFonce, vertTresFonce,
      bleu,
      violet,
       
      blanc, blancGrisClair, blancGris, gris, grisClair, grisFonce, grisTresFonce, grisNoir, noirGris, noir,
      
      colorTextUsual, colorTitle,
      //bouton
      boutonOFFin, boutonOFFout, boutonONin, boutonONout ;
      //for the dropdown



//SETUP
void colorSetup() {
   colorMode (HSB, 360,100,100 ) ; 
   blanc = color(0,0,95) ;            
   blancGrisClair = color( 0,0,85) ;  
   blancGris = color( 0,0,75) ; 
   grisClair = color(0,0, 65) ;       
   gris = color(0,0,50) ;             
   grisFonce = color(0,0,40)  ;     
   grisTresFonce = color(0,0,30) ; 
   grisNoir = color(0,0,20) ;      
   noirGris = color (0,0,15) ;         
   noir = color (0,0,5) ;  
   vertClair = color (100,20,100) ;     
   vert = color(100,50,70) ; 
   vertFonce = color(100,100,50) ; 
   vertTresFonce = color(100,100,30) ;
   rougeTresFonce = color(10, 100, 50) ; 
   rougeFonce = color (10, 100, 70) ;  
   rouge = color(10,100,100) ;            
   orange = color (35,100,100) ; 
   jauneOrange = color (42,100,100) ; 
   jaune = color(50,100,100) ;
   
   colorTextUsual = grisNoir ; colorTitle = noirGris ;
   boutonOFFin = orange ; boutonOFFout = rougeFonce ;
   boutonONin = vert ; boutonONout = vertFonce ;
   

}
//END COLOR



//DRAW
//////RETURN////////////
boolean checkKeyboard(int c) {
  if (keyboard.length >= c) {
    return keyboard[c];  
  }
  return false;
}
////////VOID/////////////

////MIDI/////////////////
void controllerIn(promidi.Controller controller, int device, int channel){
  numMidi = controller.getNumber();
  valMidi = controller.getValue();
}


//////////////
//CHECK FOLDER
ArrayList imageFiles = new ArrayList();
ArrayList textFiles = new ArrayList();
boolean folderImageIsSelected = true ;
boolean folderFileTextIsSelected = true ;
int countImageSelection, countFileTextSelection ;


// main void
// check what's happen in the selected folder
void checkImageFolder() {
  if(frameCount%180 == 0) {
    countImageSelection++ ;
    imageFiles.clear() ;
    // String path = sketchPath("") +"/" +preferencesPath +"Images" ; 
    String path = preferencesPath +"Images" ;
    
    ArrayList allFiles = listFilesRecursive(path);
  
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
    // show the info name file
    for (int i = 0; i < imageFiles.size(); i++) {
      File f = (File) imageFiles.get(i); 
    }
    // to don't loop with this void
    folderImageIsSelected = false ;
  }
}

void checkFileTextFolder() {
  if(frameCount%180 == 0) {
    countFileTextSelection++ ;
    textFiles.clear() ;
    
    String path = preferencesPath +"Karaoke" ;
    
    ArrayList allFiles = listFilesRecursive(path);
  
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
    // show the info name file
    for (int i = 0; i < textFiles.size(); i++) {
      File f = (File) textFiles.get(i); 
    }
    
    // to don't loop with this void
    folderFileTextIsSelected = false ;
  }
}
// end main void



void initLiveData() {
  imageDropdownList = new String[imageFiles.size()] ;
  for(int i = 0 ; i< imageDropdownList.length ; i++) {
    File f = (File) imageFiles.get(i);
    imageDropdownList[i] = f.getName() ;
    imageDropdownList[i] = imageDropdownList[i].substring(0,imageDropdownList[i].length() -4) ;
  }
  
  //text
  fileTextDropdownList = new String[textFiles.size()] ;
  for(int i = 0 ; i< fileTextDropdownList.length ; i++) {
    File f = (File) textFiles.get(i);
    fileTextDropdownList[i] = f.getName() ;
    fileTextDropdownList[i] = fileTextDropdownList[i].substring(0, fileTextDropdownList[i].length() -4) ;
  }
}




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




/////////
// CREDIT
boolean insideNameversion ;
void credit() {
  if(mouseX > 2 && mouseX < 160 && mouseY > 3 && mouseY < 26 ) insideNameversion = true ; else insideNameversion = false ;
  if(insideNameversion && mousePressed) {
    String credit[] = loadStrings("credit.txt");
    
    fill(grisNoir,225) ; 
    int startBloc = 24 ;
    rect(0, startBloc, width, height - startBloc -9 ) ; // //GROUP ZERO
    for (int i = 0 ; i < credit.length; i++) {
      textFont(textUsual_3) ;
      fill(blanc) ;
      text(credit[i], 10,startBloc + 12 + ((i+1)*14));
    }
  }
}
// END CREDIT