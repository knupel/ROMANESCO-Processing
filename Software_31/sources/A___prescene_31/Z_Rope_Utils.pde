/**
Rope UTILS 
v 1.45.3
* Copyleft (c) 2014-2018 
* Stan le Punk > http://stanlepunk.xyz/
Rope – Romanesco Processing Environment – 
Processing 3.3.7
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/




/**
print Constants
v 0.0.3
*/
Constant_list processing_constants_list = new Constant_list(PConstants.class);
Constant_list rope_constants_list = new Constant_list(Rope_Constants.class);
public void print_constants_rope() {
  if(rope_constants_list == null) {
    rope_constants_list = new Constant_list(Rope_Constants.class);
  }
  println("ROPE CONSTANTS");
  for(String s: rope_constants_list.list()){
    println(s);
  }
}

public void print_constants_processing() {
  if(processing_constants_list == null) {
    processing_constants_list = new Constant_list(PConstants.class);
  }
  println("PROCESSING CONSTANTS");
  for(String s: processing_constants_list.list()){
    println(s);
  }
} 

public void print_constants() {
  if(processing_constants_list == null) {
    processing_constants_list = new Constant_list(PConstants.class);
  }

  if(rope_constants_list == null) {
    rope_constants_list = new Constant_list(Rope_Constants.class);
  }

  println("ROPE CONSTANTS");
  for(String s: rope_constants_list.list()){
    println(s);
  }
  println();
  println("PROCESSING CONSTANTS");
  for(String s: processing_constants_list.list()){
    println(s);
  }
} 

/*
* class to list the interface stuff
*/
class Constant_list {
  Field[] classFields; 
  Constant_list(Class c){
    classFields = c.getFields();
  }
  ArrayList<String> list() {
    ArrayList<String> slist = new ArrayList();
    // for each constant
    for (Field f : classFields) {
      String s = "";
      // object type
      s = s + "(" + f.getType() + ")";
      // field name
      s = s + " " + f.getName();
      // value
      try {
        s = s + ": " + f.get(null);
      } 
      catch (IllegalAccessException e) {
      }
      // Optional special handling for field types:
      if (f.getType().equals(int.class)) {
        // ...
      }
      if (f.getType().equals(float.class)) {
        // ...
      }
      slist.add(s);
    }
    return(slist);
  }
}



















/**
FOLDER & FILE MANAGER
v 0.2.1.1
*/
/*
INPUT PART
*/
String selected_path_input = null;
boolean input_selected_is;

void select_input() {
  select_input("");
}

void select_input(String message) {
  // folder_selected_is = true ;
  selectInput(message, "input_selected");
}

void input_selected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Input path is:" +selection.getAbsolutePath());
    selected_path_input = selection.getAbsolutePath();
    input_selected_is = true;
  }
}

boolean input_selected_is() {
  return input_selected_is;
}

void reset_input_selection() {
  input_selected_is = false;
}

String selected_path_input() {
  return selected_path_input;
}


/*
FOLDER PART
*/
String selected_path_folder = null;
boolean folder_selected_is;

void select_folder() {
  select_folder("");
}

void select_folder(String message) {
  selectFolder(message, "folder_selected");
}


/**
* this method is called by method select_folder(), and the method name must be the same as named
*/
void folder_selected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Folder path is:" +selection.getAbsolutePath());
    selected_path_folder = selection.getAbsolutePath();
    folder_selected_is = true;
  }
}


boolean folder_selected_is() {
  return folder_selected_is;
}

void reset_folder_selection() {
  folder_selected_is = false;
}

String selected_path_folder() {
  return selected_path_folder;
}


// check what's happen in the selected folder
ArrayList <File> files;
int count_selection;

void set_media_list() {
  if(files == null) files = new ArrayList<File>(); else files.clear();
}



ArrayList<File> get_files() {
  return files ;
}


String [] get_files_sort() {
  if(files != null) {
    String [] list = new String [files.size()];
    for(int i = 0 ; i < get_files().size() ; i++) {
      File f = get_files().get(i);
      list[i] = f.getAbsolutePath();
    }
    Arrays.sort(list);
    return list;

  } else return null ;

}

void explore_folder(String path_folder, String... extension) {
  explore_folder(path_folder, false, extension);

}

void explore_folder(String path, boolean check_sub_folder, String... extension) {
  if((folder_selected_is || input_selected_is) && path != ("")) {
    count_selection++ ;
    set_media_list();
 
    ArrayList allFiles = list_files(path, check_sub_folder);
  
    String fileName = "";
    int count_pertinent_file = 0 ;
  
    for (int i = 0; i < allFiles.size(); i++) {
      File f = (File) allFiles.get(i);   
      fileName = f.getName(); 
      // Add it to the list if it's not a directory
      if (f.isDirectory() == false) {
        for(int k = 0 ; k < extension.length ; k++) {
          if (extension(fileName).equals(extension[k])) {
            count_pertinent_file += 1 ;
            println(count_pertinent_file, "/", i, f.getName());
            files.add(f);
          }
        }
      }
    }
    // to don't loop with this void
    folder_selected_is = false ;
    input_selected_is = false ;
  }
}




// Method to get a list of all files in a directory and all subdirectories
ArrayList list_files(String dir, boolean check_sub_folder) {
  ArrayList fileList = new ArrayList(); 
  if(check_sub_folder) { 
    explore_directory(fileList, dir);
  } else {
    if(folder_selected_is) {
      File file = new File(dir);
      File[] subfiles = file.listFiles();
      for(int i = 0 ; i < subfiles.length ; i++) {
        fileList.add(subfiles[i]);
      }
    } else if(input_selected_is) {
      File file = new File(dir);
      fileList.add(file);
    }
  }
  return fileList;
}

// Recursive function to traverse subdirectories
void explore_directory(ArrayList list_file, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    list_file.add(file);  // include directories in the list

    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      explore_directory(list_file, subfiles[i].getAbsolutePath());
    }
  } else {
    list_file.add(file);
  }
}





























/**
SAVE LOAD  FRAME Rope
v 0.3.1
*/
/**
Save Frame
V 0.1.1
*/

void saveFrame(String where, String filename, PImage img) {
  float compression = 1. ;
  saveFrame(where, filename, compression, img) ;
}


void saveFrame(String where, String filename) {
  float compression = 1. ;
  PImage img = null;
  saveFrame(where, filename, compression, img) ;
}



void saveFrame(String where, String filename, float compression) {
  PImage img = null;
  saveFrame(where, filename, compression, img);
}

void saveFrame(String where, String filename, float compression, PImage img) {
  // check if the directory or folder exist, if it's not create the path
  File dir = new File(where)  ;
  dir.mkdir() ;
  // final path with file name adding
  String path = where+"/"+filename ;
  try {
    OutputStream os = new FileOutputStream(new File(path));
    loadPixels(); 
    BufferedImage buff_img;
    if(img == null) {
      buff_img = new BufferedImage(pixelWidth, pixelHeight, BufferedImage.TYPE_INT_RGB);
      buff_img.setRGB(0, 0, pixelWidth, pixelHeight, pixels, 0, pixelWidth);
    } else {
      buff_img = new BufferedImage(img.width, img.height, BufferedImage.TYPE_INT_RGB);
      buff_img.setRGB(0, 0, img.width, img.height, img.pixels, 0, img.width);
    }

    if(path.contains(".bmp") || path.contains(".BMP")) {
      saveBMP(os, buff_img);
    } else if(path.contains(".jpeg") || path.contains(".jpg") || path.contains(".JPG") || path.contains(".JPEG")) {
      saveJPG(os, compression, buff_img);
    }
  }  catch (FileNotFoundException e) {
    //
  }
}

/**
SAVE JPG
v 0.0.1
*/
// classic one
boolean saveJPG(OutputStream output, float compression,  BufferedImage buff_img) {
  compression = truncate(compression, 1);
  if(compression < 0) compression = 0.0f;
  else if(compression > 1) compression = 1.0f;

  try {
    ImageWriter writer = null;
    ImageWriteParam param = null;
    IIOMetadata metadata = null;

    if ((writer = imageioWriter("jpeg")) != null) {
      param = writer.getDefaultWriteParam();
      param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
      param.setCompressionQuality(compression);

      writer.setOutput(ImageIO.createImageOutputStream(output));
      writer.write(metadata, new IIOImage(buff_img, null, metadata), param);
      writer.dispose();
      output.flush();
      javax.imageio.ImageIO.write(buff_img, "jpg", output);
    }
    return true ;
  }
  catch(IOException e) {
    e.printStackTrace();
  }
  return false ;
}

ImageWriter imageioWriter(String extension) {
  // code from Processing PImage.java
  Iterator<ImageWriter> iter = ImageIO.getImageWritersByFormatName(extension);
  if (iter.hasNext()) {
    return iter.next();
  }
  return null;
}


/**
SAVE BMP
v 0.3.0.1
*/
// SAVE
boolean saveBMP(OutputStream output, BufferedImage buff_img) {
  try {
    Graphics g = buff_img.getGraphics();
    g.dispose();
    output.flush();
    
    ImageIO.write(buff_img, "bmp", output);
    return true ;
  }
  catch(IOException e) {
    e.printStackTrace();
  }
  return false ;
}

// LOAD
PImage loadImageBMP(String fileName) {
  PImage img = null;

  try {
    InputStream is = createInput(fileName);
    BufferedImage buff_img = ImageIO.read(is);
    int[] pix = buff_img.getRGB(0, 0, buff_img.getWidth(), buff_img.getHeight(), null, 0, buff_img.getWidth());
    img = createImage(buff_img.getWidth(),buff_img.getHeight(), RGB);
    // println("Componenent", buff_img.getColorModel().getNumComponents()) ;
    img.pixels = pix;   

    // in case the picture is in grey value...to set the grey because this one is very very bad
    // I don't find any solution to solve it...
    // any idea ?
    if(buff_img.getColorModel().getNumComponents() == 1) {
      float ratio_brightness = .95;
      for(int i = 0 ; i < img.pixels.length ; i++) {     
        colorMode(HSB);
        float b = brightness(img.pixels[i]) *ratio_brightness ;
        img.pixels[i] = color(0,0,b);
        colorMode(RGB);
      }
    }
  }
  catch(IOException e) {
  }

  if(img != null) {
    return img;
  } else {
    return null ;
  }
}
























/**
ROPE IMAGE
v 0.5.1
*/
/**
PImage manager library
v 0.4.2
*/
class ROPImage_Manager {
  ArrayList<ROPImage> library ;
  int which_img;

  private void build() {
    if(library == null) {
      library = new ArrayList<ROPImage>();
    }
  }

  public void load(String... path_img) {
    build();
    for(int i = 0 ; i <path_img.length ; i++) {
      //Image img = loadImage(img_src[i]);
      ROPImage rop_img = new ROPImage(path_img[i]);
      //println(img.width, img_src[i]);
      library.add(rop_img);
    }  
  }

  public void add(PImage img_src) {
    build();
    ROPImage rop_img = new ROPImage(img_src);
    library.add(rop_img);
  }

  public void add(PImage img_src, String name) {
    build();
    ROPImage rop_img = new ROPImage(img_src, name);
    library.add(rop_img);
  }

  public void clear() {
    if(library != null) {
      library.clear();
    }
  }

  public ArrayList<ROPImage> list() {
    return library;
  }

  public void select(int which_one) {
    which_img = which_one ;
  }

