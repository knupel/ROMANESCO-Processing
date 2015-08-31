
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
/////////////








// VIDEO CAMERA MENU
////////////////////
import processing.video.*;
Capture cam;
String[] cameras, cam_name ;
int[] cam_width, cam_height, cam_fps ;

void list_cameras_controller() {
  cameras = Capture.list();
  cam_name = new String[cameras.length] ;
  cam_width = new int[cameras.length] ;
  cam_height = new int[cameras.length] ;
  cam_fps = new int[cameras.length] ;
  
  // about the camera
  if (cameras.length != 0) {
    println("Available cameras:");
    for(int i = 0 ; i < cameras.length ; i++) {
      String cam_data [] = split(cameras[i],",") ;
      // camera name
      cam_name[i] = cam_data [0].substring(5,cam_data[0].length()) ;
      // size camera
      String size = cam_data [1].substring(5,cam_data[1].length()) ;
      String [] sizeXY = split(size,"x") ;
      cam_width[i] = Integer.parseInt(sizeXY[0]) ;
      cam_height[i] = Integer.parseInt(sizeXY[1]) ; 
      // fps
      String fps = cam_data [2].substring(4,cam_data[2].length()) ;
      cam_fps[i] = Integer.parseInt(fps) ;
      // info
      println(i, cam_name [i], cam_width[i] +"x" +cam_height[i], cam_fps[i]) ;
    }
  } else {
    println("There are no cameras available for capture.");
  }
}


void change_camera_name() {
  for(int i = 0 ; i < cameras.length ; i++ ) {
    if(research_in_String("FaceTime", cam_name[i])) cam_name[i] = "Internal Camera" ; else cam_name[i] = "External Camera" ;
  }
}


void check_camera_device() {
  //camera
  list_cameras_controller() ;
  change_camera_name() ;
  // num of camera available for the user
  int num_cam_video = 0 ;
  for(int i = 0 ; i < cam_name.length ; i++) {
    if(cam_fps[i] >= 30 && cam_width[i] > 100 ) num_cam_video += 1 ;
  }

  cameraVideoDropdownList = new String[num_cam_video] ;
  int which_cam_video = 0 ;

  for(int i = 0 ; i < cam_name.length ; i++) {
    if(cam_fps[i] >= 30 && cam_width[i] > 100 ) {
      cameraVideoDropdownList[which_cam_video] = cam_name[i] + " | " + cam_width[i]+"x"+ cam_height[i]+" | " + cam_fps[i] + " fps" ;
      println(cameraVideoDropdownList[which_cam_video], cameraVideoDropdownList.length) ;
      which_cam_video += 1 ;
    }
  }
}




// END VIDEO CAMERA MENU
/////////////////////////















/////////////////////////////
////// KEYBOARD ////////////
boolean checkKeyboard(int c) {
  if (keyboard.length >= c) {
    return keyboard[c];  
  }
  return false;
}
// END KEYBOARD
///////////////





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