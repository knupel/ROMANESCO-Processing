/**
Rope UTILS  2015 – 2017
v 1.27.3
Rope – Romanesco Processing Environment – 
* @author Stan le Punk
* @see https://github.com/StanLepunK/Utils_rope
*/
import java.util.Arrays;
import java.util.Iterator;

import java.awt.image.BufferedImage;
import java.awt.Graphics;
import java.awt.Color;
import java.awt.Font; 
import java.awt.image.BufferedImage ;
import java.awt.FontMetrics;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;

import javax.imageio.ImageIO;
import javax.imageio.IIOImage;
import javax.imageio.ImageWriter;
import javax.imageio.ImageWriteParam;
import javax.imageio.metadata.IIOMetadata;




/**
CONSTANT NUMBER must be here to be generate before all
v 0.0.2
*/
final float PHI = (1 + sqrt(5))/2; //a number of polys use the golden ratio...
final float ROOT2 = sqrt(2); //...and the square root of two, the famous first irrationnal number by Pythagore
final float EULER = 2.718281828459045235360287471352; // Constant d'Euler

final int PERLIN = 100;
final int CHAOS = 101;
// about constant https://en.wikipedia.org/wiki/Mathematical_constant

/**
CONSTANT from PRocessing
*/
/*
static public final int X = 0;
static public final int Y = 1;
static public final int Z = 2;

static final String JAVA2D = "processing.awt.PGraphicsJava2D";

static final String P2D = "processing.opengl.PGraphics2D";
static final String P3D = "processing.opengl.PGraphics3D";

static final String OPENGL = P3D;

static final String E2D = PGraphicsDanger2D.class.getName();

static final String FX2D = "processing.javafx.PGraphicsFX2D";

static final String PDF = "processing.pdf.PGraphicsPDF";
static final String SVG = "processing.svg.PGraphicsSVG";
static final String DXF = "processing.dxf.RawDXF";

static final int OTHER   = 0;
static final int WINDOWS = 1;
static final int MACOSX  = 2;
static final int LINUX   = 3;

static final float EPSILON = 0.0001f;

static final float MAX_FLOAT = Float.MAX_VALUE;

static final float MIN_FLOAT = -Float.MAX_VALUE;

static final int MAX_INT = Integer.MAX_VALUE;

static final int MIN_INT = Integer.MIN_VALUE;

static public final int VERTEX = 0;
static public final int BEZIER_VERTEX = 1;
static public final int QUADRATIC_VERTEX = 2;
static public final int CURVE_VERTEX = 3;
static public final int BREAK = 4;

static public final int QUAD_BEZIER_VERTEX = 2;  // should not have been exposed

static final float PI = (float) Math.PI;

static final float HALF_PI = (float) (Math.PI / 2.0);
static final float THIRD_PI = (float) (Math.PI / 3.0);
static final float QUARTER_PI = (float) (Math.PI / 4.0);

static final float TWO_PI = (float) (2.0 * Math.PI);
static final float TAU = (float) (2.0 * Math.PI);

static final float DEG_TO_RAD = PI/180.0f;
static final float RAD_TO_DEG = 180.0f/PI;

static final int RADIANS = 0;
static final int DEGREES = 1;

static final String WHITESPACE = " \t\n\r\f\u00A0";

static final int RGB   = 1;  // image & color
static final int ARGB  = 2;  // image
static final int HSB   = 3;  // color
static final int ALPHA = 4;  // image

static final int TIFF  = 0;
static final int TARGA = 1;
static final int JPEG  = 2;
static final int GIF   = 3;

static final int BLUR      = 11;
static final int GRAY      = 12;
static final int INVERT    = 13;
static final int OPAQUE    = 14;
static final int POSTERIZE = 15;
static final int THRESHOLD = 16;
static final int ERODE     = 17;
static final int DILATE    = 18;


public final static int REPLACE    = 0;
public final static int BLEND      = 1 << 0;
public final static int ADD        = 1 << 1;
public final static int SUBTRACT   = 1 << 2;
public final static int LIGHTEST   = 1 << 3;
public final static int DARKEST    = 1 << 4;
public final static int DIFFERENCE = 1 << 5;
public final static int EXCLUSION  = 1 << 6;
public final static int MULTIPLY   = 1 << 7;
public final static int SCREEN     = 1 << 8;
public final static int OVERLAY    = 1 << 9;
public final static int HARD_LIGHT = 1 << 10;
public final static int SOFT_LIGHT = 1 << 11;
public final static int DODGE      = 1 << 12;
public final static int BURN       = 1 << 13;

static final int CHATTER   = 0;
static final int COMPLAINT = 1;
static final int PROBLEM   = 2;

static final int PROJECTION = 0;
static final int MODELVIEW  = 1;

static final int CUSTOM       = 0; // user-specified fanciness
static final int ORTHOGRAPHIC = 2; // 2D isometric projection
static final int PERSPECTIVE  = 3; // perspective matrix

static final int GROUP           = 0;   // createShape()

static final int POINT           = 2;   // primitive
static final int POINTS          = 3;   // vertices

static final int LINE            = 4;   // primitive
static final int LINES           = 5;   // beginShape(), createShape()
static final int LINE_STRIP      = 50;  // beginShape()
static final int LINE_LOOP       = 51;

static final int TRIANGLE        = 8;   // primitive
static final int TRIANGLES       = 9;   // vertices
static final int TRIANGLE_STRIP  = 10;  // vertices
static final int TRIANGLE_FAN    = 11;  // vertices

static final int QUAD            = 16;  // primitive
static final int QUADS           = 17;  // vertices
static final int QUAD_STRIP      = 18;  // vertices

static final int POLYGON         = 20;  // in the end, probably cannot
static final int PATH            = 21;  // separate these two

static final int RECT            = 30;  // primitive
static final int ELLIPSE         = 31;  // primitive
static final int ARC             = 32;  // primitive

static final int SPHERE          = 40;  // primitive
static final int BOX             = 41;  // primitive

static final int OPEN = 1;
static final int CLOSE = 2;

static final int CORNER   = 0;
static final int CORNERS  = 1;
static final int RADIUS   = 2;
static final int CENTER   = 3;
static final int DIAMETER = 3;

static final int CHORD  = 2;
static final int PIE    = 3;

static final int BASELINE = 0;
static final int TOP = 101;
static final int BOTTOM = 102;

static final int NORMAL     = 1;
static final int IMAGE      = 2;

public static final int CLAMP = 0;
public static final int REPEAT = 1;

static final int MODEL = 4;
static final int SHAPE = 5;

static final int SQUARE   = 1 << 0;  // called 'butt' in the svg spec
static final int ROUND    = 1 << 1;
static final int PROJECT  = 1 << 2;  // called 'square' in the svg spec
static final int MITER    = 1 << 3;
static final int BEVEL    = 1 << 5;

static final int AMBIENT = 0;
static final int SPOT = 3;

static final char BACKSPACE = 8;
static final char TAB       = 9;
static final char ENTER     = 10;
static final char RETURN    = 13;
static final char ESC       = 27;
static final char DELETE    = 127;

static final int CODED     = 0xffff;

static final int UP        = KeyEvent.VK_UP;
static final int DOWN      = KeyEvent.VK_DOWN;
static final int LEFT      = KeyEvent.VK_LEFT;
static final int RIGHT     = KeyEvent.VK_RIGHT;

static final int ALT       = KeyEvent.VK_ALT;
static final int CONTROL   = KeyEvent.VK_CONTROL;
static final int SHIFT     = KeyEvent.VK_SHIFT;

static final int PORTRAIT = 1;
static final int LANDSCAPE = 2;

static final int SPAN = 0;

static final int ARROW = Cursor.DEFAULT_CURSOR;
static final int CROSS = Cursor.CROSSHAIR_CURSOR;
static final int HAND  = Cursor.HAND_CURSOR;
static final int MOVE  = Cursor.MOVE_CURSOR;
static final int TEXT  = Cursor.TEXT_CURSOR;
static final int WAIT  = Cursor.WAIT_CURSOR;
*/