  public void select(String target_name) {
    if(library.size() > 0) {
      for(int i = 0 ; i < library.size() ; i++) {
        if(target_name.equals(library.get(i).name)) {
          which_img = i ;
          break ;
        }
      }
    } else {
      printErr("the String target name don't match with any name of image library") ;
    }
  }


  public int size() {
    if(library != null) {
      return library.size() ;
    } else return -1 ;  
  }

  public void set(PImage src_img, int target) {
    build();
    if(target < library.size()) {
      if(src_img.width == get(target).width && src_img.height == get(target).height){
        get(target).pixels = src_img.pixels ;
        get(target).updatePixels();
      } else {
        get(target).resize(src_img.width, src_img.height);
        get(target).pixels = src_img.pixels ;
        get(target).updatePixels();
      }
    } else {
      printErr("Neither target image match with your request");
    }
  }

  public void set(PImage src_img, String target_name) {
    build();
    if(library.size() > 0) {
      if(src_img.width == get(target_name).width && src_img.height == get(target_name).height){
        get(target_name).pixels = src_img.pixels ;
        get(target_name).updatePixels();
      } else {
        get(target_name).resize(src_img.width, src_img.height);
        get(target_name).pixels = src_img.pixels ;
        get(target_name).updatePixels();
      }
    } else {
      printErr("Neither target image match with your request");
    }
  }

  public String get_name() {
    return get_name(which_img);
  }

  public String get_name(int target) {
    if(library != null && library.size() > 0) {
      if(target < library.size()) {
        return library.get(target).get_name() ;
      } else return null ;
    } else return null ;
  }



  public int get_rank(String target_name) {
    if(library != null && library.size() > 0) {
      int rank = 0 ;
      for(int i = 0 ; i < library.size() ; i++) {
        String final_name = target_name.split("/")[target_name.split("/").length -1].split("\\.")[0] ;
        if(final_name.equals(library.get(i).name) ) {
          rank = i ;
          break;
        } 
      }
      return rank;
    } else return -1;
  }


  public PImage get() {
    if(library != null && library.size() > 0 ) {
      if(which_img < library.size()) return library.get(which_img).img; 
      else return library.get(0).img; 
    } else return null ;
  }

  public PImage get(int target){
    if(library != null && target < library.size()) {
      return library.get(target).img;
    } else return null;
  }

  public PImage get(String target_name){
    if(library.size() > 0) {
      int target = 0 ;
      for(int i = 0 ; i < library.size() ; i++) {
        String final_name = target_name.split("/")[target_name.split("/").length -1].split("\\.")[0] ;
        if(final_name.equals(library.get(i).name) ) {
          target = i ;
          break;
        } 
      }
      return get(target);
    } else return null;
  }


  // private class
  private class ROPImage {
    private PImage img ;
    private String name = "no name" ;

    private ROPImage(String path) {
      this.name = path.split("/")[path.split("/").length -1].split("\\.")[0] ;
      this.img = loadImage(path);
    }

    private ROPImage(PImage img) {
      this.img = img;
    }

    private ROPImage(PImage img, String name) {
      this.img = img;
      this.name = name;
    }

    public String get_name() {
      return name ;
    }

    public PImage get_image() {
      return img ;
    }
  }
}

/**
resize image
v 0.0.2
*/
/**
* resize your picture proportionaly to the window sketch of the a specificic PGraphics
*/
void image_resize(PImage src) {
  image_resize(src,g,true);
}

void image_resize(PImage src, boolean fullfit) {
  image_resize(src,g,fullfit);
}

void image_resize(PImage src, PGraphics pg, boolean fullfit) {
  float ratio_w = pg.width / (float)src.width;
  float ratio_h = pg.height / (float)src.height;
  if(!fullfit) {
    if(ratio_w > ratio_h) {
      src.resize(ceil(src.width *ratio_w), ceil(src.height *ratio_w));
    } else {
      src.resize(ceil(src.width *ratio_h), ceil(src.height *ratio_h));  
    }
  } else {
    if(ratio_w > ratio_h) {
      src.resize(ceil(src.width *ratio_h), ceil(src.height *ratio_h));
    } else {
      src.resize(ceil(src.width *ratio_w), ceil(src.height *ratio_w));  
    }
  }
}

/**
copy window
v 0.0.1
*/
PImage image_copy_window(PImage src, int where) {
  return image_copy_window(src, g, where);
}

PImage image_copy_window(PImage src, PGraphics pg, int where) {
  int x = 0 ;
  int y = 0 ;
  if(where == CENTER) {
    x = (src.width -pg.width) /2 ;
    y = (src.height -pg.height) /2 ;   
  } else if(where == LEFT) {
    y = (src.height -pg.height) /2 ; 
  } else if(where == RIGHT) { 
    x = src.width -pg.width ;
    y = (src.height -pg.height) /2 ;   
  } else if(where == TOP) {
    x = (src.width -pg.width) /2 ;   
  } else if(where == BOTTOM) { 
    x = (src.width -pg.width) /2 ;
    y = src.height -pg.height;   
  }  
  return src.get(x, y, pg.width, pg.height); 
}




/**
IMAGE
v 0.1.5.0
*/

/**
* additionnal method for image
* @see other method in Vec mini library
*/
void image(PImage img) {
  if(img != null) image(img, 0, 0);
  else printErr("Object PImage pass to method image() is null");
}


void image(PImage img, int where) {
  float x = 0 ;
  float y = 0 ;
  if(where == CENTER) {
    x = (width /2.) -(img.width /2.);
    y = (height /2.) -(img.height /2.);   
  } else if(where == LEFT) {
    x = 0;
    y = (height /2.) -(img.height /2.);
  } else if(where == RIGHT) {
    x = width -img.width;
    y = (height /2.) -(img.height /2.);
  } else if(where == TOP) {
    x = (width /2.) -(img.width /2.);
    y = 0;
  } else if(where == BOTTOM) {
    x = (width /2.) -(img.width /2.);
    y = height -img.height; 
  }
  image(img,x,y);
}

void image(PImage img, float coor) {
  if(img != null) image(img, coor, coor);
  else printErr("Object PImage pass to method image() is null");
}

void image(PImage img, iVec pos) {
  if(pos instanceof iVec2) {
    image(img, Vec2(pos.x, pos.y));
  } else if(pos instanceof iVec3) {
    image(img, Vec3(pos.x, pos.y, pos.z));
  }
}

void image(PImage img, iVec pos, iVec2 size) {
  if(pos instanceof iVec2) {
    image(img, Vec2(pos.x, pos.y), Vec2(size.x, size.y));
  } else if(pos instanceof iVec3) {
    image(img, Vec3(pos.x, pos.y, pos.z), Vec2(size.x, size.y));
  } 
}

void image(PImage img, Vec pos) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    image(img, p.x, p.y) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    start_matrix() ;
    translate(p) ;
    image(img, 0,0) ;
    stop_matrix() ;
  }
}

void image(PImage img, Vec pos, Vec2 size) {
  if(pos instanceof Vec2) {
    Vec2 p = (Vec2) pos ;
    image(img, p.x, p.y, size.x, size.y) ;
  } else if(pos instanceof Vec3) {
    Vec3 p = (Vec3) pos ;
    start_matrix() ;
    translate(p) ;
    image(img, 0,0, size.x, size.y) ;
    stop_matrix() ;
  }
}









/**
* For the future need to use shader to do that...but in the future !
*/
PImage reverse(PImage img) {
  PImage final_img;
  final_img = createImage(img.width, img.height, RGB) ;
  for(int i = 0 ; i < img.pixels.length ; i++) {
    final_img.pixels[i] = img.pixels[img.pixels.length -i -1];
  }
  return final_img ;
}

/**
* For the future need to use shader to do that...but in the future !
*/
PImage mirror(PImage img) {
  PImage final_img ;
  final_img = createImage(img.width, img.height, RGB) ;

  int read_head = 0 ;
  for(int i = 0 ; i < img.pixels.length ; i++) {
    if(read_head >= img.width) {
      read_head = 0 ;
    }
    int reverse_line = img.width -(read_head*2) -1 ;
    int target = i +reverse_line  ;

    if(target < 0 || target >img.pixels.length) println(i, read_head, target) ;
    final_img.pixels[i] = img.pixels[target] ;

    read_head++ ;
  }
  return final_img ;
}

PImage paste(PImage img, int entry, int [] array_pix, boolean vertical_is) {
  if(!vertical_is) {
    return paste_vertical(img, entry, array_pix);
  } else {
    return paste_horizontal(img, entry, array_pix);
  }
}

PImage paste_horizontal(PImage img, int entry, int [] array_pix) { 
  // println("horinzontal", frameCount, entry);
  PImage final_img ;
  final_img = img.copy() ;
  // reduce the array_pix in this one is bigger than img.pixels.length
  if(array_pix.length > final_img.pixels.length) {
     array_pix = Arrays.copyOf(array_pix,final_img.pixels.length) ;
  }

  int count = 0 ;
  int target = 0 ;
  for(int i = entry ; i < entry+array_pix.length ; i++) {
    if(i < final_img.pixels.length) {
      final_img.pixels[i] = array_pix[count];
    } else {
      target = i -final_img.pixels.length ;
      // security length outbound index
      // change the size can happen ArrayIndexOutBound,
      if(target >= final_img.pixels.length) {
        target = final_img.pixels.length -1;
      }
      if(count >= array_pix.length) {
        println("count", count, "array pix length", array_pix.length);
      }
      final_img.pixels[target] = array_pix[count];
    }
    count++ ;
  }
  return final_img ;
}


PImage paste_vertical(PImage img, int entry, int [] array_pix) { 
  PImage final_img;
  final_img = img.copy();
  // reduce the array_pix in this one is bigger than img.pixels.length
  if(array_pix.length > final_img.pixels.length) {
     array_pix = Arrays.copyOf(array_pix,final_img.pixels.length) ;
  }

  int count = 0;
  int target = 0;
  int w = final_img.width;
  int line = 0;

  for(int i = entry ; i < entry+array_pix.length ; i++) {
    int mod = i%w ;
    // the master piece algorithm to change the direction :)
    int where =  entry +(w *(w -(w -mod))) +line;
    if(mod >= w -1) {
      line++;
    }
    if(where < final_img.pixels.length) {
      final_img.pixels[where] = array_pix[count];
    } else {
      target = where -final_img.pixels.length ;
      // security length outbound index
      // change the size can happen ArrayIndexOutBound,
      if(target >= final_img.pixels.length) {
        target = final_img.pixels.length -1;
      }
      if(count >= array_pix.length) {
        println("count", count, "array pix length", array_pix.length);
      }
      final_img.pixels[target] = array_pix[count];
    }
    count++ ;
  }
  return final_img ;
}






/**
SHADER filter
v 0.5.2
few method manipulate image with the shader to don't slower Processing
part
*/
PShader rope_shader_level, rope_shader_mix, rope_shader_blend, rope_shader_overlay, rope_shader_multiply;
PShader rope_shader_gaussian_blur ;
PShader rope_shader_resize ;

String path_shader_filter_rope = "shader/filter/";
void shader_filter_folder_path(String path) {
  path_shader_filter_rope = path;
}

/**
Gaussian blur
pass x2 vertical and horizontal

*/
void blur(PImage tex, float intensity) {
  blur(tex, intensity);
}

