/**
Rope UTILS 
v 1.55.0
* Copyleft (c) 2014-2019
* Stan le Punk > http://stanlepunk.xyz/
Rope – Romanesco Processing Environment – 
Processing 3.4
* @author Stan le Punk
* @see https://github.com/StanLepunK/Rope
*/


/**
CHECK SIZE WINDOW
return true if the window size has changed
*/
iVec2 rope_window_size;
boolean window_change_is() {
  if(rope_window_size == null || !all(equal(iVec2(width,height),rope_window_size))) {
    check_window_size();
    return true;
  } else {
    return false;
  }
}

void check_window_size() {
  if(rope_window_size == null) {
    rope_window_size = iVec2(width,height);
  } else {
    rope_window_size.set(width,height);
  }
}







/**
print Constants
v 0.0.3
*/
Constant_list processing_constants_list = new Constant_list(PConstants.class);
Constant_list rope_constants_list = new Constant_list(rope.core.RConstants.class);
public void print_constants_rope() {
  if(rope_constants_list == null) {
    rope_constants_list = new Constant_list(rope.core.RConstants.class);
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
  for(String s: processing_constants_list.list()) {
    println(s);
  }
} 

public void print_constants() {
  if(processing_constants_list == null) {
    processing_constants_list = new Constant_list(PConstants.class);
  }

  if(rope_constants_list == null) {
    rope_constants_list = new Constant_list(rope.core.RConstants.class);
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
v 0.3.0
*/
/*
INOUT PART
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

String input() {
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

String folder() {
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
V 0.1.2
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
      printErr("method saveFrame(): the PImage is null, no save can be done");
    } else {
      buff_img = new BufferedImage(img.width, img.height, BufferedImage.TYPE_INT_RGB);
      buff_img.setRGB(0, 0, img.width, img.height, img.pixels, 0, img.width);
      if(path.contains(".bmp") || path.contains(".BMP")) {
        saveBMP(os, buff_img);
      } else if(path.contains(".jpeg") || path.contains(".jpg") || path.contains(".JPG") || path.contains(".JPEG")) {
        saveJPG(os, compression, buff_img);
      }
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
TRANSLATOR 
v 0.2.0
*/
/**
primitive to byte, byte to primitive
v 0.1.0
*/
import java.nio.ByteBuffer;
import java.nio.ByteOrder;

int int_from_byte(Byte b) {
  int result = b.intValue();
  return result;
}

public Boolean boolean_from_bytes(byte... array_byte) {
  if(array_byte.length == 1) {
    if(array_byte[0] == 0) return false ; return true;
  } else {
    Boolean null_data = null;
    return null_data;
  }
}

public Character char_from_bytes(byte [] array_byte) {
  if(array_byte.length == 2) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte);
    char result = buffer.getChar();
    return result;
  } else {
    Character null_data = null;
    return null_data;
  }
}

public Short short_from_bytes(byte [] array_byte) {
  if(array_byte.length == 2) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte);
    short result = buffer.getShort();
    return result;
  } else {
    Short null_data = null;
    return null_data;
  }
}

public Integer int_from_bytes(byte [] array_byte) {
  if(array_byte.length == 4) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte) ;
    int result = buffer.getInt();
    return result;
  } else {
    Integer null_data = null;
    return null_data;
  }
}

public Long long_from_bytes(byte [] array_byte) {
  if(array_byte.length == 8) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte) ;
    long result = buffer.getLong();
    return result;
  } else {
    Long null_data = null;
    return null_data;
  }
}

public Float float_from_bytes(byte [] array_byte) {
  if(array_byte.length == 4) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte) ;
    float result = buffer.getFloat();
    return result;
  } else {
    Float null_data = null;
    return null_data;
  }
}

public Double double_from_bytes(byte [] array_byte) {
  if(array_byte.length == 8) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte) ;
    double result = buffer.getDouble();
    return result;
  } else {
    Double null_data = null;
    return null_data;
  }
}



// @Deprecated // this method return a short because it's reordering by LITTLE_ENDIAN to used by getShort()
Integer int_from_4_bytes(byte [] array_byte, boolean little_endian) {
  if(array_byte.length == 4) {
    ByteBuffer buffer = ByteBuffer.wrap(array_byte);
    if(little_endian)buffer.order(ByteOrder.LITTLE_ENDIAN);
    int result = buffer.getShort();
    return result;
  } else {
    Integer null_data = null;
    return null_data;
  }
}



// return byte
byte[] to_byte(Object obj) {
  if(obj instanceof Boolean) {
    boolean value = (boolean)obj;
    byte [] array = new byte[1];
    array[0] = (byte)(value?1:0);
    return array;
  } else if(obj instanceof Character) {
    char value = (char)obj;
    return ByteBuffer.allocate(2).putChar(value).array();
  } else if(obj instanceof Short) {
    short value = (short)obj;
    return ByteBuffer.allocate(2).putShort(value).array();
  } else if(obj instanceof Integer) {
    int value = (int)obj;
    return ByteBuffer.allocate(4).putInt(value).array();
  } else if(obj instanceof Long) {
    long value = (long)obj;
    return ByteBuffer.allocate(8).putLong(value).array();
  } else if(obj instanceof Float) {
    float value = (float)obj;
    return ByteBuffer.allocate(4).putFloat(value).array();
  } else if(obj instanceof Double) {
    double value = (double)obj;
    return ByteBuffer.allocate(8).putDouble(value).array();
  } else return null;
}



