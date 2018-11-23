/*
MANAGE MEDIA
v 1.0.0
*/
void media_init_path() {
  update_movie_path();
  update_svg_path();
  update_text_path();
  update_bitmap_path();
}
void media_update(int frequence) {
  if(frameCount%frequence == 0) {
    update_movie_path();
    update_svg_path();
    update_text_path();
    update_bitmap_path();
    thread("load_autosave");
  }
}


/**
svg
*/
ROPE_svg[] svg_import;
String svg_current_path;
String [] svg_path;
void load_svg(int id) {
  // which_bitmap is the int return from the dropdown menu
  if(which_shape[id] > svg_path.length ) which_shape[id] = 0;

  if(svg_path != null && svg_path.length > 0 && which_shape[id] < svg_path.length && svg_path[which_shape[id]] != null) {
    svg_current_path = svg_path[which_shape[id]];
    if(!svg_current_path.equals(svg_path_ref[id])) {
      svg_import[id] = new ROPE_svg(this, svg_current_path, "bricks");
    }
    svg_path_ref[id] = svg_current_path;
  }
}

void update_svg_path() {
  svg_path = new String[svg_files.size()];
  for (int i = 0; i < svg_files.size(); i++) {
    File f = (File) svg_files.get(i);
    if(f.exists()) {
      svg_path[i] = f.getAbsolutePath();
    }   
  }
}

void change_svg_from_pad(int ID) {
  which_shape[ID] = pad_inc(which_shape[ID],UP);
  which_shape[ID] = pad_inc(which_shape[ID],DOWN);
  which_shape[ID] = pad_inc(which_shape[ID],RIGHT);
  which_shape[ID] = pad_inc(which_shape[ID],LEFT);

  if(which_shape[ID] < 0) {
    which_shape[ID] = svg_path.length -1;
  } else if (which_shape[ID] >= svg_path.length) {
     which_shape[ID] = 0;
  }
}





/**
text
*/
String[] text_import ;
String [] text_path;
void load_txt(int id) {
  // which_text is the int return from the dropdown menu
  if(text_path != null && text_path.length > 0 && which_text[id] < text_path.length && text_path[which_text[id]] != null) {
    if(which_text[id] > text_path.length ) which_text[id] = 0;
    text_import[id] = importText(text_path[which_text[id]]);
  } else {
    text_import[id] = "Big Brother has been burning all books.\nCheck the controller if there is any text imported";
  }    
}


void update_text_path() {
  text_path = new String[text_files.size()] ;
  for (int i = 0; i < text_files.size(); i++) {
    File f = (File) text_files.get(i);
    if(f.exists()) {
      text_path[i] = f.getAbsolutePath();
    }   
  }
}

void change_text_from_pad(int ID) {
  which_text[ID] = pad_inc(which_text[ID],UP);
  which_text[ID] = pad_inc(which_text[ID],DOWN);
  which_text[ID] = pad_inc(which_text[ID],RIGHT);
  which_text[ID] = pad_inc(which_text[ID],LEFT);

  if(which_text[ID] < 0) {
    which_text[ID] = text_path.length -1;
  } else if (which_text[ID] >= text_path.length) {
     which_text[ID] = 0;
  }
}






/**
bitmap
*/
PImage[] bitmap ;
String [] bitmap_path ;
void load_bitmap(int id) {
  if(which_bitmap[id] > bitmap_path.length) {
    which_bitmap[id] = 0;
  }
  if(bitmap_path != null && bitmap_path.length > 0 && which_bitmap[id] < bitmap_path.length && bitmap_path[which_bitmap[id]] != null) {
    String bitmap_current_path = bitmap_path[which_bitmap[id]];
    if(!bitmap_current_path.equals(bitmap_path_ref[id])) {
      bitmap[id] = loadImage(bitmap_current_path);
    }
    bitmap_path_ref[id] = bitmap_current_path;
  }
}

void update_bitmap_path() {
  bitmap_path = new String[bitmap_files.size()] ;
  for (int i = 0; i < bitmap_files.size(); i++) {
    File f = (File) bitmap_files.get(i);
    if(f.exists()) {
      bitmap_path[i] = f.getAbsolutePath();
    }   
  }
}