void blur(PGraphics p, PImage tex, float intensity) {
  set_blur(intensity) ;
  // temp
  if(temp_gaussian_blur == null) {
    temp_gaussian_blur = createImage(tex.width, tex.height, ARGB);
    tex.loadPixels() ;
    temp_gaussian_blur.pixels = tex.pixels;
    temp_gaussian_blur.updatePixels();
  }
  if(temp_gaussian_blur.width != tex.width || temp_gaussian_blur.height != tex.height) {
    temp_gaussian_blur.resize(tex.width, tex.height);
    tex.loadPixels() ;
    temp_gaussian_blur.pixels = tex.pixels;
    temp_gaussian_blur.updatePixels();
  }

  reset_blur(tex);


  if(rope_shader_gaussian_blur == null) rope_shader_gaussian_blur = loadShader(path_shader_filter_rope+"rope_filter_gaussian_blur.glsl");
  
  if(pass_rope_1 == null) {
    if(p == null) pass_rope_1 = createGraphics(tex.width,tex.height,P2D);
    else pass_rope_1 = createGraphics(p.width,p.height,P2D);
  }
  if(pass_rope_2 == null) {
    if(p == null) pass_rope_2 = createGraphics(tex.width,tex.height,P2D);
    else pass_rope_2 = createGraphics(p.width,p.height,P2D);
  }


  if(p != null) {
    rope_shader_gaussian_blur.set("PGraphics_renderer_is",true);
    float ratio_x = (float)p.width / (float)tex.width ;
    float ratio_y = (float)p.height / (float)tex.height ;
    rope_shader_gaussian_blur.set("wh_renderer_ratio",ratio_x, ratio_y);
  }

  rope_shader_gaussian_blur.set("blurSize", size_gaussian_blur_rope);
  rope_shader_gaussian_blur.set("sigma", sigma_gaussian_blur_rope);


  
  // Applying the blur shader along the vertical direction   
  rope_shader_gaussian_blur.set("horizontalPass", true);
  pass_rope_1.beginDraw();            
  pass_rope_1.shader(rope_shader_gaussian_blur);
  pass_rope_1.image(tex, 0, 0); 
  pass_rope_1.endDraw();

  // Applying the blur shader along the horizontal direction        
  rope_shader_gaussian_blur.set("horizontalPass", false);
   pass_rope_2.beginDraw();            
   pass_rope_2.shader(rope_shader_gaussian_blur);  
   pass_rope_2.image(pass_rope_1, 0, 0);
   pass_rope_2.endDraw(); 

  if(p == null) {
     pass_rope_2.loadPixels() ;
    tex.pixels =  pass_rope_2.pixels ;
    tex.updatePixels() ;
  } else {
     pass_rope_2.loadPixels();
    p.pixels =  pass_rope_2.pixels;
    p.updatePixels();

  }
}

/*
util blur
*/
PGraphics pass_rope_1, pass_rope_2;
PImage temp_gaussian_blur ;
void reset_blur(PImage tex) {
  if(temp_gaussian_blur != null) {
    temp_gaussian_blur.loadPixels() ;
    tex.pixels = temp_gaussian_blur.pixels;
    tex.updatePixels();
  }
}

int size_gaussian_blur_rope = 7 ;
float sigma_gaussian_blur_rope = 3f ;

void set_blur(float intensity) {
  size_gaussian_blur_rope = floor(intensity) ;
  sigma_gaussian_blur_rope = intensity *.5 ;
}







  
/**
multiply

*/
/**
* size
*/
/**
void multiply_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_multiply == null) rope_shader_multiply = loadShader("shader/filter/rope_filter_multiply.glsl");
  rope_shader_multiply.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}

void multiply_size(int w, int h) {
  if(rope_shader_multiply == null) rope_shader_multiply = loadShader("shader/filter/rope_filter_multiply.glsl");
  rope_shader_multiply.set("wh_renderer_ratio",1f/w, 1f/h);
}
*/

void set_multiply_shader() {
  if(rope_shader_multiply == null) rope_shader_multiply = loadShader(path_shader_filter_rope+"rope_filter_multiply.glsl");
}
/**
* flip 
*/
void multiply_flip_tex(boolean bx_tex, boolean by_tex) {
  multiply_flip(bx_tex,by_tex,false,false);
}

void multiply_flip_inc(boolean bx_inc, boolean by_inc) {
  multiply_flip(false,false,bx_inc,by_inc);
}

void multiply_flip(boolean bx, boolean by) {
  multiply_flip(bx,by,bx,by);
}

void multiply_flip(boolean bx_tex, boolean by_tex, boolean bx_inc, boolean by_inc) {
  set_multiply_shader();
  rope_shader_multiply.set("flip_tex",bx_tex,by_tex);
  rope_shader_multiply.set("flip_inc",bx_inc,by_inc);
}

/**
* follower method
*/
void multiply(PImage tex, PImage inc) {
  multiply(tex, inc, 1);
}

void multiply(PImage tex, PImage inc, Vec2 ratio) {
  multiply(tex, inc, ratio.x, ratio.y);
}

void multiply(PImage tex, PImage inc, Vec3 ratio) {
  multiply(tex, inc, ratio.x, ratio.y, ratio.z);
}