/**
* from iVec, Vec to PVector
*/
PVector to_PVector(Object obj) {
  if(obj instanceof Vec || obj instanceof iVec) {
    if(obj instanceof Vec) {
      Vec v = (Vec)obj;
      return new PVector(v.x,v.y,v.z);
    } else {
      iVec iv = (iVec)obj;
      return new PVector(iv.x,iv.y,iv.z);
    }
  } else {
    printErr("method to_PVectro(): wait for Object of type Vec or iVec");
    return null;
  }
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
print
v 0.2.0
*/
// print Err
void printErr(Object... obj) {
  System.err.println(write_message(obj));
}

// print tempo
void printErrTempo(int tempo, Object... obj) {
  if(frameCount%tempo == 0 || frameCount <= 1) {
    String message = write_message(obj);
    System.err.println(message);
  }
}

void printTempo(int tempo, Object... obj) {
  if(frameCount%tempo == 0 || frameCount <= 1) {
    String message = write_message(obj);
    println(message);
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


// to map not linear, start the curve hardly to start slowly
float map_begin(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
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
float map_end(float value, float sourceMin, float sourceMax, float targetMin, float targetMax, int level) {
  if (value < sourceMin ) value = sourceMin ;
  if (value > sourceMax ) value = sourceMax ;
  float newMax = sourceMax - sourceMin ;
  float deltaTarget = targetMax - targetMin ;
  float ratio = ((value - sourceMin) / newMax ) ;
  ratio = pow(ratio, 1.0/level) ;
  float result = targetMin +deltaTarget *ratio;
  return result;
}

float map(float value, float start_1, float stop_1, float start_2, float stop_2, int begin, int end) {
  begin = abs(begin);
  end = abs(end);
  if(begin != 0 && end != 0) {
    if (value < start_1 ) value = start_1;
    if (value > stop_2 ) value = stop_2;

    float new_max = stop_2 - start_1;
    float delta = stop_2 - start_2;
    float ratio = (value - start_1) / new_max;

    ratio = map(ratio,0,1,-1,1);
    if (ratio < 0) {
      if(begin < 2) ratio = pow(ratio,begin) ;
      else ratio = pow(ratio,begin) *(-1);
      if(ratio > 0) ratio *= -1;
    } else {
      ratio = pow(ratio,end);
    }
    
    ratio = map(ratio,-1,1,0,1);
    float result = start_2 +delta *ratio;
    return result;
  } else if(begin == 0 && end != 0) {
    return map_end(value,start_1,stop_1,start_2,stop_2,end);
  } else if(end == 0 && begin != 0) {
    return map_begin(value,start_1,stop_1,start_2,stop_2,begin);
  } else {
    return map(value,start_1,stop_1,start_2,stop_2,1,1);
  }

}











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
CHECK
v 0.2.4
*/
/**
Check Type
v 0.0.4
*/
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
  } else if(obj == null) {
    return "null";
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
v 0.3.3
*/
String write_message(Object... obj) {
  String mark = " ";
  return write_message_sep(mark,obj);
}
String write_message_sep(String mark, Object... obj) {
  String m = "";
  for(int i = 0 ; i < obj.length ; i++) {
    m += write_message(obj[i], obj.length,i,mark);
  }
  return m;
}

// local method
String write_message(Object obj, int length, int i, String mark) {
  String message = "";
  String add = "";
  if(i == length -1) { 
    if(obj == null) {
      add = "null";
    } else {
      add = obj.toString();
    }
    return message += add;
  } else {
    if(obj == null) {
      add = "null";
    } else {
      add = obj.toString();
    }
    return message += add + mark;
  }
}



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
  if(target ==null) {
    printErr("method width_String(): String target =",target);
    target = "";
  }
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
2014-2018
v 0.2.0
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

/**
* work around extension
*/
String extension(String filename) {
  if(filename != null) {
    if(filename.contains(".")) {
      return filename.substring(filename.lastIndexOf(".") + 1, filename.length());
    } else {
      return null;
    } 
  } else {
    return null;
  }
}

boolean extension_is(String... data) {
  boolean is = false;
  if(data.length >= 2) {
    String extension_to_compare = extension(data[0]);
    if(extension_to_compare != null) {
      for(int i = 1 ; i < data.length ; i++) {
        if(extension_to_compare.equals(data[i])) {
          is = true;
          break;
        } else {
          is = false;
        }
      }
    } else {
      printErr("method extension_is(): [",data[0],"] this path don't have any extension");
    }
  } else {
    printErr("method extension_is() need almost two components, the first is the path and the next is extension");
  }
  return is;
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