/**

CANVAS
v 0.1.0

*/
PImage [] canvas;
int current_canvas;

// build canvas
void new_canvas(int num) {
  canvas = new PImage[num];
}

void create_canvas(int w, int h, int type, int which) {
  canvas[which] = createImage(w, h, type);
}




// misc
int canvas_num() {
  return canvas.length;
}

// select the canvas must be used for your next work
void select_canvas(int which_one) {
  if(which_one < canvas.length && which_one >= 0) {
    current_canvas = which_one;
  } else {
    println("void select_canvas() : Your selection" ,which_one, "is not available, canvas '0' be use");
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
v 0.0.3
*/
boolean fullscreen_is = false ;
iVec2 show_pos ;
/**
Add to set the center of the canvas in relation with the window
*/
int offset_canvas_x = 0 ;
int offset_canvas_y = 0 ;
void set_show() {
  if(!fullscreen_is) {
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
  if(fullscreen_is) {
    image(get_canvas(num), show_pos);
  } else {
    image(get_canvas(num));
  }  
}
















/**
SELECT FOLDER
v 0.0.1
*/
String selected_path_Folder = null;
boolean folder_selected_is;
void select_folder(String message) {
  // folder_selected_is = true ;
  selectFolder(message, "folder_selected");
}

boolean folder_selected_is() {
  return folder_selected_is;
}

void reset_folder_selection() {
  folder_selected_is = false;
}

String selected_path_folder() {
  return selected_path_Folder;
}

void folder_selected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Folder path is:" +selection.getAbsolutePath());
    selected_path_Folder = selection.getAbsolutePath();
    folder_selected_is = true;
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
IMAGE
v 0.1.3
*/

// additionnal method for image
// @see other method in Vec mini library
void image(PImage img) {
  image(img, 0, 0);
}

void image(PImage img, float coor) {
  image(img, coor, coor);
}







PImage reverse(PImage img) {
  PImage final_img;
  final_img = createImage(img.width, img.height, RGB) ;
  for(int i = 0 ; i < img.pixels.length ; i++) {
    final_img.pixels[i] = img.pixels[img.pixels.length -i -1];
  }
  return final_img ;
}


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
END TRANSLATOR
*/











/**

COLOR 0.2.0

*/
/**
camaieu 0.1.1
*/
// return hue or other date in range of specific data float
float camaieu(float max, float color_ref, float range) {
  float camaieu = 0 ;
  float which_color = random(-range, range) ;
  camaieu = color_ref +which_color ;
  if(camaieu < 0 ) camaieu = max +camaieu ;
  if(camaieu > max) camaieu = camaieu -max ;
  return camaieu ;
}

/**
color pool 0.2.0
*/
// color pool Vec4 RGB
Vec4 [] color_pool_RGB(int num) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  float key_hue = -1 ;
  return color_pool_RGB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

Vec4 [] color_pool_RGB(int num, float key_hue) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  return color_pool_RGB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}


Vec4 [] color_pool_RGB(int num, int num_group, float hue_range) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float key_hue = -1 ;
  return color_pool_RGB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


Vec4 [] color_pool_RGB(int num, int num_group, float key_hue, float hue_range) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  return color_pool_RGB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

Vec4 [] color_pool_RGB(int num, int num_group, float hue_range, Vec2 sat_range, Vec2 bright_range, Vec2 alpha_range) {
  float key_hue = -1 ;
  return color_pool_RGB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


Vec4 [] color_pool_RGB(int num, int num_group, float key_hue, float hue_range, Vec2 sat_range, Vec2 bright_range, Vec2 alpha_range) {
  Vec4 [] list = new Vec4[num]  ;
  int [] c = color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
  for(int i = 0 ; i <list.length ; i++) {
    list[i] = new Vec4(red(c[i]),green(c[i]),blue(c[i]),alpha(c[i])) ;
  }
  return list ;
}

// color pool Vec4 HSB
Vec4 [] color_pool_HSB(int num) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  float key_hue = -1 ;
  return color_pool_HSB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

Vec4 [] color_pool_HSB(int num, float key_hue) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  return color_pool_HSB(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}


Vec4 [] color_pool_HSB(int num, int num_group, float hue_range) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float key_hue = -1 ;
  return color_pool_HSB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


Vec4 [] color_pool_HSB(int num, int num_group, float key_hue, float hue_range) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  return color_pool_HSB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

Vec4 [] color_pool_HSB(int num, int num_group, float hue_range, Vec2 sat_range, Vec2 bright_range, Vec2 alpha_range) {
  float key_hue = -1 ;
  return color_pool_HSB(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}


Vec4 [] color_pool_HSB(int num, int num_group, float key_hue, float hue_range, Vec2 sat_range, Vec2 bright_range, Vec2 alpha_range) {
  Vec4 [] list = new Vec4[num]  ;
  int [] c = color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
  for(int i = 0 ; i <list.length ; i++) {
    list[i] = new Vec4(hue(c[i]),saturation(c[i]),brightness(c[i]),alpha(c[i])) ;
  }
  return list ;
}

// color pool int
int [] color_pool(int num) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  float key_hue = -1 ;
  return color_pool(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

int [] color_pool(int num, float key_hue) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float range = g.colorModeX *.5 ;
  int num_group = 1 ;
  return color_pool(num, num_group, key_hue, range, sat_range, bright_range, alpha_range) ;
}

int [] color_pool(int num, int num_group, float hue_range) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  float key_hue = -1 ;
  return color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

int [] color_pool(int num, int num_group, float key_hue, float hue_range) {
  Vec2 sat_range = Vec2(g.colorModeY) ;
  Vec2 bright_range = Vec2(g.colorModeZ) ;
  Vec2 alpha_range = Vec2(g.colorModeA) ;
  return color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;
}

int [] color_pool(int num, int num_group, float hue_range, Vec2 sat_range, Vec2 bright_range, Vec2 alpha_range) {
  float key_hue = -1 ;
  return color_pool(num, num_group, key_hue, hue_range, sat_range, bright_range, alpha_range) ;

}

// color pool by group
int [] color_pool(int num, int num_group, float key_hue, float hue_range, Vec2 sat_range, Vec2 bright_range, Vec2 alpha_range) {
  int ref = g.colorMode ;
  float x = g.colorModeX ;
  float y = g.colorModeY ;
  float z = g.colorModeZ ;
  float a = g.colorModeA ;
  colorMode(HSB,360,100,100,100) ;

  float [] color_ref = new float[num_group] ;
  if(key_hue >= 0 ) {
    color_ref[0] = key_hue ;
  } else {
    color_ref[0] = random(g.colorModeX) ;
  }
  if(num_group > 1) {
    float step = g.colorModeX / num_group ;
    for(int i = 1 ; i < num_group ; i++) {
      color_ref[i] = color_ref[i -1] + step ;
      if(color_ref[i] > g.colorModeX) {
        color_ref[i] = color_ref[i] - g.colorModeX ;
      }      
    }
  }

  int [] list = new int[num] ;
  int count = 0 ;
  int step = num / num_group ;
  int next_stop = step ; ;
  for(int i = 0 ; i < list.length ; i++) {
    if(i > next_stop) {
      next_stop += step ;
    }
    float saturation = random(sat_range) ;
    float brightness = random(bright_range) ;
    float alpha = random(alpha_range) ;
    float hue = camaieu(g.colorModeX, color_ref[count], hue_range) ;
    list[i] = color(hue, saturation,brightness, alpha) ;
    count++ ;
    if(count >= color_ref.length) count = 0 ;

  }
  colorMode(ref,x,y,z,a) ;
  return list ;
}





/**
component range
*/
boolean alpha_range(float min, float max, int colour) {
  float alpha = alpha(colour) ;
  return in_range(min, max, alpha) ;
}

boolean red_range(float min, float max, int colour) {
  float  r = red(colour) ;
  return in_range(min, max, r) ;
}

boolean green_range(float min, float max, int colour) {
  float  g = green(colour) ;
  return in_range(min, max, g) ;
}

boolean blue_range(float min, float max, int colour) {
  float  b = blue(colour) ;
  return in_range(min, max, b) ;
}

boolean saturation_range(float min, float max, int colour) {
  float  s = saturation(colour) ;
  return in_range(min, max, s) ;
}

boolean brightness_range(float min, float max, int colour) {
  float  b = brightness(colour) ;
  return in_range(min, max, b) ;
}


boolean hue_range(float min, float max, int colour) {
  int c_m = g.colorMode ;
  float c_x = g.colorModeX ;
  float c_y = g.colorModeY ;
  float c_z = g.colorModeZ ;
  float c_a = g.colorModeA ;
  colorMode(HSB, c_x, c_y, c_z, c_a) ;
  float  h = hue(colour) ;

  boolean result = false ;
  // test for the wheel value, hue is one of them ;
  result = in_range_wheel(min, max, c_x, h) ;
  // return to the current colorMode
  colorMode(c_m, c_x, c_y, c_z, c_a) ;
  return result ;
}












/**
convert color 0.0.1
*/
//convert color HSB to RVB
Vec3 HSB_to_RGB(float hue, float saturation, float brightness) {
  Vec4 vecRGB = HSB_to_RGB(hue, saturation, brightness, g.colorModeA).copy() ;
  return Vec3(vecRGB.x,vecRGB.y,vecRGB.z) ;
}

Vec4 HSB_to_RGB(float hue, float saturation, float brightness, float alpha) {
  Vec4 ref = Vec4(g.colorModeX, g.colorModeY, g.colorModeY, g.colorModeA) ;
  color c = color (hue, saturation, brightness, alpha);

  colorMode(RGB,255) ;
  Vec4 vecRGBa = Vec4 (red(c), green(c), blue(c), alpha(c)) ;
  // return to the previous colorMode
  colorMode(HSB,ref.r, ref.g, ref.b, ref.a) ;
  return vecRGBa ;
}



// color context
/*
* good when the text is on different background
*/
int color_context(int colorRef, int threshold, int clear, int dark) {
  int new_color ;
  if( brightness( colorRef ) < threshold ) {
    new_color = clear;
  } else {
    new_color = dark ;
  }
  return new_color ;
}
/**

END COLOR

*/






















/**
EXPORT FILE PDF_PNG 0.0.3

*/
// global PDF / PNG
String default_folder_shot_pdf = "pdf_folder" ;
String default_folder_shot_png = "png_folder" ;
String default_name_pdf = "pdf_file_" ;
String default_name_png = "png_file_" ;
String ranking_shot = "_######" ;

void start_shot(String path_folder, String name_file) {
  start_PDF(path_folder, name_file) ;
  start_PNG(path_folder, name_file) ;
}

void start_shot(String name_file) {
  start_PDF(default_folder_shot_pdf, name_file) ;
  start_PNG(default_folder_shot_png, name_file) ;
}

void start_shot() {
  start_PDF() ;
  // start_PNG() ;
}

void save_shot() {
  save_PDF() ;
  save_PNG() ;
}
void event_shot() {
  event_PNG() ;
  event_PDF() ;
}




// PDF
import processing.pdf.*;
boolean record_PDF;
void start_PDF() {
  start_PDF(default_folder_shot_pdf, default_name_pdf+ranking_shot) ;
}

void start_PDF(String name_file) {
  start_PDF(default_folder_shot_pdf, name_file) ;
}
void start_PDF(String path_folder, String name_file) {
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
      saveFrame(default_folder_shot_png +"/"+ default_name_png + ranking_shot+".png");
    } else {
      saveFrame(path_folder_png +"/"+ name_file_png +".png");
    }
    record_PNG = false ;
  }
}

void event_PNG() {
  record_PNG = true;
}

/**
END EXPORT FILE PDF / PNG
*/



















/**
Rope – Romanesco Processing environment – 
BACKGROUND_2D_3D 0.0.3
* @author Stan le Punk
* @see other Processing work on https://github.com/StanLepunK
*/

float MAX_RATIO_DEPTH = 6.9 ;

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
Background
*/
void background_rope(float colour) {
  background_norm(colour / g.colorModeX, colour / g.colorModeY, colour / g.colorModeZ) ;
  // background_2D(colour, g.colorModeA) ;
}

void background_rope(float colour, float alpha) {
  background_norm(colour / g.colorModeX, colour / g.colorModeY, colour / g.colorModeZ, alpha / g.colorModeA) ;
}


void background_rope(float red, float green, float blue, float alpha) {
  background_norm(red / g.colorModeX, green / g.colorModeY, blue / g.colorModeZ, alpha / g.colorModeA) ;
}

void background_rope(float red, float green, float blue) {
  background_norm(red / g.colorModeX, green / g.colorModeY, blue / g.colorModeZ) ;
}

void background_rope(Vec4 c) {
  background_norm(c.x / g.colorModeX, c.y / g.colorModeY, c.z / g.colorModeZ, c.w / g.colorModeA) ;
}

void background_rope(Vec3 c) {
  background_norm(c.x / g.colorModeX, c.y / g.colorModeY, c.z / g.colorModeZ) ;
}

void background_rope(Vec2 c) {
  background_norm(c.x / g.colorModeX, c.x / g.colorModeY, c.x / g.colorModeZ, c.y / g.colorModeA) ;
}















/**
TABLE METHOD 0.0.3
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

void setTable(Table table, TableRow [] rows, Info_obj... info) {
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


void setRow(Table table, Info_obj info) {
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
v 0.0.4
*/
// print 
void printErr(Object var) {
  System.err.println(var) ;
}


// print tempo
void printErrTempo(int tempo, Object var) {
  if(frameCount%tempo == 0 ) {
    System.err.println(var) ;
  }
}

void printTempo(int tempo, Object... var) {
  if(frameCount%tempo == 0 ) {
    println(var) ;
  }
}



void printArrayTempo(int tempo, Object[] var) {
  if(frameCount%tempo == 0 ) {
    printArray(var) ;
  }
}

void printArrayTempo(int tempo, float[] var) {
  if(frameCount%tempo == 0 ) {
    printArray(var) ;
  }
}

void printArrayTempo(int tempo, int[] var) {
  if(frameCount%tempo == 0 ) {
    printArray(var) ;
  }
}

void printArrayTempo(int tempo, String[] var) {
  if(frameCount%tempo == 0 ) {
    printArray(var) ;
  }
}








/**
Info_dict 0.2.4

*/
public class Info_dict {
  ArrayList<Info> list ;
  char type_list = 'o' ;

  Info_dict(char type_list) {
    this.type_list = type_list ;
  }

  Info_dict() {
    list = new ArrayList<Info>() ;
  }

  // add Object
  void add(String name, Object a) {
    Info_obj info = new Info_obj(name, a) ;
    list.add(info) ;
  }
  void add(String name, Object a, Object b) {
    Info_obj info = new Info_obj(name, a,b) ;
    list.add(info) ;
  }
  void add(String name, Object a, Object b, Object c) {
    Info_obj info = new Info_obj(name, a,b,c) ;
    list.add(info) ;
  }
  void add(String name, Object a, Object b, Object c, Object d) {
    Info_obj info = new Info_obj(name, a,b,c,d) ;
    list.add(info) ;
  }
  void add(String name, Object a, Object b, Object c, Object d, Object e) {
    Info_obj info = new Info_obj(name, a,b,c,d,e) ;
    list.add(info) ;
  }
  void add(String name, Object a, Object b, Object c, Object d, Object e, Object f) {
    Info_obj info = new Info_obj(name, a,b,c,d,e,f) ;
    list.add(info) ;
  }
  void add(String name, Object a, Object b, Object c, Object d, Object e, Object f, Object g) {
    Info_obj info = new Info_obj(name, a,b,c,d,e,f,g) ;
    list.add(info) ;
  }

   // size
   int size() {
    return list.size() ;
   }

  // read
  void read() {
    for(Info a : list) {
      println(a, type(type_list)) ;
    }
  }

  // check type
  String type (char type)  {
    String t = ("Unknow") ;
    if(type == 'i') t = "Integer" ;
    else if(type == 's') t = "String" ;
    else if(type == 'f') t = "Float" ;
    else if(type == 'o') t = "Object" ;
    else if(type == 'v') t = "Vec" ;
    else t = ("Unknow") ;
    return t ;
  }
  

  // get
  Info get(int target) {
    if(target < list.size() && target >= 0) {
      return list.get(target) ;
    } else return null ;
  }
  
  Info [] get(String which) {
    Info [] info  ;
    int count = 0 ;
    for(Info a : list) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info[count] ;
      count = 0 ;
      for(Info a : list) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_String[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }

  // clear
  void clear() {
    list.clear() ;
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list.size() ; i++) {
      Info a = list.get(i) ;
      if(a.get_name().equals(which)) {
        list.remove(i) ;
      }
    }
  }
  
  void remove(int target) {
   if(target < list.size()) {
      list.remove(target) ;
    }
  }
}

/**
Info_int_dict
*/

public class Info_int_dict extends Info_dict {
  ArrayList<Info_int> list_int ;
  Info_int_dict() {
    super('i') ;
    list_int = new ArrayList<Info_int>() ;
  }


  // add int
  void add(String name, int a) {
    Info_int info = new Info_int(name, a) ;
    list_int.add(info) ;
  } 
  void add(String name, int a, int b) {
    Info_int info = new Info_int(name, a,b) ;
    list_int.add(info) ;
  } 

  void add(String name, int a, int b, int c) {
    Info_int info = new Info_int(name, a,b,c) ;
    list_int.add(info) ;
  } 
  void add(String name, int a, int b, int c, int d) {
    Info_int info = new Info_int(name, a,b,c,d) ;
    list_int.add(info) ;
  } 
  void add(String name, int a, int b, int c, int d, int e) {
    Info_int info = new Info_int(name, a,b,c,d,e) ;
    list_int.add(info) ;
  } 
  void add(String name, int a, int b, int c, int d, int e, int f) {
    Info_int info = new Info_int(name, a,b,c,d,e,f) ;
    list_int.add(info) ;
  }
  void add(String name, int a, int b, int c, int d, int e, int f, int g) {
    Info_int info = new Info_int(name, a,b,c,d,e,f,g) ;
    list_int.add(info) ;
  }


  // size
  int size() {
    return list_int.size() ;
  }

  // read
  void read() {
    for(Info a : list_int) {
      println(a, type(a.get_type())) ;
    }
  }
  

  // get
  Info_int get(int target) {
    if(target < list_int.size() && target >= 0) {
      return list_int.get(target) ;
    } else return null ;
  }
  
  Info_int [] get(String which) {
    Info_int [] info  ;
    int count = 0 ;
    for(Info_int a : list_int) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info_int[count] ;
      count = 0 ;
      for(Info_int a : list_int) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_int[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }

  // clear
  void clear() {
    list_int.clear() ;
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list_int.size() ; i++) {
      Info_int a = list_int.get(i) ;
      if(a.get_name().equals(which)) {
        list_int.remove(i) ;
      }
    }
  }
  
  void remove(int target) {
   if(target < list_int.size()) {
      list_int.remove(target) ;
    }
  }
}

/**
Info_float_dict

*/
public class Info_float_dict extends Info_dict {
  ArrayList<Info_float> list_float ;
  Info_float_dict() {
    super('f') ;
    list_float = new ArrayList<Info_float>() ;
  }

  // add float
  void add(String name, float a) {
    Info_float info = new Info_float(name, a) ;
    list_float.add(info) ;
  }
  void add(String name, float a, float b) {
    Info_float info = new Info_float(name, a,b) ;
    list_float.add(info) ;
  }
  void add(String name, float a, float b, float c) {
    Info_float info = new Info_float(name, a,b,c) ;
    list_float.add(info) ;
  }
  void add(String name, float a, float b, float c, float d) {
    Info_float info = new Info_float(name, a,b,c,d) ;
    list_float.add(info) ;
  }
  void add(String name, float a, float b, float c, float d, float e) {
    Info_float info = new Info_float(name, a,b,c,d,e) ;
    list_float.add(info) ;
  }
  void add(String name, float a, float b, float c, float d, float e, float f) {
    Info_float info = new Info_float(name, a,b,c,d,e,f) ;
    list_float.add(info) ;
  }
  void add(String name, float a, float b, float c, float d, float e, float f, float g) {
    Info_float info = new Info_float(name, a,b,c,d,e,f,g) ;
    list_float.add(info) ;
  }

  // size
  int size() {
    return list_float.size() ;
  }

  //read
  void read() {
    for(Info a : list_float) {
      println(a, type(a.get_type())) ;
    }
  }
   

  // get
  Info_float get(int target) {
    if(target < list_float.size() && target >= 0) {
      return list_float.get(target) ;
    } else return null ;
  }
  
  Info_float [] get(String which) {
    Info_float [] info  ;
    int count = 0 ;
    for(Info_float a : list_float) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info_float[count] ;
      count = 0 ;
      for(Info_float a : list_float) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_float[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }

  // clear
  void clear() {
    list_float.clear() ;
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list_float.size() ; i++) {
      Info a = list_float.get(i) ;
      if(a.get_name().equals(which)) {
        list_float.remove(i) ;
      }
    }
  }
  
  void remove(int target) {
   if(target < list_float.size()) {
      list_float.remove(target) ;
    }
  }
}



/**
Info_String_dict

*/
public class Info_String_dict extends Info_dict {
  ArrayList<Info_String> list_String ;
  Info_String_dict() {
    super('s') ;
    list_String = new ArrayList<Info_String>() ;
  }

  // add String
  void add(String name, String a) {
    Info_String info = new Info_String(name, a) ;
    list_String.add(info) ;
  }
  void add(String name, String a, String b) {
    Info_String info = new Info_String(name, a,b) ;
    list_String.add(info) ;
  }
  void add(String name, String a, String b, String c) {
    Info_String info = new Info_String(name, a,b,c) ;
    list_String.add(info) ;
  }
  void add(String name, String a, String b, String c, String d) {
    Info_String info = new Info_String(name, a,b,c,d) ;
    list_String.add(info) ;
  }
  void add(String name, String a, String b, String c, String d, String e) {
    Info_String info = new Info_String(name, a,b,c,d,e) ;
    list_String.add(info) ;
  }
  void add(String name, String a, String b, String c, String d, String e, String f) {
    Info_String info = new Info_String(name, a,b,c,d,e,f) ;
    list_String.add(info) ;
  }
  void add(String name, String a, String b, String c, String d, String e, String f,String g) {
    Info_String info = new Info_String(name, a,b,c,d,e,f,g) ;
    list_String.add(info) ;
  }

  // size
  int size() {
    return list_String.size() ;
  }

  //read
  void read() {
    for(Info a : list_String) {
      println(a, type(a.get_type())) ;
    }
  }
  

  // get
  Info_String get(int target) {
    if(target < list_String.size() && target >= 0) {
      return list_String.get(target) ;
    } else return null ;
  }
  
  Info_String [] get(String which) {
    Info_String [] info  ;
    int count = 0 ;
    for(Info_String a : list_String) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info_String[count] ;
      count = 0 ;
      for(Info_String a : list_String) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_String[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }

  // clear
  void clear() {
    list_String.clear() ;
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list_String.size() ; i++) {
      Info_String a = list_String.get(i) ;
      if(a.get_name().equals(which)) {
        list_String.remove(i) ;
      }
    }
  }
  
  void remove(int target) {
   if(target < list_String.size()) {
      list_String.remove(target) ;
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
    Info_Vec info = new Info_Vec(name, a) ;
    list_Vec.add(info) ;
  }
  void add(String name, Vec a, Vec b) {
    Info_Vec info = new Info_Vec(name, a,b) ;
    list_Vec.add(info) ;
  }
  void add(String name, Vec a, Vec b, Vec c) {
    Info_Vec info = new Info_Vec(name, a,b,c) ;
    list_Vec.add(info) ;
  }
  void add(String name, Vec a, Vec b, Vec c, Vec d) {
    Info_Vec info = new Info_Vec(name, a,b,c,d) ;
    list_Vec.add(info) ;
  }
  void add(String name, Vec a, Vec b, Vec c, Vec d, Vec e) {
    Info_Vec info = new Info_Vec(name, a,b,c,d,e) ;
    list_Vec.add(info) ;
  }
  void add(String name, Vec a, Vec b, Vec c, Vec d, Vec e, Vec f) {
    Info_Vec info = new Info_Vec(name, a,b,c,d,e,f) ;
    list_Vec.add(info) ;
  }
  void add(String name, Vec a, Vec b, Vec c, Vec d, Vec e, Vec f, Vec g) {
    Info_Vec info = new Info_Vec(name, a,b,c,d,e,f,g) ;
    list_Vec.add(info) ;
  }

  // size
  int size() {
    return list_Vec.size() ;
  }

  //read
  void read() {
    for(Info a : list_Vec) {
      println(a, type(a.get_type())) ;
    }
  }
  

  // get
  Info_Vec get(int target) {
    if(target < list_Vec.size() && target >= 0) {
      return list_Vec.get(target) ;
    } else return null ;
  }
  
  Info_Vec [] get(String which) {
    Info_Vec [] info  ;
    int count = 0 ;
    for(Info_Vec a : list_Vec) {
      if(a.get_name().equals(which)) {
        count++ ;
      }
    }
    if (count > 0 ) {
      info = new Info_Vec[count] ;
      count = 0 ;
      for(Info_Vec a : list_Vec) {
        if(a.get_name().equals(which)) {
          info[count] = a ;
          count++ ;
        }
      }
    } else {
      info = new Info_Vec[1] ;
      info[0] = null ;
    }
    if(info.length == 1 && info[0] == null )return null ; else return info ;
  }

  // clear
  void clear() {
    list_Vec.clear() ;
  }

  // remove
  void remove(String which) {
    for(int i = 0 ; i < list_Vec.size() ; i++) {
      Info_Vec a = list_Vec.get(i) ;
      if(a.get_name().equals(which)) {
        list_Vec.remove(i) ;
      }
    }
  }
  
  void remove(int target) {
   if(target < list_Vec.size()) {
      list_Vec.remove(target) ;
    }
  }
}



/**
Info 0.1.0.1

*/
interface Info {
  String get_name() ;

  Object [] catch_all() ;
  Object catch_obj(int arg) ;

  char get_type() ;
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
  int [] get_all() {
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
  @ Override String toString() {
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
  String [] get_all() {
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
  @ Override String toString() {
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
  float [] get_all() {
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
  @ Override String toString() {
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
  Vec [] get_all() {
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
      System.err.println(error_target) ;
      return null ;
    }
  }

  char get_type() { return type ; }

  // Print info
  @ Override String toString() {
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
*/
class Info_obj extends Info_method {
  char type = 'o' ;
  Object a, b, c, d, e, f, g ;
  int num_value ;

  Info_obj(String name) {
    super(name) ;
  }


  // Object value
  Info_obj(String name, Object... var) {
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
  Object [] get_all() {
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
    } else {
      System.err.println(error_target) ;
      return null ;
    }
  }
  
  char get_type() { return type ; }


  // Print info
  @ Override String toString() {
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
  // if(freeze_is) freeze_is = false ; else freeze_is = true ;
  freeze_is = (freeze_is)? false:true ;
  if (freeze_is)  {
    noLoop();
  } else {
    loop();
  }
}

/*
void freeze() {
  if (looping)  {
    noLoop();
  } else {
    loop();
  }
}
*/


/**
Random around value
*/

float random_gaussian(float value) {
  return random_gaussian( value, .4) ;
}


float random_gaussian(float value, float range) {
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
   
  return  result;
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

*/


/**
Check renderer
*/
boolean renderer_P3D() {
  if(get_renderer_name(getGraphics()).equals("processing.opengl.PGraphics3D")) return true ; else return false ;
}


String get_renderer_name(final PGraphics graph) {
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
Check Type
*/
public String object_type(Object t) {
  String type = "Type unknow" ;
  if(t instanceof Integer) {
    type = ("Integer") ;
  } else if(t instanceof Float) {
    type = ("Float") ;
  } else if(t instanceof String) {
    type = ("String") ;
  } else if(t instanceof Double) {
    type = ("Double") ;
  } else if(t instanceof Long) {
    type = ("Long") ;
  } else if(t instanceof Short) {
    type = ("Short") ;
  } else if(t instanceof Boolean) {
    type = ("Boolean") ;
  } else if(t instanceof Byte) {
    type = ("Byte") ;
  } else if(t instanceof Character) {
    type = ("Character") ;
  }else {
    type = ("Type unknow") ;
  }
  return type ;
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
*/

//STRING SPLIT
String [] split_text(String textToSplit, String separator) {
  String [] text = textToSplit.split(separator) ;
  return text  ;
}


//STRING COMPARE LIST SORT
//raw compare
int longest_word( String[] listWordsToSort) {
  int sizeWord = 0 ;
  for ( int i = 0 ; i < listWordsToSort.length ; i++) {
    if (listWordsToSort[i].length() > sizeWord )  sizeWord = listWordsToSort[i].length() ;
  }
  return  sizeWord ;
}
//with starting and end keypoint in the String must be sort
int longest_word( String[] listWordsToSort, int start, int finish ) {
  int sizeWord = 0 ;

  for ( int i = start ; i < finish ; i++) {
    if (listWordsToSort[i].length() > sizeWord )  sizeWord = listWordsToSort[i].length() ;
  }
  return  sizeWord ;
}



// with the same size_text for each line
int longest_word_in_pixel(String[] listWordsToSort, int size_font) {
  int sizeWord = 0 ;
  for ( int i = 0 ; i < listWordsToSort.length ; i++) {
    if (width_String(listWordsToSort[i], size_font) > sizeWord )  sizeWord = width_String(listWordsToSort[i],size_font) ;
  }
  return  sizeWord ;
}

// with the same size_text for each line, choice the which line you check
int longest_word_in_pixel( String[] listWordsToSort, int size_font, int start, int finish ) {
  int sizeWord = 0 ;
  for ( int i = start ; i <= finish ; i++) {
    if (width_String(listWordsToSort[i], size_font) > sizeWord )  sizeWord = width_String(listWordsToSort[i],size_font) ;
  }
  return  sizeWord ;
}

// with list of size_text for each line
int longest_word_in_pixel( String[] listWordsToSort, int [] size_font) {
  int sizeWord = 0 ;
  for ( int i = 0 ; i < listWordsToSort.length ; i++) {
    if (width_String(listWordsToSort[i], size_font[i]) > sizeWord )  sizeWord = width_String(listWordsToSort[i],size_font[i]) ;
  }
  return  sizeWord ;
}

// with list of size_text for each line, choice the which line you check
int longest_word_in_pixel( String[] listWordsToSort, int [] size_font, int start, int finish ) {
  int sizeWord = 0 ;
  for ( int i = start ; i <= finish ; i++) {
    if (width_String(listWordsToSort[i], size_font[i]) > sizeWord )  sizeWord = width_String(listWordsToSort[i],size_font[i]) ;
  }
  return  sizeWord ;
}






int width_String(String target, int size) {
  return width_String("defaultFont", target, size) ;
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





// remove the path of your file
String file_name(String s) {
  String file_name = "" ;
  String [] split_path = s.split("/") ;
  file_name = split_path[split_path.length -1] ;
  return file_name ;
}