void change_bitmap_from_pad(int ID) {
  which_bitmap[ID] = pad_inc(which_bitmap[ID],UP);
  which_bitmap[ID] = pad_inc(which_bitmap[ID],DOWN);
  which_bitmap[ID] = pad_inc(which_bitmap[ID],RIGHT);
  which_bitmap[ID] = pad_inc(which_bitmap[ID],LEFT);

  if(which_bitmap[ID] < 0) {
    which_bitmap[ID] = bitmap_path.length -1;
  } else if (which_bitmap[ID] >= bitmap_path.length) {
     which_bitmap[ID] = 0;
  }
}






/**
movie 
*/
void load_movie(boolean change_movie_is, int id) {
  boolean new_movie_is = check_for_new_movie();
  if(movie_path.length > 0 && which_movie[id] < movie_path.length && (new_movie_is || change_movie_is)) {
    setting_movie(id,movie_path[which_movie[id]]);
  }  
}


void change_movie_from_pad(int ID) {
  which_movie[ID] = pad_inc(which_movie[ID],UP);
  which_movie[ID] = pad_inc(which_movie[ID],DOWN);
  which_movie[ID] = pad_inc(which_movie[ID],RIGHT);
  which_movie[ID] = pad_inc(which_movie[ID],LEFT);

  if(which_movie[ID] < 0) {
    which_movie[ID] = movie_path.length -1;
  } else if (which_movie[ID] >= movie_path.length) {
    which_movie[ID] = 0;
  }
}








float [] movie_time;
String [] movie_path;
String [] movie_path_ref;
boolean check_for_new_movie() {
  boolean new_movie_is = false;
  if(movie_path_ref == null || movie_path_ref.length != movie_path.length) {
    new_movie_is = true;
    movie_path_ref = new String[movie_path.length];
    movie_time = new float[movie_path.length];
  }
  
  // in case there a same quantity of ref we must check if the path ref is the same
  if(!new_movie_is)
  for(int i = 0 ; i < movie_files.size() ; i++) {
    try {
      new_movie_is = !movie_path_ref[i].equals(movie_path[i]);
    }
    catch (ArrayIndexOutOfBoundsException e) {
      printErrTempo(60,"boolean check_for_new_movie() catch: ArrayIndexOutOfBoundsException");

    }
    catch(Exception e){
        printErrTempo(60,"boolean check_for_new_movie() catch: Some Other exception");
     }
    
    if(new_movie_is) {
      break;
    }
  }

  // in case there is a new movie make a new ref path
  if(new_movie_is) {
    for(int i = 0 ; i < movie_files.size() ; i++) {
      movie_path_ref[i] = movie_path[i];
    }
  }
  return new_movie_is;
}


void update_movie_path() {
  if(movie_path == null || movie_path.length != movie_files.size()) {
    movie_path = new String[movie_files.size()] ;
  }
  for (int i = 0; i < movie_files.size(); i++) {
    File f = (File) movie_files.get(i);
    if(f.exists()) {
      movie_path[i] = f.getAbsolutePath();
    }   
  }
}


// Movie Manager
void setting_movie(int id, String path) {
  if(movie[id] != null) {
    movie[id].stop();
  }
  if(ext(path,"mov") || ext(path,"MOV") || ext(path,"avi") || ext(path,"AVI") || ext(path,"mp4") || ext(path,"MP4") || ext(path,"mkv") || ext(path,"MKV")) {
    movie[id] = new Movie(this,path);
    movie[id].loop();
    movie[id].pause();
  } else {
    printErrTempo(240,"ROMANESCO don't find the movie:",id,path);
  }
}

void movieEvent(Movie m) {
  m.read(); 
}

/*
void classic_movie(int id, int place, boolean full_width, boolean full_height) {
  int pos_x = 0;
  int pos_y = 0;
  int size_x = movie[id].width;
  int size_y = movie[id].height;

  // Size in the Scene
  if(full_width && full_height) {
    size_x = width;
    size_y = height;
  } else if(!full_width && !full_height) {
    size_x = movie[id].width;
    size_y = movie[id].height;
  } else if(full_width && !full_height) {
    size_x = width;
    float ratio = (float)width / (float)movie[id].width ;
    size_y = int(movie[id].height *ratio);
  } else if(!full_width && full_height) {
    size_y = height ;
    float ratio = (float)height / (float)movie[id].height ;
    size_x = int(movie[id].width *ratio) ;
  }
  
  // position in the Scene
  if(place == CENTER) {
    pos_x = width/2 - (size_x/2) ;
    pos_y = height/2  - (size_y/2);
  }

  // show movie
  image(movie[id], pos_x, pos_y, size_x, size_y) ;
}
*/















































/**
TEXT MANAGER
*/
String importRaw [];
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