void multiply(PImage tex, PImage inc, Vec4 ratio) {
  multiply(tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}

void multiply(PImage tex, PImage inc, float... ratio) {
  if(ratio.length == 1) {
    multiply(null, tex, inc, ratio[0]);
  } else if(ratio.length == 2) {
    multiply(null, tex, inc, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    multiply(null, tex, inc, ratio[0], ratio[1], ratio[2]);
  } else {
    multiply(null, tex, inc, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}


/**
* with PGraphics work
*/
void multiply(PGraphics p, PImage tex, PImage inc) {
  multiply(p, tex, inc, 1);
}

void multiply(PGraphics p, PImage tex, PImage inc, Vec2 ratio) {
  multiply(p, tex, inc, ratio.x, ratio.y);
}

void multiply(PGraphics p, PImage tex, PImage inc, Vec3 ratio) {
  multiply(p, tex, inc, ratio.x, ratio.y, ratio.z);
}

void multiply(PGraphics p, PImage tex, PImage inc, Vec4 ratio) {
  multiply(p, tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}
/**
* Master method multiply
* this method have a purpose to blend the four channel color.
* @param Pimage tex, is the image must be back
* @param Pimage inc, is the image must be incrusted on the background picture
* @param float [], Vec2, Vec3 or Vec4 is the normal ratio overlaying
*/
void multiply(PGraphics p, PImage tex, PImage inc, float... ratio) {
  set_multiply_shader();
  
  Vec4 r = array_to_Vec4_rgba(ratio);

  rope_shader_multiply.set("incrustation",inc);
  rope_shader_multiply.set("ratio",r.x,r.z,r.w,r.z);

  if(p == null) {
    rope_shader_multiply.set("texture",tex);
    shader(rope_shader_multiply);
    //g.filter(rope_shader_multiply);
  } else {
    rope_shader_multiply.set("texture_PGraphics",tex);
    rope_shader_multiply.set("PGraphics_renderer_is",true);
    p.filter(rope_shader_multiply);
  }
}
/**
overlay

*/
/**
* size
*/
/**
void overlay_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_overlay == null) rope_shader_overlay = loadShader("shader/filter/rope_filter_overlay.glsl");
  rope_shader_overlay.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}
*/
void set_overlay_shader() {
  if(rope_shader_overlay == null) rope_shader_overlay = loadShader(path_shader_filter_rope+"rope_filter_overlay.glsl");
}
/**
* flip 
*/
void overlay_flip_tex(boolean bx_tex, boolean by_tex) {
  overlay_flip(bx_tex,by_tex,false,false);
}

void overlay_flip_inc(boolean bx_inc, boolean by_inc) {
  overlay_flip(false,false,bx_inc,by_inc);
}

void overlay_flip(boolean bx, boolean by) {
  overlay_flip(bx,by,bx,by);
}

void overlay_flip(boolean bx_tex, boolean by_tex, boolean bx_inc, boolean by_inc) {
  set_overlay_shader();
  rope_shader_overlay.set("flip_tex",bx_tex,by_tex);
  rope_shader_overlay.set("flip_inc",bx_inc,by_inc);
}
/**
* follower method
*/
void overlay(PImage tex, PImage inc) {
  overlay(tex, inc, 1);
}

void overlay(PImage tex, PImage inc, Vec2 ratio) {
  overlay(tex, inc, ratio.x, ratio.y);
}

void overlay(PImage tex, PImage inc, Vec3 ratio) {
  overlay(tex, inc, ratio.x, ratio.y, ratio.z);
}

void overlay(PImage tex, PImage inc, Vec4 ratio) {
  overlay(tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}

void overlay(PImage tex, PImage inc, float... ratio) {
  if(ratio.length == 1) {
    overlay(null, tex, inc, ratio[0]);
  } else if(ratio.length == 2) {
    overlay(null, tex, inc, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    overlay(null, tex, inc, ratio[0], ratio[1], ratio[2]);
  } else {
    overlay(null, tex, inc, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}


/**
* with PGraphics work
*/
void overlay(PGraphics p, PImage tex, PImage inc) {
  overlay(p, tex, inc, 1);
}

void overlay(PGraphics p, PImage tex, PImage inc, Vec2 ratio) {
  overlay(p, tex, inc, ratio.x, ratio.y);
}

void overlay(PGraphics p, PImage tex, PImage inc, Vec3 ratio) {
  overlay(p, tex, inc, ratio.x, ratio.y, ratio.z);
}

void overlay(PGraphics p, PImage tex, PImage inc, Vec4 ratio) {
  overlay(p, tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}
/**
* Master method overlay
* this method have a purpose to blend the four channel color.
* @param Pimage tex, is the image must be back
* @param Pimage inc, is the image must be incrusted on the background picture
* @param float [], Vec2, Vec3 or Vec4 is the normal ratio overlaying
*/
void overlay(PGraphics p, PImage tex, PImage inc, float... ratio) { 
  set_overlay_shader();

  Vec4 r = array_to_Vec4_rgba(ratio);
  
  rope_shader_overlay.set("incrustation",inc);
  rope_shader_overlay.set("ratio",r.x,r.z,r.w,r.z);
  
  if(p == null) {
    rope_shader_overlay.set("texture",tex);
    shader(rope_shader_overlay);
  } else {
    rope_shader_overlay.set("texture_PGraphics",tex);
    rope_shader_overlay.set("PGraphics_renderer_is",true);
    p.filter(rope_shader_overlay);
  }
}






/**
blend

*/
/**
* size
*/
/**
void blend_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_blend == null) rope_shader_blend = loadShader("shader/filter/rope_filter_blend.glsl");
  rope_shader_blend.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}
*/
void set_blend_shader() {
  if(rope_shader_blend == null) rope_shader_blend = loadShader(path_shader_filter_rope+"rope_filter_blend.glsl");
}
/**
* flip 
*/
void blend_flip_tex(boolean bx_tex, boolean by_tex) {
  blend_flip(bx_tex,by_tex,false,false);
}

void blend_flip_inc(boolean bx_inc, boolean by_inc) {
  blend_flip(false,false,bx_inc,by_inc);
}

void blend_flip(boolean bx, boolean by) {
  blend_flip(bx,by,bx,by);
}

void blend_flip(boolean bx_tex, boolean by_tex, boolean bx_inc, boolean by_inc) {
  set_blend_shader();
  rope_shader_overlay.set("flip_tex",bx_tex,by_tex);
  rope_shader_overlay.set("flip_inc",bx_inc,by_inc);
}
/**
* follower method
*/
void blend(PImage tex, PImage inc, float blend, Vec2 ratio) {
  blend(null, tex, inc, blend, ratio.x, ratio.y);
}

void blend(PImage tex, PImage inc, float blend, Vec3 ratio) {
  blend(null, tex, inc, blend, ratio.x, ratio.y, ratio.z);
}

void blend(PImage tex, PImage inc, float blend, Vec4 ratio) {
  blend(null, tex, inc, blend, ratio.x, ratio.y, ratio.z, ratio.w);
}

void blend(PImage tex, PImage inc, float blend, float... ratio) {
  if(ratio.length == 1) {
    blend(null, tex, inc, blend, ratio[0]);
  } else if(ratio.length == 2) {
    blend(null, tex, inc, blend, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    blend(null, tex, inc, blend, ratio[0], ratio[1], ratio[2]);
  } else {
    blend(null, tex, inc, blend, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}


/**
* with PGraphics work
*/
void blend(PGraphics p, PImage tex, float blend, PImage inc) {
  blend(p, tex, inc, blend, 1);
}

void blend(PGraphics p, PImage tex, PImage inc, float blend, Vec2 ratio) {
  blend(p, tex, inc, blend, ratio.x, ratio.y);
}

void blend(PGraphics p, PImage tex, PImage inc, float blend, Vec3 ratio) {
  blend(p, tex, inc, blend, ratio.x, ratio.y, ratio.z);
}

void blend(PGraphics p, PImage tex, PImage inc, float blend, Vec4 ratio) {
  blend(p, tex, inc, blend, ratio.x, ratio.y, ratio.z, ratio.w);
}




/**
* Master method blend
* this method have a purpose to blend the four channel color.
* @param Pimage tex, is the image must be back
* @param Pimage inc, is the image must be incrusted on the background picture
* @param float [], Vec2, Vec3 or Vec4 is the normal ratio overlaying
*/
void blend(PGraphics p, PImage tex, PImage inc, float blend, float... ratio) { 
  set_blend_shader();

  Vec4 r = array_to_Vec4_rgba(ratio);
  
  rope_shader_blend.set("incrustation",inc);
  rope_shader_blend.set("blend", blend);
  rope_shader_blend.set("ratio",r.x,r.z,r.w,r.z);
  
  if(p == null) {
    rope_shader_blend.set("texture",tex);
    shader(rope_shader_blend);
  } else {
    rope_shader_blend.set("texture_PGraphics",tex);
    rope_shader_blend.set("PGraphics_renderer_is",true);
    p.filter(rope_shader_blend);
  }
}

/**
mix

*/
/**
* size
*/
/**
void mix_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_mix == null) rope_shader_mix = loadShader("shader/filter/rope_filter_mix.glsl");
  rope_shader_mix.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}
*/
void set_mix_shader() {
  if(rope_shader_mix == null) rope_shader_mix = loadShader(path_shader_filter_rope+"rope_filter_mix.glsl");
}
/**
* flip 
*/
void mix_flip_tex(boolean bx_tex, boolean by_tex) {
  mix_flip(bx_tex,by_tex,false,false);
}

void mix_flip_inc(boolean bx_inc, boolean by_inc) {
  mix_flip(false,false,bx_inc,by_inc);
}

void mix_flip(boolean bx, boolean by) {
  mix_flip(bx,by,bx,by);
}

void mix_flip(boolean bx_tex, boolean by_tex, boolean bx_inc, boolean by_inc) {
  set_mix_shader();
  rope_shader_mix.set("flip_tex",bx_tex,by_tex);
  rope_shader_mix.set("flip_inc",bx_inc,by_inc);
}

/**
* without PGraphics work
*/
void mix(PImage tex, PImage inc) {
  mix(null, tex, inc, 1);
}

void mix(PImage tex, PImage inc, Vec2 ratio) {
  mix(null, tex, inc, ratio.x, ratio.y);
}

void mix(PImage tex, PImage inc, Vec3 ratio) {
  mix(null, tex, inc, ratio.x, ratio.y, ratio.z);
}

void mix(PImage tex, PImage inc, Vec4 ratio) {
  mix(null, tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}

void mix(PImage tex, PImage inc, float... ratio) {
  if(ratio.length == 1) {
    mix(null, tex, inc, ratio[0]);
  } else if(ratio.length == 2) {
    mix(null, tex, inc, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    mix(null, tex, inc, ratio[0], ratio[1], ratio[2]);
  } else {
    mix(null, tex, inc, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}

/**
* with PGraphics work
*/
void mix(PGraphics p, PImage tex, PImage inc) {
  mix(p, tex, inc, 1);
}

void mix(PGraphics p, PImage tex, PImage inc, Vec2 ratio) {
  mix(p, tex, inc, ratio.x, ratio.y);
}

void mix(PGraphics p, PImage tex, PImage inc, Vec3 ratio) {
  mix(p, tex, inc, ratio.x, ratio.y, ratio.z);
}

void mix(PGraphics p, PImage tex, PImage inc, Vec4 ratio) {
  mix(p, tex, inc, ratio.x, ratio.y, ratio.z, ratio.w);
}

/**
* Master method mix
* this method have a purpose to mix the four channel color.
*/
void mix(PGraphics p, PImage tex, PImage inc, float... ratio) {
  set_mix_shader();

  Vec4 r = array_to_Vec4_rgba(ratio); 
  
  rope_shader_mix.set("incrustation",inc);
  rope_shader_mix.set("ratio",r.r,r.g,r.b,r.a);

  if(p == null) {
    rope_shader_mix.set("texture",tex);
    shader(rope_shader_mix);
  } else {
    rope_shader_mix.set("texture_PGraphics",tex);
    rope_shader_mix.set("PGraphics_renderer_is",true);
    p.filter(rope_shader_mix);
  }
}

/**
level colour

*/
/**
* size
*/
/**
void level_size(int w1, int h1, int w2, int h2) {
  if(rope_shader_level == null) rope_shader_level = loadShader("shader/filter/rope_filter_level.glsl");
  rope_shader_level.set("wh_renderer_ratio",(float)w2 / (float)w1, (float)h2 / (float)h1);
}
*/
/**
* flip 
 */
void level_flip(boolean bx, boolean by) {
  if(rope_shader_level == null) rope_shader_level = loadShader(path_shader_filter_rope+"rope_filter_level.glsl");
  rope_shader_level.set("flip",bx,by);
}
/**
* follower method
*/
void level(PImage tex, Vec2 level) {
  level(tex,level.x,level.y);
}

void level(PImage tex, Vec3 level) {
  level(tex,level.x,level.y,level.z);
}

void level(PImage tex, Vec4 level) {
  level(tex,level.r,level.g,level.b,level.a);
}

void level(PImage tex, float... ratio) {
  if(ratio.length == 1) {
    level(null, tex, ratio[0]);
  } else if(ratio.length == 2) {
    level(null, tex, ratio[0], ratio[1]);
  } else if(ratio.length == 3) {
    level(null, tex, ratio[0], ratio[1], ratio[2]);
  } else {
    level(null, tex, ratio[0], ratio[1], ratio[2], ratio[3]);
  }
}

/**
* with PGraphics work
*/
void level(PGraphics p, PImage tex, PImage inc) {
  level(p, tex, 1);
}

void level(PGraphics p, PImage tex, Vec2 ratio) {
  level(p, tex, ratio.x, ratio.y);
}

void level(PGraphics p, PImage tex, Vec3 ratio) {
  level(p, tex, ratio.x, ratio.y, ratio.z);
}

void level(PGraphics p, PImage tex, Vec4 ratio) {
  level(p, tex, ratio.x, ratio.y, ratio.z, ratio.w);
}
/**
* Master method level
* this method have a purpose to mix the four channel color.
*/
void level(PGraphics p, PImage tex, float... ratio) {

  if(rope_shader_level == null) rope_shader_level = loadShader(path_shader_filter_rope+"rope_filter_level.glsl");

  Vec4 r = array_to_Vec4_rgba(ratio);
 
  rope_shader_level.set("level",r.r,r.g,r.b,r.a);

  if( p == null ) {
    rope_shader_level.set("texture",tex);
    shader(rope_shader_level);
  } else {
    rope_shader_level.set("texture_PGraphics",tex);
    rope_shader_level.set("PGraphics_renderer_is",true);
    p.filter(rope_shader_level);
  }
}























































/**
CANVAS
v 0.1.2.1
*/
PImage [] canvas;
int current_canvas;

// build canvas
void new_canvas(int num) {
  canvas = new PImage[num];
}

void create_canvas(int w, int h, int type) {
  canvas = new PImage[1];
  canvas[0] = createImage(w, h, type);
}

void create_canvas(int w, int h, int type, int which_one) {
  canvas[which_one] = createImage(w, h, type);
}

// clean
void clean_canvas(int which_canvas) {
  int c = color(0,0) ;
  clean_canvas(which_canvas, c) ;
}

void clean_canvas(int which_canvas, int c) {
  if(which_canvas < canvas.length) {
    select_canvas(which_canvas) ;
    for(int i = 0 ; i < get_canvas().pixels.length ; i++) {
      get_canvas().pixels[i] = c ;
    }
  } else {
    String message = ("The target: " + which_canvas + " don't match with an existing canvas");
    printErr(message);
  }
}



// misc
int canvas_size() {
  return canvas.length;
}

// select the canvas must be used for your next work
void select_canvas(int which_one) {
  if(which_one < canvas.length && which_one >= 0) {
    current_canvas = which_one;
  } else {
    String message = ("void select_canvas(): Your selection " + which_one + " is not available, canvas '0' be use");
    printErr(message);
    current_canvas = 0;
  }
}

// get
PImage get_canvas(int which) {
  if(which < canvas.length) {
    return canvas[which];
  } else return null; 
}

PImage get_canvas() {
  return canvas[current_canvas];
}

int get_canvas_id() {
  return current_canvas;
}

// update
void update_canvas(PImage img) {
  update_canvas(img,current_canvas);
}

void update_canvas(PImage img, int which_one) {
  if(which_one < canvas.length && which_one >= 0) {
    canvas[which_one] = img;
  } else {
    println("void update_canvas() : Your selection" ,which_one, "is not available, canvas '0' be use");
    canvas[0] = img;
  }  
}


/**
canvas event
v 0.0.1
*/
void alpha_canvas(int target, float change) { 
  for(int i = 0 ; i < get_canvas(target).pixels.length ; i++) {
    int c = get_canvas(target).pixels[i];
    float rr = red(c);
    float gg = green(c);
    float bb = blue(c);
    float aa = alpha(c);
    aa += change ;
    if(i== 0 && target == 1 && aa < 5) {
      // println(aa, change);
    } 
    if(aa < 0 ) {
      aa = 0 ;
    }
    get_canvas(target).pixels[i] = color(rr,gg,bb,aa) ;
  }
  get_canvas(target).updatePixels() ;
}




/**
show canvas
v 0.0.4
*/
boolean fullscreen_canvas_is = false ;
iVec2 show_pos ;
/**
Add to set the center of the canvas in relation with the window
*/
int offset_canvas_x = 0 ;
int offset_canvas_y = 0 ;
void set_show() {
  if(!fullscreen_canvas_is) {
    surface.setSize(get_canvas().width, get_canvas().height);
  } else {
    offset_canvas_x = width/2 - (get_canvas().width/2);
    offset_canvas_y = height/2 - (get_canvas().height/2);
    show_pos = iVec2(offset_canvas_x,offset_canvas_y) ;
  }
}

iVec2 get_offset_canvas() {
  return iVec2(offset_canvas_x, offset_canvas_y);
}

int get_offset_canvas_x() {
  return offset_canvas_x;
}

int get_offset_canvas_y() {
  return offset_canvas_y;
}

void show_canvas(int num) {
  if(fullscreen_canvas_is) {
    image(get_canvas(num), show_pos);
  } else {
    image(get_canvas(num));
  }  
}

/**
END IMAGE ROPE

*/






































/**
TRANSLATOR 
v 0.1.0
*/
/**
int to byte, byte to int
v 0.0.2
*/
import java.nio.ByteBuffer ;
import java.nio.ByteOrder ;
int int_from_4_bytes(byte [] array_byte) {
  if(array_byte.length == 4) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte) ;
    buffer.order(ByteOrder.LITTLE_ENDIAN) ;
    int result = buffer.getShort();
    return result;
  } else {
    Integer null_data = null ;
    return null_data ;
  }

}


// be carefull here we use the class Byte, not the primitive byte  'B' vs 'b'
int int_from_byte(Byte b) {
  int result = b.intValue() ;
  return result ;
}

int int_from_2_bytes(byte [] array_byte) {
  if(array_byte.length == 2) {
    int result = -1 ;
    return result ;
  } else {
    Integer null_data = null ;
    return null_data ;
  }
}


// return byte
byte[] bytes_2_from_int(int x) {
  byte [] array = new byte[2];    
  array[0] = (byte) x;
  array[1] = (byte) (x>>8);  
  return array;
}
  


byte[] bytes_4_from_int(int size) {
  byte [] array = new byte[4]; 
  array[0] = (byte)  size;
  array[1] = (byte) (size >> 8) ;
  array[2] = (byte) (size >> 16) ;
  array[3] = (byte) (size >> 24) ; 
  return array;
}


/**
truncate a float argument
v 0.0.2
*/
float truncate(float x) {
    return round(x *100.0f) /100.0f;
}

float truncate(float x, int num) {
  float result = 0.0 ;
  switch(num) {
    case 0:
      result = round(x *1.0f) /1.0f;
      break;
    case 1:
      result = round(x *10.0f) /10.0f;
      break;
    case 2:
      result = round(x *100.0f) /100.0f;
      break;
    case 3:
      result = round(x *1000.0f) /1000.0f;
      break;
    case 4:
      result = round(x *10000.0f) /10000.0f;
      break;
    case 5:
      result = round(x *100000.0f) /100000.0f;
      break;
    default:
      result = x;
      break;
  }
  return result;
}

/**
Int to String
Float to String
v 0.0.3
*/
/*
@ return String
*/
String join_int_to_String(int []data) {
  String intString ;
  String [] dataString = new String [data.length] ;
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = Integer.toString(data[i]) ;
  intString = join(dataString,"/") ;
  
  return intString ;
}

//float to String with array list
String join_float_to_String(float []data) {
  String floatString ;
  String [] dataString = new String [data.length] ;
  //for ( int i = 0 ; i < data.length ; i++) dataString[i] = Float.toString(data[i]) ;
  //we must use just one decimal after coma, to dodge the outBoundIndex blablabla
  for ( int i = 0 ; i < data.length ; i++) dataString[i] = String.format("%.1f" ,data[i]) ;
  floatString = join(dataString,"/") ;
  
  return floatString ;
}

//Translater to String
// float to String
String float_to_String_1(float data) {
  String float_string_value ;
  float_string_value = String.format("%.1f", data ) ;
  return float_String(float_string_value) ;
}
//
String float_to_String_2(float data) {
  String float_string_value ;
  float_string_value = String.format("%.2f", data ) ;
  return float_String(float_string_value) ;
}
//
String float_to_String_3(float data) {
  String float_string_value ;
  float_string_value = String.format("%.3f", data ) ;
  return float_String(float_string_value) ;
}

//
String float_to_String_4(float data) {
  String float_string_value ;
  float_string_value = String.format("%.4f", data ) ;
  return float_String(float_string_value) ;
}
// local
String float_String(String value) {
  if(value.contains(".")) {
    return value ;
  } else {
    String [] temp = split(value, ",") ;
    value = temp[0] +"." + temp[1] ;
    return value ;
  }
}


// int to String
String int_to_String(int data) {
  String float_string_value ;
  float_string_value = Integer.toString(data ) ;
  return float_string_value ;
}



/**
array float to Vec
*/
Vec4 array_to_Vec4_rgba(float... f) {
  Vec4 v = Vec4(1);
  if(f.length == 1) {
    v.set(f[0],f[0],f[0],1.);
  } else if(f.length == 2) {
    v.set(f[0],f[0],f[0],f[1]);
  } else if(f.length == 3) {
    v.set(f[0],f[1],f[2],1);
  } else if(f.length > 3) {
    v.set(f[0],f[1],f[2],f[3]);
  }
  return v;
}

/**
END TRANSLATOR
*/




































































/**
EXPORT FILE PDF_PNG 0.1.1
*/
String ranking_shot = "_######" ;
// PDF
import processing.pdf.*;
boolean record_PDF;
void start_PDF() {
  start_PDF(null,null) ;
}

void start_PDF(String name_file) {
  start_PDF(null, name_file) ;
}
void start_PDF(String path_folder, String name_file) {
  if(path_folder == null) path_folder = "pdf_folder";
  if(name_file == null) name_file = "pdf_file_"+ranking_shot;

  if (record_PDF && !record_PNG) {
    if(renderer_P3D()) {
      beginRaw(PDF, path_folder+"/"+name_file+".pdf"); 
    } else {
      beginRecord(PDF, path_folder+"/"+name_file+".pdf");
    }
  }
}

void save_PDF() {
  if (record_PDF && !record_PNG) {
    if(renderer_P3D()) {
      endRaw(); 
    } else {
      endRecord() ;
    }
    println("PDF");
    record_PDF = false;
  }
}

void event_PDF() {
  record_PDF = true;
}




// PNG
boolean record_PNG ;
boolean naming_PNG ;
String path_folder_png, name_file_png  ;
void start_PNG(String path_folder, String name_file) {
  path_folder_png = path_folder ;
  name_file_png = name_file ;
  naming_PNG = true ;
}

void save_PNG() {
  if(record_PNG) {
    if(!naming_PNG) {
      saveFrame("png_folder/shot_" + ranking_shot + ".png");
    } else {
      saveFrame(path_folder_png + "/" + name_file_png + ".png");
    }
    record_PNG = false ;
  }
}

void event_PNG() {
  record_PNG = true;
}




























/**
BACKGROUND_2D_3D 
v 0.1.0
*/
float MAX_RATIO_DEPTH = 6.9 ;

/**
Background classic processing
*/
// Vec
void background(Vec4 c) {
  background(c.r,c.g,c.b,c.a) ;
}

void background(Vec3 c) {
  background(c.r,c.g,c.b) ;
}

void background(Vec2 c) {
  background(c.x,c.y) ;
}
// iVec
void background(iVec4 c) {
  background(c.x,c.y,c.z,c.w) ;
}

void background(iVec3 c) {
  background(c.x,c.y,c.z) ;
}

void background(iVec2 c) {
  background(c.x,c.y) ;
}




/**
Normalize background
*/

void background_norm(Vec4 bg) {
  background_norm(bg.x, bg.y, bg.z, bg.a) ;
}

void background_norm(Vec3 bg) {
  background_norm(bg.x, bg.y, bg.z, 1) ;
}

void background_norm(Vec2 bg) {
  background_norm(bg.x, bg.x, bg.x, bg.y) ;
}

void background_norm(float c, float a) {
  background_norm(c, c, c, a) ;
}

void background_norm(float c) {
  background_norm(c, c, c, 1) ;
}

void background_norm(float r,float g, float b) {
  background_norm(r, g, b, 1) ;
}

// Main method
void background_norm(float r_c, float g_c, float b_c, float a_c) {
  rectMode(CORNER) ;
  float x = map(r_c,0,1, 0, g.colorModeX) ;
  float y = map(g_c,0,1, 0, g.colorModeY) ;
  float z = map(b_c,0,1, 0, g.colorModeZ) ;
  float a = map(a_c,0,1, 0, g.colorModeA) ;
  noStroke() ;
  fill(x, y, z, a) ;
  int canvas_x = width ;
  int canvas_y = height ;
  if(renderer_P3D()) {
    canvas_x = width *100 ;
    canvas_y = height *100 ;
    int pos_x = - canvas_x /2 ;
    int pos_y = - canvas_y /2 ;
    // this problem of depth is not clarify, is must refactoring
    int pos_z = int( -height *MAX_RATIO_DEPTH) ;
    pushMatrix() ;
    translate(0,0,pos_z) ;
    rect(pos_x,pos_y,canvas_x, canvas_y) ;
    popMatrix() ;
  } else {
    rect(0,0,canvas_x, canvas_y) ;
  }
  // HSB mode
  if(g.colorMode == 3) {
    fill(0, 0, g.colorModeZ) ;
    stroke(0) ;
  // RGB MODE
  } else if (g.colorMode == 1) {
    fill(g.colorModeX, g.colorModeY, g.colorModeZ) ;
    stroke(0) ;

  }
  strokeWeight(1) ; 
}



/**
background rope
*/
void background_rope(int c) {
  if(g.colorMode == 3) {
    background_rope(hue(c),saturation(c),brightness(c));
  } else {
    background_rope(red(c),green(c),blue(c));
  }
}

void background_rope(int c, float w) {
  if(g.colorMode == 3) {
    background_rope(hue(c),saturation(c),brightness(c),w);
  } else {
    background_rope(red(c),green(c),blue(c),w );
  }
}

void background_rope(float c) {
  background_rope(c,c,c);
}

void background_rope(float c, float w) {
  background_rope(c,c,c,w);
}

void background_rope(Vec4 c) {
  background_rope(c.x,c.y,c.z,c.w);
}

void background_rope(Vec3 c) {
  background_rope(c.x,c.y,c.z);
}

void background_rope(Vec2 c) {
  background_rope(c.x,c.x,c.x,c.y);
}

// master method
void background_rope(float x, float y, float z, float w) {
  background_norm(x/g.colorModeX, y/g.colorModeY, z/g.colorModeZ, w /g.colorModeA) ;
}

void background_rope(float x, float y, float z) {
  background_norm(x/g.colorModeX, y/g.colorModeY, z/g.colorModeZ) ;
}



































/**
TABLE METHOD 
v 0.0.3.1
for Table with the first COLLUMN is used for name and the next 6 for the value.
The method is used with the Class Info

*/
// table method for row sort
void buildTable(Table table, TableRow [] tableRow, String [] col_name, String [] row_name) {
  // add col
  for(int i = 0 ; i < col_name.length ; i++) {
    table.addColumn(col_name[i]);
  }
  // add row
  tableRow = new TableRow[row_name.length] ;
  buildRow(table, row_name) ;
}

void buildTable(Table table, String [] col_name) {
  // add col
  for(int i = 0 ; i < col_name.length ; i++) {
    table.addColumn(col_name[i]);
  }
}

void buildRow(Table table, String [] row_name) {
  int num_row = table.getRowCount() ;
  for(int i = 0 ; i < num_row ; i++) {
    TableRow row = table.getRow(i) ;
    row.setString(table.getColumnTitle(0), row_name[i]) ; 
  }
}

void setTable(Table table, TableRow [] rows, Info_Object... info) {
  for(int i = 0 ; i < rows.length ; i++) {
    if(rows[i] != null) {
      for(int j = 0 ; j < info.length ; j++) {
        if(info[j] != null && info[j].get_name().equals(rows[i].getString(table.getColumnTitle(0)))) {
          for(int k = 1 ; k < 7 ; k++) {
            if(table.getColumnCount() > k && info[j].catch_obj(k-1) != null)  write_row(rows[i], table.getColumnTitle(k), info[j].catch_obj(k-1)) ;
          }
        }
        
      }
    }
  }
}


void setRow(Table table, Info_Object info) {
  TableRow result = table.findRow(info.get_name(), table.getColumnTitle(0)) ;
  if(result != null) {
    for(int k = 1 ; k < 7 ; k++) {
      if(table.getColumnCount() > k && info.catch_obj(k-1) != null)  write_row(result, table.getColumnTitle(k), info.catch_obj(k-1)) ;
    }
  }
}

void write_row(TableRow row, String col_name, Object o) {
  if(o instanceof String) {
    String s = (String) o ;
    row.setString(col_name, s);
  } else if(o instanceof Short) {
    short sh = (Short) o ;
    row.setInt(col_name, sh);
  } else if(o instanceof Integer) {
    int in = (Integer) o ;
    row.setInt(col_name, in);
  } else if(o instanceof Float) {
    float f = (Float) o ;
    row.setFloat(col_name, f);
  } else if(o instanceof Character) {
    char c = (Character) o ;
    String s = Character.toString(c) ;
    row.setString(col_name, s);
  } else if(o instanceof Boolean) {
    boolean b = (Boolean) o ;
    String s = Boolean.toString(b) ;
    row.setString(col_name, s);
  } 
}


















/**
print
v 0.1.2
*/
// util variable

// print Err
void printErr(Object... obj) {
  String message= ("");
  for(int i = 0 ; i < obj.length ; i++) {
    message = write_print_message(message, obj[i], obj.length, i);
  }
  System.err.println(message);
}

// print tempo
void printErrTempo(int tempo, Object... obj) {
  if(frameCount%tempo == 0 || frameCount <= 1) {
    String message= ("");
    for(int i = 0 ; i < obj.length ; i++) {
      message = write_print_message(message, obj[i], obj.length, i);
    }
    System.err.println(message);
    // System.err.println(message+"/n"); // don't work for unknow reason
    // System.err.println(message+System.lineSeparator());
  }
}

void printTempo(int tempo, Object... obj) {
  if(frameCount%tempo == 0 || frameCount <= 1) {
    String message= ("");
    for(int i = 0 ; i < obj.length ; i++) {
      message = write_print_message(message, obj[i], obj.length, i);
    }
    println(message);
  }
}



// local method
String write_print_message(String message, Object obj, int length, int i) {
  if(i == length -1) {
    return message += obj.toString() ;
  } else {
    return message += obj.toString() + " ";
  }
}


void printArrayTempo(int tempo, Object[] obj) {
  if(frameCount%tempo == 0 || frameCount <= 1) {
    printArray(obj);
  }
}

void printArrayTempo(int tempo, float[] var) {
  if(frameCount%tempo == 0 || frameCount <= 10) {
    printArray(var);
  }
}

void printArrayTempo(int tempo, int[] var) {
  if(frameCount%tempo == 0 || frameCount <= 10) {
    printArray(var);
  }
}

void printArrayTempo(int tempo, String[] var) {
  if(frameCount%tempo == 0 || frameCount <= 10) {
    printArray(var);
  }
}

































/**
Info_dict 
v 0.3.0.1
*/
public class Info_dict {
  ArrayList<Info> list;
  char type_list = 'o';

  Info_dict(char type_list) {
    this.type_list = type_list;
  }

  Info_dict() {
    list = new ArrayList<Info>();
  }

  // add Object
  void add(String name, Object a) {
    Info_Object info = new Info_Object(name,a);
    list.add(info);
  }
  void add(String name, Object a, Object b) {
    Info_Object info = new Info_Object(name,a,b);
    list.add(info);
  }
  void add(String name, Object a, Object b, Object c) {
    Info_Object info = new Info_Object(name,a,b,c);
    list.add(info);
  }
  void add(String name, Object a, Object b, Object c, Object d) {
    Info_Object info = new Info_Object(name,a,b,c,d);
    list.add(info);
  }
  void add(String name, Object a, Object b, Object c, Object d, Object e) {
    Info_Object info = new Info_Object(name,a,b,c,d,e);
    list.add(info);
  }
  void add(String name, Object a, Object b, Object c, Object d, Object e, Object f) {
    Info_Object info = new Info_Object(name,a,b,c,d,e,f);
    list.add(info);
  }
  void add(String name, Object a, Object b, Object c, Object d, Object e, Object f, Object g) {
    Info_Object info = new Info_Object(name,a,b,c,d,e,f,g);
    list.add(info);
  }

   // size
   int size() {
    return list.size();
   }

  // read
  void read() {
    println("Object list");
    for(Info a : list) {
      if(a instanceof Info_Object) {
        Info_Object obj = (Info_Object)a ;
        if(obj.a != null && obj.b == null && obj.c == null && obj.d == null && obj.e == null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a));   
        }
        if(obj.a != null && obj.b != null && obj.c == null && obj.d == null && obj.e == null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d == null && obj.e == null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d != null && obj.e == null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c),get_type(obj.d));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d != null && obj.e != null && obj.f == null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c),get_type(obj.d),get_type(obj.e));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d != null && obj.e != null && obj.f != null && obj.g == null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c),get_type(obj.d),get_type(obj.e),get_type(obj.f));   
        }
        if(obj.a != null && obj.b != null && obj.c != null && obj.d != null && obj.e != null && obj.f != null && obj.g != null) {
          println(a,get_type(obj.a),get_type(obj.b),get_type(obj.c),get_type(obj.d),get_type(obj.e),get_type(obj.f),get_type(obj.g));   
        }      
      }
    }
  }

  // get
  Info get(int target) {
    if(target < list.size() && target >= 0) {
      return list.get(target);
    } else return null;
  }
  
  Info [] get(String which) {
    Info [] info;
    int count = 0;
    for(Info a : list) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info[count] ;
      count = 0;
      for(Info a : list) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++;
        }
      }
    } else {
      info = new Info_String[1];
      info[0] = null;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info;
  }

  // clear
  void clear() {
    list.clear();
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list.size() ; i++) {
      Info a = list.get(i);
      if(a.get_name().equals(which)) {
        list.remove(i);
      }
    }
  }
  
  void remove(int target) {
   if(target < list.size()) {
      list.remove(target);
    }
  }
}

/**
Info_int_dict
v 0.0.2
*/

public class Info_int_dict extends Info_dict {
  ArrayList<Info_int> list_int;
  Info_int_dict() {
    super('i');
    list_int = new ArrayList<Info_int>();
  }


  // add int
  void add(String name, int a) {
    Info_int info = new Info_int(name,a);
    list_int.add(info);
  } 
  void add(String name, int a, int b) {
    Info_int info = new Info_int(name,a,b);
    list_int.add(info);
  } 

  void add(String name, int a, int b, int c) {
    Info_int info = new Info_int(name,a,b,c);
    list_int.add(info);
  } 
  void add(String name, int a, int b, int c, int d) {
    Info_int info = new Info_int(name, a,b,c,d);
    list_int.add(info);
  } 
  void add(String name, int a, int b, int c, int d, int e) {
    Info_int info = new Info_int(name,a,b,c,d,e);
    list_int.add(info);
  } 
  void add(String name, int a, int b, int c, int d, int e, int f) {
    Info_int info = new Info_int(name,a,b,c,d,e,f);
    list_int.add(info);
  }
  void add(String name, int a, int b, int c, int d, int e, int f, int g) {
    Info_int info = new Info_int(name,a,b,c,d,e,f,g);
    list_int.add(info);
  }


  // size
  int size() {
    return list_int.size() ;
  }

  // read
  void read() {
    println("Integer list");
    for(Info a : list_int) {
      println(a,"Integer");
    }
  }
  

  // get
  Info_int get(int target) {
    if(target < list_int.size() && target >= 0) {
      return list_int.get(target);
    } else return null;
  }
  
  Info_int [] get(String which) {
    Info_int [] info  ;
    int count = 0;
    for(Info_int a : list_int) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info_int[count] ;
      count = 0 ;
      for(Info_int a : list_int) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++;
        }
      }
    } else {
      info = new Info_int[1] ;
      info[0] = null;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }

  // clear
  void clear() {
    list_int.clear();
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list_int.size() ; i++) {
      Info_int a = list_int.get(i) ;
      if(a.get_name().equals(which)) {
        list_int.remove(i);
      }
    }
  }
  
  void remove(int target) {
   if(target < list_int.size()) {
      list_int.remove(target);
    }
  }
}

/**
Info_float_dict
v 0.0.2
*/
public class Info_float_dict extends Info_dict {
  ArrayList<Info_float> list_float ;
  Info_float_dict() {
    super('f');
    list_float = new ArrayList<Info_float>();
  }

  // add float
  void add(String name, float a) {
    Info_float info = new Info_float(name,a);
    list_float.add(info);
  }
  void add(String name, float a, float b) {
    Info_float info = new Info_float(name,a,b);
    list_float.add(info);
  }
  void add(String name, float a, float b, float c) {
    Info_float info = new Info_float(name,a,b,c);
    list_float.add(info);
  }
  void add(String name, float a, float b, float c, float d) {
    Info_float info = new Info_float(name,a,b,c,d);
    list_float.add(info);
  }
  void add(String name, float a, float b, float c, float d, float e) {
    Info_float info = new Info_float(name,a,b,c,d,e);
    list_float.add(info);
  }
  void add(String name, float a, float b, float c, float d, float e, float f) {
    Info_float info = new Info_float(name,a,b,c,d,e,f);
    list_float.add(info);
  }
  void add(String name, float a, float b, float c, float d, float e, float f, float g) {
    Info_float info = new Info_float(name,a,b,c,d,e,f,g);
    list_float.add(info);
  }

  // size
  int size() {
    return list_float.size() ;
  }

  //read
  void read() {
    println("Float list");
    for(Info a : list_float) {
      println(a,"Float");
    }
  }
   

  // get
  Info_float get(int target) {
    if(target < list_float.size() && target >= 0) {
      return list_float.get(target);
    } else return null;
  }
  
  Info_float [] get(String which) {
    Info_float [] info;
    int count = 0;
    for(Info_float a : list_float) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info_float[count] ;
      count = 0 ;
      for(Info_float a : list_float) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++;
        }
      }
    } else {
      info = new Info_float[1] ;
      info[0] = null;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }

  // clear
  void clear() {
    list_float.clear();
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list_float.size() ; i++) {
      Info a = list_float.get(i) ;
      if(a.get_name().equals(which)) {
        list_float.remove(i);
      }
    }
  }
  
  void remove(int target) {
   if(target < list_float.size()) {
      list_float.remove(target);
    }
  }
}



