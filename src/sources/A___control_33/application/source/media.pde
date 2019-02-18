/**
ADD MEDIA
v 0.1.1
*/
String input_ref;
void add_media() {
  if(load_media_input && input() != null && !input().equals(input_ref)) {
    input_ref = input();
    add_media(input());
    load_media_input = false;
    autosave();  
  }

  if(load_media_folder) { 
    boolean explore_sub_folder = false;
    explore_folder(folder(),explore_sub_folder,
                            "mov","MOV","AVI","AVI","mkv","MKV","mp4","MP4",
                            "jpeg","JPEG","jpg","jpeg","tif","TIF","tiff","TIFF","tga","TGA","gif","GIF",
                            "txt","TXT",
                            "svg","SVG");
    if(get_files() != null && get_files().size() > 0) {
      for(File f : get_files()) {
        println(f.getAbsolutePath());
        add_media(f.getAbsolutePath());
      }
      load_media_folder = false;
      get_files().clear();
    }
    autosave();  
  }
}





void update_media() {
  //text
  file_text_dropdown_list = new String[text_files.size()] ;
  for(int i = 0 ; i< file_text_dropdown_list.length ; i++) {
    File f = (File) text_files.get(i);
    file_text_dropdown_list[i] = naming_media_file(f);
  }

  // bitmap
  bitmap_dropdown_list = new String[bitmap_files.size()] ;
  for(int i = 0 ; i< bitmap_dropdown_list.length ; i++) {
    File f = (File) bitmap_files.get(i);
    bitmap_dropdown_list[i] = naming_media_file(f);
  }

  // shape
  shape_dropdown_list = new String[svg_files.size()] ;
  for(int i = 0 ; i< shape_dropdown_list.length ; i++) {
    File f = (File) svg_files.get(i);
    shape_dropdown_list[i] = naming_media_file(f);
  }

  // Movie
  movie_dropdown_list = new String[movie_files.size()] ;
  for(int i = 0 ; i < movie_dropdown_list.length ; i++) {
    File f = (File) movie_files.get(i);
    movie_dropdown_list[i] = naming_media_file(f);
  }
}


String naming_media_file(File f) {
  String name = f.getName();
  String ext = extension(name);
  String remove = "."+ext;
  name = name.replace(remove,"");
  if(name.length() > 13) {
    String begin = name.substring(0,6);
    String end = name.substring(name.length() -4);
    name = begin+"..."+end;
    // check for dead link
  }
  if(!f.exists()) {
    name = "<"+name+ ">";
  }
  return name;
}
