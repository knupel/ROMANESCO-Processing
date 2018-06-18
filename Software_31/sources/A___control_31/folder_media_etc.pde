/**
CHECK FOLDER
*/
ArrayList text_files = new ArrayList();
ArrayList bitmap_files = new ArrayList();
ArrayList svg_files = new ArrayList();
ArrayList movie_files = new ArrayList();


boolean folder_image_bitmap_selected = true ;
boolean folder_image_svg_selected = true ;
boolean folder_movie_selected = true ;
boolean folder_text_selected = true ;

void check_media_folder() {
  check_filter();
  check_file_text_folder();
  check_image_bitmap_folder();
  check_image_svg_folder();
  check_movie_folder();
}


void check_filter() {
  if(filter_dropdown_list == null) {
    String path = preference_path +"shader/shader_filter/filter_name.txt";
    String [] s = loadStrings(path);
    filter_dropdown_list = split(s[0],",");
  }
}

// main void
// check what's happen in the selected folder
void check_image_bitmap_folder() {
  if(frameCount%180 == 0) {
    bitmap_files.clear() ;
    String path = import_path +"bitmap";
    
    ArrayList allFiles = listFilesRecursive(path);
  
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("PNG") || lastThree.equals("png") || lastThree.equals("JPG") || lastThree.equals("jpg") || lastThree.equals("GIF") || lastThree.equals("gif")) {
          bitmap_files.add(f);
        }
      }
    }
    // show the info name file
    for (int i = 0; i < bitmap_files.size(); i++) {
      File f = (File) bitmap_files.get(i); 
    }
    // to don't loop with this void
    folder_image_bitmap_selected = false ;
  }
}

void check_image_svg_folder() {
  if(frameCount%180 == 0) {
    svg_files.clear() ;
    String path = import_path +"svg" ;
    
    ArrayList allFiles = listFilesRecursive(path);
  
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("SVG") || lastThree.equals("svg")) {
          svg_files.add(f);
        }
      }
    }
    // show the info name file
    for (int i = 0; i < svg_files.size(); i++) {
      File f = (File) svg_files.get(i); 
    }
    // to don't loop with this void
    folder_image_svg_selected = false ;
  }
}

void check_movie_folder() {
  if(frameCount%180 == 0) {
    movie_files.clear() ;
    String path = import_path +"movie" ;
    
    ArrayList allFiles = listFilesRecursive(path);
  
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("MOV") || lastThree.equals("mov")) {
          movie_files.add(f);
        }
      }
    }
    // show the info name file
    for (int i = 0; i < movie_files.size(); i++) {
      File f = (File) movie_files.get(i); 
    }
    // to don't loop with this void
    folder_movie_selected = false ;
  }
}

void check_file_text_folder() {
  if(frameCount%180 == 0) {
    text_files.clear() ;
    
    String path = import_path +"Karaoke" ;
    
    ArrayList allFiles = listFilesRecursive(path);
  
    String fileName = "";
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        String lastThree = fileName.substring(fileName.length()-3, fileName.length());
        if (lastThree.equals("TXT") || lastThree.equals("txt")) {
          text_files.add(f);
        }
      }
    }
    // show the info name file
    for (int i = 0; i < text_files.size(); i++) {
      File f = (File) text_files.get(i); 
    }
    
    // to don't loop with this void
    folder_text_selected = false ;
  }
}



void update_media() {
  //text
  file_text_dropdown_list = new String[text_files.size()] ;
  for(int i = 0 ; i< file_text_dropdown_list.length ; i++) {
    File f = (File) text_files.get(i);
    file_text_dropdown_list[i] = f.getName() ;
    file_text_dropdown_list[i] = file_text_dropdown_list[i].substring(0, file_text_dropdown_list[i].length() -4) ;
  }
  // bitmap
  bitmap_dropdown_list = new String[bitmap_files.size()] ;
  for(int i = 0 ; i< bitmap_dropdown_list.length ; i++) {
    File f = (File) bitmap_files.get(i);
    bitmap_dropdown_list[i] = f.getName() ;
    bitmap_dropdown_list[i] = bitmap_dropdown_list[i].substring(0,bitmap_dropdown_list[i].length() -4) ;
  }

  // shape
  shape_dropdown_list = new String[svg_files.size()] ;
  for(int i = 0 ; i< shape_dropdown_list.length ; i++) {
    File f = (File) svg_files.get(i);
    shape_dropdown_list[i] = f.getName() ;
    shape_dropdown_list[i] = shape_dropdown_list[i].substring(0,shape_dropdown_list[i].length() -4) ;
  }

  // Movie
  movie_dropdown_list = new String[movie_files.size()] ;
  for(int i = 0 ; i < movie_dropdown_list.length ; i++) {
    File f = (File) movie_files.get(i);
    movie_dropdown_list[i] = f.getName() ;
    movie_dropdown_list[i] = movie_dropdown_list[i].substring(0,movie_dropdown_list[i].length() -4) ;
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
  } else {
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