/**
Info_String_dict

*/
public class Info_String_dict extends Info_dict {
  ArrayList<Info_String> list_String ;
  Info_String_dict() {
    super('s');
    list_String = new ArrayList<Info_String>();
  }

  // add String
  void add(String name, String a) {
    Info_String info = new Info_String(name,a);
    list_String.add(info);
  }
  void add(String name, String a, String b) {
    Info_String info = new Info_String(name,a,b); 
    list_String.add(info);
  }
  void add(String name, String a, String b, String c) {
    Info_String info = new Info_String(name,a,b,c);
    list_String.add(info);
  }
  void add(String name, String a, String b, String c, String d) {
    Info_String info = new Info_String(name,a,b,c,d);
    list_String.add(info);
  }
  void add(String name, String a, String b, String c, String d, String e) {
    Info_String info = new Info_String(name,a,b,c,d,e);
    list_String.add(info);
  }
  void add(String name, String a, String b, String c, String d, String e, String f) {
    Info_String info = new Info_String(name,a,b,c,d,e,f);
    list_String.add(info);
  }
  void add(String name, String a, String b, String c, String d, String e, String f,String g) {
    Info_String info = new Info_String(name,a,b,c,d,e,f,g);
    list_String.add(info);
  }

  // size
  int size() {
    return list_String.size() ;
  }

