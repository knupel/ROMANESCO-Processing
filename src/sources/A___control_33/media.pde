









String input_ref;
String input_media_ref;
String input_image_ref;
String input_shape_ref;
String input_text_ref;
String input_movie_ref;

void add_media() {
  boolean any_input_is = false;
  if(input_is() && !input().equals(input_ref)) {
    input_ref = input();
    add_media(input());
    input_is(false);
    any_input_is = true;
  }

  if(input_is("media") && input("media") != null && !input("media").equals(input_media_ref)) {
    input_media_ref = input("media");
    add_media(input_media_ref);
    input_is("media",false);
    any_input_is = true;
  }

  if(input_is("image") && input("image") != null && !input("image").equals(input_image_ref)) {
    input_image_ref = input("image");
    add_media(input_image_ref);
    input_is("image",false);
    any_input_is = true;
  }

  if(input_is("shape") && input("shape") != null &&  !input("shape").equals(input_shape_ref)) {
    input_shape_ref = input("shape");
    add_media(input_shape_ref);
    input_is("shape",false);
    any_input_is = true;
  }

  if(input_is("text") && input("text") != null && !input("text").equals(input_text_ref)) {
    input_text_ref = input("text");
    add_media(input_text_ref);
    input_is("text",false);
    any_input_is = true;
  }

  if(input_is("movie") && input("movie") != null &&  !input("movie").equals(input_movie_ref)) {
    input_movie_ref = input("movie");
    add_media(input_movie_ref);
    input_is("movie",false);
    any_input_is = true;
  }

  if(any_input_is) {
    autosave();  
  }

  if(folder_input_default_is()) {
    boolean explore_sub_folder = false;
    explore_folder(folder(),explore_sub_folder,
                            "mov","avi","mkv","mp4",
                            "jpeg","jpg","tif","tiff","tga","gif","png",
                            "txt",
                            "svg");
    if(get_files() != null && get_files().size() > 0) {
      for(File f : get_files()) {
        println(f.getAbsolutePath());
        add_media(f.getAbsolutePath());
      }
      folder_is(false);
      get_files().clear();
    }
    autosave();  
  }
}





void update_media() {
  //text
  file_text_dropdown_list = new String[text_files.size()];
  for(int i = 0 ; i< file_text_dropdown_list.length ; i++) {
    File f = (File)text_files.get(i);
    file_text_dropdown_list[i] = naming_media_file(f);
  }

  // bitmap
  bitmap_dropdown_list = new String[bitmap_files.size()];
  for(int i = 0 ; i< bitmap_dropdown_list.length ; i++) {
    File f = (File)bitmap_files.get(i);
    bitmap_dropdown_list[i] = naming_media_file(f);
  }

  // shape
  shape_dropdown_list = new String[svg_files.size()];
  for(int i = 0 ; i< shape_dropdown_list.length ; i++) {
    File f = (File)svg_files.get(i);
    shape_dropdown_list[i] = naming_media_file(f);
  }

  // Movie
  movie_dropdown_list = new String[movie_files.size()];
  for(int i = 0 ; i < movie_dropdown_list.length ; i++) {
    File f = (File)movie_files.get(i);
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
    String end = name.substring(name.length() - 4);
    name = begin + "..." + end;
    // check for dead link
  }
  if(!f.exists()) {
    name = "<"+name+ ">";
  }
  return name;
}




