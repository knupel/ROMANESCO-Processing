









String input_ref;
String input_media_ref;
String input_image_ref;
String input_shape_ref;
String input_text_ref;
String input_movie_ref;

void add_media() {
  boolean any_input_is = false;
  if(input_use_is() && !input_path().equals(input_ref)) {
    input_ref = input_path();
    add_media(input_path());
    input_use(false);
    any_input_is = true;
  }

  if(input_use_is("media") && input_path("media") != null && !input_path("media").equals(input_media_ref)) {
    input_media_ref = input_path("media");
    add_media(input_media_ref);
    input_use("media",false);
    any_input_is = true;
  }

  if(input_use_is("image") && input_path("image") != null && !input_path("image").equals(input_image_ref)) {
    input_image_ref = input_path("image");
    add_media(input_image_ref);
    input_use("image",false);
    any_input_is = true;
  }

  if(input_use_is("shape") && input_path("shape") != null &&  !input_path("shape").equals(input_shape_ref)) {
    input_shape_ref = input_path("shape");
    add_media(input_shape_ref);
    input_use("shape",false);
    any_input_is = true;
  }

  if(input_use_is("text") && input_path("text") != null && !input_path("text").equals(input_text_ref)) {
    input_text_ref = input_path("text");
    add_media(input_text_ref);
    input_use("text",false);
    any_input_is = true;
  }

  if(input_use_is("movie") && input_path("movie") != null &&  !input_path("movie").equals(input_movie_ref)) {
    input_movie_ref = input_path("movie");
    add_media(input_movie_ref);
    input_use("movie",false);
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