  //read
  void read() {
    println("String list");
    for(Info a : list_String) {
      println(a,"String");
    }
  }
  

  // get
  Info_String get(int target) {
    if(target < list_String.size() && target >= 0) {
      return list_String.get(target);
    } else return null;
  }
  
  Info_String [] get(String which) {
    Info_String [] info  ;
    int count = 0 ;
    for(Info_String a : list_String) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info_String[count] ;
      count = 0;
      for(Info_String a : list_String) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++;
        }
      }
    } else {
      info = new Info_String[1];
      info[0] = null;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info;
  }

  // clear
  void clear() {
    list_String.clear();
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list_String.size() ; i++) {
      Info_String a = list_String.get(i);
      if(a.get_name().equals(which)) {
        list_String.remove(i);
      }
    }
  }
  
  void remove(int target) {
   if(target < list_String.size()) {
      list_String.remove(target);
    }
  }
}


/**
Info_Vec_dict
*/
public class Info_Vec_dict extends Info_dict {
  ArrayList<Info_Vec> list_Vec ;
  Info_Vec_dict() {
    super('v') ;
    list_Vec = new ArrayList<Info_Vec>() ;
  }

  // add Vec
  void add(String name, Vec a) {
    Info_Vec info = new Info_Vec(name,a);
    list_Vec.add(info);
  }
  void add(String name, Vec a, Vec b) {
    Info_Vec info = new Info_Vec(name,a,b);
    list_Vec.add(info);
  }
  void add(String name, Vec a, Vec b, Vec c) {
    Info_Vec info = new Info_Vec(name,a,b,c);
    list_Vec.add(info);
  }
  void add(String name, Vec a, Vec b, Vec c, Vec d) {
    Info_Vec info = new Info_Vec(name,a,b,c,d);
    list_Vec.add(info);
  }
  void add(String name, Vec a, Vec b, Vec c, Vec d, Vec e) {
    Info_Vec info = new Info_Vec(name,a,b,c,d,e);
    list_Vec.add(info);
  }
  void add(String name, Vec a, Vec b, Vec c, Vec d, Vec e, Vec f) {
    Info_Vec info = new Info_Vec(name,a,b,c,d,e,f);
    list_Vec.add(info);
  }
  void add(String name, Vec a, Vec b, Vec c, Vec d, Vec e, Vec f, Vec g) {
    Info_Vec info = new Info_Vec(name,a,b,c,d,e,f,g);
    list_Vec.add(info);
  }

  // size
  int size() {
    return list_Vec.size();
  }

  //read
  void read() {
    println("Vec list");
    for(Info a : list_Vec) {
      println(a,"Vec");
    }
  }
  

  // get
  Info_Vec get(int target) {
    if(target < list_Vec.size() && target >= 0) {
      return list_Vec.get(target);
    } else return null;
  }
  
  Info_Vec [] get(String which) {
    Info_Vec [] info;
    int count = 0 ;
    for(Info_Vec a : list_Vec) {
      if(a.get_name().equals(which)) {
        count++;
      }
    }
    if (count > 0 ) {
      info = new Info_Vec[count];
      count = 0 ;
      for(Info_Vec a : list_Vec) {
        if(a.get_name().equals(which)) {
          info[count] = a;
          count++ ;
        }
      }
    } else {
      info = new Info_Vec[1];
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info;
  }

  // clear
  void clear() {
    list_Vec.clear();
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list_Vec.size() ; i++) {
      Info_Vec a = list_Vec.get(i) ;
      if(a.get_name().equals(which)) {
        list_Vec.remove(i);
      }
    }
  }
  
  void remove(int target) {
   if(target < list_Vec.size()) {
      list_Vec.remove(target);
    }
  }
}



/**
Info 0.1.0.2

*/
interface Info {
  String get_name();

  Object [] catch_all() ;
  Object catch_obj(int arg);

  char get_type();
}
 
abstract class Info_method implements Info {
  String name  ;
  // error message
  String error_target = "Your target is beyond of my knowledge !" ;
  String error_value_message = "This value is beyond of my power mate !" ;
  Info_method (String name) {
    this.name = name ;
  }


  String get_name() { 
    return name ;
  }
}


/**
INFO int

*/
class Info_int extends Info_method {
  char type = 'i' ;
  int a, b, c, d, e, f, g ;
  int num_value ;  


  Info_int(String name) {
    super(name) ;
  }

  Info_int(String name, int... var) {
    super(name) ;
    if(var.length > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = var.length ;
    }
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
    if(var.length > 6) this.g = var[6] ;
  }


  // get
  int [] get() {
    int [] list = new int[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  int get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return 0 ;
    } 
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return null ;
    } 
  }
  
  char get_type() { return type ; }

  // Print info
  @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g +" ]";
    } else {
      System.err.println(num_value) ;
      System.err.println(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO String
*/
class Info_String extends Info_method {
  char type = 's' ;
  String a, b, c, d, e, f, g ;
  int num_value ;  

  Info_String(String name) {
    super(name) ;
  }

  Info_String(String name, String... var) {
    super(name) ;
    if(var.length > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = var.length ;
    }
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
    if(var.length > 6) this.g = var[6] ;
  }


  // get
  String [] get() {
    String [] list = new String[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  String get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    }else {
      System.err.println(error_target) ;
      return null ;
    }
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    }else {
      System.err.println(error_target) ;
      return null ;
    }
  }

  char get_type() { return type ; }


  // Print info
  @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g + " ]";
    } else {
      System.err.println(num_value) ;
      System.err.println(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO float
*/
class Info_float extends Info_method {
  char type = 'f' ;
  float a, b, c, d, e, f, g ;
  int num_value ; 

  Info_float(String name) {
    super(name) ;
  }

  Info_float(String name, float... var) {
    super(name) ;
    if(var.length > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = var.length ;
    }
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
    if(var.length > 6) this.g = var[6] ;
  }

  // get
  float [] get() {
    float [] list = new float[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  float get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return 0.0 ;
    }
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return null ;
    }
  }

  char get_type() { return type ; }
  
  // Print info
  @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g + " ]";
    } else {
      System.err.println(num_value) ;
      System.err.println(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}

/**
INFO Vec
v 0.0.2
*/
class Info_Vec extends Info_method {
  char type = 'v' ;
  Vec a, b, c, d, e, f, g ;
  int num_value ;  

  Info_Vec(String name) {
    super(name) ;
  }

  // Vec value
  Info_Vec(String name, Vec... var) {
    super(name) ;
    if(var.length > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = var.length ;
    }
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
    if(var.length > 6) this.g = var[6] ;
  }




  // get
  Vec [] get() {
    Vec [] list = new Vec[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  Vec get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    }else {
      System.err.println(error_target) ;
      return null;
    }
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    } else {
      System.err.println(error_target) ;
      return null ;
    }
  }

  char get_type() { return type; }

  // Print info
  @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g + " ]";
    } else {
      System.err.println(num_value) ;
      System.err.println(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}




/**
INFO OBJECT
v 0.0.2
*/
class Info_Object extends Info_method {
  char type = 'o' ;
  Object a, b, c, d, e, f, g ;
  int num_value ;

  Info_Object(String name) {
    super(name) ;
  }


  // Object value
  Info_Object(String name, Object... var) {
    super(name) ;
    if(var.length > 7 ) {
      num_value = 7 ; 
    } else {
      num_value = var.length ;
    }
    if(var.length > 0) this.a = var[0] ;
    if(var.length > 1) this.b = var[1] ;
    if(var.length > 2) this.c = var[2] ;
    if(var.length > 3) this.d = var[3] ;
    if(var.length > 4) this.e = var[4] ;
    if(var.length > 5) this.f = var[5] ;
    if(var.length > 6) this.g = var[6] ;
  }


  // get
  Object [] get() {
    Object [] list = new Object []{a,b,c,d,e,f,g} ;
    return list ;
  }

  Object get(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    } else {
      printErr(error_target) ;
      return null ;
    }
  }
  
  Object [] catch_all() {
    Object [] list = new Object[]{a,b,c,d,e,f,g} ;
    return list ;
  }

  Object catch_obj(int which) {
    if(which == 0) {
      return a ; 
    } else if(which == 1) {
      return b ;
    } else if(which == 2) {
      return c ;
    } else if(which == 3) {
      return d ;
    } else if(which == 4) {
      return e ;
    } else if(which == 5) {
      return f ;
    } else if(which == 6) {
      return g ;
    } else {
      printErr(error_target) ;
      return null ;
    }
  }
  
  char get_type() { return type ; }


  // Print info
  @Override String toString() {
    if(num_value == 1) {
      return "[ " + name + ": " + a + " ]";
    } else if(num_value == 2) {
      return "[ " + name + ": " + a + ", " + b + " ]";
    } else if(num_value == 3) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + " ]";
    } else if(num_value == 4) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + " ]";
    } else if(num_value == 5) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + " ]";
    } else if(num_value == 6) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + " ]";
    } else if(num_value == 7) {
      return "[ " + name + ": " + a + ", " + b + ", " + c + ", " + d + ", " + e + ", " + f + ", " + g + " ]";
    } else {
      printErr(num_value) ;
      printErr(error_value_message) ;
      return "hmmm hmmm there is problem with your stuff mate";
    }
  }
}
/**
END INFO LIST

*/























/**
MAP
map the value between the min and the max
@ return float
*/
float map_cycle(float value, float min, float max) {
  max += .000001 ;
  float newValue ;
  if(min < 0 && max >= 0 ) {
    float tempMax = max +abs(min) ;
    value += abs(min) ;
    float tempMin = 0 ;
    newValue =  tempMin +abs(value)%(tempMax - tempMin)  ;
    newValue -= abs(min) ;
    return newValue ;
  } else if ( min < 0 && max < 0) {
    newValue = abs(value)%(abs(max)+min) -max ;
    return newValue ;
  } else {
    newValue = min + abs(value)%(max - min) ;
    return newValue ;
  }
}




/*
map the value between the min and the max, but this value is lock between the min and the max
@ return float
*/
float map_locked(float value, float sourceMin, float sourceMax, float targetMin, float targetMax) {
  if(sourceMax >= targetMax ) sourceMax = targetMax ;
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  float result = targetMin +deltaTarget *ratio;
  return result; 
}

// to map not linear, start the curve slowly to finish hardly
float map_smooth_start(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = pow(ratio, level) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}

// to map not linear, start the curve hardly to finish slowly
float map_smooth_end(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  // ratio = roots(ratio, level) ; // the method roots is use in math util
  ratio = pow(ratio, 1.0/level) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}

// to map not linear, like a "S"
float map_smooth(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = map(ratio,0,1, -1, 1 ) ;
  int correction = 1 ;
  if(level % 2 == 1 ) correction = 1 ; else correction = -1 ;
  if (ratio < 0 ) ratio = pow(ratio, level) *correction  ; else ratio = pow(ratio, level)  ;
  ratio = map(ratio, -1,1, 0,1) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}
// END MAP
//////////










/**
MISC
v 0.0.6

*/
/**
stop trhead draw by using loop and noLoop()
*/
boolean freeze_is ;
void freeze() {
  freeze_is = (freeze_is)? false:true ;
  if (freeze_is)  {
    noLoop();
  } else {
    loop();
  }
}



/**
Gaussian randomize
v 0.0.2
*/
@Deprecated
float random_gaussian(float value) {
  return random_gaussian(value, .4) ;
}

@Deprecated
float random_gaussian(float value, float range) {
  /*
  * It's cannot possible to indicate a value result here, this part need from the coder ?
  */
  printErrTempo(240,"float random_gaussian(); method must be improved or totaly deprecated");
  range = abs(range) ;
  float distrib = random(-1, 1) ;
  float result = 0 ;
  if(value == 0) {
    value = 1 ;
    result = (pow(distrib,5)) *(value *range) +value ;
    result-- ;
  } else {
    result = (pow(distrib,5)) *(value *range) +value ;
  }
  return result;
}



/**
Next Gaussian randomize
v 0.0.2
*/
/**
* return value from -1 to 1
* @return float
*/
Random random = new Random();
float random_next_gaussian() {
  return random_next_gaussian(1,1);
}

float random_next_gaussian(int n) {
  return random_next_gaussian(1,n);
}

float random_next_gaussian(float range) {
  return random_next_gaussian(range,1);
}

float random_next_gaussian(float range, int n) {
  float roots = (float)random.nextGaussian();
  float var = map(roots,-2.5,2.5,-1,1);  
  if(n > 1) {
    if(n%2 ==0 && var < 0) {
       var = -1 *pow(var,n);
     } else {
       var = pow(var,n);
     }
     return var *range ;
  } else {
    return var *range ;
  }
}






/**
PIXEL UTILS
v 0.0.2
2017-2017
*/
int [][] loadPixels_array_2D() {
  int [][] array_pix ;
  loadPixels() ;
  array_pix = new int[height][width] ;
  int which_pix = 0 ;
  for(int y = 0 ; y < height ; y++) {
    for(int x = 0 ; x < width ; x++) {
      which_pix = y *width +x ;
      array_pix[y][x] = pixels[which_pix] ;
    }
  }
  if(array_pix != null) {
    return array_pix ;
  } else {
    return null ;
  }
}























/**
GRAPHICS METHOD
v 0.3.1
*/
/**
SCREEN
*/
void set_window(int px, int py, int sx, int sy) {
  set_window(iVec2(px,py), iVec2(sx,sy), get_screen_location(0));
}

void set_window(int px, int py, int sx, int sy, int target) {
  set_window(iVec2(px,py), iVec2(sx,sy), get_screen_location(target));
}

void set_window(iVec2 pos, iVec2 size) {
  set_window(pos, size, get_screen_location(0));
}

void set_window(iVec2 pos, iVec2 size, int target) {
  set_window(pos, size, get_screen_location(target));
}

void set_window(iVec2 pos, iVec2 size, iVec2 pos_screen) { 
  int offset_x = pos.x;
  int offset_y = pos.y;
  int dx = pos_screen.x;
  int dy = pos_screen.y;
  surface.setSize(size.x,size.y);
  surface.setLocation(offset_x +dx, offset_y +dy);
}

/**
check screen
*/
/**
screen size
*/
iVec2 get_screen_size() {
  return get_display_size(sketchDisplay() -1);
}

iVec2 get_screen_size(int target) {
  return get_display_size(target);
}

@Deprecated
iVec2 get_display_size() {
  return get_display_size(sketchDisplay() -1);
}


iVec2 get_display_size(int which_display) {  
  Rectangle display = get_screen(which_display);
  return iVec2((int)display.getWidth(), (int)display.getHeight()); 
}

/**
screen location
*/

iVec2 get_screen_location(int which_display) {
  Rectangle display = get_screen(which_display);
  return iVec2((int)display.getX(), (int)display.getY());
}

/**
screen num
*/
int get_screen_num() {
  return get_display_num();
}

int get_display_num() {
  GraphicsEnvironment environment = GraphicsEnvironment.getLocalGraphicsEnvironment();
  return environment.getScreenDevices().length;
}


/**
screen
*/
Rectangle get_screen(int target_screen) {
  GraphicsEnvironment environment = GraphicsEnvironment.getLocalGraphicsEnvironment();
  GraphicsDevice[] awtDevices = environment.getScreenDevices();
  int target = 0 ;
  if(target_screen < awtDevices.length) {
    target = target_screen ; 
  } else {
    printErr("No screen match with your request, instead we use the current screen");
    target = sketchDisplay() -1;
    if(target >= awtDevices.length) target = awtDevices.length -1;
  }
  GraphicsDevice awtDisplayDevice = awtDevices[target];
  Rectangle display = awtDisplayDevice.getDefaultConfiguration().getBounds();
  return display;
}




/**
Check renderer
*/
boolean renderer_P3D() {
  if(get_renderer(getGraphics()).equals("processing.opengl.PGraphics3D")) return true ; else return false ;
}


String get_renderer() {
  return get_renderer(g);
}

String get_renderer(final PGraphics graph) {
  try {
    if (Class.forName(JAVA2D).isInstance(graph))  return JAVA2D;
    if (Class.forName(FX2D).isInstance(graph))    return FX2D;
    if (Class.forName(P2D).isInstance(graph))     return P2D;
    if (Class.forName(P3D).isInstance(graph))     return P3D;
    if (Class.forName(PDF).isInstance(graph))     return PDF;
    if (Class.forName(DXF).isInstance(graph))     return DXF;
  }

  catch (ClassNotFoundException ex) {
  }
  return "Unknown";
}




























/**
CHECK
v 0.2.3
*/
/**
Check Type
v 0.0.3
*/
@Deprecated
String object_type(Object obj) {
  return get_type(obj);
}

String get_type(Object obj) {
  if(obj instanceof Integer) {
    return "Integer";
  } else if(obj instanceof Float) {
    return "Float";
  } else if(obj instanceof String) {
    return "String";
  } else if(obj instanceof Double) {
    return "Double";
  } else if(obj instanceof Long) {
    return "Long";
  } else if(obj instanceof Short) {
    return "Short";
  } else if(obj instanceof Boolean) {
    return "Boolean";
  } else if(obj instanceof Byte) {
    return "Byte";
  } else if(obj instanceof Character) {
    return "Character";
  } else if(obj instanceof PVector) {
    return "PVector";
  } else if(obj instanceof Vec) {
    return "Vec";
  } else if(obj instanceof iVec) {
    return "iVec";
  } else if(obj instanceof bVec) {
    return "bVec";
  } else return "Unknow" ;
}












/**
check value in range
*/
boolean in_range(float min, float max, float value) {
  if(value <= max && value >= min) {
    return true ; 
  } else {
    return false ;
  }
}

boolean in_range_wheel(float min, float max, float roof_max, float value) {
  if(value <= max && value >= min) {
    return true ;
  } else {
    // wheel value
    if(max > roof_max ) {
      // test hight value
      if(value <= (max - roof_max)) {
        return true ;
      } 
    } 
    if (min < 0) {
      // here it's + min 
      if(value >= (roof_max + min)) {
        return true ;
      } 
    } 
    return false ;
  }
}














































/**
STRING UTILS
v 0.3.2
*/

//STRING SPLIT
String [] split_text(String str, String separator) {
  String [] text = str.split(separator) ;
  return text  ;
}


//STRING COMPARE LIST SORT
//raw compare
int longest_String(String[] string_list) {
  int finish = 0;
  if(string_list != null) finish = string_list.length;
  return longest_String(string_list, 0, finish);
}

//with starting and end keypoint in the String must be sort
int longest_String(String[] string_list, int start, int finish) {
  int length = 0;
  if(string_list != null) {
    for ( int i = start ; i < finish ; i++) {
      if (string_list[i].length() > length ) length = string_list[i].length() ;
    }
  }
  return length;
}

/**
Longuest String with PFont
*/
int longest_String_pixel(PFont font, String[] string_list) {
  int [] size_font = new int[1];
  size_font[0] = font.getSize();
  int finish = 0;
  if(string_list != null) finish = string_list.length;
  return longest_String_pixel(font.getName(), string_list, size_font, 0, finish);
}

int longest_String_pixel(PFont font, String[] string_list, int... size_font) {
  int finish = 0;
  if(string_list != null) finish = string_list.length;
  return longest_String_pixel(font.getName(), string_list, size_font, 0, finish);
}

int longest_String_pixel(PFont font, String[] string_list, int [] size_font, int start, int finish) {
  return longest_String_pixel(font.getName(), string_list, size_font, start, finish);
}

/**
Longuest String with String name Font
*/
int longest_String_pixel(String font_name, String[] string_list, int... size_font) {
  int finish = 0;
  if(string_list != null) finish = string_list.length;
  return longest_String_pixel(font_name, string_list, size_font, 0, finish);
}

// diferrent size by line
int longest_String_pixel(String font_name, String[] string_list, int size_font, int start, int finish) {
  int [] s_font = new int[1];
  s_font[0] = size_font;
  return longest_String_pixel(font_name, string_list, s_font, start, finish);
}

int longest_String_pixel(String font_name, String[] string_list, int [] size_font, int start, int finish) {
  int width_pix = 0 ;
  if(string_list != null) {
    int target_size_font = 0;
    for (int i = start ; i < finish && i < string_list.length; i++) {
      if(i >= size_font.length) target_size_font = 0 ;
      if (width_String(font_name, string_list[i], size_font[target_size_font]) > width_pix) {
        width_pix = width_String(string_list[i],size_font[target_size_font]);
      }
      target_size_font++;
    }
  }
  return width_pix;
}




/**
width String
*/
int width_String(String target, int size) {
  return width_String("defaultFont", target, size) ;
}

int width_String(PFont pfont, String target, int size) {
  return width_String(pfont.getName(), target, size);
}

int width_String(String font_name, String target, int size) {
  Font font = new Font(font_name, Font.BOLD, size) ;
  BufferedImage img = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
  FontMetrics fm = img.getGraphics().getFontMetrics(font);
  return fm.stringWidth(target);
}




int width_char(char target, int size) {
  return width_char("defaultFont", target, size) ;
}

int width_char(PFont pfont, char target, int size) {
  return width_char(pfont.getName(), target, size);
}
int width_char(String font_name, char target, int size) {
  Font font = new Font(font_name, Font.BOLD, size) ;
  BufferedImage img = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
  FontMetrics fm = img.getGraphics().getFontMetrics(font);
  return fm.charWidth(target);
}







// Research a specific word in String
boolean research_in_String(String research, String target) {
  boolean result = false ;
  for(int i = 0 ; i < target.length() - research.length() +1; i++) {
    result = target.regionMatches(i,research,0,research.length()) ;
    if (result) break ;
  }
  return result ;
}




/**
String file utils
*/
/**
* remove element of the sketch path
*/
String sketchPath(int minus) {
  minus = abs(minus);
  String [] element = split(sketchPath(),"/");
  String new_path ="" ;
  if(minus < element.length ) {
    for(int i = 0 ; i < element.length -minus ; i++) {
      new_path +="/";
      new_path +=element[i];
    }
    return new_path; 
  } else {
    printErr("The number of path elements is lower that elements must be remove, instead a data folder is used");
    return sketchPath()+"/data";
  }  
}



// remove the path of your file
String file_name(String s) {
  String file_name = "" ;
  String [] split_path = s.split("/") ;
  file_name = split_path[split_path.length -1] ;
  return file_name ;
}


String extension(String filename) {
  return filename.substring(filename.lastIndexOf(".") + 1, filename.length());
}
